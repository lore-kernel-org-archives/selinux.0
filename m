Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9J4tiWt015388
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 00:55:44 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9J4thmR005250
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:55:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9J4tgjp005247 for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:55:43 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6519C924F3
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:55:41 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 92E1B7F03A
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:55:35 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new SE Linux debian repository
Date: Sun, 19 Oct 2003 14:55:35 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310191455.35040.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

deb http://www.coker.com.au/newselinux/ ./

The above sources.list line can be used for support of the new (2.6 and 
back-port to 2.4) SE Linux in Debian/u n s t a b l e.

It currently has packages for procps and coreutils.  The packages for the 
kernel-patches and the policy are the same so they are just symlinks.  The 
rest will follow soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
