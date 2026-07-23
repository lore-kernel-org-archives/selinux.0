Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD7322A2E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832063; cv=pass; b=Rk6c8leM/JGHNXorOJKAwWnbge34QGWxcSaeujkeYQsQ9QcvjCXuODKHCNZ8qOB13Um3rOwdWFu59J3dduCoSBOtlDuG9fXRiU+nc589N77iUBkyINFP35uR3W9Ok0KiSd+EkASnHPol/VvGyMLKIqJRovsk002zAR8CiY2dOyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832063; c=relaxed/simple;
	bh=Pz+h7jgVHaoJ/AE65ji76QK9AaURVO8wKiVGcqoLPeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJRZA2nGQAe5IkXKh/rGeieTdheirXH9Yg/N2gdzefcbxZGrVK+sq3TX3IPg0nDtPFcP5XxsrWDOk/8HepP9dhO84/APfbG9vjlRIPzkkoepJf/qoSJhbGXweFyO5N2a9hKV+grHZ9Xm9yNx+i0aNytCdF6L1rc1YYxOTzOhnFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFNWiEaZ; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFNWiEaZ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so12493835ad.0
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 11:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784832062; cv=none;
        d=google.com; s=arc-20260327;
        b=pS9YBi7xQYOtwY4dBa/pLNA0cKYFrCEqchu2IjJ8PKxCLj8P6HmtR2Yccb6Wj94V7C
         Ie1VtLM2eZAPjWTACZzbXA7/Pdn9cCpdO0N4OAVbu9M0iZaLQoYQfzdj/jm7vuy3ySZb
         bCuJal1PraFJYraNO7qrQ7p3PXfi11NuTvGotlAtSU6NOy/pDd+E0Kk46KVVVSsjT97X
         ttn66aoMDYQr28T1DPlfJXF6+gUpuHqVCZM3fbeXzugaPpczoxZsRYEd3J3I0cJVemB8
         RnIsk9PbX/Nc3tBlr+5YcI/nEKdE93m0bkTseTa0JTiVjRlAl6aUq5dwoRcy3vHviVX6
         OsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qsAU320Oy04ue+9pC7dNzkRyYsWlEJIbixtzaspCZ4c=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Z6t8d5xBPGfK3xsLDHEHxlR+IVsRRgpjkVCwACpjO4wBwI7tdGU8eqcsGjDM+iOCvS
         lIgMR+LmVBGiaNpAGLN6eOu9jDyVZ4ltlV307CQ0x/fE4KHsFapN3ECOifGH4KyTjk05
         OY1sv20E5dMFCK5vo2AjhUGmW46bML2j27piv26ah+GO38eyTelQRsppaCXF3dJP1SuZ
         0ty+p1ErJbCbBciGj8nvSnfBkxM6ooPtlqydqlcK1bQUPWS0LN1/o2o700WbmrdnYQjc
         FW23CUpt40xyVP7gkneVVOHXT8vBU3686BudaqycDjoPa1kSi++GNEG1zKkYRsK/9SI1
         YThw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832062; x=1785436862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qsAU320Oy04ue+9pC7dNzkRyYsWlEJIbixtzaspCZ4c=;
        b=qFNWiEaZqCe1DQ8JwXEy8Ygf6+/fhDgIhZoWRuXCmC24hbgJ1JIu/FcIJx+MuVSlIi
         wL9O+IWOVkeBY59xhMANxyKcKRBfSwBxJgDqR6T0TYi71dByTeNfPrwhHRW8aQS2WNmM
         rp6sdKeXO19AjZNlIs0dInPVylfoEjcn1ZJ7GOZbpdusseeAo8YTgPMO03ZpFK/vtXIJ
         8DWi7N4uiL9bHBuFuhuHy44K2xN2LTkTrY8XPSYg2MfV3WoQ8beRZWTTKqhJV4QOr7C5
         nx2FGLf4rPgZWbV26Q321dIuy3azRGwhYSp6k5aIs9PAvhTAjNwYRjlCk0vHAsdOZcjg
         uF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832062; x=1785436862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsAU320Oy04ue+9pC7dNzkRyYsWlEJIbixtzaspCZ4c=;
        b=ZAgaeVrpD7yao8nfNItuVFz08rNGdV8Fbuu7kVtTaXsITlqicpvn3lvsumhdTsPrQa
         7UQOqkI3Xq2PohGYCrx2GPg6nwnIeSbQ3mFCyWLHERcxaLv9w50XKFS0ar2cxVa0Y6j9
         RGj2BqX8BBGA1EV1fXqL4gBy0QzTcytp4ok9simFq4JRPmvlM47N6xrtseMvyHXdxyRn
         UTSy++GHS16UT2rNZDnpyo7LYajsc103a/r5FgvxAjdQFRW/nxZ35gJ3q6uFLwp6apXF
         6u5VT92KsUjUOOfESA9N1dL/uU5eTkDg6xZLZGZ7PrqVlMZ9TOIjhE7ZouUID+4toMqj
         791A==
X-Gm-Message-State: AOJu0Yw2gPmJ2hKVlaOxtKXR4gxcu46oT0/rly+YwJI/MkFlePxfuNVz
	fHHdhUKo9u3VT5WCpe6WMSnNU17lMPmhUwgK9loNX+ZTR4gjHNzA2MTeD5ttBMpgmNSk3UiIY8n
	D+FhNKF+Gz+BbD8pX2vUlRCztmxoPG7IL12eg
X-Gm-Gg: AR+sD12ft722JkyGET29EsgNfU5xilb5eB9aUUEXpOxxIY57nXg2/sjIovl/l0N6cLg
	GTEw9vybFuZy+6qqG94QlkyPvP9QUyelNyn2I+8BXbidn5bfC3vyPyViKj9UE3oEmprS6ys9Okz
	bbeESHNvwUgTDcXTEh8+P4RVF8LrZdgC6BrkQDm8qOCu/8gOneyQ0RcSP8LYd91xSHuVGkHl1Gv
	W9pksXabK07fVSi9tnENDP6morsYn1PcAtCOTqS160uJ1oYfWB9XrMbLdbKng==
X-Received: by 2002:a17:902:dac7:b0:2c7:ebfb:618f with SMTP id
 d9443c01a7336-2cfa6b73a76mr50110305ad.14.1784832061895; Thu, 23 Jul 2026
 11:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722174551.100020-1-jwcart2@gmail.com>
In-Reply-To: <20260722174551.100020-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 14:40:49 -0400
X-Gm-Features: AUfX_mwOi5skaPo5NUFLNsrgecuJd__Oqxj6oPDjV4wVQ6PRASMl7c1pcl8QKfo
Message-ID: <CAEjxPJ4gbw1VUCtAL6EUt_1kbyuL9MsorV-KUYd-feX6ymb5-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Validate more access vector permissions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:46=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The commit 8c64e5bb6fe7 ("libsepol: validate access vector
> permissions") added a check that at least one permission of an
> access vector is valid. Add a macro to simplify the check and
> add a check for av rules in conditional blocks.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
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
