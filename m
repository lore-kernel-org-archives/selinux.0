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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AE7C433E0
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68A664E00
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 14:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBPOma (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBPOmU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 09:42:20 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22ADC061756
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:41:39 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id k204so11439984oih.3
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJFUgh2JSgD8nnxpmayUwBa5Tp1jOJ7NEvI1AvduNko=;
        b=OTXgeXMRN1qr3eOJrCzdTerEPryZcF5xXNX38GaGt8HKGXsa0JpxYtpbAxkcUs+q3n
         c/quC4pY+QBnPXms+VlDhw3bNU6kI1P0T8NmhIhc0ozXNksWmFpAH++0Lv0ufptwpkT4
         vT1i0Zyh5qyKoT38saxOYBl4+QgxrM8itvRZY66v1qgYF1L/BVxn9Yn0PphMHz2mNzf2
         eoqtqENg0haM0CAL2+EwXpmRU/1Qohw9dvC532bAs/u0MWTXRPnDom3KDvViLIqRaMBV
         4X1oqpI40NNSp1NAynchEn+5mSO+VSZc5fJcwGpb5aY/J4oQMqIr7wWqmcQOQ6kfnC1Y
         aRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJFUgh2JSgD8nnxpmayUwBa5Tp1jOJ7NEvI1AvduNko=;
        b=DrnBpwMjD5tJaahLzODqKXyIKYXCAm4n1AiQViqE6vTFi9jHEtLHjwjxlasvB3eoFh
         W1tE1xJqbc9+sFoQOtdHSwhKv4UVNauc5iUp9W5XRZIlh8kODSg+cz11XyCw5zGkHtY2
         6M4BR8veZEmdFj9o9fijov0T2AH9jUIhYRxw5nCtot9aM1Ur3x9KKo8oiJpkoWGWzyZP
         zeu+2eAcs/MY2CuMU+Z2/NX2VPFbgJkgtvjQqm/6HNsF6RQ//BBA6Lf/CELN6gjZDRoe
         vq9gkHMRWqUVZXjTpQwx9oMHnZp1IeHCOpI7b9Oo/xxc34bOj51cxdB9RADgvvUk2oge
         gUCw==
X-Gm-Message-State: AOAM5306Ywdw2TUBAvHW20B6WZXV1+INqeYkpuZLFQuAw+8kTHhINdg+
        l2yvhbRWdMyxSBZDAx8lnLLojOkg+nvyuEzizuLZ2LLSEXI=
X-Google-Smtp-Source: ABdhPJwaai1ymcTJi9TeQHqYsIHytvHFfnlkZpajCQSSSo0+jynOZkqp9tm4YjsFbgdyhi2e/xyzYG7Zm1tYGhib2D8=
X-Received: by 2002:aca:f00a:: with SMTP id o10mr2810670oih.128.1613486499452;
 Tue, 16 Feb 2021 06:41:39 -0800 (PST)
MIME-Version: 1.0
References: <a8abefda-5c2b-918d-65d9-e21b89e9a2bf@gmail.com>
 <acce2531-a70b-0df6-e258-d152e5b03bcf@gmail.com> <CAP+JOzR-UDTApuKGE7nNY=4Ds0Lj+cR90G6CnF-FteYpB+EiXg@mail.gmail.com>
In-Reply-To: <CAP+JOzR-UDTApuKGE7nNY=4Ds0Lj+cR90G6CnF-FteYpB+EiXg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 16 Feb 2021 09:41:28 -0500
Message-ID: <CAP+JOzTxAsCt-O=B-UBEpo78Togam24FPA33OpUUonJOsB8gvg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] secilc/docs: add custom color theme
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 11, 2021 at 6:37 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 10, 2021 at 11:01 AM bauen1 <j2468h@googlemail.com> wrote:
> >
> > Since the default pandoc themes either don't highlight everything or
> > don't fit the black/white color style of the html / pdf I've created my
> > own.
> >
> > Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied.
Thanks,
Jim

> > ---
> >
> > v3:
> >     No changes.
> >
> >  secilc/docs/Makefile    |  2 +-
> >  secilc/docs/theme.theme | 59 +++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 60 insertions(+), 1 deletion(-)
> >  create mode 100644 secilc/docs/theme.theme
> >
> > diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> > index a91bcde0..a03ebeed 100644
> > --- a/secilc/docs/Makefile
> > +++ b/secilc/docs/Makefile
> > @@ -28,7 +28,7 @@ FILE_LIST ?= cil_introduction.md \
> >
> >  PANDOC_FILE_LIST = $(addprefix $(TMPDIR)/,$(FILE_LIST))
> >
> > -PANDOC_HIGHLIGHT_STYLE="pygments"
> > +PANDOC_HIGHLIGHT_STYLE="theme.theme"
> >
> >  PDF_OUT=CIL_Reference_Guide.pdf
> >  HTML_OUT=CIL_Reference_Guide.html
> > diff --git a/secilc/docs/theme.theme b/secilc/docs/theme.theme
> > new file mode 100644
> > index 00000000..5ffa9a65
> > --- /dev/null
> > +++ b/secilc/docs/theme.theme
> > @@ -0,0 +1,59 @@
> > +{
> > +    "text-color": null,
> > +    "background-color": null,
> > +    "line-number-color": null,
> > +    "line-number-background-color": null,
> > +    "text-styles": {
> > +        "String": {
> > +            "text-color": "#049b0a",
> > +            "background-color": null,
> > +            "bold": false,
> > +            "italic": false,
> > +            "underline": false
> > +        },
> > +        "SpecialChar": {
> > +            "text-color": "#049b0a",
> > +            "background-color": null,
> > +            "bold": false,
> > +            "italic": false,
> > +            "underline": false
> > +        },
> > +
> > +        "Function": {
> > +            "text-color": "#ff9358",
> > +            "background-color": null,
> > +            "bold": true,
> > +            "italic": false,
> > +            "underline": false
> > +        },
> > +
> > +        "Operator": {
> > +            "text-color": "#43a8ed",
> > +            "background-color": null,
> > +            "bold": true,
> > +            "italic": false,
> > +            "underline": false
> > +        },
> > +        "BuiltIn": {
> > +            "text-color": "#ff6dd3",
> > +            "background-color": null,
> > +            "bold": true,
> > +            "italic": false,
> > +            "underline": false
> > +        },
> > +        "Comment": {
> > +            "text-color": "#bc7a00",
> > +            "background-color": null,
> > +            "bold": false,
> > +            "italic": true,
> > +            "underline": false
> > +        },
> > +        "Keyword": {
> > +            "text-color": "#28648e",
> > +            "background-color": null,
> > +            "bold": true,
> > +            "italic": false,
> > +            "underline": false
> > +        }
> > +    }
> > +}
> > --
> > 2.30.0
> >
