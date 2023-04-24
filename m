Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489F1C77B61
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDXQic (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXQic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 12:38:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2403A8C
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:38:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506bf4cbecbso6848974a12.1
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682354308; x=1684946308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyDd/d+/2NDMVMbXV7w0deCl154qSmm3xjLpLnfFfiU=;
        b=SpfxP69VwbGLrOLQle/EiGi3Vgmsw7rBveiCSTfY1FrTyO4dMIYsUuZ+JPlIfoVr2f
         O5eWY4Ii1b4y1t1QOPRHhEFKwZ7J1tLD2N8xyM5SCB9XSC7gWhp5YjGo93k3DQD5HMdq
         3/2yurDXyAKG8oWfNjJ6UmaSVCUD3J8UQH8WzlsuSdvDmWzy6bB2AKAybgprgxjL+KRR
         77zCm3LpxukA4BF3A3s2O3k+W80/x4xkqA59WQzizqjsRtdKkItp0FOe/xo2Yc1hgIut
         i9/KJNrtDhXw0GoYqJ58MW7N1rKQpTF7QPpZK/a5hLsk8JlJHbhJkKbFnPXGPtAptImb
         BEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682354308; x=1684946308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyDd/d+/2NDMVMbXV7w0deCl154qSmm3xjLpLnfFfiU=;
        b=dhb2wKvjQZsSkN9ZtxyyZlyr5vMgGFZCdUjMk6GVzrCFKhNh/UidMVliSV+2o5ksnX
         /6LC9tdqWDJLzsvLd3tns+QLzFo24CUHLrSrPsRuWtRjjxltqWI3K2G035IE4IAjxYSr
         Sp70An2JLaZXGEfxL3rWHAt3chrMqo0J84M+jNdlwtnvXozQWJwXi9yoHE1G5HmR520d
         HYSaZZK1lMlFrAc7nh8SZpxViSC+LqnJwUQFIkR5fSANNMrqbvLW6Ioq4WbDPNRk5ehk
         h+mktYUxG6Yet8QX8x7isj1g9qhCreLjZVYSFGpZD+VjwfES7Ul406aMvjWayU5OSlCP
         BKDA==
X-Gm-Message-State: AAQBX9dY8EIn80DfcR4fcCfeEgNtMyv4qucF1awgs1G8hEoWdaiTKrwz
        a/efXd/SwvtrKeFSTGfAsTr2F8X1YhlBOU4wOCRR2p0z
X-Google-Smtp-Source: AKy350aynzOd2n5p8dUcCz0smU5MbckxdzNMIQ7gr3rJ5UyK/ZNzmBs2tbBpng1LleKiq3xyRuR6GGyq6Zs7PlVKnSg=
X-Received: by 2002:aa7:dbd9:0:b0:500:2cc6:36da with SMTP id
 v25-20020aa7dbd9000000b005002cc636damr12775981edt.19.1682354307922; Mon, 24
 Apr 2023 09:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230420153556.32115-1-cgzones@googlemail.com> <CAEjxPJ769sxp0CieV42iGEYYcnEAj51DvFu8oD+y+JH_EhXUgg@mail.gmail.com>
In-Reply-To: <CAEjxPJ769sxp0CieV42iGEYYcnEAj51DvFu8oD+y+JH_EhXUgg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Apr 2023 12:38:16 -0400
Message-ID: <CAP+JOzTUX71FvYKL-1BoTtAxLxyz8xknSG4S-V7NeiSjgL+iSw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] libsepol: rename struct member
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 21, 2023 at 11:27=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Apr 20, 2023 at 11:41=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Avoid using the identifier `bool` to improve support with future C
> > standards.  C23 is about to make `bool` a predefined macro (see N2654).
> >
> > Since the type `cond_expr_t` is part of the public API it will break
> > client applications.  A quick search of the code in Debian shows only
> > usages in checkpolicy and setools.
>
> NB Header files under the sepol/policydb subdirectory are not part of
> the libsepol shared library API/ABI and thus changes there are not
> considered to be API/ABI changes. They should only affect users of the
> static libsepol and there is no warranty for them.
>

So should that paragraph be removed or should it say something like:
"While header files under the sepol/policydb subdirectory are not part
of the libsepol shared library API/ABI, these changes will break
setools."?

Jim

> >
> > Define a new macro signaling the renaming to simplify support of client
> > applications for new and older versions of libsepol.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >    update version identifier in header to 3.6
> > ---
> >  libsepol/cil/src/cil_binary.c                 |  6 +++---
> >  libsepol/include/sepol/policydb/conditional.h |  4 +++-
> >  libsepol/src/conditional.c                    | 14 +++++++-------
> >  libsepol/src/expand.c                         |  6 +++---
> >  libsepol/src/kernel_to_cil.c                  |  2 +-
> >  libsepol/src/kernel_to_conf.c                 |  2 +-
> >  libsepol/src/link.c                           |  6 +++---
> >  libsepol/src/module_to_cil.c                  |  2 +-
> >  libsepol/src/policydb_validate.c              |  2 +-
> >  libsepol/src/write.c                          |  2 +-
> >  libsepol/tests/debug.c                        |  2 +-
> >  libsepol/tests/test-linker-cond-map.c         |  2 +-
> >  12 files changed, 26 insertions(+), 24 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binar=
y.c
> > index 40615db2..ef7f4d70 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -2123,7 +2123,7 @@ static int __cil_cond_item_to_sepol_expr(policydb=
_t *pdb, struct cil_list_item *
> >                 *head =3D cil_malloc(sizeof(cond_expr_t));
> >                 (*head)->next =3D NULL;
> >                 (*head)->expr_type =3D COND_BOOL;
> > -               (*head)->bool =3D sepol_bool->s.value;
> > +               (*head)->boolean =3D sepol_bool->s.value;
> >                 *tail =3D *head;
> >         } else if (item->flavor =3D=3D CIL_LIST) {
> >                 struct cil_list *l =3D item->data;
> > @@ -2159,7 +2159,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(p=
olicydb_t *pdb, struct cil_list
> >                 enum cil_flavor cil_op =3D (enum cil_flavor)(uintptr_t)=
item->data;
> >
> >                 op =3D cil_malloc(sizeof(*op));
> > -               op->bool =3D 0;
> > +               op->boolean =3D 0;
> >                 op->next =3D NULL;
> >
> >                 switch (cil_op) {
> > @@ -2226,7 +2226,7 @@ static int __cil_cond_expr_to_sepol_expr_helper(p=
olicydb_t *pdb, struct cil_list
> >                                 goto exit;
> >                         }
> >                         op =3D cil_malloc(sizeof(*op));
> > -                       op->bool =3D 0;
> > +                       op->boolean =3D 0;
> >                         op->next =3D NULL;
> >                         op->expr_type =3D COND_OR;
> >                         t1->next =3D h2;
> > diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol/i=
nclude/sepol/policydb/conditional.h
> > index 49c0d766..5318ea19 100644
> > --- a/libsepol/include/sepol/policydb/conditional.h
> > +++ b/libsepol/include/sepol/policydb/conditional.h
> > @@ -54,7 +54,9 @@ typedef struct cond_expr {
> >  #define COND_NEQ       7       /* bool !=3D bool */
> >  #define COND_LAST      COND_NEQ
> >         uint32_t expr_type;
> > -       uint32_t bool;
> > +       /* The member `boolean` was renamed from `bool` in version 3.6 =
*/
> > +#define COND_EXPR_T_RENAME_BOOL_BOOLEAN
> > +       uint32_t boolean;
> >         struct cond_expr *next;
> >  } cond_expr_t;
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index a620451d..24380ea0 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -125,7 +125,7 @@ int cond_expr_equal(cond_node_t * a, cond_node_t * =
b)
> >                 if (cur_a->expr_type !=3D cur_b->expr_type)
> >                         return 0;
> >                 if (cur_a->expr_type =3D=3D COND_BOOL) {
> > -                       if (cur_a->bool !=3D cur_b->bool)
> > +                       if (cur_a->boolean !=3D cur_b->boolean)
> >                                 return 0;
> >                 }
> >                 cur_a =3D cur_a->next;
> > @@ -223,7 +223,7 @@ int cond_evaluate_expr(policydb_t * p, cond_expr_t =
* expr)
> >                         if (sp =3D=3D (COND_EXPR_MAXDEPTH - 1))
> >                                 return -1;
> >                         sp++;
> > -                       s[sp] =3D p->bool_val_to_struct[cur->bool - 1]-=
>state;
> > +                       s[sp] =3D p->bool_val_to_struct[cur->boolean - =
1]->state;
> >                         break;
> >                 case COND_NOT:
> >                         if (sp < 0)
> > @@ -279,7 +279,7 @@ cond_expr_t *cond_copy_expr(cond_expr_t * expr)
> >                 memset(new_expr, 0, sizeof(cond_expr_t));
> >
> >                 new_expr->expr_type =3D cur->expr_type;
> > -               new_expr->bool =3D cur->bool;
> > +               new_expr->boolean =3D cur->boolean;
> >
> >                 if (!head)
> >                         head =3D new_expr;
> > @@ -388,10 +388,10 @@ int cond_normalize_expr(policydb_t * p, cond_node=
_t * cn)
> >                 switch (e->expr_type) {
> >                 case COND_BOOL:
> >                         /* see if we've already seen this bool */
> > -                       if (!bool_present(e->bool, cn->bool_ids, cn->nb=
ools)) {
> > +                       if (!bool_present(e->boolean, cn->bool_ids, cn-=
>nbools)) {
> >                                 /* count em all but only record up to C=
OND_MAX_BOOLS */
> >                                 if (cn->nbools < COND_MAX_BOOLS)
> > -                                       cn->bool_ids[cn->nbools++] =3D =
e->bool;
> > +                                       cn->bool_ids[cn->nbools++] =3D =
e->boolean;
> >                                 else
> >                                         cn->nbools++;
> >                         }
> > @@ -737,7 +737,7 @@ static int expr_isvalid(policydb_t * p, cond_expr_t=
 * expr)
> >                 return 0;
> >         }
> >
> > -       if (expr->bool > p->p_bools.nprim) {
> > +       if (expr->boolean > p->p_bools.nprim) {
> >                 WARN(NULL, "security: conditional expressions uses unkn=
own bool.");
> >                 return 0;
> >         }
> > @@ -775,7 +775,7 @@ static int cond_read_node(policydb_t * p, cond_node=
_t * node, void *fp)
> >                 memset(expr, 0, sizeof(cond_expr_t));
> >
> >                 expr->expr_type =3D le32_to_cpu(buf[0]);
> > -               expr->bool =3D le32_to_cpu(buf[1]);
> > +               expr->boolean =3D le32_to_cpu(buf[1]);
> >
> >                 if (!expr_isvalid(p, expr)) {
> >                         free(expr);
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 8d19850e..1337c32f 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2025,8 +2025,8 @@ static int cond_node_map_bools(expand_state_t * s=
tate, cond_node_t * cn)
> >
> >         cur =3D cn->expr;
> >         while (cur) {
> > -               if (cur->bool)
> > -                       cur->bool =3D state->boolmap[cur->bool - 1];
> > +               if (cur->boolean)
> > +                       cur->boolean =3D state->boolmap[cur->boolean - =
1];
> >                 cur =3D cur->next;
> >         }
> >
> > @@ -2899,7 +2899,7 @@ static void discard_tunables(sepol_handle_t *sh, =
policydb_t *pol)
> >                              cur_expr =3D cur_expr->next) {
> >                                 if (cur_expr->expr_type !=3D COND_BOOL)
> >                                         continue;
> > -                               booldatum =3D pol->bool_val_to_struct[c=
ur_expr->bool - 1];
> > +                               booldatum =3D pol->bool_val_to_struct[c=
ur_expr->boolean - 1];
> >                                 if (booldatum->flags & COND_BOOL_FLAGS_=
TUNABLE)
> >                                         tmp[tunables++] =3D booldatum;
> >                                 else
> > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.=
c
> > index ad4121d5..e9cd89c2 100644
> > --- a/libsepol/src/kernel_to_cil.c
> > +++ b/libsepol/src/kernel_to_cil.c
> > @@ -43,7 +43,7 @@ static char *cond_expr_to_str(struct policydb *pdb, s=
truct cond_expr *expr)
> >
> >         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
> >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > -                       char *val1 =3D pdb->p_bool_val_to_name[curr->bo=
ol - 1];
> > +                       char *val1 =3D pdb->p_bool_val_to_name[curr->bo=
olean - 1];
> >                         new_val =3D create_str("%s", 1, val1);
> >                 } else {
> >                         const char *op;
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_con=
f.c
> > index 73b72b5d..c48a7114 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -42,7 +42,7 @@ static char *cond_expr_to_str(struct policydb *pdb, s=
truct cond_expr *expr)
> >
> >         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
> >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > -                       char *val1 =3D pdb->p_bool_val_to_name[curr->bo=
ol - 1];
> > +                       char *val1 =3D pdb->p_bool_val_to_name[curr->bo=
olean - 1];
> >                         new_val =3D create_str("%s", 1, val1);
> >                 } else {
> >                         const char *op;
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index cbe4cea4..3b7742bc 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1524,9 +1524,9 @@ static int copy_cond_list(cond_node_t * list, con=
d_node_t ** dst,
> >                         /* expression nodes don't have a bool value of =
0 - don't map them */
> >                         if (cur_expr->expr_type !=3D COND_BOOL)
> >                                 continue;
> > -                       assert(module->map[SYM_BOOLS][cur_expr->bool - =
1] !=3D 0);
> > -                       cur_expr->bool =3D
> > -                           module->map[SYM_BOOLS][cur_expr->bool - 1];
> > +                       assert(module->map[SYM_BOOLS][cur_expr->boolean=
 - 1] !=3D 0);
> > +                       cur_expr->boolean =3D
> > +                           module->map[SYM_BOOLS][cur_expr->boolean - =
1];
> >                 }
> >                 new_node->nbools =3D cur->nbools;
> >                 /* FIXME should COND_MAX_BOOLS be used here? */
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 2b24d33e..e7bc6ee6 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -1272,7 +1272,7 @@ static int cond_expr_to_cil(int indent, struct po=
licydb *pdb, struct cond_expr *
> >
> >         for (curr =3D cond_expr; curr !=3D NULL; curr =3D curr->next) {
> >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > -                       val1 =3D pdb->p_bool_val_to_name[curr->bool - 1=
];
> > +                       val1 =3D pdb->p_bool_val_to_name[curr->boolean =
- 1];
> >                         // length of boolean + 2 parens + null terminat=
or
> >                         len =3D strlen(val1) + 2 + 1;
> >                         new_val =3D malloc(len);
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index 9a9ec40b..301aa200 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -974,7 +974,7 @@ static int validate_cond_expr(sepol_handle_t *handl=
e, const struct cond_expr *ex
> >         for (; expr; expr =3D expr->next) {
> >                 switch(expr->expr_type) {
> >                 case COND_BOOL:
> > -                       if (validate_value(expr->bool, boolean))
> > +                       if (validate_value(expr->boolean, boolean))
> >                                 goto bad;
> >                         if (depth =3D=3D (COND_EXPR_MAXDEPTH - 1))
> >                                 goto bad;
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index a9fdf93a..024fe628 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -834,7 +834,7 @@ static int cond_write_node(policydb_t * p,
> >         for (cur_expr =3D node->expr; cur_expr !=3D NULL; cur_expr =3D =
cur_expr->next) {
> >                 items =3D 0;
> >                 buf[items++] =3D cpu_to_le32(cur_expr->expr_type);
> > -               buf[items++] =3D cpu_to_le32(cur_expr->bool);
> > +               buf[items++] =3D cpu_to_le32(cur_expr->boolean);
> >                 items2 =3D put_entry(buf, sizeof(uint32_t), items, fp);
> >                 if (items2 !=3D items)
> >                         return POLICYDB_ERROR;
> > diff --git a/libsepol/tests/debug.c b/libsepol/tests/debug.c
> > index 90aa6e0a..8494dd25 100644
> > --- a/libsepol/tests/debug.c
> > +++ b/libsepol/tests/debug.c
> > @@ -41,7 +41,7 @@ void display_expr(policydb_t * p, cond_expr_t * exp, =
FILE * fp)
> >         for (cur =3D exp; cur !=3D NULL; cur =3D cur->next) {
> >                 switch (cur->expr_type) {
> >                 case COND_BOOL:
> > -                       fprintf(fp, "%s ", p->p_bool_val_to_name[cur->b=
ool - 1]);
> > +                       fprintf(fp, "%s ", p->p_bool_val_to_name[cur->b=
oolean - 1]);
> >                         break;
> >                 case COND_NOT:
> >                         fprintf(fp, "! ");
> > diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/tes=
t-linker-cond-map.c
> > index 694a7346..6ea0e4c2 100644
> > --- a/libsepol/tests/test-linker-cond-map.c
> > +++ b/libsepol/tests/test-linker-cond-map.c
> > @@ -70,7 +70,7 @@ static void test_cond_expr_mapping(policydb_t * p, av=
rule_decl_t * d, test_cond_
> >
> >                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
> >                 if (bools[i].bool) {
> > -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][=
expr->bool - 1], bools[i].bool) =3D=3D 0);
> > +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS][=
expr->boolean - 1], bools[i].bool) =3D=3D 0);
> >                 }
> >                 expr =3D expr->next;
> >         }
> > --
> > 2.40.0
> >
