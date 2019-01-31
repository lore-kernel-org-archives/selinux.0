Return-Path: <SRS0=JPc9=QH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD3C282DB
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE62218AF
	for <selinux@archiver.kernel.org>; Thu, 31 Jan 2019 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfAaVIQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:08:16 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:51284 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfAaVIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Jan 2019 16:08:16 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 007D75646AC
        for <selinux@vger.kernel.org>; Thu, 31 Jan 2019 22:08:12 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/3] python: use == or != when comparing a variable with a string or a integer
Date:   Thu, 31 Jan 2019 22:07:52 +0100
Message-Id: <20190131210753.11221-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131210753.11221-1-nicolas.iooss@m4x.org>
References: <20190131210753.11221-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jan 31 22:08:13 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Flake8 3.7.0 added a new fatal error message when parsing Python files:

    python/semanage/semanage:112:16: F632 use ==/!= to compare str, bytes, and int literals
    python/semanage/semanage:124:23: F632 use ==/!= to compare str, bytes, and int literals
    ...
    python/sepolgen/src/sepolgen/output.py:77:8: F632 use ==/!= to compare str, bytes, and int literals
    python/sepolgen/src/sepolgen/output.py:80:8: F632 use ==/!= to compare str, bytes, and int literals
    python/sepolgen/src/sepolgen/output.py:83:8: F632 use ==/!= to compare str, bytes, and int literals
    python/sepolicy/sepolicy/generate.py:646:16: F632 use ==/!= to compare str, bytes, and int literals
    python/sepolicy/sepolicy/generate.py:1349:16: F632 use ==/!= to compare str, bytes, and int literals

Fix all these warnings.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/semanage               | 118 ++++++++++++-------------
 python/sepolgen/src/sepolgen/output.py |   6 +-
 python/sepolicy/sepolicy/generate.py   |   4 +-
 3 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 49add51ec24e..6afeac140b08 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -109,7 +109,7 @@ class SetExportFile(argparse.Action):
 
     def __call__(self, parser, namespace, values, option_string=None):
         if values:
-            if values is not "-":
+            if values != "-":
                 try:
                     sys.stdout = open(values, 'w')
                 except:
@@ -121,7 +121,7 @@ class SetExportFile(argparse.Action):
 class SetImportFile(argparse.Action):
 
     def __call__(self, parser, namespace, values, option_string=None):
-        if values and values is not "-":
+        if values and values != "-":
             try:
                 sys.stdin = open(values, 'r')
             except IOError as e:
@@ -189,17 +189,17 @@ def handleLogin(args):
 
     OBJECT = object_dict['login'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.login, args.seuser, args.range)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.login, args.seuser, args.range)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.login)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("login %s" % (str(i)))
 
@@ -322,26 +322,26 @@ def handleFcontext(args):
 
     OBJECT = object_dict['fcontext'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         if args.equal:
             OBJECT.add_equal(args.file_spec, args.equal)
         else:
             OBJECT.add(args.file_spec, args.type, args.ftype, args.range, args.seuser)
-    if args.action is "modify":
+    if args.action == "modify":
         if args.equal:
             OBJECT.add_equal(args.file_spec, args.equal)
         else:
             OBJECT.modify(args.file_spec, args.type, args.ftype, args.range, args.seuser)
-    if args.action is "delete":
+    if args.action == "delete":
         if args.equal:
             OBJECT.delete(args.file_spec, args.equal)
         else:
             OBJECT.delete(args.file_spec, args.ftype)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("fcontext %s" % str(i))
 
@@ -390,17 +390,17 @@ def handleUser(args):
 
     OBJECT = object_dict['user'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.selinux_name, args.roles, args.level, args.range, args.prefix)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.selinux_name, args.roles, args.level, args.range, args.prefix)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.selinux_name)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("user %s" % str(i))
 
@@ -440,17 +440,17 @@ def handlePort(args):
 
     OBJECT = object_dict['port'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.port, args.proto, args.range, args.type)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.port, args.proto, args.range, args.type)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.port, args.proto)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("port %s" % str(i))
 
@@ -485,17 +485,17 @@ def handlePkey(args):
 
     OBJECT = object_dict['ibpkey'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.ibpkey, args.subnet_prefix, args.range, args.type)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.ibpkey, args.subnet_prefix, args.range, args.type)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.ibpkey, args.subnet_prefix)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("ibpkey %s" % str(i))
 
@@ -528,17 +528,17 @@ def handleIbendport(args):
 
     OBJECT = object_dict['ibendport'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.ibendport, args.ibdev_name, args.range, args.type)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.ibendport, args.ibdev_name, args.range, args.type)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.ibendport, args.ibdev_name)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("ibendport %s" % str(i))
 
@@ -571,17 +571,17 @@ def handleInterface(args):
 
     OBJECT = object_dict['interface'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.interface, args.range, args.type)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.interface, args.range, args.type)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.interface)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("interface %s" % str(i))
 
@@ -617,11 +617,11 @@ def handleModule(args):
         OBJECT.set_enabled(args.module_name, False)
     if args.action == "remove":
         OBJECT.delete(args.module_name, args.priority)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
     if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("module %s" % str(i))
 
@@ -652,17 +652,17 @@ def handleNode(args):
 
     OBJECT = object_dict['node'](args)
 
-    if args.action is "add":
+    if args.action == "add":
         OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type)
-    if args.action is "modify":
+    if args.action == "modify":
         OBJECT.modify(args.node, args.netmask, args.proto, args.range, args.type)
-    if args.action is "delete":
+    if args.action == "delete":
         OBJECT.delete(args.node, args.netmask, args.proto)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("node %s" % str(i))
 
@@ -698,14 +698,14 @@ def handleBoolean(args):
 
     OBJECT = object_dict['boolean'](args)
 
-    if args.action is "modify":
+    if args.action == "modify":
         if args.boolean:
             OBJECT.modify(args.boolean, args.state, False)
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading, args.locallist)
-    if args.action is "deleteall":
+    if args.action == "deleteall":
         OBJECT.deleteall()
-    if args.action is "extract":
+    if args.action == "extract":
         for i in OBJECT.customized():
             print("boolean %s" % str(i))
 
@@ -736,12 +736,12 @@ def setupBooleanParser(subparsers):
 def handlePermissive(args):
     OBJECT = object_dict['permissive'](args)
 
-    if args.action is "list":
+    if args.action == "list":
         OBJECT.list(args.noheading)
     elif args.type is not None:
-        if args.action is "add":
+        if args.action == "add":
             OBJECT.add(args.type)
-        if args.action is "delete":
+        if args.action == "delete":
             OBJECT.delete(args.type)
     else:
         args.parser.print_usage(sys.stderr)
diff --git a/python/sepolgen/src/sepolgen/output.py b/python/sepolgen/src/sepolgen/output.py
index 7a83aee407cf..3a21b64c19f7 100644
--- a/python/sepolgen/src/sepolgen/output.py
+++ b/python/sepolgen/src/sepolgen/output.py
@@ -74,13 +74,13 @@ def id_set_cmp(x, y):
 # Compare two avrules
 def avrule_cmp(a, b):
     ret = id_set_cmp(a.src_types, b.src_types)
-    if ret is not 0:
+    if ret != 0:
         return ret
     ret = id_set_cmp(a.tgt_types, b.tgt_types)
-    if ret is not 0:
+    if ret != 0:
         return ret
     ret = id_set_cmp(a.obj_classes, b.obj_classes)
-    if ret is not 0:
+    if ret != 0:
         return ret
 
     # At this point, who cares - just return something
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 37ddfc7a2d63..5a2195b8033f 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -643,7 +643,7 @@ allow %s_t %s_t:%s_socket name_%s;
 
     def __find_path(self, file):
         for d in self.DEFAULT_DIRS:
-            if file.find(d) is 0:
+            if file.find(d) == 0:
                 self.DEFAULT_DIRS[d][1].append(file)
                 return self.DEFAULT_DIRS[d]
         self.DEFAULT_DIRS["rw"][1].append(file)
@@ -1346,7 +1346,7 @@ allow %s_t %s_t:%s_socket name_%s;
                 else:
                     continue
 
-            if len(temp_dirs) is not 0:
+            if len(temp_dirs) != 0:
                 for i in temp_dirs:
                     if i in self.dirs.keys():
                         del(self.dirs[i])
-- 
2.20.1

