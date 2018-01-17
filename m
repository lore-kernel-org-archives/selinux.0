MIME-Version: 1.0
In-Reply-To: <20180116202327.23253-3-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
 <20180116202327.23253-3-marcus.folkesson@gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Wed, 17 Jan 2018 23:12:56 +0100
Message-ID: <CAJfZ7==ONcncWgfN7dOV7tFMqkasrsS9UG_+oRADWeFRdYCwxQ@mail.gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 02/14] libselinux: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jan 16, 2018 at 9:23 PM, Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
> This patch solves the following issues:
> - The pkg-config files generates odd paths when using DESTDIR without PREFIX
> - DESTDIR is needed during compile time to compute library and header paths which it should not.
> - Installing with both DESTDIR and PREFIX set gives us odd paths
> - Make usage of DESTDIR and PREFIX more standard
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  libselinux/include/Makefile     |  4 ++--
>  libselinux/man/Makefile         |  7 ++++---
>  libselinux/src/Makefile         | 12 +++++-------
>  libselinux/src/libselinux.pc.in |  2 +-
>  libselinux/utils/Makefile       |  6 ++----
>  5 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/libselinux/include/Makefile b/libselinux/include/Makefile
> index 757a6c9c..3b51f5ce 100644
> --- a/libselinux/include/Makefile
> +++ b/libselinux/include/Makefile
> @@ -1,6 +1,6 @@
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -INCDIR ?= $(PREFIX)/include/selinux
> +PREFIX ?= /usr
> +INCDIR = $(DESTDIR)$(PREFIX)/include/selinux
>
>  all:
>
> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> index 0643e6af..233bfaa9 100644
> --- a/libselinux/man/Makefile
> +++ b/libselinux/man/Makefile
> @@ -1,7 +1,8 @@
>  # Installation directories.
> -MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
> -MAN5DIR ?= $(DESTDIR)/usr/share/man/man5
> -MAN3DIR ?= $(DESTDIR)/usr/share/man/man3
> +PREFIX ?= /usr
> +MAN8DIR ?= $(DESTDIR)$(PREFIX)/share/man/man8
> +MAN5DIR ?= $(DESTDIR)$(PREFIX)/share/man/man5
> +MAN3DIR ?= $(DESTDIR)$(PREFIX)/share/man/man3
>
>  all:
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 18df75c8..18a58164 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -8,8 +8,8 @@ RUBYPREFIX ?= $(notdir $(RUBY))
>  PKG_CONFIG ?= pkg-config
>
>  # Installation directories.
> -PREFIX ?= $(DESTDIR)/usr
> -LIBDIR ?= $(PREFIX)/lib
> +PREFIX ?= /usr
> +LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
>  SHLIBDIR ?= $(DESTDIR)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
> @@ -19,8 +19,6 @@ PYCEXT ?= $(shell $(PYTHON) -c 'import imp;print([s for s,m,t in imp.get_suffixe
>  RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] + " -I" + RbConfig::CONFIG["rubyhdrdir"]')
>  RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
>  RUBYINSTALL ?= $(DESTDIR)$(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
> -LIBBASE ?= $(shell basename $(LIBDIR))
> -LIBSEPOLA ?= $(LIBDIR)/libsepol.a
>
>  VERSION = $(shell cat ../VERSION)
>  LIBVERSION = 1
> @@ -148,7 +146,7 @@ $(LIBSO): $(LOBJS)
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> -       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBBASE):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
> +       sed -e 's/@VERSION@/$(VERSION)/; s:@prefix@:$(PREFIX):; s:@libdir@:$(LIBDIR):; s:@includedir@:$(INCLUDEDIR):; s:@PCRE_MODULE@:$(PCRE_MODULE):' < $< > $@
>
>  selinuxswig_python_exception.i: ../include/selinux/selinux.h
>         bash -e exception.sh > $@ || (rm -f $@ ; false)
> @@ -156,8 +154,8 @@ selinuxswig_python_exception.i: ../include/selinux/selinux.h
>  $(AUDIT2WHYLOBJ): audit2why.c
>         $(CC) $(filter-out -Werror, $(CFLAGS)) $(PYINC) -fPIC -DSHARED -c -o $@ $<
>
> -$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ) $(LIBSEPOLA)
> -       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS)
> +$(AUDIT2WHYSO): $(AUDIT2WHYLOBJ)
> +       $(CC) $(CFLAGS) $(LDFLAGS) -L. -shared -o $@ $^ -lselinux $(PYLIBS) -l:libsepol.a

Hello,
This change makes audit2why.so no longer being rebuilt when libsepol's
code change. This is an issue when debugging issues in libsepol, which
is why I added $(LIBSEPOLA) to the dependencies of $(AUDIT2WHYSO) in
commit dcd135cc06ab ("Re-link programs after libsepol.a is updated"
[1]).
By the way, I like the change from using a "hardcoded" path to
libsepol.a to telling the compiler to look into directories specified
with option -L in LDFLAGS. This would ease the packaging a little bit,
as it makes defining LIBSEPOLA no longer necessary (if I understood
the changes correctly, I have not tested this point). Is there a way
to ask the compiler for the resolved location of a static library, in
a way which can be used to compute the value of LIBSEPOLA? ("gcc
-Wl,--trace ..." displays it but it is not easily usable).

Best regards,
Nicolas

[1] https://github.com/SELinuxProject/selinux/commit/dcd135cc06abd8cd662d2d7a896e368f09380dd2
