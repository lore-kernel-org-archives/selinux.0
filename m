Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8039C001B0
	for <selinux@archiver.kernel.org>; Wed, 16 Aug 2023 17:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjHPRsf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Aug 2023 13:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345011AbjHPRsF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Aug 2023 13:48:05 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB1F7
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:48:01 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b962c226ceso106294281fa.3
        for <selinux@vger.kernel.org>; Wed, 16 Aug 2023 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692208079; x=1692812879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9P63/0cdJSmWqnqNgSO+1S4CLlJcuYJDyLTQ0AyPWM=;
        b=JaJmHRYPsLc2KpVJhezudawNc1MZv7HCbPilperXBNJu+HfSG/91EReWV2hfkMZ19p
         IaZlcZFDC4l8Dr32FG1fsPzMG+RLa6zFpklefPxDzzwdmnWwpv4+3I1v+C5YQeteUPgz
         +EZ2J9hjoweOh2S3XdnezvL0fYanwaqzPB34oMem83rILXa6OecOA8HeD2WKhwLeHmMS
         jzq768oCQgAZXMcrMaq/y6o2MT54DaKK79/U9hXYHj2zV1G7yTJgcCQgj7Fq0s5OT4OF
         P8PEhAcu+PiWyZbNF98YbgUZdKvZEChNL3lkTyD7v19tUxSWPhkfp+ui4grIQFn3qvux
         xL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208079; x=1692812879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9P63/0cdJSmWqnqNgSO+1S4CLlJcuYJDyLTQ0AyPWM=;
        b=jdeIwUH32PJiT8mLKBsaZNeCAlclDHGLjaBm7baXivxrJhTcr9Aki8oG/yMBZUwhig
         XUk9j+onCZbnE2O0/X+TwAjq0Qzg6/BlWPIV/5LdfuetXvzPZY8vsCjU50DSwzAuUkGo
         8kmiHUgWVDiONsmJLg5M+WQkIc3sDb6GUF5dUoEnCuoANDvB5LQkx9dN9PFaOk0h/bMd
         IAtmtEl+L/BYNZlN3xrymRTJgAKbKdXsrZ92XbX4fPKJVRKCPFi9YFeIcnlLg07aO/xb
         lu5rZucuii+n6Z2tnS20xV2yem2/FMSWKD7k1iTSKZqQ2ErRQSimXuaJefH5mUwB/Hfv
         Z9Yg==
X-Gm-Message-State: AOJu0YyujDHONiunYd4COtZwX7UEUWoPJrRyubM//01XnJ4hzjTVoVKE
        FUeJxCV9Wl3u3aBYDAGNCXT81k0sZwUBJY3ldwUlZCNU39g=
X-Google-Smtp-Source: AGHT+IGvvbsHzf0VpMo2x7dUbTFBf8knTiEubRM5Q9g+QWSUEn9q4cxeC8DiBSjkppJpPM3iIALuSr16/VxKy3MaugQ=
X-Received: by 2002:a2e:9bd0:0:b0:2b6:cf64:7a8e with SMTP id
 w16-20020a2e9bd0000000b002b6cf647a8emr2036787ljj.19.1692208078571; Wed, 16
 Aug 2023 10:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230809210157.112275-1-jwcart2@gmail.com> <20230809210157.112275-5-jwcart2@gmail.com>
In-Reply-To: <20230809210157.112275-5-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Aug 2023 13:47:47 -0400
Message-ID: <CAP+JOzQCsAS2190hoSfaYC1vwR-FVH15r5GCO1OL=Z4kFaG7Cw@mail.gmail.com>
Subject: Re: [PATCH 4/9 v4] libsepol/cil: Process deny rules
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 9, 2023 at 5:02=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> A deny rule is like a neverallow rule, except that permissions are
> removed rather than an error reported.
>
> (allow S1 T1 P1)
> (deny  S2 T2 P2)
>
> First, write the allow rule with all of the permissions not in the deny r=
ule
> P3 =3D P1 and not P2
> (allow S1 T1 P3)
>
> Obviously, the rule is only written if P3 is not an empty list. This goes
> for the rest of the rules as well--they are only written if the source an=
d
> target exist.
>
> The remaining rules will only involve the common permissions
> P4 =3D P1 and P2
>
> Next, write the allow rule for any types in S1 that are not in S2
> S3 =3D S1 and not S2
> (allow S3 T1 P4)
>
> Finally, write the allow rules needed to cover the types in T1 that are
> not in T2. Since, T1 and T2 might be "self", "notself", or "other", this
> requires more complicated handling. Any rule with "self" will not match
> a rule with either "notself" or "other".
>
> if (T1 is self and T2 is self) or (T1 is notself and T2 is notself) then
>   Nothing more needs to be done.
>
> The rest of the rules will depend on the intersection of S1 and S2
> which cannot be the empty set since the allow and deny rules match.
> S4 =3D S1 and S2
>
> if T1 is notself or T1 is other or T2 is notself or T2 is other then
>   if T1 is notself then
>     if T2 is other then
>       T =3D ALL and not S2
>       (allow S4 T P4)
>     else [T2 is not self, notself, or other]
>       S5 =3D S4 and not T2
>       S6 =3D S4 and T2
>       TA =3D ALL and not T2
>       TB =3D TA and not S4
>       (allow S6 TA P4)
>       (allow S5 TB P4)
>       if cardinality(S5) > 1 then
>         (allow S5 other P4)
>   else if T1 is other then
>     (allow S3 S4 P4)
>     if T2 is notself then
>       [Nothing else is needed]
>     else if T2 is other then
>       (allow S4 S3 P4)
>     else [T2 is not self, notself, or other]
>       S5 =3D S4 and not T2
>       S6 =3D S4 and T2
>       TC =3D S1 and not T2
>       TD =3D S3 and not T2
>       (allow S6 TC P4)
>       (allow S5 TD P4)
>       if cardinality(S5) > 1 then
>         (allow S5 other P4)
>   else [T1 is not self, notself, or other]
>     S8 =3D S4 and T1
>     (allow S8 self P4)
>     if T2 is notself then
>       [Nothing else is needed]
>     else [T2 is other]
>       T =3D T1 and not S2
>       (allow S4 T P4)
> else [Neither T1 nor T2 are notself or other]
>   if T1 is self and T2 is not self then
>     S5 =3D S4 and not T2
>     (allow S5 self P4)
>   else if T1 is not self and T2 is self then
>     S7 =3D S4 and not T1
>     S8 =3D S4 and T1
>     T8 =3D T1 and not S4
>     (allow S7 T1 P4)
>     (allow S8 T8 P4)
>     if cardinality(S8) > 1 then
>       (allow S8 other P4)
>   else [Neither T1 nor T2 is self]
>     T3 =3D T1 and not T2
>     (allow S4 T3 P4)
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_deny.c | 1413 +++++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_deny.h |   36 +
>  libsepol/cil/src/cil_post.c |    7 +
>  3 files changed, 1456 insertions(+)
>  create mode 100644 libsepol/cil/src/cil_deny.c
>  create mode 100644 libsepol/cil/src/cil_deny.h
>
> diff --git a/libsepol/cil/src/cil_deny.c b/libsepol/cil/src/cil_deny.c
> new file mode 100644
> index 00000000..8db6177d
> --- /dev/null
> +++ b/libsepol/cil/src/cil_deny.c
> @@ -0,0 +1,1413 @@
> +/*
> + * This file is public domain software, i.e. not copyrighted.
> + *
> + * Warranty Exclusion
> + * ------------------
> + * You agree that this software is a non-commercially developed program
> + * that may contain "bugs" (as that term is used in the industry) and
> + * that it may not function as intended. The software is licensed
> + * "as is". NSA makes no, and hereby expressly disclaims all, warranties=
,
> + * express, implied, statutory, or otherwise with respect to the softwar=
e,
> + * including noninfringement and the implied warranties of merchantabili=
ty
> + * and fitness for a particular purpose.
> + *
> + * Limitation of Liability
> + *-----------------------
> + * In no event will NSA be liable for any damages, including loss of dat=
a,
> + * lost profits, cost of cover, or other special, incidental, consequent=
ial,
> + * direct or indirect damages arising from the software or the use there=
of,
> + * however caused and on any theory of liability. This limitation will a=
pply
> + * even if NSA has been advised of the possibility of such damage. You
> + * acknowledge that this is a reasonable allocation of risk.
> + *
> + * Original author: James Carter
> + */
> +
> +#include <sepol/policydb/ebitmap.h>
> +
> +#include "cil_internal.h"
> +#include "cil_find.h"
> +#include "cil_flavor.h"
> +#include "cil_list.h"
> +#include "cil_strpool.h"
> +#include "cil_log.h"
> +#include "cil_symtab.h"
> +#include "cil_build_ast.h"
> +#include "cil_copy_ast.h"
> +#include "cil_deny.h"
> +
> +#define CIL_DENY_ATTR_PREFIX "deny_rule_attr"
> +
> +/*
> + * A deny rule is like a neverallow rule, except that permissions are
> + * removed rather than an error reported.
> + *
> + * (allow S1 T1 P1)
> + * (deny  S2 T2 P2)
> + *
> + * First, write the allow rule with all of the permissions not in the de=
ny rule
> + * P3 =3D P1 and not P2
> + * (allow S1 T1 P3)
> + *
> + * Obviously, the rule is only written if P3 is not an empty list. This =
goes
> + * for the rest of the rules as well--they are only written if the sourc=
e and
> + * target exist.
> + *
> + * The remaining rules will only involve the common permissions
> + * P4 =3D P1 and P2
> + *
> + * Next, write the allow rule for any types in S1 that are not in S2
> + * S3 =3D S1 and not S2
> + * (allow S3 T1 P4)
> + *
> + * Finally, write any allow rules needed to cover the types in T1 that a=
re
> + * not in T2. Since, T1 and T2 might be "self", "notself", or "other", t=
his
> + * requires more complicated handling. Any rule with "self" will not mat=
ch
> + * a rule with either "notself" or "other".
> + *
> + * if (T1 is self and T2 is self) or (T1 is notself and T2 is notself) t=
hen
> + *   Nothing more needs to be done.
> + *
> + * The rest of the rules will depend on the intersection of S1 and S2
> + * which cannot be the empty set since the allow and deny rules match.
> + * S4 =3D S1 and S2
> + *
> + * if T1 is notself or T1 is other or T2 is notself or T2 is other then
> + *   if T1 is notself then
> + *     if T2 is other then
> + *       T =3D ALL and not S2
> + *       (allow S4 T P4)
> + *     else [T2 is not self, notself, or other]
> + *       S5 =3D S4 and not T2
> + *       S6 =3D S4 and T2
> + *       TA =3D ALL and not T2
> + *       TB =3D TA and not S4
> + *       (allow S6 TA P4)
> + *       (allow S5 TB P4)
> + *       if cardinality(S5) > 1 then
> + *         (allow S5 other P4)
> + *   else if T1 is other then
> + *     (allow S3 S4 P4)
> + *     if T2 is notself then
> + *       [Nothing else is needed]
> + *     else if T2 is other then
> + *       (allow S4 S3 P4)
> + *     else [T2 is not self, notself, or other]
> + *       S5 =3D S4 and not T2
> + *       S6 =3D S4 and T2
> + *       TC =3D S1 and not T2
> + *       TD =3D S3 and not T2
> + *       (allow S6 TC P4)
> + *       (allow S5 TD P4)
> + *       if cardinality(S5) > 1 then
> + *         (allow S5 other P4)
> + *   else [T1 is not self, notself, or other]
> + *     S8 =3D S4 and T1
> + *     (allow S8 self P4)
> + *     if T2 is notself then
> + *       [Nothing else is needed]
> + *     else [T2 is other]
> + *       T =3D T1 and not S2
> + *       (allow S4 T P4)
> + * else [Neither T1 nor T2 are notself or other]
> + *   if T1 is self and T2 is not self then
> + *     S5 =3D S4 and not T2
> + *     (allow S5 self P4)
> + *   else if T1 is not self and T2 is self then
> + *     S7 =3D S4 and not T1
> + *     S8 =3D S4 and T1
> + *     T8 =3D T1 and not S4
> + *     (allow S7 T1 P4)
> + *     (allow S8 T8 P4)
> + *     if cardinality(S8) > 1 then
> + *       (allow S8 other P4)
> + *   else [Neither T1 nor T2 is self]
> + *     T3 =3D T1 and not T2
> + *     (allow S4 T3 P4)
> + */
> +
> +static int cil_perm_match(const struct cil_perm *p1, const struct cil_li=
st *pl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       cil_list_for_each(curr, pl2) {
> +               struct cil_perm *p =3D curr->data;
> +               if (p =3D=3D p1) {
> +                       return CIL_TRUE;
> +               }
> +       }
> +       return CIL_FALSE;
> +}
> +
> +static int cil_class_perm_match(const struct cil_class *c1, const struct=
 cil_perm *p1, const struct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       cil_list_for_each(curr, cpl2) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *cp =3D curr->data;
> +                       if (FLAVOR(cp->class) =3D=3D CIL_CLASS) {
> +                               if (cp->class =3D=3D c1) {
> +                                       if (cil_perm_match(p1, cp->perms)=
) {
> +                                               return CIL_TRUE;
> +                                       }
> +                               }
> +                       } else { /* MAP */
> +                               struct cil_list_item *p;
> +                               cil_list_for_each(p, cp->perms) {
> +                                       struct cil_perm *cmp =3D p->data;
> +                                       if (cil_class_perm_match(c1, p1, =
cmp->classperms)) {
> +                                               return CIL_TRUE;
> +                                       }
> +                               }
> +                       }
> +               } else { /* SET */
> +                       struct cil_classperms_set *cp_set =3D curr->data;
> +                       struct cil_classpermission *cp =3D cp_set->set;
> +                       if (cil_class_perm_match(c1, p1, cp->classperms))=
 {
> +                               return CIL_TRUE;
> +                       }
> +               }
> +       }
> +       return CIL_FALSE;
> +}
> +
> +static int cil_classperms_match_any(const struct cil_classperms *cp1, co=
nst struct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       cil_list_for_each(curr, cp1->perms) {
> +               struct cil_perm *perm =3D curr->data;
> +               if (cil_class_perm_match(cp1->class, perm, cpl2)) {
> +                       return CIL_TRUE;
> +               }
> +       }
> +       return CIL_FALSE;
> +}
> +
> +int cil_classperms_list_match_any(const struct cil_list *cpl1, const str=
uct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       if (!cpl1 || !cpl2) {
> +               return (!cpl1 && !cpl2) ? CIL_TRUE : CIL_FALSE;
> +       }
> +
> +       cil_list_for_each(curr, cpl1) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *cp =3D curr->data;
> +                       if (FLAVOR(cp->class) =3D=3D CIL_CLASS) {
> +                               if (cil_classperms_match_any(cp, cpl2)) {
> +                                       return CIL_TRUE;
> +                               }
> +                       } else { /* MAP */
> +                               struct cil_list_item *p;
> +                               cil_list_for_each(p, cp->perms) {
> +                                       struct cil_perm *cmp =3D p->data;
> +                                       if (cil_classperms_list_match_any=
(cmp->classperms, cpl2)) {
> +                                               return CIL_TRUE;
> +                                       }
> +                               }
> +                       }
> +               } else { /* SET */
> +                       struct cil_classperms_set *cp_set =3D curr->data;
> +                       struct cil_classpermission *cp =3D cp_set->set;
> +                       if (cil_classperms_list_match_any(cp->classperms,=
 cpl2)) {
> +                               return CIL_TRUE;
> +                       }
> +               }
> +       }
> +       return CIL_FALSE;
> +}
> +
> +static int cil_classperms_match_all(const struct cil_classperms *cp1, co=
nst struct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       cil_list_for_each(curr, cp1->perms) {
> +               struct cil_perm *perm =3D curr->data;
> +               if (!cil_class_perm_match(cp1->class, perm, cpl2)) {
> +                       return CIL_FALSE;
> +               }
> +       }
> +       return CIL_TRUE;
> +}
> +
> +int cil_classperms_list_match_all(const struct cil_list *cpl1, const str=
uct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       if (!cpl1 || !cpl2) {
> +               return (!cpl1 && !cpl2) ? CIL_TRUE : CIL_FALSE;
> +       }
> +
> +       cil_list_for_each(curr, cpl1) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *cp =3D curr->data;
> +                       if (FLAVOR(cp->class) =3D=3D CIL_CLASS) {
> +                               if (!cil_classperms_match_all(cp, cpl2)) =
{
> +                                       return CIL_FALSE;
> +                               }
> +                       } else { /* MAP */
> +                               struct cil_list_item *p;
> +                               cil_list_for_each(p, cp->perms) {
> +                                       struct cil_perm *cmp =3D p->data;
> +                                       if (!cil_classperms_list_match_al=
l(cmp->classperms, cpl2)) {
> +                                               return CIL_FALSE;
> +                                       }
> +                               }
> +                       }
> +               } else { /* SET */
> +                       struct cil_classperms_set *cp_set =3D curr->data;
> +                       struct cil_classpermission *cp =3D cp_set->set;
> +                       if (!cil_classperms_list_match_all(cp->classperms=
, cpl2)) {
> +                               return CIL_FALSE;
> +                       }
> +               }
> +       }
> +       return CIL_TRUE;
> +}
> +
> +static void cil_classperms_copy(struct cil_classperms **new, const struc=
t cil_classperms *old)
> +{
> +       cil_classperms_init(new);
> +       (*new)->class_str =3D old->class_str;
> +       (*new)->class =3D old->class;
> +       cil_copy_list(old->perm_strs, &(*new)->perm_strs);
> +       cil_copy_list(old->perms, &(*new)->perms);
> +}
> +
> +static void cil_classperms_set_copy(struct cil_classperms_set **new, con=
st struct cil_classperms_set *old)
> +{
> +       cil_classperms_set_init(new);
> +       (*new)->set_str =3D old->set_str;
> +       (*new)->set =3D old->set;
> +}
> +
> +void cil_classperms_list_copy(struct cil_list **new, const struct cil_li=
st *old)
> +{
> +       struct cil_list_item *curr;
> +
> +       if (!new) {
> +               return;
> +       }
> +
> +       if (!old) {
> +               *new =3D NULL;
> +               return;
> +       }
> +
> +       cil_list_init(new, CIL_LIST);
> +
> +       cil_list_for_each(curr, old) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *new_cp;
> +                       cil_classperms_copy(&new_cp, curr->data);
> +                       cil_list_append(*new, CIL_CLASSPERMS, new_cp);
> +               } else { /* SET */
> +                       struct cil_classperms_set *new_cps;
> +                       cil_classperms_set_copy(&new_cps, curr->data);
> +                       cil_list_append(*new, CIL_CLASSPERMS_SET, new_cps=
);
> +               }
> +       }
> +
> +       if (cil_list_is_empty(*new)) {
> +               cil_list_destroy(new, CIL_FALSE);
> +       }
> +}
> +
> +/* Append cp1 and cpl2 to result */
> +static void cil_classperms_and(struct cil_list **result, const struct ci=
l_classperms *cp1, const struct cil_list *cpl2)
> +{
> +       struct cil_classperms *new_cp =3D NULL;
> +       struct cil_list_item *curr;
> +
> +       if (cil_classperms_match_all(cp1, cpl2)) {
> +               cil_classperms_copy(&new_cp, cp1);
> +               cil_list_append(*result, CIL_CLASSPERMS, new_cp);
> +               return;
> +       }
> +
> +       cil_list_for_each(curr, cp1->perms) {
> +               struct cil_perm *perm =3D curr->data;
> +               if (cil_class_perm_match(cp1->class, perm, cpl2)) {
> +                       if (new_cp =3D=3D NULL) {
> +                               cil_classperms_init(&new_cp);
> +                               new_cp->class_str =3D cp1->class_str;
> +                               new_cp->class =3D cp1->class;
> +                               cil_list_init(&new_cp->perm_strs, CIL_PER=
M);
> +                               cil_list_init(&new_cp->perms, CIL_PERM);
> +                               cil_list_append(*result, CIL_CLASSPERMS, =
new_cp);
> +                       }
> +                       cil_list_append(new_cp->perm_strs, CIL_STRING, pe=
rm->datum.fqn);
> +                       cil_list_append(new_cp->perms, CIL_DATUM, perm);
> +               }
> +       }
> +}
> +
> +/* Append cp1 and cpl2 to result */
> +static void cil_classperms_map_and(struct cil_list **result, const struc=
t cil_classperms *cp1, const struct cil_list *cpl2)
> +{
> +       struct cil_classperms *new_cp =3D NULL;
> +       struct cil_list_item *p;
> +
> +       cil_list_for_each(p, cp1->perms) {
> +               struct cil_perm *map_perm =3D p->data;
> +               if (cil_classperms_list_match_all(map_perm->classperms, c=
pl2)) {
> +                       if (new_cp =3D=3D NULL) {
> +                               cil_classperms_init(&new_cp);
> +                               new_cp->class_str =3D cp1->class_str;
> +                               new_cp->class =3D cp1->class;
> +                               cil_list_init(&new_cp->perm_strs, CIL_PER=
M);
> +                               cil_list_init(&new_cp->perms, CIL_PERM);
> +                               cil_list_append(*result, CIL_CLASSPERMS, =
new_cp);
> +                       }
> +                       cil_list_append(new_cp->perm_strs, CIL_STRING, ma=
p_perm->datum.fqn);
> +                       cil_list_append(new_cp->perms, CIL_DATUM, map_per=
m);
> +               } else {
> +                       struct cil_list *new_cpl =3D NULL;
> +                       cil_classperms_list_and(&new_cpl, map_perm->class=
perms, cpl2);
> +                       if (new_cpl) {
> +                               struct cil_list_item *i;
> +                               cil_list_for_each(i, new_cpl) {
> +                                       cil_list_append(*result, i->flavo=
r, i->data);
> +                               }
> +                               cil_list_destroy(&new_cpl, CIL_FALSE);
> +                       }
> +               }
> +       }
> +}
> +
> +/* Append cps1 and cpl2 to result */
> +static void cil_classperms_set_and(struct cil_list **result, const struc=
t cil_classperms_set *cps1, const struct cil_list *cpl2)
> +{
> +       struct cil_classpermission *cp =3D cps1->set;
> +
> +       if (cil_classperms_list_match_all(cp->classperms, cpl2)) {
> +               struct cil_classperms_set *new_cps;
> +               cil_classperms_set_copy(&new_cps, cps1);
> +               cil_list_append(*result, CIL_CLASSPERMS_SET, new_cps);
> +       } else {
> +               struct cil_list *new_cpl;
> +               cil_classperms_list_and(&new_cpl, cp->classperms, cpl2);
> +               if (new_cpl) {
> +                       struct cil_list_item *i;
> +                       cil_list_for_each(i, new_cpl) {
> +                               cil_list_append(*result, i->flavor, i->da=
ta);
> +                       }
> +                       cil_list_destroy(&new_cpl, CIL_FALSE);
> +               }
> +       }
> +}
> +
> +/* result =3D cpl1 and cpl2 */
> +void cil_classperms_list_and(struct cil_list **result, const struct cil_=
list *cpl1, const struct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       if (!result) {
> +               return;
> +       }
> +
> +       if (!cpl1 || !cpl2) {
> +               *result =3D NULL;
> +               return;
> +       }
> +
> +       if (cil_classperms_list_match_all(cpl1, cpl2)) {
> +               cil_classperms_list_copy(result, cpl1);
> +               return;
> +       }
> +
> +       cil_list_init(result, CIL_LIST);
> +
> +       cil_list_for_each(curr, cpl1) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *cp =3D curr->data;
> +                       if (FLAVOR(cp->class) =3D=3D CIL_CLASS) {
> +                               cil_classperms_and(result, cp, cpl2);
> +                       } else { /* MAP */
> +                               cil_classperms_map_and(result, cp, cpl2);
> +                       }
> +               } else { /* SET */
> +                       struct cil_classperms_set *cps =3D curr->data;
> +                       cil_classperms_set_and(result, cps, cpl2);
> +               }
> +       }
> +
> +       if (cil_list_is_empty(*result)) {
> +               cil_list_destroy(result, CIL_FALSE);
> +       }
> +}
> +
> +/* Append cp1 and not cpl2 to result */
> +static void cil_classperms_andnot(struct cil_list **result, const struct=
 cil_classperms *cp1, const struct cil_list *cpl2)
> +{
> +       struct cil_classperms *new_cp =3D NULL;
> +       struct cil_list_item *curr;
> +
> +       if (!cil_classperms_match_any(cp1, cpl2)) {
> +               cil_classperms_copy(&new_cp, cp1);
> +               cil_list_append(*result, CIL_CLASSPERMS, new_cp);
> +               return;
> +       }
> +
> +       cil_list_for_each(curr, cp1->perms) {
> +               struct cil_perm *perm =3D curr->data;
> +               if (!cil_class_perm_match(cp1->class, perm, cpl2)) {
> +                       if (new_cp =3D=3D NULL) {
> +                               cil_classperms_init(&new_cp);
> +                               new_cp->class_str =3D cp1->class_str;
> +                               new_cp->class =3D cp1->class;
> +                               cil_list_init(&new_cp->perm_strs, CIL_PER=
M);
> +                               cil_list_init(&new_cp->perms, CIL_PERM);
> +                               cil_list_append(*result, CIL_CLASSPERMS, =
new_cp);
> +                       }
> +                       cil_list_append(new_cp->perm_strs, CIL_STRING, pe=
rm->datum.fqn);
> +                       cil_list_append(new_cp->perms, CIL_DATUM, perm);
> +               }
> +       }
> +}
> +
> +/* Append cp1 and not cpl2 to result */
> +static void cil_classperms_map_andnot(struct cil_list **result, const st=
ruct cil_classperms *cp1, const struct cil_list *cpl2)
> +{
> +       struct cil_classperms *new_cp =3D NULL;
> +       struct cil_list_item *p;
> +
> +       cil_list_for_each(p, cp1->perms) {
> +               struct cil_perm *map_perm =3D p->data;
> +               if (!cil_classperms_list_match_any(map_perm->classperms, =
cpl2)) {
> +                       if (new_cp =3D=3D NULL) {
> +                               cil_classperms_init(&new_cp);
> +                               new_cp->class_str =3D cp1->class_str;
> +                               new_cp->class =3D cp1->class;
> +                               cil_list_init(&new_cp->perm_strs, CIL_PER=
M);
> +                               cil_list_init(&new_cp->perms, CIL_PERM);
> +                               cil_list_append(*result, CIL_CLASSPERMS, =
new_cp);
> +                       }
> +                       cil_list_append(new_cp->perm_strs, CIL_STRING, ma=
p_perm->datum.fqn);
> +                       cil_list_append(new_cp->perms, CIL_DATUM, map_per=
m);
> +               } else {
> +                       struct cil_list *new_cpl =3D NULL;
> +                       cil_classperms_list_andnot(&new_cpl, map_perm->cl=
assperms, cpl2);
> +                       if (new_cpl) {
> +                               struct cil_list_item *i;
> +                               cil_list_for_each(i, new_cpl) {
> +                                       cil_list_append(*result, i->flavo=
r, i->data);
> +                               }
> +                               cil_list_destroy(&new_cpl, CIL_FALSE);
> +                       }
> +               }
> +       }
> +}
> +
> +/* Append cps1 and not cpl2 to result */
> +static void cil_classperms_set_andnot(struct cil_list **result, const st=
ruct cil_classperms_set *cps1, const struct cil_list *cpl2)
> +{
> +       struct cil_classpermission *cp =3D cps1->set;
> +
> +       if (!cil_classperms_list_match_any(cp->classperms, cpl2)) {
> +               struct cil_classperms_set *new_cps;
> +               cil_classperms_set_copy(&new_cps, cps1);
> +               cil_list_append(*result, CIL_CLASSPERMS_SET, new_cps);
> +       } else {
> +               struct cil_list *new_cpl;
> +               cil_classperms_list_andnot(&new_cpl, cp->classperms, cpl2=
);
> +               if (new_cpl) {
> +                       struct cil_list_item *i;
> +                       cil_list_for_each(i, new_cpl) {
> +                               cil_list_append(*result, i->flavor, i->da=
ta);
> +                       }
> +                       cil_list_destroy(&new_cpl, CIL_FALSE);
> +               }
> +       }
> +}
> +
> +/* result =3D cpl1 and not cpl2 */
> +void cil_classperms_list_andnot(struct cil_list **result, const struct c=
il_list *cpl1, const struct cil_list *cpl2)
> +{
> +       struct cil_list_item *curr;
> +
> +       if (!result) {
> +               return;
> +       }
> +
> +       if (!cpl1) {
> +               *result =3D NULL;
> +               return;
> +       }
> +
> +       if (!cpl2 || !cil_classperms_list_match_any(cpl1, cpl2)) {
> +               cil_classperms_list_copy(result, cpl1);
> +               return;
> +       }
> +
> +       cil_list_init(result, CIL_LIST);
> +
> +       cil_list_for_each(curr, cpl1) {
> +               if (curr->flavor =3D=3D CIL_CLASSPERMS) {
> +                       struct cil_classperms *cp =3D curr->data;
> +                       if (FLAVOR(cp->class) =3D=3D CIL_CLASS) {
> +                               cil_classperms_andnot(result, cp, cpl2);
> +                       } else { /* MAP */
> +                               cil_classperms_map_andnot(result, cp, cpl=
2);
> +                       }
> +               } else { /* SET */
> +                       struct cil_classperms_set *cps =3D curr->data;
> +                       cil_classperms_set_andnot(result, cps, cpl2);
> +               }
> +       }
> +
> +       if (cil_list_is_empty(*result)) {
> +               cil_list_destroy(result, CIL_FALSE);
> +       }
> +}
> +
> +static int cil_datum_cardinality(const struct cil_symtab_datum *d)
> +{
> +       if (!d) {
> +               return 0;
> +       }
> +       if (FLAVOR(d) !=3D CIL_TYPEATTRIBUTE) {
> +               return 1;
> +       } else {
> +               struct cil_typeattribute *a =3D (struct cil_typeattribute=
 *)d;
> +               return ebitmap_cardinality(a->types);
> +       }
> +}
> +
> +/* result =3D ALL and not d2 */
> +static int cil_datum_not(ebitmap_t *result, const struct cil_symtab_datu=
m *d, int max)
> +{
> +       int rc =3D SEPOL_OK;
> +
> +       if (FLAVOR(d) !=3D CIL_TYPEATTRIBUTE) {
> +               struct cil_type *t =3D (struct cil_type *)d;
> +               ebitmap_t e;
> +
> +               ebitmap_init(&e);
> +               rc =3D ebitmap_set_bit(&e, t->value, 1);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(&e);
> +                       goto exit;
> +               }
> +
> +               ebitmap_init(result);
> +               rc =3D ebitmap_not(result, &e, max);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(&e);
> +                       ebitmap_destroy(result);
> +                       goto exit;
> +               }
> +               ebitmap_destroy(&e);
> +       } else {
> +               struct cil_typeattribute *a =3D (struct cil_typeattribute=
 *)d;
> +
> +               ebitmap_init(result);
> +               rc =3D ebitmap_not(result, a->types, max);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(result);
> +                       goto exit;
> +               }
> +       }
> +exit:
> +       return rc;
> +}
> +
> +/* result =3D d1 and d2 */
> +static int cil_datums_and(ebitmap_t *result, const struct cil_symtab_dat=
um *d1, const struct cil_symtab_datum *d2)
> +{
> +       int rc =3D SEPOL_OK;
> +       enum cil_flavor f1 =3D FLAVOR(d1);
> +       enum cil_flavor f2 =3D FLAVOR(d2);
> +
> +       if (f1 !=3D CIL_TYPEATTRIBUTE && f2 !=3D CIL_TYPEATTRIBUTE) {
> +               struct cil_type *t1 =3D (struct cil_type *)d1;
> +               struct cil_type *t2 =3D (struct cil_type *)d2;
> +               ebitmap_init(result);
> +               if (t1->value =3D=3D t2->value) {
> +                       rc =3D ebitmap_set_bit(result, t1->value, 1);
> +                       if (rc !=3D SEPOL_OK) {
> +                               ebitmap_destroy(result);
> +                               goto exit;
> +                       }
> +               }
> +       } else if (f1 =3D=3D CIL_TYPEATTRIBUTE && f2 !=3D CIL_TYPEATTRIBU=
TE) {
> +               struct cil_typeattribute *a1 =3D (struct cil_typeattribut=
e *)d1;
> +               struct cil_type *t2 =3D (struct cil_type *)d2;
> +               ebitmap_init(result);
> +               if (ebitmap_get_bit(a1->types, t2->value)) {
> +                       rc =3D ebitmap_set_bit(result, t2->value, 1);
> +                       if (rc !=3D SEPOL_OK) {
> +                               ebitmap_destroy(result);
> +                               goto exit;
> +                       }
> +               }
> +       } else if (f1 !=3D CIL_TYPEATTRIBUTE && f2 =3D=3D CIL_TYPEATTRIBU=
TE) {
> +               struct cil_type *t1 =3D (struct cil_type *)d1;
> +               struct cil_typeattribute *a2 =3D (struct cil_typeattribut=
e *)d2;
> +               ebitmap_init(result);
> +               if (ebitmap_get_bit(a2->types, t1->value)) {
> +                       rc =3D ebitmap_set_bit(result, t1->value, 1);
> +                       if (rc !=3D SEPOL_OK) {
> +                               ebitmap_destroy(result);
> +                               goto exit;
> +                       }
> +               }
> +       } else {
> +               /* Both are attributes */
> +               struct cil_typeattribute *a1 =3D (struct cil_typeattribut=
e *)d1;
> +               struct cil_typeattribute *a2 =3D (struct cil_typeattribut=
e *)d2;
> +               rc =3D ebitmap_and(result, a1->types, a2->types);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(result);
> +                       goto exit;
> +               }
> +       }
> +exit:
> +       return rc;
> +}
> +
> +/* result =3D d1 and not d2 */
> +static int cil_datums_andnot(ebitmap_t *result, const struct cil_symtab_=
datum *d1, const struct cil_symtab_datum *d2)
> +{
> +       int rc =3D SEPOL_OK;
> +       enum cil_flavor f1 =3D FLAVOR(d1);
> +       enum cil_flavor f2 =3D FLAVOR(d2);
> +
> +       if (f1 !=3D CIL_TYPEATTRIBUTE && f2 !=3D CIL_TYPEATTRIBUTE) {
> +               struct cil_type *t1 =3D (struct cil_type *)d1;
> +               struct cil_type *t2 =3D (struct cil_type *)d2;
> +               ebitmap_init(result);
> +               if (t1->value !=3D t2->value) {
> +                       rc =3D ebitmap_set_bit(result, t1->value, 1);
> +                       if (rc !=3D SEPOL_OK) {
> +                               ebitmap_destroy(result);
> +                               goto exit;
> +                       }
> +               }
> +       } else if (f1 =3D=3D CIL_TYPEATTRIBUTE && f2 !=3D CIL_TYPEATTRIBU=
TE) {
> +               struct cil_typeattribute *a1 =3D (struct cil_typeattribut=
e *)d1;
> +               struct cil_type *t2 =3D (struct cil_type *)d2;
> +               rc =3D ebitmap_cpy(result, a1->types);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               rc =3D ebitmap_set_bit(result, t2->value, 0);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(result);
> +                       goto exit;
> +               }
> +       } else if (f1 !=3D CIL_TYPEATTRIBUTE && f2 =3D=3D CIL_TYPEATTRIBU=
TE) {
> +               struct cil_type *t1 =3D (struct cil_type *)d1;
> +               struct cil_typeattribute *a2 =3D (struct cil_typeattribut=
e *)d2;
> +               ebitmap_init(result);
> +               if (!ebitmap_get_bit(a2->types, t1->value)) {
> +                       rc =3D ebitmap_set_bit(result, t1->value, 1);
> +                       if (rc !=3D SEPOL_OK) {
> +                               ebitmap_destroy(result);
> +                               goto exit;
> +                       }
> +               }
> +       } else {
> +               /* Both are attributes */
> +               struct cil_typeattribute *a1 =3D (struct cil_typeattribut=
e *)d1;
> +               struct cil_typeattribute *a2 =3D (struct cil_typeattribut=
e *)d2;
> +               rc =3D ebitmap_andnot(result, a1->types, a2->types, a1->t=
ypes->highbit);
> +               if (rc !=3D SEPOL_OK) {
> +                       ebitmap_destroy(result);
> +                       goto exit;
> +               }
> +       }
> +exit:
> +       return rc;
> +}
> +
> +static size_t num_digits(unsigned n)
> +{
> +       size_t num =3D 1;
> +       while (n >=3D 10) {
> +               n /=3D 10;
> +               num++;
> +       }
> +       return num;
> +}
> +
> +static char *cil_create_new_attribute_name(unsigned num)
> +{
> +       char *s1 =3D NULL;
> +       char *s2 =3D NULL;
> +       size_t len_num =3D num_digits(num);
> +       size_t len =3D strlen(CIL_DENY_ATTR_PREFIX) + 1 + len_num + 1;
> +       int rc;
> +
> +       if (len >=3D CIL_MAX_NAME_LENGTH) {
> +               cil_log(CIL_ERR, "Name length greater than max name lengt=
h of %d",
> +                               CIL_MAX_NAME_LENGTH);
> +               goto exit;
> +       }
> +
> +       s1 =3D cil_malloc(len);
> +       rc =3D snprintf(s1, len, "%s_%u", CIL_DENY_ATTR_PREFIX, num);
> +       if (rc < 0 || (size_t)rc >=3D len) {
> +               cil_log(CIL_ERR, "Error creating new attribute name");
> +               free(s1);
> +               goto exit;
> +       }
> +
> +       s2 =3D cil_strpool_add(s1);
> +       free(s1);
> +
> +exit:
> +       return s2;
> +}
> +
> +static struct cil_list *cil_create_and_expr_list(enum cil_flavor f1, voi=
d *v1, enum cil_flavor f2, void *v2)
> +{
> +       struct cil_list *expr;
> +
> +       cil_list_init(&expr, CIL_TYPE);
> +       cil_list_append(expr, CIL_OP, (void *)CIL_AND);
> +       cil_list_append(expr, f1, v1);
> +       cil_list_append(expr, f2, v2);
> +
> +       return expr;
> +}
> +
> +static struct cil_list *cil_create_andnot_expr_list(enum cil_flavor f1, =
void *v1, enum cil_flavor f2, void *v2)
> +{
> +       struct cil_list *expr, *sub_expr;
> +
> +       cil_list_init(&expr, CIL_TYPE);
> +       cil_list_append(expr, CIL_OP, (void *)CIL_AND);
> +       cil_list_append(expr, f1, v1);
> +       cil_list_init(&sub_expr, CIL_TYPE);
> +       cil_list_append(sub_expr, CIL_OP, (void *)CIL_NOT);
> +       cil_list_append(sub_expr, f2, v2);
> +       cil_list_append(expr, CIL_LIST, sub_expr);
> +
> +       return expr;
> +}
> +
> +static struct cil_tree_node *cil_create_and_insert_node(struct cil_tree_=
node *prev, enum cil_flavor flavor, void *data)
> +{
> +       struct cil_tree_node *new;
> +
> +       cil_tree_node_init(&new);
> +       new->parent =3D prev->parent;
> +       new->line =3D prev->line;
> +       new->hll_offset =3D prev->hll_offset;
> +       new->flavor =3D flavor;
> +       new->data =3D data;
> +       new->next =3D prev->next;
> +       prev->next =3D new;
> +
> +       return new;
> +}
> +
> +static int cil_create_and_insert_attribute_and_set(struct cil_db *db, st=
ruct cil_tree_node *prev, struct cil_list *str_expr, struct cil_list *datum=
_expr, ebitmap_t *types, struct cil_symtab_datum **d)
> +{
> +       struct cil_tree_node *attr_node =3D NULL;
> +       char *name;
> +       struct cil_typeattribute *attr =3D NULL;
> +       struct cil_tree_node *attrset_node =3D NULL;
> +       struct cil_typeattributeset *attrset =3D NULL;
> +       symtab_t *symtab =3D NULL;
> +       int rc =3D SEPOL_ERR;
> +
> +       name =3D cil_create_new_attribute_name(db->num_types_and_attrs);
> +       if (!name) {
> +               goto exit;
> +       }
> +
> +       cil_typeattributeset_init(&attrset);
> +       attrset->attr_str =3D name;
> +       attrset->str_expr =3D str_expr;
> +       attrset->datum_expr =3D datum_expr;
> +
> +       cil_typeattribute_init(&attr);
> +       cil_list_init(&attr->expr_list, CIL_TYPE);
> +       cil_list_append(attr->expr_list, CIL_LIST, datum_expr);
> +       attr->types =3D types;
> +       attr->used =3D CIL_ATTR_AVRULE;
> +       attr->keep =3D (ebitmap_cardinality(types) < db->attrs_expand_siz=
e) ? CIL_FALSE : CIL_TRUE;
> +
> +       attr_node =3D cil_create_and_insert_node(prev, CIL_TYPEATTRIBUTE,=
 attr);
> +       attrset_node =3D cil_create_and_insert_node(attr_node, CIL_TYPEAT=
TRIBUTESET, attrset);
> +
> +       rc =3D cil_get_symtab(prev->parent, &symtab, CIL_SYM_TYPES);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       rc =3D cil_symtab_insert(symtab, name, &attr->datum, attr_node);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       db->num_types_and_attrs++;
> +
> +       *d =3D &attr->datum;
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       if (attr_node) {
> +               cil_destroy_typeattribute(attr_node->data); // This will =
not destroy datum_expr
> +               free(attr_node);
> +       }
> +       if (attrset_node) {
> +               prev->next =3D attrset_node->next;
> +               free(attrset_node);
> +       }
> +       return rc;
> +}
> +
> +struct attr_symtab_map_data {
> +       struct cil_symtab_datum *d;
> +       ebitmap_t *types;
> +};
> +
> +static int cil_check_attribute_in_symtab(__attribute__((unused))hashtab_=
key_t k, hashtab_datum_t d, void *args)
> +{
> +       struct attr_symtab_map_data *data =3D args;
> +
> +       if (FLAVOR(d) =3D=3D CIL_TYPEATTRIBUTE) {
> +               struct cil_typeattribute *attr =3D (struct cil_typeattrib=
ute *)d;
> +               if (ebitmap_cmp(data->types, attr->types)) {
> +                       data->d =3D d;
> +               }
> +       }
> +       return SEPOL_OK;
> +}
> +
> +static struct cil_symtab_datum *cil_check_for_previously_defined_attribu=
te(struct cil_db *db, ebitmap_t *types, struct cil_symtab_datum *d)
> +{
> +       symtab_t *local_symtab, *root_symtab;
> +       struct attr_symtab_map_data data;
> +       int rc;
> +
> +       data.d =3D NULL;
> +       data.types =3D types;
> +
> +       local_symtab =3D d->symtab;
> +       root_symtab =3D &((struct cil_root *)db->ast->root->data)->symtab=
[CIL_SYM_TYPES];
> +
> +       if (local_symtab !=3D root_symtab) {
> +               rc =3D cil_symtab_map(local_symtab, cil_check_attribute_i=
n_symtab, &data);
> +               if (rc !=3D SEPOL_OK) {
> +                       return NULL;
> +               }
> +       }
> +
> +       if (!data.d) {
> +               rc =3D cil_symtab_map(root_symtab, cil_check_attribute_in=
_symtab, &data);
> +               if (rc !=3D SEPOL_OK) {
> +                       return NULL;
> +               }
> +       }
> +
> +       return data.d;
> +}
> +
> +static int cil_create_attribute_all_and_not_d(struct cil_db *db, struct =
cil_symtab_datum *d, struct cil_symtab_datum **d3)
> +{
> +       struct cil_list *str_expr;
> +       struct cil_list *datum_expr;
> +       ebitmap_t *types;
> +       int rc;
> +
> +       *d3 =3D NULL;
> +
> +       if (!d) {
> +               return SEPOL_ERR;
> +       }
> +
> +       str_expr =3D cil_create_andnot_expr_list(CIL_OP, (void *)CIL_ALL,=
 CIL_STRING, d->fqn);
> +       datum_expr =3D cil_create_andnot_expr_list(CIL_OP, (void *)CIL_AL=
L, CIL_DATUM, d);
> +
> +       types =3D cil_malloc(sizeof(*types));
> +       rc =3D cil_datum_not(types, d, db->num_types);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       if (ebitmap_is_empty(types)) {
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       if (ebitmap_cardinality(types) =3D=3D 1) {
> +               unsigned i =3D ebitmap_highest_set_bit(types);
> +               *d3 =3D DATUM(db->val_to_type[i]);
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       *d3 =3D cil_check_for_previously_defined_attribute(db, types, d);
> +       if (*d3) {
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       rc =3D cil_create_and_insert_attribute_and_set(db, NODE(d), str_e=
xpr, datum_expr, types, d3);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       cil_list_destroy(&str_expr, CIL_FALSE);
> +       cil_list_destroy(&datum_expr, CIL_FALSE);
> +       free(types);
> +       return rc;
> +}
> +
> +static int cil_create_attribute_d1_and_not_d2(struct cil_db *db, struct =
cil_symtab_datum *d1, struct cil_symtab_datum *d2, struct cil_symtab_datum =
**d3)
> +{
> +       struct cil_list *str_expr;
> +       struct cil_list *datum_expr;
> +       ebitmap_t *types;
> +       int rc;
> +
> +       if (!d2) {
> +               *d3 =3D d1;
> +               return SEPOL_OK;
> +       }
> +
> +       *d3 =3D NULL;
> +
> +       if (!d1 || d1 =3D=3D d2) {
> +               return SEPOL_OK;
> +       }
> +
> +       str_expr =3D cil_create_andnot_expr_list(CIL_STRING, d1->fqn, CIL=
_STRING, d2->fqn);
> +       datum_expr =3D cil_create_andnot_expr_list(CIL_DATUM, d1, CIL_DAT=
UM, d2);
> +
> +       types =3D cil_malloc(sizeof(*types));
> +       rc =3D cil_datums_andnot(types, d1, d2);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +       if (ebitmap_is_empty(types)) {
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       if (ebitmap_cardinality(types) =3D=3D 1) {
> +               unsigned i =3D ebitmap_highest_set_bit(types);
> +               *d3 =3D DATUM(db->val_to_type[i]);
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       *d3 =3D cil_check_for_previously_defined_attribute(db, types, d1)=
;
> +       if (*d3) {
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       rc =3D cil_create_and_insert_attribute_and_set(db, NODE(d1), str_=
expr, datum_expr, types, d3);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       cil_list_destroy(&str_expr, CIL_FALSE);
> +       cil_list_destroy(&datum_expr, CIL_FALSE);
> +       free(types);
> +       return rc;
> +}
> +
> +static int cil_create_attribute_d1_and_d2(struct cil_db *db, struct cil_=
symtab_datum *d1, struct cil_symtab_datum *d2, struct cil_symtab_datum **d3=
)
> +{
> +       struct cil_list *str_expr;
> +       struct cil_list *datum_expr;
> +       ebitmap_t *types;
> +       int rc;
> +
> +       if (d1 =3D=3D d2) {
> +               *d3 =3D d1;
> +               return SEPOL_OK;
> +       }
> +
> +       *d3 =3D NULL;
> +
> +       if (!d1 || !d2) {
> +               return SEPOL_OK;
> +       }
> +
> +       str_expr =3D cil_create_and_expr_list(CIL_STRING, d1->fqn, CIL_ST=
RING, d2->fqn);
> +       datum_expr =3D cil_create_and_expr_list(CIL_DATUM, d1, CIL_DATUM,=
 d2);
> +
> +       types =3D cil_malloc(sizeof(*types));
> +       rc =3D cil_datums_and(types, d1, d2);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +       if (ebitmap_is_empty(types)) {
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       if (ebitmap_cardinality(types) =3D=3D 1) {
> +               unsigned i =3D ebitmap_highest_set_bit(types);
> +               *d3 =3D DATUM(db->val_to_type[i]);
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       *d3 =3D cil_check_for_previously_defined_attribute(db, types, d1)=
;
> +       if (*d3) {
> +               ebitmap_destroy(types);
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       rc =3D cil_create_and_insert_attribute_and_set(db, NODE(d1), str_=
expr, datum_expr, types, d3);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       cil_list_destroy(&str_expr, CIL_FALSE);
> +       cil_list_destroy(&datum_expr, CIL_FALSE);
> +       free(types);
> +       return rc;
> +}
> +
> +static struct cil_avrule *cil_create_avrule(struct cil_symtab_datum *src=
, struct cil_symtab_datum *tgt, struct cil_list *classperms)
> +{
> +       struct cil_avrule *new;
> +
> +       cil_avrule_init(&new);
> +       new->is_extended =3D CIL_FALSE;
> +       new->rule_kind =3D CIL_AVRULE_ALLOWED;
> +       new->src_str =3D src->name;
> +       new->src =3D src;
> +       new->tgt_str =3D tgt->name;
> +       new->tgt =3D tgt;
> +       new->perms.classperms =3D classperms;
> +
> +       return new;
> +}
> +
> +static struct cil_tree_node *cil_create_and_add_avrule(struct cil_tree_n=
ode *curr, struct cil_symtab_datum *src, struct cil_symtab_datum *tgt, stru=
ct cil_list *classperms)
> +{
> +       struct cil_avrule *new_avrule;
> +       struct cil_list *new_cp_list;
> +
> +       if (!src || !tgt) {
> +               return curr;
> +       }
> +
> +       cil_classperms_list_copy(&new_cp_list, classperms);
> +       new_avrule =3D cil_create_avrule(src, tgt, new_cp_list);
> +       return cil_create_and_insert_node(curr, CIL_AVRULE, new_avrule);
> +}
> +
> +static int cil_remove_permissions_from_special_rule(struct cil_db *db, s=
truct cil_tree_node *curr, struct cil_symtab_datum *s1, struct cil_symtab_d=
atum *t1, struct cil_symtab_datum *s2, struct cil_symtab_datum *t2, struct =
cil_list *p4, struct cil_symtab_datum *s3, struct cil_symtab_datum *s4)
> +{
> +       int rc;
> +
> +       if (t1 =3D=3D DATUM(db->notselftype)) {
> +               if (t2 =3D=3D DATUM(db->othertype)) {
> +                       struct cil_symtab_datum *t;
> +                       rc =3D cil_create_attribute_all_and_not_d(db, s2,=
 &t);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       curr =3D cil_create_and_add_avrule(curr, s4, t, p=
4);
> +               } else {
> +                       struct cil_symtab_datum *s5, *s6, *ta, *tb;
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, s4,=
 t2, &s5);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_d1_and_d2(db, s4, t2,=
 &s6);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_all_and_not_d(db, t2,=
 &ta);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, ta,=
 s4, &tb);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       curr =3D cil_create_and_add_avrule(curr, s6, ta, =
p4);
> +                       curr =3D cil_create_and_add_avrule(curr, s5, tb, =
p4);
> +                       if (cil_datum_cardinality(s5) > 1) {
> +                               curr =3D cil_create_and_add_avrule(curr, =
s5, DATUM(db->othertype), p4);
> +                       }
> +               }
> +       } else if (t1 =3D=3D DATUM(db->othertype)) {
> +               curr =3D cil_create_and_add_avrule(curr, s3, s4, p4);
> +               if (t2 =3D=3D DATUM(db->notselftype)) {
> +                       /* Nothing else is needed */
> +               } else if (t2 =3D=3D DATUM(db->othertype)) {
> +                       curr =3D cil_create_and_add_avrule(curr, s4, s3, =
p4);
> +               } else {
> +                       struct cil_symtab_datum *s5, *s6, *tc, *td;
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, s4,=
 t2, &s5);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_d1_and_d2(db, s4, t2,=
 &s6);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, s1,=
 t2, &tc);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, s3,=
 t2, &td);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       curr =3D cil_create_and_add_avrule(curr, s6, tc, =
p4);
> +                       curr =3D cil_create_and_add_avrule(curr, s5, td, =
p4);
> +                       if (cil_datum_cardinality(s5) > 1) {
> +                               curr =3D cil_create_and_add_avrule(curr, =
s5, DATUM(db->othertype), p4);
> +                       }
> +               }
> +       } else {
> +               struct cil_symtab_datum *s8;
> +               rc =3D cil_create_attribute_d1_and_d2(db, s4, t1, &s8);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               curr =3D cil_create_and_add_avrule(curr, s8, DATUM(db->se=
lftype), p4);
> +               if (t2 =3D=3D DATUM(db->notselftype)) {
> +                       /* Nothing else is needed */
> +               } else { /* t2 =3D=3D DATUM(db->othertype) */
> +                       struct cil_symtab_datum *t;
> +                       rc =3D cil_create_attribute_d1_and_not_d2(db, t1,=
 s2, &t);
> +                       if (rc !=3D SEPOL_OK) {
> +                               goto exit;
> +                       }
> +                       curr =3D cil_create_and_add_avrule(curr, s4, t, p=
4);
> +               }
> +       }
> +       return SEPOL_OK;
> +
> +exit:
> +       return rc;
> +}
> +
> +static int cil_remove_permissions_from_rule(struct cil_db *db, struct ci=
l_tree_node *allow_node, const struct cil_tree_node *deny_node)
> +{
> +       struct cil_avrule *allow_rule =3D allow_node->data;
> +       struct cil_deny_rule *deny_rule =3D deny_node->data;
> +       struct cil_symtab_datum *s1 =3D allow_rule->src;
> +       struct cil_symtab_datum *t1 =3D allow_rule->tgt;
> +       struct cil_list *p1 =3D allow_rule->perms.classperms;
> +       struct cil_symtab_datum *s2 =3D deny_rule->src;
> +       struct cil_symtab_datum *t2 =3D deny_rule->tgt;
> +       struct cil_list *p2 =3D deny_rule->classperms;
> +       struct cil_list *p3 =3D NULL;
> +       struct cil_list *p4 =3D NULL;
> +       struct cil_symtab_datum *s3, *s4;
> +       struct cil_tree_node *curr =3D allow_node;
> +       int rc;
> +
> +       cil_classperms_list_andnot(&p3, p1, p2);
> +       if (!cil_list_is_empty(p3)) {;
> +               curr =3D cil_create_and_add_avrule(curr, s1, t1, p3);
> +       }
> +       cil_destroy_classperms_list(&p3);
> +       p3 =3D NULL;
> +
> +       cil_classperms_list_and(&p4, p1, p2);
> +       if (cil_list_is_empty(p4)) {
> +               cil_tree_log(allow_node, CIL_ERR, "Allow rule did not mat=
ch deny rule: No matching class and permissions");
> +               cil_tree_log((struct cil_tree_node *)deny_node, CIL_ERR, =
"Deny rule");
> +               rc =3D SEPOL_ERR;
> +               goto exit;
> +       }
> +
> +       rc =3D cil_create_attribute_d1_and_not_d2(db, s1, s2, &s3);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +       curr =3D cil_create_and_add_avrule(curr, s3, t1, p4);
> +
> +       if ((t1 =3D=3D DATUM(db->selftype) && t2 =3D=3D DATUM(db->selftyp=
e)) ||
> +               (t1 =3D=3D DATUM(db->notselftype) && t2 =3D=3D DATUM(db->=
notselftype))) {
> +               /* Nothing more needs to be done */
> +               rc =3D SEPOL_OK;
> +               goto exit;
> +       }
> +
> +       rc =3D cil_create_attribute_d1_and_d2(db, s1, s2, &s4);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       if (t1 =3D=3D DATUM(db->notselftype) || t1 =3D=3D DATUM(db->other=
type) ||
> +               t2 =3D=3D DATUM(db->notselftype) || t2 =3D=3D DATUM(db->o=
thertype)) {
> +               rc =3D cil_remove_permissions_from_special_rule(db, curr,=
 s1, t1, s2, t2, p4, s3, s4);
> +               goto exit;
> +       }
> +
> +       if (t1 =3D=3D DATUM(db->selftype) && t2 !=3D DATUM(db->selftype))=
 {
> +               struct cil_symtab_datum *s5;
> +               rc =3D cil_create_attribute_d1_and_not_d2(db, s4, t2, &s5=
);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               curr =3D cil_create_and_add_avrule(curr, s5, DATUM(db->se=
lftype), p4);
> +       } else if (t1 !=3D DATUM(db->selftype) && t2 =3D=3D DATUM(db->sel=
ftype)) {
> +               struct cil_symtab_datum *s7, *s8, *t8;
> +               rc =3D cil_create_attribute_d1_and_not_d2(db, s4, t1, &s7=
);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               rc =3D cil_create_attribute_d1_and_d2(db, s4, t1, &s8);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               rc =3D cil_create_attribute_d1_and_not_d2(db, t1, s4, &t8=
);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               curr =3D cil_create_and_add_avrule(curr, s7, t1, p4);
> +               curr =3D cil_create_and_add_avrule(curr, s8, t8, p4);
> +               if (cil_datum_cardinality(s8) > 1) {
> +                       curr =3D cil_create_and_add_avrule(curr, s8, DATU=
M(db->othertype), p4);
> +               }
> +       } else {
> +               struct cil_symtab_datum *t3;
> +               rc =3D cil_create_attribute_d1_and_not_d2(db, t1, t2, &t3=
);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               curr =3D cil_create_and_add_avrule(curr, s4, t3, p4);
> +       }
> +
> +exit:
> +       if (p4) {
> +               cil_destroy_classperms_list(&p4);
> +       }
> +       return rc;
> +}
> +
> +static int cil_find_matching_allow_rules(struct cil_list *matching, stru=
ct cil_tree_node *start, struct cil_tree_node *deny_node)
> +{
> +       struct cil_deny_rule *deny_rule =3D deny_node->data;
> +       struct cil_avrule target;
> +
> +       target.rule_kind =3D CIL_AVRULE_ALLOWED;
> +       target.is_extended =3D CIL_FALSE;
> +       target.src =3D deny_rule->src;
> +       target.tgt =3D deny_rule->tgt;
> +       target.perms.classperms =3D deny_rule->classperms;
> +
> +       return cil_find_matching_avrule_in_ast(start, CIL_AVRULE, &target=
, matching, CIL_FALSE);
> +}
> +
> +static int cil_process_deny_rule(struct cil_db *db, struct cil_tree_node=
 *start, struct cil_tree_node *deny_node)
> +{
> +       struct cil_list *matching;
> +       struct cil_list_item *item;
> +       int rc;
> +
> +       cil_list_init(&matching, CIL_NODE);
> +
> +       rc =3D cil_find_matching_allow_rules(matching, start, deny_node);
> +       if (rc !=3D SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       cil_list_for_each(item, matching) {
> +               struct cil_tree_node *allow_node =3D item->data;
> +               rc =3D cil_remove_permissions_from_rule(db, allow_node, d=
eny_node);
> +               cil_tree_node_remove(allow_node);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +
> +       }
> +
> +exit:
> +       cil_list_destroy(&matching, CIL_FALSE);
> +       return rc;
> +}
> +
> +static int cil_process_deny_rules(struct cil_db *db, struct cil_tree_nod=
e *start, struct cil_list *deny_rules)
> +{
> +       struct cil_list_item *item;
> +       int rc;

-    int rc;
+    int rc =3D SEPOL_OK;

Otherwise, if the list of deny rules is empty, rc is returned unitialized.
I am not sure how all my testing didn't find this, but the CI testing
did when I pushed the merge branch to my github.
Jim

> +
> +       cil_list_for_each(item, deny_rules) {
> +               struct cil_tree_node *deny_node =3D item->data;
> +               rc =3D cil_process_deny_rule(db, start, deny_node);
> +               if (rc !=3D SEPOL_OK) {
> +                       goto exit;
> +               }
> +               cil_tree_node_remove(deny_node);
> +       }
> +
> +exit:
> +       return rc;
> +}
> +
> +static int __cil_find_deny_rules(struct cil_tree_node *node,  uint32_t *=
finished, void *extra_args)
> +{
> +       struct cil_list *deny_rules =3D extra_args;
> +
> +       if (node->flavor =3D=3D CIL_BLOCK) {
> +               struct cil_block *block =3D node->data;
> +               if (block->is_abstract =3D=3D CIL_TRUE) {
> +                       *finished =3D CIL_TREE_SKIP_HEAD;
> +               }
> +       } else if (node->flavor =3D=3D CIL_MACRO) {
> +               *finished =3D CIL_TREE_SKIP_HEAD;
> +       } else if (node->flavor =3D=3D CIL_DENY_RULE) {
> +               cil_list_append(deny_rules, CIL_DENY_RULE, node);
> +       }
> +       return SEPOL_OK;
> +}
> +
> +int cil_process_deny_rules_in_ast(struct cil_db *db)
> +{
> +       struct cil_tree_node *start;
> +       struct cil_list *deny_rules;
> +       int rc =3D SEPOL_ERR;
> +
> +       cil_list_init(&deny_rules, CIL_DENY_RULE);
> +
> +       if (!db) {
> +               cil_log(CIL_ERR, "No CIL db provided to process deny rule=
s\n");
> +               goto exit;
> +       }
> +
> +       start =3D db->ast->root;
> +       rc =3D cil_tree_walk(start, __cil_find_deny_rules, NULL, NULL, de=
ny_rules);
> +       if (rc !=3D SEPOL_OK) {
> +               cil_log(CIL_ERR, "An error occurred while getting deny ru=
les\n");
> +               goto exit;
> +       }
> +
> +       rc =3D cil_process_deny_rules(db, start, deny_rules);
> +       if (rc !=3D SEPOL_OK) {
> +               cil_log(CIL_ERR, "An error occurred while processing deny=
 rules\n");
> +               goto exit;
> +       }
> +
> +exit:
> +       cil_list_destroy(&deny_rules, CIL_FALSE);
> +       return rc;
> +}
> diff --git a/libsepol/cil/src/cil_deny.h b/libsepol/cil/src/cil_deny.h
> new file mode 100644
> index 00000000..f22e8bf1
> --- /dev/null
> +++ b/libsepol/cil/src/cil_deny.h
> @@ -0,0 +1,36 @@
> +/*
> + * This file is public domain software, i.e. not copyrighted.
> + *
> + * Warranty Exclusion
> + * ------------------
> + * You agree that this software is a non-commercially developed program
> + * that may contain "bugs" (as that term is used in the industry) and
> + * that it may not function as intended. The software is licensed
> + * "as is". NSA makes no, and hereby expressly disclaims all, warranties=
,
> + * express, implied, statutory, or otherwise with respect to the softwar=
e,
> + * including noninfringement and the implied warranties of merchantabili=
ty
> + * and fitness for a particular purpose.
> + *
> + * Limitation of Liability
> + *-----------------------
> + * In no event will NSA be liable for any damages, including loss of dat=
a,
> + * lost profits, cost of cover, or other special, incidental, consequent=
ial,
> + * direct or indirect damages arising from the software or the use there=
of,
> + * however caused and on any theory of liability. This limitation will a=
pply
> + * even if NSA has been advised of the possibility of such damage. You
> + * acknowledge that this is a reasonable allocation of risk.
> + *
> + * Original author: James Carter
> + */
> +
> +#ifndef CIL_DENY_H_
> +#define CIL_DENY_H_
> +
> +int cil_classperms_list_match_any(const struct cil_list *cpl1, const str=
uct cil_list *cpl2);
> +int cil_classperms_list_match_all(const struct cil_list *cpl1, const str=
uct cil_list *cpl2);
> +void cil_classperms_list_copy(struct cil_list **new, const struct cil_li=
st *old);
> +void cil_classperms_list_and(struct cil_list **result, const struct cil_=
list *cpl1, const struct cil_list *cpl2);
> +void cil_classperms_list_andnot(struct cil_list **result, const struct c=
il_list *cpl1, const struct cil_list *cpl2);
> +int cil_process_deny_rules_in_ast(struct cil_db *db);
> +
> +#endif /* CIL_DENY_H_ */
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index a7c66ead..da97a392 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -47,6 +47,7 @@
>  #include "cil_policy.h"
>  #include "cil_verify.h"
>  #include "cil_symtab.h"
> +#include "cil_deny.h"
>
>  #define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in libsepol/src/modul=
e_to_cil.c */
>  #define TYPEATTR_INFIX "_typeattr_"        /* Also in libsepol/src/modul=
e_to_cil.c */
> @@ -2551,6 +2552,12 @@ int cil_post_process(struct cil_db *db)
>                 goto exit;
>         }
>
> +       rc =3D cil_process_deny_rules_in_ast(db);
> +       if (rc !=3D SEPOL_OK) {
> +               cil_log(CIL_ERR, "Failed to process deny rules\n");
> +               goto exit;
> +       }
> +
>         rc =3D cil_post_verify(db);
>         if (rc !=3D SEPOL_OK) {
>                 cil_log(CIL_ERR, "Failed to verify cil database\n");
> --
> 2.41.0
>
