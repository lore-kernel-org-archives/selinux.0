Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457847279B
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684626; cv=pass; b=saVYsA71s180weeVeGk64MBpdF4eTwUzvXxAti/G5HaiZPF+zV0kAnWUTObG6iAsL2FKcwb2T+dfj48nOLsg722muziB4ECPRFQht4yEEtXlBGJ6kfIxequDYlsaqXgx5HmUFYcFe/e3yixowi/tWcIqCgo9Xt1eRTvtnDP/ZvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684626; c=relaxed/simple;
	bh=CcuoIO/vjOKd0ToBVI7aQ4t/YHncgtcjwCdqWAhWYsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVluYFCobhvYe03We2LTo9osLXHODwDBJbFfcQamuH4KVPf/bUv6AhsyNgSjHrThSYjJZW40uro/j3b2jCMywr86vThRmhiDzhq+wlNXf8jAMENlc4EaaXV3ryywsRtuelC9h/Y6H9R1JoiPzkHWMXkTfipe99IVjyJaYlYic7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzgHOAj7; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzgHOAj7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393d07e8938so62943451fa.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 08:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778684623; cv=none;
        d=google.com; s=arc-20240605;
        b=FNHM5SQ432nfxrJgAW1G52ntL3oQQd+IrYiyiwc5cfX0Z7Knho7wCpbj3CtduJTibw
         0IVMgQHUYLL38sKKv7Zi27h6WIBDOJGQUIHuRnzchnCcbhxMRg9g2Ph3G7nTAMsYId57
         SgVZ/5Kqpwvv0475fOC1Zu9inMP91jzo19JOhXkN8cr3svH4sMoIwgGGxfNK00ZQ4ABZ
         lfFfIzQGcbVVR/s+5QHyG/H37gBYIA3OUChlRbWgYJl/hrWxAkMwlgMIM/KIsEiyJrep
         jKwaogq5Z+4zJs0O6stEEDQ/nKwg2pjvsEWZW5krmI7Cu900e8pFWAERyIPoC7KIfLYQ
         VDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCCf0VzKjiCY9ldLEa6IwAZT+9rieP4o7QdTKARgg/M=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=hI5e6tzPH2uudbpQRPrCJZHzxaDPE45lbIJhZnBrXHLan+t15bp3/0xlJhswUep88P
         3xcyOYsR/0VUhsalRwu1RdAV97xczlUN5bl627eqzGiydxyClI+77kFqVVFLF14CSJ+M
         2jH6nPImOksnNqHIhmcOF+0+tPPLvd4Km/YV0UPGiV2UHbpdh4VW0Wklh6RQg30GwCm3
         nerKnw5DdTKKc9IByy0cXtStj5awkO8F3i1HezN/YV8iyfRhqDKoSRxWn2T+7PBZLOzH
         r9UHXIG29dCwJaIyAQ3Hv5uzvbdd3ieCYaoZyhF6nCIrYd7iNAWgSbbopKTgaDqROMGP
         dpQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778684623; x=1779289423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCCf0VzKjiCY9ldLEa6IwAZT+9rieP4o7QdTKARgg/M=;
        b=GzgHOAj7HFpfI1Y7uye4q/x1A5YygZP8jMmg7qa4p/H16US9qb0xT1sP8P7BJGj5Pt
         0eGO+ZVLWM7HOgQZA8IxeRcCnA0q0mZMImr6NmOLS19JF3vSGFcjGu5AqF1c74w76SaB
         s8MMeDFATOzljjIimrQLy+fKCZIX/dZobXzyrCz6V2a0l/+iqf+9/Fc6D+4SoWxcgf3D
         Wi6VtfoDcW3jQIvf5Hi+5/cIWR/jTffV0qOLFQK8k5491kLD62kiiRHuK/n8qBkr1BiG
         caD4JMML9XRRxtc4UPZT0yqu2L23Gox8of9Re0ZnC1oKlNPluvbubKucK7qh3XrQllgX
         carQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778684623; x=1779289423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCCf0VzKjiCY9ldLEa6IwAZT+9rieP4o7QdTKARgg/M=;
        b=WWIeO4/zxcX1WleOOxi2Gi8H5v0qaGz8pHDG3xsJzq8vzKZNAXkPE8bMOQeLQOCaYA
         XS+9Nw5lgsS0aR4Ogjl14TWLyc2aHpJfrE548XwQSNbL/ttoViB4NOkWJxYU05/jY4jm
         a/dScyECLXTlC7OPZKN7Ds4jjHtshget9nVPcip06mjAHgJrJJVZuh221AfNwYUGwTC/
         DHNZP4opwreHGiRstRgvEkMSRygbeMtMulkfAVSwin6Mz3MBK+xqD0oxo7VG/u+qDsY1
         UFDKJK2QFKqs2DPxmhgRDPUc/a4uRrR4H2ZN+QkRixSOjKF/FgJlAnRlJNDggF0il+tY
         KuOA==
X-Gm-Message-State: AOJu0YyVjoF/qGezuSQvO5YOaeyTEnklDDt0xgxsAdeQGKLBBgFxrXRx
	MYLG+I4s4UrpdgSsmTwVQ2NeeduPTocXG3hOGmF+VYwA3i5BrcCrzVBCud1jOCmWd0/1sYU76oR
	FWvwtSWaSK/6cEL6U8mwWgnFXnDm9bGRfdADr
X-Gm-Gg: Acq92OE74CTAPG4yvNGf+TWxz462+kxry/xPaQ/sPCEXIIfwPy0TGLFQIJNgnuFLf++
	beYudKHqN6il7xcH/UlJp5tu00IF8gZinxPW3yhKUwJjOBGAwMUuLIEGxNo5Yvc9TMQ2NyJsy8D
	Aw8GZChXg4uxfsN3412sUQxDr/u1EvawPD0gLUXuEtbKRfCHsTqJYjkEk/z3XBpRe4JIKLtBmqm
	wItZHW8vURZmPkyJijsRNGVnYye+ElwkXJY4I0uFwpzyObOe6AkfAJ4jCPDMYVmMcBdtGfQaVWc
	qp6+zSyubtpegG4=
X-Received: by 2002:a05:651c:41d9:b0:394:3deb:f360 with SMTP id
 38308e7fff4ca-3944ea827a9mr9280611fa.20.1778684622768; Wed, 13 May 2026
 08:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420124124.324404-1-vmojzis@redhat.com>
In-Reply-To: <20260420124124.324404-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 13 May 2026 11:03:31 -0400
X-Gm-Features: AVHnY4I8uY3qW7qJHCYn8HtjreRTe5LVYFMRA_rhLQRxcIWrQ0DDkxZ732jBj04
Message-ID: <CAP+JOzTSxCP9LASNMKS=QT4TdKpb3ri9NKsu09hdtE5++UV=fw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/test: Show all options for dispol and dismod
 in -h
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 8:41=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Show the following options, which were hidden in the usage message,
> because they require additional input:
>
> dispol:
>   7    change a boolean value
>   f    set output file
>   m    display menu
>   q    quit
>
> dismod:
>   l    Link in a module
>   f    set output file
>   m    display menu
>   q    quit
>
> Fixes:
>   $dispol -h
>   Usage:
>    sedispol [OPTIONS] binary_pol_file
>
>   Options:
>    -h, --help   print this help message
>    -a, --actions ACTIONS   run non-interactively
>
>   Actions:
>     1    display unconditional AVTAB
>     2    display conditional AVTAB (entirely)
>     3    display conditional AVTAB (only ENABLED rules)
>     4    display conditional AVTAB (only DISABLED rules)
>     5    display booleans
>     6    display conditional expressions
>     8    display role transitions
>     c    display policy capabilities
>     C    display classes
>     u    display users
>     r    display roles
>     t    display types
>     a    display type attributes
>     p    display the list of permissive types
>     U    display unknown handling setting
>     F    display filename_trans rules
>
>   With the patch:
>
>   Actions:
>     1    display unconditional AVTAB
>     2    display conditional AVTAB (entirely)
>     3    display conditional AVTAB (only ENABLED rules)
>     4    display conditional AVTAB (only DISABLED rules)
>     5    display booleans
>     6    display conditional expressions
>     7    change a boolean value
>     8    display role transitions
>     c    display policy capabilities
>     C    display classes
>     u    display users
>     r    display roles
>     t    display types
>     a    display type attributes
>     p    display the list of permissive types
>     U    display unknown handling setting
>     F    display filename_trans rules
>     f    set output file
>     m    display menu
>     q    quit
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/test/dismod.c | 3 +--
>  checkpolicy/test/dispol.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> index 4868190f..ed5aaa45 100644
> --- a/checkpolicy/test/dismod.c
> +++ b/checkpolicy/test/dismod.c
> @@ -106,8 +106,7 @@ static __attribute__((__noreturn__)) void usage(const=
 char *progname)
>         puts("");
>         puts("Actions:");
>         for (unsigned int i =3D 0; commands[i].meta !=3D EOL; i++) {
> -               if (commands[i].meta =3D=3D HEADER
> -                   || commands[i].meta & NOOPT)
> +               if (!(commands[i].meta & CMD))
>                         continue;
>                 printf("  %c    %s\n", commands[i].cmd, commands[i].desc)=
;
>         }
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 3f80c1a2..c3339b88 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -79,8 +79,7 @@ static __attribute__((__noreturn__)) void usage(const c=
har *progname)
>         puts("");
>         puts("Actions:");
>         for (unsigned int i =3D 0; commands[i].meta !=3D EOL; i++) {
> -               if (commands[i].meta =3D=3D HEADER
> -                   || commands[i].meta & NOOPT)
> +               if (!(commands[i].meta & CMD))
>                         continue;
>                 printf("  %c    %s\n", commands[i].cmd, commands[i].desc)=
;
>         }
> --
> 2.53.0
>
>
