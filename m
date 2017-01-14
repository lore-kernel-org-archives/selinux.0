Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0EEeXxE006468
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 09:40:33 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 145BD56079C
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 15:40:31 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] semanage,
 sepolicy: make tests not fail on systems without SELinux
Date: Sat, 14 Jan 2017 15:40:24 +0100
Message-Id: <20170114144024.4709-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selinux.security_getenforce() triggers an exception when running tests
on systems without SELinux. In order to skip tests which need SELinux in
enforcing mode, test selinux.is_selinux_enabled() too, like commit
945bc8853b62 ("sandbox: make test not fail on systems without SELinux").

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/test-semanage.py | 2 +-
 python/sepolicy/test_sepolicy.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/test-semanage.py b/python/semanage/test-semanage.py
index 12ffc98afd6e..c8f6ec231fc2 100644
--- a/python/semanage/test-semanage.py
+++ b/python/semanage/test-semanage.py
@@ -276,7 +276,7 @@ def gen_semanage_test_args(parser):
 if __name__ == "__main__":
     import selinux
     semanage_test_list = [x for x in dir(SemanageTests) if x.startswith("test_")]
-    if selinux.security_getenforce() == 1:
+    if selinux.is_selinux_enabled() and selinux.security_getenforce() == 1:
         parser = argparse.ArgumentParser(description='Semanage unit test script')
         gen_semanage_test_args(parser)
         try:
diff --git a/python/sepolicy/test_sepolicy.py b/python/sepolicy/test_sepolicy.py
index 61dfb4550830..304e56f60a7c 100644
--- a/python/sepolicy/test_sepolicy.py
+++ b/python/sepolicy/test_sepolicy.py
@@ -115,7 +115,7 @@ class SepolicyTests(unittest.TestCase):
 
 if __name__ == "__main__":
     import selinux
-    if selinux.security_getenforce() == 1:
+    if selinux.is_selinux_enabled() and selinux.security_getenforce() == 1:
         unittest.main()
     else:
         print("SELinux must be in enforcing mode for this test")
-- 
2.11.0
