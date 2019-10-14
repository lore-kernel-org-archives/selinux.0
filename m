Return-Path: <SRS0=gfEM=YH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BC9ECE58E
	for <selinux@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9203220854
	for <selinux@archiver.kernel.org>; Mon, 14 Oct 2019 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g03BA/Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbfJNLra (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:47:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730178AbfJNLra (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Oct 2019 07:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571053648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgYv54c4vuKeaHcGIIKYzlMRCTdnJho61wNbWnGsb8Q=;
        b=g03BA/AmSBf2jcPAYXBcx1U+ClyGQi7maH1eZAV+dKIoAvImh78MRcDnLgWMhjnE5iF8u5
        2I2ZUyFwDrY77PiRWBYQmPYqy0qTGb3/wNasbeonQDEwKqebIwWJDMf/c4o2k3BHSL+ycp
        n8BbB55J2SSGDCHYq3zAY6QtWJPglY4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-Wi-712GgP6auuWqjrE9_SA-1; Mon, 14 Oct 2019 07:47:25 -0400
Received: by mail-ot1-f72.google.com with SMTP id z24so7485001otq.6
        for <selinux@vger.kernel.org>; Mon, 14 Oct 2019 04:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hYG28HXnkRNT7QRwH9xxr4Q7Dggoitdum3h4Y5lSECE=;
        b=MKHeU+7vv/vmhHuAydCaqzv92DSeecARnkL9a7MWDm9pSwz/g1PDDvDJxQ6iy81R/J
         unx2zxn4gfIneaE6+ET1nDdnJgGzB5UGFXPewn/JD2dml3kpq3qyPbDzV234HVag8Ugv
         cqC4OJSqu6tGENa3fGy0qvjECdXx/wTYq2A8xWbUu3aNfchPOMyc2MMQqR6ayj1mUI7r
         9AmTZQgYL/luPjuQkz2iYePLckPXsj2XaOzxJKfP+bozpHWBrztm3j8oQ5s0trnEF0O+
         7q/v7cViwIKChoMlfSD/OkQJlekCXVxgei414tAVXUUCtmbfXNzVe9Oe9HopTQunIkdB
         8Wlw==
X-Gm-Message-State: APjAAAVFV48cHvnED0nzPDquQuJtSPD7zsNVJ6R0zlrEZHxAWkf4EGVc
        VP+SyEU2EZJ3fusUnpA7aNK4pK4D05k8wFg6JXpUmRHoGH9j0w9HgRndHB/xw8tI9oRqVIXpotP
        FC0ZJmN/yaboVNe4xGE8dFzQc9Jzi35mFDA==
X-Received: by 2002:aca:100f:: with SMTP id 15mr24126446oiq.166.1571053644828;
        Mon, 14 Oct 2019 04:47:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxr0HFF6Ze6Ybvexx5611FfLGOvA2CmefkmBdOXsw0uSiBRY9Y7bJ+nt39vKAxDGb8bvyqXTZnK7VqthAkPaTk=
X-Received: by 2002:aca:100f:: with SMTP id 15mr24126427oiq.166.1571053644371;
 Mon, 14 Oct 2019 04:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131600.21473-1-omosnace@redhat.com> <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
 <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com>
 <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov> <CAHC9VhRmX0ofWA7Yqg73XfDW0Hhf2j6Yr7pi1pQ=bDBiARd5sg@mail.gmail.com>
 <CAFqZXNvoh_ev=-RTFPgMBKGddzWME=SBqtX-EtKQ8f_YEGQOkw@mail.gmail.com> <CAHC9VhR=VF5jEttDLOh0XUkWuLi-aoK9uGGOTCST5ue=-ymatQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR=VF5jEttDLOh0XUkWuLi-aoK9uGGOTCST5ue=-ymatQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 14 Oct 2019 13:47:13 +0200
Message-ID: <CAFqZXNtpAnyCa9OKkbo5UYyZUQm=p6V_bKaf_ztyjOcjYfOQ4A@mail.gmail.com>
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: Wi-712GgP6auuWqjrE9_SA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 10, 2019 at 12:50 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Oct 9, 2019 at 10:53 AM Ondrej Mosnacek <omosnace@redhat.com> wro=
te:
> > On Wed, Oct 9, 2019 at 4:01 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Oct 9, 2019 at 9:53 AM Stephen Smalley <sds@tycho.nsa.gov> wr=
ote:
> > > > On 10/8/19 5:30 PM, Paul Moore wrote:
> > > > > On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.g=
ov> wrote:
> > > > >> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> > > > >>> Add a test that verifies that SELinux permissions are not check=
ed when
> > > > >>> mounting submounts. The test sets up a simple local NFS export =
on a
> > > > >>> directory which has another filesystem mounted on its subdirect=
ory.
> > > > >>> Since the export is set up with the crossmnt option enabled, an=
y client
> > > > >>> mount will try to transparently mount any subdirectory that has=
 a
> > > > >>> filesystem mounted on it on the server, triggering an internal =
mount.
> > > > >>> The test tries to access the automounted part of this export vi=
a a
> > > > >>> client mount without having a permission to mount filesystems, =
expecting
> > > > >>> it to succeed.
> > > > >>>
> > > > >>> The original bug this test is checking for has been fixed in ke=
rnel
> > > > >>> commit 892620bb3454 ("selinux: always allow mounting submounts"=
), which
> > > > >>> has been backported to 4.9+ stable kernels.
> > > > >>>
> > > > >>> The test first checks whether it is able to export and mount di=
rectories
> > > > >>> via NFS and skips the actual tests if e.g. NFS daemon is not ru=
nning.
> > > > >>> This means that the testsuite can still be run without having t=
he NFS
> > > > >>> server installed and running.
> > > > >>
> > > > >> 1) We have to manually start nfs-server in order for the test to=
 run;
> > > > >> else it will be skipped automatically.  Do we want to start/stop=
 the
> > > > >> nfs-server as part of the test script?
> > > > >
> > > > > My two cents are that I'm not sure we want to automatically start=
/stop
> > > > > the NFS server with the usual "make test", perhaps we have a dedi=
cated
> > > > > NFS test target that does the setup-test-shutdown?  Other ideas a=
re
> > > > > welcome.
> > > >
> > > > I guess my concern is that anything that doesn't run with the defau=
lt
> > > > make test probably won't get run at all with any regularity.
> > >
> > > FWIW, I think I'm the only one regularly running the tests on upstrea=
m
> > > kernels and reporting the results.  RH was running the tests at one
> > > point, and may still be doing so, but I have no idea what kernels the=
y
> > > are testing (maybe just RHEL, stable Fedora, etc.) and what their
> > > process is when they find failures.
> >
> > We do still run the selinux-testsuite nightly on Fedora Rawhide with
> > your kernel-secnext kernel builds (I suppose we fetch them from COPR).
> > I can't really describe what we do when they fail, because that hardly
> > ever happens now :)
>
> I'm happy to hear that the tests are still running, but we must be
> looking at different test results ;)

Well, we pin the testsuite to a fixed commit and bump it manually as
needed/wanted, so we generally don't see failures that are fixed
quickly. But I don't recall many (non-false-positive) failures
appearing on kernel-secnext in the past few months either.

>
> > But if we came across a failure that would suggest
> > a bug, we would certainly investigate and report it.
>
> Great, thank you.
>
> > The testsuite is now also being run as part of CKI
> > (https://github.com/cki-project), which AFAIK currently runs regularly
> > on linux-stable kernels (the results are posted publicly to
> > stable@vger.kernel.org). I don't follow these reports closely, so I'm
> > not sure if there were any non-false-positive failures there...
>
> That's good news.  I assume CKI has some provision for emailing people
> when there are test failures?  I don't really need to see every
> -stable kernel test, but it might be nice to see the failures.
> Alternatively, now that I think about it, this shouldn't be that hard
> to setup with the secnext stuff ...

I don't know if it is possible to subscribe to test failures (I'd
guess not). There is a notion of test maintainers, who are defined
internally, who receive reports of failures for review before they are
sent to relevant recipients, but this is an internal-only facility...
Maybe you can try filing a feature request at [1]?

[1] https://github.com/CKI-project/meta/issues

>
> > > > For
> > > > something that requires specialized hardware (e.g. InfiniBand), thi=
s is
> > > > reasonable but that isn't true of NFS.  For the more analogous case=
s of
> > > > e.g. labeled IPSEC, NetLabel, SECMARK, we already load and unload
> > > > network configurations for the testsuite during testing.
> > >
> > > That's a good point about the other networking tests.  My gut feeling
> > > tells me that NFS should be "different", but I guess I can't really
> > > justify that statement in an objectively meaningful way.
> >
> > I think the main reason why I didn't include NFS server starting was
> > that I don't know how to do it robustly across distros... Already on
> > RHEL the service name varies ("nfs-server" vs. just "nfs") and then
> > there is "service xyz start" vs. "systemctl start xyz"...
>
> That's another good point.  At this point in time I think it is
> relatively safe to stick with systemd/systemctl (and skip if systemctl
> is not found) as systemd appears to be eating the world; although this
> doesn't help with the service name problem.

It seems that wherever the service can be started by systemctl, it is
called "nfs-server" (on RHEL-7 there is also an alias "nfs"), so I
think we can stick to just 'systemctl start nfs-server' and it should
work most (if not all) of the time.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

