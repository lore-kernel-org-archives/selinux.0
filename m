Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JBY4I4002454
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 07:34:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JBXfQj023685
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:33:41 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4JBXdxS023682
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 11:33:40 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 333A8BF4E
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:33:59 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 28747-09
 for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:33:57 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id CA32CBF3D
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:33:57 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6DFE992705
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:33:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 504A4876D
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 21:32:13 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: rw_sem_perms() etc
Date: Mon, 19 May 2003 21:32:12 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305192132.12745.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it make sense to change the rw_sem_perms() and rw_shm_perms() macros to 
not permit create and destroy access, and then add some new macros 
create_sem_perms() and create_shm_perms()?

Doing so would make the semaphore and shared memory macros have the same style 
as the macros for file and directory permissions which will potentially save 
confusion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
