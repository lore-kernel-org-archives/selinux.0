Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DC18FDCF
	for <selinux@vger.kernel.org>; Wed, 10 Jul 2024 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608019; cv=none; b=KI2/M6Cke6VsiW/6KQaduRzhU84UbNfmMdFg7hwL5EahYu1PGY3smC1spG4x8o4AVYgP0uGFpYXnRJVBMI6v00yEfBxPu4Kr4iRv4rWIDTEBynm8oIYAKtVre8Iekp4/CupltmjswQGuq4/V4UeJAQ/lzWlAVph98OVh++EgBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608019; c=relaxed/simple;
	bh=lUejIBjgkSRZK9nXeVw7xBPpqekdbR52PsTjDzDGnKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgVuZDTo8CPvMQRYDpYEVLIYW92se8T9G5S625gfGaHn1VSVlWNaVG+AUzvJQ8eOj5suZw0cu8EoKqXbb1GswrFLPBisPzuq9ZIsGf0XJBL0A8SnyP2wv2d/+SKAHef/16PdiF9/fGgFUdJOBj9nHnMACcjW0K65E9Ka65fk2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=l+zdYosG; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="l+zdYosG"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJvWV6m6rzxvQ;
	Wed, 10 Jul 2024 12:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720608006;
	bh=8hdd97ZzjanvrH81RpupqwCmx1FmND14UpviDAFPS3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+zdYosG3135vxXCkBw5gZ4Lu+PMNNf664VjjTfsqjNZZklpPX6p1GFcudSvJsLaX
	 0Wxenl5xYhurDRtaiHSj0X8vmrFmdnJxtQoH5ltWftT2EGt+yOH9JKCKs9+sy68sgy
	 O4IzjKAzc6RZLwosL9xav6KTN9ZifD2wHMKPC1JY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJvWV3nm1z61K;
	Wed, 10 Jul 2024 12:40:06 +0200 (CEST)
Date: Wed, 10 Jul 2024 12:40:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240710.peiDu2aiD1su@digikod.net>
References: <20240710024029.669314-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710024029.669314-2-paul@paul-moore.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> The LSM framework has an existing inode_free_security() hook which
> is used by LSMs that manage state associated with an inode, but
> due to the use of RCU to protect the inode, special care must be
> taken to ensure that the LSMs do not fully release the inode state
> until it is safe from a RCU perspective.
> 
> This patch implements a new inode_free_security_rcu() implementation
> hook which is called when it is safe to free the LSM's internal inode
> state.  Unfortunately, this new hook does not have access to the inode
> itself as it may already be released, so the existing
> inode_free_security() hook is retained for those LSMs which require
> access to the inode.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

I like this new hook.  It is definitely safer than the current approach.

To make it more consistent, I think we should also rename
security_inode_free() to security_inode_put() to highlight the fact that
LSM implementations should not free potential pointers in this blob
because they could still be dereferenced in a path walk.

> ---
>  include/linux/lsm_hook_defs.h     |  1 +
>  security/integrity/ima/ima.h      |  2 +-
>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
>  security/integrity/ima/ima_main.c |  2 +-
>  security/landlock/fs.c            |  9 ++++++---
>  security/security.c               | 26 +++++++++++++-------------
>  6 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8fd87f823d3a..abe6b0ef892a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>  	 unsigned int obj_type)
>  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>  	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
>  	 int *xattr_count)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3e568126cd48..e2a2e4c7eab6 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
>  
>  struct ima_iint_cache *ima_iint_find(struct inode *inode);
>  struct ima_iint_cache *ima_inode_get(struct inode *inode);
> -void ima_inode_free(struct inode *inode);
> +void ima_inode_free_rcu(void *inode_sec);
>  void __init ima_iintcache_init(void);
>  
>  extern const int read_idmap[];
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
> index e23412a2c56b..54480df90bdc 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>  }
>  
>  /**
> - * ima_inode_free - Called on inode free
> - * @inode: Pointer to the inode
> + * ima_inode_free_rcu - Called to free an inode via a RCU callback
> + * @inode_sec: The inode::i_security pointer
>   *
> - * Free the iint associated with an inode.
> + * Free the IMA data associated with an inode.
>   */
> -void ima_inode_free(struct inode *inode)
> +void ima_inode_free_rcu(void *inode_sec)
>  {
> -	struct ima_iint_cache *iint;
> +	struct ima_iint_cache **iint_p = inode_sec + ima_blob_sizes.lbs_inode;
>  
> -	if (!IS_IMA(inode))
> -		return;
> -
> -	iint = ima_iint_find(inode);
> -	ima_inode_set_iint(inode, NULL);
> -
> -	ima_iint_free(iint);
> +	/* *iint_p should be NULL if !IS_IMA(inode) */
> +	if (*iint_p)
> +		ima_iint_free(*iint_p);
>  }
>  
>  static void ima_iint_init_once(void *foo)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f04f43af651c..5b3394864b21 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>  	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
>  #endif
> -	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
> +	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
>  };
>  
>  static const struct lsm_id ima_lsmid = {
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 22d8b7c28074..f583f8cec345 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  
>  /* Inode hooks */
>  
> -static void hook_inode_free_security(struct inode *const inode)
> +static void hook_inode_free_security_rcu(void *inode_sec)
>  {
> +	struct landlock_inode_security *lisec;

Please rename "lisec" to "inode_sec" for consistency with
get_inode_object()'s variables.

> +
>  	/*
>  	 * All inodes must already have been untied from their object by
>  	 * release_inode() or hook_sb_delete().
>  	 */
> -	WARN_ON_ONCE(landlock_inode(inode)->object);
> +	lisec = inode_sec + landlock_blob_sizes.lbs_inode;
> +	WARN_ON_ONCE(lisec->object);
>  }

This looks good to me.

We can add these footers:
Reported-by: syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000076ba3b0617f65cc8@google.com

However, I'm wondering if we could backport this patch down to v5.15 .
I guess not, so I'll need to remove this hook implementation for
Landlock, backport it to v5.15, and then you'll need to re-add this
check with this patch.  At least it has been useful to spot this inode
issue, but it could still be useful to spot potential memory leaks with
a negligible performance impact.


>  
>  /* Super-block hooks */
> @@ -1628,7 +1631,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>  }
>  
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
> -	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
> +	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
>  
>  	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
>  	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
> diff --git a/security/security.c b/security/security.c
> index b52e81ac5526..bc6805f7332e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
>  
>  static void inode_free_by_rcu(struct rcu_head *head)
>  {
> -	/*
> -	 * The rcu head is at the start of the inode blob
> -	 */
> +	/* The rcu head is at the start of the inode blob */
> +	call_void_hook(inode_free_security_rcu, head);

For this to work, we need to extend the inode blob size (lbs_inode) with
sizeof(struct rcu_head).  The current implementation override the
content of the blob with a new rcu_head.

>  	kmem_cache_free(lsm_inode_cache, head);
>  }
>  
> @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
>   * security_inode_free() - Free an inode's LSM blob
>   * @inode: the inode
>   *
> - * Deallocate the inode security structure and set @inode->i_security to NULL.
> + * Release any LSM resources associated with @inode, although due to the
> + * inode's RCU protections it is possible that the resources will not be
> + * fully released until after the current RCU grace period has elapsed.
> + *
> + * It is important for LSMs to note that despite being present in a call to
> + * security_inode_free(), @inode may still be referenced in a VFS path walk
> + * and calls to security_inode_permission() may be made during, or after,
> + * a call to security_inode_free().  For this reason the inode->i_security
> + * field is released via a call_rcu() callback and any LSMs which need to
> + * retain inode state for use in security_inode_permission() should only
> + * release that state in the inode_free_security_rcu() LSM hook callback.
>   */
>  void security_inode_free(struct inode *inode)
>  {
>  	call_void_hook(inode_free_security, inode);
> -	/*
> -	 * The inode may still be referenced in a path walk and
> -	 * a call to security_inode_permission() can be made
> -	 * after inode_free_security() is called. Ideally, the VFS
> -	 * wouldn't do this, but fixing that is a much harder
> -	 * job. For now, simply free the i_security via RCU, and
> -	 * leave the current inode->i_security pointer intact.
> -	 * The inode will be freed after the RCU grace period too.
> -	 */
>  	if (inode->i_security)
>  		call_rcu((struct rcu_head *)inode->i_security,
>  			 inode_free_by_rcu);

We should have something like:
call_rcu(inode->i_security.rcu, inode_free_by_rcu);

> -- 
> 2.45.2
> 
> 
