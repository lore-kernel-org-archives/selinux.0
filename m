Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA26537
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 09:16:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18739
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 14:13:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA18735
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 14:13:53 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A7B6A92738
	for <selinux@tycho.nsa.gov>; Wed, 22 Jan 2003 01:16:39 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 614E026AD
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 15:16:33 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: spasswd
Date: Tue, 21 Jan 2003 15:16:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301211516.32919.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For the spasswd wrapper program, I am thinking of patching it to run
"passwd rjc" if the identity part of my security context is "rjc".

This gives the same protection against false password changes as the current 
scheme (lookup the Unix user-name matching the UID of the process and then 
check that it matches the SE Linux identity), but also has support for 
multiple accounts with the same UID.  Having a separate "root" account with a 
different shell is fairly common practise.

Any objections?  Any suggestions for other things I should change at the same 
time?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
