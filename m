Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6RDJYcI001726
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 09:19:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 901091B982B
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 13:11:14 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 27 Jul 2017 15:10:52 +0200
Message-Id: <20170727131053.7962-3-plautrba@redhat.com>
In-Reply-To: <20170727131053.7962-1-plautrba@redhat.com>
References: <20170727131053.7962-1-plautrba@redhat.com>
Subject: [PATCH 3/4] sepolicy: Make manpage and transition faster
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

SETools4 and Python 3 versions of map() and filter() uses iterators to
generates query results and these iterators can't be imply re-used. It
makes manpage and transitions operations really slow as they do lot of queries.

This patch changes it in the way that it caches results in lists for all
types, allow rules and transitions first and use cached results to
filter them using Python's filter() function.

Before:
$ time sepolicy manpage -d httpd_t sshd_t init_t
real    0m53.486s
user    0m53.171s
sys     0m0.054s

After:
$ time sepolicy manpage -d httpd_t sshd_t init_t
real    0m10.532s
user    0m10.368s
sys     0m0.114s

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/sepolicy/__init__.py   | 62 ++++++++++++++++++++++++----------
 python/sepolicy/sepolicy/manpage.py    | 29 ++++++++++++----
 python/sepolicy/sepolicy/transition.py |  8 +++--
 3 files changed, 73 insertions(+), 26 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 8fa2c2ae..5cfc0715 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -99,6 +99,7 @@ local_files = None
 fcdict = None
 methods = []
 all_types = None
+all_types_info = None
 user_types = None
 role_allows = None
 portrecs = None
@@ -113,6 +114,8 @@ bools = None
 all_attributes = None
 booleans = None
 booleans_dict = None
+all_allow_rules = None
+all_transitions = None
 
 
 def get_installed_policy(root="/"):
@@ -168,10 +171,10 @@ def info(setype, name=None):
             q.name = name
 
         return ({
-            'aliases': map(str, x.aliases()),
+            'aliases': list(map(str, x.aliases())),
             'name': str(x),
             'permissive': bool(x.ispermissive),
-            'attributes': map(str, x.attributes())
+            'attributes': list(map(str, x.attributes()))
         } for x in q.results())
 
     elif setype == ROLE:
@@ -181,8 +184,8 @@ def info(setype, name=None):
 
         return ({
             'name': str(x),
-            'roles': map(str, x.expand()),
-            'types': map(str, x.types()),
+            'roles': list(map(str, x.expand())),
+            'types': list(map(str, x.types())),
         } for x in q.results())
 
     elif setype == ATTRIBUTE:
@@ -192,7 +195,7 @@ def info(setype, name=None):
 
         return ({
             'name': str(x),
-            'types': map(str, x.expand()),
+            'types': list(map(str, x.expand())),
         } for x in q.results())
 
     elif setype == PORT:
@@ -220,7 +223,7 @@ def info(setype, name=None):
         return ({
             'range': str(x.mls_range),
             'name': str(x),
-            'roles': map(str, x.roles),
+            'roles': list(map(str, x.roles)),
             'level': str(x.mls_level),
         } for x in q.results())
 
@@ -362,17 +365,26 @@ def search(types, seinfo=None):
 def get_conditionals(src, dest, tclass, perm):
     tdict = {}
     tlist = []
-    if dest.endswith("_t"):
-        allows = search([ALLOW], {SOURCE: src, TARGET: dest, CLASS: tclass, PERMS: perm})
-    else:
-        # to include attribute
-        allows = search([ALLOW], {SOURCE: src, CLASS: tclass, PERMS: perm})
-        for i in allows:
-            if i['target'] == dest:
-                allows = []
-                allows.append(i)
+    src_list = [src]
+    dest_list = [dest]
+    # add assigned attributes
+    try:
+        src_list += list(filter(lambda x: x['name'] == src, get_all_types_info()))[0]['attributes']
+    except:
+        pass
     try:
-        for i in map(lambda y: (y), filter(lambda x: set(perm).issubset(x[PERMS]) and x['boolean'], allows)):
+        dest_list += list(filter(lambda x: x['name'] == dest, get_all_types_info()))[0]['attributes']
+    except:
+        pass
+    allows = map(lambda y: y, filter(lambda x:
+                x['source'] in src_list and
+                x['target'] in dest_list and
+                set(perm).issubset(x[PERMS]) and
+                'boolean' in x,
+                get_all_allow_rules()))
+
+    try:
+        for i in allows:
             tdict.update({'source': i['source'], 'boolean': i['boolean']})
             if tdict not in tlist:
                 tlist.append(tdict)
@@ -734,6 +746,11 @@ def get_all_types():
         all_types = [x['name'] for x in info(TYPE)]
     return all_types
 
+def get_all_types_info():
+    global all_types_info
+    if all_types_info is None:
+        all_types_info = list(info(TYPE))
+    return all_types_info
 
 def get_user_types():
     global user_types
@@ -1018,12 +1035,23 @@ def gen_short_name(setype):
         short_name = domainname + "_"
     return (domainname, short_name)
 
+def get_all_allow_rules():
+    global all_allow_rules
+    if not all_allow_rules:
+        all_allow_rules = search([ALLOW])
+    return all_allow_rules
+
+def get_all_transitions():
+    global all_transitions
+    if not all_transitions:
+        all_transitions = list(search([TRANSITION]))
+    return all_transitions
 
 def get_bools(setype):
     bools = []
     domainbools = []
     domainname, short_name = gen_short_name(setype)
-    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x, search([ALLOW], {'source': setype}))):
+    for i in map(lambda x: x['boolean'], filter(lambda x: 'boolean' in x and x['source'] == setype, get_all_allow_rules())):
         for b in i:
             if not isinstance(b, tuple):
                 continue
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index 7f17ba29..6df6f431 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -938,7 +938,11 @@ selinux(8), %s(8), semanage(8), restorecon(8), chcon(1), sepolicy(8)
         return True
 
     def _entrypoints(self):
-        entrypoints = [x['target'] for x in sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['entrypoint'], 'class': 'file'})]
+        entrypoints = [x['target'] for x in filter(lambda y:
+            y['source'] == self.type and y['class'] == 'file' and 'entrypoint' in y['permlist'],
+            sepolicy.get_all_allow_rules()
+        )]
+
         if len(entrypoints) == 0:
             return
 
@@ -980,15 +984,23 @@ For example one process might be launched with %(type)s_t:s0:c1,c2, and another
 """ % {'type': self.domainname})
 
     def _writes(self):
-        permlist = sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'permlist': ['open', 'write'], 'class': 'file'})
+        # add assigned attributes
+        src_list = [self.type]
+        try:
+            src_list += list(filter(lambda x: x['name'] == self.type, sepolicy.get_all_types_info()))[0]['attributes']
+        except:
+            pass
+
+        permlist = list(filter(lambda x:
+            x['source'] in src_list and
+            set(['open', 'write']).issubset(x['permlist']) and
+            x['class'] == 'file',
+            sepolicy.get_all_allow_rules()))
         if permlist is None or len(permlist) == 0:
             return
 
         all_writes = []
         attributes = ["proc_type", "sysctl_type"]
-        for i in permlist:
-            if not i['target'].endswith("_t"):
-                attributes.append(i['target'])
 
         for i in permlist:
             if self._valid_write(i['target'], attributes):
@@ -1187,7 +1199,12 @@ The SELinux user %s_u is able to connect to the following tcp ports.
 """ % ",".join(ports))
 
     def _home_exec(self):
-        permlist = sepolicy.search([sepolicy.ALLOW], {'source': self.type, 'target': 'user_home_type', 'class': 'file', 'permlist': ['ioctl', 'read', 'getattr', 'execute', 'execute_no_trans', 'open']})
+        permlist = list(filter(lambda x:
+            x['source'] == self.type and
+            x['target'] == 'user_home_type' and
+            x['class'] == 'file' and
+            set(['ioctl', 'read', 'getattr', 'execute', 'execute_no_trans', 'open']).issubset(set(x['permlist'])),
+            sepolicy.get_all_allow_rules()))
         self.fd.write("""
 .SH HOME_EXEC
 """)
diff --git a/python/sepolicy/sepolicy/transition.py b/python/sepolicy/sepolicy/transition.py
index ad53cef7..7dea8059 100755
--- a/python/sepolicy/sepolicy/transition.py
+++ b/python/sepolicy/sepolicy/transition.py
@@ -30,7 +30,9 @@ def _entrypoint(src):
 
 
 def _get_trans(src):
-    return sepolicy.search([sepolicy.TRANSITION], {sepolicy.SOURCE: src, sepolicy.CLASS: "process"})
+    src_list = [src] + list(filter(lambda x: x['name'] == src, sepolicy.get_all_types_info()))[0]['attributes']
+    trans_list = list(filter(lambda x: x['source'] in src_list and x['class'] == 'process', sepolicy.get_all_transitions()))
+    return trans_list
 
 
 class setrans:
@@ -53,8 +55,8 @@ class setrans:
         if not self.dest:
             self.sdict[source]["map"] = trans
         else:
-            self.sdict[source]["map"] = map(lambda y: y, filter(lambda x: x["transtype"] == self.dest, trans))
-            self.sdict[source]["child"] = map(lambda y: y["transtype"], filter(lambda x: x["transtype"] not in [self.dest, source], trans))
+            self.sdict[source]["map"] = list(map(lambda y: y, filter(lambda x: x["transtype"] == self.dest, trans)))
+            self.sdict[source]["child"] = list(map(lambda y: y["transtype"], filter(lambda x: x["transtype"] not in [self.dest, source], trans)))
             for s in self.sdict[source]["child"]:
                 self._process(s)
 
-- 
2.13.3
