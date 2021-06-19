Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC289C2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199C61264
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhFSOXW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:23:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:60561 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhFSOXW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 10:23:22 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B282C560791
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 16:21:09 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id h12so10077630pfe.2
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 07:21:09 -0700 (PDT)
X-Gm-Message-State: AOAM5311njG33gTEkS4cEWct1p63Gtl4Ye39B9wZsn6Q3haUI1MWPUsQ
        gCvxOX6vFqkyXwR6s51oYeHnZ0XLFe9UkSl1GdU=
X-Google-Smtp-Source: ABdhPJzCnBODfiiuchDqiqDZQXokFZcnb4rtOgOtqMFnw9AiEYO/wAq5eueDwNMnHeB9tcVRb7bzGOh2+Bsk9Wj4Wig=
X-Received: by 2002:a63:485a:: with SMTP id x26mr15307419pgk.159.1624112468533;
 Sat, 19 Jun 2021 07:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-2-jwcart2@gmail.com>
In-Reply-To: <20210614150546.512001-2-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 16:20:57 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m9dst6hA75Vu7mAcjJyvX7LTcM+E64Gw2KPeNf9XRzAA@mail.gmail.com>
Message-ID: <CAJfZ7=m9dst6hA75Vu7mAcjJyvX7LTcM+E64Gw2KPeNf9XRzAA@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol/cil: Properly check for loops in sets
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 16:21:10 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> Commit 61fbdce666f24c4a118b249ece6b014d54b65074 (ibsepol/cil: Check
> for self-referential loops in sets) added checks for self-referential
> loops in user, role, type, and category sets. Unfortunately, this
> check ends up in an infinite loop if the set with the self-referential
> loop is used in a different set that is checked before the bad set.
>
> The problem with the old check is that only the initial datum is used
> for the check. Instead, use a stack to track all of the set datums
> that are currently involved as the check is made. A self-referential
> loop occurs if a duplicate datum is found for any of the datums in the
> stack.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For this patch:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

> ---
>  libsepol/cil/src/cil_verify.c | 48 +++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 8e15a0e6..59397f70 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -44,6 +44,7 @@
>  #include "cil_tree.h"
>  #include "cil_list.h"
>  #include "cil_find.h"
> +#include "cil_stack.h"
>
>  #include "cil_verify.h"
>
> @@ -430,9 +431,9 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
>         return SEPOL_OK;
>  }
>
> -static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
> +static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_stack *stack);
>
> -static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_symtab_datum *orig)
> +static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_stack *stack)
>  {
>         struct cil_list_item *item;
>         int rc = SEPOL_OK;
> @@ -444,9 +445,9 @@ static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_
>         cil_list_for_each(item, expr) {
>                 if (item->flavor == CIL_DATUM) {
>                         struct cil_symtab_datum* datum = item->data;
> -                       rc = cil_verify_no_self_reference(FLAVOR(datum), datum, orig);
> +                       rc = cil_verify_no_self_reference(FLAVOR(datum), datum, stack);
>                 } else if (item->flavor == CIL_LIST) {
> -                       rc = __verify_no_self_reference_in_expr(item->data, orig);
> +                       rc = __verify_no_self_reference_in_expr(item->data, stack);
>                 }
>                 if (rc != SEPOL_OK) {
>                         return SEPOL_ERR;
> @@ -456,36 +457,47 @@ static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_
>         return SEPOL_OK;
>  }
>
> -static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig)
> +static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_stack *stack)
>  {
> +       struct cil_stack_item *item;
> +       int i = 0;
>         int rc = SEPOL_OK;
>
> -       if (datum == orig) {
> -               cil_tree_log(NODE(orig), CIL_ERR, "Self-reference found for %s", orig->name);
> -               return SEPOL_ERR;
> -       } else if (orig == NULL) {
> -               orig = datum;
> +       cil_stack_for_each(stack, i, item) {
> +               struct cil_symtab_datum *prev = item->data;
> +               if (datum == prev) {
> +                       cil_tree_log(NODE(datum), CIL_ERR, "Self-reference found for %s", datum->name);
> +                       return SEPOL_ERR;
> +               }
>         }
>
>         switch (flavor) {
>         case CIL_USERATTRIBUTE: {
>                 struct cil_userattribute *attr = (struct cil_userattribute *)datum;
> -               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               cil_stack_push(stack, CIL_DATUM, datum);
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
> +               cil_stack_pop(stack);
>                 break;
>         }
>         case CIL_ROLEATTRIBUTE: {
>                 struct cil_roleattribute *attr = (struct cil_roleattribute *)datum;
> -               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               cil_stack_push(stack, CIL_DATUM, datum);
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
> +               cil_stack_pop(stack);
>                 break;
>         }
>         case CIL_TYPEATTRIBUTE: {
>                 struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
> -               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               cil_stack_push(stack, CIL_DATUM, datum);
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, stack);
> +               cil_stack_pop(stack);
>                 break;
>         }
>         case CIL_CATSET: {
>                 struct cil_catset *set = (struct cil_catset *)datum;
> -               rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, orig);
> +               cil_stack_push(stack, CIL_DATUM, datum);
> +               rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, stack);
> +               cil_stack_pop(stack);
>                 break;
>         }
>         default:
> @@ -1826,9 +1838,13 @@ int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __at
>         case CIL_USERATTRIBUTE:
>         case CIL_ROLEATTRIBUTE:
>         case CIL_TYPEATTRIBUTE:
> -       case CIL_CATSET:
> -               rc = cil_verify_no_self_reference(node->flavor, node->data, NULL);
> +       case CIL_CATSET: {
> +               struct cil_stack *stack;
> +               cil_stack_init(&stack);
> +               rc = cil_verify_no_self_reference(node->flavor, node->data, stack);
> +               cil_stack_destroy(&stack);
>                 break;
> +       }
>         default:
>                 rc = SEPOL_OK;
>                 break;
> --
> 2.26.3
>

