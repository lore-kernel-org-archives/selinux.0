Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97E1BWt011557
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 10:01:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97E1A7d028637
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 14:01:10 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h97E17Rn028634 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 14:01:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7AB6792472
	for <selinux@tycho.nsa.gov>; Wed,  8 Oct 2003 00:01:01 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7A0C17F09C
	for <selinux@tycho.nsa.gov>; Wed,  8 Oct 2003 00:00:52 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: /selinux/enforce permissions
Date: Wed, 8 Oct 2003 00:00:51 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310080000.51892.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Wouldn't it make sense to have the permissions 0644 for /selinux/enforce?

Or maybe even 0666 would do?  After all either SE Linux is controlling it, or 
it doesn't matter too much...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
