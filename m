Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8N6qSsJ011366
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 02:52:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8N6ojd0001872
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 06:50:45 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8N6oiVY001869
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 06:50:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 59BE6C16A
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:52:25 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12640-01 for <selinux@tycho.nsa.gov>;
 Tue, 23 Sep 2003 16:52:23 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id CDBD5BF3F
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:52:23 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 90534924D6
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:52:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3384C7F004
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 16:52:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles performance patch
Date: Tue, 23 Sep 2003 16:52:21 +1000
References: <200309231522.25749.russell@coker.com.au> <200309231623.41712.russell@coker.com.au>
In-Reply-To: <200309231623.41712.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309231652.21595.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Sep 2003 16:23, Russell Coker wrote:
> Now my version takes 15:45 CPU to check 157K files and 1:46 to check 102K
> files.  That is a rate of 166 files per second on a P3-650 and 962 on a
> P-166.  Either the operations that setfiles performs are seriously
> optimised for the original Pentium, the GCC 2.9.5 I used to compile for the
> P1 is better than the gcc 3.3.2 used for for the P2, or we have some
> performance issues whereby setfiles does not scale linearly to the number
> of files in the file system.  I will investigate this next and post again
> soon.

I've just tested the gcc 2.9.5 version on my P3-650 machine and found it to 
give almost exactly the same performance as the gcc 3.3.2 version (3 seconds 
difference in elapsed time out of 5M).

Next I will do some more tests on different file system sizes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
