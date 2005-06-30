Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U3vvgA019126
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 23:58:04 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U3uKdE022920
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 03:56:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 643C361B03
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 13:56:47 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18867-07 for <selinux@tycho.nsa.gov>;
	Thu, 30 Jun 2005 13:56:47 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1F99A61B02
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 13:56:47 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 6026344
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 13:56:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: security_compute_av(3)
Date: Thu, 30 Jun 2005 13:56:34 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200506301356.37995.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It appears that most functions in this man page require the header file 
selinux/av_permissions.h, but the man page omits to mention this.


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
