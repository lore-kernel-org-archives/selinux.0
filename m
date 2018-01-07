Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w07KdcnH007420
 for <selinux@tycho.nsa.gov>; Sun, 7 Jan 2018 15:39:38 -0500
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
 [209.85.215.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id AA2C5564AE9
 for <selinux@tycho.nsa.gov>; Sun,  7 Jan 2018 21:38:59 +0100 (CET)
Received: by mail-lf0-f49.google.com with SMTP id y71so10097229lfd.12
 for <selinux@tycho.nsa.gov>; Sun, 07 Jan 2018 12:38:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180103211346.27213-1-marcus.folkesson@gmail.com>
References: <20180103162955.22677-1-marcus.folkesson@gmail.com>
 <20180103211346.27213-1-marcus.folkesson@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 7 Jan 2018 21:38:58 +0100
Message-ID: <CAJfZ7=kaGwRKBGD1os2ApK0cUBkEzhiQnE3s3RSWaHBU9Z1tFg@mail.gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2] libselinux: introduce PCPREFIX substitute
 variable for .pc files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jan 3, 2018 at 10:13 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> `prefix` in the .pc file may be messed up when using a buildsystem
> that has specified a sysroot as DESTDIR.
> We need to make it possible to override the default `libdir`
> and `includedir`.
>
> `includedir` may be overridden by `INCLUDEDIR` but `libdir` is using
> `PREFIX` to setup the path.
>
> Therefore, introduce PCPREFIX to make it possible to generate a more
> customized .pc file.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Looks good to me. This patch does not seem to break the existing usage
and adds more flexibility for packagers. By the way, I was worried by
the modification on INCLUDEDIR, but as this variable is only used to
generate pkg-config files, it is reasonable to use PCPREFIX instead of
PREFIX in its definition.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

> ---
>
> v2:
>         - Reword commit message to be easier to understand...
>
>  libselinux/src/Makefile  | 5 +++--
>  libsemanage/src/Makefile | 5 +++--
>  libsepol/src/Makefile    | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 18df75c8..baa2ba0f 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -9,9 +9,10 @@ PKG_CONFIG ?= pkg-config
>
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> +PCPREFIX ?= $(PREFIX)
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
> -INCLUDEDIR ?= $(PREFIX)/include
> +INCLUDEDIR ?= $(PCPREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
> @@ -148,7 +149,7 @@ $(LIBSO): $(LOBJS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
>
>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index fdb178f5..8fe2f6dd 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -9,9 +9,10 @@ PKG_CONFIG ?= pkg-config
>
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> +PCPREFIX ?= $(PREFIX)
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
> -INCLUDEDIR ?= $(PREFIX)/include
> +INCLUDEDIR ?= $(PCPREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>  PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>  PYSITEDIR ?= $(DESTDIR)$(shell $(PYTHON) -c 'import site; print(site.getsitepackages()[0])')
> @@ -95,7 +96,7 @@ $(LIBSO): $(LOBJS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
>
>  semanageswig_python_exception.i: ../include/semanage/semanage.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 819d261b..59c287aa 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -1,6 +1,7 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> -INCLUDEDIR ?= $(PREFIX)/include
> +PCPREFIX ?= $(PREFIX)
> +INCLUDEDIR ?= $(PCPREFIX)/include
>  LIBDIR ?= $(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  RANLIB ?= ranlib
> @@ -52,7 +53,7 @@ $(LIBSO): $(LOBJS) $(LIBMAP)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PCPREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):' < $< > $@
>
>  $(LIBMAP): $(LIBMAP).in
>  ifneq ($(DISABLE_CIL),y)
> --
> 2.15.1
>
>
