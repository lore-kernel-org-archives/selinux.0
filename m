Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4EGYcYY020116
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 12:34:38 -0400
To: Stephen Smalley <sds@tycho.nsa.gov>,
 LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
 <fd3c36e4-6e75-4eec-afdf-a493889c696f@schaufler-ca.com>
 <a38fb118-8c72-e18d-e55a-48fdc40e21f4@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <906d5338-0021-740d-36dc-0f32b2c36f55@schaufler-ca.com>
Date: Mon, 14 May 2018 09:32:28 -0700
MIME-Version: 1.0
In-Reply-To: <a38fb118-8c72-e18d-e55a-48fdc40e21f4@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 10/23] LSM: Infrastructure management of the inode security
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/14/2018 8:04 AM, Stephen Smalley wrote:
> On 05/10/2018 08:53 PM, Casey Schaufler wrote:
>> From: Casey Schaufler <casey@schaufler-ca.com>
>> Date: Thu, 10 May 2018 14:23:27 -0700
>> Subject: [PATCH 10/23] LSM: Infrastructure management of the inode security
>>  blob
>>
>> Move management of the inode->i_security blob out
>> of the individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h         |  3 ++
>>  security/security.c               | 85 +++++++++++++++++++++++++++++++++++++--
>>  security/selinux/hooks.c          | 32 +--------------
>>  security/selinux/include/objsec.h |  5 +--
>>  security/smack/smack_lsm.c        | 70 +++++---------------------------
>>  5 files changed, 99 insertions(+), 96 deletions(-)
>> <SNIP>
>> diff --git a/security/security.c b/security/security.c
>> index b414186ad45f..02df9b608b7e 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -41,6 +41,7 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>>  static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
>>  
>>  static struct kmem_cache *lsm_file_cache;
>> +static struct kmem_cache *lsm_inode_cache;
>>  
>>  char *lsm_names;
>>  static struct lsm_blob_sizes blob_sizes;
>> @@ -98,6 +99,10 @@ int __init security_init(void)
>>  		lsm_file_cache = kmem_cache_create("lsm_file_cache",
>>  						   blob_sizes.lbs_file, 0,
>>  						   SLAB_PANIC, NULL);
>> +	if (blob_sizes.lbs_inode)
>> +		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
>> +						    blob_sizes.lbs_inode, 0,
>> +						    SLAB_PANIC, NULL);
>>  	/*
>>  	 * The second call to a module specific init function
>>  	 * adds hooks to the hook lists and does any other early
>> @@ -108,8 +113,9 @@ int __init security_init(void)
>>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>>  	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>>  	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
>> +	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
>>  	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
>> -#endif
>> +#endif /* CONFIG_SECURITY_LSM_DEBUG */
>>  
>>  	return 0;
>>  }
>> @@ -285,6 +291,13 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>>  	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
>>  	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
>>  	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
>> +	/*
>> +	 * The inode blob gets an rcu_head in addition to
>> +	 * what the modules might need.
>> +	 */
>> +	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
>> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
>> +	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>>  }
>>  
>>  /**
>> @@ -348,6 +361,46 @@ void lsm_early_task(struct task_struct *task)
>>  		panic("%s: Early task alloc failed.\n", __func__);
>>  }
>>  
>> +/**
>> + * lsm_inode_alloc - allocate a composite inode blob
>> + * @inode: the inode that needs a blob
>> + *
>> + * Allocate the inode blob for all the modules
>> + *
>> + * Returns 0, or -ENOMEM if memory can't be allocated.
>> + */
>> +int lsm_inode_alloc(struct inode *inode)
>> +{
>> +	if (!lsm_inode_cache) {
>> +		inode->i_security = NULL;
>> +		return 0;
>> +	}
>> +
>> +	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_KERNEL);
> Should be GFP_NOFS (and was that way in SELinux and Smack).

Yes, you're correct. I'll make the change.
