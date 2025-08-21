Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922123054E0;
	Thu, 21 Aug 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775540; cv=none; b=MxoIzkj/RtKxhK5TYbuVVpXrQbUsf3g7ZdEpaylmSLZrGKVkj7PvN1NulCbg9tU69NzkeQ7/xq9znLwDpaTpSqys60a6+lCYJ/agmMRnOonQxWAfIgkhheeov1vgkFcysrw6ugF/WWSs9A9+CKLqt4KPT/j5n0T9cERQWIPY/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775540; c=relaxed/simple;
	bh=3aSDVqLgdzpgGlEgR3TiPrT5jO6i3NSV2fMp8nRPNGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9SGu5dgahjmUIouzvNpaq6/GfILgkfOLM25TLrW7gd1SXRj9SI8L28qmAKVOTDsOYQxr086uhilm7gaiAMqN7oCsHr05YpFtrl2Dl/qtdXF9Z1PuR9ntsoJRMa09WB4OC2cGe6yVEuSCAIv0oNIDVK9YYs4gBA6mCRuKyKyYkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 57LBKEDu031957;
	Thu, 21 Aug 2025 06:20:14 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 57LBKBVi031956;
	Thu, 21 Aug 2025 06:20:11 -0500
Date: Thu, 21 Aug 2025 06:20:11 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: LSM namespacing API
Message-ID: <20250821112011.GA31850@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 21 Aug 2025 06:20:14 -0500 (CDT)

On Tue, Aug 19, 2025 at 10:56:27AM -0400, Paul Moore wrote:

> Hello all,

Good morning, I hope the day is going well for everyone.

> As most of you are likely aware, Stephen Smalley has been working on
> adding namespace support to SELinux, and the work has now progressed
> to the point where a serious discussion on the API is warranted.  For
> those of you are unfamiliar with the details or Stephen's patchset, or
> simply need a refresher, he has some excellent documentation in his
> work-in-progress repo:
> 
> * https://github.com/stephensmalley/selinuxns
> 
> Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> about SELinux namespacing, you can watch the presentation here:
> 
> * https://www.youtube.com/watch?v=AwzGCOwxLoM
> 
> In the past you've heard me state, rather firmly at times, that I
> believe namespacing at the LSM framework layer to be a mistake,
> although if there is something that can be done to help facilitate the
> namespacing of individual LSMs at the framework layer, I would be
> supportive of that.  I think that a single LSM namespace API, similar
> to our recently added LSM syscalls, may be such a thing, so I'd like
> us to have a discussion to see if we all agree on that, and if so,
> what such an API might look like.
> 
> At LSS-NA this year, John Johansen and I had a brief discussion where
> he suggested a single LSM wide clone*(2) flag that individual LSM's
> could opt into via callbacks.  John is directly CC'd on this mail, so
> I'll let him expand on this idea.
> 
> While I agree with John that a fs based API is problematic (see all of
> our discussions around the LSM syscalls), I'm concerned that a single
> clone*(2) flag will significantly limit our flexibility around how
> individual LSMs are namespaced, something I don't want to see happen.
> This makes me wonder about the potential for expanding
> lsm_set_self_attr(2) to support a new LSM attribute that would support
> a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> provide a single LSM framework API for an unshare operation while also
> providing a mechanism to pass LSM specific via the lsm_ctx struct if
> needed.  Just as we do with the other LSM_ATTR_* flags today,
> individual LSMs can opt-in to the API fairly easily by providing a
> setselfattr() LSM callback.
> 
> Thoughts?

There has been an adage that traces back to the writings of George
Santayana in 1905 that seems relevant:

"Those who cannot remember the past are condemned to repeat it."

To that end, some input from more than a decade of our work on this
issue.  Some of our reflections below are relevant to issues being
covered in downstream components of this thread, particularly by John
in the last few hours.

We have had code on the table for three years with respect to the
problem of generic namespacing of security policy/model/architecture,
whatever one chooses to call it.

For everyone's reference, here are the URL's to the patch series:

V1:
https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t

V2:
https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

V3:
https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#t

V4:
https://lore.kernel.org/linux-security-module/20240826103728.3378-1-greg@enjellic.com/T/#t

We started this work about 13-15 years ago.  We initially described
our work and the need for it, 10 years ago almost to this day.  See
our 2015 paper at the Linux Security Summit in Seattle.

James Morris and Casey were in the first row, Stephen and a co-worker
from the NSA were in the second row, to the speakers left.

If one spends some time looking under the hood, TSEM is in large part
about providing a generic framework for running multiple, independent
and orthogonal security frameworks/policies/architectures, whatever
one chooses to call these entities.

The reason that we argue that TSEM is a generic framework, is that in
our internal work, we have ported the major LSM's, including the IMA
infrastructure, to run in isolated namespaces as plugins for TSEM's
notion of Trusted Modeling Agents (TMA's).  We also have ongoing work
that enables Kubernetes to dispatch workloads, using whatever LSM
based security policy that container developers desire for their
workloads.

Suffice it to say, we have howed a lot of ground on the issues
surrounding this, including issues surrounding production deployment
of this type of technology.

In our initial implementation, circa 2015, we adopted the approach of
using a CLONE_* flag and wired the implementation of security
namespaces into the rest of the namespace infrastructure.

During COVID, we re-architected the entire implementation and moved to
using a control file in the pseudo-filesystem that TSEM implements, we
have never looked back on this decision.

TSEM security workloads are a poster child for security namespaces
that require a number of different setup parameters.  A command verb
syntax with key=value pairs, written to a pseudo-file, has proven
itself to be the most flexible approach when setting up security
workloads.

With respect to namespace transition, we trigger the transition of a
process to a new namespace (unsharing) when the process issues the
request via the control file.  This has proven to be, at once, the
most straight forward and least security prone approach.

The other major, and thorny issue, is the notion of another process
'entering' a security namespace.  There are a ton of open issues to be
considered with this, the approach that we took that has worked well
to date, is the notion of a 'trust orchestrator' that has
responsibility for controlling the namespace.  Any manipulations or
control of the namespace are conducted through the orchestrator
process.

If anyone chooses to look at our implementation, you will find that we
'bless' the orchestrator process, at the time of namespace creation,
with access to the security namespace context control structure for
the namespace being created.  The orchestrator is the only entity that
can access the security state of the namespace, other than processes
within the namespace itself.

This significantly narrows the scope of vulnerability with respect to
who or what can manipulate a security namespace.  There are a number
of thorny issues, that we have not seen anyone mention, that surface
with respect to allowing entry into a security namespace by an
arbitrary process.  Believe me when I say we have found a number of
them by accident and incident.

So big picture.

Over a decade of experience with these issues, suggests that Paul's
premise that most of these issues are best left to specific LSM's that
elect to implement namespacing, is correct.

The challenge is that this situation ends up being all or nothing.

The actual amount of code involved in unsharing a namespace is so
trivial, in comparison to the work involved with setting up and
maintaining state information for a security namespace context, that
it seems to make little sense to implement this support at the level
of the LSM infrastructure itself.

If the decision is made to provide generic namespace support, other
than a request to create a namespace, it will rapidly become a
slippery slope with respect to the amount of infrastructure needed to
address the complexities associated with every security model being
different from every other.

The caveat to this is if our notion of a 'trust orchestrator' would be
deemed to have merit.  In that case, an LSM based namespace separation
architecture would provide a common point for the orchestrator to be
'blessed' with access to control of a namespace.

The other open issue is whether or not a separate capability should be
implemented that allows the creation of a new security namespace.  If
one paws through our TSEM submissions, one will see that we proposed
such a capability bit.

Casey noted, rather emphatically, that no new capabilities were going
to be implemented in Linux, particularly for what was described as a
'toy' project.  He indicated that CAP_MAC_ADMIN was the canonical
capability that should be used for manipulating LSM's.

We will be very interested in seeing how a discussion around this
evolves, as 'escaping' from an existing security context to a new one
is an extremely critical operation from a security perspective, if one
stands back and looks at the issue objectively.  If the concept of a
'security orchestrator' is embraced, it would make perfect sense for
the orchestrator to drop CAP_SEC_NS, or whatever it would be called,
and retain CAP_MAC_ADMIN in order to manage the namespace.

So lots of issues to consider; thorny, political and otherwise, on
multiple fronts.

> paul-moore.com

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

