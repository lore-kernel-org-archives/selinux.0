Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02591
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 17:36:33 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA22207
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:34:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA22203 for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:34:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2C6C092713
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 09:36:30 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7B2F92096
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 23:36:22 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: the new default_contexts file
Date: Wed, 30 Oct 2002 23:36:21 +0100
MIME-Version: 1.0
Message-Id: <200210302336.21769.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The idea of having key-value pairs where the key is the partial context of the 
daemon is good.

However only being able to specify an order is not good.

I would like to be able to have two users, user "a" gets user_r:user_t by 
default while user "b" gets second_r:second_t by default even though both 
users are authorised for both roles.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
