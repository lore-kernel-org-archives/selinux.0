Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JKkurT013639
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 16:46:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JKksNX010907
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 20:46:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: [RFC] Upstream policy handling
Date: Mon, 20 Sep 2004 06:46:51 +1000
Cc: selinux <selinux@tycho.nsa.gov>
References: <414DA0A7.1000708@gentoo.org>
In-Reply-To: <414DA0A7.1000708@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409200646.51865.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 20 Sep 2004 01:07, Joshua Brindle <method@gentoo.org> wrote:
> The current upstream policy is a compositite of most changes made by
> distros and policy writers who may have different philosophies about how
> the policy should work.

Not really.  The different philosophies are the ones that are totally 
unmergable.  One example was posted here about a year ago that didn't seem to 
have a single domain or type name in common with the NSA policy.

> One example is our sysadmfile trim which happened a few weeks ago. Chris
>   PeBenito suggested this on the list only to be scrutinized, we have

Scrutiny is good!  It's when code is not scrutinised that the quality drops.  
Open Source is about scrutiny of code.

> since gone ahead with the changes but based on the feedback here Chris
> felt it a moot point to post the changes. Recently it was suggested by
> another distro (though vetoed by Steve) to make sysadmfile even more
> accessible to non-admins. This illustrates the radical difference in
> policy philosophies.

No, it demonstrates that Steve knows what's going on, has a plan, and is 
making everyone stick to it.  Convince Steve and your patch goes in to the 
CVS!

> I feel that distro tunables are undesirable. They bloat the policy in
> unnecessary ways and just don't make sense to me. Downstream vendors
> often apply their own patches to applications, so Gentoo, Debian and
> Redhat would have patchsets for apps rather than the upstream app having
> #ifdef REDHAT ... #elif DEBIAN and so on. (Russel pointed out that some
> apps have this sort of thing in upstream but that doesn't make it
> correct ;) )

OK, try maintaining a separate Gentoo policy patch for another year or so and 
see if you still think that distribution specific tunables are a bad 
idea.  ;)

> Specifically I think it would be optimal to set up a policy repository
> at bkbits.net (yes, this is bitkeeper, yes I know about the license,
> will cover that later). In this repository there should be branches for
> each vendor, and the NSA. Obviously each vendor pushes their own policy
> changes into their branch. If the NSA and/or any other vendors like the

The problem is that vendors will introduce bad patches.  Without the 
requirement to get the policy checked off by Steve the quality will drop 
while the number of unmerged patches steadily increases.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
