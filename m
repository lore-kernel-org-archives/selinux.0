Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA12718
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 17:24:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA26859
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 21:23:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA26855
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 21:23:08 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E586692465
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 07:24:19 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id F3339A488
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 23:24:14 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new psmisc
Date: Sat, 28 Sep 2002 15:52:15 +0200
MIME-Version: 1.0
Message-Id: <200209281552.15915.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Psmisc version 21.2 has just been released and has SE support.

The SE support is disabled by default, has a couple of minor bugs related to 
code merging, and one bug that was in the code I sent in.

I hope to get these sorted out with Craig in the next few days and have the 
next release of procps support SE Linux without needing any patches.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
