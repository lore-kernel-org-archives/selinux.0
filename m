Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8U3Hs3P025723
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 23:17:54 -0400
Received: by mail-pa0-f54.google.com with SMTP id dw4so20099272pac.1
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 20:17:47 -0700 (PDT)
From: Bowgo Tsai <bowgotsai@google.com>
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>
Subject: [PATCH] Remove Android.mk files and only keep them in Android tree
Date: Fri, 30 Sep 2016 11:17:40 +0800
Message-Id: <1475205460-146158-1-git-send-email-bowgotsai@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: bowgotsai <bowgotsai@google.com>

The corresponding repository in Android tree:
  https://android.googlesource.com/platform/external/selinux/
---
 Android.mk             |   2 -
 checkpolicy/Android.mk |  73 --------------------------
 libsepol/Android.mk    | 138 -------------------------------------------------
 secilc/Android.mk      |  26 ----------
 4 files changed, 239 deletions(-)
 delete mode 100644 Android.mk
 delete mode 100644 checkpolicy/Android.mk
 delete mode 100644 libsepol/Android.mk
 delete mode 100644 secilc/Android.mk

diff --git a/Android.mk b/Android.mk
deleted file mode 100644
index 02f35a9..0000000
--- a/Android.mk
+++ /dev/null
@@ -1,2 +0,0 @@
-# This empty Android.mk file will prevent the build system
-# from building anything below this point.
diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
deleted file mode 100644
index 3b7ff8a..0000000
--- a/checkpolicy/Android.mk
+++ /dev/null
@@ -1,73 +0,0 @@
-LOCAL_PATH:= $(call my-dir)
-
-common_src_files := \
-	policy_parse.y \
-	policy_scan.l \
-	queue.c \
-	module_compiler.c \
-	parse_util.c \
-	policy_define.c
-
-common_cflags := \
-	-Wall -Wshadow -O2 \
-	-pipe -fno-strict-aliasing \
-
-common_includes := \
-	$(LOCAL_PATH)/ \
-	$(LOCAL_PATH)/../libsepol/include/ \
-	$(LOCAL_PATH)/../libsepol/src/ \
-
-##
-# "-x c" forces the lex/yacc files to be compiled as c the build system
-# otherwise forces them to be c++. Need to also add an explicit -std because the
-# build system will soon default C++ to -std=c++11.
-yacc_flags := -x c -std=gnu89
-
-
-##
-# checkpolicy
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := checkpolicy
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
-LOCAL_STATIC_LIBRARIES := libsepol
-LOCAL_YACCFLAGS := -v
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
-
-
-##
-# checkmodule
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := checkmodule
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
-LOCAL_STATIC_LIBRARIES := libsepol
-LOCAL_YACCFLAGS := -v
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
-
-##
-# dispol
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := dispol
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes)
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := test/dispol.c
-LOCAL_STATIC_LIBRARIES := libsepol
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
diff --git a/libsepol/Android.mk b/libsepol/Android.mk
deleted file mode 100644
index 6d89f17..0000000
--- a/libsepol/Android.mk
+++ /dev/null
@@ -1,138 +0,0 @@
-LOCAL_PATH:= $(call my-dir)
-
-common_src_files := \
-	src/assertion.c \
-	src/avrule_block.c \
-	src/avtab.c \
-	src/boolean_record.c \
-	src/booleans.c \
-	src/conditional.c \
-	src/constraint.c \
-	src/context.c \
-	src/context_record.c \
-	src/debug.c \
-	src/ebitmap.c \
-	src/expand.c \
-	src/genbools.c \
-	src/genusers.c \
-	src/handle.c \
-	src/hashtab.c \
-	src/hierarchy.c \
-	src/iface_record.c \
-	src/interfaces.c \
-	src/link.c \
-	src/mls.c \
-	src/module.c \
-	src/module_to_cil.c \
-	src/node_record.c \
-	src/nodes.c \
-	src/polcaps.c \
-	src/policydb.c \
-	src/policydb_convert.c \
-	src/policydb_public.c \
-	src/port_record.c \
-	src/ports.c \
-	src/roles.c \
-	src/services.c \
-	src/sidtab.c \
-	src/symtab.c \
-	src/user_record.c \
-	src/users.c \
-	src/util.c \
-	src/write.c
-
-cil_src_files := \
-	cil/src/cil_binary.c \
-	cil/src/cil_build_ast.c \
-	cil/src/cil.c \
-	cil/src/cil_copy_ast.c \
-	cil/src/cil_find.c \
-	cil/src/cil_fqn.c \
-	cil/src/cil_lexer.l \
-	cil/src/cil_list.c \
-	cil/src/cil_log.c \
-	cil/src/cil_mem.c \
-	cil/src/cil_parser.c \
-	cil/src/cil_policy.c \
-	cil/src/cil_post.c \
-	cil/src/cil_reset_ast.c \
-	cil/src/cil_resolve_ast.c \
-	cil/src/cil_stack.c \
-	cil/src/cil_strpool.c \
-	cil/src/cil_symtab.c \
-	cil/src/cil_tree.c \
-	cil/src/cil_verify.c
-
-common_cflags := \
-	-D_GNU_SOURCE \
-	-Wall -W -Wundef \
-	-Wshadow -Wmissing-noreturn \
-	-Wmissing-format-attribute
-
-common_includes := \
-	$(LOCAL_PATH)/include/ \
-	$(LOCAL_PATH)/src/ \
-	$(LOCAL_PATH)/cil/include/ \
-	$(LOCAL_PATH)/cil/src/ \
-
-##
-# "-x c" forces the lex/yacc files to be compiled as c the build system
-# otherwise forces them to be c++. Need to also add an explicit -std because the
-# build system will soon default C++ to -std=c++11.
-yacc_flags := -x c -std=gnu89
-
-##
-# libsepol.so
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := libsepol
-LOCAL_MODULE_TAGS := optional
-LOCAL_COPY_HEADERS_TO := sepol
-LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h cil/include/cil/cil.h
-LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_MODULE_CLASS := SHARED_LIBRARIES
-
-include $(BUILD_HOST_SHARED_LIBRARY)
-
-##
-# libsepol.a
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := libsepol
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
-LOCAL_MODULE_CLASS := STATIC_LIBRARIES
-
-include $(BUILD_HOST_STATIC_LIBRARY)
-
-##
-# chkcon
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := chkcon
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes) 
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := utils/chkcon.c
-LOCAL_SHARED_LIBRARIES := libsepol
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
-
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := libsepol
-LOCAL_MODULE_TAGES := optional
-LOCAL_C_INCLUDES := $(common_includes)
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := $(common_src_files)
-LOCAL_MODULE_CLASS := STATIC_LIBRARIES
-
-include $(BUILD_STATIC_LIBRARY)
diff --git a/secilc/Android.mk b/secilc/Android.mk
deleted file mode 100644
index 6c7b9d3..0000000
--- a/secilc/Android.mk
+++ /dev/null
@@ -1,26 +0,0 @@
-LOCAL_PATH:= $(call my-dir)
-
-common_src_files := secilc.c
-
-common_cflags := \
-	-Wall -Wshadow -O2 \
-	-pipe -fno-strict-aliasing \
-
-common_includes := \
-	$(LOCAL_PATH)/../libsepol/cil/include/ \
-	$(LOCAL_PATH)/../libsepol/include/ \
-
-##
-# secilc
-#
-include $(CLEAR_VARS)
-
-LOCAL_MODULE := secilc
-LOCAL_MODULE_TAGS := optional
-LOCAL_C_INCLUDES := $(common_includes)
-LOCAL_CFLAGS := $(common_cflags)
-LOCAL_SRC_FILES := secilc.c
-LOCAL_SHARED_LIBRARIES := libsepol
-LOCAL_MODULE_CLASS := EXECUTABLES
-
-include $(BUILD_HOST_EXECUTABLE)
-- 
2.8.0.rc3.226.g39d4020
