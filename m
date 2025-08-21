Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE72E2EF7
	for <selinux@vger.kernel.org>; Thu, 21 Aug 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770463; cv=none; b=irD75XI1rLuDRtCEplyUisy9CCgLSypr/tJo4cPFgQ2mLqRgXtJAHBJEBd/h0ITI4CDUvk1yNuoi2nOuPw0hlhUj56QcXvSd2TjtNWWadjyxx6Q+GS/Jr0CjGMftJncJFl2Mi/LlH9yvsogMZ/JwvNi3ytVYs7+GJMGawrnbS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770463; c=relaxed/simple;
	bh=Idb9ZHyChsfRBR+tNt79yQz32xCRecrhfI92/Y7/RmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQyOd9MkpLEytrGsN9o0pThpWNNM1cVDoJvrKkdCn0loR2sJlPiqbIrY4Lz6x43iX29SE31KO9HsQ/P9c68zr6QjneypWRSQEirRCPdXdfozkvGFStujeyoTnLOGCqKWZwzHo4aR+JE8jgx9TGz/BbzmED5MT8MZ7paPXCtN2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=RQf25jFG; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="RQf25jFG"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c6zNT0DBBz8wL;
	Thu, 21 Aug 2025 12:00:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755770456;
	bh=1Sfbk0ujanptbS6mnwT3SpSlboWo6/xyKv6kMqmSG6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQf25jFGweivrYrZO2n1LULgPrZRIvgEpztLU3qDJ/UP+zJOkxEZtP+JIHg6+kXYn
	 KrzMmbhtV1pFXWYucIj1eumj7JvDyViBtOl4QwU4U54I1f6ikBT3GgQOamVpptGfKY
	 2ifPWcW0UJ+BTjcF3XAwOvs4LXV9HvVulCRn/XM8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c6zNS2KpSz4mX;
	Thu, 21 Aug 2025 12:00:56 +0200 (CEST)
Date: Thu, 21 Aug 2025 12:00:55 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: Re: LSM namespacing API
Message-ID: <20250820.xo0hee4Zeeyu@digikod.net>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
 <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Aug 19, 2025 at 02:40:52PM -0400, Paul Moore wrote:
> On Tue, Aug 19, 2025 at 1:11 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > The advantage of a clone flag is that the operation is atomic with
> > the other namespace flag based behaviors. Having a two step process
> >
> >         clone(); lsm_set_self_attr(); - or -
> >         lsm_set_self_attr(); clone();
> >
> > is going to lead to cases where neither order really works correctly.
> 
> I was envisioning something that works similarly to LSM_ATTR_EXEC
> where the unshare isn't immediate, but rather happens at a future
> event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
> LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().

The next unshare(2) would make more sense to me.

This deferred operation could be requested with a flag in
lsm_config_system_policy(2) instead:
https://lore.kernel.org/r/20250709080220.110947-1-maxime.belair@canonical.com
