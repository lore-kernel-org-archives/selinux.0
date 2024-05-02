Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C91553BB
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673095; cv=none; b=odJJsE6mESDlpzWvAA4phhuTg/letjfYA8lxmvwnR4h5LI2PPZjNIb0ON2QViO/FZ9TeZ2inqnN+NjJVu6gE7+udbawoUPCXnXrx2jOtfB3NmoH0PP2sUXpWeo62TiA/KBGFIaEkqwO+I9/vTeCdbIKABjN1LI84wsDfGUyPip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673095; c=relaxed/simple;
	bh=5CusJSsaqHJqDy27pCZ/fAASnlWRSx8pzVBOeJpeLyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdws+lku23ZVLZeRepUGBIL+FwoDMgFmVnP+6/Ou/J+hXol6+tnw7/3gd6RCacKtbVoE2TO2eUGgkFM5lDh1jEP98sixxOz0mQqtsDAHnznWSUVPQf+6NnYRX3XBkwzXmgh9azIdTrzofWH6PCseGODbAYsuXuFDGmKCqrZkarI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzdOAWHQ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzdOAWHQ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c70999ff96so4530217b6e.2
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673092; x=1715277892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GN1OmwcrvjLpA8klD2gQeLvC21e56dgNm132+xZxTV4=;
        b=VzdOAWHQjB46m49gLuBHKp/klZzOpSIpBwYOwhmcKDdxCN9vYc+5Vm68tfVIX2ls5x
         DlSFE+0Cd2kg1096xd/p1pRDJioZmJb/QcnqtuCpj0lDa4gDUw/jxC0XZCAC9DdVIzM2
         ddkYzu9gV3uYVwiR6FTadWRYeCVfqhvLr6zOheqptN94IPpWuIVUZFLdodXqW6du2mg+
         lyx4SyRm5sjzdowCh/gPwE1Vw0je7oY1ujNaNqJHV4llt3dwZPjs3dNalz3xVqIxTLz8
         b2LKvpQozpwpsSGioUru7f4QjYb+WjA09Rdt6Xotc2GBQfBfT0DVXZlRMEktQznr0YY/
         2tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673092; x=1715277892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GN1OmwcrvjLpA8klD2gQeLvC21e56dgNm132+xZxTV4=;
        b=BsRqfF2NEF50LLZN7fxTmoMg/dQWiM+/qRBVSbgvxcuOzPjRAbKmaLUdH8fNS2e/Cj
         q5qKYIVr66IuAJul2EO9xX/JvMrVJiRCOBFQBu7OREopQQWEEGMy9uy670G5xI4Tstid
         I65pgZ/hYsTtP9J2J/BHGC+5czwR9aP4xmoQ+DYoV37RJoNPHB6xSy8CI0FcgtPMtZQO
         Prz8HXyZRiekxWZhGKPoCF224LoK0CzCKkPaiLUovQlw6ile2BAJNwdSzBxGgNVT+Z7j
         o1hYfDaRaEqP90PpCTbpn10xH+LNSsfR1G30Z44FjMnXBkE0174WUGXNrsPBPurPcgK/
         JXBQ==
X-Gm-Message-State: AOJu0YzUxR8XQV+GkH/imhMZsDEcbOyCBoFOXmsGoqMnTJCHAvmtOx5g
	/V+AtsSUrs2cED5QF6IeZGq2RdB1g1mf5fEK5AE5fyMDesSuor7OIhPxCvCsg21xIMpIUKx7tsC
	WBA3qXnAIeYBAFgkut75kxqiOa3PY8Q==
X-Google-Smtp-Source: AGHT+IES1V77u2GQYPyGPVUG1FFpSoTWW3wW7fLFgMGH8d0bIiIIAiOeRHVrUxwwOX6Q1oRzFdBK8qcghag5b835U2U=
X-Received: by 2002:a05:6808:194:b0:3c8:39b2:bd8b with SMTP id
 w20-20020a056808019400b003c839b2bd8bmr674186oic.55.1714673092192; Thu, 02 May
 2024 11:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415165242.108230-1-cgoettsche@seltendoof.de> <CAP+JOzRHdYJZDdPKGFKHrEhGih8V2g=fydfDA_ai3W95VZEAdQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRHdYJZDdPKGFKHrEhGih8V2g=fydfDA_ai3W95VZEAdQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 2 May 2024 14:04:41 -0400
Message-ID: <CAP+JOzTNyOgax=CNarNOt=7BO-C9gZ-BzJy8nhE0Y7HHhUk9Rw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: validate class permissions
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 2:48=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Apr 15, 2024 at 12:53=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Validate the symbol tables for permissions of security classes and
> > common classes:
> >   * check their value is valid
> >   * check their values are unique
> >   * check permission values of classes do not reuse values from
> >     inherited permissions
> >
> > This simplifies validating permissions of access vectors a lot, since i=
t
> > is now only a binary and against the valid permission mask of the class=
.
> >
> > Use UINT32_MAX instead of 0 as the special value for validating
> > constraints signaling a validate-trans rule, since classes with no
> > permissions are permitted, but they must not have a normal constraint
> > attached.
> >
> > Reported-by: oss-fuzz (issue 67893)
> > Improves: 8c64e5bb6fe7 ("libsepol: validate access vector permissions")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >    - move check independent of individual constraints out of the loop
> >    - change nperms parameter type of validate_constraint_nodes() from
> >      unsigned int to uint32_t
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/policydb_validate.c | 104 ++++++++++++++++++++-----------
> >  1 file changed, 68 insertions(+), 36 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index c4f8c300..e1623172 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -11,6 +11,7 @@
> >
> >  #define bool_xor(a, b) (!(a) !=3D !(b))
> >  #define bool_xnor(a, b) (!bool_xor(a, b))
> > +#define PERMISSION_MASK(nprim) ((nprim) =3D=3D PERM_SYMTAB_SIZE ? (~UI=
NT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
> >
> >  typedef struct validate {
> >         uint32_t nprim;
> > @@ -23,6 +24,12 @@ typedef struct map_arg {
> >         const policydb_t *policy;
> >  } map_arg_t;
> >
> > +typedef struct perm_arg {
> > +       uint32_t visited;
> > +       const uint32_t nprim;
> > +       const uint32_t inherited_nprim;
> > +} perm_arg_t;
> > +
> >  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebit=
map_t *gaps)
> >  {
> >         uint32_t i;
> > @@ -227,17 +234,21 @@ bad:
> >         return -1;
> >  }
> >
> > -static int validate_constraint_nodes(sepol_handle_t *handle, unsigned =
int nperms, const constraint_node_t *cons, validate_t flavors[])
> > +static int validate_constraint_nodes(sepol_handle_t *handle, uint32_t =
nperms, const constraint_node_t *cons, validate_t flavors[])
> >  {
> >         const constraint_expr_t *cexp;
> > +       const int is_validatetrans =3D (nperms =3D=3D UINT32_MAX);
> >         int depth;
> >
> > +       if (cons && nperms =3D=3D 0)
> > +               goto bad;
> > +
> >         for (; cons; cons =3D cons->next) {
> > -               if (nperms =3D=3D 0 && cons->permissions !=3D 0)
> > +               if (is_validatetrans && cons->permissions !=3D 0)
> >                         goto bad;
> > -               if (nperms > 0 && cons->permissions =3D=3D 0)
> > +               if (!is_validatetrans && cons->permissions =3D=3D 0)
> >                         goto bad;
> > -               if (nperms > 0 && nperms !=3D PERM_SYMTAB_SIZE && cons-=
>permissions >=3D (UINT32_C(1) << nperms))
> > +               if (!is_validatetrans && nperms !=3D PERM_SYMTAB_SIZE &=
& cons->permissions >=3D (UINT32_C(1) << nperms))
> >                         goto bad;
> >
> >                 if (!cons->expr)
> > @@ -251,7 +262,7 @@ static int validate_constraint_nodes(sepol_handle_t=
 *handle, unsigned int nperms
> >                                         goto bad;
> >                                 depth++;
> >
> > -                               if (cexp->attr & CEXPR_XTARGET && nperm=
s !=3D 0)
> > +                               if (cexp->attr & CEXPR_XTARGET && !is_v=
alidatetrans)
> >                                         goto bad;
> >                                 if (!(cexp->attr & CEXPR_TYPE)) {
> >                                         if (validate_empty_type_set(cex=
p->type_names))
> > @@ -366,11 +377,49 @@ bad:
> >         return -1;
> >  }
> >
> > +static int perm_visit(__attribute__((__unused__)) hashtab_key_t k, has=
htab_datum_t d, void *args)
> > +{
> > +       perm_arg_t *pargs =3D args;
> > +       const perm_datum_t *perdatum =3D d;
> > +
> > +       if (!value_isvalid(perdatum->s.value, pargs->nprim))
> > +               return -1;
> > +
> > +       if (pargs->inherited_nprim !=3D 0 && value_isvalid(perdatum->s.=
value, pargs->inherited_nprim))
> > +               return -1;
> > +
> > +       if ((UINT32_C(1) << (perdatum->s.value - 1)) & pargs->visited)
> > +               return -1;
> > +
> > +       pargs->visited |=3D (UINT32_C(1) << (perdatum->s.value - 1));
> > +       return 0;
> > +}
> > +
> > +static int validate_permission_symtab(sepol_handle_t *handle, const sy=
mtab_t *permissions, uint32_t inherited_nprim)
> > +{
> > +       /* Check each entry has a different valid value and is not over=
riding an inherited one */
> > +
> > +       perm_arg_t pargs =3D { .visited =3D 0, .nprim =3D permissions->=
nprim, .inherited_nprim =3D inherited_nprim };
> > +
> > +       if (hashtab_map(permissions->table, perm_visit, &pargs))
> > +               goto bad;
> > +
> > +       return 0;
> > +
> > +bad:
> > +       ERR(handle, "Invalid permission table");
> > +       return -1;
> > +}
> > +
> >  static int validate_common_datum(sepol_handle_t *handle, const common_=
datum_t *common, validate_t flavors[])
> >  {
> >         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
> >                 goto bad;
> > -       if (common->permissions.table->nel =3D=3D 0 || common->permissi=
ons.nprim > PERM_SYMTAB_SIZE)
> > +       if (common->permissions.nprim =3D=3D 0 || common->permissions.n=
prim > PERM_SYMTAB_SIZE)
> > +               goto bad;
> > +       if (common->permissions.nprim !=3D common->permissions.table->n=
el)
> > +               goto bad;
> > +       if (validate_permission_symtab(handle, &common->permissions, 0)=
)
> >                 goto bad;
> >
> >         return 0;
> > @@ -393,11 +442,17 @@ static int validate_class_datum(sepol_handle_t *h=
andle, const class_datum_t *cla
> >                 goto bad;
> >         if (class->comdatum && validate_common_datum(handle, class->com=
datum, flavors))
> >                 goto bad;
> > -       if (class->permissions.nprim > PERM_SYMTAB_SIZE)
> > +       /* empty classes are permitted */
> > +       if (class->permissions.nprim > PERM_SYMTAB_SIZE || class->permi=
ssions.table->nel > PERM_SYMTAB_SIZE)
> > +               goto bad;
> > +       if (class->permissions.nprim !=3D
> > +           (class->permissions.table->nel + (class->comdatum ? class->=
comdatum->permissions.table->nel : 0)))
> > +               goto bad;
> > +       if (validate_permission_symtab(handle, &class->permissions, cla=
ss->comdatum ? class->comdatum->permissions.nprim : 0))
> >                 goto bad;
> >         if (validate_constraint_nodes(handle, class->permissions.nprim,=
 class->constraints, flavors))
> >                 goto bad;
> > -       if (validate_constraint_nodes(handle, 0, class->validatetrans, =
flavors))
> > +       if (validate_constraint_nodes(handle, UINT32_MAX, class->valida=
tetrans, flavors))
> >                 goto bad;
> >
> >         switch (class->default_user) {
> > @@ -877,46 +932,23 @@ bad:
> >         return -1;
> >  }
> >
> > -static int perm_match(__attribute__ ((unused)) hashtab_key_t key, hash=
tab_datum_t datum, void *data)
> > -{
> > -       const uint32_t *v =3D data;
> > -       const perm_datum_t *perdatum =3D datum;
> > -
> > -       return *v =3D=3D perdatum->s.value;
> > -}
> > -
> >  static int validate_access_vector(sepol_handle_t *handle, const policy=
db_t *p, sepol_security_class_t tclass,
> >                                   sepol_access_vector_t av)
> >  {
> >         const class_datum_t *cladatum =3D p->class_val_to_struct[tclass=
 - 1];
> > -       uint32_t i;
> >
> >         /*
> >          * Check that at least one permission bit is valid.
> >          * Older compilers might set invalid bits for the wildcard perm=
ission.
> >          */
> > -       for (i =3D 0; i < cladatum->permissions.nprim; i++) {
> > -               if (av & (UINT32_C(1) << i)) {
> > -                       uint32_t v =3D i + 1;
> > -                       int rc;
> > -
> > -                       rc =3D hashtab_map(cladatum->permissions.table,=
 perm_match, &v);
> > -                       if (rc =3D=3D 1)
> > -                               goto good;
> > -
> > -                       if (cladatum->comdatum) {
> > -                               rc =3D hashtab_map(cladatum->comdatum->=
permissions.table, perm_match, &v);
> > -                               if (rc =3D=3D 1)
> > -                                       goto good;
> > -                       }
> > -               }
> > -       }
> > +       if (!(av & PERMISSION_MASK(cladatum->permissions.nprim)))
> > +               goto bad;
> >
> > +       return 0;
> > +
> > +bad:
> >         ERR(handle, "Invalid access vector");
> >         return -1;
> > -
> > -good:
> > -       return 0;
> >  }
> >
> >  static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t =
*d, void *args)
> > --
> > 2.43.0
> >
> >
