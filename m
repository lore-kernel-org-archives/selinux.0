Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F144CC433EF
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 22:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD74361526
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 22:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhJDWLI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:11:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:57602 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhJDWLI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 18:11:08 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 814E9560079
        for <selinux@vger.kernel.org>; Tue,  5 Oct 2021 00:09:16 +0200 (CEST)
Received: by mail-io1-f44.google.com with SMTP id 134so22067603iou.12
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 15:09:16 -0700 (PDT)
X-Gm-Message-State: AOAM531OjKWoIjsCt/BlLPbwWGFIymActO2kcut9k1jEYvFvWwKc9SPf
        mqFLLdQ/9c9TrMDnlj8tEcyZdwZOkpxwbAUxwVs=
X-Google-Smtp-Source: ABdhPJz5NtyhGfBC81FKQ5cnW4WMYvGiV3ZuvlLaBUuXDze3gkhZvH6h/Ay0wERh+yQu9UVOO7W+vgFf7S6/oZI/NfQ=
X-Received: by 2002:a02:cac8:: with SMTP id f8mr11886203jap.66.1633385355393;
 Mon, 04 Oct 2021 15:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210929202454.136401-1-jwcart2@gmail.com>
In-Reply-To: <20210929202454.136401-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 5 Oct 2021 00:09:04 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mKjv_MYAqWmUFMCD8aDJgsnXzj1YmyuDPhfta87RTjRQ@mail.gmail.com>
Message-ID: <CAJfZ7=mKjv_MYAqWmUFMCD8aDJgsnXzj1YmyuDPhfta87RTjRQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not skip macros when resolving until
 later passes
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Oct  5 00:09:17 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 29, 2021 at 10:25 PM James Carter <jwcart2@gmail.com> wrote:
>
> Since only tunableifs need to be resolved in a macro before the macro
> is copied for each call, macros were being skipped after resolving
> tunableifs. Statments not allowed to be in macros would be found during
> the pass that resolved tunableifs. Unfortunately, in-statments are
> resolved after tunableifs and they can be used to add statements to
> macros that are not allowed.
>
> Instead, do not skip macros until after the pass that resolves in-
> statements that are to be resolved after block inheritance. This
> allows blocks, blockinherits, blockabstracts, and macros that were
> added by an in-statement to be found and an error reported.
>
> This bug was found by the secilc-fuzzer.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I confirm this fixes the issue reported in
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36466&q=selinux&can=2
which can be reproduced by the following policy:

(macro MACRO ())
(in MACRO (blockinherit BLOCK)) (call MACRO)
(in MACRO (blockinherit BLOCK)) (call MACRO)
(in MACRO (blockinherit BLOCK)) (call MACRO)
(in MACRO (blockinherit BLOCK)) (call MACRO)
(in MACRO (blockinherit BLOCK)) (call MACRO)
(in MACRO (blockinherit BLOCK)) (call MACRO)
...
repeated at least 4000 times

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 2cf94368..e97a9f46 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3946,7 +3946,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
>         }
>
>         if (node->flavor == CIL_MACRO) {
> -               if (pass != CIL_PASS_TIF) {
> +               if (pass > CIL_PASS_IN_AFTER) {
>                         *finished = CIL_TREE_SKIP_HEAD;
>                         rc = SEPOL_OK;
>                         goto exit;
> --
> 2.31.1
>

