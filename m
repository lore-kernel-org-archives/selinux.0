Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w74JmZoQ007487
 for <selinux@tycho.nsa.gov>; Sat, 4 Aug 2018 15:48:39 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 74DF4561220
 for <selinux@tycho.nsa.gov>; Sat,  4 Aug 2018 21:48:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  4 Aug 2018 21:47:26 +0200
Message-Id: <20180804194734.12577-6-nicolas.iooss@m4x.org>
In-Reply-To: <20180804194734.12577-1-nicolas.iooss@m4x.org>
References: <20180804194734.12577-1-nicolas.iooss@m4x.org>
Subject: [PATCH 05/13] python/sepolicy: use lowercase variable name
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SELinuxGui.files_initial_data_insert() uses both "seLinux_label" and
"selinux_label", which leads to using an undefined variable, as reported
by flake8:

    python/sepolicy/sepolicy/gui.py:1191:42: F821 undefined name 'selinux_label'

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/gui.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index 537d5168a536..16f24a0ab2f9 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -1175,7 +1175,7 @@ class SELinuxGui():
                         continue
                 self.files_initial_data_insert(self.writable_files_liststore, path, write, file_class)
 
-    def files_initial_data_insert(self, liststore, path, seLinux_label, file_class):
+    def files_initial_data_insert(self, liststore, path, selinux_label, file_class):
         iter = liststore.append(None)
         if path is None:
             path = _("MISSING FILE PATH")
@@ -1191,7 +1191,7 @@ class SELinuxGui():
                 file_class = self.markup(selinux_label)
                 file_class = self.markup(file_class)
         liststore.set_value(iter, 0, path)
-        liststore.set_value(iter, 1, seLinux_label)
+        liststore.set_value(iter, 1, selinux_label)
         liststore.set_value(iter, 2, file_class)
         liststore.set_value(iter, 7, modify)
 
-- 
2.18.0
