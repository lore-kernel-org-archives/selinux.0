Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11322
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 16:46:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBELkEI15907
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 21:46:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBELkDf15903 for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 21:46:13 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, selinux@tycho.nsa.gov
Subject: Re: new Debian packages
Date: Sat, 14 Dec 2002 22:46:03 +0100
References: <20021213223108.GA5424@lyta.coker.com.au> <20021214004206.D22479@lemuria.org>
In-Reply-To: <20021214004206.D22479@lemuria.org>
MIME-Version: 1.0
Message-Id: <200212142246.03463.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Dec 2002 00:42, Tom wrote:
> On Fri, Dec 13, 2002 at 11:31:08PM +0100, Russell Coker wrote:
> > I have packaged the new kernel patch and the selinux-small code and
> > uploaded them to my web site and to Debian.
> >
> > Please make sure that you install the "selinux" and
> > "selinux-policy-default" packages BEFORE booting a kernel compiled with
> > the latest kernel patch.
>
> I'll be testing this next week. Any new kernels from Brian that I could
> give a shakedown while I'm at it? (I've hosed my test machine again.
> Must remember to be more careful. Will probably write a new chapter
> into my "things not to do with SELinux" paper. :) )

With what Brian is attempting to do with his kernels it might take him a while 
to get a new one out.  Maybe you would be better off just compiling your own.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
