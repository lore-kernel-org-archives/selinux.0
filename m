Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E94C11F66
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0B3613AF
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 14:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGIOSf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhGIOSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jul 2021 10:18:34 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7488FC0613DD
        for <selinux@vger.kernel.org>; Fri,  9 Jul 2021 07:15:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f93-20020a9d03e60000b02904b1f1d7c5f4so8752436otf.9
        for <selinux@vger.kernel.org>; Fri, 09 Jul 2021 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rWWZeWH897akkXwzsC9VyAjlCqCSqzT49imc64Je2Cg=;
        b=WbMNbtaLctXOQZ+0rTs82s4Y5x9zR0tonSk9B4CDrgAqtU+kNTbfpt6DuAXksLSNVQ
         f9jKvnYA06dlgoTwCPhzvDlaEu20mLDLgfwG42spbzbMFlrat9uxZuY3sL5wXNrbs/rq
         r3WYIWi0hzW+pzlyixQPY1NqktIGbipOWwGgmvk/zDefXPjQueYxEaXjetcESRcmexYF
         VS0KO+yyY5GtxPyYlq4dFMP+XE3G+G2c9TFdCYWxVscyGkNDVdOWhXX6Wi2v/pcPBuL3
         EwqVX4hYDp0aUa5gJ497C4vEd5CCQIJsI/rwOc5/xjxTRgHKmLRVG2+UXa6qbebf1C5T
         4UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rWWZeWH897akkXwzsC9VyAjlCqCSqzT49imc64Je2Cg=;
        b=tugE80Sict8dJr/KbUWGJW99TpYvxFvc/qpanUV+CRoSev5gGGQJ01YmSKGfVkw6Q+
         LWHF8LCDsbdJqXbcM59O5ZMaalzYGzfMGnmF1GgjjpkNnC+X5nZq+QcddBTfiYaKX6I5
         Xas9IZbE4pgnf2VwnNab3TmlpT++rgHUapPA4mTL7MRbmmq8Kh3HjkGFPXnRYyTdupqk
         5muoBkGqpF4c47msMTGNMxOg4sK+OBDb4MqV99z2HikO+2qEw3rk3XmP8cCMKH/kxRqX
         EFVkxwYtWSY5ssCgHSO4qYRBTXTCzlLO4+ZNpW7oGJPa9BI2V/r7gu0OUmgweWNLSgGf
         wZ6g==
X-Gm-Message-State: AOAM530YEubYlUiX49pIl7EeOUThVB7CZAPwB96/IOou9d+409z31Q19
        A+wePCShvcQU1RzDTd8N4ijlZ6X9M3+a9qNN9NG3dJ1EAeY=
X-Google-Smtp-Source: ABdhPJyW3fhTa/Zk0vJlxqSwp/TlAo6naaLGabfxH4RHkBnMO9WdHeIgwWEnBvU7BnxyvxpS3oyzEfDxTRF09H71Mh0=
X-Received: by 2002:a05:6830:16d2:: with SMTP id l18mr14281694otr.196.1625840149767;
 Fri, 09 Jul 2021 07:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210708122152.11837-1-jwcart2@gmail.com>
In-Reply-To: <20210708122152.11837-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 9 Jul 2021 10:15:38 -0400
Message-ID: <CAP+JOzTsyw_4DGojB8t7xkCHe4M834=yGEZ7gJ4u6aVdV1SQuQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Only expand anonymous category sets in an expression
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch has been superseded by the patch that also checks for a
category set being used in a category range.
Jim

On Thu, Jul 8, 2021 at 8:21 AM James Carter <jwcart2@gmail.com> wrote:
>
> commit 982ec302b67f3c7f8df667dadb67352b1e4a6d18 (libsepol/cil:
> Account for anonymous category sets in an expression) attempted to
> properly handle anonymous category sets when resolving category
> expressions. Unfortunately, it did not check whether a category set
> was actually an anonymous category set and expanded all category
> sets in an expression. If a category set refers to itself in the
> expression, then everything from the name of the category set to the
> end of the expression is ignored.
>
> So, for example, the rule "(categoryset cs (c0 cs c1 c2))", would be
> equivalent to the rule "(categoryset cs (c0))" as everything from
> "cs" to the end would be dropped. The secilc-fuzzer found that the
> rule "(categoryset cat (not cat))" would cause a segfault since
> "(not)" is not a valid expression and it is assumed to be valid
> during later evaluation because syntax checking has already been
> done.
>
> Instead, check whether or not the category set is anonymous before
> expanding it when resolving an expression.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_resolve_ast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index 145d4e74..933caf9b 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -3261,7 +3261,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
>                         if (rc != SEPOL_OK) {
>                                 goto exit;
>                         }
> -                       if (sym_index == CIL_SYM_CATS && NODE(res_datum)->flavor == CIL_CATSET) {
> +                       if (sym_index == CIL_SYM_CATS && !res_datum->name && NODE(res_datum)->flavor == CIL_CATSET) {
>                                 struct cil_catset *catset = (struct cil_catset *)res_datum;
>                                 if (!catset->cats->datum_expr) {
>                                         rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
> --
> 2.31.1
>
