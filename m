Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJ35bRb016023
	for <selinux@tycho.nsa.gov>; Tue, 18 Nov 2003 22:05:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJ357Bb026500
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 03:05:07 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAJ3554o026497
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 03:05:06 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 7961D61BE5
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:05:28 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07339-03 for <selinux@tycho.nsa.gov>;
	Wed, 19 Nov 2003 14:05:28 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 4349361BE4
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:05:28 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 00393925E8
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:05:26 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 2984E7F019
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 14:05:25 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: newrole and serial console
Date: Wed, 19 Nov 2003 14:05:24 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311191405.24719.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I find that a serial console does not work with newrole.  Newrole will re-open 
the terminal device to relabel it, and the re-open will block because it is 
already open.

Why is it that the file handles 0..2 are closed and re-opened for the child?  
Why not just keep the existing handles after changing the context of the 
device node?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
