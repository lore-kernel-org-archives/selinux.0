Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ED5C433E1
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0305E206D8
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 15:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZAoCp6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGXPsa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXPsa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 11:48:30 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B255C0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 08:48:30 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v21so37691otj.9
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZkIAEkuDf5fci2p4cptUsfyVO66bgv66ZT2NA/aS7A=;
        b=OZAoCp6SwHw0BnAk2hJcqGtOT3U2kL27scAFT028Wh5uqU2hlZ8jqENFW23yC8Fdsi
         bW0XhRe6jkV19+LTVTm7v5MFiVA+WT3P8UZhTCejmbuZH2i1QRHFw5lmut7BJcAsBorl
         urVNJT/MPO4Ijw/jVCKti+g6JWnV4/ZsrW9h0h8C+wsc+DoUUttajfWb7F5cWKkRzUri
         eYjo00CVeYAOkEs1y1eMRzuJO+JR8R3dehcbj9yDr5owU0mMoEUggTbvGgS29gkOKZ2S
         CkZxJoIUMBwLk3KsGTCMCvP8uiC3roeOK1Qpkqt5ngNo845UMVQCNv7o3MM8t5t4wa2e
         nPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZkIAEkuDf5fci2p4cptUsfyVO66bgv66ZT2NA/aS7A=;
        b=eLlsV5F8yNo+ur2FjOZdvV/Z+4rY+mWe7oNI9lWLhVSPJSVc2kyjp/aUkprrbDRFMb
         I3+CDx3hHlGYvzzu+E1NVgDY9PhLdtFGvybzNlZoVfH54+1+peuAPmmuNzccQ4yrXP5l
         7q6PM5RyqyCNp3wR19zLkKpcr2fGmO39VERomleLtlWaPLI69u7I2wwbSwKdSAS3oEsb
         f06ib5Ah5+OkIOmyKxdE4v01VCk9UrjhLYBAas7peREq99dW2+XkXMFbeYzB2lua0NQ8
         wBpd0s5R097GfeYX6kMs0msyTiLBWhj2T5hsWkFNmBMORusaI9XgNu4cSTzHZIcUUtk0
         JHOg==
X-Gm-Message-State: AOAM53228jX3mtqEObXvtYPhRwyIOfyB54alx5oZE8/+wci0ArTMRT1M
        r0iwfo5LY05WI/9f4nOTUApCY4LyL/tZcwNkFvUgrA==
X-Google-Smtp-Source: ABdhPJy3hpXAdQBeJF18wlpUWl2qpqYAQbdZbG+rnAArrvpCNs8Vs8txdC59ELhhOUldnRJj9JI5q9gbyoe/mgOJD6g=
X-Received: by 2002:a9d:6e14:: with SMTP id e20mr9035506otr.89.1595605709682;
 Fri, 24 Jul 2020 08:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com> <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 11:48:18 -0400
Message-ID: <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 11:34 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 10:14 AM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > /selinux/status") introduced the sestatus mechanism, which allows for
> > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> >
> > The mechanism was initially intended for use by userspace object
> > managers which were calculating access decisions within their
> > application and did not rely on the libselinux AVC implementation. In
> > order to properly make use of sestatus within avc_has_perm(), the status
> > mechanism needs to properly set avc internals during status events;
> > else, avc_enforcing is never updated upon sestatus changes.
> >
> > This commit introduces a new selinux_status_loop() function, which
> > replaces the default netlink-equivalent, avc_netlink_loop(). The
> > function watches the kernel status page until an error occurs, at which
> > point it will exit the thread. In the event that the status page cannot
> > be opened (on avc_open), the thread will continue to function as before
> > by using a fallback netlink socket.
> >
> > This allows us to replace the call to avc_netlink_open() in
> > avc_init_internal() with a call to selinux_status_open() and remove the
> > avc_netlink_check_nb() call from the critical code path in
> > avc_has_perm_noaudit(), as well as selinux_check_access().
> >
> > Userspace object managers that still need a netlink socket can call
> > avc_netlink_acquire_fd() to open open and/or obtain one.
> >
> > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > functionality.
> >
> > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> > ---
> > Testing:
> >   - dbus-daemon v1.12.8 on RHEL8.2
> >   - dbus-broker v22 on F32
>
> This looks good to me as far as the code is concerned.  However,
> installing the patched libselinux and rebooting, I notice that
> afterward I have dbus-daemon running on a Fedora rawhide instance and
> consuming nearly 100% CPU constantly.  I'm guessing it is sitting in
> the status loop. Not sure why there is a dbus-daemon instance running
> at all since dbus-broker seems to be the default in Fedora and
> systemctl shows dbus-daemon as disabled.  But if I revert to the stock
> libselinux, it stops hogging CPU.  Thoughts?

Used gdb to attach to the separate thread and got a traceback before
and after the libselinux patch.
Sure enough, before it is performing a blocking poll() operation and
hence sleeping.  After it is spinning in
the status loop.
