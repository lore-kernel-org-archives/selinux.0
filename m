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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79975C4338F
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C2F60295
	for <selinux@archiver.kernel.org>; Tue, 17 Aug 2021 21:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHQVGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Aug 2021 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHQVGb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Aug 2021 17:06:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB06EC061764
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 14:05:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id o185so1088288oih.13
        for <selinux@vger.kernel.org>; Tue, 17 Aug 2021 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pu+h0JuS04HrQAg6alqJjwUQR8hN/2BbiR7EH3fl8dI=;
        b=VDAiYriDG3ZW+P5eajUmb+Pi1hr1aGJVtGGEYvAZaxYBQdFTWvXax5x9azKQX63T4m
         rm5MAJoK3XS5q6GxjH/RLhNKkvAYsMzGKQ3r6a0R0MI2gDQOZQIQmDRx4PLvOqVVuX7r
         VWVp1NhWXJ9lqKww/9TQ59HKDukppDYEWiieO/UwCXseFvcjL7H74B6yAjzCVbmGer2Q
         8hTG0ezKXfsFVKZ4M6M4e2jRqvj6q89MBNVuY4LNDQXdQo+mTtzhsjoWBMqdQGcg1IcM
         93pg1jUy30CMOSuvTjzY5/4+KmnYQ9i/UiCUrUyFx/6clxDU8s7uTHUdgiGGgSwF3CBl
         VS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pu+h0JuS04HrQAg6alqJjwUQR8hN/2BbiR7EH3fl8dI=;
        b=XDixGxAa2mGprDqz4qjc0TishyjhclgCGXdSnq2bA69OfX6qtTWReOM5RSo/p6BVe1
         vB/PHSblqPouwybGyjYue5NHVSs/ORlcKtYhpI+c6/Ococr6yJmVACmIcEp8aQni67c2
         kmJGNvQz/Tf0qo4JhsJfDlpa9Noe65hlb6N4kSPkBdqq+lNekdhiyrJtUV1jGpR6RSVx
         /PkxS04tDUZvtXRfvw7n8fEt+nhEZdtWfs+QSR/ykcsHNsi+r1EO3LddrxbOayjqhuxS
         6csXI15dR0G3qtty9F316FKhKGmoBeMSFvc0H+SPFW46gR8/c6G2VOre/7K4/SRBmeTh
         TO2Q==
X-Gm-Message-State: AOAM533x7fETsPFc323fqIu4V/BU5U8jWKTavcebcc5WADKeD5+TjkHg
        NGJIKuDQo9VKt1LjoE0eQGofO8xEkJULwDKLauE=
X-Google-Smtp-Source: ABdhPJzCarCM5UsThTny3KlEaSwlM6BhBh2YBa0kc3D6DLPkALwufnG/nkEc4UTDb/tomO2QRlb9TQUaLglMxxtWsCA=
X-Received: by 2002:aca:4b49:: with SMTP id y70mr4021820oia.16.1629234357103;
 Tue, 17 Aug 2021 14:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210813115157.789302-1-jwcart2@gmail.com> <20210813115157.789302-2-jwcart2@gmail.com>
 <CAJfZ7==cV13-tVy9H1bvsAAviMdxK=Dwb5WL5+B4aCyN0fBviQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==cV13-tVy9H1bvsAAviMdxK=Dwb5WL5+B4aCyN0fBviQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 17 Aug 2021 17:05:46 -0400
Message-ID: <CAP+JOzRPJvuTGwNzNLOL8c+XPQhd631rFZwqbhb+pvUixarvOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Improve in-statement to allow use after inheritance
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Dominick Grift <dominick.grift@defensec.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 17, 2021 at 4:31 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
>  On Fri, Aug 13, 2021 at 1:52 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL's in-statement is resolved before block inheritance. This has
> > the advantage of allowing an in-statement to add rules to a base
> > block (say for a new permission) and having those rules also be
> > added everywhere that base block is inherited. But the disadvantage
> > of this behavior is that it is not possible to use an in-statement
> > on a block that is inherited for the simple reason that that block
> > does not exist when the in-statment is resolved.
> >
> > Change the syntax of the in-statement to allow specifying whether
> > the rules should be added before or after inheritance. If neither
> > is specified, then the behavior remains the same. All current
> > in-statements will work as before.
> >
> > Either the old syntax
> >   (in container_id
> >       cil_statement
> >       ...
> >   )
> > or the new syntax
> >   (in before|after container_id
> >       cil_statement
> >       ...
> >   )
> > may be used for in-statements. But only "(in after ..." will have
> > the new behavior. Using "(in before ..." will give the same
> > behavior as before.
> >
> > Macro Example
> > ;
> > (block b1
> >   (macro m1 ((type ARG1))
> >     (allow ARG1 self (C1 (P1a)))
> >   )
> > )
> > (in after b1.m1
> >   (allow ARG1 self (C1 (P1c)))
> > )
> > (type t1a)
> > (call b1.m1 (t1a))
> > (blockinherit b1)
> > (in after m1
> >   (allow ARG1 self (C1 (P1b)))
> > )
> > (type t1b)
> > (call m1 (t1b))
> > ;
> > This results in the following rules:
> >   (allow t1a self (C1 (P1a)))
> >   (allow t1a self (C1 (P1c)))
> >   (allow t1b self (C1 (P1a)))
> >   (allow t1b self (C1 (P1b)))
> >
> > Block Example
> > ;
> > (block b2
> >   (block b
> >     (type ta)
> >     (allow ta self (C2 (P2a)))
> >   )
> > )
> > (in before b2.b
> >   (type tb)
> >   (allow tb self (C2 (P2b)))
> > )
> > (block c2
> >   (blockinherit b2)
> >   (in after b
> >     (type tc)
> >     (allow tc self (C2 (P2c)))
> >   )
> > )
> > ;
> > This results in the following rules:
> >   (allow b2.b.ta self (C2 (P2a)))
> >   (allow b2.b.tb self (C2 (P2b)))
> >   (allow c2.b.ta self (C2 (P2a)))
> >   (allow c2.b.tb self (C2 (P2b)))
> >   (allow c2.b.tc self (C2 (P2c)))
> >
> > Using in-statements on optionals also works as expected.
> >
> > One additional change is that blockabstract and blockinherit rules
> > are not allowed when using an after in-statement. This is because
> > both of those are resolved before an after in-statement would be
> > resolved.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil.c             |  5 +++
> >  libsepol/cil/src/cil_build_ast.c   | 31 +++++++++++++++++--
> >  libsepol/cil/src/cil_internal.h    |  6 +++-
> >  libsepol/cil/src/cil_resolve_ast.c | 49 +++++++++++++++++++++---------
> >  4 files changed, 72 insertions(+), 19 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> > index d24c81c8..672342b5 100644
> > --- a/libsepol/cil/src/cil.c
> > +++ b/libsepol/cil/src/cil.c
> > @@ -142,6 +142,8 @@ char *CIL_KEY_HANDLEUNKNOWN_DENY;
> >  char *CIL_KEY_HANDLEUNKNOWN_REJECT;
> >  char *CIL_KEY_MACRO;
> >  char *CIL_KEY_IN;
> > +char *CIL_KEY_IN_BEFORE;
> > +char *CIL_KEY_IN_AFTER;
> >  char *CIL_KEY_MLS;
> >  char *CIL_KEY_DEFAULTRANGE;
> >  char *CIL_KEY_BLOCKINHERIT;
> > @@ -353,6 +355,8 @@ static void cil_init_keys(void)
> >         CIL_KEY_DEFAULTTYPE = cil_strpool_add("defaulttype");
> >         CIL_KEY_MACRO = cil_strpool_add("macro");
> >         CIL_KEY_IN = cil_strpool_add("in");
> > +       CIL_KEY_IN_BEFORE = cil_strpool_add("before");
> > +       CIL_KEY_IN_AFTER = cil_strpool_add("after");
> >         CIL_KEY_MLS = cil_strpool_add("mls");
> >         CIL_KEY_DEFAULTRANGE = cil_strpool_add("defaultrange");
> >         CIL_KEY_GLOB = cil_strpool_add("*");
> > @@ -2121,6 +2125,7 @@ void cil_in_init(struct cil_in **in)
> >         *in = cil_malloc(sizeof(**in));
> >
> >         cil_symtab_array_init((*in)->symtab, cil_sym_sizes[CIL_SYM_ARRAY_IN]);
> > +       (*in)->is_after = CIL_FALSE;
> >         (*in)->block_str = NULL;
> >  }
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 9da90883..4a87e212 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -380,7 +380,8 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
> >         enum cil_syntax syntax[] = {
> >                 CIL_SYN_STRING,
> >                 CIL_SYN_STRING,
> > -               CIL_SYN_N_LISTS,
> > +               CIL_SYN_STRING | CIL_SYN_N_LISTS,
> > +               CIL_SYN_N_LISTS | CIL_SYN_END,
> >                 CIL_SYN_END
> >         };
>
> Hello,
> I am unfamiliar with __cil_verify_syntax, but when I see this
> definition of syntax, it makes me think that the syntax allows {...,
> CIL_SYN_N_LISTS, CIL_SYN_N_LISTS, CIL_SYN_END}, which is not supposed
> to be allowed. Nevertheless when this happens,
> parse_current->next->next->data should be NULL (if I understand
> correctly what __cil_verify_syntax does with CIL_SYN_N_LISTS) so the
> in statement is treated as a current in statement (with no
> before/after keywords).
>
> After more digging in __cil_verify_syntax, it seems that this first
> interpretation is partially unsound ("two successive CIL_SYN_N_LISTS"
> does not make sense) but in fact using "CIL_SYN_STRING |
> CIL_SYN_N_LISTS" could cause issues, because this can match a list
> (i.e. a sequence of nodes such that c->data == NULL && c->cl_head !=
> NULL) ended with a string (i.e. c->data != NULL && c->cl_head ==
> NULL). So I guess that it is possible to craft a CIL policy with "(in
> container_id (cil_statements) some_string (other_cil_statements))",
> and the current code could behave unexpectedly on "some_string".
> This could in fact be a bug in __cil_verify_syntax, which should
> verify that either the current node is a string or that the current
> and its successors are all list nodes, but not a mix of "a list of
> list nodes ended with a string", when CIL_SYN_STRING | CIL_SYN_N_LISTS
> is used.
>

I think that your analysis might be correct here. I will take a look
at this. I think that __cil_verify_syntax() is limited and might not
be capable of catching everything. So at the very least, I probably
need to do more checking in cil_gen_in().

> I do not currently have time to check that there is actually a bug
> (and will not have before the end of August). So I am sharing my
> thoughts to make you aware of this. If you see something that I missed
> (and this is likely), please do not hesitate to reply that I am wrong.
>

As always, thanks for your comments,
Jim

> Thanks,
> Nicolas
>
> >         int syntax_len = sizeof(syntax)/sizeof(*syntax);
> > @@ -403,14 +404,29 @@ int cil_gen_in(struct cil_db *db, struct cil_tree_node *parse_current, struct ci
> >
> >         cil_in_init(&in);
> >
> > -       in->block_str = parse_current->next->data;
> > +       if (parse_current->next->next->data) {
> > +               char *is_after_str = parse_current->next->data;
> > +               if (is_after_str == CIL_KEY_IN_BEFORE) {
> > +                       in->is_after = CIL_FALSE;
> > +               } else if (is_after_str == CIL_KEY_IN_AFTER) {
> > +                       in->is_after = CIL_TRUE;
> > +               } else {
> > +                       cil_log(CIL_ERR, "Value must be either \'before\' or \'after\'\n");
> > +                       rc = SEPOL_ERR;
> > +                       goto exit;
> > +               }
> > +               in->block_str = parse_current->next->next->data;
> > +       } else {
> > +               in->is_after = CIL_FALSE;
> > +               in->block_str = parse_current->next->data;
> > +       }
> >
> >         ast_node->data = in;
> >         ast_node->flavor = CIL_IN;
> >
> >         return SEPOL_OK;
> >  exit:
> > -       cil_tree_log(parse_current, CIL_ERR, "Bad in statement");
> > +       cil_tree_log(parse_current, CIL_ERR, "Bad in-statement");
> >         cil_destroy_in(in);
> >         return rc;
> >  }
> > @@ -6136,12 +6152,21 @@ int __cil_build_ast_node_helper(struct cil_tree_node *parse_current, uint32_t *f
> >         }
> >
> >         if (in != NULL) {
> > +               struct cil_in *in_block = in->data;
> >                 if (parse_current->data == CIL_KEY_TUNABLE ||
> >                         parse_current->data == CIL_KEY_IN) {
> >                         rc = SEPOL_ERR;
> >                         cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in in-statement", (char *)parse_current->data);
> >                         goto exit;
> >                 }
> > +               if (in_block->is_after == CIL_TRUE) {
> > +                       if (parse_current->data == CIL_KEY_BLOCKINHERIT ||
> > +                               parse_current->data == CIL_KEY_BLOCKABSTRACT) {
> > +                               rc = SEPOL_ERR;
> > +                               cil_tree_log(parse_current, CIL_ERR, "%s is not allowed in an after in-statement", (char *)parse_current->data);
> > +                               goto exit;
> > +                       }
> > +               }
> >         }
> >
> >         if (macro != NULL) {
> > diff --git a/libsepol/cil/src/cil_internal.h b/libsepol/cil/src/cil_internal.h
> > index 98e303d1..d33c66bc 100644
> > --- a/libsepol/cil/src/cil_internal.h
> > +++ b/libsepol/cil/src/cil_internal.h
> > @@ -56,10 +56,11 @@ enum cil_pass {
> >         CIL_PASS_INIT = 0,
> >
> >         CIL_PASS_TIF,
> > -       CIL_PASS_IN,
> > +       CIL_PASS_IN_BEFORE,
> >         CIL_PASS_BLKIN_LINK,
> >         CIL_PASS_BLKIN_COPY,
> >         CIL_PASS_BLKABS,
> > +       CIL_PASS_IN_AFTER,
> >         CIL_PASS_CALL1,
> >         CIL_PASS_CALL2,
> >         CIL_PASS_ALIAS1,
> > @@ -158,6 +159,8 @@ extern char *CIL_KEY_HANDLEUNKNOWN_DENY;
> >  extern char *CIL_KEY_HANDLEUNKNOWN_REJECT;
> >  extern char *CIL_KEY_MACRO;
> >  extern char *CIL_KEY_IN;
> > +extern char *CIL_KEY_IN_BEFORE;
> > +extern char *CIL_KEY_IN_AFTER;
> >  extern char *CIL_KEY_MLS;
> >  extern char *CIL_KEY_DEFAULTRANGE;
> >  extern char *CIL_KEY_BLOCKINHERIT;
> > @@ -355,6 +358,7 @@ struct cil_blockabstract {
> >
> >  struct cil_in {
> >         symtab_t symtab[CIL_SYM_NUM];
> > +       int is_after;
> >         char *block_str;
> >  };
> >
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> > index 18007324..77e0d402 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -62,7 +62,8 @@ struct cil_args_resolve {
> >         struct cil_list *unordered_classorder_lists;
> >         struct cil_list *catorder_lists;
> >         struct cil_list *sensitivityorder_lists;
> > -       struct cil_list *in_list;
> > +       struct cil_list *in_list_before;
> > +       struct cil_list *in_list_after;
> >         struct cil_stack *disabled_optionals;
> >  };
> >
> > @@ -2449,10 +2450,8 @@ exit:
> >         return rc;
> >  }
> >
> > -int cil_resolve_in_list(void *extra_args)
> > +int cil_resolve_in_list(struct cil_list *in_list, void *extra_args)
> >  {
> > -       struct cil_args_resolve *args = extra_args;
> > -       struct cil_list *ins = args->in_list;
> >         struct cil_list_item *curr = NULL;
> >         struct cil_tree_node *node = NULL;
> >         struct cil_tree_node *last_failed_node = NULL;
> > @@ -2466,7 +2465,7 @@ int cil_resolve_in_list(void *extra_args)
> >                 resolved = 0;
> >                 unresolved = 0;
> >
> > -               cil_list_for_each(curr, ins) {
> > +               cil_list_for_each(curr, in_list) {
> >                         if (curr->flavor != CIL_NODE) {
> >                                 continue;
> >                         }
> > @@ -3590,12 +3589,10 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
> >         int rc = SEPOL_OK;
> >         struct cil_args_resolve *args = extra_args;
> >         enum cil_pass pass = 0;
> > -       struct cil_list *ins;
> >
> >         if (node == NULL || args == NULL) {
> >                 goto exit;
> >         }
> > -       ins = args->in_list;
> >
> >         pass = args->pass;
> >         switch (pass) {
> > @@ -3604,11 +3601,14 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
> >                         rc = cil_resolve_tunif(node, args);
> >                 }
> >                 break;
> > -       case CIL_PASS_IN:
> > +       case CIL_PASS_IN_BEFORE:
> >                 if (node->flavor == CIL_IN) {
> >                         // due to ordering issues, in statements are just gathered here and
> >                         // resolved together in cil_resolve_in_list once all are found
> > -                       cil_list_prepend(ins, CIL_NODE, node);
> > +                       struct cil_in *in = node->data;
> > +                       if (in->is_after == CIL_FALSE) {
> > +                               cil_list_prepend(args->in_list_before, CIL_NODE, node);
> > +                       }
> >                 }
> >                 break;
> >         case CIL_PASS_BLKIN_LINK:
> > @@ -3626,6 +3626,16 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
> >                         rc = cil_resolve_blockabstract(node, args);
> >                 }
> >                 break;
> > +       case CIL_PASS_IN_AFTER:
> > +               if (node->flavor == CIL_IN) {
> > +                       // due to ordering issues, in statements are just gathered here and
> > +                       // resolved together in cil_resolve_in_list once all are found
> > +                       struct cil_in *in = node->data;
> > +                       if (in->is_after == CIL_TRUE) {
> > +                               cil_list_prepend(args->in_list_after, CIL_NODE, node);
> > +                       }
> > +               }
> > +               break;
> >         case CIL_PASS_CALL1:
> >                 if (node->flavor == CIL_CALL && args->macro == NULL) {
> >                         rc = cil_resolve_call(node, args);
> > @@ -4073,7 +4083,8 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >         extra_args.unordered_classorder_lists = NULL;
> >         extra_args.catorder_lists = NULL;
> >         extra_args.sensitivityorder_lists = NULL;
> > -       extra_args.in_list = NULL;
> > +       extra_args.in_list_before = NULL;
> > +       extra_args.in_list_after = NULL;
> >         extra_args.disabled_optionals = NULL;
> >
> >         cil_list_init(&extra_args.to_destroy, CIL_NODE);
> > @@ -4082,7 +4093,8 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >         cil_list_init(&extra_args.unordered_classorder_lists, CIL_LIST_ITEM);
> >         cil_list_init(&extra_args.catorder_lists, CIL_LIST_ITEM);
> >         cil_list_init(&extra_args.sensitivityorder_lists, CIL_LIST_ITEM);
> > -       cil_list_init(&extra_args.in_list, CIL_IN);
> > +       cil_list_init(&extra_args.in_list_before, CIL_IN);
> > +       cil_list_init(&extra_args.in_list_after, CIL_IN);
> >         cil_stack_init(&extra_args.disabled_optionals);
> >
> >         for (pass = CIL_PASS_TIF; pass < CIL_PASS_NUM; pass++) {
> > @@ -4093,12 +4105,18 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
> >                         goto exit;
> >                 }
> >
> > -               if (pass == CIL_PASS_IN) {
> > -                       rc = cil_resolve_in_list(&extra_args);
> > +               if (pass == CIL_PASS_IN_BEFORE) {
> > +                       rc = cil_resolve_in_list(extra_args.in_list_before, &extra_args);
> > +                       if (rc != SEPOL_OK) {
> > +                               goto exit;
> > +                       }
> > +                       cil_list_destroy(&extra_args.in_list_before, CIL_FALSE);
> > +               } else if (pass == CIL_PASS_IN_AFTER) {
> > +                       rc = cil_resolve_in_list(extra_args.in_list_after, &extra_args);
> >                         if (rc != SEPOL_OK) {
> >                                 goto exit;
> >                         }
> > -                       cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > +                       cil_list_destroy(&extra_args.in_list_after, CIL_FALSE);
> >                 }
> >
> >                 if (pass == CIL_PASS_BLKIN_LINK) {
> > @@ -4217,7 +4235,8 @@ exit:
> >         __cil_ordered_lists_destroy(&extra_args.sensitivityorder_lists);
> >         __cil_ordered_lists_destroy(&extra_args.unordered_classorder_lists);
> >         cil_list_destroy(&extra_args.to_destroy, CIL_FALSE);
> > -       cil_list_destroy(&extra_args.in_list, CIL_FALSE);
> > +       cil_list_destroy(&extra_args.in_list_before, CIL_FALSE);
> > +       cil_list_destroy(&extra_args.in_list_after, CIL_FALSE);
> >         cil_stack_destroy(&extra_args.disabled_optionals);
> >
> >         return rc;
> > --
> > 2.31.1
> >
>
