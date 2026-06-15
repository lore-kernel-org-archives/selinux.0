Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E483FD13D
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781535390; cv=pass; b=Es0iYU5zbYv5TW3n48MgMYRLoz9itc6FiMgJkOhaHYOBGb99PHYaAfdnld/5WozP0mDE19rwIEprRuLs7lyQkIpB5g5hodTOZ4HVdXHuPnTe+/y97izHS+MkFLcdDZtX7PofjMSqSyNahcYWi1hlI6ayBhQ2P2NyT4hHxeOjGhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781535390; c=relaxed/simple;
	bh=8vjMHhbqdjpHqtaNgpgwKpfhN+MOLN+vXGRqzSgh5VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vw3LPMLgGY6IjtlD2T+005kVNFsXDZE3jF+3VdUgb0LugTsZK+Zqcfa6NCLHNFcSfnqToMusLkCBY/uDo/zsJGbpfmRzRVCe767ppedYOR8+JP9goW8OK6ocdVlyd8ukArhYdTp23HhGjPMMuq6SMXetEND/lGSFgqJXnZtLAAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RACCN4VC; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RACCN4VC"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so2235152a91.3
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 07:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535388; cv=none;
        d=google.com; s=arc-20240605;
        b=dKEyYINkEZ8+z6WXBE7ssml7uJFDyZduk5yyyqi/V1IqGYFuiF8Incb5d5/9dJSPaM
         LGTaAarCTCZYkHLKl1bQ+BW0/7maaR+QMoopbri6GgJRBycabqdYNSyFQQH4zt1bfAgM
         g2WhjGjV02tDZngvdNey+jLPqN7LRWyusiemiGnjjfDY2s0zfWREoKD7QpnEcsFQpVX2
         2x/1ccQP2rynrwpeW/Pg6N1WKPXqE+ZnA1QvUK4TYojMu+V4Zbwqs/b3XCpNY/17UpP5
         IZeeeNxBssUWBUoAIFSXcWUnMjETiczzZRnnsUwDKcH+PnR+oeFLwEVRlXPjeR00Ezzw
         V/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEN6nD1J0yE4y7Ox7uGt0f5Nv1wcy72enXY5V70dAQw=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=HElP+UV1qYhNTUVBtrGlRBDuiqAuUV1VnSohQBH1vpcayBtHB6EXlyALM4KnJQpOGK
         rQSTRFuP9vHdWa6CCPsp+2ePE/9oI6Fj+xAQDB1yWT5PAUL4OmnfDyke0SXpei9wjozH
         bu1ZG8ptw6ydo0+uu5ATGlWvWNgDwawinLhH7Hfp4VuYs2HCO3Boh0rqT103KshcnEWp
         EDFzbra+0FFUyLPCrDbvhJjzWgs+vQA9VIZ4m4NIDaEfyl0qMyAXVA0P1Fzv8rjlwRkE
         nxYLin/zgPSfIM79MmZVxswdTWVD0QVL1PvlqEDn9BVg1S7XuNsowQ8v+tMQE035EVk9
         5jIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781535388; x=1782140188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEN6nD1J0yE4y7Ox7uGt0f5Nv1wcy72enXY5V70dAQw=;
        b=RACCN4VCOoeJDxHNiIeQN9JIjYpE82qrPEpteYkPxWPKIKPJyOeIKN2ffDlSnT/arp
         YRKqg27uRv1vh+VSYTOsWUVkx0jGq/DOUR6v8AZDuZUVju0J8rLPCtXB/2FCoPDlosiO
         WL0a9QHtUuy9L/XhlsTcjZXyyNp1cPa+upHNvqAAeM2iZUca59JBgYgqMX/WE/2RAgAw
         kz/UL1KDvysdJlUtwpvQjXxJ3wjuk7jHWI/SzQOlyhiXVBtfpI1i0uHh7qMzNXS6zigT
         IHzX4R/EKgzY7Ovv4Ci48p5HphhVyNpYXOB1dB9slniZoaa0xKKYVGjTtEPdajBxiTv6
         Zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781535388; x=1782140188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEN6nD1J0yE4y7Ox7uGt0f5Nv1wcy72enXY5V70dAQw=;
        b=TpsvJ8rL8o/reWzo0n+mIQ0DMct2A6x216r40uU47lPFki7t60djH8qV/NteI6cn5+
         9CL75BH5SrWJBhXddtse+hi2jK2ficTQZAOLnUnxhqOUVZWEe0RmrKl+S7gkZqkcxqw/
         DFMOudtefAVhJlQ9japs1zKtH93epfur35ipEazzPKPLdvC9Gmo5b91U21cH/n91qyNG
         y/S9X5c9/WkKkHRjiLVA2O3sI6I6ve+LdHQ24gCO0ALGn/RA1vvpbGuDbm8C64+81ykU
         tIAQpxYY916nnwf95HveMmazOa1oZHOCgxQMzxfsOYe93DOu3Z4hrBUCPLLm634rMXP2
         iMkA==
X-Gm-Message-State: AOJu0Ywgiv2xkhXIe4rYptVoBfezObDIAsB0drgTLAcfOvpvqMcfao6h
	REFwSx3Ub0TNv5wNK3JBbv9eIm9IwFyHCtX2r1TIbISJjmYK0v9dkcVkVIyPg5psE8QMUjS6y28
	HQf+4jBgCiz1TW/kYQFKPsj/Xp/z/oVw=
X-Gm-Gg: Acq92OG1iFDyje0U0lrPyJraa3fbBMRoYA95GdUEEgENZ/SxUSiDjj5E1aVkMppuiVm
	y37rdJXwRn7xtdMnQYS3b/beGgbEqAG/nHiOY30zEwvSrS/QmhsLSx5MQjvIB7k9w6VEhSTGmgd
	/HDBd52weRVQZcoax1lelGhkdpN0eW/csh4w08QAVzwqZ/4xpjlvE0CwC20FdLwackKhN+m0huo
	/OnW2E5dllAjbru5SD3Qx1alv6fE3lrhFcvQ9H4+W2LlQlqIcxCPQdMoe639nw8P7L/Lwq9QvS9
	ZAdyxaA=
X-Received: by 2002:a17:90b:2547:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-37a03bd0b9cmr15555965a91.21.1781535388420; Mon, 15 Jun 2026
 07:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614143645.55809-1-kalevi@kolttonen.fi> <20260614143645.55809-2-kalevi@kolttonen.fi>
In-Reply-To: <20260614143645.55809-2-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 10:56:16 -0400
X-Gm-Features: AVVi8CfAIf9y6moGCeXIm5Bh6YDc6Z6IdqZxg21vU8P2CbyvVKtrA6XINMQLYfc
Message-ID: <CAEjxPJ51u6jLyeoKVeaAAYoDpDowhGngP3W6pipFX_dSb5iX_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] policycoreutils: use null character in strings
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 10:36=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policycoreutils/secon/secon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index 2f2b06ed..6d4bff94 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -373,7 +373,7 @@ static int my_getXcon_raw(pid_t pid, char **con, cons=
t char *val)
>                 char *tmp =3D strchr(ptr, '\n');
>
>                 if (tmp)
> -                       *tmp =3D 0;
> +                       *tmp =3D '\0';
>
>                 if (*ptr && !(*con =3D strdup(ptr)))
>                         return (-1);
> @@ -422,7 +422,7 @@ static char *get_scon(void)
>                                     " Couldn't read security context");
>
>                         ptr +=3D strspn(ptr, " \n\t");
> -                       ptr[strcspn(ptr, " \n\t")] =3D 0;
> +                       ptr[strcspn(ptr, " \n\t")] =3D '\0';
>                 }
>
>                 if (!(con_tmp =3D strdup(ptr)))
> --
> 2.54.0
>
>
