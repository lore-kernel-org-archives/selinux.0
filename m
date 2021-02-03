Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1222AC433E0
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC95264F5F
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 08:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhBCIYP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 03:24:15 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:53149 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhBCIYN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 03:24:13 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 1F080564DE7
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 09:23:29 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id t25so12483336otc.5
        for <selinux@vger.kernel.org>; Wed, 03 Feb 2021 00:23:29 -0800 (PST)
X-Gm-Message-State: AOAM531n+Y7O2yZ72W1o6o2LXOB/+FIuiT0HUymzwlM8ACjca9Il3rAI
        +j37mXzuMbMeBEqX9a1MP+GmRqDtjZARR0IcgNw=
X-Google-Smtp-Source: ABdhPJxO2TYUYhaxKJwvMLeAxls0HvXFPgh0cMaeXF0Vw4Swj1vQuBU/IjlrWTI7Ien/BCHVJm5179eTIk7x27OS170=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr1259977otr.96.1612340607944;
 Wed, 03 Feb 2021 00:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20210201142426.134081-1-jwcart2@gmail.com> <CAJfZ7=mZWzLbs5+Ba5bcGaAvOBSYzB5af6hDcGHjJ-i0fXmAVg@mail.gmail.com>
 <CAP+JOzQpSRqPotgzQOD9yEf7uXxOEVQS5K0DZ9bELCkskj2d8Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQpSRqPotgzQOD9yEf7uXxOEVQS5K0DZ9bELCkskj2d8Q@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 3 Feb 2021 09:23:17 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=ksQnz4h7O-pX7RfQ2Gp4i5WXvZFN8N2fGuE_DWQhg7WA@mail.gmail.com>
Message-ID: <CAJfZ7=ksQnz4h7O-pX7RfQ2Gp4i5WXvZFN8N2fGuE_DWQhg7WA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Fix heap-use-after-free when using optional blockinherit
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  3 09:23:29 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 2, 2021 at 10:15 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Feb 1, 2021 at 5:08 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Mon, Feb 1, 2021 at 3:24 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > This is based on a patch by Nicolas Iooss. He writes:
> > >     When secilc compiles the following policy:
> > >
> > >         (block b1
> > >             (optional o1
> > >                 (blockinherit b1)
> > >                 (blockinherit x)
> > >             )
> > >         )
> > >
> > >     it disables the optional block at pass 3 (CIL_PASS_BLKIN_LINK)
> > >     because the block "x" does not exist.
> > >     __cil_resolve_ast_last_child_helper() calls
> > >     cil_tree_children_destroy() on the optional block, which destroys
> > >     the two blockinherit statements. But the (blockinherit b1) node
> > >     was referenced inside (block b1) node, in its block->bi_nodes list.
> > >     Therefore, when this list is used at pass 4 (CIL_PASS_BLKIN_COPY),
> > >     it contains a node which was freed: this triggers a use-after-free
> > >     issue
> > >
> > >     Fix this issue by removing blockinherit nodes from their lists of
> > >     nodes block->bi_nodes when they are being destroyed. As
> > >     cil_destroy_blockinherit() does not have a reference to the node
> > >     containing the blockinherit data, implement this new logic in
> > >     cil_tree_node_destroy().
> > >
> > >     This issue was found while investigating a testcase from an OSS-Fuzz
> > >     issue which seems unrelated (a Null-dereference READ in
> > >     cil_symtab_get_datum,
> > >     https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=29861).
> > >
> > > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > > ---
> > >  libsepol/cil/src/cil_build_ast.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > > index 02481558..3d8367fe 100644
> > > --- a/libsepol/cil/src/cil_build_ast.c
> > > +++ b/libsepol/cil/src/cil_build_ast.c
> > > @@ -283,6 +283,23 @@ void cil_destroy_blockinherit(struct cil_blockinherit *inherit)
> > >                 return;
> > >         }
> > >
> > > +       if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> > > +               struct cil_tree_node *node;
> > > +               struct cil_list_item *item;
> > > +               int found = CIL_FALSE;
> > > +
> > > +               cil_list_for_each(item, inherit->block->bi_nodes) {
> > > +                       node = item->data;
> > > +                       if (node->data == inherit) {
> > > +                               found = CIL_TRUE;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +               if (found == CIL_TRUE) {
> > > +                       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
> > > +               }
> > > +       }
> > > +
> > >         free(inherit);
> > >  }
> >
> > Hello,
> > The code seems to be too complex for two reasons.
> >
> > First, doing "if (node->data == inherit) found = CIL_TRUE;" then "if
> > (found == CIL_TRUE){...}" seems too verbose. The code could be
> > simplified to something such as:
> >
> > if (inherit->block != NULL && inherit->block->bi_nodes != NULL) {
> >   struct cil_list_item *item;
> >
> >   /* Find the in bi_nodes the item which contains the inherit object */
> >   cil_list_for_each(item, inherit->block->bi_nodes) {
> >     struct cil_tree_node *node = item->data;
> >     if (node->data == inherit) {
> >       cil_list_remove(inherit->block->bi_nodes, CIL_NODE, node, CIL_FALSE);
> >       break;
> >     }
> >   }
> > }
> >
>
> I sent a revised patch.
>
> > Second, doing so makes the code browse the inherit->block->bi_nodes
> > list twice (in cil_list_for_each and cil_list_remove). This seems to
> > be easily optimisable by unlinking item when if (node->data ==
> > inherit), but unfortunately there is no helper function for this
> > (because cil_list_item_destroy() does not unlink the item). What do
> > you think of adding a new helper function
> > cil_list_item_unlink_and_destroy(list, item, destroy_data) which would
> > provide a feature between cil_list_remove() and
> > cil_list_item_destroy()?
> >
> I don't know how you can get around walking the list twice. The first
> time through you need to find the node that is going to be removed by
> matching the node's data and the second time through the node is
> removed by matching the list item's data. Not all lists are lists of
> nodes, so the list functions can't search the data of something in the
> list. There are probably a lot of lists of nodes, so perhaps there
> could be a special function that searches the data of a list of nodes
> for a match, but I am not too worried about efficiency here.

I was thinking of something such as (in cil_destroy_blockinherit):

struct cil_list_item *previous = NULL;
cil_list_for_each(item, inherit->block->bi_nodes) {
  node = item->data;
  if (node->data == inherit) {
    if (previous == NULL) {
       inherit->block->bi_nodes->head = item->next;
    } else {
      previous->next = item->next;
    }
    if (item->next == NULL) {
      inherit->block->bi_nodes->tail = previous;
    }
    cil_list_item_destroy(&item, CIL_FALSE);
    break;
  }
  previous = item;
}

This code walks inherit->block->bi_nodes only once, but it would be
less maintainable because it relies on cil_list's implementation
details. So I was thinking of introducing a new helper function which
would implement the logic around "unlinking" in cil_list by using the
found "item".

> I don't understand what you are proposing with
> cil_list_item_unlink_and_destroy().

Nevermind. Thinking more about this, this could make the code more
complex. I will test and review your v2 patch. Thanks!

Nicolas

