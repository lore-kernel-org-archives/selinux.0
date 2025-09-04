Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96075221555;
	Thu,  4 Sep 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952250; cv=none; b=oOPMoFOf/eglpnYhSx/XSKLtycvLcDVI28FDZ+0ZncpK9oZd05RaqtS/h8a3akrPN8BCOoHSp1EacoVqQdseQVnY2m/AVc4LAK5UhQBJweHGSI3DeQOnu/8oGfWCMPRo45lGAdMKvXIPJkGZIhyF0TzFW6ifZXGVpR2Poi7tZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952250; c=relaxed/simple;
	bh=niObyJul1LMFoKhIqxMXVFoUE9gWJJhkeI89YA/fPmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQqMoAZESheJFu7mF+ykzmZOe6jawponxRIFH0socul/n+JQOt+YZLiUdv1LMovRtFUkGQC2esQQczP65DMviCU9Arkp84uIEzzCIiwa/JyAKfGrX2VEfKosDSbgd04Y+ZOo5NF3nwUdJj67SdShtzSPABLZ24vYFUlsqqmbcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 5842Gr3m007352;
	Wed, 3 Sep 2025 21:16:53 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 5842Goci007351;
	Wed, 3 Sep 2025 21:16:50 -0500
Date: Wed, 3 Sep 2025 21:16:50 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: LSM namespacing API
Message-ID: <20250904021650.GA7191@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com> <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com> <aKcskclwVVe1X4kP@mail.hallyn.com> <6c69fc81-32a7-442c-8c7f-992eda9c2d18@canonical.com> <20250901160102.GA9179@wind.enjellic.com> <3826d6c2-164b-415f-8bf4-63060ce428df@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3826d6c2-164b-415f-8bf4-63060ce428df@schaufler-ca.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 03 Sep 2025 21:16:53 -0500 (CDT)

On Mon, Sep 01, 2025 at 10:31:43AM -0700, Casey Schaufler wrote:

Hi, I hope mid-week has gone well for everyone.

> On 9/1/2025 9:01 AM, Dr. Greg wrote:
> > On Thu, Aug 21, 2025 at 07:57:11AM -0700, John Johansen wrote:
> >
> > Good morning, I hope the week is starting well for everyone.
> >
> > Now that everyone is getting past the summer holiday season, it would
> > seem useful to specifically clarify some of the LSM namespace
> > implementation details.
> >
> >> On 8/21/25 07:26, Serge E. Hallyn wrote:
> >>> On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
> >>>> On 8/19/25 10:47, Stephen Smalley wrote:
> >>>>> On Tue, Aug 19, 2025 at 10:56???AM Paul Moore <paul@paul-moore.com> 
> >>>>> wrote:
> >>>>>> Hello all,
> >>>>>>
> >>>>>> As most of you are likely aware, Stephen Smalley has been working on
> >>>>>> adding namespace support to SELinux, and the work has now progressed
> >>>>>> to the point where a serious discussion on the API is warranted.  For
> >>>>>> those of you are unfamiliar with the details or Stephen's patchset, or
> >>>>>> simply need a refresher, he has some excellent documentation in his
> >>>>>> work-in-progress repo:
> >>>>>>
> >>>>>> * https://github.com/stephensmalley/selinuxns
> >>>>>>
> >>>>>> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> >>>>>> about SELinux namespacing, you can watch the presentation here:
> >>>>>>
> >>>>>> * https://www.youtube.com/watch?v=AwzGCOwxLoM
> >>>>>>
> >>>>>> In the past you've heard me state, rather firmly at times, that I
> >>>>>> believe namespacing at the LSM framework layer to be a mistake,
> >>>>>> although if there is something that can be done to help facilitate the
> >>>>>> namespacing of individual LSMs at the framework layer, I would be
> >>>>>> supportive of that.  I think that a single LSM namespace API, similar
> >>>>>> to our recently added LSM syscalls, may be such a thing, so I'd like
> >>>>>> us to have a discussion to see if we all agree on that, and if so,
> >>>>>> what such an API might look like.
> >>>>>>
> >>>>>> At LSS-NA this year, John Johansen and I had a brief discussion where
> >>>>>> he suggested a single LSM wide clone*(2) flag that individual LSM's
> >>>>>> could opt into via callbacks.  John is directly CC'd on this mail, so
> >>>>>> I'll let him expand on this idea.
> >>>>>>
> >>>>>> While I agree with John that a fs based API is problematic (see all of
> >>>>>> our discussions around the LSM syscalls), I'm concerned that a single
> >>>>>> clone*(2) flag will significantly limit our flexibility around how
> >>>>>> individual LSMs are namespaced, something I don't want to see happen.
> >>>>>> This makes me wonder about the potential for expanding
> >>>>>> lsm_set_self_attr(2) to support a new LSM attribute that would support
> >>>>>> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> >>>>>> provide a single LSM framework API for an unshare operation while also
> >>>>>> providing a mechanism to pass LSM specific via the lsm_ctx struct if
> >>>>>> needed.  Just as we do with the other LSM_ATTR_* flags today,
> >>>>>> individual LSMs can opt-in to the API fairly easily by providing a
> >>>>>> setselfattr() LSM callback.
> >>>>>>
> >>>>>> Thoughts?
> >>>>> I think we want to be able to unshare a specific security module
> >>>>> namespace without unsharing the others, i.e. just SELinux or just
> >>>>> AppArmor.
> >>>> yes which is part of the problem with the single flag. That choice
> >>>> would be entirely at the policy level, without any input from userspace.
> >>> AIUI Paul's suggestion is the user can pre-set the details of which
> >>> lsms to unshare and how with the lsm_set_self_attr(), and then a
> >>> single CLONE_LSM effects that.
> >> yes, I was specifically addressing the conversation I had with Paul at
> >> LSS that Paul brought up. That is
> >>
> >>   At LSS-NA this year, John Johansen and I had a brief discussion where
> >>   he suggested a single LSM wide clone*(2) flag that individual LSM's
> >>   could opt into via callbacks.
> >>
> >> the idea there isn't all that different than what Paul proposed. You
> >> could have a single flag, if you can provide ancillary information. But
> >> a single flag on its own isn't sufficient.
> > If one thing has come out of this thread, it would seem to be the fact
> > that there is going to be little commonality in the requirements that
> > various LSM's will have for the creation of a namespace.
> >
> > Given that, the most infrastructure that the LSM should provide would
> > be a common API for a resource orchestrator to request namespace
> > separation and to provide a framework for configuring the namespace
> > prior to when execution begins in the context of the namespace.
> >
> > The first issue to resolve would seem to be what namespace separation
> > implies.
> >
> > John, if I interpret your comments in this discussion correctly, your
> > contention is that when namespace separation is requested, all of the
> > LSM's that implement namespaces will create a subordinate namespace,
> > is that a correct assumption?
> >
> > It would seem, consistent with the 'stacking' concept, that any LSM
> > with namespace capability that chooses not to separate, will result in
> > denial of the separation request.  That in turn will imply the need to
> > unwind or delete any namespace context that other LSM's may have
> > allocated before the refusal occurred.

> Were it true that 'stacking' rated the status of a 'concept'.

If 'concept' doesn't work as a term, we can call it an agreement on
the co-existence of multiple security models.

> An LSM that is capable of namespacing (the definition of which is
> elusive at this time) should be allowed to decline participation in
> a namespace creation.

Given the above, a full stop may be in order.

Perhaps, in pursuit of wisdom, we should call for a general consensus
among the group as to whether or not we have any clue as to what we
are doing?

> That, or there needs to be a convention for "null" namespaces, by
> which an LSM can pretend that it isn't involved in the new
> namespace. I think the latter smells funny and would invite
> "security people don't understand performance" remarks. No LSM
> should be allowed to prevent another from using namespaces.

Unfortunately that would seem to collide with the general consensus
that has evolved around 'stacking', as the means by which Linux
supports multiple LSM based security models/architectures.

The kernel security architecture admits to the notion that all of
the active LSM's have to agree that a specific security event be
allowed.  If any LSM elects to deny a hook call, permission is denied
for the event.

John responded to our e-mail in this thread and clarified that he
doesn't believe that a POSIX 1e style capability for namespace
separation is required.  However, our understanding from his reply is
that he felt that LSM namespace creation itself should have its own
LSM hook/event.

If this is the case, to be consistent with the stacking architecture,
any LSM should have the ability to deny security namespace creation
through its interpretation of the LSM namespace creation hook.

For example, it would certainly seem to be a valid concept for
something like an enhanced 'lockdown' mode to deny the ability for any
processes to escape into an LSM policy domain other than what was
configured when the platform was placed in a locked down status.

If we don't adhere to this model, we will have a 'snowflake' to
contend with in the LSM security model.

> > This model also implies that the orchestrator requesting the
> > separation will need to pass a set of parameters describing the
> > characteristics of each namespace, described by the LSM identifier
> > that they pertain to.  Since there may be a need to configure multiple
> > namespaces there would be a requirement to pass an array or list of
> > these parameter sets.

> Just like lsm_set_self_attr(2).

That provides basic infrastructure, however, with concession to the
general acknowledgement that every LSM is different, the requirement
for every attribute to have a unique descriptive identity value may
prove restrictive, particularly in model based LSM's.

What may be needed is an agnostic attribute identifier that
orchestration software could use, in combination with the 'flags'
variable to specify exactly what type of attribute is being delivered
by the system call to an LSM.  In other words, the attribute would
tell an LSM to interpret the flags value as an indicator of the
payload being delivered.

> > There will also be a need to inject, possibly substantial amounts of
> > policy or model information into the namespace, before execution in
> > the context of the namespace begins.

> Yup. A major downside of loadable policy.

Irregardless of merit, it will be reality, see below.

> > There will also be a need to decide whether namespace separation
> > should occur at the request of the orchestrator or at the next fork,
> > the latter model being what the other resource namespaces use.  We
> > believe the argument for direct separation can be made by looking at
> > the gymnastics that orchestrators need to jump through with the
> > 'change-on-fork' model.
> >
> > Case in point, it would seem realistic that a process with sufficient
> > privilege, may desire to place itself in a new LSM namespace context
> > in a manner that does not require re-execution of itself.
> >
> > With respect to separation, the remaining issue is if a new security
> > capability bit needs to be implemented to gate namespace separation.
> > John, based on your comments, I believe you would support this need?

> I don't like the notion of a new capability for this. But then, I
> object to almost every new capability proposed. Existing namespaces
> don't need their own capabilities. I don't see this case as special.

It appears that John is thinking that an LSM hook is what will be
needed, so no new capability bit would be required.

That concept seems consistent with the precedence that was established
by using this type of scheme to control the creation of user
namespaces.

> >> You can do a subset with a single flag and only policy directing things,
> >> but that would cut container managers out of the decision. Without a
> >> universal container identifier that really limits what you can do. In
> >> another email I likend it to the MCS label approach to the container
> >> where you have a single security policy for the container and each
> >> container gets to be a unique instance of that policy. Its not a perfect
> >> analogy as with namespace policy can be loaded into the namespace making
> >> it unique. I don't think the approach is right because not all namespaces
> >> implement a loadable policy, and even when they do I think we can do a
> >> better job if the container manager is allowed to provide additional
> >> context with the namespacing request.
> > In order to be relevant, the configuration of LSM namespaces need to
> > be under control of a resource orchestrator or container manager.

> I do not approve of kernel features that are pointless without
> specific user space support. If it can't be used in ways other than
> those defined by a particular user space component they really don't
> belong in the kernel.

It appears you have already created the necessary infrastructure with
lsm_set_self_attr(2).

Given the apparent consensus that an LSM is free to implement
namespaces in whatever manner it pleases, an LSM can offer
configuration of an instance of its security namespace with an LSM
specific pseudo-filesystem interface.

If a centralized namespace separation is pursued, what will be
required is a method for loading policy/configuration before execution
starts in the context of the namespace.

> > What we hear from people doing Kubernetes, at scale, is a desire to be
> > able to request that a container be run somewhere in the hardware
> > resource pool and for that container to implement a security model
> > specific to the needs of the workload running in that container.  In a
> > manner that is orthogonal from other security policies that may be in
> > effect for other workloads, on the host or in other containers.

> That sounds to me like they want per-container security policy. That
> would require that the kernel have the 'concept' of a
> container. That's not something I expect to see in my lifetime.

Per-container security policy is the expectation that will be raised
by the creation of LSM namespaces.  We can speak very directly to that
fact, from conversations with groups that are running fleets of
thousands of virtual machines supporting tens of thousands of
container instances.

A 'container' is a set of kernel resource domains applied to an
execution workload.  An LSM namespace will be another resource domain
that is placed around the workload by an orchestration system.

Speaking from personal implementation experience.  If the LSM
namespace is entered and configured before the container runtime
engine is started, you have in effect, created a per container
security policy for that workload.

There are a plethora of issues surrounding this but it may be best to
leave those to further evolution of this discussion.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
