Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3QFcUXp025601
 for <selinux@tycho.nsa.gov>; Wed, 26 Apr 2017 11:38:31 -0400
Subject: Re: [PATCH 1/3] selinux: Implement LSM notification system
To: Sebastien Buisson <sbuisson.ddn@gmail.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com, danielj@mellanox.com,
 Sebastien Buisson <sbuisson@ddn.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8d4c5ab6-8c15-312a-398b-c3ee9d7e8cb6@schaufler-ca.com>
Date: Wed, 26 Apr 2017 08:38:22 -0700
MIME-Version: 1.0
In-Reply-To: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 4/26/2017 8:02 AM, Sebastien Buisson wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Add a generic notification mechanism in the LSM. Interested consumers
> can register a callback with the LSM and security modules can produce
> events.

Why is this a generic mechanism? Do you ever see anyone
other than SELinux using it?

> Add a call to the notification mechanism from SELinux when the AVC
> cache changes.

This seems like a whole lot of mechanism for
something you could accomplish with a log message.
What am I missing?

>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> ---
>  include/linux/security.h | 23 +++++++++++++++++++++++
>  security/security.c      | 20 ++++++++++++++++++++
>  security/selinux/hooks.c | 12 ++++++++++++
>  3 files changed, 55 insertions(+)
>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index af675b5..73a9c93 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -68,6 +68,10 @@
>  struct user_namespace;
>  struct timezone;
>  
> +enum lsm_event {
> +	LSM_POLICY_CHANGE,
> +};
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, int audit);
> @@ -163,6 +167,10 @@ struct security_mnt_opts {
>  	int num_mnt_opts;
>  };
>  
> +int call_lsm_notifier(enum lsm_event event, void *data);
> +int register_lsm_notifier(struct notifier_block *nb);
> +int unregister_lsm_notifier(struct notifier_block *nb);
> +
>  static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
>  {
>  	opts->mnt_opts = NULL;
> @@ -381,6 +389,21 @@ int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
>  struct security_mnt_opts {
>  };
>  
> +static inline int call_lsm_notifier(enum lsm_event event, void *data)
> +{
> +	return 0;
> +}
> +
> +static inline int register_lsm_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline  int unregister_lsm_notifier(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
>  static inline void security_init_mnt_opts(struct security_mnt_opts *opts)
>  {
>  }
> diff --git a/security/security.c b/security/security.c
> index b9fea39..ef9d9e1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -32,6 +32,8 @@
>  /* Maximum number of letters for an LSM name string */
>  #define SECURITY_NAME_MAX	10
>  
> +static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
> +
>  struct security_hook_heads security_hook_heads __lsm_ro_after_init;
>  char *lsm_names;
>  /* Boot-time LSM user choice */
> @@ -146,6 +148,24 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  		panic("%s - Cannot get early memory.\n", __func__);
>  }
>  
> +int call_lsm_notifier(enum lsm_event event, void *data)
> +{
> +	return atomic_notifier_call_chain(&lsm_notifier_chain, event, data);
> +}
> +EXPORT_SYMBOL(call_lsm_notifier);
> +
> +int register_lsm_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&lsm_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(register_lsm_notifier);
> +
> +int unregister_lsm_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_unregister(&lsm_notifier_chain, nb);
> +}
> +EXPORT_SYMBOL(unregister_lsm_notifier);
> +
>  /*
>   * Hook list operation macros.
>   *
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..a4d36f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -171,6 +171,14 @@ static int selinux_netcache_avc_callback(u32 event)
>  	return 0;
>  }
>  
> +static int selinux_lsm_notifier_avc_callback(u32 event)
> +{
> +	if (event == AVC_CALLBACK_RESET)
> +		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
> +
> +	return 0;
> +}
> +
>  /*
>   * initialise the security for the init task
>   */
> @@ -6379,6 +6387,10 @@ static __init int selinux_init(void)
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
>  
> +	if (avc_add_callback(selinux_lsm_notifier_avc_callback,
> +			     AVC_CALLBACK_RESET))
> +		panic("SELinux: Unable to register AVC LSM notifier callback\n");
> +
>  	if (selinux_enforcing)
>  		printk(KERN_DEBUG "SELinux:  Starting in enforcing mode\n");
>  	else
