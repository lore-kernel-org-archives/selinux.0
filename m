Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C1BC43381
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D85264E24
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 09:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhBCJCC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 04:02:02 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:34448 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhBCJCB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 04:02:01 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B8F5B5649E0
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 10:01:19 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id 63so22701160oty.0
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 01:01:19 -0800 (PST)
X-Gm-Message-State: AOAM533zZacNBnCX5gamiLEGdllSCsPOZNPbURmRQc+Glas+aVXzM87f
        /EL8UNQooZ59oS+NRtvQbdmCcufleLaRatNaCcc=
X-Google-Smtp-Source: ABdhPJwCRCblU2os59x/FUaitNo98/w2hGNF785+ZKCAO+XaFAEtATa77lfglRK9FfqFirkYmmJiPTuC8Vnv8pWJA/Q=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr1340663otr.96.1612342878673;
 Wed, 03 Feb 2021 01:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20210202205417.120630-1-jwcart2@gmail.com>
In-Reply-To: <20210202205417.120630-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 3 Feb 2021 10:01:07 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nOmd6roSTLupt44VpiseEViHQKFi-eWZNhT3tzRefLbw@mail.gmail.com>
Message-ID: <CAJfZ7=nOmd6roSTLupt44VpiseEViHQKFi-eWZNhT3tzRefLbw@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol/cil: Fix heap-use-after-free when using
 optional blockinherit
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 10:01:20 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 2, 2021 at 9:54 PM James Carter <jwcart2@gmail.com> wrote:
>
> This is based on a patch by Nicolas Iooss. He writes:
>     When secilc compiles the following policy:
>
>         (block b1
>             (optional o1
>                 (blockinherit b1)
>                 (blockinherit x)
>             )
>         )
>
>     it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK)
>     because the block "x" does not exist.
>     __cil_resolve_ast_last_child_helper() calls
>     cil_tree_children_destroy() on the optional block, which destroys
>     the two blockinherit statements. But the (blockinherit b1) node
>     was referenced inside (block b1) node, in its block->bi_nodes list.
>     Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY),
>     it contains a node which was freed: this triggers a use-after-free
>     issue
>
>     Fix this issue by removing blockinherit nodes from their lists of
>     nodes block->bi_nodes when they are being destroyed. As
>     cil_destroy_blockinherit() does not have a reference to the node
>     containing the blockinherit data, implement this new logic in
>     cil_tree_node_destroy().
>
>     This issue was found while investigating a testcase from an OSS-Fuzz
>     issue which seems unrelated (a Null-dereference READ in
>     cil_symtab_get_datum,
>     https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).
>
> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: James Carter <jwcart2@gmail.com>

I tested the patch and confirm it fixes the issue.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/cil/src/cil_build_ast.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 02481558..ab0efd53 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -283,6 +283,19 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
>                 return;
>         }
>
> +       if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> +               struct cil_tree_node *node;
> +               struct cil_list_item *item;
> +
> +               cil_list_for_each(item, inherit->block->bi_nodes) {
> +                       node = item->data;
> +                       if (node->data == inherit) {
> +                               cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
> +                               break;
> +                       }
> +               }
> +       }
> +
>         free(inherit);
>  }
>
> --
> 2.26.2
>

