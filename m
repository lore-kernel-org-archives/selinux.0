Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A4219A81
	for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447864; cv=none; b=FDsLYInyAWgrqa0+UMo6e8S/JX6H+D/6BBjLSAt/9N2HfCFXiRma1GMDlJ9ub5Jr8YojJv3VnpJgC4fGXUwcqnHgfkst0xMStNZva1mN3hLCvidsyl/2k/lCKpbrH8JdBJiKN4gZM9sxN3ZljwaUaU6Xkl8Ig4EeIgBUXXSXNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447864; c=relaxed/simple;
	bh=7UwV/0uQ+EmQ3hm2jHu9RX0GA8pxBA91x9M38htS3BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYwvsgflPjZHBZqn/N2VB79ZmThMrsOwRomh0jhI/gkX7VLBCtCIh6bW21Mb+9KzTe3m0w1gJBu77dBYPoZlZVtSa8PHu4hO254EoKJeled6Nee5L6Ax3j/xOrO4JcSp1llodXcwDz167u42kyKr03iBx91xvU+d7r4SwSmVzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVt0WLpZ; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVt0WLpZ"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d42f08219so2026372241.0
        for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743447862; x=1744052662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOmeyA/X5J7w/cHBDfJ1aE/XYnkr7bSOtD40j/gNqoM=;
        b=UVt0WLpZczzFUBFBKlOF+yyQ1Zu7iWDWQuqQGbyqA+ZllUXmXs2K4Wntjhmzfe+IiN
         Dp3kTPo35+b88++Z2ecphMnL7dWEu2NN9/LMr9I5fXlP7spI5pOEUHaPCzSSaT4n7XTC
         EHJqC/STgIZlioCOch8UDxAqGzHlwj6qauXBnzuobr7BPomwpJf7ch5sKX0sK1Zlqy/M
         TkYoulatNAQDuzptGxUFVC0ZstAAWSIttCBmpwtEIBzN+NM/OLoMjjoxEtqwtQVl9t4q
         2XjecJFcL+n08Go2RVuDBq10a+O7CRXKr9Vn+3B2q/TUbybxkwDTdK/7zVMKyDYgRgHQ
         ZeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743447862; x=1744052662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOmeyA/X5J7w/cHBDfJ1aE/XYnkr7bSOtD40j/gNqoM=;
        b=LoYoWmimm+65KUxTlH6gSJKMgU1EvZ6QKFT8xb+Guj+YcE9yk5sINgioHtq4G8/IKE
         K492N6ypdfxAEIiGnTI/AkXVHCehZKXJQDehYb1oTTNJmkgjcw07U/gJe+nd9jJEI5LS
         AhUhkf1ydb6e45TIMSlimJaByxnk01++CsFKsGTexfMfbZt4sFhAi4nFYnBvkWITQ4AS
         JM9wJCuS7Vt7GOdMLo95Q5pcToXkaGF6pxuOaFPeDnM43np1tN/1vLnPi0LnqgcOylQb
         tKQ36nwwMFNJf00e4l311oBjZ6OKMxWOZ4N6+L1YLsAZOSKgAp4GTmyYeCcYr59HqQhJ
         PhEQ==
X-Gm-Message-State: AOJu0YyyKFhAoAumnnoCQu4D419oe2RiTwiQkHc1YZI7vgsupI+Gg0Oh
	Bj9B8+XSZcaQgYcu9yiSY+3QwUdaGoKtECl+lyOKSvMNBrearsXvXjjoS5E2i8bKJtWf0qt59C2
	/PiL/ohm0dCigZN6eE+AzCv1vP/F/byy3
X-Gm-Gg: ASbGncsNpUdzo9A3llcKZyqTw99gn+RWUAOm/qJa9t7MERrA+XeK4Xz15jnt1yfKswG
	AC8gskjgQsuQ7pA+0jGwJU70VBCX463ggRg+Tc0/F6aWdCHmi56jF9f4d0rETK6s0/0Yoi8zNvQ
	WVBsUWkOP0cb1h8Bad1SWljhI=
X-Google-Smtp-Source: AGHT+IHHlw5YIDqpGgVZ/6aPeDierIZWhUs7iIcgn8833gwRomXiAoYI93ph8nvv3wK+/ETdKVzw6Dllt8kymilZQHE=
X-Received: by 2002:a05:6102:534a:b0:4c1:91da:dac1 with SMTP id
 ada2fe7eead31-4c8277720a5mr211524137.6.1743447861495; Mon, 31 Mar 2025
 12:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz>
In-Reply-To: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 31 Mar 2025 15:04:10 -0400
X-Gm-Features: AQ5f1Joy-c_KTq5HQStvrRNJLIN8Z3_sUiBzzVVi7OwY_awJLKEg52HHMky02OU
Message-ID: <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com>
Subject: Re: [PATCH] Insert -I../../libselinux/include and -L../../libselinux/src
 into subprograms where needed
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:33=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@=
nabijaczleweli.xyz> wrote:
>
> These subprograms (sublibraries) use plain
>   #include <selinux/selinux.h>
>   cc ... -lselinux ...
> &c. which includes/links to the system libselinux.
>
> Naturally, this doesn't work if you don't have one.
>
> All of these fell out of a plain make invocation,
> yielding errors like
>   cc  -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -W=
missing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-der=
eference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwr=
ite-strings -fno-common -I../include -D_GNU_SOURCE -c -o boolean_record.o b=
oolean_record.c
>   boolean_record.c:26:10: fatal error: selinux/selinux.h: No such file or=
 directory
>      26 | #include <selinux/selinux.h>
>         |          ^~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>
>   make[2]: Entering directory '/tmp/selinux/policycoreutils/sestatus'
>   cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-self -Wm=
issing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnull-dere=
ference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused -Wwri=
te-strings -fno-common -D_FILE_OFFSET_BITS=3D64   -c -o sestatus.o sestatus=
.c
>   sestatus.c:12:10: fatal error: selinux/selinux.h: No such file or direc=
tory
>      12 | #include <selinux/selinux.h>
>         |          ^~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>
> Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/Makefile             | 4 ++--
>  mcstrans/src/Makefile                | 2 ++
>  mcstrans/utils/Makefile              | 3 +++
>  policycoreutils/load_policy/Makefile | 2 +-
>  policycoreutils/newrole/Makefile     | 3 ++-
>  policycoreutils/run_init/Makefile    | 3 ++-
>  policycoreutils/secon/Makefile       | 3 ++-
>  policycoreutils/semodule/Makefile    | 2 ++
>  policycoreutils/sestatus/Makefile    | 3 ++-
>  policycoreutils/setfiles/Makefile    | 2 ++
>  policycoreutils/setsebool/Makefile   | 2 ++
>  policycoreutils/unsetfiles/Makefile  | 3 ++-
>  python/audit2allow/Makefile          | 2 ++
>  restorecond/Makefile                 | 4 ++--
>  14 files changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 8dfbd762..4db45aad 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -60,7 +60,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissing=
-noreturn -Wmissing-format-
>  SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-var=
iable -Wno-shadow \
>                 -Wno-unused-parameter -Wno-missing-prototypes
>
> -override CFLAGS +=3D -I../include -D_GNU_SOURCE
> +override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SOUR=
CE
>  RANLIB ?=3D ranlib
>
>  SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
> @@ -90,7 +90,7 @@ $(LIBA): $(OBJS)
>         $(RANLIB) $@
>
>  $(LIBSO): $(LOBJS)
> -       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -=
laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.=
map,-z,defs
> +       $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -L../../l=
ibselinux/src -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),--versio=
n-script=3Dlibsemanage.map,-z,defs
>         ln -sf $@ $(TARGET)
>
>  $(LIBPC): $(LIBPC).in ../VERSION
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index 89dbac16..88487068 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -16,6 +16,8 @@ PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
>  PROG=3Dmcstransd
>  INITSCRIPT=3Dmcstrans
>  CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribu=
te
> +override CFLAGS +=3D -I../../libselinux/include
> +override LDFLAGS+=3D -L../../libselinux/src
>
>  all: $(PROG)
>
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index eec714f1..57a73932 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -2,6 +2,9 @@
>  PREFIX ?=3D /usr
>  SBINDIR ?=3D $(PREFIX)/sbin
>
> +override CFLAGS +=3D -I../../libselinux/include
> +override LDFLAGS+=3D -L../../libselinux/src
> +
>  TARGETS=3Dtranscon untranscon
>
>  # If no specific libsepol.a is specified, fall back on LDFLAGS search pa=
th
> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_=
policy/Makefile
> index ad80d500..6b2fa880 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -6,7 +6,7 @@ MANDIR ?=3D $(PREFIX)/share/man
>  LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\=
"" -DPACKAGE=3D"\"policycoreutils\""
> +override CFLAGS +=3D $(LDFLAGS) -I../../libselinux/include -L../../libse=
linux/src -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policyc=
oreutils\""
>  override LDLIBS +=3D -lsepol -lselinux
>
>  TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/M=
akefile
> index 4b8145d3..308e92dc 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -24,7 +24,8 @@ VERSION =3D $(shell cat ../VERSION)
>
>  CFLAGS ?=3D -Werror -Wall -W
>  EXTRA_OBJS =3D
> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=3D=
"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION)=
\" -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutil=
s\""
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux
>  ifeq ($(PAMH), y)
>         override CFLAGS +=3D -DUSE_PAM
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init=
/Makefile
> index 619ebc1d..6c92fda1 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -10,7 +10,8 @@ PAMH ?=3D $(shell test -f /usr/include/security/pam_app=
l.h && echo y)
>  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAG=
E=3D"\"policycoreutils\""
> +override CFLAGS +=3D -I../../libselinux/include -DUSE_NLS -DLOCALEDIR=3D=
"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux
>  ifeq ($(PAMH), y)
>         override CFLAGS +=3D -DUSE_PAM
> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makef=
ile
> index 440503a1..c2102606 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -7,7 +7,8 @@ MANDIR ?=3D $(PREFIX)/share/man
>  WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function=
-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -=
Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zer=
o-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
>  VERSION =3D $(shell cat ../VERSION)
>  CFLAGS ?=3D $(WARNS) -O1
> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION)=
\"
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux
>
>  all: secon
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule=
/Makefile
> index 9fbf99d6..31cb2670 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -5,6 +5,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR =3D $(PREFIX)/share/man
>
>  CFLAGS ?=3D -Werror -Wall -W
> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
> +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
>  override LDLIBS +=3D -lsepol -lselinux -lsemanage
>  SEMODULE_OBJS =3D semodule.o
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus=
/Makefile
> index aebf050c..70748157 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -7,7 +7,8 @@ MANDIR =3D $(PREFIX)/share/man
>  ETCDIR ?=3D /etc
>
>  CFLAGS ?=3D -Werror -Wall -W
> -override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
> +override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D64
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux
>
>  all: sestatus
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles=
/Makefile
> index 84ffb08b..8e589a30 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
>  AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>
>  CFLAGS ?=3D -g -Werror -Wall -W
> +override CFLAGS +=3D -I../../libselinux/include
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux -lsepol -lpthread
>
>  ifeq ($(AUDITH), y)
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebo=
ol/Makefile
> index fc5b4ff6..54489ba3 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
>  BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
>
>  CFLAGS ?=3D -Werror -Wall -W
> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/incl=
ude
> +override LDFLAGS+=3D -L../../libselinux/src     -L../../libsemanage/src
>  override LDLIBS +=3D -lselinux -lsemanage
>  SETSEBOOL_OBJS =3D setsebool.o
>
> diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetf=
iles/Makefile
> index 9e5edc04..08fa1abb 100644
> --- a/policycoreutils/unsetfiles/Makefile
> +++ b/policycoreutils/unsetfiles/Makefile
> @@ -2,7 +2,8 @@ PREFIX ?=3D /usr
>  SBINDIR ?=3D $(PREFIX)/sbin
>  MANDIR ?=3D $(PREFIX)/share/man
>
> -override CFLAGS +=3D -D_GNU_SOURCE
> +override CFLAGS +=3D -I../../libselinux/include -D_GNU_SOURCE
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux
>
>
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index fb04b8bd..28b8f7f2 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -8,6 +8,8 @@ BINDIR ?=3D $(PREFIX)/bin
>  MANDIR ?=3D $(PREFIX)/share/man
>
>  CFLAGS ?=3D -Werror -Wall -W
> +override CFLAGS +=3D -I../../libselinux/include
> +override LDFLAGS+=3D -L../../libselinux/src
>
>  # If no specific libsepol.a is specified, fall back on LDFLAGS search pa=
th
>  # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 1ddfcc92..b8b86eb4 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -18,8 +18,8 @@ GIO_CFLAGS =3D -DHAVE_DBUS $(shell $(PKG_CONFIG) --cfla=
gs gio-2.0)
>  GIO_LIBS =3D $(shell $(PKG_CONFIG) --libs gio-2.0)
>
>  CFLAGS ?=3D -g -Werror -Wall -W
> -override CFLAGS +=3D $(GIO_CFLAGS)
> -
> +override CFLAGS +=3D -I../../libselinux/include $(GIO_CFLAGS)
> +override LDFLAGS+=3D -L../../libselinux/src
>  override LDLIBS +=3D -lselinux $(GIO_LIBS)
>
>  all: restorecond
> --
> 2.39.5
