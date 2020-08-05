Return-Path: <SRS0=Kca8=BP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC566C433E0
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A317022CB3
	for <selinux@archiver.kernel.org>; Wed,  5 Aug 2020 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4E+dUYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHEUTR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHEUTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 16:19:16 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96272C061575
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 13:19:16 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v6so23604843ota.13
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLfyOBdQfppqne6x5pwJSiZXNSZ7O17M4M6XYOSTx4U=;
        b=b4E+dUYD9Eq81XqUvuznCkeANVKAZ+1o7g3BsfxhSej89UU88Im2Okg4317X1+eHiH
         ghMBYXgrWZkfGolWD2pamHRDabzuRv3KECTp5AtITLLysV76bEvMeTaei1p3FuPZ3L3K
         1XJrNOhvlB0aPjevuU5PtuAo+wuwdZYv1wdg099UizRpyIC5rkOTPqkEqFGDXgdMLyJR
         rZWPPkhtM0J/TNWG7t1ykiysLIaKhD0u9OIyEMNqaNG0mTjNhBm8QjqZ2o1STtberLRv
         ULq2+gAL82R5LNW0XnEF7MqujmdfEaiBgeuogmcPeudBclZczk05TVyKTmLSP2YgULFb
         /xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLfyOBdQfppqne6x5pwJSiZXNSZ7O17M4M6XYOSTx4U=;
        b=f6/ojKSS9HY820Cd78pfozxM/BlOP9V1HaBwg0nTy71LOLEZTUqNK+xuH8i2wKsdBG
         hnkhL3jhAoKCfGOzA/d997lQ6yLe+7eszStV3BayXqj5O7h+vjsiT7N3bl4ldU0xjsFt
         Kb7rRVBP2FeT3YF3FE668qAW0sAIgTfZ2i7iJYHB10faQjar2jQ8d/R1UnyjHBHNp/Xl
         NqsYK8G0PawWUrdQcdCLo82l02uzaZrW1H1OBGpzH8ifZgS6FVqcKHxdaW85IEhHH9EG
         IUSSgB8Gb0qM6Zoi7E1R6FdXPEOUa0zUbZK+rM6iohWZqfRqYWni2Y8qJMRMRkmsvzOa
         LH4w==
X-Gm-Message-State: AOAM5301FDDXS4dXlVkL67I8nvUmvjDU1OztRrL1z4gYJU2lu+81ZDQ/
        tl1e4pXmz+Qm8DF/TIK55sMBFhOtQNSdEfvXnywLkolAOow=
X-Google-Smtp-Source: ABdhPJyeVVY1lKsSlrVq1aDB+gu2FKWSMxuvAu/GkVtFozgtJy247fPXBxuj+VdwX3jEcHDhg5ENCPQ0B3WKzaPpcBI=
X-Received: by 2002:a9d:65ca:: with SMTP id z10mr4409490oth.295.1596658755975;
 Wed, 05 Aug 2020 13:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzQe8Q0GKtm9aavEQTzFWCT8sUi8shjw=TmgJYm5XkaN_w@mail.gmail.com>
 <20200805194823.492092-1-dominick.grift@defensec.nl>
In-Reply-To: <20200805194823.492092-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 5 Aug 2020 16:22:30 -0400
Message-ID: <CAP+JOzRy+UxEAjJjuKy3NkDq-1S6tSvjEYAF+TpEcyHpUPPnTw@mail.gmail.com>
Subject: Re: [PATCH v5] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 5, 2020 at 3:50 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added for Androids Treble in 2017.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2: overriden is overridden
> v3: add link to README.md
> v4: rephrase and add another example
> v5: use description from James Carter
>
>  secilc/docs/README.md              |  1 +
>  secilc/docs/cil_type_statements.md | 51 ++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
> index 3f1838e6..efab2a71 100644
> --- a/secilc/docs/README.md
> +++ b/secilc/docs/README.md
> @@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
>    * [typealiasactual](cil_type_statements.md#typealiasactual)
>    * [typeattribute](cil_type_statements.md#typeattribute)
>    * [typeattributeset](cil_type_statements.md#typeattributeset)
> +  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
>    * [typebounds](cil_type_statements.md#typebounds)
>    * [typechange](cil_type_statements.md#typechange)
>    * [typemember](cil_type_statements.md#typemember)
> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
> index f9dd3a76..432cede5 100644
> --- a/secilc/docs/cil_type_statements.md
> +++ b/secilc/docs/cil_type_statements.md
> @@ -213,6 +213,57 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>          )
>      )
>
> +expandtypeattribute
> +-------------------
> +
> +Overrides the compiler defaults for the expansion of one or more
> +previously declared [`typeattribute`](cil_type_statements.md#typeattribute)
> +identifiers.
> +
> +This rule gives more control over type attribute expansion and
> +removal. When the value is true, all rules involving the type
> +attribute will be expanded and the type attribute will be removed from
> +the policy. When the value is false, the type attribute will not be
> +removed from the policy, even if the default expand rules or "-X"
> +option cause the rules involving the type attribute to be expanded.
> +
> +**Statement definition:**
> +
> +    (expandtypeattribute typeattribute_id expand_value)
> +
> +**Where:**
> +
> +<table>
> +<colgroup>
> +<col width="25%" />
> +<col width="75%" />
> +</colgroup>
> +<tbody>
> +<tr class="odd">
> +<td align="left"><p><code>expandtypeattribute</code></p></td>
> +<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
> +</tr>
> +<tr class="even">
> +<td align="left"><p><code>typeattribute_id</code></p></td>
> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers. Multiple entries consist of a space separated list enclosed in parentheses '()'.</p></td>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>expand_value</code></p></td>
> +<td align="left"><p>Either true or false.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Examples:**
> +
> +This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> +
> +    (expandtypeattribute domain true)
> +
> +This example uses the expandtypeattribute statement to not expand previously declared `file_type` and `port_type` type attributes regardless of compiler defaults.
> +
> +    (expandtypeattribute (file_type port_type) false)
> +
>  typebounds
>  ----------
>
> --
> 2.28.0
>
