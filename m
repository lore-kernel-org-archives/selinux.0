Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA19460
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 17:46:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA03957
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 22:44:12 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id WAA03953
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2002 22:44:10 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 92DA592724
	for <selinux@tycho.nsa.gov>; Thu,  7 Nov 2002 09:45:50 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8F1958F8A
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2002 23:45:45 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: rw_dir_perms vs r_dir_perms
Date: Wed, 6 Nov 2002 17:21:17 +0100
MIME-Version: 1.0
Message-Id: <200211061721.17136.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

r_dir_perms includes ioctl access while rw_dir_perms doesn't.

This is obviously wrong as rw_dir_perms should be a superset of r_dir_perms.

Should it be added to rw_dir_perms or removed from r_dir_perms?

Also the other *_dir_perms macros will need appropriate adjustments...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
