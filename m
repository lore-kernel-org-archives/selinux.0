From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Enable building CIL in the host libsepol.
Date: Tue,  3 Feb 2015 11:19:37 -0500
Message-Id: <1422980377-22013-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Enable building CIL as part of the host libsepol.
This will allow using it for host-side policy tools.
Omit it from the device libsepol used for the CTS for now,
unless/until such a time as we find it necessary there.

Also build secilc, the CIL compiler.

Change-Id: I2f04a720d9143a9c84fbab211511f76d82581b0b
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/Android.mk | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/libsepol/Android.mk b/libsepol/Android.mk
index 9bbcee1..ab4bcd1 100644
--- a/libsepol/Android.mk
+++ b/libsepol/Android.mk
@@ -40,6 +40,27 @@ common_src_files := \
 	src/util.c \
 	src/write.c
 
+cil_src_files := \
+	cil/src/cil_binary.c \
+	cil/src/cil_build_ast.c \
+	cil/src/cil.c \
+	cil/src/cil_copy_ast.c \
+	cil/src/cil_fqn.c \
+	cil/src/cil_lexer.l \
+	cil/src/cil_list.c \
+	cil/src/cil_log.c \
+	cil/src/cil_mem.c \
+	cil/src/cil_parser.c \
+	cil/src/cil_policy.c \
+	cil/src/cil_post.c \
+	cil/src/cil_reset_ast.c \
+	cil/src/cil_resolve_ast.c \
+	cil/src/cil_stack.c \
+	cil/src/cil_strpool.c \
+	cil/src/cil_symtab.c \
+	cil/src/cil_tree.c \
+	cil/src/cil_verify.c
+
 common_cflags := \
 	-Wall -W -Wundef \
 	-Wshadow -Wmissing-noreturn \
@@ -51,7 +72,15 @@ endif
 
 common_includes := \
 	$(LOCAL_PATH)/include/ \
-	$(LOCAL_PATH)/src/
+	$(LOCAL_PATH)/src/ \
+	$(LOCAL_PATH)/cil/include/ \
+	$(LOCAL_PATH)/cil/src/ \
+
+##
+# "-x c" forces the lex/yacc files to be compiled as c the build system
+# otherwise forces them to be c++. Need to also add an explicit -std because the
+# build system will soon default C++ to -std=c++11.
+yacc_flags := -x c -std=gnu89
 
 ##
 # libsepol.so
@@ -61,8 +90,8 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files)
+LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
 LOCAL_MODULE_CLASS := SHARED_LIBRARIES
 
 include $(BUILD_HOST_SHARED_LIBRARY)
@@ -75,8 +104,8 @@ include $(CLEAR_VARS)
 LOCAL_MODULE := libsepol
 LOCAL_MODULE_TAGS := optional
 LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files)
+LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
+LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
 LOCAL_MODULE_CLASS := STATIC_LIBRARIES
 
 include $(BUILD_HOST_STATIC_LIBRARY)
@@ -106,3 +135,18 @@ LOCAL_SRC_FILES := $(common_src_files)
 LOCAL_MODULE_CLASS := STATIC_LIBRARIES
 
 include $(BUILD_STATIC_LIBRARY)
+
+##
+# secilc
+#
+include $(CLEAR_VARS)
+
+LOCAL_MODULE := secilc
+LOCAL_MODULE_TAGS := optional
+LOCAL_C_INCLUDES := $(common_includes)
+LOCAL_CFLAGS := $(common_cflags)
+LOCAL_SRC_FILES := cil/secilc.c
+LOCAL_STATIC_LIBRARIES := libsepol
+LOCAL_MODULE_CLASS := EXECUTABLES
+
+include $(BUILD_HOST_EXECUTABLE)
-- 
1.9.3
