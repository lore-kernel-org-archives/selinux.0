Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA29437
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 08:19:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA10379
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:18:28 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id MAA10370
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 12:18:26 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 406C692465
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 22:19:54 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8B37B76A5
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 14:19:46 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: losing type information under high load
Date: Fri, 27 Sep 2002 14:19:46 +0200
MIME-Version: 1.0
Message-Id: <200209271419.46189.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have two machines running ReiserFS for /var/cache/squid where files 
occasionally get changed to type system_u:object_r:file_t for no good reason.

This has happened for the last few kernel patches, with kernel 2.4.18 and 
2.4.19, and is not related to power failures or crashes.

The only other similar occurance I observed involved a mail server queue file 
(but this only happened once and I'm not certain it wasn't due to another 
cause).

I suspect that there is some sort of ReiserFS/SE problem here regarding file 
systems that are under moderate load (neither of the Squid machines in 
question is under heavy load - the more highly loaded machine was running 
fine when it was a Pentium-166, now it's a well configured Athlon 1000 with 
corresponding improvements in RAM and disk).

These problems occur about two or three times a month (it'll be tough to track 
down).  I can't recommend that the NSA people spend any great amount of time 
investigating this until/unless we get some confirmation of this (and 
preferrably from someone who isn't using ReiserFS).

However this raises another issue.  In the default policy we allow almost 
everything read access to file_t directories, sym-links, and files.  So any 
situation that results in a file changing to the default type (EG a power 
failure at an inconveniant time) may make a file world-readable!!!

Is there any reason for not restricting file_t to the administrator only?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
