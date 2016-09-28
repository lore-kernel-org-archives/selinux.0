From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 2/3] libselinux: drop DISABLE_AVC=y
Date: Wed, 28 Sep 2016 11:26:08 -0400
Message-Id: <1475076369-13586-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
References: <1475076369-13586-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Remove build config DISABLE_AVC, it is unused and broken.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/Makefile       | 6 +-----
 libselinux/src/Makefile   | 3 ---
 libselinux/src/mapping.h  | 7 -------
 libselinux/utils/Makefile | 3 ---
 4 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index d1532e8..c96695d 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -1,12 +1,8 @@
 SUBDIRS = src include utils man
 
-DISABLE_AVC ?= n
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
 DISABLE_BOOL ?= n
-ifeq ($(DISABLE_AVC),y)
-	EMFLAGS+= -DDISABLE_AVC
-endif
 ifeq ($(DISABLE_BOOL),y)
 	EMFLAGS+= -DDISABLE_BOOL
 endif
@@ -16,7 +12,7 @@ endif
 ifeq ($(DISABLE_SETRANS),y)
 	EMFLAGS+= -DDISABLE_SETRANS
 endif
-export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
+export DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
 
 USE_PCRE2 ?= n
 ifeq ($(USE_PCRE2),y)
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 36e42b8..8cfdf34 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -41,9 +41,6 @@ LIBSO=$(TARGET).$(LIBVERSION)
 AUDIT2WHYLOBJ=$(PYPREFIX)audit2why.lo
 AUDIT2WHYSO=$(PYPREFIX)audit2why.so
 
-ifeq ($(DISABLE_AVC),y)
-	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c checkAccess.c
-endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_SRCS+=booleans.c
 endif
diff --git a/libselinux/src/mapping.h b/libselinux/src/mapping.h
index b96756b..22a4cca 100644
--- a/libselinux/src/mapping.h
+++ b/libselinux/src/mapping.h
@@ -31,11 +31,4 @@ map_perm(security_class_t tclass, access_vector_t kperm);
 extern void
 map_decision(security_class_t tclass, struct av_decision *avd);
 
-/*mapping is not used for embedded build*/
-#ifdef DISABLE_AVC 
-#define unmap_perm(x,y) y
-#define unmap_class(x) x
-#define map_decision(x,y) 
-#endif
-
 #endif				/* _SELINUX_MAPPING_H_ */
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 1943bef..9ec928b 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -36,9 +36,6 @@ sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
 selinux_restorecon: LDLIBS += -lsepol
 
-ifeq ($(DISABLE_AVC),y)
-	UNUSED_TARGETS+=compute_av compute_create compute_member compute_relabel
-endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_TARGETS+=getsebool togglesebool
 endif
-- 
1.9.1
