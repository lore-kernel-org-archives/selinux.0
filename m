Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v35CwgkP015082
 for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2017 08:58:42 -0400
Received: by mail-wr0-f173.google.com with SMTP id k6so13426575wre.2
 for <selinux@tycho.nsa.gov>; Wed, 05 Apr 2017 05:58:40 -0700 (PDT)
MIME-Version: 1.0
From: cgzones <cgzones@googlemail.com>
Date: Wed, 5 Apr 2017 14:58:38 +0200
Message-ID: <CAJ2a_DeZ+7yTWgipgvbXeymZwYyz0RrwanRWSszQtjCVgnWW6w@mail.gmail.com>
Subject: security_bounded_transition
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi list,

when running `apt update` i'm getting a bunch of the following
security_bounded_transition audits:

type=PROCTITLE msg=audit(05/04/17 14:47:20.268:219) :
proctitle=/usr/bin/dpkg --print-foreign-architectures
type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=1
name=/lib64/ld-linux-x86-64.so.2 inode=132140 dev=08:01 mode=file,755
ouid=root ogid=root rdev=00:00 obj=system_u:object_r:ld_so_t:s0
nametype=NORMAL
type=PATH msg=audit(05/04/17 14:47:20.268:219) : item=0
name=/usr/bin/dpkg inode=131862 dev=08:01 mode=file,755 ouid=root
ogid=root rdev=00:00 obj=system_u:object_r:dpkg_exec_t:s0
nametype=NORMAL
type=CWD msg=audit(05/04/17 14:47:20.268:219) : cwd=/root/selinux/policy
type=EXECVE msg=audit(05/04/17 14:47:20.268:219) : argc=2
a0=/usr/bin/dpkg a1=--print-foreign-architectures
type=SYSCALL msg=audit(05/04/17 14:47:20.268:219) : arch=x86_64
syscall=execve success=yes exit=0 a0=0x56455b39a820 a1=0x56455b39e6d0
a2=0x7ffdfaf43cd0 a3=0x2 items=2 ppid=2328 pid=2329 auid=debianuser
uid=_apt gid=nogroup euid=_apt suid
=_apt fsuid=_apt egid=nogroup sgid=nogroup fsgid=nogroup tty=pts0
ses=1 comm=dpkg exe=/usr/bin/dpkg
subj=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023 key=(null)
type=SELINUX_ERR msg=audit(05/04/17 14:47:20.268:219) :
op=security_bounded_transition seresult=denied
oldcontext=staff_u:sysadm_r:apt_t:s0-s0:c0.c1023
newcontext=staff_u:sysadm_r:dpkg_t:s0-s0:c0.c1023

I do not use any type-/role-bounds rules, and apt and dpkg are working
without (noticeable) issues.

Best regards,
     Christian Göttsche
