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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22789C83027
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F17600CC
	for <selinux@archiver.kernel.org>; Thu,  2 Sep 2021 16:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhIBQev (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbhIBQev (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Sep 2021 12:34:51 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A2CC061575
        for <selinux@vger.kernel.org>; Thu,  2 Sep 2021 09:33:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h133so3272970oib.7
        for <selinux@vger.kernel.org>; Thu, 02 Sep 2021 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5iRwJJgryotcfb66t1x+mQaRP8BafsS7dy8OCkBaXQ0=;
        b=M1zThEQfsDdVVFNnwangaMwKrS09B2tqFiqELdaoAim4pa322ktzIaMf6QWtXVLv0j
         LOs749mkX3MNdGz7JsQAt4nrRlC+6v3DRFTLH/TmmaWPNrNG8s5jpgFnHZQcl9Rj+sOJ
         heLaMC8WE6tZHnYE3UjOjCpJ498hIYvGz07iwIRCUrBvR1EJGU+RwD7czk2QM+X8WSBV
         MN1Plvuv8/UHXa+LE3im4ivWw5YWtXPMM+/CwYJqdWpAqs5uwTDztztDqIqthhg2Fsqa
         iHsIiiX+oJ0LdR1OX9FBqlbxMMrMxi8HaRLmaCrTr9/e3+A9Y4E6AcrfxJ9EIRhIML1I
         Cw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5iRwJJgryotcfb66t1x+mQaRP8BafsS7dy8OCkBaXQ0=;
        b=l16qShNgiCdjTgajhDtzBZ0VoZ4iDTxFe+zdve5pNaXBLTSUTsEg6uRnOEm09UPPzr
         +Hg3UHYF95FCItC76LQr8BRx+gXIa2seWHXzCTiPPF1BukibDOPaKBXs5SYFC1q+SwgG
         OnQlZPbwjVr8ajHJEYhaNh7jzCJ+kxasBD/CK+AAnKS3AH9MAwKRaT3ZA30Qy20qY4nT
         QZruFXxdD7zobZAvU36cEuf+euO00ioRavB/wB9eqv5U0QCLg7dBkkGU+VwmcahUkxAA
         m6l55QKP9/Xlve5JnbRCtFclfKPQ2/HipVtlcrDM4QQGyXDZwztLch2kZgFLvI5fL4ot
         kilA==
X-Gm-Message-State: AOAM532+Hv+BsIpOPhd+ds+E6hFbvGtpLUioxj0RdO8p3S+39opJhczW
        Cv6K1ovLru6ngdHWuUgs0iLWa8LQkHFbL2mtVLZJjlrL
X-Google-Smtp-Source: ABdhPJxmN8K4enlEhAxG+fHxp5CB7zLOdLNJld13N0fXavtP1H+P2r5gLlIKW+Ykv5bPJ5hFUc09VyKfkTp9yZymO+U=
X-Received: by 2002:aca:f189:: with SMTP id p131mr2927907oih.128.1630600432141;
 Thu, 02 Sep 2021 09:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210830182442.491886-1-jwcart2@gmail.com> <CAJfZ7==eOkW7ckauF2fYLpX=Gt6e0N750CbnH6rWdbNbTQbvGg@mail.gmail.com>
In-Reply-To: <CAJfZ7==eOkW7ckauF2fYLpX=Gt6e0N750CbnH6rWdbNbTQbvGg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Sep 2021 12:33:41 -0400
Message-ID: <CAP+JOzQHmeT7CbkvxUeO2Ee9AaUNryHdOMdf7ayMuOoLJQVZuw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Don't destroy optionals whose parent
 will be destroyed
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 1, 2021 at 3:26 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
>  On Mon, Aug 30, 2021 at 8:24 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > If an optional that is to be disabled is the child of an optional that
> > is going to be disabled, then there is no reason to add that optional
> > to the stack of disabled optionals, because it is going to be destroyed
> > anyways. This means that there is no reason to maintain a stack of
> > disabled optionals at all.
> >
> > Instead of using a stack to track disabled optionals, use a pointer
> > that points to the top-most optional that is to be disabled. When a
> > rule fails to resolve in an optional, if the disabled optional pointer
> > has not been set, then set it to that optional. If the pointer has
> > been set already, then the optional is already going to be destroyed,
> > so nothing else needs to be done. The resolution failure and the fact
> > that the optional is being disabled is reported in either case.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For the 3 patches:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

This series has been merged.

> (I liked these simplifications, and if someone encounters a stack
> exhaustion issue because of changing cil_tree_children_destroy to a
> recursive function, I guess a reasonable recursion limit could be
> added where it would make sense)
>
Yes, my thought was that since cil_tree_walk() & cil_tree_walk_core()
have similar
limits, that it wouldn't be a problem. And, if it was, we could add a
recursion limit as you suggest.

Thanks,
Jim

> Thanks,
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_resolve_ast.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 18007324..aeedc7dd 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -56,6 +56,7 @@ struct cil_args_resolve {
> >         struct cil_tree_node *block;
> >         struct cil_tree_node *macro;
> >         struct cil_tree_node *optional;
> > +       struct cil_tree_node *disabled_optional;
> >         struct cil_tree_node *boolif;
> >         struct cil_list *sidorder_lists;
> >         struct cil_list *classorder_lists;
> > @@ -63,7 +64,6 @@ struct cil_args_resolve {
> >         struct cil_list *catorder_lists;
> >         struct cil_list *sensitivityorder_lists;
> >         struct cil_list *in_list;
> > -       struct cil_stack *disabled_optionals;
> >  };
> >
> >  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> > @@ -3873,7 +3873,6 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> >         struct cil_tree_node *macro = args->macro;
> >         struct cil_tree_node *optional = args->optional;
> >         struct cil_tree_node *boolif = args->boolif;
> > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> >
> >         if (node == NULL) {
> >                 goto exit;
> > @@ -3956,7 +3955,9 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> >                 if (optional == NULL) {
> >                         cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
> >                 } else {
> > -                       cil_stack_push(disabled_optionals, CIL_NODE, optional);
> > +                       if (!args->disabled_optional) {
> > +                               args->disabled_optional = optional;
> > +                       }
> >                         cil_tree_log(node, CIL_INFO, "Failed to resolve %s statement", cil_node_to_string(node));
> >                         cil_tree_log(optional, CIL_INFO, "Disabling optional '%s'", DATUM(optional->data)->name);
> >                         rc = SEPOL_OK;
> > @@ -4003,7 +4004,6 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> >  {
> >         int rc = SEPOL_ERR;
> >         struct cil_args_resolve *args = extra_args;
> > -       struct cil_stack *disabled_optionals = args->disabled_optionals;
> >         struct cil_tree_node *parent = NULL;
> >
> >         if (current == NULL ||  extra_args == NULL) {
> > @@ -4026,11 +4026,10 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> >                 args->macro = NULL;
> >         } else if (parent->flavor == CIL_OPTIONAL) {
> >                 struct cil_tree_node *n = parent->parent;
> > -               struct cil_stack_item *item = cil_stack_peek(disabled_optionals);
> > -               if (item && item->data == parent) {
> > -                       cil_stack_pop(disabled_optionals);
> > +               if (args->disabled_optional == parent) {
> >                         *(args->changed) = CIL_TRUE;
> >                         cil_list_append(args->to_destroy, CIL_NODE, parent);
> > +                       args->disabled_optional = NULL;
> >                 }
> >                 args->optional = NULL;
> >                 while (n && n->flavor != CIL_ROOT) {
> > @@ -4067,6 +4066,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >         extra_args.block = NULL;
> >         extra_args.macro = NULL;
> >         extra_args.optional = NULL;
> > +       extra_args.disabled_optional = NULL;
> >         extra_args.boolif= NULL;
> >         extra_args.sidorder_lists = NULL;
> >         extra_args.classorder_lists = NULL;
> > @@ -4074,7 +4074,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >         extra_args.catorder_lists = NULL;
> >         extra_args.sensitivityorder_lists = NULL;
> >         extra_args.in_list = NULL;
> > -       extra_args.disabled_optionals = NULL;
> >
> >         cil_list_init(&extra_args.to_destroy, CIL_NODE);
> >         cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
> > @@ -4083,7 +4082,6 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >         cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
> >         cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
> >         cil_list_init(&extra_args.in_list, CIL_IN);
> > -       cil_stack_init(&extra_args.disabled_optionals);
> >
> >         for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
> >                 extra_args.pass = pass;
> > @@ -4218,7 +4216,6 @@ exit:
> >         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> >         cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> >         cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > -       cil_stack_destroy(&extra_args.disabled_optionals);
> >
> >         return rc;
> >  }
> > --
> > 2.31.1
> >
>
