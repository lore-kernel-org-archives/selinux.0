Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91541C2324
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155217; cv=pass; b=EvgiMFuRwenpmR5FBWYQzYPjBazUjSmxvyp3Y1A68YE3lMTKXiiiRopKOiG85goKYjoy28NTlHuIqbcNyD5+mZdz5DM/3KuZ0P1oUnmpwR3vB2wl58+a5/mO5J5MreXIRq7hrOt1lJwq4vCBdUPWzv5M9IhXgPs1FFL0mpAUMLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155217; c=relaxed/simple;
	bh=kqMEDzztcPk33rYamp6iSXcBGPs73X/pJcCJa+0iC6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s53k9Z/MdSCIru23RojttMAOjGGavrXiZZPkYzcT3b1TxwZf610HNaB885EhC88ng4tCwUyD/I8uVlGVlRhBbgqE262zoF4WIsfS/dj/8EgIxx3jUIy/N9Q4weyYwH+UQ0SlLlPpnWiY/SfYfOPNgXUEnSUIb4t0gSQB1tNQCjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehuI1N6w; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehuI1N6w"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2247e38eso55207235ad.3
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 12:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782155215; cv=none;
        d=google.com; s=arc-20240605;
        b=ce2eUa1n48d3zAEV2UXjAPCCKP91fc9oJYk8/sOloZW7B7x3rOqe1BqwyQVPkJqaCG
         8JlxWwLbQf4d0274dTr9IjfjsIhPaeHxRRs+B5wWWIGiaqNjBl95BrnvHmNl3em/9Ag5
         p+Fi8AmOkJ1yIDgBdWT5Taw36xbib60AUXXPkBWIvCvlfd/2DxsQSgw48f1H1c/e0YZM
         w2/lV7FLwFc9N/MuItuq54d5e0W37ma5N5uorDeGaK2W3zStyTY7E8Q9PsLw1D7UhdhZ
         WXbInKn7Mgeu+J2buz8r8v54by54B9prgf09BHQxYZY7lcRsJN9/mPukG0LeezqzTmx2
         iGDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hTyzVDZURsfcxgUtWCa8w2QLyio0h57bnJVVofLuX1M=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=JlwkQBg7bi303BwO1hH9ca1M1HH0w3lwf1mPXJHYl5t9/nIsrlSlShEiB/2dHCq8Rz
         UoaCJdehIAeio8RVVPBWaIl/Uny4c+XXQ2xjawIa07KErpnWz+IiAEBSI+FUcnj1Bm36
         UqLQpyBlI6XZCmdG5BIHe7tVx0X9p5HgTzFbRLPPuEpIJO31B9KQDbASpfvMn8C0JQr3
         wBETNZuROdFV4gxVsWkKoK1IqFwmhxrk6+RnreKAuEfwX4nCDLh41tNSlqWZleYAT3lB
         kQvDBGpzn2PS7dUUIQy4eoyI+SN5oYnYz8SbbOZ4+/bISMmnj4mkXZWQ4e+VLTAxG9jG
         QM3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155215; x=1782760015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTyzVDZURsfcxgUtWCa8w2QLyio0h57bnJVVofLuX1M=;
        b=ehuI1N6wtn5R4VcV05nSQrwDQXixTKmgRolgucgOV8Yys0mCVu7BCZAJKKaehqDwRL
         4AbEGsmVjMx/u9G/h3rwZk3mG+m2OeBhEKW4RWAeXD0+DTTLQWAg/l79Ss1fmjVPpcwq
         62F0IWbARobthMFrXxFbr5g9S8nV4YM59ASlXJD2BYTDea2hItrM0UdsfYr9dIK4+vtx
         nhqFS8Mx+7c69N/vGzru2N3V6ND6ZJvWarhKFv0/yOiYSQfgtAz9qWF2LFsps2UZQulc
         G2F965jAcd7t200xZeenUlhPmZG9QWUZ7FKETn+VNhZW2sjxrYRLyDbHkB1r74BAfVF4
         SO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155215; x=1782760015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hTyzVDZURsfcxgUtWCa8w2QLyio0h57bnJVVofLuX1M=;
        b=QkJZEcfXwoLPEB55wdNfG7o7WC5Rdc4jLhwOylRFCkAyHQKzilPBzZzLPUAFJSx4QE
         STfnJSO1Bxdcergb6rZ+aKPJQhHDwZhC2Xyzx8J5MB4Mxs+Jt5zRKBy5SePc8BHbQO2R
         gZHjPODQX+lrifxzSOPLORhn8ZIIr2kdciRPE0++Tj0Y72WgBFQ8g2nTng2v7M+B/0hf
         tfakl74jX5PLlUATFT3w1JPaQIReKU/84nXEoOGUqmu2NzYF+b6rMS/aE/iko4RkuAYu
         HKjtOVjyNSfPK9faFp1WzdaSzd1Rjm9ph4tdcFhgAdn2UBvlRSy2pbRRWun1Y//+5uhu
         1nKQ==
X-Gm-Message-State: AOJu0YxjSxr2hEqvRhUsMkboaBVIXqapdJUTAjsoaIDH4ZXTrzoZzAbP
	YI8ee7yds6ngaAAlz1dTNiy4adWl6ofi99uCfB5Ttrgabje46Vv7eYDRZ3IhHhI80mME9leq/V4
	6TGKwU1+U6cxV34U2WND5584wd3wVXYBWZg==
X-Gm-Gg: AfdE7clNjhY9e7ctcpjsapOCexx06AE9aLRH2AhyfzTfiMaXPWrtPLTPfDLGYN5KXAK
	2dncJIJjHyQt1+pc05xSUAJUmFDFgQ9R/gYDKB53s0FAvPOwWnlSSvG24cjvP4cZSlFh+PB5nYM
	f6UKa4GWQMfZMR2g7ylA4iaGt2yNlWVpPixccSNcAeZVLJ+cVpIJ5QcI+1RO2YayghVih722nBo
	EXCDFjaG4/elsBtMZYed3h7mqws7vRRbLumItNHXvf4ZQ4XnR4ty4wBSGyFo9WeINUgqV4d
X-Received: by 2002:a17:902:ce09:b0:2c2:d910:db05 with SMTP id
 d9443c01a7336-2c718f917ccmr186506545ad.29.1782155215026; Mon, 22 Jun 2026
 12:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173541.174998-1-jwcart2@gmail.com> <20260622173541.174998-3-jwcart2@gmail.com>
In-Reply-To: <20260622173541.174998-3-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 15:06:43 -0400
X-Gm-Features: AVVi8CcQNdulyrTr_3ZVv3pYuPEFMy-yJBjnrMclpcHW8v36oLd_9M2S2ByaaYU
Message-ID: <CAEjxPJ7z08VwnAudM7Ljr+9duzV5CcDzJJnsE7BrrnUpMokqDw@mail.gmail.com>
Subject: Re: [PATCH 3/6 v3] libsepol/cil: Add overflow checks for circular
 reference checks
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
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
> ---
> v3: Use the __builtin_mul_overflow() family of functions
>     Split out cil_stack fixes to a new patch
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
> index eb732e44..240f3b23 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -975,8 +975,11 @@ static int __cil_verify_user_pre_eval(struct cil_tre=
e_node *node)
>                         }
>
>                         if (steps =3D=3D limit) {
> +                               if (__builtin_smul_overflow(limit, 2, &li=
mit)) {
> +                                       cil_log(CIL_ERR, "Overflow");

cil_log() appears to require the caller to provide the terminating \n,
unlike cil_tree_log().
This is repeated below.

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
> +                               cil_log(CIL_ERR, "Overflow");
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
> +                               cil_log(CIL_ERR, "Overflow");
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
> +                               cil_log(CIL_ERR, "Overflow");
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
