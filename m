Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE4C43381
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329FE64EFC
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 09:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhBXJhv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 04:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234590AbhBXJhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 04:37:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614159345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDpumoxA9uXAvbvE4QJIt1iLqbsCBPKNd/TgxemxMkY=;
        b=EaVFYlmMAU5FE8tunClH4o10rpk4rZmGUWvv9ot1IniYy3g9o1FZxAx4c5IpnebG8sVBxY
        wEULx7rewYJou19RBZcDOcc6LnqXu88k/Eq8PqVlAHx1tpVuWIMhlZZvpR4qY+1Mf8mQlM
        znm3kXIqurfLI36dsYFQfCByTAcPMxc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-S5XMFbswNY2wwX_zkgXugw-1; Wed, 24 Feb 2021 04:33:57 -0500
X-MC-Unique: S5XMFbswNY2wwX_zkgXugw-1
Received: by mail-yb1-f199.google.com with SMTP id v62so1733869ybb.15
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 01:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDpumoxA9uXAvbvE4QJIt1iLqbsCBPKNd/TgxemxMkY=;
        b=BBpBiMGVsvDwfiFkYKgwLLgCLnDMjDKBk2tJqEd+8iC6UU3d3Rd7CDXtRIY6Nk9Ryn
         81gkf943CrmrsuDy9OgAVrGT3Xt6IXax6MWSHWP9PbDPvt+HYJ1sfzMPkPMuXh1BIUgy
         OEIxZ1SuC0KbK8GfG4PmPcc9/nyhh5qo1yZrwFPg9O2Lng7jcX+OlqZ5rfqU/33rZFNL
         apE6AveMNCwklxeG+e79tmEavRXxvgE8PUyVC13jX9fRdWVjyi2/qOmxv2rlVRAHqO39
         S6Y32uZuDbqm4bloA99V8lyb0vAf1o2Gbp0dr0VXSxehBVeViYmzhLagDxO6iUpG3TLI
         mCgg==
X-Gm-Message-State: AOAM533nM/FWbBDxGNv2/YB3We3y73xmg6fnuTBkVpC1nrou5N2KECEy
        LtsiUUvF8EYKNtb204LDyGZs+Hsd4z5dP+C3hzN7yj0LF3E2mi4hZtSejuBi8KWxtx+QmkLiSN5
        y/ltSu+bD1bF01xbL7ITa02EopkUT8hm/mA==
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr44758937ybr.81.1614159236718;
        Wed, 24 Feb 2021 01:33:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpYwp7rz1tdZc6MVyGEegVfNnPphVXA8W4qlR+z7XNIP7BwBVjfbStjkgQyv4w9jES9ZUs+L1LQu9g9Lts1ZU=
X-Received: by 2002:a5b:ac2:: with SMTP id a2mr44758913ybr.81.1614159236426;
 Wed, 24 Feb 2021 01:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia> <20210223223652.GD6000@sequoia>
In-Reply-To: <20210223223652.GD6000@sequoia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Feb 2021 10:33:46 +0100
Message-ID: <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
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

On Tue, Feb 23, 2021 at 11:37 PM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
> On 2021-02-23 15:50:56, Tyler Hicks wrote:
> > On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > > I'm seeing a race during policy load while the "regular" sidtab
> > > conversion is happening and a live conversion starts to take place in
> > > sidtab_context_to_sid().
> > >
> > > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > > then another policy gets loaded ~2-3s into boot. That second policy load
> > > is what hits the race condition situation because the sidtab is only
> > > partially populated and there's a decent amount of filesystem operations
> > > happening, at the same time, which are triggering live conversions.
>
> Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
> change here:
>
>  https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/
>
> I'll put these changes through a validation run (the only place that I
> can seem to reproduce this crash) and see how it looks.

Hm... I think there is actually another race condition introduced by
the switch from rwlock to RCU [1]... Judging from the call trace you
may be hitting that.

Basically, before the switch the sidtab swapover worked like this:
1. Start live conversion of new entries.
2. Convert existing entries.
[Still only the old sidtab is visible to readers here.]
3. Swap sidtab under write lock.
4. Now only the new sidtab is visible to readers, so the old one can
be destroyed.

After the switch to RCU, we now have:
1. Start live conversion of new entries.
2. Convert existing entries.
3. RCU-assign the new policy pointer to selinux_state.
[!!! Now actually both old and new sidtab may be referenced by
readers, since there is no synchronization barrier previously provided
by the write lock.]
4. Wait for synchronize_rcu() to return.
5. Now only the new sidtab is visible to readers, so the old one can
be destroyed.

So the race can happen between 3. and 5., if one thread already sees
the new sidtab and adds a new entry there, and a second thread still
has the reference to the old sidtab and also tires to add a new entry;
live-converting to the new sidtab, which it doesn't expect to change
by itself. Unfortunately I failed to realize this when reviewing the
patch :/

I think the only two options to fix it are A) switching back to
read-write lock (the easy and safe way; undoing the performance
benefits of [1]), or B) implementing a safe two-way live conversion of
new sidtab entries, so that both tables are kept in sync while they
are both available (more complicated and with possible tricky
implications of different interpretations of contexts by the two
policies).

[1] 1b8b31a2e612 ("selinux: convert policy read-write lock to RCU")

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

