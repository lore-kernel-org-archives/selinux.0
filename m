Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11294
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 16:45:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBELjTI15879
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 21:45:29 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBELjRf15875 for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 21:45:28 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: new Debian packages
Date: Sat, 14 Dec 2002 22:45:15 +0100
Cc: selinux@tycho.nsa.gov
References: <20021213223108.GA5424@lyta.coker.com.au> <20021214004206.D22479@lemuria.org> <20021214005331.GG13385@snoopy.apana.org.au>
In-Reply-To: <20021214005331.GG13385@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <200212142245.15413.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 14 Dec 2002 01:53, Brian May wrote:
> On Sat, Dec 14, 2002 at 12:42:07AM +0100, Tom wrote:
> > I'll be testing this next week. Any new kernels from Brian that I could
> > give a shakedown while I'm at it? (I've hosed my test machine again.
> > Must remember to be more careful. Will probably write a new chapter
> > into my "things not to do with SELinux" paper. :) )
>
> The latest patch I have, at the usual place, is for the 2.4.19
> kernel.
>
> It has at least one know security bug fixed in the kernel, plus lots
> of patches I need from time to time (eg. EVMS, ACL, SE-Linux, FreeS/WAN,
> DOV).

That'll keep you busy!

I've given up on EVMS as Linus is not accepting the full EVMS thing and they 
have been forced to radically change their plans.  As this happened before I 
got around to doing anything serious with EVMS I decided to skip it until 
it's all settled down.

FreeS/WAN is in a similar situation, it's never going into the main kernel 
tree and there's already a replacement for 2.6.

I've been thinking that it may be time to start moving some of my machines to 
2.5.x.  I think that 2.5.x development has slowed down enough for me to port 
the LSM patches between kernels.

I'm just looking at 2.5 now.  It appears to have IPSec, it has device-mapper 
(not sure if this means LVM2 is in), it has ACLs, and lots of other nice 
things such as CryptoAPI.

Maybe next time I run SE play machines I'll run one on a 2.4.x kernel and one 
on 2.5.x (Sun gave me a RaQ to use for this sort of thing - thanks Sun).

> I am not sure if there are version of these patches that will work
> with 2.4.20 yet, that is something I need to investigate (DOV at least
> is suppost to have been integrated into the kernel by now).

What is DOV?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
