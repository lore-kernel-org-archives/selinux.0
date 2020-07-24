Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B81C433E3
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D922206C1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 16:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amrFECy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgGXQJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgGXQJp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 12:09:45 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B9C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 09:09:44 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id g18so1062189ooa.0
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RN4PaFKgTuwx2nAu04ml5n4WptsVE0BbHCXhZ2ECARM=;
        b=amrFECy6Q0B94H96yfm9cqa3mULOA4SSBFcKckFClRO6fjgxwUTUQvl7Jt5tQ0Pn8Q
         XRVXz7Hod42YRUv7k1EY3sCZTxstQ/4KhJ6/V3IV2LIPrLMLIMIoCU37NXAG6JYU+wye
         ALYj5O0pqm68FT2qdZzVNzi8p1IELEo8n54mKkHrXoR1cHgViZGAsk5O73D4Qsxe42uJ
         Fp+zfAMmi518fe7lya3Ey6u8YC3XTwUQ/2liOLKMpISx6hG9g9MFAw8ZuqbJkN28rsHo
         qHCvfpOw6jL6pKGFa5XaiY71l8Jt/z+gX3smUocwCNEqXcknTBfpPP5EQpEZx8BBaSSH
         nNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RN4PaFKgTuwx2nAu04ml5n4WptsVE0BbHCXhZ2ECARM=;
        b=D/Fwfc5lY5jATTZytVRHuyBPkHZJblqua9EbhcYxRqrSU/6b39qyz0ypdOOLIupCER
         JixEoTMJzg1GR8xwh7Q8uij8y+15fhljJ061tAjoOMkTuT47CtylqAVyVfG3S0O33+z9
         RgUA/V05XeDh2EksPegH0Ka3J0RWNdfZMmaM82UDzBnOMlXed1Beqeu3GGz6qAhq1MiZ
         NNAywN0m22cEr2/z+WG0LF775gMAQqahzEzlbM97KI0qMh0S7Y0WlWaLzfM/58bqg2aG
         o0XnwDvGIzdpT9Kzy5HoWIN/8ZJVrevxB2k3u0w6LGBOR46gYl+JBSzNJgMBcXbzRVxq
         ydpg==
X-Gm-Message-State: AOAM530VC1PGtj1HE1lHQZolKNNTCDSS5MoXHAa8gdwYOzbbaOZcm6P8
        he6Yn5H6KqRxwcfEwaZlhlO/uD2vTQj0olAkKpPsQg==
X-Google-Smtp-Source: ABdhPJzRTkZECU5UwmdUKVOhoZsiJCsl1mjOtJIioln/bzxFo5jfZPMU/ZjUw1EAYvUqc1iCjdTvykKjgV1e39k9a+Y=
X-Received: by 2002:a4a:b006:: with SMTP id f6mr10216699oon.13.1595606984185;
 Fri, 24 Jul 2020 09:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com> <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 12:09:33 -0400
Message-ID: <CAEjxPJ4JF_2jRP5WG6Uz51gEc7H+nRv2YAhcdTUzcwwYmQub_A@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 11:48 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 11:34 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 10:14 AM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > >
> > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > > /selinux/status") introduced the sestatus mechanism, which allows for
> > > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> > >
> > > The mechanism was initially intended for use by userspace object
> > > managers which were calculating access decisions within their
> > > application and did not rely on the libselinux AVC implementation. In
> > > order to properly make use of sestatus within avc_has_perm(), the status
> > > mechanism needs to properly set avc internals during status events;
> > > else, avc_enforcing is never updated upon sestatus changes.
> > >
> > > This commit introduces a new selinux_status_loop() function, which
> > > replaces the default netlink-equivalent, avc_netlink_loop(). The
> > > function watches the kernel status page until an error occurs, at which
> > > point it will exit the thread. In the event that the status page cannot
> > > be opened (on avc_open), the thread will continue to function as before
> > > by using a fallback netlink socket.
> > >
> > > This allows us to replace the call to avc_netlink_open() in
> > > avc_init_internal() with a call to selinux_status_open() and remove the
> > > avc_netlink_check_nb() call from the critical code path in
> > > avc_has_perm_noaudit(), as well as selinux_check_access().
> > >
> > > Userspace object managers that still need a netlink socket can call
> > > avc_netlink_acquire_fd() to open open and/or obtain one.
> > >
> > > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > > functionality.
> > >
> > > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > > ---
> > > Testing:
> > >   - dbus-daemon v1.12.8 on RHEL8.2
> > >   - dbus-broker v22 on F32
> >
> > This looks good to me as far as the code is concerned.  However,
> > installing the patched libselinux and rebooting, I notice that
> > afterward I have dbus-daemon running on a Fedora rawhide instance and
> > consuming nearly 100% CPU constantly.  I'm guessing it is sitting in
> > the status loop. Not sure why there is a dbus-daemon instance running
> > at all since dbus-broker seems to be the default in Fedora and
> > systemctl shows dbus-daemon as disabled.  But if I revert to the stock
> > libselinux, it stops hogging CPU.  Thoughts?
>
> Used gdb to attach to the separate thread and got a traceback before
> and after the libselinux patch.
> Sure enough, before it is performing a blocking poll() operation and
> hence sleeping.  After it is spinning in
> the status loop.

So, options would appear to be:
1) Drop the usage of avc_using_threads altogether, i.e. even if the
caller provided a thread callback, don't create another thread and
just call selinux_status_updated() on every avc_has_perm_noaudit()
unless avc_app_main_loop is set.  Rationale: dbus-daemon was only
using threads to avoid the overhead of avc_netlink_check_nb() on every
avc_has_perm_noaudit() call, and we've eliminated that via use of
sestatus, hence we don't need to create a separate thread at all.
-or-
2) If using threads, then create the netlink socket during avc_init
and keep using the netlink loop for the thread.  This preserves the
blocking behavior.

#1 seems more optimal to me and gets rid of threading for dbus-daemon,
which was something they didn't like anyway.
