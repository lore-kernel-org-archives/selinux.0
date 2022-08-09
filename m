Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1587FC25B0C
	for <selinux@archiver.kernel.org>; Tue,  9 Aug 2022 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiHIPXB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Aug 2022 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244938AbiHIPWp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Aug 2022 11:22:45 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F362126F
        for <selinux@vger.kernel.org>; Tue,  9 Aug 2022 08:22:18 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q6-20020a05683033c600b0061d2f64df5dso8672806ott.13
        for <selinux@vger.kernel.org>; Tue, 09 Aug 2022 08:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FKh+JQRS0LMXqoppIxW03DL7x7Pt/o6tl/Gq/t+dlE4=;
        b=C7a+vEYCxuJJl6Z8iimYuYToDrFcW+w1E52rTWKWPRY4wkCQHC4O72JB5IinE9aqqD
         +GWZA7lg5BT4RZ5LtE86gooKM9WFSpuNluyAAwXLWqK+GJIm9B6hJRqRZKx+5pmqZT8G
         DhrAIfNFYudMrG/P1oum/EOionu1wAIyhIrVYI1+gHl7/V+x+GNENd+mwkaTQWKXJZHH
         TfjsralTdcLXuGoFWItEYE0ehyh55tG3tONjI0Hoc5xZjmzXq/n265fdoxAt2nw0CrlS
         xJWN290IbKULQiBR547SGJPMT3uEnKmce8NPnbD1PsLBF0NDIkVBy3zxELAkS1AaunEG
         pGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FKh+JQRS0LMXqoppIxW03DL7x7Pt/o6tl/Gq/t+dlE4=;
        b=dMZWxVPv3gPviTRlMhWYig+Y9H2QS3QENC7G8nC/ZaNuJOduWndCJ96lLVjTIV3D5h
         z0XKnIg8wEeZ5B6GiPXPuoMTvUpcqnDG4ao9XELc7rcU5tYNM5FEM2r2j8a0koF3/l0e
         X+0MaX1GE3wDw1uJZov0YnBn/yHIKin8x6VNiF4fGBoGBNSayvJR5tztKDE5Y+Mk7wi7
         Mor9mbbeq3Ofnvkx5Oy+mdGTNGX4KZ9B47OLhjxxEEg1QB5WvQ76bD1wpgZvG5YhmgWC
         R89QqetqJXPec3sbPxzwqYvmCG4jz9iVUQ03LM4GbOhOyfBJ0Kszf0VBSUcTGmm+6iO4
         Aodg==
X-Gm-Message-State: ACgBeo0rETl3HTHto586eVhblzARQNE61oyp5Zu12wr7Bc4COy2lI4UC
        TS0WltgERPn+yym49AEJw/qJ1L6GMR6ezXjbFj9gprOa
X-Google-Smtp-Source: AA6agR4vtorAHRcYBqG8DzkPWkoV88s1QVGjou0CR0I2qrPTGwHKTRboL8VsUo1LEXmPx+bbfMZ1qMvM6vgO6/z5wgw=
X-Received: by 2002:a05:6830:3147:b0:61c:b4a9:a801 with SMTP id
 c7-20020a056830314700b0061cb4a9a801mr8824557ots.53.1660058537433; Tue, 09 Aug
 2022 08:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com> <CAP+JOzTEQa79dmOiN0CqStPEieo6QMjdaqYOrR9mPMH-r5yASQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTEQa79dmOiN0CqStPEieo6QMjdaqYOrR9mPMH-r5yASQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 9 Aug 2022 11:22:06 -0400
Message-ID: <CAP+JOzRX7_QZ_KDNhPccnskBj80FQoDw0UQhnL_p99KXUGeb1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] libsepol: refactor ebitmap conversion in link.c
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 8, 2022 at 11:01 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Refactor the ebitmap conversions in link.c into its own function.
> >
> > Do not log an OOM message twice on type_set_or_convert() failure.
> >
> > Drop the now unused state parameter from type_set_or_convert() and
> > type_set_convert().
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

I applied this patch, but none of the others from this series.
This patch really fit better with the other ebitmap work that was
being merged anyway.

Thanks,
Jim


> > ---
> >  libsepol/src/link.c | 140 +++++++++++++++-----------------------------
> >  1 file changed, 47 insertions(+), 93 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 7e8313cb..cbe4cea4 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -958,26 +958,28 @@ static int alias_copy_callback(hashtab_key_t key,=
 hashtab_datum_t datum,
> >
> >  /*********** callbacks that fix bitmaps ***********/
> >
> > -static int type_set_convert(type_set_t * types, type_set_t * dst,
> > -                           policy_module_t * mod, link_state_t * state
> > -                           __attribute__ ((unused)))
> > +static int ebitmap_convert(const ebitmap_t *src, ebitmap_t *dst, const=
 uint32_t *map)
> >  {
> > -       unsigned int i;
> > -       ebitmap_node_t *tnode;
> > -       ebitmap_for_each_positive_bit(&types->types, tnode, i) {
> > -               assert(mod->map[SYM_TYPES][i]);
> > -               if (ebitmap_set_bit
> > -                   (&dst->types, mod->map[SYM_TYPES][i] - 1, 1)) {
> > -                       goto cleanup;
> > -               }
> > -       }
> > -       ebitmap_for_each_positive_bit(&types->negset, tnode, i) {
> > -               assert(mod->map[SYM_TYPES][i]);
> > -               if (ebitmap_set_bit
> > -                   (&dst->negset, mod->map[SYM_TYPES][i] - 1, 1)) {
> > -                       goto cleanup;
> > -               }
> > +       unsigned int bit;
> > +       ebitmap_node_t *node;
> > +       ebitmap_for_each_positive_bit(src, node, bit) {
> > +               assert(map[bit]);
> > +               if (ebitmap_set_bit(dst, map[bit] - 1, 1))
> > +                       return -1;
> >         }
> > +
> > +       return 0;
> > +}
> > +
> > +static int type_set_convert(const type_set_t * types, type_set_t * dst=
,
> > +                           const policy_module_t * mod)
> > +{
> > +       if (ebitmap_convert(&types->types, &dst->types, mod->map[SYM_TY=
PES]))
> > +               goto cleanup;
> > +
> > +       if (ebitmap_convert(&types->negset, &dst->negset, mod->map[SYM_=
TYPES]))
> > +               goto cleanup;
> > +
> >         dst->flags =3D types->flags;
> >         return 0;
> >
> > @@ -988,13 +990,13 @@ static int type_set_convert(type_set_t * types, t=
ype_set_t * dst,
> >  /* OR 2 typemaps together and at the same time map the src types to
> >   * the correct values in the dst typeset.
> >   */
> > -static int type_set_or_convert(type_set_t * types, type_set_t * dst,
> > -                              policy_module_t * mod, link_state_t * st=
ate)
> > +static int type_set_or_convert(const type_set_t * types, type_set_t * =
dst,
> > +                              const policy_module_t * mod)
> >  {
> >         type_set_t ts_tmp;
> >
> >         type_set_init(&ts_tmp);
> > -       if (type_set_convert(types, &ts_tmp, mod, state) =3D=3D -1) {
> > +       if (type_set_convert(types, &ts_tmp, mod) =3D=3D -1) {
> >                 goto cleanup;
> >         }
> >         if (type_set_or_eq(dst, &ts_tmp)) {
> > @@ -1004,7 +1006,6 @@ static int type_set_or_convert(type_set_t * types=
, type_set_t * dst,
> >         return 0;
> >
> >        cleanup:
> > -       ERR(state->handle, "Out of memory!");
> >         type_set_destroy(&ts_tmp);
> >         return -1;
> >  }
> > @@ -1012,18 +1013,11 @@ static int type_set_or_convert(type_set_t * typ=
es, type_set_t * dst,
> >  static int role_set_or_convert(role_set_t * roles, role_set_t * dst,
> >                                policy_module_t * mod, link_state_t * st=
ate)
> >  {
> > -       unsigned int i;
> >         ebitmap_t tmp;
> > -       ebitmap_node_t *rnode;
> >
> >         ebitmap_init(&tmp);
> > -       ebitmap_for_each_positive_bit(&roles->roles, rnode, i) {
> > -               assert(mod->map[SYM_ROLES][i]);
> > -               if (ebitmap_set_bit
> > -                   (&tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> > -                       goto cleanup;
> > -               }
> > -       }
> > +       if (ebitmap_convert(&roles->roles, &tmp, mod->map[SYM_ROLES]))
> > +               goto cleanup;
> >         if (ebitmap_union(&dst->roles, &tmp)) {
> >                 goto cleanup;
> >         }
> > @@ -1088,13 +1082,11 @@ static int mls_range_convert(mls_semantic_range=
_t * src, mls_semantic_range_t *
> >  static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
> >                              void *data)
> >  {
> > -       unsigned int i;
> >         char *id =3D key;
> >         role_datum_t *role, *dest_role =3D NULL;
> >         link_state_t *state =3D (link_state_t *) data;
> >         ebitmap_t e_tmp;
> >         policy_module_t *mod =3D state->cur;
> > -       ebitmap_node_t *rnode;
> >         hashtab_t role_tab;
> >
> >         role =3D (role_datum_t *) datum;
> > @@ -1111,30 +1103,20 @@ static int role_fix_callback(hashtab_key_t key,=
 hashtab_datum_t datum,
> >         }
> >
> >         ebitmap_init(&e_tmp);
> > -       ebitmap_for_each_positive_bit(&role->dominates, rnode, i) {
> > -               assert(mod->map[SYM_ROLES][i]);
> > -               if (ebitmap_set_bit
> > -                   (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> > -                       goto cleanup;
> > -               }
> > -       }
> > +       if (ebitmap_convert(&role->dominates, &e_tmp, mod->map[SYM_ROLE=
S]))
> > +               goto cleanup;
> >         if (ebitmap_union(&dest_role->dominates, &e_tmp)) {
> >                 goto cleanup;
> >         }
> > -       if (type_set_or_convert(&role->types, &dest_role->types, mod, s=
tate)) {
> > +       if (type_set_or_convert(&role->types, &dest_role->types, mod)) =
{
> >                 goto cleanup;
> >         }
> >         ebitmap_destroy(&e_tmp);
> >
> >         if (role->flavor =3D=3D ROLE_ATTRIB) {
> >                 ebitmap_init(&e_tmp);
> > -               ebitmap_for_each_positive_bit(&role->roles, rnode, i) {
> > -                       assert(mod->map[SYM_ROLES][i]);
> > -                       if (ebitmap_set_bit
> > -                           (&e_tmp, mod->map[SYM_ROLES][i] - 1, 1)) {
> > -                               goto cleanup;
> > -                       }
> > -               }
> > +               if (ebitmap_convert(&role->roles, &e_tmp, mod->map[SYM_=
ROLES]))
> > +                       goto cleanup;
> >                 if (ebitmap_union(&dest_role->roles, &e_tmp)) {
> >                         goto cleanup;
> >                 }
> > @@ -1152,13 +1134,11 @@ static int role_fix_callback(hashtab_key_t key,=
 hashtab_datum_t datum,
> >  static int type_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
> >                              void *data)
> >  {
> > -       unsigned int i;
> >         char *id =3D key;
> >         type_datum_t *type, *new_type =3D NULL;
> >         link_state_t *state =3D (link_state_t *) data;
> >         ebitmap_t e_tmp;
> >         policy_module_t *mod =3D state->cur;
> > -       ebitmap_node_t *tnode;
> >         symtab_t *typetab;
> >
> >         type =3D (type_datum_t *) datum;
> > @@ -1181,13 +1161,8 @@ static int type_fix_callback(hashtab_key_t key, =
hashtab_datum_t datum,
> >         }
> >
> >         ebitmap_init(&e_tmp);
> > -       ebitmap_for_each_positive_bit(&type->types, tnode, i) {
> > -               assert(mod->map[SYM_TYPES][i]);
> > -               if (ebitmap_set_bit
> > -                   (&e_tmp, mod->map[SYM_TYPES][i] - 1, 1)) {
> > -                       goto cleanup;
> > -               }
> > -       }
> > +       if (ebitmap_convert(&type->types, &e_tmp, mod->map[SYM_TYPES]))
> > +               goto cleanup;
> >         if (ebitmap_union(&new_type->types, &e_tmp)) {
> >                 goto cleanup;
> >         }
> > @@ -1269,9 +1244,8 @@ static int copy_avrule_list(avrule_t * list, avru=
le_t ** dst,
> >                 new_rule->specified =3D cur->specified;
> >                 new_rule->flags =3D cur->flags;
> >                 if (type_set_convert
> > -                   (&cur->stypes, &new_rule->stypes, module, state) =
=3D=3D -1
> > -                   || type_set_convert(&cur->ttypes, &new_rule->ttypes=
, module,
> > -                                       state) =3D=3D -1) {
> > +                   (&cur->stypes, &new_rule->stypes, module) =3D=3D -1
> > +                   || type_set_convert(&cur->ttypes, &new_rule->ttypes=
, module) =3D=3D -1) {
> >                         goto cleanup;
> >                 }
> >
> > @@ -1355,8 +1329,6 @@ static int copy_role_trans_list(role_trans_rule_t=
 * list,
> >                                 policy_module_t * module, link_state_t =
* state)
> >  {
> >         role_trans_rule_t *cur, *new_rule =3D NULL, *tail;
> > -       unsigned int i;
> > -       ebitmap_node_t *cnode;
> >
> >         cur =3D list;
> >         tail =3D *dst;
> > @@ -1374,19 +1346,12 @@ static int copy_role_trans_list(role_trans_rule=
_t * list,
> >                 if (role_set_or_convert
> >                     (&cur->roles, &new_rule->roles, module, state)
> >                     || type_set_or_convert(&cur->types, &new_rule->type=
s,
> > -                                          module, state)) {
> > +                                          module)) {
> >                         goto cleanup;
> >                 }
> >
> > -               ebitmap_for_each_positive_bit(&cur->classes, cnode, i) =
{
> > -                       assert(module->map[SYM_CLASSES][i]);
> > -                       if (ebitmap_set_bit(&new_rule->classes,
> > -                                           module->
> > -                                           map[SYM_CLASSES][i] - 1,
> > -                                           1)) {
> > -                               goto cleanup;
> > -                       }
> > -               }
> > +               if (ebitmap_convert(&cur->classes, &new_rule->classes, =
module->map[SYM_CLASSES]))
> > +                       goto cleanup;
> >
> >                 new_rule->new_role =3D module->map[SYM_ROLES][cur->new_=
role - 1];
> >
> > @@ -1476,8 +1441,8 @@ static int copy_filename_trans_list(filename_tran=
s_rule_t * list,
> >                 if (!new_rule->name)
> >                         goto err;
> >
> > -               if (type_set_or_convert(&cur->stypes, &new_rule->stypes=
, module, state) ||
> > -                   type_set_or_convert(&cur->ttypes, &new_rule->ttypes=
, module, state))
> > +               if (type_set_or_convert(&cur->stypes, &new_rule->stypes=
, module) ||
> > +                   type_set_or_convert(&cur->ttypes, &new_rule->ttypes=
, module))
> >                         goto err;
> >
> >                 new_rule->tclass =3D module->map[SYM_CLASSES][cur->tcla=
ss - 1];
> > @@ -1497,8 +1462,6 @@ static int copy_range_trans_list(range_trans_rule=
_t * rules,
> >                                  policy_module_t * mod, link_state_t * =
state)
> >  {
> >         range_trans_rule_t *rule, *new_rule =3D NULL;
> > -       unsigned int i;
> > -       ebitmap_node_t *cnode;
> >
> >         for (rule =3D rules; rule; rule =3D rule->next) {
> >                 new_rule =3D
> > @@ -1512,21 +1475,15 @@ static int copy_range_trans_list(range_trans_ru=
le_t * rules,
> >                 *dst =3D new_rule;
> >
> >                 if (type_set_convert(&rule->stypes, &new_rule->stypes,
> > -                                    mod, state))
> > +                                    mod))
> >                         goto cleanup;
> >
> >                 if (type_set_convert(&rule->ttypes, &new_rule->ttypes,
> > -                                    mod, state))
> > +                                    mod))
> >                         goto cleanup;
> >
> > -               ebitmap_for_each_positive_bit(&rule->tclasses, cnode, i=
) {
> > -                       assert(mod->map[SYM_CLASSES][i]);
> > -                       if (ebitmap_set_bit
> > -                           (&new_rule->tclasses,
> > -                            mod->map[SYM_CLASSES][i] - 1, 1)) {
> > -                               goto cleanup;
> > -                       }
> > -               }
> > +               if (ebitmap_convert(&rule->tclasses, &new_rule->tclasse=
s, mod->map[SYM_CLASSES]))
> > +                       goto cleanup;
> >
> >                 if (mls_range_convert(&rule->trange, &new_rule->trange,=
 mod, state))
> >                         goto cleanup;
> > @@ -1688,15 +1645,12 @@ static int copy_scope_index(scope_index_t * src=
, scope_index_t * dest,
> >         }
> >         dest->class_perms_len =3D largest_mapped_class_value;
> >         for (i =3D 0; i < src->class_perms_len; i++) {
> > -               ebitmap_t *srcmap =3D src->class_perms_map + i;
> > +               const ebitmap_t *srcmap =3D src->class_perms_map + i;
> >                 ebitmap_t *destmap =3D
> >                     dest->class_perms_map + module->map[SYM_CLASSES][i]=
 - 1;
> > -               ebitmap_for_each_positive_bit(srcmap, node, j) {
> > -                       if (ebitmap_set_bit(destmap, module->perm_map[i=
][j] - 1,
> > -                                           1)) {
> > -                               goto cleanup;
> > -                       }
> > -               }
> > +
> > +               if (ebitmap_convert(srcmap, destmap, module->perm_map[i=
]))
> > +                       goto cleanup;
> >         }
> >
> >         return 0;
> > --
> > 2.36.1
> >
