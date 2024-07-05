Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914E16C87B;
	Fri,  5 Jul 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211285; cv=none; b=bT9bTUm3NIa68Nuzi+3q3yLbE7aAhp+Y2LzPSA3tH+TYD7ZCs0xU4IYHyW5atx2q9x+Lo7I6KUFQmuZ7v3kIBzyupKcAqleK/iKqXiPRB2RS1nlrLxBtqVLsU9HM3HYCSnP7I21RFIQP/1hr+BOHK+5aS7HSRnxF5Z8fo1+FzQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211285; c=relaxed/simple;
	bh=NL+K7wTvWIIJcOI3nH5/UmoRp86jiGOjSMhH+b3K7HI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mEBIkwNZG3buSDwQ1gcKtGefS4Jt9lJG1yjq/X1W6Ac1APLGVSL1G04rDSGF3BjSDXdZ24mMG+VrksGswXIwVdvMssY4E7LYmHYzapH0kpDilbpXoOVpD7XuSclc+oekeU959hDxx5L8060weCVhD66iMuBhMjF3BvpnEcoMGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C76C116B1;
	Fri,  5 Jul 2024 20:28:03 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH] lsm: fixup the inode xattr capability handling
From: KP Singh <kpsingh@chromium.org>
In-Reply-To: <20240503005850.466144-2-paul@paul-moore.com>
Date: Fri, 5 Jul 2024 22:28:00 +0200
Cc: selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Felix Fu <fuzhen5@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <835A3242-CE91-4F73-99D8-66980DC14234@chromium.org>
References: <20240503005850.466144-2-paul@paul-moore.com>
To: Paul Moore <paul@paul-moore.com>
X-Mailer: Apple Mail (2.3774.600.62)



> On 3 May 2024, at 02:58, Paul Moore <paul@paul-moore.com> wrote:
>=20
> The current security_inode_setxattr() and security_inode_removexattr()
> hooks rely on individual LSMs to either call into the associated
> capability hooks (cap_inode_setxattr() or cap_inode_removexattr()), or
> return a magic value of 1 to indicate that the LSM layer itself should
> perform the capability checks.  Unfortunately, with the default return
> value for these LSM hooks being 0, an individual LSM hook returning a
> 1 will cause the LSM hook processing to exit early, potentially
> skipping a LSM.  Thankfully, with the exception of the BPF LSM, none
> of the LSMs which currently register inode xattr hooks should end up
> returning a value of 1, and in the BPF LSM case, with the BPF LSM =
hooks
> executing last there should be no real harm in stopping processing of
> the LSM hooks.  However, the reliance on the individual LSMs to either
> call the capability hooks themselves, or signal the LSM with a return
> value of 1, is fragile and relies on a specific set of LSMs being
> enabled.  This patch is an effort to resolve, or minimize, these
> issues.
>=20
> Before we discuss the solution, there are a few observations and
> considerations that we need to take into account:
> * BPF LSM registers an implementation for every LSM hook, and that
>  implementation simply returns the hook's default return value, a
>  0 in this case.  We want to ensure that the default BPF LSM behavior
>  results in the capability checks being called.


The BPF LSM never intended to add default callbacks from the very first =
day:


https://lwn.net/ml/linux-kernel/20200224171305.GA21886@chromium.org/


But, we went ahead with a "compromise" because were were going to make =
the LSM layer better and tackle this problem with the broader =
enhancements for the LSM layer. Little did I know this would take 4 =
years (and counting...) from then.


If you want to go ahead with this change for other reasons, please feel =
free to. But, I don't want the BPF LSM default callbacks being cited as =
a reason here.


- KP

> * SELinux and Smack do not expect the traditional capability checks
>  to be applied to the xattrs that they "own".
> * SELinux and Smack are currently written in such a way that the
>  xattr capability checks happen before any additional LSM specific
>  access control checks.  SELinux does apply SELinux specific access
>  controls to all xattrs, even those not "owned" by SELinux.
> * IMA and EVM also register xattr hooks but assume that the LSM layer
>  and specific LSMs have already authorized the basic xattr operation.


[...]=
