Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5S73arT010726
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 03:03:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5S73LVC003307
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 07:03:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E71C861C7F
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:03:33 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18402-10 for <selinux@tycho.nsa.gov>;
	Mon, 28 Jun 2004 17:03:33 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8E97661BD6
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:03:33 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id F13E7B5A26
	for <selinux@tycho.nsa.gov>; Mon, 28 Jun 2004 17:03:31 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: assertions
Date: Mon, 28 Jun 2004 17:03:31 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200406281703.31530.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it be possible for the assertion messages to include the line number of 
the offending line?

Currently the assertion messages give the number of the line containing the 
assertion, but not the number of the line which violates it, which can be 
annoying when lots of attributes are used.  Sure we can use apol to get the 
same information, but if checkpolicy already has the information then it 
would be easier to have it just deliver it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
