Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8NHe3rT011168
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 13:40:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8NHd1v8003619
	for <selinux@tycho.nsa.gov>; Thu, 23 Sep 2004 17:39:02 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6019861B01
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 03:40:01 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16444-05 for <selinux@tycho.nsa.gov>;
	Fri, 24 Sep 2004 03:40:01 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0765661AFB
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 03:40:01 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8A93DB5889
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 03:39:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: start_udev
Date: Fri, 24 Sep 2004 03:39:57 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200409240339.57966.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In Fedora there is a shell script named /sbin/start_udev.  This script is run 
from rc.sysinit to setup sym-links etc on a tmpfs /dev.  In the most strict 
configuration of the strict policy initrc_t does not have the required access 
to device_t.  I currently have start_udev labelled as udev_exec_t which makes 
this work.

Which is worse, allowing initrc_t to transition to udev_t by a shell script or 
just giving initrc_t extra privs?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
