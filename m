MIME-Version: 1.0
In-Reply-To: <1474921984-24984-1-git-send-email-william.c.roberts@intel.com>
References: <1474921984-24984-1-git-send-email-william.c.roberts@intel.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 26 Sep 2016 13:39:20 -0700
Message-ID: <CAFftDdpbjpa5dcv2kNoGYjjetDD+MPBDUVsG_3dCWyVxzdOxjQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add ANDROID_HOST=y build option
To: William Roberts <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Sep 26, 2016 at 1:33 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> To build the selinux host configuration, specify
> ANDROID_HOST=y on the Make command line.
>
> eg)
> make ANDROID_HOST=y
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libselinux/Makefile     | 13 ++++++++++--
>  libselinux/src/Makefile | 54 ++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 46 insertions(+), 21 deletions(-)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 5a8d42c..b9dc7bc 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS = src include utils man
> +SUBDIRS = src

just leave these as is and override on ANDROID_HOST=y

>
>  DISABLE_AVC ?= n
>  DISABLE_SETRANS ?= n
> @@ -10,6 +10,11 @@ ifeq ($(EMBEDDED),y)
>         override DISABLE_RPM=y
>         override DISABLE_BOOL=y
>  endif
> +ifeq ($(ANDROID_HOST),y)
> +       override DISABLE_SETRANS=y
> +       EMFLAGS+= -DDISABLE_RPM -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
> +                                                                               -DBUILD_HOST
> +endif
>  ifeq ($(DISABLE_AVC),y)
>         EMFLAGS+= -DDISABLE_AVC
>  endif
> @@ -22,7 +27,7 @@ endif
>  ifeq ($(DISABLE_SETRANS),y)
>         EMFLAGS+= -DDISABLE_SETRANS
>  endif
> -export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS
> +export DISABLE_AVC DISABLE_SETRANS DISABLE_RPM DISABLE_BOOL EMFLAGS ANDROID_HOST
>
>  USE_PCRE2 ?= n
>  ifeq ($(USE_PCRE2),y)
> @@ -33,6 +38,10 @@ else
>  endif
>  export PCRE_CFLAGS PCRE_LDFLAGS
>
> +ifneq ($(ANDROID_HOST), y)
> +SUBDIRS += include utils man
> +endif
> +
>  all install relabel clean distclean indent:
>         @for subdir in $(SUBDIRS); do \
>                 (cd $$subdir && $(MAKE) $@) || exit 1; \
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 36e42b8..a1c4114 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -47,9 +47,17 @@ endif
>  ifeq ($(DISABLE_BOOL),y)
>         UNUSED_SRCS+=booleans.c
>  endif
> +ifeq ($(ANDROID_HOST),y)
> +       SRCS=callbacks.c freecon.c label.c label_file.c \
> +                       label_android_property.c regex.c label_support.c \
> +                       matchpathcon.c setrans_client.c sha1.c
> +       override CFLAGS += -DNO_MEDIA_BACKEND -DNO_DB_BACKEND -DNO_X_BACKEND \
> +                                                                               -DBUILD_HOST
> +else
> +       SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
> +endif
>
>  GENERATED=$(SWIGCOUT) $(SWIGRUBYCOUT) selinuxswig_python_exception.i
> -SRCS= $(filter-out $(UNUSED_SRCS) $(GENERATED) audit2why.c, $(sort $(wildcard *.c)))
>
>  MAX_STACK_SIZE=32768
>
> @@ -74,9 +82,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
>            -fipa-pure-const -Wno-suggest-attribute=pure -Wno-suggest-attribute=const \
>            -Werror -Wno-aggregate-return -Wno-redundant-decls
>
> -PCRE_LDFLAGS ?= -lpcre
> -
> -override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS) $(PCRE_CFLAGS)
> +override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE $(EMFLAGS)

This seems to have been clobbered resolving a merge-conflict, correct.

>
>  SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
>                 -Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
> @@ -92,6 +98,28 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./ $(EMFLAGS)
>
>  SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(EMFLAGS)
>
> +$(LIBA): $(OBJS)
> +       $(AR) rcs $@ $^
> +       $(RANLIB) $@
> +
> +$(LIBSO): $(LOBJS)
> +       $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> +       ln -sf $@ $(TARGET)
> +
> +%.o:  %.c policy.h
> +       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> +
> +%.lo:  %.c policy.h
> +       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> +
> +# ANDROID_HOST Build option only builds the shared and static versions of
> +# libselinux.
> +ifeq ($(ANDROID_HOST),y)
> +
> +all: $(LIBA) $(LIBSO)
> +
> +else
> +
>  all: $(LIBA) $(LIBSO) $(LIBPC)
>
>  pywrap: all $(SWIGFILES) $(AUDIT2WHYSO)
> @@ -110,14 +138,6 @@ $(SWIGSO): $(SWIGLOBJ)
>  $(SWIGRUBYSO): $(SWIGRUBYLOBJ)
>         $(CC) $(CFLAGS) -shared -o $@ $^ -L. -lselinux $(LDFLAGS) -L$(LIBDIR)
>
> -$(LIBA): $(OBJS)
> -       $(AR) rcs $@ $^
> -       $(RANLIB) $@
> -
> -$(LIBSO): $(LOBJS)
> -       $(CC) $(CFLAGS) -shared -o $@ $^ $(PCRE_LDFLAGS) -ldl $(LDFLAGS) -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs,-z,relro
> -       ln -sf $@ $(TARGET)
> -
>  $(LIBPC): $(LIBPC).in ../VERSION
>         sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
>
> @@ -130,12 +150,6 @@ $(AUDIT2WHYLOBJ): audit2why.c
>  $(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
>         $(CC) $(CFLAGS) -shared -o $@ $^ -L. $(LDFLAGS) -lselinux $(LIBDIR)/libsepol.a -L$(LIBDIR)
>
> -%.o:  %.c policy.h
> -       $(CC) $(CFLAGS) $(TLSFLAGS) -c -o $@ $<
> -
> -%.lo:  %.c policy.h
> -       $(CC) $(CFLAGS) -fPIC -DSHARED -c -o $@ $<
> -
>  $(SWIGCOUT): $(SWIGIF)
>         $(SWIG) $<
>
> @@ -178,4 +192,6 @@ distclean: clean
>  indent:
>         ../../scripts/Lindent $(filter-out $(GENERATED),$(wildcard *.[ch]))
>
> -.PHONY: all clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> +.PHONY: clean pywrap rubywrap swigify install install-pywrap install-rubywrap distclean
> +endif
> +.PHONY: all
> --
> 1.9.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
