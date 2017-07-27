Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6RDgXYm013718
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 09:42:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 58C22104D7D
 for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2017 13:11:07 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 27 Jul 2017 15:10:50 +0200
Message-Id: <20170727131053.7962-1-plautrba@redhat.com>
Subject: [PATCH 1/4] sepolicy: Fix minor typo in 'transition -s' test
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 python/sepolicy/test_sepolicy.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/sepolicy/test_sepolicy.py b/python/sepolicy/test_sepolicy.py
index 304e56f6..6d60d6f6 100644
--- a/python/sepolicy/test_sepolicy.py
+++ b/python/sepolicy/test_sepolicy.py
@@ -60,7 +60,7 @@ class SepolicyTests(unittest.TestCase):
         self.assertSuccess(p.returncode, err)
 
     def test_transition_s(self):
-        "Verify sepolicy transition -l works"
+        "Verify sepolicy transition -s works"
         p = Popen(['sepolicy', 'transition', '-s', 'httpd_t'], stdout=PIPE)
         out, err = p.communicate()
         self.assertSuccess(p.returncode, err)
-- 
2.13.3
