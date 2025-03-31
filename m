Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6D18D
	for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449696; cv=none; b=De7WKWOS0VI7fHQ+4AEwYHQc5raO1IO0LeuWbHZ87tvmg4qEcVbAcfMShyThl7O1Hf7+jw1dAhsQ6FIkmicoQB7N6sXG1nUnJWqhBrIKMgkrM+ItZFMO62TcypOooa/jfF7ABt5vO5nR8qiib+TVSQk8JhhBRlNNXSlbOhghWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449696; c=relaxed/simple;
	bh=J+QmD+DC83WbkOqthgVmmN4oensjtrmz5/HoJM8s4h4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Egh5AkgBF9m4MSq3Zs8I++o+jAuJfPz1VvcnnZEgBYBU4kpZiCtBaDWP2h0eT65zCDtWP8jcAZLB9Veof3W+ELqoxajI854ljQRg6AvJhf12JenlUCIi9DCU2aeaKTM2Xr9mqncNxV7wH2B2gujILpsTk+Hymwuf0x0ixooGq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=kNAf58xS; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="kNAf58xS"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so4809031a12.1
        for <selinux@vger.kernel.org>; Mon, 31 Mar 2025 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1743449693; x=1744054493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+QmD+DC83WbkOqthgVmmN4oensjtrmz5/HoJM8s4h4=;
        b=kNAf58xS+wjdjf3DiLoZeICZdwCViYSSBKLODRMNSjj1/H6MFAtONQNvIMHqTrfla2
         JBvZnoN0Kbm20t4gtD2wzqm/lrwCZntFDD/nabC8E/Mtwnm3uE/XhqfmQSx9DsFT/36Z
         OrnEBM/CLUJI1rUtQ00dAhfpxVUcXtfUu4jzHfOdR6dNAUk+Ee/cEMA0osX/AgH0jNrT
         uZ9aIeycouusndegovtW4PNUcL3R5bU5y1K7zAzxQ4uHjmwfjUk+nB7+bXvmS3KqXCFW
         RfDnTR1odlP5XEo/L01EuvKeVghh6VBhM2AuCuS9U8XBZQp4vQBkZPdZG8Yi6BEIxfw2
         43xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743449693; x=1744054493;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+QmD+DC83WbkOqthgVmmN4oensjtrmz5/HoJM8s4h4=;
        b=gPr2EeE8eTWicQ6IjYSdf1ItOwSArat6zgk9hMI6yOMsYA2hlleT/yljMmQcnvge/B
         G7kQ3gLmrgj0rcXotzVLdDxHVafkiZnH2V146wnr2W+A0LbKCI0X1O1XYieEkMq3s0mf
         eZT1HSM+tyTc3jhMdbbod5ZtiAGaLbYXx79v49P3f/75Atcg7vdRgXlkSnKwpnKZ53nv
         1nuJ5Fa06jenoj9tQr65we0Jz0tZdY475hPygqqVAYBcf1OwiUGSGPvaQbFLJ2yYa8f9
         VGhUIWGrsJvAUxlCvXrayGw+BmuV7vvByciHCqD8gYoBHF0x4CcrQdTC7aclOBAcJN0y
         VKTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpA587nteSfrLQb/ncvLz/WUGAKlIgvKATFB+K4EyIC2MNP1wMhs3cgnUBORA8kuEpuLiX2j23@vger.kernel.org
X-Gm-Message-State: AOJu0YytWhVzJtHKFAq2u6N5nASyhPVkRHi3xxZtcyvNAYM5wMBT3yEB
	5QzD2QmxljHRIfRBg9pPYf4vc2K5LfKZFuVm4gfGU5xpTcvRVMpU3c8001+n
X-Gm-Gg: ASbGncuQRX+5IzqAbN+Wu9TWckOYBnrlf7rBi02t2WPP4pUiJqY01fI9S6fBPKXjPOt
	azWgv265U2oNEh3E5o0ZxXN64wCC9RzF3mG6c6/jLrx7UcniZlKmDmMhL7xyGzWM6/r4M0MrdTv
	5LUHoIRufl/GUTouHqM03iRuV9PkVjRWdqx6OEFaPLcckoDdtO6x3luV7G/u+SA7agB1+ZkMby5
	avcglWiHb1Hw8+1Ix0ctPukJTRxCqrKy4cJiAUBKhbUmtQDKuBDbS8UiAMkZZJBPGEKBnujF2z1
	VitTiD4H85Jm8eYKQPEhiL2aN4DLgLRvO4y2IH0qUTVG9k4FP7Epw2uUinj7LbsOMlCK6zO/XOZ
	NmEaDvMvbaCvk5ITlu/yvzwmp
X-Google-Smtp-Source: AGHT+IH/KOWbsusV9oR9cnPYUeUAZJKTq9+MCMKOKS5KK3lQ4exPLkRi0me2WKEy5qzN2Vz9NemfiA==
X-Received: by 2002:a50:c8ca:0:b0:5f0:1b8e:35ba with SMTP id 4fb4d7f45d1cf-5f01b8e42e3mr1929294a12.6.1743449692703;
        Mon, 31 Mar 2025 12:34:52 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-176-001-128-042.176.1.pool.telefonica.de. [176.1.128.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d38e3sm6045315a12.24.2025.03.31.12.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 12:34:52 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:34:49 +0200 (GMT+02:00)
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
To: James Carter <jwcart2@gmail.com>
Cc: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>,
	selinux@vger.kernel.org
Message-ID: <3c5a1d53-788b-459c-ab97-551f2f4d7c31@googlemail.com>
In-Reply-To: <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com>
References: <kwnnb3dirxubncipnklpimiv34bmetaxchzvzkoztsw62kx7zd@tarta.nabijaczleweli.xyz> <CAP+JOzQB=n-g27pbbSKf5YMKfFyNXq2zoxy=92fR86Bo57Ng=A@mail.gmail.com>
Subject: Re: [PATCH] Insert -I../../libselinux/include and
 -L../../libselinux/src into subprograms where needed
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3c5a1d53-788b-459c-ab97-551f2f4d7c31@googlemail.com>

Mar 31, 2025 21:06:23 James Carter <jwcart2@gmail.com>:

> On Thu, Feb 27, 2025 at 4:33=E2=80=AFPM =D0=BD=D0=B0=D0=B1 <nabijaczlewel=
i@nabijaczleweli.xyz> wrote:
>>
>> These subprograms (sublibraries) use plain
>> =C2=A0 #include <selinux/selinux.h>
>> =C2=A0 cc ... -lselinux ...
>> &c. which includes/links to the system libselinux.
>>
>> Naturally, this doesn't work if you don't have one.
>>
>> All of these fell out of a plain make invocation,
>> yielding errors like
>> =C2=A0 cc=C2=A0 -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Wi=
nit-self -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes=
 -Wnull-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -W=
unused -Wwrite-strings -fno-common -I../include -D_GNU_SOURCE -c -o boolean=
_record.o boolean_record.c
>> =C2=A0 boolean_record.c:26:10: fatal error: selinux/selinux.h: No such f=
ile or directory
>> =C2=A0=C2=A0=C2=A0=C2=A0 26 | #include <selinux/selinux.h>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
>> =C2=A0 compilation terminated.
>>
>> =C2=A0 make[2]: Entering directory '/tmp/selinux/policycoreutils/sestatu=
s'
>> =C2=A0 cc -O2 -Werror -Wall -Wextra -Wfloat-equal -Wformat=3D2 -Winit-se=
lf -Wmissing-format-attribute -Wmissing-noreturn -Wmissing-prototypes -Wnul=
l-dereference -Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef -Wunused=
 -Wwrite-strings -fno-common -D_FILE_OFFSET_BITS=3D64=C2=A0=C2=A0 -c -o ses=
tatus.o sestatus.c
>> =C2=A0 sestatus.c:12:10: fatal error: selinux/selinux.h: No such file or=
 directory
>> =C2=A0=C2=A0=C2=A0=C2=A0 12 | #include <selinux/selinux.h>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
>> =C2=A0 compilation terminated.
>>
>> Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Shouldn't this be handled via the DESTDIR logic in the root Makefile?

>
>> ---
>> libsemanage/src/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> mcstrans/src/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
>> mcstrans/utils/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
>> policycoreutils/load_policy/Makefile | 2 +-
>> policycoreutils/newrole/Makefile=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
>> policycoreutils/run_init/Makefile=C2=A0=C2=A0=C2=A0 | 3 ++-
>> policycoreutils/secon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +=
+-
>> policycoreutils/semodule/Makefile=C2=A0=C2=A0=C2=A0 | 2 ++
>> policycoreutils/sestatus/Makefile=C2=A0=C2=A0=C2=A0 | 3 ++-
>> policycoreutils/setfiles/Makefile=C2=A0=C2=A0=C2=A0 | 2 ++
>> policycoreutils/setsebool/Makefile=C2=A0=C2=A0 | 2 ++
>> policycoreutils/unsetfiles/Makefile=C2=A0 | 3 ++-
>> python/audit2allow/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 2 ++
>> restorecond/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> 14 files changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
>> index 8dfbd762..4db45aad 100644
>> --- a/libsemanage/src/Makefile
>> +++ b/libsemanage/src/Makefile
>> @@ -60,7 +60,7 @@ CFLAGS ?=3D -Werror -Wall -W -Wundef -Wshadow -Wmissin=
g-noreturn -Wmissing-format-
>> SWIG_CFLAGS +=3D -Wno-error -Wno-unused-but-set-variable -Wno-unused-var=
iable -Wno-shadow \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 -Wno-unused-parameter -Wno-missing-prototypes
>>
>> -override CFLAGS +=3D -I../include -D_GNU_SOURCE
>> +override CFLAGS +=3D -I../include -I../../libselinux/include -D_GNU_SOU=
RCE
>> RANLIB ?=3D ranlib
>>
>> SWIG =3D swig -Wall -python -o $(SWIGCOUT) -outdir ./
>> @@ -90,7 +90,7 @@ $(LIBA): $(OBJS)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(RANLIB) $@
>>
>> $(LIBSO): $(LOBJS)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFL=
AGS) -shared -o $@ $^ -lsepol -laudit -lselinux -lbz2 -Wl,-soname,$(LIBSO),=
--version-script=3Dlibsemanage.map,-z,defs
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFL=
AGS) -shared -o $@ $^ -L../../libselinux/src -lsepol -laudit -lselinux -lbz=
2 -Wl,-soname,$(LIBSO),--version-script=3Dlibsemanage.map,-z,defs
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ln -sf $@ $(TARGET)
>>
>> $(LIBPC): $(LIBPC).in ../VERSION
>> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
>> index 89dbac16..88487068 100644
>> --- a/mcstrans/src/Makefile
>> +++ b/mcstrans/src/Makefile
>> @@ -16,6 +16,8 @@ PROG_OBJS=3D $(patsubst %.c,%.o,$(PROG_SRC))
>> PROG=3Dmcstransd
>> INITSCRIPT=3Dmcstrans
>> CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribu=
te
>> +override CFLAGS +=3D -I../../libselinux/include
>> +override LDFLAGS+=3D -L../../libselinux/src
>>
>> all: $(PROG)
>>
>> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
>> index eec714f1..57a73932 100644
>> --- a/mcstrans/utils/Makefile
>> +++ b/mcstrans/utils/Makefile
>> @@ -2,6 +2,9 @@
>> PREFIX ?=3D /usr
>> SBINDIR ?=3D $(PREFIX)/sbin
>>
>> +override CFLAGS +=3D -I../../libselinux/include
>> +override LDFLAGS+=3D -L../../libselinux/src
>> +
>> TARGETS=3Dtranscon untranscon
>>
>> # If no specific libsepol.a is specified, fall back on LDFLAGS search pa=
th
>> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load=
_policy/Makefile
>> index ad80d500..6b2fa880 100644
>> --- a/policycoreutils/load_policy/Makefile
>> +++ b/policycoreutils/load_policy/Makefile
>> @@ -6,7 +6,7 @@ MANDIR ?=3D $(PREFIX)/share/man
>> LOCALEDIR ?=3D $(DESTDIR)$(PREFIX)/share/locale
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> -override CFLAGS +=3D $(LDFLAGS) -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)=
\"" -DPACKAGE=3D"\"policycoreutils\""
>> +override CFLAGS +=3D $(LDFLAGS) -I../../libselinux/include -L../../libs=
elinux/src -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policy=
coreutils\""
>> override LDLIBS +=3D -lsepol -lselinux
>>
>> TARGETS=3D$(patsubst %.c,%,$(sort $(wildcard *.c)))
>> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/=
Makefile
>> index 4b8145d3..308e92dc 100644
>> --- a/policycoreutils/newrole/Makefile
>> +++ b/policycoreutils/newrole/Makefile
>> @@ -24,7 +24,8 @@ VERSION =3D $(shell cat ../VERSION)
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> EXTRA_OBJS =3D
>> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
>> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION=
)\" -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreuti=
ls\""
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux
>> ifeq ($(PAMH), y)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 override CFLAGS +=3D -DUSE_PA=
M
>> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_ini=
t/Makefile
>> index 619ebc1d..6c92fda1 100644
>> --- a/policycoreutils/run_init/Makefile
>> +++ b/policycoreutils/run_init/Makefile
>> @@ -10,7 +10,8 @@ PAMH ?=3D $(shell test -f /usr/include/security/pam_ap=
pl.h && echo y)
>> AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> -override CFLAGS +=3D -DUSE_NLS -DLOCALEDIR=3D"\"$(LOCALEDIR)\"" -DPACKA=
GE=3D"\"policycoreutils\""
>> +override CFLAGS +=3D -I../../libselinux/include -DUSE_NLS -DLOCALEDIR=
=3D"\"$(LOCALEDIR)\"" -DPACKAGE=3D"\"policycoreutils\""
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux
>> ifeq ($(PAMH), y)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 override CFLAGS +=3D -DUSE_PA=
M
>> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Make=
file
>> index 440503a1..c2102606 100644
>> --- a/policycoreutils/secon/Makefile
>> +++ b/policycoreutils/secon/Makefile
>> @@ -7,7 +7,8 @@ MANDIR ?=3D $(PREFIX)/share/man
>> WARNS=3D-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function=
-cast -Wcast-align -Wwrite-strings -Waggregate-return -Wstrict-prototypes -=
Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Wno-format-zer=
o-length -Wformat-nonliteral -Wformat-security -Wfloat-equal
>> VERSION =3D $(shell cat ../VERSION)
>> CFLAGS ?=3D $(WARNS) -O1
>> -override CFLAGS +=3D -DVERSION=3D\"$(VERSION)\"
>> +override CFLAGS +=3D -I../../libselinux/include -DVERSION=3D\"$(VERSION=
)\"
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux
>>
>> all: secon
>> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodul=
e/Makefile
>> index 9fbf99d6..31cb2670 100644
>> --- a/policycoreutils/semodule/Makefile
>> +++ b/policycoreutils/semodule/Makefile
>> @@ -5,6 +5,8 @@ SBINDIR ?=3D $(PREFIX)/sbin
>> MANDIR =3D $(PREFIX)/share/man
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/inc=
lude
>> +override LDFLAGS+=3D -L../../libselinux/src=C2=A0=C2=A0=C2=A0=C2=A0 -L.=
./../libsemanage/src
>> override LDLIBS +=3D -lsepol -lselinux -lsemanage
>> SEMODULE_OBJS =3D semodule.o
>>
>> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatu=
s/Makefile
>> index aebf050c..70748157 100644
>> --- a/policycoreutils/sestatus/Makefile
>> +++ b/policycoreutils/sestatus/Makefile
>> @@ -7,7 +7,8 @@ MANDIR =3D $(PREFIX)/share/man
>> ETCDIR ?=3D /etc
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> -override CFLAGS +=3D -D_FILE_OFFSET_BITS=3D64
>> +override CFLAGS +=3D -I../../libselinux/include -D_FILE_OFFSET_BITS=3D6=
4
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux
>>
>> all: sestatus
>> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfile=
s/Makefile
>> index 84ffb08b..8e589a30 100644
>> --- a/policycoreutils/setfiles/Makefile
>> +++ b/policycoreutils/setfiles/Makefile
>> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
>> AUDITH ?=3D $(shell test -f /usr/include/libaudit.h && echo y)
>>
>> CFLAGS ?=3D -g -Werror -Wall -W
>> +override CFLAGS +=3D -I../../libselinux/include
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux -lsepol -lpthread
>>
>> ifeq ($(AUDITH), y)
>> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setseb=
ool/Makefile
>> index fc5b4ff6..54489ba3 100644
>> --- a/policycoreutils/setsebool/Makefile
>> +++ b/policycoreutils/setsebool/Makefile
>> @@ -6,6 +6,8 @@ MANDIR =3D $(PREFIX)/share/man
>> BASHCOMPLETIONDIR ?=3D $(PREFIX)/share/bash-completion/completions
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> +override CFLAGS +=3D -I../../libselinux/include -I../../libsemanage/inc=
lude
>> +override LDFLAGS+=3D -L../../libselinux/src=C2=A0=C2=A0=C2=A0=C2=A0 -L.=
./../libsemanage/src
>> override LDLIBS +=3D -lselinux -lsemanage
>> SETSEBOOL_OBJS =3D setsebool.o
>>
>> diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unset=
files/Makefile
>> index 9e5edc04..08fa1abb 100644
>> --- a/policycoreutils/unsetfiles/Makefile
>> +++ b/policycoreutils/unsetfiles/Makefile
>> @@ -2,7 +2,8 @@ PREFIX ?=3D /usr
>> SBINDIR ?=3D $(PREFIX)/sbin
>> MANDIR ?=3D $(PREFIX)/share/man
>>
>> -override CFLAGS +=3D -D_GNU_SOURCE
>> +override CFLAGS +=3D -I../../libselinux/include -D_GNU_SOURCE
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux
>>
>>
>> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
>> index fb04b8bd..28b8f7f2 100644
>> --- a/python/audit2allow/Makefile
>> +++ b/python/audit2allow/Makefile
>> @@ -8,6 +8,8 @@ BINDIR ?=3D $(PREFIX)/bin
>> MANDIR ?=3D $(PREFIX)/share/man
>>
>> CFLAGS ?=3D -Werror -Wall -W
>> +override CFLAGS +=3D -I../../libselinux/include
>> +override LDFLAGS+=3D -L../../libselinux/src
>>
>> # If no specific libsepol.a is specified, fall back on LDFLAGS search pa=
th
>> # Otherwise, as $(LIBSEPOLA) already appears in the dependencies, there
>> diff --git a/restorecond/Makefile b/restorecond/Makefile
>> index 1ddfcc92..b8b86eb4 100644
>> --- a/restorecond/Makefile
>> +++ b/restorecond/Makefile
>> @@ -18,8 +18,8 @@ GIO_CFLAGS =3D -DHAVE_DBUS $(shell $(PKG_CONFIG) --cfl=
ags gio-2.0)
>> GIO_LIBS =3D $(shell $(PKG_CONFIG) --libs gio-2.0)
>>
>> CFLAGS ?=3D -g -Werror -Wall -W
>> -override CFLAGS +=3D $(GIO_CFLAGS)
>> -
>> +override CFLAGS +=3D -I../../libselinux/include $(GIO_CFLAGS)
>> +override LDFLAGS+=3D -L../../libselinux/src
>> override LDLIBS +=3D -lselinux $(GIO_LIBS)
>>
>> all: restorecond
>> --
>> 2.39.5

