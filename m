Subject: Re: MCS and default labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20090909100647.GE24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
	 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
	 <20090908163628.GC24297@myhost.felk.cvut.cz>
	 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
	 <20090909100647.GE24297@myhost.felk.cvut.cz>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 08:17:40 -0400
Message-Id: <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-09 at 12:06 +0200, Michal Svoboda wrote:
> Stephen Smalley wrote:
> > Unfortunately for you, MCS is using the existing MLS engine, which
> > doesn't presently support inheritance from parent directory (unlike the
> > TE engine).  So to support the behavior you want, you'd have to modify
> > the actual code (and that's kernel code).  Thus, you are more likely to
> > find success using actual MLS or using TE.
> 
> Let me see if I can come up with a simple patch that does the work. It
> sounds better than rewriting each app to actually change the labels for
> themselves. (Is there even an API for specifying MCS label prior to file
> creation? If it has to be changed after the file exists then it's a huge
> race condition style hole.)

setfscreatecon(3) specifies a security context prior to file creation.

The kernel MLS logic lives in security/selinux/ss/mls.c.  Determining
the MLS level of a new subject or object is handled by
mls_compute_sid().  Any change would have to support either model
(inherit from source context or inherit from target context), so
logically it would be policy-driven.  Which likely means an extension to
the policy language and compiler.  Not an entirely trivial undertaking.

There is a range_transition statement in the policy that allows one to
specify a desired level/range for a new subject/object based on the type
pair and class, but that does not support inheritance of the level from
the target context.  Possibly it could be extended to do so.

> > > Secondly I don't see why a user is not able to discretionarily specify
> > > his range outright when going via ssh just as he can with roles. 
> > 
> > That's another artifact of the MLS model (label preservation /
> > confinement).
> 
> Unfortunately here I have no idea on what code should I look to remove
> that artifact.

I think it is just lack of support in sshd due to lack of interest in
supporting it for MLS.  You could add it, but you'd need to make sure
that it doesn't break the MLS behavior, as that is the one people care
about.

> > > No. MLS is about strict ordering 0 < 1 < 2 ... I just want a partially
> > > ordered set. I want compartments, not sensitivities. MCS and MLS are
> > > orthogonal, at least by their theoretical properties (and SELinux MCS
> > > strongly resembles the theory in practice).
> > 
> > I think you're confused about MLS; it supports a set of hierarchical
> > sensitivities and a set of non-hierarchical categories, and MCS is
> > nothing more than a particular configuration of the MLS engine.  So you
> > are free to just use a single MLS sensitivity and only use its
> > categories.  
> 
> I think I am not confused. There are two principles, sensitivities and
> categories. Categories do have hierarchy, just not a strictly ordered
> one. For any two categories one could find a supremal and infimal ones,
> and that's what contributes to the quadratic number of types should TE
> be used instead.
> 
> A MCS system is then just taking advantage of the categories principle,
> and not utilising the sensitivities one. That is perfectly what I want,
> but I just want it to be usable on my use case, ie. files inheriting
> categories from parent dirs, which I think is perfectly valid. I see
> this topic recurring and the standard reply "use something else than
> MCS" is just weird at least.

Nothing prevents you from using MLS with a single sensitivity, only
using categories as the distinguishing element.  But that is not
identical to MCS, as I've explained - the use of the low/current level
differs between MLS and MCS (which in turns creates the problem for you
in terms of file labeling under MCS, but would work under MLS), and the
set of policy constraints is quite different.

TE gives you the desired labeling behavior (inherit from parent
directory).  MLS gives you the same end result (the process would be
labeled s0:c1 and thus its files would get created as such).  MCS does
not.  It isn't so odd then to recommend using something other than MCS.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
