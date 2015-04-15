Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3FM7iDt022676
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 18:07:44 -0400
Received: by iebrs15 with SMTP id rs15so38555725ieb.3
 for <selinux@tycho.nsa.gov>; Wed, 15 Apr 2015 15:07:42 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Add empty top level Android.mk / CleanSpec.mk files
Date: Wed, 15 Apr 2015 15:07:22 -0700
Message-Id: <1429135642-25619-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Needed to allow Android to keep building with a copy of the SELinux
source code checked into external/selinux

Bug: 19963152
Change-Id: I4e192bb6ca5d185e11540aca7253e729d92a00c1
---
 Android.mk   | 2 ++
 CleanSpec.mk | 2 ++
 2 files changed, 4 insertions(+)
 create mode 100644 Android.mk
 create mode 100644 CleanSpec.mk

diff --git a/Android.mk b/Android.mk
new file mode 100644
index 0000000..02f35a9
--- /dev/null
+++ b/Android.mk
@@ -0,0 +1,2 @@
+# This empty Android.mk file will prevent the build system
+# from building anything below this point.
diff --git a/CleanSpec.mk b/CleanSpec.mk
new file mode 100644
index 0000000..1ac5a62
--- /dev/null
+++ b/CleanSpec.mk
@@ -0,0 +1,2 @@
+# This empty CleanSpec.mk file will prevent the build system
+# from descending into subdirs.
-- 
2.2.0.rc0.207.ga3a616c
