Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u526nQco022431
 for <selinux@tycho.nsa.gov>; Thu, 2 Jun 2016 02:49:26 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id C55561A1BB
 for <selinux@tycho.nsa.gov>; Thu,  2 Jun 2016 08:49:21 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id e7kGqPwKlXZP for <selinux@tycho.nsa.gov>;
 Thu,  2 Jun 2016 08:49:18 +0200 (CEST)
Received: from fornost.bigon.be (unknown
 [IPv6:2a02:578:85fc:0:2440:d764:9b75:61a9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 9B7F61A0D9
 for <selinux@tycho.nsa.gov>; Thu,  2 Jun 2016 08:49:18 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Sort object files for deterministic linking order
Date: Thu,  2 Jun 2016 08:49:18 +0200
Message-Id: <1464850158-16461-1-git-send-email-bigon@debian.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

This patch is part of the Debian effort to make the build reproducible

Thank to Reiner Herrmann <reiner@reiner-h.de> for the patches

Signed-off-by: Laurent Bigonville <bigon@bigon.be>
---
 libselinux/src/Makefile  | 2 +-
 libsemanage/src/Makefile | 2 +-
 libsepol/src/Makefile    | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index ac9a5d6..d94163e 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -49,7 +49,7 @@ ifeq ($(DISABLE_BOOL),y)
 endif
 
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
-SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(wildcard *.c))
+SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
 MAX_STACK_SIZE=32768
 
diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index d6c3f0f..96ee652 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -52,7 +52,7 @@ SWIGRUBYSO=$(RUBYPREFIX)_semanage.so
 LIBSO=$(TARGET).$(LIBVERSION)
 
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) semanageswig_python_exception.i
-SRCS= $(filter-out $(GENERATED),$(wildcard *.c))
+SRCS= $(filter-out $(GENERATED),$(sort $(wildcard *.c)))
 
 OBJS= $(patsubst %.c,%.o,$(SRCS)) conf-scan.o conf-parse.o
 LOBJS= $(patsubst %.c,%.lo,$(SRCS)) conf-scan.lo conf-parse.lo
diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
index c0c3274..b0c901f 100644
--- a/libsepol/src/Makefile
+++ b/libsepol/src/Makefile
@@ -18,15 +18,15 @@ TARGET=libsepol.so
 LIBPC=libsepol.pc
 LIBMAP=libsepol.map
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
-LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
+OBJS= $(patsubst %.c,%.o,$(sort $(wildcard *.c)))
+LOBJS= $(patsubst %.c,%.lo,$(sort $(wildcard *.c)))
 CFLAGS ?= -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
 
 override CFLAGS += -I. -I../include -D_GNU_SOURCE
 
 ifneq ($(DISABLE_CIL),y)
-OBJS += $(sort $(patsubst %.c,%.o,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
-LOBJS += $(sort $(patsubst %.c,%.lo,$(wildcard $(CILDIR)/src/*.c) $(CIL_GENERATED)))
+OBJS += $(sort $(patsubst %.c,%.o,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_GENERATED)))
+LOBJS += $(sort $(patsubst %.c,%.lo,$(sort $(wildcard $(CILDIR)/src/*.c)) $(CIL_GENERATED)))
 override CFLAGS += -I$(CILDIR)/include
 endif
 
-- 
2.8.1
