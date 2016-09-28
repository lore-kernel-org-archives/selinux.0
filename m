From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux: set DISABLE_RPM default to y.
Date: Wed, 28 Sep 2016 12:00:24 -0400
Message-Id: <1475078424-21486-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1475078424-21486-1-git-send-email-william.c.roberts@intel.com>
References: <1475078424-21486-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Change the default build behavior to always use DISABLE_RPM.
To get the old behavior call make with DISABLE_RPM=n.

eg.)
make DISABLE_RPM=n

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 41d836c..cec2943 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -1,7 +1,7 @@
 SUBDIRS = src include utils man
 
 DISABLE_SETRANS ?= n
-DISABLE_RPM ?= n
+DISABLE_RPM ?= y
 ifeq ($(DISABLE_RPM),y)
 	DISABLE_FLAGS+= -DDISABLE_RPM
 endif
-- 
1.9.1
