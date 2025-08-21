Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7719C542
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770213; cv=none; b=a0/vV3xTogi7o/a1Ht/mNGBcoRbG2YPHnv76c0IHF7ytx2cDGfo0iJSDbT0DxnWyfVXVLZLP+SqjuyAOM1OTW9D3S8FXrQezLJt67YPDrcl2h9bVJ1KHb/lwi71/sf0ABGBAbBPlmrw+BOmH6J1Rs936vG3pZRuMyhGY5ULkqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770213; c=relaxed/simple;
	bh=RD++S/2gB9rhfpyLLace3/VKTHkKstFCChwuvbgMXtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnKEd24TxWJnVFjvbyAsRCjQtwfphh2Y+0+O6mrrYCpKXw1+O1qJ3PYN0rYqjWxCeBt0hQnMc9zHEnNAW3UBGKgqel29NYE7jvyuaVTYhYZMEGnGQj3TCEanqv8bjIZf/LlEIva8aUpPhduHpAQCBVHcK97+bM5+iquOEh0ebBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ZlTa45mg; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ZlTa45mg"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c6zHb0XS5z7n0;
	Thu, 21 Aug 2025 11:56:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755770202;
	bh=CcF96cTH8TvqDj/jopGA6l4dQnniN37SmQZfVrjgA5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlTa45mgBaEvPksgDV0n5FHogncwebFkXt9a/LeLPx5oGamuvY2fhbBoeymZaf/Xm
	 A8tC2rG5tvEnfO5/4qx3+7AvKkEzqg9mSO4lQGO6mCq3TE/nXcgaUbBa2kwTNtkeaN
	 bP1TCVhn+D+cKhN1mAVSSJSvJQgkvERz0AgsSndg=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4c6zHZ3BYyzV3X;
	Thu, 21 Aug 2025 11:56:42 +0200 (CEST)
Date: Thu, 21 Aug 2025 11:56:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <20250821.Ree4Liedeita@digikod.net>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <20250820.ieNg1quoRouz@digikod.net>
 <CAHC9VhS3c257ywxADRzPYE-DsXSwRp8P2RhAfdDnXJHOX5bXTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhS3c257ywxADRzPYE-DsXSwRp8P2RhAfdDnXJHOX5bXTQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Aug 20, 2025 at 04:47:15PM -0400, Paul Moore wrote:
> On Wed, Aug 20, 2025 at 10:44 AM Mickaël Salaün <mic@digikod.net> wrote:
> > On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > > On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> 
> ...
> 
> > > Since we have an existing LSM namespace combination, with processes
> > > running inside of it, it might be sufficient to simply support moving
> > > into an existing LSM namespace set with setns(2) using only a pidfd
> > > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> >
> > Bike shedding but, I would prefer CLONE_NEWSEC or something without LSM
> > because the goal is not to add a new LSM but a new "security" namespace.
> 
> I disagree with your statement about the goal.  In fact I would argue
> that one of the goals is to explicitly *not* create a generic
> "security" namespace.  Defining a single, LSM-wide namespace, is
> already an almost impossible task, extending it to become a generic
> "security" namespace seems maddening.

I didn't suggest a generic "security" namespace that would include
non-LSM access checks, just using the name "security" instead of "LSM",
but never mind.

> 
> > > setns(2) caller to match that of the target pidfd.  We still wouldn't
> > > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
> >
> > Why making clone*() support this flag would be an issue?
> 
> With the understanding that I'm not going to support a single LSM-wide
> namespace (see my previous comments), we would need multiple flags for

I'm confused about the goal of this thread...  When I read namespace I
think about the user space interface that enables to tie a set of
processes to ambient kernel objects.  I'm not suggesting to force all
LSM to handle namespaces, but to have a unified user space interface
(i.e. namespace flag, file descriptor...) that can be used by user space
to request a new "context" that may or may not be used by running LSMs.

> clone*(), one for each LSM that wanted to implement a namespace.

My understanding of this proposal was to create a LSM-wide namespace,
and one of the reason was to avoid one namespace per LSM.  As I
explained in my previous email, I think it would make sense and could be
convincing.

> While clone3() has expanded the number of flag bits from clone(),
> there is still a limitation of 64-bits and I'm fairly certain the
> other kernel devs are not going to be supportive of a flag for each
> LSM that wants one.
> 
> Maybe we could argue for our own u64 in cl_args, or create our own
> lsm_clone(2) syscall that mimics clone3(2) with better LSM support,
> but neither of these seem like great ideas at the moment.

My idea was that using CLONE_NEWLSM would just fork the current/initial
namespace used by LSMs to tie security policies/configurations to
processes, but as John already said, it would be the responsibility of
each LSM to either inherit and keep in sync the parent policy (e.g.
SELinux) or start with a blank/default one (e.g. Yama).

One way to configure a newly created namespace could be to load a
configuration in the parent namespace (e.g. with one of the new LSM
config syscall and a dedicated flag) that would only be applied to child
namespaces when they are created, similarly to attr/exec for execve(2).
I think this is what you meant with the LSM_UNSHARE flag, right?

> 
> > > Any other ideas?
> >
> > The goal of a namespace is to configure absolute references (e.g. file
> > path, network address, PID, time).  I think it would make sense to have
> > an LSM/MAC/SEC namespace that would enforce a consistent access control
> > on every processes in this namespace.
> 
> Once again, I'm not going to support the idea of a namespace at the
> LSM framework layer, individual LSMs are better suited to implementing
> their own namespacing concepts.  However, I do support the LSM
> framework providing an API and/or helpers to help make it easier for
> individual LSMs and userspace to create/manage individual LSM
> namespaces.

Should we still talk about "namespace" or use another name?

> 
> > A related namespace file
> > descriptor could then be used with an LSM-specific syscall to configure
> > the policy related to a specific namespace (instead of only the current
> > namespace)
> 
> That is a reasonable request, and I think the same underlying solution
> that we would use for setns(2) could also be used here.

I'm not sure having a set of namespace file descriptors without related
clone flags would be acceptable, at least for what we currently call
Linux "namespace".
