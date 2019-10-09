Return-Path: <SRS0=kJgC=YC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC4FC47404
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3777C21848
	for <selinux@archiver.kernel.org>; Wed,  9 Oct 2019 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hqTvZHky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJIOBR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:01:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45776 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIOBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Oct 2019 10:01:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so2588475ljb.12
        for <selinux@vger.kernel.org>; Wed, 09 Oct 2019 07:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5w6DfA5fK6ohCj35lJ5yO2ByRXvYnJVG9/NqsSI2uk=;
        b=hqTvZHky0VNn8PvNdE17t8yGwxczwdAG9yeLsbrx1L4+MxEgT0wh/rY0E6mqKofxcj
         NtRJN+XtjGLKo7JQeY8KyP5cHL4WkgR5G1no17pqcdtVSQZC7zVM3w5ndFutXsagyH7C
         FXMLn7vhEfCzwyBVXVWRnKB21d8bkojXwkSx+shtUc3RCtF66UCpIniBTi0YaX2mQkVC
         /77qkrEnJQZWRKHLttxfQQNfxgsLBJZfRZzPZreds/U9HY8HRQ96N3HmIRyQIs57V6cf
         CIIypFU8jMsMcRh20sgBr/M0qkO9B8Mqt2PUHTKoz+W73AF/HXvEjpfu/li7S6oNlbUc
         vMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5w6DfA5fK6ohCj35lJ5yO2ByRXvYnJVG9/NqsSI2uk=;
        b=FvTGE54OAqsS482Mj0WuhE5yBbEyLy0+g25nDUSfaxX5bsG0DrW9BhXB4HdqP8VHZI
         rvMKWRj8HbsAEz2cBqS+VtMOBRl2gjx1UnGBt34wgpYxDFWPGQK5P345T2uf/2knVdKY
         Hpz2ST2f++FanKh5RqIEBTVWesVhQkF00V0o7CoyNEVrjsXnqglypM7QEgwxnRpgzptF
         cI2COe8/Pc5cyOZAlyoCc8BHM+Gdxpnw+iDsI2O/n1DhJwQGRXa59bUAjp0j57dUWx2j
         E6sjR1Dt7GT1qBKOxU7rgyoD4aGlSpNmexXzeql+6IPgV2Wo+VTZXgEwgF7XSKJrtHB6
         lU0A==
X-Gm-Message-State: APjAAAUUzLi36l6vpZLQAkcvM1EB90bDh4KUVAYsYIFULfBclBDUwY5i
        VNkzRBIUuZAdd8+FQZjkaYeZFF/WhiRcpX9qFTaGy3o=
X-Google-Smtp-Source: APXvYqzyIC6Ji5obQJSEWZjdr5xmwZ2vJ5jPPO0JqHZhL7adZQSap1LwG9rldYiERuUqxSGOV/lPqtlSkHy/vCZVOUk=
X-Received: by 2002:a2e:6e18:: with SMTP id j24mr2373585ljc.57.1570629675501;
 Wed, 09 Oct 2019 07:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190930131600.21473-1-omosnace@redhat.com> <c9cc5939-a6f3-73cd-7ff3-a83a04d36b17@tycho.nsa.gov>
 <CAHC9VhTVNgqOgRjgk37x0EyZQWBbrYJ1FND5hVMxZUJ5JcofPA@mail.gmail.com> <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov>
In-Reply-To: <ddea594c-717b-cb40-6bd7-7bb6c8cae79d@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Oct 2019 10:01:04 -0400
Message-ID: <CAHC9VhRmX0ofWA7Yqg73XfDW0Hhf2j6Yr7pi1pQ=bDBiARd5sg@mail.gmail.com>
Subject: Re: [PATCH testsuite] selinux-testsuite: Add submount test
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 9, 2019 at 9:53 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/8/19 5:30 PM, Paul Moore wrote:
> > On Mon, Sep 30, 2019 at 10:07 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 9/30/19 9:16 AM, Ondrej Mosnacek wrote:
> >>> Add a test that verifies that SELinux permissions are not checked when
> >>> mounting submounts. The test sets up a simple local NFS export on a
> >>> directory which has another filesystem mounted on its subdirectory.
> >>> Since the export is set up with the crossmnt option enabled, any client
> >>> mount will try to transparently mount any subdirectory that has a
> >>> filesystem mounted on it on the server, triggering an internal mount.
> >>> The test tries to access the automounted part of this export via a
> >>> client mount without having a permission to mount filesystems, expecting
> >>> it to succeed.
> >>>
> >>> The original bug this test is checking for has been fixed in kernel
> >>> commit 892620bb3454 ("selinux: always allow mounting submounts"), which
> >>> has been backported to 4.9+ stable kernels.
> >>>
> >>> The test first checks whether it is able to export and mount directories
> >>> via NFS and skips the actual tests if e.g. NFS daemon is not running.
> >>> This means that the testsuite can still be run without having the NFS
> >>> server installed and running.
> >>
> >> 1) We have to manually start nfs-server in order for the test to run;
> >> else it will be skipped automatically.  Do we want to start/stop the
> >> nfs-server as part of the test script?
> >
> > My two cents are that I'm not sure we want to automatically start/stop
> > the NFS server with the usual "make test", perhaps we have a dedicated
> > NFS test target that does the setup-test-shutdown?  Other ideas are
> > welcome.
>
> I guess my concern is that anything that doesn't run with the default
> make test probably won't get run at all with any regularity.

FWIW, I think I'm the only one regularly running the tests on upstream
kernels and reporting the results.  RH was running the tests at one
point, and may still be doing so, but I have no idea what kernels they
are testing (maybe just RHEL, stable Fedora, etc.) and what their
process is when they find failures.

I also try to enable everything that I can enable for my test runs.
Thanks to Mellanox I can even run the IB tests.

> For
> something that requires specialized hardware (e.g. InfiniBand), this is
> reasonable but that isn't true of NFS.  For the more analogous cases of
> e.g. labeled IPSEC, NetLabel, SECMARK, we already load and unload
> network configurations for the testsuite during testing.

That's a good point about the other networking tests.  My gut feeling
tells me that NFS should be "different", but I guess I can't really
justify that statement in an objectively meaningful way.

-- 
paul moore
www.paul-moore.com
