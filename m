Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3BE552;
	Sat, 23 Aug 2025 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755970901; cv=none; b=oWG6Jpavn+/owc0YB3+A4NU2Aql31RRYjUJ8dab8uLG6SP9vggGv0Ae8T7WjcK43TVOTfTbEQrV7wDTgKJqGzTrWO/MPx+vomHumFBuSG512YZrnxtNesbUn7B8Vs44kGW7hPWXOxE/hx9sBYXY7vRwbAMwazYcLHcjpcttpTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755970901; c=relaxed/simple;
	bh=Xvr9IrPEglbACbyEUBHhwORvutq5JO4DS9Wxee73eGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBMWMSoLIZfLTvCE4he/tsH74nlL0naqdZFwUgoUpcnrYrdxEv9Hup/fFcRQm0eIGUbCR4ssDlV64UEe2iOBW1G6aPeLbWNyO8pscxjneyzU1f6XHxCXt9ASTIbcjGKDWh4G6XnG8kq4ptL4DY021kjJy7aNwwFRgpWGTZuTawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 57NHf6wm023363;
	Sat, 23 Aug 2025 12:41:06 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 57NHf1Rs023361;
	Sat, 23 Aug 2025 12:41:01 -0500
Date: Sat, 23 Aug 2025 12:41:01 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
        Micka??l Sala??n <mic@digikod.net>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Maxime B??lair <maxime.belair@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <20250823174101.GA22123@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com> <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com> <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com> <20250820.xo0hee4Zeeyu@digikod.net> <CAHC9VhSS1K0Zsq_ULP4sK9Okwthd+CO3vUdVPAf+F8FKfZsVqQ@mail.gmail.com> <5612ec76-9257-402b-ac98-bdc8a8287a60@schaufler-ca.com> <47fb07e3-5047-49dc-b5fa-83b4f82f9dce@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fb07e3-5047-49dc-b5fa-83b4f82f9dce@canonical.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 23 Aug 2025 12:41:06 -0500 (CDT)

On Fri, Aug 22, 2025 at 12:59:29PM -0700, John Johansen wrote:

Good morning, I hope the weekend is going well for everyone.

> On 8/22/25 07:47, Casey Schaufler wrote:
> >On 8/21/2025 7:14 PM, Paul Moore wrote:
> >>On Thu, Aug 21, 2025 at 6:00???AM Micka??l Sala??n <mic@digikod.net> 
> >>wrote:
> >>>On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
> >>>>On Tue, Aug 19, 2025 at 1:11???PM Casey Schaufler 
> >>>><casey@schaufler-ca.com> wrote:
> >>>>>The advantage of a clone flag is that the operation is atomic with
> >>>>>the other namespace flag based behaviors. Having a two step process
> >>>>>
> >>>>>         clone(); lsm_set_self_attr(); - or -
> >>>>>         lsm_set_self_attr(); clone();
> >>>>>
> >>>>>is going to lead to cases where neither order really works correctly.
> >>>>I was envisioning something that works similarly to LSM_ATTR_EXEC
> >>>>where the unshare isn't immediate, but rather happens at a future
> >>>>event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> >>>>LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().
> >>>The next unshare(2) would make more sense to me.
> >>That's definitely something to discuss.  I've been fairly loose on
> >>that in the discussion thus far, but as things are starting to settle
> >>on the lsm_set_self_attr(2) approach as one API, we should start to
> >>clarify that.
> >>
> >>>This deferred operation could be requested with a flag in
> >>>lsm_config_system_policy(2) instead:
> >>>https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical.com
> >>I want to keep the policy syscall work separate from the LSM namespace
> >>discussion as we don't want to require a policy load operation to
> >>create a new LSM namespace.  I think it's probably okay if the policy
> >>syscall work were to be namespace aware so that an orchestrator could
> >>load a LSM policy into a LSM namespace other than it's own, but that
> >>is still not overly dependent on what we are discussing here (yes,
> >>maybe it is a little, but only just so).
> >
> >Policy load and namespace manipulation *must* be kept separate. Smack
> >requires the ability to "load policy" at any time. Smack allows a process
> >to add "policy" to further restrict its own access, and does not require
> >a namespace change. There has been an implementation of namespaces for
> >Smack, but the developers disappeared quietly and sadly no one picked it
> >up. Introducing a requirement that LSMs support namespaces in order to
> >load policy beyond system initialization is a non-starter.

> yes the ability to load policy must be exist separately, however
> policy load could be made namespace aware so that a parent could
> inject policy into a child.

Policy or model load, specific to the subordinate namespace, will be
a necessity.

As Casey noted, some LSM namespaces will require configuration and
management calls well after the namespace has started.  Other LSM's
will want the configuration to be completed before the namespace
starts, with any further configurations to the namespace blocked.

There is a very valid security rationale for isolating the capability
for namespace separation from the capability that allows the
configuration of a security model.  It would be an entirely realistic
security objective for a namespace to block further separation
attempts, while still allowing for management operations to be
conducted in the context of the subordinate namespace.

Hence the rationale for splitting CAP_MAC_ADMIN from whatever name the
bike shedding process around the new capability naming process
produces.

> There is also an open question as to whether we need to allow, but
> not require, some kind of policy manipulation/injection with the
> creation of the LSM namespace so that the there is an atomic
> transition with entering the namespace. Is there a case where policy
> really needs to be present atomically with the creation of the
> namespace? If so we need to further break it down to
>
> 1. is it sufficient for the LSM to do it, without container manager
> guidance?  An inherit of policy, or already present policy that can be
> injected. Then we don't need policy load inject to be considered at
> the point of clone/unshare.
> 
> 2. do we need to let the container manager hint/load policy.

Policy load needs to be atomic with respect to namespace separation.
In other words, the policy needs to be in place when execution within
the context of the new security namespace begins.

A resource orchestrator will need the ability to load the new policy
that will be enforced into the context of the new namespace.

In the case of some model/integrity based LSM's, the security events
related to the policy load need to occur in the context of the parent
LSM namespace.

See the writings of Werner Karl Heisenberg for the reasoning behind
that... :-)

> So far I think the inherit/policy directed injection works for
> apparmor, and selinux. Container managers generally speaking have to
> additional setup after the container is created before running the
> work load, which means a separate load phase should be fine.
> 
> However I can see an argument for having policy in place when
> clone/unshare exit. Admittedly atm its largely around flexibility, and
> nebulous ill defined use cases. Just because something works for
> apparmor, selinux, and I think smack, doesn't mean it would work for
> all use cases.
> 
> But we also should add flexibility for flexibility just because we can
> see there might be some future utility for some future use case. It
> would certainly make the interface uglier, and more complicated, and I
> would hate to have to carry that without a concrete use case.
> 
> I think unless there is a solid use case for making clone/unshare
> policy aware we don't worry about it for now. A new interface can be
> add in the future if the capability is really needed.

We will respond more directly to the issue of clone, unshare and
external process entry, in the other thread where you initiated a
discussion of these issues.  We believe there is a strong argument to
be made that LSM namespace separation is a poor fit for the classic
fork/unshare model of the other resource namespaces.

Among other issues, a direct separation model places the complexity of
policy verification and loading in userspace.  As was noted above,
accounting for the security events related to the policy verification
and load process, in the orchestrator process, will be a requirement
for some integrity and functional models.

Have a good weekend.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

