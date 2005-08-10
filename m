Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7ADf3Ob001701
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 09:41:08 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7ADX37C004426
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 13:33:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 16FEB61B19
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 23:32:51 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02477-02 for <selinux@tycho.nsa.gov>;
	Wed, 10 Aug 2005 23:32:50 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 93ACF61B17
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 23:32:50 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 367D41B
	for <selinux@tycho.nsa.gov>; Wed, 10 Aug 2005 23:32:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: checkpolicy constraints bug
Date: Wed, 10 Aug 2005 23:32:45 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200508102332.48483.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

constrain process transition
      ( r1 == r2 or ( t1 == privrole and t2 == userdomain )
ifdef(`crond.te', `
         or (t1 == crond_t and t2 == user_crond_domain)
')
ifdef(`userhelper.te',
      `or (t1 == userhelperdomain)')
ifdef(`postfix.te', `
ifdef(`direct_sysadm_daemon',
      `or (t1 == sysadm_mail_t and t2 == system_mail_t and r2 == system_r )')
')
       or (t1 == priv_system_role and r2 == system_r )
        );


The above section in the constraints file for the strict policy works with 
checkpolicy version 1.23.1-1 (FC4 release) but fails with 1.25.3-1 (latest 
rawhide).

type=AVC msg=audit(1123680529.941:1493682): avc:  denied  { transition } for  
pid=3242 comm="bash" name="sshd" dev=dm-0 ino=69461 
scontext=root:sysadm_r:sysadm_t tcontext=root:system_r:initrc_t 
tclass=process
type=SYSCALL msg=audit(1123680529.941:1493682): arch=40000003 syscall=11 
success=no exit=-13 a0=8cbea88 a1=8cbd2c8 a2=8cbbc30 a3=1 items=1 pid=3242 
auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 comm="bash" 
exe="/bin/bash"
type=AVC_PATH msg=audit(1123680529.941:1493682):  path="/etc/rc.d/init.d/sshd"
type=CWD msg=audit(1123680529.941:1493682):  cwd="/root"
type=PATH msg=audit(1123680529.941:1493682): item=0 name="/etc/init.d/sshd" 
flags=101  inode=69461 dev=fd:00 mode=0100755 ouid=0 ogid=0 rdev=00:00


Above is the relevant section from the audit.log file.  Nothing else changed 
apart from the checkpolicy version, downgrading to the old version makes 
checkpolicy produce a binary policy that works.

I will be happy to provide the policy.conf as well as both versions of the 
binary if desired.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
