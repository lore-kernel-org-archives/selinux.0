Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA00161
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 10:46:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA01221
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 15:45:20 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA01216
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2001 15:45:19 GMT
Date: Wed, 10 Jan 2001 10:44:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Johnathon Day <jcday@mail.thesportsregister.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Security enhancements, et al
In-Reply-To: <Pine.LNX.4.21.0101100924010.5905-100000@mail.thesportsregister.com>
Message-ID: <Pine.SOL.3.95.1010110102657.16290J-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Wed, 10 Jan 2001, Johnathon Day wrote:

>    First off, a quick question. Is there any code in SGI's Open B1 release
> that could be sensibly utilised in SELinux? (I've not gone right the way
> through OB1, but it seems silly to have a comprehensive resource just
> sitting there. On the other hand, if SELinux covers everything of interest
> in OB1 and/or the effort of writing from specs would be easier than a port
> then trying to force chunks of OB1 into SELinux would be stupid beyond
> belief.)

SELinux does not cover everything of interest in the SGI B1 sample
source code, since SELinux only addresses flexible mandatory access
controls.  It would be great if we could leverage SGI's B1 sample source
code for other aspects of the system such as auditing.  However, I'm not
sure how feasible that will be, since the sample code was extracted from
Trusted IRIX and since SELinux is seeking to provide a flexible
operating system security architecture that is more general than what
is defined by the TCSEC or the LSPP.  We haven't examined the OB1 code to
assess whether we might be able to use some of it.

>    Secondly, I've not seen a mention of SELinux on Freshmeat. The Slashdot
> article probably did wonders for interest, but Freshmeat is a great tool
> for maintaining the momentum. It'd be "better" if one of the core team
> could post it, but that's an implementation issue. Getting it posted is
> the main thing.

This is a good idea, and should probably be done by the NSA
project leader.

>    Lastly, the reply to my question on IPSEC wasn't terribly clear. (But
> that might just have been me.) I couldn't figure out if SELinux will have
> it's own IPSEC implementation or a 3rd-party one. And, if 3rd-party, who.
> The "Open Source" IPSECs I know of are: NIST (Linux), FreeS/WAN (Linux),
> CISCO (BSD), MIT (BSD) and DOD (BSD). There are bound to be others. This
> is not exhaustive. It'd be possible for SELinux to fork off any of these,
> with various levels of effort, or to merge in diffs to support the SELinux
> API.

Sorry if I was vague.  The plan is to use a third-party Linux IPSEC
implementation and modify it as needed.  My expectation is that we will
use FreeS/WAN, but that isn't written in stone.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
