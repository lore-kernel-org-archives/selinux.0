Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA23080
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 06:42:42 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA28254
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 11:40:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id LAA28250
	for <selinux@tycho.nsa.gov>; Mon, 9 Dec 2002 11:40:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 01F9492668
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 22:42:38 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5FA6FEC
	for <selinux@tycho.nsa.gov>; Mon,  9 Dec 2002 12:42:33 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Debian package building on multiple architectures
Date: Mon, 9 Dec 2002 12:42:32 +0100
MIME-Version: 1.0
Message-Id: <200212091242.32684.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://buildd.debian.org/build.php?&pkg=selinux-small
The above URL shows the progress of the auto-builders in compiling 
selinux-small for Debian.

At the moment HPPA, ARM, S390, and SPARC are successful (i386 is not in the 
list because I compile for i386 myself).

Now we need some people to try compiling kernels for these platforms and 
booting them.  I'll build ARM (but I'll need to boot the kernels on other 
people's machines for a while until I get my own hardware).  S390 should be 
easy enough if you have a fast x86 machine (say an Athlon 1400) for Hercules.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
