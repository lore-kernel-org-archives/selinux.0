Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UBr8Ns026990
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 07:53:08 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UBlJDY019164
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 11:47:20 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 522C661B01
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 21:47:19 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14984-03 for <selinux@tycho.nsa.gov>;
	Fri, 30 Sep 2005 21:47:19 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EC3F161AFB
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 21:47:18 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id CFBF23EC0
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 21:47:14 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: /proc and chcon
Date: Fri, 30 Sep 2005 21:47:08 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200509302147.14082.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Was it the intention that some /proc objects can be relabeled now that the 
kernel supports exposing their context through the xattr interface?

It's impossible to change the context of /proc/PID entries, but files such 
as /proc/mtrr can be relabeled.

It seems to me that this functionality is undesirable.  Apart from /proc/PID 
entries everything under /proc has genfscon entries, I think it makes sense 
to have that as the only way of labeling /proc.

Also I imagine that the plan is to have the xattr interface also be used to 
display the context for a file system mounted with "-o context=...".  For 
that case I also think that it would be a bad idea to support changing the 
context via restorecon/chcon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
