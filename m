Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47Hj6I4011315
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 13:45:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h47HipVf021605
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 17:44:51 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h47HiO4D021578
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 17:44:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Nick Gray <nagray@austin.rr.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: SELinux and LFS
Date: Thu, 8 May 2003 03:43:11 +1000
References: <1052323369.1487.46.camel@celestial>
In-Reply-To: <1052323369.1487.46.camel@celestial>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305080343.11969.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 8 May 2003 02:02, Nick Gray wrote:
> I raise a question, within our group, about the viability of using
> RedHat as a base for a secure system. I believe that certification of a

Considered Debian?

> system based on a (almost any) distribution would be rather difficult to
> achieve. This coupled with the fact that a Redhat server that was under
> scrutiny here at the lab, continued to contact Redhat via HTTPS despite
> my efforts to remove the software responsible. I actually found circular
> dependencies in the packages.

Debian has no such "features", and is in a fairly good state with regard to 
circular dependencies.

For building a Debian system from source there are some dependency issues.  
For example you can't build packages in a regular fashion without Perl, and 
Perl needs a huge number of other things to be built before it can be built.  
Doing a cross-compile bootstrap of Debian will be painful because of this.  
But recompiling every package in a Debian system should be quite easy (on 
i486 and newer CPUs at least).

> which I have been playing with for the last couple of weeks called
> appropriately enough "Linux from Scratch" so far I have been able to use

Some people on this list have been talking about getting SE Linux going with 
Gentoo which is based on compiling everything.  I wonder how their progress 
is going.

> LFS as the starting point for a CDROM based Linux gateway/firewall.I
> started a build of SELinux on a LFS system, but had several problems
> including discovering what I believe are a couple bugs in the code.I

Which code do you suspect to contain bugs?  SE code or LFS?

> In the next day or so I will post the problem I found in the makefile.
> Perhaps it is either a known issue or doesn't come up on Redhat based
> systems. In a separate post I will address a problem I found in string.h
> (as soon as I get a chance to figure out what the problem is)

What version of libc6 was used for the headers?  Some of my programs used to 
have problems with older libc6 header files for string.h and other things.

> Don't get me wrong, I have nothing against Redhat. I'm just not sure
> that I could keep a straight face when placing this in front of the
> accreditors.

If there is anything I can do to make Debian more suitable for such things 
then please let me know.  Subject to the constraint of having almost no free 
time I'll do what I can.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
