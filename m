Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBKHbBBr014939
	for <selinux@tycho.nsa.gov>; Thu, 20 Dec 2012 12:37:11 -0500
Message-ID: <50D34CA7.4030908@schaufler-ca.com>
Date: Thu, 20 Dec 2012 09:36:39 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: linux-security-module@vger.kernel.org, jmorris@namei.org,
        john.johansen@canonical.com, eparis@redhat.com, keescook@chromium.org,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v11 0/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com> <201212202302.GGH12474.tLSOMOVHFFJQOF@I-love.SAKURA.ne.jp>
In-Reply-To: <201212202302.GGH12474.tLSOMOVHFFJQOF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/20/2012 6:02 AM, Tetsuo Handa wrote:
> Several bugfixes for v11 patchset.
>
>   Fixed off-by-one bug in lsm_read().

Where is the off-by-one error?

>  (Changed to use PAGE_SIZE in preparation for LKM-based LSM modules.)

How does this help in the LKM-based case? I don't see it.

>   Fixed race condition in present_read().

Yes, there could be a problem with reset_security_ops.
I'll use this.

>   Removed redundant specified_lsms[][].

It's __init data, and ensures the result is correct.
If there's a good reason to change the way boot ordering
is done, I'm open to it, but I don't see how your change
makes anything better.

>   Removed COMPOSER_NAMES_MAX symbol.

I don't like your PAGE_SIZE assumptions one bit. I will stick
with COMPOSER_NAMES_MAX and feel secure in knowing that the
buffers will be big enough.

>
>   Moved "Too many security modules." check in security_module_enable()
>   to after confirming that that module is not yet registered.

Yup, a good change.

> Fixed off-by-one order assignment in security_module_enable().
>   (ops->order must be 0...COMPOSER_MAX-1 rather than 1...COMPOSER_MAX,
>    for ops->order is index used by lsm_get_blob()/lsm_set_blob().

The zeroth blob used to be the capability vector, but that's
gone now, you're correct.

> LSM modules which do not use lsm_get_blob()/lsm_set_blob() will be able to
>    use ops->order == -1. By allowing LKM-based LSM modules, users can add
>    LSM modules with ops->order == -1 regardless of COMPOSER_MAX constraint.)

An LSM that uses no blobs (e.g. Yama) does not care what value is in sop->order.
An LSM that uses any blobs needs a unique sop->order.
 

>   ops->getprocattr && ops->setprocattr in security_module_enable() should be
>   ops->getprocattr || ops->setprocattr in case out-of-tree LSM modules provided
>   only either one.

No. Think it through. It makes no sense whatever for an LSM to supply one
without the other. That, and it could cock up the race condition logic for
reset_security_ops and those two hooks.

> I felt that it would be nice if /proc/pid/attr/$lsmname.$type is created only
> when $lsmname is registered, but doing so might be difficult because it is a
> constant array. Out-of-tree LSM must manually add entries by directly modifying
> fs/proc/base.c . Furthermore, LKM-based LSM cannot add entries (although
> neither TOMOYO nor CaitSith will need it).

I agree that it would be better if the entries were added on registration.
I also agree (sort of) that lsm/current is better than lsm.current.
I would be open to proposed implementations.

> diff --git a/include/linux/lsm.h b/include/linux/lsm.h
> index 5f36b6b..fcf852e 100644
> --- a/include/linux/lsm.h
> +++ b/include/linux/lsm.h
> @@ -24,7 +24,6 @@
>   * Maximum number of LSMs that can be used at a time.
>   */
>  #define COMPOSER_MAX		CONFIG_SECURITY_COMPOSER_MAX
> -#define COMPOSER_NAMES_MAX	((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)
>  
>  #include <linux/security.h>
>  
> diff --git a/security/inode.c b/security/inode.c
> index 2c14313..8cebd4b 100644
> --- a/security/inode.c
> +++ b/security/inode.c

No. I'm keeping a safe constant for buffer sizes.

> @@ -225,15 +225,19 @@ static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  {
>  	struct security_operations *sop;
>  	char *data;
> -	int len;
> +	int len = 0;
>  
> -	data = kzalloc(COMPOSER_NAMES_MAX, GFP_KERNEL);
> +	/*
> +	 * We assume that total length is shorter than PAGE_SIZE bytes
> +	 * no matter how many LSM modules are loaded.
> +	 */
> +	data = kzalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (data == NULL)
>  		return -ENOMEM;
>  
>  	list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
> -		strcat(data, sop->name);
> -		strcat(data, ",");
> +		len += snprintf(data + len, PAGE_SIZE - 1 - len, "%s,",
> +				sop->name);
>  	}
>  	len = strlen(data);
>  	if (len > 1)

No. I am not making assumptions about buffer sizes and there is no off-by-one error.

> @@ -257,9 +261,10 @@ static ssize_t present_read(struct file *filp, char __user *buf, size_t count,
>  	char *raw;
>  	char *data;
>  	int len;
> +	struct security_operations *ops = lsm_present;
>  
> -	if (lsm_present)
> -		raw = lsm_present->name;
> +	if (ops)
> +		raw = ops->name;
>  	else
>  		raw = "(none)";
>  	len = strlen(raw);
> diff --git a/security/security.c b/security/security.c
> index 75e2f6e..48597d6 100644
> --- a/security/security.c
> +++ b/security/security.c

Yes. Have I mentioned how I feel about reset_security_ops?

> @@ -34,8 +34,7 @@
>  
>  /* Boot-time LSM user choice */
>  
> -static __initdata char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1];
> -static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
> +static __initdata char allowed_lsms[((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)];
>  static __initdata char present_lsm[SECURITY_NAME_MAX + 1] =
>  	CONFIG_PRESENT_SECURITY;
>  
> @@ -47,8 +46,6 @@ static int (*present_getprocattr)
>  static int (*present_setprocattr)
>  		(struct task_struct *p, char *name, void *value, size_t size);
>  
> -static int lsm_count;
> -
>  #define for_each_hook(SOP, HOOK) \
>  	list_for_each_entry(SOP, &lsm_hooks[LSM_##HOOK], list[LSM_##HOOK])
>  
> @@ -363,26 +360,7 @@ int reset_security_ops(struct security_operations *ops)
>  /* Save user chosen LSM(s) */
>  static int __init choose_lsm(char *str)
>  {
> -	char *cp;
> -	char *ep;
> -	int i;
> -
> -	strncpy(allowed_lsms, str, COMPOSER_NAMES_MAX);
> -	cp = allowed_lsms;
> -
> -	for (i = 0; i < COMPOSER_MAX; i++) {
> -		ep = strchr(cp, ',');
> -		if (ep != NULL)
> -			*ep = '\0';
> -		if (strlen(cp) > SECURITY_NAME_MAX)
> -			pr_warn("LSM \"%s\" is invalid and ignored.\n", cp);
> -		else
> -			strncpy(specified_lsms[i], cp, SECURITY_NAME_MAX);
> -		if (ep == NULL)
> -			break;
> -		cp = ep + 1;
> -	}
> -
> +	strncpy(allowed_lsms, str, sizeof(allowed_lsms) - 1);
>  	return 1;
>  }
>  __setup("security=", choose_lsm);

No. I like the way I'm doing it just fine.

> @@ -402,14 +380,10 @@ __setup("security=", choose_lsm);
>   */
>  int __init security_module_enable(struct security_operations *ops)
>  {
> -	struct security_operations *sop;
> +	static int lsm_count;
> + 	struct security_operations *sop;
>  	int i;
>  
> -	if (lsm_count >= COMPOSER_MAX) {
> -		pr_warn("Too many security modules. %s not loaded.\n",
> -				ops->name);
> -		return 0;
> -	}
>  	/*
>  	 * Set up the operation vector early, but only once.
>  	 * This allows LSM specific file systems to check to see if they

Yes to moving lsm_count check.
No to lsm_count move.

> @@ -420,6 +394,7 @@ int __init security_module_enable(struct security_operations *ops)
>  				__func__);
>  		return 0;
>  	}
> +
>  	/*
>  	 * Return success if the LSM is already resistered
>  	 */
> @@ -427,20 +402,42 @@ int __init security_module_enable(struct security_operations *ops)
>  		if (sop == ops)
>  			return 1;
>  
> -	if (specified_lsms[0][0] != '\0') {
> -		ops->order = 0;
> -		for (i = 0; specified_lsms[i][0] != '\0'; i++) {
> -			if (strcmp(ops->name, specified_lsms[i]) == 0) {
> -				ops->order = i + 1;
> +	/*
> +	 * Determine the call order and blob slot for this module.
> +	 */
> +	if (!*allowed_lsms) {
> +		/* First come, first called. */
> +		i = lsm_count;
> +	} else {
> +		/*
> +		 * Call order is controlled by security= parameter.
> +		 * Decline if this module is not listed.
> +		 */
> +		const char *name = ops->name;
> +		const int name_len = strlen(name);
> +		const char *lsm = allowed_lsms;
> +		i = 0;
> +		while (*lsm) {
> +			if (!strncmp(lsm, name, name_len) &&
> +			    (!lsm[name_len] || lsm[name_len] == ','))
>  				break;
> -			}
> +			while (*lsm && *lsm++ != ',')
> +				;
> +			i++;
>  		}
> -		if (ops->order == 0) {
> +		if (!*lsm) {
>  			pr_notice("LSM %s declined by boot options.\n",
> -					ops->name);
> +				  name);
>  			return 0;
>  		}
>  	}
> +	if (lsm_count >= COMPOSER_MAX) {
> +		pr_warn("Too many security modules. %s not loaded.\n",
> +			ops->name);
> +		return 0;
> +	}
> +	ops->order = i;
> +
>  	/*
>  	 * Check for conflicting LSMs.
>  	 */

No to boot order logic.
Yes to moving lsm_count check.

> @@ -460,26 +457,13 @@ int __init security_module_enable(struct security_operations *ops)
>  	}
>  
>  	/*
> -	 * The order will already be set if the command line
> -	 * includes "security=".
> -	 *
> -	 * Do this before the enlisting. If there is an error
> -	 * (Very unlikely!) that prevents the enlisting from
> -	 * completing it is still necessary to have a blob slot
> -	 * for it.
> -	 */
> -	lsm_count++;
> -	if (ops->order == 0)
> -		ops->order = lsm_count;
> -
> -	/*
>  	 * Use the LSM specified by CONFIG_SECURITY_PRESENT for
>  	 * [gs]etprocattr. If the LSM specified is PRESENT_FIRST
>  	 * use the first LSM to register that has the hooks.
>  	 * If the specified LSM lacks the hooks treat it as if
>  	 * there is no LSM registered that supplied them.
>  	 */
> -	if (ops->getprocattr && ops->setprocattr &&
> +	if ((ops->getprocattr || ops->setprocattr) &&
>  	    (!strcmp(ops->name, present_lsm) ||
>  	     (!lsm_present && !strcmp(PRESENT_FIRST, present_lsm)))) {
>  		lsm_present = ops;

No on boot order logic
No on present condidtions

> @@ -488,9 +472,11 @@ int __init security_module_enable(struct security_operations *ops)
>  		pr_info("Security Module %s is presented in /proc.\n",
>  			ops->name);
>  	}
> +
>  	/*
>  	 * Return success after registering the LSM.
>  	 */
> +	lsm_count++;
>  	lsm_enlist_ops(ops);
>  
>  	return 1;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
