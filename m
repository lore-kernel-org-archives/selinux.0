Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0722EC433DB
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 19:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B294564DDC
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 19:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhB1TW0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhB1TWZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 14:22:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DD4C061786
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 11:21:45 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id r17so24173121ejy.13
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 11:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/9WMXaIkgAups8qMso644nzG0vT/9z30jf6eiROJz4=;
        b=FjbeA9zLLE1FCw69sub3C4LL32GbvmYE6Agq8CYIcM09zaORE4INVKA/bFwQdpE9Ty
         m+it4FLrBYn89XFM38kcsanHTjmigWgGQJ+hYtlEvP42otoYwpPpaJ+5RS9pGUtRovoe
         B7VighAFT0dFzHK8GCSaQ+gHBLNLRMXJSbrfQ0Z72WyoxDMnxZEdaqbaMkO6WIwNO4mm
         BQX2zSquZGu2SGwmWrx+S0IentrrNad1G9V7Qpqf33hYE1EpP3TrCMZF0QeqVcNR6GQp
         dm4+XaH0fXOrrNHkZYwM7pN1FCgb1asooQmx9AbA2fOh3dZ9iGNzAYz+IRt7PZmDepqS
         5vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/9WMXaIkgAups8qMso644nzG0vT/9z30jf6eiROJz4=;
        b=QkFggp8vbbgyaQKhYaFrnYxonF18H2ktixCMEzPAVECsNxhFfkP9dz+7jwXJCHOpDx
         36WTCOYNy/dX/UAvYQf3ZF9PQHLrYwO243t+sbz76PwIRvWdlQO408RCHEbZicKIUzxQ
         g2hUKBQgw8ICKYlugmL1lERpHGUH1WQFPN0DjK4W8IDLkS2r3noGsQ4XCdOCoRGNzb2F
         s9c2eQCqK/ZgmueLP3l0JifPYLELOSPsrOTdcyCFFilHXmgIpv1oH+YVk6PP1XRejtaG
         WdnJ29cpR0LJhdfpAen8SNpicwosmUxnitrSQn9uDTCs/DeebSdXebQy3ywMI4KFOZD2
         wgFg==
X-Gm-Message-State: AOAM531nYkF9Q9/xk40/tikmsqNzuqvfy3f1ciYxhEQW00MI+/ReanUQ
        LmuRu6dzPqYirxD2UpLnjIJx+nn6bK8sA3GD1g1E
X-Google-Smtp-Source: ABdhPJxBzG9r6Cwhy21/wd0JPai6UBo3J0R5VrNtaLFb7mNDncKtGFdcoerxRL5RgYNEZojQxEPZ+h3jMsM5w1X/J7Y=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr12613146ejf.431.1614540103993;
 Sun, 28 Feb 2021 11:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com> <CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com>
In-Reply-To: <CAFqZXNu8s5edDbSZuSutetTsy58i08vPuP2h-n9=kT34HcPc4w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 28 Feb 2021 14:21:33 -0500
Message-ID: <CAHC9VhSCs17LEW=QZ2WLeD3-GVzv2RpUJaw7qQNSFWgfEWjkbg@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 26, 2021 at 6:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Feb 26, 2021 at 2:07 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Feb 24, 2021 at 4:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > After the switch to RCU, we now have:
> > > 1. Start live conversion of new entries.
> > > 2. Convert existing entries.
> > > 3. RCU-assign the new policy pointer to selinux_state.
> > > [!!! Now actually both old and new sidtab may be referenced by
> > > readers, since there is no synchronization barrier previously provided
> > > by the write lock.]
> > > 4. Wait for synchronize_rcu() to return.
> > > 5. Now only the new sidtab is visible to readers, so the old one can
> > > be destroyed.
> > >
> > > So the race can happen between 3. and 5., if one thread already sees
> > > the new sidtab and adds a new entry there, and a second thread still
> > > has the reference to the old sidtab and also tires to add a new entry;
> > > live-converting to the new sidtab, which it doesn't expect to change
> > > by itself. Unfortunately I failed to realize this when reviewing the
> > > patch :/
> >
> > It is possible I'm not fully understanding the problem and/or missing
> > an important detail - it is rather tricky code, and RCU can be very
> > hard to reason at times - but I think we may be able to solve this
> > with some lock fixes inside sidtab_context_to_sid().  Let me try to
> > explain to see if we are on the same page here ...
> >
> > The problem is when we have two (or more) threads trying to
> > add/convert the same context into a sid; the task with new_sidtab is
> > looking to add a new sidtab entry, while the task with old_sidtab is
> > looking to convert an entry in old_sidtab into a new entry in
> > new_sidtab.  Boom.
> >
> > Looking at the code in sidtab_context_to_sid(), when we have two
> > sidtabs that are currently active (old_sidtab->convert pointer is
> > valid) and a task with old_sidtab attempts to add a new entry to both
> > sidtabs it first adds it to the old sidtab then it also adds it to the
> > new sidtab.  I believe the problem is that in this case while the task
> > grabs the old_sidtab->lock, it never grabs the new_sidtab->lock which
> > allows it to race with tasks that already see only new_sidtab.  I
> > think adding code to sidtab_context_to_sid() which grabs the
> > new_sidtab->lock when adding entries to the new_sidtab *should* solve
> > the problem.
> >
> > Did I miss something important? ;)
>
> Sadly, yes :) Consider this scenario (assuming we fix the locking at
> sidtab level):
>
> If it happens that a new SID (x) is added via the new sidtab and then
> another one (y) via the old sidtab, to avoid clash of SIDs, we would
> need to leave a "hole" in the old sidtab for SID x. And this will
> cause trouble if the thread that has just added SID y, then tries to
> translate the context string corresponding to SID x (without re-taking
> the RCU read lock and refreshing the policy pointer). Even if we
> handle skipping the "holes" in the old sidtab safely, the translation
> would then end up adding a duplicate SID entry for the context already
> represented by SID x - which is not a state we want to end up in.

Ah, yes, you're right.  I was only thinking about the problem of
adding an entry to the old sidtab, and not the (much more likely case)
of an entry being added to the new sidtab.  Bummer.

Thinking aloud for a moment - what if we simply refused to add new
sidtab entries if the task's sidtab pointer is "old"?  Common sense
would tell us that this scenario should be very rare at present, and I
believe the testing mentioned in this thread adds some weight to that
claim.  After all, this only affects tasks which entered into their
RCU protected session prior to the policy load RCU sync *AND* are
attempting to add a new entry to the sidtab.  That *has* to be a
really low percentage, especially on a system that has been up and
running for some time.  My gut feeling is this should be safe as well;
all of the calling code should have the necessary error handling in
place as there are plenty of reasons why we could normally fail to add
an entry to the sidtab; memory allocation failures being the most
obvious failure point I would suspect.  This obvious downside to such
an approach is that those operations which do meet this criteria would
fail - and we should likely emit an error in this case - but is this
failure really worse than any other transient kernel failure, and is
attempting to mitigate this failure worth abandoning the RCU approach
for the sidtab?

-- 
paul moore
www.paul-moore.com
