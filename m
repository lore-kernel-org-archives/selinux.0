Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335DDC433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067A960555
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbhIFRzI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:55:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40371 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243962AbhIFRzH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 13:55:07 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id AF16C564771
        for <selinux@vger.kernel.org>; Mon,  6 Sep 2021 19:54:00 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id i13so4716832pjv.5
        for <selinux@vger.kernel.org>; Mon, 06 Sep 2021 10:54:00 -0700 (PDT)
X-Gm-Message-State: AOAM530yBPQU5sehBBGhVUTP8TFc3dXpyJkN3XH70ywt7qaj5XUArGaj
        Q2q0EGW7MUsaRr7FQHmN+zzMfUEvRGn7WF8DWXI=
X-Google-Smtp-Source: ABdhPJwN6AYxiUPF9g6oipN4C58Hu+Dek6k6W1hPlvXUZY5bOdkYWV4+gpRRBxfUjOJaRVvqWClEXcP+98Ej67ORexk=
X-Received: by 2002:a17:90a:6507:: with SMTP id i7mr254548pjj.205.1630950839171;
 Mon, 06 Sep 2021 10:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210901204252.635570-1-jwcart2@gmail.com>
In-Reply-To: <20210901204252.635570-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 6 Sep 2021 19:53:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kr1AxWqEV66kiAA0zkBpQ5mJ+woGL-my8_Szs7T_-LpA@mail.gmail.com>
Message-ID: <CAJfZ7=kr1AxWqEV66kiAA0zkBpQ5mJ+woGL-my8_Szs7T_-LpA@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] libsepol/cil: Remove redundant syntax checking
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep  6 19:54:01 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 1, 2021 at 10:42 PM James Carter <jwcart2@gmail.com> wrote:
>
> For every call to cil_fill_classperms_list(), the syntax of the
> whole rule, including the class permissions, has already been
> checked. There is no reason to check it again. Also, because the
> class permissions appear in the middle of some rules, like
> constraints, the syntax array does not end with CIL_SYN_END. This
> is the only case where the syntax array does not end with CIL_SYN_END.
> This prevents __cil_verify_syntax() from requiring that the syntax
> array ends with CIL_SYN_END.
>
> Remove the redundant syntax checking in cil_fill_classperms_list().
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> v2: Same as v1

For these 3 patches:

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

>
>  libsepol/cil/src/cil_build_ast.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index a5afc267..f0bb8c0c 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -736,20 +736,11 @@ int cil_fill_classperms_list(struct cil_tree_node *parse_current, struct cil_lis
>  {
>         int rc = SEPOL_ERR;
>         struct cil_tree_node *curr;
> -       enum cil_syntax syntax[] = {
> -               CIL_SYN_STRING | CIL_SYN_LIST,
> -       };
> -       int syntax_len = sizeof(syntax)/sizeof(*syntax);
>
>         if (parse_current == NULL || cp_list == NULL) {
>                 goto exit;
>         }
>
> -       rc = __cil_verify_syntax(parse_current, syntax, syntax_len);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         cil_list_init(cp_list, CIL_CLASSPERMS);
>
>         curr = parse_current->cl_head;
> --
> 2.31.1
>

