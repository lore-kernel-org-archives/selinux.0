Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45C3Cu6013308
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 08:03:13 -0400
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 68773564830
 for <selinux@tycho.nsa.gov>; Thu,  5 May 2016 14:03:04 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Update .gitignore files
Date: Thu,  5 May 2016 14:02:38 +0200
Message-Id: <1462449760-9072-2-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
References: <1462449760-9072-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/.gitignore        | 5 +++++
 libsemanage/tests/.gitignore       | 1 +
 libsepol/tests/.gitignore          | 1 +
 libsepol/tests/policies/.gitignore | 3 +++
 sepolgen/tests/.gitignore          | 4 ++++
 5 files changed, 14 insertions(+)
 create mode 100644 libsemanage/tests/.gitignore
 create mode 100644 libsepol/tests/.gitignore
 create mode 100644 libsepol/tests/policies/.gitignore
 create mode 100644 sepolgen/tests/.gitignore

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 060eaabd1a72..ed3bf0bb28f9 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -14,7 +14,12 @@ getseuser
 matchpathcon
 policyvers
 sefcontext_compile
+selabel_digest
+selabel_lookup
+selabel_lookup_best_match
+selabel_partial_match
 selinux_check_securetty_context
+selinux_restorecon
 selinuxenabled
 selinuxexeccon
 setenforce
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
new file mode 100644
index 000000000000..f07111dba429
--- /dev/null
+++ b/libsemanage/tests/.gitignore
@@ -0,0 +1 @@
+libsemanage-tests
diff --git a/libsepol/tests/.gitignore b/libsepol/tests/.gitignore
new file mode 100644
index 000000000000..c3f60fd2b945
--- /dev/null
+++ b/libsepol/tests/.gitignore
@@ -0,0 +1 @@
+libsepol-tests
diff --git a/libsepol/tests/policies/.gitignore b/libsepol/tests/policies/.gitignore
new file mode 100644
index 000000000000..5a547a8aa9df
--- /dev/null
+++ b/libsepol/tests/policies/.gitignore
@@ -0,0 +1,3 @@
+test-downgrade/
+test-*/*.mls
+test-*/*.std
diff --git a/sepolgen/tests/.gitignore b/sepolgen/tests/.gitignore
new file mode 100644
index 000000000000..c120af8a0067
--- /dev/null
+++ b/sepolgen/tests/.gitignore
@@ -0,0 +1,4 @@
+module_compile_test.fc
+module_compile_test.if
+output
+tmp/
-- 
2.8.2
