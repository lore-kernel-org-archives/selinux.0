MIME-Version: 1.0
In-Reply-To: <12cf1eaf-47e5-25ba-dae2-a02705e9ba68@tycho.nsa.gov>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
 <1476735850-7844-6-git-send-email-william.c.roberts@intel.com>
 <12cf1eaf-47e5-25ba-dae2-a02705e9ba68@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 18 Oct 2016 08:43:16 -0400
Message-ID: <CAFftDdrZ7c6MQ=tPwQdtE0-xpTqHk1ePFOzJ4pgV1_3hEWQTqg@mail.gmail.com>
Subject: Re: [PATCH 6/8] libselinux: support ANDROID_HOST=1 on Mac
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <william.c.roberts@intel.com>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=94eb2c073c685ae5d6053f230987
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c073c685ae5d6053f230987
Content-Type: text/plain; charset=UTF-8

On Oct 18, 2016 08:41, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
>
> On 10/17/2016 04:24 PM, william.c.roberts@intel.com wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > To build on mac, first build libsepol with
> > DISABLE_CIL=y and no DESTDIR set.
>
> DISABLE_CIL=y isn't required after the earlier patches, right?

Correct libsepol builds, I forgot to edit the commit message. I'm flying,
so if that's your only issue could you please rewrite the message?

>
> >
> > Secondly, build libselinux with ANDROID_HOST=y
> >
> > This configuration can be used to test the Android
> > host build on Mac.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  libselinux/Makefile       | 10 ++++++++++
> >  libselinux/src/Makefile   | 36 ++++++++++++++++++++++++++----------
> >  libselinux/utils/Makefile | 29 +++++++++++++++++++++--------
> >  3 files changed, 57 insertions(+), 18 deletions(-)
> >
> > diff --git a/libselinux/Makefile b/libselinux/Makefile
> > index baa0db3..ef971f4 100644
> > --- a/libselinux/Makefile
> > +++ b/libselinux/Makefile
> > @@ -27,6 +27,16 @@ else
> >  endif
> >  export PCRE_CFLAGS PCRE_LDFLAGS
> >
> > +OS := $(shell uname)
> > +export OS
> > +
> > +ifeq ($(shell $(CC) -v 2>&1 | grep "clang"),)
> > +COMPILER := gcc
> > +else
> > +COMPILER := clang
> > +endif
> > +export COMPILER
> > +
> >  all install relabel clean distclean indent:
> >       @for subdir in $(SUBDIRS); do \
> >               (cd $$subdir && $(MAKE) $@) || exit 1; \
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 13501cd..7a1ae05 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -48,23 +48,39 @@ OBJS= $(patsubst %.c,%.o,$(SRCS))
> >  LOBJS= $(patsubst %.c,%.lo,$(SRCS))
> >  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security
-Winit-self -Wmissing-include-dirs \
> >            -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow
-Wpointer-arith \
> > -          -Wbad-function-cast -Wcast-align -Wwrite-strings
-Wlogical-op -Waggregate-return \
> > +          -Wbad-function-cast -Wcast-align -Wwrite-strings
-Waggregate-return \
> >            -Wstrict-prototypes -Wold-style-definition
-Wmissing-prototypes \
> >            -Wmissing-declarations -Wmissing-noreturn
-Wmissing-format-attribute \
> >            -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch
-Wvolatile-register-var \
> > -          -Wdisabled-optimization -Wbuiltin-macro-redefined
-Wpacked-bitfield-compat \
> > -          -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar
-Wcpp \
> > +          -Wdisabled-optimization -Wbuiltin-macro-redefined \
> > +          -Wattributes -Wmultichar \
> >            -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion
-Wendif-labels -Wextra \
> > -          -Wformat-contains-nul -Wformat-extra-args
-Wformat-zero-length -Wformat=2 -Wmultichar \
> > -          -Wnormalized=nfc -Woverflow -Wpointer-to-int-cast -Wpragmas
-Wsuggest-attribute=const \
> > -          -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
-Wtrampolines \
> > -          -Wno-missing-field-initializers -Wno-sign-compare
-Wjump-misses-init \
> > -          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE)
-Wp,-D_FORTIFY_SOURCE=2 \
> > +          -Wformat-extra-args -Wformat-zero-length -Wformat=2
-Wmultichar \
> > +          -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > +          -Wno-missing-field-initializers -Wno-sign-compare \
> > +          -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE)
\
> >            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
\
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option
-funit-at-a-time \
> > -          -fipa-pure-const -Wno-suggest-attribute=pure
-Wno-suggest-attribute=const \
> >            -Werror -Wno-aggregate-return -Wno-redundant-decls
> >
> > +LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
> > +
> > +ifeq ($(COMPILER), gcc)
> > +override CFLAGS += -fipa-pure-const -Wlogical-op
-Wpacked-bitfield-compat -Wsync-nand \
> > +     -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
-Wsuggest-attribute=const \
> > +     -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
-Wtrampolines -Wjump-misses-init \
> > +     -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
-Wp,-D_FORTIFY_SOURCE=2
> > +else
> > +override CFLAGS += -Wunused-command-line-argument
> > +override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
> > +LD_SONAME_FLAGS=-install_name,$(LIBSO)
> > +endif
> > +
> > +ifeq ($(OS), Darwin)
> > +override CFLAGS += -I/opt/local/include
> > +override LDFLAGS += -L/opt/local/lib -undefined dynamic_lookup
> > +endif
> > +
> >  PCRE_LDFLAGS ?= -lpcre
> >
> >  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE
$(DISABLE_FLAGS) $(PCRE_CFLAGS)
> > @@ -117,7 +133,7 @@ $(LIBA): $(OBJS)
> >       $(RANLIB) $@
> >
> >  $(LIBSO): $(LOBJS)
> > -     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS)
-L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> > +     $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS)
-L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)
> >       ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index e56a953..a4f9903 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -8,22 +8,35 @@ INCLUDEDIR ?= $(PREFIX)/include
> >  MAX_STACK_SIZE=8192
> >  CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security
-Winit-self -Wmissing-include-dirs \
> >            -Wunused -Wunknown-pragmas -Wstrict-aliasing -Wshadow
-Wpointer-arith \
> > -          -Wbad-function-cast -Wcast-align -Wwrite-strings
-Wlogical-op -Waggregate-return \
> > +          -Wbad-function-cast -Wcast-align -Wwrite-strings
-Waggregate-return \
> >            -Wstrict-prototypes -Wold-style-definition
-Wmissing-prototypes \
> >            -Wmissing-declarations -Wmissing-noreturn
-Wmissing-format-attribute \
> >            -Wredundant-decls -Wnested-externs -Winline -Winvalid-pch
-Wvolatile-register-var \
> > -          -Wdisabled-optimization -Wbuiltin-macro-redefined
-Wpacked-bitfield-compat \
> > -          -Wsync-nand -Wattributes -Wcoverage-mismatch -Wmultichar
-Wcpp \
> > +          -Wdisabled-optimization -Wbuiltin-macro-redefined \
> > +          -Wattributes -Wmultichar \
> >            -Wdeprecated-declarations -Wdiv-by-zero -Wdouble-promotion
-Wendif-labels -Wextra \
> > -          -Wformat-contains-nul -Wformat-extra-args
-Wformat-zero-length -Wformat=2 -Wmultichar \
> > -          -Wnormalized=nfc -Woverflow -Wpointer-to-int-cast -Wpragmas
-Wsuggest-attribute=const \
> > -          -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
-Wtrampolines \
> > -          -Wno-missing-field-initializers -Wno-sign-compare
-Wjump-misses-init \
> > +          -Wformat-extra-args -Wformat-zero-length -Wformat=2
-Wmultichar \
> > +          -Woverflow -Wpointer-to-int-cast -Wpragmas \
> > +          -Wno-missing-field-initializers -Wno-sign-compare \
> >            -Wno-format-nonliteral -Wframe-larger-than=$(MAX_STACK_SIZE)
-Wp,-D_FORTIFY_SOURCE=2 \
> >            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
\
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option
-funit-at-a-time \
> > -          -fipa-pure-const -Wno-suggest-attribute=pure
-Wno-suggest-attribute=const \
> >            -Werror -Wno-aggregate-return -Wno-redundant-decls
> > +
> > +LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
> > +
> > +ifeq ($(COMPILER), gcc)
> > +override CFLAGS += -fipa-pure-const -Wpacked-bitfield-compat
-Wsync-nand -Wcoverage-mismatch \
> > +     -Wcpp -Wformat-contains-nul -Wnormalized=nfc
-Wsuggest-attribute=const \
> > +     -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
-Wtrampolines -Wjump-misses-init \
> > +     -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > +endif
> > +
> > +ifeq ($(OS), Darwin)
> > +override CFLAGS += -I/opt/local/include -I../../libsepol/include
> > +override LDFLAGS += -L../../libsepol/src -undefined dynamic_lookup
> > +endif
> > +
> >  override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE
$(DISABLE_FLAGS) $(PCRE_CFLAGS)
> >  LDLIBS += -L../src -lselinux -L$(LIBDIR)
> >  PCRE_LDFLAGS ?= -lpcre
> >
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Seandroid-list-request@tycho.nsa.gov.

--94eb2c073c685ae5d6053f230987
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Oct 18, 2016 08:41, &quot;Stephen Smalley&quot; &lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; On 10/17/2016 04:24 PM, <a href=3D"mailto:william.c.roberts@intel.com"=
>william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt; From: William Roberts &lt;<a href=3D"mailto:william.c.roberts@int=
el.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; To build on mac, first build libsepol with<br>
&gt; &gt; DISABLE_CIL=3Dy and no DESTDIR set.<br>
&gt;<br>
&gt; DISABLE_CIL=3Dy isn&#39;t required after the earlier patches, right?</=
p>
<p dir=3D"ltr">Correct libsepol builds, I forgot to edit the commit message=
. I&#39;m flying, so if that&#39;s your only issue could you please rewrite=
 the message?</p>
<p dir=3D"ltr">&gt;<br>
&gt; &gt;<br>
&gt; &gt; Secondly, build libselinux with ANDROID_HOST=3Dy<br>
&gt; &gt;<br>
&gt; &gt; This configuration can be used to test the Android<br>
&gt; &gt; host build on Mac.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: William Roberts &lt;<a href=3D"mailto:william.c.ro=
berts@intel.com">william.c.roberts@intel.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 libselinux/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++++++++=
++<br>
&gt; &gt;=C2=A0 libselinux/src/Makefile=C2=A0 =C2=A0| 36 ++++++++++++++++++=
++++++++----------<br>
&gt; &gt;=C2=A0 libselinux/utils/Makefile | 29 +++++++++++++++++++++-------=
-<br>
&gt; &gt;=C2=A0 3 files changed, 57 insertions(+), 18 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/libselinux/Makefile b/libselinux/Makefile<br>
&gt; &gt; index baa0db3..ef971f4 100644<br>
&gt; &gt; --- a/libselinux/Makefile<br>
&gt; &gt; +++ b/libselinux/Makefile<br>
&gt; &gt; @@ -27,6 +27,16 @@ else<br>
&gt; &gt;=C2=A0 endif<br>
&gt; &gt;=C2=A0 export PCRE_CFLAGS PCRE_LDFLAGS<br>
&gt; &gt;<br>
&gt; &gt; +OS :=3D $(shell uname)<br>
&gt; &gt; +export OS<br>
&gt; &gt; +<br>
&gt; &gt; +ifeq ($(shell $(CC) -v 2&gt;&amp;1 | grep &quot;clang&quot;),)<b=
r>
&gt; &gt; +COMPILER :=3D gcc<br>
&gt; &gt; +else<br>
&gt; &gt; +COMPILER :=3D clang<br>
&gt; &gt; +endif<br>
&gt; &gt; +export COMPILER<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 all install relabel clean distclean indent:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@for subdir in $(SUBDIRS); do \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(cd $$subdi=
r &amp;&amp; $(MAKE) $@) || exit 1; \<br>
&gt; &gt; diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile<br=
>
&gt; &gt; index 13501cd..7a1ae05 100644<br>
&gt; &gt; --- a/libselinux/src/Makefile<br>
&gt; &gt; +++ b/libselinux/src/Makefile<br>
&gt; &gt; @@ -48,23 +48,39 @@ OBJS=3D $(patsubst %.c,%.o,$(SRCS))<br>
&gt; &gt;=C2=A0 LOBJS=3D $(patsubst %.c,%.lo,$(SRCS))<br>
&gt; &gt;=C2=A0 CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-secur=
ity -Winit-self -Wmissing-include-dirs \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wunused -Wunknown-pragm=
as -Wstrict-aliasing -Wshadow -Wpointer-arith \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wbad-function-cast -Wcast-al=
ign -Wwrite-strings -Wlogical-op -Waggregate-return \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wbad-function-cast -Wcast-al=
ign -Wwrite-strings -Waggregate-return \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wstrict-prototypes -Wol=
d-style-definition -Wmissing-prototypes \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wmissing-declarations -=
Wmissing-noreturn -Wmissing-format-attribute \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wredundant-decls -Wnest=
ed-externs -Winline -Winvalid-pch -Wvolatile-register-var \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdisabled-optimization -Wbui=
ltin-macro-redefined -Wpacked-bitfield-compat \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wsync-nand -Wattributes -Wco=
verage-mismatch -Wmultichar -Wcpp \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdisabled-optimization -Wbui=
ltin-macro-redefined \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wattributes -Wmultichar \<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdeprecated-declaration=
s -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wformat-contains-nul -Wforma=
t-extra-args -Wformat-zero-length -Wformat=3D2 -Wmultichar \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wnormalized=3Dnfc -Woverflow=
 -Wpointer-to-int-cast -Wpragmas -Wsuggest-attribute=3Dconst \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wsuggest-attribute=3Dnoretur=
n -Wsuggest-attribute=3Dpure -Wtrampolines \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-missing-field-initialize=
rs -Wno-sign-compare -Wjump-misses-init \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-format-nonliteral -Wfram=
e-larger-than=3D$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=3D2 \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wformat-extra-args -Wformat-=
zero-length -Wformat=3D2 -Wmultichar \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Woverflow -Wpointer-to-int-c=
ast -Wpragmas \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-missing-field-initialize=
rs -Wno-sign-compare \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-format-nonliteral -Wfram=
e-larger-than=3D$(MAX_STACK_SIZE) \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fstack-protector-all --=
param=3Dssp-buffer-size=3D4 -fexceptions \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fasynchronous-unwind-ta=
bles -fdiagnostics-show-option -funit-at-a-time \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fipa-pure-const -Wno-suggest=
-attribute=3Dpure -Wno-suggest-attribute=3Dconst \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-r=
eturn -Wno-redundant-decls<br>
&gt; &gt;<br>
&gt; &gt; +LD_SONAME_FLAGS=3D-soname,$(LIBSO),-z,defs,-z,relro<br>
&gt; &gt; +<br>
&gt; &gt; +ifeq ($(COMPILER), gcc)<br>
&gt; &gt; +override CFLAGS +=3D -fipa-pure-const -Wlogical-op -Wpacked-bitf=
ield-compat -Wsync-nand \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wcoverage-mismatch -Wcpp -Wformat-contains-=
nul -Wnormalized=3Dnfc -Wsuggest-attribute=3Dconst \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-att=
ribute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-a=
ttribute=3Dconst -Wp,-D_FORTIFY_SOURCE=3D2<br>
&gt; &gt; +else<br>
&gt; &gt; +override CFLAGS +=3D -Wunused-command-line-argument<br>
&gt; &gt; +override LDFLAGS +=3D -L/opt/local/lib -undefined dynamic_lookup=
<br>
&gt; &gt; +LD_SONAME_FLAGS=3D-install_name,$(LIBSO)<br>
&gt; &gt; +endif<br>
&gt; &gt; +<br>
&gt; &gt; +ifeq ($(OS), Darwin)<br>
&gt; &gt; +override CFLAGS +=3D -I/opt/local/include<br>
&gt; &gt; +override LDFLAGS +=3D -L/opt/local/lib -undefined dynamic_lookup=
<br>
&gt; &gt; +endif<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 PCRE_LDFLAGS ?=3D -lpcre<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 override CFLAGS +=3D -I../include -I$(INCLUDEDIR) -D_GNU_SO=
URCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)<br>
&gt; &gt; @@ -117,7 +133,7 @@ $(LIBA): $(OBJS)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(RANLIB) $@<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 $(LIBSO): $(LOBJS)<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFL=
AGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0$(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFL=
AGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,$(LD_SONAME_FLAGS)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ln -sf $@ $(TARGET)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 $(LIBPC): $(LIBPC).in ../VERSION<br>
&gt; &gt; diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefil=
e<br>
&gt; &gt; index e56a953..a4f9903 100644<br>
&gt; &gt; --- a/libselinux/utils/Makefile<br>
&gt; &gt; +++ b/libselinux/utils/Makefile<br>
&gt; &gt; @@ -8,22 +8,35 @@ INCLUDEDIR ?=3D $(PREFIX)/include<br>
&gt; &gt;=C2=A0 MAX_STACK_SIZE=3D8192<br>
&gt; &gt;=C2=A0 CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-secur=
ity -Winit-self -Wmissing-include-dirs \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wunused -Wunknown-pragm=
as -Wstrict-aliasing -Wshadow -Wpointer-arith \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wbad-function-cast -Wcast-al=
ign -Wwrite-strings -Wlogical-op -Waggregate-return \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wbad-function-cast -Wcast-al=
ign -Wwrite-strings -Waggregate-return \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wstrict-prototypes -Wol=
d-style-definition -Wmissing-prototypes \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wmissing-declarations -=
Wmissing-noreturn -Wmissing-format-attribute \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wredundant-decls -Wnest=
ed-externs -Winline -Winvalid-pch -Wvolatile-register-var \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdisabled-optimization -Wbui=
ltin-macro-redefined -Wpacked-bitfield-compat \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wsync-nand -Wattributes -Wco=
verage-mismatch -Wmultichar -Wcpp \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdisabled-optimization -Wbui=
ltin-macro-redefined \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wattributes -Wmultichar \<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wdeprecated-declaration=
s -Wdiv-by-zero -Wdouble-promotion -Wendif-labels -Wextra \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wformat-contains-nul -Wforma=
t-extra-args -Wformat-zero-length -Wformat=3D2 -Wmultichar \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wnormalized=3Dnfc -Woverflow=
 -Wpointer-to-int-cast -Wpragmas -Wsuggest-attribute=3Dconst \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wsuggest-attribute=3Dnoretur=
n -Wsuggest-attribute=3Dpure -Wtrampolines \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-missing-field-initialize=
rs -Wno-sign-compare -Wjump-misses-init \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wformat-extra-args -Wformat-=
zero-length -Wformat=3D2 -Wmultichar \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Woverflow -Wpointer-to-int-c=
ast -Wpragmas \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-missing-field-initialize=
rs -Wno-sign-compare \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Wno-format-nonliteral -=
Wframe-larger-than=3D$(MAX_STACK_SIZE) -Wp,-D_FORTIFY_SOURCE=3D2 \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fstack-protector-all --=
param=3Dssp-buffer-size=3D4 -fexceptions \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fasynchronous-unwind-ta=
bles -fdiagnostics-show-option -funit-at-a-time \<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -fipa-pure-const -Wno-suggest=
-attribute=3Dpure -Wno-suggest-attribute=3Dconst \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -Werror -Wno-aggregate-r=
eturn -Wno-redundant-decls<br>
&gt; &gt; +<br>
&gt; &gt; +LD_SONAME_FLAGS=3D-soname,$(LIBSO),-z,defs,-z,relro<br>
&gt; &gt; +<br>
&gt; &gt; +ifeq ($(COMPILER), gcc)<br>
&gt; &gt; +override CFLAGS +=3D -fipa-pure-const -Wpacked-bitfield-compat -=
Wsync-nand -Wcoverage-mismatch \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wcpp -Wformat-contains-nul -Wnormalized=3Dn=
fc -Wsuggest-attribute=3Dconst \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wsuggest-attribute=3Dnoreturn -Wsuggest-att=
ribute=3Dpure -Wtrampolines -Wjump-misses-init \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0-Wno-suggest-attribute=3Dpure -Wno-suggest-a=
ttribute=3Dconst<br>
&gt; &gt; +endif<br>
&gt; &gt; +<br>
&gt; &gt; +ifeq ($(OS), Darwin)<br>
&gt; &gt; +override CFLAGS +=3D -I/opt/local/include -I../../libsepol/inclu=
de<br>
&gt; &gt; +override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lo=
okup<br>
&gt; &gt; +endif<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 override CFLAGS +=3D -I../include -I$(INCLUDEDIR) -D_GNU_SO=
URCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)<br>
&gt; &gt;=C2=A0 LDLIBS +=3D -L../src -lselinux -L$(LIBDIR)<br>
&gt; &gt;=C2=A0 PCRE_LDFLAGS ?=3D -lpcre<br>
&gt; &gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Seandroid-list mailing list<br>
&gt; <a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.n=
sa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave@t=
ycho.nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.ns=
a.gov</a>.<br></p>

--94eb2c073c685ae5d6053f230987--
