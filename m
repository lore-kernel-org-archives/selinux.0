Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3U0ZXI4002315
	for <selinux@tycho.nsa.gov>; Tue, 29 Apr 2003 20:35:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3U0ZW7R011528
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 00:35:32 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3U0ZNKP011512 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 00:35:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id ABB52BF3E
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:35:11 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09057-10
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:35:10 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 53FDCBF3D
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:35:10 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E5140924AD
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:35:09 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A9F3B3908
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2003 10:34:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: truncate(2) and setattr
Date: Wed, 30 Apr 2003 10:34:38 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304301034.38073.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why does truncate(2) require setattr access to the file?

Using truncate(file, len + 1) to increase the size of the file by 1 byte has 
exactly the same affect on the file attributes as seeking to the end and 
writing one byte.

Using truncate to make a file smaller has no greater affect on the file 
attributes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
