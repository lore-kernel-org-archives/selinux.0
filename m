Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91BDvsJ024040
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 07:13:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91BC9Zt019079
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 11:12:09 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h91BC5M3019065
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 11:12:06 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 601D7924F2
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 21:13:47 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 857B97F06B
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 21:13:45 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: makemap
Date: Wed, 1 Oct 2003 21:13:44 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310012113.44940.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

/usr/bin/makemap                system_u:object_r:sbin_t

What is the above entry in types.fc about?  Is there a hard-link between a 
file in /usr/sbin and /usr/bin?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
