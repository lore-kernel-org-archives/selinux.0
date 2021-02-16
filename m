Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEACDC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 20:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A48164E04
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 20:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBPU6P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:58:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:55284 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBPU6O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 15:58:14 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EC256564DE7
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 21:57:28 +0100 (CET)
Received: by mail-oo1-f51.google.com with SMTP id i11so2574794oov.13
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 12:57:28 -0800 (PST)
X-Gm-Message-State: AOAM533HK7AD4s4z65tWw3IAP/EYt2uMw9f2BKmmL63X2Ztc6pnTe+ub
        RBRBdIfpKkiubvVAABUGrf/Dq11jauO2aHimjZo=
X-Google-Smtp-Source: ABdhPJxPGmmz0KKBDjD8U0MKr8ldjIkevRGhxcPQU4a7OhlZxM2XsL8q6+QYlo5cPE0hiugw/K1cvHHPt/z7iaY8DrQ=
X-Received: by 2002:a05:6820:312:: with SMTP id l18mr15651265ooe.46.1613509047884;
 Tue, 16 Feb 2021 12:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20210208162342.410262-1-jwcart2@gmail.com>
In-Reply-To: <20210208162342.410262-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 16 Feb 2021 21:57:17 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mWfKv70TL-RuLZo5UUeNUDhiXbzCJrA9uiEu2m-R_prQ@mail.gmail.com>
Message-ID: <CAJfZ7=mWfKv70TL-RuLZo5UUeNUDhiXbzCJrA9uiEu2m-R_prQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Destroy disabled optional blocks after pass
 is complete
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 16 21:57:29 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 8, 2021 at 5:23 PM James Carter <jwcart2@gmail.com> wrote:
>
> Nicolas Iooss reports:
>   I am continuing to investigate OSS-Fuzz crashes and the following one
>   is quite complex. Here is a CIL policy which triggers a
>   heap-use-after-free error in the CIL compiler:
>
>   (class CLASS (PERM2))
>   (classorder (CLASS))
>   (classpermission CLSPRM)
>   (optional o
>       (mlsvalidatetrans x (domby l1 h1))
>       (common CLSCOMMON (PERM1))
>       (classcommon CLASS CLSCOMMON)
>   )
>   (classpermissionset CLSPRM (CLASS (PERM1)))
>
>   The issue is that the mlsvalidatetrans fails to resolve in pass
>   CIL_PASS_MISC3, which comes after the resolution of classcommon (in
>   pass CIL_PASS_MISC2). So:
>
>   * In pass CIL_PASS_MISC2, the optional block still exists, the
>   classcommon is resolved and class CLASS is linked with common
>   CLSCOMMON.
>   * In pass CIL_PASS_MISC3, the optional block is destroyed, including
>   the common CLSCOMMON.
>   * When classpermissionset is resolved, function cil_resolve_classperms
>   uses "common_symtab = &class->common->perms;", which has been freed.
>   The use-after-free issue occurs in __cil_resolve_perms (in
>   libsepol/cil/src/cil_resolve_ast.c):
>
>     // common_symtab was freed
>     rc = cil_symtab_get_datum(common_symtab, curr->data, &perm_datum);
>
> The fundamental problem here is that when the optional block is
> disabled it is immediately destroyed in the middle of the pass, so
> the class has not been reset and still refers to the now destroyed
> common when the classpermissionset is resolved later in the same pass.
>
> Added a list, disabled_optionals, to struct cil_args_resolve which is
> passed when resolving the tree. When optionals are disabled, they are
> now added to this list and then are destroyed after the tree has been
> reset between passes.
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I confirm the patch fixes the issue.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 0c85eabe..49a5d139 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -51,6 +51,7 @@ struct cil_args_resolve {
>         struct cil_db *db;
>         enum cil_pass pass;
>         uint32_t *changed;
> +       struct cil_list *disabled_optionals;
>         struct cil_tree_node *optstack;
>         struct cil_tree_node *boolif;
>         struct cil_tree_node *macro;
> @@ -3863,7 +3864,7 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
>
>                 if (((struct cil_optional *)parent->data)->enabled == CIL_FALSE) {
>                         *(args->changed) = CIL_TRUE;
> -                       cil_tree_children_destroy(parent);
> +                       cil_list_append(args->disabled_optionals, CIL_NODE, parent);
>                 }
>
>                 /* pop off the stack */
> @@ -3926,6 +3927,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>         extra_args.in_list = NULL;
>         extra_args.blockstack = NULL;
>
> +       cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
>         cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
>         cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
>         cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
> @@ -3993,6 +3995,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>                 }
>
>                 if (changed && (pass > CIL_PASS_CALL1)) {
> +                       struct cil_list_item *item;
>                         /* Need to re-resolve because an optional was disabled that contained
>                          * one or more declarations. We only need to reset to the call1 pass
>                          * because things done in the preceding passes aren't allowed in
> @@ -4021,6 +4024,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
>                                 cil_log(CIL_ERR, "Failed to reset declarations\n");
>                                 goto exit;
>                         }
> +                       cil_list_for_each(item, extra_args.disabled_optionals) {
> +                               cil_tree_children_destroy(item->data);
> +                       }
> +                       cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
> +                       cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
>                 }
>
>                 /* reset the arguments */
> @@ -4049,6 +4057,7 @@ exit:
>         __cil_ordered_lists_destroy(&extra_args.catorder_lists);
>         __cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
>         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> +       cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
>         cil_list_destroy(&extra_args.in_list, CIL_FALSE);
>
>         return rc;
> --
> 2.26.2
>

