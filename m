Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MJmDWh014410
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 15:48:14 -0400
Received: by mail-pa0-f43.google.com with SMTP id hm5so32269415pac.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 12:48:11 -0700 (PDT)
From: Bowgo Tsai <bowgotsai@google.com>
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>
Subject: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
Date: Fri, 23 Sep 2016 03:48:05 +0800
Message-Id: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: bowgotsai <bowgotsai@google.com>

---
 checkpolicy/Android.mk | 11 ++---------
 libsepol/Android.mk    | 16 ++++++++--------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
index 3b7ff8a..ee2f158 100644
--- a/checkpolicy/Android.mk
+++ b/checkpolicy/Android.mk
@@ -18,13 +18,6 @@ common_includes := \
 	$(LOCAL_PATH)/../libsepol/src/ \
 
 ##
-# "-x c" forces the lex/yacc files to be compiled as c the build system
-# otherwise forces them to be c++. Need to also add an explicit -std because the
-# build system will soon default C++ to -std=c++11.
-yacc_flags := -x c -std=gnu89
-
-
-##
 # checkpolicy
 #
 include $(CLEAR_VARS)
@@ -32,7 +25,7 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := checkpolicy
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
 LOCAL_STATIC_LIBRARIES := libsepol
 LOCAL_YACCFLAGS := -v
@@ -49,7 +42,7 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := checkmodule
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
 LOCAL_STATIC_LIBRARIES := libsepol
 LOCAL_YACCFLAGS := -v
diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index 6d89f17..e9cfeef 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -81,6 +81,7 @@ common_includes := \
 # build system will soon default C++ to -std=c++11.
 yacc_flags := -x c -std=gnu89
 
+
 ##
 # libsepol.so
 #
@@ -88,12 +89,11 @@ include $(CLEAR_VARS)
 
 LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGS := optional
-LOCAL_COPY_HEADERS_TO := sepol
-LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h cil/include/cil/cil.h
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_CPPFLAGS := $(yacc_flags)
 LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_MODULE_CLASS := SHARED_LIBRARIES
+LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
 
 include $(BUILD_HOST_SHARED_LIBRARY)
 
@@ -105,9 +105,10 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_CPPFLAGS := $(yacc_flags)
 LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_MODULE_CLASS := STATIC_LIBRARIES
+LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
 
 include $(BUILD_HOST_STATIC_LIBRARY)
 
@@ -122,7 +123,6 @@ LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := utils/chkcon.c
 LOCAL_SHARED_LIBRARIES := libsepol
-LOCAL_MODULE_CLASS := EXECUTABLES
 
 include $(BUILD_HOST_EXECUTABLE)
 
@@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES := optional
 LOCAL_C_INCLUDES := $(common_includes)
 LOCAL_CFLAGS := $(common_cflags)
 LOCAL_SRC_FILES := $(common_src_files)
-LOCAL_MODULE_CLASS := STATIC_LIBRARIES
+LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
 
 include $(BUILD_STATIC_LIBRARY)
-- 
2.8.0.rc3.226.g39d4020
