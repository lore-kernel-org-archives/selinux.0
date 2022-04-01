Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C7C433F5
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 20:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbiDAUwi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiDAUwg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 16:52:36 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC911C34B2
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 13:50:44 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-df22f50e0cso4016828fac.3
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tEuKkDQ+oOY2G+Q4y36+DDjhIa8GEsxbbzgAN16nCuQ=;
        b=a3VzgrZwXzeZpP/n0l8LQRLlukPPztKFm59/sK59hT2Jkt585KX5RFkV0gze/ZiIND
         5PnEPLpzYdhoaHzKurURWk8B9a3HCEN73kEedwnc5LhCnFvjS3udQK5QY+ZsEBiQ8IsQ
         c2rnz8WfW1Cx+7BWWw3fZNtM5/rq+6v96Xw0yUBKmZ77Bxqskc+iW4FHksCv6ZcSaHGA
         bfEqRx8ba4Z1CXDnlA99lUY1/9qDdRCL/cnEGqXP2Gy6g7+0gchg2Bjvd3urxa+wWJN8
         laPqc1k+3Tu8IpsrimZY2yk+YMJIRBdHvD73p7uRYdo34baKOwiEPW/cYx4DHMOZ1sSO
         WRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tEuKkDQ+oOY2G+Q4y36+DDjhIa8GEsxbbzgAN16nCuQ=;
        b=dhXOoyozyPR5Zek+3T5iU6OJhW07YqbazxkMRyn/VAhpuveNwpyeLJR6D1sRgx4MmS
         CQ8D9jPxILTxaY7juLuRa/O2wk0a6g9Uao5kLFajmLv7hviTcEiLx+q/baFJAgj8kK5G
         L1//C42oOq3ak+DpF092bMna8dTFknYJl4pisfqMHoaF9+epuxCoPf4v70pWbIuwBxgt
         7d8lPeCz1eOYDKmssiZuxofILtZN8q5oEIPIznTNPys9erm0RVFVBUWXXtL6zFmoN0UF
         3irb8N2Uas5lKv3J5UvhJNXt8tJ4xRJ1n+a3e2DglhiHhNp7g6QgP25qduGz7b3XHfKK
         uF2Q==
X-Gm-Message-State: AOAM532vrOb0G0fBETyCsbao2mLb3cW0oVWscyGiPLcmlug5pyAlh+aF
        YMafzzkkStOpEl6znJpUAEgcwsyzDjHCPgO1zl8=
X-Google-Smtp-Source: ABdhPJx89aKO22CCBfRzPDQmVK2lHoJCl2dXXL3kaUrO912RhEJUE/43pTsYjBvhD4W+riKcRKKaHSO+hRZ2Uap1Tak=
X-Received: by 2002:a05:6871:81e:b0:dd:9f3e:c94a with SMTP id
 q30-20020a056871081e00b000dd9f3ec94amr5830968oap.156.1648846242728; Fri, 01
 Apr 2022 13:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144752.31495-1-cgzones@googlemail.com>
In-Reply-To: <20220331144752.31495-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 16:50:31 -0400
Message-ID: <CAP+JOzRJjRfrDGD0upAfYfWr1dVhmCeZeShoKbt17CO8e-Ms6g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] libsepol/cil: declare file local functions static
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 5:57 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_binary.c      | 110 ++++++++++++++---------------
>  libsepol/cil/src/cil_build_ast.c   |  16 ++---
>  libsepol/cil/src/cil_copy_ast.c    |  46 ++++++------
>  libsepol/cil/src/cil_find.c        |   2 +-
>  libsepol/cil/src/cil_list.c        |   2 +-
>  libsepol/cil/src/cil_log.c         |   2 +-
>  libsepol/cil/src/cil_post.c        |  36 +++++-----
>  libsepol/cil/src/cil_reset_ast.c   |   2 +-
>  libsepol/cil/src/cil_resolve_ast.c |  68 +++++++++---------
>  libsepol/cil/src/cil_symtab.c      |   4 +-
>  libsepol/cil/src/cil_tree.c        |   2 +-
>  libsepol/cil/src/cil_verify.c      |  60 ++++++++--------
>  libsepol/cil/src/cil_write_ast.c   |   2 +-
>  13 files changed, 176 insertions(+), 176 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 53017e2d..7ce391e7 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -284,7 +284,7 @@ exit:
>         return rc;
>  }
>
> -int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_db *db,=
 struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_ci=
l[])
> +static int cil_classorder_to_policydb(policydb_t *pdb, const struct cil_=
db *db, struct cil_class *class_value_to_cil[], struct cil_perm **perm_valu=
e_to_cil[])
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr_class;
> @@ -396,7 +396,7 @@ exit:
>         return rc;
>  }
>
> -int cil_role_bounds_to_policydb(policydb_t *pdb, struct cil_role *cil_ro=
le)
> +static int cil_role_bounds_to_policydb(policydb_t *pdb, struct cil_role =
*cil_role)
>  {
>         int rc =3D SEPOL_ERR;
>         role_datum_t *sepol_role =3D NULL;
> @@ -479,7 +479,7 @@ exit:
>         return rc;
>  }
>
> -int cil_type_bounds_to_policydb(policydb_t *pdb, struct cil_type *cil_ty=
pe)
> +static int cil_type_bounds_to_policydb(policydb_t *pdb, struct cil_type =
*cil_type)
>  {
>         int rc =3D SEPOL_ERR;
>         type_datum_t *sepol_type =3D NULL;
> @@ -587,7 +587,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_typeattr_bitmap_init(policydb_t *pdb)
> +static int __cil_typeattr_bitmap_init(policydb_t *pdb)
>  {
>         int rc =3D SEPOL_ERR;
>         uint32_t i;
> @@ -698,7 +698,7 @@ exit:
>         return rc;
>  }
>
> -int cil_user_bounds_to_policydb(policydb_t *pdb, struct cil_user *cil_us=
er)
> +static int cil_user_bounds_to_policydb(policydb_t *pdb, struct cil_user =
*cil_user)
>  {
>         int rc =3D SEPOL_ERR;
>         user_datum_t *sepol_user =3D NULL;
> @@ -881,7 +881,7 @@ exit:
>         return rc;
>  }
>
> -int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_ali=
as)
> +static int cil_sensalias_to_policydb(policydb_t *pdb, struct cil_alias *=
cil_alias)
>  {
>         int rc =3D SEPOL_ERR;
>         char *key =3D NULL;
> @@ -919,7 +919,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_cond_insert_rule(avtab_t *avtab, avtab_key_t *avtab_key, avtab=
_datum_t *avtab_datum, cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +static int __cil_cond_insert_rule(avtab_t *avtab, avtab_key_t *avtab_key=
, avtab_datum_t *avtab_datum, cond_node_t *cond_node, enum cil_flavor cond_=
flavor)
>  {
>         int rc =3D SEPOL_OK;
>         avtab_ptr_t avtab_ptr =3D NULL;
> @@ -954,7 +954,7 @@ exit:
>         return rc;
>  }
>
> -avtab_datum_t *cil_cond_av_list_search(avtab_key_t *key, cond_av_list_t =
*cond_list)
> +static avtab_datum_t *cil_cond_av_list_search(avtab_key_t *key, cond_av_=
list_t *cond_list)
>  {
>         cond_av_list_t *cur_av;
>
> @@ -970,7 +970,7 @@ avtab_datum_t *cil_cond_av_list_search(avtab_key_t *k=
ey, cond_av_list_t *cond_li
>         return NULL;
>  }
>
> -int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32_t src,=
 uint32_t tgt, uint32_t obj, uint32_t res, struct cil_type_rule *cil_rule, =
cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +static int __cil_insert_type_rule(policydb_t *pdb, uint32_t kind, uint32=
_t src, uint32_t tgt, uint32_t obj, uint32_t res, struct cil_type_rule *cil=
_rule, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
> @@ -1063,7 +1063,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db *db, s=
truct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flavor cond=
_flavor)
> +static int __cil_type_rule_to_avtab(policydb_t *pdb, const struct cil_db=
 *db, struct cil_type_rule *cil_rule, cond_node_t *cond_node, enum cil_flav=
or cond_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         uint16_t kind =3D cil_rule->rule_kind;
> @@ -1120,7 +1120,7 @@ int cil_type_rule_to_policydb(policydb_t *pdb, cons=
t struct cil_db *db, struct c
>         return  __cil_type_rule_to_avtab(pdb, db, cil_rule, NULL, CIL_FAL=
SE);
>  }
>
> -int __cil_typetransition_to_avtab(policydb_t *pdb, const struct cil_db *=
db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node, enum =
cil_flavor cond_flavor)
> +static int __cil_typetransition_to_avtab(policydb_t *pdb, const struct c=
il_db *db, struct cil_nametypetransition *typetrans, cond_node_t *cond_node=
, enum cil_flavor cond_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         type_datum_t *sepol_src =3D NULL;
> @@ -1209,7 +1209,7 @@ int cil_typetransition_to_policydb(policydb_t *pdb,=
 const struct cil_db *db, str
>         return  __cil_typetransition_to_avtab(pdb, db, typetrans, NULL, C=
IL_FALSE);
>  }
>
> -int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_class, uint=
32_t *datum)
> +static int __perm_str_to_datum(char *perm_str, class_datum_t *sepol_clas=
s, uint32_t *datum)
>  {
>         int rc;
>         perm_datum_t *sepol_perm;
> @@ -1233,7 +1233,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *sepol_cl=
ass, uint32_t *datum)
> +static int __cil_perms_to_datum(struct cil_list *perms, class_datum_t *s=
epol_class, uint32_t *datum)
>  {
>         int rc =3D SEPOL_ERR;
>         char *key =3D NULL;
> @@ -1259,7 +1259,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t src, ui=
nt32_t tgt, uint32_t obj, uint32_t data, cond_node_t *cond_node, enum cil_f=
lavor cond_flavor)
> +static int __cil_insert_avrule(policydb_t *pdb, uint32_t kind, uint32_t =
src, uint32_t tgt, uint32_t obj, uint32_t data, cond_node_t *cond_node, enu=
m cil_flavor cond_flavor)
>  {
>         int rc =3D SEPOL_OK;
>         avtab_key_t avtab_key;
> @@ -1306,7 +1306,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, struct ci=
l_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classperms *c=
p, cond_node_t *cond_node, enum cil_flavor cond_flavor)
> +static int __cil_avrule_expand_helper(policydb_t *pdb, uint16_t kind, st=
ruct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_classp=
erms *cp, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         type_datum_t *sepol_src =3D NULL;
> @@ -1347,7 +1347,7 @@ exit:
>  }
>
>
> -int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct cil_symta=
b_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classperms, co=
nd_node_t *cond_node, enum cil_flavor cond_flavor)
> +static int __cil_avrule_expand(policydb_t *pdb, uint16_t kind, struct ci=
l_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_list *classpe=
rms, cond_node_t *cond_node, enum cil_flavor cond_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
> @@ -1402,7 +1402,7 @@ static int __cil_should_expand_attribute( const str=
uct cil_db *db, struct cil_sy
>         return !attr->keep || (ebitmap_cardinality(attr->types) < db->att=
rs_expand_size);
>  }
>
> -int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *db, stru=
ct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor cond_fla=
vor)
> +static int __cil_avrule_to_avtab(policydb_t *pdb, const struct cil_db *d=
b, struct cil_avrule *cil_avrule, cond_node_t *cond_node, enum cil_flavor c=
ond_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         uint16_t kind =3D cil_avrule->rule_kind;
> @@ -1528,7 +1528,7 @@ int cil_avrule_to_policydb(policydb_t *pdb, const s=
truct cil_db *db, struct cil_
>  #define XPERM_LOW(x) (x << 5)
>  /* high value for this u32 */
>  #define XPERM_HIGH(x) (((x + 1) << 5) - 1)
> -void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, struct avt=
ab_extended_perms *xperms)
> +static void __avrule_xperm_setrangebits(uint16_t low, uint16_t high, str=
uct avtab_extended_perms *xperms)
>  {
>         unsigned int i;
>         uint16_t h =3D high + 1;
> @@ -1553,7 +1553,7 @@ void __avrule_xperm_setrangebits(uint16_t low, uint=
16_t high, struct avtab_exten
>  #define IOC_DRIV(x) (x >> 8)
>  #define IOC_FUNC(x) (x & 0xff)
>
> -int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, struct ci=
l_list **xperms_list)
> +static int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap_t *xperms, st=
ruct cil_list **xperms_list)
>  {
>         ebitmap_node_t *node;
>         unsigned int i;
> @@ -1618,7 +1618,7 @@ int __cil_permx_bitmap_to_sepol_xperms_list(ebitmap=
_t *xperms, struct cil_list *
>         return SEPOL_OK;
>  }
>
> -int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t dat=
um, void *args)
> +static int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datu=
m_t datum, void *args)
>  {
>         int rc =3D SEPOL_OK;
>         struct policydb *pdb;
> @@ -1668,7 +1668,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, uint32_=
t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
> +static int __cil_avrulex_ioctl_to_hashtable(hashtab_t h, uint16_t kind, =
uint32_t src, uint32_t tgt, uint32_t obj, ebitmap_t *xperms)
>  {
>         uint16_t specified;
>         avtab_key_t *avtab_key;
> @@ -1725,7 +1725,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t kind, st=
ruct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil_permis=
sionx *permx, struct cil_args_binary *args)
> +static int __cil_avrulex_to_hashtable_helper(policydb_t *pdb, uint16_t k=
ind, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, struct cil=
_permissionx *permx, struct cil_args_binary *args)
>  {
>         int rc =3D SEPOL_ERR;
>         type_datum_t *sepol_src =3D NULL;
> @@ -1765,7 +1765,7 @@ exit:
>         return rc;
>  }
>
> -int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db *db, s=
truct cil_avrule *cil_avrulex, struct cil_args_binary *args)
> +static int cil_avrulex_to_hashtable(policydb_t *pdb, const struct cil_db=
 *db, struct cil_avrule *cil_avrulex, struct cil_args_binary *args)
>  {
>         int rc =3D SEPOL_ERR;
>         uint16_t kind;
> @@ -1883,7 +1883,7 @@ static int __cil_avrulex_ioctl_destroy(hashtab_key_=
t k, hashtab_datum_t datum, _
>         return SEPOL_OK;
>  }
>
> -int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribut=
e__((unused)) uint32_t *finished, void *extra_args)
> +static int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __a=
ttribute__((unused)) uint32_t *finished, void *extra_args)
>  {
>         int rc;
>         enum cil_flavor flavor;
> @@ -2174,7 +2174,7 @@ static int __cil_cond_expr_to_sepol_expr(policydb_t=
 *pdb, struct cil_list *cil_e
>         return SEPOL_OK;
>  }
>
> -int __cil_validate_cond_expr(cond_expr_t *cond_expr)
> +static int __cil_validate_cond_expr(cond_expr_t *cond_expr)
>  {
>         cond_expr_t *e;
>         int depth =3D -1;
> @@ -2454,7 +2454,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, const stru=
ct cil_db *db, struct cil_list_item *item, enum cil_flavor expr_flavor, con=
straint_expr_t *expr)
> +static int __cil_constrain_expr_datum_to_sepol_expr(policydb_t *pdb, con=
st struct cil_db *db, struct cil_list_item *item, enum cil_flavor expr_flav=
or, constraint_expr_t *expr)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -2554,7 +2554,7 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, const struc=
t cil_db *db, struct cil_list_item *op_item, enum cil_flavor expr_flavor, c=
onstraint_expr_t *expr)
> +static int __cil_constrain_expr_leaf_to_sepol_expr(policydb_t *pdb, cons=
t struct cil_db *db, struct cil_list_item *op_item, enum cil_flavor expr_fl=
avor, constraint_expr_t *expr)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *l_item =3D op_item->next;
> @@ -2649,7 +2649,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, const str=
uct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **head, =
constraint_expr_t **tail)
> +static int __cil_constrain_expr_to_sepol_expr_helper(policydb_t *pdb, co=
nst struct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t *=
*head, constraint_expr_t **tail)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *item;
> @@ -2747,7 +2747,7 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil=
_db *db, const struct cil_list *cil_expr, constraint_expr_t **sepol_expr)
> +static int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const str=
uct cil_db *db, const struct cil_list *cil_expr, constraint_expr_t **sepol_=
expr)
>  {
>         int rc;
>         constraint_expr_t *head, *tail;
> @@ -2762,7 +2762,7 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *=
pdb, const struct cil_db *db,
>         return SEPOL_OK;
>  }
>
> -int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
> +static int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
>  {
>         constraint_expr_t *e;
>         int depth =3D -1;
> @@ -2805,7 +2805,7 @@ int __cil_validate_constrain_expr(constraint_expr_t=
 *sepol_expr)
>         return SEPOL_OK;
>  }
>
> -int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_d=
b *db, struct cil_symtab_datum *class, struct cil_list *perms, struct cil_l=
ist *expr)
> +static int cil_constrain_to_policydb_helper(policydb_t *pdb, const struc=
t cil_db *db, struct cil_symtab_datum *class, struct cil_list *perms, struc=
t cil_list *expr)
>  {
>         int rc =3D SEPOL_ERR;
>         constraint_node_t *sepol_constrain =3D NULL;
> @@ -2851,7 +2851,7 @@ exit:
>         return rc;
>  }
>
> -int cil_constrain_expand(policydb_t *pdb, const struct cil_db *db, struc=
t cil_list *classperms, struct cil_list *expr)
> +static int cil_constrain_expand(policydb_t *pdb, const struct cil_db *db=
, struct cil_list *classperms, struct cil_list *expr)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
> @@ -2905,7 +2905,7 @@ exit:
>         return rc;
>  }
>
> -int cil_validatetrans_to_policydb(policydb_t *pdb, const struct cil_db *=
db, struct cil_validatetrans *cil_validatetrans)
> +static int cil_validatetrans_to_policydb(policydb_t *pdb, const struct c=
il_db *db, struct cil_validatetrans *cil_validatetrans)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list *expr =3D cil_validatetrans->datum_expr;
> @@ -2942,7 +2942,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_cats_to_mls_level(policydb_t *pdb, struct cil_cats *cats, mls_=
level_t *mls_level)
> +static int __cil_cats_to_mls_level(policydb_t *pdb, struct cil_cats *cat=
s, mls_level_t *mls_level)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *i;
> @@ -3035,7 +3035,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_levelrange_to_mls_range(policydb_t *pdb, struct cil_levelrange=
 *cil_lvlrange, mls_range_t *mls_range)
> +static int __cil_levelrange_to_mls_range(policydb_t *pdb, struct cil_lev=
elrange *cil_lvlrange, mls_range_t *mls_range)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_level *low =3D cil_lvlrange->low;
> @@ -3062,7 +3062,7 @@ exit:
>         return rc;
>  }
>
> -int cil_userlevel_userrange_to_policydb(policydb_t *pdb, struct cil_user=
 *cil_user)
> +static int cil_userlevel_userrange_to_policydb(policydb_t *pdb, struct c=
il_user *cil_user)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_level *cil_level =3D cil_user->dftlevel;
> @@ -3088,7 +3088,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_context_to_sepol_context(policydb_t *pdb, struct cil_context *=
cil_context, context_struct_t *sepol_context)
> +static int __cil_context_to_sepol_context(policydb_t *pdb, struct cil_co=
ntext *cil_context, context_struct_t *sepol_context)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_levelrange *cil_lvlrange =3D cil_context->range;
> @@ -3126,7 +3126,7 @@ exit:
>         return rc;
>  }
>
> -int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db *db)
> +static int cil_sidorder_to_policydb(policydb_t *pdb, const struct cil_db=
 *db)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *curr;
> @@ -3615,7 +3615,7 @@ exit:
>         return rc;
>  }
>
> -int cil_devicetreecon_to_policydb(policydb_t *pdb, struct cil_sort *devi=
cetreecons)
> +static int cil_devicetreecon_to_policydb(policydb_t *pdb, struct cil_sor=
t *devicetreecons)
>  {
>         int rc =3D SEPOL_ERR;
>         uint32_t i =3D 0;
> @@ -3639,7 +3639,7 @@ exit:
>         return rc;
>  }
>
> -int cil_default_to_policydb(policydb_t *pdb, struct cil_default *def)
> +static int cil_default_to_policydb(policydb_t *pdb, struct cil_default *=
def)
>  {
>         struct cil_list_item *curr;
>         class_datum_t *sepol_class;
> @@ -3694,7 +3694,7 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -int cil_defaultrange_to_policydb(policydb_t *pdb, struct cil_defaultrang=
e *def)
> +static int cil_defaultrange_to_policydb(policydb_t *pdb, struct cil_defa=
ultrange *def)
>  {
>         struct cil_list_item *curr;
>         class_datum_t *sepol_class;
> @@ -3727,7 +3727,7 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -int __cil_node_to_policydb(struct cil_tree_node *node, void *extra_args)
> +static int __cil_node_to_policydb(struct cil_tree_node *node, void *extr=
a_args)
>  {
>         int rc =3D SEPOL_OK;
>         int pass;
> @@ -3909,7 +3909,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_binary_create_helper(struct cil_tree_node *node, uint32_t *fin=
ished, void *extra_args)
> +static int __cil_binary_create_helper(struct cil_tree_node *node, uint32=
_t *finished, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -3937,7 +3937,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_db *db)
> +static int __cil_contexts_to_policydb(policydb_t *pdb, const struct cil_=
db *db)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -4007,7 +4007,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_common_val_array_insert(hashtab_key_t key, hashtab_datum_t dat=
um, void *data)
> +static int __cil_common_val_array_insert(hashtab_key_t key, hashtab_datu=
m_t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         common_datum_t *common =3D (common_datum_t *)datum;
> @@ -4020,7 +4020,7 @@ int __cil_common_val_array_insert(hashtab_key_t key=
, hashtab_datum_t datum, void
>         return 0;
>  }
>
> -int __cil_class_val_array_insert(hashtab_key_t key, hashtab_datum_t datu=
m, void *data)
> +static int __cil_class_val_array_insert(hashtab_key_t key, hashtab_datum=
_t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         class_datum_t *class =3D (class_datum_t *)datum;
> @@ -4034,7 +4034,7 @@ int __cil_class_val_array_insert(hashtab_key_t key,=
 hashtab_datum_t datum, void
>         return 0;
>  }
>
> -int __cil_role_val_array_insert(hashtab_key_t key, hashtab_datum_t datum=
, void *data)
> +static int __cil_role_val_array_insert(hashtab_key_t key, hashtab_datum_=
t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         role_datum_t *role =3D (role_datum_t *)datum;
> @@ -4048,7 +4048,7 @@ int __cil_role_val_array_insert(hashtab_key_t key, =
hashtab_datum_t datum, void *
>         return 0;
>  }
>
> -int __cil_type_val_array_insert(hashtab_key_t key, hashtab_datum_t datum=
, void *data)
> +static int __cil_type_val_array_insert(hashtab_key_t key, hashtab_datum_=
t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         type_datum_t *type =3D (type_datum_t *)datum;
> @@ -4062,7 +4062,7 @@ int __cil_type_val_array_insert(hashtab_key_t key, =
hashtab_datum_t datum, void *
>         return 0;
>  }
>
> -int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_t datum=
, void *data)
> +static int __cil_user_val_array_insert(hashtab_key_t key, hashtab_datum_=
t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         user_datum_t *user =3D (user_datum_t *)datum;
> @@ -4076,7 +4076,7 @@ int __cil_user_val_array_insert(hashtab_key_t key, =
hashtab_datum_t datum, void *
>         return 0;
>  }
>
> -int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_t datum=
, void *data)
> +static int __cil_bool_val_array_insert(hashtab_key_t key, hashtab_datum_=
t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         cond_bool_datum_t *bool =3D (cond_bool_datum_t *)datum;
> @@ -4090,7 +4090,7 @@ int __cil_bool_val_array_insert(hashtab_key_t key, =
hashtab_datum_t datum, void *
>         return 0;
>  }
>
> -int __cil_level_val_array_insert(hashtab_key_t key, hashtab_datum_t datu=
m, void *data)
> +static int __cil_level_val_array_insert(hashtab_key_t key, hashtab_datum=
_t datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         level_datum_t *level =3D (level_datum_t *)datum;
> @@ -4103,7 +4103,7 @@ int __cil_level_val_array_insert(hashtab_key_t key,=
 hashtab_datum_t datum, void
>         return 0;
>  }
>
> -int __cil_cat_val_array_insert(hashtab_key_t key, hashtab_datum_t datum,=
 void *data)
> +static int __cil_cat_val_array_insert(hashtab_key_t key, hashtab_datum_t=
 datum, void *data)
>  {
>         policydb_t *pdb =3D data;
>         cat_datum_t *cat =3D (cat_datum_t *)datum;
> @@ -4116,7 +4116,7 @@ int __cil_cat_val_array_insert(hashtab_key_t key, h=
ashtab_datum_t datum, void *d
>         return 0;
>  }
>
> -int __cil_policydb_val_arrays_create(policydb_t *policydb)
> +static int __cil_policydb_val_arrays_create(policydb_t *policydb)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -4211,7 +4211,7 @@ static void __cil_set_conditional_state_and_flags(p=
olicydb_t *pdb)
>         }
>  }
>
> -int __cil_policydb_create(const struct cil_db *db, struct sepol_policydb=
 **spdb)
> +static int __cil_policydb_create(const struct cil_db *db, struct sepol_p=
olicydb **spdb)
>  {
>         int rc;
>         struct policydb *pdb =3D NULL;
> @@ -4240,7 +4240,7 @@ exit:
>  }
>
>
> -int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db, struct=
 cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
> +static int __cil_policydb_init(policydb_t *pdb, const struct cil_db *db,=
 struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_ci=
l[])
>  {
>         int rc =3D SEPOL_ERR;
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_buil=
d_ast.c
> index 5f9392d1..26fa7906 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -56,7 +56,7 @@ struct cil_args_build {
>         struct cil_tree_node *boolif;
>  };
>
> -int cil_fill_list(struct cil_tree_node *current, enum cil_flavor flavor,=
 struct cil_list **list)
> +static int cil_fill_list(struct cil_tree_node *current, enum cil_flavor =
flavor, struct cil_list **list)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_tree_node *curr;
> @@ -176,7 +176,7 @@ exit:
>         return rc;
>  }
>
> -void cil_clear_node(struct cil_tree_node *ast_node)
> +static void cil_clear_node(struct cil_tree_node *ast_node)
>  {
>         if (ast_node =3D=3D NULL) {
>                 return;
> @@ -2141,7 +2141,7 @@ void cil_destroy_avrule(struct cil_avrule *rule)
>         free(rule);
>  }
>
> -int cil_fill_permissionx(struct cil_tree_node *parse_current, struct cil=
_permissionx *permx)
> +static int cil_fill_permissionx(struct cil_tree_node *parse_current, str=
uct cil_permissionx *permx)
>  {
>         enum cil_syntax syntax[] =3D {
>                 CIL_SYN_STRING,
> @@ -2844,7 +2844,7 @@ exit:
>         return rc;
>  }
>
> -int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flav=
or flavor, struct cil_list **expr)
> +static int cil_gen_constraint_expr(struct cil_tree_node *current, enum c=
il_flavor flavor, struct cil_list **expr)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -3583,7 +3583,7 @@ void cil_destroy_category(struct cil_cat *cat)
>         free(cat);
>  }
>
> -int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse_curren=
t, struct cil_tree_node *ast_node)
> +static int cil_gen_catset(struct cil_db *db, struct cil_tree_node *parse=
_current, struct cil_tree_node *ast_node)
>  {
>         enum cil_syntax syntax[] =3D {
>                 CIL_SYN_STRING,
> @@ -6476,7 +6476,7 @@ static struct cil_tree_node * parse_statement(struc=
t cil_db *db, struct cil_tree
>         return new_ast_node;
>  }
>
> -int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uin=
t32_t *finished, void *extra_args)
> +static int __cil_build_ast_node_helper(struct cil_tree_node *parse_curre=
nt, uint32_t *finished, void *extra_args)
>  {
>         struct cil_args_build *args =3D extra_args;
>         struct cil_tree_node *new_ast_node =3D NULL;
> @@ -6524,7 +6524,7 @@ int __cil_build_ast_node_helper(struct cil_tree_nod=
e *parse_current, uint32_t *f
>         return SEPOL_OK;
>  }
>
> -int __cil_build_ast_first_child_helper(__attribute__((unused)) struct ci=
l_tree_node *parse_current, void *extra_args)
> +static int __cil_build_ast_first_child_helper(__attribute__((unused)) st=
ruct cil_tree_node *parse_current, void *extra_args)
>  {
>         struct cil_args_build *args =3D extra_args;
>         struct cil_tree_node *ast =3D args->ast;
> @@ -6544,7 +6544,7 @@ int __cil_build_ast_first_child_helper(__attribute_=
_((unused)) struct cil_tree_n
>         return SEPOL_OK;
>  }
>
> -int __cil_build_ast_last_child_helper(struct cil_tree_node *parse_curren=
t, void *extra_args)
> +static int __cil_build_ast_last_child_helper(struct cil_tree_node *parse=
_current, void *extra_args)
>  {
>         struct cil_args_build *args =3D extra_args;
>         struct cil_tree_node *ast =3D args->ast;
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_=
ast.c
> index a4ead9db..17f05021 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -85,7 +85,7 @@ void cil_copy_list(struct cil_list *data, struct cil_li=
st **copy)
>         *copy =3D new;
>  }
>
> -int cil_copy_node(__attribute__((unused)) struct cil_db *db, void *data,=
 void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_node(__attribute__((unused)) struct cil_db *db, void=
 *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         char *new =3D NULL;
>
> @@ -151,7 +151,7 @@ int cil_copy_blockinherit(__attribute__((unused)) str=
uct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -int cil_copy_policycap(__attribute__((unused)) struct cil_db *db, void *=
data, void **copy, symtab_t *symtab)
> +static int cil_copy_policycap(__attribute__((unused)) struct cil_db *db,=
 void *data, void **copy, symtab_t *symtab)
>  {
>         struct cil_policycap *orig =3D data;
>         char *key =3D orig->datum.name;
> @@ -641,7 +641,7 @@ int cil_copy_typeattributeset(struct cil_db *db, void=
 *data, void **copy, __attr
>         return SEPOL_OK;
>  }
>
> -int cil_copy_expandtypeattribute(__attribute__((unused)) struct cil_db *=
db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_expandtypeattribute(__attribute__((unused)) struct c=
il_db *db, void *data, void **copy, __attribute__((unused)) symtab_t *symta=
b)
>  {
>         struct cil_expandtypeattribute *orig =3D data;
>         struct cil_expandtypeattribute *new =3D NULL;
> @@ -663,7 +663,7 @@ int cil_copy_expandtypeattribute(__attribute__((unuse=
d)) struct cil_db *db, void
>         return SEPOL_OK;
>  }
>
> -int cil_copy_alias(__attribute__((unused)) struct cil_db *db, void *data=
, void **copy, symtab_t *symtab)
> +static int cil_copy_alias(__attribute__((unused)) struct cil_db *db, voi=
d *data, void **copy, symtab_t *symtab)
>  {
>         struct cil_alias *orig =3D data;
>         struct cil_alias *new =3D NULL;
> @@ -683,7 +683,7 @@ int cil_copy_alias(__attribute__((unused)) struct cil=
_db *db, void *data, void *
>         return SEPOL_OK;
>  }
>
> -int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *db, void=
 *data, void **copy, __attribute__((unused))symtab_t *symtab)
> +static int cil_copy_aliasactual(__attribute__((unused)) struct cil_db *d=
b, void *data, void **copy, __attribute__((unused))symtab_t *symtab)
>  {
>         struct cil_aliasactual *orig =3D data;
>         struct cil_aliasactual *new =3D NULL;
> @@ -698,7 +698,7 @@ int cil_copy_aliasactual(__attribute__((unused)) stru=
ct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -int cil_copy_roletransition(__attribute__((unused)) struct cil_db *db, v=
oid *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_roletransition(__attribute__((unused)) struct cil_db=
 *db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_roletransition *orig =3D data;
>         struct cil_roletransition *new =3D NULL;
> @@ -777,7 +777,7 @@ int cil_copy_bool(__attribute__((unused)) struct cil_=
db *db, void *data, void **
>         return SEPOL_OK;
>  }
>
> -int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, void *da=
ta, void **copy, symtab_t *symtab)
> +static int cil_copy_tunable(__attribute__((unused)) struct cil_db *db, v=
oid *data, void **copy, symtab_t *symtab)
>  {
>         struct cil_tunable *orig =3D data;
>         struct cil_tunable *new =3D NULL;
> @@ -797,7 +797,7 @@ int cil_copy_tunable(__attribute__((unused)) struct c=
il_db *db, void *data, void
>         return SEPOL_OK;
>  }
>
> -void cil_copy_fill_permissionx(struct cil_db *db, struct cil_permissionx=
 *orig, struct cil_permissionx *new)
> +static void cil_copy_fill_permissionx(struct cil_db *db, struct cil_perm=
issionx *orig, struct cil_permissionx *new)
>  {
>         new->kind =3D orig->kind;
>         new->obj_str =3D orig->obj_str;
> @@ -832,7 +832,7 @@ int cil_copy_avrule(struct cil_db *db, void *data, vo=
id **copy, __attribute__((u
>         return SEPOL_OK;
>  }
>
> -int cil_copy_permissionx(struct cil_db *db, void *data, void **copy, sym=
tab_t *symtab)
> +static int cil_copy_permissionx(struct cil_db *db, void *data, void **co=
py, symtab_t *symtab)
>  {
>         struct cil_permissionx *orig =3D data;
>         struct cil_permissionx *new =3D NULL;
> @@ -908,7 +908,7 @@ int cil_copy_cat(__attribute__((unused)) struct cil_d=
b *db, void *data, void **c
>         return SEPOL_OK;
>  }
>
> -void cil_copy_cats(struct cil_db *db, struct cil_cats *orig, struct cil_=
cats **new)
> +static void cil_copy_cats(struct cil_db *db, struct cil_cats *orig, stru=
ct cil_cats **new)
>  {
>         cil_cats_init(new);
>         cil_copy_expr(db, orig->str_expr, &(*new)->str_expr);
> @@ -1219,7 +1219,7 @@ int cil_copy_ibpkeycon(struct cil_db *db, void *dat=
a, void **copy, __attribute__
>         return SEPOL_OK;
>  }
>
> -int cil_copy_ibendportcon(struct cil_db *db, void *data, void **copy, __=
attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_ibendportcon(struct cil_db *db, void *data, void **c=
opy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_ibendportcon *orig =3D data;
>         struct cil_ibendportcon *new =3D NULL;
> @@ -1350,7 +1350,7 @@ int cil_copy_pcidevicecon(struct cil_db *db, void *=
data, void **copy, __attribut
>         return SEPOL_OK;
>  }
>
> -int cil_copy_devicetreecon(struct cil_db *db, void *data, void **copy, _=
_attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_devicetreecon(struct cil_db *db, void *data, void **=
copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_devicetreecon *orig =3D data;
>         struct cil_devicetreecon *new =3D NULL;
> @@ -1497,7 +1497,7 @@ exit:
>         return rc;
>  }
>
> -int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data=
, void **copy, symtab_t *symtab)
> +static int cil_copy_macro(__attribute__((unused)) struct cil_db *db, voi=
d *data, void **copy, symtab_t *symtab)
>  {
>         struct cil_macro *orig =3D data;
>         char *key =3D orig->datum.name;
> @@ -1562,7 +1562,7 @@ int cil_copy_ipaddr(__attribute__((unused)) struct =
cil_db *db, void *data, void
>         return SEPOL_OK;
>  }
>
> -int cil_copy_condblock(__attribute__((unused)) struct cil_db *db, void *=
data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_condblock(__attribute__((unused)) struct cil_db *db,=
 void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_condblock *orig =3D data;
>         struct cil_condblock *new =3D *copy;
> @@ -1589,7 +1589,7 @@ int cil_copy_boolif(struct cil_db *db, void *data, =
void **copy, __attribute__((u
>         return SEPOL_OK;
>  }
>
> -int cil_copy_tunif(struct cil_db *db, void *data, void **copy, __attribu=
te__((unused)) symtab_t *symtab)
> +static int cil_copy_tunif(struct cil_db *db, void *data, void **copy, __=
attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_tunableif *orig =3D data;
>         struct cil_tunableif *new =3D NULL;
> @@ -1604,7 +1604,7 @@ int cil_copy_tunif(struct cil_db *db, void *data, v=
oid **copy, __attribute__((un
>         return SEPOL_OK;
>  }
>
> -int cil_copy_default(__attribute__((unused)) struct cil_db *db, void *da=
ta, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_default(__attribute__((unused)) struct cil_db *db, v=
oid *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_default *orig =3D data;
>         struct cil_default *new =3D NULL;
> @@ -1624,7 +1624,7 @@ int cil_copy_default(__attribute__((unused)) struct=
 cil_db *db, void *data, void
>         return SEPOL_OK;
>  }
>
> -int cil_copy_defaultrange(__attribute__((unused)) struct cil_db *db, voi=
d *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_defaultrange(__attribute__((unused)) struct cil_db *=
db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_defaultrange *orig =3D data;
>         struct cil_defaultrange *new =3D NULL;
> @@ -1642,7 +1642,7 @@ int cil_copy_defaultrange(__attribute__((unused)) s=
truct cil_db *db, void *data,
>         return SEPOL_OK;
>  }
>
> -int cil_copy_handleunknown(__attribute__((unused)) struct cil_db *db, vo=
id *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_handleunknown(__attribute__((unused)) struct cil_db =
*db, void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_handleunknown *orig =3D data;
>         struct cil_handleunknown *new =3D NULL;
> @@ -1654,7 +1654,7 @@ int cil_copy_handleunknown(__attribute__((unused)) =
struct cil_db *db, void *data
>         return SEPOL_OK;
>  }
>
> -int cil_copy_mls(__attribute__((unused)) struct cil_db *db, void *data, =
void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_mls(__attribute__((unused)) struct cil_db *db, void =
*data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_mls *orig =3D data;
>         struct cil_mls *new =3D NULL;
> @@ -1666,7 +1666,7 @@ int cil_copy_mls(__attribute__((unused)) struct cil=
_db *db, void *data, void **c
>         return SEPOL_OK;
>  }
>
> -int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, void *dat=
a, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_bounds(__attribute__((unused)) struct cil_db *db, vo=
id *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_bounds *orig =3D data;
>         struct cil_bounds *new =3D NULL;
> @@ -1681,7 +1681,7 @@ int cil_copy_bounds(__attribute__((unused)) struct =
cil_db *db, void *data, void
>         return SEPOL_OK;
>  }
>
> -int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, void *d=
ata, void **copy, __attribute__((unused)) symtab_t *symtab)
> +static int cil_copy_src_info(__attribute__((unused)) struct cil_db *db, =
void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
>  {
>         struct cil_src_info *orig =3D data;
>         struct cil_src_info *new =3D NULL;
> @@ -1697,7 +1697,7 @@ int cil_copy_src_info(__attribute__((unused)) struc=
t cil_db *db, void *data, voi
>         return SEPOL_OK;
>  }
>
> -int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finishe=
d, void *extra_args)
> +static int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *=
finished, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_tree_node *parent =3D NULL;
> @@ -2104,7 +2104,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_copy_last_child_helper(__attribute__((unused)) struct cil_tree=
_node *orig, void *extra_args)
> +static int __cil_copy_last_child_helper(__attribute__((unused)) struct c=
il_tree_node *orig, void *extra_args)
>  {
>         struct cil_tree_node *node =3D NULL;
>         struct cil_args_copy *args =3D NULL;
> diff --git a/libsepol/cil/src/cil_find.c b/libsepol/cil/src/cil_find.c
> index 3898725f..8b755277 100644
> --- a/libsepol/cil/src/cil_find.c
> +++ b/libsepol/cil/src/cil_find.c
> @@ -292,7 +292,7 @@ exit:
>         return rc;
>  }
>
> -int cil_find_matching_avrule(struct cil_tree_node *node, struct cil_avru=
le *avrule, struct cil_avrule *target, struct cil_list *matching, int match=
_self)
> +static int cil_find_matching_avrule(struct cil_tree_node *node, struct c=
il_avrule *avrule, struct cil_avrule *target, struct cil_list *matching, in=
t match_self)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_symtab_datum *s1 =3D avrule->src;
> diff --git a/libsepol/cil/src/cil_list.c b/libsepol/cil/src/cil_list.c
> index 8a426f1f..85446b4c 100644
> --- a/libsepol/cil/src/cil_list.c
> +++ b/libsepol/cil/src/cil_list.c
> @@ -35,7 +35,7 @@
>  #include "cil_log.h"
>  #include "cil_mem.h"
>
> -__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void ci=
l_list_error(const char* msg, ...)
> +__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) static =
void cil_list_error(const char* msg, ...)
>  {
>         va_list ap;
>         va_start(ap, msg);
> diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
> index e78c0aeb..e45c58fc 100644
> --- a/libsepol/cil/src/cil_log.c
> +++ b/libsepol/cil/src/cil_log.c
> @@ -37,7 +37,7 @@
>
>  static enum cil_log_level cil_log_level =3D CIL_ERR;
>
> -void cil_default_log_handler(__attribute__((unused)) int lvl, const char=
 *msg)
> +static void cil_default_log_handler(__attribute__((unused)) int lvl, con=
st char *msg)
>  {
>         fprintf(stderr, "%s", msg);
>  }
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index 09c02af9..7f33cd9e 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -366,7 +366,7 @@ int cil_post_nodecon_compare(const void *a, const voi=
d *b)
>         }
>  }
>
> -int cil_post_pirqcon_compare(const void *a, const void *b)
> +static int cil_post_pirqcon_compare(const void *a, const void *b)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_pirqcon *apirqcon =3D *(struct cil_pirqcon**)a;
> @@ -383,7 +383,7 @@ int cil_post_pirqcon_compare(const void *a, const voi=
d *b)
>         return rc;
>  }
>
> -int cil_post_iomemcon_compare(const void *a, const void *b)
> +static int cil_post_iomemcon_compare(const void *a, const void *b)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_iomemcon *aiomemcon =3D *(struct cil_iomemcon**)a;
> @@ -402,7 +402,7 @@ int cil_post_iomemcon_compare(const void *a, const vo=
id *b)
>         return rc;
>  }
>
> -int cil_post_ioportcon_compare(const void *a, const void *b)
> +static int cil_post_ioportcon_compare(const void *a, const void *b)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_ioportcon *aioportcon =3D *(struct cil_ioportcon**)a;
> @@ -421,7 +421,7 @@ int cil_post_ioportcon_compare(const void *a, const v=
oid *b)
>         return rc;
>  }
>
> -int cil_post_pcidevicecon_compare(const void *a, const void *b)
> +static int cil_post_pcidevicecon_compare(const void *a, const void *b)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_pcidevicecon *apcidevicecon =3D *(struct cil_pcidevice=
con**)a;
> @@ -438,7 +438,7 @@ int cil_post_pcidevicecon_compare(const void *a, cons=
t void *b)
>         return rc;
>  }
>
> -int cil_post_devicetreecon_compare(const void *a, const void *b)
> +static int cil_post_devicetreecon_compare(const void *a, const void *b)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_devicetreecon *adevicetreecon =3D *(struct cil_devicet=
reecon**)a;
> @@ -466,35 +466,35 @@ int cil_post_fsuse_compare(const void *a, const voi=
d *b)
>         return rc;
>  }
>
> -int cil_post_filecon_context_compare(const void *a, const void *b)
> +static int cil_post_filecon_context_compare(const void *a, const void *b=
)
>  {
>         struct cil_filecon *a_filecon =3D *(struct cil_filecon**)a;
>         struct cil_filecon *b_filecon =3D *(struct cil_filecon**)b;
>         return context_compare(a_filecon->context, b_filecon->context);
>  }
>
> -int cil_post_ibpkeycon_context_compare(const void *a, const void *b)
> +static int cil_post_ibpkeycon_context_compare(const void *a, const void =
*b)
>  {
>         struct cil_ibpkeycon *a_ibpkeycon =3D *(struct cil_ibpkeycon **)a=
;
>         struct cil_ibpkeycon *b_ibpkeycon =3D *(struct cil_ibpkeycon **)b=
;
>         return context_compare(a_ibpkeycon->context, b_ibpkeycon->context=
);
>  }
>
> -int cil_post_portcon_context_compare(const void *a, const void *b)
> +static int cil_post_portcon_context_compare(const void *a, const void *b=
)
>  {
>         struct cil_portcon *a_portcon =3D *(struct cil_portcon**)a;
>         struct cil_portcon *b_portcon =3D *(struct cil_portcon**)b;
>         return context_compare(a_portcon->context, b_portcon->context);
>  }
>
> -int cil_post_genfscon_context_compare(const void *a, const void *b)
> +static int cil_post_genfscon_context_compare(const void *a, const void *=
b)
>  {
>         struct cil_genfscon *a_genfscon =3D *(struct cil_genfscon**)a;
>         struct cil_genfscon *b_genfscon =3D *(struct cil_genfscon**)b;
>         return context_compare(a_genfscon->context, b_genfscon->context);
>  }
>
> -int cil_post_netifcon_context_compare(const void *a, const void *b)
> +static int cil_post_netifcon_context_compare(const void *a, const void *=
b)
>  {
>         int rc;
>         struct cil_netifcon *a_netifcon =3D *(struct cil_netifcon**)a;
> @@ -506,56 +506,56 @@ int cil_post_netifcon_context_compare(const void *a=
, const void *b)
>         return context_compare(a_netifcon->packet_context, b_netifcon->pa=
cket_context);
>  }
>
> -int cil_post_ibendportcon_context_compare(const void *a, const void *b)
> +static int cil_post_ibendportcon_context_compare(const void *a, const vo=
id *b)
>  {
>         struct cil_ibendportcon *a_ibendportcon =3D *(struct cil_ibendpor=
tcon **)a;
>         struct cil_ibendportcon *b_ibendportcon =3D *(struct cil_ibendpor=
tcon **)b;
>         return context_compare(a_ibendportcon->context, b_ibendportcon->c=
ontext);
>  }
>
> -int cil_post_nodecon_context_compare(const void *a, const void *b)
> +static int cil_post_nodecon_context_compare(const void *a, const void *b=
)
>  {
>         struct cil_nodecon *a_nodecon =3D *(struct cil_nodecon **)a;
>         struct cil_nodecon *b_nodecon =3D *(struct cil_nodecon **)b;
>         return context_compare(a_nodecon->context, b_nodecon->context);
>  }
>
> -int cil_post_pirqcon_context_compare(const void *a, const void *b)
> +static int cil_post_pirqcon_context_compare(const void *a, const void *b=
)
>  {
>         struct cil_pirqcon *a_pirqcon =3D *(struct cil_pirqcon**)a;
>         struct cil_pirqcon *b_pirqcon =3D *(struct cil_pirqcon**)b;
>         return context_compare(a_pirqcon->context, b_pirqcon->context);
>  }
>
> -int cil_post_iomemcon_context_compare(const void *a, const void *b)
> +static int cil_post_iomemcon_context_compare(const void *a, const void *=
b)
>  {
>         struct cil_iomemcon *a_iomemcon =3D *(struct cil_iomemcon**)a;
>         struct cil_iomemcon *b_iomemcon =3D *(struct cil_iomemcon**)b;
>         return context_compare(a_iomemcon->context, b_iomemcon->context);
>  }
>
> -int cil_post_ioportcon_context_compare(const void *a, const void *b)
> +static int cil_post_ioportcon_context_compare(const void *a, const void =
*b)
>  {
>         struct cil_ioportcon *a_ioportcon =3D *(struct cil_ioportcon**)a;
>         struct cil_ioportcon *b_ioportcon =3D *(struct cil_ioportcon**)b;
>         return context_compare(a_ioportcon->context, b_ioportcon->context=
);
>  }
>
> -int cil_post_pcidevicecon_context_compare(const void *a, const void *b)
> +static int cil_post_pcidevicecon_context_compare(const void *a, const vo=
id *b)
>  {
>         struct cil_pcidevicecon *a_pcidevicecon =3D *(struct cil_pcidevic=
econ**)a;
>         struct cil_pcidevicecon *b_pcidevicecon =3D *(struct cil_pcidevic=
econ**)b;
>         return context_compare(a_pcidevicecon->context, b_pcidevicecon->c=
ontext);
>  }
>
> -int cil_post_devicetreecon_context_compare(const void *a, const void *b)
> +static int cil_post_devicetreecon_context_compare(const void *a, const v=
oid *b)
>  {
>         struct cil_devicetreecon *a_devicetreecon =3D *(struct cil_device=
treecon**)a;
>         struct cil_devicetreecon *b_devicetreecon =3D *(struct cil_device=
treecon**)b;
>         return context_compare(a_devicetreecon->context, b_devicetreecon-=
>context);
>  }
>
> -int cil_post_fsuse_context_compare(const void *a, const void *b)
> +static int cil_post_fsuse_context_compare(const void *a, const void *b)
>  {
>         struct cil_fsuse *a_fsuse =3D *(struct cil_fsuse**)a;
>         struct cil_fsuse *b_fsuse =3D *(struct cil_fsuse**)b;
> diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_rese=
t_ast.c
> index 0ba075c8..0864d7ef 100644
> --- a/libsepol/cil/src/cil_reset_ast.c
> +++ b/libsepol/cil/src/cil_reset_ast.c
> @@ -475,7 +475,7 @@ static void cil_reset_booleanif(struct cil_booleanif =
*bif)
>         cil_list_destroy(&bif->datum_expr, CIL_FALSE);
>  }
>
> -int __cil_reset_node(struct cil_tree_node *node,  __attribute__((unused)=
) uint32_t *finished, __attribute__((unused)) void *extra_args)
> +static int __cil_reset_node(struct cil_tree_node *node,  __attribute__((=
unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
>  {
>         switch (node->flavor) {
>         case CIL_CLASS:
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_re=
solve_ast.c
> index 69a8a2ed..7823eb94 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -191,7 +191,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_classperms_set(struct cil_tree_node *current, struct cil=
_classperms_set *cp_set, void *extra_args)
> +static int cil_resolve_classperms_set(struct cil_tree_node *current, str=
uct cil_classperms_set *cp_set, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_symtab_datum *datum =3D NULL;
> @@ -275,7 +275,7 @@ exit:
>         return rc;
>  }
>
> -void cil_type_used(struct cil_symtab_datum *datum, int used)
> +static void cil_type_used(struct cil_symtab_datum *datum, int used)
>  {
>         struct cil_typeattribute *attr =3D NULL;
>
> @@ -292,7 +292,7 @@ void cil_type_used(struct cil_symtab_datum *datum, in=
t used)
>         }
>  }
>
> -int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_pe=
rmissionx *permx, void *extra_args)
> +static int cil_resolve_permissionx(struct cil_tree_node *current, struct=
 cil_permissionx *permx, void *extra_args)
>  {
>         struct cil_symtab_datum *obj_datum =3D NULL;
>         int rc =3D SEPOL_ERR;
> @@ -459,7 +459,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void =
*extra_args)
> +static int cil_resolve_expandtypeattribute(struct cil_tree_node *current=
, void *extra_args)
>  {
>         struct cil_expandtypeattribute *expandattr =3D current->data;
>         struct cil_symtab_datum *attr_datum =3D NULL;
> @@ -493,7 +493,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_aliasactual(struct cil_tree_node *current, void *extra_a=
rgs, enum cil_flavor flavor, enum cil_flavor alias_flavor)
> +static int cil_resolve_aliasactual(struct cil_tree_node *current, void *=
extra_args, enum cil_flavor flavor, enum cil_flavor alias_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         enum cil_sym_index sym_index;
> @@ -544,7 +544,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_alias_to_actual(struct cil_tree_node *current, enum cil_=
flavor flavor)
> +static int cil_resolve_alias_to_actual(struct cil_tree_node *current, en=
um cil_flavor flavor)
>  {
>         struct cil_alias *alias =3D current->data;
>         struct cil_alias *a1 =3D current->data;
> @@ -733,7 +733,7 @@ exit:
>         return rc;
>  }
>
> -int __class_update_perm_values(__attribute__((unused)) hashtab_key_t k, =
hashtab_datum_t d, void *args)
> +static int __class_update_perm_values(__attribute__((unused)) hashtab_ke=
y_t k, hashtab_datum_t d, void *args)
>  {
>         struct cil_perm *perm =3D (struct cil_perm *)d;
>
> @@ -1178,7 +1178,7 @@ struct cil_ordered_list {
>         struct cil_tree_node *node;
>  };
>
> -void __cil_ordered_list_init(struct cil_ordered_list **ordered)
> +static void __cil_ordered_list_init(struct cil_ordered_list **ordered)
>  {
>         *ordered =3D cil_malloc(sizeof(**ordered));
>
> @@ -1187,7 +1187,7 @@ void __cil_ordered_list_init(struct cil_ordered_lis=
t **ordered)
>         (*ordered)->node =3D NULL;
>  }
>
> -void __cil_ordered_list_destroy(struct cil_ordered_list **ordered)
> +static void __cil_ordered_list_destroy(struct cil_ordered_list **ordered=
)
>  {
>         cil_list_destroy(&(*ordered)->list, CIL_FALSE);
>         (*ordered)->node =3D NULL;
> @@ -1195,7 +1195,7 @@ void __cil_ordered_list_destroy(struct cil_ordered_=
list **ordered)
>         *ordered =3D NULL;
>  }
>
> -void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
> +static void __cil_ordered_lists_destroy(struct cil_list **ordered_lists)
>  {
>         struct cil_list_item *item =3D NULL;
>
> @@ -1215,13 +1215,13 @@ void __cil_ordered_lists_destroy(struct cil_list =
**ordered_lists)
>         *ordered_lists =3D NULL;
>  }
>
> -void __cil_ordered_lists_reset(struct cil_list **ordered_lists)
> +static void __cil_ordered_lists_reset(struct cil_list **ordered_lists)
>  {
>         __cil_ordered_lists_destroy(ordered_lists);
>         cil_list_init(ordered_lists, CIL_LIST_ITEM);
>  }
>
> -struct cil_list_item *__cil_ordered_item_insert(struct cil_list *old, st=
ruct cil_list_item *curr, struct cil_list_item *item)
> +static struct cil_list_item *__cil_ordered_item_insert(struct cil_list *=
old, struct cil_list_item *curr, struct cil_list_item *item)
>  {
>         if (item->flavor =3D=3D CIL_SID) {
>                 struct cil_sid *sid =3D item->data;
> @@ -1256,7 +1256,7 @@ struct cil_list_item *__cil_ordered_item_insert(str=
uct cil_list *old, struct cil
>         return cil_list_insert(old, curr, item->flavor, item->data);
>  }
>
> -int __cil_ordered_list_insert(struct cil_list *old, struct cil_list_item=
 *ocurr, struct cil_list_item *nstart, struct cil_list_item *nstop)
> +static int __cil_ordered_list_insert(struct cil_list *old, struct cil_li=
st_item *ocurr, struct cil_list_item *nstart, struct cil_list_item *nstop)
>  {
>         struct cil_list_item *ncurr =3D NULL;
>
> @@ -1269,7 +1269,7 @@ int __cil_ordered_list_insert(struct cil_list *old,=
 struct cil_list_item *ocurr,
>         return SEPOL_OK;
>  }
>
> -struct cil_list_item *__cil_ordered_find_match(struct cil_list_item *t, =
struct cil_list_item *i)
> +static struct cil_list_item *__cil_ordered_find_match(struct cil_list_it=
em *t, struct cil_list_item *i)
>  {
>         while (i) {
>                 if (i->data =3D=3D t->data) {
> @@ -1280,7 +1280,7 @@ struct cil_list_item *__cil_ordered_find_match(stru=
ct cil_list_item *t, struct c
>         return NULL;
>  }
>
> -int __cil_ordered_lists_merge(struct cil_list *old, struct cil_list *new=
)
> +static int __cil_ordered_lists_merge(struct cil_list *old, struct cil_li=
st *new)
>  {
>         struct cil_list_item *omatch =3D NULL;
>         struct cil_list_item *ofirst =3D old->head;
> @@ -1409,7 +1409,7 @@ exit:
>         return rc;
>  }
>
> -struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **ordered=
_lists, struct cil_list **unordered_lists)
> +static struct cil_list *__cil_ordered_lists_merge_all(struct cil_list **=
ordered_lists, struct cil_list **unordered_lists)
>  {
>         struct cil_list *composite =3D NULL;
>         struct cil_list_item *curr =3D NULL;
> @@ -1556,7 +1556,7 @@ exit:
>         return rc;
>  }
>
> -void cil_set_cat_values(struct cil_list *ordered_cats, struct cil_db *db=
)
> +static void cil_set_cat_values(struct cil_list *ordered_cats, struct cil=
_db *db)
>  {
>         struct cil_list_item *curr;
>         int v =3D 0;
> @@ -1652,7 +1652,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_cats(struct cil_tree_node *current, struct cil_cats *cat=
s, void *extra_args)
> +static int cil_resolve_cats(struct cil_tree_node *current, struct cil_ca=
ts *cats, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -2224,7 +2224,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_devicetreecon(struct cil_tree_node *current, void *extra=
_args)
> +static int cil_resolve_devicetreecon(struct cil_tree_node *current, void=
 *extra_args)
>  {
>         struct cil_devicetreecon *devicetreecon =3D current->data;
>         struct cil_symtab_datum *context_datum =3D NULL;
> @@ -2316,7 +2316,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *e=
xtra_args)
> +static int cil_resolve_blockinherit_link(struct cil_tree_node *current, =
void *extra_args)
>  {
>         struct cil_blockinherit *inherit =3D current->data;
>         struct cil_symtab_datum *block_datum =3D NULL;
> @@ -2349,7 +2349,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_blockinherit_copy(struct cil_tree_node *current, void *e=
xtra_args)
> +static int cil_resolve_blockinherit_copy(struct cil_tree_node *current, =
void *extra_args)
>  {
>         struct cil_block *block =3D current->data;
>         struct cil_args_resolve *args =3D extra_args;
> @@ -2398,7 +2398,7 @@ static void cil_mark_subtree_abstract(struct cil_tr=
ee_node *node)
>         }
>  }
>
> -int cil_resolve_blockabstract(struct cil_tree_node *current, void *extra=
_args)
> +static int cil_resolve_blockabstract(struct cil_tree_node *current, void=
 *extra_args)
>  {
>         struct cil_blockabstract *abstract =3D current->data;
>         struct cil_symtab_datum *block_datum =3D NULL;
> @@ -2469,7 +2469,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
> +static int cil_resolve_in_list(struct cil_list *in_list, void *extra_arg=
s)
>  {
>         struct cil_list_item *curr =3D NULL;
>         struct cil_tree_node *node =3D NULL;
> @@ -2523,7 +2523,7 @@ exit:
>  }
>
>
> -int cil_resolve_bounds(struct cil_tree_node *current, void *extra_args, =
enum cil_flavor flavor, enum cil_flavor attr_flavor)
> +static int cil_resolve_bounds(struct cil_tree_node *current, void *extra=
_args, enum cil_flavor flavor, enum cil_flavor attr_flavor)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_bounds *bounds =3D current->data;
> @@ -2605,7 +2605,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_default(struct cil_tree_node *current, void *extra_args)
> +static int cil_resolve_default(struct cil_tree_node *current, void *extr=
a_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_default *def =3D current->data;
> @@ -2628,7 +2628,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_defaultrange(struct cil_tree_node *current, void *extra_=
args)
> +static int cil_resolve_defaultrange(struct cil_tree_node *current, void =
*extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_defaultrange *def =3D current->data;
> @@ -2651,7 +2651,7 @@ exit:
>         return rc;
>  }
>
> -void cil_print_recursive_call(struct cil_tree_node *call_node, struct ci=
l_tree_node *terminating_node)
> +static void cil_print_recursive_call(struct cil_tree_node *call_node, st=
ruct cil_tree_node *terminating_node)
>  {
>         struct cil_list *trace =3D NULL;
>         struct cil_list_item * item =3D NULL;
> @@ -2686,7 +2686,7 @@ void cil_print_recursive_call(struct cil_tree_node =
*call_node, struct cil_tree_n
>         cil_list_destroy(&trace, CIL_FALSE);
>  }
>
> -int cil_check_recursive_call(struct cil_tree_node *call_node, struct cil=
_tree_node *macro_node)
> +static int cil_check_recursive_call(struct cil_tree_node *call_node, str=
uct cil_tree_node *macro_node)
>  {
>         struct cil_tree_node *curr =3D NULL;
>         struct cil_call * call =3D NULL;
> @@ -3022,7 +3022,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
> +static int cil_resolve_call(struct cil_tree_node *current, void *extra_a=
rgs)
>  {
>         struct cil_call *call =3D current->data;
>         struct cil_args_resolve *args =3D extra_args;
> @@ -3072,7 +3072,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_call_args(struct cil_tree_node *current, void *extra_arg=
s)
> +static int cil_resolve_call_args(struct cil_tree_node *current, void *ex=
tra_args)
>  {
>         struct cil_call *call =3D current->data;
>         int rc =3D SEPOL_ERR;
> @@ -3603,7 +3603,7 @@ static int cil_check_for_bad_inheritance(struct cil=
_tree_node *node)
>         return rc;
>  }
>
> -int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
> +static int __cil_resolve_ast_node(struct cil_tree_node *node, void *extr=
a_args)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_args_resolve *args =3D extra_args;
> @@ -3893,7 +3893,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *=
finished, void *extra_args)
> +static int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uin=
t32_t *finished, void *extra_args)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_args_resolve *args =3D extra_args;
> @@ -4000,7 +4000,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_resolve_ast_first_child_helper(struct cil_tree_node *current, =
void *extra_args)
> +static int __cil_resolve_ast_first_child_helper(struct cil_tree_node *cu=
rrent, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_args_resolve *args =3D extra_args;
> @@ -4029,7 +4029,7 @@ exit:
>
>  }
>
> -int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, v=
oid *extra_args)
> +static int __cil_resolve_ast_last_child_helper(struct cil_tree_node *cur=
rent, void *extra_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_args_resolve *args =3D extra_args;
> diff --git a/libsepol/cil/src/cil_symtab.c b/libsepol/cil/src/cil_symtab.=
c
> index c1951560..7e43a690 100644
> --- a/libsepol/cil/src/cil_symtab.c
> +++ b/libsepol/cil/src/cil_symtab.c
> @@ -42,7 +42,7 @@
>  #include "cil_strpool.h"
>  #include "cil_log.h"
>
> -__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void ci=
l_symtab_error(const char* msg, ...)
> +__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) static =
void cil_symtab_error(const char* msg, ...)
>  {
>         va_list ap;
>         va_start(ap, msg);
> @@ -149,7 +149,7 @@ void cil_symtab_destroy(symtab_t *symtab)
>         }
>  }
>
> -void cil_complex_symtab_hash(struct cil_complex_symtab_key *ckey, int ma=
sk, intptr_t *hash)
> +static void cil_complex_symtab_hash(struct cil_complex_symtab_key *ckey,=
 int mask, intptr_t *hash)
>  {
>         intptr_t sum =3D ckey->key1 + ckey->key2 + ckey->key3 + ckey->key=
4;
>         *hash =3D (intptr_t)((sum >> 2) & mask);
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index aafc9dee..525b60d4 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -273,7 +273,7 @@ void cil_tree_node_destroy(struct cil_tree_node **nod=
e)
>     extra_args:               any additional data to be passed to the hel=
per functions
>  */
>
> -int cil_tree_walk_core(struct cil_tree_node *node,
> +static int cil_tree_walk_core(struct cil_tree_node *node,
>                                            int (*process_node)(struct cil=
_tree_node *node, uint32_t *finished, void *extra_args),
>                                            int (*first_child)(struct cil_=
tree_node *node, void *extra_args),
>                                            int (*last_child)(struct cil_t=
ree_node *node, void *extra_args),
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.=
c
> index d994d717..aecbdc19 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -591,7 +591,7 @@ int __cil_verify_initsids(struct cil_list *sids)
>         return rc;
>  }
>
> -int __cil_is_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
> +static int __cil_is_cat_in_cats(struct cil_cat *cat, struct cil_cats *ca=
ts)
>  {
>         struct cil_list_item *i;
>
> @@ -606,7 +606,7 @@ int __cil_is_cat_in_cats(struct cil_cat *cat, struct =
cil_cats *cats)
>  }
>
>
> -int __cil_verify_cat_in_cats(struct cil_cat *cat, struct cil_cats *cats)
> +static int __cil_verify_cat_in_cats(struct cil_cat *cat, struct cil_cats=
 *cats)
>  {
>         if (__cil_is_cat_in_cats(cat, cats) !=3D CIL_TRUE) {
>                 cil_log(CIL_ERR, "Failed to find category %s in category =
list\n", cat->datum.name);
> @@ -616,7 +616,7 @@ int __cil_verify_cat_in_cats(struct cil_cat *cat, str=
uct cil_cats *cats)
>         return SEPOL_OK;
>  }
>
> -int __cil_verify_cats_associated_with_sens(struct cil_sens *sens, struct=
 cil_cats *cats)
> +static int __cil_verify_cats_associated_with_sens(struct cil_sens *sens,=
 struct cil_cats *cats)
>  {
>         int rc =3D SEPOL_OK;
>         struct cil_list_item *i, *j;
> @@ -650,7 +650,7 @@ int __cil_verify_cats_associated_with_sens(struct cil=
_sens *sens, struct cil_cat
>         return rc;
>  }
>
> -int __cil_verify_levelrange_sensitivity(struct cil_db *db, struct cil_se=
ns *low, struct cil_sens *high)
> +static int __cil_verify_levelrange_sensitivity(struct cil_db *db, struct=
 cil_sens *low, struct cil_sens *high)
>  {
>         struct cil_list_item *curr;
>         int found =3D CIL_FALSE;
> @@ -679,7 +679,7 @@ exit:
>
>  }
>
> -int __cil_verify_levelrange_cats(struct cil_cats *low, struct cil_cats *=
high)
> +static int __cil_verify_levelrange_cats(struct cil_cats *low, struct cil=
_cats *high)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_list_item *item;
> @@ -707,7 +707,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_levelrange(struct cil_db *db, struct cil_levelrange *lr=
)
> +static int __cil_verify_levelrange(struct cil_db *db, struct cil_levelra=
nge *lr)
>  {
>         int rc =3D SEPOL_ERR;
>
> @@ -739,7 +739,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_named_levelrange(struct cil_db *db, struct cil_tree_nod=
e *node)
> +static int __cil_verify_named_levelrange(struct cil_db *db, struct cil_t=
ree_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_levelrange *lr =3D node->data;
> @@ -814,7 +814,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_role(struct cil_tree_node *node)
> +static int __cil_verify_role(struct cil_tree_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_role *role =3D node->data;
> @@ -845,7 +845,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_type(struct cil_tree_node *node)
> +static int __cil_verify_type(struct cil_tree_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_type *type =3D node->data;
> @@ -876,7 +876,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
> +static int __cil_verify_context(struct cil_db *db, struct cil_context *c=
tx)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_user *user =3D ctx->user;
> @@ -954,7 +954,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_named_context(struct cil_db *db, struct cil_tree_node *=
node)
> +static int __cil_verify_named_context(struct cil_db *db, struct cil_tree=
_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_context *ctx =3D node->data;
> @@ -1017,7 +1017,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribut=
e__((unused)) uint32_t *finished, __attribute__((unused)) void *extra_args)
> +static int __cil_verify_booleanif_helper(struct cil_tree_node *node, __a=
ttribute__((unused)) uint32_t *finished, __attribute__((unused)) void *extr=
a_args)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_tree_node *rule_node =3D node;
> @@ -1105,7 +1105,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_booleanif(struct cil_tree_node *node, struct cil_comple=
x_symtab *symtab)
> +static int __cil_verify_booleanif(struct cil_tree_node *node, struct cil=
_complex_symtab *symtab)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_booleanif *bif =3D (struct cil_booleanif*)node->data;
> @@ -1129,7 +1129,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_netifcon(struct cil_db *db, struct cil_tree_node=
 *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_netifcon *netif =3D node->data;
> @@ -1159,7 +1159,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_ibendportcon(struct cil_db *db, struct cil_tree_node *n=
ode)
> +static int __cil_verify_ibendportcon(struct cil_db *db, struct cil_tree_=
node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_ibendportcon *ib_end_port =3D node->data;
> @@ -1179,7 +1179,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node=
 *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_genfscon *genfs =3D node->data;
> @@ -1200,7 +1200,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_filecon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_filecon(struct cil_db *db, struct cil_tree_node =
*node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_filecon *file =3D node->data;
> @@ -1226,7 +1226,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_nodecon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_nodecon(struct cil_db *db, struct cil_tree_node =
*node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_nodecon *nodecon =3D node->data;
> @@ -1247,7 +1247,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_ibpkeycon(struct cil_db *db, struct cil_tree_node *node=
)
> +static int __cil_verify_ibpkeycon(struct cil_db *db, struct cil_tree_nod=
e *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_ibpkeycon *pkey =3D node->data;
> @@ -1267,7 +1267,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_portcon(struct cil_db *db, struct cil_tree_node =
*node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_portcon *port =3D node->data;
> @@ -1288,7 +1288,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_pirqcon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_pirqcon(struct cil_db *db, struct cil_tree_node =
*node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_pirqcon *pirq =3D node->data;
> @@ -1309,7 +1309,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_iomemcon(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_iomemcon(struct cil_db *db, struct cil_tree_node=
 *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_iomemcon *iomem =3D node->data;
> @@ -1330,7 +1330,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_ioportcon(struct cil_db *db, struct cil_tree_node *node=
)
> +static int __cil_verify_ioportcon(struct cil_db *db, struct cil_tree_nod=
e *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_ioportcon *ioport =3D node->data;
> @@ -1351,7 +1351,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_pcidevicecon(struct cil_db *db, struct cil_tree_node *n=
ode)
> +static int __cil_verify_pcidevicecon(struct cil_db *db, struct cil_tree_=
node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_pcidevicecon *pcidev =3D node->data;
> @@ -1372,7 +1372,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree_node *=
node)
> +static int __cil_verify_devicetreecon(struct cil_db *db, struct cil_tree=
_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_devicetreecon *dt =3D node->data;
> @@ -1393,7 +1393,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *node)
> +static int __cil_verify_fsuse(struct cil_db *db, struct cil_tree_node *n=
ode)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_fsuse *fsuse =3D node->data;
> @@ -1414,7 +1414,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_permissionx(struct cil_permissionx *permx, struct cil_t=
ree_node *node)
> +static int __cil_verify_permissionx(struct cil_permissionx *permx, struc=
t cil_tree_node *node)
>  {
>         int rc;
>         struct cil_list *classes =3D NULL;
> @@ -1461,13 +1461,13 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_avrulex(struct cil_tree_node *node)
> +static int __cil_verify_avrulex(struct cil_tree_node *node)
>  {
>         struct cil_avrule *avrulex =3D node->data;
>         return __cil_verify_permissionx(avrulex->perms.x.permx, node);
>  }
>
> -int __cil_verify_class(struct cil_tree_node *node)
> +static int __cil_verify_class(struct cil_tree_node *node)
>  {
>         int rc =3D SEPOL_ERR;
>         struct cil_class *class =3D node->data;
> @@ -1503,7 +1503,7 @@ exit:
>         return rc;
>  }
>
> -int __cil_verify_policycap(struct cil_tree_node *node)
> +static int __cil_verify_policycap(struct cil_tree_node *node)
>  {
>         int rc;
>         struct cil_policycap *polcap =3D node->data;
> diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_writ=
e_ast.c
> index bebb2670..b75784ef 100644
> --- a/libsepol/cil/src/cil_write_ast.c
> +++ b/libsepol/cil/src/cil_write_ast.c
> @@ -546,7 +546,7 @@ static const char *macro_param_flavor_to_string(enum =
cil_flavor flavor)
>         return str;
>  }
>
> -void cil_write_src_info_node(FILE *out, struct cil_tree_node *node)
> +static void cil_write_src_info_node(FILE *out, struct cil_tree_node *nod=
e)
>  {
>         struct cil_src_info *info =3D node->data;
>         if (info->kind =3D=3D CIL_KEY_SRC_CIL || info->kind =3D=3D CIL_KE=
Y_SRC_HLL_LMS) {
> --
> 2.35.1
>
