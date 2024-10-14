Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE91AA7AF;
	Mon, 14 Oct 2024 21:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941739; cv=none; b=HgaxkllnVHSd7PZyzyE3Kj/aATyGk9D67rYizxlQp2K6ymwKGaeBHoxxzTdah6SvHe9CCHjTm1jXkIMkyHHJr0ddvAyjfaawJZr+ADnG95pBnTiBciOPjPWeaVNcl0AokaokytR9oWi6QZMmG+Lm+Bq9INxCroM5a+ncOLmunIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941739; c=relaxed/simple;
	bh=QMyBife+gcnqO0eW+6Pm94ukAcP4n02KobpnpnqFXjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjUOIx5LQeSeifPIy18rnAv/M2SroA/ouaofgcjXXDLnXDS7zDhT7qROL4vRWjRqrCUjeHrLyKGHt0PhyT3h7R5RrSQLMGO2oNa/d+35WwbUJHP2lkwRaO0GLVhJDWBw4OfqFJtKIB53aqj+PDqPjHlewJ5xiI6gtQWU6RMGxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 36A977BA; Mon, 14 Oct 2024 16:35:34 -0500 (CDT)
Date: Mon, 14 Oct 2024 16:35:34 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org, jmorris@namei.org,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	mic@digikod.net
Subject: Re: [PATCH v2 0/6] LSM: Replace secctx/len pairs with lsm_context
Message-ID: <20241014213534.GB1100381@mail.hallyn.com>
References: <20241014151450.73674-1-casey.ref@schaufler-ca.com>
 <20241014151450.73674-1-casey@schaufler-ca.com>
 <20241014212937.GA1100381@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014212937.GA1100381@mail.hallyn.com>

On Mon, Oct 14, 2024 at 04:29:37PM -0500, Serge E. Hallyn wrote:
> On Mon, Oct 14, 2024 at 08:14:44AM -0700, Casey Schaufler wrote:
> > LSM: Replace secctx/len pairs with lsm_context
> > 
> > Several of the Linux Security Module (LSM) interfaces use a pair of
> > pointers for transmitting security context data and data length. The
> > data passed is refered to as a security context.  While all existing
> > modules provide nul terminated strings, there is no requirement that
> > they to so. Hence, the length is necessary.
> > 
> > Security contexts are provided by a number of interfaces. The interface
> > security_release_secctx() is used when the caller is finished with the
> > data. Each of the security modules that provide security contexts manages
> > them differently. This was safe in the past, because only one security
> > module that provides security contexts is allowed to be active. To allow
> > multiple active modules that use security contexts it is necessary to
> > identify which security module created a security context. Adding a third
> > pointer to the interfaces for the LSM identification is not appealing.
> > 
> > A new structure, lsm_context, is created for use in these interfaces.
> > It includes three members: the data pointer, the data length and
> > the LSM ID of its creator. The interfaces that create contexts and
> > security_release_secctx() now use a pointer to an lsm_context instead
> > of a pointer pair.
> > 
> > The changes are mostly mechanical, and some scaffolding is used within
> > the patch set to allow for smaller individual patches.
> 
> Hey Casey,
> 
> so this set is not bisectable.  Applying just patch 1 will no compile, right?
> What is your plan for getting past that?  Squash some or all of them into one?
> Or are you planning a wider reorg of the patches down the line, once the
> basics of the end result are agreed upon?

Sorry, I may have misread that.  secids make my eyes glaze over.
