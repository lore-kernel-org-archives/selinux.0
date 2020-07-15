Return-Path: <SRS0=JLv6=A2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F6CC433ED
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 19:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC37C20657
	for <selinux@archiver.kernel.org>; Wed, 15 Jul 2020 19:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uktTQeyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGOTq4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jul 2020 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbgGOTqz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jul 2020 15:46:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0309C061755
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 12:46:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id j11so3140370oiw.12
        for <selinux@vger.kernel.org>; Wed, 15 Jul 2020 12:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s8DIxqCX1taMIxf+QVjIHqK8ir6JsrYpcjoKFdZtfo=;
        b=uktTQeyys1mhqwk8tvnsJ5n8vB+2wOUAsFBO00ycRflNQnZ8AdTvE7j/Nwj9zg7Gmf
         2cHFTqKjsJWcHHwkK1Z8ujJTw/iB3KPGOMFBOQgM0PkzM7hhPu2m3ftPkcLYfljg0Tfk
         HJX4ySrFhrfQp0V6T70LJ0IUsXFQ57RkaJYrqjcJuqr7JmJ1vB3ArtWkK3cVCF2QSqst
         HFRGWEKeDSkzUGOOd4LkwRVs3x9eamdccBPhdZC9Zeu84a/T3yBw3ZkbP465imG1dGdG
         w6pySoFQNvA4edC6V8fHaFeW2KgfC1Dih1sEzLC0WtUNr/AElLvquB4Wl7WTn1ZU/eak
         UZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s8DIxqCX1taMIxf+QVjIHqK8ir6JsrYpcjoKFdZtfo=;
        b=X34XABkvPJbmtQV8rIU5VHvRH7xyTVA795aNsz5DA25RteMwBVFvt9r4EvIfaEVggg
         K5BWGkTS8izgehsuUjwio/BnXsr28Vn+qYZA8sKNeK8hiSxx1FAG8K9PZ82oPE+C07wc
         s9gsQYWhmDhetLIS5XKt62rY4cQVhtXDr9GHpzC6Ry6d3XGKBtMQWEq7+WQt4U+QSxPx
         r6a1bfChv6GPJQuEX0NpS+qWf8ArM9H0wQnWC0n4wnbKg6pCdKkTZBOzB3MPgi7d6uG3
         5wleXTrh+TX64lDFQAbGIKMcO7Uj5mIVE2ADLNT3QiPxV/OTjP44bBj8K09Q2kJKTNy4
         hkPw==
X-Gm-Message-State: AOAM531cbu/LFsN6G0WYvpDPgGjyLhQKHecqCgtxAhdqswpnTb3gUj5b
        lvDMUb95HiB2U38IgcJ4Td5nJFh9bYFsrWrKNMM=
X-Google-Smtp-Source: ABdhPJxv9kuSjgLLmWhB4S8Pt+KxiXznJ2PAww83lPqSdJ4fLMCzO4tw5paIimbu/SoJ3Q+j+uEyLI775QczS9Eeg8g=
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr1122219oih.92.1594842415202;
 Wed, 15 Jul 2020 12:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
 <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
 <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com>
 <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com> <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com>
In-Reply-To: <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 15 Jul 2020 15:49:11 -0400
Message-ID: <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 2:52 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Wed, Jul 15, 2020 at 1:10 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Wed, Jul 15, 2020 at 12:28 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Jul 15, 2020 at 12:04 PM Mike Palmiotto
> > > <mike.palmiotto@crunchydata.com> wrote:
> > > >
> > > > On Tue, Jul 14, 2020 at 6:42 PM Mike Palmiotto
> > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > >
> > > > > On Tue, Jul 14, 2020 at 5:35 PM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 14, 2020 at 5:20 PM Mike Palmiotto
> > > > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > <snip>
> > > > > > > Do you think we should go ahead and completely swap in sestatus? I was
> > > > > > > just worried about breaking userspace object managers that are
> > > > > > > currently using netlink threads by default, for instance
> > > > > > > systemd-dbusd.  I can spend some more time getting those to work with
> > > > > > > the status page if you think that's worthwhile.
> > > > > >
> > > > > > I'd be interested in understanding the impact of such a change on
> > > > > > existing userspace object managers.  If we can switch the default
> > > > > > behavior for applications that are not explicitly using
> > > > > > avc_netlink_*() interfaces themselves (e.g. they are only using
> > > > > > selinux_check_access or avc_has_perm), then that would be beneficial
> > > > > > since I think it fully removes the need for a system call on the AVC
> > > > > > cache-hit code path.
> > > > >
> > > > > I'll have to do a bit of digging to see how this will affect dbus, et
> > > > > al. On first blush, it looks like they're just doing
> > > > > avc_netlink_check_nb() in their watch thread. Presumably other object
> > > > > managers are doing something similar so we would just need to make
> > > > > sure there is a netlink fd available.
> > > >
> > > > So it looks like dbus (at least) is directly checking for a netlink
> > > > socket[1], so just doing away with the avc_netlink_open call wouldn't
> > > > work out. My thinking is we have two options:
> > > >
> > > > 1) Add a new seopt to use sestatus and let userspace object managers opt-in
> > > >
> > > > 2) Call both selinux_status_open and avc_netlink_open in
> > > > avc_init_internal. This would satisfy the hard requirement for a
> > > > netlink socket. Then we can default to using sestatus in all of the
> > > > netlink processing paths, as you suggested in your last reply. We
> > > > could
> > > >
> > > > Option 2 seems better from the standpoint of using sestatus by
> > > > default, but it looks like recvfrom will never be called and the
> > > > messages will just sit in kernel memory.
> > > >
> > > > I'm inclined to go with option 1 at this point.
> > > >
> > > > [1] https://gitlab.freedesktop.org/dbus/dbus/-/blob/master/bus/selinux.c#L269
> > >
> > > Couldn't we change avc_netlink_acquire_fd() to test whether fd hasn't
> > > yet been set (i.e. == -1) and call avc_netlink_open() in that case?
> > > Then dbus would still gets its netlink fd as expected but we wouldn't
> > > need to open it inside of avc_init?
> >
> > Much better. I'll send a new patch up shortly.
>
> Okay, maybe not that shortly. I tried your suggestion and dbus doesn't
> appear to receive the netlink messages.
>
> Initially I figured it had something to do with
> avc_create_thread(avc_netlink_loop) call still being in
> avc_init_internal, so I exposed the thread pointer in avc_internal.h
> and moved the call into avc_netlink_open, which seemed more
> appropriate. Still no dice.
>
> I'm probably doing something wrong -- I'll figure it out, but it's
> going to take me longer than I thought to track this down.

Recommend writing a little test program to exercise it first without
bringing in all of the dbus baggage.  Don't think Fedora is even using
dbusd anymore, just dbus-broker.
If you get stuck, feel free to send your patch and I can take a look too.
