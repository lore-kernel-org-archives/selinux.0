Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9B4ZxWt008085
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 00:35:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9B4ZwUb007744
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 04:35:58 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h9B4ZvhX007741 for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 04:35:57 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2106992472
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 14:35:50 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D88DC7F031
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 14:35:47 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: specifying groups of types
Date: Sat, 11 Oct 2003 14:35:46 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310111435.46684.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Following a discussion on IRC, it occurs to me that it would be handy to have 
the following in the policy language:
allow some_domain { file_type !shadow_t }:...

So we can specify everything in file_type except for shadow_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
