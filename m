Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BFFC4332D
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32C264F92
	for <selinux@archiver.kernel.org>; Sat,  6 Feb 2021 03:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhBFDFT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhBFCvN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Feb 2021 21:51:13 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18713C0617A7
        for <selinux@vger.kernel.org>; Fri,  5 Feb 2021 14:02:26 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 63so8411468oty.0
        for <selinux@vger.kernel.org>; Fri, 05 Feb 2021 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ke/iQKdjrVvMf6Ogy6itp5CbE7z37eS5V48khmiPMg=;
        b=mfT3Yg/d0XxtrSShtxP4GBBXG//aU6AO22p8DniN+7VGoWn5Akr4heKDdikTG2RZ48
         FW0oDihCLpd6vvFMajcKipoZJ8uF+9oZbtgSwK22f69PZ5rkb/yElOeokfwrudm1+BQ7
         WF0oG7eGsXGyTBxx4QSfWU5E1TaLqFgn/a1grFLM4blKRCcSYcwtpTDG1DVQCOSRZW8D
         u2XlJirDcPEt0NUKDR/yHZZijnyqPrbSMnoQ1P8j0+eZ2ckT12Ia/wx9/N+iODNyQaBK
         k9f5Pb+uJ8gkXI+gXC02kl4WkWigzgllkpx1qWhGQww/tMp+E5QHDd1i5UVEzWJXFn3H
         7FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ke/iQKdjrVvMf6Ogy6itp5CbE7z37eS5V48khmiPMg=;
        b=uTevfp1xNTrNdbTsfrWFT/HM1S91hUJnXlgV1v5ddWkJXE4mDAcuusVJUMsxYIgkb3
         Vy7catjtAV6Re/OtMmYf06eQEydVJFH03l2Lx/w0bVk+EUYt6qGn0HFD07v5dF4Fk4s6
         QgjVvZGAwnA77+oeEcvPlh6ZRS3ZOoZYvdNTcmUjQSSqY/1YT6ixw/A5/vK0/qlgYMS/
         lcGxLUiBvutITGoguCRLjDok70UzqdES6uc9VnyAtsqob2kULjXAsmF7OqwB+MySRQOs
         XuYjdx1K/ulV6XTP6ymsgfTq0lE3a44jAWYXvth/EDJl0kgf8xCMFphi+3LpAU++8drP
         IOsg==
X-Gm-Message-State: AOAM530hNGXiqAC4cwdUx+Ek7h2CZLp2Tef3F9rwrUSaFnDwMzN4/ar0
        1t7FnxSQLl0+IXisLt19TtPWNtiY+A39hQggG9Lr3bztEsk=
X-Google-Smtp-Source: ABdhPJxSIxEnCirAasxn4PKEVx1hpVZGnBtimNkdhlNMwhhFXHyV8QIYzj/MrEmk9w5lLzkggdv/oprQvmWvPGtQdSk=
X-Received: by 2002:a05:6830:3482:: with SMTP id c2mr4910182otu.59.1612562545372;
 Fri, 05 Feb 2021 14:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20210205094539.388854-1-nicolas.iooss@m4x.org> <20210205094539.388854-2-nicolas.iooss@m4x.org>
In-Reply-To: <20210205094539.388854-2-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 5 Feb 2021 17:02:14 -0500
Message-ID: <CAP+JOzQv0QzwL_OYBsaOPgFUGP+Bo1WQJGnJkaG2rN8T-O+s=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol/cil: be more robust when encountering <src_info>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 5, 2021 at 4:54 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> OSS-Fuzz found a Null-dereference READ in the CIL compiler when trying
> to compile the following policy:
>
>     (<src_info>)
>
> In cil_gen_src_info(), parse_current->next is NULL even though the code
> expects that both parse_current->next and parse_current->next->next
> exists.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28457
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

This is an interesting case. All of the <SOMETHING> are generated
internally. I never even thought about what would happen if they
actually appeared in the policy. I'll have to think about what the
best way to handle this is. Your patch works fine, but it might be
better to check for and reject these in the parser.

Jim

> ---
>  libsepol/cil/src/cil_build_ast.c | 5 +++++
>  libsepol/cil/src/cil_tree.c      | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 5094d62e2238..726f46cd478d 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -6070,6 +6070,11 @@ int cil_gen_src_info(struct cil_tree_node *parse_current, struct cil_tree_node *
>         /* No need to check syntax, because this is auto generated */
>         struct cil_src_info *info = NULL;
>
> +       if (parse_current->next == NULL || parse_current->next->next == NULL) {
> +               cil_tree_log(parse_current, CIL_ERR, "Bad <src_info>");
> +               return SEPOL_ERR;
> +       }
> +
>         cil_src_info_init(&info);
>
>         info->is_cil = (parse_current->next->data == CIL_KEY_SRC_CIL) ? CIL_TRUE : CIL_FALSE;
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 886412d1b974..3da972e9cf4e 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -69,7 +69,7 @@ struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **
>
>         while (node) {
>                 if (node->flavor == CIL_NODE && node->data == NULL) {
> -                       if (node->cl_head->data == CIL_KEY_SRC_INFO) {
> +                       if (node->cl_head->data == CIL_KEY_SRC_INFO && node->cl_head->next != NULL && node->cl_head->next->next != NULL) {
>                                 /* Parse Tree */
>                                 *path = node->cl_head->next->next->data;
>                                 *is_cil = (node->cl_head->next->data == CIL_KEY_SRC_CIL);
> --
> 2.30.0
>
