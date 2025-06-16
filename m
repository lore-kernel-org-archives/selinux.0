Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E42217F40
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086389; cv=none; b=ArcMaCv8WVBgMFK6ZACpQJaJYdZpxltQT3Vblakpt7zDsnOL+iAZWhaBYqyoL6uQ2hjS/jPY+1LL7miEkrGPMobcs9uUBVMSm0Fej1dIFUqUYaNjvK0BKdE6pruLytdT+6gChmPRN12yYRa60iDnBoB9/ugTk2jq+ESbznfpdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086389; c=relaxed/simple;
	bh=Ds8VH4yesKz2jb02aD+1iR1iNFcpUPacGgvXypizP+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4e9gC6E0eivX8WY8yQacIJB2Ntr4a0iqlKchSH6p831kg/Z4wK9yb7+BLzVS8q2ulrpEyNbhDRgy6hCXnv/suIVGjuLsX8jZrp0w2G8cI51yWw4D5RTVy/wExINfx67UxF45BTnLixUdgMcxBZMwnR3n7UuescisNk3ORygOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WxOJBxvT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WxOJBxvT"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e73e9e18556so4306325276.0
        for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750086386; x=1750691186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrRnZ9pyC8XqqZtxmYq5AS5+2UIIVm7E+jUkLig2gk8=;
        b=WxOJBxvTPP0VYdh5BzqEx0uQpjtpEhTurR1QfOOtw/p84C+zeE9tIDrNgXb7ldkvKP
         WqDi5FcocWwkZBEr8W2H3m3TKVc6ZOjcdjtO1+gcGfrJyk8DRpW8WgiU9wyvH+0i4TML
         LMbkVYx37qfOa96PHhqVMTpoZD5tcMWKpNrF1gWMvs8CDuhTX1u4ZPBKY8uC6UvhBRDR
         z7DukqXhqGdxz7zHeU0YrMMrMl98IVYGHF5TeJi0vL94/YleEl9fPcUAdZNXk2FukoIT
         e3qxLLjzy7wcmqsQBrdtln6hzbADXN5quXG5CZk+Bae9GhLx0a+I02vGsOf9j8GQ3Rpl
         tB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750086386; x=1750691186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrRnZ9pyC8XqqZtxmYq5AS5+2UIIVm7E+jUkLig2gk8=;
        b=ix214bbrqx56iha2VGiJCLtXgx1225AHmvw+cF8guN/mdoX/zFexg/CSt/ensHqIsn
         +Gf8DHC1r3zul0CjQpm0hg/i/00rYlzCH6qwTirPIgqPrbHEkoV5zYMIGxlsCx9WC2Th
         N8XEvU1NGRpCw59AANkbsHdfgfrjaiDs24csf/atMk/e+CK62+8Z0/F0Cj2Auap3oOp/
         NjXUbLtyvXNKLJPUwxJQRWAsZyYjysBrYYBP86qxRxpWf59N0bNZTOhTcIZw+bGUG3lx
         gGUOLZFYRJAoPNeF7vxN8v5te9x/Xs6UYd8nfmpdAN+54BSixjDl57nu7BO9Umq1+MY0
         5iXQ==
X-Gm-Message-State: AOJu0Yzeqd3tSgmMb/09lAyQZ4WT+P+YIqdDn2tKi4Jz/lVpGHCfFCmT
	2LICesPRfBlHXV4ieF7tor+eHkwCOBxzVWw3v2zx2IZwsTOWizhT7tT9YBmCkuZwubRHjfKVCEN
	xDHJUVWuiDxHruDq0yxNyXr2smuVnwKQ=
X-Gm-Gg: ASbGncvHqwNyqhK6qhlH3pteubRLyRHkrex4tZSqwPOc8+6fJdzRxzVTZ90cvtsOKar
	3ccvEw5nSnY1bkY0WL+LHy4fHlGhmbvIw5HASRBLVhBgHGorB+D0Z0YkoZI3qvOGU8T6w9SEuWH
	HTQOSwA4Nex3jgKgDUE8HYCwCIeiUBLpdjpG4uHLR+O7++
X-Google-Smtp-Source: AGHT+IHd4Lik29Uo/FVkwlb17DEa6NOsJ6YCqd7q4tcnc2LC8jlbDzQFrTdmmM/dPqQJtxGyX/LyrJd2VZnA5vKNves=
X-Received: by 2002:a05:6902:2687:b0:e81:84ac:cb1 with SMTP id
 3f1490d57ef6-e822abf5ce4mr13748559276.8.1750086386260; Mon, 16 Jun 2025
 08:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613193704.12261-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250613193704.12261-2-stephen.smalley.work@gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 16 Jun 2025 17:06:15 +0200
X-Gm-Features: AX0GCFs5jumAKHr0o_69nriYgbSUOmR0VGaPMgVsG5OoqhM0GYYv69jqshDJRuc
Message-ID: <CAJ2a_DdvyHHbqjd9cR7cWkdYx_LcwX3NSMPF_80oFZdxNvvgFQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jun 2025 at 21:37, Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We should count the terminating NUL byte as part of the ctx_len.
> Otherwise, UBSAN logs a warning:
>   UBSAN: array-index-out-of-bounds in security/selinux/xfrm.c:99:14
>   index 60 is out of range for type 'char [*]'
>
> The allocation itself is correct so there is no actual out of bounds
> indexing, just a warning.

Seems reasonable.
Should also fix not copying the NUL terminator in selinux_xfrm_policy_clone=
():

     new_ctx =3D kmemdup(old_ctx, sizeof(*old_ctx) + old_ctx->ctx_len,
                         GFP_ATOMIC);

> Suggested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ6tA5+LxsGfOJokzdPeRomBHjKLBV=
R6zbrg+_w3ZZbM3A@mail.gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/xfrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 90ec4ef1b082..61d56b0c2be1 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -94,7 +94,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx =
**ctxp,
>
>         ctx->ctx_doi =3D XFRM_SC_DOI_LSM;
>         ctx->ctx_alg =3D XFRM_SC_ALG_SELINUX;
> -       ctx->ctx_len =3D str_len;
> +       ctx->ctx_len =3D str_len + 1;
>         memcpy(ctx->ctx_str, &uctx[1], str_len);
>         ctx->ctx_str[str_len] =3D '\0';
>         rc =3D security_context_to_sid(ctx->ctx_str, str_len,
> --
> 2.49.0
>
