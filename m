Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7H3HGrT011119
	for <selinux@tycho.nsa.gov>; Mon, 16 Aug 2004 23:17:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7H3GYqL004449
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 03:16:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1A33A61AF1
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:17:13 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08117-06 for <selinux@tycho.nsa.gov>;
	Tue, 17 Aug 2004 13:17:12 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C905661AF0
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:17:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 57978B58B0
	for <selinux@tycho.nsa.gov>; Tue, 17 Aug 2004 13:17:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: how does this port binding happen?
Date: Tue, 17 Aug 2004 13:17:10 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408171317.10813.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { name_bind } for  pid=14909 exe=/usr/bin/kview src=669 
scontext=rjc:staff_r:staff_t tcontext=system_u:object_r:port_t 
tclass=tcp_socket

kview is a viewer for JPEG etc images.  It is never run as root.  How does it 
get to the stage of an SE Linux access check?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
