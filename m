Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA22901
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 05:49:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB9AnnI23376
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 10:49:49 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gB9Anlf23372 for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 10:49:47 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 349A292668
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 21:49:46 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id AF747EC
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 11:49:38 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: selinux-small/module/Makefile
Date: Mon, 9 Dec 2002 11:49:36 +0100
MIME-Version: 1.0
Message-Id: <200212091149.36395.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-e s/parisc64/parisc/
I believe that the sed command for setting the architecture should have the 
above added to it for HPPA.

With that added it builds for me on HPPA.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
