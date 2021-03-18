Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA5C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF2664EBD
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 22:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhCRWL6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 18:11:58 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:38024 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhCRWLl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 18:11:41 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BC541560618
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 23:11:39 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id u19so2348555pgh.10
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 15:11:39 -0700 (PDT)
X-Gm-Message-State: AOAM531GpFLJUV8Jt8iaR1JLBaY2dWLp5qz+8oL2fUJYuXWpkyhQxoFX
        vJx1lzvKfSazLgkzc4hAiNjUMkJRbUVqwQFa384=
X-Google-Smtp-Source: ABdhPJwR3L03hYHsBAsBjEU6UwQQCeUjCHUbQJa18wneU5tEaMMijijDozdhUZT6vNsFw9dkmA8bxBn2mhnKUIYDqe8=
X-Received: by 2002:a63:c84a:: with SMTP id l10mr8673304pgi.159.1616105498339;
 Thu, 18 Mar 2021 15:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210318190826.151168-1-jwcart2@gmail.com>
In-Reply-To: <20210318190826.151168-1-jwcart2@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 18 Mar 2021 23:11:27 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nrByi0wG-j9Z3GkDnJKKFOO5VEPG1LTUx0tkV6oJ8juw@mail.gmail.com>
Message-ID: <CAJfZ7=nrByi0wG-j9Z3GkDnJKKFOO5VEPG1LTUx0tkV6oJ8juw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Exit with an error if declaration name is a
 reserved word
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Mar 18 23:11:40 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 8:09 PM James Carter <jwcart2@gmail.com> wrote:
>
> When CIL evaluates sets, conditional expressions, or constraint
> expressions, bad things can happen if an identifier has a name that
> is the same as an operator. CIL will interpret the name as an
> identifier in some places and as an operator in others.
>
> Example:
>   (classmap CM1 (and pm1 pm2))
>   (classmapping CM1 and (C1 (P1a)))
>   (classmapping CM1 pm1 (C1 (P1b)))
>   (classmapping CM1 pm2 (C1 (P1c)))
>   (allow TYPE self (CM1 (and pm1 pm2)))
> In the classmap and classmapping statements, "and" is the name of an
> identifier, but in the allow rule, "and" is an expression operator.
> The result is a segfault.
>
> When an identifier is declared and it is being validated, check if
> it has the same name as a reserved word for an expression operator
> that can be used with the identifer's flavor and exit with an error
> if it does.
>
> Also, change the name of the function __cil_verify_name() to
> cil_verify_name(), since this function is neither static nor a
> helper function.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Hello,
I like this patch, but it makes "make test" fail:

make[1]: Entering directory '/selinux/secilc'
./secilc test/policy.cil
Name t1 is a reserved word
Invalid name
Bad type declaration at test/policy.cil:341
Failed to compile cildb: -1

I guess the test policy needs to be updated in order to no longer use
types t1 and t2 (in
https://github.com/SELinuxProject/selinux/blob/d155b410d4bbc90d28f361b966f0429598da8188/secilc/test/policy.cil#L341-L354).

Nicolas

> ---
>  libsepol/cil/src/cil_build_ast.c | 28 ++--------------
>  libsepol/cil/src/cil_verify.c    | 56 +++++++++++++++++++++++++++++++-
>  libsepol/cil/src/cil_verify.h    |  2 +-
>  3 files changed, 58 insertions(+), 28 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 4e53f06a..e57de662 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -114,7 +114,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
>         symtab_t *symtab = NULL;
>         struct cil_symtab_datum *prev;
>
> -       rc = __cil_verify_name((const char*)key);
> +       rc = cil_verify_name((const char*)key, nflavor);
>         if (rc != SEPOL_OK) {
>                 goto exit;
>         }
> @@ -1953,12 +1953,6 @@ int cil_gen_roleattribute(struct cil_db *db, struct cil_tree_node *parse_current
>                 goto exit;
>         }
>
> -       if (parse_current->next->data == CIL_KEY_SELF) {
> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         cil_roleattribute_init(&attr);
>
>         key = parse_current->next->data;
> @@ -2337,12 +2331,6 @@ int cil_gen_type(struct cil_db *db, struct cil_tree_node *parse_current, struct
>                 goto exit;
>         }
>
> -       if (parse_current->next->data == CIL_KEY_SELF) {
> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         cil_type_init(&type);
>
>         key = parse_current->next->data;
> @@ -2391,12 +2379,6 @@ int cil_gen_typeattribute(struct cil_db *db, struct cil_tree_node *parse_current
>                 goto exit;
>         }
>
> -       if (parse_current->next->data == CIL_KEY_SELF) {
> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         cil_typeattribute_init(&attr);
>
>         key = parse_current->next->data;
> @@ -3048,12 +3030,6 @@ int cil_gen_alias(struct cil_db *db, struct cil_tree_node *parse_current, struct
>                 goto exit;
>         }
>
> -       if (flavor == CIL_TYPEALIAS && parse_current->next->data == CIL_KEY_SELF) {
> -               cil_log(CIL_ERR, "The keyword '%s' is reserved\n", CIL_KEY_SELF);
> -               rc = SEPOL_ERR;
> -               goto exit;
> -       }
> -
>         cil_alias_init(&alias);
>
>         key = parse_current->next->data;
> @@ -5278,7 +5254,7 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
>
>                 param->str =  current_item->cl_head->next->data;
>
> -               rc = __cil_verify_name(param->str);
> +               rc = cil_verify_name(param->str, param->flavor);
>                 if (rc != SEPOL_OK) {
>                         cil_destroy_param(param);
>                         goto exit;
> diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
> index 09e3daf9..c2efbf1c 100644
> --- a/libsepol/cil/src/cil_verify.c
> +++ b/libsepol/cil/src/cil_verify.c
> @@ -47,7 +47,55 @@
>
>  #include "cil_verify.h"
>
> -int __cil_verify_name(const char *name)
> +static int __cil_is_reserved_name(const char *name, enum cil_flavor flavor)
> +{
> +       switch (flavor) {
> +       case CIL_BOOL:
> +       case CIL_TUNABLE:
> +               if ((name == CIL_KEY_EQ) || (name == CIL_KEY_NEQ))
> +                       return CIL_TRUE;
> +               break;
> +       case CIL_PERM:
> +       case CIL_MAP_PERM:
> +               if (name == CIL_KEY_ALL)
> +                       return CIL_TRUE;
> +               break;
> +       case CIL_USER:
> +       case CIL_USERATTRIBUTE:
> +               if ((name == CIL_KEY_ALL) || (name == CIL_KEY_CONS_U1) || (name == CIL_KEY_CONS_U2) || (name == CIL_KEY_CONS_U3))
> +                       return CIL_TRUE;
> +               break;
> +       case CIL_ROLE:
> +       case CIL_ROLEATTRIBUTE:
> +               if ((name == CIL_KEY_ALL) || (name == CIL_KEY_CONS_R1) || (name == CIL_KEY_CONS_R2) || (name == CIL_KEY_CONS_R3))
> +                       return CIL_TRUE;
> +               break;
> +       case CIL_TYPE:
> +       case CIL_TYPEATTRIBUTE:
> +       case CIL_TYPEALIAS:
> +               if ((name == CIL_KEY_ALL) || (name == CIL_KEY_SELF) || (name == CIL_KEY_CONS_T1) || (name == CIL_KEY_CONS_T2) || (name == CIL_KEY_CONS_T3))
> +                       return CIL_TRUE;
> +               break;
> +       case CIL_CAT:
> +       case CIL_CATSET:
> +       case CIL_CATALIAS:
> +       case CIL_PERMISSIONX:
> +               if ((name == CIL_KEY_ALL) || (name == CIL_KEY_RANGE))
> +                       return CIL_TRUE;
> +               break;
> +       default:
> +               return CIL_FALSE;
> +               break;
> +       }
> +
> +       if ((name == CIL_KEY_AND) || (name == CIL_KEY_OR) || (name == CIL_KEY_NOT) || (name == CIL_KEY_XOR)) {
> +               return CIL_TRUE;
> +       }
> +
> +       return CIL_FALSE;
> +}
> +
> +int cil_verify_name(const char *name, enum cil_flavor flavor)
>  {
>         int rc = SEPOL_ERR;
>         int len;
> @@ -77,6 +125,12 @@ int __cil_verify_name(const char *name)
>                         goto exit;
>                 }
>         }
> +
> +       if (__cil_is_reserved_name(name, flavor)) {
> +               cil_log(CIL_ERR, "Name %s is a reserved word\n", name);
> +               goto exit;
> +       }
> +
>         return SEPOL_OK;
>
>  exit:
> diff --git a/libsepol/cil/src/cil_verify.h b/libsepol/cil/src/cil_verify.h
> index 905761b0..1887ae3f 100644
> --- a/libsepol/cil/src/cil_verify.h
> +++ b/libsepol/cil/src/cil_verify.h
> @@ -56,7 +56,7 @@ struct cil_args_verify {
>         int *pass;
>  };
>
> -int __cil_verify_name(const char *name);
> +int cil_verify_name(const char *name, enum cil_flavor flavor);
>  int __cil_verify_syntax(struct cil_tree_node *parse_current, enum cil_syntax s[], int len);
>  int cil_verify_expr_syntax(struct cil_tree_node *current, enum cil_flavor op, enum cil_flavor expr_flavor);
>  int cil_verify_constraint_leaf_expr_syntax(enum cil_flavor l_flavor, enum cil_flavor r_flavor, enum cil_flavor op, enum cil_flavor expr_flavor);
> --
> 2.26.2
>

