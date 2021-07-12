Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094AFC07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FC661153
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 13:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhGLNQi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 09:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhGLNQi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 09:16:38 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F62C0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 06:13:48 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id t25so5525222oiw.13
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMg24hLLeGeI8AKZUyg6ThuhEFidSaFpSW1cx2so8uU=;
        b=gCDh7JCDZJJw9SCTdzj75wARqCI7BAJAa30XKieojY81ySHtCIFuQD5SnrPGaB15YU
         9Hg7hdPgSZUzn4La+fv05g9EUMNnAercO4VAk8xc0zMJ3rI+yn+PH0zy1+bYJ6rOw3Nb
         x+GFLZT2L8Co87HqNuO3rpFs//pG4HMtt+Bfhy6712NF7G/g8QpiAy2bH+ovv3AWe605
         4MYnK0JW1UAbvRsy37vsUp753qSAd6D7tQMLuOzuDTbyQqGFMW1uGdBvxE4DtToNm3zK
         dVW1lf6M7kN0h4ZemaE3/bxz0d/o+Th4cLloxHb/9pYG3h2lFJL+Hi/h6Sr59FpRPKn7
         mFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMg24hLLeGeI8AKZUyg6ThuhEFidSaFpSW1cx2so8uU=;
        b=m28cqCnQV2vMTCnOEB0EUNY4N3SvFajdRHkRgZ9/OpYbiFktPL1zlbz/os8yBIYQGL
         VwWilEQu9CmRMVPOnPARocYl5Y+bF1NTOEoFIj5lTuLN1VowB/7D6GNK5WFCYDGe8KuL
         tVGu5TBQApZ/rxtxmpFmxZJA4qLvuIrxJh/sMiTMHKKoc/nNZVMy80nhAT7BYkiNKUEr
         jALiMHP9kYHk/2yTZT5MKoyifrgsT/F/J/G/Hb55cUPqo0dK9rTTPsn226R7azFmIChE
         ewAMXVmoQ+a0urt03qmr02fVejMw3URL3+KzvfFy2K8+Flpe0d2PLo9AuoTaFg8jEwbZ
         e9QQ==
X-Gm-Message-State: AOAM531JLESVVH1SARVOTkUYRPAMCl+jbKin4esCw8KNoPsPdfKkhZXw
        jAA2JuDgq4gWYTb9MBTe1PTLhUz0ijjVFHzORo0=
X-Google-Smtp-Source: ABdhPJy+t9z5WZ2jMvc1Xb7UAjaUIeYWnzZ4X0sK3NlZ1Zu5l0mGtrITEoOYOFAU7O5pXpT4aFfzA3rscwCb134QDjU=
X-Received: by 2002:aca:a887:: with SMTP id r129mr4197019oie.128.1626095628278;
 Mon, 12 Jul 2021 06:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210709141149.59229-1-jwcart2@gmail.com> <CAJfZ7=n1Q=AOg4gFbDZ+8fqBfxUieJ+6a74Gi5m_t4h7iFzz1w@mail.gmail.com>
In-Reply-To: <CAJfZ7=n1Q=AOg4gFbDZ+8fqBfxUieJ+6a74Gi5m_t4h7iFzz1w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 12 Jul 2021 09:13:37 -0400
Message-ID: <CAP+JOzQEvvL-AH_o4dPKpAzzFzsP5Gmaukqg7iV+BpHiPm5fvw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix handling category sets in an expression
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 3:00 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Jul 9, 2021 at 4:11 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > There are two problems that need to be addressed when resolving an
> > expression with category sets.
> >
> > 1. Only expand anonymous category sets in an expression.
> >
> > Commit 982ec302b67f3c7f8df667dadb67352b1e4a6d18 (libsepol/cil:
> > Account for anonymous category sets in an expression) attempted to
> > properly handle anonymous category sets when resolving category
> > expressions. Unfortunately, it did not check whether a category set
> > was actually an anonymous category set and expanded all category
> > sets in an expression. If a category set refers to itself in the
> > expression, then everything from the name of the category set to the
> > end of the expression is ignored.
> >
> > For example, the rule "(categoryset cs (c0 cs c1 c2))", would be
> > equivalent to the rule "(categoryset cs (c0))" as everything from
> > "cs" to the end would be dropped. The secilc-fuzzer found that the
> > rule "(categoryset cat (not cat))" would cause a segfault since
> > "(not)" is not a valid expression and it is assumed to be valid
> > during later evaluation because syntax checking has already been
> > done.
> >
> > Instead, check whether or not the category set is anonymous before
> > expanding it when resolving an expression.
> >
> > 2. Category sets cannot be used in a category range
> >
> > A category range can be used to specify a large number of categories.
> > The range "(range c0 c1023)" refers to 1024 categories. Only categories
> > and category aliases can be used in a range. Determining if an
> > identifier is a category, an alias, or a set can only be done after
> > resolving the identifer.
>
> Misspelling: identifer -> identifier
>
> >
> > Keep track of the current operator as an expression is being resolved
> > and if the expression involves categories and a category set is
> > encountered, then return an error if the expression is a category
> > range.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 145d4e74..3d3ef955 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -3228,6 +3228,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
> >         struct cil_symtab_datum *res_datum = NULL;
> >         enum cil_sym_index sym_index =  CIL_SYM_UNKNOWN;
> >         struct cil_list *datum_sub_expr;
> > +       enum cil_flavor op = CIL_NONE;
> >
> >         switch (str_expr->flavor) {
> >         case CIL_BOOL:
> > @@ -3263,14 +3264,24 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
> >                         }
> >                         if (sym_index == CIL_SYM_CATS && NODE(res_datum)->flavor == CIL_CATSET) {
> >                                 struct cil_catset *catset = (struct cil_catset *)res_datum;
> > -                               if (!catset->cats->datum_expr) {
> > -                                       rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
> > -                                       if (rc != SEPOL_OK) {
> > -                                               goto exit;
> > +                               if (op == CIL_RANGE) {
> > +                                       cil_tree_log(parent, CIL_ERR, "Category set not allowed in category range");
> > +                                       rc = SEPOL_ERR;
> > +                                       goto exit;
> > +                               }
> > +                               if (!res_datum->name) {
> > +                                       /* Anonymous category sets need to be resolved when encountered */
> > +                                       if (!catset->cats->datum_expr) {
> > +                                               rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
> > +                                               if (rc != SEPOL_OK) {
> > +                                                       goto exit;
> > +                                               }
> >                                         }
> > +                                       cil_copy_list(catset->cats->datum_expr, &datum_sub_expr);
> > +                                       cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
> > +                               } else {
> > +                                       cil_list_append(*datum_expr, CIL_DATUM, res_datum);
> >                                 }
> > -                               cil_copy_list(catset->cats->datum_expr, &datum_sub_expr);
> > -                               cil_list_append(*datum_expr, CIL_LIST, datum_sub_expr);
> >                         } else {
> >                                 if (sym_index == CIL_SYM_TYPES && (expr_type == CIL_CONSTRAIN || expr_type == CIL_VALIDATETRANS)) {
> >                                         cil_type_used(res_datum, CIL_ATTR_CONSTRAINT);
> > @@ -3287,9 +3298,12 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
> >                         break;
> >                 }
> >                 default:
> > +                       if (curr->flavor == CIL_OP) {
> > +                               op = (enum cil_flavor)curr->data;
> > +                       }
>
> Hello,
> This patch looks good to me, and it actually also fixes
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=35494&q=selinux&can=2
> (memory leak when compiling "(categoryset e(u)) (categoryset u(e))",
> because the categorysets were expanded).
>
> Nevertheless when building with clang 12, I get the following warning:
>
> ../cil/src/cil_resolve_ast.c:3308:10: error: cast to smaller integer
> type 'enum cil_flavor' from 'void *'
> [-Werror,-Wvoid-pointer-to-enum-cast]
>                                 op = (enum cil_flavor)curr->data;
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> This issue can be fixed by introducing an intermediate cast to
> uintptr_t, like what was done in commit 32f8ed3d6b0b ("libsepol/cil:
> introduce intermediate cast to silence -Wvoid-pointer-to-enum-cast"):
>
>     op = (enum cil_flavor)(uintptr_t)curr->data;
>
> If this looks good to you, could you please fix this?
>

I will send out a v2 with the fix.
Thanks for the review,
Jim

> Cheers,
> Nicolas
>
