Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vBDCGmBX011317
 for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2017 07:16:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 021716F5
 for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2017 12:16:42 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 13 Dec 2017 13:16:33 +0100
Message-Id: <20171213121633.11721-1-plautrba@redhat.com>
Subject: [PATCH] python/semanage: make seobject.py backward
 compatible
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 985753f changed behavior of seobject class constructors. While
semanage itself was fixed, there are other tools like
system-config-selinux and chcat which depend on the original behavior.
This change make the constructors backward compatible.

Fixes: $ system-config-selinux
Traceback (most recent call last):
  File "/usr/share/system-config-selinux/system-config-selinux.py", line 196, in <module>
    app = childWindow()
  File "/usr/share/system-config-selinux/system-config-selinux.py", line 100, in __init__
    self.add_page(booleansPage.booleansPage(xml))
  File "/usr/share/system-config-selinux/booleansPage.py", line 142, in __init__
    self.load(self.filter)
  File "/usr/share/system-config-selinux/booleansPage.py", line 212, in load
    self.booleans = seobject.booleanRecords()
TypeError: __init__() missing 1 required positional argument: 'args'

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/seobject.py | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 770745e4..b927b184 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -240,17 +240,22 @@ class semanageRecords:
     store = None
     args = None
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         global handle
-        self.args = args
-        try:
-            self.noreload = args.noreload
-        except:
-            self.noreload = False
-        self.sh = self.get_handle(args.store)
+        if args:
+            # legacy code - args was store originally
+            if type(args) == str:
+                self.store = args
+            else:
+                self.args = args
+        self.noreload = getattr(args, "noreload", False)
+        if not self.store:
+            self.store = getattr(args, "store", "")
+
+        self.sh = self.get_handle(self.store)
 
         rc, localstore = selinux.selinux_getpolicytype()
-        if args.store == "" or args.store == localstore:
+        if self.store == "" or self.store == localstore:
             self.mylog = logger()
         else:
             self.mylog = nulllogger()
@@ -331,7 +336,7 @@ class semanageRecords:
 
 class moduleRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def get_all(self):
@@ -443,7 +448,7 @@ class moduleRecords(semanageRecords):
 
 class dontauditClass(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def toggle(self, dontaudit):
@@ -456,7 +461,7 @@ class dontauditClass(semanageRecords):
 
 class permissiveRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def get_all(self):
@@ -525,7 +530,7 @@ class permissiveRecords(semanageRecords):
 
 class loginRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         self.oldsename = None
         self.oldserange = None
@@ -782,7 +787,7 @@ class loginRecords(semanageRecords):
 
 class seluserRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def get(self, name):
@@ -1045,7 +1050,7 @@ class portRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def __genkey(self, port, proto):
@@ -1320,7 +1325,7 @@ class ibpkeyRecords(semanageRecords):
     except:
         valid_types = []
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def __genkey(self, pkey, subnet_prefix):
@@ -1573,7 +1578,7 @@ class ibendportRecords(semanageRecords):
     except:
         valid_types = []
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def __genkey(self, ibendport, ibdev_name):
@@ -1809,7 +1814,7 @@ class nodeRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         self.protocol = ["ipv4", "ipv6"]
 
@@ -2045,7 +2050,7 @@ class nodeRecords(semanageRecords):
 
 class interfaceRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
 
     def __add(self, interface, serange, ctype):
@@ -2242,7 +2247,7 @@ class fcontextRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         self.equiv = {}
         self.equiv_dist = {}
@@ -2631,7 +2636,7 @@ class fcontextRecords(semanageRecords):
 
 class booleanRecords(semanageRecords):
 
-    def __init__(self, args):
+    def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         self.dict = {}
         self.dict["TRUE"] = 1
-- 
2.15.1
