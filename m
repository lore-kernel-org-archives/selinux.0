Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DE3E275E
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780338839; cv=pass; b=a7M8FpjLAyUnHse0qYGDwOO3AA69qF1hRRTZ8js975F9IzEQqag38aKoP7MpwpyThDTjZbMw4VYNVdoS82k5O6b9dTkdZZt43yXZkmvQfl1mErgKOCiNNn4ppY/tPqjO8vrNlh6LS2JVBc58X6eQYYseUbatHNvT+w9Gk2yPGUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780338839; c=relaxed/simple;
	bh=4Wa+7ctl53nzijsgKgZw3s/XkwAizOjUTmiYE+zx9Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsXDw1lykdknp7xMFfLaK0mOxtkrC2DIGuS/IcLo/32JWuIKpOflyYKONX3tgj4n2jwn+dsKq0P21qeVvT+NxseArtXFvPNmMmN00ZYUJlBbzkJH6hm2Ht6i5aYXwIgzxzM4ooP9PCVPNuHIO+Gifz84jdXPUy9ewXKX9EmqRU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS5Jxiok; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS5Jxiok"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c35980fdso17505565ad.2
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 11:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780338837; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3KJ3DJpSn/MJ0tJeN1ZORxOr/Poz6lWL9OFrAX6wmhNroDVYHygUbf9dSpOSl9/lz
         QZAG5/IwXsxExawhIta5nkIF0oZxpL4SteV1HxT3ix18PCExMhs8zFEOeMFU3OZYzfo1
         VP3C4isfhDfpVs9mjYYCE8C09AHWdo+gojtXYYzwViclB4G0MMUO8TlDct0ZgFQPvlPm
         1c4FL8u6aco8psscb/J45WNmPdswS3WANlgF6GJy0IUGD8STkO8xRYZVSf4Tf+91+Hom
         J1A7lvF0KH8sJgQ7nIK1Q/dDA/fq/usDeUNrKlOuXmLmf5LWvi0w8u2v8epqW+CG+LB8
         EfSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqYs5lhriYk1x9eTtk1ylWxoGNIoC7b0pNRs0wrsKYs=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=k5AxBn8NnL1OIaFlJZKw/SnRjnbvGvy1vb1M42fh/1Zllmtoo3rkw4SsfeM0pYdbvf
         BmQ2U+ZEJjpmpzAwlEPK2wGCKWZ5KGH5zc7Jzgw3v1SSrieCdZ9A0BMmHu8aDuWyn2U4
         GZiynzbb49Fgz4mlRJfv1lJdh+vL+sFRkqAs93Y32ojiOSe9xkpcSJr14Qts/IAXiEcJ
         A50V2ZMxC+O03fyD8Yz7H8YTEI81VGRuw5GyaXe73vyeEkJtdT573fS7We6e0A/VQaGV
         PvHCSNX8nM0V8baNUBrZMlflU3AUGv6TAFXQuikAEDV/omK/s6RjAtX9RKiLqrTVdurC
         R2mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780338837; x=1780943637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqYs5lhriYk1x9eTtk1ylWxoGNIoC7b0pNRs0wrsKYs=;
        b=FS5Jxiokqg+e80jhDiFSxPV23e5oTCeiyeehHy8p4+76BNBNxGoglBFlfDuUwpKJb8
         tHUT7qdBn9JuyPj3eZXWChvTaoldSTIA0zDoZw5FiJXpeGIoUy5sv4x2VsrHx7AzxpG6
         GBadC/39LW/zcJdwNRahyGoZ2aH1wkX5j2ENcO0I3p2L+doQjdsQTlb4Z19nKzq57PSg
         EHcD+HLAmDPgSCrhtTWFl1AxZrFjfDJ8EQta0YgEOrsjkScfhkMBBN99bzEWGuSyUQmV
         /tjySyi0NdgiQSyu6hzjLKo123RrIlkvNBKX4+UY+vfGNe1IIB3VZ0CpswqibxYq3Ste
         Njvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780338837; x=1780943637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqYs5lhriYk1x9eTtk1ylWxoGNIoC7b0pNRs0wrsKYs=;
        b=qfoX+tn4ANHR+GF+Kwjw0e26opglwbtERsaH/UsV1OF2TPoIrk8W8lmGWUBgpKUJ6y
         CsAoIIL+nHD7BE4m3pl9AdSPumBSfjcU3WtUkuIMCVdIDoqgux9+pC2vP1rtXRWTHNDX
         X+kHezgM9IM1HrH+WDV6Kwe6Ju3GsV56fCBLBy7XpVyQBRhEQDVHoxuesjEesS97s4xE
         4Ri49QqnBFLLUxExKscD/yYZFTAsn+CX7Sm0B7veA1u6w9PQ6PrpILZpjkPIRLlYyg8t
         UWE0E9/DhvI2g+Yvf1MWF8QuHyK9JT3gs3FA7mEkxFacIVjpxAEv5iA+/VKGR9cGqxPG
         0B5w==
X-Gm-Message-State: AOJu0YwM1rWcR8hOHJv/8FhH1lzPVRDkKSPawd44JooFq0quEY9K/018
	NsTGrjJofxYpLCFsZPAXfx89d/VT+MRC+p/HuUUdKHt0OlZnEkebrDiRkNGqVqzDbQHK8u2h/Zx
	4prsRbvFzL8MXou36fJ9zJsp1vFZ88kRdJQ==
X-Gm-Gg: Acq92OEH/n4XdFJUILSsM2eZ9SZKpcN0aIG+5VV8Q1DTchix9VbwJqB+cbnJSz1vmDy
	vb75p4CqwG4zF9qcmBAET8qhSAF22xpw5sAQ3a14mKiyIzcgUKXldqX8pNZoirWQI/eImjI2Yt4
	wTy5Vy+3OzT3QPYg7ijVmB0YN1kJgyxBVXTdYTktQYHTlT/sZ/qpkCVtoDdacu3AZhAnrV5r7FC
	4I5bKtdmgHygdY9/Aa8wqBus8t6wepeHpXh4X4YsAMUSaRcSAAbi0LoEJ3vrJ21VA1Bo/uIUmwy
	5WD0hGQX3jUF2h+uBQ==
X-Received: by 2002:a17:903:248:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2bf3638221dmr132514765ad.0.1780338837379; Mon, 01 Jun 2026
 11:33:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531163723.683086-2-nvraxn@posteo.uk>
In-Reply-To: <20260531163723.683086-2-nvraxn@posteo.uk>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 1 Jun 2026 14:33:45 -0400
X-Gm-Features: AVHnY4JwUEggzf-TbcB3d-8ABvUDM8DFoHWLqDZCey_b9HG_BS2vXOKWYv6E1nM
Message-ID: <CAEjxPJ6SdvWkcUd=EmivGhB=m8cnh71-2JzHKS60izTfTXC67w@mail.gmail.com>
Subject: Re: [PATCH] libselinux: restorecon: add_exclude: validate directory
 before deref
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 12:38=E2=80=AFPM Rahul Sandhu <nvraxn@posteo.uk> wr=
ote:
>
> Currently, the call to strcmp() with directory as an argument results
> in directory being dereferenced before it is checked to be non-NULL.
> Hence, move the validation of directory before the call to strcmp().
>
> Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 69a53503..6a36de67 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -204,12 +204,6 @@ static int add_exclude(const char *directory, bool w=
ho)
>         size_t len =3D 0;
>         int i;
>
> -       /* Check if already present. */
> -       for (i =3D 0; i < exclude_count; i++) {
> -               if (strcmp(directory, exclude_lst[i].directory) =3D=3D 0)
> -                       return 0;
> -       }
> -
>         if (directory =3D=3D NULL || directory[0] !=3D '/') {
>                 selinux_log(SELINUX_ERROR,
>                             "Full path required for exclude: %s.\n",
> @@ -218,6 +212,12 @@ static int add_exclude(const char *directory, bool w=
ho)
>                 return -1;
>         }
>
> +       /* Check if already present. */
> +       for (i =3D 0; i < exclude_count; i++) {
> +               if (strcmp(directory, exclude_lst[i].directory) =3D=3D 0)
> +                       return 0;
> +       }
> +
>         if (exclude_count >=3D INT_MAX - 1) {
>                 selinux_log(SELINUX_ERROR, "Too many directory excludes: =
%d.\n", exclude_count);
>                 errno =3D EOVERFLOW;
> --
> 2.54.0
>
>
