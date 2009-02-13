Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1DMHK7E021680
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 17:17:20 -0500
Received: from trauma.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1DME2xb001377
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2009 22:14:02 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [refpolicy] [PATCH] refpolicy: Add missing network related MLSconstraints
Date: Fri, 13 Feb 2009 17:17:13 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15BA0238@HAVOC.tcs-sec.com>
References: <20090212211531.619341973@hp.com> <200902131544.42460.paul.moore@hp.com> <4995E83B.1040003@sun.com> <200902131702.10467.paul.moore@hp.com>
From: <chanson@TrustedCS.com>
To: <paul.moore@hp.com>, <Glenn.Faden@sun.com>
Cc: <refpolicy@oss.tresys.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

You are correct, we want to keep the existing overrides, but not provide
anymore overrides. The network interface / node checking rope should be
very short. The few exceptions of unlabeled_t or kernel_t. kernel_t was
necessary for nfs awhile back (may not be necessary now), probably
iSCSI, or basically things where the kernel is generating the packet
instead of a process and not assuming other credentials.  

-Chad

> 
> > In Solaris Trusted Extensions, neither the net_mac_read, 
> > net_mac_write, nor net_repy_equal privileges are 
> implemented. It was 
> > viewed as a weakness in Trusted Solaris that MAC could be 
> overridden by privilege.
> > Instead, the administrator (who configures the system 
> network policy) 
> > can enumerate multilevel network ports, and appropriately 
> privileged 
> > services can bind to them.
> 
> I assume by multilevel network ports you are talking about 
> port polyinstantiation and not a single (in every sense of 
> the word) port that allows a range of labels?
> 
> If we assume polyports then I agree that it makes perfect 
> sense to try and work around the MLS constraints.  I wonder 
> about some privileged apps but I would need to think about 
> that some more.
> 
> > Since MLS constraints are relatively new to UNIX, there isn't a 
> > compatibility requirement that the superuser should be able to 
> > override it. So don't provide any more rope than you need to.
> 
> Well, the MLS constraints aren't all that new to SELinux and 
> several already exist in the networking space (the patch 
> above didn't create any new ones, just used the existing 
> constraints).  As I understand it, the SELinux constraints 
> are also quite different from the TSOL/TX privileges; I'll 
> concede that they are both rope, but I think the lengths are 
> quite different ;)
> 
> Perhaps I'm missing something but I'm pretty sure that 
> without any form of polyports (I highly doubt we will see 
> these anytime soon) we are going to need/want network MLS 
> constraint overrides.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
