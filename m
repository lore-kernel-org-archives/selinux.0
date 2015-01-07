Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t07M4B0i012792
 for <selinux@tycho.nsa.gov>; Wed, 7 Jan 2015 17:04:13 -0500
From: John Brooks <john.brooks@jolla.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Build libsepol with -O2
Date: Wed,  7 Jan 2015 15:03:39 -0700
Message-Id: <1420668221-52637-2-git-send-email-john.brooks@jolla.com>
In-Reply-To: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libsepol contains performance sensitive code; in particular, compiler
optimizations save a few minutes off of the optimized policydb hash
tables.
---
 libsepol/src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index 6450d67..059f198 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -22,7 +22,7 @@ OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
 LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute
 
-override CFLAGS += -I. -I../include -D_GNU_SOURCE
+override CFLAGS += -I. -I../include -D_GNU_SOURCE -O2
 
 ifneq ($(DISABLE_CIL),y)
 OBJS += $(sort $(patsubst %.c,%.o,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
-- 
1.9.3
