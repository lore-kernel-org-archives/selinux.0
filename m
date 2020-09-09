Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072E5C433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EF3208CA
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNcK9xEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIIUY7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUY6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:24:58 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70750C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 13:24:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g10so3434269otq.9
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 13:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l194kgLAH+YhoYHDcpWghspUs5pTFnX0yyjeXyUS0SM=;
        b=mNcK9xEcgFVDbD0GjvQkaJ4eOFHCydSW2NOTu+aLfpHY6l+yEvZJl5ip7FRFFVF4tn
         L6PHWyKgFSIJUwrVLABL7oBDY+pA6v4qzWc/gGd22TmshJhVVOmtqJy0epJxS5VsjPea
         um2ZSjhiYSyijuEO6JKQ9SIxteJ+Nt1qhQA70aAWccpGVzHqlDxPJ9DFnduJlLe8SMz2
         6EZmYSkftrfNZY953Bt46oMfkNM7+DSvdV0yViGp5kwVeDvY+SHZ6+9WN3QsqNIVdN3c
         YOyZviedin1ytdfiXAKgOWedFGRhPgXyZ/kxLsMcAkuNeakIduTRGlBx6Dmjxe1250ed
         a1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l194kgLAH+YhoYHDcpWghspUs5pTFnX0yyjeXyUS0SM=;
        b=J4g0g+YQ73M0ut8slTSN7YnlnbU+wNVn6Zc35jbXzrJuq1l8bGoEbzEQAUQ+16pNDM
         hdiYz42Krsxh2zeV8GQHrK9Imy02CMnQCakA676KPjxwHRXJh6GZXfJfsK2xhN3MuYC9
         UDBX6iMreCLxCRt7GFgAexJvLyutwH4tswA0Ssij6GpDqqcow57aWMKoSLHp3T1dFBQs
         vSqF8gT+HOuaiaSkF/8YrLsoNtTT1MaWbuXOb4oa+BkuqsWlzGiGizB8LYuWSafH0tgi
         crYBQOiUh9Nz18V7yVxx398MjL8Y2bZD4TaEygXu4DsE7LLOQ2OnDdxWEMI9HTlWEfqD
         r77A==
X-Gm-Message-State: AOAM530JjZGBWa1/C6pVDZDEcIwPpvY72PZbH+3YihQLRXZm250scEXn
        p3pBC83cUXu7q5M9UbSr/M/cWFggqGsxv/2Vo92622P9
X-Google-Smtp-Source: ABdhPJzImY/6SSAtGOKcqPME0jw7L8d3g1+uz3pPymH1eTKL/9AvybIoPgZzjo6boFJhNV4rIhZ4udvlRLCNCW/5eLo=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr1750922otn.89.1599683097890;
 Wed, 09 Sep 2020 13:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200909182444.254828-1-jwcart2@gmail.com>
In-Reply-To: <20200909182444.254828-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 9 Sep 2020 16:24:47 -0400
Message-ID: <CAEjxPJ7nPcuGRe5HUc+za-9Zh13LWcjuEPWhFVCzL=qh==t66w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Validate constraint expressions before
 adding to binary policy
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 2:25 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of constraint expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries with constraint expressions exceeding
> the max depth to be created.
>
> Validate the constraint expression using the same logic that is used
> when reading the binary policy. This includes checking the depth of the
> the expression.
>
> Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c    | 50 ++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.c | 20 ++++---------
>  2 files changed, 55 insertions(+), 15 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 77266858..0604db3c 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2713,6 +2713,51 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
>         return SEPOL_OK;
>  }
>
> +int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
> +{
> +       constraint_expr_t *e = sepol_expr;
> +       int depth = -1;
> +
> +       while (e) {
> +               switch (e->expr_type) {
> +               case CEXPR_NOT:
> +                       if (depth < 0) {
> +                               cil_log(CIL_ERR,"Invalid constraint expression\n");
> +                               return SEPOL_ERR;
> +                       }
> +                       break;
> +               case CEXPR_AND:
> +               case CEXPR_OR:
> +                       if (depth < 1) {
> +                               cil_log(CIL_ERR,"Invalid constraint expression\n");
> +                               return SEPOL_ERR;
> +                       }
> +                       depth--;
> +                       break;
> +               case CEXPR_ATTR:
> +                       if (depth == (CEXPR_MAXDEPTH - 1)) {
> +                               cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
> +                               return SEPOL_ERR;
> +                       }
> +                       depth++;
> +                       break;
> +               case CEXPR_NAMES:

You don't like sharing a single block for multiple cases?  Up to you.
As long as it gets annotated with the magic fallthrough indicator,
modern compilers shouldn't care.

> +                       if (depth == (CEXPR_MAXDEPTH - 1)) {
> +                               cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
> +                               return SEPOL_ERR;
> +                       }
> +                       depth++;
> +                       break;
> +               default:
> +                       cil_log(CIL_ERR,"Invalid constraint expression\n");
> +                       return SEPOL_ERR;
> +               }
> +               e = e->next;
> +       }

Only difference I noticed from checkpolicy logic here is that you
don't do a final check that depth was 0 at the end.  Don't know if
that is impossible here for other reasons.
