Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OECfx6002366
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 09:12:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OE9AlY022859
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 14:09:10 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2OE98KX022856
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 14:09:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 70574BF43
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 01:12:37 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 06232-06
 for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 01:12:36 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 327D7BF42
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 01:12:36 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 097AD9253C
	for <selinux@tycho.nsa.gov>; Tue, 25 Mar 2003 01:12:38 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5749A32B9
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 15:12:28 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Important fix for init.te
Date: Mon, 24 Mar 2003 15:12:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303241512.27894.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have finally discovered why my servers are crashing on reboot!  It seems 
that the lockd kernel thread for NFS which runs as init_t (for some reason - 
I don't know why) needs to create a UDP socket when it's being shut down.  If 
it fails to create the socket then it crashes, and the result can include 
file system corruption, files with incorrect SE Linux type labels, etc.

To fix this I added the following to the end of init.te.  I suggest that it be 
added to the CVS as a priority.

# to allow lockd (kernel thread) to shutdown without kernel panic
allow init_t self:udp_socket create_socket_perms;

This is probably not the best solution however, the kernel thread probably 
should not run as init_t.  But until I work out how to fix this giving UDP 
access to init_t is necessary.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
