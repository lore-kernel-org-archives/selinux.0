MIME-Version: 1.0
In-Reply-To: <f68e3901-7d0b-524b-51d8-2488e8ffa60b@tycho.nsa.gov>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
 <CAFftDdqUs82JM2JCxbFFxre62hc-PNM7rYoKAMrxMfcUiuheQA@mail.gmail.com>
 <f68e3901-7d0b-524b-51d8-2488e8ffa60b@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 11:43:57 -0700
Message-ID: <CAFftDdoo+jvceEquA1xWp8g1-aDyZCm1FOA47h3chMbFH34UQA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add ANDROID_HOST=y build option
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c046e1e9d5efe053d81a003
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c046e1e9d5efe053d81a003
Content-Type: text/plain; charset=UTF-8

On Sep 27, 2016 10:00, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 09/27/2016 11:08 AM, William Roberts wrote:
> > On Tue, Sep 27, 2016 at 7:11 AM, Stephen Smalley <sds@tycho.nsa.gov>
wrote:
> >> On 09/26/2016 04:53 PM, william.c.roberts@intel.com wrote:
> >>> From: William Roberts <william.c.roberts@intel.com>
> >>>
> >>> To build the selinux host configuration, specify
> >>> ANDROID_HOST=y on the Make command line.
> >>>
> >>> eg)
> >>> make ANDROID_HOST=y
> >>
> >> Seems oddly named, neither corresponding to the #define it enables
> >> (BUILD_HOST) nor to the target platform.
> >
> > We could change this to BUILD_HOST=y to enable all of it, but
considering
> > that this build is specific for Android, I thought the naming to be more
> > appropriate.
> >
> > Additionally, EMBEDDED doesn't flip anything called EMBEDDED as well.
> >
> >>
> >>>
> >>> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >>> ---
> >>>  libselinux/Makefile     |  8 +++++++-
> >>>  libselinux/src/Makefile | 50
+++++++++++++++++++++++++++++++++----------------
> >>>  2 files changed, 41 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/libselinux/Makefile b/libselinux/Makefile
> >>> index 5a8d42c..50ae009 100644
> >>> --- a/libselinux/Makefile
> >>> +++ b/libselinux/Makefile
> >>> @@ -10,6 +10,12 @@ ifeq ($(EMBEDDED),y)
> >>>       override DISABLE_RPM=y
> >>>       override DISABLE_BOOL=y
> >>>  endif
> >>> +ifeq ($(ANDROID_HOST),y)
> >>> +     override DISABLE_SETRANS=y
> >>> +     EMFLAGS+= -DDISABLE_RPM -DNO_MEDIA_BACKEND -DNO_DB_BACKEND
-DNO_X_BACKEND \
> >>> +             -DBUILD_HOST
> >>> +     SUBDIRS = src
> >>> +endif
>
> Also, this is redundant; you can handle it entirely within
> libselinux/src/Makefile without anything here.

You mean all the ANDROID _HOST stuff? I didn't want to depart from what's
there, that seemed to be the spot for disabling things.

--94eb2c046e1e9d5efe053d81a003
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 27, 2016 10:00, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 09/27/2016 11:08 AM, William Roberts wrote:<br>
&gt; &gt; On Tue, Sep 27, 2016 at 7:11 AM, Stephen Smalley &lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; &gt;&gt; On 09/26/2016 04:53 PM, <a href=3D"mailto:william.c.roberts@i=
ntel.com">william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt;&gt;&gt; From: William Roberts &lt;<a href=3D"mailto:william.c.rob=
erts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; To build the selinux host configuration, specify<br>
&gt; &gt;&gt;&gt; ANDROID_HOST=3Dy on the Make command line.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; eg)<br>
&gt; &gt;&gt;&gt; make ANDROID_HOST=3Dy<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Seems oddly named, neither corresponding to the #define it en=
ables<br>
&gt; &gt;&gt; (BUILD_HOST) nor to the target platform.<br>
&gt; &gt;<br>
&gt; &gt; We could change this to BUILD_HOST=3Dy to enable all of it, but c=
onsidering<br>
&gt; &gt; that this build is specific for Android, I thought the naming to =
be more<br>
&gt; &gt; appropriate.<br>
&gt; &gt;<br>
&gt; &gt; Additionally, EMBEDDED doesn&#39;t flip anything called EMBEDDED =
as well.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:will=
iam.c.roberts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;=C2=A0 libselinux/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++=
+++++-<br>
&gt; &gt;&gt;&gt;=C2=A0 libselinux/src/Makefile | 50 ++++++++++++++++++++++=
+++++++++++----------------<br>
&gt; &gt;&gt;&gt;=C2=A0 2 files changed, 41 insertions(+), 17 deletions(-)<=
br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/libselinux/Makefile b/libselinux/Makefile<br=
>
&gt; &gt;&gt;&gt; index 5a8d42c..50ae009 100644<br>
&gt; &gt;&gt;&gt; --- a/libselinux/Makefile<br>
&gt; &gt;&gt;&gt; +++ b/libselinux/Makefile<br>
&gt; &gt;&gt;&gt; @@ -10,6 +10,12 @@ ifeq ($(EMBEDDED),y)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0override DISABLE_RPM=3Dy<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0override DISABLE_BOOL=3Dy<br>
&gt; &gt;&gt;&gt;=C2=A0 endif<br>
&gt; &gt;&gt;&gt; +ifeq ($(ANDROID_HOST),y)<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0override DISABLE_SETRANS=3Dy<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0EMFLAGS+=3D -DDISABLE_RPM -DNO_MEDIA=
_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-DBUILD_=
HOST<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0SUBDIRS =3D src<br>
&gt; &gt;&gt;&gt; +endif<br>
&gt;<br>
&gt; Also, this is redundant; you can handle it entirely within<br>
&gt; libselinux/src/Makefile without anything here.</p>
<p dir=3D"ltr">You mean all the ANDROID _HOST stuff? I didn&#39;t want to d=
epart from what&#39;s there, that seemed to be the spot for disabling thing=
s.</p>

--94eb2c046e1e9d5efe053d81a003--
