Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9UJBEWt014951
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 14:11:14 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9UJBDKl010086
	for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 19:11:13 GMT
Received: from lyta.coker.com.au (nat-pool-bos.redhat.com [66.187.230.200])
        by jazzband.ncsc.mil  with ESMTP id h9UJB65m010082 for <selinux@tycho.nsa.gov>; Thu, 30 Oct 2003 19:11:12 GMT
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 636277F004
	for <selinux@tycho.nsa.gov>; Fri, 31 Oct 2003 06:10:15 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: user's access to files in their own home directory
Date: Fri, 31 Oct 2003 06:10:14 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310310610.14859.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So far in writing the policy I have allowed the user full access to files in 
their own home directory, with the exception of gpg where secrecy requires 
that the user's processes often be denied read access.

I would like some feedback on how people feel about having files/dirs under a 
user's home directory that they can't unlink or rename.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
