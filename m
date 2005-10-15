Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9GMOuNs022967
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 18:24:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9GMMHcL026856
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 22:22:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BE65561B00
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:29 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07499-08 for <selinux@tycho.nsa.gov>;
	Mon, 17 Oct 2005 08:22:28 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CD85861AF6
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:27 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id B3C5C61
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:08 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: MLS context?
Date: Sat, 15 Oct 2005 20:27:54 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510152027.59150.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What is the canonical term for the MLS part of the policy?  Currently I've 
been using the term "MLS context" to refer to the combination of level (or 
range of levels) and categories (if there are any).

Is this an OK term?  If not then what should I use?

Also it has to be short.  I am NOT going to say "MLS range and optional 
categories" 100 times in the course of a talk.  Two words is the maximum, if 
there is no canonical term for this then we need to make something up.

Also what term should I use for the human-readable version of the above as 
taken from /etc/mcs.conf?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
