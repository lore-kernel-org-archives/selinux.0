Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01822
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 12:52:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA07139
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:51:32 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA07129
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 17:51:31 GMT
Message-ID: <3A5CA144.A7EEFA56@sgi.com>
Date: Wed, 10 Jan 2001 09:52:04 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: open-source@csl.sri.com
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Ros: Re: enhanced security for Linux, from Stephen Smalley
References: <DBF2F9C6F6BAD211BB1B00A0C99D970233AD5D@dns-205.dhcp-77.nai.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

"Badger, Lee" wrote:
> 
> Casey,
> 
> I have to strongly disagree.
> 
> > Unfortunately, I see no way that the industry can take
> > advantage of it. We've been pushing B1 (now LSPP) as the
> > ultimate COTS security solution since the late 1980's
> > and we're not going to drop that investment any time
> 
> As one of the creators of Domain and Type Enforcement (DTE), I have to
> tell you that type enforcement is pretty different from MLS.

Which is my point. We have been selling MLS. We will continue
selling MLS. New technology, even if it's better, will take
some time to develop in the marketplace.

> ... It can support Biba ...

So does Trix. So will MLS Linux.

> ... It can support notions such as controlled execution.

Ever look at UNICOS PALs ?

> These are all capabilities that are natural for Security-Enhanced
> Linux (SELinux), and that are very important for commercial
> applications, but which are difficult, at best, with B1-like systems.

These are things that MLS systems can do. I dispute your
conclusion. I have customers doing many of these things,
as well as other clever configurations.

> The confidentiality lattice just wasn't designed with these things in
> mind.

The confidentiality lattice is to system security what
Froot Loops are to a nutritious breakfast.

> I see many ways that industry can use these capabilities.  Just
> consider any web farm.  Any 24x7 server.  Any organization that uses
> servers that could be penetrated externally (e.g., the buffer overflow
> attacks documented by CERT).

All applications to which a system with MLS and least privilege
can and have been applied.

> SELinux can and should also be applied
> within organizations.  Firewall perimeters are getting weaker, and
> there is an increased need to harden all host systems.  The label
> lattice of the orange book doesn't help much there, but a system like
> SELinux provides a very appropriate set of tools for applying access
> controls so as to appropriately harden interior systems.

The Orange Book lattice is perfect for hardening interior systems.
Our biggest Trix customers use the system for that purpose.

> > throw that away, even for a vastly superior technology
> > (Hey! I *AM* Dilbert's Boss!) which DE does not appear
> > to be.
> 
> I would not claim superiority for SELinux in the area of
> confidentiality or in the area of general assurance.

OKay.

> But for
> integrity and flexibility and the ability to support confinement
> policies of interest to commercial customers (i.e., like confining
> those CGI scripts), SELinux provides a _much_ more useful set of tools
> than Orange Book systems.

I believe your claim to be unfounded. Your example of confining
CGI scripts can be addressed with B&LaP, Biba, or both. I question
your claim that the "tools" available are superior. Certainly
the industry experiance with MLS systems has created a knowledge
base of problem solutions far in excess of what exists for DE.

> For these kinds of problems, SELinux
> deserves a close look.  It has different goals from those of the
> Orange Book, and is not an equivalent to B1.

Which, again, was my point. Beware the notion that B1 can't
solve the problems DE can, and that DE will be accepted where
B1 wasn't. MLS system are gaining acceptance. Thus we work
toward MLS in Linux. As a vendor I'm out to sell systems. If
there were evidence that DE would outsell MLS I'd be happy
to jump on the bandwagon.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
