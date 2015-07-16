Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j7021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:13 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id C709D2E121E
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:11 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 10/11] sepolgen: Close files after reading/writing in tests.
Date: Thu, 16 Jul 2015 13:48:20 +0200
Message-Id: <1437047301-17672-11-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/tests/test_audit.py       | 1 +
 sepolgen/tests/test_interfaces.py  | 1 +
 sepolgen/tests/test_objectmodel.py | 1 +
 3 files changed, 3 insertions(+)

diff --git a/sepolgen/tests/test_audit.py b/sepolgen/tests/test_audit.py
index c72ca61..6379954 100644
--- a/sepolgen/tests/test_audit.py
+++ b/sepolgen/tests/test_audit.py
@@ -166,6 +166,7 @@ class TestAuditParser(unittest.TestCase):
         f = open("audit.txt")
         a = sepolgen.audit.AuditParser()
         a.parse_file(f)
+        f.close()
         self.assertEqual(len(a.avc_msgs), 21)
         self.assertEqual(len(a.compute_sid_msgs), 0)
         self.assertEqual(len(a.invalid_msgs), 0)
diff --git a/sepolgen/tests/test_interfaces.py b/sepolgen/tests/test_interfaces.py
index a10ce2d..a55f7db 100644
--- a/sepolgen/tests/test_interfaces.py
+++ b/sepolgen/tests/test_interfaces.py
@@ -268,6 +268,7 @@ class TestInterfaceSet(unittest.TestCase):
         i2 = interfaces.InterfaceSet()
         f = open("output")
         i2.from_file(f)
+        f.close()
         if_status = [False, False, False]
         for ifv in i2.interfaces.values():
             if ifv.name == "files_search_usr":
diff --git a/sepolgen/tests/test_objectmodel.py b/sepolgen/tests/test_objectmodel.py
index 19c9eac..b503672 100644
--- a/sepolgen/tests/test_objectmodel.py
+++ b/sepolgen/tests/test_objectmodel.py
@@ -25,6 +25,7 @@ class TestInfoFlow(unittest.TestCase):
         info = sepolgen.objectmodel.PermMappings()
         fd = open("perm_map")
         info.from_file(fd)
+        fd.close()
 
         pm = info.get("filesystem", "mount")
         self.assertEqual(pm.perm, "mount")
-- 
2.4.3
