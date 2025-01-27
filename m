Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F842A1BB
	for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 03:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737948637; cv=none; b=OGPGfRvcHWAN+fHpQJZ/IzOSmxyLdDHXKpL6AAT6o0WZRkvP+C1cjGiHXmi9B4EZXpsuMgjJ8rPnz0itwhGHKQ+jaOh8X+0tsY88iqSdegfXkeGAstcxG3Y8h+9WXz/NeUeU0K7UsjuUopXtkUhHnZYwUoebm6jSPoMZraSrcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737948637; c=relaxed/simple;
	bh=rhJyQx5bw6wx7cO3wC+ZDeQsWeHNOuyKuimn7rVCRE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN2ynqGt9lEDbnGJtjxGehfkWr1g3t79cV494fZi87pH47RHstvB1OL4wNUcrdSCaEAQDySBuTgADV2esxjfjX0u7MC6POj/orncfWRnck7nwbOOdriciinxuMeYm8fGQEKw770OGUlOg2eV3/qFd61PzpLkfppUV9ZtseE3+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiHIcn2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiHIcn2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A2AC4CED2;
	Mon, 27 Jan 2025 03:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737948637;
	bh=rhJyQx5bw6wx7cO3wC+ZDeQsWeHNOuyKuimn7rVCRE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiHIcn2k1CBJ3MnCNCDCtiESzVEzSrt+xlC8Dj3MXUrPgFtqm1fQTNyAaBQs++h+m
	 82ezku+pt+luvNesGm2UNLZjczgjIg8cT+kKFazEi5BzyJ3tYM+JX72TVkl3a1JXys
	 bWm7xWXMPYHFnyrTImfl9AYdsIx9TScOkRy0NgU/YlTYo7wXPBKU8N5p+AZYff53VK
	 OTlgUqRhdcrknliHabA6Q4ecNGVTybN41dQEr1I/kNZQgP56TwVf1xuThqZdF86RVj
	 CB0plOa1AobxThoISXFDx23xvRCgZbPy8OPZTvmWl08kRDfJ4t3H4wXUpldN3BFbtO
	 g+jMsPlavzzhQ==
Date: Mon, 27 Jan 2025 03:30:33 +0000
From: sergeh@kernel.org
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Subject: Re: [RFC PATCH 05/44] netstate,selinux: create the selinux netlink
 socket per network namespace
Message-ID: <Z5b92VmV-tEM-MU-@lei>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
 <20250102164509.25606-6-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102164509.25606-6-stephen.smalley.work@gmail.com>

On Thu, Jan 02, 2025 at 11:44:30AM -0500, Stephen Smalley wrote:
> The selinux netlink socket is used to notify userspace of changes to
> the enforcing mode and policy reloads.  At present, these notifications
> are always sent to the initial network namespace.  In order to support
> multiple selinux namespaces, each with its own enforcing mode and
> policy, we need to create and use a separate selinux netlink socket
> for each network namespace.
> 
> Without this change, a policy reload in a child selinux namespace
> causes a notification to be sent to processes in the init namespace
> with a sequence number that may be higher than the policy sequence
> number for that namespace.  As a result, userspace AVC instances in
> the init namespace will then end up rejecting any further access
> vector results from its own security server instance due to the
> policy sequence number appearing to regress, which in turn causes
> all subsequent uncached access checks to fail.  Similarly,
> without this change, changing enforcing mode in the child selinux
> namespace triggers a notification to all userspace AVC instances
> in the init namespace that will switch their enforcing modes.
> 
> This change does alter SELinux behavior, since previously reloading
> policy or changing enforcing mode in a non-init network namespace would
> trigger a notification to processes in the init network namespace.
> However, this behavior is not being relied upon by existing userspace
> AFAICT and is arguably wrong regardless.
> 
> This change presumes that one will always unshare the network namespace
> when unsharing a new selinux namespace (the reverse is not required).
> Otherwise, the same inconsistencies could arise between the notifications
> and the relevant policy.  At present, nothing enforces this guarantee
> at the kernel level; it is left up to userspace (e.g. container runtimes).
> It is an open question as to whether this is a good idea or whether
> unsharing of the selinux namespace should automatically unshare the network

Is there any advantage to not enforcing that?  Something useful it might
facilitate?
