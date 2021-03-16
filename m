Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E51C433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C95964F39
	for <selinux@archiver.kernel.org>; Tue, 16 Mar 2021 20:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhCPUtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:49:31 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:44852 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhCPUtI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Mar 2021 16:49:08 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id ACBD6564C35
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 21:49:04 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id z5so17542189plg.3
        for <selinux@vger.kernel.org>; Tue, 16 Mar 2021 13:49:04 -0700 (PDT)
X-Gm-Message-State: AOAM533EWpArHZmMsbzyTAUbEBpSPDDVyTQ9CgBMOCmkckkqRefIj652
        NZKlFdKfWoaZCTgxfVrP+RGksQGE9TvR+6K6znQ=
X-Google-Smtp-Source: ABdhPJyHyep8Fu4YbKz0Xk17bQnJHOb+ZVh06onCGhLR6bRyGCXpSifzSBI4aU75ZKVyJ5pn0fog+YMfwauleQfhl7I=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr837220pjh.143.1615927743402;
 Tue, 16 Mar 2021 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210316165131.37312-1-jwcart2@gmail.com>
In-Reply-To: <20210316165131.37312-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 16 Mar 2021 21:48:52 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==dLpSiV04zRKJdSXMg-FS3uZVQcQkixdK9tJ4+4d8xvQ@mail.gmail.com>
Message-ID: <CAJfZ7==dLpSiV04zRKJdSXMg-FS3uZVQcQkixdK9tJ4+4d8xvQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check for duplicate blocks, optionals, and macros
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 16 21:49:05 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 5:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> In CIL, blocks, optionals, and macros share the same symbol table so
> that the targets of "in" statements can be located. Because of this,
> they cannot have the same name in the same namespace, but, because
> they do not show up in the final policy, they can have the same name
> as long as they are in different namespaces. Unfortunately, when
> copying from one namespace to another, no check was being done to see
> if there was a conflict.
>
> When copying blocks, optionals, and macros, if a datum is found in
> the destination namespace, then there is a conflict with a previously
> declared block, optional, or macro, so exit with an error.
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I confirm this patch fixes the reported bug, and makes secilc no
longer crashes on the non-reduced test case found by OSS-Fuzz.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/cil/src/cil_copy_ast.c | 89 +++++++++------------------------
>  1 file changed, 25 insertions(+), 64 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> index c9aada9d..ed967861 100644
> --- a/libsepol/cil/src/cil_copy_ast.c
> +++ b/libsepol/cil/src/cil_copy_ast.c
> @@ -100,16 +100,17 @@ int cil_copy_block(__attribute__((unused)) struct cil_db *db, void *data, void *
>         struct cil_block *orig = data;
>         char *key = orig->datum.name;
>         struct cil_symtab_datum *datum = NULL;
> +       struct cil_block *new;
>
>         cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum == NULL) {
> -               struct cil_block *new;
> -               cil_block_init(&new);
> -               *copy = new;
> -       } else {
> -               *copy = datum;;
> +       if (datum != NULL) {
> +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> +               return SEPOL_ERR;
>         }
>
> +       cil_block_init(&new);
> +       *copy = new;
> +
>         return SEPOL_OK;
>  }
>
> @@ -1509,64 +1510,22 @@ int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void *
>         struct cil_macro *orig = data;
>         char *key = orig->datum.name;
>         struct cil_symtab_datum *datum = NULL;
> +       struct cil_macro *new;
>
>         cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum == NULL) {
> -               struct cil_macro *new;
> -               cil_macro_init(&new);
> -               if (orig->params != NULL) {
> -                       cil_copy_list(orig->params, &new->params);
> -               }
> -
> -               *copy = new;
> -
> -       } else {
> -               struct cil_list_item *curr_orig = NULL;
> -               struct cil_list_item *curr_new = NULL;
> -               struct cil_param *param_orig = NULL;
> -               struct cil_param *param_new = NULL;
> -
> -               if (((struct cil_macro*)datum)->params != NULL) {
> -                       curr_new = ((struct cil_macro*)datum)->params->head;
> -               }
> -
> -               if (orig->params != NULL) {
> -                       curr_orig = orig->params->head;
> -               }
> -
> -               if (curr_orig != NULL && curr_new != NULL) {
> -                       while (curr_orig != NULL) {
> -                               if (curr_new == NULL) {
> -                                       goto exit;
> -                               }
> -
> -                               param_orig = (struct cil_param*)curr_orig->data;
> -                               param_new = (struct cil_param*)curr_new->data;
> -                               if (param_orig->str != param_new->str) {
> -                                       goto exit;
> -                               } else if (param_orig->flavor != param_new->flavor) {
> -                                       goto exit;
> -                               }
> -
> -                               curr_orig = curr_orig->next;
> -                               curr_new = curr_new->next;
> -                       }
> -
> -                       if (curr_new != NULL) {
> -                               goto exit;
> -                       }
> -               } else if (!(curr_orig == NULL && curr_new == NULL)) {
> -                       goto exit;
> -               }
> +       if (datum != NULL) {
> +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> +               return SEPOL_ERR;
> +       }
>
> -               *copy = datum;
> +       cil_macro_init(&new);
> +       if (orig->params != NULL) {
> +               cil_copy_list(orig->params, &new->params);
>         }
>
> -       return SEPOL_OK;
> +       *copy = new;
>
> -exit:
> -       cil_log(CIL_INFO, "cil_copy_macro: macro cannot be redefined\n");
> -       return SEPOL_ERR;
> +       return SEPOL_OK;
>  }
>
>  int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> @@ -1574,16 +1533,17 @@ int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, voi
>         struct cil_optional *orig = data;
>         char *key = orig->datum.name;
>         struct cil_symtab_datum *datum = NULL;
> +       struct cil_optional *new;
>
>         cil_symtab_get_datum(symtab, key, &datum);
> -       if (datum == NULL) {
> -               struct cil_optional *new;
> -               cil_optional_init(&new);
> -               *copy = new;
> -       } else {
> -               *copy = datum;
> +       if (datum != NULL) {
> +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> +               return SEPOL_ERR;
>         }
>
> +       cil_optional_init(&new);
> +       *copy = new;
> +
>         return SEPOL_OK;
>  }
>
> @@ -2122,6 +2082,7 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
>                         args->dest = new;
>                 }
>         } else {
> +               cil_tree_log(orig, CIL_ERR, "Problem copying %s node", cil_node_to_string(orig));
>                 goto exit;
>         }
>
> --
> 2.26.2
>

