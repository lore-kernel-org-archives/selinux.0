Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B66C433DB
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84BA264ED4
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 15:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhBXPpo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 10:45:44 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41202 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235620AbhBXOhe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 09:37:34 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 677E120B6C40;
        Wed, 24 Feb 2021 06:36:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 677E120B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614177413;
        bh=f6M1L4+YPaEkOkpFKDkks9/iMdw0tuIyo+Sn3wOAtR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmU8bOFIMACplHx1Sof8884gvIG/jF1rGfoECbswTuvURtfb2RawJTiqn1QxuMlj6
         f5MQRgD067UHcE6zA43V0yAh7UwxxeCq4HzGX5vs4icg2MVEBLBkDrMq+RCsWGsCDG
         VKXl6wdehUPaXDMxrV/y4J8BKnc38KO0wHTfW7/k=
Date:   Wed, 24 Feb 2021 08:36:51 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live
 conversion
Message-ID: <20210224143651.GE6000@sequoia>
References: <20210223214346.GB6000@sequoia>
 <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia>
 <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-24 10:33:46, Ondrej Mosnacek wrote:
> On Tue, Feb 23, 2021 at 11:37 PM Tyler Hicks
> <tyhicks@linux.microsoft.com> wrote:
> > On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > > I'm seeing a race during policy load while the "regular" sidtab
> > > > conversion is happening and a live conversion starts to take place in
> > > > sidtab_context_to_sid().
> > > >
> > > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > > is what hits the race condition situation because the sidtab is only
> > > > partially populated and there's a decent amount of filesystem operations
> > > > happening, at the same time, which are triggering live conversions.
> >
> > Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> > change here:
> >
> >  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
> >
> > I'll put these changes through a validation run (the only place that I
> > can seem to reproduce this crash) and see how it looks.
> 
> Hm... I think there is actually another race condition introduced by
> the switch from rwlock to RCU [1]... Judging from the call trace you
> may be hitting that.

I believe your patches above fixed the race I was seeing. I was able to
make it through a full validation run without any crashes. Without those
patches applied, I would see several crashes resulting from this race
over the course of a validation run.

I'll continue to test with your changes and let you know if I end up
running into the other race you spotted.

Tyler

> 
> Basically, before the switch the sidtab swapover worked like this:
> 1. Start live conversion of new entries.
> 2. Convert existing entries.
> [Still only the old sidtab is visible to readers here.]
> 3. Swap sidtab under write lock.
> 4. Now only the new sidtab is visible to readers, so the old one can
> be destroyed.
> 
> After the switch to RCU, we now have:
> 1. Start live conversion of new entries.
> 2. Convert existing entries.
> 3. RCU-assign the new policy pointer to selinux_state.
> [!!! Now actually both old and new sidtab may be referenced by
> readers, since there is no synchronization barrier previously provided
> by the write lock.]
> 4. Wait for synchronize_rcu() to return.
> 5. Now only the new sidtab is visible to readers, so the old one can
> be destroyed.
> 
> So the race can happen between 3. and 5., if one thread already sees
> the new sidtab and adds a new entry there, and a second thread still
> has the reference to the old sidtab and also tires to add a new entry;
> live-converting to the new sidtab, which it doesn't expect to change
> by itself. Unfortunately I failed to realize this when reviewing the
> patch :/
> 
> I think the only two options to fix it are A) switching back to
> read-write lock (the easy and safe way; undoing the performance
> benefits of [1]), or B) implementing a safe two-way live conversion of
> new sidtab entries, so that both tables are kept in sync while they
> are both available (more complicated and with possible tricky
> implications of different interpretations of contexts by the two
> policies).
> 
> [1] 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")
> 
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
> 
