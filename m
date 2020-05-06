Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A6C28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 15:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D186620708
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 15:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErGAaykG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgEFPy5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729846AbgEFPy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 11:54:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93FC061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 08:54:57 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 19so516629ioz.10
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5yYhZ6seGP7bBKVbfquyMOxEfwxhan3cs0sf1QgmjJ8=;
        b=ErGAaykGqXVHNpkuSlC8ThMjymEz1HRFZt+V1Do9hZkcTy+dqbQCL6xtT6i8zXGckC
         LnHE7N2+DgKKNdVoLzPCNXGTW0JDnpvQ+HDgCsjctBTjo6EjnejjQOq5o1DnEz6wzgwN
         MWaiL82E7GbHufTONqzJUdgQp7AyNviRIDdlrOjb0QnwhhUejZBc/6GFAchBnvr0cRlF
         tVewPHzjc6xBf12zYLvb/LbiOQHLPohgfsW8G7aHCLmJ2PaRa+8ylMg/+ucd4PCUzAJ6
         WPoZaZ8o5Fv0ux334UEnTrDDpmEGCDcyLoFBQT9CczZLkwc9A03qjyo+cc2ZD875W6XX
         kXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5yYhZ6seGP7bBKVbfquyMOxEfwxhan3cs0sf1QgmjJ8=;
        b=FyI/B0hnoqyuW6QElCuYtBgVPASyj7gVGW9TbwS5fzcz9Vl2FsPq6Eus2B534YvNe8
         TyUgcCOWkDY4eWbG4i0fVCewcY2B4oc26SoihYz4w3+uQzUc44jHq7MnK/vsgAU45CxR
         7/fXpzTUAATH0y+vrqZRUxnXENA4lD84TRJyttkIXhv6uUQeMuQsKD1V2cdJSAqZ8pE2
         ZeS7EMSus87P7zYbmnf2B1gWhEGy/R5liQRqMAZwVxpcmZeddRPyMmamZT0lyKj/KFha
         FEhoZEV+ikWymJpdTDH6B/r4m8WNiG4x0IFy7T44byOyYHvawJprSiHbjQHC9Am8wgZD
         gEiw==
X-Gm-Message-State: AGi0PubkZOCWbV+PRqz1aaVRC82ZLbS/nKZsO9SWQkjxb9sZ3naDcmS3
        bKsQsoXFRsnl6C2mYG64Doom1PeaMZ8WjBEtC2/s8Pkc
X-Google-Smtp-Source: APiQypL4WubhvoWIRtH2IU8g3dzI8J3AvB16+NK2yT0aIDCp8eAJpaeqveJfxFePQtF9TUEY8WT1zaT3wqCvJpMPYAc=
X-Received: by 2002:a02:cd03:: with SMTP id g3mr8754588jaq.61.1588780496135;
 Wed, 06 May 2020 08:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com> <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 6 May 2020 10:54:44 -0500
Message-ID: <CAFftDdoMEY7C2mrJNj1DTMQqFViTnDozj2DzHQNOU=5P=1cRig@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 6, 2020 at 10:50 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 10:57 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Wed, May 6, 2020 at 8:45 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, May 5, 2020 at 8:54 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > Update the testsuite policy and code so that it builds and
> > > > runs on Debian unstable and stable successfully (if one has
> > > > already enabled SELinux on Debian).  Provide the necessary
> > > > dependencies and instructions in the README.
> > >
> > > A few notes for anyone trying to run this on Debian:
> > >
> > > 1) There is an open bug in Debian around gdm login shells running in
> > > the wrong context (initrc_t instead of unconfined_t),
> > > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=874191, due to the
> > > /sys/fs/selinux/user ERANGE problem breaking pam_selinux for the
> > > systemd --user instance and the lack of either a policy workaround (as
> > > previously done in Fedora to limit outbound transitions from init_t to
> > > only valid cases) or the recent libselinux fix (to stop using
> > > /sys/fs/selinux/user altogether).  To permit testing without requiring
> > > my own custom policy or libselinux, I simply ran the tests from a ssh
> > > login rather than a graphical login.  Non-graphical console login
> > > probably would have worked too but I didn't try. But I have escalated
> > > the bug with the Debian SELinux maintainers in hopes of getting that
> > > fixed.
> > >
> > > 2) In Debian unstable, I also had to setsebool -P ssh_sysadm_login=1
> > > to allow ssh login as unconfined.  I let the Debian SELinux
> > > maintainers know but it isn't clear they will change the default.
> > >
> > > 3) Debian policy package ships with /etc/selinux/config set to
> > > permissive since the policy often doesn't work cleanly out of the box,
> > > so I had to manually setenforce 1 before running the testsuite.  This
> > > btw killed any gdm login sessions as well due to missing execmem and
> > > other permissions so that's another reason to not do it from a gdm
> > > login under their current policy.
> > >
> > > 4) The Debian stable kernel didn't enable CONFIG_NETLABEL so all of
> > > the netlabel-dependent inet_socket tests failed on stable.  Debian
> > > unstable kernel had CONFIG_NETLABEL enabled and they all passed there.
> > > I didn't consider it worthwhile to build my own Debian stable kernel
> > > for testing it; I just wanted to ensure that the policy worked, which
> > > I consider the Debian unstable test to prove.
> > >
> > > Interestingly, on Debian unstable, we end up running more tests than
> > > on Fedora rawhide currently: 64 test scripts with 869 individual tests
> > > versus 62 test scripts with 824 individual tests.  This is because
> > > Debian unstable's policy (which is based on a recent snapshot of
> > > refpolicy) has class and permission definitions for everything in its
> > > kernel except the lockdown class, versus Fedora which lacks the watch*
> > > permissions as well as the perf_event and lockdown classes.
> >
> > This is fantastic, I haven't looked at it fully yet. But I'm assuming this would
> > be the initial bulk work to get the make check on travis better. So in theory
> > we can just replicate this on Travis. Is my understanding correct here?
> > Ideally, we can get to a point where if CI is passing, its already an RC
> > candidate.
>
> That would be great but I don't think it is quite that easy
> unfortunately. I'm not a travis-ci expert by any means, but I don't
> think it provides us with a way to replicate the current steps
> required to enable SELinux in Debian or Ubuntu.  Debian's current
> approach to enabling SELinux involves installing some additional
> packages, running a selinux-activate script to modify the kernel
> command line in the grub configuration to enable SELinux in the kernel
> and to update some other configurations (e.g. adding pam_selinux to
> pam configs), rebooting to come up with SELinux enabled in the kernel
> and to label all filesystems, and rebooting a second time to come up
> with everything including init in the right SELinux domain.  In
> contrast I think travis-ci just provides you with a stock Ubuntu LTS
> image and allows you to install additional packages and run commands
> on that running instance, but not to specify custom kernel parameters
> initially or to reboot the system before proceeding with further
> commands (if anyone knows differently, speak up). We'd have to get to
> the point where enabling SELinux in Debian is possible without
> requiring a reboot at all.  And then we'd have to wait for that
> support to find its way into one of the Ubuntu images supported by
> travis-ci.  Might be easier to just get travis-ci to support Fedora or
> CentOS images in the first place. Regardless, allowing the testsuite
> to be run by users of other distributions is worthwhile IMHO.

Oh dang. I was hoping just root access would be enough. We could,
always start a VM
with Fedora on the Travis CI machine.... It would be heavy... but its
doable. Getting
travis to move their images to non-ancient things has seemed
impossible, and then them
picking Ubuntu helps keep packages outdated :-P. I might also want to
see what we can
do for other CI options.

My approach for getting our CI in a state where we can just release
off of master if CI is
passing, was a VM + Fedora.
