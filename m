Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA16956
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:21:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA18792
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:21:08 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id XAA18788
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 23:21:08 GMT
Date: Thu, 11 Jan 2001 17:21:41 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101112321.RAA86832@tomcat.admin.navo.hpc.mil>
To: ak@suse.de, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Subject: Re: [selinux] Re: SELinux and covert channels
Cc: ak@suse.de, Bennett Todd <bet@rahul.net>,
        =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
        selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

---------  Received message begins Here  ---------

> 
> On Thu, Jan 11, 2001 at 01:24:10PM -0600, Jesse Pollard wrote:
> > > > Today, I'd say most software engineers familiar with the problem
> > > > consider the gyrations required to close all covert channels to be
> > > > too painful, and so design systems where preventing covert channels
> > > > is not a security requirement.
> > > 
> > > Especially since it is very cheap now to buy just two PCs.
> > 
> > But it is not cheap to buy two (or more) beowulf clusters...
> > or two 8/16/32 CPU SMP systems...
> 
> When you need to flush caches on context switch then beowulf gets completely
> useless. Only way would be to partition them (half the cluster for this,
> half the cluster for that) 

It shouldn't happen on EVERY context switch - that would show that the
system is overloaded, in which case you will flush context anyway. If the
switch is from userA to kernel to userA, there should be no flush. It is
still a context switch. If it is from userA process1, to userA process2
(both with the same security labels) again, the flush wouldn't be necessary.

Only when the switch ALSO switches the current security label would it be
necessary to force a cache flush.

The case of a Beowulf cluster is (nearly) equivalent to a Cray T3. When
a job starts in the system, the scheduler allocates 5-100 processors. While
that job is using them, cache flushes are at a minimum. A second job can
start using another 5-100 processors. Both jobs may be in the system, but
with two different security labels (and on different processors).

I already use a system that does this. All Cray T3's use MLS - they have
to. No choice - if MLS is turned off, then nearly ALL security controls
are gone.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
