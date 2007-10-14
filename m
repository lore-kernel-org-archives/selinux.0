Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9EC6aL2011527
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 08:06:36 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9EC6X41012019
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 12:06:34 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 46B95182B5
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 22:06:31 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 54wWK-NAz2sD for <selinux@tycho.nsa.gov>;
	Sun, 14 Oct 2007 22:06:31 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id E90871810B
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 22:06:30 +1000 (EST)
Received: from localhost (unknown [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id A459322332
	for <selinux@tycho.nsa.gov>; Sun, 14 Oct 2007 22:06:29 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: checkmodule and MLS/MCS support
Date: Sun, 14 Oct 2007 22:06:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200710142206.29369.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://ramblingfoo.blogspot.com/2007/10/selinux-mlsmcs-support.html

Given that everyone who is working on SE Linux seems to be working on MCS and 
MLS systems, would it make sense to have the default checkmodule operation be 
to generate modules for MLS/MCS policy?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
