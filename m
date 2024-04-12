Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19592249E8
	for <selinux@vger.kernel.org>; Fri, 12 Apr 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712954955; cv=none; b=eyEkNNskyEtjFn6WlWg8tAWypRpOBQ3hQlR32AkUYNeBiV9YVYadsVpUUV/A7tDz1iSTYDRHdwskpTQclnBi3XWeZE7KJOAgHDKjI1CQGSMpaNK62TNzQEmdFaigZ0cbh/n31tEvEm9C1zflYPPZhIVlvMZi6GyL2lxkj1naXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712954955; c=relaxed/simple;
	bh=qizxo+oHLcJuPpAW8YrY9USCn6TPdjkQl6p7UVouVoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY/4mihXHN8NrlqsVxpfEp2nL+ScewdIbcwMmAZUdtMELvRTjhXpOnpa7Vd/1/inw2vvUZgZYs7DqI99g0KFgSsxCQJ33cN5ghB2ISdHe6vc4+XaA+qeaV4IpLEzJ5iUGsjBMNiXZgIXEgcgnJDZGCt4NyszrROyatdLd4tT2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZjdFLfT; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZjdFLfT"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479ef9db155so556193137.1
        for <selinux@vger.kernel.org>; Fri, 12 Apr 2024 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712954953; x=1713559753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVOB6MLbCzsFGJywm8oHa1EWCeNYqcvevJgewQ54gdw=;
        b=mZjdFLfT2sZ6HCVo4QdgelZfDzt/45TX1GKhEMKAwzVai0AsQWKVBThyE2t7mqrZgJ
         Psl51dUdJoyd4pGLmbh3IaUOuIHuk1WooC0mSksxAHjIA5V3lc2plGHZD0E1M7pXA8oV
         8ySA4Wh66YXM7sUJsY0U4tu+8sRvq0lH/h2+4uxL8D5b6Jed7V2hwLUD5JOnlgIj3bd5
         5uJARjirQXdauLErgE46Yt9VRCoyGJ2VeYvOixS9gJsUrDrGUgcIFKL6ppFfQmkNIN2R
         keNaOOrdaC4G4B71p35XK+vWIa6blKEFsplb1s5ZjzJflshV5rFqeznj94z5ENLwf7CK
         3dHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712954953; x=1713559753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVOB6MLbCzsFGJywm8oHa1EWCeNYqcvevJgewQ54gdw=;
        b=kP4QAnYiKyvswJuAQB7V+IpO6aYlQfn1mWGXu1LN6VzHc8DxJlhl7fHp52pP8kABc7
         jGh7Mde96rcabI5XpBfn+9kJ1gZEDFaFPqwpAalBDX2a4ScOalbmF84htd5knyCWgFox
         kqWDwSDZnlKAVvHn0p0N81UNYAReinadedOul5jEAuAVrzol8vxB9DgoG4TH2WCWml6L
         N8ejFrLfxv+1/R9HGYo4BOfykoVzLb6RkU1AlXM+oEnGMKKWh0R1/nLn3inWnqG2sJGx
         sNEG6zZ/dawxdYW77B3Y6vPt6WtbLQ/6S6W9JlNXIxjUT2inMZmgYeXQ2V7BxIFSKR4F
         yY3w==
X-Gm-Message-State: AOJu0YwMTE4R/SyRRnccVG3lVOZdVEz9bEI0mByAEUztXtdacSa3d03s
	jRxbRekGRQ7s0glZe8aTONJKMr8I3arrlFp3gsdK+TMYn9YYvwijq+mW4Os4Grq0rLCiTS1YVLG
	Pf2JD+O1Scdkp0+lBjKOOY0+zlqQVhg==
X-Google-Smtp-Source: AGHT+IGbunSqjoiDAF4zeiIFZFGC6LfvkBVUCyFQU41uQido0V/JHDymWZ7KuslAr8cBbNU5+mdKEZytIZw4NdTsrwE=
X-Received: by 2002:a05:6102:e09:b0:47a:36b9:16d8 with SMTP id
 o9-20020a0561020e0900b0047a36b916d8mr4727430vst.25.1712954952860; Fri, 12 Apr
 2024 13:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408150531.63085-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240408150531.63085-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 12 Apr 2024 16:49:01 -0400
Message-ID: <CAP+JOzShcf30aDV52UFL_vd0iHKEX7b6kuj3Z0kKB6JPaviSog@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate class permissions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 11:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Validate the symbol tables for permissions of security classes and
> common classes:
>   * check their value is valid
>   * check their values are unique
>   * check permission values of classes do not reuse values from
>     inherited permissions
>
> This simplifies validating permissions of access vectors a lot, since it
> is now only a binary and against the valid permission mask of the class.
>
> Use UINT32_MAX instead of 0 as the special value for validating
> constraints signaling a validate-trans rule, since classes with no
> permissions are permitted, but they must not have a normal constraint
> attached.
>
> Reported-by: oss-fuzz (issue 67893)
> Improves: 8c64e5bb6fe7 ("libsepol: validate access vector permissions")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 101 ++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 35 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index c4f8c300..a5051416 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -11,6 +11,7 @@
>
>  #define bool_xor(a, b) (!(a) !=3D !(b))
>  #define bool_xnor(a, b) (!bool_xor(a, b))
> +#define PERMISSION_MASK(nprim) ((nprim) =3D=3D PERM_SYMTAB_SIZE ? (~UINT=
32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
>
>  typedef struct validate {
>         uint32_t nprim;
> @@ -23,6 +24,12 @@ typedef struct map_arg {
>         const policydb_t *policy;
>  } map_arg_t;
>
> +typedef struct perm_arg {
> +       uint32_t visited;
> +       const uint32_t nprim;
> +       const uint32_t inherited_nprim;
> +} perm_arg_t;
> +
>  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitma=
p_t *gaps)
>  {
>         uint32_t i;
> @@ -230,14 +237,17 @@ bad:
>  static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, const constraint_node_t *cons, validate_t flavors[])
>  {
>         const constraint_expr_t *cexp;
> +       const int is_validatetrans =3D (nperms =3D=3D UINT32_MAX);
>         int depth;
>
>         for (; cons; cons =3D cons->next) {
> -               if (nperms =3D=3D 0 && cons->permissions !=3D 0)
> +               if (is_validatetrans && cons->permissions !=3D 0)
> +                       goto bad;
> +               if (!is_validatetrans && nperms =3D=3D 0)

This conditional does not need to be in the loop and is_validatetrans
will always be false if nperms =3D=3D 0.

The rest of the patch looks good.

Thanks,
Jim

>                         goto bad;
> -               if (nperms > 0 && cons->permissions =3D=3D 0)
> +               if (!is_validatetrans && cons->permissions =3D=3D 0)
>                         goto bad;
> -               if (nperms > 0 && nperms !=3D PERM_SYMTAB_SIZE && cons->p=
ermissions >=3D (UINT32_C(1) << nperms))
> +               if (!is_validatetrans && nperms !=3D PERM_SYMTAB_SIZE && =
cons->permissions >=3D (UINT32_C(1) << nperms))
>                         goto bad;
>
>                 if (!cons->expr)
> @@ -251,7 +261,7 @@ static int validate_constraint_nodes(sepol_handle_t *=
handle, unsigned int nperms
>                                         goto bad;
>                                 depth++;
>
> -                               if (cexp->attr & CEXPR_XTARGET && nperms =
!=3D 0)
> +                               if (cexp->attr & CEXPR_XTARGET && !is_val=
idatetrans)
>                                         goto bad;
>                                 if (!(cexp->attr & CEXPR_TYPE)) {
>                                         if (validate_empty_type_set(cexp-=
>type_names))
> @@ -366,11 +376,49 @@ bad:
>         return -1;
>  }
>
> +static int perm_visit(__attribute__((__unused__)) hashtab_key_t k, hasht=
ab_datum_t d, void *args)
> +{
> +       perm_arg_t *pargs =3D args;
> +       const perm_datum_t *perdatum =3D d;
> +
> +       if (!value_isvalid(perdatum->s.value, pargs->nprim))
> +               return -1;
> +
> +       if (pargs->inherited_nprim !=3D 0 && value_isvalid(perdatum->s.va=
lue, pargs->inherited_nprim))
> +               return -1;
> +
> +       if ((UINT32_C(1) << (perdatum->s.value - 1)) & pargs->visited)
> +               return -1;
> +
> +       pargs->visited |=3D (UINT32_C(1) << (perdatum->s.value - 1));
> +       return 0;
> +}
> +
> +static int validate_permission_symtab(sepol_handle_t *handle, const symt=
ab_t *permissions, uint32_t inherited_nprim)
> +{
> +       /* Check each entry has a different valid value and is not overri=
ding an inherited one */
> +
> +       perm_arg_t pargs =3D { .visited =3D 0, .nprim =3D permissions->np=
rim, .inherited_nprim =3D inherited_nprim };
> +
> +       if (hashtab_map(permissions->table, perm_visit, &pargs))
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid permission table");
> +       return -1;
> +}
> +
>  static int validate_common_datum(sepol_handle_t *handle, const common_da=
tum_t *common, validate_t flavors[])
>  {
>         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
>                 goto bad;
> -       if (common->permissions.table->nel =3D=3D 0 || common->permission=
s.nprim > PERM_SYMTAB_SIZE)
> +       if (common->permissions.nprim =3D=3D 0 || common->permissions.npr=
im > PERM_SYMTAB_SIZE)
> +               goto bad;
> +       if (common->permissions.nprim !=3D common->permissions.table->nel=
)
> +               goto bad;
> +       if (validate_permission_symtab(handle, &common->permissions, 0))
>                 goto bad;
>
>         return 0;
> @@ -393,11 +441,17 @@ static int validate_class_datum(sepol_handle_t *han=
dle, const class_datum_t *cla
>                 goto bad;
>         if (class->comdatum && validate_common_datum(handle, class->comda=
tum, flavors))
>                 goto bad;
> -       if (class->permissions.nprim > PERM_SYMTAB_SIZE)
> +       /* empty classes are permitted */
> +       if (class->permissions.nprim > PERM_SYMTAB_SIZE || class->permiss=
ions.table->nel > PERM_SYMTAB_SIZE)
> +               goto bad;
> +       if (class->permissions.nprim !=3D
> +           (class->permissions.table->nel + (class->comdatum ? class->co=
mdatum->permissions.table->nel : 0)))
> +               goto bad;
> +       if (validate_permission_symtab(handle, &class->permissions, class=
->comdatum ? class->comdatum->permissions.nprim : 0))
>                 goto bad;
>         if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->constraints, flavors))
>                 goto bad;
> -       if (validate_constraint_nodes(handle, 0, class->validatetrans, fl=
avors))
> +       if (validate_constraint_nodes(handle, UINT32_MAX, class->validate=
trans, flavors))
>                 goto bad;
>
>         switch (class->default_user) {
> @@ -877,46 +931,23 @@ bad:
>         return -1;
>  }
>
> -static int perm_match(__attribute__ ((unused)) hashtab_key_t key, hashta=
b_datum_t datum, void *data)
> -{
> -       const uint32_t *v =3D data;
> -       const perm_datum_t *perdatum =3D datum;
> -
> -       return *v =3D=3D perdatum->s.value;
> -}
> -
>  static int validate_access_vector(sepol_handle_t *handle, const policydb=
_t *p, sepol_security_class_t tclass,
>                                   sepol_access_vector_t av)
>  {
>         const class_datum_t *cladatum =3D p->class_val_to_struct[tclass -=
 1];
> -       uint32_t i;
>
>         /*
>          * Check that at least one permission bit is valid.
>          * Older compilers might set invalid bits for the wildcard permis=
sion.
>          */
> -       for (i =3D 0; i < cladatum->permissions.nprim; i++) {
> -               if (av & (UINT32_C(1) << i)) {
> -                       uint32_t v =3D i + 1;
> -                       int rc;
> -
> -                       rc =3D hashtab_map(cladatum->permissions.table, p=
erm_match, &v);
> -                       if (rc =3D=3D 1)
> -                               goto good;
> -
> -                       if (cladatum->comdatum) {
> -                               rc =3D hashtab_map(cladatum->comdatum->pe=
rmissions.table, perm_match, &v);
> -                               if (rc =3D=3D 1)
> -                                       goto good;
> -                       }
> -               }
> -       }
> +       if (!(av & PERMISSION_MASK(cladatum->permissions.nprim)))
> +               goto bad;
>
> +       return 0;
> +
> +bad:
>         ERR(handle, "Invalid access vector");
>         return -1;
> -
> -good:
> -       return 0;
>  }
>
>  static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d=
, void *args)
> --
> 2.43.0
>
>
