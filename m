Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0B3C433E7
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D500F22283
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X41/7laS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407103AbgJTNHi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406792AbgJTNHi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Oct 2020 09:07:38 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C850C061755
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 06:07:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h10so2050884oie.5
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a//ErE4tuRydRTQyPpovCOH/NHdt1B7k53sIhh1UB9Q=;
        b=X41/7laSCkFrI3J0iZtHNK/vjzJSF0DO8j9iia1UQnpYfKv3BXQovMqNIM6eqBOGD/
         oMtDImHPxZJJCkTlBg3pPEciDFi1syz51W4jdHB5cmRKCJKVxQkgIpICctpOgCx8YwDT
         7yXCESu0y7YpBf3aKfKLl6Mx4CVWbNjfefHQFx2nI4jSX2eV51L7h92DJFuL1s040IFH
         GH8IZKN+4ew/F846ZK8WFA/2FzNiR0wtm2k0YfxuDVa3n5qSXUCAtz746r6UIf4J9WWn
         gqmHQlfGSECLaVTYgJVQdudmUCWIr1Y5SpSZUBoN0XuxTaqySg9Vku+ScH/wSPOWGOME
         w2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a//ErE4tuRydRTQyPpovCOH/NHdt1B7k53sIhh1UB9Q=;
        b=gLridFgI0A3eMs+/MuuVAO1t6ZS1ZH10NkjBIj8GC9VlOPpMYNaLGGqxbDZHrIoZUF
         +wzTP3BLkt+MVXvNFI248Yl6iwAdk2eXT3axYgT8Ls6iLF5f6HyvBMo7E7ocryeq/6MZ
         27YwaxMoD/1lxX80Y4nhVxhicH9ih7tDmU2rIfuMJIHOl2GDzU/XilhENNy142EIpuVC
         TFky8KfCru4uK0TmObTT7o5MNtZ+adx4IfU3XXQAsGpWc/giU60hXhGP6XhHT4GLI6By
         3nVdUyzyFGFh2TIrLcbiK0o7+1j9B1ERGu5ZIpKqeDNeun3ydODpfoosILRLZY/pT3ec
         x1xA==
X-Gm-Message-State: AOAM531FshduMy8BMGAxbalRHR7odkKEOxw9w4ijztnG/W6O+5s9MUJT
        1EYdVXt9eMy46/c9yYCqc3iXnDelW2zap58h/xGBAIcy
X-Google-Smtp-Source: ABdhPJyI2ISYEN1OKisUrl8kqRxZgzksKvR7DrPXfKPXyL9ZA6wTvCAz3YM9USQJ7sLi/dnbWDJOJx+FKmGxry6LgCU=
X-Received: by 2002:aca:498b:: with SMTP id w133mr1606898oia.138.1603199256480;
 Tue, 20 Oct 2020 06:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201015204352.569018-1-jwcart2@gmail.com> <CAFqZXNsFSqa6NGHmDwLC-fF-KG2zZf3REuPGfRO3Va_8CT_nUA@mail.gmail.com>
In-Reply-To: <CAFqZXNsFSqa6NGHmDwLC-fF-KG2zZf3REuPGfRO3Va_8CT_nUA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 20 Oct 2020 09:07:25 -0400
Message-ID: <CAP+JOzQJpZUU9uEs74nBomo7skQBkwnD92zawpRwWzkqRpYVfQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Give error for more than one true or false block
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 20, 2020 at 8:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Oct 15, 2020 at 10:44 PM James Carter <jwcart2@gmail.com> wrote:
> > Both tunableif and booleanif use conditional blocks (either true or
> > false). No ordering is imposed, so a false block can be first (or even
> > the only) block. Checks are made to ensure that the first and second
> > (if it exists) blocks are either true or false, but no checks are made
> > to ensure that there is only one true and/or one false block. If there
> > are more than one true or false block, only the first will be used and
> > the other will be ignored.
> >
> > Create a function, cil_verify_conditional_blocks(), that gives an error
> > along with a message if more than one true or false block is specified
> > and call that function when building tunableif and booleanif blocks in
> > the AST.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 44 +++++---------------------------
> >  libsepol/cil/src/cil_verify.c    | 35 +++++++++++++++++++++++++
> >  libsepol/cil/src/cil_verify.h    |  1 +
> >  3 files changed, 42 insertions(+), 38 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 3aabb05e..a8955834 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -2821,7 +2821,6 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
> >         int syntax_len = sizeof(syntax)/sizeof(*syntax);
> >         struct cil_booleanif *bif = NULL;
> >         struct cil_tree_node *next = NULL;
> > -       struct cil_tree_node *cond = NULL;
> >         int rc = SEPOL_ERR;
> >
> >         if (db == NULL || parse_current == NULL || ast_node == NULL) {
> > @@ -2841,27 +2840,12 @@ int cil_gen_boolif(struct cil_db *db, struct cil_tree_node *parse_current, struc
> >                 goto exit;
> >         }
> >
> > -       cond = parse_current->next->next;
> > -
> > -       /* Destroying expr tree after stack is created*/
> > -       if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
> > -               cond->cl_head->data != CIL_KEY_CONDFALSE) {
> > -               rc = SEPOL_ERR;
> > -               cil_log(CIL_ERR, "Conditional neither true nor false\n");
> > +       rc = cil_verify_conditional_blocks(parse_current->next->next);
> > +       if (rc != SEPOL_OK) {
> >                 goto exit;
> >         }
> >
> > -       if (cond->next != NULL) {
> > -               cond = cond->next;
> > -               if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
> > -                       cond->cl_head->data != CIL_KEY_CONDFALSE) {
> > -                       rc = SEPOL_ERR;
> > -                       cil_log(CIL_ERR, "Conditional neither true nor false\n");
> > -                       goto exit;
> > -               }
> > -       }
> > -
> > -
> > +       /* Destroying expr tree */
> >         next = parse_current->next->next;
> >         cil_tree_subtree_destroy(parse_current->next);
> >         parse_current->next = next;
> > @@ -2905,7 +2889,6 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
> >         int syntax_len = sizeof(syntax)/sizeof(*syntax);
> >         struct cil_tunableif *tif = NULL;
> >         struct cil_tree_node *next = NULL;
> > -       struct cil_tree_node *cond = NULL;
> >         int rc = SEPOL_ERR;
> >
> >         if (db == NULL || parse_current == NULL || ast_node == NULL) {
> > @@ -2924,27 +2907,12 @@ int cil_gen_tunif(struct cil_db *db, struct cil_tree_node *parse_current, struct
> >                 goto exit;
> >         }
> >
> > -       cond = parse_current->next->next;
> > -
> > -       if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
> > -               cond->cl_head->data != CIL_KEY_CONDFALSE) {
> > -               rc = SEPOL_ERR;
> > -               cil_log(CIL_ERR, "Conditional neither true nor false\n");
> > +       rc = cil_verify_conditional_blocks(parse_current->next->next);
> > +       if (rc != SEPOL_OK) {
> >                 goto exit;
> >         }
> >
> > -       if (cond->next != NULL) {
> > -               cond = cond->next;
> > -
> > -               if (cond->cl_head->data != CIL_KEY_CONDTRUE &&
> > -                       cond->cl_head->data != CIL_KEY_CONDFALSE) {
> > -                       rc = SEPOL_ERR;
> > -                       cil_log(CIL_ERR, "Conditional neither true nor false\n");
> > -                       goto exit;
> > -               }
> > -       }
> > -
> > -       /* Destroying expr tree after stack is created*/
> > +       /* Destroying expr tree */
> >         next = parse_current->next->next;
> >         cil_tree_subtree_destroy(parse_current->next);
> >         parse_current->next = next;
> > diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> > index c73bbeee..7b3d2a8b 100644
> > --- a/libsepol/cil/src/cil_verify.c
> > +++ b/libsepol/cil/src/cil_verify.c
> > @@ -324,6 +324,41 @@ exit:
> >         return SEPOL_ERR;
> >  }
> >
> > +int cil_verify_conditional_blocks(struct cil_tree_node *current)
> > +{
> > +       int found_true = CIL_FALSE;
> > +       int found_false = CIL_FALSE;
> > +
> > +       if (current->cl_head->data == CIL_KEY_CONDTRUE) {
> > +               found_true = CIL_TRUE;
> > +       } else if (current->cl_head->data == CIL_KEY_CONDFALSE) {
> > +               found_false = CIL_TRUE;
> > +       } else {
> > +               cil_tree_log(current,CIL_ERR,"Expected true or false block in conditional");
>
> Please put a space after each comma in the argument list (same in the
> other cil_tree_log() calls in this function).
>

Sure, no problem.

> > +               return SEPOL_ERR;
> > +       }
> > +
> > +       current = current->next;
> > +       if (current != NULL) {
> > +               if (current->cl_head->data == CIL_KEY_CONDTRUE) {
> > +                       if (found_true) {
> > +                               cil_tree_log(current,CIL_ERR,"More than one true block in conditional");
> > +                               return SEPOL_ERR;
> > +                       }
> > +               } else if (current->cl_head->data == CIL_KEY_CONDFALSE) {
> > +                       if (found_false) {
> > +                               cil_tree_log(current,CIL_ERR,"More than one false block in conditional");
> > +                               return SEPOL_ERR;
> > +                       }
> > +               } else {
> > +                       cil_tree_log(current,CIL_ERR,"Expected true or false block in conditional");
> > +                       return SEPOL_ERR;
> > +               }
>
> Perhaps this is checked somewhere else or I'm missing something, but
> shouldn't this function also fail if there are more than two blocks
> (i.e. current->next != NULL here)? Not that it would cause any damage
> (I guess the extra blocks would be just ignored), but IMHO it's better
> to be strict about it.

More than two blocks will fail the syntax check, so no additional
checks are needed.

I'll send an updated patch.
Thanks,
Jim

>
> > +       }
> > +
> > +       return SEPOL_OK;
> > +}
> > +
> >  int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
> >  {
> >         struct cil_list_item *i;
> > diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
> > index bda1565f..905761b0 100644
> > --- a/libsepol/cil/src/cil_verify.h
> > +++ b/libsepol/cil/src/cil_verify.h
> > @@ -61,6 +61,7 @@ int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[]
> >  int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
> >  int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
> >  int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
> > +int cil_verify_conditional_blocks(struct cil_tree_node *current);
> >  int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list);
> >  int __cil_verify_ranges(struct cil_list *list);
> >  int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
> > --
> > 2.25.4
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
