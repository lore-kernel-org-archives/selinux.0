Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FH6igA012793
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 13:06:45 -0400 (EDT)
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FH2OBp015423
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 17:02:24 GMT
Received: from taynzmail03.nz-tay.cpqcorp.net (taynzmail03.nz-tay.cpqcorp.net [16.47.4.103])
	by atlrel6.hp.com (Postfix) with ESMTP id 1C7C65531
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 13:03:10 -0400 (EDT)
Received: from anw.zk3.dec.com (alpha.zk3.dec.com [16.140.128.4])
	by taynzmail03.nz-tay.cpqcorp.net (Postfix) with ESMTP id DF734202B
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 13:03:09 -0400 (EDT)
Message-ID: <42D7EC4C.1000407@hp.com>
Date: Fri, 15 Jul 2005 13:03:08 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: init running at s9 by default on a MLS system?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I have been playing with Dan Walsh's MLS policy RPM on Fedora Rawhide 
and I noticed on the later versions that init is running at level s9 
which appears to be causing some problems.  The particular issue I am 
dealing with right now is when fsck (as run from /etc/rc.d/rc.sysinit) 
tries to check all of the filesystems in /etc/fstab.  The problem lies 
in the fact that the disk partitions in /dev are all labeled at s0 and 
fsck is trying to open them with write access.  Needless to say the 
policy is correct for the strict policy but as soon as you introduce the 
different levels you run into problems.

My question is this: should init be running at s9 and if so should we 
relabel the partitions to be at s9 as well?

-- 
. paul moore . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. paul.moore@hp.com                                      hewlett packard
. (603) 884-5056                                          linux security

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
