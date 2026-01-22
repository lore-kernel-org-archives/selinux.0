Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4C32D45C;
	Thu, 22 Jan 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769092646; cv=none; b=ee8XK7Vofi41k01KTMqZ16xFGnPOR9kW4gt7q1USodxItt9JX9bNCSqPPyKXJUonlNkx98ogi3AIW/v6aGsuS57elxbAdWl6K7sKg9jeYRnewg5Aq7AEEUxBBvPKJUQUyU6Us3Syy/j5FplauR4SxO201SMom1iD403QKewmBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769092646; c=relaxed/simple;
	bh=P8AJzOiR3sPqDe6hTCRwgczBy2Ea5sT2if/nh/WzG/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFZRCiqZWrhdcvzgluDQBVOhYFvtQSBsmMSj0m4HyMhAVEh3KLVUp6G8QCaX2f1PnJSAh1aImKsLxcOk70cWX1N0EUIGciXTRLIXocrafn7ZCXvmsdOYezZZXUrXMFNt7SR8nO2b2/F8dQ72gZZhywvWLdwsEe5L88wni5yHh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmZjT/NN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmZjT/NN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F07C116C6;
	Thu, 22 Jan 2026 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769092645;
	bh=P8AJzOiR3sPqDe6hTCRwgczBy2Ea5sT2if/nh/WzG/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmZjT/NNd6fCcanauIcaLDG6+KTBbHPA9gfStGQ0+ee/htrPhNcjyDwRglSNgyCGX
	 ICW2eGsy3rcJLG/y7VpKUVUlq8Bwu0DXHMft8tGEXp6JPsge8A3HxR76celhQKy2lo
	 3rGnou+k1p6hZQ8vAgJvfisotnMmwpWJTtsbqrpkq3YTRtq+kLUer0hG+Js5kkqzaM
	 yhqV/VHu2iEOu9qA2xylt3DKHqaFgbyxkeUu6+qLOnX31lG454qNf+2CtHI+i7IyU7
	 b2gCCD/SkbMJoddgnT1UJhpBA/DWfb/5JEvwDcorTzrjFXn4L6qa/8mvzZQ7vD4WZU
	 ihkPagDTMY5vQ==
Date: Thu, 22 Jan 2026 15:37:20 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
Message-ID: <aXI2IOmVZTWlYE_9@example.org>
References: <20260122141303.241133-1-omosnace@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122141303.241133-1-omosnace@redhat.com>

On Thu, Jan 22, 2026 at 03:13:03PM +0100, Ondrej Mosnacek wrote:
> The IPC sysctls implement the ctl_table_root::permissions hook and
> they override the file access mode based on the CAP_CHECKPOINT_RESTORE
> capability, which is being checked regardless of whether any access is
> actually denied or not, so if an LSM denies the capability, an audit
> record may be logged even when access is in fact granted.
> 
> It wouldn't be viable to restructure the sysctl permission logic to only
> check the capability when the access would be actually denied if it's
> not granted. Thus, do the same as in net_ctl_permissions()
> (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit(),
> so that the check never emits an audit record.
> 
> Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart sysctls at open time")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Some permission hooks already use ns_capable_noaudit.
For example, pid_table_root_permissions.
I think it makes sense here also.

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  include/linux/capability.h | 6 ++++++
>  ipc/ipc_sysctl.c           | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 1fb08922552c7..37db92b3d6f89 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -203,6 +203,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
>  		ns_capable(ns, CAP_SYS_ADMIN);
>  }
>  
> +static inline bool checkpoint_restore_ns_capable_noaudit(struct user_namespace *ns)
> +{
> +	return ns_capable_noaudit(ns, CAP_CHECKPOINT_RESTORE) ||
> +		ns_capable_noaudit(ns, CAP_SYS_ADMIN);
> +}
> +
>  /* audit system wants to get cap info from files as well */
>  int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
>  			   const struct dentry *dentry,
> diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> index 15b17e86e198c..9b087ebeb643b 100644
> --- a/ipc/ipc_sysctl.c
> +++ b/ipc/ipc_sysctl.c
> @@ -214,7 +214,7 @@ static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table
>  	if (((table->data == &ns->ids[IPC_SEM_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_MSG_IDS].next_id) ||
>  	     (table->data == &ns->ids[IPC_SHM_IDS].next_id)) &&
> -	    checkpoint_restore_ns_capable(ns->user_ns))
> +	    checkpoint_restore_ns_capable_noaudit(ns->user_ns))
>  		mode = 0666;
>  	else
>  #endif
> -- 
> 2.52.0
> 

-- 
Rgrds, legion

