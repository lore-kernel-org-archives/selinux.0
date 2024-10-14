Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EF14B965;
	Mon, 14 Oct 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941388; cv=none; b=E1M3ewlPCFDskw7Bg1k2LRnqOL4zIVaf59D2W5Ugp2y3+sK3lr/jENjmUIgR/lxDV8wQgcB/+P0DwMAfDiQn8CX0pf7IIwVqfkH/8XdqDZ+sxUmmc8KfCpd48ZPDhzUsH5b0KON93+0GIoQsTVBKjWAhmQ6G6E+SfM5tw33JPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941388; c=relaxed/simple;
	bh=kejcbBQmCLrRfOdyP9u5bzjmXECWH71Iolf0jNAMyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KF1dKbatCR/W0tEgDcoJUz1w3i47BUdDMeg/l0YGMyGdkmvevUOidofsgQzEWmr9vYkEFZoaVatFK38eceCJNVovpoKgU/Zb8lJbVAtp/rrKPjOmkxGXYTqP/ty9sAwenKqfU++ZMRiGycIJw5UosXkTS3DkKojPUh4tuOCYBC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 0EF157BA; Mon, 14 Oct 2024 16:29:37 -0500 (CDT)
Date: Mon, 14 Oct 2024 16:29:37 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org,
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v2 0/6] LSM: Replace secctx/len pairs with lsm_context
Message-ID: <20241014212937.GA1100381@mail.hallyn.com>
References: <20241014151450.73674-1-casey.ref@schaufler-ca.com>
 <20241014151450.73674-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014151450.73674-1-casey@schaufler-ca.com>

On Mon, Oct 14, 2024 at 08:14:44AM -0700, Casey Schaufler wrote:
> LSM: Replace secctx/len pairs with lsm_context
> 
> Several of the Linux Security Module (LSM) interfaces use a pair of
> pointers for transmitting security context data and data length. The
> data passed is refered to as a security context.  While all existing
> modules provide nul terminated strings, there is no requirement that
> they to so. Hence, the length is necessary.
> 
> Security contexts are provided by a number of interfaces. The interface
> security_release_secctx() is used when the caller is finished with the
> data. Each of the security modules that provide security contexts manages
> them differently. This was safe in the past, because only one security
> module that provides security contexts is allowed to be active. To allow
> multiple active modules that use security contexts it is necessary to
> identify which security module created a security context. Adding a third
> pointer to the interfaces for the LSM identification is not appealing.
> 
> A new structure, lsm_context, is created for use in these interfaces.
> It includes three members: the data pointer, the data length and
> the LSM ID of its creator. The interfaces that create contexts and
> security_release_secctx() now use a pointer to an lsm_context instead
> of a pointer pair.
> 
> The changes are mostly mechanical, and some scaffolding is used within
> the patch set to allow for smaller individual patches.

Hey Casey,

so this set is not bisectable.  Applying just patch 1 will no compile, right?
What is your plan for getting past that?  Squash some or all of them into one?
Or are you planning a wider reorg of the patches down the line, once the
basics of the end result are agreed upon?

-serge
