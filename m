Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53425C3A59E
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CE2208E4
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2NJoiAGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfIDVv4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:51:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfIDVv4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 17:51:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id a4so237531ljk.8
        for <selinux@vger.kernel.org>; Wed, 04 Sep 2019 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLUB432lX5X3dutdKzDN6KsR3auvv5fSBeZh7KikZzo=;
        b=2NJoiAGOpt9EhVLktNahlqVEweZ+qKtyqdfP9FHTFD6E18VYgG3/HoTqe5gCPcQPWd
         IlNhcbPsTB4kTSF7PgnpaNYgsD2pDX/rDoUZjRHbRnx2gJcTZZmIw+xG/OKZeD8aD9f9
         tanHAEdXT1zjtYid1J1mTWnhx3mlkQv8ZJIvprzgApKQ9Ieigk9ffHgQEqNS1v5PovDb
         mY1wJIdOA1GEufp005LWgizB/1JXNFcCLGI39n4WuZ0ql5Xka9jlOoLI+dTlhI32qKN+
         vSERBd93Mg9khccp/oYYDbi4S41krSoNvCCILcwaa0cFQlGbnaeu3STrnLqxXjlE8fX9
         eqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLUB432lX5X3dutdKzDN6KsR3auvv5fSBeZh7KikZzo=;
        b=LJL+x325NyhpZmk1pKImbwdLLxrnarUzlSmj1vraF3VQ2gXbtF3Y6MuC7nePUucyOW
         ZZA49qmd7vO2RnoeNIMD5osxU6kNsReFdkBUwf2tdhWDU1QWfx5SmaFtU6xxwcrEHp0L
         2AV175P6TunxNoiTuTE9qmM3h549MEIIrfX1zVjX9cISivRLx+SyX12IBJsR/m5HFkJZ
         pJVHV0v7cVNEl3VN07ZJVqUYpMWrUd6qdR02vPpBQeniET4jg16huA+BUJBpjjIAdWa1
         67grNy1R12nHoxpAd/DtvJzI+Bw+dpbYBYxb0OqiA3JQTzfrv3jclS3/pj+W5O4ojsbw
         oRTw==
X-Gm-Message-State: APjAAAUEZuEGGaKglBpjiKSArpfYJ/+Lca5D9/DcD1dj7Muw5eLukU4/
        cDTCGqEKvwoPdF/353pCteSGRIoGx35gSz2OccptG2V/ew==
X-Google-Smtp-Source: APXvYqy3e1v+/x4b///s6dVWGT9J1VIq3d4mniXLVl+MruruSEB411ufS5kaRbgtqUBU9f0aim9KGwkMa+9szEMIOps=
X-Received: by 2002:a2e:9ac5:: with SMTP id p5mr11678393ljj.46.1567633914358;
 Wed, 04 Sep 2019 14:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <156685561015.29917.5393176418461343562.stgit@chester> <6bee6b4c-db3e-4031-4996-f94ae68abbaa@tycho.nsa.gov>
In-Reply-To: <6bee6b4c-db3e-4031-4996-f94ae68abbaa@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Sep 2019 17:51:41 -0400
Message-ID: <CAHC9VhS9PaO6iqAp0V-W86xT+Zcdy0b1BDbMFvRmSuJ-1742Ag@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: ensure the cgroups_label tests works
 on old and new systems
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 4, 2019 at 8:48 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 8/26/19 5:40 PM, Paul Moore wrote:
> > From: Paul Moore <paul@paul-moore.com>
> >
> > Commit 697efc910393 ("selinux-testsuite: fix the cgroups_label test")
> > fixed the cgroups_label test on new systems, but it broke old systems.
> > Try to use /sys/fs/cgroup/unified first and if that doesn't exist go
> > with the new approach introduced in the commit above.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> This leaves the test system in a broken state, with all of
> /sys/fs/cgroup/unified getting relabeled to test_cgroup_t during the
> test and then switching to unlabeled_t upon the unloading of the test
> policy.  I get a bajillion denials after the testsuite completes from
> anything trying to access /sys/fs/cgroup/unified, and ls -Z
> /sys/fs/cgroup/unified shows it as being unlabeled_t throughout.

A bajillion, that sounds serious! ;)

Anyway, my apologies for breaking things after the test runs.  My test
systems pretty much just run the tests (over and over and over) so I
didn't notice the breakage.  I'll post a patch for this right now ...

> > ---
> >   tests/cgroupfs_label/test |    6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/cgroupfs_label/test b/tests/cgroupfs_label/test
> > index 385b953..91517b4 100755
> > --- a/tests/cgroupfs_label/test
> > +++ b/tests/cgroupfs_label/test
> > @@ -5,7 +5,11 @@ BEGIN { plan tests => 2 }
> >
> >   my $ret;
> >
> > -my $dir = "/sys/fs/cgroup/selinuxtest";
> > +# Older systems use /sys/fs/cgroup/unified, newer use /sys/fs/cgroup.
> > +my $dir = "/sys/fs/cgroup/unified";
> > +if (! -d $dir) {
> > +     $dir = "/sys/fs/cgroup/selinuxtest";
> > +}
> >
> >   # Create a new cgroupfs directory and relabel it.
> >   mkdir("$dir");
> >

-- 
paul moore
www.paul-moore.com
