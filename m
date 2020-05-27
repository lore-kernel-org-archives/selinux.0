Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55E7C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8702084C
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 14:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOwD/Vr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgE0OXK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388660AbgE0OXK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 10:23:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31DC08C5C1
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 07:23:10 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so21808099oib.12
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Id4db4SWKtJnciCmXLf6a9Pc9Dc1IsjCTWSnvyfHoY=;
        b=bOwD/Vr4sytIvlKZrXjQ5/0m7bx5r25HASCTlXycvH3bUsMAo7M/pSJd6ODo0xTPc3
         nvzLS2Rh2dedL17GxjShk42DgmMZhutftiT/NUjfWeFNv+PZRxf5wpSAm6188q7Q9Gt5
         zHzS8tEfRc1Y2ob05bix0FGUjZkzEVNBje+4zABaROnou8rtrqUgtx96a6uf5AwxzK8l
         NjnFeKnS28Av8TNr3FcgJE3K7+S+2r8tanidtYk+gWp6bUj9QBD9gwQl8q1ArtveiNDu
         +WT9T6LP8kIOVhD4pkCPdJKHzc/B3DMhfUh5ZrAtgYR9hUQhM54VRhOynYG7Vip2WoIo
         NYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Id4db4SWKtJnciCmXLf6a9Pc9Dc1IsjCTWSnvyfHoY=;
        b=GBWbrc5ApexxzZyB38+jQxHpT4nLiXbJt50tXCn1qPJwf4IEGLt1dWT6u7P9b7cHLF
         M4tQzjm2kVrXeryCG70O9GqShy4/OiHo0UljrsGjmSCUJIolOSgjbap6OfvVWWQtVORm
         CDtdKSAQKBP88f1x/yn3phX5XbXS4gC589h3DxqOQa2CnQJiVIGfjnUbHdxz1hHp43m5
         fnf4TmBx3wjoQ/Ws55CVi9zOSfnqcB6aaZDu21D9SqDz6E1KTibyLVzmlf7MT9AEeAut
         fKFkBMtO9qZqckddS1yTyOMHhkV0HQTpUb6SDbC70mmLqn6fb/tSTX6vu5luC58ZT10g
         /yfA==
X-Gm-Message-State: AOAM532TOVS0Zr7esTtsxcjxrIe3ABCE4Ss+0uhS3hCj7xSAHyEhxzim
        e9VRiUlecA+5PQoaF97DlaHk4E+kNLSGIZs4Gug=
X-Google-Smtp-Source: ABdhPJzcbJakVHhtsJ4sEpwgG53q3qylD3gz8iBi8wMNaYThH8KVwxP7dOEyQqCfx1ulJUoRdvwjNm6oYQ/KtSKLNNI=
X-Received: by 2002:aca:a948:: with SMTP id s69mr2891952oie.140.1590589389456;
 Wed, 27 May 2020 07:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200522145038.194209-1-jwcart2@gmail.com> <20200522145038.194209-2-jwcart2@gmail.com>
In-Reply-To: <20200522145038.194209-2-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 10:22:58 -0400
Message-ID: <CAEjxPJ6FBrGviZVjGQE=-wfVsetubcKfM-FTTqpAp9ZnCF_geA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol: Fix type alias handling in kernel_to_conf
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 22, 2020 at 10:55 AM James Carter <jwcart2@gmail.com> wrote:
>
> Type alias rules are not written out when converting a binary kernel
> policy to a policy.conf. The problem is that type aliases are not in
> the type_val_to_struct array and that is what is being used to find
> the aliases.
>
> Since type aliases are only in the types hashtable, walk that to
> find the type aliases.
>
> Fixed the syntax of the typalias rule which requires "alias" to come
> between the type and the aliases (ex/ typealias TYPE alias ALIAS;).
>
> Fixes: 0a08fd1e69797d6a ("libsepol: Add ability to convert binary
>        policy to policy.conf file")
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This fixes the missing alias problem, so:
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

However, in testing these, I noticed that if I do the following:
checkpolicy -MF -o policy.conf -b /etc/selinux/targeted/policy/policy.32
checkpolicy -MC -o policy.cil -b /etc/selinux/targeted/policy/policy.32
checkpolicy -M -o policyfromconf policy.conf
secilc -o policyfromcil policy.cil
checkpolicy -M -o policyfromkernel -b /etc/selinux/targeted/policy.32

then the three policyfrom* files differ in length and contents.
Decompiling them all via checkpolicy -MF (or -MC) and diff'ing those
(since sediff takes too long) appears to suggest differences from
attribute removal (odd since I thought you reverted that), redundant
rule removal (isn't that off by default too?), and portcon ordering
(by protocol).
Optimally we should able to regenerate the same kernel policy from all
three (although we might need to run the kernel policy through
checkpolicy to normalize ordering).
