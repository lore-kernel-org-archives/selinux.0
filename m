Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF8197A91;
	Wed, 10 Jul 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645325; cv=none; b=jov8UayIJoCOI+0NAywfDemc/Z0MVpLUV7VeddmS2pZzm7AYPv9bGSNlVfjVFZEwNZsx1HpOAI2XeGZ44Ypsvb7UO/0G4nSPk5s8vsb5fb8o8+2Xtt3nPyoxrLNOsW1tFzbT1S3eLaggMpUkkKQwDEH3hRU9xfl6Dz9StQQKLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645325; c=relaxed/simple;
	bh=rfFs8iMAFVc1YOT6B/slxivQnJPHfOG9XeMqG/dCCno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eLQQ3S2MEMKv3N4m3RygmhF6qIDrOibYYtxQAwsXsSb8FdnuVdiRQLjWBZyMX9X/u1qGxo20AoRyJn8AaC/42tcmmzLRrkkx/3FFRqqhhd9xdU89bn+x+0GHXxmsXxRqA3bDtXnbC8w33M1VvgUdnUY2XjwkAO2HrUVJoKA0VAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4WK8vy5x99z9v7Hl;
	Thu, 11 Jul 2024 04:43:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6D33B1403D2;
	Thu, 11 Jul 2024 05:01:48 +0800 (CST)
Received: from [10.48.132.127] (unknown [10.48.132.127])
	by APP1 (Coremail) with SMTP id LxC2BwBX5KO09o5mZQk0AQ--.64340S2;
	Wed, 10 Jul 2024 22:01:47 +0100 (CET)
Message-ID: <ebe7be89-1e5d-443b-b066-e5286ca1c986@huaweicloud.com>
Date: Wed, 10 Jul 2024 23:01:38 +0200
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
References: <20240710024029.669314-2-paul@paul-moore.com>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <20240710024029.669314-2-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwBX5KO09o5mZQk0AQ--.64340S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1rXr45tFy7XrW3uFykXwb_yoW3Cw4fpa
	n2qF17Grn8JFy7urs5tF17ua1Sgay5GF47GrZ5Cw1IyFnxZry0qr4UAr1UCF15GrWkXw1I
	qwnF9rsxAw4DtrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUy2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYY7kG6xAYrwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
	6r4UYxBIdaVFxhVjvjDU0xZFpf9x07boxRDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj50YZgABsV

On 7/10/2024 4:40 AM, Paul Moore wrote:
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
> ---
>   include/linux/lsm_hook_defs.h     |  1 +
>   security/integrity/ima/ima.h      |  2 +-
>   security/integrity/ima/ima_iint.c | 20 ++++++++------------
>   security/integrity/ima/ima_main.c |  2 +-
>   security/landlock/fs.c            |  9 ++++++---
>   security/security.c               | 26 +++++++++++++-------------
>   6 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8fd87f823d3a..abe6b0ef892a 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -114,6 +114,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
>   	 unsigned int obj_type)
>   LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
>   LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> +LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *)
>   LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
>   	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
>   	 int *xattr_count)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3e568126cd48..e2a2e4c7eab6 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -223,7 +223,7 @@ static inline void ima_inode_set_iint(const struct inode *inode,
>   
>   struct ima_iint_cache *ima_iint_find(struct inode *inode);
>   struct ima_iint_cache *ima_inode_get(struct inode *inode);
> -void ima_inode_free(struct inode *inode);
> +void ima_inode_free_rcu(void *inode_sec);
>   void __init ima_iintcache_init(void);
>   
>   extern const int read_idmap[];
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
> index e23412a2c56b..54480df90bdc 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -109,22 +109,18 @@ struct ima_iint_cache *ima_inode_get(struct inode *inode)
>   }
>   
>   /**
> - * ima_inode_free - Called on inode free
> - * @inode: Pointer to the inode
> + * ima_inode_free_rcu - Called to free an inode via a RCU callback
> + * @inode_sec: The inode::i_security pointer
>    *
> - * Free the iint associated with an inode.
> + * Free the IMA data associated with an inode.
>    */
> -void ima_inode_free(struct inode *inode)
> +void ima_inode_free_rcu(void *inode_sec)
>   {
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

It looks ok for me. The only thing we are not doing is to set the 
pointer to NULL, but I guess does not matter, since the inode security 
blob is being freed.

I also ran some UML kernel tests in the CI, and everything looks good:

https://github.com/robertosassu/ima-evm-utils/actions/runs/9880817007/job/27291259487

Will think a bit, if I'm missing something.

Roberto

>   }
>   
>   static void ima_iint_init_once(void *foo)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index f04f43af651c..5b3394864b21 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1193,7 +1193,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
>   #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>   	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
>   #endif
> -	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
> +	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
>   };
>   
>   static const struct lsm_id ima_lsmid = {
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 22d8b7c28074..f583f8cec345 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1198,13 +1198,16 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>   
>   /* Inode hooks */
>   
> -static void hook_inode_free_security(struct inode *const inode)
> +static void hook_inode_free_security_rcu(void *inode_sec)
>   {
> +	struct landlock_inode_security *lisec;
> +
>   	/*
>   	 * All inodes must already have been untied from their object by
>   	 * release_inode() or hook_sb_delete().
>   	 */
> -	WARN_ON_ONCE(landlock_inode(inode)->object);
> +	lisec = inode_sec + landlock_blob_sizes.lbs_inode;
> +	WARN_ON_ONCE(lisec->object);
>   }
>   
>   /* Super-block hooks */
> @@ -1628,7 +1631,7 @@ static int hook_file_ioctl_compat(struct file *file, unsigned int cmd,
>   }
>   
>   static struct security_hook_list landlock_hooks[] __ro_after_init = {
> -	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
> +	LSM_HOOK_INIT(inode_free_security_rcu, hook_inode_free_security_rcu),
>   
>   	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
>   	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
> diff --git a/security/security.c b/security/security.c
> index b52e81ac5526..bc6805f7332e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1596,9 +1596,8 @@ int security_inode_alloc(struct inode *inode)
>   
>   static void inode_free_by_rcu(struct rcu_head *head)
>   {
> -	/*
> -	 * The rcu head is at the start of the inode blob
> -	 */
> +	/* The rcu head is at the start of the inode blob */
> +	call_void_hook(inode_free_security_rcu, head);
>   	kmem_cache_free(lsm_inode_cache, head);
>   }
>   
> @@ -1606,20 +1605,21 @@ static void inode_free_by_rcu(struct rcu_head *head)
>    * security_inode_free() - Free an inode's LSM blob
>    * @inode: the inode
>    *
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
>    */
>   void security_inode_free(struct inode *inode)
>   {
>   	call_void_hook(inode_free_security, inode);
> -	/*
> -	 * The inode may still be referenced in a path walk and
> -	 * a call to security_inode_permission() can be made
> -	 * after inode_free_security() is called. Ideally, the VFS
> -	 * wouldn't do this, but fixing that is a much harder
> -	 * job. For now, simply free the i_security via RCU, and
> -	 * leave the current inode->i_security pointer intact.
> -	 * The inode will be freed after the RCU grace period too.
> -	 */
>   	if (inode->i_security)
>   		call_rcu((struct rcu_head *)inode->i_security,
>   			 inode_free_by_rcu);

