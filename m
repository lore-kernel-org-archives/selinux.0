Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475B9C433DF
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5599206CA
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 17:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ81CVrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbgJORAR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 13:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbgJORAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 13:00:17 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DB6C061755
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:00:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d28so3581543ote.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvrm5l35TMwDB9A6myTW+9LOSDfORFqxKtuSQ1xwPF8=;
        b=EZ81CVrXgXjZ/XIaUAF8GjaF8Kj1IDwskC44mlHCrY4eeGyyHWtwTJdXQEhogCN+tr
         qWJXCjbq9z2vY1pXpUBPY6y/XjU7ytmZhWkGtocl6s2QjJfWDR6mDuLuGJ3u6S3ccmAn
         6u3gYTBG6Ddhn3Mr/0r7vG0tp5Xf9APRcisIzua09ve5XM+PoE9h5KV/+flGev7x0nZ3
         NsW/qBieRvRh5udgwfPbBPJa6QtyEYpYufMEgqDH3FhaDSZEzM4tvkJ5HJs2MNtpCTUJ
         7MZ6CyWxQd2ArERKtx49k3R1EdRMWFBpUdjnpaPfRdnjXL+7IhO5fsr5hzOYF/ilIgYz
         OqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvrm5l35TMwDB9A6myTW+9LOSDfORFqxKtuSQ1xwPF8=;
        b=B5nmkv/s8vw7QOTZSTGeTRGuXZZmsGCvFYgo20ipyFiVeiW25q1DRS1v3Qv7qO0C1h
         48wrfJlwtXGC4gy4uhBM2cboibkDf/12pEJUAelV5gqKnAdTmPh5ErBEUZGoYY+K9c3C
         oGPDMI6l8pH4ZJwACALNt97jURxDB8WoXfqQBeRMoas+X/d/q4bR+AEV63LvZp5KvwJS
         rxaUV6yxUiRglg6QimX/ap3HCnn5keGAdN3hsuxevs9gBEvy83Eiwe0YaYc0y4OIHFDr
         A/kJzuJ4CLsX2s5mG5NES8cUHMQIuvNdScDFoDSM+HLdA/zN6ZrvrDu15PuZYsNthYHx
         u34g==
X-Gm-Message-State: AOAM531lrXvnh1DAB9rf/L0igRUUK7qqOjMk7BDWNa7hjmHJRtNwc08z
        7ipSEmeibdbza3MwKgYWrbNMEjC+8zZ0W9NbmoY=
X-Google-Smtp-Source: ABdhPJwIljIAt9cV0IAxH95V3hveDkZ8vA30FWtzq7/GjhB4n1nATbPEILMZeAgM6mtx2oujCQDQtLBLPLHtBihGIHA=
X-Received: by 2002:a9d:1406:: with SMTP id h6mr3218158oth.59.1602781216540;
 Thu, 15 Oct 2020 10:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
In-Reply-To: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 15 Oct 2020 13:00:05 -0400
Message-ID: <CAP+JOzQVGvB2CJN+DF8dn1Y=EwJQErh9UThEmoec_=X6_ye6CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: drop confusing BUG_ON macro
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Oct 3, 2020 at 3:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Contrary to Linux kernel, BUG_ON() does not halt the execution, in
> libsepol/src/services.c. Instead it displays an error message and
> continues the execution.
>
> This means that this code does not prevent an out-of-bound write from
> happening:
>
>     case CEXPR_AND:
>         BUG_ON(sp < 1);
>         sp--;
>         s[sp] &= s[sp + 1];
>
> Use if(...){BUG();rc=-EINVAL;goto out;} constructions instead, to make
> sure that the array access is always in-bound.
>
> This issue has been found using clang's static analyzer:
> https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-50a861.html#EndPath
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index 90da1f4efef3..beb0711f6680 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -67,7 +67,6 @@
>  #include "flask.h"
>
>  #define BUG() do { ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
> -#define BUG_ON(x) do { if (x) ERR(NULL, "Badness at %s:%d", __FILE__, __LINE__); } while (0)
>
>  static int selinux_enforcing = 1;
>
> @@ -469,18 +468,30 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
>                 /* Now process each expression of the constraint */
>                 switch (e->expr_type) {
>                 case CEXPR_NOT:
> -                       BUG_ON(sp < 0);
> +                       if (sp < 0) {
> +                               BUG();
> +                               rc = -EINVAL;
> +                               goto out;
> +                       }
>                         s[sp] = !s[sp];
>                         cat_expr_buf(expr_list[expr_counter], "not");
>                         break;
>                 case CEXPR_AND:
> -                       BUG_ON(sp < 1);
> +                       if (sp < 1) {
> +                               BUG();
> +                               rc = -EINVAL;
> +                               goto out;
> +                       }
>                         sp--;
>                         s[sp] &= s[sp + 1];
>                         cat_expr_buf(expr_list[expr_counter], "and");
>                         break;
>                 case CEXPR_OR:
> -                       BUG_ON(sp < 1);
> +                       if (sp < 1) {
> +                               BUG();
> +                               rc = -EINVAL;
> +                               goto out;
> +                       }
>                         sp--;
>                         s[sp] |= s[sp + 1];
>                         cat_expr_buf(expr_list[expr_counter], "or");
> --
> 2.28.0
>
