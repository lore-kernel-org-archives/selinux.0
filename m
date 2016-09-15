Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8FEdqKE022025
 for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2016 10:39:56 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA0749D0DB
 for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2016 14:39:54 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] sandbox: tests - close stdout of p1
Date: Thu, 15 Sep 2016 16:39:28 +0200
Message-Id: <1473950369-2547-2-git-send-email-plautrba@redhat.com>
In-Reply-To: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
References: <1473950369-2547-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

p1.stdout should be closed after it's connected to p2 according to
https://docs.python.org/3/library/subprocess.html#replacing-shell-pipeline

Fixes:
$ make PYTHON=python3 test
Verify that we can read file descriptors handed to sandbox ...
/usr/lib64/python3.5/unittest/case.py:638: ResourceWarning: unclosed
file <_io.BufferedReader name=4>
  testMethod()

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/sandbox/test_sandbox.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policycoreutils/sandbox/test_sandbox.py b/policycoreutils/sandbox/test_sandbox.py
index d5368c2..98c04a7 100644
--- a/policycoreutils/sandbox/test_sandbox.py
+++ b/policycoreutils/sandbox/test_sandbox.py
@@ -28,6 +28,7 @@ class SandboxTests(unittest.TestCase):
         "Verify that we can read file descriptors handed to sandbox"
         p1 = Popen(['cat', '/etc/passwd'], stdout=PIPE)
         p2 = Popen([sys.executable, 'sandbox', 'grep', 'root'], stdin=p1.stdout, stdout=PIPE)
+        p1.stdout.close()
         out, err = p2.communicate()
         self.assertTrue(b'root' in out)
 
-- 
1.8.3.1
