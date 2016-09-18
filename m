Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8IFkp70030139
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 11:46:51 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 6BC4F1A1A8
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 17:46:14 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id Vawm5HxFbQ89 for <selinux@tycho.nsa.gov>;
 Sun, 18 Sep 2016 17:46:10 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:a03f:d9:8b00:faa3:456b:4d88:6dc7])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id B588A1A06E
 for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2016 17:46:10 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] sandbox: Use GObject introspection binding instead of pygtk2
Date: Sun, 18 Sep 2016 17:46:09 +0200
Message-Id: <20160918154609.8168-1-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

sandbox command is also now using GTK 3.0

This patch comes from Fedora patch set
---
 policycoreutils/sandbox/sandbox | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 9f200d5..726ba9b 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -111,16 +111,18 @@ def copyfile(file, srcdir, dest):
 def savefile(new, orig, X_ind):
     copy = False
     if(X_ind):
-        import gtk
-        dlg = gtk.MessageDialog(None, 0, gtk.MESSAGE_INFO,
-                                gtk.BUTTONS_YES_NO,
+        import gi
+        gi.require_version('Gtk', '3.0')
+        from gi.repository import Gtk
+        dlg = Gtk.MessageDialog(None, 0, Gtk.MessageType.INFO,
+                                Gtk.ButtonsType.YES_NO,
                                 _("Do you want to save changes to '%s' (Y/N): ") % orig)
         dlg.set_title(_("Sandbox Message"))
-        dlg.set_position(gtk.WIN_POS_MOUSE)
+        dlg.set_position(Gtk.WindowPosition.MOUSE)
         dlg.show_all()
         rc = dlg.run()
         dlg.destroy()
-        if rc == gtk.RESPONSE_YES:
+        if rc == Gtk.ResponseType.YES:
             copy = True
     else:
         try:
@@ -452,8 +454,10 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                     if self.__options.dpi:
                         dpi = self.__options.dpi
                     else:
-                        import gtk
-                        dpi = str(gtk.settings_get_default().props.gtk_xft_dpi / 1024)
+                        import gi
+                        gi.require_version('Gtk', '3.0')
+                        from gi.repository import Gtk
+                        dpi = str(Gtk.Settings.get_default().props.gtk_xft_dpi / 1024)
 
                     xmodmapfile = self.__homedir + "/.xmodmap"
                     xd = open(xmodmapfile, "w")
-- 
2.9.3
