Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2IBK7x6004700
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 06:20:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2IBGdn8002516
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 11:16:39 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2IBGbpk002509
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 11:16:38 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id E328FBF52
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 21:56:46 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 15486-09
 for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 21:56:45 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 90BF6BF41
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 21:56:45 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6DDDA9253C
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 21:56:46 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 30E84790D
	for <selinux@tycho.nsa.gov>; Tue, 18 Mar 2003 11:56:36 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: file_type_auto_trans(initrc_t, etc_t, etc_runtime_t) 
Date: Tue, 18 Mar 2003 11:56:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303181156.34723.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that the above policy line should be changed to:
file_type_auto_trans(initrc_t, etc_t, etc_runtime_t, file)

Currently I have a script that creates a symlink under /etc which doesn't need 
to be in etc_runtime_t.  I don't think that there's any need for enabling all 
file types to be created in etc_runtime_t (especially as there isn't policy 
to allow other programs to access those types).

I have also changed all other instances of type transitions to etc_runtime_t 
to refer to "file" class objects in my tree.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
