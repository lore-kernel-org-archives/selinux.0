Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJAuDRb017194
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 05:56:13 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAJAuCqY024809
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 10:56:12 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAJAu90o024795 for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 10:56:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id D29CE61BE6
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 21:56:03 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30291-06 for <selinux@tycho.nsa.gov>;
	Wed, 19 Nov 2003 21:56:03 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 85C6861BE5
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 21:56:03 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 54706925E8
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 21:56:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 599787F0A0
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 21:56:01 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: igmp_packet_t in system_r
Date: Wed, 19 Nov 2003 21:56:00 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311192156.00832.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why are types such as igmp_packet_t in system_r?  I thought that such types 
used for labelling packets would not need to be in any role...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
