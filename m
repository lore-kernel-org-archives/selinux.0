Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JNOirT014228
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 19:24:44 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JNOiNX013149
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 23:24:44 GMT
Message-ID: <414E153B.7070805@gentoo.org>
Date: Sun, 19 Sep 2004 19:24:43 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Colin Walters <walters@verbum.org>
CC: selinux@tycho.nsa.gov, Chris PeBenito <pebenito@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
References: <414DA0A7.1000708@gentoo.org> <1095631736.4431.27.camel@nexus.verbum.private>
In-Reply-To: <1095631736.4431.27.camel@nexus.verbum.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Sun, 2004-09-19 at 11:07 -0400, Joshua Brindle wrote:
>
>  
>
>>The current upstream policy is a compositite of most changes made by 
>>distros and policy writers who may have different philosophies about
>>how the policy should work.
>>    
>>
>
>Agreed, but we should take care in divergence; the upstream maintainers
>have a lot of experience here, and the current policy serves as a strong
>reference point.  I think Stephen's pointed out bugs in patches from
>pretty much everyone...
>
>  
>
Obviosly, and bouncing questions/ideas off of them are important but 
they won't be around to monitor every policy patch forever. Further, 
I'll agree that the upstream policy serves as a 'comprehensive' 
reference but that policy (the sample policy) was (AFAIK) never meant to 
be used in production, and is useful for making systems work much more 
than making systems analyzably secure.

The divergence is not the problem, if divergence wasn't good then most 
applications wouldn't exist today. There is no compelling need for every 
vendor to shoehorn their policy into the sample, adding bloat and 
causing it's analyzability to go down. Policies whose goals are 
fundamentally different shouldn't have to be combined in an awkward way. 
The solution is to make a central repository for vendors to share their 
policies.

>>One example is our sysadmfile trim which happened a few weeks ago.
>>    
>>
>
>Maybe it's just me, but I wasn't all that convinced by Chris' arguments.
>For accidental damage, it seems better to encourage people to do as much
>as possible as staff_r.  As for malicious programs, I think if you've
>run any malicious program as sysadm_r you're pretty much hosed.
>
>  
>
Thats fine, you need not be convinced, we are going for a more secure 
policy rather than a more userfriendly policy. Every additional 
restriction on sysadm_t means better security. This is our policy goal 
and clearly not yours, showing exactly what the problem is.

>How else does the Gentoo policy differ from the NSA example policy?
>
>  
>
I'll leave this for Chris to answer

>>If there are any other suggestions or comments on this I'd like to hear 
>>them. Obviously the implementation details are up in the air here, and I 
>>know that some of you can't/won't use bk. 
>>    
>>
>
>Right, "can't" is the operative word here, at least for me.  The
>Bitkeeper license prohibits people who work on a competing system from
>using the gratis version of Bitkeeper.
>
>  
>
I figured that might be a problem for someone

>>If there are suggestions for a 
>>  better system and a way to host it (preferably neutrally) that would 
>>be great.
>>    
>>
>
>If you are set on this, I suggest GNU Arch.  It is actually better than
>Bitkeeper in a number of ways (besides the obvious one of licensing);
>for example, it supports cherry-picking (applying individual
>changesets), and doesn't require anything other than an unmodified web
>server for read access. 
>
>As for hosting, unfortunately Sourceforge doesn't support anything
>except CVS.  There is sourcecontrol.net, sort of like the Arch
>equivalent of bkbits.net.
>
>
>  
>
cool, will definately look at this

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
