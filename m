Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BB8C43458
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA8206F6
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKG2NGRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXS0L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGXS0L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 14:26:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3D5C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 11:26:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 18so7696688otv.6
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Qz8zFHK1OCcAVSN2HiQ4HrGt4mUEmbWPZLvPWse3tg=;
        b=LKG2NGREo0uZiL8ZZpM0LfZgR9nnBxyeDdzCrupiCDhVdncC+xmPRHSneUXO/NihCH
         wHHBVQLJ+WEVgMjPC7+TfUuBLzNsRWZ3GEB0t/DJTca3uvKSKKQz7RPfqxUk4zvKG9CF
         nGPGFmH5bsStPbpTxY5S5MgEm3fe8mdTG047KsyPUnznQypHFT/FwLj26iM9fiu5RHMw
         KvbJ4QpoQwXZ2m8WEHtKEL2qmoLJLSBpDoBIuBILZ+DNdYTv70HACK5df+lRhSbkgtu2
         ng/at0Yjt11IYNHmcKfKI+hAkiMXbSgPuX5Ju4h5ZtzcbfKn2W6mRWpunwTpHDNiZmUI
         IdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Qz8zFHK1OCcAVSN2HiQ4HrGt4mUEmbWPZLvPWse3tg=;
        b=nJ2IwQsE19+FVSKCsiPakhavD/aBqVuGWwUyVD3a0khmoL6XjfhxR85/tRwrTvqibc
         n9hxavzFcWaxk9XWNjtfkxo66PDDuKN4Wb6BgDacbvnGngMBYQ84T7cF4HwOx907DgV4
         9IsWazbfudgAIuFhbhyZGedHbN5oQf74AYAc1oaISEz2xY8j+8X0z21nyveIoatzTniY
         eHmWCZ1dQgWBoBgQU7gVK/D9PQjSrbMvpchkN7htlVBDH+CFtUM3w+HYZ5qUcm55NPqv
         7cP6SywDX64SlYLYyII8P2Jg2trPsnFj67WcjhIgDV+WDuR5utK9J7ri9CKmaNVSInB/
         s9Yg==
X-Gm-Message-State: AOAM531Ao2zPyQwXyMSlR9CUaLus3fAm3mc514eTJghFvLquaa3V2Gac
        FsAmLgO5RGwDiFZb9JTL5bqJ63KB3QwZ6yUdlVboRQ==
X-Google-Smtp-Source: ABdhPJyTFsfhlen8wVC8L+ck0Aq32rB3EFgd+PfhDgPtaP0sLaY7ZpV8oruUtacr5c/DXFgFplFGi2DNVJH9SsIXqNo=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr10217769oti.162.1595615170179;
 Fri, 24 Jul 2020 11:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
 <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
 <CAEjxPJ4JF_2jRP5WG6Uz51gEc7H+nRv2YAhcdTUzcwwYmQub_A@mail.gmail.com> <CAMN686FNvCu8tsPhnFa2y-M_1-n+TWdMt9w-Pyr6QqK+VeLi8A@mail.gmail.com>
In-Reply-To: <CAMN686FNvCu8tsPhnFa2y-M_1-n+TWdMt9w-Pyr6QqK+VeLi8A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 14:25:59 -0400
Message-ID: <CAEjxPJ5NxR=qM9VgAH+DASzquqAjEKb-YDqY7cNN9Ujm5Ut+tQ@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 12:23 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Fri, Jul 24, 2020 at 12:09 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 11:48 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Jul 24, 2020 at 11:34 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 24, 2020 at 10:14 AM Mike Palmiotto
> > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > >
> > > > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > > > > /selinux/status") introduced the sestatus mechanism, which allows for
> > > > > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> > > > >
> > > > > The mechanism was initially intended for use by userspace object
> > > > > managers which were calculating access decisions within their
> > > > > application and did not rely on the libselinux AVC implementation. In
> > > > > order to properly make use of sestatus within avc_has_perm(), the status
> > > > > mechanism needs to properly set avc internals during status events;
> > > > > else, avc_enforcing is never updated upon sestatus changes.
> > > > >
> > > > > This commit introduces a new selinux_status_loop() function, which
> > > > > replaces the default netlink-equivalent, avc_netlink_loop(). The
> > > > > function watches the kernel status page until an error occurs, at which
> > > > > point it will exit the thread. In the event that the status page cannot
> > > > > be opened (on avc_open), the thread will continue to function as before
> > > > > by using a fallback netlink socket.
> > > > >
> > > > > This allows us to replace the call to avc_netlink_open() in
> > > > > avc_init_internal() with a call to selinux_status_open() and remove the
> > > > > avc_netlink_check_nb() call from the critical code path in
> > > > > avc_has_perm_noaudit(), as well as selinux_check_access().
> > > > >
> > > > > Userspace object managers that still need a netlink socket can call
> > > > > avc_netlink_acquire_fd() to open open and/or obtain one.
> > > > >
> > > > > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > > > > functionality.
> > > > >
> > > > > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > > > > ---
> > > > > Testing:
> > > > >   - dbus-daemon v1.12.8 on RHEL8.2
> > > > >   - dbus-broker v22 on F32
> > > >
> > > > This looks good to me as far as the code is concerned.  However,
> > > > installing the patched libselinux and rebooting, I notice that
> > > > afterward I have dbus-daemon running on a Fedora rawhide instance and
> > > > consuming nearly 100% CPU constantly.  I'm guessing it is sitting in
> > > > the status loop. Not sure why there is a dbus-daemon instance running
> > > > at all since dbus-broker seems to be the default in Fedora and
> > > > systemctl shows dbus-daemon as disabled.  But if I revert to the stock
> > > > libselinux, it stops hogging CPU.  Thoughts?
> > >
> > > Used gdb to attach to the separate thread and got a traceback before
> > > and after the libselinux patch.
> > > Sure enough, before it is performing a blocking poll() operation and
> > > hence sleeping.  After it is spinning in
> > > the status loop.
> >
> > So, options would appear to be:
> > 1) Drop the usage of avc_using_threads altogether, i.e. even if the
> > caller provided a thread callback, don't create another thread and
> > just call selinux_status_updated() on every avc_has_perm_noaudit()
> > unless avc_app_main_loop is set.  Rationale: dbus-daemon was only
> > using threads to avoid the overhead of avc_netlink_check_nb() on every
> > avc_has_perm_noaudit() call, and we've eliminated that via use of
> > sestatus, hence we don't need to create a separate thread at all.
> > -or-
> > 2) If using threads, then create the netlink socket during avc_init
> > and keep using the netlink loop for the thread.  This preserves the
> > blocking behavior.
> >
> > #1 seems more optimal to me and gets rid of threading for dbus-daemon,
> > which was something they didn't like anyway.
>
> Perhaps this is misguided, but it seems like avc_init is deprecated
> and along with it the ability to even set a custom thread callback.
> IOTW there does not appear to be a mechanism to set a thread callback
> while using avc_open (only avc_init). Perhaps we can just get rid of
> the default callback for avc_open and allow the (deprecated) avc_init
> to continue using it as it does?
>
> Is this basically what you were proposing for #2? I think I'd be more
> inclined to go with that approach, in case userspace object managers
> are doing other things in their thread callback.

I think that's the same as #2 if I understood you currently.  That's
fine if you prefer it.
So then programs using avc_init() with non-NULL thread callbacks
(hence avc_using_threads == 1) will still create the netlink socket
and start a thread running avc_netlink_loop().  And programs using
avc_netlink_acquire_fd() will create the netlink socket if not already
created and can use it however they want.  Everything else will move
to using the status page.
