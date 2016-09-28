From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 1/3] libselinux: drop build config EMBEDDED=y
Date: Wed, 28 Sep 2016 11:26:07 -0400
Message-Id: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

It was reported that this is no longer used, so drop it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 5a8d42c..d1532e8 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -4,12 +4,6 @@ DISABLE_AVC ?= n
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
 DISABLE_BOOL ?= n
-ifeq ($(EMBEDDED),y)
-	override DISABLE_AVC=y
-	override DISABLE_SETRANS=y
-	override DISABLE_RPM=y
-	override DISABLE_BOOL=y
-endif
 ifeq ($(DISABLE_AVC),y)
 	EMFLAGS+= -DDISABLE_AVC
 endif
-- 
1.9.1
