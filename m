Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9GMOuNs022968
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 18:24:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9GMMbdD024977
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 22:22:38 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3BB5661AF5
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:29 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07815-01 for <selinux@tycho.nsa.gov>;
	Mon, 17 Oct 2005 08:22:28 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D97E261B01
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:27 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id D9FA463
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:08 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: range_transition inside a conditional
Date: Mon, 17 Oct 2005 07:57:52 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510170757.58947.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is that supposed to work?  It doesn't seem to do so at the moment (checkpolicy 
version 1.27.8-2 in rawhide.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
