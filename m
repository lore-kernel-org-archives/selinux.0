Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA26005
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 07:59:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA14906
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 12:56:56 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA14902
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 12:56:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: box is back
Date: Tue, 21 Jan 2003 13:59:35 +0100
Cc: Don Marti <dmarti@zgp.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301211359.35581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a new SE Linux play machine online.
ssh -p 222 root@adsl.coker.com.au
Password "1234"

IRC channel is #selinux on irc.debian.org.

It's using the latest kernel patch (compiled with GCC 3.2) and policy.

This time almost everything runs as root and almost all files and directories 
are mode 777 (some daemons change things and I've installed a few new 
packages that have resulted in some files with restrictive permissions).  
It's difficult to keep everything mode 777, but the general aim is for SE 
Linux to be the only security mechanism.

I plan to also change all daemons apart from sshd to not use other UIDs as 
well, and change the spasswd wrapper to allow you to change your password.

If anyone wants their own role so that they can avoid having lamers kill their 
shell then let me know by private email.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
