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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93591C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF564E3B
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBKXid (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 18:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhBKXic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 18:38:32 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD279C0613D6
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 15:37:51 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id o12so6828616ote.12
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 15:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPulwOf+vusUUM85gAwJbv2b8+Dc5fFViEz97WQ3Tso=;
        b=PblOPJ/MqpmxXSrUJywNgCW4/ik1vjw6YbKDZT06Ea5Mv8EN9yYTRAUCXZm6uCMkng
         zvf7hezQE9GVV9bbz5AyXd52DgIdX0KyE7eg8u7K+XMXiLhi5QU5Pn9V0R4UbZ77rnoV
         WhbeMBANc4L30Lacm5KyUG2EBlHUnGXanrmREHmeVDurtKu2/lCd9hyxcjY5HQU2C14V
         8sIFK1TaFzbaJ2GmoMXyNTj9QTVsVBYjdWJBV0UMC3G/ZFnvDHHFphoJrKY3yQLhqLnw
         /TGI/pqelWGbsFmsmUjIPPDy16ZyXPcgGqipp2sfXwBLMcfUX1ZLbxDS4bfyNDv06Etv
         To1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPulwOf+vusUUM85gAwJbv2b8+Dc5fFViEz97WQ3Tso=;
        b=GrErXEIvNYF//UP9ipEVsAxGUr1nPuEwIXKzt1tyk8PU+7ufpyyrtrTq2tsld147gE
         OBzJNKXDrLz2Xz7s5ATTe/fsXa+2C0Pqrf5dmRkXFu2FJF0zszu7VhBdGqdJ6jp0xklZ
         1oYLnmwRw/sVNzvLtBw/MdXoIocAs2d92y9HGEijiBXoXXEqgwgMY5Dh6EMcms96zh4s
         L5iDiSnY6att7APz6JI14VKiPPclWHUNwKDatTxUUmJf+QwK3wQT03zfrXrLzHwhCMQY
         gw80pSMu6OUS9V4IHZ1ulrcJ9Yay8m7DEGUoeo2aPjhXSbGN5Y1hBGtHGrq0CNmtNH1A
         NN6A==
X-Gm-Message-State: AOAM532btAojyFUsRGYpeE+9fVjH0483NzZbYzOv0TgBu94CHXNgBTnn
        Ube+pJNEC9fbfrR3FpSM0N6RRQRSHiRDaJtCmMUNKlixHFVJAg==
X-Google-Smtp-Source: ABdhPJw5WqDCC2loYF/c6h/YVJxVeDCfYdAwsjoQYOybRlUb92pwDQxgDsxbT5gSoi6UFMXlf/IDFXBfsN/vuQiaazM=
X-Received: by 2002:a9d:32e2:: with SMTP id u89mr303423otb.196.1613086671269;
 Thu, 11 Feb 2021 15:37:51 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com> <acce2531-a70b-0df6-e258-d152e5b03bcf@gmail.com>
In-Reply-To: <acce2531-a70b-0df6-e258-d152e5b03bcf@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 11 Feb 2021 18:37:40 -0500
Message-ID: <CAP+JOzR-UDTApuKGE7nNY=4Ds0Lj+cR90G6CnF-FteYpB+EiXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] secilc/docs: add custom color theme
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 10, 2021 at 11:01 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Since the default pandoc themes either don't highlight everything or
> don't fit the black/white color style of the html / pdf I've created my
> own.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> v3:
>     No changes.
>
>  secilc/docs/Makefile    |  2 +-
>  secilc/docs/theme.theme | 59 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 secilc/docs/theme.theme
>
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index a91bcde0..a03ebeed 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -28,7 +28,7 @@ FILE_LIST ?= cil_introduction.md \
>
>  PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
>
> -PANDOC_HIGHLIGHT_STYLE="pygments"
> +PANDOC_HIGHLIGHT_STYLE="theme.theme"
>
>  PDF_OUT=CIL_Reference_Guide.pdf
>  HTML_OUT=CIL_Reference_Guide.html
> diff --git a/secilc/docs/theme.theme b/secilc/docs/theme.theme
> new file mode 100644
> index 00000000..5ffa9a65
> --- /dev/null
> +++ b/secilc/docs/theme.theme
> @@ -0,0 +1,59 @@
> +{
> +    "text-color": null,
> +    "background-color": null,
> +    "line-number-color": null,
> +    "line-number-background-color": null,
> +    "text-styles": {
> +        "String": {
> +            "text-color": "#049b0a",
> +            "background-color": null,
> +            "bold": false,
> +            "italic": false,
> +            "underline": false
> +        },
> +        "SpecialChar": {
> +            "text-color": "#049b0a",
> +            "background-color": null,
> +            "bold": false,
> +            "italic": false,
> +            "underline": false
> +        },
> +
> +        "Function": {
> +            "text-color": "#ff9358",
> +            "background-color": null,
> +            "bold": true,
> +            "italic": false,
> +            "underline": false
> +        },
> +
> +        "Operator": {
> +            "text-color": "#43a8ed",
> +            "background-color": null,
> +            "bold": true,
> +            "italic": false,
> +            "underline": false
> +        },
> +        "BuiltIn": {
> +            "text-color": "#ff6dd3",
> +            "background-color": null,
> +            "bold": true,
> +            "italic": false,
> +            "underline": false
> +        },
> +        "Comment": {
> +            "text-color": "#bc7a00",
> +            "background-color": null,
> +            "bold": false,
> +            "italic": true,
> +            "underline": false
> +        },
> +        "Keyword": {
> +            "text-color": "#28648e",
> +            "background-color": null,
> +            "bold": true,
> +            "italic": false,
> +            "underline": false
> +        }
> +    }
> +}
> --
> 2.30.0
>
