Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13481
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 11:52:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA10012
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 16:49:00 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA10008
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 16:48:58 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 50FAE92569
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 03:52:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C05B3270B
	for <selinux@tycho.nsa.gov>; Wed, 19 Feb 2003 17:51:53 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Cover Story in Linux Journal
Date: Wed, 19 Feb 2003 17:51:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200302191751.53243.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An article on SE Linux by Carsten Grohmann and Konstantin Agouros is the 
February cover story for Linux Journal.  It's a good article and I recommend 
that everyone here reads it.  Users can learn a lot from it, and developers 
can get some ideas of things to improve.


The article mentions a problem with /etc/localtime being a hard link on SUSE 
causing problems.  This is something we should fix in policy.

Maybe we should just label all the time zone files readable_t?


A problem is mentioned with suse mingetty.  The error messages displayed in 
the article appear to have come from permissive mode (in enforcing mode the 
directories containing the files in question could not be searched).  Perhaps 
we should just add the following rule to getty.te:
dontaudit getty_t domain:dir { getattr search };
That should fix mingetty and other similar getties.


Regarding the name of cron, the Red Hat name for cron is crond, the Debian 
(and apparently SUSE) name is cron.  The idea is that you only have one cron 
program installed.


I agree with removing updatedb.  If you like security then you don't like 
updatedb anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
