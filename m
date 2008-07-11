Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6BC5i4Y008107
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2008 08:05:44 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6BC5Zjn014068
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2008 12:05:42 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 9DFB718324
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2008 22:05:28 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UOF9liVicDuZ for <selinux@tycho.nsa.gov>;
	Fri, 11 Jul 2008 22:05:28 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 3036E1830F
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2008 22:05:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id B3D3CB4006
	for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2008 22:05:26 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: checkmodule error
Date: Fri, 11 Jul 2008 22:05:24 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807112205.26358.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

# /usr/bin/checkmodule -M base.conf
/usr/bin/checkmodule:  loading policy configuration from c.conf
libsepol.expand_module: Error while indexing out symbols
/usr/bin/checkmodule:  expand module failed

According to the archives the above problem was solved almost two months ago.  
I've tried using the latest checkmodule and libraries from Fedora 9.  Are 
they not new enough?

I've tried to upgrade to Rawhide, but yum doesn't seem to be selecting mirrors 
that work at the moment.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
