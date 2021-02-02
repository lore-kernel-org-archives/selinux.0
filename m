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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD749C433E0
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 21:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872D064F64
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 21:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhBBVPo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBBVPn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 16:15:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA97C061573
        for <selinux@vger.kernel.org>; Tue,  2 Feb 2021 13:15:03 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id g69so24337152oib.12
        for <selinux@vger.kernel.org>; Tue, 02 Feb 2021 13:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/yRKIgIvjZRX9WvksVHGWUU0bKJ0lLh0+Vf5ccgAnA=;
        b=fbzDSaN+VAwO1PNEjvdrvRpaIAoc0Sm0HqP2CVIgku7e9V9Swl6XZAwPZrjL98S+d5
         jDy6vt0X/SJmbBeEpRlEQUf+GqOdpdySw8XknwBl1bZSIjPNjAuRQd/au0VO+C8QjDtc
         jM7wHk7aIKAqxbY1jdIAblRyksMF9AGJtgTWvA74QNwKXYKOfRfQsbJJkQ/OoS3mM59c
         Kp933Mms894H2Yl/wyJMFrizwb02fJX4004SRSNzX44gvifklbLSQ4qdexf+bsVwk44b
         mhOU1zL52A9JqhAPjIAIrCqNljxeXNgSqMztuY5t0tHYvk6D+o5z6MNPt2AoOF4TUjJ1
         tahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/yRKIgIvjZRX9WvksVHGWUU0bKJ0lLh0+Vf5ccgAnA=;
        b=L4fDI15pQpvRRtb7vnU4bbhvhUklho/ccYomj2lEbLppfYz+ffeHx2r59SZPKZKLtr
         p6wJVVdS9KSnWXIdPCspTWWfVmGAudq00hv824YgAGSLsIyU/Xw4C3NbZE/4oFL/n80a
         h513UnFpA7Bzk9/wHYiXqbyEls8vv67v8mOfKQf7u6ICYLJGPXSb6VXTmhNU7wr03yP9
         sdAq6hU1ViJt8XDQqb55X849w71yyj7EEYc6Ycp9kkQZlbtX2StnB2XDVNeUeWTEVXPK
         fGkSkZmh15L8Q0cvNRFRR669ewX7oVQdTT8SuX40bMy8VweCTWeOoAk1RbbuD0kROuFl
         gDXQ==
X-Gm-Message-State: AOAM532tJDDMKV3xqeLLw8OgmBNONo4imW9RMLDmzm9ImGpW8QrphBgJ
        pIXrXU6ft1VEyTSCEDurVHA5tK51/97Ukwuy1Mk=
X-Google-Smtp-Source: ABdhPJwE8WmrNjUUZdpah0ZemikUxA5TLrqXTRrwgYZfvvPJbzpRHICPTN54ia3rublLXRfwpUMzFsSrB+nENEkrdzM=
X-Received: by 2002:a05:6808:115:: with SMTP id b21mr4078422oie.16.1612300502846;
 Tue, 02 Feb 2021 13:15:02 -0800 (PST)
MIME-Version: 1.0
References: <20210201142426.134081-1-jwcart2@gmail.com> <CAJfZ7=mZWzLbs5+Ba5bcGaAvOBSYzB5af6hDcGHjJ-i0fXmAVg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mZWzLbs5+Ba5bcGaAvOBSYzB5af6hDcGHjJ-i0fXmAVg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 2 Feb 2021 16:14:52 -0500
Message-ID: <CAP+JOzQpSRqPotgzQOD9yEf7uXxOEVQS5K0DZ9bELCkskj2d8Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix heap-use-after-free when using optional blockinherit
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 1, 2021 at 5:08 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Feb 1, 2021 at 3:24 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > This is based on a patch by Nicolas Iooss. He writes:
> >     When secilc compiles the following policy:
> >
> >         (block b1
> >             (optional o1
> >                 (blockinherit b1)
> >                 (blockinherit x)
> >             )
> >         )
> >
> >     it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK)
> >     because the block "x" does not exist.
> >     __cil_resolve_ast_last_child_helper() calls
> >     cil_tree_children_destroy() on the optional block, which destroys
> >     the two blockinherit statements. But the (blockinherit b1) node
> >     was referenced inside (block b1) node, in its block->bi_nodes list.
> >     Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY),
> >     it contains a node which was freed: this triggers a use-after-free
> >     issue
> >
> >     Fix this issue by removing blockinherit nodes from their lists of
> >     nodes block->bi_nodes when they are being destroyed. As
> >     cil_destroy_blockinherit() does not have a reference to the node
> >     containing the blockinherit data, implement this new logic in
> >     cil_tree_node_destroy().
> >
> >     This issue was found while investigating a testcase from an OSS-Fuzz
> >     issue which seems unrelated (a Null-dereference READ in
> >     cil_symtab_get_datum,
> >     https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).
> >
> > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 02481558..3d8367fe 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -283,6 +283,23 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
> >                 return;
> >         }
> >
> > +       if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> > +               struct cil_tree_node *node;
> > +               struct cil_list_item *item;
> > +               int found = CIL_FALSE;
> > +
> > +               cil_list_for_each(item, inherit->block->bi_nodes) {
> > +                       node = item->data;
> > +                       if (node->data == inherit) {
> > +                               found = CIL_TRUE;
> > +                               break;
> > +                       }
> > +               }
> > +               if (found == CIL_TRUE) {
> > +                       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
> > +               }
> > +       }
> > +
> >         free(inherit);
> >  }
>
> Hello,
> The code seems to be too complex for two reasons.
>
> First, doing "if (node->data == inherit) found = CIL_TRUE;" then "if
> (found == CIL_TRUE){...}" seems too verbose. The code could be
> simplified to something such as:
>
> if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
>   struct cil_list_item *item;
>
>   /* Find the in bi_nodes the item which contains the inherit object */
>   cil_list_for_each(item, inherit->block->bi_nodes) {
>     struct cil_tree_node *node = item->data;
>     if (node->data == inherit) {
>       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
>       break;
>     }
>   }
> }
>

I sent a revised patch.

> Second, doing so makes the code browse the inherit->block->bi_nodes
> list twice (in cil_list_for_each and cil_list_remove). This seems to
> be easily optimisable by unlinking item when if (node->data ==
> inherit), but unfortunately there is no helper function for this
> (because cil_list_item_destroy() does not unlink the item). What do
> you think of adding a new helper function
> cil_list_item_unlink_and_destroy(list, item, destroy_data) which would
> provide a feature between cil_list_remove() and
> cil_list_item_destroy()?
>
I don't know how you can get around walking the list twice. The first
time through you need to find the node that is going to be removed by
matching the node's data and the second time through the node is
removed by matching the list item's data. Not all lists are lists of
nodes, so the list functions can't search the data of something in the
list. There are probably a lot of lists of nodes, so perhaps there
could be a special function that searches the data of a list of nodes
for a match, but I am not too worried about efficiency here.

I don't understand what you are proposing with
cil_list_item_unlink_and_destroy().

Thanks for the comments,
Jim


> By the way, while testing more the patch I sent, I found out that this
> introduces a use-after-free issue if inherit->block was freed. I
> encountered this issue with a simple CIL policy: "(block
> b2a)(blockinherit b2a)". I will send a patch for this, which performs
> the opposite operation in cil_destroy_block().
>
> Thanks,
> Nicolas
>
