Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i23FT1Rb011614
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 10:29:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i23FRM6Q019463
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 15:27:22 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i23FQf5t019327
	for <selinux@tycho.nsa.gov>; Wed, 3 Mar 2004 15:27:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id A89A161C71
	for <selinux@tycho.nsa.gov>; Thu,  4 Mar 2004 02:26:57 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09849-05 for <selinux@tycho.nsa.gov>;
	Thu, 4 Mar 2004 02:26:57 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 58D2261C70
	for <selinux@tycho.nsa.gov>; Thu,  4 Mar 2004 02:26:57 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 1797E53670
	for <selinux@tycho.nsa.gov>; Thu,  4 Mar 2004 02:26:56 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy booleans
Date: Thu, 4 Mar 2004 02:26:55 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403040226.55513.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Would it be possible for booleans to apply to things other than allow 
statements?

I would like to have booleans determining which domains are allowed in a role, 
and which role transitions are permitted.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
