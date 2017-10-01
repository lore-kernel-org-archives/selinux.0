Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91GHGO0018167
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 12:17:16 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 06866561235
 for <selinux@tycho.nsa.gov>; Sun,  1 Oct 2017 18:15:39 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  1 Oct 2017 18:15:15 +0200
Message-Id: <20171001161517.16407-2-nicolas.iooss@m4x.org>
In-Reply-To: <20171001161517.16407-1-nicolas.iooss@m4x.org>
References: <20171001161517.16407-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/4] gui: fix parsing of "semodule -lfull" in tab
 Modules
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The output of "semodule -lfull" changed from "module version" to
"priority module kind". Update system-config-selinux to use this new
format in its tab "Policy Module".

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/modulesPage.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index c7fde9ea1ef8..34c5d9e3c488 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -58,7 +58,8 @@ class modulesPage(semanagePage):
         self.module_filter.connect("activate", self.filter_changed)
         self.audit_enabled = False
 
-        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING)
+        self.store = Gtk.ListStore(GObject.TYPE_STRING, GObject.TYPE_STRING,
+                                   GObject.TYPE_STRING)
         self.view.set_model(self.store)
         self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
         col = Gtk.TreeViewColumn(_("Module Name"), Gtk.CellRendererText(), text=0)
@@ -66,7 +67,7 @@ class modulesPage(semanagePage):
         col.set_resizable(True)
         self.view.append_column(col)
         self.store.set_sort_column_id(0, Gtk.SortType.ASCENDING)
-        col = Gtk.TreeViewColumn(_("Version"), Gtk.CellRendererText(), text=1)
+        col = Gtk.TreeViewColumn(_("Priority"), Gtk.CellRendererText(), text=1)
         self.enable_audit_button = xml.get_object("enableAuditButton")
         self.enable_audit_button.connect("clicked", self.enable_audit)
         self.new_button = xml.get_object("newModuleButton")
@@ -74,6 +75,11 @@ class modulesPage(semanagePage):
         col.set_sort_column_id(1)
         col.set_resizable(True)
         self.view.append_column(col)
+        self.store.set_sort_column_id(2, Gtk.SortType.ASCENDING)
+        col = Gtk.TreeViewColumn(_("Kind"), Gtk.CellRendererText(), text=2)
+        col.set_sort_column_id(2)
+        col.set_resizable(True)
+        self.view.append_column(col)
         self.store.set_sort_func(1, self.sort_int, "")
         status, self.policy_type = selinux.selinux_getpolicytype()
 
@@ -95,16 +101,17 @@ class modulesPage(semanagePage):
         self.filter = filter
         self.store.clear()
         try:
-            fd = Popen("semodule -l", shell=True, stdout=PIPE).stdout
+            fd = Popen("semodule -lfull", shell=True, stdout=PIPE).stdout
             l = fd.readlines()
             fd.close()
             for i in l:
-                module, ver, newline = i.split('\t')
-                if not (self.match(module, filter) or self.match(ver, filter)):
+                priority, module, kind = i.decode('utf-8').split()
+                if not (self.match(module, filter) or self.match(priority, filter)):
                     continue
                 iter = self.store.append()
                 self.store.set_value(iter, 0, module.strip())
-                self.store.set_value(iter, 1, ver.strip())
+                self.store.set_value(iter, 1, priority.strip())
+                self.store.set_value(iter, 2, kind.strip())
         except:
             pass
         self.view.get_selection().select_path((0,))
-- 
2.14.2
