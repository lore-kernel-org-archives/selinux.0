Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA15961
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:21:41 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA23034
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:20:14 GMT
Received: from Cantor.suse.de (Cantor.suse.de [194.112.123.193])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA23030
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:20:13 GMT
Date: Thu, 11 Jan 2001 21:21:33 +0100
From: Andi Kleen <ak@suse.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: ak@suse.de, Bennett Todd <bet@rahul.net>,
        =?iso-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
        selinux@tycho.nsa.gov
Subject: Re: [selinux] Re: SELinux and covert channels
Message-ID: <20010111212133.A6902@gruyere.muc.suse.de>
References: <200101111924.NAA77275@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200101111924.NAA77275@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Thu, Jan 11, 2001 at 01:24:10PM -0600
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Jan 11, 2001 at 01:24:10PM -0600, Jesse Pollard wrote:
> > > Today, I'd say most software engineers familiar with the problem
> > > consider the gyrations required to close all covert channels to be
> > > too painful, and so design systems where preventing covert channels
> > > is not a security requirement.
> > 
> > Especially since it is very cheap now to buy just two PCs.
> 
> But it is not cheap to buy two (or more) beowulf clusters...
> or two 8/16/32 CPU SMP systems...

When you need to flush caches on context switch then beowulf gets completely
useless. Only way would be to partition them (half the cluster for this,
half the cluster for that) 

-Andi


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
