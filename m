Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4D6HEI4006388
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 02:17:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4D6GujN021824
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 06:16:56 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4D6GsTU021821
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 06:16:55 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id B6D2ABF4F
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 16:17:10 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 30009-03
 for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 16:17:09 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 7D667BF4E
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 16:17:09 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1A43B924A3
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 16:17:09 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5656E3733
	for <selinux@tycho.nsa.gov>; Tue, 13 May 2003 16:15:46 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /etc/magic
Date: Tue, 13 May 2003 16:15:45 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305131615.45687.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The new version of the "file" package in Debian has a database entry for the 
SE Linux policy format.

I haven't tried it out yet, but I expect it'll be almost exactly the same as 
the patch I submitted, which gave the following result:
# file -z /etc/security/selinux/policy.12
/etc/security/selinux/policy.12: SE Linux policy v12 5 symbols 6 ocons (gzip 
compressed data, from Unix, max compression)

I think that this is also going into the upstream source.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
