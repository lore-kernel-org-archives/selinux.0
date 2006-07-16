Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6G3WNZN027073
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 23:32:24 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6G3WKX0002349
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 03:32:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E890D61B0B
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 13:32:16 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 28861-10 for <selinux@tycho.nsa.gov>;
	Sun, 16 Jul 2006 13:32:16 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 911FC61AFD
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 13:32:16 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 13C9AA82F9
	for <selinux@tycho.nsa.gov>; Sun, 16 Jul 2006 13:32:15 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: FC5 policy
Date: Sun, 16 Jul 2006 13:32:13 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607161332.14880.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://www.coker.com.au/selinux/fc5/

At the above URL I have a policy patch for FC5 against the latest Fedora 
package (2.2.47-3.fc5) and some RPMs of it.  The changelog is below:

- Makes Amavis, Clamav, and Postgrey work, and work with Postfix.
- Makes the Apache policy build with the latest policycoreutils.
- Started to fix the mailman issues, it still needs more work and some package
  bug fixes to get it going properly.
- Allowed Samba to talk to CUPS.
- Allowed semanage to talk to the controlling terminal.
- Allowed unconfined domains to see unlabeled_t processes and kill them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
