Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hASD2mRb027246
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 08:02:48 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hASD2lqY004391
	for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 13:02:48 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hASD2k0o004382 for <selinux@tycho.nsa.gov>; Fri, 28 Nov 2003 13:02:47 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id E93D461BED
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 00:02:40 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27886-01 for <selinux@tycho.nsa.gov>;
	Sat, 29 Nov 2003 00:02:39 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 3C16761BE6
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 00:02:39 +1100 (EST)
Received: from kaos.lurking-grue.org (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E2C3E924CC
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 00:02:38 +1100 (EST)
Received: from kaos (kaos [127.0.0.1])
	by kaos.lurking-grue.org (Postfix) with ESMTP id 3DDD847287
	for <selinux@tycho.nsa.gov>; Sat, 29 Nov 2003 00:02:36 +1100 (EST)
From: Faye Coker <faye@lurking-grue.org>
Reply-To: faye@lurking-grue.org
To: SELinux <selinux@tycho.nsa.gov>
Subject: HOWTO for the new SE Linux
Date: Sat, 29 Nov 2003 00:02:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311290002.34609.faye@lurking-grue.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have updated my "Getting Started with SE Linux HOWTO" document to cover the 
new SE Linux.  I haven't tested the new-SElinux-from-scratch howto 
instructions as much as I'd like (I need to scrape together a spare Debian 
box and I'm currently having some issues with a Fedora SE Linux install), so 
the document will probably need some tweaking.

The document doesn't cover editing policy but I am working on a separate howto 
which covers editing policy and other background knowledge stuff in more 
detail, for people new to SE Linux.

My revised Getting Started doc can be found at

http://www.lurking-grue.org/gettingstarted_newselinuxHOWTO.html

Once I do some fine tuning and more testing, I'll put it up on Sourceforge.


faye
-- 
Faye Coker
faye@lurking-grue.org



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
