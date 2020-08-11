Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3433EC433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E46206C3
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EkMFv/Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgHKPSS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKPSR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 11:18:17 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C5EC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 08:18:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so9189676edb.10
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6FV1NDsedqzs6/2H9GHq4LXSxZuufoe4Jy+m4Q3l1nI=;
        b=EkMFv/Sf0JqKcirGXqYVrknDurTlsgBIwLmuQg8fqvjQBxN9CVj0+npDX7qUgVYiGG
         06vHHvk2jVzlfbE1vaFYhz4ug1HFWixPFFkkdPgsdxVlcMj67nS+Qt1ft69kOCLjLibH
         1phRFBssNAPJSEtx7bJcomEPRtOOKA2ZOQ9d6WwOJKd0ndcQRMOoHsCxQGiMJph+ZIm2
         2fR8L9+G/AOy1Oata69jYD5llKcKhbSakF7o6gb2zPMK4uq8DCUaEaJBWxmXMM1V6Mz/
         qaegrmBtgGp0z12h+UtVQb4tT3BPA22SIq8PaEbil/0yp+gfqC2zUfgVySq0mRjkUAaz
         MvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6FV1NDsedqzs6/2H9GHq4LXSxZuufoe4Jy+m4Q3l1nI=;
        b=YnYWz7oSBBCgz7IedmL86TFaRf7pcPVR7z+8oQ37C8zxs0UKp9VY4U/Gry9w/xGyZe
         ho7VLYyepVcBFh08HWsUJImHb1nSu2INO3tr1pGscXN75w+Kv8Rv8S+xgBCNHAacYOHk
         7hCZFpo2ehoj1+JInyY8nP0rgtMR3mawRVyyCt5CJZBg2O4peIvHB7auwRa+cAKYZtVJ
         fOcsZ/buWigHeVOw/Me4a1LmeDRFX2+6e0KEwkxjW+GjEXZtmPP4ItG+s+0tED+RGLsP
         s+oZZMsv1Dw7pvBzhgcCUhc58Wwr67Tyhyx4yUTm5t5CE3jVnFEbQCfuyvskgskvUq/p
         +8BA==
X-Gm-Message-State: AOAM531wEml6T72Hpm9ISUnxlELogRsyF0gkjcOoriWGMnvwlsG0PX1p
        4VHcHXiN/YCMobBb+TNN2QA5JSS/pEuJ6qQF1DNJ
X-Google-Smtp-Source: ABdhPJyz/ydk1N5h/pW7iE1pa8tQZikMUQlrjxtEf6IvBEDjzkZsWOTLcfV1XHxeZEROfPOXfnvtX22Gz4ZuvJOidSw=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr26175207eda.31.1597159096019;
 Tue, 11 Aug 2020 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132640.1787455-1-omosnace@redhat.com> <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
 <CAFqZXNtogqZXMEcLqA=ci7oiVSYvp0QNvq40zmBJ39B7XpgVHA@mail.gmail.com>
In-Reply-To: <CAFqZXNtogqZXMEcLqA=ci7oiVSYvp0QNvq40zmBJ39B7XpgVHA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 Aug 2020 11:18:04 -0400
Message-ID: <CAHC9VhRs5adeioQuacWkkPZyWh=k2NgUpLWyGhGWoq8+3k6ySw@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 4:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Aug 7, 2020 at 3:42 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 7, 2020 at 9:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > This patch removes the old hackery to test-build the testsuite and
> > > replaces it with scripts that run the full testsuite on a Fedora VM. The
> > > scripts are based on William Roberts' work on SELinux userspace CI [1],
> > > which does a similar thing.
> > >
> > > The CI currently uses a F32 VM image which comes with a 5.6.6 kernel.
> > > Eventually we might want to run on a more recent kernel/userspace, but
> > > even this is already a big improvement over the old CI approach.
> > >
> > > One downside is that with this patch we lose the test build against
> > > refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> > > with refpolicy later on.
> > >
> > > [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Sounds good to me.  Only question I have is whether it would be
> > possible to use a Fedora rawhide VM instead of a fixed version like
> > 32?
> > I understand that may have some stability issues but it would get us
> > more recent kernel, userspace, and policy for testing.
>
> I just posted a v2, which runs the testsuite on both:
> https://lore.kernel.org/selinux/20200811084555.105374-1-omosnace@redhat.com/T/

Thank you.  While Fedora, and RH, likely care most about the latest
stable Fedora release, the Rawhide results are the most interesting
from an upstream perspective.

> > On the Debian side, I'd recommend Debian unstable which despite the
> > name is more stable I think than rawhide and is what I've used for
> > getting the testsuite up and running on Debian.  That exercises more
> > of the tests than even Fedora rawhide does currently due to defining
> > more classes/permissions.
>
> Yes, it would definitely improve coverage, but I'd rather pass that
> baton to someone else at this point.

I've mentioned this before and I feel like this is a good time to
stress this point again - I think it is very important to work on
becoming less Fedora/RH centric.  I recognize that this might be a bit
of a learning curve for most of us as we try to get up to speed with
different distros and packaging formats (the latter is a pain point
I'm currently working through with Debian's dpkg), but I think this is
an important part of helping to increase SELinux adoption.

-- 
paul moore
www.paul-moore.com
