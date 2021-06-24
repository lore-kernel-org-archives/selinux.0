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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDAEC49EA5
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4481F611CB
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFXOc6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXOc6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 10:32:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECD8C061574
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:30:39 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5800668otl.0
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1ZJklUFD8dyPq5zcLuZj0sPlboU82hHv7SJjN4pSbw=;
        b=ubwCADCzyPwxqyeI1pji4qNHsLllS5oYNUoox2RatSi1iZ8Ia90/WzpbegUu/UJjLP
         Ga8vEEYp/q1exqWOQIHji2kPsVY9P7uk9SK0NXFBe7qucNifsgT4xUplujccxkLTyduD
         2v5C6azPzUm4dhVN9hmTwxMr9QCpGINOb58hDGIicpF6UZ7gYRWlwBSrsfWPVmVilstU
         nav2Cf5/3cG8yaHWWPbOk3oxmJFLZqhsHiB/8zRWdh3x2KsKhnjbKIsS+vbUb+VELnZE
         P/dGTPbJE8J2FlPyhChhNo9fJHn82l+GylVwqkN7JLoqh8hNmf96UKBeRfFiJdIembj+
         PamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1ZJklUFD8dyPq5zcLuZj0sPlboU82hHv7SJjN4pSbw=;
        b=CK0mSYoI1jUZL9RrxH4oa4WBl+laRpq4cDtJk7icSqdUn8ZEQwgbP60tqxrHvR/RgO
         UmyuqF3uysyEmo/v7GzWWziT+AG9tIq/ezdf0pl5iIGSDU+pfMgQqK4Rw3T+sf3FuGjI
         41gp4U8I6iCNtYELoN8NUowfd71XoQbMzLnPgryzaw31MEooDbX5S9Br1r3UjyIUXRsD
         SNxCNqqp0rax8rDZS3O6X6MMBJhQ3q2EVK6OyqUDF9sY/dZDNnfR/BqPBBBfn7FcXAJe
         prJYK+9wIn/We6kXG0Hm4QWw/ae1JcorPQmIrlBxnIDcZ/vt+Czr5tGLzL6dxRXbsVeZ
         Sl2g==
X-Gm-Message-State: AOAM532mnVWBW4XtJQrRHPrhb8irc7Jx4478FTRJauyg3j9E7OO/Bxvb
        R9EZYAO4rNSOK4X+5qhtLuOr/pw/tDchL299ESw=
X-Google-Smtp-Source: ABdhPJyFU7CZVjPHRbBi8kzxCsNEFJ09c7FFHwYjB9DydmfNxwUknq5Fupp7xOhzyZueCObaBlJuNd8buyLOti9ActA=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr4923867otp.295.1624545038590;
 Thu, 24 Jun 2021 07:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210617174340.176419-1-jwcart2@gmail.com> <CAJfZ7=k0YWBe_Gd_fHSG2eZu19GzaqcQV5mm=5=pEp5EXAzi7Q@mail.gmail.com>
 <CAP+JOzQqjNaLF-iS=KpUYhVSdr92w7SujqM8ZGVjSbCmy_xK5g@mail.gmail.com>
In-Reply-To: <CAP+JOzQqjNaLF-iS=KpUYhVSdr92w7SujqM8ZGVjSbCmy_xK5g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Jun 2021 10:30:27 -0400
Message-ID: <CAP+JOzS+H69yXhCTiXc37OakxrXnjr_iH1uCYKzE4=CNXttDCg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Allow duplicate optional blocks in most cases
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 23, 2021 at 4:37 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Jun 23, 2021 at 4:05 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Thu, Jun 17, 2021 at 7:43 PM James Carter <jwcart2@gmail.com> wrote:
> > >
> > > The commit d155b410d4bbc90d28f361b966f0429598da8188 (libsepol/cil:
> > > Check for duplicate blocks, optionals, and macros) fixed a bug
> > > that allowed duplicate blocks, optionals, and macros with the same
> > > name in the same namespace. For blocks and macros, a duplicate
> > > is always a problem, but optional block names are only used for
> > > in-statement resolution. If no in-statement refers to an optional
> > > block, then it does not matter if more than one with same name
> > > exists.
> > >
> > > One easy way to generate multiple optional blocks with the same
> > > name declaration is to call a macro with an optional block multiple
> > > times in the same namespace.
> > >
> > > As an example, here is a portion of CIL policy
> > >   (macro m1 ((type t))
> > >     (optional op1
> > >       (allow t self (CLASS (PERM)))
> > >     )
> > >   )
> > >   (type t1)
> > >   (call m1 (t1))
> > >   (type t2)
> > >   (call m1 (t2))
> > > This will result in two optional blocks with the name op1.
> > >
> > > There are three parts to allowing multiple optional blocks with
> > > the same name declaration.
> > >
> > > 1) Track an optional block's enabled status in a different way.
> > >
> > >    One hinderance to allowing multiple optional blocks with the same
> > >    name declaration is that they cannot share the same datum. This is
> > >    because the datum is used to get the struct cil_optional which has
> > >    the enabled field and each block's enabled status is independent of
> > >    the others.
> > >
> > >    Remove the enabled field from struct cil_optional, so it only contains
> > >    the datum. Use a stack to track which optional blocks are being
> > >    disabled, so they can be deleted in the right order.
> > >
> > > 2) Allow multiple declarations of optional blocks.
> > >
> > >    Update cil_allow_multiple_decls() so that a flavor of CIL_OPTIONAL
> > >    will return CIL_TRUE. Also remove the check in cil_copy_optional().
> > >
> > > 3) Check if an in-statement refers to an optional with multiple
> > >    declarations and exit with an error if it does.
> > >
> > > Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Hello,
> >
> > This patch looks good to me, even though it conflicts with the pending
> > patch "libsepol/cil: Improve degenerate inheritance check" in
> > libsepol/cil/src/cil_resolve_ast.c:
> >
> > ++<<<<<<< HEAD
> >  +      struct cil_stack *disabled_optionals;
> > ++=======
> > +       int *inheritance_check;
> > ++>>>>>>> c8dde7093e4a (libsepol/cil: Improve degenerate inheritance check)
> > ...
> > ++<<<<<<< HEAD
> >  +      extra_args.disabled_optionals = NULL;
> > ++=======
> > +       extra_args.inheritance_check = &inheritance_check;
> > ++>>>>>>> c8dde7093e4a (libsepol/cil: Improve degenerate inheritance check)
> >
> > I guess both additions need to be kept when merging both patches
> >
> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
>
> Yes, I will have to resolve that conflict when I merge them.
> Thanks for the review,
> Jim
>

This has been merged (with the conflicts resolved).
Jim

> > > ---
> > >  libsepol/cil/src/cil.c             |  1 -
> > >  libsepol/cil/src/cil_build_ast.c   |  3 ++
> > >  libsepol/cil/src/cil_copy_ast.c    | 11 +-----
> > >  libsepol/cil/src/cil_internal.h    |  1 -
> > >  libsepol/cil/src/cil_resolve_ast.c | 55 ++++++++++++++++++------------
> > >  5 files changed, 37 insertions(+), 34 deletions(-)
> > >
> > > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > > index 0d351b49..671b5ec6 100644
> > > --- a/libsepol/cil/src/cil.c
> > > +++ b/libsepol/cil/src/cil.c
> > > @@ -2752,7 +2752,6 @@ void cil_call_init(struct cil_call **call)
> > >  void cil_optional_init(struct cil_optional **optional)
> > >  {
> > >         *optional = cil_malloc(sizeof(**optional));
> > > -       (*optional)->enabled = CIL_TRUE;
> > >         cil_symtab_datum_init(&(*optional)->datum);
> > >  }
> > >
> > > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > > index 71f14e20..2c72accc 100644
> > > --- a/libsepol/cil/src/cil_build_ast.c
> > > +++ b/libsepol/cil/src/cil_build_ast.c
> > > @@ -96,6 +96,9 @@ static int cil_allow_multiple_decls(struct cil_db *db, enum cil_flavor f_new, en
> > >                         return CIL_TRUE;
> > >                 }
> > >                 break;
> > > +       case CIL_OPTIONAL:
> > > +               return CIL_TRUE;
> > > +               break;
> > >         default:
> > >                 break;
> > >         }
> > > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> > > index 954eab33..9c0231f2 100644
> > > --- a/libsepol/cil/src/cil_copy_ast.c
> > > +++ b/libsepol/cil/src/cil_copy_ast.c
> > > @@ -1529,19 +1529,10 @@ int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void *
> > >         return SEPOL_OK;
> > >  }
> > >
> > > -int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> > > +int cil_copy_optional(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
> > >  {
> > > -       struct cil_optional *orig = data;
> > > -       char *key = orig->datum.name;
> > > -       struct cil_symtab_datum *datum = NULL;
> > >         struct cil_optional *new;
> > >
> > > -       cil_symtab_get_datum(symtab, key, &datum);
> > > -       if (datum != NULL) {
> > > -               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> > > -               return SEPOL_ERR;
> > > -       }
> > > -
> > >         cil_optional_init(&new);
> > >         *copy = new;
> > >
> > > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> > > index a77c9520..24be09aa 100644
> > > --- a/libsepol/cil/src/cil_internal.h
> > > +++ b/libsepol/cil/src/cil_internal.h
> > > @@ -358,7 +358,6 @@ struct cil_in {
> > >
> > >  struct cil_optional {
> > >         struct cil_symtab_datum datum;
> > > -       int enabled;
> > >  };
> > >
> > >  struct cil_perm {
> > > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > > index 77ffe0ff..62e0e013 100644
> > > --- a/libsepol/cil/src/cil_resolve_ast.c
> > > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > > @@ -46,12 +46,13 @@
> > >  #include "cil_verify.h"
> > >  #include "cil_strpool.h"
> > >  #include "cil_symtab.h"
> > > +#include "cil_stack.h"
> > >
> > >  struct cil_args_resolve {
> > >         struct cil_db *db;
> > >         enum cil_pass pass;
> > >         uint32_t *changed;
> > > -       struct cil_list *disabled_optionals;
> > > +       struct cil_list *to_destroy;
> > >         struct cil_tree_node *block;
> > >         struct cil_tree_node *macro;
> > >         struct cil_tree_node *optional;
> > > @@ -62,6 +63,7 @@ struct cil_args_resolve {
> > >         struct cil_list *catorder_lists;
> > >         struct cil_list *sensitivityorder_lists;
> > >         struct cil_list *in_list;
> > > +       struct cil_stack *disabled_optionals;
> > >  };
> > >
> > >  static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key, struct cil_tree_node *ast_node)
> > > @@ -2552,6 +2554,15 @@ int cil_resolve_in(struct cil_tree_node *current, void *extra_args)
> > >
> > >         block_node = NODE(block_datum);
> > >
> > > +       if (block_node->flavor == CIL_OPTIONAL) {
> > > +               if (block_datum->nodes && block_datum->nodes->head != block_datum->nodes->tail) {
> > > +                       cil_tree_log(current, CIL_ERR, "Multiple optional blocks referred to by in-statement");
> > > +                       cil_tree_log(block_node, CIL_ERR, "First optional block");
> > > +                       rc = SEPOL_ERR;
> > > +                       goto exit;
> > > +               }
> > > +       }
> > > +
> > >         rc = cil_copy_ast(db, current, block_node);
> > >         if (rc != SEPOL_OK) {
> > >                 cil_tree_log(current, CIL_ERR, "Failed to copy in-statement");
> > > @@ -3867,6 +3878,7 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > >         struct cil_tree_node *macro = args->macro;
> > >         struct cil_tree_node *optional = args->optional;
> > >         struct cil_tree_node *boolif = args->boolif;
> > > +       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > >
> > >         if (node == NULL) {
> > >                 goto exit;
> > > @@ -3946,22 +3958,14 @@ int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *finished
> > >
> > >         rc = __cil_resolve_ast_node(node, extra_args);
> > >         if (rc == SEPOL_ENOENT) {
> > > -               enum cil_log_level lvl = CIL_ERR;
> > > -
> > > -               if (optional != NULL) {
> > > -                       lvl = CIL_INFO;
> > > -
> > > -                       struct cil_optional *opt = (struct cil_optional *)optional->data;
> > > -                       struct cil_tree_node *opt_node = NODE(opt);;
> > > -                       /* disable an optional if something failed to resolve */
> > > -                       opt->enabled = CIL_FALSE;
> > > -                       cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
> > > -                       cil_tree_log(opt_node, lvl, "Disabling optional '%s'", opt->datum.name);
> > > +               if (optional == NULL) {
> > > +                       cil_tree_log(node, CIL_ERR, "Failed to resolve %s statement", cil_node_to_string(node));
> > > +               } else {
> > > +                       cil_stack_push(disabled_optionals, CIL_NODE, optional);
> > > +                       cil_tree_log(node, CIL_INFO, "Failed to resolve %s statement", cil_node_to_string(node));
> > > +                       cil_tree_log(optional, CIL_INFO, "Disabling optional '%s'", DATUM(optional->data)->name);
> > >                         rc = SEPOL_OK;
> > > -                       goto exit;
> > >                 }
> > > -
> > > -               cil_tree_log(node, lvl, "Failed to resolve %s statement", cil_node_to_string(node));
> > >                 goto exit;
> > >         }
> > >
> > > @@ -4004,6 +4008,7 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > >  {
> > >         int rc = SEPOL_ERR;
> > >         struct cil_args_resolve *args = extra_args;
> > > +       struct cil_stack *disabled_optionals = args->disabled_optionals;
> > >         struct cil_tree_node *parent = NULL;
> > >
> > >         if (current == NULL ||  extra_args == NULL) {
> > > @@ -4026,9 +4031,11 @@ int __cil_resolve_ast_last_child_helper(struct cil_tree_node *current, void *ext
> > >                 args->macro = NULL;
> > >         } else if (parent->flavor == CIL_OPTIONAL) {
> > >                 struct cil_tree_node *n = parent->parent;
> > > -               if (((struct cil_optional *)parent->data)->enabled == CIL_FALSE) {
> > > +               struct cil_stack_item *item = cil_stack_peek(disabled_optionals);
> > > +               if (item && item->data == parent) {
> > > +                       cil_stack_pop(disabled_optionals);
> > >                         *(args->changed) = CIL_TRUE;
> > > -                       cil_list_append(args->disabled_optionals, CIL_NODE, parent);
> > > +                       cil_list_append(args->to_destroy, CIL_NODE, parent);
> > >                 }
> > >                 args->optional = NULL;
> > >                 while (n && n->flavor != CIL_ROOT) {
> > > @@ -4072,14 +4079,17 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > >         extra_args.catorder_lists = NULL;
> > >         extra_args.sensitivityorder_lists = NULL;
> > >         extra_args.in_list = NULL;
> > > +       extra_args.disabled_optionals = NULL;
> > >
> > > -       cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
> > > +       cil_list_init(&extra_args.to_destroy, CIL_NODE);
> > >         cil_list_init(&extra_args.sidorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.classorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
> > >         cil_list_init(&extra_args.in_list, CIL_IN);
> > > +       cil_stack_init(&extra_args.disabled_optionals);
> > > +
> > >         for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
> > >                 extra_args.pass = pass;
> > >                 rc = cil_tree_walk(current, __cil_resolve_ast_node_helper, __cil_resolve_ast_first_child_helper, __cil_resolve_ast_last_child_helper, &extra_args);
> > > @@ -4172,11 +4182,11 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> > >                                         goto exit;
> > >                                 }
> > >                         }
> > > -                       cil_list_for_each(item, extra_args.disabled_optionals) {
> > > +                       cil_list_for_each(item, extra_args.to_destroy) {
> > >                                 cil_tree_children_destroy(item->data);
> > >                         }
> > > -                       cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
> > > -                       cil_list_init(&extra_args.disabled_optionals, CIL_NODE);
> > > +                       cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> > > +                       cil_list_init(&extra_args.to_destroy, CIL_NODE);
> > >                         changed = 0;
> > >                 }
> > >         }
> > > @@ -4193,8 +4203,9 @@ exit:
> > >         __cil_ordered_lists_destroy(&extra_args.catorder_lists);
> > >         __cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
> > >         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> > > -       cil_list_destroy(&extra_args.disabled_optionals, CIL_FALSE);
> > > +       cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> > >         cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > > +       cil_stack_destroy(&extra_args.disabled_optionals);
> > >
> > >         return rc;
> > >  }
> > > --
> > > 2.26.3
> > >
> >
