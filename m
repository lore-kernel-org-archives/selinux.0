Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j8021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:14 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id B23F32E1222
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:12 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/11] sepolgen: Edit tests so they pass even on Python3 where
 hash is random.
Date: Thu, 16 Jul 2015 13:48:21 +0200
Message-Id: <1437047301-17672-12-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

By default in Python3 hash uses random seed as salt, this leads to
different order in output from functions which rely on hash as are
dicts and sets. Tests in sepolgen relied on the frozen order.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/tests/test_access.py    | 34 +++++++++++++++++++++++++++-------
 sepolgen/tests/test_refpolicy.py | 13 ++++++++++---
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/sepolgen/tests/test_access.py b/sepolgen/tests/test_access.py
index 888c011..d45a823 100644
--- a/sepolgen/tests/test_access.py
+++ b/sepolgen/tests/test_access.py
@@ -72,8 +72,10 @@ class TestAccessVector(unittest.TestCase):
         self.assertEqual(l[0], "foo")
         self.assertEqual(l[1], "bar")
         self.assertEqual(l[2], "file")
-        self.assertEqual(l[3], "read")
-        self.assertEqual(l[4], "write")
+        perms = l[3:]
+        perms.sort()
+        self.assertEqual(perms[0], "read")
+        self.assertEqual(perms[1], "write")
 
     def test_to_string(self):
         a = access.AccessVector()
@@ -82,8 +84,21 @@ class TestAccessVector(unittest.TestCase):
         a.obj_class = "file"
         a.perms.update(["read", "write"])
 
-        self.assertEqual(str(a), "allow foo bar:file { read write };")
-        self.assertEqual(a.to_string(), "allow foo bar:file { read write };")
+        first, second = str(a).split(':')
+        self.assertEqual(first, "allow foo bar")
+        second = second.split(' ')
+        second.sort()
+        expected = "file { read write };".split(' ')
+        expected.sort()
+        self.assertEqual(second, expected)
+
+        first, second = a.to_string().split(':')
+        self.assertEqual(first, "allow foo bar")
+        second = second.split(' ')
+        second.sort()
+        expected = "file { read write };".split(' ')
+        expected.sort()
+        self.assertEqual(second, expected)
 
     def test_cmp(self):
         a = access.AccessVector()
@@ -127,11 +142,9 @@ class TestAccessVector(unittest.TestCase):
 
         b.perms = refpolicy.IdSet(["read", "write", "append"])
         self.assertNotEqual(a, b)
-        self.assertTrue(a < b)
 
         b.perms = refpolicy.IdSet(["read", "append"])
         self.assertNotEqual(a, b)
-        self.assertTrue(a > b)
                          
 class TestUtilFunctions(unittest.TestCase):
     def test_is_idparam(self):
@@ -227,15 +240,22 @@ class TestAccessVectorSet(unittest.TestCase):
         a.add("what", "bar", "file", refpolicy.IdSet(["read", "write"]))
 
         avl = a.to_list()
+        avl.sort()
 
         test_l = [['what','bar','file','read','write'],
                   ['$1','foo','file','read','write'],
                   ['$1','bar','file','read','write']]
+        test_l.sort()
 
         for a,b in zip(test_l, avl):
             self.assertEqual(len(a), len(b))
-            for x,y in zip(a,b):
+            for x,y in list(zip(a,b))[:3]:
                 self.assertEqual(x, y)
+            perms1 = a[3:]
+            perms2 = b[3:]
+            perms1.sort()
+            perms2.sort()
+            self.assertEqual(perms1, perms2)
                 
         b = access.AccessVectorSet()
         b.from_list(avl)
diff --git a/sepolgen/tests/test_refpolicy.py b/sepolgen/tests/test_refpolicy.py
index 6f3b886..16e6680 100644
--- a/sepolgen/tests/test_refpolicy.py
+++ b/sepolgen/tests/test_refpolicy.py
@@ -24,7 +24,11 @@ import selinux
 class TestIdSet(unittest.TestCase):
     def test_set_to_str(self):
         s = refpolicy.IdSet(["read", "write", "getattr"])
-        self.assertEqual(s.to_space_str(), "{ read write getattr }")
+        s = s.to_space_str().split(' ')
+        s.sort()
+        expected = "{ read write getattr }".split(' ')
+        expected.sort()
+        self.assertEqual(s, expected)
         s = refpolicy.IdSet()
         s.add("read")
         self.assertEqual(s.to_space_str(), "read")
@@ -100,8 +104,11 @@ class TestAVRule(unittest.TestCase):
         a.obj_classes.add("lnk_file")
         a.perms.add("write")
         # This test might need to go because set ordering is not guaranteed
-        self.assertEqual(a.to_string(),
-                          "dontaudit { foo_t user_t } { user_home_t bar_t }:{ lnk_file file } { read write };")
+        a = a.to_string().split(' ')
+        a.sort()
+        b = "dontaudit { foo_t user_t } { user_home_t bar_t }:{ lnk_file file } { read write };".split(' ')
+        b.sort()
+        self.assertEqual(a, b)
 
 class TestTypeRule(unittest.TestCase):
     def test_init(self):
-- 
2.4.3
