Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9JCaBXM014307
 for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2016 08:36:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F512C056793
 for <selinux@tycho.nsa.gov>; Wed, 19 Oct 2016 12:36:07 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/gui: fix system-config-selinux editing
 features
Date: Wed, 19 Oct 2016 14:36:03 +0200
Message-Id: <1476880563-20144-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Return column definitions to portsPage (gui fails to load otherwise).

fcontextPage:
  "ftype" dropdown was filled from 2 sources (system-config-selinux.glade
  and fcontextPage - from seobject module) which resulted in duplicate
  and invalid options. When given to "semanage fcontext -f", ftype has to be
  converted to 1 letter argument mode.

TreeView.get_selection().get_selected() can return "None" if no item is selected
(the list can be empty). Test if correct iterator was acquired.

Fixes:
  https://bugzilla.redhat.com/show_bug.cgi?id=1344842

Signed-off-by: vmojzis <vmojzis@redhat.com>
---
 policycoreutils/gui/fcontextPage.py             | 17 +++++------------
 policycoreutils/gui/portsPage.py                |  6 ++++++
 policycoreutils/gui/semanagePage.py             |  4 ++--
 policycoreutils/gui/system-config-selinux.glade |  2 +-
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/policycoreutils/gui/fcontextPage.py b/policycoreutils/gui/fcontextPage.py
index c176de4..2e26666 100644
--- a/policycoreutils/gui/fcontextPage.py
+++ b/policycoreutils/gui/fcontextPage.py
@@ -105,13 +105,6 @@ class fcontextPage(semanagePage):
         self.load()
         self.fcontextEntry = xml.get_widget("fcontextEntry")
         self.fcontextFileTypeCombo = xml.get_widget("fcontextFileTypeCombo")
-        liststore = self.fcontextFileTypeCombo.get_model()
-        for k in seobject.file_types:
-            if len(k) > 0 and k[0] != '-':
-                iter = liststore.append()
-                liststore.set_value(iter, 0, k)
-        iter = liststore.get_iter_first()
-        self.fcontextFileTypeCombo.set_active_iter(iter)
         self.fcontextTypeEntry = xml.get_widget("fcontextTypeEntry")
         self.fcontextMLSEntry = xml.get_widget("fcontextMLSEntry")
 
@@ -183,7 +176,7 @@ class fcontextPage(semanagePage):
             fspec = store.get_value(iter, SPEC_COL)
             ftype = store.get_value(iter, FTYPE_COL)
             self.wait()
-            (rc, out) = getstatusoutput("semanage fcontext -d -f '%s' '%s'" % (ftype, fspec))
+            (rc, out) = getstatusoutput("semanage fcontext -d -f '%s' '%s'" % (seobject.file_type_str_to_option[ftype], fspec))
             self.ready()
 
             if rc != 0:
@@ -194,14 +187,14 @@ class fcontextPage(semanagePage):
             self.error(e.args[0])
 
     def add(self):
-        ftype = ["", "--", "-d", "-c", "-b", "-s", "-l", "-p"]
         fspec = self.fcontextEntry.get_text().strip()
         type = self.fcontextTypeEntry.get_text().strip()
         mls = self.fcontextMLSEntry.get_text().strip()
         list_model = self.fcontextFileTypeCombo.get_model()
-        active = self.fcontextFileTypeCombo.get_active()
+        it = self.fcontextFileTypeCombo.get_active_iter()
+        ftype = list_model.get_value(it,0)
         self.wait()
-        (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, ftype[active], fspec))
+        (rc, out) = getstatusoutput("semanage fcontext -a -t %s -r %s -f '%s' '%s'" % (type, mls, seobject.file_type_str_to_option[ftype], fspec))
         self.ready()
         if rc != 0:
             self.error(out)
@@ -220,7 +213,7 @@ class fcontextPage(semanagePage):
         iter = self.fcontextFileTypeCombo.get_active_iter()
         ftype = list_model.get_value(iter, 0)
         self.wait()
-        (rc, out) = getstatusoutput("semanage fcontext -m -t %s -r %s -f '%s' '%s'" % (type, mls, ftype, fspec))
+        (rc, out) = getstatusoutput("semanage fcontext -m -t %s -r %s -f '%s' '%s'" % (type, mls, seobject.file_type_str_to_option[ftype], fspec))
         self.ready()
         if rc != 0:
             self.error(out)
diff --git a/policycoreutils/gui/portsPage.py b/policycoreutils/gui/portsPage.py
index b6445db..b8fdaad 100644
--- a/policycoreutils/gui/portsPage.py
+++ b/policycoreutils/gui/portsPage.py
@@ -23,6 +23,12 @@ import os
 import gobject
 import sys
 import seobject
+
+TYPE_COL = 0
+PROTOCOL_COL = 1
+MLS_COL = 2
+PORT_COL = 3
+
 try:
     from subprocess import getstatusoutput
 except ImportError:
diff --git a/policycoreutils/gui/semanagePage.py b/policycoreutils/gui/semanagePage.py
index 1f14d56..27367f3 100644
--- a/policycoreutils/gui/semanagePage.py
+++ b/policycoreutils/gui/semanagePage.py
@@ -130,8 +130,8 @@ class semanagePage:
         dlg.destroy()
 
     def deleteDialog(self):
-        store, iter = self.view.get_selection().get_selected()
-        if self.verify(_("Are you sure you want to delete %s '%s'?" % (self.description, store.get_value(iter, 0))), _("Delete %s" % self.description)) == gtk.RESPONSE_YES:
+        store, it = self.view.get_selection().get_selected()
+        if (it is not None) and (self.verify(_("Are you sure you want to delete %s '%s'?" % (self.description, store.get_value(it, 0))), _("Delete %s" % self.description)) == gtk.RESPONSE_YES):
             self.delete()
 
     def use_menus(self):
diff --git a/policycoreutils/gui/system-config-selinux.glade b/policycoreutils/gui/system-config-selinux.glade
index 05a697e..4547b3f 100644
--- a/policycoreutils/gui/system-config-selinux.glade
+++ b/policycoreutils/gui/system-config-selinux.glade
@@ -729,7 +729,7 @@ regular file
 directory
 character device
 block device
-socket
+socket file
 symbolic link
 named pipe
 </property>
-- 
2.7.4
