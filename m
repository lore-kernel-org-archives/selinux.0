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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA4C4338F
	for <selinux@archiver.kernel.org>; Thu, 12 Aug 2021 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5853D604AC
	for <selinux@archiver.kernel.org>; Thu, 12 Aug 2021 13:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhHLNhd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Aug 2021 09:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhHLNhd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Aug 2021 09:37:33 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ADAC061756
        for <selinux@vger.kernel.org>; Thu, 12 Aug 2021 06:37:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c23-20020a0568301af7b029050cd611fb72so7745331otd.3
        for <selinux@vger.kernel.org>; Thu, 12 Aug 2021 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVwtkNWZWdaavzMlBlFxaDlpi3wqQH+augWMIKgaRuM=;
        b=iBX4rZUIa3vhfNGeOKUkTBm4fJKRIHDBQzFR24S/BNr0Sw/jeS6fAA91klG7FUAAPb
         jlOyQkDO/tMMFGYoggjg8a4Dsvp8Mno5Ol0bBjuKqO7Cr9Nf9MY1mUZBe7RUup7DZogn
         GfhO6Z9U7jmFWwgUDGvMibK3qpholsTYb3oE8imD0Q9lE3ptrFUvfy08ESj6ayrpYE8u
         7J7JVZB0UIV6rW035kq4IFyANOT9b9P1f7xS463G0TfH6SRP/mINvmxILeSSkdegpki8
         fZi8jLKFmo1Eh0t9hkklu10mzEAlJxyoWT8E09uQjGJwXTWSWkw6s3aA+WvHH4n3zfdO
         qNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVwtkNWZWdaavzMlBlFxaDlpi3wqQH+augWMIKgaRuM=;
        b=gpsKdnN/ceMYPO3djOC92WHQpshdmk3BHcZECz8mgyi4IYOEOVjUHJIvKlK4RAEEBU
         gxW9bI90EEQQcwGWnPajOz1CF5TGKHnC/2XJwdGE70AQ+D9tunMGD/LsdFWr4NpwTUIb
         fDuoYe+Y0XE1HYIXz5eWEZVuIJzKwriQIidUKBfb2k8C8SRdDyxvNCPlwfY8fort7sEb
         ntYh14WjymkNLRBZN54yyGyTII1+21CPbO5l5/eJMhmIGPQlYL0b1+BiLejIoxUP3E5/
         26S3wkTdbmVKowN1tGMvzrU4JUUmrhPRSyctsxJSwDyUFCayWTHkJwZhYBjJoBIeiBqH
         lbSg==
X-Gm-Message-State: AOAM532B2jyD1xxP8AQPk5ItnXGUlGwxXCkbaIPr6IZ+mx5lPltl/z2U
        BuymdN0nlnPvRafpOOvpiwoPnN77vqazHd472f1swDcqzLI=
X-Google-Smtp-Source: ABdhPJz5VXphgvivzuatjkzBDJXHBVuO35nQSDvPWI1KHocW0ihJ3G3mgpaV5aI6H1/oQjFI+QuGuGdFBIsaCx45MHo=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr3415300otn.59.1628775427654;
 Thu, 12 Aug 2021 06:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210812115243.224604-1-dominick.grift@defensec.nl>
In-Reply-To: <20210812115243.224604-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 12 Aug 2021 09:36:56 -0400
Message-ID: <CAP+JOzSrMj03VjOn3yAKGk5gGBdRg8dPbtn_CMivBMCqO8H6ow@mail.gmail.com>
Subject: Re: [PATCH] cil_container_statements.md: clarify in-statement limitations
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 12, 2021 at 8:33 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> in-statements are resolved before inheritance and this is
> unintuitive. Explain that one can instead re-declare blocks and macros
> that were inherited, effectively yielding similar results.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

I am working on an optional extension of the behavior of the
in-statement that I hope to send out soon. If that works out, then the
documentation is going to change, so let's hold off on this patch for
now to see how that turns out.

Thanks,
Jim

> ---
>  secilc/docs/cil_container_statements.md | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_container_statements.md
> index 41a4612c..0259778c 100644
> --- a/secilc/docs/cil_container_statements.md
> +++ b/secilc/docs/cil_container_statements.md
> @@ -282,6 +282,8 @@ Allows the insertion of CIL statements into a named container ([`block`](cil_con
>
>  Not allowed in [`macro`](cil_call_macro_statements.md#macro), [`booleanif`](cil_conditional_statements.md#booleanif), and other [`in`](cil_container_statements.md#in) blocks.
>
> +Note that [`in`](cil_container_statements.md#in) statements referencing blocks and macros that were inherited cannot be resolved and that instead it is allowed to re-declare blocks and macros that were inherited, resulting in similar behavior.
> +
>  [`tunable`](cil_conditional_statements.md#tunable) and [`in`](cil_container_statements.md#in) statements are not allowed in [`in`](cil_container_statements.md#in) blocks.
>
>  **Statement definition:**
> --
> 2.32.0
>
