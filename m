Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJ7IERb016673
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 02:18:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJ7IDqY021095
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 07:18:14 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAJ7IC0o021092 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 07:18:13 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 1087461BE7
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:18:07 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19738-05 for <selinux@tycho.nsa.gov>;
	Wed, 19 Nov 2003 18:18:06 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 9034761BE6
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:18:06 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 57E1B925E8
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:18:06 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6E8247F0A6
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 18:18:04 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policycoreutils/po
Date: Wed, 19 Nov 2003 18:18:03 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311191818.03912.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The Makefile's in the po directory of policycoreutils seem wrong.  There are 
Makefile.in and Makefile.in.in (looks like the remnants of an autoconf 
experiment).  Also the clean rule of the Makefile does not remove the 
generated file sv.gmo (looks like it should remove *.gmo).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
