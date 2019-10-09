Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F0ECE58C
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F016C218AC
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 22:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AFee5at7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbfJIWuE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 18:50:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43283 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731140AbfJIWuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 18:50:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id u3so2861177lfl.10
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2019 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zzcdxc02coSGQXLnwLxCWRN54HaP7TrVuJVDyf1NVo=;
        b=AFee5at74Is126Fg7moNTwLMDUTqFPoglNTvaeuzzt8TCU7SRnwucCJ08Iik+jkY+B
         d8aua3vmVV9QraLfuDM2ne93gh7KYfoo1e7tKJlwlwNWZ5ruhAtQQle3mHKlJ2IEhc7/
         /gRZXdWx/ZqPdWHS0HGVj6emS9nnVj06BDa18SADzyFGGWCo50nyZoJF8txy7NKoli7/
         WF99yNH5Db+g4nDS+LuJ5YElnAk8Oog1wjJ8iZ7vwbV+tbAwiSyo0QR6ItWRzl4PiRza
         8tnhQR6gKB3lilzr/LfwQnxfKjzsBfr6d0fDWNQ+P3aTTKkURGAGs9VqWCqlU5z0gl1S
         0Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zzcdxc02coSGQXLnwLxCWRN54HaP7TrVuJVDyf1NVo=;
        b=Niqo6F6Xh/YlW5kFrixkWNPrhLlTXx82eP+AhM+3sCWr+cehIOX7IemF29pA8IWiUu
         vhVrvnju3K771dco+GPI/satpzpg2dxEO08eXIFiNpXYe+66DaKzHegkmNoUTb6eHpGJ
         fhcGUCNKpK3UUZUNgAi5VLBjf/6Li9SHT8fYIVlwV+XgorsTEDfqDNIlroDSk54mB3fR
         wUCa/bI33LGkzFzS4yy4Gf+M1Rj8p/FupRp91VqOMaBbDDiZ8yUFxwoutkOk8KgwHLRB
         pmMaVeG/8d/dcGJGx3mgpAUjsd+1RpNWOrS5ZWF0/29LJtHFh0PiHt5vCPG8aiJx8XCD
         fPTg==
X-Gm-Message-State: APjAAAVU48Gy02KoQHLusN5uv9xOoCMs8oj8PBIMoMhZbIJfTCD2rr0q
        T5JVRrRex0mi2yNuCSi2Hu1GlMek0L0x6FU4aIIX
X-Google-Smtp-Source: APXvYqwq1CG/6KUiJDkwf2lcCpwCJURmWm5uQPIXrCsFmgpx1hxBtL2f8GWM3kgv46dh6E0FOx7EfgXd2oENwGKufj8=
X-Received: by 2002:ac2:5542:: with SMTP id l2mr3416244lfk.119.1570661401033;
 Wed, 09 Oct 2019 15:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131600.21473-1-omosnace@redhat.com> <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
 <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
 <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov> <CAHC9VhRmX0ofWA7Yqg73XfDW0Hhf2j6Yr7pi1pQ=bDBiARd5sg@mail.gmail.com>
 <CAFqZXNvoh_ev=-RTFPgMBKGddzWME=SBqtX-EtKQ8f_YEGQOkw@mail.gmail.com>
In-Reply-To: <CAFqZXNvoh_ev=-RTFPgMBKGddzWME=SBqtX-EtKQ8f_YEGQOkw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Oct 2019 18:49:50 -0400
Message-ID: <CAHC9VhR=VF5jEttDLOh0XUkWuLi-aoK9uGGOTCST5ue=-ymatQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 10:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Oct 9, 2019 at 4:01 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 9, 2019 at 9:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On 10/8/19 5:30 PM, Paul Moore wrote:
> > > > On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> > > >>> Add a test that verifies that SELinux permissions are not checked when
> > > >>> mounting submounts. The test sets up a simple local NFS export on a
> > > >>> directory which has another filesystem mounted on its subdirectory.
> > > >>> Since the export is set up with the crossmnt option enabled, any client
> > > >>> mount will try to transparently mount any subdirectory that has a
> > > >>> filesystem mounted on it on the server, triggering an internal mount.
> > > >>> The test tries to access the automounted part of this export via a
> > > >>> client mount without having a permission to mount filesystems, expecting
> > > >>> it to succeed.
> > > >>>
> > > >>> The original bug this test is checking for has been fixed in kernel
> > > >>> commit 892620bb3454 ("selinux: always allow mounting submounts"), which
> > > >>> has been backported to 4.9+ stable kernels.
> > > >>>
> > > >>> The test first checks whether it is able to export and mount directories
> > > >>> via NFS and skips the actual tests if e.g. NFS daemon is not running.
> > > >>> This means that the testsuite can still be run without having the NFS
> > > >>> server installed and running.
> > > >>
> > > >> 1) We have to manually start nfs-server in order for the test to run;
> > > >> else it will be skipped automatically.  Do we want to start/stop the
> > > >> nfs-server as part of the test script?
> > > >
> > > > My two cents are that I'm not sure we want to automatically start/stop
> > > > the NFS server with the usual "make test", perhaps we have a dedicated
> > > > NFS test target that does the setup-test-shutdown?  Other ideas are
> > > > welcome.
> > >
> > > I guess my concern is that anything that doesn't run with the default
> > > make test probably won't get run at all with any regularity.
> >
> > FWIW, I think I'm the only one regularly running the tests on upstream
> > kernels and reporting the results.  RH was running the tests at one
> > point, and may still be doing so, but I have no idea what kernels they
> > are testing (maybe just RHEL, stable Fedora, etc.) and what their
> > process is when they find failures.
>
> We do still run the selinux-testsuite nightly on Fedora Rawhide with
> your kernel-secnext kernel builds (I suppose we fetch them from COPR).
> I can't really describe what we do when they fail, because that hardly
> ever happens now :)

I'm happy to hear that the tests are still running, but we must be
looking at different test results ;)

> But if we came across a failure that would suggest
> a bug, we would certainly investigate and report it.

Great, thank you.

> The testsuite is now also being run as part of CKI
> (https://github.com/cki-project), which AFAIK currently runs regularly
> on linux-stable kernels (the results are posted publicly to
> stable@vger.kernel.org). I don't follow these reports closely, so I'm
> not sure if there were any non-false-positive failures there...

That's good news.  I assume CKI has some provision for emailing people
when there are test failures?  I don't really need to see every
-stable kernel test, but it might be nice to see the failures.
Alternatively, now that I think about it, this shouldn't be that hard
to setup with the secnext stuff ...

> > > For
> > > something that requires specialized hardware (e.g. InfiniBand), this is
> > > reasonable but that isn't true of NFS.  For the more analogous cases of
> > > e.g. labeled IPSEC, NetLabel, SECMARK, we already load and unload
> > > network configurations for the testsuite during testing.
> >
> > That's a good point about the other networking tests.  My gut feeling
> > tells me that NFS should be "different", but I guess I can't really
> > justify that statement in an objectively meaningful way.
>
> I think the main reason why I didn't include NFS server starting was
> that I don't know how to do it robustly across distros... Already on
> RHEL the service name varies ("nfs-server" vs. just "nfs") and then
> there is "service xyz start" vs. "systemctl start xyz"...

That's another good point.  At this point in time I think it is
relatively safe to stick with systemd/systemctl (and skip if systemctl
is not found) as systemd appears to be eating the world; although this
doesn't help with the service name problem.

-- 
paul moore
www.paul-moore.com
