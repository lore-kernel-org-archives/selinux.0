Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JM7grT014026
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 18:07:42 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JM7fNX012068
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 22:07:41 GMT
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by monk.area614.net (Postfix) with ESMTP id 1C03D41067B
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 18:07:48 -0400 (EDT)
Subject: Re: [RFC] Upstream policy handling
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
In-Reply-To: <414DA0A7.1000708@gentoo.org>
References: <414DA0A7.1000708@gentoo.org>
Content-Type: text/plain
Date: Sun, 19 Sep 2004 18:08:56 -0400
Message-Id: <1095631736.4431.27.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-09-19 at 11:07 -0400, Joshua Brindle wrote:

> The current upstream policy is a compositite of most changes made by 
> distros and policy writers who may have different philosophies about
> how the policy should work.

Agreed, but we should take care in divergence; the upstream maintainers
have a lot of experience here, and the current policy serves as a strong
reference point.  I think Stephen's pointed out bugs in patches from
pretty much everyone...

> One example is our sysadmfile trim which happened a few weeks ago.

Maybe it's just me, but I wasn't all that convinced by Chris' arguments.
For accidental damage, it seems better to encourage people to do as much
as possible as staff_r.  As for malicious programs, I think if you've
run any malicious program as sysadm_r you're pretty much hosed.

How else does the Gentoo policy differ from the NSA example policy?

> If there are any other suggestions or comments on this I'd like to hear 
> them. Obviously the implementation details are up in the air here, and I 
> know that some of you can't/won't use bk. 

Right, "can't" is the operative word here, at least for me.  The
Bitkeeper license prohibits people who work on a competing system from
using the gratis version of Bitkeeper.

> If there are suggestions for a 
>   better system and a way to host it (preferably neutrally) that would 
> be great.

If you are set on this, I suggest GNU Arch.  It is actually better than
Bitkeeper in a number of ways (besides the obvious one of licensing);
for example, it supports cherry-picking (applying individual
changesets), and doesn't require anything other than an unmodified web
server for read access. 

As for hosting, unfortunately Sourceforge doesn't support anything
except CVS.  There is sourcecontrol.net, sort of like the Arch
equivalent of bkbits.net.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
