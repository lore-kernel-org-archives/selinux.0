Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37E937DEBA;
	Sun, 29 Mar 2026 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774802340; cv=none; b=g9cOwaNRNnA+SUnIg3VDSLKTJijJdW5iHkTn9smMpZNbUmM9X71YusYjTETAbZ0Oz9Vy7fsS7WS+1H+aWoSw/Z2/qseyNtLUUqf+P3S4Lloa2CKQaXmfCCiC1+4xeYR7N9ey9k99tUk6m1kCFX9xmwYuGJ9otXYIuFFNNV0fqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774802340; c=relaxed/simple;
	bh=bvuMG18vSTngMmD7ud2D3+CBJw2XOX4U6aerD0oDXpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6kiLI5LLlVXF3EdHLU9zEVrXGhctV8XHgFSHatmmEhVCh3Hm5yXNoT7SBWXrXpN9PsgGFAdV648rgXdNdQDT2dp1kodGMHp2fLgDrLfQWyemmqgCxLomV4jRokwHb9hPtZaavZjkUXQ7SQSPiw24SuaON5jIpgGq0k9UK/KNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 62TG9QEK008736;
	Sun, 29 Mar 2026 11:09:26 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 62TG9PjZ008735;
	Sun, 29 Mar 2026 11:09:25 -0500
Date: Sun, 29 Mar 2026 11:09:25 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <aclOtS61nbG5Wf3p@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
 <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
 <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
 <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRgi8_gdx0nKwkOws1VD6EFG+bHNTN5Q8YCxZ3HOCu5PQ@mail.gmail.com>
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sun, 29 Mar 2026 11:09:26 -0500 (CDT)

On Tue, Mar 24, 2026 at 05:31:09PM -0400, Paul Moore wrote:

Good afternoon, I hope the weekend has gone well for everyone.

A few comments on the LSM namespace architecture for when the current
overlayfs drama subsides... :-)

> On Tue, Mar 3, 2026 at 11:46???AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > I'd really like to hear from some of the other LSMs before we start
> > diving into the code.  It may sound funny, but from my perspective
> > doing the work to get the API definition "right" is far more important
> > than implementing it.

> It's been three weeks now, and I haven't seen any strong arguments for
> supporting the clone() API at this time, so we can leave that out for
> now and stick with just the unshare() API for an initial attempt.  We
> can always add a clone() API at a later date if needed; going small
> and expanding over time is usually a better decision anyway.
> 
> So to quickly summarize, here is where I think the discussion landed:
> 
> * Implement the lsm_unshare() syscall
> 
> I expect it would look something like 'lsm_unshare(struct lsm_ctx
> *ctx, u32 size, u32 flags)' with @ctx specifying the particular LSM
> being unshared, and @flags being 0/unused at this point in time
> (unless we can think of something we want to specify here).  Like
> lsm_set_self_attr(), only one @ctx can be specified at a time, so you
> can only unshare one LSM at a time.

Unless we miss something, it would seem that there needs to be
additional thought as to how a process moves, atomically, from one
effective security configuration to the next.

At a minimum, if we restrict ourselves to the model of simply changing
the namespace for a single LSM, there would seem to be a need to have
a 2-step process in order to atomically transition from one security
model/policy to the next.

The logical first step would seem to be to signal an LSM that a
namespace change is impending, with the second step being to tell the
LSM to actually execute the transition.

Presumably in the first step, an LSM would allocate an LSM namespace
memory blob for the new security context and it would also seem like a
good place to determine whether or not the namespace change should be
allowed, secondary to an understanding of possible TOCTOU issues.

The interim between the first and second steps would allow an
orchestrator to configure the new namespace and load new namespace
specific policy into the security namespace blob allocated in the
first step.

It would seem that the flags variable might be a good option to use to
handle this 2-stage transition, for example LSM_NS_INIT and
LSM_NS_CHANGE, respectively, to specify the initialization and
execution phases of the transition.

A simple unshare call becomes much more problematic in the face of an
orchestrator that may wish to create a set of new LSM namespaces for a
new process/container environment.  The inability to atomically
activate the entire new representation of the LSM stack would seem to
be problematic.

The other unanswered issue, or perhaps we missed it, are the security
controls that should be associated with the unshare call.

For example:

Will there be a new LSM hook that allows other LSM's to veto the
creation of a namespace either for itself or for another LSM?  We've
mentioned this before, but it would seem logical that the ability to
deny a change in overall system security policy would be something
that the 'lockdown' LSM would want to do.

Is there a need to have yet another kernel command-line parameter that
would completely deny the ability to create security namespaces?

Is CAP_MAC_ADMIN appropriate as the required capability to create a
new namespace or does there need to be, for security rigor, a specific
capability (CAP_LSM_NS?) that gates the ability to execute whatever
form of the system call is adopted?

Should there be an option to completely compile LSM namespaces out of
the kernel?

> * Implement /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
> 
> As discussed previously, this allows us to move a process into an
> existing, established LSM namespace set.  The caller cannot
> selectively choose which individual LSM namespaces they join from the
> given LSM namespace set, they receive the same LSM namespace
> configuration as the target process.

As an initial aside.  It would be assumed that a positive result of a
setns call would be to cause the calling process to atomically change
its security namespace set.  This would further suggest the need to
have the security namespace creation process also execute atomically
in a multi-LSM namespace change environment.

We may be the only group that has significant field experience with
this, but when it comes to LSM security namespaces, there is a larger
security issue at hand.  That is the concept of whether or not a setns
call, for any resource namespace, should also force a security
namespace change if the security namespace of the calling process
differs from that of the target process.

This, of course, runs up against the meme that containers are not a
kernel concept, but it seems safe to assume, for all practical
purposes, that this horse has bolted from the barn.

A gedanken experiment that should be near and dear to participants in
this conversation, Microsoft's Confidential Containers.

The current predicate for 'trust' based architectures is cryptographic
based integrity measurements and attestation.  If a resource
orchestrator has elected to place a container workload in an alternate
integrity namespace, should another process be allowed to enter, for
example the mount namespace of that process, without also entering
the integrity namespace for the process.

That is just the tip of the iceberg on this issue.

> Any comments, corrections, etc.?  If not, if someone wants to send me
> a patch{set} implementing these changes we can merge them into
> lsm/dev-staging until we have a LSM which implements support for the
> new API.

The above issues come from 10 years of experience in dealing with all
of the issues that arise, particularly in production environments,
with security namespaces.

Without solid answers to these issues the community would be remiss in
cementing down any API's, perhaps that is not a challenge with
existence only in staging.

We would be happy to test fire any API's, but if operational sentiment
is that only in-kernel LSM's and experience are relevant, the odds are
that this functionality isn't going to get done right.  The number of
individuals/people with first hand practical experience with these
issues can probably be comfortably enumerated with one hand.

> paul-moore.com

Have a good week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
