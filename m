Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF531C433F5
	for <selinux@archiver.kernel.org>; Wed, 23 Feb 2022 21:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiBWVoH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiBWVoG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Feb 2022 16:44:06 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8DB3E5FC
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 13:43:38 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so164841eje.10
        for <selinux@vger.kernel.org>; Wed, 23 Feb 2022 13:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bJacL1gK1myHV6cmtvqCkNpKIOqEyVm+DidPJT3PKU=;
        b=sF8l6ITl0deyEMbxKkVIBrcWScHYUlwGQ8IQ5KmZ0HCOlbjdfOy9WsrDyQj6LWGhcv
         XHvcMFnlKmcsJSmgsY1rmpKshkAg8cYruw0wsuugbnkkzHD7MgPdOC6tAdEgHg45WR+3
         m2k4uZAbXdat+d3aXBzZTuFw6/XegOEvHgQR0tzcTRKAFhVFLNB2IjLo9pHyoUtVqGMB
         UOAT9gfzUxBjmOblb6206DPGuu+3UnRppOf3g1ywhHao8I/RF1TKAzOGE12ktriKt6mU
         Ml+BO4wJnQjK5FTt9k1MqxRe7WHHjEMoa10RhXV7MpH16ah7JM3J00tfLRBaLWVSYivY
         JAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bJacL1gK1myHV6cmtvqCkNpKIOqEyVm+DidPJT3PKU=;
        b=nKXY6Cd8Y7mq2uTgKANJP/WxSxNjaN1qElyXAz40tYomyDuk9sL+NAQXMNvL88o+J2
         zDuXafrXMnwQ/q2sZg49Ia5DbrFAti4HurHYZEo/W9H4b3I726RIec/bv+6Ttyw+B3hd
         L6IzmihhcqMsio4L7QvEmsbiXJOkvENoDhOAfRLjaW8Iw0bQwf3vLXYPVgy/TScK/Nbe
         iQYzo4OL89fy9TrgbOg3qav9K0H/zVIA1vrfrp+3bdBiqy/RWoeeNPI1orHMWCRhcL8H
         8he+DjlLhdWMdMhU0fEiCqdrCn08I9zGjRE9fKRucuQBtVtdVE2uanpyoHuWRFqMTu0y
         WF4Q==
X-Gm-Message-State: AOAM531OPpsgi6+AXEYcRmzL8CSNySV2FdebYqdJpP5nb+Hf6leookCi
        hkVsFbSYVBUhXfu0DS/9J1jSw0FfPJLqALoL9htLa+uQ3KJm
X-Google-Smtp-Source: ABdhPJwBa5BiAlhVuYVNXrJfYpf/d2rqSaNKp6tkpVo7n2CjOE9eD8xGwRxxfeJ3qiugJDqV0tr235dYcrvqaLu+QZo=
X-Received: by 2002:a17:906:6b8f:b0:6cd:7984:26fc with SMTP id
 l15-20020a1709066b8f00b006cd798426fcmr1203566ejr.701.1645652616571; Wed, 23
 Feb 2022 13:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20220221131533.74238-1-richard_c_haines@btinternet.com>
 <CAHC9VhQnRQFrM-mTzUQ3UsyVp2JYw1wUh=7yrdjH7-QmHKidAg@mail.gmail.com>
 <20396305e71619dbee4fa3c612925b57f4bb0a4b.camel@btinternet.com>
 <CAFqZXNuf5J35Jb3nmQ6YRrc6C2f5rk-30U0rB4wTMd-+SBQhEQ@mail.gmail.com>
 <2b45951fceea5f535550f8ab3f3d25c3ff12a8c5.camel@btinternet.com> <CAHC9VhSDavBRxWEp2frY_dkSaxSBHfiCZ1zF2YNNoq6+-+GTjA@mail.gmail.com>
In-Reply-To: <CAHC9VhSDavBRxWEp2frY_dkSaxSBHfiCZ1zF2YNNoq6+-+GTjA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 23 Feb 2022 16:43:25 -0500
Message-ID: <CAHC9VhQ6kVroFZri+=DTewcecZASsH9VGZKi_zY4MzbbSmkEng@mail.gmail.com>
Subject: Re: [PATCH V2] security/selinux: Always allow FIOCLEX and FIONCLEX
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, demiobenour@gmail.com,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 23, 2022 at 4:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Feb 23, 2022 at 7:43 AM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > On Wed, 2022-02-23 at 13:12 +0100, Ondrej Mosnacek wrote:
> > > On Wed, Feb 23, 2022 at 12:58 PM Richard Haines
> > > <richard_c_haines@btinternet.com> wrote:
> > > > On Tue, 2022-02-22 at 18:28 -0500, Paul Moore wrote:
> > > > > On Mon, Feb 21, 2022 at 8:15 AM Richard Haines
> > > > > <richard_c_haines@btinternet.com> wrote:
> > > > > >
> > > > > > These ioctls are equivalent to fcntl(fd, F_SETFD, flags), which
> > > > > > SELinux
> > > > > > always allows too.  Furthermore, a failed FIOCLEX could result
> > > > > > in a
> > > > > > file
> > > > > > descriptor being leaked to a process that should not have
> > > > > > access to
> > > > > > it.
> > > > > >
> > > > > > As this patch removes access controls, a policy capability
> > > > > > needs to
> > > > > > be
> > > > > > enabled in policy to always allow these ioctls.
> > > > > >
> > > > > > Based-on-patch-by: Demi Marie Obenour <demiobenour@gmail.com>
> > > > > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > > > > ---
> > > > > > V2 Change: Control via a policy capability. See this thread for
> > > > > > discussion:
> > > > > > https://lore.kernel.org/selinux/CAHC9VhQEPxYP_KU56gAGNHKQaxucY8gSsHiUB42PVgADBAccRQ@mail.gmail.com/T/#t
> > > > > >
> > > > > > With this patch and the polcap enabled, the selinux-testsuite
> > > > > > will
> > > > > > fail:
> > > > > > ioctl/test at line 47 - Will need a fix.
> > > > > >
> > > > > >  security/selinux/hooks.c                   | 7 +++++++
> > > > > >  security/selinux/include/policycap.h       | 1 +
> > > > > >  security/selinux/include/policycap_names.h | 3 ++-
> > > > > >  security/selinux/include/security.h        | 7 +++++++
> > > > > >  4 files changed, 17 insertions(+), 1 deletion(-)
> > > > >
> > > > > Thanks Richard for putting together the v2 of this patch.
> > > > >
> > > > > As far as the test is concerned, it seems like the quick-n-dirty
> > > > > fix
> > > > > is to simply remove the ioctl(FIOCLEX) test in test_noioctl.c; is
> > > > > everyone okay with that?  At least that is what I'm going to do
> > > > > with
> > > > > my local copy that I use to validate the kernel-secnext builds
> > > > > unless
> > > > > someone has a better patch :)
> > > >
> > > > To fix this I was planning to submit a patch that would change the
> > > > ioctl(FIOCLEX) tests to ioctl(FS_IOC_GETFSLABEL) as that would
> > > > continue
> > > > to test the xperms.
> > >
> > > That one seems to be implemented only by some filesystems. Is there
> > > any more generic one we could use?
> >
> > What about  FS_IOC_GETFLAGS
>
> Unless I'm mistaken, FIGETBSZ should be largely fs independent.

Bah, nevermind, FIGETBSZ ends up in a FILE__GETATTR check.
FS_IOC_GETFLAGS has the same problem.

How about FIOQSIZE?

-- 
paul-moore.com
