Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k47DjoaB030653
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 09:45:50 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k47DjliA024689
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 13:45:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CD4DF61B06
	for <selinux@tycho.nsa.gov>; Sun,  7 May 2006 23:45:47 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22035-01 for <selinux@tycho.nsa.gov>;
	Sun, 7 May 2006 23:45:47 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7CBEE61B03
	for <selinux@tycho.nsa.gov>; Sun,  7 May 2006 23:45:47 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A20A7A7EAE
	for <selinux@tycho.nsa.gov>; Sun,  7 May 2006 23:45:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: /etc/mtab and namespaces
Date: Sun, 7 May 2006 23:45:45 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605072345.49483.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190962
I have filed a bugzilla entry requesting that /etc/mtab be made a sym-link 
to /proc/mounts to allow df(1) to work correctly when multiple name spaces 
are being used.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
