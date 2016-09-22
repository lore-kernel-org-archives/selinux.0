Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MJnO8w014524
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 15:49:24 -0400
Received: by mail-pa0-f41.google.com with SMTP id oz2so32230268pac.2
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 12:49:19 -0700 (PDT)
From: Bowgo Tsai <bowgotsai@google.com>
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>
Subject: [PATCH 2/2] Add libsepol and secil host and device targets
Date: Fri, 23 Sep 2016 03:49:04 +0800
Message-Id: <1474573744-124781-1-git-send-email-bowgotsai@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: bowgotsai <bowgotsai@google.com>

Also clean up some LOCAL_C_INCLUDES as it should be included
by LOCAL_EXPORT_C_INCLUDE_DIRS from libsepol.

BUG=31366888

Change-Id: I0e21279097f0635761672b838ad26861fc49e9ea
---
 checkpolicy/Android.mk |  8 --------
 libsepol/Android.mk    | 15 +++++++++++----
 secilc/Android.mk      | 21 +++++++++++++++------
 secilc/secilc.c        |  2 +-
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
index ee2f158..53409f8 100644
--- a/checkpolicy/Android.mk
+++ b/checkpolicy/Android.mk
@@ -12,11 +12,6 @@ common_cflags := \
 	-Wall -Wshadow -O2 \
 	-pipe -fno-strict-aliasing \
 
-common_includes := \
-	$(LOCAL_PATH)/ \
-	$(LOCAL_PATH)/../libsepol/include/ \
-	$(LOCAL_PATH)/../libsepol/src/ \
-
 ##
 # checkpolicy
 #
@@ -24,7 +19,6 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := checkpolicy
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
 LOCAL_STATIC_LIBRARIES := libsepol
@@ -41,7 +35,6 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := checkmodule
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
 LOCAL_STATIC_LIBRARIES := libsepol
@@ -57,7 +50,6 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := dispol
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := test/dispol.c
 LOCAL_STATIC_LIBRARIES := libsepol
diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index e9cfeef..637669a 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -93,7 +93,9 @@ LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_CPPFLAGS := $(yacc_flags)
 LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
+LOCAL_EXPORT_C_INCLUDE_DIRS := \
+    $(LOCAL_PATH)/include \
+    $(LOCAL_PATH)/cil/include
 
 include $(BUILD_HOST_SHARED_LIBRARY)
 
@@ -108,7 +110,9 @@ LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_CPPFLAGS := $(yacc_flags)
 LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
+LOCAL_EXPORT_C_INCLUDE_DIRS := \
+    $(LOCAL_PATH)/include \
+    $(LOCAL_PATH)/cil/include
 
 include $(BUILD_HOST_STATIC_LIBRARY)
 
@@ -132,7 +136,10 @@ LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGES := optional
 LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files)
-LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
+LOCAL_CPPFLAGS := $(yacc_flags)
+LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
+LOCAL_EXPORT_C_INCLUDE_DIRS := \
+    $(LOCAL_PATH)/include \
+    $(LOCAL_PATH)/cil/include
 
 include $(BUILD_STATIC_LIBRARY)
diff --git a/secilc/Android.mk b/secilc/Android.mk
index 6c7b9d3..6d0f702 100644
--- a/secilc/Android.mk
+++ b/secilc/Android.mk
@@ -6,21 +6,30 @@ common_cflags := \
 	-Wall -Wshadow -O2 \
 	-pipe -fno-strict-aliasing \
 
-common_includes := \
-	$(LOCAL_PATH)/../libsepol/cil/include/ \
-	$(LOCAL_PATH)/../libsepol/include/ \
-
 ##
-# secilc
+# secilc on the host.
 #
 include $(CLEAR_VARS)
 
 LOCAL_MODULE := secilc
 LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := secilc.c
 LOCAL_SHARED_LIBRARIES := libsepol
 LOCAL_MODULE_CLASS := EXECUTABLES
 
 include $(BUILD_HOST_EXECUTABLE)
+
+##
+# secilc on the target.
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := secilc
+LOCAL_MODULE_TAGS := optional
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := secilc.c
+LOCAL_STATIC_LIBRARIES := libsepol
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_EXECUTABLE)
diff --git a/secilc/secilc.c b/secilc/secilc.c
index e98abe2..dad1e90 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -35,7 +35,7 @@
 #include <sys/stat.h>
 
 #ifdef ANDROID
-#include <sepol/cil.h>
+#include <cil/cil.h>
 #else
 #include <sepol/cil/cil.h>
 #endif
-- 
2.8.0.rc3.226.g39d4020
