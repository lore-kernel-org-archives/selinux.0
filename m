Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7J3jhXl022472
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 23:45:43 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so750856pfe.0
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 20:45:39 -0700 (PDT)
From: Jason Zaman <jason@perfinion.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] audit2allow: tests should use local copy not system
Date: Fri, 19 Aug 2016 11:45:17 +0800
Message-Id: <1471578317-22785-3-git-send-email-jason@perfinion.com>
In-Reply-To: <1471578317-22785-1-git-send-email-jason@perfinion.com>
References: <1471578317-22785-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The tests currently just executed "audit2allow" which meant search in
$PATH. They should instead test the one in the pwd. The files in the
repo are not executable so prefix with "python" also.

Signed-off-by: Jason Zaman <jason@perfinion.com>
---
 policycoreutils/audit2allow/test_audit2allow.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/audit2allow/test_audit2allow.py b/policycoreutils/audit2allow/test_audit2allow.py
index 765c9ea..a826a9f 100644
--- a/policycoreutils/audit2allow/test_audit2allow.py
+++ b/policycoreutils/audit2allow/test_audit2allow.py
@@ -33,7 +33,7 @@ class Audit2allowTests(unittest.TestCase):
 
     def test_audit2allow(self):
         "Verify audit2allow works"
-        p = Popen(['audit2allow', "-i", "test.log"], stdout=PIPE)
+        p = Popen(['python', './audit2allow', "-i", "test.log"], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
@@ -41,7 +41,7 @@ class Audit2allowTests(unittest.TestCase):
 
     def test_audit2why(self):
         "Verify audit2why works"
-        p = Popen(['audit2why', "-i", "test.log"], stdout=PIPE)
+        p = Popen(['python', './audit2why', "-i", "test.log"], stdout=PIPE)
         out, err = p.communicate()
         if err:
             print(out, err)
-- 
2.7.3
