Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3015191F98;
	Fri,  5 Sep 2025 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110541; cv=none; b=Hux0Ef6tzjydYc9P/ATWtn6AK/5qfeHWcOND/jXybp2hqI0kj3pb97Haac2s3YhJVsNYDc/qcHNqjvWmgp8UVduk9Y+tWwm6FqSB7gxd1hLGCK/Q0zf07oXNA8uFmMM62FdKxPDFPCBJnzGYXEtOv9/Rwtx1wBmSfbOBpMzFfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110541; c=relaxed/simple;
	bh=d/mKyr4rXN2CeC+eU4S4t7dwzeVxFlw5NccVZjZ8jM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9xfSnVvS1x+ftg74QfTtsaLdmRjbXP4yLWigiPThQ/QrKInRcCXtDF2T1OP21D41cZsCU0HrEgwIiuYmtAeapSJ6aO23BU34yUxaHEccRRt/Y/1cqqM+lGsVF2JJ8iJHIaBJyPNASod2vzIxZDW1OepMISB+3jRUj+/VFVLIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 585MF0Mw001261;
	Fri, 5 Sep 2025 17:15:00 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 585MEuaZ001260;
	Fri, 5 Sep 2025 17:14:56 -0500
Date: Fri, 5 Sep 2025 17:14:56 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: LSM namespacing API
Message-ID: <20250905221456.GA1206@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com> <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com> <aKcskclwVVe1X4kP@mail.hallyn.com> <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com> <20250901160102.GA9179@wind.enjellic.com> <fc3aadf1-9598-4fc2-bdb9-290df425b5d8@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3aadf1-9598-4fc2-bdb9-290df425b5d8@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 05 Sep 2025 17:15:00 -0500 (CDT)

On Tue, Sep 02, 2025 at 03:55:39AM -0700, John Johansen wrote:

Hi, I hope the week has gone well for everyone.

> On 9/1/25 09:01, Dr. Greg wrote:
> >On Thu, Aug 21, 2025 at 07:57:11AM -0700, John Johansen wrote:
> >
> >Good morning, I hope the week is starting well for everyone.
> >
> >Now that everyone is getting past the summer holiday season, it would
> >seem useful to specifically clarify some of the LSM namespace
> >implementation details.
> >
> >>On 8/21/25 07:26, Serge E. Hallyn wrote:
> >>>On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
> >>>>On 8/19/25 10:47, Stephen Smalley wrote:
> >>>>>On Tue, Aug 19, 2025 at 10:56???AM Paul Moore <paul@paul-moore.com>
> >>>>>wrote:
> >>>>>>
> >>>>>>Hello all,
> >>>>>>
> >>>>>>As most of you are likely aware, Stephen Smalley has been working on
> >>>>>>adding namespace support to SELinux, and the work has now progressed
> >>>>>>to the point where a serious discussion on the API is warranted.  For
> >>>>>>those of you are unfamiliar with the details or Stephen's patchset, or
> >>>>>>simply need a refresher, he has some excellent documentation in his
> >>>>>>work-in-progress repo:
> >>>>>>
> >>>>>>* https://github.com/stephensmalley/selinuxns
> >>>>>>
> >>>>>>Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> >>>>>>about SELinux namespacing, you can watch the presentation here:
> >>>>>>
> >>>>>>* https://www.youtube.com/watch?v=AwzGCOwxLoM
> >>>>>>
> >>>>>>In the past you've heard me state, rather firmly at times, that I
> >>>>>>believe namespacing at the LSM framework layer to be a mistake,
> >>>>>>although if there is something that can be done to help facilitate the
> >>>>>>namespacing of individual LSMs at the framework layer, I would be
> >>>>>>supportive of that.  I think that a single LSM namespace API, similar
> >>>>>>to our recently added LSM syscalls, may be such a thing, so I'd like
> >>>>>>us to have a discussion to see if we all agree on that, and if so,
> >>>>>>what such an API might look like.
> >>>>>>
> >>>>>>At LSS-NA this year, John Johansen and I had a brief discussion where
> >>>>>>he suggested a single LSM wide clone*(2) flag that individual LSM's
> >>>>>>could opt into via callbacks.  John is directly CC'd on this mail, so
> >>>>>>I'll let him expand on this idea.
> >>>>>>
> >>>>>>While I agree with John that a fs based API is problematic (see all of
> >>>>>>our discussions around the LSM syscalls), I'm concerned that a single
> >>>>>>clone*(2) flag will significantly limit our flexibility around how
> >>>>>>individual LSMs are namespaced, something I don't want to see happen.
> >>>>>>This makes me wonder about the potential for expanding
> >>>>>>lsm_set_self_attr(2) to support a new LSM attribute that would support
> >>>>>>a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> >>>>>>provide a single LSM framework API for an unshare operation while also
> >>>>>>providing a mechanism to pass LSM specific via the lsm_ctx struct if
> >>>>>>needed.  Just as we do with the other LSM_ATTR_* flags today,
> >>>>>>individual LSMs can opt-in to the API fairly easily by providing a
> >>>>>>setselfattr() LSM callback.
> >>>>>>
> >>>>>>Thoughts?
> >>>>>
> >>>>>I think we want to be able to unshare a specific security module
> >>>>>namespace without unsharing the others, i.e. just SELinux or just
> >>>>>AppArmor.
> >>>>
> >>>>yes which is part of the problem with the single flag. That choice
> >>>>would be entirely at the policy level, without any input from userspace.
> >>>
> >>>AIUI Paul's suggestion is the user can pre-set the details of which
> >>>lsms to unshare and how with the lsm_set_self_attr(), and then a
> >>>single CLONE_LSM effects that.
> >
> >>yes, I was specifically addressing the conversation I had with Paul at
> >>LSS that Paul brought up. That is
> >>
> >>   At LSS-NA this year, John Johansen and I had a brief discussion where
> >>   he suggested a single LSM wide clone*(2) flag that individual LSM's
> >>   could opt into via callbacks.
> >>
> >>the idea there isn't all that different than what Paul proposed. You
> >>could have a single flag, if you can provide ancillary information. But
> >>a single flag on its own isn't sufficient.
> >
> >If one thing has come out of this thread, it would seem to be the fact
> >that there is going to be little commonality in the requirements that
> >various LSM's will have for the creation of a namespace.

> yes

Given that and the conversations to date, the open question may be
whether there needs to be a common 'LSM namespace' infrastructure at
all or just punt everything to LSM's that choose to implement
namespaces.

> >Given that, the most infrastructure that the LSM should provide would
> >be a common API for a resource orchestrator to request namespace
> >separation and to provide a framework for configuring the namespace
> >prior to when execution begins in the context of the namespace.

> hrmmm, certainly a common API. Any task could theoretically use the API
> it doesn't have to be a resource orchestrator, but I suppose you could
> call it such.

No argument that any task could call for separation.

We seem to be dancing around the notion that the primary use, nee
demand, for a security namespace will be to allow container specific
security policies.  In that scenario, the resource orchestrator or
container runtime will be what is requesting a specific security
model to be implemented in a namespace.

> I also dont know that we need to provide a framework for configuring
> the namespace prior to when execcution begins in the context of the
> namespace. It might be a nice to have, but configuring of LSMs is
> very LSM specific.
>
> We don't even have a common LSM policy load interface atm, though there
> is a proposal. Configuration is a step beyond that. Would it be nice
> to have, sure. Are we going to get that far, I don't know.

At least for model based LSM's, the configuration needs to occur
before execution within the namespace begins in order to avoid
possible races with respect to the security policy that gets effected.

Casey advocates for the use of lsm_set_self_attr(2), which has the
advantage of a common API and is probably sufficient if an LSM elects
to provide a generic management interface.

The system call is currently not namespace aware so the challenge will
be how to direct the configuration payload to the correct namespace.

Given that limitation, it seems highly probably that individual LSM's
will implement configuration/policy management via their various
pseudo-filesystem implementations that will grow awareness for the
namespace context that the commands are being issued for.

> >The first issue to resolve would seem to be what namespace separation
> >implies.
> >
> >John, if I interpret your comments in this discussion correctly, your
> >contention is that when namespace separation is requested, all of the
> >LSM's that implement namespaces will create a subordinate namespace,
> >is that a correct assumption?

> No, not necessarily. The task can request to "unshare/create" LSMs
> similar to requesting a set of system namespaces. Then every LSM,
> whether part of the request or not get to do their thing. If every
> LSM agrees, then a transition hook will process and each LSM will
> again do its thing. This would likely be what was requested but its
> possible that an LSM not in the request will do something, based on
> its model.
>
> In the end usespace gets to make a request, each security policy is
> responsible for staying withing its security model/policy.

This approach seems contrary to what Casey is advocating for in our
conversations, but perhaps we misunderstand what he is saying.

Casey indicated that no other LSM should be able to deny the ability
of another LSM to create a namespace.

As we noted in our exchange with him, this seems to violate the
current LSM model where all of the LSM's need to agree that an event
should be allowed, or it fails.

> >It would seem, consistent with the 'stacking' concept, that any LSM
> >with namespace capability that chooses not to separate, will result in
> >denial of the separation request.  That in turn will imply the need to

> Not necessarily. They could allow and choose not to transition. Or
> they could not create a namespace but update some state.

> >unwind or delete any namespace context that other LSM's may have
> >allocated before the refusal occurred.

> The request does need to be split into a permission hook and a
> transition hook similar to exec. If any LSM in the permission hook
> denies, the request is denied. If any LSM in the transition hook
> fails again the request will fail, and the LSMs would get their
> regular clean up hook called for the object associated.

See above, the open question seems to be whether or not there is
agreement that any LSM can generically deny the creation of namespace
creation.

Again, we may misunderstand Casey on this issue.

> >This model also implies that the orchestrator requesting the
> >separation will need to pass a set of parameters describing the
> >characteristics of each namespace, described by the LSM identifier
> >that they pertain to.  Since there may be a need to configure multiple
> >namespaces there would be a requirement to pass an array or list of
> >these parameter sets.

> yes it will require a list/array see lsm_set_self_attr(2)

Again, the issue is making this system call namespace aware.

> >There will also be a need to inject, possibly substantial amounts of
> >policy or model information into the namespace, before execution in
> >the context of the namespace begins.

> Allowing for this and requiring this are two different things. Like
> I said above we don't even currently have a common policy load
> interface.  Configuration is another step beyond policy load.

It would seem the most straight forward path is to simply punt this to
the LSM's itself.  If nothing else, it reduces the issues that
everyone needs to agree on.

> >There will also be a need to decide whether namespace separation
> >should occur at the request of the orchestrator or at the next fork,

> Or allow both, but yes a decision needs to be made

Again, allow both at the discretion of the LSM.

> >the latter model being what the other resource namespaces use.  We
> >believe the argument for direct separation can be made by looking at
> >the gymnastics that orchestrators need to jump through with the
> >'change-on-fork' model.

> Looking at current system namespacing we have clone/unshare which
> really or on fork. setns enters existing namespaces.
>
> We either need to create new variants of clone/unshare or potentially
> have an LSM syscall that setups addition parameters that then are
> triggered by clone/unshare. If going the latter route then its just
> a matter whether the LSM call returns a handle that can be operated
> on or not.

We will find that current namespace semantics are challenging with
respect to being a good model for LSM namespaces.

Current namespaces focus on managing a single resource.  In contrast,
as we have seen in our discussions, an 'LSM namespace' involves
multiple resources, each with their own specific requirements.  On top
of that we have the complication of 'stacking' where anything that
happens will be the composite of what all the LSM's agree on, some of
which may be in the root namespace and some of which may be in
subordinate namespaces.

The notion of a process entering a security namespace, aka setns, will
be interesting.  It would seem that this will require callbacks to
every LSM that is participating in the namespace.  Presumably all of
the references to LSM security contexts will need to be suspended and
replaced with references to the context(s) for the security namespace
that is being entered.

With respect to managing this effectively, we would advocate for a
64-bit global counter that gets incremented on each successful LSM
namespace creation event.  That would provide a unique handle for the
namespace that will never wrap.

> >Case in point, it would seem realistic that a process with sufficient
> >privilege, may desire to place itself in a new LSM namespace context
> >in a manner that does not require re-execution of itself.

> yes, but it is questionable whether security policy should allow that.
> At the very least security policy should be consulted and may deny
> it.

What we are talking about here is the need to support a process
requesting to run in an alternate LSM namespace without forking.

The question of whether this should be allowed will be regulated by
whatever composite security policy is operational, the same as would
be the case with the switch on fork model.

> >With respect to separation, the remaining issue is if a new security
> >capability bit needs to be implemented to gate namespace separation.
> >John, based on your comments, I believe you would support this need?

> No, I don't think a capability (as in posix.1e) per say is needed. I
> think an LSM permission request is.

Once again, that seems inconsistent with what Casey is advocating.

Although I'm sure he is happy that a new capability bit is not in the
offing... :-)

> >>You can do a subset with a single flag and only policy directing things,
> >>but that would cut container managers out of the decision. Without a
> >>universal container identifier that really limits what you can do. In
> >>another email I likend it to the MCS label approach to the container
> >>where you have a single security policy for the container and each
> >>container gets to be a unique instance of that policy. Its not a perfect
> >>analogy as with namespace policy can be loaded into the namespace making
> >>it unique. I don't think the approach is right because not all namespaces
> >>implement a loadable policy, and even when they do I think we can do a
> >>better job if the container manager is allowed to provide additional
> >>context with the namespacing request.
> >
> >In order to be relevant, the configuration of LSM namespaces need to
> >be under control of a resource orchestrator or container manager.

> No, the must be under the control of the LSMs.

I think we are talking past one another.

Configuration was perhaps a poor choice of vernacular, we were
referring to policy or model load.

As we mentioned in our exchange with Casey, the expection for all of
this from the user community will be to allow resource orchestrators
to run a workload under the constraints of a specific security policy.

Where policy should be probably plural.

Stephen even notes this on the slides that are linked from his GitHub
selinuxns site.

> >What we hear from people doing Kubernetes, at scale, is a desire to be
> >able to request that a container be run somewhere in the hardware
> >Resource pool and for that container to implement a security model
> >specific to the needs of the workload running in that container.  In a
> >manner that is orthogonal from other security policies that may be in
> >effect for other workloads, on the host or in other containers.

> sure, assuming the host policy allows it. Otherwise it is just a host
> policy by-pass, which can not be allowed. K8s people have a specific
> use case, they need to configure the host for that use case. They can
> not expect that use case to work on host that has been configured
> for say an MLS security constraint.

Given that the concept of LSM stacking is overlaid on top of
namespaces, the result of all this will be security policies that will
be very interesting to reason about, particularly if multiple levels
of namespacing are allowed.

The other issue will be potential performance issues for LSM's that
choose to chase permissions all the way back up to the root namespace.
We've heard continuous suggestions that every pointer de-reference
is problematic from a performance perspective.

So, lots of issues to consider in all of this.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
