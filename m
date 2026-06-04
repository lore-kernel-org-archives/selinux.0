Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613F47B408
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581863; cv=pass; b=e6sG4kNgBndm0QC4cJOETZej5sJcbbE4FBC6qYcs5MdrOrLqjih7C20M4rUQ7fJfYr2aiUQvMZgbLvbxG3zmefoUbVLL9r5qwYWogkPdObwDgjC+T9YRGFE5MWHJJvHJffkFFH5kIT84uwbTXJTNcEsR+0CmNevuLOrHiAhIyWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581863; c=relaxed/simple;
	bh=xGZdZtV/gEBDMuU/JCmtiVz/t6D9zoWRlrx7ZA+wG+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4cQaqRTxIK+EtN8R7dk1lFqXJwzNcY2a0EOxl/u/2v2VB2EK8SuP/+lRELgl2l+K48mi+/gnvsWubqCYafIFIyA/ZHjLTmWngR543fpuX0MIMgvDVWd0dTZS2eaycMYUw8UkgbVb/UehK5oApIaI4yCwLrk75ke6BUNVmoj3Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omxHKThb; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omxHKThb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84237c55ef9so376125b3a.0
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 07:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780581861; cv=none;
        d=google.com; s=arc-20240605;
        b=kHdPGXAjJs1vr3ka7W8XlA7GlnvoykXYK6Sfym7JqBsO4MDbw80jFmRp9Wlsy7k3Dy
         H2O6H7AyPjYuDDRiP1Jh+BtOkJm/MXHDgiA6zPb+du+ZANqJ7TT6MAFTmpCVhB3zmlMS
         OP5Xqx3YTxKLaoYPt5UH8J6qA0UKbSoNLSduU3m9EmfUXb/r9FKHTFTN+zN4jvDHXNjv
         jV7r2lv/ml1p9YXScHpoomj3mBNYaP9vkbUsM4jAivY5kLFg13Ipez+HB2RhkDuTKXg2
         iS3oG/sQT4EeKISDGJN8eWRqlU1foscnLnp4X9UgRxw1xLjuT/0LNTL4Dqi1NAceOrMs
         f+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SCVjkCAgtK8r33naSQD7okM0dN3FYXgs3UDsg2WGTs4=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=TIbOrXqpZoqse3vlcmhnMPKGWpV6QC04L59O18GemRANTMymhuYwQB7WbxME6Hzc5G
         yVWhb+c9GjOW1F4tunn59DmZ9WK8YCJ0g5OptlC8/mKdoLclY6MTXk2af0MLzhju0YKD
         /SaZcyw+l3EuToKTnXupPtody55Q7T2CWMGoIdw1RQy/Bab59BXOViBV/r48BRbd7hHs
         o7Z5EWQi7Z6zT++5hdX3RsXD3SyB61yE6GLjtFWoSerxz6h+iVe1/DDRr/XL46BMu5pG
         IwlhkZkmt4O4w1+DS8mxTb7w78GeMn0ZHaVCcQLMQxAFh31rDd2AUb0iHVy6ZPITt/4X
         rjjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780581861; x=1781186661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCVjkCAgtK8r33naSQD7okM0dN3FYXgs3UDsg2WGTs4=;
        b=omxHKThb67UqvfwsRnJzDqkijrjRrnGEzCe91IHGtjKyQ22XUJ6lSKrZR4/aLIgnje
         T/n4pOgMpia410Ch4B3SYDnOd9pPkfou5SGTI3zcl66XORrq84IclbqFtUI6L9gU7fOX
         7Dbtb67jTh58land5CeQcjRnn6zwdSR4ZoEghoMiK+pYEkmgb5muY3NtsD8HNtx92z2H
         g+s4HqHFysGfC4wwWAYoP/m0+kAq8lBN30P2N576T1azpFHXLYbh3/lIjyuBPVbDkesv
         kEJ+Z8TGFo2Eztp8zDGUjR5gwnrUr7Q2gNG+2UlmsSAbcxSFjWh4iHm/mdFLLaVeStcH
         nblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780581861; x=1781186661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SCVjkCAgtK8r33naSQD7okM0dN3FYXgs3UDsg2WGTs4=;
        b=chiJ6n3aFofZnRS9dcL4JU6aswfFZyKPiY0lDHfOrJruYFsFCMx1yhB/QENntPzUIm
         sJtO0f49S+ZqVoZAfyWZgno52CW4V9SRjxAg+3VJ59V9PH0tj4rnALyFMPKS2H9Yu359
         8QjoEgcjqke5bo9t9funbxlawepwc6nT+tJMbKhpKHzWHAIpXGxfabhRfkNX6GDeusAe
         ddlKs9B/TWDMePK6dbcxSq1yKOCwZ6qA7jfxay6tkPtbXjLd9yPPCswuXNqO0aWvof2r
         uaeFNDRF7jsEDo0qrUenA1xICTmGxtLuVThPZMfBzQPQfBzDfxRwVqjYNPBxLQz/zbaa
         pRJQ==
X-Gm-Message-State: AOJu0YwsT9hZYj+JrmWAjlfJAuoJs2I6qaP0V+pZ3P/y4u1DDVOr1yfa
	B7h37bc8l2fHxGMjPat+jwoPfvr/nUhnfdq7i2E6cS7ZL3pS5xhTBFTNBrnEECt0d/8aX8qe/vY
	calbZYPpuXvBbFbopviCJI0Ov+45/ZLY=
X-Gm-Gg: Acq92OG0+4TsHyzg9ub901Cty3DQP3PwPkaQj/kAhWXsAMphklF3AcSpRb8qY2CDytZ
	t4sCR6rvqr6aXhXPnBWITBNKbzxyWbbk+yVsDVdkEa4b7JtaDnXL9IqaD6H8Dz5VXdgs8Xz0Kub
	xPfsa3K9xyQZSbBwfHftm0xVm2aBaXFDDNJuYjYPR7GUnzpFY4YoJG/co4WijG3NikFlSDjpvKo
	/jT5v8YSPk0QQXQrPHG/FBiG18hYwHISGwE3kgEzvx07XuCH/eNWh+Yk+/u070dUjfH+YSqqNra
	09DaW72TJuM3iWvfsg==
X-Received: by 2002:a05:6a00:1ca2:b0:842:5ea5:5ff8 with SMTP id
 d2e1a72fcca58-84284f3791dmr6926329b3a.42.1780581860934; Thu, 04 Jun 2026
 07:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604134948.6312-1-jwcart2@gmail.com>
In-Reply-To: <20260604134948.6312-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 4 Jun 2026 10:04:09 -0400
X-Gm-Features: AVHnY4LopoG07XOgD9VL5b1upp_aWZovlFgwYkZHq_hlJO40wSliDGu2dAg1hbA
Message-ID: <CAEjxPJ4teCpzENLJF-grEY2O0UeDjJ0TX34MrW+9RDMDB77kAA@mail.gmail.com>
Subject: Re: [PATCH] secilc/secilcheck: Exit with an error for an assertion violation
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:53=E2=80=AFAM James Carter <jwcart2@gmail.com> wro=
te:
>
> secilcheck was exiting with SEPOL_OK upon an assertion violation
> because the "goto exit" was missing.
>
> Added the "goto exit" and now secilcheck will exit with an error
> for an assertion violation.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secilcheck.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/secilc/secilcheck.c b/secilc/secilcheck.c
> index bf12a812..e8e030ee 100644
> --- a/secilc/secilcheck.c
> +++ b/secilc/secilcheck.c
> @@ -298,6 +298,7 @@ int main(int argc, char *argv[])
>         if (violation =3D=3D 1) {
>                 fprintf(stderr, "There was a neverallow violation\n");
>                 rc =3D SEPOL_ERR;
> +               goto exit;
>         }
>
>         rc =3D SEPOL_OK;
> --
> 2.54.0
>
>
