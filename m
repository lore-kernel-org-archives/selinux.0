Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYMKW011354
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:29 -0400
Received: by mail-pa0-f65.google.com with SMTP id q2so17934449pap.0
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:28 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/12] semanage: misc style issues
Date: Fri,  5 Aug 2016 02:33:56 +0800
Message-Id: <1470335645-24224-4-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unused imports
== None should be is None

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/semanage/semanage         |  5 +++--
 policycoreutils/semanage/seobject.py      | 15 +++++----------
 policycoreutils/semanage/test-semanage.py |  3 ---
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 954411d..e6e3a49 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -23,6 +23,7 @@
 #
 #
 
+import traceback
 import argparse
 import seobject
 import sys
@@ -111,7 +112,7 @@ class SetExportFile(argparse.Action):
                 try:
                     sys.stdout = open(values, 'w')
                 except:
-                    sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
+                    sys.stderr.write(traceback.format_exc())
                     sys.exit(1)
         setattr(namespace, self.dest, values)
 
@@ -702,7 +703,7 @@ def handlePermissive(args):
 
     if args.action is "list":
         OBJECT.list(args.noheading)
-    elif args.type != None:
+    elif args.type is not None:
         if args.action is "add":
             OBJECT.add(args.type)
         if args.action is "delete":
diff --git a/policycoreutils/semanage/seobject.py b/policycoreutils/semanage/seobject.py
index 66ff00e..5100720 100644
--- a/policycoreutils/semanage/seobject.py
+++ b/policycoreutils/semanage/seobject.py
@@ -23,14 +23,11 @@
 
 import pwd
 import grp
-import string
 import selinux
-import tempfile
 import os
 import re
 import sys
 import stat
-import shutil
 from semanage import *
 PROGNAME = "policycoreutils"
 import sepolicy
@@ -129,9 +126,9 @@ except:
                 message += " role=" + serole
             if oldserole != "":
                 message += " old_role=" + oldserole
-            if serange != "" and serange != None:
+            if serange != "" and serange is not None:
                 message += " MLSRange=" + serange
-            if oldserange != "" and oldserange != None:
+            if oldserange != "" and oldserange is not None:
                 message += " old_MLSRange=" + oldserange
             self.log_list.append(message)
 
@@ -416,7 +413,7 @@ class dontauditClass(semanageRecords):
         if dontaudit not in ["on", "off"]:
             raise ValueError(_("dontaudit requires either 'on' or 'off'"))
         self.begin()
-        rc = semanage_set_disable_dontaudit(self.sh, dontaudit == "off")
+        semanage_set_disable_dontaudit(self.sh, dontaudit == "off")
         self.commit()
 
 
@@ -459,7 +456,6 @@ class permissiveRecords(semanageRecords):
             print(t)
 
     def add(self, type):
-        import glob
         try:
             import sepolgen.module as module
         except ImportError:
@@ -830,7 +826,6 @@ class seluserRecords(semanageRecords):
         self.mylog.log("seuser", sename=name, serole=",".join(roles), serange=serange)
 
     def add(self, name, roles, selevel, serange, prefix):
-        serole = " ".join(roles)
         try:
             self.begin()
             self.__add(name, roles, selevel, serange, prefix)
@@ -1897,7 +1892,7 @@ class fcontextRecords(semanageRecords):
         if setype != "<<none>>":
             con = semanage_fcontext_get_con(fcontext)
 
-            if con == None:
+            if con is None:
                 con = self.createcon(target)
 
             if (is_mls_enabled == 1) and (serange != ""):
@@ -2071,7 +2066,7 @@ class booleanRecords(semanageRecords):
             self.current_booleans = []
             ptype = None
 
-        if self.store == None or self.store == ptype:
+        if self.store is None or self.store == ptype:
             self.modify_local = True
         else:
             self.modify_local = False
diff --git a/policycoreutils/semanage/test-semanage.py b/policycoreutils/semanage/test-semanage.py
index 10c4d8f..12ffc98 100644
--- a/policycoreutils/semanage/test-semanage.py
+++ b/policycoreutils/semanage/test-semanage.py
@@ -1,8 +1,5 @@
 import unittest
-import os
-import shutil
 import sys
-from tempfile import mkdtemp
 from subprocess import Popen, PIPE
 
 import argparse
-- 
2.7.3
