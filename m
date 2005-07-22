Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6MFXJgA006473
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 11:33:19 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6MFSWYP025539
	for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2005 15:28:33 GMT
Message-Id: <200507221528.j6MFSDvx017543@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>
Cc: <gyurdiev@redhat.com>, "'Joshua Brindle'" <jbrindle@tresys.com>,
   <selinux@tycho.nsa.gov>
Subject: RE: Iptables discussion
Date: Fri, 22 Jul 2005 11:28:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <42E105EE.6050603@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> Sent: Friday, July 22, 2005 10:43 AM
> To: Karl MacMillan
> Cc: gyurdiev@redhat.com; 'Joshua Brindle'; selinux@tycho.nsa.gov
> Subject: Re: Iptables discussion
> 
> Karl MacMillan wrote:
> 
> >>-----Original Message-----
> >>From: Ivan Gyurdiev [mailto:gyurdiev@redhat.com]
> >>Sent: Friday, July 22, 2005 9:45 AM
> >>To: Karl MacMillan
> >>Cc: 'Daniel J Walsh'; 'Joshua Brindle'; selinux@tycho.nsa.gov
> >>Subject: RE: Iptables discussion
> >>
> >>
> >>
> >>
> >>>Solving the user-interface issues can be done more effectively, in my
> >>>
> >>>
> >>opinion,
> >>
> >>
> >>>by hiding both iptables and SElinux. My preference would be to extend the
> >>>SELinux policy language to be able to express the kind of controls that you
> >>>
> >>>
> >>are
> >>
> >>
> >>>interested in expressing and create a configuration tool (gui or text
> based)
> >>>that generates the policy. That would leave a policy.conf or equivalent
> that
> >>>could be analyzed for correctness.
> >>>
> >>>
> >>I think whatever rules are automatically generated will be at a low
> >>level of complexity, because anything else would be better handled by
> >>writing policy. Given this, I think it will be trivial to generate
> >>additions to policy.conf to address your analysis concern. Where
> >>exactly this is done is an implementation detail :)
> >>
> >>
> >>
> >
> >Good - after re-reading you and Dan's messages I realized that you might be
> >simply suggesting that the iptables program generate SELinux policy. That
> makes
> >sense to me and is consistent with what I am saying about a user-interface.
> The
> >only other comment is that I would like this to be optional. We have a need
> to
> >create systems that have a fixed policy.
> >
> >
> Yes,  I am suggesting potentially IPTables could generate policy that
> you could check, and I am
> not suggesting that you remove the existing policy semantics.  I believe
> that users have a need and
> knowledge on how to configue iptables, and many tools have been written
> to allow the mangement of
> network security via IPTables.  The enhancement I would be looking for
> is how we could get
> iptables to communicate with SELinux to further constrain the system.
> 
> I see policy as being somewhat static.  IE We write the core policy that
> will work pretty much the same way
> on everyones machine.  The problem is that users have sections of policy
> that will differ.  Users, Ports, Interfaces
> on a machine by machine basis.  They have to be able to simply extend or
> modify policy to work better in their environments.
> I also see users needing to write small sections of policy, without
> modifying policy sources.  As an example I have a bug
> report right now from a user looking to use an app (plugin) with
> squirrelmail to do mail forwarding.   This app gets execed via
> squirrelmail and fails because it needs the setgid capability.  Now if
> the user could write one line of code, he could get the app working the
> way he wants, without having to disable squirrelmail protection or all
> of httpd.
> 

I agree that there are different kinds of policy customizations. We have been
using a model of:

Upstream policy (e.g. NSA, ref policy) -> oem modification / additions (e.g.,
Red Hat) -> third party additions (e.g. ISVs) -> local customizations.

Each of these has different needs. I agree that when we hit third part additions
the bulk of the policy is static. I had been assuming that the local
customizations would be a well-defined set of settings that the admin could
twiddle. Your squirrelmail example is sort-of different, though. I can clearly
see the need for it, but don't have a good idea of how to facilitate that
without pushing the user into full-on policy customization.

> There are customers that will pay for a customized policy that will lock
> down their system to a security specification and want it proovably
> secure.  There are a lot more customers who will pay for security  that
> they are reasonably certain protects their machine, but are not willing
> to pay someone to customize it.
> 

Definitely, and the former category will probably stay small of the foreseeable
future. I think we can meet the needs of both, though. 

> >
> >
> >>What's missing here, is a good API to work with policy, so that you
> >>can manipulate policy internals with anything other than checkpolicy.
> >>That's why I'm asking for an intermediate representation. My particular
> >>implementation of it may not be very good (suggestions welcome),
> >>but it's certainly better than what's out there - I don't think
> >>passing in policy-dependent integer id's, and exposing internal data
> >>structures will make a successful api.
> >>
> >>
> >
> >Why not continue down the path that we have started with libsemanage? I think
> it
> >is better to have a well-defined set of local machine customizations that are
> >available via libsemanage than forcing applications to do direct policy
> >manipulation. This will, I think, result in an smaller, easier to use API
> that
> >will allow a transition path to the policy server (which will hopefully allow
> us
> >to do these kinds of customizations across multiple machines). It also helps
> >with policy updates - by clearly defining local customizations and upstream
> >policy it is easier for package managers and admins to handle policy updates.
> >
> >
> >
> I agree.
> 

OK.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> >Karl
> >
> >---
> >Karl MacMillan
> >Tresys Technology
> >http://www.tresys.com
> >(410) 290-1411 ext 134
> >
> >
> >
> >
> 
> 
> --




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
