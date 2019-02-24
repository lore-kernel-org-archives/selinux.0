Return-Path: <SRS0=tF6o=Q7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A82C43381
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 18:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2196D20661
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfBXSRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:17:49 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:43597 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfBXSRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Feb 2019 13:17:49 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 59D4D5611EB
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 19:17:45 +0100 (CET)
Received: by mail-oi1-f171.google.com with SMTP id g16so5565995oib.1
        for <selinux@vger.kernel.org>; Sun, 24 Feb 2019 10:17:45 -0800 (PST)
X-Gm-Message-State: AHQUAuYomxOX9B0A5K0nbUQqjyhMq546OPHTfV2/jp3uff3BHBiglWbx
        x7PfUIGdvN++bDK8xJ342uBkC+TiAcT0eYj90Q8=
X-Google-Smtp-Source: AHgI3Ib6c+jfoHoelJcmwY1gXHKLbdJNwW/Ki1qbFrza3cBWmBpXTlyVN44vQ8ZjGpU4qGgYiGwIj1v6tTzULmEToP8=
X-Received: by 2002:aca:f546:: with SMTP id t67mr8559222oih.152.1551032264315;
 Sun, 24 Feb 2019 10:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20190224165919.GA4310@brutus.lan> <20190224173944.GA18551@brutus.lan>
In-Reply-To: <20190224173944.GA18551@brutus.lan>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 24 Feb 2019 19:17:33 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=njaGvMdSJdpfzK238=BS_u7i+DE61mLic1OezEC20ngQ@mail.gmail.com>
Message-ID: <CAJfZ7=njaGvMdSJdpfzK238=BS_u7i+DE61mLic1OezEC20ngQ@mail.gmail.com>
Subject: Re: Bash 5 change in behavior and SELinux
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 24 19:17:46 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 24, 2019 at 6:39 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> On Sun, Feb 24, 2019 at 05:59:19PM +0100, Dominick Grift wrote:
> > Recently Bash-5 appeared in the Fedora repositories and i instantly noticed an inpleasant change (for the record: this did not happen before):
>
> I suppose this is just a "feature" or a "bug" in Bash-5 and that i will just have to deal with it. Just seems a bit unnecessary access to me.
>
> >
> > [kcinimod@brutus ~]$ touch mytest1.test
> > [kcinimod@brutus ~]$ rm ~/*.test
> > rm: cannot remove '/home/kcinimod/*.test': No such file or directory
> > [kcinimod@brutus ~]$ rm ~/mytest1.test
> > [kcinimod@brutus ~]$ echo $?
> > 0
> >
> > After running `semodule -DB` the following AVC denials surfaced:
> >
> > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-3" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:files.home.file:s0 tclass=dir permissive=1
> > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-1" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:fs.rootfs.fs:s0 tclass=dir permissive=1

[For other readers: these are the labels of /home and /, the parent
directories of /home/kcinimod/]

> > So I took to #bash and they told me:
> >
> > 17:43 <_abc_> grift: that is exactly what you see on android and is
> >               a direct result of the missing x bit equivalent in
> >               the selinux policy
> >
> > 17:44 <_abc_> grift: rephrased: globbing the * requires the x bit
> >               set
> > 17:44 <_abc_> (it's equivalent in selinux policy)
> >
> > So why does this show up as a "read"? Its allowed to "search" "/" and "/home", but since Bash 5 this no longer is enough.
> >
> > Scripts break everywhere because of this

What is the syscall associated with the avc entries? This would help
finding in bash's source what triggered this behavior.
I tried to reproduce your commands in Arch Linux (bash package
5.0.0-1) or Fedora 30 (bash package 5.0.2-1.fc30 for x86_64) by using
strace on bash and watching the syscalls, but nothing stood out: I see
an "openat(AT_FDCWD, "/home/kcinimod/",
O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3" followed by calls to
"getdents64(3, ...)", which are like expected. This could be due to
several things:

* The bash version you are using is not 5.0.2-1.fc30. Which one are you using?
* It might come from a kernel bug (which would open the parent
directories with read access). That would be really strange, but only
to be sure: is bash 4 working fine when you downgrade bash package
while keeping the same kernel?
* Or it might come from a bash dependency (like readline).

> >
> > Here is an strace:
> >
> > execve("/usr/bin/rm", ["rm", "/home/kcinimod/*.test"], 0x7ffd4a604e68 /* 33 vars */) = 0

By the way, using strace on rm was not useful because it only showed
that it was been called with the raw (unexpanded) parameter. Could you
run the same commands of your test-case in a "strace -s1024 -o
strace-bash.log bash" and share the resulting strace-bash.log file?

Thanks,
Nicolas

