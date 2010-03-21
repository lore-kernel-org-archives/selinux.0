Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o2L253k0030253
	for <selinux@tycho.nsa.gov>; Sat, 20 Mar 2010 22:05:03 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o2L25cGA024082
	for <selinux@tycho.nsa.gov>; Sun, 21 Mar 2010 02:05:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AD87E180C5
	for <selinux@tycho.nsa.gov>; Sun, 21 Mar 2010 13:04:56 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: capability:sysadmin and xend
Date: Sun, 21 Mar 2010 13:04:52 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201003211304.55200.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is a sample of the audit.log from starting a Xen server running 
Debian/Testing on i386.

>From linux/syscallent.h in the strace source it appears that syscall 3 is 
sys_read.  What might xend be doing?

type=AVC msg=audit(1269119177.855:8): avc:  denied  { sys_admin } for  pid=985 
comm="xend" capability=21  scontext=system_u:system_r:xend_t:s0 
tcontext=system_u:system_r:xend_t:s0 tclass=capability
type=SYSCALL msg=audit(1269119177.855:8): arch=40000003 syscall=3 success=yes 
exit=2 a0=f a1=99714b4 a2=2 a3=2 items=0 ppid=984 pid=985 auid=4294967295 
uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) 
ses=4294967295 comm="xend" exe="/usr/bin/python2.5" 
subj=system_u:system_r:xend_t:s0 key=(null)
type=AVC msg=audit(1269119177.855:9): avc:  denied  { sys_admin } for  pid=985 
comm="xend" capability=21  scontext=system_u:system_r:xend_t:s0 
tcontext=system_u:system_r:xend_t:s0 tclass=capability
type=SYSCALL msg=audit(1269119177.855:9): arch=40000003 syscall=3 success=yes 
exit=2 a0=f a1=99714b4 a2=2 a3=2 items=0 ppid=984 pid=985 auid=4294967295 
uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) 
ses=4294967295 comm="xend" exe="/usr/bin/python2.5" 
subj=system_u:system_r:xend_t:s0 key=(null)


Xen works fine without enabling this access, so I'll probably put in a 
dontaudit rule.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
