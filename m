Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i65Dr0rT025104
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 09:53:00 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i65DqdEZ007025
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 13:52:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 099D061C14
	for <selinux@tycho.nsa.gov>; Mon,  5 Jul 2004 23:52:56 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30030-08 for <selinux@tycho.nsa.gov>;
	Mon, 5 Jul 2004 23:52:55 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B4A1361BD7
	for <selinux@tycho.nsa.gov>; Mon,  5 Jul 2004 23:52:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id EF557B59A1
	for <selinux@tycho.nsa.gov>; Mon,  5 Jul 2004 23:52:53 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: cifs_t
Date: Mon, 5 Jul 2004 23:52:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407052352.53439.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

typealias sambafs_t alias cifs_t;

What is the benefit of the above?

If we are going to make cifs_t the new name for what is currently sambafs_t 
then surely the correct thing to do is to change the declaration of sambafs_t 
to cifs_t and use the following typealias:

typealias cifs_t alias sambafs_t;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
