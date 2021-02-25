Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF7C433E6
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 16:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F89864F03
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBYQkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 11:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231439AbhBYQkF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 11:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614271118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8k5iuxiLeQ7XpluaEJD41Fvh3xDGJX0n9czsqF38RE=;
        b=f39Sxd+NoO8cKEGtJcIAYmYfvam1Ngki6mgJSbKRNVh/7+zlnkVt/JBJP57wYLOdxpZf9O
        Ct32g5MTBYYqjUI1qttSjDm7sJaBLBOl9YIQdFg4AFfhoqPgl8uD1ZlKy05Jw/ejLwupDk
        3UPS06qoHkn1+9MxjdsQAo1sy5IlsrY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-zfEQXOKaPH-90ngBvsbG9A-1; Thu, 25 Feb 2021 11:38:36 -0500
X-MC-Unique: zfEQXOKaPH-90ngBvsbG9A-1
Received: by mail-yb1-f200.google.com with SMTP id y7so6664730ybh.20
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 08:38:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8k5iuxiLeQ7XpluaEJD41Fvh3xDGJX0n9czsqF38RE=;
        b=EqOVE6+22+aRVq3UeW6k426HlpYgq2sh5mPBCcxo9y+/kYmlwY5wEL9+Y9Uteg2k9n
         E2SftAsckPPBDuQUI++28lD/F6IKwCXvCkT/4PLqhpJf3s43o7MCN1Uy9gEKAfrK7alI
         2i9fsjWsaa1ivIroYRfONF5v5EJo8NRNiiZ0GU3Is8xVcH3WonXd/EnDK3kJSuzNpbXK
         TIcJs90ieOq5SkAA/BFW1zP+zn6ujEjgGAvLzUh2t1PvIThgkLJkEWHQsNdHn0HnENi4
         7iS6G1MtVO9kXiIJHynAHnjLkDNucjh349JJmZtEvrXq1CGFflpTZduOY/2L0Ab0UTqD
         tmtg==
X-Gm-Message-State: AOAM533x4fHbhxamKhHJnmBXenOFe+qsZunMFyzVrtNFIfbV8q+N8bk3
        ENEdU6mwGRu7lp3AG8P8HObAhG/H7a/1JJG9Xw5U/IvQgWt1ZamOC1hziqPJK2uzH+zN+tHSVA4
        F9mriSSChZvl3gjD+PgHk5tzNY1Cd5j9ORg==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr5425905ybp.436.1614271116314;
        Thu, 25 Feb 2021 08:38:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkBbvx4rfF50W/uTvBYf+1s75D6DnxRzl8SDv+NVzE39i9Cf0s7VZpzCrSEnFS+Xea/mN0iPQsflY97qjOO88=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr5425878ybp.436.1614271116082;
 Thu, 25 Feb 2021 08:38:36 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <20210224143651.GE6000@sequoia>
In-Reply-To: <20210224143651.GE6000@sequoia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 25 Feb 2021 17:38:25 +0100
Message-ID: <CAFqZXNsNtAD56H0K-oOMkm=M_M6g=zuSvprDAWVk_phwQGk_TQ@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 24, 2021 at 3:43 PM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> On 2021-02-24 10:33:46, Ondrej Mosnacek wrote:
> > On Tue, Feb 23, 2021 at 11:37 PM Tyler Hicks
> > <tyhicks@linux.microsoft.com> wrote:
> > > On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > > > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > > > I'm seeing a race during policy load while the "regular" sidtab
> > > > > conversion is happening and a live conversion starts to take place in
> > > > > sidtab_context_to_sid().
> > > > >
> > > > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > > > is what hits the race condition situation because the sidtab is only
> > > > > partially populated and there's a decent amount of filesystem operations
> > > > > happening, at the same time, which are triggering live conversions.
> > >
> > > Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> > > change here:
> > >
> > >  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
> > >
> > > I'll put these changes through a validation run (the only place that I
> > > can seem to reproduce this crash) and see how it looks.
> >
> > Hm... I think there is actually another race condition introduced by
> > the switch from rwlock to RCU [1]... Judging from the call trace you
> > may be hitting that.
>
> I believe your patches above fixed the race I was seeing. I was able to
> make it through a full validation run without any crashes. Without those
> patches applied, I would see several crashes resulting from this race
> over the course of a validation run.

Hm... okay so probably you were indeed running into that bug. I tried
to reproduce the other race (I added a BUG_ON to help detect it), but
wasn't able to reproduce it with my (pretty aggressive) stress test. I
only managed to trigger it by adding a conditional delay in the right
place. So I now know the second bug is really there, though it' seems
to be very unlikely to be hit in practice (might be more likely on
systems with many CPU cores, though). The first bug, OTOH, is
triggered almost instantly by my stress test.

Unless someone objects, I'll start working on a patch to switch back
to read-write lock for now. If all goes well, I'll send it sometime
next week.

>
> I'll continue to test with your changes and let you know if I end up
> running into the other race you spotted.

Thanks, but given the results of my testing it's probably not worth trying :)

>
> Tyler
>
> >
> > Basically, before the switch the sidtab swapover worked like this:
> > 1. Start live conversion of new entries.
> > 2. Convert existing entries.
> > [Still only the old sidtab is visible to readers here.]
> > 3. Swap sidtab under write lock.
> > 4. Now only the new sidtab is visible to readers, so the old one can
> > be destroyed.
> >
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
> >
> > I think the only two options to fix it are A) switching back to
> > read-write lock (the easy and safe way; undoing the performance
> > benefits of [1]), or B) implementing a safe two-way live conversion of
> > new sidtab entries, so that both tables are kept in sync while they
> > are both available (more complicated and with possible tricky
> > implications of different interpretations of contexts by the two
> > policies).
> >
> > [1] 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
> >
> > --
> > Ondrej Mosnacek
> > Software Engineer, Linux Security - SELinux kernel
> > Red Hat, Inc.
> >
>


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

