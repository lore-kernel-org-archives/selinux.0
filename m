Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RBP4rT019082
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 07:25:04 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RBP0oM013380
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 11:25:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 47D7961AFE
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:24:56 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19766-02 for <selinux@tycho.nsa.gov>;
	Fri, 27 Aug 2004 21:24:56 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D381361AFD
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:24:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D5EC5B58B1
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 21:24:53 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: iptables device nodes
Date: Fri, 27 Aug 2004 21:24:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408272124.53303.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 95 char        IP filter
                  0 = /dev/ipl          Filter control device/log file
                  1 = /dev/ipnat        NAT control device/log file
                  2 = /dev/ipstate      State information log file
                  3 = /dev/ipauth       Authentication control device/log file


I just noticed the above in devices.txt, the device nodes appear to be already 
on systems running the latest rawhide.  What programs use them?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
