Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8TGkIsJ013041
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 12:46:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8TGkHCG008148
	for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 16:46:17 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8TGk8qJ008145 for <selinux@tycho.nsa.gov>; Mon, 29 Sep 2003 16:46:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 2E4F4BF45
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 02:46:06 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17219-05 for <selinux@tycho.nsa.gov>;
 Tue, 30 Sep 2003 02:45:35 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id B0632BF15
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 02:45:35 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 59DE7924D6
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 02:45:35 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 37CC77F07C
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2003 02:45:18 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: new policy
Date: Tue, 30 Sep 2003 02:45:17 +1000
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309300245.17758.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have put a new policy online at http://www.coker.com.au/selinux/policy.tgz

It has more support for Red Hat stuff, the start of support for the initrd
policy (no-where near usable yet, just getting the conditional code right),
and more improvements to attributes and assertions.

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
