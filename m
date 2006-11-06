Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA6IU2hd007996
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 13:30:02 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA6ITHiG020719
	for <selinux@tycho.nsa.gov>; Mon, 6 Nov 2006 18:29:17 GMT
Subject: Re: rpmlint
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@gentoo.org>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <454F7B5F.1060601@gentoo.org>
References: <200611030816.22148.sgrubb@redhat.com>
	 <454E6663.8070609@gentoo.org>
	 <1162829020.26148.44.camel@localhost.localdomain>
	 <454F61E0.7090705@gentoo.org>
	 <1162831067.26148.53.camel@localhost.localdomain>
	 <454F7B5F.1060601@gentoo.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 13:28:54 -0500
Message-Id: <1162837734.26148.61.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-06 at 13:13 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Mon, 2006-11-06 at 11:25 -0500, Joshua Brindle wrote:
> >>
> > 
> > Encapsulation at this level is not a goal in my opinion. Encapsulation
> > is a source construct that helps make the policy _development_
> > manageable.
> > 
> 
> There is already encapsulation at this level: mls level translations.. 
> Contexts have always been opaque, how does a package handle mcs, mls, 
> targeted and strict policy (this is a real issue since lspp 
> configuration doesn't use targeted)
> 

Translation != Encapsulation - they have different goals.

If there is not a policy named "targeted" then the operation should
fail. Most packages should treat that as a non-fatal error and let the
default context apply to the files. That is one of the advantages of
splitting the labeling configuration and the application of the default
label.

> > It cannot, in any way, help allow implementation changes on a running
> > system as the identifiers are visible - e.g., types are used on the
> > filesystem. Users, roles, types, booleans, etc. are well known
> > identifiers that must be directly referenced to manage a system.
> > 
> >> I think this is a more general problem, how does any given app know that 
> >> it needs "some label" that gives it the ability to have textrels in its 
> >> libraries.
> > 
> > I think that the current practice is fine - types have well known
> > meanings for specific policies.
> > 
> >>> What if we added the ability to specify the store by name (i.e.,
> >>> semanage -s targeted fcontext -a . . . .). I think it should be
> >>> acceptable to make assumptions about what a well know policy contains.
> >>> Getting them to use semanage in this way would fix other problems - like
> >>> relabeling - without introducing unnecessary policy modules.
> >>>
> >> Store is an arbitrary string that means nothing. Sure this is practical 
> >> but there are version issues (if a type exists in some version X but not 
> >> before that, etc).
> >>
> > 
> > We are talking about a package targeting a specific system. Targeted for
> > FC6 is _not_ a random string - it refers to the shipping, default policy
> > with a known set of fixed types. Can a user install a completely
> > different "targeted" policy? Of course, but this doesn't happen.
> > 
> 
> It does whenever anyone downloads the refpolicy to change which modules 
> are built in, this happens, we've seen people request it in irc.
> 

And would this likely cause breakage in the scenario we are talking
about? Not likely. Also, those users should probably be encouraged to
give the policy a different name. We should enable people to support the
common configuration easily.

> > Adding more abstraction here is just going to confuse people - let's go
> > for the reasonably safe option now that lets people make selinux support
> > for their packages better without forcing them to jump through too many
> > hoops. This is Linux not *BSD - let's stop over engineering.
> > 
> 
> thats a pot shot... I didn't even suggest any kind of engineering (or 
> implementation) whatsoever, just noting potential concerns.
> 

No it's not and only a Nazi would suggest otherwise [1].

Karl

[1] http://en.wikipedia.org/wiki/Godwin's_law


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
