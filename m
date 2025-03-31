Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D0217719
	for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435555; cv=none; b=CX+gvN1ySuJB5nuIjYHCLvo9jTo9wCr0ZIXY3anO/qNkeKhKrpIBkONtNqnYVR0T1qQiS71xYg6XV4/i8moHeHUwYLEdavdAyQuqM7qQydDw7mO1DdLRb0GniPlxxOEODsdLchRxdl2LBvl74bC1sqfKHxNOLy14+94AfjQ6S1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435555; c=relaxed/simple;
	bh=cLmCWXLwuRPZfLdQt8u98JXEdL0iO+PPefFeOf29APQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2PTX0Elv1mZ/1gmIRrQvQmTyDUd4e/p8R3o97GpHZY9rQV5ML1QfJ3HKFD+lEFA+WQ59f/pNV6YLZDPXr4F0X1yDKuwV8SKKCh8hjfpjsPCpg0QcQrWAhU49UkHgG3e39z53r/X1/gO/p0quMDBDD4cLhHqdu4xsUcKLtWizbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUI17axL; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUI17axL"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d587dbc15so4266862241.1
        for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435550; x=1744040350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T61R6neEXnaFyT+Lh/FaBvAi2MVRYQbDPT0KhfyuR24=;
        b=HUI17axLYZxGtetTofIVcOoCd2ePsZpp2nOeOZMLLif5N2HfJQj15kJJFxAgBLET8F
         CSwuR/a4JIdNM0KPPXFLEXeMLcfwgKu6Pj1e9qN7EiF9UQSaRmzLWLIapVsieO+dzoYa
         Cmm4QFuEN0PAzXSVLhqff1cvSy0Asr3G1i4X8Xdl66qFWNdIh8Ilk/MM4JkzH9KXJnY7
         9icV8pO3fHFtSjMfMJNcKu5aNvnoiwAu5/IlxZRKd/lffdHZxxhjSwYOsWLn6Ub+gu7+
         /8q7A+/Z38ejYYUe7LxKFXZU6Q4LEYSUs8yTz9sOmX8P95HOK91Prc2MIpXC1UezNYt0
         kNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435550; x=1744040350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T61R6neEXnaFyT+Lh/FaBvAi2MVRYQbDPT0KhfyuR24=;
        b=Jjzlmrc22vOVsS+vbXZIBly+xXC0vc4pYhZn+etEE2sN/9TKLGo2Kb3NgPV5+m5a5U
         donj9OJIxl/9seFmPylGZCUnG439if8onZr7Hn0KRqpu3qh6Eb8jiLaFfetfIrqBQd+i
         vNhmIPizeooATSzUcQXpNlnk//OzLFHs5Wn7FXOpsSOuRYdvrrbiYps773zoTHZg1yiz
         94XVA387Bc1had4kaE+vrup1mLIhnsWH1cooNvIee6gp7FVgDWa3HlCQb5mKOGpHFR7+
         GV0JUSIVouYZBrsb/yLFqzwkt0oth2I06DyFm/HdIM4OGda3th+cIJa0U2revutMQ2Sj
         ioTA==
X-Gm-Message-State: AOJu0YyOjDSnpw16lQlehKg7hipo9N7vWc10SBeEQlsWObJcyeVeEUKb
	ZjT4f7TDmIEwxa1yODBK4NTkxxDnrD0zn7Rnw4m5cuMKuwpKIjj9VODoYGLSptaZ/phdQ6IrxoT
	fRDHFyjeQFanyIdSVdJMFqEzNZAh/2mXH
X-Gm-Gg: ASbGnctudrb1p57snfWAB0n5QLKvsTf7q3EVj/kKDyTgLRrZeJkfEnKQ5MasmmqXzt4
	HK/29ta2889JK5lEjM2JkJA21A0jdhAy9HuX41C2mtfB5WeRlPhQdf9++3CVXmrRfsFaSJiCt5E
	UdLDciK9L+t0F2khd6l1Iq2d4=
X-Google-Smtp-Source: AGHT+IF8YZWwOP/kb/VxZokfErKCNzIiRaEtZuQlJq1BLwJYz+X4Uxv5ULGLOs74rVUnfFrPGKNCoh41WHYZ+CEzeY8=
X-Received: by 2002:a05:6102:a4a:b0:4c1:492a:d75b with SMTP id
 ada2fe7eead31-4c6c261e792mr8247737137.2.1743435549549; Mon, 31 Mar 2025
 08:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211211651.1297357-3-hi@alyssa.is>
In-Reply-To: <20250211211651.1297357-3-hi@alyssa.is>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 31 Mar 2025 11:38:58 -0400
X-Gm-Features: AQ5f1JpMIk0bBJ0lYaLQfwcQqR-Tr3M-7Jn8jr517efRNr6rV41Ge0FEozRgFrs
Message-ID: <CAP+JOzRb1K9nKJTvKSFMrQMf_GzHLpoc98VxS-NKuN9zPgJ8fA@mail.gmail.com>
Subject: Re: [PATCH v3] Support static-only builds
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 4:20=E2=80=AFPM Alyssa Ross <hi@alyssa.is> wrote:
>
> Sometimes it's useful to have a static-only toolchain.  This can be
> due to targetting some weird embedded platform, or it can be because
> it ensures that no dynamic libraries are sneaking into a system that's
> supposed to be 100% static due to non-cooperative build systems.  Most
> build systems support static-only builds, e.g. autoconf provides a
> --disable-shared configure option.
>
> selinux's custom make-based build system did not support such an
> option, so here I've added one.  Apart from the obvious changes, I had
> to make the utilities that use external libraries link against them
> manually, because that can't be inferred from the static selinux
> libraries.  For downstream users of libselinux using pkg-config, this
> shouldn't be a problem, because libselinux.pc already includes the
> Requires.private line that specifies libpcre should be linked against
> as well.
>
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Changes since v3:
>
>  =E2=80=A2 Resolve conflicts.
>  =E2=80=A2 Add selabel_compare to PCRE_USERS.
>  =E2=80=A2 Use pkg-config for libselinux in policycoreutils, so PCRE is l=
inked.
>
> v2: https://lore.kernel.org/selinux/20211113141616.361640-1-hi@alyssa.is
>
>  libselinux/src/Makefile              | 11 ++++++++---
>  libselinux/utils/Makefile            |  8 +++++++-
>  libsemanage/src/Makefile             |  9 +++++++--
>  libsepol/src/Makefile                | 11 ++++++++---
>  policycoreutils/Makefile             |  5 +++++
>  policycoreutils/load_policy/Makefile |  2 +-
>  policycoreutils/newrole/Makefile     |  2 +-
>  policycoreutils/run_init/Makefile    |  2 +-
>  policycoreutils/secon/Makefile       |  2 +-
>  policycoreutils/semodule/Makefile    |  3 ++-
>  policycoreutils/sestatus/Makefile    |  2 +-
>  policycoreutils/setfiles/Makefile    |  2 +-
>  policycoreutils/setsebool/Makefile   |  3 ++-
>  policycoreutils/unsetfiles/Makefile  |  2 +-
>  14 files changed, 46 insertions(+), 18 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 213c7d34..261c22d4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -147,7 +147,10 @@ endif
>
>  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FL=
AGS)
>
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>
>  pywrap: all selinuxswig_python_exception.i
>         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.p=
y build_ext
> @@ -186,11 +189,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBD=
IR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SH=
LIBDIR)
> -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DEST=
DIR)$(LIBDIR)/pkgconfig
>         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SH=
LIBDIR)
> +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBD=
IR)/$(TARGET)
> +endif
>
>  install-pywrap: pywrap
>         CFLAGS=3D"$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip =
install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR=
) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 0d7095b1..6b1dc7c9 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -53,7 +53,13 @@ else
>  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  endif
>
> -sefcontext_compile: LDLIBS +=3D ../src/libselinux.a $(PCRE_LDLIBS) -lsep=
ol
> +sefcontext_compile: LDLIBS +=3D ../src/libselinux.a -lsepol
> +
> +PCRE_USERS =3D matchpathcon sefcontext_compile selabel_compare \
> +       selabel_digest selabel_get_digests_all_partial_matches \
> +       selabel_lookup selabel_lookup_best_match \
> +       selabel_partial_match
> +$(PCRE_USERS): LDLIBS +=3D $(PCRE_LDLIBS)
>
>  all: $(TARGETS)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 8dfbd762..7d60b1e9 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -67,7 +67,10 @@ SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
>
>  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>
>  pywrap: all $(SWIGSO)
>
> @@ -137,11 +140,13 @@ swigify: $(SWIGIF)
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBD=
IR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -       install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
>         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DEST=
DIR)$(LIBDIR)/pkgconfig
>         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
>         test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m=
 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
> +ifneq ($(DISABLE_SHARED),y)
> +       install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
>         cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +endif
>
>  install-pywrap: pywrap
>         test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)=
$(PYTHONLIBDIR)
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 71fa3ed7..a1aed072 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -45,7 +45,10 @@ LDFLAGS +=3D -undefined dynamic_lookup
>  LN=3Dgln
>  endif
>
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>
>
>  $(LIBA):  $(OBJS)
> @@ -87,11 +90,13 @@ endif
>  install: all
>         test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBD=
IR)
>         install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SH=
LIBDIR)
> -       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DEST=
DIR)$(LIBDIR)/pkgconfig
>         install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +       test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SH=
LIBDIR)
> +       install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>         $(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(L=
IBDIR)/$(TARGET)
> +endif
>
>  relabel:
>         /sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 32ad0201..7acd51dd 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,5 +1,10 @@
>  SUBDIRS =3D setfiles load_policy newrole run_init secon sestatus semodul=
e setsebool scripts po man hll unsetfiles
>
> +PKG_CONFIG ?=3D pkg-config
> +
> +LIBSELINUX_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs libselinux)
> +export LIBSELINUX_LDLIBS
> +
>  all install relabel clean indent:
>         @for subdir in $(SUBDIRS); do \
>                 (cd $$subdir && $(MAKE) $@) || exit 1; \
> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_=
policy/Makefile
> index ad80d500..37c0111b 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -7,7 +7,7 @@ LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
>
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\=
"" -DPACKAGE=3D"\"policycoreutils\""
> -override LDLIBS +=3D -lsepol -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS) -lsepol
>
>  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
>
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/M=
akefile
> index 4b8145d3..6e95e79f 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -25,7 +25,7 @@ VERSION =3D $(shell cat ../VERSION)
>  CFLAGS ?=3D -Werror -Wall -W
>  EXTRA_OBJS =3D
>  override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=3D=
"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> -override LDLIBS +=3D -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
>  ifeq ($(PAMH), y)
>         override CFLAGS +=3D -DUSE_PAM
>         EXTRA_OBJS +=3D hashtab.o
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init=
/Makefile
> index 619ebc1d..a5002587 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -11,7 +11,7 @@ AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && =
echo y)
>
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAG=
E=3D"\"policycoreutils\""
> -override LDLIBS +=3D -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
>  ifeq ($(PAMH), y)
>         override CFLAGS +=3D -DUSE_PAM
>         override LDLIBS +=3D -lpam -lpam_misc
> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makef=
ile
> index 440503a1..daa3e10e 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -8,7 +8,7 @@ WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith=
 -Wbad-function-cast -Wca
>  VERSION =3D $(shell cat ../VERSION)
>  CFLAGS ?=3D $(WARNS) -O1
>  override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
> -override LDLIBS +=3D -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
>
>  all: secon
>
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 9fbf99d6..3855f95e 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -5,11 +5,12 @@ SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR =3D $(PREFIX)/share/man
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override LDLIBS +=3D -lsepol -lselinux -lsemanage
> +override LDLIBS +=3D -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
>  SEMODULE_OBJS =3D semodule.o
>
>  all: semodule genhomedircon
>
> +semodule: LDLIBS +=3D -laudit -lbz2
>  semodule: $(SEMODULE_OBJS)
>
>  genhomedircon:
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus=
/Makefile
> index aebf050c..b0df6d28 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -8,7 +8,7 @@ ETCDIR ?=3D /etc
>
>  CFLAGS ?=3D -Werror -Wall -W
>  override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> -override LDLIBS +=3D -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
>
>  all: sestatus
>
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles=
/Makefile
> index 84ffb08b..0b27e934 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -6,7 +6,7 @@ MANDIR =3D $(PREFIX)/share/man
>  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>
>  CFLAGS ?=3D -g -Werror -Wall -W
> -override LDLIBS +=3D -lselinux -lsepol -lpthread
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS) -lsepol -lpthread
>
>  ifeq ($(AUDITH), y)
>         override CFLAGS +=3D -DUSE_AUDIT
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index fc5b4ff6..12b6315d 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -6,13 +6,14 @@ MANDIR =3D $(PREFIX)/share/man
>  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override LDLIBS +=3D -lselinux -lsemanage
> +override LDLIBS +=3D -lsemanage $(LIBSELINUX_LDLIBS)
>  SETSEBOOL_OBJS =3D setsebool.o
>
>  BASHCOMPLETIONS=3Dsetsebool-bash-completion.sh
>
>  all: setsebool
>
> +setsebool: LDLIBS +=3D -laudit -lbz2
>  setsebool: $(SETSEBOOL_OBJS)
>
>  install: all
> diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetf=
iles/Makefile
> index 9e5edc04..bdc1b9de 100644
> --- a/policycoreutils/unsetfiles/Makefile
> +++ b/policycoreutils/unsetfiles/Makefile
> @@ -3,7 +3,7 @@ SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR ?=3D $(PREFIX)/share/man
>
>  override CFLAGS +=3D -D_GNU_SOURCE
> -override LDLIBS +=3D -lselinux
> +override LDLIBS +=3D $(LIBSELINUX_LDLIBS)
>
>
>  all: unsetfiles
>
> base-commit: 71aec30d068789e856e7cc429b620ae1cfa890f1
> --
> 2.47.0
>
>
