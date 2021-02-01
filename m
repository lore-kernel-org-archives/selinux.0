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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13637C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A4D64EA3
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBAO1P (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhBAO1K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:27:10 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D831AC06174A
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 06:26:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id k25so18926539oik.13
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpYQxQ03EBagIyA//jvF4s5jtoQdz8rg3nF199vZZp4=;
        b=ISWeRXVtyCt2s7LPNhy/IuVQU5oSO5X2d0SdFrzHeUmppuNmFOWUu3VKPFgPnw5LPZ
         IVwbCJgTiNeNVUdDp0r1i9/+qPjCyBNHjxD0AiPoC5W1Rz6rNJdoIs5D6hXTgBZ07Za9
         fZKVhTkmatPKr0POr5ccFw8rJ3MY++fYqfbGZM5BnsQAKtDr6lDq1F1KFxnAZfzMVydo
         fNHU/Q40qs8OanfVizKugqVrbb34IPclb/A6LzZVyNPpa7tXf86vOrDCeUYdWaHXWvm6
         XZCEpMydFYN0NLK0wnOKnY7hJXhXsFX8i0y84aBQDTguqpqsRmZMBIwwOefyQnE/LxdT
         5Ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpYQxQ03EBagIyA//jvF4s5jtoQdz8rg3nF199vZZp4=;
        b=uHTe3wsm6ywbNmh67HLOGaAFTLvq/hbZSX+1mw1RuMmFLwm51vN2brOAC5AYe//LMa
         h9KrmDp2mRyEUlwVoVA+Zn69doz+XyLYwMh+9f9gbIbftaukTVhj7YyFBzExHWv6OGMB
         +p9hVnP+9jJqnf8OpPkMWsbFqiLKNlv74p54qBdHzIxjRk54mqKcOroG/xTDpTCFVXni
         W6UitvoKICqTK9SglQEoGCZLe68HpAZYH6EVm420iFAj3r6hExFYDMihp+KFd15H0eO4
         FDXx21BS/upbtjUhUT8AsCaPDABT5wNKQ546bz+BffqwMd4/ylP0/XsTkfS4bStBPVMG
         mOoA==
X-Gm-Message-State: AOAM53330G4fDRyyLGhV8In/ZrSIm3HwOakpoj9ivOO+2OGPJb7nMCDl
        4jRHHwmfvhfoSOfjbPVU6vc9lgA60DpCfn/Rsc0Snibv
X-Google-Smtp-Source: ABdhPJwBxunei6VEckHoYgyagXjhImxVHYdGu/+UVvFcoK9KdXDlU8bF3Cq+jM9EO8yaJx+7znv11HZCoMSnbvmnBsE=
X-Received: by 2002:a05:6808:115:: with SMTP id b21mr10611849oie.16.1612189588347;
 Mon, 01 Feb 2021 06:26:28 -0800 (PST)
MIME-Version: 1.0
References: <20210131231240.58838-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210131231240.58838-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 1 Feb 2021 09:26:17 -0500
Message-ID: <CAP+JOzRZGq9AGFdHV7BAb5Eo4RboEtYH=ikHZH0SJfk2fBWxBQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix heap-use-after-free when using optional blockinherit
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 31, 2021 at 6:14 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When secilc compiles the following policy:
>
>     (block b1
>         (optional o1
>             (blockinherit b1)
>             (blockinherit x)
>         )
>     )
>
> it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK) because
> the block "x" does not exist. __cil_resolve_ast_last_child_helper()
> calls cil_tree_children_destroy() on the optional block, which destroys
> the two blockinherit statements. But the (blockinherit b1) node was
> referenced inside (block b1) node, in its block->bi_nodes list.
> Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY), it
> contains a node which was freed: this triggers a use-after-free issue
>
> Fix this issue by removing blockinherit nodes from their lists of nodes
> block->bi_nodes when they are being destroyed. As
> cil_destroy_blockinherit() does not have a reference to the node
> containing the blockinherit data, implement this new logic in
> cil_tree_node_destroy().
>
> This issue was found while investigating a testcase from an OSS-Fuzz
> issue which seems unrelated (a Null-dereference READ in
> cil_symtab_get_datum, https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

The patch is good, but I prefer the work to be done in
cil_destroy_blockinherit(), so I just sent out a patch based on this
one to do that.

Jim

> ---
>  libsepol/cil/src/cil_tree.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
> index 886412d1b974..72c4892de707 100644
> --- a/libsepol/cil/src/cil_tree.c
> +++ b/libsepol/cil/src/cil_tree.c
> @@ -223,11 +223,20 @@ void cil_tree_node_init(struct cil_tree_node **node)
>  void cil_tree_node_destroy(struct cil_tree_node **node)
>  {
>         struct cil_symtab_datum *datum;
> +       struct cil_blockinherit *inherit;
>
>         if (node == NULL || *node == NULL) {
>                 return;
>         }
>
> +       if ((*node)->flavor == CIL_BLOCKINHERIT) {
> +               inherit = (*node)->data;
> +               if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> +                       // Unlink the blockinherit from the block
> +                       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, *node, CIL_FALSE);
> +               }
> +       }
> +
>         if ((*node)->flavor >= CIL_MIN_DECLARATIVE) {
>                 datum = (*node)->data;
>                 cil_symtab_datum_remove_node(datum, *node);
> --
> 2.30.0
>
