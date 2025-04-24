Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF227B519;
	Thu, 24 Apr 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500325; cv=none; b=ulqwG+xPeidfsPabwo9zwn9WDb56tOhhatwm6cmd9bJ400/5S9X0cSJ6Wpla2yUxc1BoCikJnTLLZWb4kc4gka0kKLM5jrGFNTd1fVsT43RCEKDBg/oIPI8NacHm0EZBtGqiyaazgbUj+geUgfkXxbr3ozNAfXNmiosHnyWxrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500325; c=relaxed/simple;
	bh=4cvuzHcmHrwa785PAn6weho6zU3Lk00QP2t5Neo56Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncYVPSkUqyCPrKdjc9WGaQu388vMQCiAa40N/EAiMp14xnHOsellQqALJvdT3gJ8M71sWWAN+b6K4naRHKS0FzzbLyeV4y2Jy57hhf9F3KWe+gJp0RDqFx0RAbgS6Yq2DMMo9J1rfL7IpHyoyVlXW91mFDxpghmFgSkUicry20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZbBSCNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZbBSCNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E35AC4CEE3;
	Thu, 24 Apr 2025 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745500324;
	bh=4cvuzHcmHrwa785PAn6weho6zU3Lk00QP2t5Neo56Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZbBSCNmLH4viOCChkBsuLlguE6dtJB0G2K9cC0usOI1PKUGrCDJwQwU3SWPFUL33
	 R65w6nXourbz1aa70I21U+di6kSvmxqF54iX9Lkx9XOKqOjTb3fANiWmSYq+c+UWL5
	 I3uYWEvMGHw27lsitsRLn514qiByywTncJJURXcQ=
Date: Thu, 24 Apr 2025 15:12:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, omosnace@redhat.com,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] vfs,shmem,kernfs: fix listxattr to include security.*
 xattrs
Message-ID: <2025042427-hardship-captive-4d7b@gregkh>
References: <20250424124644.4413-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424124644.4413-1-stephen.smalley.work@gmail.com>

On Thu, Apr 24, 2025 at 08:46:43AM -0400, Stephen Smalley wrote:
> The vfs has long had a fallback to obtain the security.* xattrs from the
> LSM when the filesystem does not implement its own listxattr, but
> shmem/tmpfs and kernfs later gained their own xattr handlers to support
> other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
> filesystems like sysfs no longer return the synthetic security.* xattr
> names via listxattr unless they are explicitly set by userspace or
> initially set upon inode creation after policy load. coreutils has
> recently switched from unconditionally invoking getxattr for security.*
> for ls -Z via libselinux to only doing so if listxattr returns the xattr
> name, breaking ls -Z of such inodes.
> 
> Before:
> $ getfattr -m.* /run/initramfs
> <no output>
> $ getfattr -m.* /sys/kernel/fscaps
> <no output>
> 
> After:
> $ getfattr -m.* /run/initramfs
> security.selinux
> $ getfattr -m.* /sys/kernel/fscaps
> security.selinux
> 
> Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
> Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

As this "changed" in the past, shouldn't it have a "Fixes:" tag?

thanks,

greg k-h
