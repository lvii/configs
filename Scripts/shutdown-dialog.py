#!/usr/bin/env python2

# shutdown-dialog - logout/reboot/shutdown your computer with an
# easy-to-use dialog
# Copyright (C) 2008  Penguin Development
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import pygtk
pygtk.require("2.0")
import gtk

import os
import sys
import subprocess
import time

LOGOUT_COMMAND = "sudo killall X"

class ShutdownDialog:
    def __init__(self):
        iconsize = gtk.icon_size_register("64x64", 64, 64)

        self.window = gtk.Window()
        self.window.set_decorated(False)
        self.window.set_keep_above(True)

        self.frame1 = gtk.Frame()
        self.frame2 = gtk.Frame()
        self.frame3 = gtk.Frame()

        self.layoutBox = gtk.VBox(False, 5)
        self.layoutBox.set_border_width(5)
        self.buttonsBox1 = gtk.HBox(True, 5)
        self.buttonsBox2 = gtk.HBox(True, 5)
        self.buttonsBox3 = gtk.HBox(True, 5)
        self.buttonsBox1.set_border_width(5)
        self.buttonsBox2 = gtk.HBox(True, 5)
        self.buttonsBox2.set_border_width(5)
        self.buttonsBox3.set_border_width(5)
        self.cancelButtonAlignment = gtk.Alignment(1.0, 0.5)

        self.logoutButton = gtk.Button("Logout")
        ico = gtk.Image()
        ico.set_from_icon_name("gnome-logout", iconsize)
        self.logoutButton.set_image(ico)

        self.restartButton = gtk.Button("Restart")
        ico = gtk.Image()
        ico.set_from_icon_name("gnome-session-reboot", iconsize)
        self.restartButton.set_image(ico)

        self.haltButton = gtk.Button("Shutdown")
        ico = gtk.Image()
        ico.set_from_icon_name("gnome-shutdown", iconsize)
        self.haltButton.set_image(ico)

        self.suspendButton = gtk.Button("Suspend")
        ico = gtk.Image()
        ico.set_from_icon_name("gnome-session-suspend", iconsize)
        self.suspendButton.set_image(ico)

        self.hibernateButton = gtk.Button("Hibernate")
        ico = gtk.Image()
        ico.set_from_icon_name("gnome-session-hibernate", iconsize)
        self.hibernateButton.set_image(ico)

        self.cancelButton = gtk.Button(None, gtk.STOCK_CANCEL)

        self.buttonsBox1.pack_start(self.logoutButton)
        self.buttonsBox2.pack_start(self.restartButton)
        self.buttonsBox2.pack_start(self.haltButton)
        self.buttonsBox3.pack_start(self.suspendButton)
        self.buttonsBox3.pack_start(self.hibernateButton)
        self.cancelButtonAlignment.add(self.cancelButton)
        self.frame1.add(self.buttonsBox1)
        self.frame2.add(self.buttonsBox2)
        self.frame3.add(self.buttonsBox3)
        self.layoutBox.pack_start(self.frame1)
        self.layoutBox.pack_start(self.frame2)
        self.layoutBox.pack_start(self.frame3)
        self.layoutBox.pack_start(self.cancelButtonAlignment)

        self.window.add(self.layoutBox)

        self.window.show_all()

        self.window.set_gravity(gtk.gdk.GRAVITY_NORTH_WEST)
        w, h = self.window.get_size()
        self.window.move(gtk.gdk.screen_width() / 2 - w / 2,
			gtk.gdk.screen_height() / 2 - h / 2)

        self.window.connect("delete-event", self.terminate)
        self.cancelButton.connect("clicked", self.terminate)

        self.logoutButton.connect("clicked", self.logout)
        self.restartButton.connect("clicked", self.reboot)
        self.haltButton.connect("clicked", self.shutdown)
        self.suspendButton.connect("clicked", self.suspend)
        self.hibernateButton.connect("clicked", self.hibernate)

    def main(self):
        gtk.main()

    def terminate(self, widget = None, data = None):
        gtk.main_quit()

    def logout(self, widget = None, data = None):
        self.callcmd(LOGOUT_COMMAND)

    def shutdown(self, widget = None, data = None):
        self.callcmd("sudo /sbin/shutdown -h now")

    def reboot(self, widget = None, data = None):
        self.callcmd("sudo /sbin/shutdown -r now")

    def suspend(self, widget = None, data = None):
        self.callcmd("sudo /usr/sbin/pm-suspend")

    def hibernate(self, widget = None, data = None):
        self.callcmd("sudo /usr/sbin/pm-hibernate")

    def callcmd(self, cmd):
        proc = subprocess.Popen(cmd, stdout = subprocess.PIPE, stderr =
                subprocess.PIPE, shell = True)
        starttime = time.time() * 1000

        status = proc.poll()
        while status is None and time.time() * 1000 < starttime + 5000:
            status = proc.poll()

        if status is None:
            if sys.hexversion >= 0x02060000:
                proc.kill()
            else:
                subprocess.Popen("kill -9 " + str(proc.pid), shell = True)

        if status != 0:
            subprocess.Popen(cmd, shell = True)

        self.terminate()

def main():
    shutdownDialog = ShutdownDialog()
    shutdownDialog.main()

if __name__ == "__main__":
    LOGOUT_COMMAND = os.getenv("LOGOUT_COMMAND", LOGOUT_COMMAND)

    if len(sys.argv) > 1:
        LOGOUT_COMMAND = " ".join(sys.argv[1:])

    main()
