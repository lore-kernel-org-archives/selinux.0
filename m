Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MBPirT012843
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 07:25:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MBOvdQ003466
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 11:24:59 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fedora and udev
Date: Sun, 22 Aug 2004 21:25:38 +1000
Cc: fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408222125.38169.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that udev is now virtually mandatory as of the latest rawhide update.

udev uses ramfs for /tmp, ramfs (as of the latest Fedora kernel 2.6.8-1.525) 
has no support for file labelling and breaks everything.

Can we get ramfs labelling working in the next few days or do we have to 
change things to not depend on udev?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
