Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8K05rrT014478
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 20:05:53 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8K04t2w002845
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 00:04:55 GMT
Subject: Re: [RFC] Upstream policy handling
From: Colin Walters <walters@verbum.org>
To: Joshua Brindle <method@gentoo.org>
Cc: selinux@tycho.nsa.gov, Chris PeBenito <pebenito@gentoo.org>
In-Reply-To: <414E153B.7070805@gentoo.org>
References: <414DA0A7.1000708@gentoo.org>
	 <1095631736.4431.27.camel@nexus.verbum.private>
	 <414E153B.7070805@gentoo.org>
Content-Type: text/plain
Date: Sun, 19 Sep 2004 20:07:21 -0400
Message-Id: <1095638841.4431.87.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-09-19 at 19:24 -0400, Joshua Brindle wrote:

> Obviosly, and bouncing questions/ideas off of them are important but 
> they won't be around to monitor every policy patch forever. 

I don't know what we'd do without them though...

> Further, 
> I'll agree that the upstream policy serves as a 'comprehensive' 
> reference but that policy (the sample policy) was (AFAIK) never meant to 
> be used in production, 

I think the NSA was more saying that the sample policy is just that, a
sample.  I don't think they were implying you'd be crazy to run it in
production.

> and is useful for making systems work much more 
> than making systems analyzably secure.

I wouldn't really agree with this, particularly since we now have the
targeted policy.  The direction of the sample strict policy has been
returning to lesser privilege.

> The divergence is not the problem, if divergence wasn't good then most 
> applications wouldn't exist today.

Divergence here should be justified well, since it can have a large
effect on system security.

>  There is no compelling need for every 
> vendor to shoehorn their policy into the sample, adding bloat and 
> causing it's analyzability to go down.
>  Policies whose goals are 
> fundamentally different shouldn't have to be combined in an awkward way. 

I'm guessing what you're indirectly referring to is all the (tunable)
weakening that happened to the sample strict policy when Fedora was
first trying to integrate SELinux.  Again, now that we have the targeted
policy things are going back; Dan just asked for the removal of
unlimitedUsers for example.

If this is the problem, I think it's already been solved.

> >Maybe it's just me, but I wasn't all that convinced by Chris' arguments.
> >For accidental damage, it seems better to encourage people to do as much
> >as possible as staff_r.  As for malicious programs, I think if you've
> >run any malicious program as sysadm_r you're pretty much hosed.
> >
> >  
> >
> Thats fine, you need not be convinced, we are going for a more secure 
> policy rather than a more userfriendly policy. Every additional 
> restriction on sysadm_t means better security. 

This feels like handwaving.  sysadm_t is a special domain since it can
circumvent system security in many ways.  Not that restricting it isn't
useful, but the only justification I recall for e.g. preventing sysadm_t
from accessing device files was preventing accidental damage (i.e.
reliability), not security.

> This is our policy goal 
> and clearly not yours, showing exactly what the problem is.

I think we share the goal of security; I'd just like to see better
justification for some of these changes.

In particular I think our time is much better spent on adding policy for
more daemons, tightening the existing ones, and modifying programs to
make them SELinux-aware, rather than adding a few more relatively
trivial restrictions on sysadm_t.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
