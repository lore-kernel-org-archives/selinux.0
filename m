Return-Path: <SRS0=tF6o=Q7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B391C43381
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 18:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29933204EC
	for <selinux@archiver.kernel.org>; Sun, 24 Feb 2019 18:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfBXShO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 24 Feb 2019 13:37:14 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:51240 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfBXShO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 24 Feb 2019 13:37:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id 610D02E05B1;
        Sun, 24 Feb 2019 19:37:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id e_I0kH5rCAwa; Sun, 24 Feb 2019 19:37:09 +0100 (CET)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id C21B22E047D;
        Sun, 24 Feb 2019 19:37:09 +0100 (CET)
Date:   Sun, 24 Feb 2019 19:37:08 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: Bash 5 change in behavior and SELinux
Message-ID: <20190224183708.GA3000@brutus.lan>
References: <20190224165919.GA4310@brutus.lan>
 <20190224173944.GA18551@brutus.lan>
 <CAJfZ7=njaGvMdSJdpfzK238=BS_u7i+DE61mLic1OezEC20ngQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfZ7=njaGvMdSJdpfzK238=BS_u7i+DE61mLic1OezEC20ngQ@mail.gmail.com>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Feb 24, 2019 at 07:17:33PM +0100, Nicolas Iooss wrote:
> On Sun, Feb 24, 2019 at 6:39 PM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > On Sun, Feb 24, 2019 at 05:59:19PM +0100, Dominick Grift wrote:
> > > Recently Bash-5 appeared in the Fedora repositories and i instantly noticed an inpleasant change (for the record: this did not happen before):
> >
> > I suppose this is just a "feature" or a "bug" in Bash-5 and that i will just have to deal with it. Just seems a bit unnecessary access to me.
> >
> > >
> > > [kcinimod@brutus ~]$ touch mytest1.test
> > > [kcinimod@brutus ~]$ rm ~/*.test
> > > rm: cannot remove '/home/kcinimod/*.test': No such file or directory
> > > [kcinimod@brutus ~]$ rm ~/mytest1.test
> > > [kcinimod@brutus ~]$ echo $?
> > > 0
> > >
> > > After running `semodule -DB` the following AVC denials surfaced:
> > >
> > > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-3" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:files.home.file:s0 tclass=dir permissive=1
> > > avc:  denied  { read } for  pid=2178 comm="bash" name="/" dev="dm-1" ino=2 scontext=wheel.id:wheel.role:wheel.subj:s0 tcontext=sys.id:sys.role:fs.rootfs.fs:s0 tclass=dir permissive=1
> 
> [For other readers: these are the labels of /home and /, the parent
> directories of /home/kcinimod/]
> 
> > > So I took to #bash and they told me:
> > >
> > > 17:43 <_abc_> grift: that is exactly what you see on android and is
> > >               a direct result of the missing x bit equivalent in
> > >               the selinux policy
> > >
> > > 17:44 <_abc_> grift: rephrased: globbing the * requires the x bit
> > >               set
> > > 17:44 <_abc_> (it's equivalent in selinux policy)
> > >
> > > So why does this show up as a "read"? Its allowed to "search" "/" and "/home", but since Bash 5 this no longer is enough.
> > >
> > > Scripts break everywhere because of this
> 
> What is the syscall associated with the avc entries? This would help
> finding in bash's source what triggered this behavior.
> I tried to reproduce your commands in Arch Linux (bash package
> 5.0.0-1) or Fedora 30 (bash package 5.0.2-1.fc30 for x86_64) by using
> strace on bash and watching the syscalls, but nothing stood out: I see
> an "openat(AT_FDCWD, "/home/kcinimod/",
> O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3" followed by calls to
> "getdents64(3, ...)", which are like expected. This could be due to
> several things:

type=SYSCALL msg=audit(02/24/2019 19:33:13.924:18121) : arch=x86_64 syscall=openat success=yes exit=3 a0=0xffffff9c a1=0x561168c81e40 a2=O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC a3=0x0 items=1 ppid=2270 pid=27900 auid=kcinimod uid=kcinimod gid=kcinimod euid=kcinimod suid=kcinimod fsuid=

> 
> * The bash version you are using is not 5.0.2-1.fc30. Which one are you using?

it is 5.0.2-1, downgrading to 4.4.23-7 fixes it

> * It might come from a kernel bug (which would open the parent
> directories with read access). That would be really strange, but only
> to be sure: is bash 4 working fine when you downgrade bash package
> while keeping the same kernel?

Yes 4 is fine

> * Or it might come from a bash dependency (like readline).

Does not look like it: just downgrading "bash" fixes it

> 
> > >
> > > Here is an strace:
> > >
> > > execve("/usr/bin/rm", ["rm", "/home/kcinimod/*.test"], 0x7ffd4a604e68 /* 33 vars */) = 0
> 
> By the way, using strace on rm was not useful because it only showed
> that it was been called with the raw (unexpanded) parameter. Could you
> run the same commands of your test-case in a "strace -s1024 -o
> strace-bash.log bash" and share the resulting strace-bash.log file?
> 
> Thanks,
> Nicolas
> 

-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
