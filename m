Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9NLRVAF007511
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 17:27:31 -0400
Received: from asmtpout024.mac.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9NLQbr7011553
	for <selinux@tycho.nsa.gov>; Fri, 23 Oct 2009 21:26:37 GMT
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Received: from falmouth.jbj.org
 (cpe-069-134-024-120.nc.res.rr.com [69.134.24.120])
 by asmtp024.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KRZ00HW4KXQV010@asmtp024.mac.com> for
 selinux@tycho.nsa.gov; Fri, 23 Oct 2009 14:27:29 -0700 (PDT)
Subject: Re: RPM support for SELinux
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <4AE1AE02.6070702@manicmethod.com>
Date: Fri, 23 Oct 2009 17:27:26 -0400
Cc: Chad Sellers <csellers@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Message-id: <D61F5B71-5D0C-4250-A3C1-36700B6877B2@mac.com>
References: <C7061E9C.AB85E%csellers@tresys.com>
 <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com>
 <4AE0AE8C.8000801@manicmethod.com>
 <41960C97-411F-4D37-9F71-9EE3AADEE8CF@mac.com>
 <4AE1AE02.6070702@manicmethod.com>
To: Joshua Brindle <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 23, 2009, at 9:22 AM, Joshua Brindle wrote:
>
> That is not the purpose of this patchset, and it was never claimed  
> to be the purpose of this patchset.
>
> The purpose of this patchset is to start integrating policy support  
> into RPM, and for RPM to remain completely trusted. I did say that  
> we have an ultimate goal of breaking RPM up into pieces so we could  
> remove trust from the main parts, and to eventually be able to run  
> RPM in different security domains depending on different aspects of  
> the RPM (where it came from, who signed it, who is running RPM, etc)  
> but that is not something this patch set can accomplish and indeed  
> is a long term goal.
>
> We can't very well go off for a long time and come back with a  
> patchset that completely changes the architecture of RPM, we are  
> doing this development in the open and therefore each individual  
> patch set along the way brings us closer, it doesn't completely  
> solve the problem.
>

No you can't. Nor can you wander around making contradictory statements
about what you intend publically.

So now the goal is "completely change the architecture of RPM" without
any statement of purpose (other than that you think the change is  
needed)
and you claim to be doing development in the open.

If you stated your goals more clearly, with perhaps an illustration of
what you think needs doing, you might find better acceptance.

Each individual patch set I've seen is currently appearing, to somewhat
negative comments not just from me, and then you wander off
to re-appear with essentially the same patch set with almost exactly
the same issues (like the opaqueness of bz2 blobs embedded
in rpm headers, and the size of the unnormalized uncompressed
policy data, and the difficulties of executing helpers in empty
chroot's). Go read the comments, the issues were pointed out not just  
by me.

Could you please state your goals more clearly so that a developer
might understand the reasoning behind an end-point that seems to  
include "completely changes
the architecture of RPM" as an end-point (or why did you bother  
mentioning).

Otherwise, piecemeal patching (as in the current patch set) closely  
followed
by claims that you are going to move to "hi-level compilers to install  
policy"
(my paraphrase from memory) seems more like a randopm walk than  
anything else.

73 de Jeff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
