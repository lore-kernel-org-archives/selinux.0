Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFXTgA006490
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:33:29 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFRtKk008144
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:27:55 GMT
Message-Id: <200507221528.j6MFSSvx017547@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 11:28:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1122042296.24847.30.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, July 22, 2005 10:25 AM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; 'Joshua Brindle'; selinux@tycho.nsa.gov
> Subject: RE: Iptables discussion
> 
> 
> > > What's missing here, is a good API to work with policy, so that you
> > > can manipulate policy internals with anything other than checkpolicy.
> > > That's why I'm asking for an intermediate representation. My particular
> > > implementation of it may not be very good (suggestions welcome),
> > > but it's certainly better than what's out there - I don't think
> > > passing in policy-dependent integer id's, and exposing internal data
> > > structures will make a successful api.
> >
> > Why not continue down the path that we have started with libsemanage? I
> think it
> > is better to have a well-defined set of local machine customizations that
> are
> > available via libsemanage than forcing applications to do direct policy
> > manipulation. This will, I think, result in an smaller, easier to use API
> that
> > will allow a transition path to the policy server (which will hopefully
> allow us
> > to do these kinds of customizations across multiple machines). It also helps
> > with policy updates - by clearly defining local customizations and upstream
> > policy it is easier for package managers and admins to handle policy
> updates.
> 
> Well, libsemanage will end up relying on libsepol, so it's just a
> question of where this issue is resolved - I think both libraries should
> present API that does not expose policydb internals. Then program X that
> wants to do rule generation would call libsemanage, and libsemanage
> would handle (1) the transaction, (2) the audit trail you want in
> policy.conf, and then would pass down the request to libsepol without
> doing things like generating sid's itself, and looking at caches, and
> other policydb details.
> 

OK - that sounds like a good plan to me. Josh is working on getting the
libsemanage updates done as soon as possible. Why don't we push on getting that
ready for you to add the network related APIs and you continue pushing on
libsepol? Also, as Josh Guttman pointed out your work would benefit slat as
well.

Are you imagining a file like local.users for network related configuration -
this would allow direct modification of the configuration files for those that
would prefer that to using tools / libsemanage? Any idea about what the rules
that will be generated will look like? I'm trying to get a handle on exactly how
this network configuration will look and whether it is going to require pulling
out parts of the existing policy. For example, would the apache module stop
allowing any send / receive on any node, netif, or port and then there would be
a default local network configuration provided? 

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
