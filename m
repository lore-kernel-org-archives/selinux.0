Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j68E7igA021440
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 10:07:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j68E5HGt000867
	for <selinux@tycho.nsa.gov>; Fri, 8 Jul 2005 14:05:19 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1FDD461B05
	for <selinux@tycho.nsa.gov>; Sat,  9 Jul 2005 00:05:05 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30480-10 for <selinux@tycho.nsa.gov>;
	Sat, 9 Jul 2005 00:05:04 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A8BA961AFF
	for <selinux@tycho.nsa.gov>; Sat,  9 Jul 2005 00:05:04 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: crond_t
Date: Sat, 9 Jul 2005 00:04:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507090004.57794.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that the domain crond_t needs the attribute privfd.  The number of 
things that are run from cron jobs demands it.  A user of the rawhide policy 
reported a problem running ping from a cron job on IRC.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
