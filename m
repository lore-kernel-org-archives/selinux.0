Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE517C433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 15:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43F220737
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4Pi3cQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGXPfD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXPfD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 11:35:03 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ACCC0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 08:35:01 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id s190so1880727ooa.13
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 08:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6uuaKSwoP/p9oU6/BIzuJSk/UywnjhWI/7ZJnkUlOk=;
        b=g4Pi3cQFL4Zb1ddJgjDce1ZPmvvYY50dfihAy7OTjVB5oxQnFFfW7cxeoTJmAbpy1V
         RMe55sj9VbaGaacxckClTR4ZCAHqPVRjibtmwPj3KiyizaQQ6bTtmCMlc9Jn5wP9eLyn
         mMnb658umX+EzbtkrnMWnLKX8Ao5wHZ7LiU6TGeENMRBW7ZBvW1KvJVnoIlw2knhuqMP
         fWdCcygMaLwDPFITLW3j9L8XeWatODZsvGVnWOERO/AtB0dDM07y8z5DCnUhYBcgqx62
         zlj0CoArvlQ058vWGlIbSDwffv8TQG3y8/FiCI8+hMTTnN+VSbu00/a5ofMlMTGKn0kz
         wsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6uuaKSwoP/p9oU6/BIzuJSk/UywnjhWI/7ZJnkUlOk=;
        b=cZroqWRf6VOPpdFpQzAtEc57vedW5FdLWtAy2ox95ORn7Nd+RbNrfHtczeRCKO6snM
         pv/eOX6GERFvqcBK7Czcxo8jbdN2O+mxgCKBPzPKKVf3w/GZoto5F7q4nzCmrjyrQFAb
         5Q+lekP8cVU3DvdihJshNRCkRJI4gSUZh2HlR0I/WXHDyCyCkUlETlLNyUNvBNPO+YdJ
         PpaeZR7OmUfL8ex2iPBDyOFpyeg+ddpBSfM8ikYgZCxbauJU8ZpkFQRtRyjKSzMPw+oK
         GGOOkksBf/ztoTvUj/2oxDsL+h5PJkJtSYThWrOHqghdEQam749YtBUm7zxvhnkXlveC
         uAQw==
X-Gm-Message-State: AOAM531r96ZLzAmYOiSaNzp7ncgftRc26bDeAl44QBhKEQgtnknC7lq+
        y6elhn8PFXt122uVWUY+i5XZ7MZVca6w/HD2aJOvwQ==
X-Google-Smtp-Source: ABdhPJzVyQQaJomWh1FA9XUmOHDvuFMYJmNg/XAixWayptBaBraucs2szcvw/r95N+SIacjkMNfVO3jPnAwqz3WTSGM=
X-Received: by 2002:a4a:3b0f:: with SMTP id s15mr7187508oos.71.1595604900523;
 Fri, 24 Jul 2020 08:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
In-Reply-To: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 11:34:49 -0400
Message-ID: <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 10:14 AM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> /selinux/status") introduced the sestatus mechanism, which allows for
> mmap()'ing of the kernel status page as a replacement for avc_netlink.
>
> The mechanism was initially intended for use by userspace object
> managers which were calculating access decisions within their
> application and did not rely on the libselinux AVC implementation. In
> order to properly make use of sestatus within avc_has_perm(), the status
> mechanism needs to properly set avc internals during status events;
> else, avc_enforcing is never updated upon sestatus changes.
>
> This commit introduces a new selinux_status_loop() function, which
> replaces the default netlink-equivalent, avc_netlink_loop(). The
> function watches the kernel status page until an error occurs, at which
> point it will exit the thread. In the event that the status page cannot
> be opened (on avc_open), the thread will continue to function as before
> by using a fallback netlink socket.
>
> This allows us to replace the call to avc_netlink_open() in
> avc_init_internal() with a call to selinux_status_open() and remove the
> avc_netlink_check_nb() call from the critical code path in
> avc_has_perm_noaudit(), as well as selinux_check_access().
>
> Userspace object managers that still need a netlink socket can call
> avc_netlink_acquire_fd() to open open and/or obtain one.
>
> Update the manpage to reflect the new avc_netlink_acquire_fd()
> functionality.
>
> Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> ---
> Testing:
>   - dbus-daemon v1.12.8 on RHEL8.2
>   - dbus-broker v22 on F32

This looks good to me as far as the code is concerned.  However,
installing the patched libselinux and rebooting, I notice that
afterward I have dbus-daemon running on a Fedora rawhide instance and
consuming nearly 100% CPU constantly.  I'm guessing it is sitting in
the status loop. Not sure why there is a dbus-daemon instance running
at all since dbus-broker seems to be the default in Fedora and
systemctl shows dbus-daemon as disabled.  But if I revert to the stock
libselinux, it stops hogging CPU.  Thoughts?
