Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC714D44A
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128077; cv=none; b=VqxuFMds+RBhe1SHSq8R7wumlPKTSmcY4LOEhlg0DYZzz0eNWtHNOUlw0jhbj4ddVOdpnqKv1p1ffKz9WQmw28PE70uEgGPKoJsGo007Iv6ELbDGB4o2+0lbYjS6N5Mc7NYkpu/5h/tzgLqX0oTFfM6kRjLzGWbo/zsNZkKDGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128077; c=relaxed/simple;
	bh=WQQINVNAsX8521Dw/eFN5W/2mTs8TyAegk6u+mFD52c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7fMA3NHpQRxV6prWu0+MuV1tSLEM2gGyAiJv0J1icDM7rQGTO+qw5Mx5mcfK2JybDbnFRyeR4Y00Rs2tfri/Iuu4HjVqzXpQZSJIMwwXac3Sm32wpMgLAHLf7rvXbmEdL511HKdQDJWyVyfPPZ609uI7QCcJ54nOmES8isQTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSfEINgC; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSfEINgC"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-47273838a21so193756137.1
        for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 05:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709128074; x=1709732874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd1y3+vlK5Pi84N60LKdnXri8ycbTVa8xA+C1MEqlIE=;
        b=SSfEINgCoHaybRti6nK94C9RcvX4XbmULMJZQ/PURmOwiniVPkR5gzdwtlSDoFZs8Q
         w/obLrSLbv4RFzgDroOG15/8M4VKcJDI/8WWD5vRmxiFLqHso3JLf/AI7TcPclmRQbbq
         573eebEz22xxsCS91FMy0SlZn/APBouEi5btvuFZXymbZ53mxGyuamA439t1bJybiTev
         +3Loxx9Zu89ORprMVeXYX/aVpQEBb1nxCapqIDznayMNJyIutq+OoCnKgukG7noX0YMv
         6XzpWYBSJ3XWyfnWArdci3RJkz2e7J5YWZjn+YQ6IYb0gn2jn2IgidyIH8LX/Mr3XhrV
         jeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128074; x=1709732874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd1y3+vlK5Pi84N60LKdnXri8ycbTVa8xA+C1MEqlIE=;
        b=HsSP7Ajs47NGsb4TEoxM3BVsj9Snjfrz2RHUaQBdDXXrDyKz2EQT1UYGDN4vswexKv
         T21Zr+mUSV2c9HUoSxYWy9zwkZBUi9Y6iQlgmumxVjhrNS7ho0qIJvLRQBUaCnOr3/8H
         RufFH5/W2RKyI4lOP6qqA5p2Al8pJ7fVbysiUmGwMF+vVnIthvXFbpbGLcWI/pj8IcZG
         0JO6XHclqqlTEahlh9L5+rKD8N1KDU4Bfy+VicA9DGCjiifJbobdC9MyXJ5jy3SzNuQu
         EqAHiNhnerbkufo1J2qVpAeDW+wFFt5b2JrR1qmePP36TMfALIycg8t7w1CHQJDZf6v4
         UNaQ==
X-Gm-Message-State: AOJu0YwiOIssIQnQaZXPrjYc3lwwvlh4gyfaxoFZ73mvEK8ANY3qqFin
	2F6+M/0mw6SpZfb/WWb3Ao8zborJz/X0qxPqC35oi6Ks5RAxB2k3DobGetWWMRBfVKiqq9eIwFH
	p0n+9m68ovoLOlsbnL0E6mLmEVl8=
X-Google-Smtp-Source: AGHT+IFl+AOXZcGl1+cgq4rZ4HLegkGKj6HeSUuQnSve72oJmIsBvEeuyT3OKjkHQIhNzUQJy2QY0FYcOBul0zpV8sE=
X-Received: by 2002:a67:fe94:0:b0:471:b75f:d9cc with SMTP id
 b20-20020a67fe94000000b00471b75fd9ccmr1768633vsr.4.1709128073278; Wed, 28 Feb
 2024 05:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212151103.1113711-1-jwcart2@gmail.com> <CAJ2a_DcjPwm-EM2SVwtLTd70uJQ3deA_Sbw5GGvkBDxKuW-WiA@mail.gmail.com>
In-Reply-To: <CAJ2a_DcjPwm-EM2SVwtLTd70uJQ3deA_Sbw5GGvkBDxKuW-WiA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 28 Feb 2024 08:47:41 -0500
Message-ID: <CAP+JOzTV3gCncZTP0tBw-pn5GcP4s+8ZaYj7kUhGVYQk+ZFg2g@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Use a dynamic buffer in sepol_av_to_string()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 11:25=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 12 Dec 2023 at 16:11, James Carter <jwcart2@gmail.com> wrote:
> >
> > In the internal function sepol_av_to_string(), use a dynamically
> > allocated buffer for the permission names of an access vector instead
> > of a fixed static buffer to support very long permission names.
> >
> > Update the internal users of sepol_av_to_string() to free the buffer.
> >
> > The exported function sepol_perm_to_string() is just a wrapper to
> > the internal function. To avoid changing the behavior of this function,
> > use a static buffer and copy the resulting string from the internal
> > function. If the string is too long for the buffer or there was an
> > error in creating the string, return a string indicating the error.
> >
> > All of the changes to the internal function and users was the work
> > of Christian G=C3=B6ttsche <cgzones@googlemail.com>.
> >
> > Reported-by: oss-fuzz (issue 64832, 64933)
> > Suggested-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> > v2: In sepol_av_perm_to_string():
> >       - Use "sizeof(avbuf)" instead of 1024
> >       - Added "free(avstr)"
> >     In sepol_av_to_string():
> >       - Added "*p =3D '\0';" to ensure buffer is initialized
>
> Kindly Ping.
> Any progress on this one?
>

I plan on merging this soon.
Thanks,
Jim

> >  checkpolicy/test/dismod.c              | 11 +++---
> >  checkpolicy/test/dispol.c              |  7 ++--
> >  libsepol/include/sepol/policydb/util.h |  2 +-
> >  libsepol/src/assertion.c               | 16 ++++++---
> >  libsepol/src/hierarchy.c               |  7 ++--
> >  libsepol/src/kernel_to_cil.c           |  7 ++++
> >  libsepol/src/kernel_to_conf.c          | 15 +++++---
> >  libsepol/src/module_to_cil.c           |  7 ++++
> >  libsepol/src/services.c                | 26 ++++++++++++--
> >  libsepol/src/util.c                    | 50 +++++++++++++++-----------
> >  10 files changed, 103 insertions(+), 45 deletions(-)
> >
> > diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
> > index ac2d61d2..bd45c95e 100644
> > --- a/checkpolicy/test/dismod.c
> > +++ b/checkpolicy/test/dismod.c
> > @@ -118,12 +118,11 @@ static __attribute__((__noreturn__)) void usage(c=
onst char *progname)
> >  static void render_access_mask(uint32_t mask, uint32_t class, policydb=
_t * p,
> >                                FILE * fp)
> >  {
> > -       char *perm;
> > +       char *perm =3D sepol_av_to_string(p, class, mask);
> >         fprintf(fp, "{");
> > -       perm =3D sepol_av_to_string(p, class, mask);
> > -       if (perm)
> > -               fprintf(fp, "%s ", perm);
> > +       fprintf(fp, "%s ", perm ?: "<format-failure>");
> >         fprintf(fp, "}");
> > +       free(perm);
> >  }
> >
> >  static void render_access_bitmap(ebitmap_t * map, uint32_t class,
> > @@ -135,8 +134,8 @@ static void render_access_bitmap(ebitmap_t * map, u=
int32_t class,
> >         for (i =3D ebitmap_startbit(map); i < ebitmap_length(map); i++)=
 {
> >                 if (ebitmap_get_bit(map, i)) {
> >                         perm =3D sepol_av_to_string(p, class, UINT32_C(=
1) << i);
> > -                       if (perm)
> > -                               fprintf(fp, "%s", perm);
> > +                       fprintf(fp, "%s", perm ?: "<format-failure>");
> > +                       free(perm);
> >                 }
> >         }
> >         fprintf(fp, " }");
> > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > index 944ef7ec..2662048e 100644
> > --- a/checkpolicy/test/dispol.c
> > +++ b/checkpolicy/test/dispol.c
> > @@ -93,12 +93,11 @@ static __attribute__((__noreturn__)) void usage(con=
st char *progname)
> >  static int render_access_mask(uint32_t mask, avtab_key_t * key, policy=
db_t * p,
> >                        FILE * fp)
> >  {
> > -       char *perm;
> > +       char *perm =3D sepol_av_to_string(p, key->target_class, mask);
> >         fprintf(fp, "{");
> > -       perm =3D sepol_av_to_string(p, key->target_class, mask);
> > -       if (perm)
> > -               fprintf(fp, "%s ", perm);
> > +       fprintf(fp, "%s ", perm ?: "<format-failure>");
> >         fprintf(fp, "}");
> > +       free(perm);
> >         return 0;
> >  }
> >
> > diff --git a/libsepol/include/sepol/policydb/util.h b/libsepol/include/=
sepol/policydb/util.h
> > index db8da213..70c531d3 100644
> > --- a/libsepol/include/sepol/policydb/util.h
> > +++ b/libsepol/include/sepol/policydb/util.h
> > @@ -31,7 +31,7 @@ extern "C" {
> >
> >  extern int add_i_to_a(uint32_t i, uint32_t * cnt, uint32_t ** a);
> >
> > -extern char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclas=
s,
> > +extern char *sepol_av_to_string(const policydb_t *policydbp, sepol_sec=
urity_class_t tclass,
> >                                 sepol_access_vector_t av);
> >
> >  char *sepol_extended_perms_to_string(avtab_extended_perms_t *xperms);
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index 6de7d031..3076babe 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -48,26 +48,30 @@ static void report_failure(sepol_handle_t *handle, =
policydb_t *p, const avrule_t
> >                            unsigned int stype, unsigned int ttype,
> >                            const class_perm_node_t *curperm, uint32_t p=
erms)
> >  {
> > +       char *permstr =3D sepol_av_to_string(p, curperm->tclass, perms)=
;
> > +
> >         if (avrule->source_filename) {
> >                 ERR(handle, "neverallow on line %lu of %s (or line %lu =
of %s) violated by allow %s %s:%s {%s };",
> >                     avrule->source_line, avrule->source_filename, avrul=
e->line, policy_name(p),
> >                     p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> > -                   sepol_av_to_string(p, curperm->tclass, perms));
> > +                   permstr ?: "<format-failure>");
> >         } else if (avrule->line) {
> >                 ERR(handle, "neverallow on line %lu violated by allow %=
s %s:%s {%s };",
> >                     avrule->line, p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> > -                   sepol_av_to_string(p, curperm->tclass, perms));
> > +                   permstr ?: "<format-failure>");
> >         } else {
> >                 ERR(handle, "neverallow violated by allow %s %s:%s {%s =
};",
> >                     p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> > -                   sepol_av_to_string(p, curperm->tclass, perms));
> > +                   permstr ?: "<format-failure>");
> >         }
> > +
> > +       free(permstr);
> >  }
> >
> >  static int match_any_class_permissions(class_perm_node_t *cp, uint32_t=
 class, uint32_t data)
> > @@ -200,13 +204,17 @@ static int report_assertion_extended_permissions(=
sepol_handle_t *handle,
> >
> >         /* failure on the regular permissions */
> >         if (!found_xperm) {
> > +               char *permstr =3D sepol_av_to_string(p, curperm->tclass=
, perms);
> > +
> >                 ERR(handle, "neverallowxperm on line %lu of %s (or line=
 %lu of %s) violated by\n"
> >                                 "allow %s %s:%s {%s };",
> >                                 avrule->source_line, avrule->source_fil=
ename, avrule->line, policy_name(p),
> >                                 p->p_type_val_to_name[stype],
> >                                 p->p_type_val_to_name[ttype],
> >                                 p->p_class_val_to_name[curperm->tclass =
- 1],
> > -                               sepol_av_to_string(p, curperm->tclass, =
perms));
> > +                               permstr ?: "<format-failure>");
> > +
> > +               free(permstr);
> >                 errors++;
> >
> >         }
> > diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
> > index 350443a8..06e05310 100644
> > --- a/libsepol/src/hierarchy.c
> > +++ b/libsepol/src/hierarchy.c
> > @@ -443,12 +443,15 @@ static void bounds_report(sepol_handle_t *handle,=
 policydb_t *p, uint32_t child,
> >             p->p_type_val_to_name[child - 1],
> >             p->p_type_val_to_name[parent - 1]);
> >         for (; cur; cur =3D cur->next) {
> > +               char *permstr =3D sepol_av_to_string(p, cur->key.target=
_class, cur->datum.data);
> > +
> >                 ERR(handle, "    %s %s : %s { %s }",
> >                     p->p_type_val_to_name[cur->key.source_type - 1],
> >                     p->p_type_val_to_name[cur->key.target_type - 1],
> >                     p->p_class_val_to_name[cur->key.target_class - 1],
> > -                   sepol_av_to_string(p, cur->key.target_class,
> > -                                      cur->datum.data));
> > +                   permstr ?: "<format-failure>");
> > +
> > +               free(permstr);
> >         }
> >  }
> >
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index bcb58eee..634826d5 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -297,6 +297,11 @@ static int class_constraint_rules_to_strs(struct p=
olicydb *pdb, char *classkey,
> >                 }
> >
> >                 perms =3D sepol_av_to_string(pdb, class->s.value, curr-=
>permissions);
> > +               if (!perms) {
> > +                       ERR(NULL, "Failed to generate permission string=
");
> > +                       rc =3D -1;
> > +                       goto exit;
> > +               }
> >
> >                 if (is_mls) {
> >                         key_word =3D "mlsconstrain";
> > @@ -307,6 +312,7 @@ static int class_constraint_rules_to_strs(struct po=
licydb *pdb, char *classkey,
> >                 }
> >
> >                 rc =3D strs_create_and_add(strs, "(%s (%s (%s)) %s)", k=
ey_word, classkey, perms+1, expr);
> > +               free(perms);
> >                 free(expr);
> >                 if (rc !=3D 0) {
> >                         goto exit;
> > @@ -1772,6 +1778,7 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
> >                 }
> >                 rule =3D create_str("(%s %s %s (%s (%s)))",
> >                                   flavor, src, tgt, class, perms+1);
> > +               free(perms);
> >         } else if (key->specified & AVTAB_XPERMS) {
> >                 perms =3D xperms_to_str(datum->xperms);
> >                 if (perms =3D=3D NULL) {
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 83f46e0f..de1d9e09 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -292,6 +292,11 @@ static int class_constraint_rules_to_strs(struct p=
olicydb *pdb, char *classkey,
> >                 }
> >
> >                 perms =3D sepol_av_to_string(pdb, class->s.value, curr-=
>permissions);
> > +               if (!perms) {
> > +                       ERR(NULL, "Failed to generate permission string=
");
> > +                       rc =3D -1;
> > +                       goto exit;
> > +               }
> >                 if (strchr(perms, ' ')) {
> >                         perm_prefix =3D "{ ";
> >                         perm_suffix =3D " }";
> > @@ -311,6 +316,7 @@ static int class_constraint_rules_to_strs(struct po=
licydb *pdb, char *classkey,
> >                                          flavor, classkey,
> >                                          perm_prefix, perms+1, perm_suf=
fix,
> >                                          expr);
> > +               free(perms);
> >                 free(expr);
> >                 if (rc !=3D 0) {
> >                         goto exit;
> > @@ -1682,7 +1688,7 @@ static char *avtab_node_to_str(struct policydb *p=
db, avtab_key_t *key, avtab_dat
> >  {
> >         uint32_t data =3D datum->data;
> >         type_datum_t *type;
> > -       const char *flavor, *src, *tgt, *class, *perms, *new;
> > +       const char *flavor, *src, *tgt, *class, *new;
> >         char *rule =3D NULL, *permstring;
> >
> >         switch (0xFFF & key->specified) {
> > @@ -1730,13 +1736,14 @@ static char *avtab_node_to_str(struct policydb =
*pdb, avtab_key_t *key, avtab_dat
> >         class =3D pdb->p_class_val_to_name[key->target_class - 1];
> >
> >         if (key->specified & AVTAB_AV) {
> > -               perms =3D sepol_av_to_string(pdb, key->target_class, da=
ta);
> > -               if (perms =3D=3D NULL) {
> > +               permstring =3D sepol_av_to_string(pdb, key->target_clas=
s, data);
> > +               if (permstring =3D=3D NULL) {
> >                         ERR(NULL, "Failed to generate permission string=
");
> >                         goto exit;
> >                 }
> >                 rule =3D create_str("%s %s %s:%s { %s };",
> > -                                 flavor, src, tgt, class, perms+1);
> > +                                 flavor, src, tgt, class, permstring+1=
);
> > +               free(permstring);
> >         } else if (key->specified & AVTAB_XPERMS) {
> >                 permstring =3D sepol_extended_perms_to_string(datum->xp=
erms);
> >                 if (permstring =3D=3D NULL) {
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index ee22dbbd..2ec66292 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -597,6 +597,7 @@ static int avrule_to_cil(int indent, struct policyd=
b *pdb, uint32_t type, const
> >                                         rule, src, tgt,
> >                                         pdb->p_class_val_to_name[classp=
erm->tclass - 1],
> >                                         perms + 1);
> > +                       free(perms);
> >                 } else {
> >                         cil_println(indent, "(%s %s %s %s %s)",
> >                                         rule, src, tgt,
> > @@ -1967,7 +1968,13 @@ static int constraints_to_cil(int indent, struct=
 policydb *pdb, char *classkey,
> >
> >                 if (is_constraint) {
> >                         perms =3D sepol_av_to_string(pdb, class->s.valu=
e, node->permissions);
> > +                       if (perms =3D=3D NULL) {
> > +                               ERR(NULL, "Failed to generate permissio=
n string");
> > +                               rc =3D -1;
> > +                               goto exit;
> > +                       }
> >                         cil_println(indent, "(%sconstrain (%s (%s)) %s)=
", mls, classkey, perms + 1, expr);
> > +                       free(perms);
> >                 } else {
> >                         cil_println(indent, "(%svalidatetrans %s %s)", =
mls, classkey, expr);
> >                 }
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index 0eeee7ec..36e2368f 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -347,9 +347,11 @@ static char *get_class_info(sepol_security_class_t=
 tclass,
> >                 p +=3D len;
> >                 buf_used +=3D len;
> >                 if (state_num < 2) {
> > +                       char *permstr =3D sepol_av_to_string(policydb, =
tclass, constraint->permissions);
> > +
> >                         len =3D snprintf(p, class_buf_len - buf_used, "=
{%s } (",
> > -                       sepol_av_to_string(policydb, tclass,
> > -                               constraint->permissions));
> > +                                      permstr ?: "<format-failure>");
> > +                       free(permstr);
> >                 } else {
> >                         len =3D snprintf(p, class_buf_len - buf_used, "=
(");
> >                 }
> > @@ -1237,7 +1239,25 @@ out:
> >   const char *sepol_av_perm_to_string(sepol_security_class_t tclass,
> >                                         sepol_access_vector_t av)
> >  {
> > -       return sepol_av_to_string(policydb, tclass, av);
> > +       static char avbuf[1024];
> > +       char *avstr =3D sepol_av_to_string(policydb, tclass, av);
> > +       size_t len;
> > +
> > +       memset(avbuf, 0, sizeof(avbuf));
> > +
> > +       if (avstr) {
> > +               len =3D strlen(avstr);
> > +               if (len < sizeof(avbuf)) {
> > +                       strcpy(avbuf, avstr);
> > +               } else {
> > +                       sprintf(avbuf, "<access-vector overflowed buffe=
r>");
> > +               }
> > +               free(avstr);
> > +       } else {
> > +               sprintf(avbuf, "<format-failure>");
> > +       }
> > +
> > +       return avbuf;
> >  }
> >
> >  /*
> > diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> > index 2f877920..dcbdccf1 100644
> > --- a/libsepol/src/util.c
> > +++ b/libsepol/src/util.c
> > @@ -32,7 +32,7 @@
> >
> >  struct val_to_name {
> >         unsigned int val;
> > -       char *name;
> > +       const char *name;
> >  };
> >
> >  /* Add an unsigned integer to a dynamically reallocated array.  *cnt
> > @@ -82,20 +82,27 @@ static int perm_name(hashtab_key_t key, hashtab_dat=
um_t datum, void *data)
> >         return 0;
> >  }
> >
> > -char *sepol_av_to_string(policydb_t * policydbp, uint32_t tclass,
> > +char *sepol_av_to_string(const policydb_t *policydbp, sepol_security_c=
lass_t tclass,
> >                          sepol_access_vector_t av)
> >  {
> >         struct val_to_name v;
> > -       static char avbuf[1024];
> > -       class_datum_t *cladatum;
> > -       char *perm =3D NULL, *p;
> > -       unsigned int i;
> > +       const class_datum_t *cladatum =3D policydbp->class_val_to_struc=
t[tclass - 1];
> > +       uint32_t i;
> >         int rc;
> > -       int avlen =3D 0, len;
> > +       char *buffer =3D NULL, *p;
> > +       int len;
> > +       size_t remaining, size =3D 64;
> > +
> > +retry:
> > +       if (__builtin_mul_overflow(size, 2, &size))
> > +               goto err;
> > +       p =3D realloc(buffer, size);
> > +       if (!p)
> > +               goto err;
> > +       *p =3D '\0'; /* Just in case there are no permissions */
> > +       buffer =3D p;
> > +       remaining =3D size;
> >
> > -       memset(avbuf, 0, sizeof avbuf);
> > -       cladatum =3D policydbp->class_val_to_struct[tclass - 1];
> > -       p =3D avbuf;
> >         for (i =3D 0; i < cladatum->permissions.nprim; i++) {
> >                 if (av & (UINT32_C(1) << i)) {
> >                         v.val =3D i + 1;
> > @@ -106,22 +113,23 @@ char *sepol_av_to_string(policydb_t * policydbp, =
uint32_t tclass,
> >                                                  permissions.table, per=
m_name,
> >                                                  &v);
> >                         }
> > -                       if (rc)
> > -                               perm =3D v.name;
> > -                       if (perm) {
> > -                               len =3D
> > -                                   snprintf(p, sizeof(avbuf) - avlen, =
" %s",
> > -                                            perm);
> > -                               if (len < 0
> > -                                   || (size_t) len >=3D (sizeof(avbuf)=
 - avlen))
> > -                                       return NULL;
> > +                       if (rc =3D=3D 1) {
> > +                               len =3D snprintf(p, remaining, " %s", v=
.name);
> > +                               if (len < 0)
> > +                                       goto err;
> > +                               if ((size_t) len >=3D remaining)
> > +                                       goto retry;
> >                                 p +=3D len;
> > -                               avlen +=3D len;
> > +                               remaining -=3D len;
> >                         }
> >                 }
> >         }
> >
> > -       return avbuf;
> > +       return buffer;
> > +
> > +err:
> > +       free(buffer);
> > +       return NULL;
> >  }
> >
> >  #define next_bit_in_range(i, p) (((i) + 1 < sizeof(p)*8) && xperm_test=
(((i) + 1), p))
> > --
> > 2.43.0
> >
