Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019BB2620D1
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049632; cv=none; b=XIIn55uRdgToqTz9Kg70sET8GZJwOfQymZfj4dBvxetIiRZ1/i7GZIm7mLVJ/S5vP76uBp3mP2KWjmkiVrKHlTMMAJWhoPapvH90wS0Qds7d2h05ihe2NhH8ePr+/blHJltnJxe5WyVLycbcYGyOMwDAE3c2Teuy4oVJsO0O1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049632; c=relaxed/simple;
	bh=jMl0LR5BxvRHo5ecAIxPegkxNtaodVZWO90hlLHKjvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4ZnkMHM02bdKMhtMn1nKNoTt1cDz9Mh/HHnmjdZCe1cnhwdFQhENnfWy64Lr8KRkTxF8S9A8/p99Ia88Zgm0r5jv8BCI2dFCdCDtNbS/7QAGKFVMAB6ZZv0hqbntwBDEbERaPIq5HQD7qln3ff2gp+Ole3lGnGEUYYIi2ub/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euVAs1CP; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euVAs1CP"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so5142710241.1
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049630; x=1744654430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk9Ak+h0uCEY2HAxTiGFhIxOtwE0hElp/vkGVUYShg8=;
        b=euVAs1CPrabCz5T7epYa92J63SGXpULzTsPGb+hkUm+PPHQ/SpgTPLHrcck4SCk02B
         FiNAxptNS2vyII7USdpnnM9GX51rohyek5/VRtDXv6M+Y9VItuxGp7rAUTKmRPJiWaNG
         42imzyTK30kzl+tb7b2oZjAjQHg2TY6c+KvRaElYh+NYKOiNhIQmyf1PW0MU4JSxgIqC
         oayXlwCCP0LoLEk/Cm1hX8FPx19br4lG0phSUxJMQzA0S1BGo2a+9HqXuaZ8uvT0I5MI
         5YTvB+CozgoH9/KLYo79hbu5yFj66Jpjhk7/v/OUKkPoXGSrJ41NlTp+knHKGkylKSMM
         XeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049630; x=1744654430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk9Ak+h0uCEY2HAxTiGFhIxOtwE0hElp/vkGVUYShg8=;
        b=IUhQv4ZSi/y6sCrkFkw7CX6fyQvd3JpIcraFzEnZoLfzux4VBGVZ2+zvW4xlLco5oA
         mPREIS5oSBiYDw6RDQQoH8j6EhjsY94I5XpFZs7Kgck5qW9GV+uHGya7MuHeEuga55uF
         jutnqoMgrvPlPJYn4wMuBXacSnzDi286ohYoz9ypM1ZzFISprSiQuzlp83PzM4ye630B
         RvkLB4OOdkhGO9KCZgT+ojaJ6M3OPg2cIzovC1bMLC4oyDTjyI1mtd6h3W/3oOy1bKvM
         uscIJW2qtVFpeXmF1c2x5+y9vE+JHS9qUL6jizrsZrf/A7Hzoswozz/Apk49FOpzOVGT
         9CRg==
X-Gm-Message-State: AOJu0Yx8qG5p2rMaoQUKRBvyoxYzzamixiyCTN75Bz+FKrpxF3Itg3bo
	DXY2xVuezZJw8gxcVtNR4rY17j+SEcffc71SHtFO3whDHypNxqH25GZEzjYI7MetdgqGGH5f698
	quXBtbC338X/9++L6A6yV7Hhro6Jy9A==
X-Gm-Gg: ASbGncujEnej7hl/+ePX8l9QtjTPHMANI0zM5GWnJzde1dSvo5MXiwvM89QhwbfihZH
	neXKFzG+JXbPfcJ6lG8jWlTsLRs2cmoShlR+xGvkn2Y7lBBSMHBsaFxMDD5HMxqfXs25lNYoRZA
	7COREia1LRKjb+XU6BnF1UAbg=
X-Google-Smtp-Source: AGHT+IGwhnWasDUKRyXm9UZVjSK8QWfnCVCOXpMZhg2UFzIj9qJLnWx4sEcRi4NSHG+zCyvbeJi3brmTlgw3wugNSyk=
X-Received: by 2002:a05:6102:836:b0:4c1:8ded:2d66 with SMTP id
 ada2fe7eead31-4c9b3c04ecamr448307137.12.1744049629849; Mon, 07 Apr 2025
 11:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314131751.28289-1-cgoettsche@seltendoof.de>
 <20250314131751.28289-4-cgoettsche@seltendoof.de> <CAP+JOzRSKsrx_Q+2GRGUvzaxUaQCZ2W1guwvg6z0NLtDb8+k1Q@mail.gmail.com>
In-Reply-To: <CAP+JOzRSKsrx_Q+2GRGUvzaxUaQCZ2W1guwvg6z0NLtDb8+k1Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:13:38 -0400
X-Gm-Features: ATxdqUECV_X3v2IAisRVECFaStd9YkgvSJOXIKR_aktB5UhOH_QWTGAeYBIh7fg
Message-ID: <CAP+JOzQBLMVDen8zvmTAenZCoaLS1SDO7tXGH5TSR_cwKuyjNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] libselinux: constify global strings
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Mar 14, 2025 at 9:18=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Declare the read-only encode table const.
> > Drop the only once used global variable selinux_rootpath.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these four patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged these four patches.
Thanks,
Jim

> > ---
> >  libselinux/src/compute_create.c | 2 +-
> >  libselinux/src/selinux_config.c | 3 +--
> >  2 files changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_c=
reate.c
> > index d19baa0b..ff8553bc 100644
> > --- a/libselinux/src/compute_create.c
> > +++ b/libselinux/src/compute_create.c
> > @@ -33,7 +33,7 @@ static int object_name_encode(const char *objname, ch=
ar *buffer, size_t buflen)
> >                                 return -1;
> >                         buffer[offset++] =3D '+';
> >                 } else {
> > -                       static const char *table =3D "0123456789ABCDEF"=
;
> > +                       static const char *const table =3D "0123456789A=
BCDEF";
> >                         int     l =3D (code & 0x0f);
> >                         int     h =3D (code & 0xf0) >> 4;
> >
> > diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_c=
onfig.c
> > index 1d8cfb71..75db14ba 100644
> > --- a/libselinux/src/selinux_config.c
> > +++ b/libselinux/src/selinux_config.c
> > @@ -153,7 +153,6 @@ static int setpolicytype(const char *type)
> >  }
> >
> >  static char *selinux_policyroot =3D NULL;
> > -static const char *selinux_rootpath =3D SELINUXDIR;
> >
> >  static void init_selinux_config(void)
> >  {
> > @@ -312,7 +311,7 @@ int selinux_set_policy_root(const char *path)
> >
> >  const char *selinux_path(void)
> >  {
> > -       return selinux_rootpath;
> > +       return SELINUXDIR;
> >  }
> >
> >
> > --
> > 2.47.2
> >
> >
