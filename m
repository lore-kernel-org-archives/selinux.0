Return-Path: <SRS0=qcS5=BJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513CC433E0
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 008F720829
	for <selinux@archiver.kernel.org>; Thu, 30 Jul 2020 22:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO/+MGeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgG3WWt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbgG3WWt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jul 2020 18:22:49 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9AC061574
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:22:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l27so14141366oti.3
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2020 15:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xnu9LxYEUg/S0AO3LCna88Ulkhd4mc4ahwUW0KzTsDo=;
        b=KO/+MGeBPZk48LR75q9M2OobED9aQ0QRXKH5Rsop/Q4MAO35aVCbew+RpiOl47vlj2
         wBD7rxAIGs5dALutOprJmfNvSO92EwWCj7WY6PxFdYHv9tX7ULsc+BzrtQRtcJ0Rs44K
         DLUiz4G/z1DmkvRfouLmJgMX/wGVCRCiLPUIBLxYtyvLhr3gcWqoi1DkkzffhL0vSIoG
         HkhhasXhhiPGuCHSOv2ARJ6MuytJsiEFeegHaOT3PSnLFoAsy53Nlx9PH9qbaTT5Cfh0
         5eolXUB7ZNBbsNqz+ISOqJXSmowE78DG+iwprwuLLx127gC6+pxXnbORtjMzgC8jcqGf
         DWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xnu9LxYEUg/S0AO3LCna88Ulkhd4mc4ahwUW0KzTsDo=;
        b=ABvStYlKyQVuU4Wl86qZCSq7QEvYNtG/I9yOs5HaTy5eNVQVsbQ4eITZeduwPV4yqq
         g1I9iUg8Gr719Nebj3wuNtzfMKvrRz2zxr4Rwnpg9MMCPgsUqxjDQXBS7r3mqVjGuoiM
         dkIWw+6OTyxVVvFKu2FtQS1ad6iTaaRCAqJkuuidiCigUC8ih1By6Xw3dJo1FjhEaDeo
         n0v5aeLZF5cIR2c5t7BH47JpiZUQAB4GYR2bvvsaABzIWhtSBpv0WZ2xsjF57QUVvO1b
         Iu2bX8tOwu8ERRh+nBn3EMAG26Gwl23cEwsturCPJgPEUSBpvwwTLRpYbOi+kWxNDgwO
         Djrw==
X-Gm-Message-State: AOAM53138Ze5YPHtiSN2XUiInzC/QXX/FJOHDb4rI+I6fxwDF0LdoNIN
        d7+MBiL9PnsQWRENn/ZjKEQV5leXYj+iBzkJXDkaeQ==
X-Google-Smtp-Source: ABdhPJxxQaNuSfho2IIFqRxjnXeTUxC4n0LHcy1zYGk3ahmktemz8EWILupuEO5Sw6VGSFPmQBRhsrmsQ/P8K2Y+1qk=
X-Received: by 2002:a05:6830:1083:: with SMTP id y3mr635105oto.59.1596147768506;
 Thu, 30 Jul 2020 15:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200730114555.915996-1-dominick.grift@defensec.nl> <20200730131149.928220-1-dominick.grift@defensec.nl>
In-Reply-To: <20200730131149.928220-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Jul 2020 18:22:37 -0400
Message-ID: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
Subject: Re: [PATCH v3] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 30, 2020 at 9:14 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added for Androids Treble in 2017.
>
> I was unsure whether this belongs in type_statements or in conditional_statements.
>

I think that it fits best with the type statements as you have it.

> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: overriden is overridden
> v3: add link to README.md
>
>  secilc/docs/README.md              |  1 +
>  secilc/docs/cil_type_statements.md | 38 ++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
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
> index f9dd3a76..f819b3c6 100644
> --- a/secilc/docs/cil_type_statements.md
> +++ b/secilc/docs/cil_type_statements.md
> @@ -213,6 +213,44 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>          )
>      )
>
> +expandtypeattribute
> +-------------------
> +
> +Allows expansion compiler defaults for one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to be overridden.

The wording confused me at first.
I think "Overrides the compiler defaults for the expansion of one ...
identifiers." would be clearer.

> +
> +**Statement definition:**
> +
> +    (expandtypeattribute typeattribute_id true|false)
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
> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers.</p></td>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>true | false</code></p></td>
> +<td align="left"><p>Either true or false.</p></td>
> +</tr>
> +</tbody>
> +</table>
> +
> +**Example:**
> +
> +This example will use the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
> +
> +    (expandtypeattribute domain true)
> +

It would be nice to have another example that shows a list of type
attributes, so there is an example of that syntax as well.

Thanks for doing this.
Jim

>  typebounds
>  ----------
>
> --
> 2.28.0.rc1
>
