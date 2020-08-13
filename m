Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F105C433E0
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 01:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CB5206B2
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 01:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="VOE7oLDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHMBEu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMBEt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 21:04:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294D2C061383
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 18:04:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so4337732ejb.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 18:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p07eqokcg0MocP/2io56zFkise5a2QbJtcqXhDQoyxQ=;
        b=VOE7oLDQgseYPErN+oJMDsL0mlhivQwWaf3RniMUh8gCoWa80rP5D68lHpcneXeGBn
         VAeYm7SifVbaBP4W4qpAsZfM0g2Svg+JV1gl+aKbL0T+VcRapRGT18yr2yFMJS/5K6WP
         EkOqxRFiGNs9yRUrZN3uns4rNa7lVUECQewQnKlB0DXzqALjTQWzl62faRHO2KKmIP7e
         1jbG8aF3+ebyMznbInN+EsycfgIr85airPPzQuftPtwz5QExV3RMifTOPaLI/lGh+QB4
         UzZVXMfRIKyWRVT8nyxt6xF1Iul0jQ7dQVGeT6JNZy6pRfpmS1eJtc5dFrClqgcPUcEu
         kltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p07eqokcg0MocP/2io56zFkise5a2QbJtcqXhDQoyxQ=;
        b=OW0u2C9lecqwun/gLFLHaY8ezX/OKxYta1OBoZQ1a1lDXf4HxavGW7BTWU44jcrKgP
         yE6tAbkVOVRPXr6O4V24Hmf3EStgMCA7Ngg7rPLja5vSW3t8zOvNRhe/lU/llG122NN8
         5zcRNAA5BCc9fJuq54UX6UYzt2kKcgJwhyFUcmqmzd0j04lQDPSG8xo68q209dMTsK1d
         DerKLwd1uCA3QTw/67581ELS8wAffC8iCzulmZ5HaMasAIYVp9Z5VObQw7iiPJItxU/E
         ZtoS5g1PBNATX2ema8S3Ktnl5wCGtPSGkhDE/hlOkBHpDCx2hxtz6PTLjN1o+ssvyV4y
         l1XA==
X-Gm-Message-State: AOAM532ZyMNeIO8LsLURBOg7ORc43TrFdZ6p5ernj2xbYaBSordZgHhS
        MgFGHKlWaWv4q2hPjOfJRMY6BPvFlO9OmjO4jyde
X-Google-Smtp-Source: ABdhPJxdRVqB3V9ReAYEnqWTHIrty3cg36e+ch+i2b3YLQzq4yAPQSWhqyEB8iEZjCfTwWIg7uOBT9ezjXsPBAlYMf4=
X-Received: by 2002:a17:907:20e1:: with SMTP id rh1mr2445284ejb.106.1597280687676;
 Wed, 12 Aug 2020 18:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132640.1787455-1-omosnace@redhat.com> <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
 <CAFqZXNtogqZXMEcLqA=ci7oiVSYvp0QNvq40zmBJ39B7XpgVHA@mail.gmail.com>
 <CAHC9VhRs5adeioQuacWkkPZyWh=k2NgUpLWyGhGWoq8+3k6ySw@mail.gmail.com> <CAFqZXNtKMwMneGEdVd+cZGTxK8Uu02JHkGGyNDTdzPFkCHTsXQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtKMwMneGEdVd+cZGTxK8Uu02JHkGGyNDTdzPFkCHTsXQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Aug 2020 21:04:36 -0400
Message-ID: <CAHC9VhTcoMH71p9QwQNwKaVdbKZ4c3mwfnzoHBiWvEfJ_N2wCA@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 12, 2020 at 4:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Aug 11, 2020 at 5:18 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Aug 11, 2020 at 4:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Fri, Aug 7, 2020 at 3:42 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On the Debian side, I'd recommend Debian unstable which despite the
> > > > name is more stable I think than rawhide and is what I've used for
> > > > getting the testsuite up and running on Debian.  That exercises more
> > > > of the tests than even Fedora rawhide does currently due to defining
> > > > more classes/permissions.
> > >
> > > Yes, it would definitely improve coverage, but I'd rather pass that
> > > baton to someone else at this point.
> >
> > I've mentioned this before and I feel like this is a good time to
> > stress this point again - I think it is very important to work on
> > becoming less Fedora/RH centric.  I recognize that this might be a bit
> > of a learning curve for most of us as we try to get up to speed with
> > different distros and packaging formats (the latter is a pain point
> > I'm currently working through with Debian's dpkg), but I think this is
> > an important part of helping to increase SELinux adoption.
>
> It's not really about Fedora vs. Debian ...

The point I wanted was that it shouldn't be Fedora vs Debian (or any
"distro A" vs "distro B" for that matter); we should be working
towards supporting all the major distros equally well.  I'm under no
illusion that this is going to happen overnight, but I think it is
something we should keep in mind as we move forward.  Individual
developers are always going to have a favorite distro (and many of the
developers here are paid to support a given distro - I don't want to
threaten anyone's livelihood), so I recognize some distros may always
get the new features first - and that's okay - but let's not forget
the other distros too :)

> Anyway, if no one picks this up, I most likely eventually will. I just
> wanted to make it clear that this is not on my immediate TODO list and
> in case someone would like to pick it up, they are encouraged to do so
> and won't conflict with my attempts. I'd like to see it happen as much
> as you do, but right now I need to catch up with other work so this
> will have to wait a bit.

Thanks.

-- 
paul moore
www.paul-moore.com
