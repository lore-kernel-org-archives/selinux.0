Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h32NrVx6026514
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 18:53:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h32NnrOv023396
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 23:49:54 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h32NnpY1023393
	for <selinux@tycho.nsa.gov>; Wed, 2 Apr 2003 23:49:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "ccallen" <ccallen@windowpane.com>
Subject: Re: Motif for selinux?
Date: Thu, 3 Apr 2003 09:53:04 +1000
Cc: <selinux@tycho.nsa.gov>
References: <000d01c2f7fa$f3c67730$398314d1@windowpane.com> <200304022237.31539.russell@coker.com.au> <003501c2f962$231ba240$398314d1@windowpane.com>
In-Reply-To: <003501c2f962$231ba240$398314d1@windowpane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304030953.04862.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 3 Apr 2003 07:52, ccallen wrote:
> I'll try out your KDE. I have RH 7.1 and selinux 2.5, will this work ok
> with your code?

There is no "selinux 2.5", SE Linux has never been released with any version 
number other than the date (for at least the last two years).  I imagine that 
you may be referring to Linux kernel 2.5.x, that should work as well as a 
2.4.x kernel provided you have the right kernel patches.

My kdm binary may not work with RH, KDE depends on lots of shared objects and 
my package may depend on different versions of the libraries than you have 
installed.

If you compile from source then it should be OK if RH 7.1 uses KDE 2.2.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
