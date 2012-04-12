------------------------------------------------------------------------------
-- Open videos from video hosting services using quvi                       --
--                                                                          --
-- author: David Pugnasse <david.pugnasse@gmail.com>                        --
--                                                                          --
-- Command ':videos' and key 'V' in normal mode opens the video menu.       --
------------------------------------------------------------------------------

-- This script opens a console and uses mplayer to play videos.
-- Edit 'player_command' and 'quvi_command' values below to change this
-- behaviour.

local pairs = pairs
local ipairs = ipairs
local string = string

local lousy = require "lousy"
local theme = theme
local table = table
local add_binds, add_cmds = add_binds, add_cmds
local key = lousy.bind.key
local new_mode, menu_binds = new_mode, menu_binds
local capi = { luakit = luakit }

module("quvi")

-- mplayer options from youtube-viewer
-- (https://github.com/trizen/youtube-viewer)
player_command = 'mplayer %u -prefer-ipv4 -cache 30000 -cache-min 5 -unicode -utf8'

-- urxvt -e quvi <url> --exec <player_command>
quvi_command = 'urxvtc -e quvi %q --exec %q'
--quvi_command = 'quvi %q --exec %q' -- alternatively, do not open a console

-- TODO: find supported hosts from command `quvi --support`
-- We match only domain names, so there is a lot of false positive,
-- especially when invoking on one of these sites.
-- E.g.: on youtube, a bunch of crap like 'upload.youtube.com/my_videos_upload'
-- and all others "http://*.youtube.com/*" urls appears in the list.
-- Matching complete urls is better, but need more effort to maintain, as quvi
-- does not provide access to a list of url patterns for now.

local hosts = {
    'audioboo%.fm',
    'break%.com',
    'mgnetwork%.com',
    'yfrog%.com',
    'videobash%.com',
    'dailymotion%.%w+',
    'metacafe%.com',
    'bloomberg%.com',
    'guardian%.co%.uk',
    'academicearth%.org',
    'clipfish%.de',
    'publicsenat%.fr',
    'vimeo%.com',
    'liveleak%.com',
    'francetelevisions%.fr',
    'tmunderground%.com',
    'ted%.com',
    'youtube%.com',
    'funnyhub%.com',
    'tvlux%.be',
    'blip%.tv',
    'gaskrank%.tv',
    'theonion%.com',
    'buzzhumor%.com',
    'sevenload%.com',
    'collegehumor%.com|dorkly%.com',
    'tagtele%.com',
    'charlierose%.com',
    'cbsnews%.com',
    'funnyordie%.com',
    'video%.globo%.com',
    'videos%.arte%.tv',
    'video%.google%.%w+',
    'spiegel%.de',
    'videos%.sapo%.pt',
    'pluzz%.fr',
    'bikeradar%.com',
    'megavideo%.com',
    'soundcloud%.com',
    'video%.foxnews%.com',
    'video%.golem%.de',
}

new_mode("quvimenu", {
    enter = function (w)
        local url
        local afg, ifg = theme.proxy_active_menu_fg, theme.proxy_inactive_menu_fg
        local abg, ibg = theme.proxy_active_menu_bg, theme.proxy_inactive_menu_bg
        local rows = {{ "Url(s)", title = true },}
        local list = list_videos(w)
        local url
        local i=0

        for url in pairs(list) do
            table.insert(rows, {
                "  " .. url,
                url = url,
                fg = afg or ifg,
                bg = abg or ibg,
            })
            i=1
        end

        if i<1 then
            w:set_mode()
            w:notify("No video url found")
            return
        end

        w.menu:build(rows)
        w:notify("Use j/k to move, y to yank, Return to play, o to play without closing this menu.", false)
    end,

    leave = function (w)
        w.menu:hide()
    end,
})

local key = lousy.bind.key
add_binds("quvimenu", lousy.util.table.join({
    -- Play the video
    key({}, "o",
        function (w)
            local row = w.menu:get()
            if row and row.url then
                launch_quvi(row.url)
            end
        end),

    -- Play the video (close menu)
    key({}, "Return",
        function (w)
            local row = w.menu:get()
            if row and row.url then
                w:set_mode()
                launch_quvi(row.url)
            end
        end),

    -- Yank url
    key({}, "y",
        function (w)
            local row = w.menu:get()
            if row and row.url then
                capi.luakit.selection.primary = row.url -- luakit-git (aur)
                --capi.luakit.set_selection(row.url) -- luakit (community)
            end
        end),

    -- Exit menu
    key({}, "q", function (w) w:set_mode() end),

}, menu_binds))

add_binds("normal", {
    key({}, "V",
        function (w)
            w:set_mode("quvimenu")
        end),
})

local cmd = lousy.bind.cmd
add_cmds({
    cmd({"videos"}, function (w, a)
            w:set_mode("quvimenu")
        end),
})

function launch_quvi(url)
    local command = string.format(quvi_command, url, player_command)
    capi.luakit.spawn(command)
end

function list_videos(w)
    local urls = {}
    local t = {}
    local host
    local supported_host
    local url
    local k

    -- get html code from current page
    local html = w:eval_js("document.documentElement.outerHTML", "dump")

    -- add current url
    local url = w.view.uri -- luakit-git (aur)
    --local url = w:get_current().uri  -- luakit (community)

    -- keep protocol + host
    host = string.sub(url, 0, string.find(url, '/', 9, true))
    urls[url] = host

    -- retrieve urls from html code
    -- TODO: build a nicer pattern for url matching
    for url in string.gmatch(html, "(https?://[^ \n\r'><\")]+)") do
        host = string.sub(url, 0, string.find(url, '/', 9, true))
        urls[url] = host
    end

    for url, host in pairs(urls) do
        for k, supported_host in ipairs(hosts) do
            -- consider it is a video link if host matches one of supported hosts
            if string.find(host, supported_host) then
                t[url] = 1
                break -- ok there, go to next url
            end
        end
    end

    return t
end

-- vim: et:sw=4:ts=8:sts=4:tw=80
