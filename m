Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6TFKHim028295
	for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2006 11:20:17 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6TFKAaH012649
	for <selinux@tycho.nsa.gov>; Sat, 29 Jul 2006 15:20:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7FA3761B0D
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:20:14 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26749-07 for <selinux@tycho.nsa.gov>;
	Sun, 30 Jul 2006 01:20:14 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3403E61B04
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:20:14 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id EC4C9A8668
	for <selinux@tycho.nsa.gov>; Sun, 30 Jul 2006 01:20:14 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: SMP enabled restorecon
Date: Sun, 30 Jul 2006 01:20:13 +1000
References: <200607300117.23329.russell@coker.com.au>
In-Reply-To: <200607300117.23329.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200607300120.14835.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Please test this out and let me know how it goes.  Also note that setfiles
> needs the same work done (but it's easier to test it out on restorecon
> first).

I almost forgot, the code for recognising a SMP system isn't particularly 
good.  On a HT system you will get a restorecon process for each thread which 
will probably give bad performance.  If someone knows how to recognise the 
real number of CPUs in a HT system then please let me know.

Also does Linux correctly optimise for HT yet?  If I have two HT CPUs and two 
processes running will I have one process on each CPU not two processes on 
the same CPU?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
