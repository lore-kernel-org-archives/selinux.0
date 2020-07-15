Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200CFC433E1
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 02:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D4A20663
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 02:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TEA2OYHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGOCPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCPa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 22:15:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A6C061755
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 19:15:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so453696edy.1
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 19:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DsEbxxygEeOQtVBt0sQvtxaWBN7+XAvhjVWy/UbvPc=;
        b=TEA2OYHoFyxOsXwUR4ew1KhcVHGAUTdmHvicsetPpvOXIdMncjjrhI8Hhan/Ngrhxc
         PhehTA+IPJ+HrW9q/oQ2T4+nTvjAtlV9QyhClBwGhtZKogmSCah7XNLigoKTWiWd/iCp
         somGTEc3Kw97AFh1jXsdLjzNKeGFKtVhp3SrBDNHKrper5AeVNmdpK+LeNGG8K6mPWFH
         3HHjl+Yw/dlIhCFq6870v5LgJ32n/lbP2AjCzbrVdk1V+1Io54MgnVTxsmlBa/z6zeXT
         cLKGpM6xwbj6OSazELpvoDngHx/JNBLL/+TnksffV5botMpkbLF0+UYCKvRa/+VJQ2Ph
         gITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DsEbxxygEeOQtVBt0sQvtxaWBN7+XAvhjVWy/UbvPc=;
        b=Per/LD2jCCFK+nGSS0ztlGfumnR6+3MvmV9J+KLTSGFWnBQFye5dynANe4gAilQ64B
         KyPPxmDxoKzD+8HwJt1/dmcAT9r7K5RJJW7T1Gw9gFrOps5cLjgfKW2IUAo7rxQ9T8Yq
         CcU4ehEZFBsCuu8Igqck4rMRjLCtrNVY57PL1bt8wG+i4DGf/Z8X5Hjnq2dt+hJHrSaI
         vIil0BR+rnjy2lFRbWyQWmXfvxhC5OQDAIFsnDUe8pWfkYtCD7Opw8dAf99rqv6ryyEB
         JQfbMc1fS+Fxgs3JoFPPxC2NNfUW/DDR+nVhZkDpU6KaeJy2JYq8/UA8gQpmSYvOqmjK
         RnjA==
X-Gm-Message-State: AOAM530Xso1aVH978c4QPSoUAB7pAEiGOlJQPAzzZNCIQaDiIoI+sYLl
        ElDUJwcuLOvR8x/hyLbD2Bo5SXig7zDhz5tQOHpmSRM=
X-Google-Smtp-Source: ABdhPJz2GiKR0bdId1y7jtGkG0Ll8i8hdk3iRoHtUhyk3lvjRUTcTwRd8BDhBm+17qHpCvmohLMZSrQtP89q7Kw3M9A=
X-Received: by 2002:a05:6402:742:: with SMTP id p2mr7109680edy.135.1594779328108;
 Tue, 14 Jul 2020 19:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200710070903.106482-1-dominick.grift@defensec.nl> <20200710071431.107444-1-dominick.grift@defensec.nl>
In-Reply-To: <20200710071431.107444-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jul 2020 22:15:17 -0400
Message-ID: <CAHC9VhRNWLQAVzOnei5Hne8k7nXQkoQkY7txBov_rNMhKHNCFw@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v2] objects.md: some clarifications
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 10, 2020 at 3:14 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> v2: fixes patch description
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Thanks for the patch, but just like any other project, it would be
nice to see a patch description here.  You can also move the changelog
portion of the patch below a "--" delimiter so it doesn't get caught
up in the main description (changelogs aren't quite as useful once the
patch has been committed to the tree).

> ---
>  src/objects.md | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

...

> @@ -269,6 +275,20 @@ and manage their transition:
>
>  `type_transition`, `role_transition` and `range_transition`
>
> +SELinux-aware applications can enforce a new label (with the policies

As someone who is barely fluent in one language I hate to criticize
others when they are writing in their non-native language, but I think
this should be "policy's" not "policies".

> +approval of course) using the **libselinux** API functions. The
> +`process setexec`, `process setkeycreate` and `process setsockcreate`
> +access vectors can be used to allow subjects to label processes,
> +kernel keyrings, and sockets programmatically using the
> +***setexec**(3)*, ***setkeycreatecon**(3)* and
> +***setsockcreatecon**(3)* functions respectively, overriding
> +transition statements.
> +
> +The `kernel` and `unlabeled` **initial security identifiers** are used
> +to associate specified labels with subjects that were left unlabeled
> +due to initialization or with subjects that had their label
> +invalidated due to policy changes at runtime respectively.

That looks like a good definition for "unlabeled", but it doesn't look
like you've defined the "kernel" isid?

>  ### Object Reuse
>
>  As GNU / Linux runs it creates instances of objects and manages the
> --
> 2.27.0

-- 
paul moore
www.paul-moore.com
