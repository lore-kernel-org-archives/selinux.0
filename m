Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA6FhnoU003388
 for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2017 10:43:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96D377EA8F
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:00:49 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Nov 2017 16:00:39 +0100
Message-Id: <20171106150040.25300-3-plautrba@redhat.com>
In-Reply-To: <20171106150040.25300-1-plautrba@redhat.com>
References: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20171106150040.25300-1-plautrba@redhat.com>
Subject: [PATCH 2/3] python/semanage: Don't use global setup variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In order to do that we need to propagate args into seobject objects and
use args.store to get a store name.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage    | 40 +++++++++++------------------
 python/semanage/seobject.py | 62 +++++++++++++++++++++++----------------------
 2 files changed, 47 insertions(+), 55 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 8acfc855..bcac20b2 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -89,16 +89,6 @@ class CheckRole(argparse.Action):
             newval.append(v)
         setattr(namespace, self.dest, newval)
 
-store = ''
-
-
-class SetStore(argparse.Action):
-
-    def __call__(self, parser, namespace, values, option_string=None):
-        global store
-        store = values
-        setattr(namespace, self.dest, values)
-
 
 class seParser(argparse.ArgumentParser):
 
@@ -192,7 +182,7 @@ def handleLogin(args):
 
     handle_opts(args, login_args, args.action)
 
-    OBJECT = object_dict['login']()
+    OBJECT = object_dict['login'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -211,7 +201,7 @@ def handleLogin(args):
 
 
 def parser_add_store(parser, name):
-    parser.add_argument('-S', '--store', action=SetStore, help=_("Select an alternate SELinux Policy Store to manage"))
+    parser.add_argument('-S', '--store', default='', help=_("Select an alternate SELinux Policy Store to manage"))
 
 
 def parser_add_priority(parser, name):
@@ -326,7 +316,7 @@ def handleFcontext(args):
     else:
         handle_opts(args, fcontext_args, args.action)
 
-    OBJECT = object_dict['fcontext']()
+    OBJECT = object_dict['fcontext'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -395,7 +385,7 @@ def handleUser(args):
 
     handle_opts(args, user_args, args.action)
 
-    OBJECT = object_dict['user']()
+    OBJECT = object_dict['user'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -446,7 +436,7 @@ def handlePort(args):
 
     handle_opts(args, port_args, args.action)
 
-    OBJECT = object_dict['port']()
+    OBJECT = object_dict['port'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -492,7 +482,7 @@ def handlePkey(args):
 
     handle_opts(args, ibpkey_args, args.action)
 
-    OBJECT = object_dict['ibpkey']()
+    OBJECT = object_dict['ibpkey'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -536,7 +526,7 @@ def handleIbendport(args):
 
     handle_opts(args, ibendport_args, args.action)
 
-    OBJECT = object_dict['ibendport']()
+    OBJECT = object_dict['ibendport'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -580,7 +570,7 @@ def handleInterface(args):
 
     handle_opts(args, interface_args, args.action)
 
-    OBJECT = object_dict['interface']()
+    OBJECT = object_dict['interface'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -620,7 +610,7 @@ def setupInterfaceParser(subparsers):
 
 
 def handleModule(args):
-    OBJECT = seobject.moduleRecords(store)
+    OBJECT = seobject.moduleRecords(args)
     OBJECT.set_reload(args.noreload)
     if args.action == "add":
         OBJECT.add(args.module_name, args.priority)
@@ -663,7 +653,7 @@ def handleNode(args):
     node_args = {'list': [('node', 'type', 'proto', 'netmask'), ('')], 'add': [('locallist'), ('type', 'node', 'proto', 'netmask')], 'modify': [('locallist'), ('node', 'netmask', 'proto')], 'delete': [('locallist'), ('node', 'netmask', 'prototype')], 'extract': [('locallist', 'node', 'type', 'proto', 'netmask'), ('')], 'deleteall': [('locallist'), ('')]}
     handle_opts(args, node_args, args.action)
 
-    OBJECT = object_dict['node']()
+    OBJECT = object_dict['node'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
@@ -710,7 +700,7 @@ def handleBoolean(args):
 
     handle_opts(args, boolean_args, args.action)
 
-    OBJECT = object_dict['boolean']()
+    OBJECT = object_dict['boolean'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "modify":
@@ -749,7 +739,7 @@ def setupBooleanParser(subparsers):
 
 
 def handlePermissive(args):
-    OBJECT = object_dict['permissive']()
+    OBJECT = object_dict['permissive'](args)
     OBJECT.set_reload(args.noreload)
 
     if args.action is "list":
@@ -784,7 +774,7 @@ def setupPermissiveParser(subparsers):
 
 
 def handleDontaudit(args):
-    OBJECT = object_dict['dontaudit']()
+    OBJECT = object_dict['dontaudit'](args)
     OBJECT.set_reload(args.noreload)
     OBJECT.toggle(args.action)
 
@@ -802,7 +792,7 @@ def handleExport(args):
     for i in manageditems:
         print("%s -D" % i)
     for i in manageditems:
-        OBJECT = object_dict[i]()
+        OBJECT = object_dict[i](args)
         for c in OBJECT.customized():
             print("%s %s" % (i, str(c)))
 
@@ -866,7 +856,7 @@ def mkargv(line):
 
 
 def handleImport(args):
-    trans = seobject.semanageRecords(store)
+    trans = seobject.semanageRecords(args)
     trans.start()
 
     for l in sys.stdin.readlines():
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 1385315f..00246fdd 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -238,14 +238,16 @@ class semanageRecords:
     transaction = False
     handle = None
     store = None
+    args = None
 
-    def __init__(self, store):
+    def __init__(self, args):
         global handle
         self.load = True
-        self.sh = self.get_handle(store)
+        self.args = args
+        self.sh = self.get_handle(args.store)
 
         rc, localstore = selinux.selinux_getpolicytype()
-        if store == "" or store == localstore:
+        if args.store == "" or args.store == localstore:
             self.mylog = logger()
         else:
             self.mylog = nulllogger()
@@ -328,8 +330,8 @@ class semanageRecords:
 
 class moduleRecords(semanageRecords):
 
-    def __init__(self, store):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def get_all(self):
         l = []
@@ -440,8 +442,8 @@ class moduleRecords(semanageRecords):
 
 class dontauditClass(semanageRecords):
 
-    def __init__(self, store):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def toggle(self, dontaudit):
         if dontaudit not in ["on", "off"]:
@@ -453,8 +455,8 @@ class dontauditClass(semanageRecords):
 
 class permissiveRecords(semanageRecords):
 
-    def __init__(self, store):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def get_all(self):
         l = []
@@ -522,8 +524,8 @@ class permissiveRecords(semanageRecords):
 
 class loginRecords(semanageRecords):
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
         self.oldsename = None
         self.oldserange = None
         self.sename = None
@@ -534,7 +536,7 @@ class loginRecords(semanageRecords):
         if sename == "":
             sename = "user_u"
 
-        userrec = seluserRecords()
+        userrec = seluserRecords(self.args)
         range, (rc, oldserole) = userrec.get(self.oldsename)
         range, (rc, serole) = userrec.get(sename)
 
@@ -603,7 +605,7 @@ class loginRecords(semanageRecords):
         if sename == "" and serange == "":
             raise ValueError(_("Requires seuser or serange"))
 
-        userrec = seluserRecords()
+        userrec = seluserRecords(self.args)
         range, (rc, oldserole) = userrec.get(self.oldsename)
 
         if sename != "":
@@ -660,7 +662,7 @@ class loginRecords(semanageRecords):
 
     def __delete(self, name):
         rec, self.oldsename, self.oldserange = selinux.getseuserbyname(name)
-        userrec = seluserRecords()
+        userrec = seluserRecords(self.args)
         range, (rc, oldserole) = userrec.get(self.oldsename)
 
         (rc, k) = semanage_seuser_key_create(self.sh, name)
@@ -779,8 +781,8 @@ class loginRecords(semanageRecords):
 
 class seluserRecords(semanageRecords):
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def get(self, name):
         (rc, k) = semanage_user_key_create(self.sh, name)
@@ -1042,8 +1044,8 @@ class portRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def __genkey(self, port, proto):
         if proto == "tcp":
@@ -1317,8 +1319,8 @@ class ibpkeyRecords(semanageRecords):
     except:
         valid_types = []
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def __genkey(self, pkey, subnet_prefix):
         if subnet_prefix == "":
@@ -1572,8 +1574,8 @@ class ibendportRecords(semanageRecords):
     except:
         valid_types = []
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def __genkey(self, ibendport, ibdev_name):
         if ibdev_name == "":
@@ -1810,8 +1812,8 @@ class nodeRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
         self.protocol = ["ipv4", "ipv6"]
 
     def validate(self, addr, mask, protocol):
@@ -2046,8 +2048,8 @@ class nodeRecords(semanageRecords):
 
 class interfaceRecords(semanageRecords):
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
 
     def __add(self, interface, serange, ctype):
         if is_mls_enabled == 1:
@@ -2243,8 +2245,8 @@ class fcontextRecords(semanageRecords):
     except RuntimeError:
         valid_types = []
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
         self.equiv = {}
         self.equiv_dist = {}
         self.equal_ind = False
@@ -2632,8 +2634,8 @@ class fcontextRecords(semanageRecords):
 
 class booleanRecords(semanageRecords):
 
-    def __init__(self, store=""):
-        semanageRecords.__init__(self, store)
+    def __init__(self, args):
+        semanageRecords.__init__(self, args)
         self.dict = {}
         self.dict["TRUE"] = 1
         self.dict["FALSE"] = 0
-- 
2.14.3
