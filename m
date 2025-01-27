Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6C3C17
	for <selinux@vger.kernel.org>; Mon, 27 Jan 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737949267; cv=none; b=XakwGmLvjrKHD4f9G7MLw7yQOUHc+XWCE/14X5LzKwgwGAc9o/2V0z5DW2vBDrUiQ81N2AZhVgtHhBoIT4X3bG/ohgfanh9aklTio8A5zSh22iy6qZO6dlQ5I2LTjF8sslU9ulCBRfXMS8Nm1xlwaXrsqB5Yt97Y2/KfWCtH/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737949267; c=relaxed/simple;
	bh=N+n3ytShkt1sEr0R+gqGzsao+04EuxJU0O3tsVePHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox+f1BcbRb7P434jMFtj2cI7NeIcK/OD+4wzCTKJGjGZ2x5K4OD/uqAovPGS1Ok2rfnB+YLPwsmxnS0bcAABnfYpqD0eXFXksSeM0jVvBYrQIR1j+JGtWjerszVHprA7HlMahIR10zpqTxpsd+RfeCWQSscziKRA6yu01mR+FSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfT3Bcf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfT3Bcf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B6BC4CED2;
	Mon, 27 Jan 2025 03:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737949267;
	bh=N+n3ytShkt1sEr0R+gqGzsao+04EuxJU0O3tsVePHeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfT3Bcf+tMTtHn4eTaDiy0HPh7+NIQhgiIVP2YM2Dotn9lENX2hZL6247oERPSZIX
	 YejQl9tTzd7F6oHC7CUedHGpKdSCQWoXhomch7AsKciFu+xDgZX0CPvf4kgnPIhpAo
	 shmjSQo9ToJoDr93Z9aMQVeFnS45yuuykcwH3zikfW5nFEitOfDzgeY06F8pf38akv
	 EVtZBypCDXF3XWj4IgsSXUS9PoodnHMcqaSNwpH1DbvlYFhgtvnycKzQDPdBIrQMgJ
	 QB8fHlzgBnXrsKC2AhhBB0mtGh5vabThocWwWK2XVYKDJbmzJtMd/hRCCaRrf4B1tb
	 2ESgqFIfDzfbw==
Date: Mon, 27 Jan 2025 03:41:03 +0000
From: sergeh@kernel.org
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Subject: Re: [RFC PATCH 06/44] selinux: support per-task/cred selinux
 namespace
Message-ID: <Z5cAT7xpQJFOrjGf@lei>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
 <20250102164509.25606-7-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102164509.25606-7-stephen.smalley.work@gmail.com>

On Thu, Jan 02, 2025 at 11:44:31AM -0500, Stephen Smalley wrote:
> Extend the task security structure to include a reference to
> the associated selinux namespace, and to also contain a
> pointer to the cred in the parent namespace.  The current selinux
> namespace is changed to the per-task/cred selinux namespace
> for the current task/cred.
> 
> This change makes it possible to support per-cred selinux namespaces,
> but does not yet introduce a mechanism for unsharing of the selinux
> namespace.  Thus, by itself, this change does not alter the existing
> situation with respect to all processes still using a single init
> selinux namespace.
> 
> An alternative would be to hang the selinux namespace off of the
> user namespace, which itself is associated with the cred.  This
> seems undesirable however since DAC and MAC are orthogonal, and
> there appear to be real use cases where one will want to use selinux
> namespaces without user namespaces and vice versa. However, one
> advantage of hanging off the user namespace would be that it is already
> associated with other namespaces, such as the network namespace, thus
> potentially facilitating looking up the relevant selinux namespace from
> the network input/forward hooks.  In most cases however, it appears that
> we could instead copy a reference to the creating task selinux namespace
> to sock security structures and use that in those hooks.
> 
> Introduce a task_security() helper to obtain the correct task/cred
> security structure from the hooks, and update the hooks to use it.
> This returns a pointer to the security structure for the task in
> the same selinux namespace as the caller, or if there is none, a
> fake security structure with the well-defined unlabeled SIDs.  This
> ensures that we return a valid result that can be used for permission
> checks and for returning contexts from e.g. reading /proc/pid/attr files.
> 
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/hooks.c            | 50 +++++++++++++++++++++++++----
>  security/selinux/include/objsec.h   | 23 -------------
>  security/selinux/include/security.h | 32 +++++++++++++++++-
>  3 files changed, 75 insertions(+), 30 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ad8172ae7fda..ddaf1f527fe3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -108,9 +108,6 @@
>  
>  #define SELINUX_INODE_INIT_XATTRS 1
>  
> -static struct selinux_state *init_selinux_state;
> -struct selinux_state *current_selinux_state;
> -
>  /* SECMARK reference count */
>  static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
>  
> @@ -207,6 +204,8 @@ static int selinux_lsm_notifier_avc_callback(u32 event)
>  	return 0;
>  }
>  
> +static struct selinux_state *init_selinux_state;
> +
>  /*
>   * initialise the security for the init task
>   */
> @@ -216,6 +215,7 @@ static void cred_init_security(void)
>  
>  	tsec = selinux_cred(unrcu_pointer(current->real_cred));
>  	tsec->osid = tsec->sid = SECINITSID_KERNEL;
> +	tsec->state = get_selinux_state(init_selinux_state);
>  }
>  
>  /*
> @@ -229,6 +229,24 @@ static inline u32 cred_sid(const struct cred *cred)
>  	return tsec->sid;
>  }
>  
> +static struct task_security_struct unlabeled_task_security = {
> +	.osid = SECINITSID_UNLABELED,
> +	.sid = SECINITSID_UNLABELED,
> +};
> +

I don't know the selinux coding style, but I would think it worth
mentioning that a caller of task_security() must hold rcu_read_lock.
As callers you introduce here do.

> +static const struct task_security_struct *task_security(
> +	const struct task_struct *p)
> +{
> +	const struct task_security_struct *tsec;
> +
> +	tsec = selinux_cred(__task_cred(p));
> +	while (tsec->state != current_selinux_state && tsec->parent_cred)
> +		tsec = selinux_cred(tsec->parent_cred);
> +	if (tsec->state != current_selinux_state)
> +		return &unlabeled_task_security;
> +	return tsec;
> +}
> +
>  static void __ad_net_init(struct common_audit_data *ad,
>  			  struct lsm_network_audit *net,
>  			  int ifindex, struct sock *sk, u16 family)
