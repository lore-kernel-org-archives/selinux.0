Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65]) by
	tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3356ex6027497 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 00:06:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1]) by
	jazzswing.ncsc.mil  with ESMTP id h3352qOv004465 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 05:02:52 GMT
Received: from windowpane.com (ip57.gte1.rb1.bel.nwlink.com
	[209.20.131.57]) by jazzswing.ncsc.mil  with ESMTP id h3352pY1004456 for
	<selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 05:02:52 GMT
Message-ID: <004301c2f99f$3f5ad970$398314d1@windowpane.com>
From: "ccallen" <ccallen@windowpane.com>
To: "Russell Coker" <russell@coker.com.au>
Cc: <selinux@tycho.nsa.gov>
References: <000d01c2f7fa$f3c67730$398314d1@windowpane.com>
	 <200304022237.31539.russell@coker.com.au>
	 <003501c2f962$231ba240$398314d1@windowpane.com>
	 <200304030953.04862.russell@coker.com.au>
Subject: Re: Motif for selinux?
Date: Wed, 2 Apr 2003 21:09:47 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Whoops, I meant the LSM 2.5 based selinux.

I'll try recompiling from source. The kde site only lists version 2.22, will
that one work?

Conan

----- Original Message -----
From: "Russell Coker" <russell@coker.com.au>
To: "ccallen" <ccallen@windowpane.com>
Cc: <selinux@tycho.nsa.gov>
Sent: Wednesday, April 02, 2003 3:53 PM
Subject: Re: Motif for selinux?


> On Thu, 3 Apr 2003 07:52, ccallen wrote:
> > I'll try out your KDE. I have RH 7.1 and selinux 2.5, will this work ok
> > with your code?
>
> There is no "selinux 2.5", SE Linux has never been released with any
version
> number other than the date (for at least the last two years).  I imagine
that
> you may be referring to Linux kernel 2.5.x, that should work as well as a
> 2.4.x kernel provided you have the right kernel patches.
>
> My kdm binary may not work with RH, KDE depends on lots of shared objects
and
> my package may depend on different versions of the libraries than you have
> installed.
>
> If you compile from source then it should be OK if RH 7.1 uses KDE 2.2.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
