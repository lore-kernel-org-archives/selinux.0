Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MEOKgA005736
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 10:24:20 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MEIlKk028855
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 14:18:47 GMT
Message-Id: <200507221419.j6MEJDvx016520@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <gyurdiev@redhat.com>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Joshua Brindle'" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 10:19:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1122039886.24847.6.camel@celtics.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> Sent: Friday, July 22, 2005 9:45 AM
> To: Karl MacMillan
> Cc: 'Daniel J Walsh'; 'Joshua Brindle'; selinux@tycho.nsa.gov
> Subject: RE: Iptables discussion
> 
> 
> > Solving the user-interface issues can be done more effectively, in my
> opinion,
> > by hiding both iptables and SElinux. My preference would be to extend the
> > SELinux policy language to be able to express the kind of controls that you
> are
> > interested in expressing and create a configuration tool (gui or text based)
> > that generates the policy. That would leave a policy.conf or equivalent that
> > could be analyzed for correctness.
> 
> I think whatever rules are automatically generated will be at a low
> level of complexity, because anything else would be better handled by
> writing policy. Given this, I think it will be trivial to generate
> additions to policy.conf to address your analysis concern. Where
> exactly this is done is an implementation detail :)
> 

Good - after re-reading you and Dan's messages I realized that you might be
simply suggesting that the iptables program generate SELinux policy. That makes
sense to me and is consistent with what I am saying about a user-interface. The
only other comment is that I would like this to be optional. We have a need to
create systems that have a fixed policy.

> What's missing here, is a good API to work with policy, so that you
> can manipulate policy internals with anything other than checkpolicy.
> That's why I'm asking for an intermediate representation. My particular
> implementation of it may not be very good (suggestions welcome),
> but it's certainly better than what's out there - I don't think
> passing in policy-dependent integer id's, and exposing internal data
> structures will make a successful api.

Why not continue down the path that we have started with libsemanage? I think it
is better to have a well-defined set of local machine customizations that are
available via libsemanage than forcing applications to do direct policy
manipulation. This will, I think, result in an smaller, easier to use API that
will allow a transition path to the policy server (which will hopefully allow us
to do these kinds of customizations across multiple machines). It also helps
with policy updates - by clearly defining local customizations and upstream
policy it is easier for package managers and admins to handle policy updates.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
