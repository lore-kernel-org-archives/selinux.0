Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7I3HBHa009896
	for <selinux@tycho.nsa.gov>; Sun, 17 Aug 2003 23:17:11 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7I3HAj6000828
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:17:10 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7I3H9NN000825 for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 03:17:09 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5313E92719
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 13:17:02 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id AB0BA7F08C
	for <selinux@tycho.nsa.gov>; Mon, 18 Aug 2003 13:16:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: my policy tree
Date: Mon, 18 Aug 2003 13:16:58 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308181316.58061.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am merging in policy from the 2.6 branch into my policy tree, the aim is to 
have a single tree that works for both old and new SE Linux systems to allow 
easy forward and backward compatability.

On http://www.coker.com.au/selinux/policy.tgz I have a first cut at this.  It 
works well for old SE Linux systems but has not yet been tested on 2.6.0 
systems.  Please let me know how it goes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
