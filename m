Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6IF6bHa004204
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 11:06:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6IF5YFB024499
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 15:05:34 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6IF5RGD024484
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 15:05:33 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 9B35BBF5A
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 01:06:28 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 07803-04
 for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 01:06:27 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 77E68BF5C
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 01:06:21 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 4A440925ED
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 01:06:20 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3AE4D7F26B
	for <selinux@tycho.nsa.gov>; Sat, 19 Jul 2003 00:45:17 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ipc_owner
Date: Sat, 19 Jul 2003 00:45:16 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200307190045.16701.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { ipc_owner } for  pid=1008 exe=/usr/X11R6/bin/XFree86 
capability=15 scontext=rjc:user_r:user_xserver_t 
tcontext=rjc:user_r:user_xserver_t tclass=capability

The above is an access I have not noticed before.  Should I allow it or 
dontaudit it?

It seems to work OK being denied.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
