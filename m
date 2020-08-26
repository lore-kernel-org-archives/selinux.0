Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A9C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29ECE20B1F
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+klA8PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgHZNCh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730137AbgHZNCf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:02:35 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715C6C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:02:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k2so1399147ots.4
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpKVR4S+imAZuQGf8A4QbvA3spb9nVKsNqcPyk44Ees=;
        b=n+klA8PGmH9glBDs3/z9qFkjEpKpK1EKurWrq6XQbtmQDI0QE3UclOyEH1d6cgGOif
         Rou7aadWRDA1Fg9zRI70ejorEX6JWMA7LKwbIVo3ZGR3QTpiOGBHmokPwEOPltKU41b/
         Ub05Z3Z2BstphMcRPLjJ6BBf9JzOymCF+FMxbb0HDZyOgXJxEUNu1LIULNkgXCi3X3U6
         UdzPrGLUUgGZTSl6Uz6uGuaInHrB2Kn9m3YVOJbpx61QNBcaqJzJy9Cxw/+eXg/VnPWz
         aZCfKyWH30AFSCDoSaBfRV4nRrcxYuDLlRvw1gun4YbMCvIiMYaDxShfoz/juJUP+dJR
         XAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpKVR4S+imAZuQGf8A4QbvA3spb9nVKsNqcPyk44Ees=;
        b=LzS5wt6gUs2lT908GcYHp8kxIBjbrSa7wGgmlbqlLGCYc+r5fpBjo/yWDWhQphNf4K
         QT9zlZSRonW+DINAd5eMvcg82k8LRZPQSvv+gvtgrS4S/DLjH6uxnVM6LY4EwAYT53v8
         GU5gx/S2MMy+VJzau941N23TI+yUrk/4DBShENaNHHbAdpM8PjgfRBsefUhaPE8jA6nA
         bJNPTN5HWK/nnOzDtgM8mcYCLJYCdTS0uZBgtkvkOO5BUP+ApeqNiiVRSW4JyUhp5ENm
         UBlduSVPbpomb98ma8UiJGYJA74R3ZBvAX9X+BMVt6LtExee/H0+JXwUtxcU65SKYf3i
         GN3w==
X-Gm-Message-State: AOAM530k3zYeDxKvXyywxZoT0OKR9lR4XACo/6jfHPXHdg/O4P05zbA3
        JgVGL8GQVM6E0DSQgovLfW2I0vp48vsiEi1hMxA=
X-Google-Smtp-Source: ABdhPJyxclbg0t4a0+xTj0ZThpxQQX6QY9MgAi3Vs1hEAag3WAnTUBqP26b1qrHreTIbs/fFx/pfEK/Aedk4EGY6ZKI=
X-Received: by 2002:a9d:25:: with SMTP id 34mr7883670ota.135.1598446953089;
 Wed, 26 Aug 2020 06:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com> <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
In-Reply-To: <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 09:02:21 -0400
Message-ID: <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 12:45 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Aug 25, 2020 at 5:01 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Tue, Aug 25, 2020 at 3:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > There seems to be no reason to use GFP_ATOMIC in these cases.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  security/selinux/hooks.c       |  6 +++---
> > >  security/selinux/ss/policydb.c | 10 +++++-----
> > >  security/selinux/ss/services.c |  4 ++--
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 89d3753b7bd5d..4de962daffbde 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -6854,7 +6854,7 @@ static int selinux_lockdown(enum lockdown_reason what)
> > >
> > >         if (WARN(invalid_reason, "Invalid lockdown reason")) {
> > >                 audit_log(audit_context(),
> > > -                         GFP_ATOMIC, AUDIT_SELINUX_ERR,
> > > +                         GFP_KERNEL, AUDIT_SELINUX_ERR,
> > >                           "lockdown_reason=invalid");
> > >                 return -EINVAL;
> > >         }
> >
> > Have you audited all callers of security_locked_down() to ensure that
> > they are never holding any locks around the call?  That's the only one
> > I saw that might be a problem now or in the future.
>
> Hm... didn't realize there were so many :) I'll try to go over them.
>
> As a side note, it would be nice if we had the may (not) sleep
> requirements documented somehow for each hook at the LSM level,
> ideally with a might_sleep() check at the beginning of each
> secuity_*() function that is expected to be called only from a
> non-atomic context... Some hooks already have arguments that specify
> this (inode_permission, inode_follow_link), but for others it is just
> implicit. I'll put this on my long-term TODO list...

Generally the core SELinux permission checking code assumes it can be
called from any context (including hardirq) and under any locking
conditions, and hooks that are for permission checking (not security
blob allocation/management) do the same.  This allows permission
checks to be performed while locks are held by the caller. and from
arbitrary contexts  I'd be inclined to just leave selinux_lockdown
unchanged given that it might be called anywhere much like capable().
