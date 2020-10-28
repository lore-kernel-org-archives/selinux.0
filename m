Return-Path: <SRS0=BfnB=EE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ACBC388F7
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 01:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356E82071A
	for <selinux@archiver.kernel.org>; Thu, 29 Oct 2020 01:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lL+kiK7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgJ2BE0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgJ2BEZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Oct 2020 21:04:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D04C0613CF
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 18:04:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so955912wrq.11
        for <selinux@vger.kernel.org>; Wed, 28 Oct 2020 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oolgt33PMh+T/hOklmS2wmZw0YTFglRzts0lARs0PM0=;
        b=lL+kiK7w+EkDfFmp9q4bS+hLokwpIj/pkgi2pmwG2qTmNKY/iAFvbUXjqH19/6gxrf
         oHH8YgRVYg6ZKVQnswz3PY8D7K9y4dwCD46YlmMLZqa26FfSOrVwTFp3v7eVcBC25o/o
         mjTj/CeEkZSkpkEdvbafvyioYT8eBYWor+cWdieknFQH0zyVh5FhnZzDKzbREUBaYSGQ
         RZ1752HjovqMbh1emcw4PUAqo7dkjLGYGXym7JaCaskbhtPjno66e85BBqyA/sLPbrVX
         oL6Q8O6p/t/PSX96HN9EsIQKF9rOfva9WXp/8R9kfpOnTsByAcbuW6/HhEQkUeAt9jY7
         ny2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oolgt33PMh+T/hOklmS2wmZw0YTFglRzts0lARs0PM0=;
        b=NdTIcpMxtjsWmSeVGBhT1hIXKKEOsiIduffUa11PhgzD1Q0+MjfqgB9XS8fF1xilGS
         utF83P4/YKHx1KjVXc12WXbkigc012fbm5KGk+wIgyOR/DE5MmwGgzIr0CIOSid0t/Un
         sUyILcy1UBz+J/yycx485oPzlk5tJQbMLasGwFAPOnBwz0D+SeUXxJ8oE1xyspUFu4hh
         0LGr3J9yafFoTJC2X5iPw0voOvdr6G8wXkaL73VZRpyqJ9mmrNTBzpazM66G9gAoCdU4
         EDkCPBg6K/SsusoFHZkBhMBq4mMt0a7ZDlQ8GYifaKk+LpVtgM7pjFhrg0sxJItO1FBV
         GO5w==
X-Gm-Message-State: AOAM5315RQDceRAnNOOyzbOXGfC3sjB1dmgKKVl4R34F8PcyyoC37LOO
        85yPFLzq8/6PfA8pkHYT15TnCR/hSRXpCDu6s/795VDkgg==
X-Google-Smtp-Source: ABdhPJzPx/vSJ4s9zHJ7yRK9EXFpbtkvD/vqufLR76h8VRT08FmRyz5a9MxaEv35J+zga1QJhP9OPgzv3qZrq26Q2s0=
X-Received: by 2002:a17:907:72cd:: with SMTP id du13mr101356ejc.398.1603851437517;
 Tue, 27 Oct 2020 19:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
 <20201009013630.6777-1-rentianyue@tj.kylinos.cn> <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
In-Reply-To: <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Oct 2020 22:17:06 -0400
Message-ID: <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     rentianyue@tj.kylinos.cn
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 8, 2020 at 9:37 PM <rentianyue@tj.kylinos.cn> wrote:
> From: Tianyue Ren <rentianyue@kylinos.cn>
>
> Mark the inode security label as invalid if we cannot find
> a dentry so that we will retry later rather than marking it
> initialized with the unlabeled SID.
>
> Fixes: 9287aed2ad1f ("selinux: Convert isec->lock into a spinlock")
> Signed-off-by: Tianyue Ren <rentianyue@kylinos.cn>
> ---
>  security/selinux/hooks.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Merged into selinux/next with some minor tweaks to the comments.
Thanks for your help!

-- 
paul moore
www.paul-moore.com
