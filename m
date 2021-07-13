Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9548EC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E806101D
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbhGMUDi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:03:38 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:49086 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUDi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:03:38 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0744C564798
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 22:00:46 +0200 (CEST)
Received: by mail-io1-f46.google.com with SMTP id x10so9938697ion.9
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 13:00:45 -0700 (PDT)
X-Gm-Message-State: AOAM531onmcuulg9IczbkBXLlAnBub0fRRHIgyTns5S6JenHWsZ371bM
        bCP2tPRWKNbZLO/7p4I6GIA0AkMc+8GXrZO5m54=
X-Google-Smtp-Source: ABdhPJwnNXbtDpGG5SV2fpTjy8K4Kk5DlVD4gh0g2IrRQCdTrNhkDJRZG6gsstznXFMB7meHrLoDsPgveXkxZ8Y8JFE=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr4496240ioh.56.1626206445180;
 Tue, 13 Jul 2021 13:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210712135038.9405-1-jwcart2@gmail.com> <CAJfZ7==HNf7kj0TnVjg5McW=-mPX+cH4ACTUAPndYi-OGcKZog@mail.gmail.com>
In-Reply-To: <CAJfZ7==HNf7kj0TnVjg5McW=-mPX+cH4ACTUAPndYi-OGcKZog@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 22:00:34 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==shzcuPHFPWJPM5MP-+JSFFKjyghcgKOC9J4Pg8tRqfA@mail.gmail.com>
Message-ID: <CAJfZ7==shzcuPHFPWJPM5MP-+JSFFKjyghcgKOC9J4Pg8tRqfA@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Fix handling category sets in an expression
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 22:00:46 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 10:06 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Jul 12, 2021 at 3:50 PM James Carter <jwcart2@gmail.com> wrote:
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
> >
> > Keep track of the current operator as an expression is being resolved
> > and if the expression involves categories and a category set is
> > encountered, then return an error if the expression is a category
> > range.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks!
> Nicolas

Merged.
Thanks!
Nicolas

> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 145d4e74..18007324 100644
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
> > +                               op = (enum cil_flavor)(uintptr_t)curr->data;
> > +                       }
> >                         cil_list_append(*datum_expr, curr->flavor, curr->data);
> >                         break;
> > -               }
> > +               }
> >         }
> >         return SEPOL_OK;
> >
> > --
> > 2.31.1
> >

