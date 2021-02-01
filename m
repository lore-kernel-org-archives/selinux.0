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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE28DC433DB
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B4664E46
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 14:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhBAO15 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhBAO1u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:27:50 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADDEC061573
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 06:27:09 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id w124so18942856oia.6
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LkcIqSTgoQoeq40F9o8VhM+XTyEiUMxg0BsERw+uzs=;
        b=QZAYiOQhS9c5F/QtwlWWEkSPmciEn98JYNDJJU8krrZ8Mj/ksx0nmwdMxBierBWL3b
         0D4mxaeuZ+1lgfwVgL7/IKaHbOnFO4qSOahQmW2X2KgMCd7yg5wZMv6SOH9sDUXvtw5z
         biQeYnK2q9K3jbcWZGf1Rx2DoEICKIWGqqJN3VbCFVOtqfTFfx1t8NBpFXmbR+39Wx2R
         7zDXweeabYuySucgJAUGhdDPQvHh7WEX1HkzQBkz4fo3xRqeb3hxImzQNKpCep9XmH6x
         09gJYmut3hrO/y0oNmWqXmP4EJHt6FR7Ys5ARSjONEVGOFaZeJZ+LRuLmvaO4Cu9DvWT
         QAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LkcIqSTgoQoeq40F9o8VhM+XTyEiUMxg0BsERw+uzs=;
        b=mVtOQJeXcwnKvwK2RPiq8JjL3xxrGN2M3kxZK5DCKG2bO2sTzqaw/+ASN1Y6gXrPHA
         DWWNJkmbNYNCO7cUO9LiRlAFerSqoLoO3VrRZo4Ty8ZweUEYHcAzoe99qyaga/ebf2LG
         kY0SKsLJSpI3bNdgAKT44YOk1DACXSjN5QR1iznpygNJIT8MHJsypuBBoAoYT1Kw0cKy
         +sMJEaGptu8Xn1am1Fnu3ONIy7PvQDnWlhWVaGV1NJR1K/VKu24qdDAJ0mIV+V93koBq
         sQntKjW8ldl6v6IfGJAwUgcjl99Hd8XQ4q6xKWdVYaQzzsz+rrS2Umqc/nDTzbCxD97r
         hTCQ==
X-Gm-Message-State: AOAM531eczi4oJpxoxD3qnRkz2G3Og+S/nLR5GCQPRZJJxSDZU21ehLn
        59NvveBsNeQyKyfbMQk3+vp4FYp1ACmf5CSIwlNx+5Y5kZ4=
X-Google-Smtp-Source: ABdhPJzpJVXDL0MN9Iu18QXFL69lMOGwlBF5cP0E6eRja26zLP/j+29pjSupT/wzomCEFZLTUFrEJGF7jhxaSDTUfYQ=
X-Received: by 2002:aca:5681:: with SMTP id k123mr11168069oib.138.1612189629267;
 Mon, 01 Feb 2021 06:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20210131231255.58909-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210131231255.58909-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 1 Feb 2021 09:26:58 -0500
Message-ID: <CAP+JOzTXhkddEpQE4TuEFFid_Pfu-FEfHcrFiHYsTbxRxg11NA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix memory leak when a constraint
 expression is too deep
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 31, 2021 at 6:14 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> When __cil_validate_constrain_expr() fails,
> cil_constrain_to_policydb_helper() does not destroy the constraint
> expression. This leads to a memory leak reported by OSS-Fuzz with the
> following CIL policy:
>
>     (class CLASS (PERM))
>     (classorder (CLASS))
>     (sid SID)
>     (sidorder (SID))
>     (user USER)
>     (role ROLE)
>     (type TYPE)
>     (category CAT)
>     (categoryorder (CAT))
>     (sensitivity SENS)
>     (sensitivityorder (SENS))
>     (sensitivitycategory SENS (CAT))
>     (allow TYPE self (CLASS (PERM)))
>     (roletype ROLE TYPE)
>     (userrole USER ROLE)
>     (userlevel USER (SENS))
>     (userrange USER ((SENS)(SENS (CAT))))
>     (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))
>
>     (constrain
>         (CLASS (PERM))
>         (or
>             (eq t1 TYPE)
>             (or
>                 (eq t1 TYPE)
>                 (or
>                     (eq t1 TYPE)
>                     (or
>                         (eq t1 TYPE)
>                         (or
>                             (eq t1 TYPE)
>                             (eq t1 TYPE)
>                         )
>                     )
>                 )
>             )
>         )
>     )
>
> Add constraint_expr_destroy(sepol_expr) to destroy the expression.
>
> Moreover constraint_expr_destroy() was not freeing all items of an
> expression. Code in libsepol/src and checkpolicy contained while loop to
> free all the items of a constraint expression, but not the one in
> libsepol/cil. As freeing only the first item of an expression is
> misleading, change the semantic of constraint_expr_destroy() to iterate
> the list of constraint_expr_t and to free all items.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28938
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Looks good.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c   |  7 +------
>  libsepol/cil/src/cil_binary.c |  1 +
>  libsepol/src/constraint.c     |  6 +++++-
>  libsepol/src/policydb.c       | 15 ++-------------
>  4 files changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index bf6c3e68bef3..c9286f7733c5 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3479,12 +3479,7 @@ static constraint_expr_t *constraint_expr_clone(constraint_expr_t * expr)
>
>         return h;
>        oom:
> -       e = h;
> -       while (e) {
> -               l = e;
> -               e = e->next;
> -               constraint_expr_destroy(l);
> -       }
> +       constraint_expr_destroy(h);
>         return NULL;
>  }
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 3b01ade146c5..7ba2098b61ea 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2841,6 +2841,7 @@ int cil_constrain_to_policydb_helper(policydb_t *pdb, const struct cil_db *db, s
>         return SEPOL_OK;
>
>  exit:
> +       constraint_expr_destroy(sepol_expr);
>         free(sepol_constrain);
>         return rc;
>  }
> diff --git a/libsepol/src/constraint.c b/libsepol/src/constraint.c
> index 71540195d633..58eb6da7940f 100644
> --- a/libsepol/src/constraint.c
> +++ b/libsepol/src/constraint.c
> @@ -38,10 +38,14 @@ int constraint_expr_init(constraint_expr_t * expr)
>
>  void constraint_expr_destroy(constraint_expr_t * expr)
>  {
> -       if (expr != NULL) {
> +       constraint_expr_t *next;
> +
> +       while (expr != NULL) {
> +               next = expr->next;
>                 ebitmap_destroy(&expr->names);
>                 type_set_destroy(expr->type_names);
>                 free(expr->type_names);
>                 free(expr);
> +               expr = next;
>         }
>  }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 71ada42ca609..f45d28c764ba 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1359,7 +1359,6 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>  {
>         class_datum_t *cladatum;
>         constraint_node_t *constraint, *ctemp;
> -       constraint_expr_t *e, *etmp;
>
>         if (key)
>                 free(key);
> @@ -1371,12 +1370,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>         hashtab_destroy(cladatum->permissions.table);
>         constraint = cladatum->constraints;
>         while (constraint) {
> -               e = constraint->expr;
> -               while (e) {
> -                       etmp = e;
> -                       e = e->next;
> -                       constraint_expr_destroy(etmp);
> -               }
> +               constraint_expr_destroy(constraint->expr);
>                 ctemp = constraint;
>                 constraint = constraint->next;
>                 free(ctemp);
> @@ -1384,12 +1378,7 @@ static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
>
>         constraint = cladatum->validatetrans;
>         while (constraint) {
> -               e = constraint->expr;
> -               while (e) {
> -                       etmp = e;
> -                       e = e->next;
> -                       constraint_expr_destroy(etmp);
> -               }
> +               constraint_expr_destroy(constraint->expr);
>                 ctemp = constraint;
>                 constraint = constraint->next;
>                 free(ctemp);
> --
> 2.30.0
>
