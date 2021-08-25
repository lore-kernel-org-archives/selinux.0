Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE969C4338F
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA52610E9
	for <selinux@archiver.kernel.org>; Wed, 25 Aug 2021 09:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhHYJZt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbhHYJZs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Aug 2021 05:25:48 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Aug 2021 02:25:03 PDT
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D59C061757
        for <selinux@vger.kernel.org>; Wed, 25 Aug 2021 02:25:03 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH] python: Import specific modules from setools for less deps
Date:   Wed, 25 Aug 2021 11:19:40 +0200
Message-Id: <20210825091940.240207-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Import the setools classes needed for Python bindings from specific
setools modules in order to reduce the dependency footprint
of the Python bindings.  Importing the top-level module causes all
setools modules to be loaded which includes the modules that require
networkx.

SELinux packages belong to the group of core system packages on Gentoo
Linux.  It is desirable to keep the system set as small as possible,
and the dependency between setools and networkx seems to be the easiest
link to break without major loss of functionality.

Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 python/semanage/seobject.py          |  7 ++-
 python/sepolicy/sepolicy/__init__.py | 88 ++++++++++++++++------------
 2 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 6a14f7b4..21adbf6e 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -31,7 +31,8 @@ import socket
 from semanage import *
 PROGNAME = "policycoreutils"
 import sepolicy
-import setools
+from setools.policyrep import SELinuxPolicy
+from setools.typequery import TypeQuery
 import ipaddress
 
 try:
@@ -1339,7 +1340,7 @@ class ibpkeyRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            q = setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_store_policy(self.store)), attrs=["ibpkey_type"])
+            q = TypeQuery(SELinuxPolicy(sepolicy.get_store_policy(self.store)), attrs=["ibpkey_type"])
             self.valid_types = sorted(str(t) for t in q.results())
         except:
             pass
@@ -1599,7 +1600,7 @@ class ibendportRecords(semanageRecords):
     def __init__(self, args = None):
         semanageRecords.__init__(self, args)
         try:
-            q = setools.TypeQuery(setools.SELinuxPolicy(sepolicy.get_store_policy(self.store)), attrs=["ibendport_type"])
+            q = TypeQuery(SELinuxPolicy(sepolicy.get_store_policy(self.store)), attrs=["ibendport_type"])
             self.valid_types = set(str(t) for t in q.results())
         except:
             pass
diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 9338603e..e8654abb 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -4,7 +4,6 @@
 
 import errno
 import selinux
-import setools
 import glob
 import sepolgen.defaults as defaults
 import sepolgen.interfaces as interfaces
@@ -13,6 +12,17 @@ import os
 import re
 import gzip
 
+from setools.boolquery import BoolQuery
+from setools.portconquery import PortconQuery
+from setools.policyrep import SELinuxPolicy
+from setools.objclassquery import ObjClassQuery
+from setools.rbacrulequery import RBACRuleQuery
+from setools.rolequery import RoleQuery
+from setools.terulequery import TERuleQuery
+from setools.typeattrquery import TypeAttributeQuery
+from setools.typequery import TypeQuery
+from setools.userquery import UserQuery
+
 PROGNAME = "policycoreutils"
 try:
     import gettext
@@ -168,7 +178,7 @@ def policy(policy_file):
     global _pol
 
     try:
-        _pol = setools.SELinuxPolicy(policy_file)
+        _pol = SELinuxPolicy(policy_file)
     except:
         raise ValueError(_("Failed to read %s policy file") % policy_file)
 
@@ -188,7 +198,7 @@ def info(setype, name=None):
         init_policy()
 
     if setype == TYPE:
-        q = setools.TypeQuery(_pol)
+        q = TypeQuery(_pol)
         q.name = name
         results = list(q.results())
 
@@ -206,7 +216,7 @@ def info(setype, name=None):
         } for x in results)
 
     elif setype == ROLE:
-        q = setools.RoleQuery(_pol)
+        q = RoleQuery(_pol)
         if name:
             q.name = name
 
@@ -217,7 +227,7 @@ def info(setype, name=None):
         } for x in q.results())
 
     elif setype == ATTRIBUTE:
-        q = setools.TypeAttributeQuery(_pol)
+        q = TypeAttributeQuery(_pol)
         if name:
             q.name = name
 
@@ -227,7 +237,7 @@ def info(setype, name=None):
         } for x in q.results())
 
     elif setype == PORT:
-        q = setools.PortconQuery(_pol)
+        q = PortconQuery(_pol)
         if name:
             ports = [int(i) for i in name.split("-")]
             if len(ports) == 2:
@@ -251,7 +261,7 @@ def info(setype, name=None):
         } for x in q.results())
 
     elif setype == USER:
-        q = setools.UserQuery(_pol)
+        q = UserQuery(_pol)
         if name:
             q.name = name
 
@@ -268,7 +278,7 @@ def info(setype, name=None):
         } for x in q.results())
 
     elif setype == BOOLEAN:
-        q = setools.BoolQuery(_pol)
+        q = BoolQuery(_pol)
         if name:
             q.name = name
 
@@ -278,7 +288,7 @@ def info(setype, name=None):
         } for x in q.results())
 
     elif setype == TCLASS:
-        q = setools.ObjClassQuery(_pol)
+        q = ObjClassQuery(_pol)
         if name:
             q.name = name
 
@@ -372,11 +382,11 @@ def search(types, seinfo=None):
         tertypes.append(DONTAUDIT)
 
     if len(tertypes) > 0:
-        q = setools.TERuleQuery(_pol,
-                                ruletype=tertypes,
-                                source=source,
-                                target=target,
-                                tclass=tclass)
+        q = TERuleQuery(_pol,
+                        ruletype=tertypes,
+                        source=source,
+                        target=target,
+                        tclass=tclass)
 
         if PERMS in seinfo:
             q.perms = seinfo[PERMS]
@@ -385,11 +395,11 @@ def search(types, seinfo=None):
 
     if TRANSITION in types:
         rtypes = ['type_transition', 'type_change', 'type_member']
-        q = setools.TERuleQuery(_pol,
-                                ruletype=rtypes,
-                                source=source,
-                                target=target,
-                                tclass=tclass)
+        q = TERuleQuery(_pol,
+                        ruletype=rtypes,
+                        source=source,
+                        target=target,
+                        tclass=tclass)
 
         if PERMS in seinfo:
             q.perms = seinfo[PERMS]
@@ -398,11 +408,11 @@ def search(types, seinfo=None):
 
     if ROLE_ALLOW in types:
         ratypes = ['allow']
-        q = setools.RBACRuleQuery(_pol,
-                                  ruletype=ratypes,
-                                  source=source,
-                                  target=target,
-                                  tclass=tclass)
+        q = RBACRuleQuery(_pol,
+                          ruletype=ratypes,
+                          source=source,
+                          target=target,
+                          tclass=tclass)
 
         for r in q.results():
             toret.append({'source': str(r.source),
@@ -720,11 +730,11 @@ def get_all_entrypoints():
 
 
 def get_entrypoint_types(setype):
-    q = setools.TERuleQuery(_pol,
-                            ruletype=[ALLOW],
-                            source=setype,
-                            tclass=["file"],
-                            perms=["entrypoint"])
+    q = TERuleQuery(_pol,
+                    ruletype=[ALLOW],
+                    source=setype,
+                    tclass=["file"],
+                    perms=["entrypoint"])
     return [str(x.target) for x in q.results() if x.source == setype]
 
 
@@ -739,10 +749,10 @@ def get_init_transtype(path):
 
 
 def get_init_entrypoint(transtype):
-    q = setools.TERuleQuery(_pol,
-                            ruletype=["type_transition"],
-                            source="init_t",
-                            tclass=["process"])
+    q = TERuleQuery(_pol,
+                    ruletype=["type_transition"],
+                    source="init_t",
+                    tclass=["process"])
     entrypoints = []
     for i in q.results():
         try:
@@ -754,10 +764,10 @@ def get_init_entrypoint(transtype):
     return entrypoints
 
 def get_init_entrypoints_str():
-    q = setools.TERuleQuery(_pol,
-                            ruletype=["type_transition"],
-                            source="init_t",
-                            tclass=["process"])
+    q = TERuleQuery(_pol,
+                    ruletype=["type_transition"],
+                    source="init_t",
+                    tclass=["process"])
     entrypoints = {}
     for i in q.results():
         try:
@@ -837,7 +847,7 @@ def get_all_role_allows():
         return role_allows
     role_allows = {}
 
-    q = setools.RBACRuleQuery(_pol, ruletype=[ALLOW])
+    q = RBACRuleQuery(_pol, ruletype=[ALLOW])
     for r in q.results():
         src = str(r.source)
         tgt = str(r.target)
@@ -923,7 +933,7 @@ def get_all_roles():
     if not _pol:
         init_policy()
 
-    q = setools.RoleQuery(_pol)
+    q = RoleQuery(_pol)
     roles = [str(x) for x in q.results() if str(x) != "object_r"]
     return roles
 
-- 
2.33.0

