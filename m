Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7JIVju8013995
 for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2014 14:31:51 -0400
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DFBB6140912E5
 for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2014 20:31:47 +0200 (CEST)
Received: by mail-qg0-f43.google.com with SMTP id a108so6497485qge.30
 for <selinux@tycho.nsa.gov>; Tue, 19 Aug 2014 11:31:46 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 19 Aug 2014 20:31:46 +0200
Message-ID: <CAJfZ7==Qvdx_VMpzVUGG=52QeJfjQ9CV7CWo__8iyb2BEXyzEw@mail.gmail.com>
Subject: Re: block_suspend everywhere...
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Now you confirmed it is a bug, I submitted my patch to
linux-fsdevel@vger.kernel.org and linux-kernel@vger.kernel.org:

* https://patchwork.kernel.org/patch/4745311/
* http://marc.info/?l=linux-fsdevel&m=140846970724095&w=2

This is the first time I send a patch to LKML so feel free to tell me
if I missed something in the process.

By the way, before sending my patch I wanted to know whether this is
was something already known or to find out why nobody else has
reported this bug.  Maybe the fact that few applications use eventpoll
without EPOLLWAKEUP while having CAP_BLOCK_SUSPEND explains why nobody
has seen this before.  Moreover refpolicy, Fedora policy and Gentoo
policy haven't got surprising allow/dontaudit statements with
block_suspend, from a quick glance over "grep" results.

Nicolas

2014-08-19 16:47 GMT+02:00 Stephen Smalley <stephen.smalley@gmail.com>:
>
> Looks like a bug to me.  Do you intend to submit a patch or should we?
>
> On Sat, Aug 16, 2014 at 6:01 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > Hello,
> >
> > Tonight, while analyzing audit.log to manage my SELinux policy, I found this
> > strange AVC denial:
> >
> > type=AVC msg=audit(1408212798.866:410): avc:  denied  { block_suspend } for
> > pid=7754 comm="dbus-daemon" capability=36
> > scontext=unconfined_u:unconfined_r:unconfined_t
> > tcontext=unconfined_u:unconfined_r:unconfined_t tclass=capability2
> > permissive=1
> > type=SYSCALL msg=audit(1408212798.866:410): arch=c000003e syscall=233
> > success=yes exit=0 a0=3 a1=2 a2=9 a3=7fffd4d66ec0 items=0 ppid=1 pid=7754
> > auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none)
> > ses=3 comm="dbus-daemon" exe="/usr/bin/dbus-daemon"
> > subj=unconfined_u:unconfined_r:unconfined_t key=(null)
> >
> > As I didn't understand why dbus-daemon needs CAP_BLOCK_SUSPEND, I dug a
> > little bit and read some code. Here is my analysis:
> >
> > * "arch=c000003e syscall=233" means "x86_64 syscall epoll_ctl".
> > * According to epoll_ctl man page [1], the second argument of this syscall
> > is "int op".
> > * Here, "a1=2" so the operation is EPOLL_CTL_DEL.
> > * In short, dbus-daemon called epoll_ctl(3, EPOLL_CTL_DEL, 9)
> >
> > In the kernel, epoll_ctl is implemented in fs/eventpoll.c [3]. As far as I
> > understand the execution flows like this:
> >
> > * line 1835 "ep_op_has_event(op)" is false (because op == EPOLL_CTL_DEL) so
> > epds is left uninitialized,
> > * line 1855 "ep_take_care_of_epollwakeup(&epds);" uses this uninitialized
> > structure,
> > * ep_take_care_of_epollwakeup is defined in /uapi/linux/eventpoll.h [4],
> > * this function does "(epev->events & EPOLLWAKEUP) &&
> > !capable(CAP_BLOCK_SUSPEND)" where epev is &epds from epoll_ctl.
> >
> > In short, every time "epds.events" has the EPOLLWAKEUP bit set in epoll_ctl
> > stack when this syscall is used with EPOLL_CTL_DEL operation, a
> > CAP_BLOCK_SUSPEND access check is done.  This has no impact in the syscall
> > execution (because epds structure is not used afterwards in epoll_ctl) but
> > makes AVC denials show up un audit.log when using a SELinux policy which
> > does not allow block_suspend.
> >
> > AFAICU block_suspend denials can currently show up in any program using
> > event polls.  As it seems very surprising, I may have missed something
> > important in my analysis.  Moreover as the bug I may have found has been
> > here since v3.5 [5] it seems unlikely that I have found a new bug.  Could
> > you check my analysis? Has someone already done a similar analysis when
> > studying a block_suspend denials and found another result?
> >
> > Thanks,
> >
> > Nicolas
> >
> >
> > [1] http://linux.die.net/man/2/epoll_ctl
> > [2]
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/eventpoll.h?id=v3.17-rc1
> > [3]
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/eventpoll.c?id=v3.17-rc1#n1823
> > [4]
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/eventpoll.h?id=v3.17-rc1#n65
> > [5]
> > https://github.com/torvalds/linux/commit/4d7e30d98939a0340022ccd49325a3d70f7e0238#diff-f7a2681ce5b6557b66ff2d7b228438caL1601
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
