Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D8FC4167D
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382563AbiDDVbR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380559AbiDDU2C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 16:28:02 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681225EB8
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 13:26:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n6so8343702ejc.13
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=i30RAWebMxGwE1hQiCK7U4/sgg0OEvx0aToZSQekNtU=;
        b=44lc3nHVQ/9Iqx4YJs3pqLPIr2201+yrwxcJqX66nVq3DncSRh+OFwDzpN2TlgzMZ/
         NWnpw9mhOKBextEtmA7qiWt9fY4Zxy0uNj80/iKyWjRrE0nRa6fFhAl0wB4Evhr3I1qn
         +8ORNQGWNE5JIA2DvsnrzWLsurt2uYYw57wv9Av9OghkinCrDEXwvBFUflyNRQoVQNPI
         E0woENcm0NJYliezByt0EA2fDQjXsCLm/QF1FrPWm7zjeN0RAB8EL0nZrBa6tqMoKsIs
         e+G+RTEIFwBcLUzYOU6HMctHHtKqbdQsUOgxWafnYxdyjjBMhSVzsEKR9LBBD8P9FLLo
         wh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=i30RAWebMxGwE1hQiCK7U4/sgg0OEvx0aToZSQekNtU=;
        b=l8Jumx0Wd0bYabTLVYLTq5vLVpoiYUQ1z3KsEuJzAnjKD46btKyeLZvXYPWdrxYaN+
         AolIZjgt51Hf9j79+ZNSYuZmYRezIPflfmJiNJtq0ExUrF385bHLJEgr4mYypUSYzYhc
         7JSlNNFHROowh11ouvU8AFVDhOAZW4lzYTjEE50dmzEHW/uUCP8W9i3a8/AF8tU1BzpN
         Bmu88RrHwSDTLsOW2VMGeYCOICJufN79MltrWHIkIRNQXSLhnX0qEIeCP58WYmdGyzVg
         UJq86RwPW+0hcy+3ZLdSjbpOjgEbCTfAgwRrxlf8OMEHqsN1GYnNsAXJsFxcP//upLn9
         aZvA==
X-Gm-Message-State: AOAM533RfHQdX2r4/mMt/8/4t6SDl1GaPQDxX2fuEvmL/DmcGygtzhnC
        fHGltAE2WBr0nEdocTq8iV5DPmJRO6t21WIgPijbwoU0zw==
X-Google-Smtp-Source: ABdhPJwo3430AdAzVzi/dp5QQClguiBa3ABjHOCEChpKyi/s4Hqf19Z3mBEMRj7aG4m7a/SV4C06bpdZ1AqlB8S6w0o=
X-Received: by 2002:a17:907:3f86:b0:6db:b745:f761 with SMTP id
 hr6-20020a1709073f8600b006dbb745f761mr1819378ejc.610.1649103964150; Mon, 04
 Apr 2022 13:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <164677751730.170741.6493351205403681020.stgit@olly>
In-Reply-To: <164677751730.170741.6493351205403681020.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Apr 2022 16:25:53 -0400
Message-ID: <CAHC9VhT9nMvEkyBrU4rX2amVT+wXJwRD=cKuFc_5K4Bz8+4VYA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: checkreqprot is deprecated, add some
 ssleep() discomfort
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 8, 2022 at 5:11 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The checkreqprot functionality was disabled by default back in
> Linux v4.4 (2015) with commit 2a35d196c160e3 ("selinux: change
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and it was
> officially marked as deprecated in Linux v5.7.  It was always a
> bit of a hack to workaround very old userspace and to the best of
> our knowledge, the checkreqprot functionality has been disabled by
> Linux distributions for quite some time.
>
> This patch moves the deprecation messages from KERN_WARNING to
> KERN_ERR and adds a five second sleep to anyone using it to help
> draw their attention to the deprecation and provide a URL which
> helps explain things in more detail.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c            |    4 +++-
>  security/selinux/include/security.h |    6 ++++++
>  security/selinux/selinuxfs.c        |    4 ++--
>  3 files changed, 11 insertions(+), 3 deletions(-)

Merged into selinux/next.

-- 
paul-moore.com
