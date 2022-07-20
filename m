Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8291CC43334
	for <selinux@archiver.kernel.org>; Wed, 20 Jul 2022 22:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiGTW3P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTW3P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jul 2022 18:29:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC94B422DA
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 15:29:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id w204so4267592oie.7
        for <selinux@vger.kernel.org>; Wed, 20 Jul 2022 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8e7nOOFnsMhY5tgTls8qRFItxatUOXcg09PMOTU5BU=;
        b=CrOjJQ/4+yUhAFnsnqI1nZE2jItuG4Ilh7eoq/4lSnrZqSRbXJ+IOQUjMczaFuJg2K
         VHJ0le22InxMBAQ5gCNQQIdvJ7k2ElqTapYR91W11LFntgRKGiPpz73+kpSCpeA85kRN
         IOjxXnbSyMgXaOQEd2javN3JZFWHUzKLiHVo52diuAwBvlQOMOI72/hbpDlbpLq4M13F
         AvdIRM3BbNqHQtCYWOCqb9hGOYRkJLD/ucvdmOphY49kXbJcW5CE5tZJQE37GIE4SHif
         j0V/TmiXkPaC4GaRYee8KTk5NMlIUbZ6tnJD4wdFX+oOMnMxFEGViDwW6m75anUjcES4
         U6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8e7nOOFnsMhY5tgTls8qRFItxatUOXcg09PMOTU5BU=;
        b=WqorICUJzeNTu/fYmrBi483poCYtwFRZ9cZTsqP8j/SOIPJY/yEQDCohZiEhrok6D5
         pUHZOOuNM5mVSe6w04ueI7v6eYdk+RWYbHV1p1JpSNF83UGwolXAOPHbarhP30JgE9xy
         8W+764DsWy4Ty5UXDjIDAD/FGLMnkbaDXROYF/6hvcDcfcJr97GvbmP5EBdehjfAYC7K
         Ykktn6AwLVButtL9OlmloRMDGBN6S2vS339/g5yi/L8j+fBYztwKoDAUOy8SLEPuD/ny
         dz6VpODcTYhJKTzHcOWLpt2XL4wLiF9MhStF5i7Q0ml0rRHypHuIc9KLTUkGzVNlJSKn
         JIxg==
X-Gm-Message-State: AJIora97Vixv+3Ap243Sn33LARY/h2unN/DReE0qyVss2l+gnEaMfSpX
        Q3AYrnLpTv4zwKQ8fCprX2hCnFij5mOuHDuRa6Jke9Ekxl0=
X-Google-Smtp-Source: AGRyM1v66/E1r3XY5mcwYvbxu8MHWXtTH9OobDcBobZIgwTxui41+5J7i1mMpXeYrM3jAkAQ7yIUpIHtKFXFRJNL/mc=
X-Received: by 2002:a54:4788:0:b0:33a:6311:a734 with SMTP id
 o8-20020a544788000000b0033a6311a734mr3450226oic.156.1658356152082; Wed, 20
 Jul 2022 15:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220713141148.35524-1-cgzones@googlemail.com> <20220713141148.35524-5-cgzones@googlemail.com>
In-Reply-To: <20220713141148.35524-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Jul 2022 18:29:01 -0400
Message-ID: <CAP+JOzQc4-DcyyVa5ctQE3YYm-3XR+_uYXPQJeXFzAwPH2oB-w@mail.gmail.com>
Subject: Re: [PATCH 5/5] libsepol: more strict validation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 13, 2022 at 10:13 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Validate that
>
>   - each constraint has at least one expression
>   - classes reference a valid common class identifier
>   - the role flavor is either ROLE or ATTRIB
>   - types reference a valid primary identifier
>   - types refer to a raw type, not an attribute, as bounds
>   - extended permissions in avtabs have a valid specifier
>   - type av rules refer to a raw type (e.g. type_transition)
>   - conditionals have at least one expression
>   - the state and flags of conditionals are valid
>   - filename transitions have at least one datum
>   - low ports are not bigger than high ones in port ocontexts
>   - genfs declarations refer to a valid class identifier
>   - genfs declarations contains a filesystem name
>   - filename transitions refer to a raw type
>   - permissive types are raw ones
>   - the range transition hashmap is valid
>   - the type-attribute-maps are valid
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/policydb_validate.c | 257 +++++++++++++++++++++++++------
>  1 file changed, 207 insertions(+), 50 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 0f399771..4fd8768b 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -48,6 +48,8 @@ static int validate_init(validate_t *flavor, char **val=
_to_name, uint32_t nprim)
>
>  static int validate_array_init(const policydb_t *p, validate_t flavors[]=
)
>  {
> +       if (validate_init(&flavors[SYM_COMMONS], p->p_common_val_to_name,=
 p->p_commons.nprim))
> +               goto bad;
>         if (validate_init(&flavors[SYM_CLASSES], p->p_class_val_to_name, =
p->p_classes.nprim))
>                 goto bad;
>         if (validate_init(&flavors[SYM_ROLES], p->p_role_val_to_name, p->=
p_roles.nprim))
> @@ -235,6 +237,9 @@ static int validate_constraint_nodes(sepol_handle_t *=
handle, unsigned int nperms
>                 if (nperms > 0 && nperms !=3D PERM_SYMTAB_SIZE && cons->p=
ermissions >=3D (UINT32_C(1) << nperms))
>                         goto bad;
>
> +               if (!cons->expr)
> +                       goto bad;
> +
>                 for (cexp =3D cons->expr; cexp; cexp =3D cexp->next) {
>                         if (cexp->expr_type =3D=3D CEXPR_NAMES) {
>                                 if (cexp->attr & CEXPR_XTARGET && nperms =
!=3D 0)
> @@ -339,10 +344,33 @@ bad:
>         return -1;
>  }
>
> +static int validate_common_datum(sepol_handle_t *handle, const common_da=
tum_t *common, validate_t flavors[])
> +{
> +       if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
> +               goto bad;
> +       if (common->permissions.nprim > PERM_SYMTAB_SIZE)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid common class datum");
> +       return -1;
> +}
> +
> +static int validate_common_datum_wrapper(__attribute__((unused)) hashtab=
_key_t k, hashtab_datum_t d, void *args)
> +{
> +       map_arg_t *margs =3D args;
> +
> +       return validate_common_datum(margs->handle, d, margs->flavors);
> +}
> +
>  static int validate_class_datum(sepol_handle_t *handle, const class_datu=
m_t *class, validate_t flavors[])
>  {
>         if (validate_value(class->s.value, &flavors[SYM_CLASSES]))
>                 goto bad;
> +       if (class->comdatum && validate_common_datum(handle, class->comda=
tum, flavors))
> +               goto bad;
>         if (class->permissions.nprim > PERM_SYMTAB_SIZE)
>                 goto bad;
>         if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->constraints, flavors))
> @@ -405,25 +433,6 @@ static int validate_class_datum_wrapper(__attribute_=
_((unused)) hashtab_key_t k,
>         return validate_class_datum(margs->handle, d, margs->flavors);
>  }
>
> -static int validate_common_datum(sepol_handle_t *handle, const common_da=
tum_t *common)
> -{
> -       if (common->permissions.nprim > PERM_SYMTAB_SIZE)
> -               goto bad;
> -
> -       return 0;
> -
> -bad:
> -       ERR(handle, "Invalid common class datum");
> -       return -1;
> -}
> -
> -static int validate_common_datum_wrapper(__attribute__((unused)) hashtab=
_key_t k, hashtab_datum_t d, void *args)
> -{
> -       map_arg_t *margs =3D args;
> -
> -       return validate_common_datum(margs->handle, d);
> -}
> -
>  static int validate_role_datum(sepol_handle_t *handle, const role_datum_=
t *role, validate_t flavors[])
>  {
>         if (validate_value(role->s.value, &flavors[SYM_ROLES]))
> @@ -437,6 +446,14 @@ static int validate_role_datum(sepol_handle_t *handl=
e, const role_datum_t *role,
>         if (validate_ebitmap(&role->roles, &flavors[SYM_ROLES]))
>                 goto bad;
>
> +       switch(role->flavor) {
> +       case ROLE_ROLE:
> +       case ROLE_ATTRIB:
> +               break;
> +       default:
> +               goto bad;
> +       }
> +
>         return 0;
>
>  bad:
> @@ -451,19 +468,46 @@ static int validate_role_datum_wrapper(__attribute_=
_((unused)) hashtab_key_t k,
>         return validate_role_datum(margs->handle, d, margs->flavors);
>  }
>
> -static int validate_type_datum(sepol_handle_t *handle, const type_datum_=
t *type, validate_t flavors[])
> +static int validate_simpletype(uint32_t value, const policydb_t *p, vali=
date_t flavors[])
>  {
> -       if (validate_value(type->s.value, &flavors[SYM_TYPES]))
> +       const type_datum_t *type;
> +
> +       if (validate_value(value, &flavors[SYM_TYPES]))
> +               goto bad;
> +
> +       type =3D p->type_val_to_struct[value - 1];
> +       if (!type)
>                 goto bad;
> -       if (validate_ebitmap(&type->types, &flavors[SYM_TYPES]))
> +
> +       if (type->flavor =3D=3D TYPE_ATTRIB)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       return -1;
> +}
> +
> +static int validate_type_datum(sepol_handle_t *handle, const type_datum_=
t *type, const policydb_t *p, validate_t flavors[])
> +{
> +       if (validate_value(type->s.value, &flavors[SYM_TYPES]))
>                 goto bad;
> -       if (type->bounds && validate_value(type->bounds, &flavors[SYM_TYP=
ES]))
> +       if (type->primary && validate_value(type->primary, &flavors[SYM_T=
YPES]))
>                 goto bad;
>
>         switch (type->flavor) {
>         case TYPE_TYPE:
> -       case TYPE_ATTRIB:
>         case TYPE_ALIAS:
> +               if (!ebitmap_is_empty(&type->types))
> +                       goto bad;
> +               if (type->bounds && validate_simpletype(type->bounds, p, =
flavors))
> +                       goto bad;
> +               break;
> +       case TYPE_ATTRIB:
> +               if (validate_ebitmap(&type->types, &flavors[SYM_TYPES]))
> +                       goto bad;
> +               if (type->bounds)
> +                       goto bad;
>                 break;
>         default:
>                 goto bad;
> @@ -491,7 +535,7 @@ static int validate_type_datum_wrapper(__attribute__(=
(unused)) hashtab_key_t k,
>  {
>         map_arg_t *margs =3D args;
>
> -       return validate_type_datum(margs->handle, d, margs->flavors);
> +       return validate_type_datum(margs->handle, d, margs->policy, margs=
->flavors);
>  }
>
>  static int validate_mls_semantic_cat(const mls_semantic_cat_t *cat, cons=
t validate_t *cats)
> @@ -758,22 +802,42 @@ bad:
>         return -1;
>  }
>
> +static int validate_xperms(const avtab_extended_perms_t *xperms)
> +{
> +       switch (xperms->specified) {
> +       case AVTAB_XPERMS_IOCTLDRIVER:
> +       case AVTAB_XPERMS_IOCTLFUNCTION:
> +               break;
> +       default:
> +               goto bad;
> +       }
> +
> +       return 0;
> +
> +bad:
> +       return -1;
> +}
>  static int validate_avtab_key_and_datum(avtab_key_t *k, avtab_datum_t *d=
, void *args)
>  {
> -       validate_t *flavors =3D (validate_t *)args;
> +       map_arg_t *margs =3D args;
> +
> +       if (validate_avtab_key(k, 0, margs->flavors))
> +               return -1;
>
> -       if (validate_avtab_key(k, 0, flavors))
> +       if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, m=
args->policy, margs->flavors))
>                 return -1;
>
> -       if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavo=
rs[SYM_TYPES]))
> +       if ((k->specified & AVTAB_XPERMS) && validate_xperms(d->xperms))
>                 return -1;
>
>         return 0;
>  }
>
> -static int validate_avtab(sepol_handle_t *handle, const avtab_t *avtab, =
validate_t flavors[])
> +static int validate_avtab(sepol_handle_t *handle, const avtab_t *avtab, =
const policydb_t *p, validate_t flavors[])
>  {
> -       if (avtab_map(avtab, validate_avtab_key_and_datum, flavors)) {
> +       map_arg_t margs =3D { flavors, handle, p };
> +
> +       if (avtab_map(avtab, validate_avtab_key_and_datum, &margs)) {
>                 ERR(handle, "Invalid avtab");
>                 return -1;
>         }
> @@ -797,20 +861,15 @@ static int validate_cond_av_list(sepol_handle_t *ha=
ndle, const cond_av_list_t *c
>         return 0;
>  }
>
> -static int validate_avrules(sepol_handle_t *handle, const avrule_t *avru=
le, int conditional, validate_t flavors[])
> +static int validate_avrules(sepol_handle_t *handle, const avrule_t *avru=
le, int conditional, const policydb_t *p, validate_t flavors[])
>  {
> -       const class_perm_node_t *class;
> +       const class_perm_node_t *classperm;
>
>         for (; avrule; avrule =3D avrule->next) {
>                 if (validate_type_set(&avrule->stypes, &flavors[SYM_TYPES=
]))
>                         goto bad;
>                 if (validate_type_set(&avrule->ttypes, &flavors[SYM_TYPES=
]))
>                         goto bad;
> -               class =3D avrule->perms;
> -               for (; class; class =3D class->next) {
> -                       if (validate_value(class->tclass, &flavors[SYM_CL=
ASSES]))
> -                               goto bad;
> -               }
>
>                 switch(avrule->specified) {
>                 case AVRULE_ALLOWED:
> @@ -833,6 +892,13 @@ static int validate_avrules(sepol_handle_t *handle, =
const avrule_t *avrule, int
>                         goto bad;
>                 }
>
> +               for (classperm =3D avrule->perms; classperm; classperm =
=3D classperm->next) {
> +                       if (validate_value(classperm->tclass, &flavors[SY=
M_CLASSES]))
> +                               goto bad;
> +                       if ((avrule->specified & AVRULE_TYPE) && validate=
_simpletype(classperm->data, p, flavors))
> +                               goto bad;
> +               }
> +
>                 if (avrule->specified & AVRULE_XPERMS) {
>                         if (!avrule->xperms)
>                                 goto bad;
> @@ -885,6 +951,9 @@ static int validate_cond_expr(sepol_handle_t *handle,=
 const struct cond_expr *ex
>  {
>         int depth =3D -1;
>
> +       if (!expr)
> +               goto bad;
> +
>         for (; expr; expr =3D expr->next) {
>                 switch(expr->expr_type) {
>                 case COND_BOOL:
> @@ -922,7 +991,7 @@ bad:
>         return -1;
>  }
>
> -static int validate_cond_list(sepol_handle_t *handle, const cond_list_t =
*cond, validate_t flavors[])
> +static int validate_cond_list(sepol_handle_t *handle, const cond_list_t =
*cond, const policydb_t *p, validate_t flavors[])
>  {
>         for (; cond; cond =3D cond->next) {
>                 if (validate_cond_expr(handle, cond->expr, &flavors[SYM_B=
OOLS]))
> @@ -931,12 +1000,28 @@ static int validate_cond_list(sepol_handle_t *hand=
le, const cond_list_t *cond, v
>                         goto bad;
>                 if (validate_cond_av_list(handle, cond->false_list, flavo=
rs))
>                         goto bad;
> -               if (validate_avrules(handle, cond->avtrue_list, 1, flavor=
s))
> +               if (validate_avrules(handle, cond->avtrue_list, 1, p, fla=
vors))
>                         goto bad;
> -               if (validate_avrules(handle, cond->avfalse_list, 1, flavo=
rs))
> +               if (validate_avrules(handle, cond->avfalse_list, 1, p, fl=
avors))
>                         goto bad;
>                 if (validate_bool_id_array(handle, cond->bool_ids, cond->=
nbools, &flavors[SYM_BOOLS]))
>                         goto bad;
> +
> +               switch (cond->cur_state) {
> +               case 0:
> +               case 1:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
> +
> +               switch (cond->flags) {
> +               case 0:
> +               case COND_NODE_FLAGS_TUNABLE:
> +                       break;
> +               default:
> +                       goto bad;
> +               }
>         }
>
>         return 0;
> @@ -992,6 +1077,8 @@ static int validate_filename_trans(hashtab_key_t k, =
hashtab_datum_t d, void *arg
>                 goto bad;
>         if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
>                 goto bad;
> +       if (!ftd)
> +               goto bad;
>         for (; ftd; ftd =3D ftd->next) {
>                 if (validate_ebitmap(&ftd->stypes, &flavors[SYM_TYPES]))
>                         goto bad;
> @@ -1046,6 +1133,10 @@ static int validate_ocontexts(sepol_handle_t *hand=
le, const policydb_t *p, valid
>                                         if (validate_context(&octx->conte=
xt[1], flavors, p->mls))
>                                                 goto bad;
>                                         break;
> +                               case OCON_PORT:
> +                                       if (octx->u.port.low_port > octx-=
>u.port.high_port)
> +                                               goto bad;
> +                                       break;
>                                 case OCON_FSUSE:
>                                         switch (octx->v.behavior) {
>                                         case SECURITY_FS_USE_XATTR:
> @@ -1076,7 +1167,12 @@ static int validate_genfs(sepol_handle_t *handle, =
const policydb_t *p, validate_
>                 for (octx =3D genfs->head; octx; octx =3D octx->next) {
>                         if (validate_context(&octx->context[0], flavors, =
p->mls))
>                                 goto bad;
> +                       if (octx->v.sclass && validate_value(octx->v.scla=
ss, &flavors[SYM_CLASSES]))
> +                               goto bad;
>                 }
> +
> +               if (!genfs->fstype)
> +                       goto bad;
>         }
>
>         return 0;
> @@ -1173,7 +1269,7 @@ bad:
>  }
>
>
> -static int validate_filename_trans_rules(sepol_handle_t *handle, const f=
ilename_trans_rule_t *filename_trans, validate_t flavors[])
> +static int validate_filename_trans_rules(sepol_handle_t *handle, const f=
ilename_trans_rule_t *filename_trans, const policydb_t *p, validate_t flavo=
rs[])
>  {
>         for (; filename_trans; filename_trans =3D filename_trans->next) {
>                 if (validate_type_set(&filename_trans->stypes, &flavors[S=
YM_TYPES]))
> @@ -1182,7 +1278,7 @@ static int validate_filename_trans_rules(sepol_hand=
le_t *handle, const filename_
>                         goto bad;
>                 if (validate_value(filename_trans->tclass,&flavors[SYM_CL=
ASSES] ))
>                         goto bad;
> -               if (validate_value(filename_trans->otype, &flavors[SYM_TY=
PES]))
> +               if (validate_simpletype(filename_trans->otype, p, flavors=
))
>                         goto bad;
>
>                 /* currently only the RULE_SELF flag can be set */
> @@ -1211,15 +1307,15 @@ static int validate_symtabs(sepol_handle_t *handl=
e, const symtab_t symtabs[], va
>         return 0;
>  }
>
> -static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_b=
lock_t *avrule_block, validate_t flavors[])
> +static int validate_avrule_blocks(sepol_handle_t *handle, const avrule_b=
lock_t *avrule_block, const policydb_t *p, validate_t flavors[])
>  {
>         const avrule_decl_t *decl;
>
>         for (; avrule_block; avrule_block =3D avrule_block->next) {
>                 for (decl =3D avrule_block->branch_list; decl !=3D NULL; =
decl =3D decl->next) {
> -                       if (validate_cond_list(handle, decl->cond_list, f=
lavors))
> +                       if (validate_cond_list(handle, decl->cond_list, p=
, flavors))
>                                 goto bad;
> -                       if (validate_avrules(handle, decl->avrules, 0, fl=
avors))
> +                       if (validate_avrules(handle, decl->avrules, 0, p,=
 flavors))
>                                 goto bad;
>                         if (validate_role_trans_rules(handle, decl->role_=
tr_rules, flavors))
>                                 goto bad;
> @@ -1231,7 +1327,7 @@ static int validate_avrule_blocks(sepol_handle_t *h=
andle, const avrule_block_t *
>                                 goto bad;
>                         if (validate_scope_index(handle, &decl->declared,=
 flavors))
>                                 goto bad;
> -                       if (validate_filename_trans_rules(handle, decl->f=
ilename_trans_rules, flavors))
> +                       if (validate_filename_trans_rules(handle, decl->f=
ilename_trans_rules, p, flavors))
>                                 goto bad;
>                         if (validate_symtabs(handle, decl->symtab, flavor=
s))
>                                 goto bad;
> @@ -1259,7 +1355,7 @@ static int validate_permissives(sepol_handle_t *han=
dle, const policydb_t *p, val
>         unsigned i;
>
>         ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
> -               if (validate_value(i, &flavors[SYM_TYPES]))
> +               if (validate_simpletype(i, p, flavors))
>                         goto bad;
>         }
>
> @@ -1270,6 +1366,61 @@ bad:
>         return -1;
>  }
>
> +static int validate_range_transition(hashtab_key_t key, hashtab_datum_t =
data, void *args)
> +{
> +       const range_trans_t *rt =3D (const range_trans_t *)key;
> +       const mls_range_t *r =3D data;
> +       const map_arg_t *margs =3D args;
> +       const validate_t *flavors =3D margs->flavors;
> +
> +       if (validate_value(rt->source_type, &flavors[SYM_TYPES]))
> +               goto bad;
> +       if (validate_value(rt->target_type, &flavors[SYM_TYPES]))
> +               goto bad;
> +       if (validate_value(rt->target_class, &flavors[SYM_CLASSES]))
> +               goto bad;
> +
> +       if (validate_mls_range(r, &flavors[SYM_LEVELS], &flavors[SYM_CATS=
]))
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       return -1;
> +}
> +
> +static int validate_range_transitions(sepol_handle_t *handle, const poli=
cydb_t *p, validate_t flavors[])
> +{
> +       map_arg_t margs =3D { flavors, handle, p };
> +
> +       if (hashtab_map(p->range_tr, validate_range_transition, &margs)) =
{
> +               ERR(handle, "Invalid range transition");
> +                       return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int validate_typeattr_map(sepol_handle_t *handle, const policydb_=
t *p, validate_t flavors[])
> +{
> +       const ebitmap_t *maps =3D p->type_attr_map;
> +       unsigned int i;
> +
> +       if (p->policy_type =3D=3D POLICY_KERN) {
> +               for (i =3D 0; i < p->p_types.nprim; i++) {
> +                       if (validate_ebitmap(&maps[i], &flavors[SYM_TYPES=
]))
> +                               goto bad;
> +               }
> +       } else if (maps)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid type attr map");
> +       return -1;
> +}
> +
>  static int validate_properties(sepol_handle_t *handle, const policydb_t =
*p)
>  {
>         switch (p->policy_type) {
> @@ -1341,10 +1492,10 @@ int policydb_validate(sepol_handle_t *handle, con=
st policydb_t *p)
>                 goto bad;
>
>         if (p->policy_type =3D=3D POLICY_KERN) {
> -               if (validate_avtab(handle, &p->te_avtab, flavors))
> +               if (validate_avtab(handle, &p->te_avtab, p, flavors))
>                         goto bad;
>                 if (p->policyvers >=3D POLICYDB_VERSION_BOOL)
> -                       if (validate_cond_list(handle, p->cond_list, flav=
ors))
> +                       if (validate_cond_list(handle, p->cond_list, p, f=
lavors))
>                                 goto bad;
>                 if (validate_role_transes(handle, p->role_tr, flavors))
>                         goto bad;
> @@ -1354,7 +1505,7 @@ int policydb_validate(sepol_handle_t *handle, const=
 policydb_t *p)
>                         if (validate_filename_trans_hashtab(handle, p->fi=
lename_trans, flavors))
>                                 goto bad;
>         } else {
> -               if (validate_avrule_blocks(handle, p->global, flavors))
> +               if (validate_avrule_blocks(handle, p->global, p, flavors)=
)
>                         goto bad;
>         }
>
> @@ -1376,6 +1527,12 @@ int policydb_validate(sepol_handle_t *handle, cons=
t policydb_t *p)
>         if (validate_permissives(handle, p, flavors))
>                 goto bad;
>
> +       if (validate_range_transitions(handle, p, flavors))
> +               goto bad;
> +
> +       if (validate_typeattr_map(handle, p, flavors))
> +               goto bad;
> +

This causes the downgrade test to fail. It finds a gap. The problem
only occurs for policy version 19.

The following works.

if (p->policyvers > POLICYDB_VERSION_PERMISSIVE) {
        if (validate_typeattr_map(handle, p, flavors))
            goto bad;
}

Jim

>         validate_array_destroy(flavors);
>
>         return 0;
> --
> 2.36.1
>
