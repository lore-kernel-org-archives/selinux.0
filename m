Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3E8MfI4019262
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 04:22:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3E8IsOv011260
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 08:18:54 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3E8IrY1011257
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 08:18:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5434E9081
	for <selinux@tycho.nsa.gov>; Mon, 14 Apr 2003 18:22:44 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: auditallow
Date: Mon, 14 Apr 2003 18:22:43 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304141822.43798.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

auditallow sysadm_mail_t var_run_t:dir search;

I put the above rule in my policy, but then see the following in my dmesg 
output:

Apr 14 18:16:21 caesar kernel: avc:  denied  { search } for  pid=8716 
exe=/usr/sbin/sendmail path=/run dev=09:03 ino=2593 
scontext=root:sysadm_r:sysadm_mail_t tcontext=system_u:object_r:var_run_t 
tclass=dir

Surely it should be reporting "granted" not "denied".

The machine in question is running with the kernel patch from the January 
release of SE Linux.  But I have reproduced the same situation on a machine 
running the latest release.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
