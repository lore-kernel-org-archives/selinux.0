Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2830C172
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231810; cv=pass; b=B2sZGNY8gPswZctckI4YKBhQmlIXfEZarC6F1y+TyJrN3BO9ynKFsu9hZAuRCPDfktSTQV8jMWhNc2vhxcFUF9JahcLD7pHUOrju38LK27AQ+2+WgUmZ5MFezFel/D9HTczCuxIN97LyFiORYkPXmKX0w/GQTJo345q9hhEPCSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231810; c=relaxed/simple;
	bh=HEtvd0cXijamZbaCKnKJXIYJJNzIa5zwedURXgDEr0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foOQtLpbff5PseOzSVyoC4jaT7LHDvKhVIvtZQsvXje+h0jYNZqZKP+Qtg7ACJVaFvXnT9p2dst+YVBoYm379XdIwUtQLdQsuIS2f0tQyjH2zgO7+eb+dP2ozoQLln3Ldc0m4Vz++s5bSeAJCblOKzjj3ysjBKwGDa/1ys5jvBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hffvnnFX; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hffvnnFX"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84236f9b638so67973b3a.2
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 09:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782231808; cv=none;
        d=google.com; s=arc-20240605;
        b=c+WJp2tnpi8S5tSWNXL9gYzwiz/yibjJrNtJ9hE6LlTy5SFF8AKylbRslyjfCjHmbs
         zi4frS/0CYARUprM7HzmVsoi9M+ZwafbDrPUWxBQK4ZRNiToJ8k7+1cfWXLxlvWCF1/J
         BKIZx0WsTM8ihGbCvFX+mYoRYwf4Vz4m0axSKHf8gcKJ/MubX5ciE4vndN4aMN8p7DAP
         myzxhzoqCZb+nGhEys1wKwWRpn4xBniFGn/DcxVN8gTmhOLEI3yxN+1hJkwG57hQgK2M
         1yYcUL60nYrnjnP84vYm8ozRICITrc9r+W+YHOnucGvSeRFmi8Laj6tmm+juHbR/5BIt
         mIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofJlQyelbUhwWHOuDidTh2AYCTy7iG3FE66YPJKuOMg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=DhP1hkYKLCHYesj4qwr7KZn1aFrZi1Mx08tDPxl1Ub+T/p0axYMbZlBBCCa5pzFg/N
         6iJ/DAwDhj/o4U2t3oR/YF79bzCuDQ9nTsSrh8tgXGKrcF1XlwgCwwblrkFC/lciYhGT
         JWNQtYljDGOkptiw6aEb/4Kl9ZXadlwOsqJtekZ6P4P2Ym17iRpvDyopv/Q1Ktp6sRtD
         ct5H2AAnStEvOv73qukBnLVHgt6qkD/cnhpThxn9vTViWMnvPT419ySSQY54LNKNCw8P
         Kktnrp+a9iHqAOxX4vhGlb1cu41fN8NfWlbxMriyzGTLt24jYdvguXaFgN867HdzpEUF
         DcWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782231808; x=1782836608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofJlQyelbUhwWHOuDidTh2AYCTy7iG3FE66YPJKuOMg=;
        b=hffvnnFXHMFiSGuttKWD/QBupJQC8W8hTMkK3PJQjtI4lfVFuzXLMEoLqm6vGvB44n
         iZSE9jdKR/lX1hJbyR4mUDcfj4t2O+GsdWPwa3BJ1fiOS0VkBaDwYKRTvsrU9B7otq5q
         DTGxMzX5eDXHfoxBPvvbHP1QACDpKyx4U6Turn5/ndzHYu87dBG8fkj+qKsi9+5johYX
         10/KU9E8AK5FGrqIkUjK9Ii9zwXiUh0ea0bAg1eGioMd6t/M4KAHi2R6zhl4sL09KNao
         irt+c0SWGVQDPQ+n7d0O9zHuJjc0FiF5SzOewPtIsi/tZJ/SITe+BHq0x1S/7kYGdlyu
         Fb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231808; x=1782836608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofJlQyelbUhwWHOuDidTh2AYCTy7iG3FE66YPJKuOMg=;
        b=lyyyLmQLGDPsaR1ZZFKDvc4MJ4PL+v81GiHrYSvc0MFLO057qP45vGxgXhZ0kRsVf8
         3ryTAZee+jlCBMEsWTfEwASZFWk56BDQ9JXZuGVrPOFBsUfYag62FUZCctWXDIcot+as
         ovyCkc0Mw9ZTJoHc8KNu9fd4S6bTNd19lKXKYr3nzzc/uJvqED1OSIXIDdsuDFhbJHVr
         XxuhbzHXvmScWmvLEfrYP4N3YGwUnqinch17CWm89qiyG9Qb+gNceT6EH11pYb147me0
         3sxEuMFjZYaE3obLAv0E13k2E2Hrv6B0DoDTIy6ssN5rP/Fdq0h/KmscpOg9pUz5zS0a
         xkCA==
X-Gm-Message-State: AOJu0YyBOU4HR3bvH5Auu5ULTq1EuKUtiGT8Tj0P3RkBoSS68dffxTAZ
	UjBd+XuBsSbtumBGdfjuzUe2hEgDz6ewDF4KxlMlNT3nY64nBVFEdSxWiJUV4kFWl1mzQ9EpLco
	YODoo+YWR36qJ5FqNz+SdY5Ki74g2eH4=
X-Gm-Gg: AfdE7clAhGBRoInPwjHmJqu1i6fDU8Tx9DhefGDzG8+m/iZEKcs33TdEpwE4ZRPjcjl
	SKTuMu0cRU7/vYQ6qUjNqVbKCagWbQFtRMS6X6vY9qvoei8D3cPXxFtnpHZ44nW3x1SMZsVlSAi
	0ve5shyZDwhytkVQ/zhx0bQyVZhxqW/bmu6Ti0niKkwUMIT/AsPgo8DX3pTCHQfscNMjLFtuBOo
	nO0JLNXfPI3ZCBPg87dMwTWURAuQnaEltNh3Abg5TVwTjm1hK9lQ9Yn8F578ACjr/FStBFO
X-Received: by 2002:a05:6a00:b92:b0:837:e9cc:d46e with SMTP id
 d2e1a72fcca58-8459710c776mr4140944b3a.21.1782231808278; Tue, 23 Jun 2026
 09:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623154937.16913-1-jwcart2@gmail.com> <20260623154937.16913-3-jwcart2@gmail.com>
In-Reply-To: <20260623154937.16913-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 23 Jun 2026 12:23:16 -0400
X-Gm-Features: AVVi8CfRZL2guZ6x94knNwbAzqqOYs1mOLgzc40gOQmgV7sO9CL2a6tRP-8QbJw
Message-ID: <CAEjxPJ601xf2ZNp9ejuFdC44Y-4047pOR9K_AiVn9gjyLy4VNg@mail.gmail.com>
Subject: Re: [PATCH 3/6 v4] libsepol/cil: Add overflow checks for circular
 reference checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> When resolving aliases a check is made for circular references.
> Similar checks for circular references are made for user, role,
> and type bounds and for class permissions (class mappings and
> class permission sets make circular references possible).
>
> These checks use the common idiom of using "limit *=3D 2", but
> there is no check for overflow.
>
> Use the __builtin_mul_overflow() family of functions that will
> do the multiplication while checking for overflow.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v4: Add '\n" for cil_log() messages
>
>  libsepol/cil/src/cil_resolve_ast.c |  5 ++++-
>  libsepol/cil/src/cil_verify.c      | 20 ++++++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index bdbb871a..a805ca17 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -652,8 +652,11 @@ static int cil_resolve_alias_to_actual(struct cil_tr=
ee_node *current,
>                 }
>
>                 if (steps =3D=3D limit) {
> +                       if (__builtin_smul_overflow(limit, 2, &limit)) {
> +                               cil_tree_log(current, CIL_ERR, "Overflow"=
);
> +                               return SEPOL_ERR;
> +                       }
>                         steps =3D 0;
> -                       limit *=3D 2;
>                         a2 =3D a1;
>                 }
>         }
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index eb732e44..699cdccf 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -975,8 +975,11 @@ static int __cil_verify_user_pre_eval(struct cil_tre=
e_node *node)
>                         }
>
>                         if (steps =3D=3D limit) {
> +                               if (__builtin_smul_overflow(limit, 2, &li=
mit)) {
> +                                       cil_log(CIL_ERR, "Overflow\n");
> +                                       goto exit;
> +                               }
>                                 steps =3D 0;
> -                               limit *=3D 2;
>                                 u1 =3D u2;
>                         }
>
> @@ -1028,8 +1031,11 @@ static int __cil_verify_role(struct cil_tree_node =
*node)
>                 }
>
>                 if (steps =3D=3D limit) {
> +                       if (__builtin_smul_overflow(limit, 2, &limit)) {
> +                               cil_log(CIL_ERR, "Overflow\n");
> +                               goto exit;
> +                       }
>                         steps =3D 0;
> -                       limit *=3D 2;
>                         r1 =3D r2;
>                 }
>
> @@ -1060,8 +1066,11 @@ static int __cil_verify_type(struct cil_tree_node =
*node)
>                 }
>
>                 if (steps =3D=3D limit) {
> +                       if (__builtin_smul_overflow(limit, 2, &limit)) {
> +                               cil_log(CIL_ERR, "Overflow\n");
> +                               goto exit;
> +                       }
>                         steps =3D 0;
> -                       limit *=3D 2;
>                         t1 =3D t2;
>                 }
>
> @@ -2112,8 +2121,11 @@ static int __cil_verify_classperms(struct cil_list=
 *classperms,
>         } else {
>                 steps++;
>                 if (steps > limit) {
> +                       if (__builtin_umul_overflow(limit, 2, &limit)) {
> +                               cil_log(CIL_ERR, "Overflow\n");
> +                               goto exit;
> +                       }
>                         steps =3D 1;
> -                       limit *=3D 2;
>                         orig =3D cur;
>                 }
>         }
> --
> 2.54.0
>
