Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01700
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 10:43:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA26097
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 15:41:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA26093
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 15:41:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2769892668
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 02:43:37 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 010D633B
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 16:43:31 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: expect
Date: Fri, 29 Nov 2002 16:43:31 +0100
MIME-Version: 1.0
Message-Id: <200211291643.31661.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Due to what I believe to be bugs in expect, the new open_init_pty program will 
not work correctly with old versions of expect.  Version 5.38.0 works fine, 
version 5.32.2 is broken.  I don't know when the bug was fixed exactly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
