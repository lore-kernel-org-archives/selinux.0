Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357FA2ECE95
	for <selinux@vger.kernel.org>; Thu,  3 Jul 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553339; cv=none; b=Bk646OEDom4xzvVAhUCSr5k6/WbpOmBx2pNIMhm8UetxiDmfpmdBwKRScFTDoMSHLK+vRDSQmziwyvq7oCgXVFcepRgG7DBgsqdzxV4s6DMu7DWN+tl38WXTUEkuYbn9bWS1BDY6Rj35rVCiAc9X/jZGESEGX/YYZnwlggsgrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553339; c=relaxed/simple;
	bh=/pea6r/GeFTyy9QD+q6MP5TV74dmuI5cZH2zS9vOCXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K/JhdFB6VTh/5sgy4unlps6lwZZHLQobAEnFzgRKEs63f2vPhnbXoGO21AXEEz5hko9myq+DlFQDiSZ9HRX5Mu94XrqtByX5YDpNRXY+5FUQtHIdrMA4OzmXu0JlMXVlzyMydVlRhVHeIckr4YzV57kpeBURG9AqVRaOYf7iP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iavHSL6H; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iavHSL6H"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d5d3f3f710so76211385a.2
        for <selinux@vger.kernel.org>; Thu, 03 Jul 2025 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751553335; x=1752158135; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/hNfL8LnPbOwl6y2Q1KXoI3dwFnv2ONOTJm/dAp4iI=;
        b=iavHSL6Hm1JlaXutXaAX0Dyly4ymkfsTPsO4P0uSGAf/ZweJV7Y4/mYiKMI73a1aiP
         arwdf6OIyJpIS+AOlO7+CkTO5Jxhkfw/y/U3tkusF5YhTTb1jfdUHrdwiPGr1+Y2ruDq
         LyXijM88nk4LBuwX6d834wHC84p6xy11VJVQUQOUWQRONnfP7q/CX7W2gKWGphd6Xcs8
         EDwbl8gNAOLeKj06NxcmW8c2dA0bwiyd/KFrfQEbeV/65BFGnOnmBdCPkMEwZkllz9Ds
         T+DyeKvJ53pP4j1xwISsMswLdjpbhxeM/3ATVnk84EA2/MXoq8OHebnm4vkbHyXNVrGc
         3wFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751553335; x=1752158135;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/hNfL8LnPbOwl6y2Q1KXoI3dwFnv2ONOTJm/dAp4iI=;
        b=DEqpbM67IOvQUDWszvAM5eb5AkD+HVsDxb8m6O6Aydlc4lWOwG/9WsSIUUw2rtPce4
         bU1S+/xlhbT9ODjWVktkpClL6rEj2PnF+xjxO0FMs+PNU64taLal1QF5H6nqc71xU1wZ
         X077cYw9eQb6KIE7WuVUKiHTGeyLMzjOdrdWgmf4l4Fn56/5pY8+PdtiLMptu5EEahBt
         cVmfomqjdc4rKFCQXBK+y2PqmQWM7cl6sBlLXPQnqyZ0VfJSfXwPoy6GKg+GmsSlMCUl
         Qk7eY6i2dDV24qz6yyBK9fQtcgSko5h9rD/h5d8LhDbM+0VFkgzD+Hek+S4t464t8mtG
         cgng==
X-Gm-Message-State: AOJu0Yw9nr67vHycOOPBHZr68aMCdOaLkeeKi+IybOH/xFeRkdipp05i
	c4JPEPbda84gXbda1SBtVwATfIU/I0MlGFjlLm27iDjnfcUD7G9lI0UzOkgPUqcI9iLX7rdCS/C
	7CwfyUFXlmqqS6s3u2cE5vckbsFLdx0/Bwg==
X-Gm-Gg: ASbGncv0Ag/QHC03cxqFFvH7A/MWvCYkQ2o9ASo5tC6SSvA+taV5rwbk5Zbv1GoAXf9
	WhZbMoHoI2tKf0D/mm95MB+pSY4WUEgQpzykRg9LolHcMen3MsN9fNZ7nVtQckvPyfbngUJHpTW
	fHYUcgQmwGsDWHkaZzze0QwaOCbnlFS78/zblrKQTQ
X-Google-Smtp-Source: AGHT+IF7Dw8+aC59+2hDUoOR9XKA0ImS1Q9LdULMO68xoLlK7C0NXUP2kHSINUVb//uZhBL7Hpw7vfUbSP1yXEeWk38=
X-Received: by 2002:a05:620a:1a94:b0:7d4:3d20:bff2 with SMTP id
 af79cd13be357-7d5d13e0661mr513178285a.14.1751553334485; Thu, 03 Jul 2025
 07:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630185230.228141-1-jwcart2@gmail.com>
In-Reply-To: <20250630185230.228141-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 3 Jul 2025 10:35:23 -0400
X-Gm-Features: Ac12FXzFxgqV7fX4ZjUM_PWIwkPw4J9smvJ8O-cx20CVk1-joV0p359B9In42zU
Message-ID: <CAP+JOzQ0NABr_cUwzepwD3i9qskUGSHGT6hOQw40E2_4HL-sZQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix copying of declarations
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 2:52=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Commit 117e4c651e909a418e792efd7abfb90a131973de "libsepol: Allow
> multiple policycap statements" has exposed problems in the copying
> of declarations.
>
> If a policycap statement is copied into a block (or other namespace)
> that already has that policycap statement, then instead of creating
> a new policycap struct, a pointer to the old one is returned. Later
> in __cil_copy_node_helper() when cil_add_decl_to_symtab() is called,
> SEPOL_EEXIST is returned and the original datum is destroyed. This
> obviously causes problems later when there is an attempt to access
> the orginal datum.
>
> This problem is not just with policycap statements. A pointer to
> the original datum should never be returned when copying a
> declaration. For a simple declaration, a new struct should always
> be created and passed to cil_add_decl_to_symtab(). It will handle
> duplicate declarations properly. Either returning an error if
> they are not allowed, or updating the right data structures if
> they are. Also, since cil_add_decl_to_symtab() will report errors,
> there is no need to check for a duplicate declaration before
> calling it. For a more complex declaration which requires copying
> other data as well as creating the datum, then it makes sense to
> check for a duplcate declaration before doing that copy. This
> applies to classpermisisons, permissionxs, catsets, levels,
> levelranges, contexts, and ipaddrs.
>
> When copying simple declarations, create a new declaration and
> allow cil_add_decl_to_symtab() to handle the rest. For more
> complex declarations, check for a duplicate declaration before
> copying the data.
>
> Reported-by: oss-fuzz (issues 427262638, 427271310, 427814464,
> 428057580, and 428041877)
> Signed-off-by: James Carter <jwcart2@gmail.com>

Seeing no objection, I have merged this.
Jim

> ---
>  libsepol/cil/src/cil_copy_ast.c | 252 +++++++++-----------------------
>  1 file changed, 66 insertions(+), 186 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
> index 2911523e..172d92ff 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -170,38 +170,22 @@ int cil_copy_blockinherit(__attribute__((unused)) s=
truct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db,=
 void *data, void **copy, symtab_t *symtab)
> +static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db,=
 __attribute__((unused)) void *data, void **copy, __attribute__((unused)) s=
ymtab_t *symtab)
>  {
> -       struct cil_policycap *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_policycap *new;
> -               cil_policycap_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       struct cil_policycap *new;
> +
> +       cil_policycap_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
>
> -int cil_copy_perm(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, symtab_t *symtab)
> +int cil_copy_perm(__attribute__((unused)) struct cil_db *db, __attribute=
__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *sym=
tab)
>  {
> -       struct cil_perm *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_perm *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_perm *new;
> -               cil_perm_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_perm_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -260,23 +244,11 @@ int cil_copy_classmapping(__attribute__((unused)) s=
truct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -int cil_copy_class(__attribute__((unused)) struct cil_db *db, void *data=
, void **copy, symtab_t *symtab)
> +int cil_copy_class(__attribute__((unused)) struct cil_db *db, __attribut=
e__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *sy=
mtab)
>  {
> -       struct cil_class *orig =3D data;
> -       struct cil_class *new =3D NULL;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_class: class cannot be redefi=
ned\n");
> -               return SEPOL_ERR;
> -       }
> +       struct cil_class *new;
>
>         cil_class_init(&new);
> -
> -       new->common =3D NULL;
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -285,22 +257,20 @@ int cil_copy_class(__attribute__((unused)) struct c=
il_db *db, void *data, void *
>  int cil_copy_classpermission(__attribute__((unused)) struct cil_db *db, =
void *data, void **copy, symtab_t *symtab)
>  {
>         struct cil_classpermission *orig =3D data;
> -       struct cil_classpermission *new =3D NULL;
> +       struct cil_classpermission *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         if (key !=3D NULL) {
>                 cil_symtab_get_datum(symtab, key, &datum);
>                 if (datum !=3D NULL) {
> -                       cil_log(CIL_INFO, "classpermission cannot be rede=
fined\n");
> +                       cil_log(CIL_ERR, "Named classpermission cannot be=
 redefined\n");
>                         return SEPOL_ERR;
>                 }
>         }
>
>         cil_classpermission_init(&new);
> -
>         cil_copy_classperms_list(orig->classperms, &new->classperms);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -340,20 +310,12 @@ int cil_copy_classcommon(__attribute__((unused)) st=
ruct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -int cil_copy_sid(__attribute__((unused)) struct cil_db *db, void *data, =
void **copy, symtab_t *symtab)
> +int cil_copy_sid(__attribute__((unused)) struct cil_db *db, __attribute_=
_((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symt=
ab)
>  {
> -       struct cil_sid *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_sid *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_sid *new;
> -               cil_sid_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_sid_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -377,38 +339,22 @@ int cil_copy_sidcontext(struct cil_db *db, void *da=
ta, void **copy, __attribute_
>         return SEPOL_OK;
>  }
>
> -int cil_copy_user(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, symtab_t *symtab)
> +int cil_copy_user(__attribute__((unused)) struct cil_db *db, __attribute=
__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *sym=
tab)
>  {
> -       struct cil_user *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_user *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_user *new;
> -               cil_user_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_user_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
>
> -int cil_copy_userattribute(__attribute__((unused)) struct cil_db *db, vo=
id *data, void **copy, symtab_t *symtab)
> +int cil_copy_userattribute(__attribute__((unused)) struct cil_db *db, __=
attribute__((unused)) void *data, void **copy, __attribute__((unused)) symt=
ab_t *symtab)
>  {
> -       struct cil_userattribute *orig =3D data;
> -       struct cil_userattribute *new =3D NULL;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_userattribute *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               cil_userattribute_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_userattribute_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -501,20 +447,12 @@ int cil_copy_userprefix(__attribute__((unused)) str=
uct cil_db *db, void *data, v
>         return SEPOL_OK;
>  }
>
> -int cil_copy_role(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, symtab_t *symtab)
> +int cil_copy_role(__attribute__((unused)) struct cil_db *db, __attribute=
__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *sym=
tab)
>  {
> -       struct cil_role *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_role *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_role *new;
> -               cil_role_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_role_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -534,20 +472,12 @@ int cil_copy_roletype(__attribute__((unused)) struc=
t cil_db *db, void *data, voi
>         return SEPOL_OK;
>  }
>
> -int cil_copy_roleattribute(__attribute__((unused)) struct cil_db *db, vo=
id *data, void **copy, symtab_t *symtab)
> +int cil_copy_roleattribute(__attribute__((unused)) struct cil_db *db, __=
attribute__((unused)) void *data, void **copy, __attribute__((unused)) symt=
ab_t *symtab)
>  {
> -       struct cil_roleattribute *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_roleattribute *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_roleattribute *new;
> -               cil_roleattribute_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_roleattribute_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -671,21 +601,11 @@ static int cil_copy_expandtypeattribute(__attribute=
__((unused)) struct cil_db *d
>         return SEPOL_OK;
>  }
>
> -static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, voi=
d *data, void **copy, symtab_t *symtab)
> +static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, __a=
ttribute__((unused)) void *data, void **copy, __attribute__((unused)) symta=
b_t *symtab)
>  {
> -       struct cil_alias *orig =3D data;
> -       struct cil_alias *new =3D NULL;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_alias: alias cannot be redefi=
ned\n");
> -               return SEPOL_ERR;
> -       }
> +       struct cil_alias *new;
>
>         cil_alias_init(&new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -768,18 +688,10 @@ int cil_copy_rangetransition(struct cil_db *db, voi=
d *data, void **copy, __attri
>         return SEPOL_OK;
>  }
>
> -int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, symtab_t *symtab)
> +int cil_copy_bool(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_bool *orig =3D data;
> -       struct cil_bool *new =3D NULL;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_bool: boolean cannot be redef=
ined\n");
> -               return SEPOL_ERR;
> -       }
> +       struct cil_bool *new;
>
>         cil_bool_init(&new);
>         new->value =3D orig->value;
> @@ -788,18 +700,10 @@ int cil_copy_bool(__attribute__((unused)) struct ci=
l_db *db, void *data, void **
>         return SEPOL_OK;
>  }
>
> -static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, v=
oid *data, void **copy, symtab_t *symtab)
> +static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, v=
oid *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_tunable *orig =3D data;
> -       struct cil_tunable *new =3D NULL;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_tunable: tunable cannot be re=
defined\n");
> -               return SEPOL_ERR;
> -       }
> +       struct cil_tunable *new;
>
>         cil_tunable_init(&new);
>         new->value =3D orig->value;
> @@ -846,20 +750,18 @@ int cil_copy_avrule(struct cil_db *db, void *data, =
void **copy, __attribute__((u
>  static int cil_copy_permissionx(struct cil_db *db, void *data, void **co=
py, symtab_t *symtab)
>  {
>         struct cil_permissionx *orig =3D data;
> -       struct cil_permissionx *new =3D NULL;
> +       struct cil_permissionx *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> -
> +       struct cil_symtab_datum *datum;
>
>         cil_symtab_get_datum(symtab, key, &datum);
>         if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_permissionx: permissionx cann=
ot be redefined\n");
> +               cil_log(CIL_ERR, "Permissionx cannot be redefined\n");
>                 return SEPOL_ERR;
>         }
>
>         cil_permissionx_init(&new);
>         cil_copy_fill_permissionx(db, orig, new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -899,38 +801,22 @@ int cil_copy_type_rule(__attribute__((unused)) stru=
ct cil_db *db, void *data, vo
>         return SEPOL_OK;
>  }
>
> -int cil_copy_sens(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, symtab_t *symtab)
> +int cil_copy_sens(__attribute__((unused)) struct cil_db *db, __attribute=
__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *sym=
tab)
>  {
> -       struct cil_sens *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_sens *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_sens *new;
> -               cil_sens_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_sens_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
>
> -int cil_copy_cat(__attribute__((unused)) struct cil_db *db, void *data, =
void **copy, symtab_t *symtab)
> +int cil_copy_cat(__attribute__((unused)) struct cil_db *db, __attribute_=
_((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symt=
ab)
>  {
> -       struct cil_cat *orig =3D data;
> -       char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_cat *new;
>
> -       cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum =3D=3D NULL) {
> -               struct cil_cat *new;
> -               cil_cat_init(&new);
> -               *copy =3D new;
> -       } else {
> -               *copy =3D datum;
> -       }
> +       cil_cat_init(&new);
> +       *copy =3D new;
>
>         return SEPOL_OK;
>  }
> @@ -945,20 +831,18 @@ static void cil_copy_cats(struct cil_db *db, struct=
 cil_cats *orig, struct cil_c
>  int cil_copy_catset(struct cil_db *db, void *data, void **copy, symtab_t=
 *symtab)
>  {
>         struct cil_catset *orig =3D data;
> -       struct cil_catset *new =3D NULL;
> +       struct cil_catset *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         cil_symtab_get_datum(symtab, key, &datum);
>         if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_catset: categoryset cannot be=
 redefined\n");
> +               cil_log(CIL_ERR, "Category set cannot be redefined\n");
>                 return SEPOL_ERR;
>         }
>
>         cil_catset_init(&new);
> -
>         cil_copy_cats(db, orig->cats, &new->cats);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -994,20 +878,19 @@ void cil_copy_fill_level(struct cil_db *db, struct =
cil_level *orig, struct cil_l
>  int cil_copy_level(struct cil_db *db, void *data, void **copy, symtab_t =
*symtab)
>  {
>         struct cil_level *orig =3D data;
> -       struct cil_level *new =3D NULL;
> +       struct cil_level *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         if (key !=3D NULL) {
>                 cil_symtab_get_datum(symtab, key, &datum);
>                 if (datum !=3D NULL) {
> -                       cil_log(CIL_INFO, "cil_copy_level: level cannot b=
e redefined\n");
> +                       cil_log(CIL_ERR, "Named level cannot be redefined=
\n");
>                         return SEPOL_ERR;
>                 }
>         }
>
>         cil_copy_fill_level(db, orig, &new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -1031,21 +914,20 @@ void cil_copy_fill_levelrange(struct cil_db *db, s=
truct cil_levelrange *data, st
>  int cil_copy_levelrange(struct cil_db *db, void *data, void **copy, symt=
ab_t *symtab)
>  {
>         struct cil_levelrange *orig =3D data;
> -       struct cil_levelrange *new =3D NULL;
> +       struct cil_levelrange *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         if (key !=3D NULL) {
>                 cil_symtab_get_datum(symtab, key, &datum);
>                 if (datum !=3D NULL) {
> -                       cil_log(CIL_INFO, "cil_copy_levelrange: levelrang=
e cannot be redefined\n");
> +                       cil_log(CIL_ERR, "Named levelrange cannot be rede=
fined\n");
>                         return SEPOL_ERR;
>                 }
>         }
>
>         cil_levelrange_init(&new);
>         cil_copy_fill_levelrange(db, orig, new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -1068,21 +950,20 @@ void cil_copy_fill_context(struct cil_db *db, stru=
ct cil_context *data, struct c
>  int cil_copy_context(struct cil_db *db, void *data, void **copy, symtab_=
t *symtab)
>  {
>         struct cil_context *orig =3D data;
> -       struct cil_context *new =3D NULL;
> +       struct cil_context *new;
>         char *key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         if (key !=3D NULL) {
>                 cil_symtab_get_datum(symtab, key, &datum);
>                 if (datum !=3D NULL) {
> -                       cil_log(CIL_INFO, "cil_copy_context: context cann=
ot be redefined\n");
> +                       cil_log(CIL_ERR, "Named context cannot be redefin=
ed\n");
>                         return SEPOL_ERR;
>                 }
>         }
>
>         cil_context_init(&new);
>         cil_copy_fill_context(db, orig, new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> @@ -1542,19 +1423,18 @@ void cil_copy_fill_ipaddr(struct cil_ipaddr *data=
, struct cil_ipaddr *new)
>  int cil_copy_ipaddr(__attribute__((unused)) struct cil_db *db, void *dat=
a, void **copy, symtab_t *symtab)
>  {
>         struct cil_ipaddr *orig =3D data;
> -       struct cil_ipaddr *new =3D NULL;
> +       struct cil_ipaddr *new;
>         char * key =3D orig->datum.name;
> -       struct cil_symtab_datum *datum =3D NULL;
> +       struct cil_symtab_datum *datum;
>
>         cil_symtab_get_datum(symtab, key, &datum);
>         if (datum !=3D NULL) {
> -               cil_log(CIL_INFO, "cil_copy_ipaddr: ipaddress cannot be r=
edefined\n");
> +               cil_log(CIL_ERR, "Named IP address cannot be redefined\n"=
);
>                 return SEPOL_ERR;
>         }
>
>         cil_ipaddr_init(&new);
>         cil_copy_fill_ipaddr(orig, new);
> -
>         *copy =3D new;
>
>         return SEPOL_OK;
> --
> 2.49.0
>
