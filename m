Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA12740
	for <selinux@tycho.nsa.gov>; Sat, 11 Jan 2003 16:18:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA19596
	for <selinux@tycho.nsa.gov>; Sat, 11 Jan 2003 21:16:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA19592
	for <selinux@tycho.nsa.gov>; Sat, 11 Jan 2003 21:16:12 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B505A92732
	for <selinux@tycho.nsa.gov>; Sun, 12 Jan 2003 08:18:51 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E07951994
	for <selinux@tycho.nsa.gov>; Sat, 11 Jan 2003 22:18:43 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new strace patch
Date: Sat, 11 Jan 2003 22:18:43 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301112218.43150.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've written a SE Linux patch for the latest version of strace (4.4.90).

It does the same SE Linux things as my previous patch but on the new strace.  
The major new thing in strace is support for the 2.5.x thread features.

It's at the usual place.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
