Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t6GBn1j5021566
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 07:49:10 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 1ED233812BD
 for <selinux@tycho.nsa.gov>; Thu, 16 Jul 2015 11:49:09 +0000 (UTC)
From: Robert Kuska <rkuska@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/11] sepolgen: Replace usage of xrange inside of tests.
Date: Thu, 16 Jul 2015 13:48:18 +0200
Message-Id: <1437047301-17672-9-git-send-email-rkuska@redhat.com>
In-Reply-To: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
References: <1437047301-17672-1-git-send-email-rkuska@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

xrange function is gone in Python3 and instead range is
xrange by default. Also it doesnt seem to be important
to have xrange used in tests on Python2.

Signed-off-by: Robert Kuska <rkuska@redhat.com>
---
 sepolgen/tests/test_access.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sepolgen/tests/test_access.py b/sepolgen/tests/test_access.py
index 631209c..888c011 100644
--- a/sepolgen/tests/test_access.py
+++ b/sepolgen/tests/test_access.py
@@ -165,7 +165,7 @@ class TestUtilFunctions(unittest.TestCase):
         status = [False] * 8
         for av in access.avrule_to_access_vectors(rule):
             self.assertEqual(av.perms, refpolicy.IdSet(["read", "write"]))
-            for i in xrange(len(comps)):
+            for i in range(len(comps)):
                 if comps[i][0] == av.src_type and \
                    comps[i][1] == av.tgt_type and \
                    comps[i][2] == av.obj_class:
@@ -208,7 +208,7 @@ class TestAccessVectorSet(unittest.TestCase):
         status = [False] * 8
         for av in self.s:
             self.assertEqual(av.perms, refpolicy.IdSet(["read", "write"]))
-            for i in xrange(len(comps)):
+            for i in range(len(comps)):
                 if comps[i][0] == av.src_type and \
                    comps[i][1] == av.tgt_type and \
                    comps[i][2] == av.obj_class:
-- 
2.4.3
