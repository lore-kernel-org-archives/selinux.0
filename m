Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3051BC06F
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656945; cv=none; b=D+Z2vnbKc5kVpov4FK1qunYPw5JICKVP6UZ8Y+P4214eRmElsDeTF1E2HxmK1afOPotIrLtDBbILjWHUtc9lnsIlgAuieVEeBUb8H6e3j183UzdIGcmDWrOfpmwRHRDzleHT9DI9BQUWJ2AC1XO8/rrUF+oyZr+jT6Ha2or9Kf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656945; c=relaxed/simple;
	bh=PgxPYOIaUlwBjp4Gf8K/egQ9xmEVo9VzC1wnDc0FGtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDR+9KzGwwgrTTpglMkfrhenYXhG+HPh/P3V8KHK7iuo3BjIoVnp1FrUxRUD0CdIylMpEBbsiVkgiCtHvLv1egAyBP57qySJz5/QyKd6pT5MEwEhgCOxH09GRAfpvNGiiIk2ixGQkSM4NxkPNCHbQ8F1ejNTnaZli7mhsrK+cRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecXF6c4M; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecXF6c4M"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-83172682ab3so15806241.2
        for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723656943; x=1724261743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVQ/V5QsGPsLOS8TqhLRPnGiNfW0W+gLqeAwy/7LLWE=;
        b=ecXF6c4MCNrapy1sqgsCqAmcEaNrQGFlge2VJJ9J5BMpPHQiT9WqrVggHsRMnETjio
         O98hUaQ4EWj9GnuRnvUmU8yOK6vrIHIEW110bwKkxbWcGyXSDzj+YHChJtGhibPFRIxt
         d3B+KLyiCXjkZenbcNvb2MozVYuIcgAjkjyv/9LbEtZvZXB1hIZwa5blJrsOMIzQ1fBY
         UMNMSaICT+Jd/gCQLlfhw0SrZ4rNFTu6IkgSp4yioGwM9+HOkHuzYui2AfLcXRf+nVE8
         AcNtspgxeqmitFQ1PoWJvckYzPLVatLin7iDOtHXo1faeCXGR7BnRgKxOFurqQ6PNK9L
         2a4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656943; x=1724261743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVQ/V5QsGPsLOS8TqhLRPnGiNfW0W+gLqeAwy/7LLWE=;
        b=WrzO2fB3UiCBT9Fwf8mP1ehm/97CcTdfzksiyjh5cqX/XXp2omWn9GDmjo0MyZifD4
         xBy3yNX/N7r2s/e233ToW8K8TZPuvEoWimSmO1UPMu7IkJ46JGyWs4IfSFN6jgH8nu7Q
         nsve+Jw/7Nqzf7j8vt02Qywxs8/ZOYDIOmzL0+totmK4wU0W7+uS75gmW9KlruPAkRka
         GhSKfO3cCJx835RPDS81cqQ9LtTH2M875AcplwSV4U6s8GXyWWgFO7aSa1q1cpeSs/a8
         3UYOADyqXYla05FL9vzJDxHNT8GUoGJ+1ceeVUUIqIRQvVEEcmb4frnq8OUAxPFCiR2c
         ODkw==
X-Gm-Message-State: AOJu0Yw5wHrzdY5q9kNxDxXWl5tWhtWhdp0T+PhAm1H2HSbcNgVUkmyL
	Te7lIQTu7z2EPkgpUw2daqbPg70qq8CtM1/48hzOUgWLneoVvDRdNtpr68yY4FrLO+MzFqxnMF1
	Fgc0Co94wvMVe3Oiid7SA555XZoE=
X-Google-Smtp-Source: AGHT+IExRvyyFZc617VmgsmLCWLU1e+KD53aA1KM/lwG0VvRBpE1r1I2C9TmS5Mt3KpWUBLlRJOh9lSn1E3GJIBnaaQ=
X-Received: by 2002:a05:6102:e14:b0:48f:4778:9299 with SMTP id
 ada2fe7eead31-497599d6605mr3878869137.28.1723656942741; Wed, 14 Aug 2024
 10:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623122604.34890-1-cgoettsche@seltendoof.de> <CAP+JOzQs=vt+LxDtAqe1qWk-PEOC97U6qiq+jo3BsbwmS+joXg@mail.gmail.com>
In-Reply-To: <CAP+JOzQs=vt+LxDtAqe1qWk-PEOC97U6qiq+jo3BsbwmS+joXg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 14 Aug 2024 13:35:31 -0400
Message-ID: <CAP+JOzQEsT-ETfpxopm=6TDVk=YAAGKvnBZheL_FSdpprXd36g@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: deprecate security_disable(3)
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:17=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sun, Jun 23, 2024 at 8:26=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The runtime disable functionality has been removed in Linux 6.4.  Thus
> > security_disable(3) will no longer work on these kernels.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2:
> >    Ignore deprecation warning by the internal usage of
> >    security_disable(3) in load_policy(8).
> > ---
> >  libselinux/include/selinux/selinux.h   |  6 +++++-
> >  libselinux/man/man3/security_disable.3 |  3 ++-
> >  libselinux/src/load_policy.c           |  2 ++
> >  libselinux/src/selinux_internal.h      | 18 ++++++++++++++++++
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index 61c1422b..1318a66a 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -367,7 +367,11 @@ extern int security_deny_unknown(void);
> >  /* Get the checkreqprot value */
> >  extern int security_get_checkreqprot(void);
> >
> > -/* Disable SELinux at runtime (must be done prior to initial policy lo=
ad). */
> > +/* Disable SELinux at runtime (must be done prior to initial policy lo=
ad).
> > +   Unsupported since Linux 6.4. */
> > +#ifdef __GNUC__
> > +__attribute__ ((deprecated))
> > +#endif
> >  extern int security_disable(void);
> >
> >  /* Get the policy version number. */
> > diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/ma=
n3/security_disable.3
> > index 072923ce..5ad8b778 100644
> > --- a/libselinux/man/man3/security_disable.3
> > +++ b/libselinux/man/man3/security_disable.3
> > @@ -14,7 +14,8 @@ disables the SELinux kernel code, unregisters selinux=
fs from
> >  and then unmounts
> >  .IR /sys/fs/selinux .
> >  .sp
> > -This function can only be called at runtime and prior to the initial p=
olicy
> > +This function is only supported on Linux 6.3 and earlier, and can only=
 be
> > +called at runtime and prior to the initial policy
> >  load. After the initial policy load, the SELinux kernel code cannot be=
 disabled,
> >  but only placed in "permissive" mode by using
> >  .BR security_setenforce(3).
> > diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.=
c
> > index 57d7aaef..dc1e4b6e 100644
> > --- a/libselinux/src/load_policy.c
> > +++ b/libselinux/src/load_policy.c
> > @@ -326,7 +326,9 @@ int selinux_init_load_policy(int *enforce)
> >
> >         if (seconfig =3D=3D -1) {
> >                 /* Runtime disable of SELinux. */
> > +               IGNORE_DEPRECATED_DECLARATION_BEGIN
> >                 rc =3D security_disable();
> > +               IGNORE_DEPRECATED_DECLARATION_END
> >                 if (rc =3D=3D 0) {
> >                         /* Successfully disabled, so umount selinuxfs t=
oo. */
> >                         umount(selinux_mnt);
> > diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux=
_internal.h
> > index b134808e..450a42c2 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -113,4 +113,22 @@ void *reallocarray(void *ptr, size_t nmemb, size_t=
 size);
> >  #define ignore_unsigned_overflow_
> >  #endif
> >
> > +/* Ignore usage of deprecated declaration */
> > +#ifdef __clang__
> > +#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
> > +       _Pragma("clang diagnostic push") \
> > +       _Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"=
")
> > +#define IGNORE_DEPRECATED_DECLARATION_END \
> > +       _Pragma("clang diagnostic pop")
> > +#elif defined __GNUC__
> > +#define IGNORE_DEPRECATED_DECLARATION_BEGIN \
> > +       _Pragma("GCC diagnostic push") \
> > +       _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
> > +#define IGNORE_DEPRECATED_DECLARATION_END \
> > +       _Pragma("GCC diagnostic pop")
> > +#else
> > +#define IGNORE_DEPRECATED_DECLARATION_BEGIN
> > +#define IGNORE_DEPRECATED_DECLARATION_END
> > +#endif
> > +
> >  #endif /* SELINUX_INTERNAL_H_ */
> > --
> > 2.45.2
> >
> >
