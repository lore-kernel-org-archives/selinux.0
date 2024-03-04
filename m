Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399848CC7
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579759; cv=none; b=LoDuXdffq0u7maNBipqTNdfod+qySI5GZA18RY6/WlUmopK1HvtMSzkiRmbQ52MXj8x6lroYBVOLjYaxcmgpulajpd4IQEvyfImGcABiY7xCSOGkY86pM483FShIBFMDuO8NwFHJGuOskuWsdQ51F2QbYbqiVfpqWBqx5ZYrYho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579759; c=relaxed/simple;
	bh=H8oefzbSU/8YnPegiN0dqRxRr74Z2CbBNBB5SMunZPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bt/ZGB2moq4o6PI4WzqFmwSseFVn2OyGQ7KN+qf5u1iF38OnbSJ8QnNQvo9bWOCNM/n9sbqaA4SNv4bI9T0l5HvYFK2o9RAHbnnGCD17upoR9eab6VrFEW/mpn0KLTkoV+YOG9D2OGXzg52QjHLqxRNREz9TOYWkFIoOl+PnwnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H58UJupE; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H58UJupE"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so2832548241.1
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579756; x=1710184556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxEzj1HtkZElkDT6i1r1E8kl3es/uD4CktspfOVzOPk=;
        b=H58UJupEz33nQocYS75qyv28PVvijAVLzB/Egvjq6gEJaomDC9GK+4ZqQocHNbm2rL
         h510y3UJ8jK4LYr0lqEdCDj9XEHy0NkJvD8ObGcN+7d17Zh6fUAl78lV+53L7C+9IduU
         8oVMK7G3D3etHM448mFC76M/ZH8Xt9JVBgHVNr9D549TOz0bj1Rowq1fZPsD4OH9FJ8Q
         Hyvnsu0qTFKagJR2TeF64zArGMuaSfMd5yaRWzKqA5uM9LqbD2WW3C05UHmf2G2bHoqd
         i+65cV9jcgQqw2duBBQdSYZhxcsHhfex2TbCz4rE7KlJ0T3U2m3+1P22zKb4YNc2HrOU
         7KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579756; x=1710184556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxEzj1HtkZElkDT6i1r1E8kl3es/uD4CktspfOVzOPk=;
        b=hS2Jt73rXpCi9+LjykBxY2bea2fKn1RIn8/W6EWqwVbaRLhdnSV5Ryq8lD81bU97Gd
         OwaLU58XzbZ2gNyHqLDr16zGVgy+8mqlzQKen9YAoQhKRep6DwSOf309LlBHfICCGYhS
         +t4QsenEag7WbFGlwZ8VTeq5F/+vW/Rme96toc5vw3MG41NEpKraMCSsxV5V5168KD+7
         5UZmUGMn0d2CH66yGzUoiK5qPNDD22Xi4+SLimt9K/4NEEXigPUsDiTvXiuR2z3k2mZz
         ZDw9xJQlgifbTaqtjAUn8FwkUnXUCiBHWY2/uawO8mGbHctvy/5lREdbHIlVb9slV1Zf
         +6Mw==
X-Gm-Message-State: AOJu0YxgIyLZewMzQIWtwffBidvdpNftSys//QaYB6LA0LVU/yK/4HND
	d4XUmAswkpANnEJoWoED0EV3m8+U/1dV2s8pKT+GTe80V0G+5kvbe7nFBnbM2RL/76Mqya96mqb
	oChu5ruI4C1han4vJZjHteTmeEj/NLFWR
X-Google-Smtp-Source: AGHT+IHuOSJgs2+inhLxoVPhzCD7Dm3MyIvYxS+6UjnXTtEL8KfiJwwHVd3hs/JeXJLQTDZscPmXwSkws8MpDbzJLgQ=
X-Received: by 2002:a67:fdc1:0:b0:472:7494:837d with SMTP id
 l1-20020a67fdc1000000b004727494837dmr7108790vsq.4.1709579754569; Mon, 04 Mar
 2024 11:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228204356.1809886-1-jwcart2@gmail.com>
In-Reply-To: <20240228204356.1809886-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:15:43 -0500
Message-ID: <CAP+JOzQHnu9acuUaW_1PN1B4=410Y=_-btf-WC4-kZZ-CKqG=Q@mail.gmail.com>
Subject: Re: [PATCH v3] checkpolicy, libsepol: Fix potential double free of mls_level_t
To: selinux@vger.kernel.org
Cc: cgzones@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:43=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> In checkpolicy, a sensitivity that has one or more aliases will
> temporarily share the mls_level_t structure with its aliases until
> a level statement is processed for the sensitivity (or one of the
> aliases) and the aliases are updated to have their own mls_level_t
> structure. If the policydb is destroyed while they are sharing the
> mls_level_t structure, then a double free of the shared mls_level_t
> will occur. This does not currently occur only because checkpolicy
> does very little clean-up before exiting.
>
> The "defined" field of the level_datum_t is set after a level
> statement is processed for a sensitivity and its aliases. This means
> that we know an alias has its own mls_level_t if the "defined" field
> is set. The double free can be avoided by not destroying the
> mls_leve_t structure for an alias unless the "defined" field is set.
>
> Since the "defined" field is only set to false while the mls_level_t
> structure is being shared, it would be clearer to rename the field
> as "notdefined". It would only be set during the time the sensitivity
> and its aliases are sharing the mls_level_t structure. Outside of
> checkpolicy, the "notdefined" field will always be set to 0.
>
> Also, do more validation of the level_datum_t when validating the
> policydb.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
> v3: Add a comment about the "notdefined" field in the definition of level=
_datum_t.
>     Do more validation of the level_datum_t when validating the policydb.
> v2: Change the field name from "defined" to "notdefined" and change
>     the logic to match.
>
>  checkpolicy/checkpolicy.c                  |  7 ++---
>  checkpolicy/policy_define.c                | 10 ++++---
>  libsepol/cil/src/cil_binary.c              |  3 --
>  libsepol/include/sepol/policydb/policydb.h |  2 +-
>  libsepol/src/policydb.c                    |  6 ++--
>  libsepol/src/policydb_validate.c           | 35 ++++++++++++++++++----
>  6 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index fcec6e51..d7cafaa4 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -370,10 +370,9 @@ static int check_level(hashtab_key_t key, hashtab_da=
tum_t datum, void *arg __att
>  {
>         level_datum_t *levdatum =3D (level_datum_t *) datum;
>
> -       if (!levdatum->isalias && !levdatum->defined) {
> -               fprintf(stderr,
> -                       "Error:  sensitivity %s was not used in a level d=
efinition!\n",
> -                       key);
> +       if (!levdatum->isalias && levdatum->notdefined) {
> +               fprintf(stderr, "Error:  sensitivity %s was not used in a=
 level definition!\n",
> +                               key);
>                 return -1;
>         }
>         return 0;
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 260e609d..ac215086 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -743,6 +743,7 @@ int define_sens(void)
>         level_datum_init(datum);
>         datum->isalias =3D FALSE;
>         datum->level =3D level;
> +       datum->notdefined =3D TRUE;
>
>         ret =3D declare_symbol(SYM_LEVELS, id, datum, &value, &value);
>         switch (ret) {
> @@ -780,6 +781,7 @@ int define_sens(void)
>                 level_datum_init(aliasdatum);
>                 aliasdatum->isalias =3D TRUE;
>                 aliasdatum->level =3D level;
> +               aliasdatum->notdefined =3D TRUE;
>
>                 ret =3D declare_symbol(SYM_LEVELS, id, aliasdatum, NULL, =
&value);
>                 switch (ret) {
> @@ -1006,9 +1008,10 @@ static int clone_level(hashtab_key_t key __attribu=
te__ ((unused)), hashtab_datum
>         mls_level_t *level =3D (mls_level_t *) arg, *newlevel;
>
>         if (levdatum->level =3D=3D level) {
> -               levdatum->defined =3D 1;
> -               if (!levdatum->isalias)
> +               if (!levdatum->isalias) {
> +                       levdatum->notdefined =3D FALSE;
>                         return 0;
> +               }
>                 newlevel =3D (mls_level_t *) malloc(sizeof(mls_level_t));
>                 if (!newlevel)
>                         return -1;
> @@ -1017,6 +1020,7 @@ static int clone_level(hashtab_key_t key __attribut=
e__ ((unused)), hashtab_datum
>                         return -1;
>                 }
>                 levdatum->level =3D newlevel;
> +               levdatum->notdefined =3D FALSE;
>         }
>         return 0;
>  }
> @@ -1057,8 +1061,6 @@ int define_level(void)
>         }
>         free(id);
>
> -       levdatum->defined =3D 1;
> -
>         while ((id =3D queue_remove(id_queue))) {
>                 cat_datum_t *cdatum;
>                 int range_start, range_end, i;
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index a8e3616a..95bd18ba 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -907,7 +907,6 @@ static int cil_sensalias_to_policydb(policydb_t *pdb,=
 struct cil_alias *cil_alia
>                 goto exit;
>         }
>         sepol_alias->level =3D mls_level;
> -       sepol_alias->defined =3D 1;
>         sepol_alias->isalias =3D 1;
>
>         return SEPOL_OK;
> @@ -3163,8 +3162,6 @@ int cil_sepol_level_define(policydb_t *pdb, struct =
cil_sens *cil_sens)
>                 }
>         }
>
> -       sepol_level->defined =3D 1;
> -
>         return SEPOL_OK;
>
>  exit:
> diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
> index 6682069e..56d2cb01 100644
> --- a/libsepol/include/sepol/policydb/policydb.h
> +++ b/libsepol/include/sepol/policydb/policydb.h
> @@ -217,7 +217,7 @@ typedef struct user_datum {
>  typedef struct level_datum {
>         mls_level_t *level;     /* sensitivity and associated categories =
*/
>         unsigned char isalias;  /* is this sensitivity an alias for anoth=
er? */
> -       unsigned char defined;
> +       unsigned char notdefined; /* Only set to non-zero in checkpolicy =
*/
>  } level_datum_t;
>
>  /* Category attributes */
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index f10a8a95..0c23a7a2 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hashtab=
_datum_t datum, void *p
>         if (key)
>                 free(key);
>         levdatum =3D (level_datum_t *) datum;
> -       mls_level_destroy(levdatum->level);
> -       free(levdatum->level);
> +       if (!levdatum->isalias || !levdatum->notdefined) {
> +               mls_level_destroy(levdatum->level);
> +               free(levdatum->level);
> +       }
>         level_datum_destroy(levdatum);
>         free(levdatum);
>         return 0;
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index d86f885e..1d8de44e 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -618,14 +618,39 @@ static int validate_mls_level(const mls_level_t *le=
vel, const validate_t *sens,
>         return -1;
>  }
>
> -static int validate_level_datum(__attribute__ ((unused)) hashtab_key_t k=
, hashtab_datum_t d, void *args)
> +static int validate_level_datum(sepol_handle_t *handle, const level_datu=
m_t *level, validate_t flavors[], const policydb_t *p)
>  {
> -       level_datum_t *level =3D d;
> -       validate_t *flavors =3D args;
> +       if (level->notdefined !=3D 0)
> +               goto bad;
> +
> +       if (validate_mls_level(level->level, &flavors[SYM_LEVELS], &flavo=
rs[SYM_CATS]))
> +               goto bad;
> +
> +       if (level->isalias) {
> +               const mls_level_t *l1 =3D level->level;
> +               const mls_level_t *l2;
> +               const level_datum_t *actual =3D (level_datum_t *) hashtab=
_search(p->p_levels.table, p->p_sens_val_to_name[l1->sens - 1]);
> +               if (!actual)
> +                       goto bad;
> +               l2 =3D actual->level;
> +               if (!ebitmap_cmp(&l1->cat, &l2->cat))
> +                       goto bad;
> +       }
>
> -       return validate_mls_level(level->level, &flavors[SYM_LEVELS], &fl=
avors[SYM_CATS]);
> +       return 0;
> +
> +       bad:
> +       ERR(handle, "Invalid level datum");
> +       return -1;
>  }
>
> +static int validate_level_datum_wrapper(__attribute__ ((unused)) hashtab=
_key_t k, hashtab_datum_t d, void *args)
> +{
> +       map_arg_t *margs =3D args;
> +
> +       return validate_level_datum(margs->handle, d, margs->flavors, mar=
gs->policy);
> +}
> +
>  static int validate_mls_range(const mls_range_t *range, const validate_t=
 *sens, const validate_t *cats)
>  {
>         if (validate_mls_level(&range->level[0], sens, cats))
> @@ -774,7 +799,7 @@ static int validate_datum_array_entries(sepol_handle_=
t *handle, const policydb_t
>         if (hashtab_map(p->p_users.table, validate_user_datum_wrapper, &m=
args))
>                 goto bad;
>
> -       if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum=
, flavors))
> +       if (p->mls && hashtab_map(p->p_levels.table, validate_level_datum=
_wrapper, &margs))
>                 goto bad;
>
>         if (hashtab_map(p->p_cats.table, validate_datum, &flavors[SYM_CAT=
S]))
> --
> 2.43.2
>
