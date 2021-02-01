Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64359C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 22:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3105164D92
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 22:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhBAWJF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:09:05 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35937 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBAWJB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 17:09:01 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D3F04564EE0
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 23:08:18 +0100 (CET)
Received: by mail-oo1-f48.google.com with SMTP id u7so4678408ooq.0
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 14:08:18 -0800 (PST)
X-Gm-Message-State: AOAM533/WxTynZiGNtyLI1nlM4pxQNN9ohAG36smedLOaa4YgPhmNUOO
        4jCQ1csq/XeErhLatHMkxTFGCl45e/h69eoztX0=
X-Google-Smtp-Source: ABdhPJzFC3DZZs68kayxmvEqMibWv5kS2wtiPaB6W5eckaxW+e5UuL93QtEsQeAihDQWS5a16kMB3+6d0An8yzx8MCE=
X-Received: by 2002:a4a:3b4f:: with SMTP id s76mr13115828oos.29.1612217297675;
 Mon, 01 Feb 2021 14:08:17 -0800 (PST)
MIME-Version: 1.0
References: <20210201142426.134081-1-jwcart2@gmail.com>
In-Reply-To: <20210201142426.134081-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 1 Feb 2021 23:08:06 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mZWzLbs5+Ba5bcGaAvOBSYzB5af6hDcGHjJ-i0fXmAVg@mail.gmail.com>
Message-ID: <CAJfZ7=mZWzLbs5+Ba5bcGaAvOBSYzB5af6hDcGHjJ-i0fXmAVg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix heap-use-after-free when using optional blockinherit
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  1 23:08:19 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 1, 2021 at 3:24 PM James Carter <jwcart2@gmail.com> wrote:
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
> ---
>  libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 02481558..3d8367fe 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -283,6 +283,23 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
>                 return;
>         }
>
> +       if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> +               struct cil_tree_node *node;
> +               struct cil_list_item *item;
> +               int found = CIL_FALSE;
> +
> +               cil_list_for_each(item, inherit->block->bi_nodes) {
> +                       node = item->data;
> +                       if (node->data == inherit) {
> +                               found = CIL_TRUE;
> +                               break;
> +                       }
> +               }
> +               if (found == CIL_TRUE) {
> +                       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
> +               }
> +       }
> +
>         free(inherit);
>  }

Hello,
The code seems to be too complex for two reasons.

First, doing "if (node->data == inherit) found = CIL_TRUE;" then "if
(found == CIL_TRUE){...}" seems too verbose. The code could be
simplified to something such as:

if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
  struct cil_list_item *item;

  /* Find the in bi_nodes the item which contains the inherit object */
  cil_list_for_each(item, inherit->block->bi_nodes) {
    struct cil_tree_node *node = item->data;
    if (node->data == inherit) {
      cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
      break;
    }
  }
}

Second, doing so makes the code browse the inherit->block->bi_nodes
list twice (in cil_list_for_each and cil_list_remove). This seems to
be easily optimisable by unlinking item when if (node->data ==
inherit), but unfortunately there is no helper function for this
(because cil_list_item_destroy() does not unlink the item). What do
you think of adding a new helper function
cil_list_item_unlink_and_destroy(list, item, destroy_data) which would
provide a feature between cil_list_remove() and
cil_list_item_destroy()?

By the way, while testing more the patch I sent, I found out that this
introduces a use-after-free issue if inherit->block was freed. I
encountered this issue with a simple CIL policy: "(block
b2a)(blockinherit b2a)". I will send a patch for this, which performs
the opposite operation in cil_destroy_block().

Thanks,
Nicolas

