Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3QGEHI4018475
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 12:14:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3QGEH7R018495
	for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 16:14:17 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3QGEEKP018492 for <selinux@tycho.nsa.gov>; Sat, 26 Apr 2003 16:14:15 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 9CFC1BF37
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 02:14:13 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09353-02
 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 02:14:12 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 5B654BF11
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 02:14:12 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1ACC0924A3
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 02:14:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0AED63998
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 02:13:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: busybox ls
Date: Sun, 27 Apr 2003 02:13:57 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304270213.57411.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm writing SE Linux support for busybox ls.  I can't use long options and 
most of the letters are taken.

Any suggestions on which option switches I should use for equivalent of --sid 
and --context functionality?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
