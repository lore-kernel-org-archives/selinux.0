Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2LKaxQl032519
 for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2016 16:36:59 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id CF21EC049D4F
 for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2016 20:36:56 +0000 (UTC)
From: Miroslav Grepl <mgrepl@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils/sepolgen: Add support for TYPEBOUNDS
 statement in INTERFACE policy files.
Date: Mon, 21 Mar 2016 21:36:52 +0100
Message-Id: <1458592612-5575-1-git-send-email-mgrepl@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1319338

$ sepolgen-ifgen
/usr/share/selinux/devel/include/contrib/docker.if: Syntax error on line 503 docker_t [type=IDENTIFIER]
/usr/share/selinux/devel/include/roles/unconfineduser.if: Syntax error on line 706 unconfined_t [type=IDENTIFIER]

Signed-off-by: Miroslav Grepl <mgrepl@redhat.com>
---
 sepolgen/src/sepolgen/refparser.py | 10 ++++++++++
 sepolgen/src/sepolgen/refpolicy.py | 16 ++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/sepolgen/src/sepolgen/refparser.py b/sepolgen/src/sepolgen/refparser.py
index 9b1d0c8..2cef8e8 100644
--- a/sepolgen/src/sepolgen/refparser.py
+++ b/sepolgen/src/sepolgen/refparser.py
@@ -113,6 +113,7 @@ tokens = (
     'AUDITALLOW',
     'NEVERALLOW',
     'PERMISSIVE',
+    'TYPEBOUNDS',
     'TYPE_TRANSITION',
     'TYPE_CHANGE',
     'TYPE_MEMBER',
@@ -178,6 +179,7 @@ reserved = {
     'auditallow' : 'AUDITALLOW',
     'neverallow' : 'NEVERALLOW',
     'permissive' : 'PERMISSIVE',
+    'typebounds' : 'TYPEBOUNDS',
     'type_transition' : 'TYPE_TRANSITION',
     'type_change' : 'TYPE_CHANGE',
     'type_member' : 'TYPE_MEMBER',
@@ -502,6 +504,7 @@ def p_policy_stmt(p):
     '''policy_stmt : gen_require
                    | avrule_def
                    | typerule_def
+                   | typebound_def
                    | typeattribute_def
                    | roleattribute_def
                    | interface_call
@@ -823,6 +826,13 @@ def p_typerule_def(p):
     t.file_name = p[7]
     p[0] = t
 
+def p_typebound_def(p):
+    '''typebound_def : TYPEBOUNDS IDENTIFIER comma_list SEMI'''
+    t = refpolicy.TypeBound()
+    t.type = p[2]
+    t.tgt_types.update(p[3])
+    p[0] = t
+
 def p_bool(p):
     '''bool : BOOL IDENTIFIER TRUE SEMI
             | BOOL IDENTIFIER FALSE SEMI'''
diff --git a/sepolgen/src/sepolgen/refpolicy.py b/sepolgen/src/sepolgen/refpolicy.py
index 31b40d8..2ee029c 100644
--- a/sepolgen/src/sepolgen/refpolicy.py
+++ b/sepolgen/src/sepolgen/refpolicy.py
@@ -112,6 +112,9 @@ class Node(PolicyBase):
     def typerules(self):
         return filter(lambda x: isinstance(x, TypeRule), walktree(self))
 
+    def typebounds(self):
+        return filter(lambda x: isinstance(x, TypeBound), walktree(self))
+
     def typeattributes(self):
         """Iterate over all of the TypeAttribute children of this Interface."""
         return filter(lambda x: isinstance(x, TypeAttribute), walktree(self))
@@ -522,6 +525,19 @@ class TypeRule(Leaf):
                                      self.tgt_types.to_space_str(),
                                      self.obj_classes.to_space_str(),
                                      self.dest_type)
+class TypeBound(Leaf):
+    """SElinux typebound statement.
+
+    This class represents a typebound statement.
+    """
+    def __init__(self, parent=None):
+        Leaf.__init__(self, parent)
+        self.type = ""
+        self.tgt_types = IdSet()
+
+    def to_string(self):
+        return "typebounds %s %s;" % (self.type, self.tgt_types.to_comma_str())
+
 
 class RoleAllow(Leaf):
     def __init__(self, parent=None):
-- 
2.7.2
