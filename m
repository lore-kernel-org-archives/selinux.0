Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l474RPTB001389
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 00:27:26 -0400
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l474RNuI005807
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 04:27:24 GMT
Received: from vs2.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l474RFi7026199
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 13:27:15 +0900
Date: Mon, 7 May 2007 13:34:23 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Cc: ynakam@hitachisoft.jp, busybox@kaigai.gr.jp
Subject: [patch] reducing size of libselinux(ver 2)
Message-Id: <20070507133423.3bd2463a.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

I would like to submit patch again 
to reduce size of libselinux for embedded devices, as we discussed before.
http://marc.info/?t=117609454600002&r=1&w=2
This patch is for policyrep branch.

It provides build option "EMBEDDED" for libselinux, like
$ make EMBEDDED=y
What happens by EMBEDDED=y is following:
1) Dependency to libsepol is removed.
   * You can remove libsepol for embedded devices.
   * Automatic downgrade of policy format is 
   not supported when sepol is not used.
2) Files related to userspace AVC are removed
3) Files related to booleans are removed

Above behavior can be customized below in Makefile.
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_BOOL=y
+	override DISABLE_SEPOL=y
+endif

Regards,
-- 
Yuichi Nakamura
Hitachi Software

 Makefile      |   33 ++++++++++++++++++++++++++++++---
 load_policy.c |   24 ++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

Index: libselinux/src/Makefile
===================================================================
--- libselinux/src/Makefile	(revision 2429)
+++ libselinux/src/Makefile	(working copy)
@@ -18,10 +18,37 @@
 SWIGSO=_selinux.so
 SWIGFILES=$(SWIGSO) selinux.py 
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) 
-LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c)))
+
+LSEPOL=-lsepol
+DISABLE_AVC ?= n
+DISABLE_SEPOL ?= n
+DISABLE_BOOL ?= n
+
+ifeq ($(EMBEDDED),y)
+	override DISABLE_AVC=y
+	override DISABLE_BOOL=y
+	override DISABLE_SEPOL=y
+endif
+
+SRCS=$(filter-out $(SWIGCOUT),$(wildcard *.c))
+ifeq ($(DISABLE_AVC),y)
+	UNUSED_SRCS=avc.c avc_internal.c avc_sidtab.c
+	SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
+endif
+ifeq ($(DISABLE_BOOL),y)
+	UNUSED_SRCS+=booleans.c
+	SRCS= $(filter-out $(UNUSED_SRCS), $(filter-out $(SWIGCOUT),$(wildcard *.c)))
+endif
+
+OBJS= $(patsubst %.c,%.o,$(SRCS))
+LOBJS= $(patsubst %.c,%.lo,$(SRCS))
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+ifeq ($(DISABLE_SEPOL),y)
+	override CFLAGS += -DDISABLE_SEPOL
+	override SEPOL=
+endif
+
 RANLIB=ranlib
 
 ARCH := $(patsubst i%86,i386,$(shell uname -m))
@@ -48,7 +75,7 @@
 	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -L$(LIBDIR) -Wl,-soname,$@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
+	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl $(LSEPOL) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
 	ln -sf $@ $(TARGET) 
 
 %.o:  %.c policy.h
Index: libselinux/src/load_policy.c
===================================================================
--- libselinux/src/load_policy.c	(revision 2429)
+++ libselinux/src/load_policy.c	(working copy)
@@ -15,6 +15,21 @@
 #include "policy.h"
 #include <limits.h>
 
+#ifdef DISABLE_SEPOL
+#include <sepol/policydb/policydb.h>
+/* selinux_mkload_policy needs them 
+   even when sepol is disabled. */
+int sepol_policy_kern_vers_min(void)
+{
+	return POLICYDB_VERSION_MIN;
+}
+
+int sepol_policy_kern_vers_max(void)
+{
+	return POLICYDB_VERSION_MAX;
+}
+#endif
+
 int security_load_policy(void *data, size_t len)
 {
 	char path[PATH_MAX];
@@ -48,8 +63,10 @@
 	size_t size;
 	void *map, *data;
 	int fd, rc = -1;
+#ifndef DISABLE_SEPOL
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
+#endif
 
       search:
 	snprintf(path, sizeof(path), "%s.%d",
@@ -74,6 +91,12 @@
 		goto close;
 
 	if (vers > kernvers) {
+#ifdef DISABLE_SEPOL
+		/* Automatic downgrade of policy format is not supported when sepol is not used*/
+		vers--;
+		close(fd);
+		goto search;
+#else
 		/* Need to downgrade to kernel-supported version. */
 		if (sepol_policy_file_create(&pf))
 			goto unmap;
@@ -99,6 +122,7 @@
 		}
 		sepol_policy_file_free(pf);
 		sepol_policydb_free(policydb);
+#endif
 	}
 
 	rc = security_load_policy(data, size);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
