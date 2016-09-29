Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8T2HqVW005207
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 22:17:52 -0400
Received: by mail-vk0-f54.google.com with SMTP id v205so61883526vke.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 19:17:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
References: <1474573685-124428-1-git-send-email-bowgotsai@google.com>
 <f213e1a4-5a68-dff2-b1b6-354410ef7fe1@tycho.nsa.gov>
From: Bowgo Tsai <bowgotsai@google.com>
Date: Thu, 29 Sep 2016 10:17:15 +0800
Message-ID: <CAMFYTWcz6y9whm8_z4rwQBVtcK_YniTycwu-+zsSiqrYn-kj_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol, checkpolicy: Update Android.mk
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Nick Kralevich <nnk@google.com>,
 Daniel Cashman <dcashman@google.com>,
 Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: multipart/alternative; boundary=001a11439d688af6ea053d9c137a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11439d688af6ea053d9c137a
Content-Type: text/plain; charset=UTF-8

OK, please ignore these patches, will update new ones.
I'll update the top-level Android.mk if we still want to keep Android.mk
upstream.

However, I was thinking the same thing: it seems better to only keep
Android.mk files in Android tree.
For other *.c/*.h files, keep these files up-to-date in the upstream as
well.

If no one objects to this, I'll prepare two patches.

   1. Update secilc/secilc.c
   2. Delete all Android.mk files in the upstream

Let me know your thoughts.
Thanks,

On Mon, Sep 26, 2016 at 10:24 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/22/2016 03:48 PM, Bowgo Tsai wrote:
> > From: bowgotsai <bowgotsai@google.com>
>
> It looks to me as if the final versions of these patches changed before
> they were committed to AOSP, so I'm going to ignore these and assume
> you'll submit new ones.  Also, if updating these, shouldn't you also
> update the top-level selinux/Android.mk file as well?
>
> I was wondering however if it makes sense to keep these files upstream
> or if we should just drop them and let them only exist in the Android tree.
>
> >
> > ---
> >  checkpolicy/Android.mk | 11 ++---------
> >  libsepol/Android.mk    | 16 ++++++++--------
> >  2 files changed, 10 insertions(+), 17 deletions(-)
> >
> > diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> > index 3b7ff8a..ee2f158 100644
> > --- a/checkpolicy/Android.mk
> > +++ b/checkpolicy/Android.mk
> > @@ -18,13 +18,6 @@ common_includes := \
> >       $(LOCAL_PATH)/../libsepol/src/ \
> >
> >  ##
> > -# "-x c" forces the lex/yacc files to be compiled as c the build system
> > -# otherwise forces them to be c++. Need to also add an explicit -std
> because the
> > -# build system will soon default C++ to -std=c++11.
> > -yacc_flags := -x c -std=gnu89
> > -
> > -
> > -##
> >  # checkpolicy
> >  #
> >  include $(CLEAR_VARS)
> > @@ -32,7 +25,7 @@ include $(CLEAR_VARS)
> >  LOCAL_MODULE := checkpolicy
> >  LOCAL_MODULE_TAGS := optional
> >  LOCAL_C_INCLUDES := $(common_includes)
> > -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> > +LOCAL_CFLAGS := $(common_cflags)
> >  LOCAL_SRC_FILES := $(common_src_files) checkpolicy.c
> >  LOCAL_STATIC_LIBRARIES := libsepol
> >  LOCAL_YACCFLAGS := -v
> > @@ -49,7 +42,7 @@ include $(CLEAR_VARS)
> >  LOCAL_MODULE := checkmodule
> >  LOCAL_MODULE_TAGS := optional
> >  LOCAL_C_INCLUDES := $(common_includes)
> > -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> > +LOCAL_CFLAGS := $(common_cflags)
> >  LOCAL_SRC_FILES := $(common_src_files) checkmodule.c
> >  LOCAL_STATIC_LIBRARIES := libsepol
> >  LOCAL_YACCFLAGS := -v
> > diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> > index 6d89f17..e9cfeef 100644
> > --- a/libsepol/Android.mk
> > +++ b/libsepol/Android.mk
> > @@ -81,6 +81,7 @@ common_includes := \
> >  # build system will soon default C++ to -std=c++11.
> >  yacc_flags := -x c -std=gnu89
> >
> > +
> >  ##
> >  # libsepol.so
> >  #
> > @@ -88,12 +89,11 @@ include $(CLEAR_VARS)
> >
> >  LOCAL_MODULE := libsepol
> >  LOCAL_MODULE_TAGS := optional
> > -LOCAL_COPY_HEADERS_TO := sepol
> > -LOCAL_COPY_HEADERS := include/sepol/handle.h include/sepol/policydb.h
> cil/include/cil/cil.h
> >  LOCAL_C_INCLUDES := $(common_includes)
> > -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> > +LOCAL_CFLAGS := $(common_cflags)
> > +LOCAL_CPPFLAGS := $(yacc_flags)
> >  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> > -LOCAL_MODULE_CLASS := SHARED_LIBRARIES
> > +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
> >
> >  include $(BUILD_HOST_SHARED_LIBRARY)
> >
> > @@ -105,9 +105,10 @@ include $(CLEAR_VARS)
> >  LOCAL_MODULE := libsepol
> >  LOCAL_MODULE_TAGS := optional
> >  LOCAL_C_INCLUDES := $(common_includes)
> > -LOCAL_CFLAGS := $(yacc_flags) $(common_cflags)
> > +LOCAL_CFLAGS := $(common_cflags)
> > +LOCAL_CPPFLAGS := $(yacc_flags)
> >  LOCAL_SRC_FILES := $(common_src_files) $(cil_src_files)
> > -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> > +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
> >
> >  include $(BUILD_HOST_STATIC_LIBRARY)
> >
> > @@ -122,7 +123,6 @@ LOCAL_C_INCLUDES := $(common_includes)
> >  LOCAL_CFLAGS := $(common_cflags)
> >  LOCAL_SRC_FILES := utils/chkcon.c
> >  LOCAL_SHARED_LIBRARIES := libsepol
> > -LOCAL_MODULE_CLASS := EXECUTABLES
> >
> >  include $(BUILD_HOST_EXECUTABLE)
> >
> > @@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES := optional
> >  LOCAL_C_INCLUDES := $(common_includes)
> >  LOCAL_CFLAGS := $(common_cflags)
> >  LOCAL_SRC_FILES := $(common_src_files)
> > -LOCAL_MODULE_CLASS := STATIC_LIBRARIES
> > +LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
> >
> >  include $(BUILD_STATIC_LIBRARY)
> >
>
>


-- 

Bowgo Tsai |  Engineer |  bowgotsai@google.com |  +886 (2) 8729-6364
<%2B886287296364>

--001a11439d688af6ea053d9c137a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>OK, please ignore these patches, will update new ones=
.=C2=A0</div><div>I&#39;ll update the top-level Android.mk if we still want=
 to keep Android.mk upstream.</div><div><br></div>However, I was thinking t=
he same thing: it seems better to only keep Android.mk files in Android tre=
e.<div>For other *.c/*.h files, keep these files up-to-date in the upstream=
 as well.</div><div><br></div><div>If no one objects to this, I&#39;ll prep=
are two patches.</div><div><ol><li>Update=C2=A0secilc/secilc.c</li><li>Dele=
te all Android.mk files in the upstream</li></ol><div>Let me know your thou=
ghts.</div></div><div>Thanks,</div></div><div class=3D"gmail_extra"><br><di=
v class=3D"gmail_quote">On Mon, Sep 26, 2016 at 10:24 PM, Stephen Smalley <=
span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank"=
>sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
On 09/22/2016 03:48 PM, Bowgo Tsai wrote:<br>
&gt; From: bowgotsai &lt;<a href=3D"mailto:bowgotsai@google.com">bowgotsai@=
google.com</a>&gt;<br>
<br>
It looks to me as if the final versions of these patches changed before<br>
they were committed to AOSP, so I&#39;m going to ignore these and assume<br=
>
you&#39;ll submit new ones.=C2=A0 Also, if updating these, shouldn&#39;t yo=
u also<br>
update the top-level selinux/Android.mk file as well?<br>
<br>
I was wondering however if it makes sense to keep these files upstream<br>
or if we should just drop them and let them only exist in the Android tree.=
<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 checkpolicy/Android.mk | 11 ++---------<br>
&gt;=C2=A0 libsepol/Android.mk=C2=A0 =C2=A0 | 16 ++++++++--------<br>
&gt;=C2=A0 2 files changed, 10 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk<br>
&gt; index 3b7ff8a..ee2f158 100644<br>
&gt; --- a/checkpolicy/Android.mk<br>
&gt; +++ b/checkpolicy/Android.mk<br>
&gt; @@ -18,13 +18,6 @@ common_includes :=3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(LOCAL_PATH)/../libsepol/src/ \<br>
&gt;<br>
&gt;=C2=A0 ##<br>
&gt; -# &quot;-x c&quot; forces the lex/yacc files to be compiled as c the =
build system<br>
&gt; -# otherwise forces them to be c++. Need to also add an explicit -std =
because the<br>
&gt; -# build system will soon default C++ to -std=3Dc++11.<br>
&gt; -yacc_flags :=3D -x c -std=3Dgnu89<br>
&gt; -<br>
&gt; -<br>
&gt; -##<br>
&gt;=C2=A0 # checkpolicy<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 include $(CLEAR_VARS)<br>
&gt; @@ -32,7 +25,7 @@ include $(CLEAR_VARS)<br>
&gt;=C2=A0 LOCAL_MODULE :=3D checkpolicy<br>
&gt;=C2=A0 LOCAL_MODULE_TAGS :=3D optional<br>
&gt;=C2=A0 LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt; -LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
&gt; +LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D $(common_src_files) checkpolicy.c<br>
&gt;=C2=A0 LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
&gt;=C2=A0 LOCAL_YACCFLAGS :=3D -v<br>
&gt; @@ -49,7 +42,7 @@ include $(CLEAR_VARS)<br>
&gt;=C2=A0 LOCAL_MODULE :=3D checkmodule<br>
&gt;=C2=A0 LOCAL_MODULE_TAGS :=3D optional<br>
&gt;=C2=A0 LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt; -LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
&gt; +LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D $(common_src_files) checkmodule.c<br>
&gt;=C2=A0 LOCAL_STATIC_LIBRARIES :=3D libsepol<br>
&gt;=C2=A0 LOCAL_YACCFLAGS :=3D -v<br>
&gt; diff --git a/libsepol/Android.mk b/libsepol/Android.mk<br>
&gt; index 6d89f17..e9cfeef 100644<br>
&gt; --- a/libsepol/Android.mk<br>
&gt; +++ b/libsepol/Android.mk<br>
&gt; @@ -81,6 +81,7 @@ common_includes :=3D \<br>
&gt;=C2=A0 # build system will soon default C++ to -std=3Dc++11.<br>
&gt;=C2=A0 yacc_flags :=3D -x c -std=3Dgnu89<br>
&gt;<br>
&gt; +<br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # libsepol.so<br>
&gt;=C2=A0 #<br>
&gt; @@ -88,12 +89,11 @@ include $(CLEAR_VARS)<br>
&gt;<br>
&gt;=C2=A0 LOCAL_MODULE :=3D libsepol<br>
&gt;=C2=A0 LOCAL_MODULE_TAGS :=3D optional<br>
&gt; -LOCAL_COPY_HEADERS_TO :=3D sepol<br>
&gt; -LOCAL_COPY_HEADERS :=3D include/sepol/handle.h include/sepol/policydb=
.h cil/include/cil/cil.h<br>
&gt;=C2=A0 LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt; -LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
&gt; +LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt; +LOCAL_CPPFLAGS :=3D $(yacc_flags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
&gt; -LOCAL_MODULE_CLASS :=3D SHARED_LIBRARIES<br>
&gt; +LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
&gt;<br>
&gt;=C2=A0 include $(BUILD_HOST_SHARED_LIBRARY)<br>
&gt;<br>
&gt; @@ -105,9 +105,10 @@ include $(CLEAR_VARS)<br>
&gt;=C2=A0 LOCAL_MODULE :=3D libsepol<br>
&gt;=C2=A0 LOCAL_MODULE_TAGS :=3D optional<br>
&gt;=C2=A0 LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt; -LOCAL_CFLAGS :=3D $(yacc_flags) $(common_cflags)<br>
&gt; +LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt; +LOCAL_CPPFLAGS :=3D $(yacc_flags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D $(common_src_files) $(cil_src_files)<br>
&gt; -LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
&gt; +LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
&gt;<br>
&gt;=C2=A0 include $(BUILD_HOST_STATIC_LIBRARY)<br>
&gt;<br>
&gt; @@ -122,7 +123,6 @@ LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt;=C2=A0 LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D utils/chkcon.c<br>
&gt;=C2=A0 LOCAL_SHARED_LIBRARIES :=3D libsepol<br>
&gt; -LOCAL_MODULE_CLASS :=3D EXECUTABLES<br>
&gt;<br>
&gt;=C2=A0 include $(BUILD_HOST_EXECUTABLE)<br>
&gt;<br>
&gt; @@ -133,6 +133,6 @@ LOCAL_MODULE_TAGES :=3D optional<br>
&gt;=C2=A0 LOCAL_C_INCLUDES :=3D $(common_includes)<br>
&gt;=C2=A0 LOCAL_CFLAGS :=3D $(common_cflags)<br>
&gt;=C2=A0 LOCAL_SRC_FILES :=3D $(common_src_files)<br>
&gt; -LOCAL_MODULE_CLASS :=3D STATIC_LIBRARIES<br>
&gt; +LOCAL_EXPORT_C_INCLUDE_DIRS :=3D $(LOCAL_PATH)/include<br>
&gt;<br>
&gt;=C2=A0 include $(BUILD_STATIC_LIBRARY)<br>
&gt;<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=3D=
"font-family:Times"><tbody><tr style=3D"color:rgb(85,85,85);font-family:san=
s-serif;font-size:small"><td nowrap style=3D"font-family:arial;border-top-s=
tyle:solid;border-top-color:rgb(213,15,37);border-top-width:2px">Bowgo Tsai=
 |</td><td nowrap style=3D"font-family:arial;border-top-style:solid;border-=
top-color:rgb(51,105,232);border-top-width:2px">=C2=A0Engineer |</td><td no=
wrap style=3D"font-family:arial;border-top-style:solid;border-top-color:rgb=
(0,153,57);border-top-width:2px">=C2=A0<a href=3D"mailto:bowgotsai@google.c=
om" target=3D"_blank">bowgotsai@google.com</a>=C2=A0|</td><td nowrap style=
=3D"font-family:arial;border-top-style:solid;border-top-color:rgb(238,178,1=
7);border-top-width:2px">=C2=A0<a href=3D"tel:%2B886287296364" value=3D"+88=
6287296364" style=3D"color:rgb(17,85,204);font-family:arial,sans-serif;font=
-size:12.8000001907349px;white-space:normal" target=3D"_blank">+886 (2) 872=
9-6364</a></td></tr></tbody></table><br><div><font face=3D"Times" size=3D"3=
" style=3D"color:rgb(136,136,136);background-color:rgb(255,255,255)"></font=
></div></div></div></div></div></div></div></div></div></div></div></div></=
div></div></div></div>
</div>

--001a11439d688af6ea053d9c137a--
