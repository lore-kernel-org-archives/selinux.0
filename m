Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17058
	for <selinux@tycho.nsa.gov>; Tue, 19 Nov 2002 19:24:27 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA17500
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 00:22:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA17496
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 00:22:18 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E1B2E92668
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 11:24:22 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 03C2526D
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 01:24:06 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: allow a_domain_t fs_t:filesystem getattr;
Date: Wed, 20 Nov 2002 01:24:05 +0100
MIME-Version: 1.0
Message-Id: <200211200124.05531.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that almost everything wants to check for free space on file systems 
occasionally.

Is there any reason for not changing macros such as daemon_base_domain() and 
general_domain_access() to include it instead?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
