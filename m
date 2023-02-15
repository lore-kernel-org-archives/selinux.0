Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C11C6379F
	for <selinux@archiver.kernel.org>; Wed, 15 Feb 2023 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjBOKTq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 05:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjBOKTp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Feb 2023 05:19:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3076932CD3
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676456336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9DBGCtP3d3bf5wS6EUGfhwN878s7GvOIT/XX4KTP0jE=;
        b=DR+3s+O8HeO02yiSWaOpGunGtxjYCmJKaTcoIju1glmGT9ophctcAgEpahrmYQUB+cKkiw
        7MA+iU+hgYlIMtVNbF/qKbtIDgEvgRDTYZfhDISXHb9lhA22HatW5SIWJqqv5H3SBU4C8R
        IQrRsYQXE3lzhDx5895fZJmPkxqeR+E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-aC5UKBjlNvurGuRPE7EbbA-1; Wed, 15 Feb 2023 05:18:54 -0500
X-MC-Unique: aC5UKBjlNvurGuRPE7EbbA-1
Received: by mail-pj1-f69.google.com with SMTP id l20-20020a17090ac59400b00233dc329a18so919282pjt.2
        for <selinux@vger.kernel.org>; Wed, 15 Feb 2023 02:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DBGCtP3d3bf5wS6EUGfhwN878s7GvOIT/XX4KTP0jE=;
        b=2wwWzrAwX8Po4VNSh5jPy3DDmuBqj+utnGstFpKCyfnl+AWBF1JSUAtFYIPSBnT8qe
         0o5sAC6BQhHjx/WVMIxOTjfckcQUevzj2kUfrU11aRfcjV8s049U7A+XvyR2GYXc9G83
         5Je+UVwk5AU8YbeNj1UfnqJhbk4P4o23u57KIaJJZqlamieAQ0eEs6YrfJOUlu1A8mR/
         XCB2bopBGU3C1b+soP7tgPClrPUjvjAeRW50pTBUKDibQWb48B/afxjz7eQc/sClCacU
         +LqTrY+a1R6IXEwUHaqJjzb+Qd62RDwFqJ7iRPCaKI02oWwyYTRWYVe7PKRpv80G5oGR
         haOQ==
X-Gm-Message-State: AO0yUKXQqOfuh9cOCGy+6oBACBD7Cd4YuW3mCZAWNsK9rxQBjeWHHToQ
        UjnslG/hd2bNuNZbooo+OP/2ce499GJQ137JuwIqvYPzgnfJCPsS2+YCztCN5tpNvgZHFvmMZjO
        sJpa90J/ybYeYw44B9W6wjjv8V7xzS5N0i0Fznq4qimcp
X-Received: by 2002:a63:b041:0:b0:4fa:b562:f29a with SMTP id z1-20020a63b041000000b004fab562f29amr232135pgo.120.1676456333525;
        Wed, 15 Feb 2023 02:18:53 -0800 (PST)
X-Google-Smtp-Source: AK7set94/PECXd2vao068Jq9iZl4KuIuVv9ufrBucj0EqtDynyNI4DVSE3pAB9SSfdeO9hG9zhHAcTPHtbUQ7T6Xluo=
X-Received: by 2002:a63:b041:0:b0:4fa:b562:f29a with SMTP id
 z1-20020a63b041000000b004fab562f29amr232131pgo.120.1676456333114; Wed, 15 Feb
 2023 02:18:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
 <CAFqZXNuv780r04wsLyGvi+CmBFp_v=m1KCNA=ycPRwy5J0YQ9g@mail.gmail.com>
 <CAHC9VhSpC8Fsj6e1fn=KgbjasTvD=8TDN0XV9YhN0+a4A6t8zA@mail.gmail.com>
 <CAHC9VhT8YNfhcP_h1iNaTPyM02C4Eo2U88yLV9-GHHtL0_P8Kg@mail.gmail.com> <CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 15 Feb 2023 11:18:41 +0100
Message-ID: <CAFqZXNuE6JFNqCjZ0MbDrHo+eqx9xuStq6_iOWgT4Q4H5saHvA@mail.gmail.com>
Subject: Re: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent
 Rawhide builds
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 14, 2023 at 10:59 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Feb 10, 2023 at 12:30 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Feb 10, 2023 at 11:57 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Feb 10, 2023 at 3:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Thu, Feb 9, 2023 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > Hi all,
> > > > >
> > > > > I just noticed a selinux-testsuite failure in the tests/file test:
> > > > >
> > > > > # Test 8 got: "512" (file/test at line 103)
> > > > > #   Expected: "0"
> > > > > #  file/test line 103 is: ok( $result, 0 );
> > > > > file/test ................... Failed 1/16 subtests
> > > > >
> > > > > Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
> > > > > in test_sigiotask.c is failing due to a recent Rawhide change to
> > > > > undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
> > > > > commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
> > > > > information on the Kconfig option.
> > > > >
> > > > > I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
> > > > > turning it off is a good idea, but it does mean we need to adjust the
> > > > > selinux-testsuite.
> > > >
> > > > I noticed that in our CI yesterday and had a brief look. Unfortunately
> > > > I don't (yet) fully understand the terminal device voodoo being done
> > > > in test_sigiotask.c and I don't have any idea how to make it work
> > > > without TIOCSTI. So the best fix for now seems to be to use the
> > > > dev.tty.legacy_tiocsti sysctl (see the Kconfig). However, it seems to
> > > > be broken currently:
> > > >
> > > > # sysctl dev.tty.legacy_tiocsti
> > > > # sysctl -w dev.tty.legacy_tiocsti=1
> > > > sysctl: setting key "/proc/sys/dev/tty/legacy_tiocsti": Invalid argument
> > > > #
> > >
> > > Yep, I got to that point last night and had to leave for the evening
> > > so I fired off that email figuring you might get a chance to look into
> > > it before I could.
> > >
> > > Ultimately I think we'll probably still need to find some alternative
> > > to using TIOCSTI, but I'll admit to not having spent much time at all
> > > looking into how to do that.
> > >
> > > > I will look into fixing it...
> > >
> > > Thanks for getting to the root cause and posting the fix.
> > >
> > > > > Also, as a note to the Fedora folks who will see this, maybe don't
> > > > > tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
> > > > > test failures late in the -rc7 stage doesn't do wonders for my sanity
> > > > > ;)
> > > >
> > > > When new configs are added upstream, AFAIK, they are set to the
> > > > default value in the Fedora configs and marked as "pending". The
> > > > Fedora kernel maintainer (Justin Forbes) then at some point goes
> > > > through all pending configs and sets them to a value he deems best.
> > > > This time it happened around -rc7; I'm not going to speculate why or
> > > > if it's the usual practice. I recommend raising this on
> > > > kernel@lists.fedoraproject.org - Justin is always open to suggestions
> > > > and he might be able to accomodate this expectation.
> > >
> > > Thanks, I'll send a note.
> >
> > FWIW, it looks like the current Rawhide build is back to enabling
> > CONFIG_LEGACY_TIOCSTI.  My testing is back to running clean with
> > kernel 6.2.0-0.rc7.20230210git38c1e0c6.54.1.secnext.fc38.
>
> That proved to be short lived.
>
> Ondrej, would it be possible to disable the failing test until your
> patch lands upstream and ends up in Rawhide?

https://github.com/SELinuxProject/selinux-testsuite/commit/17fe94750dceb2f1a6a286cbe907718ca1b2fb8d

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

