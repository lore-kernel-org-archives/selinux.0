Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6JGUVgA007923
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 12:30:32 -0400 (EDT)
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6JGPTZb022908
	for <selinux@tycho.nsa.gov>; Tue, 19 Jul 2005 16:25:30 GMT
Message-ID: <36282A1733C57546BE392885C0618592AF2836@chaos.tcs.tcs-sec.com>
From: Chad Hanson <chanson@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: RE: init running at s9 by default on a MLS system?
Date: Tue, 19 Jul 2005 12:28:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Paul,

I would agree the disk partitions should be at s9. The init process should
probably be at s0. We need to work on providing more updates for this
policy.

-Chad

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Friday, July 15, 2005 12:03 PM
> To: selinux@tycho.nsa.gov
> Subject: init running at s9 by default on a MLS system?
> 
> 
> Hello,
> 
> I have been playing with Dan Walsh's MLS policy RPM on Fedora Rawhide 
> and I noticed on the later versions that init is running at level s9 
> which appears to be causing some problems.  The particular issue I am 
> dealing with right now is when fsck (as run from 
> /etc/rc.d/rc.sysinit) 
> tries to check all of the filesystems in /etc/fstab.  The 
> problem lies 
> in the fact that the disk partitions in /dev are all labeled 
> at s0 and 
> fsck is trying to open them with write access.  Needless to say the 
> policy is correct for the strict policy but as soon as you 
> introduce the 
> different levels you run into problems.
> 
> My question is this: should init be running at s9 and if so should we 
> relabel the partitions to be at s9 as well?
> 
> -- 
> . paul moore . . . . . . . . . . . . . . . . . . . . . . . . 
> . . . . . .
> . paul.moore@hp.com                                      
> hewlett packard
> . (603) 884-5056                                          
> linux security
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
