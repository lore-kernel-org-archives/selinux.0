Received: from wind.enjellic.com (wind.enjellic.com [67.230.224.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E234B662;
	Fri,  6 Mar 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.230.224.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820539; cv=none; b=tasmeYJmbEtZXUqP9qdSja7P6ZU8zEtk0jxxqoTRE9C4VQ1Dyj8RuRjNf4i6oeS2yUssMPdgwxBreWp0o27F6HOdArvJAlosyQJmPHQxVpfw8Co0FtlzkQx7mkoiCZmzYHEVDkxnfV3e7paR6Rj5kfjPW4nwc29MJcDIJnYBEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820539; c=relaxed/simple;
	bh=PoW2Hmsa3XJr2dYEOm5XJGVqWQqGKLvCDFKjYYNzGWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtSwdhU2M+vgleuT6w8EI0RRwoA5SKsNlaHxxjxh9+sxon8y8bS3+txCknMJZrArH4nmjSrECbG0UwPuafG2EaQDRJ7tArJgmGfP0l6ohjE4HEiZUcbpDR15OWBGvaVlemOUXyKqeSpijQErj1GvUr5nSG1mDAkBrsMJcy1NzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=67.230.224.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 626HmJCB010007;
	Fri, 6 Mar 2026 11:48:19 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 626HmFf3010004;
	Fri, 6 Mar 2026 11:48:15 -0600
Date: Fri, 6 Mar 2026 11:48:15 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <20260306174815.GA9953@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com> <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com> <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com> <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 06 Mar 2026 11:48:19 -0600 (CST)

On Tue, Mar 03, 2026 at 11:46:53AM -0500, Paul Moore wrote:

Good morning, I hope the week is winding down well for everyone.

> On Tue, Mar 3, 2026 at 8:30???AM Stephen Smalley
> > I think my only caveat here is that your proposal is quite a bit more
> > complex than what I implemented here:
> > [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley.work@gmail.com/
> > [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley.work@gmail.com/
> > and I'm not sure the extra complexity is worth it.
> >
> > In particular:
> > 1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
> > the caller to immediately and unambiguously know if the operation is
> > supported and allowed ...

> Performing the unshare operation immediately looks much less like a
> LSM attribute and more like its own syscall.  That isn't a problem
> in my eyes, it just means if this is the direction we want to go we
> should implement a lsm_unshare(2) API, or something similar.

Stephen's take on this is correct, the least complicated path forward
is a simple call, presumably lsm_unshare(2), that instructs the LSM(s)
to carry out whatever is needed to create a new security namespace.

There are only two public implementations of what can be referred to
as major security namespacing efforts; Stephen's work with SeLinux and
our TSEM implementation.  Given that both initiatives, which are
significantly different, independently settled on the same approach
seems to suggest it is a mechanism that enjoys successful field
experience.

The larger and more important question would seem to be what type of
common namespace infrastructure actions would be amortizable across
all the different types of security models that are supported by the
LSM infrastructure.

We haven't seen any further comments or patches out of what Christian
and Lennart are attempting to implement with respect to the concept of
a security namespace in order to support their Amutable initiative.
It seems reasonable that one of the common pieces of infrastructure
would be the allocation of a security namespace specific context of
data, i.e. an LSM security blob, that Christian had proposed patches
for.

Given the potential security implications of creating a security
namespace, we assume that the 'unshare' operation would call an LSM
hook that interrogated the current LSM stack for permission to do so.

For example, it would seem reasonable that the Lockdown LSM would want
the ability to block attempts to create alternate security namespaces.

> > 3. We don't need to introduce a new CLONE_* flag at all or introduce
> > new or changed LSM hooks to clone/unshare,
> 
> While I think we could get away with a new lsm_unshare(2) syscall, I
> have zero interest in an lsm_clone(2) syscall.  If we do away with the
> namespace related LSM attributes and rely entirely on a lsm_unshare(2)
> syscall, would everyone be okay with that?

We assume that there is agreement on the fact that an orchestrator
needs to have the ability to specify attributes or policy for the new
namespace that is being created.

Given that, there will be a need to be able specify the
characteristics that configure the new namespace which will go into
effect, atomically, at the time the proposed lsm_unshare(s) system
call executes.

For example, now that IMA is an LSM, it would be reasonable to assume
that the cryptographic hash function used for the integrity
measurements could be specified as part of the namespace setup call
for a new IMA namespace.

> (I think we would still want/need the procfs API)

That is only needed if there is a desire to support the ability of a
process to enter a security namespace that it is not part of.

That is potentially a useful feature, suffice it to say however, there
are a host of issues involved with this.  We've had significant field
experience with this concept and its implications, we don't get the
sense that the mainline LSM's have had the opportunity to understand
the implications of what this would mean.

> > All that said, I'm willing to wire up the SELinux namespaces
> > implementation to the proposed interface if someone implements the
> > necessary plumbing, but I'm not sure it's better.

> I'd really like to hear from some of the other LSMs before we start
> diving into the code.  It may sound funny, but from my perspective
> doing the work to get the API definition "right" is far more
> important than implementing it.

It isn't funny, it is pragmatic, particularily in this case.

The primary challenge will be the tension that exists between the fact
that there is no practical field experience with security namespacing,
particularily with respect to its security implications, in the
mainline kernel and the Linux userspace guarantee policy, that once an
API/ABI becomes visible to userspace it cannot be changed.

At this point in time the most basic and common security namespace
infrastructure to get right and lay down would seem to be three fold:

1.) A security check for whether or not namespace creation should be
allowed.

2.) The ability to specify characteristics of a new security namespace
and to invoke those atomically when a process requests that a new
security namespace be created.

3.) Allocation of an LSM namespace 'blob' of memory that can be used
to implement the security context for the new namespace.

TSEM obviously isn't in the kernel, so understandably, our perspective
may not hold much value in these quarters.

It is, however, the most significant security namespace implementation
that has been done for Linux, with respect to its scope and
capabilities.  Perhaps most importantly, we have had ten years of
experience dealing with all of these issues and their implications,
particularly from a security perspective.

Given that, we would be happy to test fire TSEM against any proposed
infrastructure changes that focus on the generic needs of security
namespacing.

> paul-moore.com

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
