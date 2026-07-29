Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1A3CD8B5
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355216; cv=pass; b=pjYr4wEAkX9hblQOFQuK2B2QAvQgMgF+1YQVRswi+858u3cJ69I0Bz6UTO69D600X8Rp4SUyV32G6tL150AGJjM4xdcbgSuyNji0GxnXs9Ricac+zkOJ6++hyHm0m2zfYPOR6Yiei+DGuEEm+tgbc2Hzx2zx5D433WIYgSI3Wr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355216; c=relaxed/simple;
	bh=Ay5vXA2Q2XWjWhq4sf/6rDji04N5tWp99cfFtzr6fyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juLu2e946Oxv4G9hHi0J7lp6KwqMSqdxmfAotNVT+s4vLnUzdI8QBMvsJpe/jPR3p+z3Chg9w6vgLdalcq3P5mmGdpMmF3NHrXvgTb3lF7gbeGRu6nCbsEL3dL3DB1ERmrPVmUXur0Xn4g+kHtNn4eYQGgsx3REKMuIKFfbHxos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nxk59BVc; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nxk59BVc"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6aae3e18607so566756eaf.3
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785355213; cv=none;
        d=google.com; s=arc-20260327;
        b=lZEMe3IhZemxT4dNYapfJsc2JyML7iClUHx9GTiyqF58kom7iP1ZTCbWyNGRWWf5DT
         YuVcO6gua0HA9sH2AXvHb4ZjyAmmF5W9YebfQhmZqkl9mZKBKhDW47CaM89Bn7g166Wd
         zj71CTGPq9Z4P5zuOApQshbYF/Q0dlbnCqhfYQTIhgBignaiJA3ZmPMjAhO+6pETd5zY
         8oDHI5mcR56plQ2xPiC7/7JL5NthR6kNM3FNeWzxAg8EBB/TM2RrcyyFiT7zSTHLYo3y
         eGCMxVxQMOAkXzwMpyGKyZMkhEYqsKplwZNJknwGUEMXZcsQWlNAPrZfpl+0dr2cun/V
         0k+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lWHlZQIrooQqLkq7Q8VpOmI5JElaqBB4ZfWN3dZL280=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=pnwBzpy87DmDR8kxv6ikOLwtFG5nmLE62ibTTvsfZU/fUCfyK21NWKfLasPFMMJJCi
         eGpzd7u5n5HUmF7MVaz6Cl8BHPmf661Y6Vg74CwaOj30kbq8GI91fjElm3LdKkgOKQeo
         T3b6ve56L5i3pLfQQfX8/G56PtnufRskTT0HSkDkfSVP/R5Ki5l7W0m6WbpP+/1xLarF
         hPUJQYw0JuGfabzfCio5ClXOvVwVdS+JoCDSrNefPwtrD7RIO47Lxt0c0xQySNQdFxN2
         V9An+00Pez6iMVClh9F4xc0YaYq7Bvtp7f+X7fl85a/gQquExt4xmKLc5m3dnyZL2V8j
         SrQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785355213; x=1785960013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lWHlZQIrooQqLkq7Q8VpOmI5JElaqBB4ZfWN3dZL280=;
        b=Nxk59BVcMUegC9pAsybUSl8kvr2eifdsf0o0sTQiXaoSnzM9gjnZdK3uSyr7U/4trG
         sPluPYlwDiMnzKVhFc3TlhoqvWctZxMc3+gtpQfJGQG0XScYxRN5bPlHSejrljAbU+Qq
         u5ks8ObNmmbUJXhlFfVhegncue5JmJpqPGIQjLV4s3pW2CBNadGYq3NenxVN7wnyG3es
         GkEJKH9Q4JlyeemzxSR3NEz2baVV+bVX2c8PtdLmyyUaRS+zGAiEkejMioAb4IGWi+7e
         mweRyWBZ/B86bLnUwIPYbVBHE6mGzyDAYPu1hr8ylUh+IQCVhDqIT4Bd+JgBdvgsTm27
         njaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785355213; x=1785960013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lWHlZQIrooQqLkq7Q8VpOmI5JElaqBB4ZfWN3dZL280=;
        b=YOSAbEueAARjixO+aai7smv3D3JMn0/WTpRsSPuxxaTkququHIiS6SodOAl9mm9Hcv
         gaHst5d5p5IydkbUDOW0JsDRmvN4OA6gQmCsQalsSPWeKdyYl5faFHlYUr8AxiHikqPp
         jryQbT/vaRZoXHh5WJexF/2gLy8QenuRhgQpEy9Nn6495AGGfM1sZKHbCaPd3S9ne+Us
         G0UFmFLk6Y+TtdiRq1BMIuRELha05jTt3KcxLlqilYpBbRDukUSEZ1sdRAKMS5fv4cft
         3M7iA8h6zMBpyJ6/ZYPJHn2e+h7W1nsFQJdP0MlJc2NE71+ziWFAQW5BhJAFBU3GTvPo
         O+Ow==
X-Gm-Message-State: AOJu0Yx5DZ0qy/NM3XvKe7nXls5izxauQt5Lap+Ly18ZaleGt1YI9JTd
	hM/vg1XXNN9vAMK7U1oeE9URRS3NRafYMeYowa5itrrXheZPTWscwn6Vw3V5CWUZFHK4MZ8Pr0G
	zYP1BcBc6MhJoGhVKgKNw8T8hPtEP2TP8jQ==
X-Gm-Gg: AR+sD10x4uUwbEjmfG1i6VIiTZFi2RN9Pf+fhTCPUbZUtOoC7d8JQQueUEEwWmz4kUK
	FsJHsQbzFu7gyt/WvYX/QVsTck4xMoH3h+BgA8LsROyWHMAkF2ciWW80CE6s613SWFCuJ67HHLa
	ewsyLQVLeNZTbkDmUKY4dFr19TMYkEeqhRiZnVIPp6VBhf4uVPh9zZBtzJBkNPqcYRp39WkLETC
	gMBRr2WdRk5UGe2cZLHGQD3ybLXyYYdJyvww9nlw9LTn90U6yjsE0t9WP3pzK++hSVUAfnpN6me
	jKhkEej8HdvvCGwVn+G9p2C3zCLPBq04XE33T2ZCClou
X-Received: by 2002:a4a:edcb:0:b0:6a1:4040:97c1 with SMTP id
 006d021491bc7-6ac96cb29b0mr3852441eaf.56.1785355212830; Wed, 29 Jul 2026
 13:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729193713.23187-1-jwcart2@gmail.com>
In-Reply-To: <20260729193713.23187-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 16:00:01 -0400
X-Gm-Features: AUfX_mzh5cXkp9CG8JE8230i0R-gO2BMN0UpvEXajY6sYriInwI_5LnjcbMM7Uc
Message-ID: <CAEjxPJ6J=ArpCwLAaCed7Gn2K4nDJODLcSwZ5orJT7zw4HyiQg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Turn assert into error in type_set_expand()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The assertion in function type_set_expand() can only be violated by
> a malformed policy. Since it is called before the policy has been
> validated just return an error.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/expand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index 8d7fe519..19b5fdcc 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2827,8 +2827,8 @@ int type_set_expand(type_set_t *set, ebitmap_t *t, =
policydb_t *p,
>                 for (i =3D 0; i < p->p_types.nprim; i++) {
>                         if (p->type_val_to_struct[i] &&
>                             p->type_val_to_struct[i]->flavor =3D=3D TYPE_=
ATTRIB) {
> -                               assert(!ebitmap_get_bit(t, i));
> -                               continue;
> +                               if (ebitmap_get_bit(t, i))
> +                                       goto err_neg;

Why did you drop the continue; in the non-error path?

>                         }
>                         if (ebitmap_get_bit(t, i)) {
>                                 if (ebitmap_set_bit(t, i, 0))
> --
> 2.55.0
>
