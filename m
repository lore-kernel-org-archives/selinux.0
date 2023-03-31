Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FBAC761A6
	for <selinux@archiver.kernel.org>; Fri, 31 Mar 2023 18:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCaS2v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCaS2u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Mar 2023 14:28:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109AF22911
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 11:28:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t10so93044740edd.12
        for <selinux@vger.kernel.org>; Fri, 31 Mar 2023 11:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680287314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxX9xsV8ryxnI1pL7Pv1dG11PGGivu1vfHkGQVksOuA=;
        b=Wz3b9qHMAlTDuV+gP3z4eOdUXgmPnoR1sIaM1aptI2/SkPqjY/nMv7kdty7i19/FtD
         jTgolMpxKpw0F5ULyti3WBfjIV2bVWLyMrd+fti2/XC9mbz2DkPH3VNrBvm19KXkS8mP
         C8DDVzlb9uxwupCWFKIeFMeEyRd4ue7SDRrxmpyQlckFR9YIxiAkuoNBWUOfGSzb/SHn
         GDJ65tL7fsgJUAiPlKyspolKBIxK1YHozv0NzwBbppy9z5tte8zY4OkR2Nk/Wo2UMAJ9
         mWW/Px8b/nxnTIuRphvYLS48rPMC1/KCgVv0UG2vdLwvlr6VpkFMORxdA6RXtJXbveRz
         0wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxX9xsV8ryxnI1pL7Pv1dG11PGGivu1vfHkGQVksOuA=;
        b=NpAAOKBZDTkKvoKoHLtgzhV6OjccUDAtQE83+Jz3OPO/PsJ7vlMurOUeBzNfe1z4qI
         6MA9vHb9UUQSTV4+v+QgN7IuSiCqW3WnRv+tMLx4YxpuyNbXPxTPkEcfZ7VtTi8L+/ZT
         4qrQI0wghhofOXT8sTDHzFSnDRbYn61TRxoFoqAfmHV1jpvYC5rfWLoeSK3zoTkIzlAr
         aZE02BXKllictMpHOqR77fiRhNZUdeCdrcQuK5uBQvNS3M9u4QnSVHgrRBPKDpz38INS
         ZAaL0PSLQ3EdziE2EDVQq53mewMPGTFfBtYBNLRD4hdRXJcCQy23E8CQr3aBGhW2OvUx
         7RXQ==
X-Gm-Message-State: AAQBX9cDf0y2YgX1Jlj5m9WllS1FEdH1wq0GVTFQo2fGZMJgaEiUa8cu
        msncxfS9UoVL4lBVIlaGmoNcbvx+rP6aOsSjEqxfFLNZ
X-Google-Smtp-Source: AKy350aIgpdQiAzlOYf4WIXrcSfBQ0zfm8CO3J7PyX4CEIgVha29ddGn6tJvgi4i8qdICu8a2i0u4gR0O8YUQWIFn7Y=
X-Received: by 2002:a17:906:c357:b0:932:4255:5908 with SMTP id
 ci23-20020a170906c35700b0093242555908mr13807936ejb.5.1680287313913; Fri, 31
 Mar 2023 11:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221114201042.17773-1-cgzones@googlemail.com>
 <CAP+JOzTba6HK+gXGMJjAvCaMQ8G+yhb5xurfB-WwiRSCi0qsLw@mail.gmail.com> <CAJ2a_Df3cLDiHe9GetHWjXBOqUEmDqGSkfpBQoNQ6durAEdV5A@mail.gmail.com>
In-Reply-To: <CAJ2a_Df3cLDiHe9GetHWjXBOqUEmDqGSkfpBQoNQ6durAEdV5A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 31 Mar 2023 14:28:22 -0400
Message-ID: <CAP+JOzRznSwEsKO50b_K74bXXgrz01wqM53fzCLt0MnZdJ-xnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] libsepol: rename struct member
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 1:36=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Thu, 17 Nov 2022 at 22:45, James Carter <jwcart2@gmail.com> wrote:
> >
> > On Mon, Nov 14, 2022 at 3:16 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Avoid using the identifier `bool` to improve support with future C
> > > standards.  C23 is about to make `bool` a predefined macro (see N2654=
).
> > >
> > > Since the struct cond_expr_t is part of the public API it will break
> > > client applications.  A quick code search of the Debian code shows on=
ly
> > > usage in checkpolicy and setools.
> > >
> >
> > Because it will break setools, I think we should hold off on this
> > series until after the upcoming release of the SELinux userspace
> > (which should happen in early to mid December).
> > Jim
>
> Since version 3.5 has been released, could this series please be reconsid=
ered?
>

I am planning on looking at it. I am working on a second version of my
CIL deny rule patch set, but after that I will get to this.
Thanks,
Jim

> >
> > > Define a new macro signaling the renaming to simplify support of clie=
nt
> > > applications for new and older versions of libsepol.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > >  libsepol/cil/src/cil_binary.c                 |  6 +++---
> > >  libsepol/include/sepol/policydb/conditional.h |  4 +++-
> > >  libsepol/src/conditional.c                    | 14 +++++++-------
> > >  libsepol/src/expand.c                         |  6 +++---
> > >  libsepol/src/kernel_to_cil.c                  |  2 +-
> > >  libsepol/src/kernel_to_conf.c                 |  2 +-
> > >  libsepol/src/link.c                           |  6 +++---
> > >  libsepol/src/module_to_cil.c                  |  2 +-
> > >  libsepol/src/policydb_validate.c              |  2 +-
> > >  libsepol/src/write.c                          |  2 +-
> > >  libsepol/tests/debug.c                        |  2 +-
> > >  libsepol/tests/test-linker-cond-map.c         |  2 +-
> > >  12 files changed, 26 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_bin=
ary.c
> > > index 40615db2..ef7f4d70 100644
> > > --- a/libsepol/cil/src/cil_binary.c
> > > +++ b/libsepol/cil/src/cil_binary.c
> > > @@ -2123,7 +2123,7 @@ static int __cil_cond_item_to_sepol_expr(policy=
db_t *pdb, struct cil_list_item *
> > >                 *head =3D cil_malloc(sizeof(cond_expr_t));
> > >                 (*head)->next =3D NULL;
> > >                 (*head)->expr_type =3D COND_BOOL;
> > > -               (*head)->bool =3D sepol_bool->s.value;
> > > +               (*head)->boolean =3D sepol_bool->s.value;
> > >                 *tail =3D *head;
> > >         } else if (item->flavor =3D=3D CIL_LIST) {
> > >                 struct cil_list *l =3D item->data;
> > > @@ -2159,7 +2159,7 @@ static int __cil_cond_expr_to_sepol_expr_helper=
(policydb_t *pdb, struct cil_list
> > >                 enum cil_flavor cil_op =3D (enum cil_flavor)(uintptr_=
t)item->data;
> > >
> > >                 op =3D cil_malloc(sizeof(*op));
> > > -               op->bool =3D 0;
> > > +               op->boolean =3D 0;
> > >                 op->next =3D NULL;
> > >
> > >                 switch (cil_op) {
> > > @@ -2226,7 +2226,7 @@ static int __cil_cond_expr_to_sepol_expr_helper=
(policydb_t *pdb, struct cil_list
> > >                                 goto exit;
> > >                         }
> > >                         op =3D cil_malloc(sizeof(*op));
> > > -                       op->bool =3D 0;
> > > +                       op->boolean =3D 0;
> > >                         op->next =3D NULL;
> > >                         op->expr_type =3D COND_OR;
> > >                         t1->next =3D h2;
> > > diff --git a/libsepol/include/sepol/policydb/conditional.h b/libsepol=
/include/sepol/policydb/conditional.h
> > > index 49c0d766..8d4741d3 100644
> > > --- a/libsepol/include/sepol/policydb/conditional.h
> > > +++ b/libsepol/include/sepol/policydb/conditional.h
> > > @@ -54,7 +54,9 @@ typedef struct cond_expr {
> > >  #define COND_NEQ       7       /* bool !=3D bool */
> > >  #define COND_LAST      COND_NEQ
> > >         uint32_t expr_type;
> > > -       uint32_t bool;
> > > +       /* The member `boolean` was renamed from `bool` in version 3.=
5 */
> > > +#define COND_EXPR_T_RENAME_BOOL_BOOLEAN
> > > +       uint32_t boolean;
> > >         struct cond_expr *next;
> > >  } cond_expr_t;
> > >
> > > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > > index a620451d..24380ea0 100644
> > > --- a/libsepol/src/conditional.c
> > > +++ b/libsepol/src/conditional.c
> > > @@ -125,7 +125,7 @@ int cond_expr_equal(cond_node_t * a, cond_node_t =
* b)
> > >                 if (cur_a->expr_type !=3D cur_b->expr_type)
> > >                         return 0;
> > >                 if (cur_a->expr_type =3D=3D COND_BOOL) {
> > > -                       if (cur_a->bool !=3D cur_b->bool)
> > > +                       if (cur_a->boolean !=3D cur_b->boolean)
> > >                                 return 0;
> > >                 }
> > >                 cur_a =3D cur_a->next;
> > > @@ -223,7 +223,7 @@ int cond_evaluate_expr(policydb_t * p, cond_expr_=
t * expr)
> > >                         if (sp =3D=3D (COND_EXPR_MAXDEPTH - 1))
> > >                                 return -1;
> > >                         sp++;
> > > -                       s[sp] =3D p->bool_val_to_struct[cur->bool - 1=
]->state;
> > > +                       s[sp] =3D p->bool_val_to_struct[cur->boolean =
- 1]->state;
> > >                         break;
> > >                 case COND_NOT:
> > >                         if (sp < 0)
> > > @@ -279,7 +279,7 @@ cond_expr_t *cond_copy_expr(cond_expr_t * expr)
> > >                 memset(new_expr, 0, sizeof(cond_expr_t));
> > >
> > >                 new_expr->expr_type =3D cur->expr_type;
> > > -               new_expr->bool =3D cur->bool;
> > > +               new_expr->boolean =3D cur->boolean;
> > >
> > >                 if (!head)
> > >                         head =3D new_expr;
> > > @@ -388,10 +388,10 @@ int cond_normalize_expr(policydb_t * p, cond_no=
de_t * cn)
> > >                 switch (e->expr_type) {
> > >                 case COND_BOOL:
> > >                         /* see if we've already seen this bool */
> > > -                       if (!bool_present(e->bool, cn->bool_ids, cn->=
nbools)) {
> > > +                       if (!bool_present(e->boolean, cn->bool_ids, c=
n->nbools)) {
> > >                                 /* count em all but only record up to=
 COND_MAX_BOOLS */
> > >                                 if (cn->nbools < COND_MAX_BOOLS)
> > > -                                       cn->bool_ids[cn->nbools++] =
=3D e->bool;
> > > +                                       cn->bool_ids[cn->nbools++] =
=3D e->boolean;
> > >                                 else
> > >                                         cn->nbools++;
> > >                         }
> > > @@ -737,7 +737,7 @@ static int expr_isvalid(policydb_t * p, cond_expr=
_t * expr)
> > >                 return 0;
> > >         }
> > >
> > > -       if (expr->bool > p->p_bools.nprim) {
> > > +       if (expr->boolean > p->p_bools.nprim) {
> > >                 WARN(NULL, "security: conditional expressions uses un=
known bool.");
> > >                 return 0;
> > >         }
> > > @@ -775,7 +775,7 @@ static int cond_read_node(policydb_t * p, cond_no=
de_t * node, void *fp)
> > >                 memset(expr, 0, sizeof(cond_expr_t));
> > >
> > >                 expr->expr_type =3D le32_to_cpu(buf[0]);
> > > -               expr->bool =3D le32_to_cpu(buf[1]);
> > > +               expr->boolean =3D le32_to_cpu(buf[1]);
> > >
> > >                 if (!expr_isvalid(p, expr)) {
> > >                         free(expr);
> > > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > > index 8d19850e..1337c32f 100644
> > > --- a/libsepol/src/expand.c
> > > +++ b/libsepol/src/expand.c
> > > @@ -2025,8 +2025,8 @@ static int cond_node_map_bools(expand_state_t *=
 state, cond_node_t * cn)
> > >
> > >         cur =3D cn->expr;
> > >         while (cur) {
> > > -               if (cur->bool)
> > > -                       cur->bool =3D state->boolmap[cur->bool - 1];
> > > +               if (cur->boolean)
> > > +                       cur->boolean =3D state->boolmap[cur->boolean =
- 1];
> > >                 cur =3D cur->next;
> > >         }
> > >
> > > @@ -2899,7 +2899,7 @@ static void discard_tunables(sepol_handle_t *sh=
, policydb_t *pol)
> > >                              cur_expr =3D cur_expr->next) {
> > >                                 if (cur_expr->expr_type !=3D COND_BOO=
L)
> > >                                         continue;
> > > -                               booldatum =3D pol->bool_val_to_struct=
[cur_expr->bool - 1];
> > > +                               booldatum =3D pol->bool_val_to_struct=
[cur_expr->boolean - 1];
> > >                                 if (booldatum->flags & COND_BOOL_FLAG=
S_TUNABLE)
> > >                                         tmp[tunables++] =3D booldatum=
;
> > >                                 else
> > > diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_ci=
l.c
> > > index ad4121d5..e9cd89c2 100644
> > > --- a/libsepol/src/kernel_to_cil.c
> > > +++ b/libsepol/src/kernel_to_cil.c
> > > @@ -43,7 +43,7 @@ static char *cond_expr_to_str(struct policydb *pdb,=
 struct cond_expr *expr)
> > >
> > >         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
> > >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > > -                       char *val1 =3D pdb->p_bool_val_to_name[curr->=
bool - 1];
> > > +                       char *val1 =3D pdb->p_bool_val_to_name[curr->=
boolean - 1];
> > >                         new_val =3D create_str("%s", 1, val1);
> > >                 } else {
> > >                         const char *op;
> > > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_c=
onf.c
> > > index 63dffd9b..59083479 100644
> > > --- a/libsepol/src/kernel_to_conf.c
> > > +++ b/libsepol/src/kernel_to_conf.c
> > > @@ -42,7 +42,7 @@ static char *cond_expr_to_str(struct policydb *pdb,=
 struct cond_expr *expr)
> > >
> > >         for (curr =3D expr; curr !=3D NULL; curr =3D curr->next) {
> > >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > > -                       char *val1 =3D pdb->p_bool_val_to_name[curr->=
bool - 1];
> > > +                       char *val1 =3D pdb->p_bool_val_to_name[curr->=
boolean - 1];
> > >                         new_val =3D create_str("%s", 1, val1);
> > >                 } else {
> > >                         const char *op;
> > > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > > index cbe4cea4..3b7742bc 100644
> > > --- a/libsepol/src/link.c
> > > +++ b/libsepol/src/link.c
> > > @@ -1524,9 +1524,9 @@ static int copy_cond_list(cond_node_t * list, c=
ond_node_t ** dst,
> > >                         /* expression nodes don't have a bool value o=
f 0 - don't map them */
> > >                         if (cur_expr->expr_type !=3D COND_BOOL)
> > >                                 continue;
> > > -                       assert(module->map[SYM_BOOLS][cur_expr->bool =
- 1] !=3D 0);
> > > -                       cur_expr->bool =3D
> > > -                           module->map[SYM_BOOLS][cur_expr->bool - 1=
];
> > > +                       assert(module->map[SYM_BOOLS][cur_expr->boole=
an - 1] !=3D 0);
> > > +                       cur_expr->boolean =3D
> > > +                           module->map[SYM_BOOLS][cur_expr->boolean =
- 1];
> > >                 }
> > >                 new_node->nbools =3D cur->nbools;
> > >                 /* FIXME should COND_MAX_BOOLS be used here? */
> > > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_ci=
l.c
> > > index b900290a..4e15f8e4 100644
> > > --- a/libsepol/src/module_to_cil.c
> > > +++ b/libsepol/src/module_to_cil.c
> > > @@ -1272,7 +1272,7 @@ static int cond_expr_to_cil(int indent, struct =
policydb *pdb, struct cond_expr *
> > >
> > >         for (curr =3D cond_expr; curr !=3D NULL; curr =3D curr->next)=
 {
> > >                 if (curr->expr_type =3D=3D COND_BOOL) {
> > > -                       val1 =3D pdb->p_bool_val_to_name[curr->bool -=
 1];
> > > +                       val1 =3D pdb->p_bool_val_to_name[curr->boolea=
n - 1];
> > >                         // length of boolean + 2 parens + null termin=
ator
> > >                         len =3D strlen(val1) + 2 + 1;
> > >                         new_val =3D malloc(len);
> > > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb=
_validate.c
> > > index 521ea4ff..d1bc7f03 100644
> > > --- a/libsepol/src/policydb_validate.c
> > > +++ b/libsepol/src/policydb_validate.c
> > > @@ -957,7 +957,7 @@ static int validate_cond_expr(sepol_handle_t *han=
dle, const struct cond_expr *ex
> > >         for (; expr; expr =3D expr->next) {
> > >                 switch(expr->expr_type) {
> > >                 case COND_BOOL:
> > > -                       if (validate_value(expr->bool, boolean))
> > > +                       if (validate_value(expr->boolean, boolean))
> > >                                 goto bad;
> > >                         if (depth =3D=3D (COND_EXPR_MAXDEPTH - 1))
> > >                                 goto bad;
> > > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > > index a9fdf93a..024fe628 100644
> > > --- a/libsepol/src/write.c
> > > +++ b/libsepol/src/write.c
> > > @@ -834,7 +834,7 @@ static int cond_write_node(policydb_t * p,
> > >         for (cur_expr =3D node->expr; cur_expr !=3D NULL; cur_expr =
=3D cur_expr->next) {
> > >                 items =3D 0;
> > >                 buf[items++] =3D cpu_to_le32(cur_expr->expr_type);
> > > -               buf[items++] =3D cpu_to_le32(cur_expr->bool);
> > > +               buf[items++] =3D cpu_to_le32(cur_expr->boolean);
> > >                 items2 =3D put_entry(buf, sizeof(uint32_t), items, fp=
);
> > >                 if (items2 !=3D items)
> > >                         return POLICYDB_ERROR;
> > > diff --git a/libsepol/tests/debug.c b/libsepol/tests/debug.c
> > > index 90aa6e0a..8494dd25 100644
> > > --- a/libsepol/tests/debug.c
> > > +++ b/libsepol/tests/debug.c
> > > @@ -41,7 +41,7 @@ void display_expr(policydb_t * p, cond_expr_t * exp=
, FILE * fp)
> > >         for (cur =3D exp; cur !=3D NULL; cur =3D cur->next) {
> > >                 switch (cur->expr_type) {
> > >                 case COND_BOOL:
> > > -                       fprintf(fp, "%s ", p->p_bool_val_to_name[cur-=
>bool - 1]);
> > > +                       fprintf(fp, "%s ", p->p_bool_val_to_name[cur-=
>boolean - 1]);
> > >                         break;
> > >                 case COND_NOT:
> > >                         fprintf(fp, "! ");
> > > diff --git a/libsepol/tests/test-linker-cond-map.c b/libsepol/tests/t=
est-linker-cond-map.c
> > > index 694a7346..6ea0e4c2 100644
> > > --- a/libsepol/tests/test-linker-cond-map.c
> > > +++ b/libsepol/tests/test-linker-cond-map.c
> > > @@ -70,7 +70,7 @@ static void test_cond_expr_mapping(policydb_t * p, =
avrule_decl_t * d, test_cond_
> > >
> > >                 CU_ASSERT(expr->expr_type =3D=3D bools[i].expr_type);
> > >                 if (bools[i].bool) {
> > > -                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS=
][expr->bool - 1], bools[i].bool) =3D=3D 0);
> > > +                       CU_ASSERT(strcmp(p->sym_val_to_name[SYM_BOOLS=
][expr->boolean - 1], bools[i].bool) =3D=3D 0);
> > >                 }
> > >                 expr =3D expr->next;
> > >         }
> > > --
> > > 2.38.1
> > >
