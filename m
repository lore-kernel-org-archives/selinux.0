Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7B8H9rT008833
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 04:17:10 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7B8H35L028603
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 08:17:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E8D2E61C27
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 18:16:58 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21333-04 for <selinux@tycho.nsa.gov>;
	Wed, 11 Aug 2004 18:16:58 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9398061BB4
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 18:16:58 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D149FB59AA
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2004 18:16:56 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: network auditing
Date: Wed, 11 Aug 2004 18:16:56 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408111816.56367.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  granted  { name_bind } for  pid=21718 exe=/usr/bin/imapd 
scontext=system_u:system_r:courier_pop_t tcontext=system_u:object_r:port_t 
tclass=tcp_socket

On kernel 2.6.7 with the patch from the NSA site I get messages such as the 
above about port access.  Can we get this changed to log the port number as 
it used to?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
