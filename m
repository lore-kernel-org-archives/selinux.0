Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i087G8Rb020388
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 02:16:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i087F5xr009501
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 07:15:05 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i087F2Yc009487
	for <selinux@tycho.nsa.gov>; Thu, 8 Jan 2004 07:15:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id C0EDA61C47
	for <selinux@tycho.nsa.gov>; Thu,  8 Jan 2004 18:14:43 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28738-04 for <selinux@tycho.nsa.gov>;
	Thu, 8 Jan 2004 18:14:43 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 7864A61C44
	for <selinux@tycho.nsa.gov>; Thu,  8 Jan 2004 18:14:43 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 56086924F5
	for <selinux@tycho.nsa.gov>; Thu,  8 Jan 2004 18:14:43 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 78E99B59C0
	for <selinux@tycho.nsa.gov>; Thu,  8 Jan 2004 18:14:41 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: rshd
Date: Thu, 8 Jan 2004 18:14:40 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401081814.40877.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ifdef(`rshd.te',
`# Connect second port to rshd.
can_tcp_connect(rshd_t, $1_t)')
')dnl end tcp server

What is the above section of user_macros.te about?  Why does an rsh server 
connect back to the client?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
