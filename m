Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20604
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 09:38:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA23218
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 14:36:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA23214
	for <selinux@tycho.nsa.gov>; Sun, 8 Dec 2002 14:36:17 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DEEB092668
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 01:38:34 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D54DCF8
	for <selinux@tycho.nsa.gov>; Sun,  8 Dec 2002 15:38:25 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new coreutils package
Date: Sun, 8 Dec 2002 15:38:25 +0100
MIME-Version: 1.0
Message-Id: <200212081538.25157.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On http://www.coker.com.au/selinux/coreutils/ I have put a new Debian package 
of coreutils patched with SE Linux support.

Coreutils is the replacement for fileutils, shellutils, and textutils.

As part of creating the new package I have created a new patch against the 
original coreutils source named 16_selinux.  This patch is an improvement 
over the previous patches for the separate programs in a few areas.  One of 
the latest things I changed was to make runas have a --help output in the 
format that help2man expects.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
