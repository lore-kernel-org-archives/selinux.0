Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15376
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:24:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA20209
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:22:53 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA20205
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:22:52 GMT
Date: Thu, 11 Jan 2001 13:24:10 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101111924.NAA77275@tomcat.admin.navo.hpc.mil>
To: ak@suse.de, Bennett Todd <bet@rahul.net>
Subject: Re: [selinux] Re: SELinux and covert channels
Cc: =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
        Andi Kleen <ak@suse.de>, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Andi Kleen <ak@suse.de>:
> On Thu, Jan 11, 2001 at 09:38:18AM -0500, Bennett Todd wrote:
> > If you really want to block all covert channels, you end up
> > designing an OS on the same basis that cryppies design protocols
> > to thwart traffic analysis: you pad all resource utilization to
> > constant values with dummy load-inflictors, while imposing soft
> > limits that are hard to accurately discern. And even this is
> > very hard to get right: you end up having to define ceilings on
> > permitted utilization, and then you have to prevent the sender from
> > communicating covertly with the receiver by intermittently pushing
> > the system against those limits.
> 
> 
> Another thing is that it plugging all channels would require flushing
> CPU caches on all context switches (I believe some secure version of SCO
> does that). It would kill all performance.
> 
> I think with a virtual machine like vmware or plex86 you could do a reasonably
> job at separating, at the cost of burning some CPU when you also add a 
> virtual clock.  
> 
> > 
> > Lessee, besides load average, other bounded and so exhaustable, as
> > well as modulatable, resources would include pids, network ports,
> > and disk space.
> 
> Separating these is not very hard and has been already done. 
> 
> Unfortunately there are many more such things. 
> 
> 
> > 
> > Today, I'd say most software engineers familiar with the problem
> > consider the gyrations required to close all covert channels to be
> > too painful, and so design systems where preventing covert channels
> > is not a security requirement.
> 
> Especially since it is very cheap now to buy just two PCs.

But it is not cheap to buy two (or more) beowulf clusters...
or two 8/16/32 CPU SMP systems...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
