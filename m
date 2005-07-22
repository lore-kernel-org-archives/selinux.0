Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEW9gA005834
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:32:10 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MERNYP017668
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:27:23 GMT
Subject: RE: Iptables discussion
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <200507221419.j6MEJDvx016520@gotham.columbia.tresys.com>
References: <200507221419.j6MEJDvx016520@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 10:24:56 -0400
Message-Id: <1122042296.24847.30.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > What's missing here, is a good API to work with policy, so that you
> > can manipulate policy internals with anything other than checkpolicy.
> > That's why I'm asking for an intermediate representation. My particular
> > implementation of it may not be very good (suggestions welcome),
> > but it's certainly better than what's out there - I don't think
> > passing in policy-dependent integer id's, and exposing internal data
> > structures will make a successful api.
> 
> Why not continue down the path that we have started with libsemanage? I think it
> is better to have a well-defined set of local machine customizations that are
> available via libsemanage than forcing applications to do direct policy
> manipulation. This will, I think, result in an smaller, easier to use API that
> will allow a transition path to the policy server (which will hopefully allow us
> to do these kinds of customizations across multiple machines). It also helps
> with policy updates - by clearly defining local customizations and upstream
> policy it is easier for package managers and admins to handle policy updates.

Well, libsemanage will end up relying on libsepol, so it's just a
question of where this issue is resolved - I think both libraries should
present API that does not expose policydb internals. Then program X that
wants to do rule generation would call libsemanage, and libsemanage
would handle (1) the transaction, (2) the audit trail you want in
policy.conf, and then would pass down the request to libsepol without
doing things like generating sid's itself, and looking at caches, and
other policydb details.






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
