Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B01D79A6
	for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131324; cv=none; b=fA7u184uUD4OXBFcYJS1hRJPSK4OdwmuP3aYiJapsrsA9scTIL4S7gl0rI5djDM0zPhKjwfbD21isdTz1/7ZJm9waZ2AX61QAKu1DuUZFPy94+yslIPxXUSrX3DMPh6ZBuKaPE1cwI5aXa9FiufIBJ/1rT+gWW6NSZ4Hk/osF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131324; c=relaxed/simple;
	bh=zaH8wFHhmNzKEfPM+SgekHoPflW+Te53RuPlCw1bO4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPhWGUc6npEGzmNMdsyPQ5364Cj6NihnYrGr+Nfi1mGJc7TXWVhBY1m7Tb9yb+c4i0O/0Ha0IV3ntKKc0QeI7pBL1IqF5/77v0j9ByDJDZHv/soDAMT6Xnl3KiM/1cF/JbK+vG9VaJ2AQk5lHg0fwu0TEz/j1oop98vbGOI2gYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MZof2DA+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MZof2DA+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e5ef7527deso47288027b3.0
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1730131320; x=1730736120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LpQTYhYMh8DLAEapuBtFKeqGj+ROoL8Olsd/8zGK1Ss=;
        b=MZof2DA+P2MuLSW/FcvHohZbtsB+nsT5cAEDrX1ho6ajhqtEWfZIgmRCbLO7p4gQHG
         84wMFH4YST4OruEIe34puP2cmX6vh9qrWQpZfPXMddAo3gguH7Uu7lLZZgHsP9phlDoo
         +j7uPEaVspvlsSpX90WqHHAlpwic9irQvDpy5ZI8ZRydCkXhLh6PadQ2ddV4FFovu+fO
         DhpGLaJKzQbIsAaIT0eKxoaLHNIQmh2QUsi+XvPT3tEsZiITo/XhB9qivHOHfVY7Ho/f
         W12hsymw8DziI0jfhvwoeC3onOJ4TukaDmAYUw7qOSAOeqhmlQ+ChnQERNN+CnT2yfdw
         OPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131320; x=1730736120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LpQTYhYMh8DLAEapuBtFKeqGj+ROoL8Olsd/8zGK1Ss=;
        b=a6ZfduViV3/4dWyu36ylcxFLV8CIQX0qnmGrj/UEGoQMrBmzuHBnu1MAAUHreJSVX2
         vlZkYKW1IO4l1pTSOhWKj2t84U9SmH8L5v+UwT2Ied1NZkvw9F/Zdp4G/+bMYdnju150
         rJKHXX0lLUUHtvXQupuXyo/k+tYfg6ovabOZ6To7tjLXDH/KcsptkHeeyHT3cBU2hhHk
         9Vu9Fzf12Gf9HufDk3GJKPFs1d9iMpkFte2Ax9p4vGawBuu7pQmD5ccF11gxFwsfPKVU
         I3028rAA89ACrny9X7zg0f2iEkgG9dDWKNmHaU6Xs7Kj+Jx0ehrm+QrnTFoKSpNky8e4
         WepQ==
X-Gm-Message-State: AOJu0YxUqTPPqcvKtaC/+4jYua33dwwEu3MMGrS/v4BDT77Rpm0Y1efw
	pkFI4GogwCKk0x1MfsggJUJAt/kbt2MNoF188pQ3QPgsTXAbJG3nH24MaYU2yn7v4bcDdxj9n1A
	IpWAMCSc79DrQUk2ZrVw50I5ngV0=
X-Google-Smtp-Source: AGHT+IFk5W48Y02hk0v91PLY97PCSCAa5UWHZ1eDyypiQwDVQhTRQhBHoemIdlZx8YrSMD1j2NyHtSFuGhzjk197YDM=
X-Received: by 2002:a05:690c:2a8e:b0:6e2:5d2:3421 with SMTP id
 00721157ae682-6e9d892cfa5mr64806177b3.10.1730131319641; Mon, 28 Oct 2024
 09:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025154824.140073-1-cgoettsche@seltendoof.de>
 <20241025154824.140073-4-cgoettsche@seltendoof.de> <CAP+JOzSg_uXbw+R_m+NMKFXARZyC7giQ=tYPjaRfF+eSOM5Cow@mail.gmail.com>
In-Reply-To: <CAP+JOzSg_uXbw+R_m+NMKFXARZyC7giQ=tYPjaRfF+eSOM5Cow@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 28 Oct 2024 17:01:48 +0100
Message-ID: <CAJ2a_De8FOF60fmdrq54EnW_3NtfUCqUyqC-sfRzJFobQdMZgg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] libsepol/cil: add support for xperms in
 conditional policies
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 at 16:17, James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Oct 25, 2024 at 12:12=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Add support for extended permission rules in conditional policies.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Testing reveals a couple of issues handling assertions in CIL that
> works as expected in checkpolicy.
>
> (type tp21)
> (boolean bb02 true)
> (booleanif bb02
>   (true
>     (allow tp21 tpx (clx (ioctl)))
>     (allowx tp21 tpx (ioctl clx (0x1101)))
>   )
> )
> (neverallowx tp21 tpx (ioctl clx (0x4101)))
> This neverallowx should is not a violation, but is reported as one.
>
> (type tp51)
> (boolean bb05 true)
> (allow tp51 tpx (clx (ioctl)))
> (booleanif bb05
>   (true
>     (allowx tp51 tpx (ioctl clx (0x1101)))
>   )
>   (false
>     (allowx tp51 tpx (ioctl clx (0x1101)))
>   )
> )
> (neverallowx tp51 tpx (ioctl clx (0x4101)))
> Same for this neverallowx. It is not a violation, but is reported as one.
>
> CIL does most of its checking using libsepol, so I am not sure what
> the problem is.

Thanks again for testing.

It seems CIL is setting the ioctl/nlmsg permission bit into the `data`
member of `avtab_datum_t` for extended av rules while checkpolicy is
not.

The following fixup for patch 3/6 solves the issue for me:

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 20a368e4..2a9ae6e0 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -546,7 +546,7 @@ static bool
check_assertion_extended_permissions_avtab(const avrule_t *narule,
                                       if (!match_node_key(node, &tmp_key))
                                               continue;

-                                       if
(match_any_class_permissions(narule->perms, node->key.target_class,
node->datum.data)) {
+                                       if ((node->key.specified &
AVTAB_ALLOWED) && match_any_class_permissions(narule->perms,
node->key.target_class, node->datum.data)) {
                                               found_true_base =3D true;
                                               continue;
                                       }
@@ -607,7 +607,7 @@ static bool
check_assertion_extended_permissions_avtab(const avrule_t *narule,
                                       if (!match_node_key(node, &tmp_key))
                                               continue;

-                                       if
(match_any_class_permissions(narule->perms, node->key.target_class,
node->datum.data)) {
+                                       if ((node->key.specified &
AVTAB_ALLOWED) && match_any_class_permissions(narule->perms,
node->key.target_class, node->datum.data)) {
                                               found_false_base =3D true;
                                               continue;
                                       }


>
> Thanks,
> Jim
>
>
> > ---
> >  libsepol/cil/src/cil_binary.c      | 153 +++++++++++++++++++++++++----
> >  libsepol/cil/src/cil_build_ast.c   |   6 +-
> >  libsepol/cil/src/cil_resolve_ast.c |   6 +-
> >  libsepol/cil/src/cil_verify.c      |   3 +-
> >  secilc/test/policy.cil             |  13 ++-
> >  5 files changed, 153 insertions(+), 28 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 3dec1883..086dccb0 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -59,14 +59,18 @@
> >  #define AVRULEX_TABLE_SIZE (1 <<  10)
> >  #define PERMS_PER_CLASS 32
> >
> > +struct cil_args_xperm_tables {
> > +       hashtab_t ioctl;
> > +       hashtab_t nlmsg;
> > +};
> > +
> >  struct cil_args_binary {
> >         const struct cil_db *db;
> >         policydb_t *pdb;
> >         struct cil_list *neverallows;
> >         int pass;
> >         hashtab_t role_trans_table;
> > -       hashtab_t avrulex_ioctl_table;
> > -       hashtab_t avrulex_nlmsg_table;
> > +       struct cil_args_xperm_tables avrulex_xperm_tables;
> >         void **type_value_to_cil;
> >  };
> >
> > @@ -75,8 +79,14 @@ struct cil_args_booleanif {
> >         policydb_t *pdb;
> >         cond_node_t *cond_node;
> >         enum cil_flavor cond_flavor;
> > +       struct cil_args_xperm_tables avrulex_xperm_tables;
> >  };
> >
> > +static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, =
const_hashtab_key_t key);
> > +static int avrulex_compare(hashtab_t h
> > +             __attribute__ ((unused)), const_hashtab_key_t key1,
> > +                                     const_hashtab_key_t key2);
> > +
> >  static int __cil_get_sepol_user_datum(policydb_t *pdb, struct cil_symt=
ab_datum *datum, user_datum_t **sepol_user)
> >  {
> >         *sepol_user =3D hashtab_search(pdb->p_users.table, datum->fqn);
> > @@ -1762,7 +1772,10 @@ static int __cil_permx_bitmap_to_sepol_xperms_li=
st(uint32_t kind, ebitmap_t *xpe
> >  static int __cil_avrulex_xperm_to_policydb(hashtab_key_t k, hashtab_da=
tum_t datum, uint32_t xperm_kind, void *args)
> >  {
> >         int rc =3D SEPOL_OK;
> > -       struct policydb *pdb;
> > +       struct cil_args_booleanif *booleanif_args =3D args;
> > +       struct policydb *pdb =3D booleanif_args->pdb;
> > +       cond_node_t *cond_node =3D booleanif_args->cond_node;
> > +       enum cil_flavor cond_flavor =3D booleanif_args->cond_flavor;
> >         avtab_key_t *avtab_key;
> >         avtab_datum_t avtab_datum;
> >         struct cil_list *xperms_list =3D NULL;
> > @@ -1772,7 +1785,6 @@ static int __cil_avrulex_xperm_to_policydb(hashta=
b_key_t k, hashtab_datum_t datu
> >         char *kind =3D NULL;
> >
> >         avtab_key =3D (avtab_key_t *)k;
> > -       pdb =3D args;
> >
> >         sepol_obj =3D pdb->class_val_to_struct[avtab_key->target_class =
- 1];
> >
> > @@ -1793,7 +1805,12 @@ static int __cil_avrulex_xperm_to_policydb(hasht=
ab_key_t k, hashtab_datum_t datu
> >
> >         cil_list_for_each(item, xperms_list) {
> >                 avtab_datum.xperms =3D item->data;
> > -               rc =3D avtab_insert(&pdb->te_avtab, avtab_key, &avtab_d=
atum);
> > +
> > +               if (cond_node) {
> > +                       rc =3D __cil_cond_insert_rule(&pdb->te_cond_avt=
ab, avtab_key, &avtab_datum, cond_node, cond_flavor);
> > +               } else {
> > +                       rc =3D avtab_insert(&pdb->te_avtab, avtab_key, =
&avtab_datum);
> > +               }
> >                 if (rc !=3D SEPOL_OK) {
> >                         goto exit;
> >                 }
> > @@ -1876,7 +1893,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t=
 kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct c=
il_permissionx *permx, struct cil_args_binary *args)
> > +static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t=
 kind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct c=
il_permissionx *permx, struct cil_args_xperm_tables *xt)
> >  {
> >         int rc =3D SEPOL_ERR;
> >         type_datum_t *sepol_src =3D NULL;
> > @@ -1899,11 +1916,11 @@ static int __cil_avrulex_to_hashtable_helper(po=
licydb_t *pdb, uint16_t kind, str
> >
> >                 switch (permx->kind) {
> >                 case  CIL_PERMX_KIND_IOCTL:
> > -                       rc =3D __cil_avrulex_xperm_to_hashtable(args->a=
vrulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj=
->s.value, permx->perms);
> > +                       rc =3D __cil_avrulex_xperm_to_hashtable(xt->ioc=
tl, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx=
->perms);
> >                         if (rc !=3D SEPOL_OK) goto exit;
> >                         break;
> >                 case  CIL_PERMX_KIND_NLMSG:
> > -                       rc =3D __cil_avrulex_xperm_to_hashtable(args->a=
vrulex_nlmsg_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj=
->s.value, permx->perms);
> > +                       rc =3D __cil_avrulex_xperm_to_hashtable(xt->nlm=
sg, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx=
->perms);
> >                         if (rc !=3D SEPOL_OK) goto exit;
> >                         break;
> >                 default:
> > @@ -1920,7 +1937,7 @@ exit:
> >         return rc;
> >  }
> >
> > -static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_=
db *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
> > +static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_=
db *db, struct cil_avrule *cil_avrulex, struct cil_args_xperm_tables *xt)
> >  {
> >         int rc =3D SEPOL_ERR;
> >         uint16_t kind;
> > @@ -1946,7 +1963,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >
> >                 ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
> >                         src =3D DATUM(db->val_to_type[s]);
> > -                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, k=
ind, src, src, cil_avrulex->perms.x.permx, args);
> > +                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, k=
ind, src, src, cil_avrulex->perms.x.permx, xt);
> >                         if (rc !=3D SEPOL_OK) {
> >                                 ebitmap_destroy(&src_bitmap);
> >                                 goto exit;
> > @@ -1964,7 +1981,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                         for (t =3D 0; t < (unsigned int)db->num_types; =
t++) {
> >                                 if (s !=3D t) {
> >                                         tgt =3D DATUM(db->val_to_type[t=
]);
> > -                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                                         if (rc !=3D SEPOL_OK) {
> >                                                 ebitmap_destroy(&src_bi=
tmap);
> >                                                 goto exit;
> > @@ -1984,7 +2001,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                         ebitmap_for_each_positive_bit(&src_bitmap, tnod=
e, t) {
> >                                 if (s !=3D t) {
> >                                         tgt =3D DATUM(db->val_to_type[t=
]);
> > -                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                                         if (rc !=3D SEPOL_OK) {
> >                                                 ebitmap_destroy(&src_bi=
tmap);
> >                                                 goto exit;
> > @@ -1998,7 +2015,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                 int expand_tgt =3D __cil_should_expand_attribute(db, tg=
t);
> >
> >                 if (!expand_src && !expand_tgt) {
> > -                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, k=
ind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, k=
ind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                         if (rc !=3D SEPOL_OK) {
> >                                 goto exit;
> >                         }
> > @@ -2019,7 +2036,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                                 ebitmap_for_each_positive_bit(&tgt_bitm=
ap, tnode, t) {
> >                                         tgt =3D DATUM(db->val_to_type[t=
]);
> >
> > -                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                                       rc =3D __cil_avrulex_to_hashtab=
le_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                                         if (rc !=3D SEPOL_OK) {
> >                                                 ebitmap_destroy(&src_bi=
tmap);
> >                                                 ebitmap_destroy(&tgt_bi=
tmap);
> > @@ -2038,7 +2055,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                         ebitmap_for_each_positive_bit(&src_bitmap, snod=
e, s) {
> >                                 src =3D DATUM(db->val_to_type[s]);
> >
> > -                               rc =3D __cil_avrulex_to_hashtable_helpe=
r(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                               rc =3D __cil_avrulex_to_hashtable_helpe=
r(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                                 if (rc !=3D SEPOL_OK) {
> >                                         ebitmap_destroy(&src_bitmap);
> >                                         goto exit;
> > @@ -2054,7 +2071,7 @@ static int cil_avrulex_to_hashtable(policydb_t *p=
db, const struct cil_db *db, st
> >                         ebitmap_for_each_positive_bit(&tgt_bitmap, tnod=
e, t) {
> >                                 tgt =3D DATUM(db->val_to_type[t]);
> >
> > -                               rc =3D __cil_avrulex_to_hashtable_helpe=
r(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> > +                               rc =3D __cil_avrulex_to_hashtable_helpe=
r(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
> >                                 if (rc !=3D SEPOL_OK) {
> >                                         ebitmap_destroy(&tgt_bitmap);
> >                                         goto exit;
> > @@ -2123,6 +2140,21 @@ static int __cil_cond_to_policydb_helper(struct =
cil_tree_node *node, __attribute
> >                         goto exit;
> >                 }
> >                 break;
> > +       case CIL_AVRULEX:
> > +               if (db->policy_version < POLICYDB_VERSION_COND_XPERMS) =
{
> > +                       cil_tree_log(node, CIL_ERR, "Extended permissio=
n rules are not supported in policy version %d\n",
> > +                                    db->policy_version);
> > +                       rc =3D SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +               cil_avrule =3D node->data;
> > +               rc =3D cil_avrulex_to_hashtable(pdb, db, cil_avrule, &a=
rgs->avrulex_xperm_tables);
> > +               if (rc !=3D SEPOL_OK) {
> > +                       cil_tree_log(node, CIL_ERR, "Failed to insert a=
vrulex into avtab");
> > +                       goto exit;
> > +               }
> > +               break;
> > +
> >         case CIL_CALL:
> >         case CIL_TUNABLEIF:
> >                 break;
> > @@ -2429,6 +2461,8 @@ int cil_booleanif_to_policydb(policydb_t *pdb, co=
nst struct cil_db *db, struct c
> >         int was_created;
> >         int swapped =3D CIL_FALSE;
> >         cond_av_list_t tmp_cl;
> > +       hashtab_t avrulex_ioctl_table =3D NULL;
> > +       hashtab_t avrulex_nlmsg_table =3D NULL;
> >
> >         tmp_cond =3D cond_node_create(pdb, NULL);
> >         if (tmp_cond =3D=3D NULL) {
> > @@ -2497,26 +2531,97 @@ int cil_booleanif_to_policydb(policydb_t *pdb, =
const struct cil_db *db, struct c
> >         bool_args.cond_node =3D cond_node;
> >
> >         if (true_node !=3D NULL) {
> > +               avrulex_ioctl_table =3D hashtab_create(avrulex_hash, av=
rulex_compare, AVRULEX_TABLE_SIZE);
> > +               if (!avrulex_ioctl_table) {
> > +                       cil_log(CIL_INFO, "Failure to create hashtab fo=
r avrulex\n");
> > +                       goto exit;
> > +               }
> > +
> > +               avrulex_nlmsg_table =3D hashtab_create(avrulex_hash, av=
rulex_compare, AVRULEX_TABLE_SIZE);
> > +               if (!avrulex_nlmsg_table) {
> > +                       cil_log(CIL_INFO, "Failure to create hashtab fo=
r avrulex\n");
> > +                       goto exit;
> > +               }
> > +
> >                 bool_args.cond_flavor =3D CIL_CONDTRUE;
> > +               bool_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_=
table;
> > +               bool_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_=
table;
> >                 rc =3D cil_tree_walk(true_node, __cil_cond_to_policydb_=
helper, NULL, NULL, &bool_args);
> >                 if (rc !=3D SEPOL_OK) {
> >                         cil_tree_log(true_node, CIL_ERR, "Failure while=
 walking true conditional block");
> >                         goto exit;
> >                 }
> > +
> > +               rc =3D hashtab_map(avrulex_ioctl_table, __cil_avrulex_i=
octl_to_policydb, &bool_args);
> > +               if (rc !=3D SEPOL_OK) {
> > +                       cil_log(CIL_INFO, "Failure creating avrulex rul=
es\n");
> > +                       goto exit;
> > +               }
> > +
> > +               rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avrulex_n=
lmsg_to_policydb, &bool_args);
> > +               if (rc !=3D SEPOL_OK) {
> > +                       cil_log(CIL_INFO, "Failure creating avrulex rul=
es\n");
> > +                       goto exit;
> > +               }
> > +
> > +               hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_de=
stroy, NULL);
> > +               hashtab_destroy(avrulex_nlmsg_table);
> > +               avrulex_nlmsg_table =3D NULL;
> > +
> > +               hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_de=
stroy, NULL);
> > +               hashtab_destroy(avrulex_ioctl_table);
> > +               avrulex_ioctl_table =3D NULL;
> >         }
> >
> >         if (false_node !=3D NULL) {
> > +               avrulex_ioctl_table =3D hashtab_create(avrulex_hash, av=
rulex_compare, AVRULEX_TABLE_SIZE);
> > +               if (!avrulex_ioctl_table) {
> > +                       cil_log(CIL_INFO, "Failure to create hashtab fo=
r avrulex\n");
> > +                       goto exit;
> > +               }
> > +
> > +               avrulex_nlmsg_table =3D hashtab_create(avrulex_hash, av=
rulex_compare, AVRULEX_TABLE_SIZE);
> > +               if (!avrulex_nlmsg_table) {
> > +                       cil_log(CIL_INFO, "Failure to create hashtab fo=
r avrulex\n");
> > +                       goto exit;
> > +               }
> > +
> >                 bool_args.cond_flavor =3D CIL_CONDFALSE;
> > +               bool_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_=
table;
> > +               bool_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_=
table;
> >                 rc =3D cil_tree_walk(false_node, __cil_cond_to_policydb=
_helper, NULL, NULL, &bool_args);
> >                 if (rc !=3D SEPOL_OK) {
> >                         cil_tree_log(false_node, CIL_ERR, "Failure whil=
e walking false conditional block");
> >                         goto exit;
> >                 }
> > +
> > +               rc =3D hashtab_map(avrulex_ioctl_table, __cil_avrulex_i=
octl_to_policydb, &bool_args);
> > +               if (rc !=3D SEPOL_OK) {
> > +                       cil_log(CIL_INFO, "Failure creating avrulex rul=
es\n");
> > +                       goto exit;
> > +               }
> > +
> > +               rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avrulex_n=
lmsg_to_policydb, &bool_args);
> > +               if (rc !=3D SEPOL_OK) {
> > +                       cil_log(CIL_INFO, "Failure creating avrulex rul=
es\n");
> > +                       goto exit;
> > +               }
> > +
> > +               hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_de=
stroy, NULL);
> > +               hashtab_destroy(avrulex_nlmsg_table);
> > +               avrulex_nlmsg_table =3D NULL;
> > +
> > +
> > +               hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_de=
stroy, NULL);
> > +               hashtab_destroy(avrulex_ioctl_table);
> > +               avrulex_ioctl_table =3D NULL;
> >         }
> >
> >         return SEPOL_OK;
> >
> >  exit:
> > +       hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_destroy, N=
ULL);
> > +       hashtab_destroy(avrulex_ioctl_table);
> >         if (tmp_cond) {
> >                 if (tmp_cond->expr)
> >                         cond_expr_destroy(tmp_cond->expr);
> > @@ -4091,7 +4196,7 @@ static int __cil_node_to_policydb(struct cil_tree=
_node *node, void *extra_args)
> >                 case CIL_AVRULEX: {
> >                                 struct cil_avrule *rule =3D node->data;
> >                                 if (rule->rule_kind !=3D CIL_AVRULE_NEV=
ERALLOW) {
> > -                                       rc =3D cil_avrulex_to_hashtable=
(pdb, db, node->data, args);
> > +                                       rc =3D cil_avrulex_to_hashtable=
(pdb, db, node->data, &args->avrulex_xperm_tables);
> >                                 }
> >                         }
> >                         break;
> > @@ -5162,6 +5267,7 @@ int cil_binary_create_allocated_pdb(const struct =
cil_db *db, sepol_policydb_t *p
> >         int rc =3D SEPOL_ERR;
> >         int i;
> >         struct cil_args_binary extra_args;
> > +       struct cil_args_booleanif booleanif_args;
> >         policydb_t *pdb =3D &policydb->p;
> >         struct cil_list *neverallows =3D NULL;
> >         hashtab_t role_trans_table =3D NULL;
> > @@ -5226,10 +5332,15 @@ int cil_binary_create_allocated_pdb(const struc=
t cil_db *db, sepol_policydb_t *p
> >         extra_args.pdb =3D pdb;
> >         extra_args.neverallows =3D neverallows;
> >         extra_args.role_trans_table =3D role_trans_table;
> > -       extra_args.avrulex_ioctl_table =3D avrulex_ioctl_table;
> > -       extra_args.avrulex_nlmsg_table =3D avrulex_nlmsg_table;
> > +       extra_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_table;
> > +       extra_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_table;
> >         extra_args.type_value_to_cil =3D type_value_to_cil;
> >
> > +       booleanif_args.db =3D db;
> > +       booleanif_args.pdb =3D pdb;
> > +       booleanif_args.cond_node =3D NULL;
> > +       booleanif_args.cond_flavor =3D CIL_NONE;
> > +
> >         for (i =3D 1; i <=3D 3; i++) {
> >                 extra_args.pass =3D i;
> >
> > @@ -5248,12 +5359,12 @@ int cil_binary_create_allocated_pdb(const struc=
t cil_db *db, sepol_policydb_t *p
> >                 }
> >
> >                 if (i =3D=3D 3) {
> > -                       rc =3D hashtab_map(avrulex_ioctl_table, __cil_a=
vrulex_ioctl_to_policydb, pdb);
> > +                       rc =3D hashtab_map(avrulex_ioctl_table, __cil_a=
vrulex_ioctl_to_policydb, &booleanif_args);
> >                         if (rc !=3D SEPOL_OK) {
> >                                 cil_log(CIL_INFO, "Failure creating avr=
ulex rules\n");
> >                                 goto exit;
> >                         }
> > -                       rc =3D hashtab_map(avrulex_nlmsg_table, __cil_a=
vrulex_nlmsg_to_policydb, pdb);
> > +                       rc =3D hashtab_map(avrulex_nlmsg_table, __cil_a=
vrulex_nlmsg_to_policydb, &booleanif_args);
> >                         if (rc !=3D SEPOL_OK) {
> >                                 cil_log(CIL_INFO, "Failure creating avr=
ulex rules\n");
> >                                 goto exit;
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_bu=
ild_ast.c
> > index 19fbb04e..8cc3f9b2 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -6158,7 +6158,11 @@ static int check_for_illegal_statement(struct ci=
l_tree_node *parse_current, stru
> >                         parse_current->data !=3D CIL_KEY_AUDITALLOW &&
> >                         parse_current->data !=3D CIL_KEY_TYPETRANSITION=
 &&
> >                         parse_current->data !=3D CIL_KEY_TYPECHANGE &&
> > -                       parse_current->data !=3D CIL_KEY_TYPEMEMBER) {
> > +                       parse_current->data !=3D CIL_KEY_TYPEMEMBER &&
> > +                       ((args->db->policy_version < POLICYDB_VERSION_C=
OND_XPERMS) ||
> > +                         (parse_current->data !=3D CIL_KEY_ALLOWX &&
> > +                          parse_current->data !=3D CIL_KEY_DONTAUDITX =
&&
> > +                          parse_current->data !=3D CIL_KEY_AUDITALLOWX=
))) {
> >                         if (((struct cil_booleanif*)args->boolif->data)=
->preserved_tunable) {
> >                                 cil_tree_log(parse_current, CIL_ERR, "%=
s is not allowed in tunableif being treated as a booleanif", (char *)parse_=
current->data);
> >                         } else {
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_=
resolve_ast.c
> > index da8863c4..a8fa89df 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -3848,9 +3848,11 @@ static int __cil_resolve_ast_node_helper(struct =
cil_tree_node *node, uint32_t *f
> >                         node->flavor !=3D CIL_CONDBLOCK &&
> >                         node->flavor !=3D CIL_AVRULE &&
> >                         node->flavor !=3D CIL_TYPE_RULE &&
> > -                       node->flavor !=3D CIL_NAMETYPETRANSITION) {
> > +                       node->flavor !=3D CIL_NAMETYPETRANSITION &&
> > +                       ((args->db->policy_version < POLICYDB_VERSION_C=
OND_XPERMS) ||
> > +                        (node->flavor !=3D CIL_AVRULEX))) {
> >                         rc =3D SEPOL_ERR;
> > -               } else if (node->flavor =3D=3D CIL_AVRULE) {
> > +               } else if (node->flavor =3D=3D CIL_AVRULE || node->flav=
or =3D=3D CIL_AVRULEX) {
> >                         struct cil_avrule *rule =3D node->data;
> >                         if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLO=
W) {
> >                                 rc =3D SEPOL_ERR;
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verif=
y.c
> > index 9621a247..550b4542 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -1101,7 +1101,8 @@ static int __cil_verify_booleanif_helper(struct c=
il_tree_node *node, __attribute
> >         struct cil_booleanif *bif =3D node->parent->parent->data;
> >
> >         switch (rule_node->flavor) {
> > -       case CIL_AVRULE: {
> > +       case CIL_AVRULE:
> > +       case CIL_AVRULEX: {
> >                 struct cil_avrule *avrule =3D NULL;
> >                 avrule =3D rule_node->data;
> >                 if (avrule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> > diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> > index e6b78618..d0d52d0d 100644
> > --- a/secilc/test/policy.cil
> > +++ b/secilc/test/policy.cil
> > @@ -47,8 +47,9 @@
> >
> >  (block policy
> >         (class file (execute_no_trans entrypoint execmod open audit_acc=
ess a b c d e))
> > -       ; order should be: file char b c a dir d e f
> > -       (classorder (file char))
> > +       (class socket (nlmsg))
> > +       ; order should be: file socket char b c a dir d e f
> > +       (classorder (file socket char))
> >         (classorder (unordered dir))
> >         (classorder (unordered c a b d e f))
> >         (classorder (char b c a))
> > @@ -161,7 +162,10 @@
> >         ;;(allow bad_t not_bad_type (file (execute)))
> >         ;;(allow bad_t exec_t (file (execute)))
> >         (neverallow bad_t not_bad_type (file (execute)))
> > -
> > +
> > +       (auditallowx getty_t console_device_t (ioctl file (range 0x1000=
 0x10FF)))
> > +       (auditallowx getty_t kernel_t (nlmsg socket (range 0x1000 0x10F=
F)))
> > +
> >         (booleanif secure_mode
> >                 (true
> >                         (auditallow device_t exec_t (file (read write))=
)
> > @@ -172,9 +176,12 @@
> >                 (true
> >                         (typechange auditadm_t console_device_t file us=
er_tty_device_t)
> >                         (allow getty_t console_device_t (file (getattr =
open read write append)))
> > +                       (auditallowx getty_t console_device_t (ioctl fi=
le (range 0x2000 0x21FF)))
> > +                       (auditallowx getty_t kernel_t (nlmsg socket (0x=
1)))
> >                 )
> >                 (false
> >                         (dontaudit getty_t console_device_t (file (geta=
ttr open read write append)))
> > +                       (dontauditx getty_t console_device_t (ioctl fil=
e (range 0x3000 0x31FF)))
> >                 )
> >         )
> >
> > --
> > 2.45.2
> >
> >
