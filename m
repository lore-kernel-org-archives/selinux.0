Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7FB14AD07
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128147; cv=none; b=OCseKLfn9ZfZ+AxqiMVhW1alatoREBDurMPSDAzCKMm8nvkkh0hFhWO6ZnDZ/G3idc9ZDV5MHbO+AwzVBBr96va52okvIiEcVeQKLVwlXSIQTbY1qIMLTFp3dq3UcauLIDZ6l5WUP2nwczRdZmh8JJR+VK3eUwtvguPBSiNIC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128147; c=relaxed/simple;
	bh=AllVu1y0GFI7NY/8L3numR+X61qi/hiZL1Hk2HxoV+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCHsClVl6itbJ8vl2QY95KPoq2M7MDtPlkHwF4vpebhkNecgJzyPOMOLazv1cgb1LBojMB+IB6stNcCQj6vNzWt8iHC3/ZP3AVtImAEzYt6oMSHxpPQy9WVpZHTbEeBorLmbVM8SOvfmN0t3oPYgQLk/vZleTiv2dPvp04WAMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYtWlxD/; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYtWlxD/"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4cfa1b3c3a2so477036e0c.0
        for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128144; x=1709732944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpArHjn6qWXmMknjPJamFornEWZxsGci8FWZCrhZuqQ=;
        b=nYtWlxD/cJDPvhGD4fs0+RUYtjhR/cWCfOezjp0vAJv0ZahJ1qFqUVANJOJQbV+eQC
         Yx0JPMQ7IzozahR/6y3IbmtpSjYiaDA3WxNI4gzOtGBRD90VlGXcTPdJmwyfF64ovo0C
         O0KYGnpBthrsjl/pq/MKIIOSck0Yqnpa39A5Kk8iQtBw7quy0ibO8YUZaRWeV4Bozoqu
         zvGETrPK/PQpqdaNWlexvM5/i1jRrS72blDRsbC6SuoW5j6zo6/u48gSqi3NgQ4JlILg
         f6OPeT8DcmIS5BJzrAq3zwt9hxHhqdxX5TUsg0d5CSPGPbqtLSiSnhPLYszP9fWM4Ovq
         KujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128144; x=1709732944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpArHjn6qWXmMknjPJamFornEWZxsGci8FWZCrhZuqQ=;
        b=SkghWbtE7DggMWIrRlnG1Kt+F88UIZWXdUrCGFW5qFHphXELXseS+SiQ57x7LBL/NF
         v90hqJOUN0OkZ/rSQ8u/KUT1ad6n+zEdXrXbYgQjVXCzDSw1ow2XIIbfRclBjlbZdjNJ
         jKv+yWe8ZZU31YyBPDE0h3QiVkgjw1fqSPnexE0qGMMjXX3PBYBk1saXNeRFhssu0Ip6
         1ZhZGBrUOJo+6433E6BqzpNzQ60LFChbyxRYHdxvDmdwGGoqCGPvDy2uz89Q2VTK4kIQ
         9ncfCIrdeulX55EqOIdxrOj/Z6IesnBYxNUBEjB1lVxxM+DdHyEP5QcTuqKInt7x416j
         MSYg==
X-Gm-Message-State: AOJu0Yws+oTmknJAXtpFoLgGO73DXbgmBP0DecqNcQMJqB/v7QRckKwI
	43ER3gAP5WNZAcb01AWpxzp7IyN+sIYcpbkD+MT3PjjDo9gLO0Ho7vswxblF3IE4m1qomquDxJn
	ctT9i/vFj497VNhgO7b4qIOtvNpkdTqCp
X-Google-Smtp-Source: AGHT+IGCLSLr8FcFpQfMqRya7SRV48lypvKC+mQyl5k/UNf7zVFtjOLWznGZ+GXo+DwlnYi/LXNRILLARCgHNgy2JlA=
X-Received: by 2002:a05:6122:4a10:b0:4cf:da07:fb01 with SMTP id
 ez16-20020a0561224a1000b004cfda07fb01mr1783153vkb.8.1709128144117; Wed, 28
 Feb 2024 05:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210759.1310310-1-jwcart2@gmail.com> <CAJ2a_DcNB7nd2OejzukWiWKa+zpCitXzx1GMs0Ei0dszZYUG4Q@mail.gmail.com>
In-Reply-To: <CAJ2a_DcNB7nd2OejzukWiWKa+zpCitXzx1GMs0Ei0dszZYUG4Q@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Feb 2024 08:48:52 -0500
Message-ID: <CAP+JOzT8qg5CEE5YJ65yajdLsvRd9HNQYMQkxY040qpqVr+CYg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy, libsepol: Fix potential double free of mls_level_t
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:33=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 21 Feb 2024 at 22:08, James Carter <jwcart2@gmail.com> wrote:
> >
> > In checkpolicy, a sensitivity that has one or more aliases will
> > temporarily share the mls_level_t structure with its aliases until
> > a level statement is processed for the sensitivity (or one of the
> > aliases) and the aliases are updated to have their own mls_level_t
> > structure. If the policydb is destroyed while they are sharing the
> > mls_level_t structure, then a double free of the shared mls_level_t
> > will occur. This does not currently occur only because checkpolicy
> > does very little clean-up before exiting.
> >
> > The "defined" field of the level_datum_t is set after a level
> > statement is processed for a sensitivity and its aliases. This means
> > that we know an alias has its own mls_level_t if the "defined" field
> > is set. The double free can be avoided by not destroying the
> > mls_leve_t structure for an alias unless the "defined" field is set.
> >
> > Since the "defined" field is only set to false while the mls_level_t
> > structure is being shared, it would be clearer to rename the field
> > as "notdefined". It would only be set during the time the sensitivity
> > and its aliases are sharing the mls_level_t structure. Outside of
> > checkpolicy, the "notdefined" field will always be set to 0.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v2: Change the field name from "defined" to "notdefined" and change
> >     the logic to match.
>
> Thanks, in my opinion this is a much nicer approach.
>
> Maybe check in libsepol/src/policydb_validate.c:validate_level_datum()
> that notdefined is FALSE?
>

That is a good idea.

> >  checkpolicy/checkpolicy.c                  |  7 +++----
> >  checkpolicy/policy_define.c                | 10 ++++++----
> >  libsepol/cil/src/cil_binary.c              |  3 ---
> >  libsepol/include/sepol/policydb/policydb.h |  2 +-
> >  libsepol/src/policydb.c                    |  6 ++++--
> >  5 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> > index fcec6e51..d7cafaa4 100644
> > --- a/checkpolicy/checkpolicy.c
> > +++ b/checkpolicy/checkpolicy.c
> > @@ -370,10 +370,9 @@ static int check_level(hashtab_key_t key, hashtab_=
datum_t datum, void *arg __att
> >  {
> >         level_datum_t *levdatum =3D (level_datum_t *) datum;
> >
> > -       if (!levdatum->isalias && !levdatum->defined) {
> > -               fprintf(stderr,
> > -                       "Error:  sensitivity %s was not used in a level=
 definition!\n",
> > -                       key);
> > +       if (!levdatum->isalias && levdatum->notdefined) {
> > +               fprintf(stderr, "Error:  sensitivity %s was not used in=
 a level definition!\n",
> > +                               key);
> >                 return -1;
> >         }
> >         return 0;
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 260e609d..ac215086 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -743,6 +743,7 @@ int define_sens(void)
> >         level_datum_init(datum);
> >         datum->isalias =3D FALSE;
> >         datum->level =3D level;
> > +       datum->notdefined =3D TRUE;
> >
> >         ret =3D declare_symbol(SYM_LEVELS, id, datum, &value, &value);
> >         switch (ret) {
> > @@ -780,6 +781,7 @@ int define_sens(void)
> >                 level_datum_init(aliasdatum);
> >                 aliasdatum->isalias =3D TRUE;
> >                 aliasdatum->level =3D level;
> > +               aliasdatum->notdefined =3D TRUE;
> >
> >                 ret =3D declare_symbol(SYM_LEVELS, id, aliasdatum, NULL=
, &value);
> >                 switch (ret) {
> > @@ -1006,9 +1008,10 @@ static int clone_level(hashtab_key_t key __attri=
bute__ ((unused)), hashtab_datum
> >         mls_level_t *level =3D (mls_level_t *) arg, *newlevel;
> >
> >         if (levdatum->level =3D=3D level) {
> > -               levdatum->defined =3D 1;
> > -               if (!levdatum->isalias)
> > +               if (!levdatum->isalias) {
> > +                       levdatum->notdefined =3D FALSE;
> >                         return 0;
> > +               }
> >                 newlevel =3D (mls_level_t *) malloc(sizeof(mls_level_t)=
);
> >                 if (!newlevel)
> >                         return -1;
> > @@ -1017,6 +1020,7 @@ static int clone_level(hashtab_key_t key __attrib=
ute__ ((unused)), hashtab_datum
> >                         return -1;
> >                 }
> >                 levdatum->level =3D newlevel;
> > +               levdatum->notdefined =3D FALSE;
> >         }
> >         return 0;
> >  }
> > @@ -1057,8 +1061,6 @@ int define_level(void)
> >         }
> >         free(id);
> >
> > -       levdatum->defined =3D 1;
> > -
> >         while ((id =3D queue_remove(id_queue))) {
> >                 cat_datum_t *cdatum;
> >                 int range_start, range_end, i;
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index a8e3616a..95bd18ba 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -907,7 +907,6 @@ static int cil_sensalias_to_policydb(policydb_t *pd=
b, struct cil_alias *cil_alia
> >                 goto exit;
> >         }
> >         sepol_alias->level =3D mls_level;
> > -       sepol_alias->defined =3D 1;
> >         sepol_alias->isalias =3D 1;
> >
> >         return SEPOL_OK;
> > @@ -3163,8 +3162,6 @@ int cil_sepol_level_define(policydb_t *pdb, struc=
t cil_sens *cil_sens)
> >                 }
> >         }
> >
> > -       sepol_level->defined =3D 1;
> > -
> >         return SEPOL_OK;
> >
> >  exit:
> > diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/incl=
ude/sepol/policydb/policydb.h
> > index 6682069e..66d93999 100644
> > --- a/libsepol/include/sepol/policydb/policydb.h
> > +++ b/libsepol/include/sepol/policydb/policydb.h
> > @@ -217,7 +217,7 @@ typedef struct user_datum {
> >  typedef struct level_datum {
> >         mls_level_t *level;     /* sensitivity and associated categorie=
s */
> >         unsigned char isalias;  /* is this sensitivity an alias for ano=
ther? */
> > -       unsigned char defined;
> > +       unsigned char notdefined;
>
> Maybe add a small comment that it's only used as an optimization in
> checkpolicy and is 0 for fully parsed or generated policies?
>

Also a good idea.
Thanks,
Jim

> >  } level_datum_t;
> >
> >  /* Category attributes */
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index f10a8a95..0c23a7a2 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -1390,8 +1390,10 @@ static int sens_destroy(hashtab_key_t key, hasht=
ab_datum_t datum, void *p
> >         if (key)
> >                 free(key);
> >         levdatum =3D (level_datum_t *) datum;
> > -       mls_level_destroy(levdatum->level);
> > -       free(levdatum->level);
> > +       if (!levdatum->isalias || !levdatum->notdefined) {
> > +               mls_level_destroy(levdatum->level);
> > +               free(levdatum->level);
> > +       }
> >         level_datum_destroy(levdatum);
> >         free(levdatum);
> >         return 0;
> > --
> > 2.43.0
> >
