Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F48C4338F
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 14:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C360EC0
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 14:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhHIOBm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhHIOBm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Aug 2021 10:01:42 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A786C0613D3
        for <selinux@vger.kernel.org>; Mon,  9 Aug 2021 07:01:22 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w6so23645799oiv.11
        for <selinux@vger.kernel.org>; Mon, 09 Aug 2021 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM5YTVkYcwKVGOO0hTPIGZj/eQs5oBXxEjLm5+hbyx0=;
        b=mLcvw/TkbI8bUq3h5ucmgC/6QF3y80vGJPzMT72VFc9unZszEhLvHlbI4TsiPyF4xU
         onv7EB7ZFdrs68wYUQ2WnTTCpYrJDVhFREL+3Y6S95RqgEUx10Ga1VNrTH6FTrpG1Fvz
         CRv1usfH4kIVmk7QdjVMyzG+OSBI2Qusj2FjdFRylIXxDbPemy1q0+Viz/Zu1j3IZYOm
         mBSLVjfI21AswuMLGdwlZMn8s1eCTyiFcxekILMBlDszu9qhXOxr4R5ZKDaCqQ8JbceO
         b4xBlndyxXT5JzM8Goz6Sf4y8ChhIjGLEBdpue1dMkVL0NjbJzlV/vPbuXz5ecawluwo
         /spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM5YTVkYcwKVGOO0hTPIGZj/eQs5oBXxEjLm5+hbyx0=;
        b=hiEj9KsVDcG3qUCsc9F3RFxJj4zGaB7nGPAUGJE9UMDVdNFAFxXC0w4oHtYxm7rWJk
         xQvTJyoO0QXJKlDGwaNfuTMEIAG7XTC7ohkDqmBTYWdqsXQJwaE1496BavSoENkBRJd4
         EFtqTiPnneCuQ1pHsABbsBGTjGR/iEoH4WXkfZ/EVBZF7Yd2sqdTy3Iv6tehto2S8FEz
         7DIJIrbCAncqdsGiYeRTXc+Je+/S6p2b6mIli/IvT2bn9jfrv4E72d8YFmqKTmrnIOV+
         zm1cqluTk9MgBO7r7C5Z/2dARS84A6swMnlKO+6rD53E64rfktDhEpASKEGgbjmvYhEB
         DIvg==
X-Gm-Message-State: AOAM530dZ7aJXUIe9e6mGicB4g0yfKXl1rQaG3nsz10DDH2f1RjKAwrL
        /NRr2agvwWGtKTFt5REotCRYzNLNJopBZAzgceE=
X-Google-Smtp-Source: ABdhPJy9Y1LrvjFgVMF1k8rJ7jof6VV1EdXVIpzdckAGGKdjZE9PZiKumBMGW4Io9zJNAqXAw+MTJpZn0SjDrkm3c8o=
X-Received: by 2002:aca:4b49:: with SMTP id y70mr15758419oia.16.1628517681464;
 Mon, 09 Aug 2021 07:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <87fsvmu2xa.fsf@redhat.com>
In-Reply-To: <87fsvmu2xa.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 9 Aug 2021 10:01:10 -0400
Message-ID: <CAP+JOzRb0vE94arDdF6SxB3Mn-82+ztRi0OjyGRzqjAd3=ck_A@mail.gmail.com>
Subject: Re: lets think about 3.3 release
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 6, 2021 at 2:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> I's about 184 commits and 5 months since the last release so I think
> it's time to slowly stop the development and start with 3.3 release
> candidates.
>
> According to patchwork, there are few patches in queue which need to be
> reviewed, or which were reviewed and some change for requested:
>
> * https://patchwork.kernel.org/patch/11436955/ New [RFC] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability
> * https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir
>
> old, without any activity for a long time
>
> * https://patchwork.kernel.org/patch/12291637/ New [v2] checkpolicy: fix the leak memory when uses xperms
>
> changes requested
>
> * https://patchwork.kernel.org/patch/12372487/ New [v2] libselinux: add lock callbacks
> * https://patchwork.kernel.org/patch/12377593/ New libselinux/utils: drop requirement to combine compiling and linking
>
> no response yet
>
> * https://patchwork.kernel.org/patch/12420657/ New [userspace]  libsepol/cil: remove obsolete comment
>
> acked, ready to be merged
>
> * https://patchwork.kernel.org/patch/12422971/ New mcstrans: Improve mlstrans-test output
>
> no response yet
>
>
> if I missed something please tell me.
>
>
> There's one issue opened on the mailing list
>
> https://lore.kernel.org/selinux/874kc57220.fsf@defensec.nl/T/#t -
> libsepol regressions
>

I am working to address this and hope to have something out in the
next couple of days. I am also working on fixing some issues with the
line mark stuff in CIL. It would be nice to have both of these in the
next release, but I don't think they need to hold things up either.
Jim

> If you agree and there's no obejction I can start with preparation and
> plan to release 3.3-rc1 on Wed Aug 18 2021
>
>
> Petr
>
