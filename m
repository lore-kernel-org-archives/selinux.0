Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B0C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 21:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9432021855
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="p6BTchqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfAYV7w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:59:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40546 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYV7w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 16:59:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id n18-v6so9596427lji.7
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 13:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/B7FYdvgA+4dwG8U92oX1OJ+1iRHNpW6/b5sSyTcVo=;
        b=p6BTchqrxGXR7dCD9A6GZVdJraS0iOLPwdOhUnVeR+FIdJJ9Ax9jm2BVPDJ9/6Bh3G
         uJUIfr8EqYST5Ppl92b/hdo6j3aR0gZ9i+mFsv8QcAKfZgo6gOYVQJAwpNdC8lz4YKjx
         QZNcsxQ/+wlScoTbRZfxA0NMbgNYS9Zbkxi07VMpPY+Uabmlwp5m0xkVYjGQwt2P+clD
         C/ExISWLUyNqeuN14+tAsnkK29aAPeXiocwmKzti4DhwCn3kZqGFy95sUWxuwx7xpovH
         CWwA2eNPjodLUyXpQ5PSLon/noFc2Bezlq2c5s1zdZb2K5Ca4wikl8D/nDgmbqDekoDg
         5Odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/B7FYdvgA+4dwG8U92oX1OJ+1iRHNpW6/b5sSyTcVo=;
        b=KLDvzAc6FQo4XZVbaWnrQYQ/yrrfaXId5Imq2ceklK6tVudTMix6KCOK+XwfK4O0UE
         acUWEWxeVU2LioXxLQF5CqVh9Feov+AbewD7kRyhLea8sp18KayLdcP7xlAKoNzohi0s
         jWw4op/vp9/lLV8B7Yt4GQTyblxQEyAc1Vx6m+2pLyGn4oZps4F9EZqDPin9BCJjPzKO
         nasqMeufGPMdbwiIJZWwc0+WafldAkY9Z2g2fQg+u8Sws8Qthxv8dyzIeprd/9ZPxs7d
         cH0JebEtw3flvB9URpsTMz6PHDgW8h2PY62rJINs+TeWKn9zjYzPT2KomKcdHi2dRwEl
         Ex/w==
X-Gm-Message-State: AJcUukc5km5/FDGvXTJLlX05eFzH8hqmZZXuwOObYJw+erZ9JdH/PUqi
        8x1J0YN2Xg8u0F+OywKtNPNkoZuVgp4qJVBYDac0
X-Google-Smtp-Source: ALg8bN5+RMG+T5t9XtNbrAptTzPuOrXYtikRe23map2lOgDjiNblSU+9ZEZiKrES8lOVAxGxd+AS7bPHIeBq+zzGE/0=
X-Received: by 2002:a2e:9c87:: with SMTP id x7-v6mr9718361lji.196.1548453589735;
 Fri, 25 Jan 2019 13:59:49 -0800 (PST)
MIME-Version: 1.0
References: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
 <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
 <20190119112148.375edf4c@canb.auug.org.au> <20190121070410.1c90552f@canb.auug.org.au>
 <CAHC9VhQTv=b_sLOdTQ9v1Z=0=Uf2JG74ZEw4yof-GsKuu9-s0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQTv=b_sLOdTQ9v1Z=0=Uf2JG74ZEw4yof-GsKuu9-s0Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 16:59:38 -0500
Message-ID: <CAHC9VhQoZDBLrxawkk-K75hizBNKF6gLw1fcnZ7F5wbV6PJn7Q@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix error return code in policydb_read()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 22, 2019 at 12:39 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Jan 20, 2019 at 3:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > On Sat, 19 Jan 2019 11:21:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Fri, 18 Jan 2019 16:28:07 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Fri, Jan 18, 2019 at 9:18 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
> > > > >
> > > > > Fix to return a negative error code -ENOMEM from the error handling
> > > > > case instead of 0, as done elsewhere in this function.
> > > > >
> > > > > Fixes: 31696241e96e ("selinux: convert to kvmalloc")
> > > >
> > > > Unfortunately this commit isn't to be found in any of the SELinux
> > > > branches, or Linus' master branch; based on the subject line I'm
> > > > guessing the original patch is in a -next branch somewhere.  Please
> > > > find whoever pushed this patch to linux-next and have them apply the
> > > > fix.
> > >
> > > Yeah, Kent has a series doing conversions that is in Andrew Morton's
> > > mmotm patch series.
> >
> > I have added that patch to the akpm-current tree in linux-next from today.
>
> Thanks Stephen.
>
> Wei Yongjun, have you talked with Kent and/or Andrew about getting
> your fix added to their tree?  It's good that Stephen picked it up,
> but it needs to get added to the original set of patches so the fix
> makes it's way into Linus' tree at the same time as the original
> patches.

Wei Yongjun, any progress on this?

-- 
paul moore
www.paul-moore.com
