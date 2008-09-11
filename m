Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8B3r1eF008724
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 23:53:01 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8B3qFbv013448
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 03:52:17 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 841CA18064
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 13:52:53 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3m0JnqcW0y4Y for <selinux@tycho.nsa.gov>;
	Thu, 11 Sep 2008 13:52:53 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 0A20218032
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 13:52:53 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A4B3321E3E
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2008 13:52:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: strange memory use of mcstransd
Date: Thu, 11 Sep 2008 13:52:50 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809111352.51371.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

root      2307  0.2 21.5 408364 54784 ?        Ss   Aug21  90:08 mcstransd

408M of RAM for mcstransd, over the course of 20 days.  The package is 
mcstrans-0.2.7-1.el5 from CentOS 5.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
