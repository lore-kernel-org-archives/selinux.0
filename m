Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11755
	for <selinux@tycho.nsa.gov>; Mon, 1 Jan 2001 11:17:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA06462
	for <selinux@tycho.nsa.gov>; Mon, 1 Jan 2001 16:17:00 GMT
Received: from mail.thesportsregister.com (mail.thesportsregister.com [208.53.250.138])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA06458
	for <selinux@tycho.nsa.gov>; Mon, 1 Jan 2001 16:16:59 GMT
Received: from localhost (localhost [127.0.0.1])
	by mail.thesportsregister.com (Postfix) with ESMTP id E8460FCD2
	for <selinux@tycho.nsa.gov>; Mon,  1 Jan 2001 11:19:39 -0500 (EST)
Date: Mon, 1 Jan 2001 11:19:39 -0500 (EST)
From: Johnathon Day <jcday@mail.thesportsregister.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: porting to 2.4?
In-Reply-To: <Pine.SOL.3.95.1001229100358.9554B-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.21.0101011054260.7964-100000@mail.thesportsregister.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Fri, 29 Dec 2000, Stephen Smalley wrote:
> We haven't started a port to the 2.4 kernel yet, other than
> some preliminary analysis of the differences between 2.2 and
> 2.4 by a relatively new member of the NSA SELinux team.  His 
> assessment was that a port could be quite involved due to the extent
> of changes between 2.2 and 2.4, but I'm not sure how significant
> those changes are for our modifications.  In addition to porting
> our existing changes, we would want to address new features in the
> 2.4 kernel.  Since we have a small development team, we have to
> carefully balance between porting what we have to newer kernel versions
> and doing further security development.  If you are interested in
> assisting in a port to the 2.4 kernel, let us know.  

I'm playing around with 2.4, so can help some with the port.

I'd have thought that the port should be -relatively- unaffected by the
changes, as it's (by design) orthogonal to other related features.

Therefore, the changes -should- be limited to only those components that
call the API of the rest of the kernel. (Side-effects should be minimal to
non-existant, so the problem should be confined to one of interface
changes.)

The first step in solving a problem is to define its scope as narrowly as
possible and no narrower. But all this is "obvious" stuff, and nothing
new to any programmer. It's only purpose is to offer a slightly less
intimidating perspective on the 2.2se->2.4se port.

On a different note, will the SELinux project use its own IPSec
implementation, or collaborate with FreeS/WAN? Also, will any encryption
code be able to use the International Patches as plug-ins? (It would seem
stupid if everyone on the planet plugged in their own 3DES patch into the
kernel. We only need one copy of any algorithm, but at the moment, we have
algorithms in mcrypt/mhash, the international patches, ENSkip, FreeS/WAN,
and a partridge in a pear tree.)

Jonathan


You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
