Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9076033
	for <selinux@vger.kernel.org>; Mon, 15 Apr 2024 18:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206926; cv=none; b=BIO6B/z8dw6xcNlXv1yInil4BzVLFZts1bm9fuf3mvD9Bn+aCF8wk/UoFFmDqK6VTBkK1x9OM+V+RkrxYD3Y37CkG3RnG7CqaWLUQu0Hv33HlPZCZs8nri6GexxkiceDQX/B7MNDsBNmwaPQb8DDJYx+xtoi3La2co1dGaORTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206926; c=relaxed/simple;
	bh=LEcDkTrK6QJ4m124huu9+k02YQf9EyshboH3ZmmTdx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnnXI8UZmAZ/EPrj5sJaqc5xv92OwJyncaqmU4Ru+ZOOmFsI5acN8boIXOu4kxc9I0VOhLqY7aOi8ZDkHbWEHOKx4Fhub+JjaGO+QwQUBlYBReSWI4HSTNHGPdLXa1pTZ/yhBKFVP7TKtHpNoVM2dhFOUdgETdg412Dkxauu/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKkMa5DN; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKkMa5DN"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7dacc916452so354467241.0
        for <selinux@vger.kernel.org>; Mon, 15 Apr 2024 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713206923; x=1713811723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOjsGcXDBR41STReSdOqVnStfSLA/Wos3Y3K2NwpLNg=;
        b=gKkMa5DNSmH1paP+sRzYpQm/QYA3MH2jKAqsFbdo8VvyyaQAg05uMWKTyKT3JSOG6V
         /MnRyaFuY26O0q2HnfvNqoJvATlyabeOxl4hY9/v7xTYGgUkWH9qRBHLjppVwMDxHqmZ
         G2Zsp3R4ZU/vT0lhXUHs6JsN4qKuwwZUl6idOyOLtQRa4UKcFod1sIujDoypB13W3NmI
         weaMB3hkIMge7pX0VEksQPi3g3W1nuPpQkayYELwNM6f9itFO4R/OqRfCq5t3MWJKazc
         q1GXuUpKBg9XUFLMikJcWFI8Gvg+EJAOAe/CNOaef6Y40sYPMHqaYiw5D2P65+CluLxS
         MW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206923; x=1713811723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOjsGcXDBR41STReSdOqVnStfSLA/Wos3Y3K2NwpLNg=;
        b=XVJF3y/Wo/L/cCinog26Kf+TImzvdKlk7uZmY/qky52bi2N4FhqUYskLKEfWi8xVIs
         cN5hyRiIC+N8HpjSktL2WT34r+b0Zay9SIH8bpwxiAN0R8hW8BMFtwKoE1yTku5MIwwJ
         n3v9Nv09tGIS9s7Q7LY+LsauFUXK+AJRgKpN4PvGdNaZV//kGm5ErekPbqSOA1XF3+Nf
         5Bd3VFwOvT/YMHmD1Jycw5EXsNAORFdhmqDQ1eM0B2L5aE/3ILAAPgCcOJmUp+/jV3sm
         0UeeArGJXt4qiCr0CGUmxVd/8klTHxtfld6acOdoNS1/5HelDXH7TJjcP8gnDIy5j3jk
         NfeA==
X-Gm-Message-State: AOJu0YzJoNGK0jE1MrVgoVPFP1pI5YR+BToORiy+ckEtCs5ql6b83Q0T
	03XLeekVXh19xzdwTIQNpJ9HWiTGufiwqFNL8g2ygAScqTqI5AySxbtn57g/OxL/XqVkP05tiCK
	QXXCjOSXBlaWvTlm7BCC6p9k0W0A=
X-Google-Smtp-Source: AGHT+IF69nMNVA+HblEgpMzQsV6TpgcIUXaiiB/GKEM12gvPR2CMIQSfC4obsQhL8qg6fhiep+O/9BtbR7s9Kff7vN0=
X-Received: by 2002:a05:6102:c4e:b0:47b:5f23:beac with SMTP id
 y14-20020a0561020c4e00b0047b5f23beacmr5778654vss.25.1713206923202; Mon, 15
 Apr 2024 11:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415165242.108230-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240415165242.108230-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 15 Apr 2024 14:48:32 -0400
Message-ID: <CAP+JOzRHdYJZDdPKGFKHrEhGih8V2g=fydfDA_ai3W95VZEAdQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: validate class permissions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:53=E2=80=AFPM Christian G=C3=B6ttsche
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
> v2:
>    - move check independent of individual constraints out of the loop
>    - change nperms parameter type of validate_constraint_nodes() from
>      unsigned int to uint32_t
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 104 ++++++++++++++++++++-----------
>  1 file changed, 68 insertions(+), 36 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index c4f8c300..e1623172 100644
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
> @@ -227,17 +234,21 @@ bad:
>         return -1;
>  }
>
> -static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, const constraint_node_t *cons, validate_t flavors[])
> +static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t np=
erms, const constraint_node_t *cons, validate_t flavors[])
>  {
>         const constraint_expr_t *cexp;
> +       const int is_validatetrans =3D (nperms =3D=3D UINT32_MAX);
>         int depth;
>
> +       if (cons && nperms =3D=3D 0)
> +               goto bad;
> +
>         for (; cons; cons =3D cons->next) {
> -               if (nperms =3D=3D 0 && cons->permissions !=3D 0)
> +               if (is_validatetrans && cons->permissions !=3D 0)
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
> @@ -251,7 +262,7 @@ static int validate_constraint_nodes(sepol_handle_t *=
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
> @@ -366,11 +377,49 @@ bad:
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
> @@ -393,11 +442,17 @@ static int validate_class_datum(sepol_handle_t *han=
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
> @@ -877,46 +932,23 @@ bad:
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
