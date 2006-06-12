Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CIrWsV012426
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 14:53:32 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CIrVOr025104
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 18:53:31 GMT
Date: Mon, 12 Jun 2006 14:53:29 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>
Subject: Re: [RFC] [SELXFRM 0/4] SELinux/MLS enhancements to IPSec
In-Reply-To: <36282A1733C57546BE392885C0618592012D626D@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0606121447380.28542@d.namei>
References: <36282A1733C57546BE392885C0618592012D626D@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 10 Jun 2006, Venkat Yekkirala wrote:

> This patch set adds/enhances support for SELinux/MLS in handling IPSec
> xfrm's. It builds on the work by Trent Jaeger, et al, on the labeling of
> IPSec SAs. A policy patch is also included for reference. Patch is relative
> to the lspp.34 kernel (http://people.redhat.com/sgrubb/files/lspp).
> ipsec-tools 0.6.5 src in FC rawhide already has the setkey changes needed to
> work with this. A patch to ipsec-tools/racoon will follow later on the
> ipsec-tools-devel list.

These patches appear to have been wrapped by your mailer and are not 
suitable for review.  They need to be against an upstream kernel if you 
want them applied there.

Also, we need a clear and concise description of exactly what these 
patches do and their justificiation for inclusion in the upstream kernel.  
This needs to be in language that the core network and kernel maintainers 
can understand, and is the first paragraph they read as a summary (with 
details following below, which they might need/want to skip).  The subject 
line of the email also needs to be more specific, this is very vague.

Currently, I'm not sure what these patches are even about.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
