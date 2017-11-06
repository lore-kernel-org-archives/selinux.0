Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA6FYGae031738
 for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2017 10:34:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B69305F176
 for <selinux@tycho.nsa.gov>; Mon,  6 Nov 2017 15:00:50 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon,  6 Nov 2017 16:00:40 +0100
Message-Id: <20171106150040.25300-4-plautrba@redhat.com>
In-Reply-To: <20171106150040.25300-1-plautrba@redhat.com>
References: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20171106150040.25300-1-plautrba@redhat.com>
Subject: [PATCH 3/3] python/semanage: Enforce noreload only if it's
 requested by -N option
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

We want to call semanage_set_reload() only if -N option is used.

Fixes:

$ sudo umount /sys/fs/selinux

$ sudo semanage fcontext -a --type=postfix_local_tmp_t /var/opt/01789667
SELinux:  Could not downgrade policy file /etc/selinux/targeted/policy/policy.31, searching for an older version.
SELinux:  Could not open policy file <= /etc/selinux/targeted/policy/policy.31:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
SELinux:  Could not downgrade policy file /etc/selinux/targeted/policy/policy.31, searching for an older version.
SELinux:  Could not open policy file <= /etc/selinux/targeted/policy/policy.31:  No such file or directory
/sbin/load_policy:  Can't load policy:  No such file or directory
libsemanage.semanage_reload_policy: load_policy returned error code 2. (No such file or directory).
FileNotFoundError: [Errno 2] No such file or directory

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/semanage/semanage    | 15 +--------------
 python/semanage/seobject.py | 11 ++++++-----
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index bcac20b2..8d8a0860 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -183,7 +183,6 @@ def handleLogin(args):
     handle_opts(args, login_args, args.action)
 
     OBJECT = object_dict['login'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.login, args.seuser, args.range)
@@ -213,7 +212,7 @@ def parser_add_noheading(parser, name):
 
 
 def parser_add_noreload(parser, name):
-    parser.add_argument('-N', '--noreload', action='store_false', default=True, help=_('Do not reload policy after commit'))
+    parser.add_argument('-N', '--noreload', action='store_true', default=False, help=_('Do not reload policy after commit'))
 
 
 def parser_add_locallist(parser, name):
@@ -317,7 +316,6 @@ def handleFcontext(args):
         handle_opts(args, fcontext_args, args.action)
 
     OBJECT = object_dict['fcontext'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         if args.equal:
@@ -386,7 +384,6 @@ def handleUser(args):
     handle_opts(args, user_args, args.action)
 
     OBJECT = object_dict['user'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.selinux_name, args.roles, args.level, args.range, args.prefix)
@@ -437,7 +434,6 @@ def handlePort(args):
     handle_opts(args, port_args, args.action)
 
     OBJECT = object_dict['port'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.port, args.proto, args.range, args.type)
@@ -483,7 +479,6 @@ def handlePkey(args):
     handle_opts(args, ibpkey_args, args.action)
 
     OBJECT = object_dict['ibpkey'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.ibpkey, args.subnet_prefix, args.range, args.type)
@@ -527,7 +522,6 @@ def handleIbendport(args):
     handle_opts(args, ibendport_args, args.action)
 
     OBJECT = object_dict['ibendport'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.ibendport, args.ibdev_name, args.range, args.type)
@@ -571,7 +565,6 @@ def handleInterface(args):
     handle_opts(args, interface_args, args.action)
 
     OBJECT = object_dict['interface'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.interface, args.range, args.type)
@@ -611,7 +604,6 @@ def setupInterfaceParser(subparsers):
 
 def handleModule(args):
     OBJECT = seobject.moduleRecords(args)
-    OBJECT.set_reload(args.noreload)
     if args.action == "add":
         OBJECT.add(args.module_name, args.priority)
     if args.action == "enable":
@@ -654,7 +646,6 @@ def handleNode(args):
     handle_opts(args, node_args, args.action)
 
     OBJECT = object_dict['node'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "add":
         OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
@@ -701,7 +692,6 @@ def handleBoolean(args):
     handle_opts(args, boolean_args, args.action)
 
     OBJECT = object_dict['boolean'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "modify":
         if args.boolean:
@@ -740,7 +730,6 @@ def setupBooleanParser(subparsers):
 
 def handlePermissive(args):
     OBJECT = object_dict['permissive'](args)
-    OBJECT.set_reload(args.noreload)
 
     if args.action is "list":
         OBJECT.list(args.noheading)
@@ -775,7 +764,6 @@ def setupPermissiveParser(subparsers):
 
 def handleDontaudit(args):
     OBJECT = object_dict['dontaudit'](args)
-    OBJECT.set_reload(args.noreload)
     OBJECT.toggle(args.action)
 
 
@@ -876,7 +864,6 @@ def handleImport(args):
         except KeyboardInterrupt:
             sys.exit(0)
 
-    trans.set_reload(args.noreload)
     trans.finish()
 
 
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 00246fdd..228c8ae9 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -242,8 +242,11 @@ class semanageRecords:
 
     def __init__(self, args):
         global handle
-        self.load = True
         self.args = args
+        try:
+            self.noreload = args.noreload
+        except:
+            self.noreload = False
         self.sh = self.get_handle(args.store)
 
         rc, localstore = selinux.selinux_getpolicytype()
@@ -252,9 +255,6 @@ class semanageRecords:
         else:
             self.mylog = nulllogger()
 
-    def set_reload(self, load):
-        self.load = load
-
     def get_handle(self, store):
         global is_mls_enabled
 
@@ -314,7 +314,8 @@ class semanageRecords:
         if semanageRecords.transaction:
             return
 
-        semanage_set_reload(self.sh, self.load)
+        if self.noreload:
+            semanage_set_reload(self.sh, 0)
         rc = semanage_commit(self.sh)
         if rc < 0:
             self.mylog.commit(0)
-- 
2.14.3
