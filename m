Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8A31KLa006816
	for <selinux@tycho.nsa.gov>; Tue, 9 Sep 2003 23:01:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8A2xiLY027234
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 02:59:44 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8A2xgsG027229
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 02:59:43 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id BE27AC1C8
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:01:16 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19590-04 for <selinux@tycho.nsa.gov>;
 Wed, 10 Sep 2003 13:01:15 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id E55F7C1C5
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:01:14 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AA7EA92722
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:01:14 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 321347F064
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:01:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: uml
Date: Wed, 10 Sep 2003 13:01:10 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309101301.10559.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have updated my UML pages with patches for 2.4.22 and 2.6.0test5.

The 2.6.0 patch is a 1 liner which is all that's needed.

For 2.4.22 I forward ported the ACL patch and the latest old-style SE Linux 
patch to 2.4.22.

http://www.coker.com.au/uml/

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
