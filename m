Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03703C433E9
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 11:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BC164EF0
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 11:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZLVP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Feb 2021 06:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhBZLVO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Feb 2021 06:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614338388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=21WHWcxyW0R0i+nu89iK+hY7xxF9KTjB2gFpICOTc2I=;
        b=P1TiQBc/KH5BmtGi8aPb83HW5vq7BqNpmd40OlipK/LeoFSToRVXe1fC1rBnDW6o7gBM2U
        AHErgJMKrPiKkmQNkgsvVk9IMu0J0KB8ztiSrY0MqzLh+W/9DNZKochGCWmPPQUroE0E/R
        CYCpTaci76NxvKA9onStIuTMH4VULQI=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-kR9UnYReNvGnhD1IJs3rEw-1; Fri, 26 Feb 2021 06:19:46 -0500
X-MC-Unique: kR9UnYReNvGnhD1IJs3rEw-1
Received: by mail-yb1-f200.google.com with SMTP id q77so9762611ybq.0
        for <selinux@vger.kernel.org>; Fri, 26 Feb 2021 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21WHWcxyW0R0i+nu89iK+hY7xxF9KTjB2gFpICOTc2I=;
        b=q0bMJ7hKNbY0yWCIFpql5ntw+9EpL/A1R/5dW5ZvdPrtHTpw5f9W79k6YQO0QOlDMv
         osQwEtG1vdLOLhzgkvdmLprdY9Tfu7YgrSt/45g63ZZG2Oqx+VdSlfrzRF7v6EyU3OJU
         gUwLbYoP3uNTpMv6XNtx2E9ancITd1xVlXomH5rX3kgUrVq8oFN0FsGcQOl5DTz9wXWE
         0AF0kMNq3eZOEtGNAteKy5ud8M/IJXaExrrpYlRGNPwpemckB6w97ogtlz4+6U4w7gRP
         KRTQGcXt/SKPCGno8FhJmad0VV2nVJ1caG13HZBfI1k6N1EEndNk945h5Iidh8V5urpH
         Dn8w==
X-Gm-Message-State: AOAM532DbByTcAOba58f7JSixX98LQ3RyqzSByFRbIZ4F37j4pYiG+BW
        qm2ljrpxXx03L4JkSW7/deOiR3qMgHgbOOteDqkYkw9NGg67rckTAoGayWsX8GLZqOZ8aaDEHEg
        YJOXxzIOepbPpcdhzX9WyECD9XHneQmLAJQ==
X-Received: by 2002:a25:d104:: with SMTP id i4mr3775496ybg.227.1614338385619;
        Fri, 26 Feb 2021 03:19:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdQiHBNItfITac2JMT1HbsAti2DvmAEICafs5OqhUYvrC/r11A5AD8rclfrmyW0zhJGa3ZvorxhEGSxhnFBN4=
X-Received: by 2002:a25:d104:: with SMTP id i4mr3775471ybg.227.1614338385419;
 Fri, 26 Feb 2021 03:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <CAHC9VhSaU-3_fs83kEA5bxBf9xMsE29B_O5nXFpROk4=y9kgXw@mail.gmail.com> <20210226040542.1137-1-hdanton@sina.com>
In-Reply-To: <20210226040542.1137-1-hdanton@sina.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Feb 2021 12:19:35 +0100
Message-ID: <CAFqZXNu8xyeVUcYud9MLF4yp57dSb4FDyOBDyajh+=SwwomNhQ@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Hillf Danton <hdanton@sina.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 26, 2021 at 5:08 AM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 25 Feb 2021 20:06:45 -0500 Paul Moore wrote:
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
> If the convert pointer can be derefered without lock, we can opt to
> convert context after building sidtab with the risk of AB BA deadlock
> cut. Below is the minimum change I can think of along your direction.

We could fix this a bit more easily by just having a shared spinlock
for both (well, *all*) sidtabs. Yes, we'd need to have it all the way
up in selinux_state and pass it through to sidtab_init(), but IMHO
that's less bad than trying to get it right with two locks.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

