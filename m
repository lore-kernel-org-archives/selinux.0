Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAHLKFS3012144
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 16:20:15 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4A01C5647A2
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 22:20:12 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] sandbox: make test not fail on systems without SELinux
Date: Thu, 17 Nov 2016 22:20:06 +0100
Message-Id: <20161117212006.20697-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On systems without SELinux (eg. some continuous integration
environments), "make test" fails with:

    Traceback (most recent call last):
      File "test_sandbox.py", line 110, in <module>
        if selinux.security_getenforce() == 1:
    FileNotFoundError: [Errno 2] No such file or directory

This is exception is thrown because the selinuxfs file system is not
mounted.

Detect such configurations using selinux.is_selinux_enabled() and skip
the test when SELinux is disabled accordingly.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 sandbox/test_sandbox.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/test_sandbox.py b/sandbox/test_sandbox.py
index bcecf66ee257..ba849a08141d 100644
--- a/sandbox/test_sandbox.py
+++ b/sandbox/test_sandbox.py
@@ -107,7 +107,7 @@ class SandboxTests(unittest.TestCase):
 
 if __name__ == "__main__":
     import selinux
-    if selinux.security_getenforce() == 1:
+    if selinux.is_selinux_enabled() and selinux.security_getenforce() == 1:
         unittest.main()
     else:
         print("SELinux must be in enforcing mode for this test")
-- 
2.10.2
