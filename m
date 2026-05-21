Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCD21CC51
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779392112; cv=pass; b=dZi7B3A4Bj+S9XqmTIDxDPDxfWIbOWuwPHH/8r9Ikyi87zUQlEu0LTRCHeEMd/g1LsRMeBJRkCobnh0LG2QTGCOBUxROL8dQH+WcNRYCQSl3I8Q4ednrwn4U1V6+QpaWkaH82zqlj5s3J3PsYoXh7D0G8mp7i9Gyixz+fmeQi0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779392112; c=relaxed/simple;
	bh=gPId/mDy0dpvCWGn6uSpO1QDgI3TSzh0DREnKUQOytw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jhDmsllzN1Tw/gKWPgpPRDsPrpuxBpQS4WJ0t0E6AuplZbvdQNjb9k4xaHjZNhCQ+0QCA1qL4YFeg+il6MfWrzYtW4c3XZqKwnXjKhsHA/ZFk35RNCS65n07cKNJuBZ5zq5eFXP+LcVWycs9ujbwRbIG2m/OULOw6P/26WU5CYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8xttglz; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8xttglz"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39389398838so62178141fa.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 12:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779392109; cv=none;
        d=google.com; s=arc-20240605;
        b=F7b48msfasr/U9SDIX7Ivgy5nsN4KrxaWlY9OZtZPG56vysaMewQPMyc29GGTXiL5G
         Q4Zi1ZfUy+8UOPhQixyXza5+yV+y+qDormI9MpfjiJoshH4ykJ/4qWVwlvwLU3zZppCG
         2zA2gdSKAJlhZ95vsyQHw2tgC2loHDpCWdmKuvb4w/gfci845mG+5K0QfwkQHiVjYjhz
         Ho37A5VRZdnztjq4XTzgAMZYHA3vNPq//KQCbOYu0/39R7qRiR3YkuqQW4Yz36TJsc59
         BVb+/boNl5AXAM022y2bMPaHRb2lFqLWycR2ycT3ccikKXxE8BZFLrzgMVJEbvsBYxb3
         tVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TF0P60VDuxZa4Pwm6JPG3CBQAIdXbnq8vABl4m6q8vk=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=Xw8hEO6wuJmwyUwRbEEPyoFAi97vPigwDrn+GNdLrJvzzf8QyaKFjsUqnROz09mngh
         EwW6aUMsyjZ33abco6K7MnyhWGSSj9K0qjqcbHicWvO+SFjTb8MrexkRDuWrfFpcRGvt
         7oWQPGu0fy7Ri19MbqJeGySuOfse1IcMOVjQeeUqdrSKdfX9BnK8KaGZTu1zADI7yqym
         I8I/qk9BBdAfBN5T2Dioy7YI/S4HaW/CdXQWaVFX+NwJnY+30bhiE82K3XWb4H/rKqCG
         JceZ1TaE3ARTFAqD/7/e8ygL2KcQvWVpdFrgC+t390kCcUwsFf2asmVRpCC+2eWKyNMS
         2l8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779392109; x=1779996909; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF0P60VDuxZa4Pwm6JPG3CBQAIdXbnq8vABl4m6q8vk=;
        b=Z8xttglzIe8+ysbfUfPZTAgRZ1OwifmxRj/BRdqyroXHIlYPe/OZkEUYsfkN9eqnZg
         +a9ib851yxxbQNBUiWKofBmjjRfbkYIHp1HwvPGo+OzaAm3cO6EnAGqrgTQWZoLDgsvf
         +M9I3cKeXUzJT/cSm3gaiDywQiOftaTRBzNgKdoxz+Hz7lCLSpkzUVqk2iPNigW5Lbc7
         Kk3K8wJyNh6JorDSXn8yyyQ+yliT4fA365zxN4pZSK+ONqDDXHBl6k88f09MpTZnSW7e
         STAHHEqQIT4tcXQFKyyAcxLzYuCQIZ6h5K2qtRg7VznMzX0KmVsKUi3kkN60Vi4wBx87
         IGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779392109; x=1779996909;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TF0P60VDuxZa4Pwm6JPG3CBQAIdXbnq8vABl4m6q8vk=;
        b=bsgO19v32ulBicIZnbMWSpUUcXswOYvZYss4DGemSMPc6g4cRKyXsbY7l5V2OdfqAw
         i8JEzHaVSpnT8eqCFSMwRUxoczBn6URvsyj7U4XgmwJH2UNZYGNbC+Z9PymFFLd4ZLp/
         jDuo6zt0bFpcle8+6BHLGhxJGO8JZUCPX+VHoOFZkBm5CpqOwAvjsa2jCqYkeiYnsv+r
         RFv4+zywCBJJe5L3guuMmJDQvnkWJZhg5NlNlHNGECROY85nx9b4+0l8pw1OdLthvd9Z
         H0iv13sh3nOXFL4LdyaATsEsv3ggbpU8AbRw4InqebXk2Midm8LbCAAIX+q7effgC4G7
         AbvA==
X-Gm-Message-State: AOJu0Ywn7vCg2Yi6MvC1N48fFixin6gCLsFzCKkb2T9cwEV8Kyhiqq9H
	TqCnJRiAxpW5jAGZbmpALYHdJfdA3XV5XGhm6pPqMXx9wSAmZXbBkIt1pI1FOSgx13I/F4ONDKk
	0rbtO6C6cmlfoUv7K3nlKyqkJ0gUx/VcpXg==
X-Gm-Gg: Acq92OHzZmUN4MuIJ2S2nGtvL0vc9qkRUFBTrGm4sbZ1eM0u+HQxwFOCTUkYjIQnqsG
	Y6wX5INph+s26jTM+f+qQ7CbqldSE73LgLxn1uSPz6W/pS38cPfroWEDK1GZfifwp7J7t+VHBUT
	hyygCqrxWj6sdI71qsGpjxsZwnfZ/i7FWyWKm8x9Mn1or3zAJARHrLqfQisaaIuPV1o7qXWD/JR
	Kzs1uHCVvzg4DwdMWDZmSd9ZCp5LnE7Y+iaWi2Y654a86Th6RJJMtRfIr7pattQ0D/g1giLnKJR
	knKvJoIuglx1QaE=
X-Received: by 2002:a2e:bd83:0:b0:393:8ad4:4bc0 with SMTP id
 38308e7fff4ca-395d8d00d8cmr803601fa.21.1779392108985; Thu, 21 May 2026
 12:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521190627.34885-1-jwcart2@gmail.com> <20260521190627.34885-3-jwcart2@gmail.com>
In-Reply-To: <20260521190627.34885-3-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 15:34:57 -0400
X-Gm-Features: AVHnY4Ib0--79cRYbhN8IVC_s7A7LXFw-WMsAWoBZlvyt1X8df0dytECq7d-Vu0
Message-ID: <CAP+JOzR1NJqbDBN+vrsDs_rFVeBn4kwzP7WJKT9AkPNoLzAA6A@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: In module_to_cil use constrain and
 validatetrans where possible
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 3:06=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> When converting a module to CIL for an MLS policy module_to_cil was
> always using mlsconstrain and mlsvalidatetrans.
>
> Instead only use mlsconstrain and mlsvalidatetrans when the constraint
> expression contains l1, l2, h1, or h2.
>
> This follows the example of kernel_to_cil.
>
> It also avoids an error that would occur if a user is referred to
> in a constrain that then becomes an mlsconstrain. "u1 =3D=3D user_u" is
> allowed for a constrain, but the error "unknown user user_u" will
> occur for an mlsconstrain.

Actually, only checkpolicy has this problem, so you would have to
convert a base module to CIL and then used secil2conf to convert that
to a policy.conf and compile it with checkpolicy to get the error.

But still want to follow the example of kernel_to_cil and
kernel_to_conf for consistency.

Jim

>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/src/module_to_cil.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index f736288c..79d34576 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -1742,7 +1742,7 @@ exit:
>  }
>
>
> -static int constraint_expr_to_string(struct policydb *pdb, struct constr=
aint_expr *exprs, char **expr_string)
> +static int constraint_expr_to_string(struct policydb *pdb, struct constr=
aint_expr *exprs, char **expr_string, int *use_mls)
>  {
>         int rc =3D -1;
>         struct constraint_expr *expr;
> @@ -1762,6 +1762,8 @@ static int constraint_expr_to_string(struct policyd=
b *pdb, struct constraint_exp
>         unsigned int num_names =3D 0;
>         struct type_set *ts;
>
> +       *use_mls =3D 0;
> +
>         rc =3D stack_init(&stack);
>         if (rc !=3D 0) {
>                 goto exit;
> @@ -1803,6 +1805,10 @@ static int constraint_expr_to_string(struct policy=
db *pdb, struct constraint_exp
>                                 goto exit;
>                         }
>
> +                       if (expr->attr >=3D CEXPR_L1L2) {
> +                               *use_mls =3D 1;
> +                       }
> +
>                         if (expr->expr_type =3D=3D CEXPR_ATTR) {
>                                 // length of values/attrs + 2 separating =
spaces + 2 parens + null terminator
>                                 len =3D strlen(op) + strlen(attr1) + strl=
en(attr2) + 2 + 2 + 1;
> @@ -1979,18 +1985,26 @@ static int constraints_to_cil(int indent, struct =
policydb *pdb, char *classkey,
>         int rc =3D -1;
>         struct constraint_node *node;
>         char *expr =3D NULL;
> -       const char *mls;
> +       int use_mls;
> +       const char *mls =3D "";
>         char *perms;
>
> -       mls =3D pdb->mls ? "mls" : "";
> -
>         for (node =3D constraints; node !=3D NULL; node =3D node->next) {
>
> -               rc =3D constraint_expr_to_string(pdb, node->expr, &expr);
> +               rc =3D constraint_expr_to_string(pdb, node->expr, &expr, =
&use_mls);
>                 if (rc !=3D 0) {
>                         goto exit;
>                 }
>
> +               if (use_mls) {
> +                       if (!pdb->mls) {
> +                               ERR(NULL, "MLS constraint expression in n=
on-mls policy");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
> +                       mls =3D "mls";
> +               }
> +
>                 if (is_constraint) {
>                         perms =3D sepol_av_to_string(pdb, class->s.value,=
 node->permissions);
>                         if (perms =3D=3D NULL) {
> --
> 2.54.0
>
