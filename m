Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7HDY8Ha008713
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 09:34:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7HDWkOD018600
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 13:32:46 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h7HDWTKO018597
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 13:32:45 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E0EE092719
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 23:33:44 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CEA2D7F093
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 23:33:41 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: coreutils
Date: Sun, 17 Aug 2003 23:33:41 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308172333.41265.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've modified the coreutils patch for 5.0.90 and put the Debian packages in 
the usual place.

I encourage anyone who wants support for the latest coreutils to take a look 
at my patch instead of doing it themself, it's a real pain.  The coreutils 
tests have been made much more extensive between 5.0 and 5.0.90, and the 
original code failed many of them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
