Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3C4dQI4013720
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 00:39:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3C4ZgOv023600
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 04:35:42 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3C4ZOY1023597
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 04:35:41 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 690F4BF2D
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 14:38:51 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09994-06
 for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 14:38:50 +1000 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 2D3E2BF25
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 14:38:50 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EE3CF926FE
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 14:38:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9179053D
	for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2003 14:39:00 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: every_domain
Date: Sat, 12 Apr 2003 14:39:00 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200304121439.00008.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At http://www.coker.com.au/selinux/policy.tgz I have put my latest working 
tree of the SE Linux policy.

This is based off the latest NSA CVS code (IE the release a few days ago) but 
with many changes.  One thing I have done is removed the every_domain() macro 
from everything that I use on my laptop and that is being used on my parents' 
workstation (this was about 12 hours spent writing policy).

There is still a lot of work to be done in removing every_domain, but I think 
I've got most of the hard work done now and it should all be downhill from 
here.

Please note that this hasn't gone though as much testing as my policy changes 
usually get.  I've just moved country and haven't yet setup enough test 
machines for full testing.  In addition to this there are some things that I 
know to be non-functional.

But if you want to help with the development then please try this out!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
