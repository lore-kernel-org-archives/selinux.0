Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h827NRLa013408
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 03:23:27 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h827NQet002260
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 07:23:26 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h827NOlq002257 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 07:23:25 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id A9CB2BF3C
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:23:23 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24531-06 for <selinux@tycho.nsa.gov>;
 Tue,  2 Sep 2003 17:23:23 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id CE8BBBF29
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:23:22 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 77646926F8
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:23:22 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 378317F002
	for <selinux@tycho.nsa.gov>; Tue,  2 Sep 2003 17:23:28 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ls --context of /selinux
Date: Tue, 2 Sep 2003 17:23:27 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309021723.27716.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

What are the plans regarding "ls --context /selinux"?

Currently the lgetxattr() system call returns -1 (EOPNOTSUPP) and the current 
ls patch (taken from Dan's repository) refuses to even allow "ls -l" because 
of it (probably a bug in ls as I imagine that there will always be file 
systems that don't support it).

Will "ls --context /selinux" ever work?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
