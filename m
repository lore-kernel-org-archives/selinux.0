Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501CC433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 14:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8826161433
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 14:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEMO7I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbhEMO7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 10:59:06 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B06C061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 07:57:55 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso5700016ooh.11
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekv0DgRfCiJ+GkyDYx+EDGhVesQXhtj/uo0vOYOni/g=;
        b=I1t7VyjpYn+MtmK8LseCRjAshdvR1okc25BwJ5x/Of6UPwXEOy7JuOmEyHCzAgGfr7
         FwSq+jjvcs0dbBL6ae26sj5YzeCxVlp7N8OIBe+kf8kUzPzCnaSGQqBTPH1gSrRHrMUa
         1DjWYUOYOWH1aZge/cesfdCH0VhZ/9SWX7JQJIJQ+oKzUjmR8OD3VrOBbV+98AONY1aB
         JYJAlGMwbIOS4gbzzShzzZ4710dui+fYYIBkT/wUUkbAj67URMwV0AFABHAIedCUS4Wd
         /cTgGv0FOkuzPbFWWhftvqo6pyF+8IvueXJl9LYtSGuL1AWSGZ/eKVb7CkJbZnQF6VBX
         y+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekv0DgRfCiJ+GkyDYx+EDGhVesQXhtj/uo0vOYOni/g=;
        b=WGCK/inLdBikJNAJI8X+t6oryJwhzTS328PWMVR2e7jOy2jxNOQ4xhatmljSjC4SeG
         C0WWq9Hs4S4ZR22hK33wzzzkLreR8RTz7BMxexIX0/+Mk6b0kdjw73Aa/JN65Gkz83jh
         y8ebBoRSNySljxwpjUZJ1ebTHlqUYYftyBfa9W70CdnkFX5DNFTy3rZbr+B4Yu9/Wk3a
         e81q/EquWanm0B8JTvOmHYJ8nkIWUCSjOopf6tBkQwvGYe5B2artSFmccH+hzdliRJ8S
         pWoVJlhWOos5JwjzMQPQjlC3gRZh1KfZ3yoCeHMIJ2IVL5FmFHJQ3V2wVfrX4HtlLv74
         qe1w==
X-Gm-Message-State: AOAM532z8Tr67a6E7FNTaxx5UjJ3FeQq00XNmEnZpHgo48nKxB8w6MMi
        wZygzywzMgiT9KV4EeSH8HIoKP9027BHf/mXAyre/cyLYvs=
X-Google-Smtp-Source: ABdhPJxtI+6g7LP5STlsaVCTNFyxtACkSaXzV3MWDy9tARfP6i0du8KLnJsm+0hSU/EITAnknS5vv0ArsuK4GEByIn4=
X-Received: by 2002:a4a:e084:: with SMTP id w4mr2608470oos.59.1620917874650;
 Thu, 13 May 2021 07:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210504204140.100798-1-jwcart2@gmail.com>
In-Reply-To: <20210504204140.100798-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 13 May 2021 10:57:43 -0400
Message-ID: <CAP+JOzT5WJPotDu-CdQaTo74xbNbzgR1FYZJADnnv7fmmxNf2w@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Check for self-referential loops in sets
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 4, 2021 at 4:41 PM James Carter <jwcart2@gmail.com> wrote:
>
> The secilc-fuzzer found a self-referential loop using category sets.
> Any set declaration in CIL that allows sets in it is susceptible to
> the creation of a self-referential loop. There is a check, but only
> for the name of the set being declared being used in the set
> declaration.
>
> Check for self-refential loops in user, role, and type attributes
> and in category sets. Since all of the sets need to be declared,
> this check has to be done when verifying the CIL db before doing
> the post phase.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---

This has been merged.
JIm

> v2: Make cil_verify_no_self_reference() static
>
>  libsepol/cil/src/cil_resolve_ast.c | 31 +---------
>  libsepol/cil/src/cil_verify.c      | 97 +++++++++++++++++++++---------
>  libsepol/cil/src/cil_verify.h      |  1 -
>  3 files changed, 71 insertions(+), 58 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index f251ed15..5368ae80 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -438,11 +438,6 @@ int cil_resolve_typeattributeset(struct cil_tree_node *current, void *extra_args
>                 goto exit;
>         }
>
> -       rc = cil_verify_no_self_reference(attr_datum, attrtypes->datum_expr);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         if (attr->expr_list == NULL) {
>                 cil_list_init(&attr->expr_list, CIL_TYPEATTRIBUTE);
>         }
> @@ -1151,11 +1146,6 @@ int cil_resolve_roleattributeset(struct cil_tree_node *current, void *extra_args
>                 goto exit;
>         }
>
> -       rc = cil_verify_no_self_reference(attr_datum, attrroles->datum_expr);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         if (attr->expr_list == NULL) {
>                 cil_list_init(&attr->expr_list, CIL_ROLEATTRIBUTE);
>         }
> @@ -1666,21 +1656,7 @@ exit:
>
>  int cil_resolve_catset(struct cil_tree_node *current, struct cil_catset *catset, void *extra_args)
>  {
> -       int rc = SEPOL_ERR;
> -
> -       rc = cil_resolve_cats(current, catset->cats, extra_args);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
> -       rc = cil_verify_no_self_reference((struct cil_symtab_datum *)catset, catset->cats->datum_expr);
> -       if (rc != SEPOL_OK) {
> -               cil_list_destroy(&catset->cats->datum_expr, CIL_FALSE);
> -               goto exit;
> -       }
> -
> -exit:
> -       return rc;
> +       return cil_resolve_cats(current, catset->cats, extra_args);
>  }
>
>  int cil_resolve_senscat(struct cil_tree_node *current, void *extra_args)
> @@ -3545,11 +3521,6 @@ int cil_resolve_userattributeset(struct cil_tree_node *current, void *extra_args
>                 goto exit;
>         }
>
> -       rc = cil_verify_no_self_reference(attr_datum, attrusers->datum_expr);
> -       if (rc != SEPOL_OK) {
> -               goto exit;
> -       }
> -
>         if (attr->expr_list == NULL) {
>                 cil_list_init(&attr->expr_list, CIL_USERATTRIBUTE);
>         }
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 5a37dd2f..8e15a0e6 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -430,28 +430,71 @@ int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, str
>         return SEPOL_OK;
>  }
>
> -int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list)
> +static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig);
> +
> +static int __verify_no_self_reference_in_expr(struct cil_list *expr, struct cil_symtab_datum *orig)
>  {
> -       struct cil_list_item *i;
> +       struct cil_list_item *item;
> +       int rc = SEPOL_OK;
>
> -       cil_list_for_each(i, datum_list) {
> -               if (i->flavor == CIL_DATUM) {
> -                       struct cil_symtab_datum *d = i->data;
> -                       if (d == datum) {
> -                               cil_log(CIL_ERR,"Self-reference found for %s\n",datum->name);
> -                               return SEPOL_ERR;
> -                       }
> -               } else if (i->flavor == CIL_LIST) {
> -                       int rc = cil_verify_no_self_reference(datum, i->data);
> -                       if (rc != SEPOL_OK) {
> -                               return SEPOL_ERR;
> -                       }
> +       if (!expr) {
> +               return SEPOL_OK;
> +       }
> +
> +       cil_list_for_each(item, expr) {
> +               if (item->flavor == CIL_DATUM) {
> +                       struct cil_symtab_datum* datum = item->data;
> +                       rc = cil_verify_no_self_reference(FLAVOR(datum), datum, orig);
> +               } else if (item->flavor == CIL_LIST) {
> +                       rc = __verify_no_self_reference_in_expr(item->data, orig);
> +               }
> +               if (rc != SEPOL_OK) {
> +                       return SEPOL_ERR;
>                 }
>         }
>
>         return SEPOL_OK;
>  }
>
> +static int cil_verify_no_self_reference(enum cil_flavor flavor, struct cil_symtab_datum *datum, struct cil_symtab_datum *orig)
> +{
> +       int rc = SEPOL_OK;
> +
> +       if (datum == orig) {
> +               cil_tree_log(NODE(orig), CIL_ERR, "Self-reference found for %s", orig->name);
> +               return SEPOL_ERR;
> +       } else if (orig == NULL) {
> +               orig = datum;
> +       }
> +
> +       switch (flavor) {
> +       case CIL_USERATTRIBUTE: {
> +               struct cil_userattribute *attr = (struct cil_userattribute *)datum;
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               break;
> +       }
> +       case CIL_ROLEATTRIBUTE: {
> +               struct cil_roleattribute *attr = (struct cil_roleattribute *)datum;
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               break;
> +       }
> +       case CIL_TYPEATTRIBUTE: {
> +               struct cil_typeattribute *attr = (struct cil_typeattribute *)datum;
> +               rc = __verify_no_self_reference_in_expr(attr->expr_list, orig);
> +               break;
> +       }
> +       case CIL_CATSET: {
> +               struct cil_catset *set = (struct cil_catset *)datum;
> +               rc = __verify_no_self_reference_in_expr(set->cats->datum_expr, orig);
> +               break;
> +       }
> +       default:
> +               break;
> +       }
> +
> +       return rc;
> +}
> +
>  int __cil_verify_ranges(struct cil_list *list)
>  {
>         int rc = SEPOL_ERR;
> @@ -1757,27 +1800,22 @@ static int __cil_verify_map_class(struct cil_tree_node *node)
>
>  int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __attribute__((unused)) void *extra_args)
>  {
> -       int rc = SEPOL_ERR;
> +       int rc = SEPOL_OK;
>
> -       if (node->flavor == CIL_MACRO) {
> +       switch (node->flavor) {
> +       case CIL_MACRO: {
>                 *finished = CIL_TREE_SKIP_HEAD;
> -               rc = SEPOL_OK;
> -               goto exit;
> -       } else if (node->flavor == CIL_BLOCK) {
> +               break;
> +       }
> +       case CIL_BLOCK: {
>                 struct cil_block *blk = node->data;
>                 if (blk->is_abstract == CIL_TRUE) {
>                         *finished = CIL_TREE_SKIP_HEAD;
>                 }
> -               rc = SEPOL_OK;
> -               goto exit;
> +               break;
>         }
> -
> -       switch (node->flavor) {
>         case CIL_USER:
>                 rc = __cil_verify_user_pre_eval(node);
> -               if (rc != SEPOL_OK) {
> -                       goto exit;
> -               }
>                 break;
>         case CIL_MAP_CLASS:
>                 rc = __cil_verify_map_class(node);
> @@ -1785,11 +1823,16 @@ int __cil_pre_verify_helper(struct cil_tree_node *node, uint32_t *finished, __at
>         case CIL_CLASSPERMISSION:
>                 rc = __cil_verify_classpermission(node);
>                 break;
> +       case CIL_USERATTRIBUTE:
> +       case CIL_ROLEATTRIBUTE:
> +       case CIL_TYPEATTRIBUTE:
> +       case CIL_CATSET:
> +               rc = cil_verify_no_self_reference(node->flavor, node->data, NULL);
> +               break;
>         default:
>                 rc = SEPOL_OK;
>                 break;
>         }
>
> -exit:
>         return rc;
>  }
> diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
> index c497018f..4ea14f5b 100644
> --- a/libsepol/cil/src/cil_verify.h
> +++ b/libsepol/cil/src/cil_verify.h
> @@ -63,7 +63,6 @@ int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_fl
>  int cil_verify_constraint_expr_syntax(struct cil_tree_node *current, enum cil_flavor op);
>  int cil_verify_conditional_blocks(struct cil_tree_node *current);
>  int cil_verify_decl_does_not_shadow_macro_parameter(struct cil_macro *macro, struct cil_tree_node *node, const char *name);
> -int cil_verify_no_self_reference(struct cil_symtab_datum *datum, struct cil_list *datum_list);
>  int __cil_verify_ranges(struct cil_list *list);
>  int __cil_verify_ordered_node_helper(struct cil_tree_node *node, uint32_t *finished, void *extra_args);
>  int __cil_verify_ordered(struct cil_tree_node *current, enum cil_flavor flavor);
> --
> 2.26.3
>
