Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i149pGRb010867
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 04:51:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i149pF1I003538
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:51:15 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i149pEbs003499 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:51:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Dave Gilbert (Home)" <gilbertd@treblig.org>
Subject: Re: Problems finding working kernel/user land combination
Date: Wed, 4 Feb 2004 20:49:32 +1100
Cc: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
References: <401FF280.8070301@treblig.org> <200402041216.54927.russell@coker.com.au> <4020BD63.3050004@treblig.org>
In-Reply-To: <4020BD63.3050004@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402042049.32842.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Feb 2004 20:37, "Dave Gilbert (Home)" <gilbertd@treblig.org> wrote:
> So am I OK applying the kernel-patch-2.4-oldlsm_2003.08.13-8 - should
> that work with Brians tools ?

That will work with the tools you have installed.  But it's probably better to 
just upgrade to the new SE Linux.  So install the new tools from the 
"unstable" part of Brian's repository.

> > But using 2.6.1 is probably easier.
>
> Indeed; while my own experiences with 2.6.1 on my home machine are
> mostly positive, I'm not really ready to trust its stability on an
> important machine.

Well you can use 2.4.x kernels with the new SE Linux.  But there are delays in 
getting things working when a new 2.4.x kernel comes out.  Also LSM conflicts 
with most other significant kernel patches, which limits what you can do.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
