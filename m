Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25270217F54
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049099; cv=none; b=TGXMFp+/NT/+19OjgsKsxddut6g7Re/y2s35kXEBN0Egpusx+L97pTXmkgANESa9K1wMqpmcFF27xI+fLS9pIGlECV4adQWfKQHoRHctkverq+WmgXybZYHBa3LDDnPEPLaKN92xp9JvHYHa6ZlWpxZow4MQB5Inngi5PHw/nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049099; c=relaxed/simple;
	bh=FRfDaXkIH3xOMw1NScF0kIcwDlAWPH4LGSTV5P0k+d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gvb8IZPsVTXeUwUZ2///MplQg9Xk62Alz7D4LTk/9u05/r5oQwNtjk4CgexFLFhvSDuzfCDQbP7GQX7mFio914A03qnZSREp3KQZYrYbFSja0PNqsS5RVPG67MvCypDcS3Gb6OdrJO2bJkp/yV29felaeEr2/5FJZ8bOYKG2QgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp93rKkL; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp93rKkL"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-873ac8037ecso721384241.3
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049096; x=1744653896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbljRotb4WidCnanKUTDN3hDenZA0TLu6KDun1NJcbE=;
        b=bp93rKkL5XxSpr1eD7lg3Y607aaKuT0Szoa8E99oRmoTNO7JXbZoZV8MdaQ+s/a+F8
         uVaoXxS/+hN6Ukq/RY+kSilLq/Rvh12E9u9NHex1sRDtLYEQLwv/XKC99DIHmCNnZuml
         Nmp0bJtY8hDsAILSHEirvaiQq+73F7+RaET5OlEygaic9AXFCeDDg2clBMtJ8HGgyQSP
         iguyh57uegyXpwh+jEbrZu9KLHMcuYukNtwHzwy7bRHQ1hHHcdrOhgrQ0YKYS2qWU8t9
         3bqdzsjc6JTI9fOlX4t4G4P/z4JPLkXgqsKYhRpg1hENLOrX7drNsq/N3P1RcGLKKQt/
         1ODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049096; x=1744653896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbljRotb4WidCnanKUTDN3hDenZA0TLu6KDun1NJcbE=;
        b=KOq+PyKh79TQ98Ad/UfPOk/LPBb2nvgoWegtL6DYlxgS1rr+MzvVv0SX9kvySAlTot
         slDYeiHLf0ww3/DAos2CvgHB44p0cUVp8rrx3XIt7WGnB7iANgLcWvCgtaVBkK4CcScK
         XoavoIqTqY/hbc1/kt4UC05Rx8m8iz8Q3EgQCtqFZp8xo91+LkaNpZ4qxBnkiI0Rjrmo
         Ha09QPde2c7+a0tqA8k0TZt8V4IVzsVfdzwxS82F+X9OSuqNySPjLDJAa/ie6hutzrio
         4KRb7g5YhK2X9RvSxw+VY463Llo6HBGpb6SAwXDW3R57MPPlCPY+ekJZhgb/en8h7VMq
         5Zhw==
X-Gm-Message-State: AOJu0YyWgRNxCBNIenZVGZXXudR7eLA34FPor1SWKLWG44MpJeSQfifH
	cYIiBDJ9XqVSR2u5Xulwo07eMDtYBNVZD14iA5IFcDOiSwyIu03roD+3VBN5/Oht4lV0zO3ya8f
	RWaX3Te5TPhJ0ne5FowtQ8Dtb2Lw9SQ==
X-Gm-Gg: ASbGncuEMLaqBvtN7ydZ2zVNwbEUy3L9MWIPFml22teUM6koqHNCLP8bm1YHtczT9ws
	z9HjWdyO3912bFCc5hZY3vLD3l0Tocq06hhXruaza+9TmjJYiGVeV+8ySPwqwIIEyVXPJ1CRDmp
	aZ9N9CqG7hNIkyxy0u45/EXT4=
X-Google-Smtp-Source: AGHT+IHXwdpsy1uzwB8ouFNfwtyXgLTNOGKvK90aEwNJjN4RrJ8LRNycfMH0KRmTBzqaMzXPnb4iNmLDjhdUK5CcL+A=
X-Received: by 2002:a05:6102:3fa6:b0:4b2:adfb:4f91 with SMTP id
 ada2fe7eead31-4c86377d228mr7315560137.21.1744049095635; Mon, 07 Apr 2025
 11:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211211651.1297357-3-hi@alyssa.is> <CAP+JOzRb1K9nKJTvKSFMrQMf_GzHLpoc98VxS-NKuN9zPgJ8fA@mail.gmail.com>
In-Reply-To: <CAP+JOzRb1K9nKJTvKSFMrQMf_GzHLpoc98VxS-NKuN9zPgJ8fA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:04:44 -0400
X-Gm-Features: ATxdqUFeIFVT1wwT6ETUts8BebT6tvdnO-WcXTJ9mIbwo69d7l-MEObzcRcPyO8
Message-ID: <CAP+JOzTTWvMGuWtPC=KddnBHx0R7pmY5fegTtmngu-BqnOvuoA@mail.gmail.com>
Subject: Re: [PATCH v3] Support static-only builds
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:38=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Tue, Feb 11, 2025 at 4:20=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
> >
> > Sometimes it's useful to have a static-only toolchain.  This can be
> > due to targetting some weird embedded platform, or it can be because
> > it ensures that no dynamic libraries are sneaking into a system that's
> > supposed to be 100% static due to non-cooperative build systems.  Most
> > build systems support static-only builds, e.g. autoconf provides a
> > --disable-shared configure option.
> >
> > selinux's custom make-based build system did not support such an
> > option, so here I've added one.  Apart from the obvious changes, I had
> > to make the utilities that use external libraries link against them
> > manually, because that can't be inferred from the static selinux
> > libraries.  For downstream users of libselinux using pkg-config, this
> > shouldn't be a problem, because libselinux.pc already includes the
> > Requires.private line that specifies libpcre should be linked against
> > as well.
> >
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Changes since v3:
> >
> >  =E2=80=A2 Resolve conflicts.
> >  =E2=80=A2 Add selabel_compare to PCRE_USERS.
> >  =E2=80=A2 Use pkg-config for libselinux in policycoreutils, so PCRE is=
 linked.
> >
> > v2: https://lore.kernel.org/selinux/20211113141616.361640-1-hi@alyssa.i=
s
> >
> >  libselinux/src/Makefile              | 11 ++++++++---
> >  libselinux/utils/Makefile            |  8 +++++++-
> >  libsemanage/src/Makefile             |  9 +++++++--
> >  libsepol/src/Makefile                | 11 ++++++++---
> >  policycoreutils/Makefile             |  5 +++++
> >  policycoreutils/load_policy/Makefile |  2 +-
> >  policycoreutils/newrole/Makefile     |  2 +-
> >  policycoreutils/run_init/Makefile    |  2 +-
> >  policycoreutils/secon/Makefile       |  2 +-
> >  policycoreutils/semodule/Makefile    |  3 ++-
> >  policycoreutils/sestatus/Makefile    |  2 +-
> >  policycoreutils/setfiles/Makefile    |  2 +-
> >  policycoreutils/setsebool/Makefile   |  3 ++-
> >  policycoreutils/unsetfiles/Makefile  |  2 +-
> >  14 files changed, 46 insertions(+), 18 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 213c7d34..261c22d4 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -147,7 +147,10 @@ endif
> >
> >  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_=
FLAGS)
> >
> > -all: $(LIBA) $(LIBSO) $(LIBPC)
> > +all: $(LIBA) $(LIBPC)
> > +ifneq ($(DISABLE_SHARED),y)
> > +all: $(LIBSO)
> > +endif
> >
> >  pywrap: all selinuxswig_python_exception.i
> >         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup=
.py build_ext
> > @@ -186,11 +189,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
> >  install: all
> >         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LI=
BDIR)
> >         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> > -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(=
SHLIBDIR)
> > -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> >         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DE=
STDIR)$(LIBDIR)/pkgconfig
> >         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> > +ifneq ($(DISABLE_SHARED),y)
> > +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(=
SHLIBDIR)
> > +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> >         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LI=
BDIR)/$(TARGET)
> > +endif
> >
> >  install-pywrap: pywrap
> >         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pi=
p install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTD=
IR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index 0d7095b1..6b1dc7c9 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -53,7 +53,13 @@ else
> >  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> >  endif
> >
> > -sefcontext_compile: LDLIBS +=3D ../src/libselinux.a $(PCRE_LDLIBS) -ls=
epol
> > +sefcontext_compile: LDLIBS +=3D ../src/libselinux.a -lsepol
> > +
> > +PCRE_USERS =3D matchpathcon sefcontext_compile selabel_compare \
> > +       selabel_digest selabel_get_digests_all_partial_matches \
> > +       selabel_lookup selabel_lookup_best_match \
> > +       selabel_partial_match
> > +$(PCRE_USERS): LDLIBS +=3D $(PCRE_LDLIBS)
> >
> >  all: $(TARGETS)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 8dfbd762..7d60b1e9 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -67,7 +67,10 @@ SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir .=
/
> >
> >  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
> >
> > -all: $(LIBA) $(LIBSO) $(LIBPC)
> > +all: $(LIBA) $(LIBPC)
> > +ifneq ($(DISABLE_SHARED),y)
> > +all: $(LIBSO)
> > +endif
> >
> >  pywrap: all $(SWIGSO)
> >
> > @@ -137,11 +140,13 @@ swigify: $(SWIGIF)
> >  install: all
> >         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LI=
BDIR)
> >         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> > -       install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
> >         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DE=
STDIR)$(LIBDIR)/pkgconfig
> >         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> >         test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install =
-m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
> > +ifneq ($(DISABLE_SHARED),y)
> > +       install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
> >         cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> > +endif
> >
> >  install-pywrap: pywrap
> >         test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDI=
R)$(PYTHONLIBDIR)
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index 71fa3ed7..a1aed072 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -45,7 +45,10 @@ LDFLAGS +=3D -undefined dynamic_lookup
> >  LN=3Dgln
> >  endif
> >
> > -all: $(LIBA) $(LIBSO) $(LIBPC)
> > +all: $(LIBA) $(LIBPC)
> > +ifneq ($(DISABLE_SHARED),y)
> > +all: $(LIBSO)
> > +endif
> >
> >
> >  $(LIBA):  $(OBJS)
> > @@ -87,11 +90,13 @@ endif
> >  install: all
> >         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LI=
BDIR)
> >         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> > -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(=
SHLIBDIR)
> > -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> >         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DE=
STDIR)$(LIBDIR)/pkgconfig
> >         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> > +ifneq ($(DISABLE_SHARED),y)
> > +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(=
SHLIBDIR)
> > +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
> >         $(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$=
(LIBDIR)/$(TARGET)
> > +endif
> >
> >  relabel:
> >         /sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> > diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> > index 32ad0201..7acd51dd 100644
> > --- a/policycoreutils/Makefile
> > +++ b/policycoreutils/Makefile
> > @@ -1,5 +1,10 @@
> >  SUBDIRS =3D setfiles load_policy newrole run_init secon sestatus semod=
ule setsebool scripts po man hll unsetfiles
> >
> > +PKG_CONFIG ?=3D pkg-config
> > +
> > +LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> > +export LIBSELINUX_LDLIBS
> > +
> >  all install relabel clean indent:
> >         @for subdir in $(SUBDIRS); do \
> >                 (cd $$subdir && $(MAKE) $@) || exit 1; \
> > diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/loa=
d_policy/Makefile
> > index ad80d500..37c0111b 100644
> > --- a/policycoreutils/load_policy/Makefile
> > +++ b/policycoreutils/load_policy/Makefile
> > @@ -7,7 +7,7 @@ LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> >  override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR=
)\"" -DPACKAGE=3D"\"policycoreutils\""
> > -override LDLIBS +=3D -lsepol -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS) -lsepol
> >
> >  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> >
> > diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole=
/Makefile
> > index 4b8145d3..6e95e79f 100644
> > --- a/policycoreutils/newrole/Makefile
> > +++ b/policycoreutils/newrole/Makefile
> > @@ -25,7 +25,7 @@ VERSION =3D $(shell cat ../VERSION)
> >  CFLAGS ?=3D -Werror -Wall -W
> >  EXTRA_OBJS =3D
> >  override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> > -override LDLIBS +=3D -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >  ifeq ($(PAMH), y)
> >         override CFLAGS +=3D -DUSE_PAM
> >         EXTRA_OBJS +=3D hashtab.o
> > diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_in=
it/Makefile
> > index 619ebc1d..a5002587 100644
> > --- a/policycoreutils/run_init/Makefile
> > +++ b/policycoreutils/run_init/Makefile
> > @@ -11,7 +11,7 @@ AUDITH ?=3D $(shell test -f /usr/include/libaudit.h &=
& echo y)
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> >  override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACK=
AGE=3D"\"policycoreutils\""
> > -override LDLIBS +=3D -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >  ifeq ($(PAMH), y)
> >         override CFLAGS +=3D -DUSE_PAM
> >         override LDLIBS +=3D -lpam -lpam_misc
> > diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Mak=
efile
> > index 440503a1..daa3e10e 100644
> > --- a/policycoreutils/secon/Makefile
> > +++ b/policycoreutils/secon/Makefile
> > @@ -8,7 +8,7 @@ WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-ari=
th -Wbad-function-cast -Wca
> >  VERSION =3D $(shell cat ../VERSION)
> >  CFLAGS ?=3D $(WARNS) -O1
> >  override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
> > -override LDLIBS +=3D -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >
> >  all: secon
> >
> > diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodu=
le/Makefile
> > index 9fbf99d6..3855f95e 100644
> > --- a/policycoreutils/semodule/Makefile
> > +++ b/policycoreutils/semodule/Makefile
> > @@ -5,11 +5,12 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override LDLIBS +=3D -lsepol -lselinux -lsemanage
> > +override LDLIBS +=3D -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
> >  SEMODULE_OBJS =3D semodule.o
> >
> >  all: semodule genhomedircon
> >
> > +semodule: LDLIBS +=3D -laudit -lbz2
> >  semodule: $(SEMODULE_OBJS)
> >
> >  genhomedircon:
> > diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestat=
us/Makefile
> > index aebf050c..b0df6d28 100644
> > --- a/policycoreutils/sestatus/Makefile
> > +++ b/policycoreutils/sestatus/Makefile
> > @@ -8,7 +8,7 @@ ETCDIR ?=3D /etc
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> >  override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> > -override LDLIBS +=3D -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >
> >  all: sestatus
> >
> > diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfil=
es/Makefile
> > index 84ffb08b..0b27e934 100644
> > --- a/policycoreutils/setfiles/Makefile
> > +++ b/policycoreutils/setfiles/Makefile
> > @@ -6,7 +6,7 @@ MANDIR =3D $(PREFIX)/share/man
> >  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
> >
> >  CFLAGS ?=3D -g -Werror -Wall -W
> > -override LDLIBS +=3D -lselinux -lsepol -lpthread
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS) -lsepol -lpthread
> >
> >  ifeq ($(AUDITH), y)
> >         override CFLAGS +=3D -DUSE_AUDIT
> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setse=
bool/Makefile
> > index fc5b4ff6..12b6315d 100644
> > --- a/policycoreutils/setsebool/Makefile
> > +++ b/policycoreutils/setsebool/Makefile
> > @@ -6,13 +6,14 @@ MANDIR =3D $(PREFIX)/share/man
> >  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override LDLIBS +=3D -lselinux -lsemanage
> > +override LDLIBS +=3D -lsemanage $(LIBSELINUX_LDLIBS)
> >  SETSEBOOL_OBJS =3D setsebool.o
> >
> >  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
> >
> >  all: setsebool
> >
> > +setsebool: LDLIBS +=3D -laudit -lbz2
> >  setsebool: $(SETSEBOOL_OBJS)
> >
> >  install: all
> > diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unse=
tfiles/Makefile
> > index 9e5edc04..bdc1b9de 100644
> > --- a/policycoreutils/unsetfiles/Makefile
> > +++ b/policycoreutils/unsetfiles/Makefile
> > @@ -3,7 +3,7 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR ?=3D $(PREFIX)/share/man
> >
> >  override CFLAGS +=3D -D_GNU_SOURCE
> > -override LDLIBS +=3D -lselinux
> > +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
> >
> >
> >  all: unsetfiles
> >
> > base-commit: 71aec30d068789e856e7cc429b620ae1cfa890f1
> > --
> > 2.47.0
> >
> >
