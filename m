Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380DBC433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiCKQEy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350116AbiCKQEx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:04:53 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061101D0341
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:03:49 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso10977784ooj.5
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0/jINk0TT7uvhce6r3jpzHNxL7c4MJ/sQZKxtilpRo=;
        b=cjgCunaiuN3ORyM55kP1IoegWux53p6NBlV3QX26FjOqCZnHWwy1pyVNyUGguPvUcp
         olSFqXZa5jYxIMuJg8DDp7FSbdXsfvw3EHq2j+siiwTf8rOxf4MD9BhBRqJmqbi2glDy
         /xRFxz6YUKX55mOxpa5ie+WGZH0D8kKSTUCZPypm81nA6hZ0VfFy/n6kOYnFCTjGnhYU
         iizDdbVsaDCneuYRTP0kxMWWwJfFnxp1U8Eg/iaeCya5hgYsk8Kwp/8dEBEuT0YYoyHB
         YuWPeo62txYxfABi/IqE1EgJr6L4Bz3mF58TkiyZv0JtZVshZlONB4HqS1dQm0dKuqBb
         xZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0/jINk0TT7uvhce6r3jpzHNxL7c4MJ/sQZKxtilpRo=;
        b=5nw3lWFu6HVbHRpU8dwuE7gbngevmAjk1xCKZC3yEY7hHI8m2Es9WMT7bXNhyN+/Yu
         l81hXk7Gk9/E9CiqlUYvy9TcFGhxdCBuXNg+ra8IX4hAXdlG0vNHAhmjul66PQhsFdMK
         uuWJEsIQP87uBpVdbqAS4m6X1nqYKFSr+wc+0SdfJuL0AYs/fyQ7nmmH9aPu/EvBH7WF
         klRyrtWGPdH3pFP2CiOIzlGQyQQdiFAi82IAtA0sDw3U8pRp9XvvwElYbVQfpTcwKDnb
         cEYAeseVfDXGR9FBBoZL9C7xIUsxziGx/j2rqSKrbFAU+hr8pFErBZxGu8qBNBYDFMY0
         0zHQ==
X-Gm-Message-State: AOAM531UFjGP/EVMfRHabRPfZKBtS1LgruDpwpnkrbmRXgwl8NCwP2wQ
        NmcXBiU3XWXauP4PHOsGaptwBm3JitCqzOAZauWJnMgo
X-Google-Smtp-Source: ABdhPJwiylW6GTPaej+sT45XslC9fTQg9iFYGvINZPTCfCYX2KckgefC9ujK7WwfdNyggMuXN5t0eCDuSlwMe00iOkU=
X-Received: by 2002:a05:6870:5a4:b0:da:b3f:3206 with SMTP id
 m36-20020a05687005a400b000da0b3f3206mr5730790oap.182.1647014628126; Fri, 11
 Mar 2022 08:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20220303214750.566685-1-jwcart2@gmail.com>
In-Reply-To: <20220303214750.566685-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:03:37 -0500
Message-ID: <CAP+JOzQucojbrW6wv_5D7n_p_TJHteyf10Cqsi6FKMW3cVttdg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Do a more thorough validation of constraints
To:     SElinux list <selinux@vger.kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 3, 2022 at 4:48 PM James Carter <jwcart2@gmail.com> wrote:
>
> When validating a policydb, do a more thorough validation of the
> constraints.
>  - No permissions if it is a (mls)validatetrans.
>  - Only mlsvalidatetrans can use u3, r3, and t3.
>  - Expressions not involving types should have an empty type set.
>  - Only "==" and "!=" are allowed when there are names.
>  - If names are not used in an expression then both the names bitmap
>    and the type set should be empty.
>  - Only roles and mls expressions can used "dom", "domby", and "incomp".
>  - An mls expression cannot use names.
>  - If the expression is "not", "and", or "or", then the names bitmap
>    and the type set should be empty.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This has been merged.
Jim

> ---
>  libsepol/src/policydb_validate.c | 69 ++++++++++++++++++++++----------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
> index 735c7a33..2c69f201 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -228,41 +228,69 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
>         constraint_expr_t *cexp;
>
>         for (; cons; cons = cons->next) {
> +               if (nperms == 0 && cons->permissions != 0)
> +                       goto bad;
>                 if (nperms > 0 && cons->permissions == 0)
>                         goto bad;
>                 if (nperms > 0 && nperms != PERM_SYMTAB_SIZE && cons->permissions >= (UINT32_C(1) << nperms))
>                         goto bad;
>
>                 for (cexp = cons->expr; cexp; cexp = cexp->next) {
> -                       if (cexp->attr & CEXPR_USER) {
> -                               if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
> -                                       goto bad;
> -                               if (validate_empty_type_set(cexp->type_names))
> -                                       goto bad;
> -                       } else if (cexp->attr & CEXPR_ROLE) {
> -                               if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
> +                       if (cexp->expr_type == CEXPR_NAMES) {
> +                               if (cexp->attr & CEXPR_XTARGET && nperms != 0)
>                                         goto bad;
> -                               if (validate_empty_type_set(cexp->type_names))
> -                                       goto bad;
> -                       } else if (cexp->attr & CEXPR_TYPE) {
> -                               if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
> +                               if (!(cexp->attr & CEXPR_TYPE)) {
> +                                       if (validate_empty_type_set(cexp->type_names))
> +                                               goto bad;
> +                               }
> +
> +                               switch (cexp->op) {
> +                               case CEXPR_EQ:
> +                               case CEXPR_NEQ:
> +                                       break;
> +                               default:
>                                         goto bad;
> -                               if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
> +                               }
> +
> +                               switch (cexp->attr) {
> +                               case CEXPR_USER:
> +                               case CEXPR_USER | CEXPR_TARGET:
> +                               case CEXPR_USER | CEXPR_XTARGET:
> +                                       if (validate_ebitmap(&cexp->names, &flavors[SYM_USERS]))
> +                                               goto bad;
> +                                       break;
> +                               case CEXPR_ROLE:
> +                               case CEXPR_ROLE | CEXPR_TARGET:
> +                               case CEXPR_ROLE | CEXPR_XTARGET:
> +                                       if (validate_ebitmap(&cexp->names, &flavors[SYM_ROLES]))
> +                                               goto bad;
> +                                       break;
> +                               case CEXPR_TYPE:
> +                               case CEXPR_TYPE | CEXPR_TARGET:
> +                               case CEXPR_TYPE | CEXPR_XTARGET:
> +                                       if (validate_ebitmap(&cexp->names, &flavors[SYM_TYPES]))
> +                                               goto bad;
> +                                       if (validate_type_set(cexp->type_names, &flavors[SYM_TYPES]))
> +                                               goto bad;
> +                                       break;
> +                               default:
>                                         goto bad;
> -                       } else {
> +                               }
> +                       } else if (cexp->expr_type == CEXPR_ATTR) {
>                                 if (!ebitmap_is_empty(&cexp->names))
>                                         goto bad;
>                                 if (validate_empty_type_set(cexp->type_names))
>                                         goto bad;
> -                       }
>
> -                       if (cexp->expr_type == CEXPR_ATTR || cexp->expr_type == CEXPR_NAMES) {
>                                 switch (cexp->op) {
>                                 case CEXPR_EQ:
>                                 case CEXPR_NEQ:
> +                                       break;
>                                 case CEXPR_DOM:
>                                 case CEXPR_DOMBY:
>                                 case CEXPR_INCOMP:
> +                                       if ((cexp->attr & CEXPR_USER) || (cexp->attr & CEXPR_TYPE))
> +                                               goto bad;
>                                         break;
>                                 default:
>                                         goto bad;
> @@ -270,14 +298,8 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
>
>                                 switch (cexp->attr) {
>                                 case CEXPR_USER:
> -                               case CEXPR_USER | CEXPR_TARGET:
> -                               case CEXPR_USER | CEXPR_XTARGET:
>                                 case CEXPR_ROLE:
> -                               case CEXPR_ROLE | CEXPR_TARGET:
> -                               case CEXPR_ROLE | CEXPR_XTARGET:
>                                 case CEXPR_TYPE:
> -                               case CEXPR_TYPE | CEXPR_TARGET:
> -                               case CEXPR_TYPE | CEXPR_XTARGET:
>                                 case CEXPR_L1L2:
>                                 case CEXPR_L1H2:
>                                 case CEXPR_H1L2:
> @@ -300,9 +322,12 @@ static int validate_constraint_nodes(sepol_handle_t *handle, unsigned int nperms
>
>                                 if (cexp->op != 0)
>                                         goto bad;
> -
>                                 if (cexp->attr != 0)
>                                         goto bad;
> +                               if (!ebitmap_is_empty(&cexp->names))
> +                                       goto bad;
> +                               if (validate_empty_type_set(cexp->type_names))
> +                                       goto bad;
>                         }
>                 }
>         }
> --
> 2.34.1
>
