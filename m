Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA625949A
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049538; cv=none; b=aVKBJrOB41Ik/Is6IuZoDTpyZl57eEUmGDfHYUQZdsXUlHEskr1R8jRRGWZqUnhPXJg3jkZnI6qMtWPLnt12a8N7WkKuqLxCqlJ2EGaUp8moA+O1R8Ci/9KXGkn9V7RvKZP0zsXRXs2H1muL46uN1StyMJKgsdzuhNtX+ztM/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049538; c=relaxed/simple;
	bh=KdwgCJU0jweh9Fo0TnQI1jVLinpE+vhVw+VHT4tUgKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/FUxCahDfYaziFdboKjFdqfhLkNYJgEHsaMPT29vPSs3lIwFOE1TRrl9r0KCTbTimatysYMQ8XVp8ui8lQR6DRUV0DllKeAjanYizBj4bYdgbnkjj1MfqiGMj0KtdsooPrkwUyxv+tC3E5ulXzo+D5cscy5cHOFTnUliBjE0ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3Qogo5c; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3Qogo5c"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so4080976241.3
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049535; x=1744654335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROWpfKjvgxkl9AtQXAoEFkkkEWAKpX2iu3gq4mO4GpQ=;
        b=i3Qogo5c3GriNI48Ch0pyZmSm8dxkyCa5x8e3a6xgRd0J0UYIyeHRnwn9Fdq2ceb9I
         dvXKQB6KbmkaOleeYdjeRwYMKDxfb1Z9WYF41/xVeyFF7h3P8esaD5TEB669ooLooxl4
         IIHXVhNYHtFITzRYwTHD+I8SfgATAMeVQpCGZ6pvZpHpv6bFYp3XWXB7CMqs4LbQWA+P
         2CTRATHV4KEYCFfEtKkq9cqom6CfpozpeKilvvxKTmqqM8a2wU00fFQwDH/eA0I2b4bg
         JF6rCBGSTVZ0HZqyAhRBdk9ZeJxIRupeXdjeMPVPPYGG9MzcjBBVjGrVQv7g4ISgWcrr
         JiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049535; x=1744654335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROWpfKjvgxkl9AtQXAoEFkkkEWAKpX2iu3gq4mO4GpQ=;
        b=C2EUY0CSV3ld5NV+V73i3G8hVWgySGz4G+jTU8jVlLaZxcJxS/BMfDBpLK0Iakcatk
         kwPNVskw8rM+cPlwmf4IjbYTUFqN+t7dbu6r8Xe9mTO8yoSM+ccAJ+gzqzNVLx8PXSDc
         8lpx0H/4PlC+0aLBswZ8vI1sLdVuH2CLLdwtNpqnliKyLlWltH0hxhq5XSKDVObqI9R/
         Uz0uxS4MA5tfZIfrNiizKAVrQF0mgPHalBn8XTC0Pa0i4P/qg0ZGMkp16wwSx8h8rPzS
         WBp/DKUS62l9v+JQYmC6gv1WNOY0GlUp8FYmMRsgbQOHZlb7riLlqIXGyDfB1TdW25Ja
         w4lw==
X-Gm-Message-State: AOJu0Yyir3T9uNkpJX1bF6OWOwIPJhO20XAUO8VBIqt262mtdRBDK9tl
	hYiknUSPhHIxbCfSDTUREdwZ26bSSd0Cz3Mv90bwRap80mlDGLCr5qEqLwsiVirDYabHE5GH9iF
	5xDmE/h+m0lnGKocXsmnFNN+n1ywaWQ==
X-Gm-Gg: ASbGncvo4ZZ+kgVWocSryxPRmfkI8FdyMd3pKvrEgPwFXl+Bx88EqSyuyMYTEqtTAt7
	94ID7MMa/jtq3z3F6jpeN+tA0YI3yBp55GZrm4LR0fL9FGYsRXgUVcmFi6VVEjTNI2AJmp4TVhw
	BafZIJoW3l7WL3OIHHa954fRw=
X-Google-Smtp-Source: AGHT+IGMA9neYXKUb/UH53mrTxU4EXc8TeAGv/bUUXeRn6oAh8RwBLDb8yARZ4hveNGhWbaQt/czEDxQBGGbo6XsVPc=
X-Received: by 2002:a05:6102:f89:b0:4c4:e451:6f24 with SMTP id
 ada2fe7eead31-4c856a62181mr10362086137.22.1744049534907; Mon, 07 Apr 2025
 11:12:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz>
 <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com>
In-Reply-To: <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:12:03 -0400
X-Gm-Features: ATxdqUHpjZaMjFYR6AfAS9RNVvRkA17j8BCM3ABFvgvrp1lkB0kj5D0FgP7mTfA
Message-ID: <CAP+JOzRH05powmegv1PcPB2dD+ufOkBsFtW215LC3yRzq0W6zQ@mail.gmail.com>
Subject: Re: [PATCH] Insert -I../../libselinux/include and -L../../libselinux/src
 into subprograms where needed
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:04=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Feb 27, 2025 at 4:33=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczlewel=
i@nabijaczleweli.xyz> wrote:
> >
> > These subprograms (sublibraries) use plain
> >   #include <selinux/selinux.h>
> >   cc ... -lselinux ...
> > &c. which includes/links to the system libselinux.
> >
> > Naturally, this doesn't work if you don't have one.
> >
> > All of these fell out of a plain make invocation,
> > yielding errors like
> >   cc  -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self =
-Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-d=
ereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -W=
write-strings -fno-common -I../include -D_GNU_SOURCE -c -o boolean_record.o=
 boolean_record.c
> >   boolean_record.c:26:10: fatal error: selinux/selinux.h: No such file =
or directory
> >      26 | #include <selinux/selinux.h>
> >         |          ^~~~~~~~~~~~~~~~~~~
> >   compilation terminated.
> >
> >   make[2]: Entering directory '/tmp/selinux/policycoreutils/sestatus'
> >   cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -=
Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-de=
reference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Ww=
rite-strings -fno-common -D_FILE_OFFSET_BITS=3D64   -c -o sestatus.o sestat=
us.c
> >   sestatus.c:12:10: fatal error: selinux/selinux.h: No such file or dir=
ectory
> >      12 | #include <selinux/selinux.h>
> >         |          ^~~~~~~~~~~~~~~~~~~
> >   compilation terminated.
> >
> > Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/Makefile             | 4 ++--
> >  mcstrans/src/Makefile                | 2 ++
> >  mcstrans/utils/Makefile              | 3 +++
> >  policycoreutils/load_policy/Makefile | 2 +-
> >  policycoreutils/newrole/Makefile     | 3 ++-
> >  policycoreutils/run_init/Makefile    | 3 ++-
> >  policycoreutils/secon/Makefile       | 3 ++-
> >  policycoreutils/semodule/Makefile    | 2 ++
> >  policycoreutils/sestatus/Makefile    | 3 ++-
> >  policycoreutils/setfiles/Makefile    | 2 ++
> >  policycoreutils/setsebool/Makefile   | 2 ++
> >  policycoreutils/unsetfiles/Makefile  | 3 ++-
> >  python/audit2allow/Makefile          | 2 ++
> >  restorecond/Makefile                 | 4 ++--
> >  14 files changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> > index 8dfbd762..4db45aad 100644
> > --- a/libsemanage/src/Makefile
> > +++ b/libsemanage/src/Makefile
> > @@ -60,7 +60,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissi=
ng-noreturn -Wmissing-format-
> >  SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-v=
ariable -Wno-shadow \
> >                 -Wno-unused-parameter -Wno-missing-prototypes
> >
> > -override CFLAGS +=3D -I../include -D_GNU_SOURCE
> > +override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SO=
URCE
> >  RANLIB ?=3D ranlib
> >
> >  SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
> > @@ -90,7 +90,7 @@ $(LIBA): $(OBJS)
> >         $(RANLIB) $@
> >
> >  $(LIBSO): $(LOBJS)
> > -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol=
 -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanag=
e.map,-z,defs
> > +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../..=
/libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--vers=
ion-script=3Dlibsemanage.map,-z,defs
> >         ln -sf $@ $(TARGET)
> >
> >  $(LIBPC): $(LIBPC).in ../VERSION
> > diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> > index 89dbac16..88487068 100644
> > --- a/mcstrans/src/Makefile
> > +++ b/mcstrans/src/Makefile
> > @@ -16,6 +16,8 @@ PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
> >  PROG=3Dmcstransd
> >  INITSCRIPT=3Dmcstrans
> >  CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attri=
bute
> > +override CFLAGS +=3D -I../../libselinux/include
> > +override LDFLAGS+=3D -L../../libselinux/src
> >
> >  all: $(PROG)
> >
> > diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> > index eec714f1..57a73932 100644
> > --- a/mcstrans/utils/Makefile
> > +++ b/mcstrans/utils/Makefile
> > @@ -2,6 +2,9 @@
> >  PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >
> > +override CFLAGS +=3D -I../../libselinux/include
> > +override LDFLAGS+=3D -L../../libselinux/src
> > +
> >  TARGETS=3Dtranscon untranscon
> >
> >  # If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> > diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/loa=
d_policy/Makefile
> > index ad80d500..6b2fa880 100644
> > --- a/policycoreutils/load_policy/Makefile
> > +++ b/policycoreutils/load_policy/Makefile
> > @@ -6,7 +6,7 @@ MANDIR ?=3D $(PREFIX)/share/man
> >  LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR=
)\"" -DPACKAGE=3D"\"policycoreutils\""
> > +override CFLAGS +=3D $(LDFLAGS) -I../../libselinux/include -L../../lib=
selinux/src -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"polic=
ycoreutils\""
> >  override LDLIBS +=3D -lsepol -lselinux
> >
> >  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> > diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole=
/Makefile
> > index 4b8145d3..308e92dc 100644
> > --- a/policycoreutils/newrole/Makefile
> > +++ b/policycoreutils/newrole/Makefile
> > @@ -24,7 +24,8 @@ VERSION =3D $(shell cat ../VERSION)
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> >  EXTRA_OBJS =3D
> > -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> > +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSIO=
N)\" -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreut=
ils\""
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux
> >  ifeq ($(PAMH), y)
> >         override CFLAGS +=3D -DUSE_PAM
> > diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_in=
it/Makefile
> > index 619ebc1d..6c92fda1 100644
> > --- a/policycoreutils/run_init/Makefile
> > +++ b/policycoreutils/run_init/Makefile
> > @@ -10,7 +10,8 @@ PAMH ?=3D $(shell test -f /usr/include/security/pam_a=
ppl.h && echo y)
> >  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACK=
AGE=3D"\"policycoreutils\""
> > +override CFLAGS +=3D -I../../libselinux/include -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux
> >  ifeq ($(PAMH), y)
> >         override CFLAGS +=3D -DUSE_PAM
> > diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Mak=
efile
> > index 440503a1..c2102606 100644
> > --- a/policycoreutils/secon/Makefile
> > +++ b/policycoreutils/secon/Makefile
> > @@ -7,7 +7,8 @@ MANDIR ?=3D $(PREFIX)/share/man
> >  WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-functi=
on-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes=
 -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-z=
ero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
> >  VERSION =3D $(shell cat ../VERSION)
> >  CFLAGS ?=3D $(WARNS) -O1
> > -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
> > +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSIO=
N)\"
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux
> >
> >  all: secon
> > diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodu=
le/Makefile
> > index 9fbf99d6..31cb2670 100644
> > --- a/policycoreutils/semodule/Makefile
> > +++ b/policycoreutils/semodule/Makefile
> > @@ -5,6 +5,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR =3D $(PREFIX)/share/man
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/in=
clude
> > +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/sr=
c
> >  override LDLIBS +=3D -lsepol -lselinux -lsemanage
> >  SEMODULE_OBJS =3D semodule.o
> >
> > diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestat=
us/Makefile
> > index aebf050c..70748157 100644
> > --- a/policycoreutils/sestatus/Makefile
> > +++ b/policycoreutils/sestatus/Makefile
> > @@ -7,7 +7,8 @@ MANDIR =3D $(PREFIX)/share/man
> >  ETCDIR ?=3D /etc
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > -override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> > +override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D=
64
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux
> >
> >  all: sestatus
> > diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfil=
es/Makefile
> > index 84ffb08b..8e589a30 100644
> > --- a/policycoreutils/setfiles/Makefile
> > +++ b/policycoreutils/setfiles/Makefile
> > @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
> >  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
> >
> >  CFLAGS ?=3D -g -Werror -Wall -W
> > +override CFLAGS +=3D -I../../libselinux/include
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux -lsepol -lpthread
> >
> >  ifeq ($(AUDITH), y)
> > diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setse=
bool/Makefile
> > index fc5b4ff6..54489ba3 100644
> > --- a/policycoreutils/setsebool/Makefile
> > +++ b/policycoreutils/setsebool/Makefile
> > @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
> >  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/in=
clude
> > +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/sr=
c
> >  override LDLIBS +=3D -lselinux -lsemanage
> >  SETSEBOOL_OBJS =3D setsebool.o
> >
> > diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unse=
tfiles/Makefile
> > index 9e5edc04..08fa1abb 100644
> > --- a/policycoreutils/unsetfiles/Makefile
> > +++ b/policycoreutils/unsetfiles/Makefile
> > @@ -2,7 +2,8 @@ PREFIX ?=3D /usr
> >  SBINDIR ?=3D $(PREFIX)/sbin
> >  MANDIR ?=3D $(PREFIX)/share/man
> >
> > -override CFLAGS +=3D -D_GNU_SOURCE
> > +override CFLAGS +=3D -I../../libselinux/include -D_GNU_SOURCE
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux
> >
> >
> > diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> > index fb04b8bd..28b8f7f2 100644
> > --- a/python/audit2allow/Makefile
> > +++ b/python/audit2allow/Makefile
> > @@ -8,6 +8,8 @@ BINDIR ?=3D $(PREFIX)/bin
> >  MANDIR ?=3D $(PREFIX)/share/man
> >
> >  CFLAGS ?=3D -Werror -Wall -W
> > +override CFLAGS +=3D -I../../libselinux/include
> > +override LDFLAGS+=3D -L../../libselinux/src
> >
> >  # If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> >  # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, ther=
e
> > diff --git a/restorecond/Makefile b/restorecond/Makefile
> > index 1ddfcc92..b8b86eb4 100644
> > --- a/restorecond/Makefile
> > +++ b/restorecond/Makefile
> > @@ -18,8 +18,8 @@ GIO_CFLAGS =3D -DHAVE_DBUS $(shell $(PKG_CONFIG) --cf=
lags gio-2.0)
> >  GIO_LIBS =3D $(shell $(PKG_CONFIG) --libs gio-2.0)
> >
> >  CFLAGS ?=3D -g -Werror -Wall -W
> > -override CFLAGS +=3D $(GIO_CFLAGS)
> > -
> > +override CFLAGS +=3D -I../../libselinux/include $(GIO_CFLAGS)
> > +override LDFLAGS+=3D -L../../libselinux/src
> >  override LDLIBS +=3D -lselinux $(GIO_LIBS)
> >
> >  all: restorecond
> > --
> > 2.39.5
