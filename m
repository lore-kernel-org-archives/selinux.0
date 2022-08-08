Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69DFC00140
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiHHPCO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235685AbiHHPCN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 11:02:13 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C361B855
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 08:02:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10e6bdbe218so10790573fac.10
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 08:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=tA7M/btmbdvByCOTR0v5HY2dJcSM2WaInhbBvXaJxTY=;
        b=phOHGR2WQdyIu0QAOshWiN6QEV+rcT4rsuHSH/qaC1LJE7FrlRVu4v0ImBs+fyIT0w
         G33N89FCEF2I+mbjbd5J3MXx+o8e/3Nc8AZ+aE9fnE18f2vQ+/f/l3bTBewGYt4q88Y8
         5obp4rYCtC6uQKsIgDvuNw4586vvJWgHsHWbdNZIrRWgZhwCmOeJHDakfJlDOlHI1kQl
         bIJOEbgNfW7sEp0XVSrPxdnf0Ju1OfGa1UPIzJtwYEGLfYI8jkt9u9tHHiiAsiSiGxZU
         Gb+GVpj85cB9HpzF1nR9X4KJMrAAt8fgLVpd3J7sUPfZRKnweiO8jMkvkgf3xAv+yxPL
         sYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tA7M/btmbdvByCOTR0v5HY2dJcSM2WaInhbBvXaJxTY=;
        b=SymiCpFnExYEO/W95UgRBVk5OvOWgbFnnCCxEfpSl3M6oZ5wGx3CptjTlRNPGS/tjt
         7RFvh/OlJOepSF84IX5BQpIoi5iZGzeYy+3soESwoq40i+xkzmXKHenzL720S4pab3k3
         xzMUY5psvKlGYAlHxChpykqc0JJ+B0LFk3AJlR6Cd+PyMXXwLWpDbbQCdLEL2FItaU0F
         1/P6ruUHjk8Z/kxAiFl+TxpIi5Vu7DtBEMIE8Ujc3eToIojB4TXxD805TusBKKc+YlKu
         EMwi5dghG2+kI+TwC1dbczFFY6l2i42os0LziiHY/+onn7zp3ZgPYzkdt+MCQDX6w9rj
         n2lw==
X-Gm-Message-State: ACgBeo281etNlFoc+yf6/z+cA8SMOAGSJSz45cgTgmNrPYcq9PoW2wYg
        cujoxRm13ecwf4xwFvNxRh6dPUQcBXJithXMSh9T3ggDp+Y=
X-Google-Smtp-Source: AA6agR6jfY6cG9ZSII7HYlztTnJQNnIDHJTpQ82XEH4dH42bZsu/bMi4AwX5I3ldtkA+hU8ZBb0LReumhmw0jXsDyFA=
X-Received: by 2002:a05:6870:c0c5:b0:10d:5f5c:9ab1 with SMTP id
 e5-20020a056870c0c500b0010d5f5c9ab1mr12782781oad.156.1659970930836; Mon, 08
 Aug 2022 08:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com>
In-Reply-To: <20220721150515.19843-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Aug 2022 11:01:59 -0400
Message-ID: <CAP+JOzTEQa79dmOiN0CqStPEieo6QMjdaqYOrR9mPMH-r5yASQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] libsepol: refactor ebitmap conversion in link.c
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Refactor the ebitmap conversions in link.c into its own function.
>
> Do not log an OOM message twice on type_set_or_convert() failure.
>
> Drop the now unused state parameter from type_set_or_convert() and
> type_set_convert().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/link.c | 140 +++++++++++++++-----------------------------
>  1 file changed, 47 insertions(+), 93 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 7e8313cb..cbe4cea4 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -958,26 +958,28 @@ static int alias_copy_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
>
>  /*********** callbacks that fix bitmaps ***********/
>
> -static int type_set_convert(type_set_t * types, type_set_t * dst,
> -                           policy_module_t * mod, link_state_t * state
> -                           __attribute__ ((unused)))
> +static int ebitmap_convert(const ebitmap_t *src, ebitmap_t *dst, const u=
int32_t *map)
>  {
> -       unsigned int i;
> -       ebitmap_node_t *tnode;
> -       ebitmap_for_each_positive_bit(&types->types, tnode, i) {
> -               assert(mod->map[SYM_TYPES][i]);
> -               if (ebitmap_set_bit
> -                   (&dst->types, mod->map[SYM_TYPES][i] - 1, 1)) {
> -                       goto cleanup;
> -               }
> -       }
> -       ebitmap_for_each_positive_bit(&types->negset, tnode, i) {
> -               assert(mod->map[SYM_TYPES][i]);
> -               if (ebitmap_set_bit
> -                   (&dst->negset, mod->map[SYM_TYPES][i] - 1, 1)) {
> -                       goto cleanup;
> -               }
> +       unsigned int bit;
> +       ebitmap_node_t *node;
> +       ebitmap_for_each_positive_bit(src, node, bit) {
> +               assert(map[bit]);
> +               if (ebitmap_set_bit(dst, map[bit] - 1, 1))
> +                       return -1;
>         }
> +
> +       return 0;
> +}
> +
> +static int type_set_convert(const type_set_t * types, type_set_t * dst,
> +                           const policy_module_t * mod)
> +{
> +       if (ebitmap_convert(&types->types, &dst->types, mod->map[SYM_TYPE=
S]))
> +               goto cleanup;
> +
> +       if (ebitmap_convert(&types->negset, &dst->negset, mod->map[SYM_TY=
PES]))
> +               goto cleanup;
> +
>         dst->flags =3D types->flags;
>         return 0;
>
> @@ -988,13 +990,13 @@ static int type_set_convert(type_set_t * types, typ=
e_set_t * dst,
>  /* OR 2 typemaps together and at the same time map the src types to
>   * the correct values in the dst typeset.
>   */
> -static int type_set_or_convert(type_set_t * types, type_set_t * dst,
> -                              policy_module_t * mod, link_state_t * stat=
e)
> +static int type_set_or_convert(const type_set_t * types, type_set_t * ds=
t,
> +                              const policy_module_t * mod)
>  {
>         type_set_t ts_tmp;
>
>         type_set_init(&ts_tmp);
> -       if (type_set_convert(types, &ts_tmp, mod, state) =3D=3D -1) {
> +       if (type_set_convert(types, &ts_tmp, mod) =3D=3D -1) {
>                 goto cleanup;
>         }
>         if (type_set_or_eq(dst, &ts_tmp)) {
> @@ -1004,7 +1006,6 @@ static int type_set_or_convert(type_set_t * types, =
type_set_t * dst,
>         return 0;
>
>        cleanup:
> -       ERR(state->handle, "Out of memory!");
>         type_set_destroy(&ts_tmp);
>         return -1;
>  }
> @@ -1012,18 +1013,11 @@ static int type_set_or_convert(type_set_t * types=
, type_set_t * dst,
>  static int role_set_or_convert(role_set_t * roles, role_set_t * dst,
>                                policy_module_t * mod, link_state_t * stat=
e)
>  {
> -       unsigned int i;
>         ebitmap_t tmp;
> -       ebitmap_node_t *rnode;
>
>         ebitmap_init(&tmp);
> -       ebitmap_for_each_positive_bit(&roles->roles, rnode, i) {
> -               assert(mod->map[SYM_ROLES][i]);
> -               if (ebitmap_set_bit
> -                   (&tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> -                       goto cleanup;
> -               }
> -       }
> +       if (ebitmap_convert(&roles->roles, &tmp, mod->map[SYM_ROLES]))
> +               goto cleanup;
>         if (ebitmap_union(&dst->roles, &tmp)) {
>                 goto cleanup;
>         }
> @@ -1088,13 +1082,11 @@ static int mls_range_convert(mls_semantic_range_t=
 * src, mls_semantic_range_t *
>  static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
>                              void *data)
>  {
> -       unsigned int i;
>         char *id =3D key;
>         role_datum_t *role, *dest_role =3D NULL;
>         link_state_t *state =3D (link_state_t *) data;
>         ebitmap_t e_tmp;
>         policy_module_t *mod =3D state->cur;
> -       ebitmap_node_t *rnode;
>         hashtab_t role_tab;
>
>         role =3D (role_datum_t *) datum;
> @@ -1111,30 +1103,20 @@ static int role_fix_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
>         }
>
>         ebitmap_init(&e_tmp);
> -       ebitmap_for_each_positive_bit(&role->dominates, rnode, i) {
> -               assert(mod->map[SYM_ROLES][i]);
> -               if (ebitmap_set_bit
> -                   (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> -                       goto cleanup;
> -               }
> -       }
> +       if (ebitmap_convert(&role->dominates, &e_tmp, mod->map[SYM_ROLES]=
))
> +               goto cleanup;
>         if (ebitmap_union(&dest_role->dominates, &e_tmp)) {
>                 goto cleanup;
>         }
> -       if (type_set_or_convert(&role->types, &dest_role->types, mod, sta=
te)) {
> +       if (type_set_or_convert(&role->types, &dest_role->types, mod)) {
>                 goto cleanup;
>         }
>         ebitmap_destroy(&e_tmp);
>
>         if (role->flavor =3D=3D ROLE_ATTRIB) {
>                 ebitmap_init(&e_tmp);
> -               ebitmap_for_each_positive_bit(&role->roles, rnode, i) {
> -                       assert(mod->map[SYM_ROLES][i]);
> -                       if (ebitmap_set_bit
> -                           (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> -                               goto cleanup;
> -                       }
> -               }
> +               if (ebitmap_convert(&role->roles, &e_tmp, mod->map[SYM_RO=
LES]))
> +                       goto cleanup;
>                 if (ebitmap_union(&dest_role->roles, &e_tmp)) {
>                         goto cleanup;
>                 }
> @@ -1152,13 +1134,11 @@ static int role_fix_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
>  static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
>                              void *data)
>  {
> -       unsigned int i;
>         char *id =3D key;
>         type_datum_t *type, *new_type =3D NULL;
>         link_state_t *state =3D (link_state_t *) data;
>         ebitmap_t e_tmp;
>         policy_module_t *mod =3D state->cur;
> -       ebitmap_node_t *tnode;
>         symtab_t *typetab;
>
>         type =3D (type_datum_t *) datum;
> @@ -1181,13 +1161,8 @@ static int type_fix_callback(hashtab_key_t key, ha=
shtab_datum_t datum,
>         }
>
>         ebitmap_init(&e_tmp);
> -       ebitmap_for_each_positive_bit(&type->types, tnode, i) {
> -               assert(mod->map[SYM_TYPES][i]);
> -               if (ebitmap_set_bit
> -                   (&e_tmp, mod->map[SYM_TYPES][i] - 1, 1)) {
> -                       goto cleanup;
> -               }
> -       }
> +       if (ebitmap_convert(&type->types, &e_tmp, mod->map[SYM_TYPES]))
> +               goto cleanup;
>         if (ebitmap_union(&new_type->types, &e_tmp)) {
>                 goto cleanup;
>         }
> @@ -1269,9 +1244,8 @@ static int copy_avrule_list(avrule_t * list, avrule=
_t ** dst,
>                 new_rule->specified =3D cur->specified;
>                 new_rule->flags =3D cur->flags;
>                 if (type_set_convert
> -                   (&cur->stypes, &new_rule->stypes, module, state) =3D=
=3D -1
> -                   || type_set_convert(&cur->ttypes, &new_rule->ttypes, =
module,
> -                                       state) =3D=3D -1) {
> +                   (&cur->stypes, &new_rule->stypes, module) =3D=3D -1
> +                   || type_set_convert(&cur->ttypes, &new_rule->ttypes, =
module) =3D=3D -1) {
>                         goto cleanup;
>                 }
>
> @@ -1355,8 +1329,6 @@ static int copy_role_trans_list(role_trans_rule_t *=
 list,
>                                 policy_module_t * module, link_state_t * =
state)
>  {
>         role_trans_rule_t *cur, *new_rule =3D NULL, *tail;
> -       unsigned int i;
> -       ebitmap_node_t *cnode;
>
>         cur =3D list;
>         tail =3D *dst;
> @@ -1374,19 +1346,12 @@ static int copy_role_trans_list(role_trans_rule_t=
 * list,
>                 if (role_set_or_convert
>                     (&cur->roles, &new_rule->roles, module, state)
>                     || type_set_or_convert(&cur->types, &new_rule->types,
> -                                          module, state)) {
> +                                          module)) {
>                         goto cleanup;
>                 }
>
> -               ebitmap_for_each_positive_bit(&cur->classes, cnode, i) {
> -                       assert(module->map[SYM_CLASSES][i]);
> -                       if (ebitmap_set_bit(&new_rule->classes,
> -                                           module->
> -                                           map[SYM_CLASSES][i] - 1,
> -                                           1)) {
> -                               goto cleanup;
> -                       }
> -               }
> +               if (ebitmap_convert(&cur->classes, &new_rule->classes, mo=
dule->map[SYM_CLASSES]))
> +                       goto cleanup;
>
>                 new_rule->new_role =3D module->map[SYM_ROLES][cur->new_ro=
le - 1];
>
> @@ -1476,8 +1441,8 @@ static int copy_filename_trans_list(filename_trans_=
rule_t * list,
>                 if (!new_rule->name)
>                         goto err;
>
> -               if (type_set_or_convert(&cur->stypes, &new_rule->stypes, =
module, state) ||
> -                   type_set_or_convert(&cur->ttypes, &new_rule->ttypes, =
module, state))
> +               if (type_set_or_convert(&cur->stypes, &new_rule->stypes, =
module) ||
> +                   type_set_or_convert(&cur->ttypes, &new_rule->ttypes, =
module))
>                         goto err;
>
>                 new_rule->tclass =3D module->map[SYM_CLASSES][cur->tclass=
 - 1];
> @@ -1497,8 +1462,6 @@ static int copy_range_trans_list(range_trans_rule_t=
 * rules,
>                                  policy_module_t * mod, link_state_t * st=
ate)
>  {
>         range_trans_rule_t *rule, *new_rule =3D NULL;
> -       unsigned int i;
> -       ebitmap_node_t *cnode;
>
>         for (rule =3D rules; rule; rule =3D rule->next) {
>                 new_rule =3D
> @@ -1512,21 +1475,15 @@ static int copy_range_trans_list(range_trans_rule=
_t * rules,
>                 *dst =3D new_rule;
>
>                 if (type_set_convert(&rule->stypes, &new_rule->stypes,
> -                                    mod, state))
> +                                    mod))
>                         goto cleanup;
>
>                 if (type_set_convert(&rule->ttypes, &new_rule->ttypes,
> -                                    mod, state))
> +                                    mod))
>                         goto cleanup;
>
> -               ebitmap_for_each_positive_bit(&rule->tclasses, cnode, i) =
{
> -                       assert(mod->map[SYM_CLASSES][i]);
> -                       if (ebitmap_set_bit
> -                           (&new_rule->tclasses,
> -                            mod->map[SYM_CLASSES][i] - 1, 1)) {
> -                               goto cleanup;
> -                       }
> -               }
> +               if (ebitmap_convert(&rule->tclasses, &new_rule->tclasses,=
 mod->map[SYM_CLASSES]))
> +                       goto cleanup;
>
>                 if (mls_range_convert(&rule->trange, &new_rule->trange, m=
od, state))
>                         goto cleanup;
> @@ -1688,15 +1645,12 @@ static int copy_scope_index(scope_index_t * src, =
scope_index_t * dest,
>         }
>         dest->class_perms_len =3D largest_mapped_class_value;
>         for (i =3D 0; i < src->class_perms_len; i++) {
> -               ebitmap_t *srcmap =3D src->class_perms_map + i;
> +               const ebitmap_t *srcmap =3D src->class_perms_map + i;
>                 ebitmap_t *destmap =3D
>                     dest->class_perms_map + module->map[SYM_CLASSES][i] -=
 1;
> -               ebitmap_for_each_positive_bit(srcmap, node, j) {
> -                       if (ebitmap_set_bit(destmap, module->perm_map[i][=
j] - 1,
> -                                           1)) {
> -                               goto cleanup;
> -                       }
> -               }
> +
> +               if (ebitmap_convert(srcmap, destmap, module->perm_map[i])=
)
> +                       goto cleanup;
>         }
>
>         return 0;
> --
> 2.36.1
>
