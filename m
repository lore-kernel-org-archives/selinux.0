Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94C239E69;
	Thu, 21 Aug 2025 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745369; cv=none; b=MbLqIFxxP3MFiHgUvbz9h4lNsDdfwLFQi4eNy8dwA7TxPvJdizO4gDEPaD13FyQ+zEDrom/65PWXuMKJR3zDSwmFjtSJwqxkS4kPLoxs8gvCWMVJAfpPAEm1EepqhI4CR3spS6zN3Z6DqBa7ngrNOrjn2IhReVjDi4v8HBnWjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745369; c=relaxed/simple;
	bh=Er2Jiifa8fQX/s6VXcKy3r7LqVEcQDVJzhV3VYgqroA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPRr+dnzikNSpDTrZF3y9xUs+JJWT//+d7XZWNFv582lIQp+PJUzN98kIkwuueHa4JQXV8MLxYoE0W+XkfwHoVhW8buqI6y2+eyZxrCMeywwJLG2Zl1VqcsZ3Jt8XB5JHZC0wnA5Rq3z3OwVNwMIKVWorc0TEONoBIZulPcH6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id CEC05115; Wed, 20 Aug 2025 22:02:44 -0500 (CDT)
Date: Wed, 20 Aug 2025 22:02:44 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <aKaMVPbPrgUc7mtv@mail.hallyn.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
 <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR-5Rwg132UsLdpJgM0c51HYBrBDivBinw3YcYqe0QTKA@mail.gmail.com>

On Wed, Aug 20, 2025 at 10:35:42PM -0400, Paul Moore wrote:
> On Wed, Aug 20, 2025 at 10:05 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> > > On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> 
> ...
> 
> > > > Serge pointed out that we also will need an API to attach to an
> > > > existing SELinux namespace, which I captured here:
> > > > https://github.com/stephensmalley/selinuxns/issues/19
> > > > This is handled for other Linux namespaces by opening a pseudo file
> > > > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > > > do it.
> > >
> > > One option would be to have a the LSM framework return a LSM namespace
> > > "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> > > setns(2)-esque operation using lsm_set_self_attr(2) with that
> > > "handle".  We would need to figure out what would constitute a
> > > "handle" but let's just mark that as TBD for now with this approach (I
> > > think better options are available).
> >
> > The use case which would be complicated (not blocked) by this, is
> >
> > * a runtime creates a process p1
> >   * p1 unshares its lsm namespace
> > * runtime forks a debug/admin process p2
> >   * p2 wants to enter p1's namespace
> >
> > Of course the runtime could work around it by, before relinquishing
> > control of p1 to a new executable, returning the lsm_get_self_attr()
> > data to over a pipe.
> >
> > Note I don't think we should support setting another task's namespace,
> > only getting its namespace ID.
> >
> > > Since we have an existing LSM namespace combination, with processes
> > > running inside of it, it might be sufficient to simply support moving
> > > into an existing LSM namespace set with setns(2) using only a pidfd
> > > and a new CLONE_LSMNS flag (or similar, upstream might want this as
> > > CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> > > setns(2) caller to match that of the target pidfd.  We still wouldn't
> > > want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
> >
> > A part of me is telling (another part of) me that being able to setns
> > to a subset of the lsms could lead to privilege escapes through
> > weird policy configurations for the various LSMs.  In which case,
> > an all-or-nothing LSM setns might actually be preferable.
> 
> Sorry I probably wasn't as clear as I should have been, but my idea
> with using the existing procfs/setns(2) approach with a single
> CLONE_NEWLSM (name pending sufficient bikeshedding) was that the
> process being setns()'d would simply end up in the exact copy of the
> target process' LSM namespace configuration, it shouldn't be a new

Oh, I think I was being unclear - I thought the first option, using
lsm_set_self_attr(), would allow choosing a subset of LSMs to setns to.
In contrast, the pure setns with a single flag is less flexible, but
possibly safer.  So I typed there the result of my train of thought,
which is that your second suggestion is probably preferable.

> set/subset/configuration ... and I would expect us to have controls
> around that such that LSMs could enforce policy on a setns(2)
> operation that involved their LSM.


