Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B61BC2A
	for <selinux@vger.kernel.org>; Mon, 22 Apr 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818920; cv=none; b=f4XQelzGFp4B+NDzEBgRb5+r+g4BBJ3GBC6+Fx9D3HVqALcqy43X0l6sgn1o8vjEyuJ79kg1nnAbih7NQghfUSeTZCEs4mmlHn+B0sYkz+JdmwWMFHHDHNSLaRVvWY4IdJBbyWxBV/TV1Kz3efReCxEdT9Y0ptSvgpuQzq+4BR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818920; c=relaxed/simple;
	bh=VRYa7Drd/ocEEgpuqSWQ9xKbvQjy/fe0t9K4vDmWows=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n25STZWfXuHpT33Mo5O9z7KzFGnNYjrUxpUKy+NOHjXyILeo2c5PfCtwhVQbeVNrhQwREHDOa88jCmpLMq31LXb3RyJYf+G+4P7JzhTjLXFgYkjmc6OtRk/Riy3Gj80BWf3j/GIzhoR3GVOQ5i7N8XEmad3MFt1ozxnrWOD4mZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnBL7dK0; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnBL7dK0"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7e7cf5cc1d0so3721283241.0
        for <selinux@vger.kernel.org>; Mon, 22 Apr 2024 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713818917; x=1714423717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ux8nyDwonVbCDmVxG/SOHb6LmJItcNDqQgf1YS8cmY=;
        b=DnBL7dK0EEM38YQw8ZXCyJcPY4zRCMIiXmVdN+x0UMjd/ZX7CadX68NiFVHDk5tYTP
         L9IvgBkIPk3HrUz7wdi2nZ3N3WTgMigFk96OQnVz32Y7aKxGYwzeGlvcYPDdeYvsSj8s
         lenrOJtnCo/S6yMFQNxSSQ3U7pgeuNwnLZwd2B0Uw67gGgdYcB8h1qbZ5qIepEAcKkWT
         cmibGqGAWH9xR1D/UsMXoeJHCIUFCvSyUzruR6CB5ob5xzkF5HcZIDDA+FtugKC6j4zZ
         XJeP5Wkn6wEQ6r223XtxYu+zRrVKJsaEAh/W8QeH5LeVCnhEzlqaH5400doEZfZ85aMF
         MASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818917; x=1714423717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ux8nyDwonVbCDmVxG/SOHb6LmJItcNDqQgf1YS8cmY=;
        b=P1g+mrlOtMCsTUPVpx4qRTnTaG1EmeeubP/qQxU62RPGtuvYq2QRJY8dT1gvUZOrv6
         Ea8eSiD6TOw6r6V/eetwMRhccXqi4bPse21NJA1T2Co6XK5UZ2CxpWuWQ8XjrSRFrFgD
         ES7hqtb9AnjpWO5N++D/NFLRfXHtOn16VkraSwn2zz2G5SI39pwsWwn4BgD97RpDaHyf
         AWeO7jHPkDsLPPwj2nAaSNWZlHq187k6t+1bsqaJb4U1ScZmE4lzhr5X890ST1JirVlb
         Ehy2rDnxWwz/nDVHTJRbW0RM6/bZUQBW97pyVCyE5siwZ/9AbpOs4VWXhpYrAQsxdmCW
         f2VA==
X-Gm-Message-State: AOJu0YwjLWzd0Lz6puZuinWyCSWe5gbVKQcEGL8XZFfbBt4Aw9UwKmUR
	kt2hF2j5Tes4NZD1x7Nfb3sES93Qqqmb0ln1BtZXJzgJ0SoUOZPm5fRVMa4EzcQ0A9iVv2fO+J+
	rvbsJ/Kpnys5JrF1gc8kxZDvKjIYs8v+T
X-Google-Smtp-Source: AGHT+IG/z2MHT5KDU2S9UjUqfrht/suObTlaDztR6pehd4epwkxh+XL7+S8dUcK6J0v6cudJrUHDPWVYxhjKQxvMFwI=
X-Received: by 2002:a05:6102:3971:b0:478:4d51:82ec with SMTP id
 ho17-20020a056102397100b004784d5182ecmr1412276vsb.4.1713818917355; Mon, 22
 Apr 2024 13:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408150802.63941-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240408150802.63941-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 22 Apr 2024 16:48:26 -0400
Message-ID: <CAP+JOzSk1oNHeLDS9W=94j1+GH9CjwPuMiKvKSp2D=ja==7kdg@mail.gmail.com>
Subject: Re: [PATCH 1/4] libsepol: improve policy lookup failure message
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:08=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> If a policy version cannot be found include the policy target, and a
> module prefix for non kernel policies in the message.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these four patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/write.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 283d11c8..2fcc1701 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -2252,8 +2252,10 @@ int policydb_write(policydb_t * p, struct policy_f=
ile *fp)
>         info =3D policydb_lookup_compat(p->policyvers, p->policy_type,
>                                         p->target_platform);
>         if (!info) {
> -               ERR(fp->handle, "compatibility lookup failed for policy "
> -                   "version %d", p->policyvers);
> +               ERR(fp->handle, "compatibility lookup failed for %s%s pol=
icy version %d",
> +                   p->target_platform =3D=3D SEPOL_TARGET_SELINUX ? "sel=
inux" : "xen",
> +                   p->policy_type =3D=3D POLICY_KERN ? "" : " module",
> +                   p->policyvers);
>                 return POLICYDB_ERROR;
>         }
>
> --
> 2.43.0
>
>
