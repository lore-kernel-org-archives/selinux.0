Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58332D5C8B;
	Thu, 21 Aug 2025 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741923; cv=none; b=GJbYVvcdAnLFiOq4StQsnmqijjTDDfCxtD8NGJT59m/ggYWG+hQCSiK7RGm197E8gRp6oqML21957h1TvWexRyuTgT0De2/P5E3gJuRtpdsxIL8ePfE+e02pM/qvvwy4jN+gbF+mRDDNaIpTkw9HugHyy9Hd6XZk9JMiN2+keaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741923; c=relaxed/simple;
	bh=fq/NfVlYRVfigE7BdwSQj6XsZ9TBqyVOnrt9lfSwkE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=St5puMY/8h64Bl6DUuge5X1WSJPg+xRW5TxRFHLqMShGLdxZlI7YJW4Ngf9xDvvk0K5/E8sw8Z+tqzMn9s4SCB2X5ZKFttV1f02ERvj+vw0x5X33ACHomGTbcjNMvS2lYyQKojWU/WGdykFlV0qxnESp/J0ACyr62ZFPJ85UcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 184D1318; Wed, 20 Aug 2025 21:05:12 -0500 (CDT)
Date: Wed, 20 Aug 2025 21:05:12 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <aKZ+2NMx+ZQhpySY@mail.hallyn.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>

On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I think we want to be able to unshare a specific security module
> > namespace without unsharing the others, i.e. just SELinux or just
> > AppArmor.
> > Not sure if your suggestion above supports that already but wanted to note it.
> 
> The lsm_set_self_attr(2) approach allows for LSM specific unshare
> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
> two LSMs have implemented support (AppArmor and SELinux), and
> userspace can independently set the attribute as desired for each LSM.

Overall I really like the idea.

> > Serge pointed out that we also will need an API to attach to an
> > existing SELinux namespace, which I captured here:
> > https://github.com/stephensmalley/selinuxns/issues/19
> > This is handled for other Linux namespaces by opening a pseudo file
> > under /proc/pid/ns and invoking setns(2), so not sure how we want to
> > do it.
> 
> One option would be to have a the LSM framework return a LSM namespace
> "handle" for a given LSM using lsm_get_self_attr(2) and then do a
> setns(2)-esque operation using lsm_set_self_attr(2) with that
> "handle".  We would need to figure out what would constitute a
> "handle" but let's just mark that as TBD for now with this approach (I
> think better options are available).

The use case which would be complicated (not blocked) by this, is

* a runtime creates a process p1
  * p1 unshares its lsm namespace
* runtime forks a debug/admin process p2
  * p2 wants to enter p1's namespace

Of course the runtime could work around it by, before relinquishing
control of p1 to a new executable, returning the lsm_get_self_attr()
data to over a pipe.

Note I don't think we should support setting another task's namespace,
only getting its namespace ID.

> Since we have an existing LSM namespace combination, with processes
> running inside of it, it might be sufficient to simply support moving
> into an existing LSM namespace set with setns(2) using only a pidfd
> and a new CLONE_LSMNS flag (or similar, upstream might want this as
> CLONE_NEWLSM).  This would simply set the LSM namespace set for the
> setns(2) caller to match that of the target pidfd.  We still wouldn't
> want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().

A part of me is telling (another part of) me that being able to setns
to a subset of the lsms could lead to privilege escapes through
weird policy configurations for the various LSMs.  In which case,
an all-or-nothing LSM setns might actually be preferable.

I haven't thought of a concrete example, though.

> Any other ideas?
> 
> -- 
> paul-moore.com
