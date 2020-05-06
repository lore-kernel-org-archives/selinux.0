Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16DEC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDA472075A
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 19:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mxmu4TLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgEFTRQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgEFTRQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 15:17:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B32BC061A0F
        for <selinux@vger.kernel.org>; Wed,  6 May 2020 12:17:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id l19so3601130lje.10
        for <selinux@vger.kernel.org>; Wed, 06 May 2020 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2FemKdkjYW49r58jhIfFS/sLcLSLHqmQyBGLuz/tsxw=;
        b=Mxmu4TLL4X91aZuIQAykY4zLEk8jJDKvauMkYzG1PSVz91Sf42xgkHKkpB7laYquv9
         /eO/AOQOeUhrI3bOdeR1cfuxe43ek3ai9IsVpASam5+qmoyceeYChnvKkf++thG92Kz6
         ihBS0sIt0GE5cVkpxB/0M7x46ljQJxSWITDPOtg086ogB31SyFtYOdnb5Itlqc5qgEKo
         oeqzqMP5OVLmHK8JqPmJzgvmUGUUgxF2U7Or84t78/HgMovoQtQgHw8+m7JIYeZkq+U5
         ELjizn3KFXYZOsRNrgjWYaWU/FXnXIR+SjEDn+9hZ8e2Ud/LkXKIxLrjuederLWfdGrr
         K7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2FemKdkjYW49r58jhIfFS/sLcLSLHqmQyBGLuz/tsxw=;
        b=p6azgUawsgC0M2vIh+wbGaEA8mODCWAnCdr6022Ql091biTaBUiR4/I1BFPME/+eS7
         VBSu0X66W8evp1WZyau/DtOVXIl9sJEyEQpnbWPheb0uHtENtq3dnuCHHjXTaHJseVSN
         TUN4oPY9mLJ1sEUQTLMTfDwEIHP8rD6d1KizM0f0qCl126J+jL9HXxRF/UHgTacI+U0z
         v9zsMHOVpEW/LReujpaFMBd7mupKP/bdHNMGBiDHDP+5LdMfHSqhhNGHdc8+3HGAd2B8
         Dwkp2usgs9ZY2e5VJqwIHj4Q3p3KTE4M8bmV5qIfjUMNy8XajRCAiqL0uiw6Reqp2uZu
         wDdQ==
X-Gm-Message-State: AGi0PuYa7HHWvSWbOFCWo/CWIXfrB1n1a/qR6u6QL2SqnYZemXvXuUxa
        7lzl8L+OJHSHe7r+dR2/CkvUGOaLp43VfMLlD9IQIzQd
X-Google-Smtp-Source: APiQypJFlSi7yaic1+Y0tNaAPzghSfSjsXPlhfbTZJ3pz5guQ2R/aMJ9Nu9othn7U1B9i2dHojG4PDW3GbzffUZENy4=
X-Received: by 2002:a2e:3009:: with SMTP id w9mr6113662ljw.71.1588792632460;
 Wed, 06 May 2020 12:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <CAEjxPJ7GVYBTKyiQM8_XdnbXk26-Eq_cPAs1zrtK8Aj=FfZd_A@mail.gmail.com>
 <CAFftDdrD-FJ8wBk=XOkvdnkvA5o10w5pJs31H9dEhtW1zU8EHA@mail.gmail.com>
 <CAEjxPJ452zaoFwy++cKqh_Ap2rM1ezEZN83mBhN4ndHHaQ4q5Q@mail.gmail.com> <CAJVWAV07O-cQ5EzqYpodjeVRjdtD7ga=bUwEiTm00BaKRMiyFQ@mail.gmail.com>
In-Reply-To: <CAJVWAV07O-cQ5EzqYpodjeVRjdtD7ga=bUwEiTm00BaKRMiyFQ@mail.gmail.com>
From:   Dac Override <dac.override@gmail.com>
Date:   Wed, 6 May 2020 21:17:01 +0200
Message-ID: <CAJVWAV3Aq1VQodmLSOr-qV4AFXTz7CPV4fEUuSTqBTHseOFzpw@mail.gmail.com>
Subject: Fwd: [PATCH] selinux-testsuite: update to work on Debian
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Forgot to hit "reply all"

I think one reboot should be enough but i don't see how you would do
it without rebooting at all.
By adding selinux=1 on the kernel boot line you effectively disable
apparmor (the apparmor service unit has a condition that disables when
selinux=1 i believe)
You dont need that selinux-activate script either. The pam config
should be set up out of the box.
all that remains it the kernel boot options and relabel AFAIK. The
boot options can be added without booting by editing /etc/default/grub
and running update-grub, but relabeling requires a reboot.

Enabling SELinux is actually amazingly simple considering the circumstances.

On Wed, May 6, 2020 at 5:52 PM Stephen Smalley
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
