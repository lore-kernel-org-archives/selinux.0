MIME-Version: 1.0
In-Reply-To: <0e982db1-15d4-8f84-6606-d22b8d9abd80@tycho.nsa.gov>
References: <1474923189-26431-1-git-send-email-william.c.roberts@intel.com>
 <85b69cd8-e882-e68a-235f-ee444b3f0813@tycho.nsa.gov>
 <CAFftDdqUs82JM2JCxbFFxre62hc-PNM7rYoKAMrxMfcUiuheQA@mail.gmail.com>
 <0e982db1-15d4-8f84-6606-d22b8d9abd80@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 27 Sep 2016 10:00:11 -0700
Message-ID: <CAFftDdpgo0sOM5sWLBmZih3DasR4ULwhMJNtgNi4cKD31JYKMA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add ANDROID_HOST=y build option
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov,
 William Roberts <william.c.roberts@intel.com>
Content-Type: multipart/alternative; boundary=94eb2c046e1e84c26e053d802d04
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c046e1e84c26e053d802d04
Content-Type: text/plain; charset=UTF-8

On Sep 27, 2016 09:50, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
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
>
> Ok, fair point.  Actually EMBEDDED=y is broken and no one is using it
> AFAIK so we should probably kill it at some point separately.
>
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
> >>
> >> Don't you actually want to also pick up utils/sefcontext_compile?
> >> That is built and used on the build host.  And I'm not sure why we'd
> >> drop the other SUBDIRS.
> >
> > You'll start running into linking issues if things that use
> > libselinux, use something not
> > in the build host IIRC. Perhaps, if that is the issue, we just limit
> > it to sefcontext_compile.
>
> Sure, the utils/Makefile can remove entries the same way it already does
> for DISABLE_*.
> >
> >>
> >>>  ifeq ($(DISABLE_AVC),y)
> >>>       EMFLAGS+= -DDISABLE_AVC
> >>>  endif
> >>> @@ -22,7 +28,7 @@ endif
> >>>  ifeq ($(DISABLE_SETRANS),y)
> >>>       EMFLAGS+= -DDISABLE_SETRANS
> >>>  endif
> >>> -export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
> >>> +export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
ANDROID_HOST
> >>>
> >>>  USE_PCRE2 ?= n
> >>>  ifeq ($(USE_PCRE2),y)
> >>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> >>> index 36e42b8..d841ef7 100644
> >>> --- a/libselinux/src/Makefile
> >>> +++ b/libselinux/src/Makefile
> >>> @@ -47,9 +47,17 @@ endif
> >>>  ifeq ($(DISABLE_BOOL),y)
> >>>       UNUSED_SRCS+=booleans.c
> >>>  endif
> >>> +ifeq ($(ANDROID_HOST),y)
> >>> +     SRCS=callbacks.c freecon.c label.c label_file.c \
> >>> +                     label_android_property.c regex.c
label_support.c \
> >>> +                     matchpathcon.c setrans_client.c sha1.c
> >>> +     override CFLAGS += -DNO_MEDIA_BACKEND -DNO_DB_BACKEND
-DNO_X_BACKEND \
> >>> +                     -DBUILD_HOST
> >>> +else
> >>> +     SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c,
$(sort $(wildcard *.c)))
> >>> +endif
> >>>
> >>>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
> >>> -SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort
$(wildcard *.c)))
> >>>
> >>>  MAX_STACK_SIZE=32768
> >>>
> >>> @@ -92,6 +100,28 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir
./ $(EMFLAGS)
> >>>
> >>>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(EMFLAGS)
> >>>
> >>> +$(LIBA): $(OBJS)
> >>> +     $(AR) rcs $@ $^
> >>> +     $(RANLIB) $@
> >>> +
> >>> +$(LIBSO): $(LOBJS)
> >>> +     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl
$(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> >>> +     ln -sf $@ $(TARGET)
> >>> +
> >>> +%.o:  %.c policy.h
> >>> +     $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> >>> +
> >>> +%.lo:  %.c policy.h
> >>> +     $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >>
> >> Did these truly need to move?  I don't see why.
> >
> > this prevents us from having multiple definitions of the recipes or
> > multiple if's on ANDROID_HOST=y.
> > Both flavors need these wildcard targets.
>
> If I undo all of these changes, make ANDROID_HOST=y clean all works just
> fine.   So does make install.  You don't need any of this conditional
> logic in the Makefile, and it just makes it harder to read and maintain.
>
> >
> >>
> >>> +
> >>> +# ANDROID_HOST Build option only builds the shared and static
versions of
> >>> +# libselinux.
> >>> +ifeq ($(ANDROID_HOST),y)
> >>> +
> >>> +all: $(LIBA) $(LIBSO)
> >>> +
> >>> +else
> >>> +
> >>>  all: $(LIBA) $(LIBSO) $(LIBPC)
> >>
> >> Is this worthwhile/necessary?  The point of the build option IIUC is
> >> just to allow upstream testing that the Android build host version will
> >> still build, it shouldn't matter if there are extras.
> >
> > Those things die on linking... so I didn't want to submit something
> > where Make returns not 0.
> >
> >>
> >>>
> >>>  pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
> >>> @@ -110,14 +140,6 @@ $(SWIGSO): $(SWIGLOBJ)
> >>>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> >>>       $(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS)
-L$(LIBDIR)
> >>>
> >>> -$(LIBA): $(OBJS)
> >>> -     $(AR) rcs $@ $^
> >>> -     $(RANLIB) $@
> >>> -
> >>> -$(LIBSO): $(LOBJS)
> >>> -     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl
$(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> >>> -     ln -sf $@ $(TARGET)
> >>> -
> >>>  $(LIBPC): $(LIBPC).in ../VERSION
> >>>       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):;
s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> >>>
> >>> @@ -130,12 +152,6 @@ $(AUDIT2WHYLOBJ): audit2why.c
> >>>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> >>>       $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux
$(LIBDIR)/libsepol.a -L$(LIBDIR)
> >>>
> >>> -%.o:  %.c policy.h
> >>> -     $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> >>> -
> >>> -%.lo:  %.c policy.h
> >>> -     $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> >>> -
> >>>  $(SWIGCOUT): $(SWIGIF)
> >>>       $(SWIG) $<
> >>>
> >>> @@ -178,4 +194,6 @@ distclean: clean
> >>>  indent:
> >>>       ../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard
*.[ch]))
> >>>
> >>> -.PHONY: all clean pywrap rubywrap swigify install install-pywrap
install-rubywrap distclean
> >>> +.PHONY: clean pywrap rubywrap swigify install install-pywrap
install-rubywrap distclean
> >>> +endif
> >>> +.PHONY: all
> >>
> >> Why is this needed?
> >
> > The targets for %.o and %.lo are used on all build targets, the rest
> > is committed on ANDROID_HOST=y.
> > So for the stuff that is separated out, we have a .PHONY for it. For
> > the things the define in common,
> > notably ALL, we have a shared .PHONY for them.
> >
> >>
> >> BTW, this option can be dangerous.  Don't build with it and then do a
> >> make install later without doing a make clean - you'll brick your Linux
> >> system ;(
> >
> > That is true, but isn't that the point of SE Linux :-P. Kidding aside,
> > perhaps we
> > could create a guard file that's checked on install, if its there, you
need to
> > run make clean first.
> >

OK good to know, I ran into issues, but it might have been fore I had the
rest of it sorted out.

--94eb2c046e1e84c26e053d802d04
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 27, 2016 09:50, &quot;Stephen Smalley&quot; &lt;<a hr=
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
&gt;<br>
&gt; Ok, fair point.=C2=A0 Actually EMBEDDED=3Dy is broken and no one is us=
ing it<br>
&gt; AFAIK so we should probably kill it at some point separately.<br>
&gt;<br>
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
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Don&#39;t you actually want to also pick up utils/sefcontext_=
compile?<br>
&gt; &gt;&gt; That is built and used on the build host.=C2=A0 And I&#39;m n=
ot sure why we&#39;d<br>
&gt; &gt;&gt; drop the other SUBDIRS.<br>
&gt; &gt;<br>
&gt; &gt; You&#39;ll start running into linking issues if things that use<b=
r>
&gt; &gt; libselinux, use something not<br>
&gt; &gt; in the build host IIRC. Perhaps, if that is the issue, we just li=
mit<br>
&gt; &gt; it to sefcontext_compile.<br>
&gt;<br>
&gt; Sure, the utils/Makefile can remove entries the same way it already do=
es<br>
&gt; for DISABLE_*.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 ifeq ($(DISABLE_AVC),y)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EMFLAGS+=3D -DDISABLE_AVC<br>
&gt; &gt;&gt;&gt;=C2=A0 endif<br>
&gt; &gt;&gt;&gt; @@ -22,7 +28,7 @@ endif<br>
&gt; &gt;&gt;&gt;=C2=A0 ifeq ($(DISABLE_SETRANS),y)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EMFLAGS+=3D -DDISABLE_SETRANS<b=
r>
&gt; &gt;&gt;&gt;=C2=A0 endif<br>
&gt; &gt;&gt;&gt; -export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_B=
OOL EMFLAGS<br>
&gt; &gt;&gt;&gt; +export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_B=
OOL EMFLAGS ANDROID_HOST<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 USE_PCRE2 ?=3D n<br>
&gt; &gt;&gt;&gt;=C2=A0 ifeq ($(USE_PCRE2),y)<br>
&gt; &gt;&gt;&gt; diff --git a/libselinux/src/Makefile b/libselinux/src/Mak=
efile<br>
&gt; &gt;&gt;&gt; index 36e42b8..d841ef7 100644<br>
&gt; &gt;&gt;&gt; --- a/libselinux/src/Makefile<br>
&gt; &gt;&gt;&gt; +++ b/libselinux/src/Makefile<br>
&gt; &gt;&gt;&gt; @@ -47,9 +47,17 @@ endif<br>
&gt; &gt;&gt;&gt;=C2=A0 ifeq ($(DISABLE_BOOL),y)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0UNUSED_SRCS+=3Dbooleans.c<br>
&gt; &gt;&gt;&gt;=C2=A0 endif<br>
&gt; &gt;&gt;&gt; +ifeq ($(ANDROID_HOST),y)<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0SRCS=3Dcallbacks.c freecon.c label.c=
 label_file.c \<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0label_android_property.c regex.c label_support.c \<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0matchpathcon.c setrans_client.c sha1.c<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0override CFLAGS +=3D -DNO_MEDIA_BACK=
END -DNO_DB_BACKEND -DNO_X_BACKEND \<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-DBUILD_HOST<br>
&gt; &gt;&gt;&gt; +else<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0SRCS=3D $(filter-out $(UNUSED_SRCS) =
$(GENERATED) audit2why.c, $(sort $(wildcard *.c)))<br>
&gt; &gt;&gt;&gt; +endif<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 GENERATED=3D$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig=
_python_exception.i<br>
&gt; &gt;&gt;&gt; -SRCS=3D $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2w=
hy.c, $(sort $(wildcard *.c)))<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 MAX_STACK_SIZE=3D32768<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -92,6 +100,28 @@ SWIG =3D swig -Wall -python -o $(SWIG=
COUT) -outdir ./ $(EMFLAGS)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -o=
utdir ./ $(EMFLAGS)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; +$(LIBA): $(OBJS)<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0$(AR) rcs $@ $^<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0$(RANLIB) $@<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +$(LIBSO): $(LOBJS)<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ $(P=
CRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,re=
lro<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0ln -sf $@ $(TARGET)<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +%.o:=C2=A0 %.c policy.h<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@=
 $&lt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +%.lo:=C2=A0 %.c policy.h<br>
&gt; &gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -fPIC -DSHARED -c -o=
 $@ $&lt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Did these truly need to move?=C2=A0 I don&#39;t see why.<br>
&gt; &gt;<br>
&gt; &gt; this prevents us from having multiple definitions of the recipes =
or<br>
&gt; &gt; multiple if&#39;s on ANDROID_HOST=3Dy.<br>
&gt; &gt; Both flavors need these wildcard targets.<br>
&gt;<br>
&gt; If I undo all of these changes, make ANDROID_HOST=3Dy clean all works =
just<br>
&gt; fine.=C2=A0 =C2=A0So does make install.=C2=A0 You don&#39;t need any o=
f this conditional<br>
&gt; logic in the Makefile, and it just makes it harder to read and maintai=
n.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +# ANDROID_HOST Build option only builds the shared and s=
tatic versions of<br>
&gt; &gt;&gt;&gt; +# libselinux.<br>
&gt; &gt;&gt;&gt; +ifeq ($(ANDROID_HOST),y)<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +all: $(LIBA) $(LIBSO)<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt; +else<br>
&gt; &gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;=C2=A0 all: $(LIBA) $(LIBSO) $(LIBPC)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Is this worthwhile/necessary?=C2=A0 The point of the build op=
tion IIUC is<br>
&gt; &gt;&gt; just to allow upstream testing that the Android build host ve=
rsion will<br>
&gt; &gt;&gt; still build, it shouldn&#39;t matter if there are extras.<br>
&gt; &gt;<br>
&gt; &gt; Those things die on linking... so I didn&#39;t want to submit som=
ething<br>
&gt; &gt; where Make returns not 0.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;=C2=A0 pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)<br>
&gt; &gt;&gt;&gt; @@ -110,14 +140,6 @@ $(SWIGSO): $(SWIGLOBJ)<br>
&gt; &gt;&gt;&gt;=C2=A0 $(SWIGRUBYSO): $(SWIGRUBYLOBJ)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $=
^ -L. -lselinux $(LDFLAGS) -L$(LIBDIR)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -$(LIBA): $(OBJS)<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0$(AR) rcs $@ $^<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0$(RANLIB) $@<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -$(LIBSO): $(LOBJS)<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ $(P=
CRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,re=
lro<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0ln -sf $@ $(TARGET)<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;=C2=A0 $(LIBPC): $(LIBPC).in ../VERSION<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sed -e &#39;s/@VERSION@/$(VERSI=
ON)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLU=
DEDIR):&#39; &lt; $&lt; &gt; $@<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -130,12 +152,6 @@ $(AUDIT2WHYLOBJ): audit2why.c<br>
&gt; &gt;&gt;&gt;=C2=A0 $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $=
^ -L. $(LDFLAGS) -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -%.o:=C2=A0 %.c policy.h<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@=
 $&lt;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; -%.lo:=C2=A0 %.c policy.h<br>
&gt; &gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -fPIC -DSHARED -c -o=
 $@ $&lt;<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;=C2=A0 $(SWIGCOUT): $(SWIGIF)<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(SWIG) $&lt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; @@ -178,4 +194,6 @@ distclean: clean<br>
&gt; &gt;&gt;&gt;=C2=A0 indent:<br>
&gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0../../scripts/Lindent $(filter-=
out $(GENERATED),$(wildcard *.[ch]))<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -.PHONY: all clean pywrap rubywrap swigify install instal=
l-pywrap install-rubywrap distclean<br>
&gt; &gt;&gt;&gt; +.PHONY: clean pywrap rubywrap swigify install install-py=
wrap install-rubywrap distclean<br>
&gt; &gt;&gt;&gt; +endif<br>
&gt; &gt;&gt;&gt; +.PHONY: all<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Why is this needed?<br>
&gt; &gt;<br>
&gt; &gt; The targets for %.o and %.lo are used on all build targets, the r=
est<br>
&gt; &gt; is committed on ANDROID_HOST=3Dy.<br>
&gt; &gt; So for the stuff that is separated out, we have a .PHONY for it. =
For<br>
&gt; &gt; the things the define in common,<br>
&gt; &gt; notably ALL, we have a shared .PHONY for them.<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BTW, this option can be dangerous.=C2=A0 Don&#39;t build with=
 it and then do a<br>
&gt; &gt;&gt; make install later without doing a make clean - you&#39;ll br=
ick your Linux<br>
&gt; &gt;&gt; system ;(<br>
&gt; &gt;<br>
&gt; &gt; That is true, but isn&#39;t that the point of SE Linux :-P. Kiddi=
ng aside,<br>
&gt; &gt; perhaps we<br>
&gt; &gt; could create a guard file that&#39;s checked on install, if its t=
here, you need to<br>
&gt; &gt; run make clean first.<br>
&gt; &gt;</p>
<p dir=3D"ltr">OK good to know, I ran into issues, but it might have been f=
ore I had the rest of it sorted out.</p>

--94eb2c046e1e84c26e053d802d04--
