Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAI31FRb009763
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 22:01:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAI30jBb000906
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 03:00:45 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAI30g4o000896
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 03:00:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id E4FD361BE4
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:00:59 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14152-09 for <selinux@tycho.nsa.gov>;
	Tue, 18 Nov 2003 14:00:59 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 8888661BE3
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:00:59 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 10701925E8
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:00:51 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BE7D17F09F
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 14:00:38 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: capabilities and 2.4 vs 2.6
Date: Tue, 18 Nov 2003 14:00:38 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311181400.38347.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that the meaning of sys_tty_config has changed between 2.4 and 2.6.  
When comparing a 2.4 kernel running the back-port of the new SE Linux code to 
2.6.0-test9 I find that many applications request sys_tty_config in 2.6 that 
did not in 2.4.  Examples include FreeRADIUS, a bash script from the startup 
of CIPE, and courier-authdaemon.

Another issue is that on 2.6 the "atsadc" program from the atsar package now 
seems to want sys_admin capability, while on 2.4 it did not.  But it seems to 
work OK without such access (the base functionality works - not sure if I'm 
missing something).  In any case it may be best to lose a bit of 
functionality to avoid granting sys_admin...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
