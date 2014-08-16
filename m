Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s7GM1dSu018751
 for <selinux@tycho.nsa.gov>; Sat, 16 Aug 2014 18:01:40 -0400
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com
 [209.85.216.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id AF3A61400064F
 for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2014 00:01:41 +0200 (CEST)
Received: by mail-qa0-f42.google.com with SMTP id j15so3275350qaq.29
 for <selinux@tycho.nsa.gov>; Sat, 16 Aug 2014 15:01:40 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 17 Aug 2014 00:01:40 +0200
Message-ID: <CAJfZ7=mc94ESzD31HjV0z4pzrYsC4J1tSNqNw7PbW32ojxz8Xg@mail.gmail.com>
Subject: block_suspend everywhere...
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c1251452dbb10500c64840
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c1251452dbb10500c64840
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Tonight, while analyzing audit.log to manage my SELinux policy, I found
this strange AVC denial:

type=AVC msg=audit(1408212798.866:410): avc:  denied  { block_suspend } for
 pid=7754 comm="dbus-daemon" capability=36
 scontext=unconfined_u:unconfined_r:unconfined_t
tcontext=unconfined_u:unconfined_r:unconfined_t tclass=capability2
permissive=1
type=SYSCALL msg=audit(1408212798.866:410): arch=c000003e syscall=233
success=yes exit=0 a0=3 a1=2 a2=9 a3=7fffd4d66ec0 items=0 ppid=1 pid=7754
auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
tty=(none) ses=3 comm="dbus-daemon" exe="/usr/bin/dbus-daemon"
subj=unconfined_u:unconfined_r:unconfined_t key=(null)

As I didn't understand why dbus-daemon needs CAP_BLOCK_SUSPEND, I dug a
little bit and read some code. Here is my analysis:

* "arch=c000003e syscall=233" means "x86_64 syscall epoll_ctl".
* According to epoll_ctl man page [1], the second argument of this syscall
is "int op".
* Here, "a1=2" so the operation is EPOLL_CTL_DEL.
* In short, dbus-daemon called epoll_ctl(3, EPOLL_CTL_DEL, 9)

In the kernel, epoll_ctl is implemented in fs/eventpoll.c [3]. As far as I
understand the execution flows like this:

* line 1835 "ep_op_has_event(op)" is false (because op == EPOLL_CTL_DEL) so
epds is left uninitialized,
* line 1855 "ep_take_care_of_epollwakeup(&epds);" uses this uninitialized
structure,
* ep_take_care_of_epollwakeup is defined in /uapi/linux/eventpoll.h [4],
* this function does "(epev->events & EPOLLWAKEUP) &&
!capable(CAP_BLOCK_SUSPEND)" where epev is &epds from epoll_ctl.

In short, every time "epds.events" has the EPOLLWAKEUP bit set in epoll_ctl
stack when this syscall is used with EPOLL_CTL_DEL operation, a
CAP_BLOCK_SUSPEND access check is done.  This has no impact in the syscall
execution (because epds structure is not used afterwards in epoll_ctl) but
makes AVC denials show up un audit.log when using a SELinux policy which
does not allow block_suspend.

AFAICU block_suspend denials can currently show up in any program using
event polls.  As it seems very surprising, I may have missed something
important in my analysis.  Moreover as the bug I may have found has been
here since v3.5 [5] it seems unlikely that I have found a new bug.  Could
you check my analysis? Has someone already done a similar analysis when
studying a block_suspend denials and found another result?

Thanks,

Nicolas


[1] http://linux.die.net/man/2/epoll_ctl
[2]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/eventpoll.h?id=v3.17-rc1
[3]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/eventpoll.c?id=v3.17-rc1#n1823
[4]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/eventpoll.h?id=v3.17-rc1#n65
[5]
https://github.com/torvalds/linux/commit/4d7e30d98939a0340022ccd49325a3d70f7e0238#diff-f7a2681ce5b6557b66ff2d7b228438caL1601

--001a11c1251452dbb10500c64840
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>Tonight, while analyzing audit.log to manage=
 my SELinux policy, I found this strange AVC denial:<br><br>type=3DAVC msg=
=3Daudit(1408212798.866:410): avc: =A0denied =A0{ block_suspend } for =A0pi=
d=3D7754 comm=3D&quot;dbus-daemon&quot; capability=3D36 =A0scontext=3Duncon=
fined_u:unconfined_r:unconfined_t tcontext=3Dunconfined_u:unconfined_r:unco=
nfined_t tclass=3Dcapability2 permissive=3D1<br>
type=3DSYSCALL msg=3Daudit(1408212798.866:410): arch=3Dc000003e syscall=3D2=
33 success=3Dyes exit=3D0 a0=3D3 a1=3D2 a2=3D9 a3=3D7fffd4d66ec0 items=3D0 =
ppid=3D1 pid=3D7754 auid=3D1000 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0=
 egid=3D0 sgid=3D0 fsgid=3D0 tty=3D(none) ses=3D3 comm=3D&quot;dbus-daemon&=
quot; exe=3D&quot;/usr/bin/dbus-daemon&quot; subj=3Dunconfined_u:unconfined=
_r:unconfined_t key=3D(null)<br>
<br>As I didn&#39;t understand why dbus-daemon needs CAP_BLOCK_SUSPEND, I d=
ug a little bit and read some code. Here is my analysis:<br><br>* &quot;arc=
h=3Dc000003e syscall=3D233&quot; means &quot;x86_64 syscall epoll_ctl&quot;=
.<br>
* According to epoll_ctl man page [1], the second argument of this syscall =
is &quot;int op&quot;.<br>* Here, &quot;a1=3D2&quot; so the operation is EP=
OLL_CTL_DEL.<br>* In short, dbus-daemon called epoll_ctl(3, EPOLL_CTL_DEL, =
9)<br>
<br>In the kernel, epoll_ctl is implemented in fs/eventpoll.c [3]. As far a=
s I understand the execution flows like this:<br><br>* line 1835 &quot;ep_o=
p_has_event(op)&quot; is false (because op =3D=3D EPOLL_CTL_DEL) so epds is=
 left uninitialized,<br>
* line 1855 &quot;ep_take_care_of_epollwakeup(&amp;epds);&quot; uses this u=
ninitialized structure,<br>* ep_take_care_of_epollwakeup is defined in /uap=
i/linux/eventpoll.h [4],<br>* this function does &quot;(epev-&gt;events &am=
p; EPOLLWAKEUP) &amp;&amp; !capable(CAP_BLOCK_SUSPEND)&quot; where epev is =
&amp;epds from epoll_ctl.<br>
<br>In short, every time &quot;epds.events&quot; has the EPOLLWAKEUP bit se=
t in epoll_ctl stack when this syscall is used with EPOLL_CTL_DEL operation=
, a CAP_BLOCK_SUSPEND access check is done. =A0This has no impact in the sy=
scall execution (because epds structure is not used afterwards in epoll_ctl=
) but makes AVC denials show up un audit.log when using a SELinux policy wh=
ich does not allow block_suspend.<br>
<br>AFAICU block_suspend denials can currently show up in any program using=
 event polls. =A0As it seems very surprising, I may have missed something i=
mportant in my analysis. =A0Moreover as the bug I may have found has been h=
ere since v3.5 [5] it seems unlikely that I have found a new bug. =A0Could =
you check my analysis?=A0Has someone already done a similar analysis when s=
tudying a block_suspend denials and found another result?<div>
<br></div><div>Thanks,</div><div><br></div><div>Nicolas<br><br><br>[1] <a h=
ref=3D"http://linux.die.net/man/2/epoll_ctl">http://linux.die.net/man/2/epo=
ll_ctl</a><br>[2] <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/t=
orvalds/linux.git/tree/include/uapi/linux/eventpoll.h?id=3Dv3.17-rc1">https=
://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uap=
i/linux/eventpoll.h?id=3Dv3.17-rc1</a><br>
[3] <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.=
git/tree/fs/eventpoll.c?id=3Dv3.17-rc1#n1823">https://git.kernel.org/cgit/l=
inux/kernel/git/torvalds/linux.git/tree/fs/eventpoll.c?id=3Dv3.17-rc1#n1823=
</a><br>
[4] <a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.=
git/tree/include/uapi/linux/eventpoll.h?id=3Dv3.17-rc1#n65">https://git.ker=
nel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/ev=
entpoll.h?id=3Dv3.17-rc1#n65</a><br>
[5] <a href=3D"https://github.com/torvalds/linux/commit/4d7e30d98939a034002=
2ccd49325a3d70f7e0238#diff-f7a2681ce5b6557b66ff2d7b228438caL1601">https://g=
ithub.com/torvalds/linux/commit/4d7e30d98939a0340022ccd49325a3d70f7e0238#di=
ff-f7a2681ce5b6557b66ff2d7b228438caL1601</a></div>
</div>

--001a11c1251452dbb10500c64840--
