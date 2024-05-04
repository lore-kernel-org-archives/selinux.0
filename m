Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13B33989;
	Sat,  4 May 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714855105; cv=none; b=vFicuwIRztp2ehrK5lMSYC4W3E6BkCnC5YzVvUEUJjmfRQjiWugfcVyR24K/DQ6aNLhagqqQBqmeQQNgxdG8kGnv1A8rWpP6mSbfzo6bNdps8RJz0bk2Lm5UimkEiAovWqbpZEqkVnJrsuvgOB9zOH/kgCNTCOBXpRrFf4TcTAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714855105; c=relaxed/simple;
	bh=hl4YILf2+u1AeQMDEUy9HqlBh2ZXp88E08H0EBun/XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eojKaqNkVJmo/zwWQN9Vq8V8iV38tfBeR86Tyaxd9UpJ0IeA4zsepjKMWH9KbH87Cjm9vHHIdiHKWt33GNt28qCXorZpUAuQkmmD7liSDwNZl+KqgaCymTW+VcXCJd8RmxHACLvwDk9ndg1U/tbWUYd+jla/qSFk3zLP2HI3ZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 940C63F4; Sat,  4 May 2024 15:38:20 -0500 (CDT)
Date: Sat, 4 May 2024 15:38:20 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <serge@hallyn.com>, selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Felix Fu <fuzhen5@huawei.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
Message-ID: <20240504203820.GA1488570@mail.hallyn.com>
References: <20240503005850.466144-2-paul@paul-moore.com>
 <720925eb-98f5-4ef7-b064-14e1edf6aeaa@hallyn.com>
 <18f45490f18.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f45490f18.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>

On Sat, May 04, 2024 at 04:26:24PM -0400, Paul Moore wrote:
> On May 4, 2024 1:04:57 PM Serge Hallyn <serge@hallyn.com> wrote:
> > Hm, so if it should happen that lsm 2 returns 0 (allow) but lsm 3
> > has skipcap return 3, and lsm 3 would have returned
> > 1 to deny the remove, we will get an unexpected result.  It feels like
> > we need a stronger tie between the lsm which allowed and the one
> > saying skip the capability check.
> 
> That's not an unexpected result, that is a valid outcome in the world of LSM
> stacking. The skipcap check only guarantees that the capability check will
> be skipped if an LSM returns a non-zero value.  The vast majority (all?) of
> the hooks operate as you describe: a LSM towards the back of the list can
> reject an operation that was previous LSM has allowed.  This isn't limited
> to LSMs either, there are plenty of reasons, e.g. transient failures, which
> could cause an operation to fail after being authorized by a particular LSM.
> 
> A particular LSM can only authorize a requested operation; a successful
> return value from a LSM hook implementation can not guarantee a successful
> operation result.

Ok, thanks.

-serge
