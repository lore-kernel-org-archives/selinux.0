Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0E4ruRb023742
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 23:53:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0E4qlxr009448
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 04:52:47 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i0E4qUYc009415
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 04:52:46 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id BFB1961B0F
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 15:52:12 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06327-01 for <selinux@tycho.nsa.gov>;
	Wed, 14 Jan 2004 15:52:12 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 3AA9861B03
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 15:52:12 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E0E53924F5
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 15:52:11 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8FB6CB5871
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 15:52:25 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: LCA 2004
Date: Wed, 14 Jan 2004 15:52:24 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401141552.24927.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am currently at Linux Conf AU 2004 see http://www.linux.conf.au/ for 
details.

Yesterday I have a 45min talk at the Debian mini-conference about the state of 
SE Linux in Debian.

Today I gave a 3 hour tutorial on SE Linux which covered lots of things in 
great detail.  I even showed samples of SE Linux policy, this wasn't planned 
but the delegates demanded it and told me that it really helped them 
understand what SE Linux is about.  I was a bit surprised as usually showing 
policy loses the audience.

The audience response was very positive, and I got the impression that some 
people were more likely to buy RHEL 4 due to it having SE Linux support.

I have put the notes from the tutorial online on 
http://www.coker.com.au/selinux/talks/lca2004/ , however the notes have 
little in common with the actual presentation as it was largely driven by 
user questions for the last two hours.  I had enough material prepared for 
1.5 to 2 hours of talking, I followed that for 1 hour, covered most of the 
rest in response to questions, and then covered lots of other stuff in 
response to questions.  People who attended the tutorial may want to get the 
notes, but they won't be of much general use.  Also they cover the practical 
issues of installation before the theory to be tailored to the needs of 
people who want to do an install.

The initial plan for the tutorial had involved UML, I had to cancel this 
because I couldn't get UML to run properly without crashing.  Given this and 
the apparent lack of delegate interest in such things I have cancelled all 
future plans for UML based tutorials.  I still plan to put such things on the 
web, but only as is conveniant and at times when UML works well with recent 
kernels and on recent host kernels.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
