Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5S71OrT010707
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 03:01:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5S718VC003244
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 07:01:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5CB3161C7F
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:01:21 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18402-08 for <selinux@tycho.nsa.gov>;
	Mon, 28 Jun 2004 17:01:21 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0B60C61BD6
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:01:21 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9F547B5A26
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:01:18 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: r_file_perms and ioctl
Date: Mon, 28 Jun 2004 17:01:18 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406281701.18137.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that including ioctl in the r_file_perms macro is a bad idea.  
ioctl is often (usually?) used for writing, so therefore the macro is not 
doing what it's name suggests.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
