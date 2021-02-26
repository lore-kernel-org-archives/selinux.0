Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38512C433DB
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C9764EBA
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 11:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBZLNk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Feb 2021 06:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34045 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230508AbhBZLNg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Feb 2021 06:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614337929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6n53j9KxHkRJ3cFFI4fNEUccn3z7+2i49tGG9CMSsg=;
        b=AA2+3HNABQOZNjfwkCtr5xj41H1pQnh1ggrHl3YefWKpzTpcRo8HPase+d/bfc/AuHXuPi
        qJgNfTbzvuzB1TnYCRpkyaJ1o2Og/kgTScWrSrQ4K0Nf+vBz5Fixk8xOfruVOhfySPiaWH
        D8Tjl42wvu8np4UyQvVbr5biHWHxUS0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-O-qHDECvNO6x8PNSTy07jA-1; Fri, 26 Feb 2021 06:12:07 -0500
X-MC-Unique: O-qHDECvNO6x8PNSTy07jA-1
Received: by mail-yb1-f199.google.com with SMTP id v62so9630337ybb.15
        for <selinux@vger.kernel.org>; Fri, 26 Feb 2021 03:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6n53j9KxHkRJ3cFFI4fNEUccn3z7+2i49tGG9CMSsg=;
        b=NUeO3enKXLXGLU5ij6dj9zNfDRMbfnb8bmwYgim3M85k6gVSz3QSZK7VFV5yzmKoE0
         F0ohCldkgyllyR89sr0Mlf1hAi2aQ+QSbsI9z/Gp7LNjbr/XGM45sAcpkrBzMrECHGlU
         XrtrJNqSbBT6k/UEevqvuQMoHcvXOL6bJ2stFlVC918gqBQVybC0Q62IqaVJDwg0k/XH
         o9KpK22X/wl0mEsEfATGWBZ+Gg0xzSmvbamRCO9rOpHzSl6sHVFoCrPl+sjmYVMqSgGm
         Frjt/qGKES2U/G/m6CY9UsAWKg3GU5JBZP63F1Hpa4vIsNOGuUa8ukIxsFRq3bpgRSAL
         hucw==
X-Gm-Message-State: AOAM5328sxKupgzkrpKdb4CuRzEA2Rp05PLNkJjyEhYTT2JVu0bIpMvR
        f4t5TVOejQ+P8B6JPkhsXKTdCwY/7nXLBskf87xVkqR+z6mebO9sPhh3MA46riGyUCxPsbbhikh
        vJpUR080Gp6v1qLuyL7HvJQQ9OVDVSH13kw==
X-Received: by 2002:a25:ad67:: with SMTP id l39mr3741085ybe.172.1614337926806;
        Fri, 26 Feb 2021 03:12:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfdmyB2V3wBE6ftPc+OWfFKzel7ICJXiZyI+YPfu/4JcOrmhdfSffcL8fWvhRbb6NfSZyvDzKX/HibndwRGC8=
X-Received: by 2002:a25:ad67:: with SMTP id l39mr3741066ybe.172.1614337926612;
 Fri, 26 Feb 2021 03:12:06 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
In-Reply-To: <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Feb 2021 12:11:56 +0100
Message-ID: <CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 26, 2021 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > After the switch to RCU, we now have:
> > 1. Start live conversion of new entries.
> > 2. Convert existing entries.
> > 3. RCU-assign the new policy pointer to selinux_state.
> > [!!! Now actually both old and new sidtab may be referenced by
> > readers, since there is no synchronization barrier previously provided
> > by the write lock.]
> > 4. Wait for synchronize_rcu() to return.
> > 5. Now only the new sidtab is visible to readers, so the old one can
> > be destroyed.
> >
> > So the race can happen between 3. and 5., if one thread already sees
> > the new sidtab and adds a new entry there, and a second thread still
> > has the reference to the old sidtab and also tires to add a new entry;
> > live-converting to the new sidtab, which it doesn't expect to change
> > by itself. Unfortunately I failed to realize this when reviewing the
> > patch :/
>
> It is possible I'm not fully understanding the problem and/or missing
> an important detail - it is rather tricky code, and RCU can be very
> hard to reason at times - but I think we may be able to solve this
> with some lock fixes inside sidtab_context_to_sid().  Let me try to
> explain to see if we are on the same page here ...
>
> The problem is when we have two (or more) threads trying to
> add/convert the same context into a sid; the task with new_sidtab is
> looking to add a new sidtab entry, while the task with old_sidtab is
> looking to convert an entry in old_sidtab into a new entry in
> new_sidtab.  Boom.
>
> Looking at the code in sidtab_context_to_sid(), when we have two
> sidtabs that are currently active (old_sidtab->convert pointer is
> valid) and a task with old_sidtab attempts to add a new entry to both
> sidtabs it first adds it to the old sidtab then it also adds it to the
> new sidtab.  I believe the problem is that in this case while the task
> grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
> allows it to race with tasks that already see only new_sidtab.  I
> think adding code to sidtab_context_to_sid() which grabs the
> new_sidtab->lock when adding entries to the new_sidtab *should* solve
> the problem.
>
> Did I miss something important? ;)

Sadly, yes :) Consider this scenario (assuming we fix the locking at
sidtab level):

If it happens that a new SID (x) is added via the new sidtab and then
another one (y) via the old sidtab, to avoid clash of SIDs, we would
need to leave a "hole" in the old sidtab for SID x. And this will
cause trouble if the thread that has just added SID y, then tries to
translate the context string corresponding to SID x (without re-taking
the RCU read lock and refreshing the policy pointer). Even if we
handle skipping the "holes" in the old sidtab safely, the translation
would then end up adding a duplicate SID entry for the context already
represented by SID x - which is not a state we want to end up in.

This is why I said that to fully fix this, we'd need to have a
both-ways live conversion in place. (And that already starts to feel
like too much hacking for something that should probably go to
stable@...)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

