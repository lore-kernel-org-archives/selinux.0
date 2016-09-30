Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8U3JjfU025896
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 23:19:46 -0400
Received: by mail-ua0-f181.google.com with SMTP id l16so64716171uaa.1
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 20:19:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1475205460-146158-1-git-send-email-bowgotsai@google.com>
References: <1475205460-146158-1-git-send-email-bowgotsai@google.com>
From: Bowgo Tsai <bowgotsai@google.com>
Date: Fri, 30 Sep 2016 11:19:03 +0800
Message-ID: <CAMFYTWfNnr4J3YdypPTpJ8-Ux5beAtdjR7stu7BjDxwGXzMGYA@mail.gmail.com>
Subject: Re: [PATCH] Remove Android.mk files and only keep them in Android tree
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>, Daniel Cashman <dcashman@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=94eb2c1b074e6fd90a053db10eb0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c1b074e6fd90a053db10eb0
Content-Type: text/plain; charset=UTF-8

On Fri, Sep 30, 2016 at 11:17 AM, Bowgo Tsai <bowgotsai@google.com> wrote:

> From: bowgotsai <bowgotsai@google.com>
>
> The corresponding repository in Android tree:
>   https://android.googlesource.com/platform/external/selinux/
> ---
>  Android.mk             |   2 -
>  checkpolicy/Android.mk |  73 --------------------------
>  libsepol/Android.mk    | 138 ------------------------------
> -------------------
>  secilc/Android.mk      |  26 ----------
>  4 files changed, 239 deletions(-)
>  delete mode 100644 Android.mk
>  delete mode 100644 checkpolicy/Android.mk
>  delete mode 100644 libsepol/Android.mk
>  delete mode 100644 secilc/Android.mk
>
> diff --git a/Android.mk b/Android.mk
> deleted file mode 100644
> index 02f35a9..0000000
> --- a/Android.mk
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# This empty Android.mk file will prevent the build system
> -# from building anything below this point.
> diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> deleted file mode 100644
> index 3b7ff8a..0000000
> --- a/checkpolicy/Android.mk
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -LOCAL_PATH:= $(call my-dir)
> -
> -common_src_files := \
> -       policy_parse.y \
> -       policy_scan.l \
> -       queue.c \
> -       module_compiler.c \
> -       parse_util.c \
> -       policy_define.c
> -
> -common_cflags := \
> -       -Wall -Wshadow -O2 \
> -       -pipe -fno-strict-aliasing \
> -
> -common_includes := \
> -       $(LOCAL_PATH)/ \
> -       $(LOCAL_PATH)/../libsepol/include/ \
> -       $(LOCAL_PATH)/../libsepol/src/ \
> -
> -##
> -# "-x c" forces the lex/yacc files to be compiled as c the build system
> -# otherwise forces them to be c++. Need to also add an explicit -std
> because the
> -# build system will soon default C++ to -std=c++11.
> -yacc_flags := -x c -std=gnu89
> -
> -
> -##
> -# checkpolicy
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := checkpolicy
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> -LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
> -LOCAL_STATIC_LIBRARIES := libsepol
> -LOCAL_YACCFLAGS := -v
> -LOCAL_MODULE_CLASS := EXECUTABLES
> -
> -include $(BUILD_HOST_EXECUTABLE)
> -
> -
> -##
> -# checkmodule
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := checkmodule
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> -LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
> -LOCAL_STATIC_LIBRARIES := libsepol
> -LOCAL_YACCFLAGS := -v
> -LOCAL_MODULE_CLASS := EXECUTABLES
> -
> -include $(BUILD_HOST_EXECUTABLE)
> -
> -##
> -# dispol
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := dispol
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(common_cflags)
> -LOCAL_SRC_FILES := test/dispol.c
> -LOCAL_STATIC_LIBRARIES := libsepol
> -LOCAL_MODULE_CLASS := EXECUTABLES
> -
> -include $(BUILD_HOST_EXECUTABLE)
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> deleted file mode 100644
> index 6d89f17..0000000
> --- a/libsepol/Android.mk
> +++ /dev/null
> @@ -1,138 +0,0 @@
> -LOCAL_PATH:= $(call my-dir)
> -
> -common_src_files := \
> -       src/assertion.c \
> -       src/avrule_block.c \
> -       src/avtab.c \
> -       src/boolean_record.c \
> -       src/booleans.c \
> -       src/conditional.c \
> -       src/constraint.c \
> -       src/context.c \
> -       src/context_record.c \
> -       src/debug.c \
> -       src/ebitmap.c \
> -       src/expand.c \
> -       src/genbools.c \
> -       src/genusers.c \
> -       src/handle.c \
> -       src/hashtab.c \
> -       src/hierarchy.c \
> -       src/iface_record.c \
> -       src/interfaces.c \
> -       src/link.c \
> -       src/mls.c \
> -       src/module.c \
> -       src/module_to_cil.c \
> -       src/node_record.c \
> -       src/nodes.c \
> -       src/polcaps.c \
> -       src/policydb.c \
> -       src/policydb_convert.c \
> -       src/policydb_public.c \
> -       src/port_record.c \
> -       src/ports.c \
> -       src/roles.c \
> -       src/services.c \
> -       src/sidtab.c \
> -       src/symtab.c \
> -       src/user_record.c \
> -       src/users.c \
> -       src/util.c \
> -       src/write.c
> -
> -cil_src_files := \
> -       cil/src/cil_binary.c \
> -       cil/src/cil_build_ast.c \
> -       cil/src/cil.c \
> -       cil/src/cil_copy_ast.c \
> -       cil/src/cil_find.c \
> -       cil/src/cil_fqn.c \
> -       cil/src/cil_lexer.l \
> -       cil/src/cil_list.c \
> -       cil/src/cil_log.c \
> -       cil/src/cil_mem.c \
> -       cil/src/cil_parser.c \
> -       cil/src/cil_policy.c \
> -       cil/src/cil_post.c \
> -       cil/src/cil_reset_ast.c \
> -       cil/src/cil_resolve_ast.c \
> -       cil/src/cil_stack.c \
> -       cil/src/cil_strpool.c \
> -       cil/src/cil_symtab.c \
> -       cil/src/cil_tree.c \
> -       cil/src/cil_verify.c
> -
> -common_cflags := \
> -       -D_GNU_SOURCE \
> -       -Wall -W -Wundef \
> -       -Wshadow -Wmissing-noreturn \
> -       -Wmissing-format-attribute
> -
> -common_includes := \
> -       $(LOCAL_PATH)/include/ \
> -       $(LOCAL_PATH)/src/ \
> -       $(LOCAL_PATH)/cil/include/ \
> -       $(LOCAL_PATH)/cil/src/ \
> -
> -##
> -# "-x c" forces the lex/yacc files to be compiled as c the build system
> -# otherwise forces them to be c++. Need to also add an explicit -std
> because the
> -# build system will soon default C++ to -std=c++11.
> -yacc_flags := -x c -std=gnu89
> -
> -##
> -# libsepol.so
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := libsepol
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_COPY_HEADERS_TO := sepol
> -LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h
> cil/include/cil/cil.h
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> -LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> -
> -include $(BUILD_HOST_SHARED_LIBRARY)
> -
> -##
> -# libsepol.a
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := libsepol
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> -LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> -
> -include $(BUILD_HOST_STATIC_LIBRARY)
> -
> -##
> -# chkcon
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := chkcon
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(common_cflags)
> -LOCAL_SRC_FILES := utils/chkcon.c
> -LOCAL_SHARED_LIBRARIES := libsepol
> -LOCAL_MODULE_CLASS := EXECUTABLES
> -
> -include $(BUILD_HOST_EXECUTABLE)
> -
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := libsepol
> -LOCAL_MODULE_TAGES := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(common_cflags)
> -LOCAL_SRC_FILES := $(common_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> -
> -include $(BUILD_STATIC_LIBRARY)
> diff --git a/secilc/Android.mk b/secilc/Android.mk
> deleted file mode 100644
> index 6c7b9d3..0000000
> --- a/secilc/Android.mk
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -LOCAL_PATH:= $(call my-dir)
> -
> -common_src_files := secilc.c
> -
> -common_cflags := \
> -       -Wall -Wshadow -O2 \
> -       -pipe -fno-strict-aliasing \
> -
> -common_includes := \
> -       $(LOCAL_PATH)/../libsepol/cil/include/ \
> -       $(LOCAL_PATH)/../libsepol/include/ \
> -
> -##
> -# secilc
> -#
> -include $(CLEAR_VARS)
> -
> -LOCAL_MODULE := secilc
> -LOCAL_MODULE_TAGS := optional
> -LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(common_cflags)
> -LOCAL_SRC_FILES := secilc.c
> -LOCAL_SHARED_LIBRARIES := libsepol
> -LOCAL_MODULE_CLASS := EXECUTABLES
> -
> -include $(BUILD_HOST_EXECUTABLE)
> --
> 2.8.0.rc3.226.g39d4020
>
>


-- 

Bowgo Tsai |  Engineer |  bowgotsai@google.com |  +886 (2) 8729-6364
<%2B886287296364>

--94eb2c1b074e6fd90a053db10eb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br></div><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Fri, Sep 30, 2016 at 11:17 AM, Bowgo Tsai <span dir=3D"ltr">&l=
t;<a href=3D"mailto:bowgotsai@google.com" target=3D"_blank">bowgotsai@googl=
e.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: bowgots=
ai &lt;<a href=3D"mailto:bowgotsai@google.com">bowgotsai@google.com</a>&gt;=
<br>
<br>
The corresponding repository in Android tree:<br>
=C2=A0 <a href=3D"https://android.googlesource.com/platform/external/selinu=
x/" rel=3D"noreferrer" target=3D"_blank">https://android.googlesource.<wbr>=
com/platform/external/selinux/</a><br>
---<br>
=C2=A0Android.mk=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A02 -<br>
=C2=A0checkpolicy/Android.mk |=C2=A0 73 --------------------------<br>
=C2=A0libsepol/Android.mk=C2=A0 =C2=A0 | 138 ------------------------------=
<wbr>-------------------<br>
=C2=A0secilc/Android.mk=C2=A0 =C2=A0 =C2=A0 |=C2=A0 26 ----------<br>
=C2=A04 files changed, 239 deletions(-)<br>
=C2=A0delete mode 100644 Android.mk<br>
=C2=A0delete mode 100644 checkpolicy/Android.mk<br>
=C2=A0delete mode 100644 libsepol/Android.mk<br>
=C2=A0delete mode 100644 secilc/Android.mk<br>
<br>
diff --git a/Android.mk b/Android.mk<br>
deleted file mode 100644<br>
index 02f35a9..0000000<br>
--- a/Android.mk<br>
+++ /dev/null<br>
@@ -1,2 +0,0 @@<br>
-# This empty Android.mk file will prevent the build system<br>
-# from building anything below this point.<br>
diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk<br>
deleted file mode 100644<br>
index 3b7ff8a..0000000<br>
--- a/checkpolicy/Android.mk<br>
+++ /dev/null<br>
@@ -1,73 +0,0 @@<br>
-LOCAL_PATH:=3D $(call my-dir)<br>
-<br>
-common_src_files :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0policy_parse.y \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0policy_scan.l \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0queue.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0module_compiler.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0parse_util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0policy_define.c<br>
-<br>
-common_cflags :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wall -Wshadow -O2 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-pipe -fno-strict-aliasing \<br>
-<br>
-common_includes :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/<wbr>include/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/src/ \<br>
-<br>
-##<br>
-# &quot;-x c&quot; forces the lex/yacc files to be compiled as c the build=
 system<br>
-# otherwise forces them to be c++. Need to also add an explicit -std becau=
se the<br>
-# build system will soon default C++ to -std=3Dc++11.<br>
-yacc_flags :=3D -x c -std=3Dgnu89<br>
-<br>
-<br>
-##<br>
-# checkpolicy<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D checkpolicy<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D $(common_src_files) checkpolicy.c<br>
-LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
-LOCAL_YACCFLAGS :=3D -v<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
-<br>
-include $(BUILD_HOST_EXECUTABLE)<br>
-<br>
-<br>
-##<br>
-# checkmodule<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D checkmodule<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D $(common_src_files) checkmodule.c<br>
-LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
-LOCAL_YACCFLAGS :=3D -v<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
-<br>
-include $(BUILD_HOST_EXECUTABLE)<br>
-<br>
-##<br>
-# dispol<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D dispol<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D test/dispol.c<br>
-LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
-<br>
-include $(BUILD_HOST_EXECUTABLE)<br>
diff --git a/libsepol/Android.mk b/libsepol/Android.mk<br>
deleted file mode 100644<br>
index 6d89f17..0000000<br>
--- a/libsepol/Android.mk<br>
+++ /dev/null<br>
@@ -1,138 +0,0 @@<br>
-LOCAL_PATH:=3D $(call my-dir)<br>
-<br>
-common_src_files :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/assertion.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/avrule_block.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/avtab.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/boolean_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/booleans.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/conditional.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/constraint.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/context.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/context_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/debug.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/ebitmap.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/expand.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/genbools.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/genusers.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/handle.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/hashtab.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/hierarchy.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/iface_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/interfaces.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/link.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/mls.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/module.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/module_to_cil.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/node_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/nodes.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/polcaps.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/policydb.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/policydb_convert.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/policydb_public.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/port_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/ports.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/roles.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/services.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/sidtab.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/symtab.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/user_record.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/users.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/util.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0src/write.c<br>
-<br>
-cil_src_files :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_binary.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_build_ast.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_copy_ast.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_find.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_fqn.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_lexer.l \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_list.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_log.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_mem.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_parser.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_policy.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_post.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_reset_ast.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_resolve_ast.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_stack.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_strpool.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_symtab.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_tree.c \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0cil/src/cil_verify.c<br>
-<br>
-common_cflags :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-D_GNU_SOURCE \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wall -W -Wundef \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wshadow -Wmissing-noreturn \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wmissing-format-attribute<br>
-<br>
-common_includes :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/include/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/src/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/cil/include/ \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/cil/src/ \<br>
-<br>
-##<br>
-# &quot;-x c&quot; forces the lex/yacc files to be compiled as c the build=
 system<br>
-# otherwise forces them to be c++. Need to also add an explicit -std becau=
se the<br>
-# build system will soon default C++ to -std=3Dc++11.<br>
-yacc_flags :=3D -x c -std=3Dgnu89<br>
-<br>
-##<br>
-# libsepol.so<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D libsepol<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_COPY_HEADERS_TO :=3D sepol<br>
-LOCAL_COPY_HEADERS :=3D include/sepol/handle.h include/sepol/policydb.h ci=
l/include/cil/cil.h<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
-LOCAL_MODULE_CLASS :=3D SHARED_LIBRARIES<br>
-<br>
-include $(BUILD_HOST_SHARED_LIBRARY)<br>
-<br>
-##<br>
-# libsepol.a<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D libsepol<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
-LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
-<br>
-include $(BUILD_HOST_STATIC_LIBRARY)<br>
-<br>
-##<br>
-# chkcon<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D chkcon<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D utils/chkcon.c<br>
-LOCAL_SHARED_LIBRARIES :=3D libsepol<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
-<br>
-include $(BUILD_HOST_EXECUTABLE)<br>
-<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D libsepol<br>
-LOCAL_MODULE_TAGES :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D $(common_src_files)<br>
-LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
-<br>
-include $(BUILD_STATIC_LIBRARY)<br>
diff --git a/secilc/Android.mk b/secilc/Android.mk<br>
deleted file mode 100644<br>
index 6c7b9d3..0000000<br>
--- a/secilc/Android.mk<br>
+++ /dev/null<br>
@@ -1,26 +0,0 @@<br>
-LOCAL_PATH:=3D $(call my-dir)<br>
-<br>
-common_src_files :=3D secilc.c<br>
-<br>
-common_cflags :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wall -Wshadow -O2 \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0-pipe -fno-strict-aliasing \<br>
-<br>
-common_includes :=3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/cil/<wbr>include/ \<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/<wbr>include/ \<br>
-<br>
-##<br>
-# secilc<br>
-#<br>
-include $(CLEAR_VARS)<br>
-<br>
-LOCAL_MODULE :=3D secilc<br>
-LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(common_cflags)<br>
-LOCAL_SRC_FILES :=3D secilc.c<br>
-LOCAL_SHARED_LIBRARIES :=3D libsepol<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
-<br>
-include $(BUILD_HOST_EXECUTABLE)<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.0.rc3.226.g39d4020<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"=
><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"l=
tr"><div dir=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=
=3D"font-family:Times"><tbody><tr style=3D"color:rgb(85,85,85);font-family:=
sans-serif;font-size:small"><td nowrap style=3D"font-family:arial;border-to=
p-style:solid;border-top-color:rgb(213,15,37);border-top-width:2px">Bowgo T=
sai |</td><td nowrap style=3D"font-family:arial;border-top-style:solid;bord=
er-top-color:rgb(51,105,232);border-top-width:2px">=C2=A0Engineer |</td><td=
 nowrap style=3D"font-family:arial;border-top-style:solid;border-top-color:=
rgb(0,153,57);border-top-width:2px">=C2=A0<a href=3D"mailto:bowgotsai@googl=
e.com" target=3D"_blank">bowgotsai@google.com</a>=C2=A0|</td><td nowrap sty=
le=3D"font-family:arial;border-top-style:solid;border-top-color:rgb(238,178=
,17);border-top-width:2px">=C2=A0<a href=3D"tel:%2B886287296364" value=3D"+=
886287296364" style=3D"color:rgb(17,85,204);font-family:arial,sans-serif;fo=
nt-size:12.8000001907349px;white-space:normal" target=3D"_blank">+886 (2) 8=
729-6364</a></td></tr></tbody></table><br><div><font face=3D"Times" size=3D=
"3" style=3D"color:rgb(136,136,136);background-color:rgb(255,255,255)"></fo=
nt></div></div></div></div></div></div></div></div></div></div></div></div>=
</div></div></div></div>
</div>

--94eb2c1b074e6fd90a053db10eb0--
