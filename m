Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83543E4A3
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904350; cv=pass; b=fbRDZhypz2mslwxbkcajJ1q608bbBL8G5/8jC0x3sozUIHZspcBlFrRFKdnlHKYYWGIgaaEDEuynXkJPgeZkxeMrjz/0fOC2O2JDwbZ5DliTWOsGw8Ea/2jSeD0jeySe39dwSjBmP+m1mpAaoOGloJkynjaVOkP5/GWG3YpI10g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904350; c=relaxed/simple;
	bh=ueiXz5cy0dOB33Zvuvyel8Jnctn63BC1mdUxiW0HgYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzNw9ut0MgZOpVCDVc9U2Y8T7o10cVF0YU2N9j+d3utA9ZXTCtH9p3lml2g0RNvHqKVMyuwh2KakEH/pA03frsN20oHrtcmV8UhOUG0dFhtxw0YJaSfDKAaBpIj2uGWEKE+8vSAePmiQ52YgUV/eaZIAAZfEX0a03eNokzuFvgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBOfvryN; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBOfvryN"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2a76536bso5818311cf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:45:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904339; cv=none;
        d=google.com; s=arc-20260327;
        b=bXjaXnLqBJZX9kXoUji+AKzKnZTjB38nMKCSc+ZfuBXI3C6veoGhDMl+aprGqfYhED
         hZjul4rqIXcroTSDXc9VC3dPVrwep4/y1GfcP9ySKmRQQfL17ebmI57QphqAelreFK6X
         jx8qDJY4qi9aeakim8fum36QRGp0UGTFwGJmscPsNcMeNIoBDKfNsep10ck3qNSrA9V+
         uJJ1ZwMLk6ZrPv6c29XOy8dof+eHav22i4/LtHmi618s1CcHFYBt4uj5s0//0NdA5rD2
         gs1tFkwKsr+Rywfy+Uomsz98udF40qS/bjlTeblRfYPjsBx6R0K1vWTFzSBXRw+xtVTp
         IVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vFDQAg0zMj86BlFVazEeBdgeMxvwVjSjRZrQdHsrm1Y=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=nHRyX6xN5cQsZEjgPSPXiTppVHq4qNRuqNLaovR5fi4RAkESseRwHWt6sbdRXoxSMF
         y/oEKbii6NrIitrm4mgY21fBmsL1ag1IjjgZMfRyaJcuvzt+olzaWvgMbT2xpZEzeHwv
         pgVo6XXkNe3Ax1MrjAsUfuIftqnH+l/U73c39jct32mRQWMAmNhMqups83QYBCodGirB
         QOsebRfKWz7ROqkHrTWSaj+/00zgI8ZYhANVByEBkrKwJvik6aU9F0piM7aHmuDmnwTR
         kZdWY9HXqa01qGShbjgvS4SGflYoKQQCkue9HtQHnTAEGCbDvPYzrsKcf49p5nGgXQI5
         Nmjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784904339; x=1785509139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vFDQAg0zMj86BlFVazEeBdgeMxvwVjSjRZrQdHsrm1Y=;
        b=bBOfvryNV1M3sQuM8cdIO/2d9IqJ0vl+jM+avGdUkZP5fYnAIS2QcsYNzXp6+ZCnuz
         lfgMF25biBvAkWkgSU2pn9scgbxmEoX4gX0XmJK6AnXFTkyTsDxMc1B44i4Mr6cjGfv8
         V4Q2LrBoBU9k1e6guE32QD81xfwfPi1ERtvqcimt2wJOIuNFdOQKZDyITIGtNMkQfgzu
         ZqkSScPXrmJ6kf4CETR0QFJhzvQPJyI9Sk5uk7MkdXMI6lOu57KpnCQMKdrzqcbpVKrT
         3bh1d6scB4CemKg4HmvL1jUKATtjn7Cl1cLXkbu+M5Uw7ciCH5CYGr/pqMSJ1Pwzus0z
         xj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904339; x=1785509139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFDQAg0zMj86BlFVazEeBdgeMxvwVjSjRZrQdHsrm1Y=;
        b=mfO8O/0q7KJ4ar7GNVeenD2FFCWHPGIEwfKKNUwnf381pAlT8aRhedhJBcLCH/QN9H
         F0CfAqWyZKhQHMMLqXzpSajbKNgfM+9f5rV2pmZJ0kAeL+kuwNJp+Lov+92DrbcLC0RH
         MnQ6Ub1IBSD6Mo93HZHh3MLtdxj8QXGduXiOAWtwZXDBGtcmh8mFbXM2iB2HQl5k06AI
         +7e2iz5xgr0QG/3W1+gh0n7pR1cpBEBfLx7Jvh5FXllpU4ex7KCVQeuW1E7HB16hebpb
         fXzwWV/OBtKHIMptOXcB1FrilLqV3V3MXh0R19U5lXOdMM3rCfDqSrOzEULt159FE+xL
         /62g==
X-Gm-Message-State: AOJu0Yzqv/MiXmmOutkOGsRvCZH1y3ac7IwXyGj2MxSUdLf2qoWUhyUh
	haEttNiFuauzN4er0MqFtBI5UNPguYDQvAu5cgkwQWVKksBvoh8TQv+FTlH68UkvjEaXEWqYlT3
	t7a+l+FdNri/G30SBoRjzOR3KoEtdI4I=
X-Gm-Gg: AR+sD13B8kP0yM23c5pxcuarpFHn3qpTfrtrb5LWo7tmyYfwGkgdRPceYznCGd2plo2
	RztWfQ+cJA6h+W2Lvibu7RZNdyCuSwsJbookAqoy1mRIKpqc7gzM6mhRsbEiG7iWAntkchBbWlJ
	l2BD2gHlcitr+2EjUWA6oiH/zexQ4ADKzEEuCv1xGn1J+mDQHcnE3NiDCnZoHzMQhpYyv7P1mJg
	3j9ZQyR+b1bq6tzpgBmu+eOzkfHSchRdM0NjJCjRBSC+Pyh6IsKQkHiDtfoCg==
X-Received: by 2002:ac8:5a11:0:b0:527:8651:7f7a with SMTP id
 d75a77b69052e-5283de0b007mr71491011cf.26.1784904338538; Fri, 24 Jul 2026
 07:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723191805.28568-1-jwcart2@gmail.com>
In-Reply-To: <20260723191805.28568-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:45:26 -0400
X-Gm-Features: AUfX_mzwKqO9Ehj_BahB_m_Rb8DTzBzpDZVu6E1Q6JpCLv7J4CRH4x14Sh_x8Qg
Message-ID: <CAEjxPJ4dCbMTX2p7x=wGdBGSZY3So+xjrEx5DX9KQeMxOoLvhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] libsepol: Validate more access vector permissions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:18=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The commit 8c64e5bb6fe7 ("libsepol: validate access vector
> permissions") added a check that at least one permission of an
> access vector is valid. Add a macro to simplify the check and
> add a check for av rules in conditional blocks.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Already acked the previous one, but:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: No changes
>
>  libsepol/src/policydb_validate.c | 36 +++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index cde0b8d6..166e20a5 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -11,9 +11,15 @@
>
>  #define bool_xor(a, b) (!(a) !=3D !(b))
>  #define bool_xnor(a, b) (!bool_xor(a, b))
> +
> +/*
> + * Check that at least one permission bit is valid.
> + * Older compilers might set invalid bits for the wildcard permission.
> + */
>  #define PERMISSION_MASK(nprim)                          \
>         ((nprim) =3D=3D PERM_SYMTAB_SIZE ? (~UINT32_C(0)) : \
>                                        ((UINT32_C(1) << (nprim)) - 1))
> +#define NO_VALID_PERMS(av, nprim) (!((av) & PERMISSION_MASK(nprim)))
>
>  typedef struct validate {
>         uint32_t nprim;
> @@ -265,10 +271,8 @@ static int validate_constraint_nodes(sepol_handle_t =
*handle, uint32_t nperms,
>         for (; cons; cons =3D cons->next) {
>                 if (is_validatetrans && cons->permissions !=3D 0)
>                         goto bad;
> -               if (!is_validatetrans && cons->permissions =3D=3D 0)
> -                       goto bad;
> -               if (!is_validatetrans && nperms !=3D PERM_SYMTAB_SIZE &&
> -                   cons->permissions >=3D (UINT32_C(1) << nperms))
> +               if (!is_validatetrans &&
> +                   NO_VALID_PERMS(cons->permissions, nperms))
>                         goto bad;
>
>                 if (!cons->expr)
> @@ -1091,11 +1095,7 @@ static int validate_access_vector(sepol_handle_t *=
handle, const policydb_t *p,
>  {
>         const class_datum_t *cladatum =3D p->class_val_to_struct[tclass -=
 1];
>
> -       /*
> -        * Check that at least one permission bit is valid.
> -        * Older compilers might set invalid bits for the wildcard permis=
sion.
> -        */
> -       if (!(av & PERMISSION_MASK(cladatum->permissions.nprim)))
> +       if (NO_VALID_PERMS(av, cladatum->permissions.nprim))
>                 goto bad;
>
>         return 0;
> @@ -1214,12 +1214,24 @@ static int validate_avrules(sepol_handle_t *handl=
e, const avrule_t *avrule,
>
>                 for (classperm =3D avrule->perms; classperm;
>                      classperm =3D classperm->next) {
> +                       class_datum_t *cladatum;
>                         if (validate_value(classperm->tclass,
>                                            &flavors[SYM_CLASSES]))
>                                 goto bad;
> -                       if ((avrule->specified & AVRULE_TYPE) &&
> -                           validate_simpletype(classperm->data, p, flavo=
rs))
> -                               goto bad;
> +                       cladatum =3D
> +                               p->class_val_to_struct[classperm->tclass =
- 1];
> +                       if (avrule->specified & AVRULE_AV) {
> +                               if (NO_VALID_PERMS(
> +                                           classperm->data,
> +                                           cladatum->permissions.nprim))=
 {
> +                                       goto bad;
> +                               }
> +                       } else if (avrule->specified & AVRULE_TYPE) {
> +                               if (validate_simpletype(classperm->data, =
p,
> +                                                       flavors)) {
> +                                       goto bad;
> +                               }
> +                       }
>                 }
>
>                 if (avrule->specified & AVRULE_XPERMS) {
> --
> 2.55.0
>
