Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46447C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03F3214F1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7qf4rg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHZORz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgHZORz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:17:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86159C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:17:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z195so1640791oia.6
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSjOruia4oJHExexsf+1TcDTqhbGy2QCNJupncTDhGA=;
        b=o7qf4rg9D34dT2uDLY+prKjXBGv8B6KJbaT29t3dqVYHRfYtgaZ5gRSpWXls7fzFhj
         VljBZK0H4avymz8haSQNfld4GboMQNOqG0tMXkDiQseyKrClWhy8RrpEshp4lQ585l7E
         AZuu093Pm7SiHsP5Huxw//e68ocu1LGQqEENurUPb5A3RISrtTfm7sbCWYWNBH+mk4tN
         7ap5NLwf2ODZN0hluUuNa4U9nSDp7vtsowYJC/xxjSFNFzf6JRsNG121LnxxJcsmco5U
         kP4b2PVzD5TONc3UvT2L4N8tIfXJji10dJge3DQgkLJ8FaRF4dOzzYWaQr0MQ2En9WJw
         YJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSjOruia4oJHExexsf+1TcDTqhbGy2QCNJupncTDhGA=;
        b=FyThXFNSP7DqFPbD+1XnRcJ5d+ZWB4KTgsmxXJaBfYJ4Ug5A8wLBc8qva8NtG7TNYk
         g1F7+FzX2d2D13VEEGoxaTkZImeB1T8bCVXxKL0Ym8JxPnJ/82csqZtOPZqdpDQbs8l2
         TJR7bVXLJbliZzTcNCCNgoEIWyehnz4QdZ0lYBp57eStzZu1Mwqsh1mDK8G4jLSaaOBM
         3EBMSxjOP/4VYdISmRQ0Y5sRGMhpRI4Sv1zQBHBvA5Ol3f1wgsn1BhBgOotAeMPV4bwK
         uPZyl9XRrekIL9ox7M5v7pQ9RxWwVnaJyt04hBvuzEHFxPP0c9gF2c6wEGMM9iSTYkVZ
         Ek/A==
X-Gm-Message-State: AOAM530AUP5K4fVupvNPbmZuaI1Fw89Ktw5KwXiZKe6hMJ06+BdLB024
        iK1P/RmVl7erWrLUsRKoevupHVYQeVNvFslPmRU=
X-Google-Smtp-Source: ABdhPJxkEZerR7nhr3Tl1X9NXv2pXDJJJL8dRCQqPw/li7mWJTXRzY8fTeIHqbfrQN5PvYsgQrdbNyG6/2Jg6Oj7zko=
X-Received: by 2002:a05:6808:310:: with SMTP id i16mr3112679oie.160.1598451473973;
 Wed, 26 Aug 2020 07:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
 <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com>
 <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com>
 <CAHC9VhSBsTU++65fPqZvdvdT_Ja+zaj-toUSa6iVLBCt8vQOBw@mail.gmail.com> <CAFqZXNuvciwq4ApXWxR14nqezDZEJSunTONXy-dmfYmu84Mq6g@mail.gmail.com>
In-Reply-To: <CAFqZXNuvciwq4ApXWxR14nqezDZEJSunTONXy-dmfYmu84Mq6g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 10:17:43 -0400
Message-ID: <CAEjxPJ4XXgyEZ4csgcoheJ7z_qELYrJfttnk4MWbGoPyyr-pzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Aug 26, 2020 at 3:51 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Aug 26, 2020 at 9:02 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Generally the core SELinux permission checking code assumes it can be
> > > called from any context (including hardirq) and under any locking
> > > conditions, and hooks that are for permission checking (not security
> > > blob allocation/management) do the same.  This allows permission
> > > checks to be performed while locks are held by the caller. and from
> > > arbitrary contexts  I'd be inclined to just leave selinux_lockdown
> > > unchanged given that it might be called anywhere much like capable().
> >
> > Agreed.  The code paths relating to policy load, etc. are good
> > candidates for an ATOMIC->KERNEL conversion, assuming no other
> > constraints, but I'm somewhat nervous of converting stuff in hook.c
> > that doesn't have a hard sleep-ability defined.
>
> OK, I can drop the selinux_lockdown() hunk then. The other hooks.c
> hunks both have an existing GFP_KERNEL allocation in the same
> function, so I'd tend to keep them for consistency. Or do you want me
> to rather convert the GFP_KERNELs to GFP_ATOMICs there?

No, I was fine with the other parts of the patch just not the lockdown
one, because it can be called from many places like capable().
