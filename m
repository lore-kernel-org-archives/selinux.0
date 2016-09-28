From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 3/3] libselinux: drop DISABLE_BOOL=y option
Date: Wed, 28 Sep 2016 11:26:09 -0400
Message-Id: <1475076369-13586-3-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
References: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Build option DISABLE_BOOL=y is not being used, and is broken, drop it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile          | 6 +-----
 libselinux/src/Makefile      | 6 +-----
 libselinux/src/load_policy.c | 2 --
 libselinux/utils/Makefile    | 5 -----
 4 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index c96695d..bfeb4b8 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -2,17 +2,13 @@ SUBDIRS = src include utils man
 
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
-DISABLE_BOOL ?= n
-ifeq ($(DISABLE_BOOL),y)
-	EMFLAGS+= -DDISABLE_BOOL
-endif
 ifeq ($(DISABLE_RPM),y)
 	EMFLAGS+= -DDISABLE_RPM
 endif
 ifeq ($(DISABLE_SETRANS),y)
 	EMFLAGS+= -DDISABLE_SETRANS
 endif
-export DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
+export DISABLE_SETRANS DISABLE_RPM EMFLAGS
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 8cfdf34..d8a79b4 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -41,12 +41,8 @@ LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
 AUDIT2WHYSO=$(PYPREFIX)audit2why.so
 
-ifeq ($(DISABLE_BOOL),y)
-	UNUSED_SRCS+=booleans.c
-endif
-
 GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
-SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
+SRCS= $(filter-out $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
 
 MAX_STACK_SIZE=32768
 
diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 249f82f..b7e1a6f 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -256,7 +256,6 @@ checkbool:
 			}
 		}
 		
-#ifndef DISABLE_BOOL
 		if (preservebools) {
 			int *values, len, i;
 			char **names;
@@ -279,7 +278,6 @@ checkbool:
 			(void)genbools(data, size,
 				       (char *)selinux_booleans_path());
 		}
-#endif
 	}
 
 
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 9ec928b..0708d6d 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -36,11 +36,6 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
 selinux_restorecon: LDLIBS += -lsepol
 
-ifeq ($(DISABLE_BOOL),y)
-	UNUSED_TARGETS+=getsebool togglesebool
-endif
-TARGETS:= $(filter-out $(UNUSED_TARGETS), $(TARGETS))
-
 all: $(TARGETS)
 
 install: all
-- 
1.9.1
