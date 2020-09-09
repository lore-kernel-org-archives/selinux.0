Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C8C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05F72065E
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoG+ebZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgIISFq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbgIISFL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 14:05:11 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0035C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 11:05:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so3249836oif.7
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 11:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mVeeT1wwKC2d0SfkDGmNFm3xoZdFHTG+f2/5bbtx/M=;
        b=OoG+ebZ7ZrJDopaXecdjNiYBaVkfYydN6O3OGzVgMrW02Qd6H5zsPqgfGNOp+AuBG9
         tIqcR0f9awEgz1vq67umtcAB+n0IMaF72agoiMttMspnl9WeVB1qE/7iS4q0C0I41HI/
         oodnaV+UgdaexoxGWmYJE+yu+bgN1wKdP9dL0bNfbB4miJza1UY3Ba129wn6GS/Wophu
         xBTkO8MGtBkHz4H1Wmym+0Yem6MsGPNADnaaPSfdfmMPDQ34YwLMGXZ/HWgQ0z+OImAV
         kv743XxpcX+3CTYdGkMyb1rgpTN2QXJGSKX6DBJRtNMkLy6FNk0ELjYhLU1Wbnh/kwF/
         AgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mVeeT1wwKC2d0SfkDGmNFm3xoZdFHTG+f2/5bbtx/M=;
        b=ePtFH5IijGT57MihHd6Zvo5TZBfzNO+NaYHV8sxc/65jEQ6FXDWKi95bqRQHBNiy82
         WTpr2EBjnGaCFFk2iSuNt+jXnH4uvIvmT4sCf7Q/RTb6q3Lr5NDUw5YOpA+J3Sghv9cL
         GyPkbwcplFeC0xPY+eYvEaHE/I464V7L28zCKBD+MdxngJ7UZ4mJrSc7MEa/6KTyGBxY
         2gT1fOq2Su9/qEVkJoKpdP+/SBmA7+edPxYDdUnZa2WMhRUfn+fp1iUYuSPldPYvX4Iv
         g89tg+m0qjbtFoHhkP72qKOcEQnUqD78pdG3pArrXNFtNk0LCDkUIX6zulUQ4f1d4Mny
         WiRw==
X-Gm-Message-State: AOAM531CSHeGtB9Wi/qH4UwUJJSD+90zXyMUhGWWKHFcC3PNOyiIwZ2L
        bOsFTjh3NoaE3TRXl6DmmbZUgKm2azURh2Ey7QKMAguu
X-Google-Smtp-Source: ABdhPJwGEmel/+5wsVCjM8+GJsWy932Qyz+YRxReuQt1c99jAXCW8YDOLc0ppPtDz5MwXYrM6cUkaUFw3EZdh/RugKo=
X-Received: by 2002:aca:ecc4:: with SMTP id k187mr1330069oih.138.1599674703852;
 Wed, 09 Sep 2020 11:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200909163245.249011-1-jwcart2@gmail.com>
In-Reply-To: <20200909163245.249011-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Sep 2020 14:04:53 -0400
Message-ID: <CAP+JOzRGYAFH4h377gOAVUcLj4yup3_pBOneq1jAw11LTE=sQg@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol/cil: Give an error when constraint
 expressions exceed max depth
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I just realized that I copied more than just the depth checking. I am
going to keep the extra checks, but I need more error messages and a
new function name.

Jim

On Wed, Sep 9, 2020 at 12:32 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of constraint expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries with constraint expressions exceeding
> the max depth to be created.
>
> Check the depth of a constraint expression after converting it to the
> postfix form used in the binary policy and give an error when the max
> depth is exceeded.
>
> Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c    | 42 ++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.c | 20 ++++-----------
>  2 files changed, 47 insertions(+), 15 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 77266858..3131a63e 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2713,6 +2713,42 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
>         return SEPOL_OK;
>  }
>
> +int __cil_constrain_expr_check_depth(constraint_expr_t *sepol_expr)
> +{
> +       constraint_expr_t *e = sepol_expr;
> +       int depth = -1;
> +
> +       while (e) {
> +               switch (e->expr_type) {
> +               case CEXPR_NOT:
> +                       if (depth < 0)
> +                               return SEPOL_ERR;
> +                       break;
> +               case CEXPR_AND:
> +               case CEXPR_OR:
> +                       if (depth < 1)
> +                               return SEPOL_ERR;
> +                       depth--;
> +                       break;
> +               case CEXPR_ATTR:
> +                       if (depth == (CEXPR_MAXDEPTH - 1))
> +                               return SEPOL_ERR;
> +                       depth++;
> +                       break;
> +               case CEXPR_NAMES:
> +                       if (depth == (CEXPR_MAXDEPTH - 1))
> +                               return SEPOL_ERR;
> +                       depth++;
> +                       break;
> +               default:
> +                       return SEPOL_ERR;
> +               }
> +               e = e->next;
> +       }
> +
> +       return SEPOL_OK;
> +}
> +
>  int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, struct cil_symtab_datum *class, struct cil_list *perms, struct cil_list *expr)
>  {
>         int rc = SEPOL_ERR;
> @@ -2736,6 +2772,12 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
>                 goto exit;
>         }
>
> +       rc = __cil_constrain_expr_check_depth(sepol_expr);
> +       if (rc != SEPOL_OK) {
> +               cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
> +               goto exit;
> +       }
> +
>         sepol_constrain->expr = sepol_expr;
>         sepol_constrain->next = sepol_class->constraints;
>         sepol_class->constraints = sepol_constrain;
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 60ecaaff..870c6923 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -2738,7 +2738,7 @@ exit:
>         return SEPOL_ERR;
>  }
>
> -static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr, int *depth)
> +static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
>  {
>         int rc = SEPOL_ERR;
>         enum cil_flavor op;
> @@ -2750,12 +2750,6 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
>                 goto exit;
>         }
>
> -       if (*depth > CEXPR_MAXDEPTH) {
> -               cil_log(CIL_ERR, "Max depth of %d exceeded for constraint expression\n", CEXPR_MAXDEPTH);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         op = __cil_get_constraint_operator_flavor(current->data);
>
>         rc = cil_verify_constraint_expr_syntax(current, op);
> @@ -2769,14 +2763,13 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
>         case CIL_CONS_DOM:
>         case CIL_CONS_DOMBY:
>         case CIL_CONS_INCOMP:
> -               (*depth)++;
>                 rc = __cil_fill_constraint_leaf_expr(current, flavor, op, expr);
>                 if (rc != SEPOL_OK) {
>                         goto exit;
>                 }
>                 break;
>         case CIL_NOT:
> -               rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth);
> +               rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr);
>                 if (rc != SEPOL_OK) {
>                         goto exit;
>                 }
> @@ -2785,11 +2778,11 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
>                 cil_list_append(*expr, CIL_LIST, lexpr);
>                 break;
>         default:
> -               rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr, depth);
> +               rc = __cil_fill_constraint_expr(current->next->cl_head, flavor, &lexpr);
>                 if (rc != SEPOL_OK) {
>                         goto exit;
>                 }
> -               rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr, depth);
> +               rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr);
>                 if (rc != SEPOL_OK) {
>                         cil_list_destroy(&lexpr, CIL_TRUE);
>                         goto exit;
> @@ -2801,8 +2794,6 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
>                 break;
>         }
>
> -       (*depth)--;
> -
>         return SEPOL_OK;
>  exit:
>
> @@ -2812,13 +2803,12 @@ exit:
>  int cil_gen_constraint_expr(struct cil_tree_node *current, enum cil_flavor flavor, struct cil_list **expr)
>  {
>         int rc = SEPOL_ERR;
> -       int depth = 0;
>
>         if (current->cl_head == NULL) {
>                 goto exit;
>         }
>
> -       rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr, &depth);
> +       rc = __cil_fill_constraint_expr(current->cl_head, flavor, expr);
>         if (rc != SEPOL_OK) {
>                 goto exit;
>         }
> --
> 2.25.4
>
