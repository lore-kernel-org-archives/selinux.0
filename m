Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00863
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:26:41 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA29736
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:26:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id QAA29728
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 16:26:39 GMT
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA11196
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2001 11:26:37 -0500 (EST)
Date: Tue, 13 Mar 2001 11:26:37 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200103131626.LAA05834@coalstack.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Re: How is 2.4.x progressing?
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Jonathan Day wrote:
>    Long time, no post. Thought I'd drop a note and ask how the port to
> Linux 2.4.x was progressing. 

The port to 2.4.2 is mostly done. We are going to post it on the
website soon. 

> Also, wondering if SE Linux made any use of
> the International Patch, if installed. (SE Linux might not use crypto,
> but I'd be amazed if it never used secure hash functions.)

No, the International Patch is not currently used.  SELinux focuses on
the addition of mandatory access controls, and crypto is not needed to
support it. Cryptography is, however, needed as part of the total
system security picture.  We plan on integrating the SELinux's MAC
controls with cryptography (ref my message for Feb 9 on Crypto FS).

> 
>    Also, to go back to the IPSec question, NIST's Cerberus IPSec was/is
> either funded by, or partially developed by the NSA, if I'm reading the
> documents rightly. However, it was said (more than once) on this list
> that SE Linux will -probably- use FreeSWAN. My question here is not
> whether that is technically the right decision (FreeSWAN is evolving,
> Cerberus is stagnating), but whether the SE Linux core team is going to
> be free to make it. I could just be over-anxious, here, but I don't know
> of many PHB's who will pay to develop one product, and then use a
> "competitors". Any reassurance on this would be greatfully received.
> 

We really do have the freedom to choose. We can make what we think is
the right choice for the goals of SELinux. That choice will largely be
driven by the need to select a widely-available platform on which to to
demonstrate the integration of MAC controls. Although we haven't set it
in stone, that choice is likely to be FreeSWAN.  It is not all that odd
that we would support Cerberus yet use FreeSwan.  Cerberus was done for
research and demonstration purposes.

--
Pete Loscocco, NSA
pal@tycho.ncsc.mil

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
