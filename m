Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF720B20;
	Wed,  8 Jan 2025 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736342249; cv=none; b=MYHUqUhhgC41BPkokiOCFqaBYVe335834muClzrEuoymnHf3fqjZ5jqxu5Q4Xw+lXqd9jLG5r21Kozac/NwJUDw88ImXd9RHywOHkh0t9THLiNDXS/PVrCtC9XSxwv6JdCH1d7kxdDHwUR6hMpevE20d5eOJb560N0pv1kQa9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736342249; c=relaxed/simple;
	bh=1DK7hjkj9WV8fvsS84jZsjkUPGGpOR3faB9WFzBYqrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGhia3z52oqvOR5oAkjUY0GfgcRF6sGYk0TL+b6afjqAKZQksyCzZoINIB6NcsRsxHaVtbaKwfJZ4jxd6Qy18lp7Mi0q/Ggq6QsQ5WsUzl87AcVtRgtaXAwoLp6LMuwX1tBjaIyr68bDSNDKcb0G5WFtoudsWTBQiyHbo+EckYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l29Btqj1; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l29Btqj1"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e4a6b978283so1394514276.0;
        Wed, 08 Jan 2025 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736342246; x=1736947046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UxrDFJV+w/69PH6wqHMGTKMv2k8d+L16mQM9P6xBuY=;
        b=l29Btqj1MR0q+Q3757QynbhM2pgpfwomJa8qo0bpb5QQGkJzi/zM50Y09G8mCZ7u09
         K+d6TXSaYCRxUM5IQHY7mv9Y8ePtNtpISTNmpwECmqgAdgl2vl9MHnA6ognTEhOyz6ka
         /QXCiimtiTSzTHSJirahDnWzDYaummqvtquU7FkDOai8XZF4JIibcL3z1wxuX50lgq7d
         AJSIm3iNMsGXkaVuGzF0oAhpeUizTUmY5wZ770/Aw7TY/X3+g4IlzM0bHXJsm54Y5ZPX
         GobKqAnhR+vjsXzETXd9XadkvHpapRXZdhyule04llwP5a5mObPZBR6elS0+MwLftqro
         MLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736342246; x=1736947046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UxrDFJV+w/69PH6wqHMGTKMv2k8d+L16mQM9P6xBuY=;
        b=N7lpEk3B5sHi//f0lS9NtlsIe1sqMSLTlR/06UoCj5Ykz6BoWPEaDTf8GRwLqBq5Aw
         Ek3W8UoqvmYVY22KhDie/b00Ejeu4voAbpf4HTOGJOa/ZPKAak7VIaPWcg0vy2f44Zpc
         bfahihaBqVmv40mDhEbtuS3rmqi5ScUi4u9XCmTFH7/CwyRjSf6Uxaq5j2GYng/faBbD
         5uaI3rrxhQZYuzH2qWQ34DZBzJU4T6deJHmp2BI13UDLqGFKy21VfGHb4twqY7X3R2ui
         1UzRzVulOq9k+WqdVYFZYIK3tA/42jL1BjFVtvCFTAun1eJXigS8BVfMU4v9LoaVAiCw
         J7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUeVe0dk86UmnCn0FmCfAeKt9Ogw2F0UnVgT9f2BWCEv9hpfkZin/BDJLz83jg41NXiQ5C1mK1DO2HyGR8=@vger.kernel.org, AJvYcCUv1iRNHm4Q27OxqrWfBHK5ATkcyOmvgu1dr6cebPY0q++eR6uf4wRL/QNVtG2cCecaZojTtVio1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuzi/u2ZgmRsWiyR76rz3PJqDv5S28J30UjbBHnAAMl6TOf0xC
	nxkngGT4YDke+rOAiOmXTHlKBnrGVw/Mt3CUQxcejXoUzp6Tg9F/E7+T1wguAeBNJS8C71QI0yD
	lp+8eT/c/65yaBFSKUrANZ1eELb0=
X-Gm-Gg: ASbGnctl441GnkcmiLnYv4l7rKhdpWjvcZi1diyeAWjOULuu3hd8mS0qvKXuDrVlMT+
	8T96KiVsUMfpQXqpmV/PQSZIESN3MBuQGsWO4
X-Google-Smtp-Source: AGHT+IH3vFL8NcJ87wcZTW/3d0PfHPFf8ILBBOdFlVLf0dVDVL75aRmm9O9J2ztwDUAFOTDx6EcYzMnnEDaGD5M+Dbc=
X-Received: by 2002:a05:690c:7343:b0:6ee:6a2a:a517 with SMTP id
 00721157ae682-6f5204a0aeamr49595437b3.18.1736342246514; Wed, 08 Jan 2025
 05:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216164055.96267-5-cgoettsche@seltendoof.de> <01df64ed8f6eb9e6f2780b5b0aa3be5c@paul-moore.com>
In-Reply-To: <01df64ed8f6eb9e6f2780b5b0aa3be5c@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Wed, 8 Jan 2025 14:17:15 +0100
X-Gm-Features: AbW1kvZML3C0ZeA_TspCpGgfKtleODtl9U2HoYwQCftiAC2lGmbPgHkDqm6x2nY
Message-ID: <CAJ2a_Dei0Bg14N2E9U2FzM0OEvEQbOcTvQ76FH4Ut6JYq5VybA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/22] selinux: avoid nontransitive comparison
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Jan 2025 at 04:00, Paul Moore <paul@paul-moore.com> wrote:
>
> On Dec 16, 2024 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > Avoid using nontransitive comparison to prevent unexpected sorting
> > results due to (well-defined) overflows.
> > See https://www.qualys.com/2024/01/30/qsort.txt for a related issue in
> > glibc's qsort(3).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/ss/policydb.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 3ba5506a3fff..eb944582d7a6 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -37,6 +37,8 @@
> >  #include "mls.h"
> >  #include "services.h"
> >
> > +#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
>
> I'll admit that it took me a while to figure out why you decided to
> name this macro "spaceship_cmp", and then I had a little laugh when
> I realized why it was called the "spaceship" operator :)
>
> Anyway, while the spaceship operator is likely familiar to people who
> have a Perl background, the kernel is still mostly a C project so I
> don't think we can expect a base understanding of Perl, especially
> these days as Perl isn't as popular as in the past.  Can we rename
> this to something else that makes more sense in the context of C?

There seem to be 4 similar macros already in the kernel, 3 named
cmp_int() and one instance named cmp_ptr().
So I am going with cmp_int() in v3 for now, but I am open for other suggest=
ions.

>
> --
> paul-moore.com
