Received: from [144.51.25.131] (moss-pluto [144.51.25.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NF52w1021191
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 10:05:02 -0500
Subject: [PATCH libsepol] Android/MacOS X build support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 23 Feb 2012 10:05:01 -0500
Message-ID: <1330009501.27529.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Android/MacOS X build support for libsepol.
Create a Android.mk file for Android build integration.
Introduce DARWIN ifdefs for building on MacOS X.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---
 libsepol/Android.mk        |   97 ++++++++++++++++++++++++++++++++++++++++++++
 libsepol/src/genbools.c    |   18 ++++++++-
 libsepol/src/genusers.c    |   19 ++++++++-
 libsepol/src/node_record.c |    9 ++++-
 libsepol/src/private.h     |   12 +++++
 libsepol/utils/chkcon.c    |    2 +
 6 files changed, 153 insertions(+), 4 deletions(-)
 create mode 100644 libsepol/Android.mk

diff --git a/libsepol/Android.mk b/libsepol/Android.mk
new file mode 100644
index 0000000..e193765
--- /dev/null
+++ b/libsepol/Android.mk
@@ -0,0 +1,97 @@
+LOCAL_PATH:= $(call my-dir)
+
+common_src_files := \
+	src/assertion.c \
+	src/avrule_block.c \
+	src/avtab.c \
+	src/boolean_record.c \
+	src/booleans.c \
+	src/conditional.c \
+	src/constraint.c \
+	src/context.c \
+	src/context_record.c \
+	src/debug.c \
+	src/ebitmap.c \
+	src/expand.c \
+	src/genbools.c \
+	src/genusers.c \
+	src/handle.c \
+	src/hashtab.c \
+	src/hierarchy.c \
+	src/iface_record.c \
+	src/interfaces.c \
+	src/link.c \
+	src/mls.c \
+	src/module.c \
+	src/node_record.c \
+	src/nodes.c \
+	src/polcaps.c \
+	src/policydb.c \
+	src/policydb_convert.c \
+	src/policydb_public.c \
+	src/port_record.c \
+	src/ports.c \
+	src/roles.c \
+	src/services.c \
+	src/sidtab.c \
+	src/symtab.c \
+	src/user_record.c \
+	src/users.c \
+	src/util.c \
+	src/write.c
+
+common_cflags := \
+	-Wall -W -Wundef \
+	-Wshadow -Wmissing-noreturn \
+	-Wmissing-format-attribute
+
+ifeq ($(HOST_OS), darwin)
+common_cflags += -DDARWIN
+endif
+
+common_includes := \
+	$(LOCAL_PATH)/include/ \
+	$(LOCAL_PATH)/src/
+
+##
+# libsepol.so
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := libsepol
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes) 
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files)
+LOCAL_MODULE_CLASS := SHARED_LIBRARIES
+
+include $(BUILD_HOST_SHARED_LIBRARY)
+
+##
+# libsepol.a
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := libsepol
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes) 
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files)
+LOCAL_MODULE_CLASS := STATIC_LIBRARIES
+
+include $(BUILD_HOST_STATIC_LIBRARY)
+
+##
+# chkcon
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := chkcon
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes) 
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := utils/chkcon.c
+LOCAL_SHARED_LIBRARIES := libsepol
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_HOST_EXECUTABLE)
diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
index e353ef3..612ff9a 100644
--- a/libsepol/src/genbools.c
+++ b/libsepol/src/genbools.c
@@ -79,7 +79,16 @@ static int load_booleans(struct policydb *policydb, const char *path,
 	if (boolf == NULL)
 		goto localbool;
 
+#ifdef DARWIN
+        if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
+          ERR(NULL, "out of memory");
+	  return -1;
+	}
+
+        while(fgets(buffer, 255, boolf) != NULL) {
+#else
 	while (getline(&buffer, &size, boolf) > 0) {
+#endif
 		int ret = process_boolean(buffer, name, sizeof(name), &val);
 		if (ret == -1)
 			errors++;
@@ -101,7 +110,14 @@ static int load_booleans(struct policydb *policydb, const char *path,
 	snprintf(localbools, sizeof(localbools), "%s.local", path);
 	boolf = fopen(localbools, "r");
 	if (boolf != NULL) {
-		while (getline(&buffer, &size, boolf) > 0) {
+
+#ifdef DARWIN
+
+	  while(fgets(buffer, 255, boolf) != NULL) {
+#else
+
+	    while (getline(&buffer, &size, boolf) > 0) {
+#endif
 			int ret =
 			    process_boolean(buffer, name, sizeof(name), &val);
 			if (ret == -1)
diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 44f94e9..37528e2 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -1,11 +1,16 @@
 #include <stdio.h>
-#include <stdio_ext.h>
+
 #include <stdlib.h>
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
 
 #include <sepol/policydb/policydb.h>
+
+#ifndef DARWIN
+#include <stdio_ext.h>
+#endif
+
 #include <stdarg.h>
 
 #include "debug.h"
@@ -41,9 +46,19 @@ static int load_users(struct policydb *policydb, const char *path)
 	fp = fopen(path, "r");
 	if (fp == NULL)
 		return -1;
-	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 
+#ifdef DARWIN
+	if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
+	  ERR(NULL, "out of memory");
+	  return -1;
+	}
+
+	while(fgets(buffer, 255, fp) != NULL) {
+#else
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	while ((nread = getline(&buffer, &len, fp)) > 0) {
+#endif
+
 		lineno++;
 		if (buffer[nread - 1] == '\n')
 			buffer[nread - 1] = 0;
diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
index b1bd370..bd48ba0 100644
--- a/libsepol/src/node_record.c
+++ b/libsepol/src/node_record.c
@@ -70,7 +70,11 @@ static int node_parse_addr(sepol_handle_t * handle,
 				return STATUS_ERR;
 			}
 
+#ifdef DARWIN
+			memcpy(addr_bytes, in_addr.s6_addr, 16);
+#else
 			memcpy(addr_bytes, in_addr.s6_addr32, 16);
+#endif
 			break;
 		}
 	default:
@@ -158,8 +162,11 @@ static int node_expand_addr(sepol_handle_t * handle,
 		{
 			struct in6_addr addr;
 			memset(&addr, 0, sizeof(struct in6_addr));
+#ifdef DARWIN
+			memcpy(&addr.s6_addr[0], addr_bytes, 16);
+#else
 			memcpy(&addr.s6_addr32[0], addr_bytes, 16);
-
+#endif
 			if (inet_ntop(AF_INET6, &addr, addr_str,
 				      INET6_ADDRSTRLEN) == NULL) {
 
diff --git a/libsepol/src/private.h b/libsepol/src/private.h
index 24a544d..8a6d4bb 100644
--- a/libsepol/src/private.h
+++ b/libsepol/src/private.h
@@ -4,11 +4,23 @@
 
 #include <sepol/policydb/policydb.h>
 
+
+#ifdef DARWIN
+#include <sys/types.h>
+#include <machine/endian.h>
+#else
 #include <byteswap.h>
 #include <endian.h>
+#endif
+
 #include <errno.h>
 #include <dso.h>
 
+#ifdef DARWIN
+#define __BYTE_ORDER  BYTE_ORDER
+#define __LITTLE_ENDIAN  LITTLE_ENDIAN
+#endif
+
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define cpu_to_le16(x) (x)
 #define le16_to_cpu(x) (x)
diff --git a/libsepol/utils/chkcon.c b/libsepol/utils/chkcon.c
index 4c23d4c..baa5117 100644
--- a/libsepol/utils/chkcon.c
+++ b/libsepol/utils/chkcon.c
@@ -6,6 +6,8 @@
 #include <string.h>
 #include <errno.h>
 
+void usage(char*) __attribute__((noreturn));
+
 void usage(char *progname)
 {
 	printf("usage:  %s policy context\n", progname);
-- 
1.7.4.4


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
