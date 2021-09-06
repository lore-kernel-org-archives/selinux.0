Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59899C433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 18:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388A860F43
	for <selinux@archiver.kernel.org>; Mon,  6 Sep 2021 18:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243850AbhIFSeI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 14:34:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39648 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhIFSeH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Sep 2021 14:34:07 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3D66A5648A6
        for <selinux@vger.kernel.org>; Mon,  6 Sep 2021 20:33:01 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id e7so4340981plh.8
        for <selinux@vger.kernel.org>; Mon, 06 Sep 2021 11:33:01 -0700 (PDT)
X-Gm-Message-State: AOAM532yyQGviohQTqwOL7FiFLzr8N4intH2Smjgp77VoOklv6FkbAgT
        6KSD9OYlmTTdkCXXwOp0H22332oxQrpalr4s2Rs=
X-Google-Smtp-Source: ABdhPJy2+i2e4IP7RJenpx/z/aihS0HN3CH3kCLj+nZaUB7xX967XTGXjp57zv7HBqixYa35QVTpXUcq/qdQeRQmcGw=
X-Received: by 2002:a17:90a:6507:: with SMTP id i7mr394556pjj.205.1630953179753;
 Mon, 06 Sep 2021 11:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210830182442.491886-1-jwcart2@gmail.com> <CAJfZ7==eOkW7ckauF2fYLpX=Gt6e0N750CbnH6rWdbNbTQbvGg@mail.gmail.com>
 <CAP+JOzQHmeT7CbkvxUeO2Ee9AaUNryHdOMdf7ayMuOoLJQVZuw@mail.gmail.com>
In-Reply-To: <CAP+JOzQHmeT7CbkvxUeO2Ee9AaUNryHdOMdf7ayMuOoLJQVZuw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 6 Sep 2021 20:32:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nvnCR3WNSKNi5FR1UJC_P33vUo08N7119LHrSJdOu6LA@mail.gmail.com>
Message-ID: <CAJfZ7=nvnCR3WNSKNi5FR1UJC_P33vUo08N7119LHrSJdOu6LA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Don't destroy optionals whose parent
 will be destroyed
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Sep  6 20:33:01 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 2, 2021 at 6:33 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Sep 1, 2021 at 3:26 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> >  On Mon, Aug 30, 2021 at 8:24 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > If an optional that is to be disabled is the child of an optional that
> > > is going to be disabled, then there is no reason to add that optional
> > > to the stack of disabled optionals, because it is going to be destroyed
> > > anyways. This means that there is no reason to maintain a stack of
> > > disabled optionals at all.
> > >
> > > Instead of using a stack to track disabled optionals, use a pointer
> > > that points to the top-most optional that is to be disabled. When a
> > > rule fails to resolve in an optional, if the disabled optional pointer
> > > has not been set, then set it to that optional. If the pointer has
> > > been set already, then the optional is already going to be destroyed,
> > > so nothing else needs to be done. The resolution failure and the fact
> > > that the optional is being disabled is reported in either case.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > For the 3 patches:
> >
> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
>
> This series has been merged.
>
> > (I liked these simplifications, and if someone encounters a stack
> > exhaustion issue because of changing cil_tree_children_destroy to a
> > recursive function, I guess a reasonable recursion limit could be
> > added where it would make sense)
> >
> Yes, my thought was that since cil_tree_walk() & cil_tree_walk_core()
> have similar
> limits, that it wouldn't be a problem. And, if it was, we could add a
> recursion limit as you suggest.
>
> Thanks,
> Jim

Hi,
I did not take long for OSS-Fuzz to find a crash due to the
cil_tree_children_destroy change:
https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=38110 (this link
will be publicly open on 2021-12-03 at the latest).

Here is a simple reproducer, in shell:

   (echo '(' ; for i in $(seq 300000) ; do echo ';;*lmx 3 r' ; done) >
test.cil && secilc test.cil

On my system (x86_64 Arch Linux), this triggers a segmentation fault,
probably due to stack exhaustion, with maaaaany recursive calls to
cil_tree_children_destroy. Using the fuzzer, the limit is smaller
(with "seq 50000" I manage to trigger a segfault). So I guess the
number of successive line markers should be limited too.

Thanks,
Nicolas

> > Thanks,
> > Nicolas
> >
> > > ---
> > >  libsepol/cil/src/cil_resolve_ast.c | 17 +++++++----------
> > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > > index 18007324..aeedc7dd 100644
> > > --- a/libsepol/cil/src/cil_resolve_ast.c
> > > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > > @@ -56,6 +56,7 @@ struct cil_args_resolve {
> > >         struct cil_tree_node *block;
> > >         struct cil_tree_node *macro;
> > >         struct cil_tree_node *optional;
> > > +       struct cil_tree_node *disabled_optional;
> > >         struct cil_tree_node *boolif;
> > >         struct cil_list *sidorder_lists;
> > >         struct cil_list *classorder_lists;
> > > @@ -63,7 +64,6 @@ struct cil_args_resolve {
> > >         struct cil_list *catorder_lists;
> > >         struct cil_list *sensitivityorder_lists;
> > >         struct cil_list *in_list;
> > > -       struct cil_stack *disabled_optionals;
> > >  };
> > >
> > >  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> > > @@ -3873,7 +3873,6 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > >         struct cil_tree_node *macro = args->macro;
> > >         struct cil_tree_node *optional = args->optional;
> > >         struct cil_tree_node *boolif = args->boolif;
> > > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > >
> > >         if (node == NULL) {
> > >                 goto exit;
> > > @@ -3956,7 +3955,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > >                 if (optional == NULL) {
> > >                         cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
> > >                 } else {
> > > -                       cil_stack_push(disabled_optionals, CIL_NODE, optional);
> > > +                       if (!args->disabled_optional) {
> > > +                               args->disabled_optional = optional;
> > > +                       }
> > >                         cil_tree_log(node, CIL_INFO, "Failed to resolve %s statement", cil_node_to_string(node));
> > >                         cil_tree_log(optional, CIL_INFO, "Disabling optional '%s'", DATUM(optional->data)->name);
> > >                         rc = SEPOL_OK;
> > > @@ -4003,7 +4004,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > >  {
> > >         int rc = SEPOL_ERR;
> > >         struct cil_args_resolve *args = extra_args;
> > > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > >         struct cil_tree_node *parent = NULL;
> > >
> > >         if (current == NULL ||  extra_args == NULL) {
> > > @@ -4026,11 +4026,10 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > >                 args->macro = NULL;
> > >         } else if (parent->flavor == CIL_OPTIONAL) {
> > >                 struct cil_tree_node *n = parent->parent;
> > > -               struct cil_stack_item *item = cil_stack_peek(disabled_optionals);
> > > -               if (item && item->data == parent) {
> > > -                       cil_stack_pop(disabled_optionals);
> > > +               if (args->disabled_optional == parent) {
> > >                         *(args->changed) = CIL_TRUE;
> > >                         cil_list_append(args->to_destroy, CIL_NODE, parent);
> > > +                       args->disabled_optional = NULL;
> > >                 }
> > >                 args->optional = NULL;
> > >                 while (n && n->flavor != CIL_ROOT) {
> > > @@ -4067,6 +4066,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > >         extra_args.block = NULL;
> > >         extra_args.macro = NULL;
> > >         extra_args.optional = NULL;
> > > +       extra_args.disabled_optional = NULL;
> > >         extra_args.boolif= NULL;
> > >         extra_args.sidorder_lists = NULL;
> > >         extra_args.classorder_lists = NULL;
> > > @@ -4074,7 +4074,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > >         extra_args.catorder_lists = NULL;
> > >         extra_args.sensitivityorder_lists = NULL;
> > >         extra_args.in_list = NULL;
> > > -       extra_args.disabled_optionals = NULL;
> > >
> > >         cil_list_init(&extra_args.to_destroy, CIL_NODE);
> > >         cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
> > > @@ -4083,7 +4082,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > >         cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.in_list, CIL_IN);
> > > -       cil_stack_init(&extra_args.disabled_optionals);
> > >
> > >         for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
> > >                 extra_args.pass = pass;
> > > @@ -4218,7 +4216,6 @@ exit:
> > >         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> > >         cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> > >         cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > > -       cil_stack_destroy(&extra_args.disabled_optionals);
> > >
> > >         return rc;
> > >  }
> > > --
> > > 2.31.1
> > >
> >

