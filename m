Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA18407
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2002 10:45:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA13745
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2002 14:43:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA13737
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2002 14:43:39 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA27441
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2002 10:45:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA15588
	for <selinux@tycho.nsa.gov>; Sun, 20 Oct 2002 16:40:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA07885
	for <selinux@tycho.nsa.gov>; Sun, 20 Oct 2002 20:39:04 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id UAA07881
	for <selinux@tycho.nsa.gov>; Sun, 20 Oct 2002 20:39:03 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B7C1D92465
	for <selinux@tycho.nsa.gov>; Mon, 21 Oct 2002 06:40:47 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 09522A793
	for <selinux@tycho.nsa.gov>; Sun, 20 Oct 2002 22:40:40 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: strace
Date: Sun, 20 Oct 2002 22:40:39 +0200
MIME-Version: 1.0
Message-Id: <200210202240.39519.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've put a Debian package of strace with SE Linux support online on 
http://www.coker.com.au/selinux/strace/ .  It contains a newer version of my 
patch that I previously sent here (and is now on the NSA site).

It's now got full support for:
recvmsg_secure(), accept_secure(), and open_secure()

This package is for unstable, hopefully Brian will port it to woody soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
