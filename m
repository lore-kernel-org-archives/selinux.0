Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67401C433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 19:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6DE206F6
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 19:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="q9gPeooc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGXTes (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTer (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 15:34:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C191C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 12:34:47 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so5777298lfj.8
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgzdS28TdUYp6AbSVTVhIhnNTMyCpjnWrRNxeNwJkTo=;
        b=q9gPeoocZexnHr8VO+A+FAa+ly2VNNrGRxN7ZFZ9tavk9M4//ZkFGaJnPlUOEroCsJ
         RHwltftHxT6tG5U0FXrEKQWZ5KVP7YHbCWWrGiiT1mtABvbrhiQfgdVfRTC33sOF+yos
         shvBz5/AK2+oNLjzSt1h/VtkXCqyIQKQxfg60EH3oqMzkAK7tKW6yxlwQ+t8Sm1DHfL5
         N2YWCtZH4N4Sh2qBhGwU1mP5zl+EVBbk/Mjtdl5ILkrJS6AX4QabL7IdhNq27cHQmWWu
         fcUqBGhov0lb3WqCNYfyfjwA1IueM4JIhuCX7uSJSdLy89Cp2zoZY00Z5+kpuM+ZaMxh
         HNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgzdS28TdUYp6AbSVTVhIhnNTMyCpjnWrRNxeNwJkTo=;
        b=pnj32oxB47xpSGXjPXKrmugnxPf+z4I9BePftd2ToGDSZm0iMhEB+lb5hET3G2GYSF
         4ueZTFHRKhwlKCLPOJZYpbBRxNHIpta8PmHsFN30M690ghffRCgFn6YTmQmn2ktso18F
         pyGIF+u3IXL+z+BFy5E4fP54bY1OGptLwiVnPdYEdhxXGyf3EuhAfXD8Eih/lkBpoBJx
         UZGaE689J7ZDjMrD7j0BCM76qWVX93k8Mk+/m1lRw8h/5GALrNGfPk1JDvQKuzUkxEHE
         jnt1Boo21SM8ivIqqKn/WQSbHZPkwt0MnswwqF9xJe2KByfMV626LTIfepwtDhMme80d
         BGuA==
X-Gm-Message-State: AOAM530Xpmb5dA5+XF0swbSvX6wTm6NRhj0YDq8+h/Z2myiJAazCVwye
        w8T9QI0AEB+CyP0TvPrvTxW6yr9JH4t1Zlh8JiAeWw==
X-Google-Smtp-Source: ABdhPJwDWq1/O50J63Bg0iTSrRxqhyVyBOq/Z4VXPXRM6OaH5NfTWgcqMuMempW/4LnTm2I4MRTNjlNgOMak4bAgKcA=
X-Received: by 2002:a19:848d:: with SMTP id g135mr5800312lfd.1.1595619285638;
 Fri, 24 Jul 2020 12:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
 <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
 <CAEjxPJ4JF_2jRP5WG6Uz51gEc7H+nRv2YAhcdTUzcwwYmQub_A@mail.gmail.com>
 <CAMN686FNvCu8tsPhnFa2y-M_1-n+TWdMt9w-Pyr6QqK+VeLi8A@mail.gmail.com> <CAEjxPJ5NxR=qM9VgAH+DASzquqAjEKb-YDqY7cNN9Ujm5Ut+tQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5NxR=qM9VgAH+DASzquqAjEKb-YDqY7cNN9Ujm5Ut+tQ@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Fri, 24 Jul 2020 15:34:33 -0400
Message-ID: <CAMN686GPNoLppwOPSkwbCc2GX-AzKtJHayZpGOL1DWPBawwNKw@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 2:26 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 12:23 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 12:09 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Fri, Jul 24, 2020 at 11:48 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 24, 2020 at 11:34 AM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > >
> > > > > On Fri, Jul 24, 2020 at 10:14 AM Mike Palmiotto
> > > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > > >
> > > > > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > > > > > /selinux/status") introduced the sestatus mechanism, which allows for
> > > > > > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> > > > > >
> > > > > > The mechanism was initially intended for use by userspace object
> > > > > > managers which were calculating access decisions within their
> > > > > > application and did not rely on the libselinux AVC implementation. In
> > > > > > order to properly make use of sestatus within avc_has_perm(), the status
> > > > > > mechanism needs to properly set avc internals during status events;
> > > > > > else, avc_enforcing is never updated upon sestatus changes.
> > > > > >
> > > > > > This commit introduces a new selinux_status_loop() function, which
> > > > > > replaces the default netlink-equivalent, avc_netlink_loop(). The
> > > > > > function watches the kernel status page until an error occurs, at which
> > > > > > point it will exit the thread. In the event that the status page cannot
> > > > > > be opened (on avc_open), the thread will continue to function as before
> > > > > > by using a fallback netlink socket.
> > > > > >
> > > > > > This allows us to replace the call to avc_netlink_open() in
> > > > > > avc_init_internal() with a call to selinux_status_open() and remove the
> > > > > > avc_netlink_check_nb() call from the critical code path in
> > > > > > avc_has_perm_noaudit(), as well as selinux_check_access().
> > > > > >
> > > > > > Userspace object managers that still need a netlink socket can call
> > > > > > avc_netlink_acquire_fd() to open open and/or obtain one.
> > > > > >
> > > > > > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > > > > > functionality.
> > > > > >
> > > > > > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > > > > > ---
> > > > > > Testing:
> > > > > >   - dbus-daemon v1.12.8 on RHEL8.2
> > > > > >   - dbus-broker v22 on F32
> > > > >
> > > > > This looks good to me as far as the code is concerned.  However,
> > > > > installing the patched libselinux and rebooting, I notice that
> > > > > afterward I have dbus-daemon running on a Fedora rawhide instance and
> > > > > consuming nearly 100% CPU constantly.  I'm guessing it is sitting in
> > > > > the status loop. Not sure why there is a dbus-daemon instance running
> > > > > at all since dbus-broker seems to be the default in Fedora and
> > > > > systemctl shows dbus-daemon as disabled.  But if I revert to the stock
> > > > > libselinux, it stops hogging CPU.  Thoughts?
> > > >
> > > > Used gdb to attach to the separate thread and got a traceback before
> > > > and after the libselinux patch.
> > > > Sure enough, before it is performing a blocking poll() operation and
> > > > hence sleeping.  After it is spinning in
> > > > the status loop.
> > >
> > > So, options would appear to be:
> > > 1) Drop the usage of avc_using_threads altogether, i.e. even if the
> > > caller provided a thread callback, don't create another thread and
> > > just call selinux_status_updated() on every avc_has_perm_noaudit()
> > > unless avc_app_main_loop is set.  Rationale: dbus-daemon was only
> > > using threads to avoid the overhead of avc_netlink_check_nb() on every
> > > avc_has_perm_noaudit() call, and we've eliminated that via use of
> > > sestatus, hence we don't need to create a separate thread at all.
> > > -or-
> > > 2) If using threads, then create the netlink socket during avc_init
> > > and keep using the netlink loop for the thread.  This preserves the
> > > blocking behavior.
> > >
> > > #1 seems more optimal to me and gets rid of threading for dbus-daemon,
> > > which was something they didn't like anyway.
> >
> > Perhaps this is misguided, but it seems like avc_init is deprecated
> > and along with it the ability to even set a custom thread callback.
> > IOTW there does not appear to be a mechanism to set a thread callback
> > while using avc_open (only avc_init). Perhaps we can just get rid of
> > the default callback for avc_open and allow the (deprecated) avc_init
> > to continue using it as it does?
> >
> > Is this basically what you were proposing for #2? I think I'd be more
> > inclined to go with that approach, in case userspace object managers
> > are doing other things in their thread callback.
>
> I think that's the same as #2 if I understood you currently.  That's
> fine if you prefer it.
> So then programs using avc_init() with non-NULL thread callbacks
> (hence avc_using_threads == 1) will still create the netlink socket
> and start a thread running avc_netlink_loop().  And programs using
> avc_netlink_acquire_fd() will create the netlink socket if not already
> created and can use it however they want.  Everything else will move
> to using the status page.

What do you think about moving avc_create_thread call (if
avc_using_threads is set) into avc_netlink_acquire_fd().

That way, if the caller is using avc_init with a create_thread
callback, they can get their netlink socket and create the netlink
thread and everything will function as before. In theory, this would
also work for the sestatus netlink fallback.

-- 
Mike Palmiotto
https://crunchydata.com
