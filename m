Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0PKs0iO013330
 for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2018 15:54:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 3zSDld3Y37z2KHws
 for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2018 20:53:33 +0000 (UTC)
Received: from UPDC3CPA05.eemsg.mil (unknown [192.168.18.12])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 3zSDld2vxzz2KHwq
 for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2018 20:53:33 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 814A156484B
 for <selinux@tycho.nsa.gov>; Thu, 25 Jan 2018 21:52:00 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Thu, 25 Jan 2018 21:51:13 +0100
Message-Id: <20180125205113.18453-2-nicolas.iooss@m4x.org>
In-Reply-To: <20180125205113.18453-1-nicolas.iooss@m4x.org>
References: <20180125205113.18453-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] gui: remove "new" button in Modules page
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This used to invoke polgengui, which has been removed.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/modulesPage.py           |  8 --------
 gui/system-config-selinux.ui | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/gui/modulesPage.py b/gui/modulesPage.py
index 34c5d9e3c488..8a325155451f 100644
--- a/gui/modulesPage.py
+++ b/gui/modulesPage.py
@@ -70,8 +70,6 @@ class modulesPage(semanagePage):
         col = Gtk.TreeViewColumn(_("Priority"), Gtk.CellRendererText(), text=1)
         self.enable_audit_button = xml.get_object("enableAuditButton")
         self.enable_audit_button.connect("clicked", self.enable_audit)
-        self.new_button = xml.get_object("newModuleButton")
-        self.new_button.connect("clicked", self.new_module)
         col.set_sort_column_id(1)
         col.set_resizable(True)
         self.view.append_column(col)
@@ -116,12 +114,6 @@ class modulesPage(semanagePage):
             pass
         self.view.get_selection().select_path((0,))
 
-    def new_module(self, args):
-        try:
-            Popen(["/usr/share/system-config-selinux/polgengui.py"])
-        except ValueError as e:
-            self.error(e.args[0])
-
     def delete(self):
         store, iter = self.view.get_selection().get_selected()
         module = store.get_value(iter, 0)
diff --git a/gui/system-config-selinux.ui b/gui/system-config-selinux.ui
index 7cc1cc532a1f..f5d0bb728eca 100644
--- a/gui/system-config-selinux.ui
+++ b/gui/system-config-selinux.ui
@@ -1595,18 +1595,6 @@ Level</property>
                         <property name="visible">True</property>
                         <property name="can_focus">False</property>
                         <property name="toolbar_style">both</property>
-                        <child>
-                          <object class="GtkToolButton" id="newModuleButton">
-                            <property name="visible">True</property>
-                            <property name="can_focus">False</property>
-                            <property name="tooltip_text" translatable="yes">Generate new policy module</property>
-                            <property name="stock_id">gtk-new</property>
-                          </object>
-                          <packing>
-                            <property name="expand">False</property>
-                            <property name="homogeneous">True</property>
-                          </packing>
-                        </child>
                         <child>
                           <object class="GtkToolButton" id="toolbutton23">
                             <property name="visible">True</property>
-- 
2.16.0
