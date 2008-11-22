Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mAMMu5l7016033
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 17:56:06 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mAMMu3dq010889
	for <selinux@tycho.nsa.gov>; Sat, 22 Nov 2008 22:56:05 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 0BDAF1811C
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2008 09:55:54 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 7C59521C73
	for <selinux@tycho.nsa.gov>; Sun, 23 Nov 2008 09:55:52 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: SE Linux on iPaQ
Date: Sun, 23 Nov 2008 09:55:47 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811230955.50483.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://familiar.handhelds.org/#download

I would like to get back into mobile SE Linux development.  From the above URL 
it seems that the latest version of Familiar (which I used for my previous 
SE-iPaQ work) was released in 2006.  Is Familiar dead?

The latest version of Familiar uses a 2.4.x kernel (which means either 
back-porting SE Linux kernel code or getting a 2.6.x kernel working - either 
of which will take a lot of time).  I expect that the 2.4.x kernel in 
question doesn't have the recent JFFS2 update that includes XATTR support 
either.  It also has a nasty bug which prevents either of my iPaQ's from 
working on either of my cradles (so it's not a hardware issue).

http://intimate.handhelds.org/download.html

It appears that the latest version of Intimate dates from 2001.

Is anyone here using a H3900 class iPaQ?  If so what are you running on it?


PS  I'm not interested in spending any money on this.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
