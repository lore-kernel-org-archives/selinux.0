Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA11197
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 08:57:46 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA10465
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:55:54 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id NAA10460
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 13:55:51 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id DE66B92713
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 00:57:28 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 61D7E6C9B
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 14:57:21 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: font paths
Date: Mon, 28 Oct 2002 14:57:20 +0100
MIME-Version: 1.0
Message-Id: <200210281457.20996.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://lists.debian.org/debian-kde/2002/debian-kde-200210/msg00605.html

Please read the above discussion about font paths used by KDE.  I imagine that 
GNOME is likely to do the same (if they don't already).

Would it make sense to have a user_home_xfont_t for the fonts so the X server 
can read them but not the rest of the user's files?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
