Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1iw021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:01 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 64100359A4C
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:48:58 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/11] sepolgen: Replace deprecated *Equals functions in tests
Date: Thu, 16 Jul 2015 13:48:11 +0200
Message-Id: <1437047301-17672-2-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Also remove usage of cmp in tests as cmp is removed in Python3

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/tests/test_access.py      |  44 ++++++++-------
 sepolgen/tests/test_audit.py       | 108 ++++++++++++++++++-------------------
 sepolgen/tests/test_interfaces.py  |  28 +++++-----
 sepolgen/tests/test_matching.py    |  12 ++---
 sepolgen/tests/test_objectmodel.py |  18 +++----
 sepolgen/tests/test_refparser.py   |   6 +--
 sepolgen/tests/test_refpolicy.py   |  50 ++++++++---------
 7 files changed, 135 insertions(+), 131 deletions(-)

diff --git a/sepolgen/tests/test_access.py b/sepolgen/tests/test_access.py
index fec699e..631209c 100644
--- a/sepolgen/tests/test_access.py
+++ b/sepolgen/tests/test_access.py
@@ -32,7 +32,7 @@ class TestAccessVector(unittest.TestCase):
         self.assertEqual(a.obj_class, None)
         self.assertTrue(isinstance(a.perms, refpolicy.IdSet))
         self.assertTrue(isinstance(a.audit_msgs, type([])))
-        self.assertEquals(len(a.audit_msgs), 0)
+        self.assertEqual(len(a.audit_msgs), 0)
 
         # Construction from a list
         a = access.AccessVector()
@@ -82,8 +82,8 @@ class TestAccessVector(unittest.TestCase):
         a.obj_class = "file"
         a.perms.update(["read", "write"])
 
-        self.assertEquals(str(a), "allow foo bar:file { read write };")
-        self.assertEquals(a.to_string(), "allow foo bar:file { read write };")
+        self.assertEqual(str(a), "allow foo bar:file { read write };")
+        self.assertEqual(a.to_string(), "allow foo bar:file { read write };")
 
     def test_cmp(self):
         a = access.AccessVector()
@@ -98,36 +98,40 @@ class TestAccessVector(unittest.TestCase):
         b.obj_class = "file"
         b.perms.update(["read", "write"])
 
-        self.assertEquals(a, b)
+        self.assertEqual(a, b)
 
         # Source Type
         b.src_type = "baz"
-        self.assertEquals(cmp(a, b), 1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a > b)
 
         b.src_type = "gaz"
-        self.assertEquals(cmp(a, b), -1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a < b)
 
         # Target Type
         b.src_type = "foo"
         b.tgt_type = "aar"
-        self.assertEquals(cmp(a, b), 1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a > b)
 
         b.tgt_type = "gaz"
-        self.assertEquals(cmp(a, b), -1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a < b)
 
         # Perms
         b.tgt_type = "bar"
         b.perms = refpolicy.IdSet(["read"])
-        ret = cmp(a, b)
-        self.assertEquals(ret, 1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a > b)
 
         b.perms = refpolicy.IdSet(["read", "write", "append"])
-        ret = cmp(a, b)
-        self.assertEquals(ret, -1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a < b)
 
         b.perms = refpolicy.IdSet(["read", "append"])
-        ret = cmp(a, b)
-        self.assertEquals(ret, 1)
+        self.assertNotEqual(a, b)
+        self.assertTrue(a > b)
                          
 class TestUtilFunctions(unittest.TestCase):
     def test_is_idparam(self):
@@ -149,7 +153,7 @@ class TestUtilFunctions(unittest.TestCase):
         rule.perms.add("write")
 
         avs = access.avrule_to_access_vectors(rule)
-        self.assertEquals(len(avs), 8)
+        self.assertEqual(len(avs), 8)
         comps = [("foo", "what", "dir"),
                  ("foo", "what", "file"),
                  ("foo", "bar", "dir"),
@@ -160,7 +164,7 @@ class TestUtilFunctions(unittest.TestCase):
                  ("baz", "bar", "file")]
         status = [False] * 8
         for av in access.avrule_to_access_vectors(rule):
-            self.assertEquals(av.perms, refpolicy.IdSet(["read", "write"]))
+            self.assertEqual(av.perms, refpolicy.IdSet(["read", "write"]))
             for i in xrange(len(comps)):
                 if comps[i][0] == av.src_type and \
                    comps[i][1] == av.tgt_type and \
@@ -168,7 +172,7 @@ class TestUtilFunctions(unittest.TestCase):
                     status[i] = True
 
         for s in status:
-            self.assertEquals(s, True)
+            self.assertEqual(s, True)
                    
 
 class TestAccessVectorSet(unittest.TestCase):
@@ -203,7 +207,7 @@ class TestAccessVectorSet(unittest.TestCase):
                  ("baz", "bar", "file")]
         status = [False] * 8
         for av in self.s:
-            self.assertEquals(av.perms, refpolicy.IdSet(["read", "write"]))
+            self.assertEqual(av.perms, refpolicy.IdSet(["read", "write"]))
             for i in xrange(len(comps)):
                 if comps[i][0] == av.src_type and \
                    comps[i][1] == av.tgt_type and \
@@ -211,10 +215,10 @@ class TestAccessVectorSet(unittest.TestCase):
                     status[i] = True
 
         for s in status:
-            self.assertEquals(s, True)
+            self.assertEqual(s, True)
 
     def test_len(self):
-        self.assertEquals(len(self.s), 8)
+        self.assertEqual(len(self.s), 8)
 
     def test_list(self):
         a = access.AccessVectorSet()
diff --git a/sepolgen/tests/test_audit.py b/sepolgen/tests/test_audit.py
index 7b74220..c72ca61 100644
--- a/sepolgen/tests/test_audit.py
+++ b/sepolgen/tests/test_audit.py
@@ -60,29 +60,29 @@ class TestAVCMessage(unittest.TestCase):
     def test_defs(self):
         avc = sepolgen.audit.AVCMessage(audit1)
         sc = sepolgen.refpolicy.SecurityContext()
-        self.assertEquals(avc.scontext, sc)
-        self.assertEquals(avc.tcontext, sc)
-        self.assertEquals(avc.tclass, "")
-        self.assertEquals(avc.accesses, [])
+        self.assertEqual(avc.scontext, sc)
+        self.assertEqual(avc.tcontext, sc)
+        self.assertEqual(avc.tclass, "")
+        self.assertEqual(avc.accesses, [])
 
     def test_granted(self):
         avc = sepolgen.audit.AVCMessage(granted1)
         avc.from_split_string(granted1.split())
 
-        self.assertEquals(avc.scontext.user, "user_u")
-        self.assertEquals(avc.scontext.role, "system_r")
-        self.assertEquals(avc.scontext.type, "unconfined_t")
-        self.assertEquals(avc.scontext.level, "s0")
+        self.assertEqual(avc.scontext.user, "user_u")
+        self.assertEqual(avc.scontext.role, "system_r")
+        self.assertEqual(avc.scontext.type, "unconfined_t")
+        self.assertEqual(avc.scontext.level, "s0")
 
-        self.assertEquals(avc.tcontext.user, "user_u")
-        self.assertEquals(avc.tcontext.role, "object_r")
-        self.assertEquals(avc.tcontext.type, "user_home_t")
-        self.assertEquals(avc.tcontext.level, "s0")
+        self.assertEqual(avc.tcontext.user, "user_u")
+        self.assertEqual(avc.tcontext.role, "object_r")
+        self.assertEqual(avc.tcontext.type, "user_home_t")
+        self.assertEqual(avc.tcontext.level, "s0")
         
-        self.assertEquals(avc.tclass, "file")
-        self.assertEquals(avc.accesses, ["getattr"])
+        self.assertEqual(avc.tclass, "file")
+        self.assertEqual(avc.accesses, ["getattr"])
 
-        self.assertEquals(avc.denial, False)
+        self.assertEqual(avc.denial, False)
 
 
     def test_from_split_string(self):
@@ -91,54 +91,54 @@ class TestAVCMessage(unittest.TestCase):
         recs = audit1.split()
         avc.from_split_string(recs)
 
-        self.assertEquals(avc.header, "audit(1158064002.046:4):")
-        self.assertEquals(avc.scontext.user, "user_u")
-        self.assertEquals(avc.scontext.role, "system_r")
-        self.assertEquals(avc.scontext.type, "bluetooth_helper_t")
-        self.assertEquals(avc.scontext.level, "s0-s0:c0")
+        self.assertEqual(avc.header, "audit(1158064002.046:4):")
+        self.assertEqual(avc.scontext.user, "user_u")
+        self.assertEqual(avc.scontext.role, "system_r")
+        self.assertEqual(avc.scontext.type, "bluetooth_helper_t")
+        self.assertEqual(avc.scontext.level, "s0-s0:c0")
 
-        self.assertEquals(avc.tcontext.user, "system_u")
-        self.assertEquals(avc.tcontext.role, "object_r")
-        self.assertEquals(avc.tcontext.type, "xdm_tmp_t")
-        self.assertEquals(avc.tcontext.level, "s0")
+        self.assertEqual(avc.tcontext.user, "system_u")
+        self.assertEqual(avc.tcontext.role, "object_r")
+        self.assertEqual(avc.tcontext.type, "xdm_tmp_t")
+        self.assertEqual(avc.tcontext.level, "s0")
 
-        self.assertEquals(avc.tclass, "file")
-        self.assertEquals(avc.accesses, ["read"])
+        self.assertEqual(avc.tclass, "file")
+        self.assertEqual(avc.accesses, ["read"])
 
-        self.assertEquals(avc.comm, "bluez-pin")
+        self.assertEqual(avc.comm, "bluez-pin")
 
 
-        self.assertEquals(avc.denial, True)
+        self.assertEqual(avc.denial, True)
 
         # audit daemon message
         avc = sepolgen.audit.AVCMessage(audit2)
         recs = audit2.split()
         avc.from_split_string(recs)
 
-        self.assertEquals(avc.header, "audit(1158584779.745:708):")
-        self.assertEquals(avc.scontext.user, "user_u")
-        self.assertEquals(avc.scontext.role, "system_r")
-        self.assertEquals(avc.scontext.type, "vpnc_t")
-        self.assertEquals(avc.scontext.level, "s0")
+        self.assertEqual(avc.header, "audit(1158584779.745:708):")
+        self.assertEqual(avc.scontext.user, "user_u")
+        self.assertEqual(avc.scontext.role, "system_r")
+        self.assertEqual(avc.scontext.type, "vpnc_t")
+        self.assertEqual(avc.scontext.level, "s0")
 
-        self.assertEquals(avc.tcontext.user, "user_u")
-        self.assertEquals(avc.tcontext.role, "system_r")
-        self.assertEquals(avc.tcontext.type, "vpnc_t")
-        self.assertEquals(avc.tcontext.level, "s0")
+        self.assertEqual(avc.tcontext.user, "user_u")
+        self.assertEqual(avc.tcontext.role, "system_r")
+        self.assertEqual(avc.tcontext.type, "vpnc_t")
+        self.assertEqual(avc.tcontext.level, "s0")
 
-        self.assertEquals(avc.tclass, "capability")
-        self.assertEquals(avc.accesses, ["dac_read_search"])
+        self.assertEqual(avc.tclass, "capability")
+        self.assertEqual(avc.accesses, ["dac_read_search"])
 
-        self.assertEquals(avc.comm, "sh")
+        self.assertEqual(avc.comm, "sh")
 
-        self.assertEquals(avc.denial, True)
+        self.assertEqual(avc.denial, True)
 
 class TestPathMessage(unittest.TestCase):
     def test_from_split_string(self):
         path = sepolgen.audit.PathMessage(path1)
         recs = path1.split()
         path.from_split_string(recs)
-        self.assertEquals(path.path, "/usr/lib/sa/sa1")
+        self.assertEqual(path.path, "/usr/lib/sa/sa1")
 
 # TODO - add tests for the other message types
 
@@ -149,27 +149,27 @@ class TestAuditParser(unittest.TestCase):
     def test_parse_string(self):
         a = sepolgen.audit.AuditParser()
         a.parse_string(log1)
-        self.assertEquals(len(a.avc_msgs), 11)
-        self.assertEquals(len(a.compute_sid_msgs), 0)
-        self.assertEquals(len(a.invalid_msgs), 0)
-        self.assertEquals(len(a.policy_load_msgs), 0)
-        self.assertEquals(len(a.path_msgs), 1)
+        self.assertEqual(len(a.avc_msgs), 11)
+        self.assertEqual(len(a.compute_sid_msgs), 0)
+        self.assertEqual(len(a.invalid_msgs), 0)
+        self.assertEqual(len(a.policy_load_msgs), 0)
+        self.assertEqual(len(a.path_msgs), 1)
 
     def test_post_process(self):
         a = sepolgen.audit.AuditParser()
         a.parse_string(log2)
-        self.assertEquals(len(a.avc_msgs), 2)
-        self.assertEquals(a.avc_msgs[0].path, "/usr/lib/sa/sa1")
-        self.assertEquals(a.avc_msgs[1].path, "/usr/lib/sa/sa1")
+        self.assertEqual(len(a.avc_msgs), 2)
+        self.assertEqual(a.avc_msgs[0].path, "/usr/lib/sa/sa1")
+        self.assertEqual(a.avc_msgs[1].path, "/usr/lib/sa/sa1")
 
     def test_parse_file(self):
         f = open("audit.txt")
         a = sepolgen.audit.AuditParser()
         a.parse_file(f)
-        self.assertEquals(len(a.avc_msgs), 21)
-        self.assertEquals(len(a.compute_sid_msgs), 0)
-        self.assertEquals(len(a.invalid_msgs), 0)
-        self.assertEquals(len(a.policy_load_msgs), 0)
+        self.assertEqual(len(a.avc_msgs), 21)
+        self.assertEqual(len(a.compute_sid_msgs), 0)
+        self.assertEqual(len(a.invalid_msgs), 0)
+        self.assertEqual(len(a.policy_load_msgs), 0)
 
 class TestGeneration(unittest.TestCase):
     def test_generation(self):
diff --git a/sepolgen/tests/test_interfaces.py b/sepolgen/tests/test_interfaces.py
index b589bdf..a10ce2d 100644
--- a/sepolgen/tests/test_interfaces.py
+++ b/sepolgen/tests/test_interfaces.py
@@ -202,11 +202,11 @@ class TestInterfaceSet(unittest.TestCase):
         i = interfaces.InterfaceSet()
         i.add_headers(h)
 
-        self.assertEquals(len(i.interfaces), 1)
+        self.assertEqual(len(i.interfaces), 1)
         for key, interface in i.interfaces.items():
-            self.assertEquals(key, interface.name)
-            self.assertEquals(key, "foo")
-            self.assertEquals(len(interface.access), 2)
+            self.assertEqual(key, interface.name)
+            self.assertEqual(key, "foo")
+            self.assertEqual(len(interface.access), 2)
 
             # Check the access vectors
             comp_avs = [["$1", "usr_t", "dir", "create", "add_name"],
@@ -215,21 +215,21 @@ class TestInterfaceSet(unittest.TestCase):
             self.assertTrue(ret)
 
             # Check the params
-            self.assertEquals(len(interface.params), 1)
+            self.assertEqual(len(interface.params), 1)
             for param in interface.params.values():
-                self.assertEquals(param.type, refpolicy.SRC_TYPE)
-                self.assertEquals(param.name, "$1")
-                self.assertEquals(param.num, 1)
-                self.assertEquals(param.required, True)
+                self.assertEqual(param.type, refpolicy.SRC_TYPE)
+                self.assertEqual(param.name, "$1")
+                self.assertEqual(param.num, 1)
+                self.assertEqual(param.required, True)
 
     def test_expansion(self):
         h = refparser.parse(test_expansion)
         i = interfaces.InterfaceSet()
         i.add_headers(h)
 
-        self.assertEquals(len(i.interfaces), 3)
+        self.assertEqual(len(i.interfaces), 3)
         for key, interface in i.interfaces.items():
-            self.assertEquals(key, interface.name)
+            self.assertEqual(key, interface.name)
             if key == "foo":
                 comp_avs = [["$1", "usr_t", "dir", "create", "add_name"],
                             ["$1", "usr_t", "file", "read", "write"]]
@@ -277,6 +277,6 @@ class TestInterfaceSet(unittest.TestCase):
             if ifv.name == "files_exec_usr_files":
                 if_status[2] = True
 
-        self.assertEquals(if_status[0], True)
-        self.assertEquals(if_status[1], True)
-        self.assertEquals(if_status[2], True)
+        self.assertEqual(if_status[0], True)
+        self.assertEqual(if_status[1], True)
+        self.assertEqual(if_status[2], True)
diff --git a/sepolgen/tests/test_matching.py b/sepolgen/tests/test_matching.py
index 161e001..3ecb80b 100644
--- a/sepolgen/tests/test_matching.py
+++ b/sepolgen/tests/test_matching.py
@@ -33,15 +33,15 @@ class TestMatch(unittest.TestCase):
         b.dist = 100
         b.info_dir_change = True
 
-        self.assertEquals(a, b)
+        self.assertEqual(a, b)
         b.info_dir_change = False
-        self.assertEquals(cmp(a, b), 1)
-        self.assertEquals(cmp(b, a), -1)
+        self.assertTrue((a > b))
+        self.assertTrue((b < a))
 
         b.dist = 200
 
-        self.assertEquals(cmp(a, b), -1)
-        self.assertEquals(cmp(b, a), 1)
+        self.assertTrue((a < b))
+        self.assertTrue((b > a))
 
 class TestMatchList(unittest.TestCase):
     def test_append(self):
@@ -90,7 +90,7 @@ class TestMatchList(unittest.TestCase):
         for x, y in zip(l, ml):
             self.assertEqual(x, y)
 
-        self.assertEquals(ml.best(), c)
+        self.assertEqual(ml.best(), c)
 
 
 test_expansion = """
diff --git a/sepolgen/tests/test_objectmodel.py b/sepolgen/tests/test_objectmodel.py
index 3db241c..19c9eac 100644
--- a/sepolgen/tests/test_objectmodel.py
+++ b/sepolgen/tests/test_objectmodel.py
@@ -27,18 +27,18 @@ class TestInfoFlow(unittest.TestCase):
         info.from_file(fd)
 
         pm = info.get("filesystem", "mount")
-        self.assertEquals(pm.perm, "mount")
-        self.assertEquals(pm.dir, sepolgen.objectmodel.FLOW_WRITE)
-        self.assertEquals(pm.weight, 1)
+        self.assertEqual(pm.perm, "mount")
+        self.assertEqual(pm.dir, sepolgen.objectmodel.FLOW_WRITE)
+        self.assertEqual(pm.weight, 1)
 
         self.assertRaises(KeyError, info.get, "filesystem", "foo")
 
         pm = info.getdefault("filesystem", "foo")
-        self.assertEquals(pm.perm, "foo")
-        self.assertEquals(pm.dir, sepolgen.objectmodel.FLOW_BOTH)
-        self.assertEquals(pm.weight, 5)
+        self.assertEqual(pm.perm, "foo")
+        self.assertEqual(pm.dir, sepolgen.objectmodel.FLOW_BOTH)
+        self.assertEqual(pm.weight, 5)
 
         pm = info.getdefault("foo", "bar")
-        self.assertEquals(pm.perm, "bar")
-        self.assertEquals(pm.dir, sepolgen.objectmodel.FLOW_BOTH)
-        self.assertEquals(pm.weight, 5)
+        self.assertEqual(pm.perm, "bar")
+        self.assertEqual(pm.dir, sepolgen.objectmodel.FLOW_BOTH)
+        self.assertEqual(pm.weight, 5)
diff --git a/sepolgen/tests/test_refparser.py b/sepolgen/tests/test_refparser.py
index 3fe6d79..d7db145 100644
--- a/sepolgen/tests/test_refparser.py
+++ b/sepolgen/tests/test_refparser.py
@@ -107,12 +107,12 @@ class TestParser(unittest.TestCase):
         h = refparser.parse(interface_example)
         #print ""
         #refpolicy.print_tree(h)
-        #self.assertEquals(len(h.interfaces), 3)
+        #self.assertEqual(len(h.interfaces), 3)
 
         name = "files_search_usr"
         #i = h.interfaces[name]
-        #self.assertEquals(i.name, name)
-        #self.assertEquals(len(i.rules), 1)
+        #self.assertEqual(i.name, name)
+        #self.assertEqual(len(i.rules), 1)
         #rule = i.rules[0]
         #self.assertTrue(isinstance(rule, refpolicy.AVRule))
         
diff --git a/sepolgen/tests/test_refpolicy.py b/sepolgen/tests/test_refpolicy.py
index 8c87189..6f3b886 100644
--- a/sepolgen/tests/test_refpolicy.py
+++ b/sepolgen/tests/test_refpolicy.py
@@ -24,10 +24,10 @@ import selinux
 class TestIdSet(unittest.TestCase):
     def test_set_to_str(self):
         s = refpolicy.IdSet(["read", "write", "getattr"])
-        self.assertEquals(s.to_space_str(), "{ read write getattr }")
+        self.assertEqual(s.to_space_str(), "{ read write getattr }")
         s = refpolicy.IdSet()
         s.add("read")
-        self.assertEquals(s.to_space_str(), "read")
+        self.assertEqual(s.to_space_str(), "read")
 
 class TestSecurityContext(unittest.TestCase):
     def test_init(self):
@@ -38,25 +38,25 @@ class TestSecurityContext(unittest.TestCase):
         context = "user_u:object_r:foo_t"
         sc = refpolicy.SecurityContext()
         sc.from_string(context)
-        self.assertEquals(sc.user, "user_u")
-        self.assertEquals(sc.role, "object_r")
-        self.assertEquals(sc.type, "foo_t")
-        self.assertEquals(sc.level, None)
+        self.assertEqual(sc.user, "user_u")
+        self.assertEqual(sc.role, "object_r")
+        self.assertEqual(sc.type, "foo_t")
+        self.assertEqual(sc.level, None)
         if selinux.is_selinux_mls_enabled():
-            self.assertEquals(str(sc), context + ":s0")
+            self.assertEqual(str(sc), context + ":s0")
         else:
-            self.assertEquals(str(sc), context)
-        self.assertEquals(sc.to_string(default_level="s1"), context + ":s1")
+            self.assertEqual(str(sc), context)
+        self.assertEqual(sc.to_string(default_level="s1"), context + ":s1")
 
         context = "user_u:object_r:foo_t:s0-s0:c0-c255"
         sc = refpolicy.SecurityContext()
         sc.from_string(context)
-        self.assertEquals(sc.user, "user_u")
-        self.assertEquals(sc.role, "object_r")
-        self.assertEquals(sc.type, "foo_t")
-        self.assertEquals(sc.level, "s0-s0:c0-c255")
-        self.assertEquals(str(sc), context)
-        self.assertEquals(sc.to_string(), context)
+        self.assertEqual(sc.user, "user_u")
+        self.assertEqual(sc.role, "object_r")
+        self.assertEqual(sc.type, "foo_t")
+        self.assertEqual(sc.level, "s0-s0:c0-c255")
+        self.assertEqual(str(sc), context)
+        self.assertEqual(sc.to_string(), context)
 
         sc = refpolicy.SecurityContext()
         self.assertRaises(ValueError, sc.from_string, "abc")
@@ -67,20 +67,20 @@ class TestSecurityContext(unittest.TestCase):
         sc3 = refpolicy.SecurityContext("user_u:object_r:foo_t:s0")
         sc4 = refpolicy.SecurityContext("user_u:object_r:bar_t")
 
-        self.assertEquals(sc1, sc2)
-        self.assertNotEquals(sc1, sc3)
-        self.assertNotEquals(sc1, sc4)
+        self.assertEqual(sc1, sc2)
+        self.assertNotEqual(sc1, sc3)
+        self.assertNotEqual(sc1, sc4)
 
 class TestObjecClass(unittest.TestCase):
     def test_init(self):
         o = refpolicy.ObjectClass(name="file")
-        self.assertEquals(o.name, "file")
+        self.assertEqual(o.name, "file")
         self.assertTrue(isinstance(o.perms, set))
 
 class TestAVRule(unittest.TestCase):
     def test_init(self):
         a = refpolicy.AVRule()
-        self.assertEquals(a.rule_type, a.ALLOW)
+        self.assertEqual(a.rule_type, a.ALLOW)
         self.assertTrue(isinstance(a.src_types, set))
         self.assertTrue(isinstance(a.tgt_types, set))
         self.assertTrue(isinstance(a.obj_classes, set))
@@ -92,7 +92,7 @@ class TestAVRule(unittest.TestCase):
         a.tgt_types.add("bar_t")
         a.obj_classes.add("file")
         a.perms.add("read")
-        self.assertEquals(a.to_string(), "allow foo_t bar_t:file read;")
+        self.assertEqual(a.to_string(), "allow foo_t bar_t:file read;")
 
         a.rule_type = a.DONTAUDIT
         a.src_types.add("user_t")
@@ -100,17 +100,17 @@ class TestAVRule(unittest.TestCase):
         a.obj_classes.add("lnk_file")
         a.perms.add("write")
         # This test might need to go because set ordering is not guaranteed
-        self.assertEquals(a.to_string(),
+        self.assertEqual(a.to_string(),
                           "dontaudit { foo_t user_t } { user_home_t bar_t }:{ lnk_file file } { read write };")
 
 class TestTypeRule(unittest.TestCase):
     def test_init(self):
         a = refpolicy.TypeRule()
-        self.assertEquals(a.rule_type, a.TYPE_TRANSITION)
+        self.assertEqual(a.rule_type, a.TYPE_TRANSITION)
         self.assertTrue(isinstance(a.src_types, set))
         self.assertTrue(isinstance(a.tgt_types, set))
         self.assertTrue(isinstance(a.obj_classes, set))
-        self.assertEquals(a.dest_type, "")
+        self.assertEqual(a.dest_type, "")
 
     def test_to_string(self):
         a = refpolicy.TypeRule()
@@ -118,7 +118,7 @@ class TestTypeRule(unittest.TestCase):
         a.tgt_types.add("bar_exec_t")
         a.obj_classes.add("process")
         a.dest_type = "bar_t"
-        self.assertEquals(a.to_string(), "type_transition foo_t bar_exec_t:process bar_t;")
+        self.assertEqual(a.to_string(), "type_transition foo_t bar_exec_t:process bar_t;")
 
 
 class TestParseNode(unittest.TestCase):
-- 
2.4.3
