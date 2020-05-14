Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C8C433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649820709
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4fcseNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgENWVC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728332AbgENWVC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:21:02 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03062C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 15:21:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x7so506888oic.3
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oBLt1CDwc08oSTEKL6pcJtKte2BQocr48sj1280prB4=;
        b=G4fcseNd+NekgfjVArmQqv62NYHl1OdW4gpT2pV5oA94XSGpnVWJVBjzsmO20/1Cm/
         0u/y9O+AeBPOPykTZTRajDNGj5bfnhzMsAu0WXSmJfI9O3L4D+FXKCOh/Gvc62oweFVG
         I2+NP0Hnv8pZveBbkst6vgu7Jd9Ih1scynPNzQ/9fENB4tYS/u1M9slpWcrFEHwRmLtO
         H3XMaPHW4mQxy0AHyEkmqzhQpSwNs/gIPcOOiD8q59HpsWLHV7alrH57yZzOYkLYWWSk
         WYORqyBeUWz+gu3GH4nrWZyz84de+EdLKIA4Xp2O4tak6jaDz+uN+4T9sOjr7TkAtEHr
         mdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oBLt1CDwc08oSTEKL6pcJtKte2BQocr48sj1280prB4=;
        b=RE/EPLmdpjxQKesvCLP2t4ju2RU+QsO9BBU/SRyNOxySdc9MjlXrMl3wPmVxjoxqep
         oO/6bNDEwSSaL1QCnXLDLDH8sqN/MPQYjioJSvg9s5OPWWMyfEuA9cV5qNahs+KERgVw
         7Y2VRUOJixlICpm6pvmTd02bNJBf6zaOrlj7CV6zmIJFAbbYzJ13kNpKhc5jwAOkONlY
         klv9CwtHvgCrsa8Zui/6Kwan927EZRPUzvcf6WnE+ekuuohd9Ka9Bb7ZdXQDstTFvidJ
         4q9TeJ4L5ORBfvv45cTJsOCiQ1DKv4S9cyfxRAR3u1mkWRFyboaIKVEzOPrZA1MfeASC
         SGLA==
X-Gm-Message-State: AOAM532D/4QFU8Pk2cyO5Kp/riRV8SGDQAr43HMUiWN/3C5j83LeGsUb
        Ga0U2SYcNoF/Lff2QiLsBfAPOSoSM7M9KnBhBjs=
X-Google-Smtp-Source: ABdhPJz/pDvWzg8BtdrPDjNnUG4QgrqQwUMiqcIDYgkTRDzi+HYH7QR3anDt3uMNJFX+sxCJl74SdjWO5gIhs+KqiKw=
X-Received: by 2002:aca:210a:: with SMTP id 10mr96585oiz.92.1589494861241;
 Thu, 14 May 2020 15:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <3581425.j52oWYpJar@liv> <20200407085922.GA438349@workstation>
 <20200422065053.GA167999@workstation> <CAHC9VhQUmY=ue3zWdTnE1Ehi90Lj3077sLbu+jyaWoAVKuKyeQ@mail.gmail.com>
 <CAFftDdo1hqbacU2TD6zQp_t_KJq-KS5pWBMr89c4HA3=aUdUbQ@mail.gmail.com>
 <20200423150039.GC204116@workstation> <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
In-Reply-To: <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 14 May 2020 18:20:50 -0400
Message-ID: <CAEjxPJ5qm8P0jmRvQNavDsrWCDDf7yCeRQ1orp_S63u-2EfBoA@mail.gmail.com>
Subject: Re: Fedora VM On Travis for Testing
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Jason Zaman <jason@perfinion.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <brindle@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 14, 2020 at 5:03 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> I just wanted to lay out a demo of a Fedora 32 cloud VM image booting
> on Travis with execution happening in the Fedora VM.
> The Fedora VM contains the selinux source code for that particular
> travis build, so it has the PR patches, etc.
> The VM has networking.
>
> The build logs for the Travis run are here:
>   - https://travis-ci.org/github/williamcroberts/selinux/builds/687185489
>
> Which comes from my git tree here:
>   - https://github.com/williamcroberts/selinux/tree/kvm-fedora-testing
>
> Note that it's super messy, I need to go through and cleanup both the
> patch and the git
> history. I also should verify the downloaded image is signed for the VM.
> Also note that I may rebase/squash my git branch at any time.
>
> Petr started a release document here:
>   - https://github.com/bachradsusi/SELinuxProject-selinux/blob/RELEASE/RELEASE_PROCESS.md
>
> I'd like to gather feedback, and perhaps more comments on:
> 1. Is this CI approach worth continuing?
> 2. Comments on the CI scripts (I have no idea what I am doing, common issue)
> 3. Comments, patches, suggestions on what tests to run in this CI environment.
> 4. More information in in the RELEASE_PROCESS.md file. I made some
> comments there
>     as well on ideas.
>
> My goal here is that a release can occur if CI is passing without
> worry, and that
> we automate manual steps as much as possible. This way, if we get hit by a bus
> releases can occur without much effort.

I'm amazed travis-ci supports all of that (especially for free).
Hopefully you aren't violating their terms of use.
The biggest thing I'd add is to build and install the selinux
userspace in place of the stock Fedora versions (sudo make
LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel) and
then build and run the selinux-testsuite to exercise the SELinux
userspace and kernel runtime functionality.  Other things to possibly
add would be rebuilding upstream refpolicy (similar to its
.travis.yml) with the latest userspace, rebuilding and running setools
(but until we decouple it from libsepol internals this will
periodically break).
