Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BF0C4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09006124B
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 14:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFUOUz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFUOUz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 10:20:55 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD800C061574
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:18:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so17851365otk.5
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaM+49dxSVyJRojSILBFWnw6Xwp5fgPTuX9VavGCnag=;
        b=gdFeYqSAkEcxpUrE6vWlWgdbfSdnGDzp3x+FviXqxjiLsYkedATKBEIWCSPZYVZjdK
         isyhm6IlXGmASodbuIdKff5bxEuO3M2lT0mi05HgEDrIY2f1Lu4OZhwzzsT0cLXUOsob
         u6+E7K6uoVfc4aCSYJfIiHUMUcOjUng75rqT3YY8aMMOiyCJgM0m0u166iXHGXK6XCj3
         WGVejzVovj+3ST7fOwlgAy1XPjEkFXtTLnk4dI9IFFJ+3ZnLNM1nnw2LV7ohfs9T829z
         Fot9MbJEG7jB04tTFOuNLC061wx+qxTd9x2RRyUq5+Iczj5RA+E+y22+PMZDf66qapl/
         BTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaM+49dxSVyJRojSILBFWnw6Xwp5fgPTuX9VavGCnag=;
        b=dD/aXjFBP012p6jl9OBtL3/e0LFkWLUOBS4OMq6Hi6GWov0FGgn+5HTHviuRLHWayz
         E7xO+bnGCWh6agXDJ3V5W2ofBUNHAQkOgTCb5zMQB241Vyi0DgnSDBG3onkC6KgNBNd6
         2pJqmMqhWLpCI3Sv9OEV1D7oqZ1miiZhHbysqkgqroz+3376PJqVv0IP+awoEJ9iR6/7
         9MgXfNqAdfgpC++N8EJFkKjEXkMjngYKDxP7TpxmOO1aGZPaIaqM84AaXCT4trtmCvLC
         i1fAJ2n8Pn1l3aeRbrbj/Shsv9HI2cM0ozvUVAAHSd7DN0374zyiQRwvahX6FB0e2a4k
         VDoQ==
X-Gm-Message-State: AOAM5326fXr1odZHpWUCcWKmDmc/f0HnG1D6cf8jW561fLrt3Z/gBRi3
        qckbz7dCfPDiKSg1z2CfspOvkGJ6Pxh1yZnrEqs=
X-Google-Smtp-Source: ABdhPJwCl+D9K0wHss2XtvTd16YQHNVt0tnlFH7VSI4kXNOJgvTOlJoAmgsCqbiNt8CYeu5dgJa8/Tdm9mA+7+zcpJY=
X-Received: by 2002:a9d:618f:: with SMTP id g15mr9314799otk.196.1624285119249;
 Mon, 21 Jun 2021 07:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210614150546.512001-1-jwcart2@gmail.com> <20210614150546.512001-6-jwcart2@gmail.com>
 <CAJfZ7=mg0avBT_bmj2cQe5Xv6_k6Dz7dSuuaGs=WxaJnc6AMtw@mail.gmail.com>
In-Reply-To: <CAJfZ7=mg0avBT_bmj2cQe5Xv6_k6Dz7dSuuaGs=WxaJnc6AMtw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 21 Jun 2021 10:18:28 -0400
Message-ID: <CAP+JOzTnNFAvuKTNymmEiWYbyogU-mFKOm1WMPLG+K576Qxmrg@mail.gmail.com>
Subject: Re: [PATCH 5/5] libsepol/cil: Improve degenerate inheritance check
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 19, 2021 at 10:03 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Jun 14, 2021 at 5:05 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The commit 74d00a8decebf940d95064ff60042dcb2cbcc2c0 (libsepol/cil:
> > Detect degenerate inheritance and exit with an error) detects the
> > use of inheritance (mostly by the secilc-fuzzer and not in any real
> > policies) that results in the exponential growth of the policy through
> > the copying of blocks that takes place with inheritance in CIL.
> > Unfortunately, the check takes place during the pass when all the
> > blocks are being copied, so it is possible to consume all of a system's
> > memory before an error is produced.
> >
> > The new check happens in two parts. First, a check is made while the
> > block inheritance is being linked to the block it will inherit. In
> > this check, all of the parent nodes of the inheritance rule up to the
> > root node are checked and if enough of these blocks are being inherited
> > (>= CIL_DEGENERATE_INHERITANCE_DEPTH), then a flag is set for a more
> > in-depth check after the pass. This in-depth check will determine the
> > number of potential inheritances that will occur when resolving the
> > all of the inheritance rules. If this value is greater than
> > CIL_DEGENERATE_INHERITANCE_GROWTH * the original number of inheritance
> > rules and greater than CIL_DEGENERATE_INHERITANCE_MINIMUM (which is
> > set to 0x1 << CIL_DEGENERATE_INHERITANCE_DEPTH), then degenerate
> > inheritance is determined to have occurred and an error result will
> > be returned.
> >
> > Since the potential number of inheritances can quickly be an extremely
> > large number, the count of potential inheritances is aborted as soon
> > as the threshold for degenerate inheritance has been exceeded.
> >
> > Normal policies should rarely, if ever, have the in-depth check occur.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_internal.h    |   5 +-
> >  libsepol/cil/src/cil_resolve_ast.c | 229 +++++++++++++++++++----------
> >  2 files changed, 153 insertions(+), 81 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> > index a77c9520..b8610976 100644
> > --- a/libsepol/cil/src/cil_internal.h
> > +++ b/libsepol/cil/src/cil_internal.h
> > @@ -48,8 +48,9 @@
> >
> >  #define CIL_MAX_NAME_LENGTH 2048
> >
> > -#define CIL_DEGENERATE_INHERITANCE_DEPTH 12
> > -#define CIL_DEGENERATE_INHERITANCE_BREADTH (0x1 << CIL_DEGENERATE_INHERITANCE_DEPTH)
> > +#define CIL_DEGENERATE_INHERITANCE_DEPTH 10UL
> > +#define CIL_DEGENERATE_INHERITANCE_MINIMUM (0x01 << CIL_DEGENERATE_INHERITANCE_DEPTH)
> > +#define CIL_DEGENERATE_INHERITANCE_GROWTH 10UL
> >
> >  enum cil_pass {
> >         CIL_PASS_INIT = 0,
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 77ffe0ff..baf6fc0d 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -62,6 +62,7 @@ struct cil_args_resolve {
> >         struct cil_list *catorder_lists;
> >         struct cil_list *sensitivityorder_lists;
> >         struct cil_list *in_list;
> > +       int *inheritance_check;
> >  };
> >
> >  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> > @@ -2306,40 +2307,7 @@ exit:
> >         return rc;
> >  }
> >
> > -int cil_resolve_blockinherit_link(struct cil_tree_node *current, void *extra_args)
> > -{
> > -       struct cil_blockinherit *inherit = current->data;
> > -       struct cil_symtab_datum *block_datum = NULL;
> > -       struct cil_tree_node *node = NULL;
> > -       int rc = SEPOL_ERR;
> > -
> > -       rc = cil_resolve_name(current, inherit->block_str, CIL_SYM_BLOCKS, extra_args, &block_datum);
> > -       if (rc != SEPOL_OK) {
> > -               goto exit;
> > -       }
> > -
> > -       node = NODE(block_datum);
> > -
> > -       if (node->flavor != CIL_BLOCK) {
> > -               cil_log(CIL_ERR, "%s is not a block\n", cil_node_to_string(node));
> > -               rc = SEPOL_ERR;
> > -               goto exit;
> > -       }
> > -
> > -       inherit->block = (struct cil_block *)block_datum;
> > -
> > -       if (inherit->block->bi_nodes == NULL) {
> > -               cil_list_init(&inherit->block->bi_nodes, CIL_NODE);
> > -       }
> > -       cil_list_append(inherit->block->bi_nodes, CIL_NODE, current);
> > -
> > -       return SEPOL_OK;
> > -
> > -exit:
> > -       return rc;
> > -}
> > -
> > -void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_tree_node *terminating_node)
> > +static void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_tree_node *terminating_node)
> >  {
> >         struct cil_list *trace = NULL;
> >         struct cil_list_item *item = NULL;
> > @@ -2377,7 +2345,7 @@ void cil_print_recursive_blockinherit(struct cil_tree_node *bi_node, struct cil_
> >         cil_list_destroy(&trace, CIL_FALSE);
> >  }
> >
> > -int cil_check_recursive_blockinherit(struct cil_tree_node *bi_node)
> > +static int cil_check_recursive_blockinherit(struct cil_tree_node *bi_node)
> >  {
> >         struct cil_tree_node *curr = NULL;
> >         struct cil_blockinherit *bi = NULL;
> > @@ -2410,53 +2378,68 @@ exit:
> >         return rc;
> >  }
> >
> > -/*
> > - * Detect degenerate inheritance of the form:
> > - * ...
> > - * (blockinherit ba)
> > - * (block ba
> > - *    (block b1
> > - *      (blockinherit bb)
> > - *    )
> > - *    (block bb
> > - *      (block b2
> > - *        (blockinherit bc)
> > - *      )
> > - *      (block bc
> > - *      ...
> > - */
> > -static int cil_check_for_degenerate_inheritance(struct cil_tree_node *current)
> > +static int cil_possible_degenerate_inheritance(struct cil_tree_node *node)
> >  {
> > -       struct cil_block *block = current->data;
> > -       struct cil_tree_node *node;
> > -       struct cil_list_item *item;
> > -       unsigned depth;
> > -       unsigned breadth = 0;
> > -
> > -       cil_list_for_each(item, block->bi_nodes) {
> > -               breadth++;
> > -       }
> > +       unsigned depth = 1;
> >
> > -       if (breadth >= CIL_DEGENERATE_INHERITANCE_BREADTH) {
> > -               node = current->parent;
> > -               depth = 0;
> > -               while (node && node->flavor != CIL_ROOT) {
> > -                       if (node->flavor == CIL_BLOCK) {
> > -                               block = node->data;
> > -                               if (block->bi_nodes != NULL) {
> > -                                       depth++;
> > -                               }
> > +       node = node->parent;
> > +       while (node && node->flavor != CIL_ROOT) {
> > +               if (node->flavor == CIL_BLOCK) {
> > +                       if (((struct cil_block *)(node->data))->bi_nodes != NULL) {
> > +                               depth++;
> >                         }
> > -                       node = node->parent;
> >                 }
> > +               node = node->parent;
> > +       }
> >
> > -               if (depth >= CIL_DEGENERATE_INHERITANCE_DEPTH) {
> > -                       cil_tree_log(current, CIL_ERR, "Degenerate inheritance detected (depth=%u, breadth=%u)", depth, breadth);
> > -                       return SEPOL_ERR;
> > -               }
> > +       if (depth >= CIL_DEGENERATE_INHERITANCE_DEPTH) {
> > +               return CIL_TRUE;
> > +       }
>
> When I first read the code, I wondered whether this "if" condition
> would better be in the while loop, in order to break early when depth
> exceeds the threshold. Then I thought that the code was actually
> right, because the condition is expected to be unlikely. Maybe you
> could add a comment /* This condition is unlikely to happen so put it
> after the loop */ right before if (depth >=
> CIL_DEGENERATE_INHERITANCE_DEPTH)?
>

It is unlikely to trigger, but it seems like it will be clearer to
just put it in the loop. I expect the depth to be 0 most of the time,
so this is not performance critical.

> By the way in the patch I saw how "inheritance_check" is set, but I
> did not find where it is actually checked. Could you point me to the
> functions/lines which actually use its value?
>

I removed the check at one point when I was testing and I didn't put it back in.
The line "if (pass == CIL_PASS_BLKIN_LINK) {" should be "if (pass ==
CIL_PASS_BLKIN_LINK && inheritance_check == CIL_TRUE) {"

I will send out another version.

Thanks,
Jim


> Cheers,
> Nicolas
>
