Return-Path: <SRS0=5TXQ=P6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A360C282C3
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086E221019
	for <selinux@archiver.kernel.org>; Tue, 22 Jan 2019 17:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="QpxaKQSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfAVRkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:40:04 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35818 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVRkE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 22 Jan 2019 12:40:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so21437504ljb.2
        for <selinux@vger.kernel.org>; Tue, 22 Jan 2019 09:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2NhWL7AenJ+FQPbVnLmNMbTigvwRnka8Wtd5bfnLBs=;
        b=QpxaKQSqoAA9qBcQivSfljeztA9qt7LRNGfKdymFvdMy6uv/cjzthty8Ee5GuSbZ3v
         TUuWAJDK4J1ecXJTmT3wzkOBsVRYMTQthEGREiMMoYyzOlowPsTV7irMZTYGkcH2Wyiw
         s8O3qbnaDkhFhzlAKxZU8MBfIM1SmOiq1Z+Em9tyuDap3/U0GP1Epb5C+EIm7f9fysQr
         Z86Rw/g4dQ98wQPq5oGrQuMd6tMEx/smDkjaKg5WKPsOJL8bX0wOdPT1CRNgUbEUWGLr
         4QQOMh8yDBZ/T+3UdbXcNoM7s++W0SIMPFOJiMeLoMDmdVS30XDwtCXrzln3ZgrlS+1Y
         PHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2NhWL7AenJ+FQPbVnLmNMbTigvwRnka8Wtd5bfnLBs=;
        b=OQajQJp1skNXGAK6TbUWKCrQt77gkA2FWsHAZ1/uUypNI8GT0aHpoGVW2cYRBhKo3X
         pooIXg/pC/xZ82YYH4FEkI3OvI2up7tqoo/3m1wagDJKfAE9qU1umcWd4Dv6n0SpQ8qF
         sp7FcfJnZ1b+qkqo+G3ualvQwmWcGgSxIaYG6W8rSAHpIPnZbst3V0nMozELmC9fXSM7
         dxPp7+woT35J5bvQ2TwwPxwqIht8gcFbGNDDDcDqiFbSC5g+N2Fx4VH6a8qxh8F2rgIo
         1iI8FpfOFGBUVLr9OECxK1eFjhWUDG8aWGmPmzeiiMXX0mtLYDj+dyZ1Fd7qyM6G5VnB
         NcZw==
X-Gm-Message-State: AJcUukefbLxLmVyf2h0qhnzvRalKiscn9buIIJu4Tms68zWrg3R8c2xS
        2A6jQNmRwmvd5p2EKEMnJ+Nx8JTLklU8m/RZbxVM
X-Google-Smtp-Source: ALg8bN7R76bWFvapHD/upKysy2kuEAoHH1JSR6p7SKD8ECW8W0t+AV4PVa4mC8n8X8E7wdMlMf/LhwrENbVuT+OMpKY=
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr6609655lja.169.1548178802090;
 Tue, 22 Jan 2019 09:40:02 -0800 (PST)
MIME-Version: 1.0
References: <1547821427-157169-1-git-send-email-weiyongjun1@huawei.com>
 <CAHC9VhSbtqhiMQdNJ_6yeX5+ggwVNyGYXe-E=bMj2V2z2MmAsA@mail.gmail.com>
 <20190119112148.375edf4c@canb.auug.org.au> <20190121070410.1c90552f@canb.auug.org.au>
In-Reply-To: <20190121070410.1c90552f@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 22 Jan 2019 12:39:50 -0500
Message-ID: <CAHC9VhQTv=b_sLOdTQ9v1Z=0=Uf2JG74ZEw4yof-GsKuu9-s0Q@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: Fix error return code in policydb_read()
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jan 20, 2019 at 3:04 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Sat, 19 Jan 2019 11:21:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 18 Jan 2019 16:28:07 -0500 Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Fri, Jan 18, 2019 at 9:18 AM Wei Yongjun <weiyongjun1@huawei.com> wrote:
> > > >
> > > > Fix to return a negative error code -ENOMEM from the error handling
> > > > case instead of 0, as done elsewhere in this function.
> > > >
> > > > Fixes: 31696241e96e ("selinux: convert to kvmalloc")
> > >
> > > Unfortunately this commit isn't to be found in any of the SELinux
> > > branches, or Linus' master branch; based on the subject line I'm
> > > guessing the original patch is in a -next branch somewhere.  Please
> > > find whoever pushed this patch to linux-next and have them apply the
> > > fix.
> >
> > Yeah, Kent has a series doing conversions that is in Andrew Morton's
> > mmotm patch series.
>
> I have added that patch to the akpm-current tree in linux-next from today.

Thanks Stephen.

Wei Yongjun, have you talked with Kent and/or Andrew about getting
your fix added to their tree?  It's good that Stephen picked it up,
but it needs to get added to the original set of patches so the fix
makes it's way into Linus' tree at the same time as the original
patches.

-- 
paul moore
www.paul-moore.com
