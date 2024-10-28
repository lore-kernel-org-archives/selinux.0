Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4B55E73
	for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128630; cv=none; b=cUnERbjTEo8/K7E7vJJdh91UlN10rMNIuuPhCU1pXgcN9AoApbtFXbtlm8Bj659G1OT7RH3U78QBlBjnyzd6lLrg2Lrr9JUBHR84mHIdl7OlGsFzd+jYgzLEbWeJNnqswGJlILS9AZPvvLqrGaqwEcZUgdKgMCCUvy1vYxpOkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128630; c=relaxed/simple;
	bh=px5Hjt50vfENAfb0MpXuufB+M5U7yfHTww/XCy7eopc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5zjcZnkHTx5RKWQksTIeEgZiy57fqHSbBRNmKeo6LVqyxgec3eHycdy3D9bK+FK+5/jhmQQ/NddjcxxUlm/Zt0Zb7w06S41NpribLvMog/G8iTKtqk3aZC7ZqsUAHZoGrdA5O6lpTSjERhMbVYQQKeOfafTrOBBn7IIViQkams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc+VcIeF; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc+VcIeF"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e600add5dcso1986326b6e.2
        for <selinux@vger.kernel.org>; Mon, 28 Oct 2024 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730128626; x=1730733426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcupJj3n9j/OSxcVmIs5o+ZGooQsAexcWvpeDPl2s+I=;
        b=Lc+VcIeFhBqPAJiJE4TGtRwpGJAH9bCENm1wTrqV+BMNv1uLVOsyLR9wEU+FgNea15
         YPPjKjAg5sA3zpRGFWt+GfWY7Tpu80ZbWITym0ULtl2OdmKqzRIYub4TdDDpTe4A6ukr
         GE/w7ZxZVZAl+EK1y7W4d93IuD3zSuyJF9GSrGhG0iGpJSFYHvk1Ciyfjs76wHkaeB8I
         OPQQo49EopZkpuHaC37sdvCL0H6zhzuLyraB4z+ZIr0kN7msdlkZLcuUX65f9osZF0DU
         22I6eA6HJD/1thJPOaP3/B9omnJGslrH5lUZPwCmTYhUrFxKaT+keHpb5yknCdKmznXa
         LOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128626; x=1730733426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcupJj3n9j/OSxcVmIs5o+ZGooQsAexcWvpeDPl2s+I=;
        b=HYuUD/kdi8Iih92pgNOaGM2GnfrbQnmLddE1zwoi9N1fgK3HGfIdqJaJ5ikUhIBXo1
         qS7FB4SopD6octT8nzScWODXB6voof2szLaUwDV8PsC76XRh4a9QIV0QIWjTLCFERKYK
         bu7M0QmWPNEyVzqOjSTsX12zURJYWVWYeWh+q08Oy1seXvdbz9eN0xdR6ba2FSBAxK68
         6sh7LyVJJGsvhFowKQhRPvX6ep1zkHCJimjqRyvQYnqkH6LY0R8KSbNqcN5siN5bkAkV
         ay7esP5jpUb49yUUWJYLoL4TqJBR01b1m182bVRC4Rok32zND9zyDfYRz0p3q+zDoMg1
         rpog==
X-Gm-Message-State: AOJu0Yw1+Sy1ZAddIDEpErgoUHNeDxUyR8xlTqCdG1hxXO9tmpzix+oW
	rh1H1O1xLTzPRHM8FF9BfDK83EG/OAjiWsGPChmxX/u2B4bI6+8SvqvTYPjm5OZKAt8EA4XwP/l
	kOpL0d9h3BGhvQJRX163W1zuYyMo=
X-Google-Smtp-Source: AGHT+IEy8kgEqWWOeUpyFc27Turdh3OuOAYAFr0Ij2e1ANfKlLsYXc7NFdZRbgDBsv/1zVV0Wdm2qZvPzXL7Q/GVTfc=
X-Received: by 2002:a05:6808:1b14:b0:3e0:5d46:473a with SMTP id
 5614622812f47-3e6384575e6mr6274376b6e.17.1730128626250; Mon, 28 Oct 2024
 08:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025154824.140073-1-cgoettsche@seltendoof.de> <20241025154824.140073-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241025154824.140073-4-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 28 Oct 2024 11:16:54 -0400
Message-ID: <CAP+JOzSg_uXbw+R_m+NMKFXARZyC7giQ=tYPjaRfF+eSOM5Cow@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] libsepol/cil: add support for xperms in
 conditional policies
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 12:12=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Testing reveals a couple of issues handling assertions in CIL that
works as expected in checkpolicy.

(type tp21)
(boolean bb02 true)
(booleanif bb02
  (true
    (allow tp21 tpx (clx (ioctl)))
    (allowx tp21 tpx (ioctl clx (0x1101)))
  )
)
(neverallowx tp21 tpx (ioctl clx (0x4101)))
This neverallowx should is not a violation, but is reported as one.

(type tp51)
(boolean bb05 true)
(allow tp51 tpx (clx (ioctl)))
(booleanif bb05
  (true
    (allowx tp51 tpx (ioctl clx (0x1101)))
  )
  (false
    (allowx tp51 tpx (ioctl clx (0x1101)))
  )
)
(neverallowx tp51 tpx (ioctl clx (0x4101)))
Same for this neverallowx. It is not a violation, but is reported as one.

CIL does most of its checking using libsepol, so I am not sure what
the problem is.

Thanks,
Jim


> ---
>  libsepol/cil/src/cil_binary.c      | 153 +++++++++++++++++++++++++----
>  libsepol/cil/src/cil_build_ast.c   |   6 +-
>  libsepol/cil/src/cil_resolve_ast.c |   6 +-
>  libsepol/cil/src/cil_verify.c      |   3 +-
>  secilc/test/policy.cil             |  13 ++-
>  5 files changed, 153 insertions(+), 28 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 3dec1883..086dccb0 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -59,14 +59,18 @@
>  #define AVRULEX_TABLE_SIZE (1 <<  10)
>  #define PERMS_PER_CLASS 32
>
> +struct cil_args_xperm_tables {
> +       hashtab_t ioctl;
> +       hashtab_t nlmsg;
> +};
> +
>  struct cil_args_binary {
>         const struct cil_db *db;
>         policydb_t *pdb;
>         struct cil_list *neverallows;
>         int pass;
>         hashtab_t role_trans_table;
> -       hashtab_t avrulex_ioctl_table;
> -       hashtab_t avrulex_nlmsg_table;
> +       struct cil_args_xperm_tables avrulex_xperm_tables;
>         void **type_value_to_cil;
>  };
>
> @@ -75,8 +79,14 @@ struct cil_args_booleanif {
>         policydb_t *pdb;
>         cond_node_t *cond_node;
>         enum cil_flavor cond_flavor;
> +       struct cil_args_xperm_tables avrulex_xperm_tables;
>  };
>
> +static unsigned int avrulex_hash(__attribute__((unused)) hashtab_t h, co=
nst_hashtab_key_t key);
> +static int avrulex_compare(hashtab_t h
> +             __attribute__ ((unused)), const_hashtab_key_t key1,
> +                                     const_hashtab_key_t key2);
> +
>  static int __cil_get_sepol_user_datum(policydb_t *pdb, struct cil_symtab=
_datum *datum, user_datum_t **sepol_user)
>  {
>         *sepol_user =3D hashtab_search(pdb->p_users.table, datum->fqn);
> @@ -1762,7 +1772,10 @@ static int __cil_permx_bitmap_to_sepol_xperms_list=
(uint32_t kind, ebitmap_t *xpe
>  static int __cil_avrulex_xperm_to_policydb(hashtab_key_t k, hashtab_datu=
m_t datum, uint32_t xperm_kind, void *args)
>  {
>         int rc =3D SEPOL_OK;
> -       struct policydb *pdb;
> +       struct cil_args_booleanif *booleanif_args =3D args;
> +       struct policydb *pdb =3D booleanif_args->pdb;
> +       cond_node_t *cond_node =3D booleanif_args->cond_node;
> +       enum cil_flavor cond_flavor =3D booleanif_args->cond_flavor;
>         avtab_key_t *avtab_key;
>         avtab_datum_t avtab_datum;
>         struct cil_list *xperms_list =3D NULL;
> @@ -1772,7 +1785,6 @@ static int __cil_avrulex_xperm_to_policydb(hashtab_=
key_t k, hashtab_datum_t datu
>         char *kind =3D NULL;
>
>         avtab_key =3D (avtab_key_t *)k;
> -       pdb =3D args;
>
>         sepol_obj =3D pdb->class_val_to_struct[avtab_key->target_class - =
1];
>
> @@ -1793,7 +1805,12 @@ static int __cil_avrulex_xperm_to_policydb(hashtab=
_key_t k, hashtab_datum_t datu
>
>         cil_list_for_each(item, xperms_list) {
>                 avtab_datum.xperms =3D item->data;
> -               rc =3D avtab_insert(&pdb->te_avtab, avtab_key, &avtab_dat=
um);
> +
> +               if (cond_node) {
> +                       rc =3D __cil_cond_insert_rule(&pdb->te_cond_avtab=
, avtab_key, &avtab_datum, cond_node, cond_flavor);
> +               } else {
> +                       rc =3D avtab_insert(&pdb->te_avtab, avtab_key, &a=
vtab_datum);
> +               }
>                 if (rc !=3D SEPOL_OK) {
>                         goto exit;
>                 }
> @@ -1876,7 +1893,7 @@ exit:
>         return rc;
>  }
>
> -static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t k=
ind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil=
_permissionx *permx, struct cil_args_binary *args)
> +static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t k=
ind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil=
_permissionx *permx, struct cil_args_xperm_tables *xt)
>  {
>         int rc =3D SEPOL_ERR;
>         type_datum_t *sepol_src =3D NULL;
> @@ -1899,11 +1916,11 @@ static int __cil_avrulex_to_hashtable_helper(poli=
cydb_t *pdb, uint16_t kind, str
>
>                 switch (permx->kind) {
>                 case  CIL_PERMX_KIND_IOCTL:
> -                       rc =3D __cil_avrulex_xperm_to_hashtable(args->avr=
ulex_ioctl_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->=
s.value, permx->perms);
> +                       rc =3D __cil_avrulex_xperm_to_hashtable(xt->ioctl=
, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->=
perms);
>                         if (rc !=3D SEPOL_OK) goto exit;
>                         break;
>                 case  CIL_PERMX_KIND_NLMSG:
> -                       rc =3D __cil_avrulex_xperm_to_hashtable(args->avr=
ulex_nlmsg_table, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->=
s.value, permx->perms);
> +                       rc =3D __cil_avrulex_xperm_to_hashtable(xt->nlmsg=
, kind, sepol_src->s.value, sepol_tgt->s.value, sepol_obj->s.value, permx->=
perms);
>                         if (rc !=3D SEPOL_OK) goto exit;
>                         break;
>                 default:
> @@ -1920,7 +1937,7 @@ exit:
>         return rc;
>  }
>
> -static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db=
 *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
> +static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db=
 *db, struct cil_avrule *cil_avrulex, struct cil_args_xperm_tables *xt)
>  {
>         int rc =3D SEPOL_ERR;
>         uint16_t kind;
> @@ -1946,7 +1963,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>
>                 ebitmap_for_each_positive_bit(&src_bitmap, snode, s) {
>                         src =3D DATUM(db->val_to_type[s]);
> -                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, kin=
d, src, src, cil_avrulex->perms.x.permx, args);
> +                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, kin=
d, src, src, cil_avrulex->perms.x.permx, xt);
>                         if (rc !=3D SEPOL_OK) {
>                                 ebitmap_destroy(&src_bitmap);
>                                 goto exit;
> @@ -1964,7 +1981,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                         for (t =3D 0; t < (unsigned int)db->num_types; t+=
+) {
>                                 if (s !=3D t) {
>                                         tgt =3D DATUM(db->val_to_type[t])=
;
> -                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> +                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
>                                         if (rc !=3D SEPOL_OK) {
>                                                 ebitmap_destroy(&src_bitm=
ap);
>                                                 goto exit;
> @@ -1984,7 +2001,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                         ebitmap_for_each_positive_bit(&src_bitmap, tnode,=
 t) {
>                                 if (s !=3D t) {
>                                         tgt =3D DATUM(db->val_to_type[t])=
;
> -                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> +                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
>                                         if (rc !=3D SEPOL_OK) {
>                                                 ebitmap_destroy(&src_bitm=
ap);
>                                                 goto exit;
> @@ -1998,7 +2015,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                 int expand_tgt =3D __cil_should_expand_attribute(db, tgt)=
;
>
>                 if (!expand_src && !expand_tgt) {
> -                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, kin=
d, src, tgt, cil_avrulex->perms.x.permx, args);
> +                       rc =3D __cil_avrulex_to_hashtable_helper(pdb, kin=
d, src, tgt, cil_avrulex->perms.x.permx, xt);
>                         if (rc !=3D SEPOL_OK) {
>                                 goto exit;
>                         }
> @@ -2019,7 +2036,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                                 ebitmap_for_each_positive_bit(&tgt_bitmap=
, tnode, t) {
>                                         tgt =3D DATUM(db->val_to_type[t])=
;
>
> -                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> +                                       rc =3D __cil_avrulex_to_hashtable=
_helper(pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
>                                         if (rc !=3D SEPOL_OK) {
>                                                 ebitmap_destroy(&src_bitm=
ap);
>                                                 ebitmap_destroy(&tgt_bitm=
ap);
> @@ -2038,7 +2055,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                         ebitmap_for_each_positive_bit(&src_bitmap, snode,=
 s) {
>                                 src =3D DATUM(db->val_to_type[s]);
>
> -                               rc =3D __cil_avrulex_to_hashtable_helper(=
pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> +                               rc =3D __cil_avrulex_to_hashtable_helper(=
pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
>                                 if (rc !=3D SEPOL_OK) {
>                                         ebitmap_destroy(&src_bitmap);
>                                         goto exit;
> @@ -2054,7 +2071,7 @@ static int cil_avrulex_to_hashtable(policydb_t *pdb=
, const struct cil_db *db, st
>                         ebitmap_for_each_positive_bit(&tgt_bitmap, tnode,=
 t) {
>                                 tgt =3D DATUM(db->val_to_type[t]);
>
> -                               rc =3D __cil_avrulex_to_hashtable_helper(=
pdb, kind, src, tgt, cil_avrulex->perms.x.permx, args);
> +                               rc =3D __cil_avrulex_to_hashtable_helper(=
pdb, kind, src, tgt, cil_avrulex->perms.x.permx, xt);
>                                 if (rc !=3D SEPOL_OK) {
>                                         ebitmap_destroy(&tgt_bitmap);
>                                         goto exit;
> @@ -2123,6 +2140,21 @@ static int __cil_cond_to_policydb_helper(struct ci=
l_tree_node *node, __attribute
>                         goto exit;
>                 }
>                 break;
> +       case CIL_AVRULEX:
> +               if (db->policy_version < POLICYDB_VERSION_COND_XPERMS) {
> +                       cil_tree_log(node, CIL_ERR, "Extended permission =
rules are not supported in policy version %d\n",
> +                                    db->policy_version);
> +                       rc =3D SEPOL_ERR;
> +                       goto exit;
> +               }
> +               cil_avrule =3D node->data;
> +               rc =3D cil_avrulex_to_hashtable(pdb, db, cil_avrule, &arg=
s->avrulex_xperm_tables);
> +               if (rc !=3D SEPOL_OK) {
> +                       cil_tree_log(node, CIL_ERR, "Failed to insert avr=
ulex into avtab");
> +                       goto exit;
> +               }
> +               break;
> +
>         case CIL_CALL:
>         case CIL_TUNABLEIF:
>                 break;
> @@ -2429,6 +2461,8 @@ int cil_booleanif_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db, struct c
>         int was_created;
>         int swapped =3D CIL_FALSE;
>         cond_av_list_t tmp_cl;
> +       hashtab_t avrulex_ioctl_table =3D NULL;
> +       hashtab_t avrulex_nlmsg_table =3D NULL;
>
>         tmp_cond =3D cond_node_create(pdb, NULL);
>         if (tmp_cond =3D=3D NULL) {
> @@ -2497,26 +2531,97 @@ int cil_booleanif_to_policydb(policydb_t *pdb, co=
nst struct cil_db *db, struct c
>         bool_args.cond_node =3D cond_node;
>
>         if (true_node !=3D NULL) {
> +               avrulex_ioctl_table =3D hashtab_create(avrulex_hash, avru=
lex_compare, AVRULEX_TABLE_SIZE);
> +               if (!avrulex_ioctl_table) {
> +                       cil_log(CIL_INFO, "Failure to create hashtab for =
avrulex\n");
> +                       goto exit;
> +               }
> +
> +               avrulex_nlmsg_table =3D hashtab_create(avrulex_hash, avru=
lex_compare, AVRULEX_TABLE_SIZE);
> +               if (!avrulex_nlmsg_table) {
> +                       cil_log(CIL_INFO, "Failure to create hashtab for =
avrulex\n");
> +                       goto exit;
> +               }
> +
>                 bool_args.cond_flavor =3D CIL_CONDTRUE;
> +               bool_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_ta=
ble;
> +               bool_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_ta=
ble;
>                 rc =3D cil_tree_walk(true_node, __cil_cond_to_policydb_he=
lper, NULL, NULL, &bool_args);
>                 if (rc !=3D SEPOL_OK) {
>                         cil_tree_log(true_node, CIL_ERR, "Failure while w=
alking true conditional block");
>                         goto exit;
>                 }
> +
> +               rc =3D hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioc=
tl_to_policydb, &bool_args);
> +               if (rc !=3D SEPOL_OK) {
> +                       cil_log(CIL_INFO, "Failure creating avrulex rules=
\n");
> +                       goto exit;
> +               }
> +
> +               rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avrulex_nlm=
sg_to_policydb, &bool_args);
> +               if (rc !=3D SEPOL_OK) {
> +                       cil_log(CIL_INFO, "Failure creating avrulex rules=
\n");
> +                       goto exit;
> +               }
> +
> +               hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_dest=
roy, NULL);
> +               hashtab_destroy(avrulex_nlmsg_table);
> +               avrulex_nlmsg_table =3D NULL;
> +
> +               hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_dest=
roy, NULL);
> +               hashtab_destroy(avrulex_ioctl_table);
> +               avrulex_ioctl_table =3D NULL;
>         }
>
>         if (false_node !=3D NULL) {
> +               avrulex_ioctl_table =3D hashtab_create(avrulex_hash, avru=
lex_compare, AVRULEX_TABLE_SIZE);
> +               if (!avrulex_ioctl_table) {
> +                       cil_log(CIL_INFO, "Failure to create hashtab for =
avrulex\n");
> +                       goto exit;
> +               }
> +
> +               avrulex_nlmsg_table =3D hashtab_create(avrulex_hash, avru=
lex_compare, AVRULEX_TABLE_SIZE);
> +               if (!avrulex_nlmsg_table) {
> +                       cil_log(CIL_INFO, "Failure to create hashtab for =
avrulex\n");
> +                       goto exit;
> +               }
> +
>                 bool_args.cond_flavor =3D CIL_CONDFALSE;
> +               bool_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_ta=
ble;
> +               bool_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_ta=
ble;
>                 rc =3D cil_tree_walk(false_node, __cil_cond_to_policydb_h=
elper, NULL, NULL, &bool_args);
>                 if (rc !=3D SEPOL_OK) {
>                         cil_tree_log(false_node, CIL_ERR, "Failure while =
walking false conditional block");
>                         goto exit;
>                 }
> +
> +               rc =3D hashtab_map(avrulex_ioctl_table, __cil_avrulex_ioc=
tl_to_policydb, &bool_args);
> +               if (rc !=3D SEPOL_OK) {
> +                       cil_log(CIL_INFO, "Failure creating avrulex rules=
\n");
> +                       goto exit;
> +               }
> +
> +               rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avrulex_nlm=
sg_to_policydb, &bool_args);
> +               if (rc !=3D SEPOL_OK) {
> +                       cil_log(CIL_INFO, "Failure creating avrulex rules=
\n");
> +                       goto exit;
> +               }
> +
> +               hashtab_map(avrulex_nlmsg_table, __cil_avrulex_xperm_dest=
roy, NULL);
> +               hashtab_destroy(avrulex_nlmsg_table);
> +               avrulex_nlmsg_table =3D NULL;
> +
> +
> +               hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_dest=
roy, NULL);
> +               hashtab_destroy(avrulex_ioctl_table);
> +               avrulex_ioctl_table =3D NULL;
>         }
>
>         return SEPOL_OK;
>
>  exit:
> +       hashtab_map(avrulex_ioctl_table, __cil_avrulex_xperm_destroy, NUL=
L);
> +       hashtab_destroy(avrulex_ioctl_table);
>         if (tmp_cond) {
>                 if (tmp_cond->expr)
>                         cond_expr_destroy(tmp_cond->expr);
> @@ -4091,7 +4196,7 @@ static int __cil_node_to_policydb(struct cil_tree_n=
ode *node, void *extra_args)
>                 case CIL_AVRULEX: {
>                                 struct cil_avrule *rule =3D node->data;
>                                 if (rule->rule_kind !=3D CIL_AVRULE_NEVER=
ALLOW) {
> -                                       rc =3D cil_avrulex_to_hashtable(p=
db, db, node->data, args);
> +                                       rc =3D cil_avrulex_to_hashtable(p=
db, db, node->data, &args->avrulex_xperm_tables);
>                                 }
>                         }
>                         break;
> @@ -5162,6 +5267,7 @@ int cil_binary_create_allocated_pdb(const struct ci=
l_db *db, sepol_policydb_t *p
>         int rc =3D SEPOL_ERR;
>         int i;
>         struct cil_args_binary extra_args;
> +       struct cil_args_booleanif booleanif_args;
>         policydb_t *pdb =3D &policydb->p;
>         struct cil_list *neverallows =3D NULL;
>         hashtab_t role_trans_table =3D NULL;
> @@ -5226,10 +5332,15 @@ int cil_binary_create_allocated_pdb(const struct =
cil_db *db, sepol_policydb_t *p
>         extra_args.pdb =3D pdb;
>         extra_args.neverallows =3D neverallows;
>         extra_args.role_trans_table =3D role_trans_table;
> -       extra_args.avrulex_ioctl_table =3D avrulex_ioctl_table;
> -       extra_args.avrulex_nlmsg_table =3D avrulex_nlmsg_table;
> +       extra_args.avrulex_xperm_tables.ioctl =3D avrulex_ioctl_table;
> +       extra_args.avrulex_xperm_tables.nlmsg =3D avrulex_nlmsg_table;
>         extra_args.type_value_to_cil =3D type_value_to_cil;
>
> +       booleanif_args.db =3D db;
> +       booleanif_args.pdb =3D pdb;
> +       booleanif_args.cond_node =3D NULL;
> +       booleanif_args.cond_flavor =3D CIL_NONE;
> +
>         for (i =3D 1; i <=3D 3; i++) {
>                 extra_args.pass =3D i;
>
> @@ -5248,12 +5359,12 @@ int cil_binary_create_allocated_pdb(const struct =
cil_db *db, sepol_policydb_t *p
>                 }
>
>                 if (i =3D=3D 3) {
> -                       rc =3D hashtab_map(avrulex_ioctl_table, __cil_avr=
ulex_ioctl_to_policydb, pdb);
> +                       rc =3D hashtab_map(avrulex_ioctl_table, __cil_avr=
ulex_ioctl_to_policydb, &booleanif_args);
>                         if (rc !=3D SEPOL_OK) {
>                                 cil_log(CIL_INFO, "Failure creating avrul=
ex rules\n");
>                                 goto exit;
>                         }
> -                       rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avr=
ulex_nlmsg_to_policydb, pdb);
> +                       rc =3D hashtab_map(avrulex_nlmsg_table, __cil_avr=
ulex_nlmsg_to_policydb, &booleanif_args);
>                         if (rc !=3D SEPOL_OK) {
>                                 cil_log(CIL_INFO, "Failure creating avrul=
ex rules\n");
>                                 goto exit;
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 19fbb04e..8cc3f9b2 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -6158,7 +6158,11 @@ static int check_for_illegal_statement(struct cil_=
tree_node *parse_current, stru
>                         parse_current->data !=3D CIL_KEY_AUDITALLOW &&
>                         parse_current->data !=3D CIL_KEY_TYPETRANSITION &=
&
>                         parse_current->data !=3D CIL_KEY_TYPECHANGE &&
> -                       parse_current->data !=3D CIL_KEY_TYPEMEMBER) {
> +                       parse_current->data !=3D CIL_KEY_TYPEMEMBER &&
> +                       ((args->db->policy_version < POLICYDB_VERSION_CON=
D_XPERMS) ||
> +                         (parse_current->data !=3D CIL_KEY_ALLOWX &&
> +                          parse_current->data !=3D CIL_KEY_DONTAUDITX &&
> +                          parse_current->data !=3D CIL_KEY_AUDITALLOWX))=
) {
>                         if (((struct cil_booleanif*)args->boolif->data)->=
preserved_tunable) {
>                                 cil_tree_log(parse_current, CIL_ERR, "%s =
is not allowed in tunableif being treated as a booleanif", (char *)parse_cu=
rrent->data);
>                         } else {
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index da8863c4..a8fa89df 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3848,9 +3848,11 @@ static int __cil_resolve_ast_node_helper(struct ci=
l_tree_node *node, uint32_t *f
>                         node->flavor !=3D CIL_CONDBLOCK &&
>                         node->flavor !=3D CIL_AVRULE &&
>                         node->flavor !=3D CIL_TYPE_RULE &&
> -                       node->flavor !=3D CIL_NAMETYPETRANSITION) {
> +                       node->flavor !=3D CIL_NAMETYPETRANSITION &&
> +                       ((args->db->policy_version < POLICYDB_VERSION_CON=
D_XPERMS) ||
> +                        (node->flavor !=3D CIL_AVRULEX))) {
>                         rc =3D SEPOL_ERR;
> -               } else if (node->flavor =3D=3D CIL_AVRULE) {
> +               } else if (node->flavor =3D=3D CIL_AVRULE || node->flavor=
 =3D=3D CIL_AVRULEX) {
>                         struct cil_avrule *rule =3D node->data;
>                         if (rule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW)=
 {
>                                 rc =3D SEPOL_ERR;
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index 9621a247..550b4542 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -1101,7 +1101,8 @@ static int __cil_verify_booleanif_helper(struct cil=
_tree_node *node, __attribute
>         struct cil_booleanif *bif =3D node->parent->parent->data;
>
>         switch (rule_node->flavor) {
> -       case CIL_AVRULE: {
> +       case CIL_AVRULE:
> +       case CIL_AVRULEX: {
>                 struct cil_avrule *avrule =3D NULL;
>                 avrule =3D rule_node->data;
>                 if (avrule->rule_kind =3D=3D CIL_AVRULE_NEVERALLOW) {
> diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
> index e6b78618..d0d52d0d 100644
> --- a/secilc/test/policy.cil
> +++ b/secilc/test/policy.cil
> @@ -47,8 +47,9 @@
>
>  (block policy
>         (class file (execute_no_trans entrypoint execmod open audit_acces=
s a b c d e))
> -       ; order should be: file char b c a dir d e f
> -       (classorder (file char))
> +       (class socket (nlmsg))
> +       ; order should be: file socket char b c a dir d e f
> +       (classorder (file socket char))
>         (classorder (unordered dir))
>         (classorder (unordered c a b d e f))
>         (classorder (char b c a))
> @@ -161,7 +162,10 @@
>         ;;(allow bad_t not_bad_type (file (execute)))
>         ;;(allow bad_t exec_t (file (execute)))
>         (neverallow bad_t not_bad_type (file (execute)))
> -
> +
> +       (auditallowx getty_t console_device_t (ioctl file (range 0x1000 0=
x10FF)))
> +       (auditallowx getty_t kernel_t (nlmsg socket (range 0x1000 0x10FF)=
))
> +
>         (booleanif secure_mode
>                 (true
>                         (auditallow device_t exec_t (file (read write)))
> @@ -172,9 +176,12 @@
>                 (true
>                         (typechange auditadm_t console_device_t file user=
_tty_device_t)
>                         (allow getty_t console_device_t (file (getattr op=
en read write append)))
> +                       (auditallowx getty_t console_device_t (ioctl file=
 (range 0x2000 0x21FF)))
> +                       (auditallowx getty_t kernel_t (nlmsg socket (0x1)=
))
>                 )
>                 (false
>                         (dontaudit getty_t console_device_t (file (getatt=
r open read write append)))
> +                       (dontauditx getty_t console_device_t (ioctl file =
(range 0x3000 0x31FF)))
>                 )
>         )
>
> --
> 2.45.2
>
>
