Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6EGL9gA004400
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 12:21:09 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6EGH0kZ023563
	for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2005 16:17:00 GMT
Date: Thu, 14 Jul 2005 12:17:39 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: MCS/Targeted Policy...
In-Reply-To: <20050714033414.97168.qmail@web31611.mail.mud.yahoo.com>
Message-ID: <Xine.LNX.4.44.0507141155320.13333-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Jul 2005, Casey Schaufler wrote:

> > There are some fundamental differences between the
> > systems; here are some
> > very basic definitions:
> > 
> > - ACLs govern discretionary access rights to an
> > object.
> > - MCS constrains DAC and TE access rights to an
> > object.
> 
> Discretionary Type Enforcement? Is that
> really what you want to propose?

Not exactly.  The proposal is further discretionary restrictions on TE, to
provide end users with more direct control over their objects.

TE itself always remains a MAC system.

> > MCS can also operate on TE attributes.
> 
> Giving users descretionary control over
> TE attributes seems counter to the "SELinux
> is a MAC scheme" position I've heard
> fairly regularly, but it is a logical
> extension.

This does not necessarily mean user control over TE attributes, just that 
MCS policy constraints can directly reference TE attributes.

> > ACLs are limited to a small set of file type OS
> > objects.  MCS could be
> > applied to any of the objects which SELinux
> > controls, including userspace
> > components.
> 
> ACLs on sockets have been done in the past,
> you know, just as has MLS.

I'd be interested to know where was this done (especially a deployed 
product).

> > ACLs will still be in 
> >   effect, and security could be seriously degraded
> > without TE in place, as 
> >   ACLs are a privilege escalation mechanism.
> 
> What! This you've got to explain.

Ok, assume that ACLs have been used with TE to synthesize an MCS-like
security mechansim.  If TE is disabled (e.g. boot with selinux=0), the
ACLs will still be there, but without TE's containment, integrity control
etc. features.  The big difference with MCS is that it only further
constrains DAC and TE policy.  ACLs are permissive and assign access 
rights directly to objects.

> 
> > In the
> > case of MCS, the 
> >   category labels would do nothing without SELinux
> > enabled.
> 
> Ah. The POSIX ACL group made sure that adding
> an ACL to a file would not interfere with the
> mode bits, nor encourage users to set them
> "wide open" and count on the ACL alone.
> 
> Imagine a system with MCS. If everything
> and everyone used MCS, all the mode bits
> could be 777, and you might do that so they
> would not interfere with the desired MCS
> activity. Bring that up without SELinux.

I don't understand this: MCS only further restricts secuirty policy
implemnted via mode bits.  It cannot directly reduce the security of the
system with or without SELinux enabled.

> In review, MCS is a logical extension to
> SELinux. I expect you'll have to put more
> limits on its flexibility than you think.
> I expect to enjoy watching the experiment.

It is indeed still considered experimental.

Thanks for the input.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
