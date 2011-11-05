#!/usr/bin/perl
# Copyright © 2011 Petr Písař
# This is free software.  You may redistribute copies of it under the terms of
# the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
# There is NO WARRANTY, to the extent permitted by law.

# Changelog:
#
# Version4
# - Support RTMP app with slashes
# - Report URI in error messages
#
# Version 3:
# - Output in rtmpdump(1) format if `-d' option is specified
# - Do not append playpath to URL if ambigous
#
# Version 2:
# - Output playpath as librtmp option if necessary
#   (http://www.ct24.cz/vysilani/10099403120-kultura-v-regionech/)
# - Perl 5.10 support
# - Find JSON via iframe first and fall back to direct JSON
# - More general example entry page URL in usage output
# - Show content provider error message if exists
#

use strict;
use warnings;
our $VERSION = 4;

use LWP::UserAgent;
use HTTP::Request::Common;
use HTTP::Response;
use XML::XPath;
use URI;
use JSON 2.0;
use Getopt::Std;


my $SMIL_GENERATOR = '/ajax/playlistURL.php';
my $ENTRY = 'http://www.ceskatelevize.cz/ivysilani/zive/ct24/';

sub usage {
    return<<EOM;
Usage: ctstream [-d] [--] ENTRY_PAGE [STREAM_BITRATE]

Get URLs of Czech Television video streams for specific ENTRY_PAGE (e.g.
$ENTRY). If this is the only argument,
output list of all available streams in format `STREAM_BITRATE: URL' separated
by new line.  If STREAM_BITRATE is given, output URL of the stream with given
rate only.

By default, URL is printed in librtmp(3) format (space-separated librtmp
options may follow the URL and all of them must be passed as one argument
to librtmp application).

If `-d' option is specied, URL with possible arguments are printed as
rtmpdump(1) arguments. Note ampersands are kept literal (this should work in
simple subshell substition).

Version: $VERSION.
Copyright © 2011 Petr Písař
This is free software.  You may redistribute copies of it under the terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.
EOM
}

our $opt_d;
getopts('d') or 
    die usage;

if ($#ARGV < 0 || $#ARGV > 1) {
    die "Bad invocation\n\n" . usage;
}
$ENTRY = $ARGV[0];
my $BITRATE = $ARGV[1];


# each that operates on reference to array or hash
# Works with perl 5.10.1 too.
sub eachref {
    my $ref = shift;
            
    if (ref $ref eq 'HASH') {
        # Built-in implementation always supports HASH
        return sub {
            each %$ref;
        }
    }

    if (eval 'each @$ref' ) {
        # Built-in Perl 5.12 implementation
        eval 'return sub { 
            each @$ref;
        }'
    } else {
        # Manual implementation of each ARRAY (needed for Perl < 5.12)
        my $index = -1;
   
        return sub {
            $index++;
            if ($index <= $#$ref) {
                ($index, $$ref[$index]);
            } else {
                ();
            }
        }
    }
}


# Convert nested JSON structure expressed as native hash reference into flat
# array of key and value pairs.
# E.g. { "x" => [ "y" => "1", "z" => undef ] }
# becomes ( "x[0][y]", "1", "x[1][z] => null ).
# This is handy when sending nested JSON structure as
# application/x-www-form-urlencoded by HTTP::Request::Common.
sub flatten {
    my ($ref, $prefix) = @_;
    my @output = ();
    my $doeach = eachref($ref);
    while (my ($key, $val) = &$doeach) {
        # TODO: Escape /[[]=]/
        my $id = (defined $prefix) ? $prefix . '[' . $key . ']' : $key;
        if (ref $val eq 'HASH' || ref $val eq 'ARRAY') {
            push @output, flatten($val, $id);
        } else {
            push @output, ($id, $val // 'null');
        }
    }
    return @output;
}


# Format RTMP URL for librtmp
sub formaturl_librtmp {
    my ($rtmp, $app, $playpath) = @_;

    my $stream_url = $rtmp;
    if ($playpath =~ qr{/} or $app =~ qr{/}) {
        $stream_url .= ' app=' . $app . ' playpath=' . $playpath;
    } else {
        $stream_url .= $app . '/' . $playpath;
    }
}


# Format RTMP URL for librtmp
sub formaturl_rtmpdump {
    my ($rtmp, $app, $playpath) = @_;
    
    my $stream_url = '--rtmp ' . $rtmp;
    if ($playpath =~ qr{/} or $app =~ qr{/}) {
        $stream_url .= ' --app ' . $app . ' --playpath ' . $playpath;
    } else {
        $stream_url .= $app . '/' . $playpath;
    }
}


# Find first pattern match in HTML page, HTML-unescape it and return it.
# Otherwise return undef.
sub htmlgrep {
    my ($html_page, $pattern) = @_;
    my ($text) = ($html_page =~ $pattern);
    if (! defined $text) { return undef; }
    $text =~ s/&amp;/&/g;
    $text =~ s/&gt;/>/g;
    $text =~ s/&lt;/</g;
    return $text;
}


# Escape as URI and ampersands in additon
sub shellescape {
    local $_ = URI->new(shift);
    s/&/%26/g;
    return $_;
}


# Try to get JSON request data from HTML page text passed as argument.
# Return the JSON data or undef.
sub findjson {
    htmlgrep(shift, qr{callSOAP\(([^)]*)\);});
}


# Get entry HTML page
my $ua = LWP::UserAgent->new;
my $response = $ua->request(GET $ENTRY);
$response->is_success or
    die "Could not get entry page from <" . $ENTRY . ">: " .
        $response->status_line . "\n";
my $page = $response->decoded_content;


# Try to get iframe player URL
# The web page is not well-formed XML, we cannot use XPath 
# '//html:div[@id="iFramePositionContainer"]/html:iframe/@src';
# This is sometimes relative, sometimes absolute path
my $iframe_url = htmlgrep($page,
    qr{src="([^"]*/embed/iFramePlayer\.php[^"]*)"});
if (defined $iframe_url && $iframe_url) {
    # Get iframe player page
    $iframe_url = URI->new_abs($iframe_url, $ENTRY);
    $response = $ua->request(GET $iframe_url);
    $response->is_success or
        die "Could not get iframe player from <" . $iframe_url . ">: " .
            $response->status_line . "\n";
    $page = $response->decoded_content;
}


# Get JSON request data
my $json_data = htmlgrep($page, qr{callSOAP\(([^)]*)\);});
unless (defined $json_data && $json_data) {
    # Try to get error message from stream provider
    my $message = htmlgrep($page, qr{<p\s+class="message">([^<]*)<});
    if (defined $message && $message) {
        die "$message\n";
    }

    # else die in general way
    die "Could not find JSON data structure\n";
}


# Decode JSON request data
my $data;
eval { $data = decode_json($json_data) } or 
    die "Could not decode JSON string: $json_data: $@\n";
my @data = flatten($data);


# Get SMIL playlist URL
my $smil_generator_url = URI->new_abs($SMIL_GENERATOR, $ENTRY);
$response = $ua->request(POST $smil_generator_url, \@data);
$response->is_success or
    die "Could not get SMIL playlist URL from <" . $smil_generator_url .
        ">: " . $response->status_line . "\n";
my $smil_url = $response->decoded_content;


# Get SMIL playlist
$ua->agent('NSPlayer/0 (Fuck libwwperl discimination)');
$response = $ua->request(GET $smil_url);
$response->is_success or
    die "Could not get SMIL playlist from <" . $smil_url . ">: "
        . $response->status_line . "\n";
my $smil = $response->decoded_content;


# Get stream URLs
my $parser = XML::XPath->new('xml' => $smil) or
    die "Could not parse SMIL playlist from <" . $smil_url . ">:\n" .
        $smil . "\n";
my $videos =
    $parser->find('/data/smilRoot/body/switchItem/video[@enabled=true()]');
if ($videos->size <= 0) {
    die "No videos found in SMIL playlist <" . $smil_url . ">:\n" .
        $smil . "\n";
}
my $video_counter = 0;
foreach my $video ($videos->get_nodelist) {
    my $suffix = $video->getAttribute('src');
    if (! defined $suffix) {
        print STDERR q{Missing `video/@src' attribute} . "\n";
        next;
    }
    my $prefix = $video->getParentNode->getAttribute('base');
    if (! defined $suffix) {
        print STDERR
            q{Missing `video/../@base' attribute for video } . "`$suffix'\n";
        next;
    }
    my $bitrate = $video->getAttribute('system-bitrate');
    if (! defined $suffix) {
        print STDERR
            q{Missing `video/@system-bitrate' attribute for video } .
            "`$suffix'\n";
        next;
    }

    # Build stream URL. Beacuse RTMP URL can be ambigous, 
    # applications accept aditional arguments separated by space
    # (the space must not be URI-encoded).
    my $stream_url;
    {
        my $rtmp = URI->new($prefix);
        my $app = substr($rtmp->path_query, 1);
        $rtmp->path('/');
        $rtmp->query(undef);
        my $playpath = URI->new($suffix);
        if ($opt_d) {
            $stream_url = formaturl_rtmpdump($rtmp, $app, $playpath);
        } else {
            $stream_url = formaturl_librtmp($rtmp, $app, $playpath);
        }
    }

    # Output URL
    if (defined $BITRATE) {
        if ($bitrate == $BITRATE) {
            print "$stream_url\n";
            $video_counter++;
        }
    } else {
        print "$bitrate: $stream_url\n";
        $video_counter++;
    }
}
if ($video_counter <= 0) {
    die "No usable video streams found in SMIL playlist:\n$smil\n";
}

