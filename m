Return-Path: <SRS0=5Yje=BN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED1C433DF
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E08B22CAD
	for <selinux@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEm+Yuqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgHCU5C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgHCU5C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 16:57:02 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36758C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 13:57:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e6so14262132oii.4
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HyOL9swnCm2XjxDNfnpMpfDtKmLeCrGXu0vM+mpIHk=;
        b=BEm+YuqiN+WNcEsYSi1aA8ppdv81shas+28WEmPTV9eKABp902srfepdqxMhdo9j3z
         J8hLBUBZYlAx6mjIyQSBevR0I5SDNTrMVVYwsrfoppcWhftB3Q56kQv3gd6uOUeuPDXV
         lFwIPSB5V9WxuqAYn6JjsJFZEYVqXA9K5Oxgn1PBJ+KxygB+C/v4KtJO61za6WnWsmmR
         TCnLkxlkHQHT8CvpZoU6U4aZJDr7vo+pLRdwTyu3ycdAge77dGDtCNu94yBwjU0i87Ui
         e4BONzIq47EyeQwgKekSLKnvQIa0V4RkgdFZd+x7gjJbOBuFnpVXn+iRVD34wz6GORSg
         JH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HyOL9swnCm2XjxDNfnpMpfDtKmLeCrGXu0vM+mpIHk=;
        b=BdaU0bqLWMiW+zz3HbyGwuiMgoRFizyb51H/Ct7vrjIPTxIN9BoMD0obUcrKDhGfFw
         EiVPd/FwL4ApuoVs1POkbY7KqC8JE2h+DbHlbFiRiIM/8As/61Eew131OzkJLnOXT+Sd
         lDqYFI9mgzPb0NoM4AayliQNCbEP/JdrgVntgrhANeAeCA1HqM6jpxjlN9KTjXjaDlhk
         sDJ5aumypQBooz0A80BBFo5gOmz9alXj1isxgd92uoR6xsO2OdH2Bf6T7AtmS5ByLzF9
         EsyzZ45KxlPRgDgJbv94hKozWsse5ERprP2ePRKMzH/ePXpDv3XpJQvVErhGj9GwRQrz
         vtkw==
X-Gm-Message-State: AOAM531LTAaPzBElBAozhgPryiJG/1gT5IPJ0rJyIU8LoN4bDs+ageWJ
        DypE6v+f4qtbjg2g2UAGmZ1jh4tR2f+B6kLXBO0/LRl1
X-Google-Smtp-Source: ABdhPJyvEABQ6tpUf73sC5CeiFkjoejG8c5GYzSlcP10LWROhSM1C+QGOrmsrRl2ZCaYnmH0OBQSEQTUKSlIC1IWn70=
X-Received: by 2002:a05:6808:204:: with SMTP id l4mr1042461oie.16.1596488221387;
 Mon, 03 Aug 2020 13:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
 <20200802123421.222597-1-dominick.grift@defensec.nl>
In-Reply-To: <20200802123421.222597-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 3 Aug 2020 16:56:50 -0400
Message-ID: <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
Subject: Re: [PATCH v4] secilc/docs: document expandtypeattribute
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 2, 2020 at 8:39 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added for Androids Treble in 2017.
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: overriden is overridden
> v3: add link to README.md
> v4: rephrase and add another example
>
>  secilc/docs/README.md              |  1 +
>  secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
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
> index f9dd3a76..41f0f01a 100644
> --- a/secilc/docs/cil_type_statements.md
> +++ b/secilc/docs/cil_type_statements.md
> @@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>          )
>      )
>
> +expandtypeattribute
> +-------------------
> +
> +Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
> +
> +Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
> +

I didn't mention the "-X" option in my reply to the selinux notebook patch.

This is like what I mentioned in the selinux notebook, but mentions
the "-X" option.

Gives more control over type attribute expansion and removal. When the
value is true, all rules involving the type attribute will be expanded
and the type attribute will be removed from the policy. When the value
is false, the type attribute will not be removed from the policy, even
if the default expand rules or "-X" option cause the rules involving
the type attribute to be expanded.

Thanks,
Jim

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
> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers. Multiple entries consist of a space separated list enclosed in parentheses '()'.</p></td>
> +</tr>
> +<tr class="odd">
> +<td align="left"><p><code>true | false</code></p></td>
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
