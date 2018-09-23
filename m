Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8NHA15S030659
 for <selinux@tycho.nsa.gov>; Sun, 23 Sep 2018 13:10:02 -0400
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Kees Cook <keescook@chromium.org>
Cc: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
Date: Sun, 23 Sep 2018 10:09:38 -0700
MIME-Version: 1.0
In-Reply-To: <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and
 Landlock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 9/23/2018 8:59 AM, Tetsuo Handa wrote:
> On 2018/09/23 11:43, Kees Cook wrote:
>>>> I'm excited about getting this landed!
>>> Soon. Real soon. I hope. I would very much like for
>>> someone from the SELinux camp to chime in, especially on
>>> the selinux_is_enabled() removal.
>> Agreed.
>>
> This patchset from Casey lands before the patchset from Kees, doesn't it?

That is up for negotiation. We may end up combining them.

> OK, a few comments (if I didn't overlook something).
>
>   lsm_early_cred()/lsm_early_task() are called from only __init functions.

True.

>   lsm_cred_alloc()/lsm_file_alloc() are called from only security/security.c .

Also true.

>   lsm_early_inode() should be avoided because it is not appropriate to
>   call panic() when lsm_early_inode() is called after __init phase.

You're correct. In fact, lsm_early_inode() isn't needed at all
until multiple inode using modules are supported.

>   Since all free hooks are called when one of init hooks failed, each
>   free hook needs to check whether init hook was called. An example is
>   inode_free_security() in security/selinux/hooks.c (but not addressed in
>   this patch).

I *think* that selinux_inode_free_security() is safe in this
case because the blob will be zeroed, hence isec->list will
be NULL.

>   This patchset might fatally prevent LKM-based LSM modules, for LKM-based
>   LSMs cannot count on lsm_*_alloc() because size for lsm_*_alloc() cannot
>   be updated upon loading LKM-based LSMs.

LKM based security modules will require dynamically sized blobs.
These can be added to the scheme used here. Each blob would get a
header identifying the modules for which it contains data. When an
LKM is registered if has to declare it's blob space requirements
and gets back the offsets. All alloc operations have to put their
marks in the header. All LKM blob users have to check that the blob
they are looking at has the required data.

module_cred(struct cred *cred) {
	return cred->security + module_blob_sizes.lbs_cred;
}

becomes

module_cred(struct cred *cred) {
	if (blob_includes(module_id))
		return cred->security + module_blob_sizes.lbs_cred;
	return NULL;
}

and the calling code needs to accept a NULL return.
Blobs can never get smaller because readjusting the offsets
isn't going to work, so unloading an LKM security module isn't
going to be as complete as you might like. There may be a way
around this if you unload all the LKM modules, but that's a
special case and there may be dragon lurking in the mist.

>  If security_file_free() is called
>   regardless of whether lsm_file_cache is defined, LKM-based LSMs can be
>   loaded using current behavior (apart from the fact that legitimate
>   interface for appending to security_hook_heads is currently missing).
>   How do you plan to handle LKM-based LSMs?

My position all along has been that I don't plan to handle LKM
based LSMs, but that I won't do anything to prevent someone else
from adding them later. I believe that I've done that. Several
designs, including a separate list for dynamically loaded modules
have been proposed. I think some of those would work.

>  include/linux/lsm_hooks.h  |    6 ++----
>  security/security.c        |   31 ++++++-------------------------
>  security/smack/smack_lsm.c |    8 +++++++-
>  3 files changed, 15 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7e8b32f..8014614 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2095,13 +2095,11 @@ static inline void __init yama_add_hooks(void) { }
>  static inline void loadpin_add_hooks(void) { };
>  #endif
>  
> -extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
>  extern int lsm_inode_alloc(struct inode *inode);
>  
>  #ifdef CONFIG_SECURITY
> -void lsm_early_cred(struct cred *cred);
> -void lsm_early_inode(struct inode *inode);
> -void lsm_early_task(struct task_struct *task);
> +void __init lsm_early_cred(struct cred *cred);
> +void __init lsm_early_task(struct task_struct *task);
>  #endif
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/security.c b/security/security.c
> index e7c85060..341e8df 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -267,7 +267,7 @@ int unregister_lsm_notifier(struct notifier_block *nb)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
> +static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>  {
>  	if (blob_sizes.lbs_cred == 0) {
>  		cred->security = NULL;
> @@ -286,7 +286,7 @@ int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
>   *
>   * Allocate the cred blob for all the modules if it's not already there
>   */
> -void lsm_early_cred(struct cred *cred)
> +void __init lsm_early_cred(struct cred *cred)
>  {
>  	int rc;
>  
> @@ -344,7 +344,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_file_alloc(struct file *file)
> +static int lsm_file_alloc(struct file *file)
>  {
>  	if (!lsm_file_cache) {
>  		file->f_security = NULL;
> @@ -379,25 +379,6 @@ int lsm_inode_alloc(struct inode *inode)
>  }
>  
>  /**
> - * lsm_early_inode - during initialization allocate a composite inode blob
> - * @inode: the inode that needs a blob
> - *
> - * Allocate the inode blob for all the modules if it's not already there
> - */
> -void lsm_early_inode(struct inode *inode)
> -{
> -	int rc;
> -
> -	if (inode == NULL)
> -		panic("%s: NULL inode.\n", __func__);
> -	if (inode->i_security != NULL)
> -		return;
> -	rc = lsm_inode_alloc(inode);
> -	if (rc)
> -		panic("%s: Early inode alloc failed.\n", __func__);
> -}
> -
> -/**
>   * lsm_task_alloc - allocate a composite task blob
>   * @task: the task that needs a blob
>   *
> @@ -466,7 +447,7 @@ int lsm_msg_msg_alloc(struct msg_msg *mp)
>   *
>   * Allocate the task blob for all the modules if it's not already there
>   */
> -void lsm_early_task(struct task_struct *task)
> +void __init lsm_early_task(struct task_struct *task)
>  {
>  	int rc;
>  
> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>  {
>  	void *blob;
>  
> +	call_void_hook(file_free_security, file);
> +
>  	if (!lsm_file_cache)
>  		return;
>  
> -	call_void_hook(file_free_security, file);
> -

Why does this make sense? If the lsm_file_cache isn't
initialized you can't have allocated any file blobs,
no module can have initialized a file blob, hence there
can be nothing for the module to do.

>  	blob = file->f_security;
>  	file->f_security = NULL;
>  	kmem_cache_free(lsm_file_cache, blob);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 7843004..b0b4045 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -750,6 +750,13 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	if (sp->smk_flags & SMK_SB_INITIALIZED)
>  		return 0;
>  
> +	if (inode->i_security == NULL) {
> +		int rc = lsm_inode_alloc(inode);
> +
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN)) {
>  		/*
>  		 * Unprivileged mounts don't get to specify Smack values.
> @@ -818,7 +825,6 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  	/*
>  	 * Initialize the root inode.
>  	 */
> -	lsm_early_inode(inode);
>  	init_inode_smack(inode, sp->smk_root);
>  
>  	if (transmute) {
