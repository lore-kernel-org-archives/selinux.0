Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91Am4sJ023940
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 06:48:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91AkGZt017777
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 10:46:16 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h91AkFM3017774
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 10:46:15 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C1BB2924F2
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 20:47:55 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3A2CA7F004
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 20:47:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: selinux@tycho.nsa.gov
Subject: new setfiles patch
Date: Wed, 1 Oct 2003 20:47:53 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310012047.53638.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I just noticed that the check for file mode is AFTER the regex check in 
setfiles!  Obviously a check for equality of integers is much faster than 
regular expression checks so I put the file mode check first, in the hope 
that avoiding a regex check in the somewhat rare case of a type being 
specified that does not match the file being checked will save more time than 
the large number of checks for integers.

I had just modified types.fc to specify the type of the file/device for every 
entry in /dev (for correct results not for speed).  So I decided to do a test 
of setfiles on /dev, it went from 7.47s of user CPU time on a P2-400 to under 
4.78s.

For labeling a file system of 168539 Inodes the stem compression version took 
203s, while the one with stem compression and which does the check took 206s.

The tests for /dev show that there is some potential in this change.  Of 
course it's easier in that /dev is partitioned almost equally into chr_file 
and blk_file which means that we approximately halve the number of regex 
checks.  But the test for a complete root file system shows that it's not 
something we want to include right now.  Even if my file system is unusual in 
some way that makes it a degenerate case (unlikely), then it still seems most 
likely that the common case will not gain much (if anything).  So it's not 
worth patching for such little gains.

It has occurred to me that we should specify the types of files in more cases. 
There have been many instances where a new file has been installed which has 
a name that matches an existing entry but has a different type, the result 
was that it got labeled with the wrong type.  Adding the types to most 
entries will minimise such problems in future and also may potentially allow 
a performance improvement at some future time.

Currently with my stem compression patch I'm finding setfiles to take about 
80% CPU time on my test machines.  I think that I need to find one more 
optimisation method for the CPU use before I explore Steve Tweedie's ideas 
about optimising disk IO.  Currently optimising disk IO seems unlikely to 
give more than about a 30% benefit in the best case (IE systems that are more 
IO bound than my test machines).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
