Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA07373
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 13:07:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA04761
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 18:05:47 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id SAA04757
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 18:05:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 26EF492668
	for <selinux@tycho.nsa.gov>; Thu, 28 Nov 2002 05:07:40 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A53DC9F2
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 19:07:30 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: network operations
Date: Wed, 27 Nov 2002 19:07:29 +0100
MIME-Version: 1.0
Message-Id: <200211271907.29847.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When a program tries to establish a TCP connection that is denied by SE Linux 
policy then the result is that it will hang as the SYN packet is simply 
dropped.

Would it be possible for a RST packet to be sent back so that the application 
will get an error condition and then continue operating?


NB  I'm talking about localhost connections here, although I expect that the 
same situation would occur on labelled networking on a LAN.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
