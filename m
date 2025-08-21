Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9702874E8;
	Thu, 21 Aug 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786391; cv=none; b=ly33wz3/4l0o7/TEsAqw6OdegHkqbTMrejupR2VZpe7ZjnTpCZM+YhiCBtyi9yw6dFX/Uxm/Y4IoUlU/5RRIhaYo1xVcuK6B6HgMdOvyWoIgyukRHacWj7nCgLdhvOMLPARiFDiq+PUINuPrURAwiYO7MlEWqAMDvLSwuOKUVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786391; c=relaxed/simple;
	bh=13+DRQnejampEoRw06jf584x/eNFBywrewoDPMB90q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLR1nqJ3V2e8qR2dK8tGi5lt9hERh4jRtCLmwUONKtlGaaAqgEU2gz1L/O1gRVRtTN+kMHI3dooHL8c5Jeulj7+uXDpBk1k2Is8LAlQkYE+UbdnqKK3Nr/gt7KuLNmS/rgAKvIzKf0owUYQQ1bZdzCy8bVeqm6iD271KRjBG/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 879B4499; Thu, 21 Aug 2025 09:26:25 -0500 (CDT)
Date: Thu, 21 Aug 2025 09:26:25 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: John Johansen <john.johansen@canonical.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: LSM namespacing API
Message-ID: <aKcskclwVVe1X4kP@mail.hallyn.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e72960-c985-48e1-aaeb-a4286cc8508f@canonical.com>

On Thu, Aug 21, 2025 at 12:46:10AM -0700, John Johansen wrote:
> On 8/19/25 10:47, Stephen Smalley wrote:
> > On Tue, Aug 19, 2025 at 10:56 AM Paul Moore <paul@paul-moore.com> wrote:
> > > 
> > > Hello all,
> > > 
> > > As most of you are likely aware, Stephen Smalley has been working on
> > > adding namespace support to SELinux, and the work has now progressed
> > > to the point where a serious discussion on the API is warranted.  For
> > > those of you are unfamiliar with the details or Stephen's patchset, or
> > > simply need a refresher, he has some excellent documentation in his
> > > work-in-progress repo:
> > > 
> > > * https://github.com/stephensmalley/selinuxns
> > > 
> > > Stephen also gave a (pre-recorded) presentation at LSS-NA this year
> > > about SELinux namespacing, you can watch the presentation here:
> > > 
> > > * https://www.youtube.com/watch?v=AwzGCOwxLoM
> > > 
> > > In the past you've heard me state, rather firmly at times, that I
> > > believe namespacing at the LSM framework layer to be a mistake,
> > > although if there is something that can be done to help facilitate the
> > > namespacing of individual LSMs at the framework layer, I would be
> > > supportive of that.  I think that a single LSM namespace API, similar
> > > to our recently added LSM syscalls, may be such a thing, so I'd like
> > > us to have a discussion to see if we all agree on that, and if so,
> > > what such an API might look like.
> > > 
> > > At LSS-NA this year, John Johansen and I had a brief discussion where
> > > he suggested a single LSM wide clone*(2) flag that individual LSM's
> > > could opt into via callbacks.  John is directly CC'd on this mail, so
> > > I'll let him expand on this idea.
> > > 
> > > While I agree with John that a fs based API is problematic (see all of
> > > our discussions around the LSM syscalls), I'm concerned that a single
> > > clone*(2) flag will significantly limit our flexibility around how
> > > individual LSMs are namespaced, something I don't want to see happen.
> > > This makes me wonder about the potential for expanding
> > > lsm_set_self_attr(2) to support a new LSM attribute that would support
> > > a namespace "unshare" operation, e.g. LSM_ATTR_UNSHARE.  This would
> > > provide a single LSM framework API for an unshare operation while also
> > > providing a mechanism to pass LSM specific via the lsm_ctx struct if
> > > needed.  Just as we do with the other LSM_ATTR_* flags today,
> > > individual LSMs can opt-in to the API fairly easily by providing a
> > > setselfattr() LSM callback.
> > > 
> > > Thoughts?
> > 
> > I think we want to be able to unshare a specific security module
> > namespace without unsharing the others, i.e. just SELinux or just
> > AppArmor.
> 
> yes which is part of the problem with the single flag. That choice
> would be entirely at the policy level, without any input from userspace.

AIUI Paul's suggestion is the user can pre-set the details of which
lsms to unshare and how with the lsm_set_self_attr(), and then a
single CLONE_LSM effects that.

-serge
