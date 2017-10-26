Message-ID: <1509027658.25604.4.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 26 Oct 2017 10:20:58 -0400
In-Reply-To: <20171026084055.25482-1-mjg59@google.com>
References: <20171026084055.25482-1-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH V3 1/2] security: Add a cred_getsecid hook
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-10-26 at 01:40 -0700, Matthew Garrett via Selinux wrote:
> For IMA purposes, we want to be able to obtain the prepared secid in
> the
> bprm structure before the credentials are committed. Add a
> cred_getsecid
> hook that makes this possible.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: selinux@tycho.nsa.gov
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  V3: Fix smack_cred_getsecid()
> 
>  include/linux/lsm_hooks.h  |  6 ++++++
>  include/linux/security.h   |  1 +
>  security/security.c        |  7 +++++++
>  security/selinux/hooks.c   |  8 ++++++++
>  security/smack/smack_lsm.c | 18 ++++++++++++++++++
>  5 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c9258124e417..c28c6f8b65dc 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -554,6 +554,10 @@
>   *	@new points to the new credentials.
>   *	@old points to the original credentials.
>   *	Transfer data from original creds to new creds
> + * @cred_getsecid:
> + *	Retrieve the security identifier of the cred structure @c
> + *	@c contains the credentials, secid will be placed into
> @secid.
> + *	In case of failure, @secid will be set to zero.
>   * @kernel_act_as:
>   *	Set the credentials for a kernel service to act as
> (subjective context).
>   *	@new points to the credentials to be modified.
> @@ -1507,6 +1511,7 @@ union security_list_options {
>  	int (*cred_prepare)(struct cred *new, const struct cred
> *old,
>  				gfp_t gfp);
>  	void (*cred_transfer)(struct cred *new, const struct cred
> *old);
> +	void (*cred_getsecid)(const struct cred *c, u32 *secid);
>  	int (*kernel_act_as)(struct cred *new, u32 secid);
>  	int (*kernel_create_files_as)(struct cred *new, struct inode
> *inode);
>  	int (*kernel_module_request)(char *kmod_name);
> @@ -1779,6 +1784,7 @@ struct security_hook_heads {
>  	struct list_head cred_free;
>  	struct list_head cred_prepare;
>  	struct list_head cred_transfer;
> +	struct list_head cred_getsecid;
>  	struct list_head kernel_act_as;
>  	struct list_head kernel_create_files_as;
>  	struct list_head kernel_read_file;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ce6265960d6c..14848fef8f62 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -324,6 +324,7 @@ int security_cred_alloc_blank(struct cred *cred,
> gfp_t gfp);
>  void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old,
> gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred
> *old);
> +void security_cred_getsecid(const struct cred *c, u32 *secid);
>  int security_kernel_act_as(struct cred *new, u32 secid);
>  int security_kernel_create_files_as(struct cred *new, struct inode
> *inode);
>  int security_kernel_module_request(char *kmod_name);
> diff --git a/security/security.c b/security/security.c
> index 4bf0f571b4ef..02d217597400 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1004,6 +1004,13 @@ void security_transfer_creds(struct cred *new,
> const struct cred *old)
>  	call_void_hook(cred_transfer, new, old);
>  }
>  
> +void security_cred_getsecid(const struct cred *c, u32 *secid)
> +{
> +	*secid = 0;
> +	call_void_hook(cred_getsecid, c, secid);
> +}
> +EXPORT_SYMBOL(security_cred_getsecid);
> +
>  int security_kernel_act_as(struct cred *new, u32 secid)
>  {
>  	return call_int_hook(kernel_act_as, 0, new, secid);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f5d304736852..1d11679674a6 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3836,6 +3836,13 @@ static void selinux_cred_transfer(struct cred
> *new, const struct cred *old)
>  	*tsec = *old_tsec;
>  }
>  
> +static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
> +{
> +	rcu_read_lock();
> +	*secid = cred_sid(c);
> +	rcu_read_unlock();

Is rcu_read_lock() necessary here? Seems like we use cred_sid() in many
places without it.

> +}
> +
>  /*
>   * set the security data for a kernel service
>   * - all the creation contexts are set to unlabelled
> @@ -6338,6 +6345,7 @@ static struct security_hook_list
> selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(cred_free, selinux_cred_free),
>  	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
>  	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
> +	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
>  	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
>  	LSM_HOOK_INIT(kernel_create_files_as,
> selinux_kernel_create_files_as),
>  	LSM_HOOK_INIT(kernel_module_request,
> selinux_kernel_module_request),
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 286171a16ed2..37c35aaa6955 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2049,6 +2049,23 @@ static void smack_cred_transfer(struct cred
> *new, const struct cred *old)
>  	/* cbs copy rule list */
>  }
>  
> +/**
> + * smack_cred_getsecid - get the secid corresponding to a creds
> structure
> + * @c: the object creds
> + * @secid: where to put the result
> + *
> + * Sets the secid to contain a u32 version of the smack label.
> + */
> +static void smack_cred_getsecid(const struct cred *c, u32 *secid)
> +{
> +	struct smack_known *skp;
> +
> +	rcu_read_lock();
> +	skp = smk_of_task(c->security);
> +	*secid = skp->smk_secid;
> +	rcu_read_unlock();
> +}
> +
>  /**
>   * smack_kernel_act_as - Set the subjective context in a set of
> credentials
>   * @new: points to the set of credentials to be modified.
> @@ -4651,6 +4668,7 @@ static struct security_hook_list smack_hooks[]
> __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(cred_free, smack_cred_free),
>  	LSM_HOOK_INIT(cred_prepare, smack_cred_prepare),
>  	LSM_HOOK_INIT(cred_transfer, smack_cred_transfer),
> +	LSM_HOOK_INIT(cred_getsecid, smack_cred_getsecid),
>  	LSM_HOOK_INIT(kernel_act_as, smack_kernel_act_as),
>  	LSM_HOOK_INIT(kernel_create_files_as,
> smack_kernel_create_files_as),
>  	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
