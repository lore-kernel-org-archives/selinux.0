Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1CALSa8000572
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 05:21:28 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1CALP1Y013147
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 10:21:26 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 0432518073
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 21:21:14 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 9A06D2013C
	for <selinux@tycho.nsa.gov>; Thu, 12 Feb 2009 21:21:13 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: cron sys_admin
Date: Thu, 12 Feb 2009 21:21:09 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902122121.12451.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am seeing the cron daemon request capability sys_admin.  The below seems to 
indicate that vfork() is the relevant operation (190 seems to be vfork 
according to ia32entry.S).

So how does vfork() require sys_admin?

type=AVC msg=audit(1234433821.879:6677): avc:  denied  { sys_admin } for  
pid=9598 comm="cron" capability=21 
scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 
tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=capability
type=SYSCALL msg=audit(1234433821.879:6677): arch=40000003 syscall=190 
success=yes exit=9600 a0=0 a1=804ca00 a2=257e a3=0 items=0 ppid=3701 pid=9598 
auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
tty=(none) ses=4294967295 comm="cron" exe="/usr/sbin/cron" 
subj=system_u:system_r:crond_t:s0-s0:c0.c1023 key=(null)

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
