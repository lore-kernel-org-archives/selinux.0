Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8MNHS05003316
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 19:17:32 -0400
Received: by mail-ua0-f179.google.com with SMTP id u68so16772756uau.0
 for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2016 16:17:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
From: Bowgo Tsai <bowgotsai@google.com>
Date: Thu, 22 Sep 2016 16:17:22 -0700
Message-ID: <CAMFYTWedPzHCoGx=jM6-L1AV8OReLOsvhxSpouLhvfJcCy0YXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>, Jeffrey Vander Stoep <jeffv@google.com>,
 Daniel Cashman <dcashman@google.com>
Content-Type: multipart/alternative; boundary=001a114d7dde313305053d20dd97
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114d7dde313305053d20dd97
Content-Type: text/plain; charset=UTF-8

+Jeffrey and Daniel

On Thu, Sep 22, 2016 at 12:48 PM, Bowgo Tsai <bowgotsai@google.com> wrote:

> From: bowgotsai <bowgotsai@google.com>
>
> ---
>  checkpolicy/Android.mk | 11 ++---------
>  libsepol/Android.mk    | 16 ++++++++--------
>  2 files changed, 10 insertions(+), 17 deletions(-)
>
> diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> index 3b7ff8a..ee2f158 100644
> --- a/checkpolicy/Android.mk
> +++ b/checkpolicy/Android.mk
> @@ -18,13 +18,6 @@ common_includes := \
>         $(LOCAL_PATH)/../libsepol/src/ \
>
>  ##
> -# "-x c" forces the lex/yacc files to be compiled as c the build system
> -# otherwise forces them to be c++. Need to also add an explicit -std
> because the
> -# build system will soon default C++ to -std=c++11.
> -yacc_flags := -x c -std=gnu89
> -
> -
> -##
>  # checkpolicy
>  #
>  include $(CLEAR_VARS)
> @@ -32,7 +25,7 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := checkpolicy
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
>  LOCAL_STATIC_LIBRARIES := libsepol
>  LOCAL_YACCFLAGS := -v
> @@ -49,7 +42,7 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := checkmodule
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
>  LOCAL_STATIC_LIBRARIES := libsepol
>  LOCAL_YACCFLAGS := -v
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> index 6d89f17..e9cfeef 100644
> --- a/libsepol/Android.mk
> +++ b/libsepol/Android.mk
> @@ -81,6 +81,7 @@ common_includes := \
>  # build system will soon default C++ to -std=c++11.
>  yacc_flags := -x c -std=gnu89
>
> +
>  ##
>  # libsepol.so
>  #
> @@ -88,12 +89,11 @@ include $(CLEAR_VARS)
>
>  LOCAL_MODULE := libsepol
>  LOCAL_MODULE_TAGS := optional
> -LOCAL_COPY_HEADERS_TO := sepol
> -LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h
> cil/include/cil/cil.h
>  LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
> +LOCAL_CPPFLAGS := $(yacc_flags)
>  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>
>  include $(BUILD_HOST_SHARED_LIBRARY)
>
> @@ -105,9 +105,10 @@ include $(CLEAR_VARS)
>  LOCAL_MODULE := libsepol
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_C_INCLUDES := $(common_includes)
> -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> +LOCAL_CFLAGS := $(common_cflags)
> +LOCAL_CPPFLAGS := $(yacc_flags)
>  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>
>  include $(BUILD_HOST_STATIC_LIBRARY)
>
> @@ -122,7 +123,6 @@ LOCAL_C_INCLUDES := $(common_includes)
>  LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := utils/chkcon.c
>  LOCAL_SHARED_LIBRARIES := libsepol
> -LOCAL_MODULE_CLASS := EXECUTABLES
>
>  include $(BUILD_HOST_EXECUTABLE)
>
> @@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES := optional
>  LOCAL_C_INCLUDES := $(common_includes)
>  LOCAL_CFLAGS := $(common_cflags)
>  LOCAL_SRC_FILES := $(common_src_files)
> -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
>
>  include $(BUILD_STATIC_LIBRARY)
> --
> 2.8.0.rc3.226.g39d4020
>
>


-- 

Bowgo Tsai |  Engineer |  bowgotsai@google.com |  +886 (2) 8729-6364
<%2B886287296364>

--001a114d7dde313305053d20dd97
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">+Jeffrey and Daniel</div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Thu, Sep 22, 2016 at 12:48 PM, Bowgo Tsai <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:bowgotsai@google.com" target=3D"_blank">=
bowgotsai@google.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">From: bowgotsai &lt;<a href=3D"mailto:bowgotsai@google.com">bowgotsai@goo=
gle.com</a>&gt;<br>
<br>
---<br>
=C2=A0checkpolicy/Android.mk | 11 ++---------<br>
=C2=A0libsepol/Android.mk=C2=A0 =C2=A0 | 16 ++++++++--------<br>
=C2=A02 files changed, 10 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk<br>
index 3b7ff8a..ee2f158 100644<br>
--- a/checkpolicy/Android.mk<br>
+++ b/checkpolicy/Android.mk<br>
@@ -18,13 +18,6 @@ common_includes :=3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(LOCAL_PATH)/../libsepol/src/ \<br>
<br>
=C2=A0##<br>
-# &quot;-x c&quot; forces the lex/yacc files to be compiled as c the build=
 system<br>
-# otherwise forces them to be c++. Need to also add an explicit -std becau=
se the<br>
-# build system will soon default C++ to -std=3Dc++11.<br>
-yacc_flags :=3D -x c -std=3Dgnu89<br>
-<br>
-<br>
-##<br>
=C2=A0# checkpolicy<br>
=C2=A0#<br>
=C2=A0include $(CLEAR_VARS)<br>
@@ -32,7 +25,7 @@ include $(CLEAR_VARS)<br>
=C2=A0LOCAL_MODULE :=3D checkpolicy<br>
=C2=A0LOCAL_MODULE_TAGS :=3D optional<br>
=C2=A0LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
+LOCAL_CFLAGS :=3D $(common_cflags)<br>
=C2=A0LOCAL_SRC_FILES :=3D $(common_src_files) checkpolicy.c<br>
=C2=A0LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
=C2=A0LOCAL_YACCFLAGS :=3D -v<br>
@@ -49,7 +42,7 @@ include $(CLEAR_VARS)<br>
=C2=A0LOCAL_MODULE :=3D checkmodule<br>
=C2=A0LOCAL_MODULE_TAGS :=3D optional<br>
=C2=A0LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
+LOCAL_CFLAGS :=3D $(common_cflags)<br>
=C2=A0LOCAL_SRC_FILES :=3D $(common_src_files) checkmodule.c<br>
=C2=A0LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
=C2=A0LOCAL_YACCFLAGS :=3D -v<br>
diff --git a/libsepol/Android.mk b/libsepol/Android.mk<br>
index 6d89f17..e9cfeef 100644<br>
--- a/libsepol/Android.mk<br>
+++ b/libsepol/Android.mk<br>
@@ -81,6 +81,7 @@ common_includes :=3D \<br>
=C2=A0# build system will soon default C++ to -std=3Dc++11.<br>
=C2=A0yacc_flags :=3D -x c -std=3Dgnu89<br>
<br>
+<br>
=C2=A0##<br>
=C2=A0# libsepol.so<br>
=C2=A0#<br>
@@ -88,12 +89,11 @@ include $(CLEAR_VARS)<br>
<br>
=C2=A0LOCAL_MODULE :=3D libsepol<br>
=C2=A0LOCAL_MODULE_TAGS :=3D optional<br>
-LOCAL_COPY_HEADERS_TO :=3D sepol<br>
-LOCAL_COPY_HEADERS :=3D include/sepol/handle.h include/sepol/policydb.h ci=
l/include/cil/cil.h<br>
=C2=A0LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
+LOCAL_CFLAGS :=3D $(common_cflags)<br>
+LOCAL_CPPFLAGS :=3D $(yacc_flags)<br>
=C2=A0LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
-LOCAL_MODULE_CLASS :=3D SHARED_LIBRARIES<br>
+LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
<br>
=C2=A0include $(BUILD_HOST_SHARED_LIBRARY)<br>
<br>
@@ -105,9 +105,10 @@ include $(CLEAR_VARS)<br>
=C2=A0LOCAL_MODULE :=3D libsepol<br>
=C2=A0LOCAL_MODULE_TAGS :=3D optional<br>
=C2=A0LOCAL_C_INCLUDES :=3D $(common_includes)<br>
-LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
+LOCAL_CFLAGS :=3D $(common_cflags)<br>
+LOCAL_CPPFLAGS :=3D $(yacc_flags)<br>
=C2=A0LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
-LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
+LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
<br>
=C2=A0include $(BUILD_HOST_STATIC_LIBRARY)<br>
<br>
@@ -122,7 +123,6 @@ LOCAL_C_INCLUDES :=3D $(common_includes)<br>
=C2=A0LOCAL_CFLAGS :=3D $(common_cflags)<br>
=C2=A0LOCAL_SRC_FILES :=3D utils/chkcon.c<br>
=C2=A0LOCAL_SHARED_LIBRARIES :=3D libsepol<br>
-LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
<br>
=C2=A0include $(BUILD_HOST_EXECUTABLE)<br>
<br>
@@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES :=3D optional<br>
=C2=A0LOCAL_C_INCLUDES :=3D $(common_includes)<br>
=C2=A0LOCAL_CFLAGS :=3D $(common_cflags)<br>
=C2=A0LOCAL_SRC_FILES :=3D $(common_src_files)<br>
-LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
+LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
<br>
=C2=A0include $(BUILD_STATIC_LIBRARY)<br>
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

--001a114d7dde313305053d20dd97--
