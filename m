Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14762
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 12:32:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA24212
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 16:30:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA24208 for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 16:30:15 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 9306992713
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2002 02:32:05 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E32C680B
	for <selinux@tycho.nsa.gov>; Wed, 23 Oct 2002 18:31:57 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: kernel compile error with latest ver
Date: Wed, 23 Oct 2002 18:31:57 +0200
MIME-Version: 1.0
Message-Id: <200210231831.57210.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The ip_warn() macro defined in selopt.h seems to demand at least 3 parameters 
but in selopt.c it's often given only 2...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
