Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA01036
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 11:17:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA16765
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:15:06 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA16754
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 16:15:04 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: egoodwin@unimatrix.com, selinux@tycho.nsa.gov
Subject: Re: SGI Challenge XL
Date: Mon, 2 Dec 2002 17:16:58 +0100
References: <OF4CFC5AAA.4DF982B3-ON85256C83.004AE823-85256C83.004B53A4@unimatrix.net>
In-Reply-To: <OF4CFC5AAA.4DF982B3-ON85256C83.004AE823-85256C83.004B53A4@unimatrix.net>
MIME-Version: 1.0
Message-Id: <200212021716.58396.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2 Dec 2002 14:50, egoodwin@unimatrix.com wrote:
> Has anyone worked with an SGI Challenge XL server and SE Linux as yet?  We
> would like to bring this server back from retirement and consider this
> project an excellent reason to do so.  While we still have IRIX 6.5.2
> loaded to the machine, we would rather have it running Linux.  Is it
> possible to patch IRIX's kernel, or should we go with Linux?  There is a
> version of Linux compiled for the Challenge XL, although its not exactly
> one that is in "active development".

SE Linux is not going to apply to other OSs without a lot of work.  I suspect 
that the IRIX kernel may have more in common with FreeBSD than Linux and 
therefore TrustedBSD may be of more use to someone wanting to get a hardened 
IRIX.  Of course this requires IRIX source code...

SE Linux could be ported to MIPS CPUs, and it shouldn't be that difficult.  
But it may be a lot easier to just buy a new Intel machine.  A quick google 
search suggests that we're talking about 8yo hardware, it shouldn't be 
difficult to buy a small cluster of Intel machines to deliver greater 
performance (which will probably cost you less than paying someone to port SE 
Linux to MIPS).

If the Linux port to that hardware is not actively maintained then that will 
be another problem for you in getting SE Linux to work.  No-one is doing much 
serious work on back-porting patches to older kernels.  In my Debian package 
I include some older patches (because they may be useful to someone and I 
don't bother deleting them in a hurry).  But I don't go that far and I rarely 
back-port patches.

It sounds like you would have to do some coding to get a recent 2.4.x kernel 
running on that hardware and then port SE Linux to MIPS.  Porting SE Linux is 
probably the easy task...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
