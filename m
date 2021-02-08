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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CEEC433E9
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00E1964EBD
	for <selinux@archiver.kernel.org>; Mon,  8 Feb 2021 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhBHR6q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 12:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhBHR44 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 12:56:56 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55ACC0617A7
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 09:45:05 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id l5so404477ooj.7
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 09:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUqmNee0JlYB/+cXpwI+Rd1zmsaYHY9dP1a09QN/L+s=;
        b=Z2QoTyvXUJ6+Dra352WmOo7pzH+TYnWIC7HVIvZx8WK12JwVYV7W40VZct0rf+NMft
         uXaWu/9clDEXAVbU5jV43yPp14/uLoBsV1roiKpO74ijbS9SqoXnRDRRiDoHkVr0UMPS
         SVXo6r4LweqsD5iEdjLGR0gntz6YA2xAoG6Q6yp1vdkEwZtyW179I5Rwt1zsVk+jmwpj
         LQikKBbDSi/JDqVArEeyyGyRvWFj6uW7dd4RtPDzrS8ZCHrfGfR7WHRQPeH2++oM+kdp
         7RG83JDxUtASilEA5YTVyx9hqvHKYCSvBzyIJqnHiqlo5pJAXaV1XnuMM/kJMTxefUlh
         7jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUqmNee0JlYB/+cXpwI+Rd1zmsaYHY9dP1a09QN/L+s=;
        b=Gf3zqq5X/b9LIwnRGvslKwulK5kO6S+4jbd96HFMqMH2d7nqplmTYmLztr2l1n45rC
         EDaO+xfvIpaqUgazCsqGxTUQsa3bJnxAOwhk0wUteSFLDpr8lPnjHcxbukzgTurvgHz/
         M2Ccz+aTw1AExqNu5oN+T7YEK8nFGTCsEKEaTWpgUGbOdQUijHL1tW90V+EaMas6paou
         dXHDeNf+iabh1EH8Qr+OicrlW7ST2kaCcGpDjQ30BrhQhL6r1P8imhosgC++8kPszUtw
         5l8tjbw9uY8Vpd+9lnvw/TB0/NkNz+Rz8fh7WND7F+fHvgCVwuuzARv2jlUefrhqlm8w
         9Mjg==
X-Gm-Message-State: AOAM533QL1xzdwvOPCw3/bLUo5SufH7MjrPE5o+1KWiTEiSB9mj8GmmJ
        EyPXqkmMUhM85s8qfR7Eq6pwA9MpLHq3YO6+IaE=
X-Google-Smtp-Source: ABdhPJxgEhkwHaLrVXIl6n50gjAjDb6sqbUC0xT54MHpwf27d9cXlysdwhkIhrida3Sacwk0uvkRk7WLLpi3AO3BulQ=
X-Received: by 2002:a4a:aacd:: with SMTP id e13mr3179914oon.35.1612806305162;
 Mon, 08 Feb 2021 09:45:05 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com> <3cfe5057-8bfe-4058-a0f2-058ecc480ab9@gmail.com>
In-Reply-To: <3cfe5057-8bfe-4058-a0f2-058ecc480ab9@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Feb 2021 12:44:54 -0500
Message-ID: <CAP+JOzRxf31Q+3kVr7UJSFZP0Ywh_+Jq=GQ4r2iukm0mL02Shg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] secilc/docs: add custom color theme
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 6, 2021 at 4:06 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Since the default pandoc themes either don't highlight everything or
> don't fit the black/white color style of the html / pdf I've created my
> own.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

I am ok with these colors.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
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
