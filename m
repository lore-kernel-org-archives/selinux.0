Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LMVDO8031868
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 17:31:15 -0500
Message-ID: <50FDC1B2.2080309@schaufler-ca.com>
Date: Mon, 21 Jan 2013 14:31:14 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com> <50EB7FCD.3030107@schaufler-ca.com> <201301092211.CGF18746.LMOHJFOOFQtVSF@I-love.SAKURA.ne.jp> <50ED9A22.1090300@schaufler-ca.com> <201301212142.FGF86433.OVQJFMHFLtFSOO@I-love.SAKURA.ne.jp>
In-Reply-To: <201301212142.FGF86433.OVQJFMHFLtFSOO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/21/2013 4:42 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>>> Casey Schaufler wrote:
>>>> -	security_ops = ops;
>>>> +	if (lsm_count >= COMPOSER_MAX) {
>>>> +		pr_warn("Too many security modules. %s not loaded.\n",
>>>> +				ops->name);
>>>> +		return 0;
>>>> +	}
>>>>  
>>>> -	return 0;
>>>> +	if (specified_lsms[0][0] != '\0') {
>>> We can do "specified_lsms[0][0] = '\0';" after "do_security_initcalls();" so
>>> that LKM-based LSMs can be loaded without depending on security= argument?
>> You are going to have to introduce more mechanism if you want to
>> provide for LKM-based LSMs. How about we consider a change here until
>> you can propose that mechanism in its entirety.
>>
> Below is what I think we need for "current v12 patchset" + "LKM-based LSM
> support" + "Require a valid ->order value to all LSM" approach.
> What other mechanism we are missing?

The big trouble is cleaning up blobs that an LSM has allocated
at the time an LSM is unloaded. I am only including the ability
to unregister via reset_security_ops (which I plan to rename,
more on that later) because SELinux depends on it.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 535a967..615c957 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1876,10 +1876,7 @@ extern struct security_operations *lsm_present;
>  /* prototypes */
>  extern int security_init(void);
>  extern int security_module_enable(struct security_operations *ops);
> -
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -extern int reset_security_ops(struct security_operations *ops);
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> +extern void reset_security_ops(struct security_operations *ops);

Making this a void is the right thing to do. At one point in the
development of this patch this function could fail, but that's
no longer the case.

I'm renaming reset_security_ops to security_module_disable to match
up with security_module_enable. I know it's unnecessary, but I think
it's the right thing to do.

>  
>  /* Security operations */
>  int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
> diff --git a/security/security.c b/security/security.c
> index 72bf9dc..9ec72a8 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -34,11 +34,11 @@
>  
>  /* Boot-time LSM user choice */
>  
> -static __initdata char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1];
> +static char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1];
>  static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
> -static __initdata char present_lsm[SECURITY_NAME_MAX + 1] =
> -	CONFIG_PRESENT_SECURITY;
> +static char present_lsm[SECURITY_NAME_MAX + 1] = CONFIG_PRESENT_SECURITY;
>  
> +static DEFINE_SPINLOCK(lsm_registration_lock);
>  struct list_head lsm_hooks[LSM_MAX_HOOKS];
>  struct security_operations *lsm_present;
>  
> @@ -57,9 +57,8 @@ static int lsm_count;
>   * The "interesting" logic is included here rather than in the
>   * caller to reduce the volume of the calling code.
>   */
> -static void __init lsm_enlist(struct security_operations *ops,
> -				const enum lsm_hooks_index index,
> -				void *interesting)
> +static void lsm_enlist(struct security_operations *ops,
> +		       const enum lsm_hooks_index index, void *interesting)
>  {
>  	struct security_operations *sop;
>  
> @@ -85,7 +84,7 @@ static void __init lsm_enlist(struct security_operations *ops,
>  	}
>  }
>  
> -static void __init lsm_enlist_ops(struct security_operations *sop)
> +static void lsm_enlist_ops(struct security_operations *sop)
>  {
>  	lsm_enlist(sop, lsm_ptrace_access_check, sop->ptrace_access_check);
>  	lsm_enlist(sop, lsm_ptrace_traceme, sop->ptrace_traceme);
> @@ -328,15 +327,12 @@ int __init security_init(void)
>  	pr_info("Security Framework initialized\n");
>  
>  	do_security_initcalls();
> +	/* LKM-based LSM modules do not depend on security= argument. */
> +	specified_lsms[0][0] = '\0';
>  
>  	return 0;
>  }
>  
> -/*
> - * Only SELinux calls reset_security_ops.
> - */
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -
>  static void lsm_delist_ops(struct security_operations *sop)
>  {
>  	enum lsm_hooks_index i;
> @@ -347,7 +343,16 @@ static void lsm_delist_ops(struct security_operations *sop)
>  	return;
>  }
>  
> -int reset_security_ops(struct security_operations *ops)
> +/**
> + * reset_security_ops - Unregister given security module.
> + *
> + * @ops: a pointer to the struct security_operations.
> + *
> + * Note that this is for unregistering but not for unloading, for LSM
> + * infrastracture does not provide a mechanism for determining whether it is
> + * safe to unload the given module.
> + */
> +void reset_security_ops(struct security_operations *ops)
>  {
>  	/*
>  	 * This LSM is configured to own /proc/.../attr.
> @@ -355,12 +360,11 @@ int reset_security_ops(struct security_operations *ops)
>  	if (lsm_present == ops)
>  		lsm_present = NULL;
>  
> +	spin_lock(&lsm_registration_lock);
>  	lsm_delist_ops(ops);
> -
> -	return 0;
> +	spin_unlock(&lsm_registration_lock);
>  }
> -
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> +EXPORT_SYMBOL_GPL(reset_security_ops);
>  
>  /* Save user chosen LSM(s) */
>  static int __init choose_lsm(char *str)
> @@ -402,11 +406,12 @@ __setup("security=", choose_lsm);
>   *	-or no boot list was specified.
>   * Otherwise, return false.
>   */
> -int __init security_module_enable(struct security_operations *ops)
> +int security_module_enable(struct security_operations *ops)
>  {
>  	struct security_operations *sop;
>  	int i;
>  
> +	spin_lock(&lsm_registration_lock);
>  	/*
>  	 * Set up the operation vector early, but only once.
>  	 * This allows LSM specific file systems to check to see if they
> @@ -415,14 +420,14 @@ int __init security_module_enable(struct security_operations *ops)
>  	if (ops == NULL) {
>  		pr_debug("%s could not verify security_operations.\n",
>  				__func__);
> -		return 0;
> +		goto fail;
>  	}
>  	/*
>  	 * Return success if the LSM is already resistered
>  	 */
>  	for_each_hook(sop, name)
>  		if (sop == ops)
> -			return 1;
> +			goto ok;
>  
>  	/*
>  	 * This LSM has not yet been ordered.
> @@ -432,7 +437,7 @@ int __init security_module_enable(struct security_operations *ops)
>  	if (lsm_count >= COMPOSER_MAX) {
>  		pr_warn("Too many security modules. %s not loaded.\n",
>  				ops->name);
> -		return 0;
> +		goto fail;
>  	}
>  
>  	if (specified_lsms[0][0] != '\0') {
> @@ -445,7 +450,7 @@ int __init security_module_enable(struct security_operations *ops)
>  		if (ops->order == -1) {
>  			pr_notice("LSM %s declined by boot options.\n",
>  					ops->name);
> -			return 0;
> +			goto fail;
>  		}
>  	}
>  	/*
> @@ -456,14 +461,14 @@ int __init security_module_enable(struct security_operations *ops)
>  	    !list_empty(&lsm_hooks[lsm_xfrm_policy_alloc_security])) {
>  		pr_warn("LSM conflict on %s. %s not loaded.\n",
>  				"xfrm_policy_alloc_security", ops->name);
> -		return 0;
> +		goto fail;
>  	}
>  #endif
>  	if (ops->secid_to_secctx &&
>  	    !list_empty(&lsm_hooks[lsm_secid_to_secctx])) {
>  		pr_warn("LSM conflict on %s. %s not loaded.\n",
>  			"secid_to_secctx", ops->name);
> -		return 0;
> +		goto fail;
>  	}
>  
>  	/*
> @@ -499,9 +504,14 @@ int __init security_module_enable(struct security_operations *ops)
>  	 * Return success after registering the LSM.
>  	 */
>  	lsm_enlist_ops(ops);
> -
> +ok:
> +	spin_unlock(&lsm_registration_lock);
>  	return 1;
> +fail:
> +	spin_unlock(&lsm_registration_lock);
> +	return 0;
>  }
> +EXPORT_SYMBOL_GPL(security_module_enable);

I am disinclined to put in what might appear to be support
for dynamic security modules when I'm not yet willing to
sign up for that.

>  
>  /* Security operations */
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8ec7ea0..9bdea1e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5814,8 +5814,6 @@ static int selinux_disabled;
>  
>  int selinux_disable(void)
>  {
> -	int rc;
> -
>  	if (ss_initialized) {
>  		/* Not permitted after initial policy load. */
>  		return -EINVAL;
> @@ -5826,11 +5824,7 @@ int selinux_disable(void)
>  		return -EINVAL;
>  	}
>  
> -	rc = reset_security_ops(&selinux_ops);
> -	if (rc) {
> -		pr_info("SELinux:  Runtime disable disallowed.\n");
> -		return rc;
> -	}
> +	reset_security_ops(&selinux_ops);
>  
>  	printk(KERN_INFO "SELinux:  Disabled at runtime.\n");
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
