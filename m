Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4575QHn009997
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 03:05:26 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4575NU3008915
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 07:05:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 48CCA61B02
	for <selinux@tycho.nsa.gov>; Fri,  5 May 2006 17:05:20 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05369-03 for <selinux@tycho.nsa.gov>;
	Fri, 5 May 2006 17:05:20 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id F1ECC61AF1
	for <selinux@tycho.nsa.gov>; Fri,  5 May 2006 17:05:19 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 44EA3A7DE5
	for <selinux@tycho.nsa.gov>; Fri,  5 May 2006 17:05:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: pam_namespace
Date: Fri, 5 May 2006 16:23:22 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605051623.25533.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was just playing with pam_namespace.  It seems to me that the current setup 
of having tmp/tmp.inst-$USER- does not provide adequate protection.  A 
process that is hostile to the user and which runs in the system name space 
(EG any cracked daemon) can access the user's instance of /tmp.

If we had tmp/tmp.inst-$USER-/tmp (or something similar) and 
gave /tmp/tmp.inst-$USER- permission mode 000 (and something equivalent in 
terms of SE Linux access) then processes in the global name space would not 
be able to try anything.


PS  I am posting here because I am no longer subscribed to the LSPP list.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
