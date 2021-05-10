Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B9C433B4
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152D960E09
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEJOVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 10:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbhEJOT3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 10:19:29 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A1C061355
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 06:55:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so10482892oto.0
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hm6i1GxXxbZEj864N+T+UxnIfbwmsEwDTx8IECCz9ZM=;
        b=PkmOqTrOYTngiaJghk2CsgQgQxGtzVg/Bwjk+OErnHwEAyi+CTkUuMVElxQH9u6cPO
         nnM+E3EC1zJiPemGxSrgFfXc/rrTRIVuPJpMt/s4NQky05mhxUAmWtv2vYHF3P4ddaRa
         S+T5s69Nz6+k20aW/VNRanpP5XIK44D/rdoxXEPNTGybJvpeouH6e9XVexX701EZViGT
         Fy/1ycnuwVOv/ms9tQ7aiA+rEGDnwB7LUGsGOKTYczrWTCCtHfR6DNPPSjsJxLUZe+nP
         /QGaV07BGqkzFMrpFSe39HC9ROqrGyDX59s7k9GLRt2rT3JdpllYwFgSFzBe7YWSmSXj
         PbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hm6i1GxXxbZEj864N+T+UxnIfbwmsEwDTx8IECCz9ZM=;
        b=hN9fcHHM84vJahBESKyIgmFOzTKS5OpZESEqD7IHbZdCHVkTjjWXnD99ac6SRUKT6A
         AueQM0SFjy/4Yu353rEonMUbmcTWuac0aB1JP3nGbOkvwYdZ3lKniGbyPf3ZgPLoR+d2
         THGB38kAk7X/8i73qzuhz6z0AS916oEn7dFBPpAze23GMrPEgKAMUxuOqH5btyRzHAKG
         0Z8BhQbZzR1xEe9OtQTiqAaOrVJVD8gJdYwQJYSkkkFNOZ+m7Hgqo9E6dwSbms6cP8/i
         98l6OroEmRhdf6KY3t2Hzrww0ycOhkvBNcZ5cQX4sdpNQdgXNjJySqxiYqihiIvrKCxr
         lhBw==
X-Gm-Message-State: AOAM532+iqTWC3wzHOe3NcTElo2PQwW4Q0l5cYxaoS31JRpPW/ipjstL
        I+N6HnwLxnLfRouEQUb+IV9yFjosPs9PFSejIjdbFqZmQYs=
X-Google-Smtp-Source: ABdhPJysjKP36cFdSoowtDRS3NCjAYAXY90WFwu3FpHMXvgcXPnnLqVYiEfcChEOLK6jQITM5TgKGDV2vKrtD58dgqM=
X-Received: by 2002:a9d:684e:: with SMTP id c14mr21099556oto.295.1620654949016;
 Mon, 10 May 2021 06:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210507173744.198858-1-jwcart2@gmail.com> <20210507173744.198858-2-jwcart2@gmail.com>
In-Reply-To: <20210507173744.198858-2-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 10 May 2021 09:55:38 -0400
Message-ID: <CAP+JOzTjZrFpDhceF54Pv2WMPzQG4gYqdoxh1HZX9kECxgBr0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] libsepol/cil: Copy and resolve macro calls in one pass
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 7, 2021 at 1:37 PM James Carter <jwcart2@gmail.com> wrote:
>
> Lorenzo Ceragioli <lorenzo.ceragioli@phd.unipi.it> noted that the
> following policy:
>   (type a)
>   (block A
>     (macro m ((type x))
>       (type a)
>       (allow x x (file (read))))
>   )
>   (block B
>     (call A.m(a))
>   )
> results in the allow rule (allow B.a B.a (file(read))). This makes
> no sense because the "a" being passed as an argument has to be the
> global "a" and not the "a" defined in the macro.
>
> This behavior occurs because the call arguments are resolved AFTER
> the macro body has been copied and the declaration of "a" in the
> macro has been added to block B's namespace, so this is the "a"
> that the call argument resolves to, rather than the one in the
> global namespace.
>
> It turns out that calls can be copied and resolved in one pass.
>

It turns out that you can't.
If an optional is disabled, then the call arguments need to be
re-resolved because one might have resolved to a declaration in the
optional that was just disabled.

JIm

> Resolve the call arguments first and then copy the macro rules
> all in one pass.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 620 +++++++++++++++--------------
>  1 file changed, 312 insertions(+), 308 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index bbe86e22..740a9b5e 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -2840,338 +2840,300 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_call1(struct cil_tree_node *current, void *extra_args)
> +static int cil_build_call_args(struct cil_tree_node *call_node, struct cil_call *call, struct cil_macro *macro, void *extra_args)
>  {
> -       struct cil_call *new_call = current->data;
>         struct cil_args_resolve *args = extra_args;
> -       struct cil_db *db = NULL;
> -       struct cil_tree_node *macro_node = NULL;
> -       struct cil_symtab_datum *macro_datum = NULL;
> +       struct cil_list_item *item;
> +       struct cil_args *arg = NULL;
> +       struct cil_tree_node *arg_node = NULL;
>         int rc = SEPOL_ERR;
>
> -       if (args != NULL) {
> -               db = args->db;
> +       if (macro->params == NULL) {
> +               if (call->args_tree == NULL) {
> +                       return SEPOL_OK;
> +               } else {
> +                       cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
> +                       return SEPOL_ERR;;
> +               }
>         }
> -
> -       rc = cil_resolve_name(current, new_call->macro_str, CIL_SYM_BLOCKS, extra_args, &macro_datum);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> +       if (call->args_tree == NULL) {
> +               cil_tree_log(call_node, CIL_ERR, "Missing arguments");
> +               return SEPOL_ERR;
>         }
>
> -       macro_node = NODE(macro_datum);
> +       arg_node = call->args_tree->root->cl_head;
>
> -       if (macro_node->flavor != CIL_MACRO) {
> -               cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", new_call->macro_str);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -       new_call->macro = (struct cil_macro*)macro_datum;
> +       cil_list_init(&call->args, CIL_LIST_ITEM);
>
> -       if (new_call->macro->params != NULL ) {
> -
> -               struct cil_list_item *item;
> -               struct cil_args *new_arg = NULL;
> -               struct cil_tree_node *pc = NULL;
> +       cil_list_for_each(item, macro->params) {
> +               enum cil_flavor flavor = ((struct cil_param*)item->data)->flavor;
>
> -               if (new_call->args_tree == NULL) {
> -                       cil_tree_log(current, CIL_ERR, "Missing arguments");
> +               if (arg_node == NULL) {
> +                       cil_tree_log(call_node, CIL_ERR, "Missing arguments");
> +                       rc = SEPOL_ERR;
> +                       goto exit;
> +               }
> +               if (item->flavor != CIL_PARAM) {
>                         rc = SEPOL_ERR;
>                         goto exit;
>                 }
>
> -               pc = new_call->args_tree->root->cl_head;
> -
> -               cil_list_init(&new_call->args, CIL_LIST_ITEM);
> -
> -               cil_list_for_each(item, new_call->macro->params) {
> -                       enum cil_flavor flavor = ((struct cil_param*)item->data)->flavor;
> +               cil_args_init(&arg);
>
> -                       if (pc == NULL) {
> -                               cil_tree_log(current, CIL_ERR, "Missing arguments");
> +               switch (flavor) {
> +               case CIL_NAME: {
> +                       struct cil_name *name;
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
>                                 rc = SEPOL_ERR;
>                                 goto exit;
>                         }
> -                       if (item->flavor != CIL_PARAM) {
> +                       name = __cil_insert_name(args->db, arg_node->data, call_node);
> +                       if (name != NULL) {
> +                               arg->arg = (struct cil_symtab_datum *)name;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
> +                       }
> +               }
> +                       break;
> +               case CIL_TYPE:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
>                                 rc = SEPOL_ERR;
>                                 goto exit;
>                         }
> -
> -                       cil_args_init(&new_arg);
> -
> -                       switch (flavor) {
> -                       case CIL_NAME: {
> -                               struct cil_name *name;
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               name = __cil_insert_name(args->db, pc->data, current);
> -                               if (name != NULL) {
> -                                       new_arg->arg = (struct cil_symtab_datum *)name;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
> -                               }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_ROLE:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
>                         }
> -                               break;
> -                       case CIL_TYPE:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_ROLE:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_USER:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_SENS:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_CAT:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_BOOL:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_CATSET: {
> -                               if (pc->cl_head != NULL) {
> -                                       struct cil_catset *catset = NULL;
> -                                       struct cil_tree_node *cat_node = NULL;
> -                                       cil_catset_init(&catset);
> -                                       rc = cil_fill_cats(pc, &catset->cats);
> -                                       if (rc != SEPOL_OK) {
> -                                               cil_destroy_catset(catset);
> -                                               cil_destroy_args(new_arg);
> -                                               goto exit;
> -                                       }
> -                                       cil_tree_node_init(&cat_node);
> -                                       cat_node->flavor = CIL_CATSET;
> -                                       cat_node->data = catset;
> -                                       cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
> -                                                                       CIL_LIST_ITEM, cat_node);
> -                                       new_arg->arg = (struct cil_symtab_datum*)catset;
> -                               } else if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_USER:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_SENS:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_CAT:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_BOOL:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_CATSET: {
> +                       if (arg_node->cl_head != NULL) {
> +                               struct cil_catset *catset = NULL;
> +                               struct cil_tree_node *cat_node = NULL;
> +                               cil_catset_init(&catset);
> +                               rc = cil_fill_cats(arg_node, &catset->cats);
> +                               if (rc != SEPOL_OK) {
> +                                       cil_destroy_catset(catset);
> +                                       cil_destroy_args(arg);
>                                         goto exit;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
>                                 }
> -
> -                               break;
> +                               cil_tree_node_init(&cat_node);
> +                               cat_node->flavor = CIL_CATSET;
> +                               cat_node->data = catset;
> +                               cil_list_append(((struct cil_symtab_datum*)catset)->nodes,
> +                                                               CIL_LIST_ITEM, cat_node);
> +                               arg->arg = (struct cil_symtab_datum*)catset;
> +                       } else if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
>                         }
> -                       case CIL_LEVEL: {
> -                               if (pc->cl_head != NULL) {
> -                                       struct cil_level *level = NULL;
> -                                       struct cil_tree_node *lvl_node = NULL;
> -                                       cil_level_init(&level);
> -
> -                                       rc = cil_fill_level(pc->cl_head, level);
> -                                       if (rc != SEPOL_OK) {
> -                                               cil_log(CIL_ERR, "Failed to create anonymous level, rc: %d\n", rc);
> -                                               cil_destroy_level(level);
> -                                               cil_destroy_args(new_arg);
> -                                               goto exit;
> -                                       }
> -                                       cil_tree_node_init(&lvl_node);
> -                                       lvl_node->flavor = CIL_LEVEL;
> -                                       lvl_node->data = level;
> -                                       cil_list_append(((struct cil_symtab_datum*)level)->nodes,
> -                                                                       CIL_LIST_ITEM, lvl_node);
> -                                       new_arg->arg = (struct cil_symtab_datum*)level;
> -                               } else if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> +
> +                       break;
> +               }
> +               case CIL_LEVEL: {
> +                       if (arg_node->cl_head != NULL) {
> +                               struct cil_level *level = NULL;
> +                               struct cil_tree_node *lvl_node = NULL;
> +                               cil_level_init(&level);
> +
> +                               rc = cil_fill_level(arg_node->cl_head, level);
> +                               if (rc != SEPOL_OK) {
> +                                       cil_log(CIL_ERR, "Failed to create anonymous level, rc: %d\n", rc);
> +                                       cil_destroy_level(level);
> +                                       cil_destroy_args(arg);
>                                         goto exit;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
>                                 }
> -
> -                               break;
> +                               cil_tree_node_init(&lvl_node);
> +                               lvl_node->flavor = CIL_LEVEL;
> +                               lvl_node->data = level;
> +                               cil_list_append(((struct cil_symtab_datum*)level)->nodes,
> +                                                               CIL_LIST_ITEM, lvl_node);
> +                               arg->arg = (struct cil_symtab_datum*)level;
> +                       } else if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
>                         }
> -                       case CIL_LEVELRANGE: {
> -                               if (pc->cl_head != NULL) {
> -                                       struct cil_levelrange *range = NULL;
> -                                       struct cil_tree_node *range_node = NULL;
> -                                       cil_levelrange_init(&range);
> -
> -                                       rc = cil_fill_levelrange(pc->cl_head, range);
> -                                       if (rc != SEPOL_OK) {
> -                                               cil_log(CIL_ERR, "Failed to create anonymous levelrange, rc: %d\n", rc);
> -                                               cil_destroy_levelrange(range);
> -                                               cil_destroy_args(new_arg);
> -                                               goto exit;
> -                                       }
> -                                       cil_tree_node_init(&range_node);
> -                                       range_node->flavor = CIL_LEVELRANGE;
> -                                       range_node->data = range;
> -                                       cil_list_append(((struct cil_symtab_datum*)range)->nodes,
> -                                                                       CIL_LIST_ITEM, range_node);
> -                                       new_arg->arg = (struct cil_symtab_datum*)range;
> -                               } else if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> +
> +                       break;
> +               }
> +               case CIL_LEVELRANGE: {
> +                       if (arg_node->cl_head != NULL) {
> +                               struct cil_levelrange *range = NULL;
> +                               struct cil_tree_node *range_node = NULL;
> +                               cil_levelrange_init(&range);
> +
> +                               rc = cil_fill_levelrange(arg_node->cl_head, range);
> +                               if (rc != SEPOL_OK) {
> +                                       cil_log(CIL_ERR, "Failed to create anonymous levelrange, rc: %d\n", rc);
> +                                       cil_destroy_levelrange(range);
> +                                       cil_destroy_args(arg);
>                                         goto exit;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
>                                 }
> -
> -                               break;
> +                               cil_tree_node_init(&range_node);
> +                               range_node->flavor = CIL_LEVELRANGE;
> +                               range_node->data = range;
> +                               cil_list_append(((struct cil_symtab_datum*)range)->nodes,
> +                                                               CIL_LIST_ITEM, range_node);
> +                               arg->arg = (struct cil_symtab_datum*)range;
> +                       } else if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
>                         }
> -                       case CIL_IPADDR: {
> -                               if (pc->cl_head != NULL) {
> -                                       struct cil_ipaddr *ipaddr = NULL;
> -                                       struct cil_tree_node *addr_node = NULL;
> -                                       cil_ipaddr_init(&ipaddr);
> -
> -                                       rc = cil_fill_ipaddr(pc->cl_head, ipaddr);
> -                                       if (rc != SEPOL_OK) {
> -                                               cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
> -                                               cil_destroy_ipaddr(ipaddr);
> -                                               cil_destroy_args(new_arg);
> -                                               goto exit;
> -                                       }
> -                                       cil_tree_node_init(&addr_node);
> -                                       addr_node->flavor = CIL_IPADDR;
> -                                       addr_node->data = ipaddr;
> -                                       cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
> -                                                                       CIL_LIST_ITEM, addr_node);
> -                                       new_arg->arg = (struct cil_symtab_datum*)ipaddr;
> -                               } else if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> +
> +                       break;
> +               }
> +               case CIL_IPADDR: {
> +                       if (arg_node->cl_head != NULL) {
> +                               struct cil_ipaddr *ipaddr = NULL;
> +                               struct cil_tree_node *addr_node = NULL;
> +                               cil_ipaddr_init(&ipaddr);
> +
> +                               rc = cil_fill_ipaddr(arg_node->cl_head, ipaddr);
> +                               if (rc != SEPOL_OK) {
> +                                       cil_log(CIL_ERR, "Failed to create anonymous ip address, rc: %d\n", rc);
> +                                       cil_destroy_ipaddr(ipaddr);
> +                                       cil_destroy_args(arg);
>                                         goto exit;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
>                                 }
> +                               cil_tree_node_init(&addr_node);
> +                               addr_node->flavor = CIL_IPADDR;
> +                               addr_node->data = ipaddr;
> +                               cil_list_append(((struct cil_symtab_datum*)ipaddr)->nodes,
> +                                                               CIL_LIST_ITEM, addr_node);
> +                               arg->arg = (struct cil_symtab_datum*)ipaddr;
> +                       } else if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
> +                       }
>
> -                               break;
> +                       break;
> +               }
> +               case CIL_CLASS:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
>                         }
> -                       case CIL_CLASS:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_MAP_CLASS:
> -                               if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> -                                       goto exit;
> -                               }
> -                               new_arg->arg_str = pc->data;
> -                               break;
> -                       case CIL_CLASSPERMISSION: {
> -                               if (pc->cl_head != NULL) {
> -                                       struct cil_classpermission *cp = NULL;
> -                                       struct cil_tree_node *cp_node = NULL;
> -
> -                                       cil_classpermission_init(&cp);
> -                                       rc = cil_fill_classperms_list(pc, &cp->classperms);
> -                                       if (rc != SEPOL_OK) {
> -                                               cil_log(CIL_ERR, "Failed to create anonymous classpermission\n");
> -                                               cil_destroy_classpermission(cp);
> -                                               cil_destroy_args(new_arg);
> -                                               goto exit;
> -                                       }
> -                                       cil_tree_node_init(&cp_node);
> -                                       cp_node->flavor = CIL_CLASSPERMISSION;
> -                                       cp_node->data = cp;
> -                                       cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
> -                                       new_arg->arg = (struct cil_symtab_datum*)cp;
> -                               } else if (pc->data == NULL) {
> -                                       cil_tree_log(current, CIL_ERR, "Invalid macro parameter");
> -                                       cil_destroy_args(new_arg);
> -                                       rc = SEPOL_ERR;
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_MAP_CLASS:
> +                       if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
> +                               rc = SEPOL_ERR;
> +                               goto exit;
> +                       }
> +                       arg->arg_str = arg_node->data;
> +                       break;
> +               case CIL_CLASSPERMISSION: {
> +                       if (arg_node->cl_head != NULL) {
> +                               struct cil_classpermission *cp = NULL;
> +                               struct cil_tree_node *cp_node = NULL;
> +
> +                               cil_classpermission_init(&cp);
> +                               rc = cil_fill_classperms_list(arg_node, &cp->classperms);
> +                               if (rc != SEPOL_OK) {
> +                                       cil_log(CIL_ERR, "Failed to create anonymous classpermission\n");
> +                                       cil_destroy_classpermission(cp);
> +                                       cil_destroy_args(arg);
>                                         goto exit;
> -                               } else {
> -                                       new_arg->arg_str = pc->data;
>                                 }
> -                               break;
> -                       }
> -                       default:
> -                               cil_log(CIL_ERR, "Unexpected flavor: %d\n",
> -                                               (((struct cil_param*)item->data)->flavor));
> -                               cil_destroy_args(new_arg);
> +                               cil_tree_node_init(&cp_node);
> +                               cp_node->flavor = CIL_CLASSPERMISSION;
> +                               cp_node->data = cp;
> +                               cil_list_append(cp->datum.nodes, CIL_LIST_ITEM, cp_node);
> +                               arg->arg = (struct cil_symtab_datum*)cp;
> +                       } else if (arg_node->data == NULL) {
> +                               cil_tree_log(call_node, CIL_ERR, "Invalid macro parameter");
> +                               cil_destroy_args(arg);
>                                 rc = SEPOL_ERR;
>                                 goto exit;
> +                       } else {
> +                               arg->arg_str = arg_node->data;
>                         }
> -                       new_arg->param_str = ((struct cil_param*)item->data)->str;
> -                       new_arg->flavor = flavor;
> -
> -                       cil_list_append(new_call->args, CIL_ARGS, new_arg);
> -
> -                       pc = pc->next;
> +                       break;
>                 }
> -
> -               if (pc != NULL) {
> -                       cil_tree_log(current, CIL_ERR, "Unexpected arguments");
> +               default:
> +                       cil_log(CIL_ERR, "Unexpected flavor: %d\n",
> +                                       (((struct cil_param*)item->data)->flavor));
> +                       cil_destroy_args(arg);
>                         rc = SEPOL_ERR;
>                         goto exit;
>                 }
> -       } else if (new_call->args_tree != NULL) {
> -               cil_tree_log(current, CIL_ERR, "Unexpected arguments");
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> +               arg->param_str = ((struct cil_param*)item->data)->str;
> +               arg->flavor = flavor;
>
> -       if (new_call->copied == 0) {
> -               new_call->copied = 1;
> +               cil_list_append(call->args, CIL_ARGS, arg);
>
> -               rc = cil_check_recursive_call(current, macro_node);
> -               if (rc != SEPOL_OK) {
> -                       goto exit;
> -               }
> +               arg_node = arg_node->next;
> +       }
>
> -               rc = cil_copy_ast(db, macro_node, current);
> -               if (rc != SEPOL_OK) {
> -                       cil_log(CIL_ERR, "Failed to copy macro, rc: %d\n", rc);
> -                       goto exit;
> -               }
> +       if (arg_node != NULL) {
> +               cil_tree_log(call_node, CIL_ERR, "Unexpected arguments");
> +               rc = SEPOL_ERR;
> +               goto exit;
>         }
>
>         return SEPOL_OK;
> @@ -3180,19 +3142,17 @@ exit:
>         return rc;
>  }
>
> -int cil_resolve_call2(struct cil_tree_node *current, void *extra_args)
> +static int cil_resolve_call_args(struct cil_tree_node *call_node, struct cil_call *call, void *extra_args)
>  {
> -       struct cil_call *new_call = current->data;
> -       int rc = SEPOL_ERR;
> -       enum cil_sym_index sym_index = CIL_SYM_UNKNOWN;
>         struct cil_list_item *item;
> +       enum cil_sym_index sym_index = CIL_SYM_UNKNOWN;
> +       int rc = SEPOL_ERR;
>
> -       if (new_call->args == NULL) {
> -               rc = SEPOL_OK;
> -               goto exit;
> +       if (call->args == NULL) {
> +               return SEPOL_OK;
>         }
>
> -       cil_list_for_each(item, new_call->args) {
> +       cil_list_for_each(item, call->args) {
>                 struct cil_args *arg = item->data;
>                 if (arg->arg == NULL && arg->arg_str == NULL) {
>                         cil_log(CIL_ERR, "Arguments not created correctly\n");
> @@ -3275,9 +3235,9 @@ int cil_resolve_call2(struct cil_tree_node *current, void *extra_args)
>                 }
>
>                 if (sym_index != CIL_SYM_UNKNOWN) {
> -                       rc = cil_resolve_name(current, arg->arg_str, sym_index, extra_args, &(arg->arg));
> +                       rc = cil_resolve_name(call_node, arg->arg_str, sym_index, extra_args, &(arg->arg));
>                         if (rc != SEPOL_OK) {
> -                               cil_tree_log(current, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
> +                               cil_tree_log(call_node, CIL_ERR, "Failed to resolve %s in call argument list", arg->arg_str);
>                                 goto exit;
>                         }
>                 }
> @@ -3289,6 +3249,61 @@ exit:
>         return rc;
>  }
>
> +int cil_resolve_call(struct cil_tree_node *current, void *extra_args)
> +{
> +       struct cil_call *call = current->data;
> +       struct cil_args_resolve *args = extra_args;
> +       struct cil_tree_node *macro_node = NULL;
> +       struct cil_symtab_datum *macro_datum = NULL;
> +       int rc = SEPOL_ERR;
> +
> +       if (call->copied) {
> +               return SEPOL_OK;
> +       }
> +
> +       rc = cil_resolve_name(current, call->macro_str, CIL_SYM_BLOCKS, extra_args, &macro_datum);
> +       if (rc != SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       macro_node = NODE(macro_datum);
> +
> +       if (macro_node->flavor != CIL_MACRO) {
> +               cil_tree_log(current, CIL_ERR, "Failed to resolve %s to a macro", call->macro_str);
> +               rc = SEPOL_ERR;
> +               goto exit;
> +       }
> +       call->macro = (struct cil_macro*)macro_datum;
> +
> +       rc = cil_build_call_args(current, call, call->macro, extra_args);
> +       if (rc != SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       rc = cil_resolve_call_args(current, call, extra_args);
> +       if (rc != SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       call->copied = 1;
> +
> +       rc = cil_check_recursive_call(current, macro_node);
> +       if (rc != SEPOL_OK) {
> +               goto exit;
> +       }
> +
> +       rc = cil_copy_ast(args->db, macro_node, current);
> +       if (rc != SEPOL_OK) {
> +               cil_log(CIL_ERR, "Failed to copy macro, rc: %d\n", rc);
> +               goto exit;
> +       }
> +
> +       return SEPOL_OK;
> +
> +exit:
> +       return rc;
> +}
> +
>  int cil_resolve_name_call_args(struct cil_call *call, char *name, enum cil_sym_index sym_index, struct cil_symtab_datum **datum)
>  {
>         struct cil_list_item *item;
> @@ -3604,18 +3619,8 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
>                 }
>                 break;
>         case CIL_PASS_MACRO:
> -               if (node->flavor == CIL_CALL && args->macro != NULL) {
> -                       rc = cil_resolve_call1(node, args);
> -               }
> -               break;
> -       case CIL_PASS_CALL1:
> -               if (node->flavor == CIL_CALL) {
> -                       rc = cil_resolve_call1(node, args);
> -               }
> -               break;
> -       case CIL_PASS_CALL2:
> -               if (node->flavor == CIL_CALL) {
> -                       rc = cil_resolve_call2(node, args);
> +               if (node->flavor == CIL_CALL && args->macro == NULL) {
> +                       rc = cil_resolve_call(node, args);
>                 }
>                 break;
>         case CIL_PASS_ALIAS1:
> @@ -4188,7 +4193,6 @@ exit:
>  static int __cil_resolve_name_with_root(struct cil_db *db, char *name, enum cil_sym_index sym_index, struct cil_symtab_datum **datum)
>  {
>         symtab_t *symtab = &((struct cil_root *)db->ast->root->data)->symtab[sym_index];
> -
>         return cil_symtab_get_datum(symtab, name, datum);
>  }
>
> --
> 2.26.3
>
