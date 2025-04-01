Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CC209F2E
	for <selinux@vger.kernel.org>; Tue,  1 Apr 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520522; cv=none; b=OT5Uo6PBuSY9aoDU/V+E0LlX32I/xwKEsPUr104LEvXmu+R74hNykkj5XzngnmI9TS6y2PQdP0xSCcEWq8jZjhSLZHubvJrrG153FuDJHIJTuBpHupErqaN0hU5HVuXbh/RwjLKL4iLd3Rcs6gAxYEfQS0RBuMxTlEmAbqOizhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520522; c=relaxed/simple;
	bh=kHe0gLryFtkrOzbsvR8/RROJ+Umo3KcaXmMlMqjFkVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGlUtnAjROAvRKmuuAX6Pe/qDmIfZNp1Y52wzw3A3Qy8mymh5JSXFFhPMCDRiG7AYCQ68HmDCOr8AKHBBt9F4Co5hp3nAgDj+He33046VaO2P5gEhaffj7rSiI5QhQnajiqAFopGKWaTwpqAvue7h7B79WXIkfyPnXc7XiwCwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJOz1UzD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJOz1UzD"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5f720c717so474695585a.0
        for <selinux@vger.kernel.org>; Tue, 01 Apr 2025 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743520519; x=1744125319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXa+++zn7Z9uyDzMj6h2Pmhtd2iByi0+ysSLnI62Irg=;
        b=hJOz1UzD07PHhW7zS8KH2BVEg0J7OYTJt+Iib78+aiMwKiB3PcUDGSDi6ACHPaLPG7
         BRrCiLNyerhSorRUBj01C1HAMWU0aYhUcYlXje1aqh7Rs/j1ppmtuS/qnxK3WmDDSQEV
         kMH9bx5xhIu2pLGWs9o5K7PvmqAwVO8kKtjt32lB/zlO2zQrtLfM5URov2uCIi6jJkco
         FjkeWG9bv3tXk60ofG/AD3SkLE0xrDHlQdTMsXGuCxmkJVyzGjexmp/hMYYVJybsUx/l
         rBmJ2aNkRbZ0kmNZqvPqQrFjwNN/0bEvilhH7XILYFqJXTR5igkuN8bC5xBrKaJTtz+h
         hrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743520519; x=1744125319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXa+++zn7Z9uyDzMj6h2Pmhtd2iByi0+ysSLnI62Irg=;
        b=V+Nktryk7DJvOMPRmzbfhjdw4UIpsE7qkIkP89chDwBTo7O05eIO40umG0E+B3/7+P
         yEV1eGM3SZVSI4vm8MMoXwDaVCHkwHvSAhHkj3Ip367ahTYn+L35U+dNtBWeRzaR7P4p
         lKbFAAZc7OI+4nDGjZOorB1eRjMe4F++luT8LK2V5jYERAZUtilDy0gSdGrVKDaAQC+G
         9Ylya0ybssMVtTJUIgRO7pA10184WHFLi8b2KehcwDIpwB6aDmVfwU5rb39D0ub0SI3R
         EG80Nv7oGqxrElAQol0KnAF1jjFH2rQIABY6v4FpDqNdizBTlqZ2fGS8U8PbSR3iiQQj
         2cxA==
X-Forwarded-Encrypted: i=1; AJvYcCVniUIYxIhLqmgD3sdayv3zMpd/BDBT7w3unu6eJlzJJGh1oiDHfnVX5VeU6Fjl6V70erBfT6bC@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKqez0qrfsrArc6yXTOGL/XTnj+2dfwpJYTemNqfwL14UQThW
	DvqkM0RFggB4J0rs8NjMcZ2VbDmKAoDSBqv+DxxntOuomy/FoRNG1ka4vOrZfeTIYk2TjtCf+s9
	mX7qOgcc3K3wGOtOM1Uort7nNsFOC0Q==
X-Gm-Gg: ASbGnctvSS1SwekMy1cXvSArcty8C88CGr94TH7y111hdLkdssyZo2yUYmIRU4Zy5qD
	ogC3zg+zw1aYHso0c80V37ofixoy8y5WFJMWweC/UGbpFp2qGktPf7C/ZmW2ouqElloL9ZyMTSK
	eg9c1pnpCqai+UPfLEXDHuBjU=
X-Google-Smtp-Source: AGHT+IEc48hNgjH4kvailpQrOaz89ElP7XOZgKbos9jJBosWjDJde2A8+IyyLYeuiin4DlaA2xNvt44wjErn0RTPfUw=
X-Received: by 2002:a05:620a:4706:b0:7c5:6a40:6a7a with SMTP id
 af79cd13be357-7c762990afamr47119985a.6.1743520519007; Tue, 01 Apr 2025
 08:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz>
 <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com> <3c5a1d53-788b-459c-ab97-551f2f4d7c31@googlemail.com>
In-Reply-To: <3c5a1d53-788b-459c-ab97-551f2f4d7c31@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 1 Apr 2025 11:15:08 -0400
X-Gm-Features: AQ5f1JpERXX-8yuZ4tTjvmzhMzpR_12o5aJp_UTYXu31T2L04VbYzC7ln7zdTOg
Message-ID: <CAP+JOzQQdzKinA7E1jxHJo5pwhpxH2_DX0-9c7jjJm=UwO2cFg@mail.gmail.com>
Subject: Re: [PATCH] Insert -I../../libselinux/include and -L../../libselinux/src
 into subprograms where needed
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 3:34=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Mar 31, 2025 21:06:23 James Carter <jwcart2@gmail.com>:
>
> > On Thu, Feb 27, 2025 at 4:33=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczlew=
eli@nabijaczleweli.xyz> wrote:
> >>
> >> These subprograms (sublibraries) use plain
> >>   #include <selinux/selinux.h>
> >>   cc ... -lselinux ...
> >> &c. which includes/links to the system libselinux.
> >>
> >> Naturally, this doesn't work if you don't have one.
> >>
> >> All of these fell out of a plain make invocation,
> >> yielding errors like
> >>   cc  -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self=
 -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-=
dereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -=
Wwrite-strings -fno-common -I../include -D_GNU_SOURCE -c -o boolean_record.=
o boolean_record.c
> >>   boolean_record.c:26:10: fatal error: selinux/selinux.h: No such file=
 or directory
> >>      26 | #include <selinux/selinux.h>
> >>         |          ^~~~~~~~~~~~~~~~~~~
> >>   compilation terminated.
> >>
> >>   make[2]: Entering directory '/tmp/selinux/policycoreutils/sestatus'
> >>   cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self =
-Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-d=
ereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -W=
write-strings -fno-common -D_FILE_OFFSET_BITS=3D64   -c -o sestatus.o sesta=
tus.c
> >>   sestatus.c:12:10: fatal error: selinux/selinux.h: No such file or di=
rectory
> >>      12 | #include <selinux/selinux.h>
> >>         |          ^~~~~~~~~~~~~~~~~~~
> >>   compilation terminated.
> >>
> >> Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
> >
> > Acked-by: James Carter <jwcart2@gmail.com>
>
> Shouldn't this be handled via the DESTDIR logic in the root Makefile?
>

If you do "make install" then it will be handled, but if you just want
to do "make" it will not work.

This patch handles all of the cases for libselinux. A smaller one is
needed for libsepol as well for the plain "make" to work.

Thanks,
Jim

> >
> >> ---
> >> libsemanage/src/Makefile             | 4 ++--
> >> mcstrans/src/Makefile                | 2 ++
> >> mcstrans/utils/Makefile              | 3 +++
> >> policycoreutils/load_policy/Makefile | 2 +-
> >> policycoreutils/newrole/Makefile     | 3 ++-
> >> policycoreutils/run_init/Makefile    | 3 ++-
> >> policycoreutils/secon/Makefile       | 3 ++-
> >> policycoreutils/semodule/Makefile    | 2 ++
> >> policycoreutils/sestatus/Makefile    | 3 ++-
> >> policycoreutils/setfiles/Makefile    | 2 ++
> >> policycoreutils/setsebool/Makefile   | 2 ++
> >> policycoreutils/unsetfiles/Makefile  | 3 ++-
> >> python/audit2allow/Makefile          | 2 ++
> >> restorecond/Makefile                 | 4 ++--
> >> 14 files changed, 28 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> >> index 8dfbd762..4db45aad 100644
> >> --- a/libsemanage/src/Makefile
> >> +++ b/libsemanage/src/Makefile
> >> @@ -60,7 +60,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmiss=
ing-noreturn -Wmissing-format-
> >> SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-v=
ariable -Wno-shadow \
> >>                 -Wno-unused-parameter -Wno-missing-prototypes
> >>
> >> -override CFLAGS +=3D -I../include -D_GNU_SOURCE
> >> +override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_S=
OURCE
> >> RANLIB ?=3D ranlib
> >>
> >> SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
> >> @@ -90,7 +90,7 @@ $(LIBA): $(OBJS)
> >>         $(RANLIB) $@
> >>
> >> $(LIBSO): $(LOBJS)
> >> -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepo=
l -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemana=
ge.map,-z,defs
> >> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../.=
./libselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--ver=
sion-script=3Dlibsemanage.map,-z,defs
> >>         ln -sf $@ $(TARGET)
> >>
> >> $(LIBPC): $(LIBPC).in ../VERSION
> >> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> >> index 89dbac16..88487068 100644
> >> --- a/mcstrans/src/Makefile
> >> +++ b/mcstrans/src/Makefile
> >> @@ -16,6 +16,8 @@ PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
> >> PROG=3Dmcstransd
> >> INITSCRIPT=3Dmcstrans
> >> CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attri=
bute
> >> +override CFLAGS +=3D -I../../libselinux/include
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >>
> >> all: $(PROG)
> >>
> >> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> >> index eec714f1..57a73932 100644
> >> --- a/mcstrans/utils/Makefile
> >> +++ b/mcstrans/utils/Makefile
> >> @@ -2,6 +2,9 @@
> >> PREFIX ?=3D /usr
> >> SBINDIR ?=3D $(PREFIX)/sbin
> >>
> >> +override CFLAGS +=3D -I../../libselinux/include
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> +
> >> TARGETS=3Dtranscon untranscon
> >>
> >> # If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> >> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/lo=
ad_policy/Makefile
> >> index ad80d500..6b2fa880 100644
> >> --- a/policycoreutils/load_policy/Makefile
> >> +++ b/policycoreutils/load_policy/Makefile
> >> @@ -6,7 +6,7 @@ MANDIR ?=3D $(PREFIX)/share/man
> >> LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> -override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDI=
R)\"" -DPACKAGE=3D"\"policycoreutils\""
> >> +override CFLAGS +=3D $(LDFLAGS) -I../../libselinux/include -L../../li=
bselinux/src -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"poli=
cycoreutils\""
> >> override LDLIBS +=3D -lsepol -lselinux
> >>
> >> TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> >> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrol=
e/Makefile
> >> index 4b8145d3..308e92dc 100644
> >> --- a/policycoreutils/newrole/Makefile
> >> +++ b/policycoreutils/newrole/Makefile
> >> @@ -24,7 +24,8 @@ VERSION =3D $(shell cat ../VERSION)
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> EXTRA_OBJS =3D
> >> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> >> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSI=
ON)\" -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreu=
tils\""
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux
> >> ifeq ($(PAMH), y)
> >>         override CFLAGS +=3D -DUSE_PAM
> >> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_i=
nit/Makefile
> >> index 619ebc1d..6c92fda1 100644
> >> --- a/policycoreutils/run_init/Makefile
> >> +++ b/policycoreutils/run_init/Makefile
> >> @@ -10,7 +10,8 @@ PAMH ?=3D $(shell test -f /usr/include/security/pam_=
appl.h && echo y)
> >> AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> -override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPAC=
KAGE=3D"\"policycoreutils\""
> >> +override CFLAGS +=3D -I../../libselinux/include -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux
> >> ifeq ($(PAMH), y)
> >>         override CFLAGS +=3D -DUSE_PAM
> >> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Ma=
kefile
> >> index 440503a1..c2102606 100644
> >> --- a/policycoreutils/secon/Makefile
> >> +++ b/policycoreutils/secon/Makefile
> >> @@ -7,7 +7,8 @@ MANDIR ?=3D $(PREFIX)/share/man
> >> WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-functi=
on-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes=
 -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-z=
ero-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
> >> VERSION =3D $(shell cat ../VERSION)
> >> CFLAGS ?=3D $(WARNS) -O1
> >> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
> >> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSI=
ON)\"
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux
> >>
> >> all: secon
> >> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semod=
ule/Makefile
> >> index 9fbf99d6..31cb2670 100644
> >> --- a/policycoreutils/semodule/Makefile
> >> +++ b/policycoreutils/semodule/Makefile
> >> @@ -5,6 +5,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
> >> MANDIR =3D $(PREFIX)/share/man
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/i=
nclude
> >> +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/s=
rc
> >> override LDLIBS +=3D -lsepol -lselinux -lsemanage
> >> SEMODULE_OBJS =3D semodule.o
> >>
> >> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sesta=
tus/Makefile
> >> index aebf050c..70748157 100644
> >> --- a/policycoreutils/sestatus/Makefile
> >> +++ b/policycoreutils/sestatus/Makefile
> >> @@ -7,7 +7,8 @@ MANDIR =3D $(PREFIX)/share/man
> >> ETCDIR ?=3D /etc
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> -override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> >> +override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=
=3D64
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux
> >>
> >> all: sestatus
> >> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfi=
les/Makefile
> >> index 84ffb08b..8e589a30 100644
> >> --- a/policycoreutils/setfiles/Makefile
> >> +++ b/policycoreutils/setfiles/Makefile
> >> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
> >> AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
> >>
> >> CFLAGS ?=3D -g -Werror -Wall -W
> >> +override CFLAGS +=3D -I../../libselinux/include
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux -lsepol -lpthread
> >>
> >> ifeq ($(AUDITH), y)
> >> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/sets=
ebool/Makefile
> >> index fc5b4ff6..54489ba3 100644
> >> --- a/policycoreutils/setsebool/Makefile
> >> +++ b/policycoreutils/setsebool/Makefile
> >> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
> >> BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/i=
nclude
> >> +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/s=
rc
> >> override LDLIBS +=3D -lselinux -lsemanage
> >> SETSEBOOL_OBJS =3D setsebool.o
> >>
> >> diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/uns=
etfiles/Makefile
> >> index 9e5edc04..08fa1abb 100644
> >> --- a/policycoreutils/unsetfiles/Makefile
> >> +++ b/policycoreutils/unsetfiles/Makefile
> >> @@ -2,7 +2,8 @@ PREFIX ?=3D /usr
> >> SBINDIR ?=3D $(PREFIX)/sbin
> >> MANDIR ?=3D $(PREFIX)/share/man
> >>
> >> -override CFLAGS +=3D -D_GNU_SOURCE
> >> +override CFLAGS +=3D -I../../libselinux/include -D_GNU_SOURCE
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux
> >>
> >>
> >> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> >> index fb04b8bd..28b8f7f2 100644
> >> --- a/python/audit2allow/Makefile
> >> +++ b/python/audit2allow/Makefile
> >> @@ -8,6 +8,8 @@ BINDIR ?=3D $(PREFIX)/bin
> >> MANDIR ?=3D $(PREFIX)/share/man
> >>
> >> CFLAGS ?=3D -Werror -Wall -W
> >> +override CFLAGS +=3D -I../../libselinux/include
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >>
> >> # If no specific libsepol.a is specified, fall back on LDFLAGS search =
path
> >> # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, ther=
e
> >> diff --git a/restorecond/Makefile b/restorecond/Makefile
> >> index 1ddfcc92..b8b86eb4 100644
> >> --- a/restorecond/Makefile
> >> +++ b/restorecond/Makefile
> >> @@ -18,8 +18,8 @@ GIO_CFLAGS =3D -DHAVE_DBUS $(shell $(PKG_CONFIG) --c=
flags gio-2.0)
> >> GIO_LIBS =3D $(shell $(PKG_CONFIG) --libs gio-2.0)
> >>
> >> CFLAGS ?=3D -g -Werror -Wall -W
> >> -override CFLAGS +=3D $(GIO_CFLAGS)
> >> -
> >> +override CFLAGS +=3D -I../../libselinux/include $(GIO_CFLAGS)
> >> +override LDFLAGS+=3D -L../../libselinux/src
> >> override LDLIBS +=3D -lselinux $(GIO_LIBS)
> >>
> >> all: restorecond
> >> --
> >> 2.39.5
>
