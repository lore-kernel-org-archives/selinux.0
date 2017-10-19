Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9J2Kp5j028573
 for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2017 22:20:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 3yHXht0btTzg47f
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 02:20:46 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 3yHXht01SQzg47W
 for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2017 02:20:46 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id i5so5376376pfe.6
 for <selinux@tycho.nsa.gov>; Wed, 18 Oct 2017 19:20:44 -0700 (PDT)
From: bill.c.roberts@gmail.com
To: selinux@tycho.nsa.gov
Cc: William Roberts <william.c.roberts@intel.com>
Date: Wed, 18 Oct 2017 19:20:38 -0700
Message-Id: <1508379638-19927-1-git-send-email-william.c.roberts@intel.com>
Subject: [PATCH] CleanSpec.mk: remove
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The Android.mk files were removed but the CleanSpec.mk lingered on,
remove it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---

For those who whish to see the Travis-CI integration, go to:
  https://github.com/SELinuxProject/selinux/pull/66

Travis will build both PRs and direct pushes to the tree:
  https://travis-ci.org/SELinuxProject/selinux/jobs/289577844

It currently builds a whopping 22 configurations and runs the
unit test suites. Thanks Nicolas!

 CleanSpec.mk | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 CleanSpec.mk

diff --git a/CleanSpec.mk b/CleanSpec.mk
deleted file mode 100644
index 1ac5a62..0000000
--- a/CleanSpec.mk
+++ /dev/null
@@ -1,2 +0,0 @@
-# This empty CleanSpec.mk file will prevent the build system
-# from descending into subdirs.
-- 
2.7.4
