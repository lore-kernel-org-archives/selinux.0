Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8AA3WYj022911
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 06:03:32 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8AA2k6s014116
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 10:02:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 60E1E180EC
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 20:03:26 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3219ynTtOQ5z for <selinux@tycho.nsa.gov>;
	Wed, 10 Sep 2008 20:03:25 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 6CA3B180E8
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 20:03:25 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 3E4F220E78
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2008 20:03:18 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: semanage fcontext - policy loading
Date: Wed, 10 Sep 2008 20:03:15 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809102003.17804.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there some good reason for rebuilding and loading the policy as part of the 
process of running "semanage fcontext"?

It makes the process take a long time and doesn't seem to serve any purpose.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
