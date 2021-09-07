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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9BBC433F5
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 13:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EDF60EE6
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 13:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344772AbhIGNmG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbhIGNmF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 09:42:05 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE393C061575
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 06:40:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r26so12838106oij.2
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzlF7vm/A7zmTrm69wXGmNXJDB+SiJAGuF5ZUePSn4M=;
        b=f7eya/9jhGnPhFgc/oWe6n8q6+frbYuNV9CJmktD2QC+19LOvC4J+Khzguz3uKAWjh
         0LMdvz1LJXTHRIBrP04JC4FLCoRQk7XEbEldbZOl9OQYLwGuRSEBTcix1CbCX/EujoDz
         BspaoY3KGHtdrfjzhMG21ybuhEBPya8CxrFV9rgvZCTcojMe1sv0DK9t0YUU5SdTliuQ
         mChN4XYHRLUnDu2jXEm1JASogbBZKnT6GWIhhYFnCFiI+ORrRXkRkD1qFT11NSb0hwpk
         gvex+YOFDM/ok8scLoPscRwS3hz6RHyrpLvG0NXvABmKDcG7UuoBNxblAnv/DmyJwZXX
         juVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzlF7vm/A7zmTrm69wXGmNXJDB+SiJAGuF5ZUePSn4M=;
        b=mUmOL3KaBKXMcbB6J/s4SD4fyTDfbdSEdxbTr30kqxBprMBXn/AomYpvIPXxzvpl3Y
         JLatkX3LiZdZpUiPlXdk8QVxjqcBefhPNPmWg6pIsJk47A/bVo2dDoLxNi7BGyL1aVW5
         I6K21YxyaSheab65MU8Ayq7IAOzlXQf5Jn5IIH2efDdEalTlzDYn2nmBliqItEpT6GII
         cQ9eUodifRE7f6T/N3MnDGZoLjqikParNDOdTaTLgPHdEljXFvRAMDeD3NqoMGyePpi4
         W+mseLfsQ7zfr3SkcQ9AvcJndSuSsrloHHmseM9vYuHBJlXdnQPajtjG1LXFQy7DTaVl
         pMoA==
X-Gm-Message-State: AOAM53365RSCMgkv/b8PwQiAySona2MshwCp/q4BUs0urOyiziYp/Wg8
        txkYr7wtMxhKk/2k9wWgTGXY4y/MsY1vRtKmpk7fHk/q
X-Google-Smtp-Source: ABdhPJwN/ZvhMxAiD4hgmbNP1qs4M561Z2GCu8pr6dDiRP7/oe+lZ+5nn9t3XcCUGcEb0Z5ty64k3XkpaAR1taxLp6o=
X-Received: by 2002:aca:1b19:: with SMTP id b25mr2996483oib.138.1631022059043;
 Tue, 07 Sep 2021 06:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830182442.491886-1-jwcart2@gmail.com> <CAJfZ7==eOkW7ckauF2fYLpX=Gt6e0N750CbnH6rWdbNbTQbvGg@mail.gmail.com>
 <CAP+JOzQHmeT7CbkvxUeO2Ee9AaUNryHdOMdf7ayMuOoLJQVZuw@mail.gmail.com> <CAJfZ7=nvnCR3WNSKNi5FR1UJC_P33vUo08N7119LHrSJdOu6LA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nvnCR3WNSKNi5FR1UJC_P33vUo08N7119LHrSJdOu6LA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 7 Sep 2021 09:40:48 -0400
Message-ID: <CAP+JOzS8HJo8=SapsW5kmEMya=ATmaXXV5xr-4rvEY7zyj4y+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Don't destroy optionals whose parent
 will be destroyed
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 6, 2021 at 2:33 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Sep 2, 2021 at 6:33 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 3:26 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > >
> > >  On Mon, Aug 30, 2021 at 8:24 PM James Carter <jwcart2@gmail.com> wrote:
> > > >
> > > > If an optional that is to be disabled is the child of an optional that
> > > > is going to be disabled, then there is no reason to add that optional
> > > > to the stack of disabled optionals, because it is going to be destroyed
> > > > anyways. This means that there is no reason to maintain a stack of
> > > > disabled optionals at all.
> > > >
> > > > Instead of using a stack to track disabled optionals, use a pointer
> > > > that points to the top-most optional that is to be disabled. When a
> > > > rule fails to resolve in an optional, if the disabled optional pointer
> > > > has not been set, then set it to that optional. If the pointer has
> > > > been set already, then the optional is already going to be destroyed,
> > > > so nothing else needs to be done. The resolution failure and the fact
> > > > that the optional is being disabled is reported in either case.
> > > >
> > > > Signed-off-by: James Carter <jwcart2@gmail.com>
> > >
> > > For the 3 patches:
> > >
> > > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > >
> >
> > This series has been merged.
> >
> > > (I liked these simplifications, and if someone encounters a stack
> > > exhaustion issue because of changing cil_tree_children_destroy to a
> > > recursive function, I guess a reasonable recursion limit could be
> > > added where it would make sense)
> > >
> > Yes, my thought was that since cil_tree_walk() & cil_tree_walk_core()
> > have similar
> > limits, that it wouldn't be a problem. And, if it was, we could add a
> > recursion limit as you suggest.
> >
> > Thanks,
> > Jim
>
> Hi,
> I did not take long for OSS-Fuzz to find a crash due to the
> cil_tree_children_destroy change:
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=38110 (this link
> will be publicly open on 2021-12-03 at the latest).
>
> Here is a simple reproducer, in shell:
>
>    (echo '(' ; for i in $(seq 300000) ; do echo ';;*lmx 3 r' ; done) >
> test.cil && secilc test.cil
>
> On my system (x86_64 Arch Linux), this triggers a segmentation fault,
> probably due to stack exhaustion, with maaaaany recursive calls to
> cil_tree_children_destroy. Using the fuzzer, the limit is smaller
> (with "seq 50000" I manage to trigger a segfault). So I guess the
> number of successive line markers should be limited too.
>

I saw the OSS-Fuzz message, but it didn't cause a crash on my Fedora system.

There is already a limit of 4,096 open parenthesis, but the line mark
stuff does not get included in that count. I think that it would make
sense for it to get included.

Jim


> Thanks,
> Nicolas
>
> > > Thanks,
> > > Nicolas
> > >
> > > > ---
> > > >  libsepol/cil/src/cil_resolve_ast.c | 17 +++++++----------
> > > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > > > index 18007324..aeedc7dd 100644
> > > > --- a/libsepol/cil/src/cil_resolve_ast.c
> > > > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > > > @@ -56,6 +56,7 @@ struct cil_args_resolve {
> > > >         struct cil_tree_node *block;
> > > >         struct cil_tree_node *macro;
> > > >         struct cil_tree_node *optional;
> > > > +       struct cil_tree_node *disabled_optional;
> > > >         struct cil_tree_node *boolif;
> > > >         struct cil_list *sidorder_lists;
> > > >         struct cil_list *classorder_lists;
> > > > @@ -63,7 +64,6 @@ struct cil_args_resolve {
> > > >         struct cil_list *catorder_lists;
> > > >         struct cil_list *sensitivityorder_lists;
> > > >         struct cil_list *in_list;
> > > > -       struct cil_stack *disabled_optionals;
> > > >  };
> > > >
> > > >  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> > > > @@ -3873,7 +3873,6 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > > >         struct cil_tree_node *macro = args->macro;
> > > >         struct cil_tree_node *optional = args->optional;
> > > >         struct cil_tree_node *boolif = args->boolif;
> > > > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > > >
> > > >         if (node == NULL) {
> > > >                 goto exit;
> > > > @@ -3956,7 +3955,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > > >                 if (optional == NULL) {
> > > >                         cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
> > > >                 } else {
> > > > -                       cil_stack_push(disabled_optionals, CIL_NODE, optional);
> > > > +                       if (!args->disabled_optional) {
> > > > +                               args->disabled_optional = optional;
> > > > +                       }
> > > >                         cil_tree_log(node, CIL_INFO, "Failed to resolve %s statement", cil_node_to_string(node));
> > > >                         cil_tree_log(optional, CIL_INFO, "Disabling optional '%s'", DATUM(optional->data)->name);
> > > >                         rc = SEPOL_OK;
> > > > @@ -4003,7 +4004,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > > >  {
> > > >         int rc = SEPOL_ERR;
> > > >         struct cil_args_resolve *args = extra_args;
> > > > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > > >         struct cil_tree_node *parent = NULL;
> > > >
> > > >         if (current == NULL ||  extra_args == NULL) {
> > > > @@ -4026,11 +4026,10 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > > >                 args->macro = NULL;
> > > >         } else if (parent->flavor == CIL_OPTIONAL) {
> > > >                 struct cil_tree_node *n = parent->parent;
> > > > -               struct cil_stack_item *item = cil_stack_peek(disabled_optionals);
> > > > -               if (item && item->data == parent) {
> > > > -                       cil_stack_pop(disabled_optionals);
> > > > +               if (args->disabled_optional == parent) {
> > > >                         *(args->changed) = CIL_TRUE;
> > > >                         cil_list_append(args->to_destroy, CIL_NODE, parent);
> > > > +                       args->disabled_optional = NULL;
> > > >                 }
> > > >                 args->optional = NULL;
> > > >                 while (n && n->flavor != CIL_ROOT) {
> > > > @@ -4067,6 +4066,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > > >         extra_args.block = NULL;
> > > >         extra_args.macro = NULL;
> > > >         extra_args.optional = NULL;
> > > > +       extra_args.disabled_optional = NULL;
> > > >         extra_args.boolif= NULL;
> > > >         extra_args.sidorder_lists = NULL;
> > > >         extra_args.classorder_lists = NULL;
> > > > @@ -4074,7 +4074,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > > >         extra_args.catorder_lists = NULL;
> > > >         extra_args.sensitivityorder_lists = NULL;
> > > >         extra_args.in_list = NULL;
> > > > -       extra_args.disabled_optionals = NULL;
> > > >
> > > >         cil_list_init(&extra_args.to_destroy, CIL_NODE);
> > > >         cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
> > > > @@ -4083,7 +4082,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > > >         cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
> > > >         cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
> > > >         cil_list_init(&extra_args.in_list, CIL_IN);
> > > > -       cil_stack_init(&extra_args.disabled_optionals);
> > > >
> > > >         for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
> > > >                 extra_args.pass = pass;
> > > > @@ -4218,7 +4216,6 @@ exit:
> > > >         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> > > >         cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> > > >         cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > > > -       cil_stack_destroy(&extra_args.disabled_optionals);
> > > >
> > > >         return rc;
> > > >  }
> > > > --
> > > > 2.31.1
> > > >
> > >
>
