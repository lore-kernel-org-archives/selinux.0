Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JLCVrT013814
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 17:12:31 -0400 (EDT)
Received: from sccrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JLCUNX011212
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 21:12:30 GMT
Message-ID: <414DF5F2.9030700@gentoo.org>
Date: Sun, 19 Sep 2004 17:11:14 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux <selinux@tycho.nsa.gov>,
   "pebe >> Chris PeBenito" <pebenito@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
References: <414DA0A7.1000708@gentoo.org> <200409200646.51865.russell@coker.com.au>
In-Reply-To: <200409200646.51865.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Mon, 20 Sep 2004 01:07, Joshua Brindle <method@gentoo.org> wrote:
>  
>
>>The current upstream policy is a compositite of most changes made by
>>distros and policy writers who may have different philosophies about how
>>the policy should work.
>>    
>>
>
>Not really.  The different philosophies are the ones that are totally 
>unmergable.  One example was posted here about a year ago that didn't seem to 
>have a single domain or type name in common with the NSA policy.
>
>  
>
Using different policy semantics (eg., not having seperate domain and 
file types) is not the same as having different philosophies. The 
philosophy differences I speak of are the differences between, for 
example, Redhat and Gentoo. It's no secret that Redhats primary goal is 
to make SELinux work in the system (and it's a noble goal). Gentoo's 
goal is to make the system secure, and if need be break legacy 
behaviour. These are radical differences.

>>One example is our sysadmfile trim which happened a few weeks ago. Chris
>>  PeBenito suggested this on the list only to be scrutinized, we have
>>    
>>
>
>Scrutiny is good!  It's when code is not scrutinised that the quality drops.  
>Open Source is about scrutiny of code.
>
>  
>
This sort of scrutity was an example of Redhat's vs. Gentoo's policy 
philosophy as above.

>>since gone ahead with the changes but based on the feedback here Chris
>>felt it a moot point to post the changes. Recently it was suggested by
>>another distro (though vetoed by Steve) to make sysadmfile even more
>>accessible to non-admins. This illustrates the radical difference in
>>policy philosophies.
>>    
>>
>
>No, it demonstrates that Steve knows what's going on, has a plan, and is 
>making everyone stick to it.  Convince Steve and your patch goes in to the 
>CVS!
>
>  
>
The Current CVS policy is heavily biased toward Redhat (and their 
SELinux goals). This leaves no room for others (such is why I'm 
suggesting this)

>>I feel that distro tunables are undesirable. They bloat the policy in
>>unnecessary ways and just don't make sense to me. Downstream vendors
>>often apply their own patches to applications, so Gentoo, Debian and
>>Redhat would have patchsets for apps rather than the upstream app having
>>#ifdef REDHAT ... #elif DEBIAN and so on. (Russel pointed out that some
>>apps have this sort of thing in upstream but that doesn't make it
>>correct ;) )
>>    
>>
>
>OK, try maintaining a separate Gentoo policy patch for another year or so and 
>see if you still think that distribution specific tunables are a bad 
>idea.  ;)
>
>  
>
PeBenito has maintained our policy for longer than that.  Distro 
tunables (and indeed many many of the current tunables) are 
fundamentally flawed.
Think about the difficulty of analyzing policy with X number of 
tunables. To do it properly you'd have to analyze X! permutations. Then 
take into account conditionals, and optional modules.

>>Specifically I think it would be optimal to set up a policy repository
>>at bkbits.net (yes, this is bitkeeper, yes I know about the license,
>>will cover that later). In this repository there should be branches for
>>each vendor, and the NSA. Obviously each vendor pushes their own policy
>>changes into their branch. If the NSA and/or any other vendors like the
>>    
>>
>
>The problem is that vendors will introduce bad patches.  Without the 
>requirement to get the policy checked off by Steve the quality will drop 
>while the number of unmerged patches steadily increases.
>
>  
>
eh? vendors would introduce bad patches to their own policy. Obviously 
this can already be done, I'm not sure what you are getting at here.
If vendors are concerned about their patches they'd still be able to 
post them to the list (also the changesets would be available at a 
specific central place for everyone so it would be far easier to see 
what people are doing to the policies, and the differences, etc)

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
