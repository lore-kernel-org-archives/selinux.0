Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2LGWfx6022745
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 11:32:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2LGTClY022839
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 16:29:12 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h2LGT9KX022832
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 16:29:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 88B51BF44
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 03:32:36 +1100 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 17568-04
 for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 03:32:35 +1100 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 43796BF41
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 03:32:35 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E38D19253C
	for <selinux@tycho.nsa.gov>; Sat, 22 Mar 2003 03:32:36 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E4E866C5E
	for <selinux@tycho.nsa.gov>; Fri, 21 Mar 2003 17:32:26 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: executables under /usr/share
Date: Fri, 21 Mar 2003 17:32:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200303211732.26002.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In correctly labelling the files on a SE Linux system I have come across one 
significant problem, executables under /usr/share.

Many packages want to install such executables and expects that they can be 
executed by regular users, cron jobs, and/or daemons.

Labelling them correctly is unreasonably difficult with the current 
file_contexts method as there is no coherent naming scheme, and I would have 
to list all the files individually.

The only practical solutions at the moment seem to be the following:

1)  Label all files with the execute bit set under /usr/share as bin_t.

2)  Allow execute access to usr_t.

3)  Create a new share_t type of file that user_t and user_crond_t can execute 
and label all files under /usr/share with it.


If anyone has any better ideas then I would be very interested to hear them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
