Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4B7C433E1
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 18:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079A020656
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 18:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="jKgAd/6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOSw0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgGOSw0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 14:52:26 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD5C061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 11:52:25 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i80so1641348lfi.13
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7YueQdqAJYT+fpCto/bvYJkJ4ybanqp43vlLg3jdqM=;
        b=jKgAd/6cq9sk+c8tRgWSBQAWMz1AJJMSiDNrG4d5dxjToe8kykSbqhtgpUwpxRI1m+
         iSsQn0PV2UtrqemPy0N1XF1fYAZxJRiIHhLuw2yBWz2t4j09OufWP1xS5KxHW6rvxo4U
         wfqzThLzU9r34BZSnKiIy7BWyarcJa0gV3PGYAwi5Aniay8kaPR0k9CluieJ+uoocDhx
         U7t7GjNB6jIB10eRXPeh3Sy/URMpwDA8cwJ+uD2wVmyREYFnYXmdwSFp4op2f+/C08S+
         cIvXv+0TGkEiVU2AZwNJfkxEyLL4j3uD2H+TxpJLA2mo2Yjau5xr5vPZk/EGI3YMLvB+
         uXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7YueQdqAJYT+fpCto/bvYJkJ4ybanqp43vlLg3jdqM=;
        b=aSRYDELjtFcHannXZYPtAYQZi4Dial+qP4FEqWaG9FK4N5uQp8UvAduMvUTQosQVM0
         8sGYzp4BZ+wJ60JqtT5iXTwwIxGOnvFnyddFiQyVIGPWrP69z96Nzx4yRRuR07LWvv0v
         raJ/6qKqzMJBfHxL6Oo0uLTR6whkXfVXA1OSytgxms2RMWnOIiy/nq3x0X8PFDWXzuGH
         bX6dPAynmegC81Pogws8qeTGiARGk9G4eF5IMfVnnJjoFs+8xdjLHnu16pwW97/xNyes
         ASbUeqymI8PsIYdsgfoCmNTGNQu8WoKmP7bVBqeSGVU7tnAV44ZxEGCoa70AM2tn6CRD
         kqzQ==
X-Gm-Message-State: AOAM530Nn8cZ8wr7y5G5w3+HrUqe172eDEY9JLWGFigF/wZCvJeKLmwE
        EdwPm5VsHIukkYFbGYTCNFKXwRaqdh8gJqIhL7IdIw==
X-Google-Smtp-Source: ABdhPJwHomwN5nKmAUL3j1kSugMVN7GrSNZ5RklUqQ7rZDY7b54H8J+qTzMwYhKpuoykYK891TFSD3kiVBKHn31G5lY=
X-Received: by 2002:a19:8253:: with SMTP id e80mr200821lfd.199.1594839144224;
 Wed, 15 Jul 2020 11:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
 <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
 <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com> <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com>
In-Reply-To: <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Wed, 15 Jul 2020 14:52:12 -0400
Message-ID: <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 1:10 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Wed, Jul 15, 2020 at 12:28 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 12:04 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > >
> > > On Tue, Jul 14, 2020 at 6:42 PM Mike Palmiotto
> > > <mike.palmiotto@crunchydata.com> wrote:
> > > >
> > > > On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> > > > > <mike.palmiotto@crunchydata.com> wrote:
> > > <snip>
> > > > > > Do you think we should go ahead and completely swap in sestatus? I was
> > > > > > just worried about breaking userspace object managers that are
> > > > > > currently using netlink threads by default, for instance
> > > > > > systemd-dbusd.  I can spend some more time getting those to work with
> > > > > > the status page if you think that's worthwhile.
> > > > >
> > > > > I'd be interested in understanding the impact of such a change on
> > > > > existing userspace object managers.  If we can switch the default
> > > > > behavior for applications that are not explicitly using
> > > > > avc_netlink_*() interfaces themselves (e.g. they are only using
> > > > > selinux_check_access or avc_has_perm), then that would be beneficial
> > > > > since I think it fully removes the need for a system call on the AVC
> > > > > cache-hit code path.
> > > >
> > > > I'll have to do a bit of digging to see how this will affect dbus, et
> > > > al. On first blush, it looks like they're just doing
> > > > avc_netlink_check_nb() in their watch thread. Presumably other object
> > > > managers are doing something similar so we would just need to make
> > > > sure there is a netlink fd available.
> > >
> > > So it looks like dbus (at least) is directly checking for a netlink
> > > socket[1], so just doing away with the avc_netlink_open call wouldn't
> > > work out. My thinking is we have two options:
> > >
> > > 1) Add a new seopt to use sestatus and let userspace object managers opt-in
> > >
> > > 2) Call both selinux_status_open and avc_netlink_open in
> > > avc_init_internal. This would satisfy the hard requirement for a
> > > netlink socket. Then we can default to using sestatus in all of the
> > > netlink processing paths, as you suggested in your last reply. We
> > > could
> > >
> > > Option 2 seems better from the standpoint of using sestatus by
> > > default, but it looks like recvfrom will never be called and the
> > > messages will just sit in kernel memory.
> > >
> > > I'm inclined to go with option 1 at this point.
> > >
> > > [1] https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L269
> >
> > Couldn't we change avc_netlink_acquire_fd() to test whether fd hasn't
> > yet been set (i.e. == -1) and call avc_netlink_open() in that case?
> > Then dbus would still gets its netlink fd as expected but we wouldn't
> > need to open it inside of avc_init?
>
> Much better. I'll send a new patch up shortly.

Okay, maybe not that shortly. I tried your suggestion and dbus doesn't
appear to receive the netlink messages.

Initially I figured it had something to do with
avc_create_thread(avc_netlink_loop) call still being in
avc_init_internal, so I exposed the thread pointer in avc_internal.h
and moved the call into avc_netlink_open, which seemed more
appropriate. Still no dice.

I'm probably doing something wrong -- I'll figure it out, but it's
going to take me longer than I thought to track this down.

-- 
Mike Palmiotto
https://crunchydata.com
