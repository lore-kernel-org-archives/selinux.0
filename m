Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA18840
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 15:04:39 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gB7K4cI20566
	for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 20:04:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gB7K4bf20562 for <selinux@tycho.nsa.gov>; Sat, 7 Dec 2002 20:04:37 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Greg KH <greg@kroah.com>
Subject: Re: syscall numbers
Date: Sat, 7 Dec 2002 21:04:22 +0100
Cc: LSM <linux-security-module@wirex.com>, selinux@tycho.nsa.gov
References: <200212071904.15983.russell@coker.com.au> <20021207191832.GA16559@kroah.com>
In-Reply-To: <20021207191832.GA16559@kroah.com>
MIME-Version: 1.0
Message-Id: <200212072104.22795.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 7 Dec 2002 20:18, Greg KH wrote:
> On Sat, Dec 07, 2002 at 07:04:15PM +0100, Russell Coker wrote:
> > At the moment the very existance of the sys_security() call is under
> > debate so there's probably no point in submitting a change upstream, but
> > I think it would be good for development purposes if we had a syscall
> > defined for all architectures in the LSM patch.
>
> There's no more debate, the syscall is dead.

So what are we supposed to do until a replacement is devised?

I'm quite happy to make up my own stuff for Debian/unstable if there's no 
better options...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
