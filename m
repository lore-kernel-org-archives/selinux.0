Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u74IYfoG011370
 for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2016 14:34:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so18686451pfg.3
 for <selinux@tycho.nsa.gov>; Thu, 04 Aug 2016 11:34:39 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 07/12] sepolicy: dont alias sepolicy.search and sepolicy.info
Date: Fri,  5 Aug 2016 02:34:00 +0800
Message-Id: <1470335645-24224-8-git-send-email-jason@perfinion.com>
In-Reply-To: <1470335645-24224-1-git-send-email-jason@perfinion.com>
References: <1470335645-24224-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/sepolicy/sepolicy/booleans.py    |  7 ++---
 policycoreutils/sepolicy/sepolicy/communicate.py |  6 ++---
 policycoreutils/sepolicy/sepolicy/gui.py         |  1 -
 policycoreutils/sepolicy/sepolicy/manpage.py     | 34 +++++++++++-------------
 policycoreutils/sepolicy/sepolicy/network.py     |  4 +--
 policycoreutils/sepolicy/sepolicy/transition.py  |  8 +++---
 6 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/policycoreutils/sepolicy/sepolicy/booleans.py b/policycoreutils/sepolicy/sepolicy/booleans.py
index 56bef26..cf5f1ff 100644
--- a/policycoreutils/sepolicy/sepolicy/booleans.py
+++ b/policycoreutils/sepolicy/sepolicy/booleans.py
@@ -21,20 +21,17 @@
 #
 #
 import sepolicy
-import sys
-search = sepolicy.search
-info = sepolicy.info
 
 
 def expand_attribute(attribute):
     try:
-        return info(sepolicy.ATTRIBUTE, attribute)[0]["types"]
+        return sepolicy.info(sepolicy.ATTRIBUTE, attribute)[0]["types"]
     except RuntimeError:
         return [attribute]
 
 
 def get_types(src, tclass, perm):
-    allows = search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
+    allows = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
     if not allows:
         raise TypeError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
 
diff --git a/policycoreutils/sepolicy/sepolicy/communicate.py b/policycoreutils/sepolicy/sepolicy/communicate.py
index 9939c23..b96c4b9 100755
--- a/policycoreutils/sepolicy/sepolicy/communicate.py
+++ b/policycoreutils/sepolicy/sepolicy/communicate.py
@@ -22,8 +22,6 @@
 #
 import sepolicy
 import sys
-search = sepolicy.search
-info = sepolicy.info
 
 
 def usage(parser, msg):
@@ -36,13 +34,13 @@ def usage(parser, msg):
 
 def expand_attribute(attribute):
     try:
-        return info(sepolicy.ATTRIBUTE, attribute)[0]["types"]
+        return sepolicy.info(sepolicy.ATTRIBUTE, attribute)[0]["types"]
     except RuntimeError:
         return [attribute]
 
 
 def get_types(src, tclass, perm):
-    allows = search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
+    allows = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
     if not allows:
         raise ValueError("The %s type is not allowed to %s any types" % (src, ",".join(perm)))
 
diff --git a/policycoreutils/sepolicy/sepolicy/gui.py b/policycoreutils/sepolicy/sepolicy/gui.py
index 60a4d83..0ffe9ee 100644
--- a/policycoreutils/sepolicy/sepolicy/gui.py
+++ b/policycoreutils/sepolicy/sepolicy/gui.py
@@ -37,7 +37,6 @@ from selinux import DISABLED, PERMISSIVE, ENFORCING
 import sepolicy.network
 import sepolicy.manpage
 import dbus
-import time
 import os
 import re
 import gettext
diff --git a/policycoreutils/sepolicy/sepolicy/manpage.py b/policycoreutils/sepolicy/sepolicy/manpage.py
index a3ffd45..7365f93 100755
--- a/policycoreutils/sepolicy/sepolicy/manpage.py
+++ b/policycoreutils/sepolicy/sepolicy/manpage.py
@@ -27,8 +27,6 @@ __all__ = ['ManPage', 'HTMLManPages', 'manpage_domains', 'manpage_roles', 'gen_d
 import string
 import selinux
 import sepolicy
-from sepolicy import *
-
 import commands
 import os
 import time
@@ -47,7 +45,7 @@ def gen_modules_dict(path="/usr/share/selinux/devel/policy.xml"):
     import xml.etree.ElementTree
     modules_dict = {}
     try:
-        tree = xml.etree.ElementTree.fromstring(policy_xml(path))
+        tree = xml.etree.ElementTree.fromstring(sepolicy.policy_xml(path))
         for l in tree.findall("layer"):
             for m in l.findall("module"):
                 name = m.get("name")
@@ -76,7 +74,7 @@ def get_all_users_info():
     users = []
     users_range = {}
     allusers = []
-    allusers_info = info(USER)
+    allusers_info = sepolicy.info(sepolicy.USER)
 
     for d in allusers_info:
         allusers.append(d['name'])
@@ -105,7 +103,7 @@ def gen_domains():
     if domains:
         return domains
     domains = []
-    for d in get_all_domains():
+    for d in sepolicy.get_all_domains():
         found = False
         domain = d[:-2]
 #		if domain + "_exec_t" not in get_entrypoints():
@@ -114,7 +112,7 @@ def gen_domains():
             continue
         domains.append(domain)
 
-    for role in get_all_roles():
+    for role in sepolicy.get_all_roles():
         if role[:-2] in domains or role == "system_r":
             continue
         domains.append(role[:-2])
@@ -404,17 +402,17 @@ class ManPage:
         self.html = html
         self.source_files = source_files
         self.root = root
-        self.portrecs = gen_port_dict()[0]
+        self.portrecs = sepolicy.gen_port_dict()[0]
         self.domains = gen_domains()
-        self.all_domains = get_all_domains()
-        self.all_attributes = get_all_attributes()
-        self.all_bools = get_all_bools()
-        self.all_port_types = get_all_port_types()
-        self.all_roles = get_all_roles()
+        self.all_domains = sepolicy.get_all_domains()
+        self.all_attributes = sepolicy.get_all_attributes()
+        self.all_bools = sepolicy.get_all_bools()
+        self.all_port_types = sepolicy.get_all_port_types()
+        self.all_roles = sepolicy.get_all_roles()
         self.all_users = get_all_users_info()[0]
         self.all_users_range = get_all_users_info()[1]
-        self.all_file_types = get_all_file_types()
-        self.role_allows = get_all_role_allows()
+        self.all_file_types = sepolicy.get_all_file_types()
+        self.role_allows = sepolicy.get_all_role_allows()
         self.types = _gen_types()
 
         if self.source_files:
@@ -422,7 +420,7 @@ class ManPage:
         else:
             self.fcpath = self.root + selinux.selinux_file_context_path()
 
-        self.fcdict = get_fcdict(self.fcpath)
+        self.fcdict = sepolicy.get_fcdict(self.fcpath)
 
         if not os.path.exists(path):
             os.makedirs(path)
@@ -433,9 +431,9 @@ class ManPage:
             self.xmlpath = self.root + "policy.xml"
         else:
             self.xmlpath = self.root + "/usr/share/selinux/devel/policy.xml"
-        self.booleans_dict = gen_bool_dict(self.xmlpath)
+        self.booleans_dict = sepolicy.gen_bool_dict(self.xmlpath)
 
-        self.domainname, self.short_name = gen_short_name(domainname)
+        self.domainname, self.short_name = sepolicy.gen_short_name(domainname)
 
         self.type = self.domainname + "_t"
         self._gen_bools()
@@ -466,7 +464,7 @@ class ManPage:
                     types.append(t + "_t")
 
         for t in types:
-            domainbools, bools = get_bools(t)
+            domainbools, bools = sepolicy.get_bools(t)
             self.bools += bools
             self.domainbools += domainbools
 
diff --git a/policycoreutils/sepolicy/sepolicy/network.py b/policycoreutils/sepolicy/sepolicy/network.py
index 1ca3158..c4d95da 100755
--- a/policycoreutils/sepolicy/sepolicy/network.py
+++ b/policycoreutils/sepolicy/sepolicy/network.py
@@ -21,12 +21,10 @@
 #
 #
 import sepolicy
-search = sepolicy.search
-info = sepolicy.info
 
 
 def get_types(src, tclass, perm):
-    allows = search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
+    allows = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src, sepolicy.CLASS: tclass, sepolicy.PERMS: perm})
     nlist = []
     if allows:
         for i in map(lambda y: y[sepolicy.TARGET], filter(lambda x: set(perm).issubset(x[sepolicy.PERMS]), allows)):
diff --git a/policycoreutils/sepolicy/sepolicy/transition.py b/policycoreutils/sepolicy/sepolicy/transition.py
index a8edb69..ad53cef 100755
--- a/policycoreutils/sepolicy/sepolicy/transition.py
+++ b/policycoreutils/sepolicy/sepolicy/transition.py
@@ -21,18 +21,16 @@
 #
 #
 import sepolicy
-search = sepolicy.search
-info = sepolicy.info
-__all__ = ['setrans', ]
+__all__ = ['setrans']
 
 
 def _entrypoint(src):
-    trans = search([sepolicy.ALLOW], {sepolicy.SOURCE: src})
+    trans = sepolicy.search([sepolicy.ALLOW], {sepolicy.SOURCE: src})
     return map(lambda y: y[sepolicy.TARGET], filter(lambda x: "entrypoint" in x[sepolicy.PERMS], trans))
 
 
 def _get_trans(src):
-    return search([sepolicy.TRANSITION], {sepolicy.SOURCE: src, sepolicy.CLASS: "process"})
+    return sepolicy.search([sepolicy.TRANSITION], {sepolicy.SOURCE: src, sepolicy.CLASS: "process"})
 
 
 class setrans:
-- 
2.7.3
