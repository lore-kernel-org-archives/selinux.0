Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13883
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:02:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA00959
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:01:41 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA00955
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:01:39 GMT
Date: Thu, 11 Jan 2001 18:02:11 +0100
From: Andi Kleen <ak@suse.de>
To: Bennett Todd <bet@rahul.net>
Cc: =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
        Andi Kleen <ak@suse.de>, selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: SELinux and covert channels
Message-ID: <20010111180211.A2080@gruyere.muc.suse.de>
References: <A0669F3E0A6B3448A962DC6141E6C7A614415C@mis1> <20010110192931.A3665@gruyere.muc.suse.de> <20010111005355.A20214@bunuel.tii.matav.hu> <20010111093818.X21255@rahul.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010111093818.X21255@rahul.net>; from bet@rahul.net on Thu, Jan 11, 2001 at 09:38:18AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Jan 11, 2001 at 09:38:18AM -0500, Bennett Todd wrote:
> If you really want to block all covert channels, you end up
> designing an OS on the same basis that cryppies design protocols
> to thwart traffic analysis: you pad all resource utilization to
> constant values with dummy load-inflictors, while imposing soft
> limits that are hard to accurately discern. And even this is
> very hard to get right: you end up having to define ceilings on
> permitted utilization, and then you have to prevent the sender from
> communicating covertly with the receiver by intermittently pushing
> the system against those limits.


Another thing is that it plugging all channels would require flushing
CPU caches on all context switches (I believe some secure version of SCO
does that). It would kill all performance.

I think with a virtual machine like vmware or plex86 you could do a reasonably
job at separating, at the cost of burning some CPU when you also add a 
virtual clock.  

> 
> Lessee, besides load average, other bounded and so exhaustable, as
> well as modulatable, resources would include pids, network ports,
> and disk space.

Separating these is not very hard and has been already done. 

Unfortunately there are many more such things. 


> 
> Today, I'd say most software engineers familiar with the problem
> consider the gyrations required to close all covert channels to be
> too painful, and so design systems where preventing covert channels
> is not a security requirement.

Especially since it is very cheap now to buy just two PCs.


-Andi

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
