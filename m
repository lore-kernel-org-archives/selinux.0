Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9903EAC72
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676193; cv=pass; b=Pur7K+KJqH2I61LAeHLPmEDEEAhrlrpcLDtWOhJq+9msxIXYvjQX46i4RImxfnkldc8UGyrI9y7+x3SJt1RzeI0UG5Pbroo+sjkLp9nPbE+21mft7MUXW6XvT1zMZDCKlzHty5IfvprJPhlIvfq8iTXEDvKxPFU/s+sRGPriKqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676193; c=relaxed/simple;
	bh=koOY23diI8914Ko6E8b2WmV7NCltH28CxVjv/Ei1Y60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNj++5BYw3Keg2Gd1Oefzo/0Xuo0/IKbJrg6nI+W86/qFHwMzByna09+2jp9yxyc6FNQxpAibTUsui/3ouS+8qKDHVWhua4F92U8rIWFtuEktgZ3IZnZF/YFAXW2nqITES4+s13PDZMTHtf+60TJCb+T48N/eNLVIFhxb6lr3mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYx2j92J; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYx2j92J"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36da151a152so1591539a91.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676191; cv=none;
        d=google.com; s=arc-20240605;
        b=D7EGBygjbVGsb4Hl3M7YQs3Y/OdLSIqwhaNT86O/qizz0CeG84Ieuko3MSMI2LRzoD
         salNAmil+Dd09yeKmKGZavfnSVomf04Kq2WG3I8PolLk91VJi2r+3XH5C9SvaB+gfhyC
         HV7QrCqTepTG8ljRVxM4wRvQOF5dT3/qCZk+91x2tmObvnIm1tpPVe+8h5QPZMwNyWwL
         Jme7RgpnlejlYCPSKfElb4UAgI/ltzQITYPwFxlRgZGQl5b9gJBxRmMIg33bd/o4G6/m
         7HrfxW1ri64VBBYtdLRtnkETx/bmiJzVdx/2aVryoYJ83uo4y/sOY0nRZ9eEYsSJLUft
         PJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fo0fRakpsETXnPz5f0mgTTbYs7eRPvRn+aRtzXsTQOs=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=K7cO7ahBQCVpzLCCxKxlw5tYKKaf++YaflO3wDQygWHKU10TqXhEegQsOpayngtdMp
         Ki9+Os5pbM+Eb/lDWVWL4WpMlYCQ+maAjYrQjeGmOy8is5VPo0LpmcIHHtGhqqP8v4fL
         smi/hpPukJ2RV1Y1h+Y7DbwEdLNVsraLxI7W6TEVGiZdzHaAqW1BgJ67QdGPBxTunXdD
         0Z71iNjg2vv8W4ZCGxH980dREXDBBZFo5tv8SQyoq0ZnDknuhXL9MJop6KKZIVPPRQkd
         shfXshYkyGMb52ICvRFvEMSRjY/jSA0mmMbRrAzON+qF6b1qlRthgyo/MdYWqLctf0Kl
         EbVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676191; x=1781280991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo0fRakpsETXnPz5f0mgTTbYs7eRPvRn+aRtzXsTQOs=;
        b=nYx2j92JdcQCwLOy3lQP8P4teF50iNs2rzzaBpK7W/emD+YTPzs4HUZVCPVpYBl+cT
         Xuchy0thYPtB+dp0K8Vknl2CSVO837TuFTfleOvNnTMQg+TqPO+ISYu/ueD2vGEg3kKw
         Dv1u9G/p4xtb7m0pkfUn/OhNBtNa5xp6xYd3x6GpjEgrjB0RabNjnv/eGYGy+LRhU4nH
         V8FjPEht7gt6DlzsazjDxPw6+DiVRLEBMjAYXj3Aqfue9uLPWjZ4oH18SydR0FcaQtu0
         kgo7uCiKq0kXdFxiguZoc559VW7Bw88XJOzO522gyKrcBjL7bjI8aux04bqFAgRHmvuF
         KoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676191; x=1781280991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fo0fRakpsETXnPz5f0mgTTbYs7eRPvRn+aRtzXsTQOs=;
        b=Q4qJxXxgnaIJaToFZzHSuZBMzQBCcVe+kA12XAg5XZ5mZ4eqIzeANMiWfNwwnBvSoT
         wjmjEsZhdNZ0en439Fy6ijwgsNEuvId95/uHOCTMXT58wQCEAVbf5cchXHtjtB3vTvlr
         z886kTXLxHyaIGCQT1D05KCoCFLtcRSKJ48WxqnZZu56fxXPKtMZ3Nyb8C98wJDLhvX1
         W4B49XAVk8SdG0M2r5U+L+d/fgzW4D0N3N8W43zE8CD7sOD5bgX4kYw+x+iXNUAe5nSr
         0jx8BAs5IwRTifYzob6eek56vUDpXBWAh6QBr44jlfJ6jSbG2BZk70hFlM4nBreZAG+/
         h8WQ==
X-Gm-Message-State: AOJu0Yz8EO7Lg8lnEJzgXfbl4AlPO3A6vxnoqgbPm06BDE6F8mAyQITp
	3EqP5dhwEde916t4IklJr4rFBH9SWzxoAihgGc+4ASloLF9wEpVW8a2StJe+XGzeC4PBHTqHNwe
	1PxcthvGIWxwW5pxBW5bn0sNoEmxL5g6PiA==
X-Gm-Gg: Acq92OGouCXANOUhLm+ZagikCUQsbmG0zDm2RI7cv+uTSF3J1IPohDgURRE2+JQBFM5
	ZYwWBwkLOy4fzh/geq8koTgyHpQv87/BUYzNBFGs/S7EHmxUYAXkTjhXWD1+pKJYATh9Q5xgrS0
	VbAvSHiZmifBGfIlMqLljE/rEdpLdcosvF+2TbctOjUHt2eqiuEqDv9xCsYdoqdaO6fmqLpwnte
	/NMTW31FP2N5Ic5YzRcMx7c+dn6oFNN5mLeZv2E4yxnkjriuF/Q/Vi5oppWgc83ND0igQf88/hT
	cLRUCYulXbvwNCVglQ==
X-Received: by 2002:a17:903:2451:b0:2c0:d99a:2fc with SMTP id
 d9443c01a7336-2c1e78e4e7fmr47807585ad.2.1780676191118; Fri, 05 Jun 2026
 09:16:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604125557.255554-1-stephen.smalley.work@gmail.com> <20260604125557.255554-6-stephen.smalley.work@gmail.com>
In-Reply-To: <20260604125557.255554-6-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:16:19 -0400
X-Gm-Features: AVHnY4Ll-6fu7HhpppF-J_5eLBwhHJnblBLyTMKlJGS1ERMjm5tSWa9FE5uqmCU
Message-ID: <CAEjxPJ7+17fVKsxtO0t4EN61eYS1J07RXD4Kagoj4rQuJ5FjGQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] mcstrans: cap the per-domain translation cache
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 8:56=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Cap the size of the per-domain translation cache to prevent
> clients from triggering arbitrary allocations. If we hit the
> cap, the translation is still computed and returned; we just
> do not cache it for future lookups.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series was merged.

> ---
>  mcstrans/src/mcstrans.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index a983e53e..15c2d76b 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -37,6 +37,7 @@
>  #include "mcstrans.h"
>
>  #define N_BUCKETS 1453
> +#define CACHE_MAX_ENTRIES 65536
>
>  #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
>
> @@ -108,6 +109,7 @@ typedef struct base_classification {
>  typedef struct domain {
>         char *name;
>
> +       unsigned int cache_entries;
>         context_map_node_t *raw_to_trans[N_BUCKETS];
>         context_map_node_t *trans_to_raw[N_BUCKETS];
>
> @@ -661,7 +663,12 @@ static int add_base_classification(domain_t *domain,=
 char *raw, char *trans)
>
>  static int add_cache(domain_t *domain, char *raw, char *trans)
>  {
> -       context_map_t *map =3D calloc(1, sizeof(context_map_t));
> +       context_map_t *map;
> +
> +       if (domain->cache_entries >=3D CACHE_MAX_ENTRIES)
> +               return 0;
> +
> +       map =3D calloc(1, sizeof(context_map_t));
>         if (!map)
>                 goto err;
>
> @@ -688,6 +695,7 @@ static int add_cache(domain_t *domain, char *raw, cha=
r *trans)
>         if (add_to_hashtable(domain->trans_to_raw, map->trans, map) < 0)
>                 goto err;
>
> +       domain->cache_entries++;
>         return 0;
>  err:
>         log_error("%s: allocation error", "add_cache");
> --
> 2.54.0
>
