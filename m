Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E39C433E0
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA0564E10
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 10:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhCAKim (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234516AbhCAKhl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Mar 2021 05:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614594971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5J9Aaz6tdGKZ4rbCMsw46yp8g7/dLSF9lej7J4+mUio=;
        b=hNMSJli1BZMPg3WFMDQhNmVqvwJ5Ul3W19WXMNXugm/ZB/OuCxzHOSpt5HIOWVT+NI2xb1
        0UaOXIfYXhQPCtp17k8XeaRTBEyBZmWUF7ojmcHSrD+iYPaNVcaFWHANDi0x6+9MVroQ8L
        ZSeSK6zZWTyvDPLkcAoFUDGMCJXi2tM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-4e0F53OZMYGg6yJoGmgVMg-1; Mon, 01 Mar 2021 05:36:09 -0500
X-MC-Unique: 4e0F53OZMYGg6yJoGmgVMg-1
Received: by mail-yb1-f200.google.com with SMTP id a63so18706564yba.2
        for <selinux@vger.kernel.org>; Mon, 01 Mar 2021 02:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J9Aaz6tdGKZ4rbCMsw46yp8g7/dLSF9lej7J4+mUio=;
        b=a41KGmOJTISxSJHPApkETPZo390dQbim1XDWhP1CAOxzQQt+Qdai0M4O/2bBvTrDPs
         NLrxSp9P0cZ2EjBo8gQuUj1XTJB7AxxWC+y8RPYF4zf1DARMUUyUSE0vaKdzlnjCFSbp
         pS9AtfIL06Pgvd8CsdHTC4O9jjpS51MC7VsTNBvQb/gjpMfDErFwVF3mGwtyqbEeqe4/
         6BNdh5xPYqWcPaElbhxS4iOqdpcOPQuB/VWrDmdPOMwcdinEQnYTT+M8dSFEW5NoZVL2
         G+6NFFFgyM6e1bkx3kHw/oeNTZENOGnly/8xcRz/ccv0l+18DTCsxthbggkqLHFL7VSx
         PmDw==
X-Gm-Message-State: AOAM532NPBmxh6VahF/6h87pDiQFlZ1bpF5orkqB1dliRmyURa/AP3i2
        ktujQOu4wfDEO5oky2tAALubEbwfnyrg9JNH0KXxqhInBzVv8RKhk9ezjGcl7ha/d9j/0geTn+s
        T8ITiJbNns54onUaAWkxmDkD8kh3XKAtoeA==
X-Received: by 2002:a25:ac4e:: with SMTP id r14mr22127566ybd.340.1614594969007;
        Mon, 01 Mar 2021 02:36:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTiwFPpSMH6Tx4ERPceIRnjCT+n6pBqch5IMLSwU9aZ0EuMrlChYo+ypHOVN8J9Hp9JSxKC+ZV19ND3wmJQF8=
X-Received: by 2002:a25:ac4e:: with SMTP id r14mr22127541ybd.340.1614594968699;
 Mon, 01 Mar 2021 02:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com>
 <CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com> <CAHC9VhSCs17LEW=QZ2WLeD3-GVzv2RpUJaw7qQNSFWgfEWjkbg@mail.gmail.com>
In-Reply-To: <CAHC9VhSCs17LEW=QZ2WLeD3-GVzv2RpUJaw7qQNSFWgfEWjkbg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Mar 2021 11:35:56 +0100
Message-ID: <CAFqZXNufVGD0Sf-K3dKFmJyDOKGPg5jdJ_FPbQz__T8jAHhgYw@mail.gmail.com>
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

On Sun, Feb 28, 2021 at 8:21 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 26, 2021 at 6:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Feb 26, 2021 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > After the switch to RCU, we now have:
> > > > 1. Start live conversion of new entries.
> > > > 2. Convert existing entries.
> > > > 3. RCU-assign the new policy pointer to selinux_state.
> > > > [!!! Now actually both old and new sidtab may be referenced by
> > > > readers, since there is no synchronization barrier previously provided
> > > > by the write lock.]
> > > > 4. Wait for synchronize_rcu() to return.
> > > > 5. Now only the new sidtab is visible to readers, so the old one can
> > > > be destroyed.
> > > >
> > > > So the race can happen between 3. and 5., if one thread already sees
> > > > the new sidtab and adds a new entry there, and a second thread still
> > > > has the reference to the old sidtab and also tires to add a new entry;
> > > > live-converting to the new sidtab, which it doesn't expect to change
> > > > by itself. Unfortunately I failed to realize this when reviewing the
> > > > patch :/
> > >
> > > It is possible I'm not fully understanding the problem and/or missing
> > > an important detail - it is rather tricky code, and RCU can be very
> > > hard to reason at times - but I think we may be able to solve this
> > > with some lock fixes inside sidtab_context_to_sid().  Let me try to
> > > explain to see if we are on the same page here ...
> > >
> > > The problem is when we have two (or more) threads trying to
> > > add/convert the same context into a sid; the task with new_sidtab is
> > > looking to add a new sidtab entry, while the task with old_sidtab is
> > > looking to convert an entry in old_sidtab into a new entry in
> > > new_sidtab.  Boom.
> > >
> > > Looking at the code in sidtab_context_to_sid(), when we have two
> > > sidtabs that are currently active (old_sidtab->convert pointer is
> > > valid) and a task with old_sidtab attempts to add a new entry to both
> > > sidtabs it first adds it to the old sidtab then it also adds it to the
> > > new sidtab.  I believe the problem is that in this case while the task
> > > grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
> > > allows it to race with tasks that already see only new_sidtab.  I
> > > think adding code to sidtab_context_to_sid() which grabs the
> > > new_sidtab->lock when adding entries to the new_sidtab *should* solve
> > > the problem.
> > >
> > > Did I miss something important? ;)
> >
> > Sadly, yes :) Consider this scenario (assuming we fix the locking at
> > sidtab level):
> >
> > If it happens that a new SID (x) is added via the new sidtab and then
> > another one (y) via the old sidtab, to avoid clash of SIDs, we would
> > need to leave a "hole" in the old sidtab for SID x. And this will
> > cause trouble if the thread that has just added SID y, then tries to
> > translate the context string corresponding to SID x (without re-taking
> > the RCU read lock and refreshing the policy pointer). Even if we
> > handle skipping the "holes" in the old sidtab safely, the translation
> > would then end up adding a duplicate SID entry for the context already
> > represented by SID x - which is not a state we want to end up in.
>
> Ah, yes, you're right.  I was only thinking about the problem of
> adding an entry to the old sidtab, and not the (much more likely case)
> of an entry being added to the new sidtab.  Bummer.
>
> Thinking aloud for a moment - what if we simply refused to add new
> sidtab entries if the task's sidtab pointer is "old"?  Common sense
> would tell us that this scenario should be very rare at present, and I
> believe the testing mentioned in this thread adds some weight to that
> claim.  After all, this only affects tasks which entered into their
> RCU protected session prior to the policy load RCU sync *AND* are
> attempting to add a new entry to the sidtab.  That *has* to be a
> really low percentage, especially on a system that has been up and
> running for some time.  My gut feeling is this should be safe as well;
> all of the calling code should have the necessary error handling in
> place as there are plenty of reasons why we could normally fail to add
> an entry to the sidtab; memory allocation failures being the most
> obvious failure point I would suspect.  This obvious downside to such
> an approach is that those operations which do meet this criteria would
> fail - and we should likely emit an error in this case - but is this
> failure really worse than any other transient kernel failure,

No, I don't like this approach at all. Before the sidtab refactor, it
had been done exactly this way - ENOMEM was returned while the sidtab
was "frozen" (i.e. while the existing entries were being converted).
And this was a real nuisance because things would fail randomly during
policy reload. And it's not just unimportant explicit userspace
actions that can fail. Any kind of transition can lead to a new SID
being created and you'd get things like execve(), mkdir(), ... return
-ENOMEM sometimes. (With a low probability, but still...)

I wouldn't compare it to a memory allocation failure, which normally
starts happening only when the system becomes overloaded. Here the
user would *awlays* have some probability of getting this error, and
they couldn't do anything about it.

> and is
> attempting to mitigate this failure worth abandoning the RCU approach
> for the sidtab?

Perhaps it wasn't clear from what I wrote, but I certainly don't want
to abandon it completely. Just to revert to a safe state until we
figure out how to do the RCU policy reload safely. The solution with
two-way conversion seems doable, it's just not a quick and easy fix.

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

