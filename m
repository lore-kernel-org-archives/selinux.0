Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A0EC2B9F4
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A9960FE5
	for <selinux@archiver.kernel.org>; Sat, 19 Jun 2021 14:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhFSOFR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:05:17 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41297 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbhFSOFQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 19 Jun 2021 10:05:16 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EE0B956481A
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 16:03:03 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id p13so10093220pfw.0
        for <selinux@vger.kernel.org>; Sat, 19 Jun 2021 07:03:03 -0700 (PDT)
X-Gm-Message-State: AOAM5304DTEyBkWaiMLK4A+Im+tdrie4NjfcOGqjY07vpZEa8W0QdmKN
        Xiiqb/5Gxwzo/WeVhOWeqSHtIYLkZmKlA5eQg44=
X-Google-Smtp-Source: ABdhPJyWGrEZYJuFzWUlJfbUprDBuGhu7KfxhuWv0TCSyi8qC3O1YS/8vPuPF+w38RkqrKcE7nVc+Uy9CavozjTfmjU=
X-Received: by 2002:a63:d242:: with SMTP id t2mr15000793pgi.210.1624111382618;
 Sat, 19 Jun 2021 07:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-6-jwcart2@gmail.com>
In-Reply-To: <20210614150546.512001-6-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 19 Jun 2021 16:02:51 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mg0avBT_bmj2cQe5Xv6_k6Dz7dSuuaGs=WxaJnc6AMtw@mail.gmail.com>
Message-ID: <CAJfZ7=mg0avBT_bmj2cQe5Xv6_k6Dz7dSuuaGs=WxaJnc6AMtw@mail.gmail.com>
Subject: Re: [PATCH 5/5] libsepol/cil: Improve degenerate inheritance check
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jun 19 16:03:04 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
>
> The commit 74d00a8decebf940d95064ff60042dcb2cbcc2c0 (libsepol/cil:
> Detect degenerate inheritance and exit with an error) detects the
> use of inheritance (mostly by the secilc-fuzzer and not in any real
> policies) that results in the exponential growth of the policy through
> the copying of blocks that takes place with inheritance in CIL.
> Unfortunately, the check takes place during the pass when all the
> blocks are being copied, so it is possible to consume all of a system's
> memory before an error is produced.
>
> The new check happens in two parts. First, a check is made while the
> block inheritance is being linked to the block it will inherit. In
> this check, all of the parent nodes of the inheritance rule up to the
> root node are checked and if enough of these blocks are being inherited
> (>= CIL_DEGENERATE_INHERITANCE_DEPTH), then a flag is set for a more
> in-depth check after the pass. This in-depth check will determine the
> number of potential inheritances that will occur when resolving the
> all of the inheritance rules. If this value is greater than
> CIL_DEGENERATE_INHERITANCE_GROWTH * the original number of inheritance
> rules and greater than CIL_DEGENERATE_INHERITANCE_MINIMUM (which is
> set to 0x1 << CIL_DEGENERATE_INHERITANCE_DEPTH), then degenerate
> inheritance is determined to have occurred and an error result will
> be returned.
>
> Since the potential number of inheritances can quickly be an extremely
> large number, the count of potential inheritances is aborted as soon
> as the threshold for degenerate inheritance has been exceeded.
>
> Normal policies should rarely, if ever, have the in-depth check occur.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_internal.h    |   5 +-
>  libsepol/cil/src/cil_resolve_ast.c | 229 +++++++++++++++++++----------
>  2 files changed, 153 insertions(+), 81 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> index a77c9520..b8610976 100644
> --- a/libsepol/cil/src/cil_internal.h
> +++ b/libsepol/cil/src/cil_internal.h
> @@ -48,8 +48,9 @@
>
>  #define CIL_MAX_NAME_LENGTH 2048
>
> -#define CIL_DEGENERATE_INHERITANCE_DEPTH 12
> -#define CIL_DEGENERATE_INHERITANCE_BREADTH (0x1 << CIL_DEGENERATE_INHERITANCE_DEPTH)
> +#define CIL_DEGENERATE_INHERITANCE_DEPTH 10UL
> +#define CIL_DEGENERATE_INHERITANCE_MINIMUM (0x01 << CIL_DEGENERATE_INHERITANCE_DEPTH)
> +#define CIL_DEGENERATE_INHERITANCE_GROWTH 10UL
>
>  enum cil_pass {
>         CIL_PASS_INIT = 0,
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 77ffe0ff..baf6fc0d 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -62,6 +62,7 @@ struct cil_args_resolve {
>         struct cil_list *catorder_lists;
>         struct cil_list *sensitivityorder_lists;
>         struct cil_list *in_list;
> +       int *inheritance_check;
>  };
>
>  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> @@ -2306,40 +2307,7 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_args)
> -{
> -       struct cil_blockinherit *inherit = current->data;
> -       struct cil_symtab_datum *block_datum = NULL;
> -       struct cil_tree_node *node = NULL;
> -       int rc = SEPOL_ERR;
> -
> -       rc = cil_resolve_name(current, inherit->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
> -       node = NODE(block_datum);
> -
> -       if (node->flavor != CIL_BLOCK) {
> -               cil_log(CIL_ERR, "%s is not a block\n", cil_node_to_string(node));
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
> -       inherit->block = (struct cil_block *)block_datum;
> -
> -       if (inherit->block->bi_nodes == NULL) {
> -               cil_list_init(&inherit->block->bi_nodes, CIL_NODE);
> -       }
> -       cil_list_append(inherit->block->bi_nodes, CIL_NODE, current);
> -
> -       return SEPOL_OK;
> -
> -exit:
> -       return rc;
> -}
> -
> -void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_tree_node *terminating_node)
> +static void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_tree_node *terminating_node)
>  {
>         struct cil_list *trace = NULL;
>         struct cil_list_item *item = NULL;
> @@ -2377,7 +2345,7 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
>         cil_list_destroy(&trace, CIL_FALSE);
>  }
>
> -int cil_check_recursive_blockinherit(struct cil_tree_node *bi_node)
> +static int cil_check_recursive_blockinherit(struct cil_tree_node *bi_node)
>  {
>         struct cil_tree_node *curr = NULL;
>         struct cil_blockinherit *bi = NULL;
> @@ -2410,53 +2378,68 @@ exit:
>         return rc;
>  }
>
> -/*
> - * Detect degenerate inheritance of the form:
> - * ...
> - * (blockinherit ba)
> - * (block ba
> - *    (block b1
> - *      (blockinherit bb)
> - *    )
> - *    (block bb
> - *      (block b2
> - *        (blockinherit bc)
> - *      )
> - *      (block bc
> - *      ...
> - */
> -static int cil_check_for_degenerate_inheritance(struct cil_tree_node *current)
> +static int cil_possible_degenerate_inheritance(struct cil_tree_node *node)
>  {
> -       struct cil_block *block = current->data;
> -       struct cil_tree_node *node;
> -       struct cil_list_item *item;
> -       unsigned depth;
> -       unsigned breadth = 0;
> -
> -       cil_list_for_each(item, block->bi_nodes) {
> -               breadth++;
> -       }
> +       unsigned depth = 1;
>
> -       if (breadth >= CIL_DEGENERATE_INHERITANCE_BREADTH) {
> -               node = current->parent;
> -               depth = 0;
> -               while (node && node->flavor != CIL_ROOT) {
> -                       if (node->flavor == CIL_BLOCK) {
> -                               block = node->data;
> -                               if (block->bi_nodes != NULL) {
> -                                       depth++;
> -                               }
> +       node = node->parent;
> +       while (node && node->flavor != CIL_ROOT) {
> +               if (node->flavor == CIL_BLOCK) {
> +                       if (((struct cil_block *)(node->data))->bi_nodes != NULL) {
> +                               depth++;
>                         }
> -                       node = node->parent;
>                 }
> +               node = node->parent;
> +       }
>
> -               if (depth >= CIL_DEGENERATE_INHERITANCE_DEPTH) {
> -                       cil_tree_log(current, CIL_ERR, "Degenerate inheritance detected (depth=%u, breadth=%u)", depth, breadth);
> -                       return SEPOL_ERR;
> -               }
> +       if (depth >= CIL_DEGENERATE_INHERITANCE_DEPTH) {
> +               return CIL_TRUE;
> +       }

When I first read the code, I wondered whether this "if" condition
would better be in the while loop, in order to break early when depth
exceeds the threshold. Then I thought that the code was actually
right, because the condition is expected to be unlikely. Maybe you
could add a comment /* This condition is unlikely to happen so put it
after the loop */ right before if (depth >=
CIL_DEGENERATE_INHERITANCE_DEPTH)?

By the way in the patch I saw how "inheritance_check" is set, but I
did not find where it is actually checked. Could you point me to the
functions/lines which actually use its value?

Cheers,
Nicolas

