Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5IEErI4026022
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 10:14:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5IEEAss024705
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 14:14:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h5IEDohY024668
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 14:14:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 56CE7BF45
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:14:23 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 29567-08
 for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:14:22 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 1B827BF40
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:14:22 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E331E92740
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:14:19 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id EA1C092A2
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 00:14:09 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: UML
Date: Thu, 19 Jun 2003 00:14:09 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200306190014.09488.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated http://www.coker.com.au/uml/ .  I have forward-ported the UML 
kernel patch (for the UML kernel not the host kernel) to 2.4.21.

To build a UML kernel you need to apply uml-2.4.21.diff.bz2, my LSM patch for 
2.4.21, and uml-se-latest.patch.

Doing this I have a UML setup running.  However it crashes when I try to 
enable SLIRP (and I have determined that the other transports are a bad 
idea).  If anyone can get SLIRP working then I would really appreciate it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
