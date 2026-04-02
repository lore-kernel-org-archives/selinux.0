Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD7397E76;
	Thu,  2 Apr 2026 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127628; cv=none; b=MkBePKaj7TYFt9iuje/99YJH/j99BXUuq60kvhpLTDd8eC5CDfKHOJXvYamX/2aTYQlas/vRpP1lhyFjvXZju4c+HBQHuA+EqwomMwTkYjGaVZiXzimNr1v1TChjYJIyNybeArPx4p0TrV1dRWZdiGDWfDHUHWM5W8LsW94uNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127628; c=relaxed/simple;
	bh=a6vLE41elDgPcgHiS6VMOv9fJZqbHj8JG7BuxEoHT4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN6FRcAbQJZX0w996VMejgN7tfpEtxiw+E8t3viGdINfYSkfYuUpWCCQNu7XxmixQNvKwn0lFlL+0N57bGPZwFzR75EJzfPAV1QoTb5S4VfFGex9gbVEQC7GsPqOQgk71iUrvh69AWyg1TJlZWTmKrKHf9jD2cFVme2EY2gBcMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 632Axtx8008494;
	Thu, 2 Apr 2026 05:59:55 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 632AxsTm008491;
	Thu, 2 Apr 2026 05:59:54 -0500
Date: Thu, 2 Apr 2026 05:59:54 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <ac5MKr4lFQhc44i6@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
 <aclOtS61nbG5Wf3p@wind.enjellic.com>
 <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR1R7TcC2a2wZ9-G8dmXTuhcDK1YedDduq0sFgPC8QxFw@mail.gmail.com>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 02 Apr 2026 05:59:55 -0500 (CDT)

On Sun, Mar 29, 2026 at 08:56:37PM -0400, Paul Moore wrote:

Good morning, hopefully the week is going well for everyone.

> On Sun, Mar 29, 2026 at 12:09???PM Dr. Greg <greg@enjellic.com> wrote:
> > On Tue, Mar 24, 2026 at 05:31:09PM -0400, Paul Moore wrote:
> > > On Tue, Mar 3, 2026 at 11:46???AM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > I'd really like to hear from some of the other LSMs before we start
> > > > diving into the code.  It may sound funny, but from my perspective
> > > > doing the work to get the API definition "right" is far more important
> > > > than implementing it.
> >
> > > It's been three weeks now, and I haven't seen any strong arguments for
> > > supporting the clone() API at this time, so we can leave that out for
> > > now and stick with just the unshare() API for an initial attempt.  We
> > > can always add a clone() API at a later date if needed; going small
> > > and expanding over time is usually a better decision anyway.
> > >
> > > So to quickly summarize, here is where I think the discussion landed:
> > >
> > > * Implement the lsm_unshare() syscall
> > >
> > > I expect it would look something like 'lsm_unshare(struct lsm_ctx
> > > *ctx, u32 size, u32 flags)' with @ctx specifying the particular LSM
> > > being unshared, and @flags being 0/unused at this point in time
> > > (unless we can think of something we want to specify here).  Like
> > > lsm_set_self_attr(), only one @ctx can be specified at a time, so you
> > > can only unshare one LSM at a time.
> >
> > Unless we miss something, it would seem that there needs to be
> > additional thought as to how a process moves, atomically, from one
> > effective security configuration to the next.
> >
> > At a minimum, if we restrict ourselves to the model of simply changing
> > the namespace for a single LSM, there would seem to be a need to have
> > a 2-step process in order to atomically transition from one security
> > model/policy to the next.

> That depends on the individual LSMs, they are free to interpret the
> unshare request and handle it however they like.

No argument there.

An LSM will obviously need to allocate an LSM namespace specific
security 'blob' in order to hold the security context for the new
namespace.

Christian had proposed patches for a generic mechanism to create
LSM security namespace blobs, is implementation of that in scope for
this effort?

> > The interim between the first and second steps would allow an
> > orchestrator to configure the new namespace and load new namespace
> > specific policy into the security namespace ...

> As discussed previously, the LSM policy load syscalls might include
> some LSM namespace options. However, I first want to focus on
> finalizing the most basic namespace API, which on Linux is arguably
> the unshare() syscall concept.

Unfortunately, without considering all the implications and
requirements of various LSM's we may end up with lsm_share2() and
beyond.

See below.

> > It would seem that the flags variable might be a good option to use to
> > handle this 2-stage transition, for example LSM_NS_INIT and
> > LSM_NS_CHANGE, respectively, to specify the initialization and
> > execution phases of the transition.

> No.  The lsm_unshare() syscall is intended to mimic the existing
> unshare() syscall as a single step process from a user's
> perspective.  If it returns successfully the caller will be in a new
> LSM namespace as defined by the individual LSM specified in the
> syscall.

OK, we can reason forward with that paradigm.

An orchestrator issues the unshare call for an LSM namespace and upon
return from the system call the calling task is in a new namespace for
that particular LSM, the goal of which is presumably to implement a
security policy/model different than what had been in force
previously.

So the process is in a new LSM specific namespace, but still
implementing the policy from the previous namespace, until the
orchestrator can load the new policy and then trigger the LSM to
change from its previous policy to the newly loaded policy.

Is this consistent with your vision as to how all of this will work?

> > The other unanswered issue, or perhaps we missed it, are the security
> > controls that should be associated with the unshare call.

> Each LSM is free to implement whatever access controls it deems
> necessary in its lsm_unshare() callback.

Just to be clear.

When you refer to 'lsm_unshare() callback' are you referring to a new
LSM security hook to be be implemented that will allow all of the
active LSM's to pass judgement on whether or not the unshare should be
allowed to complete successfully?

See below.

> > Will there be a new LSM hook that allows other LSM's to veto the
> > creation of a namespace either for itself or for another LSM?
> 
> I would expect the lsm_unshare() syscall to operate similarly to the
> lsm_set_self_attr() syscall in this regard.

The reference to handling this like lsm_set_self_attr() is unclear.

With lsm_set_self_attr() there is no reason for another LSM to deny
setting what is an LSM specific attribute, as you note above, each LSM
gets to decide if the request to set an attribute for the LSM should
be accepted or denied.

Since lsm_unshare() is changing the overall platform security state,
it seems consistent with the design of the LSM for other LSM's to be
able to veto this action.

Once again, this seems like an action that would be consistent with
the notion of the lockdown LSM,

> > Is there a need to have yet another kernel command-line parameter that
> > would completely deny the ability to create security namespaces?

> No, at least not at this point in time.

This would seem to reinforce issues in the previous discussion.

Given that distributions are 'kitchen sink' implementations it would
seem desirable that system security architects would want to use a
lockdown option to insure that the platform security configuration
cannot be changed.

> Individual LSMs can decide how they want to gate their own namespace
> functionality, if they implement namespaces at all.
> 
> > Is CAP_MAC_ADMIN appropriate as the required capability to create a
> > new namespace or does there need to be, for security rigor, a specific
> > capability (CAP_LSM_NS?) that gates the ability to execute whatever
> > form of the system call is adopted?

> Once again, this is up to the individual LSMs, not the framework
> layer.

Fair enough.

That still leaves the question of whether or not CAP_MAC_ADMIN is
appropriate for gating the creation of a new security namespace.

> > Should there be an option to completely compile LSM namespaces out of
> > the kernel?

> That doesn't belong in the LSM framework layer, that is up to the
> individual LSMs.

You noted above the desire for lsm_unshare to be consistent with other
namespaces.

The current kernel paradigm is to allow classes of namespace
resources, ie. CONFIG_UTS_NS, CONFIG_TIME_NS et.al., to be compiled in
our out of the kernel.

It seems that CONFIG_LSM_NS would be consistent with that model.

> > > * Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
> > >
> > > As discussed previously, this allows us to move a process into an
> > > existing, established LSM namespace set.  The caller cannot
> > > selectively choose which individual LSM namespaces they join from the
> > > given LSM namespace set, they receive the same LSM namespace
> > > configuration as the target process.
> >
> > As an initial aside.  It would be assumed that a positive result of a
> > setns call would be to cause the calling process to atomically change
> > its security namespace set.  This would further suggest the need to
> > have the security namespace creation process also execute atomically
> > in a multi-LSM namespace change environment.

> In the setns case no new LSM namespaces should be created, the process
> simply joins an existing set of LSM namespaces.

The issue isn't about new namespaces being created, the issue is
atomicity of a change to a new set of security policies.

With setns an atomic transition is implemented.

The proposed lsm_unshare() behavior results in a period of time when
multiple and varying security policies are active, depending on
various race issues in the orchestrator implementation.

This opens the door to a raft of potential security issues that we can
have a new acronym for, Time Of Implementation Time Of Use (TOITOU).

> > ... That is the concept of whether or not a setns
> > call, for any resource namespace, should also force a security
> > namespace change if the security namespace of the calling process
> > differs from that of the target process.

> That decision is left to the individual LSMs.

That is reasonable.

In order to support that model, there would seem to be a need to have
a new LSM call in the setns code that allows LSM's to determine
whether or not a change in the active security namespace set should be
forced, correct?

If so, is implementation of this in scope for the lsm_unshare()
infrastructure?

To close, at the risk of being the devils advocate.

Given that the sentiment is to force almost all of these
issues/decisions into the individual LSM's, what is the advantage of
having a common lsm_unshare() system call?

In the proposed model, a resource orchestrator is going to need to
have extensive knowledge over the mechanics of all the LSM's that
implement namespace functionality.  At a very minimum, intrinsic to
the concept of security namespaces, there will be a need to load a new
policy or model into the namespace, an action that will be deeply LSM
specific.

At this point, the only common functionality may be the allocation of
a new LSM namespace 'blob'.  An argument for not doing that in
lsm_unshare() is that it precludes the ability of an orchestrator to
implement an atomic policy change, as that would require an
orchestrator to somehow load a policy/model before lsm_unshare() is
called, which in turn would require a new security context to be
allocated prior to the unshare operation.

All of this tends to be an issue with integrity or measurement based
namespaces, which are important with respect to supporting
confidential computing initiatives.  Without two stage namespace
transition, you stumble into subtle problems associated with
'Heisenberg dilemma' issues.

> paul-moore.com

Hopefully all of this will assist in defining the requirements for all
of this.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
