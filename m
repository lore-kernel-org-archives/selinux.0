Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r09GQTiC016390
	for <selinux@tycho.nsa.gov>; Wed, 9 Jan 2013 11:26:29 -0500
Message-ID: <50ED9A22.1090300@schaufler-ca.com>
Date: Wed, 09 Jan 2013 08:26:10 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50EB7C50.3070605@schaufler-ca.com> <50EB7FCD.3030107@schaufler-ca.com> <201301092211.CGF18746.LMOHJFOOFQtVSF@I-love.SAKURA.ne.jp>
In-Reply-To: <201301092211.CGF18746.LMOHJFOOFQtVSF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/9/2013 5:11 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> +/* Save user chosen LSM(s) */
>>  static int __init choose_lsm(char *str)
>>  {
>> -	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
>> +	char *cp;
>> +	char *ep;
>> +	int i;
>> +
>> +	strncpy(allowed_lsms, str, COMPOSER_NAMES_MAX);
>> +	cp = allowed_lsms;
>> +
>> +	for (i = 0; i < COMPOSER_MAX; i++) {
>> +		ep = strchr(cp, ',');
>> +		if (ep != NULL)
>> +			*ep = '\0';
>> +		if (strlen(cp) > SECURITY_NAME_MAX)
>> +			pr_warn("LSM \"%s\" is invalid and ignored.\n", cp);
> panic() might be OK for notifying the administrator of invalid module name.

I don't think panic is a good idea unless there is no alternative.
Even then it's a bad idea. It's just all you can do.

>> +		else
>> +			strncpy(specified_lsms[i], cp, SECURITY_NAME_MAX);
>> +		if (ep == NULL)
>> +			break;
>> +		cp = ep + 1;
>> +	}
>> +
>>  	return 1;
>>  }
>>  __setup("security=", choose_lsm);
>> @@ -94,74 +398,303 @@ __setup("security=", choose_lsm);
>>   * to check if your LSM is currently loaded during kernel initialization.
>>   *
>>   * Return true if:
>> - *	-The passed LSM is the one chosen by user at boot time,
>> - *	-or the passed LSM is configured as the default and the user did not
>> - *	 choose an alternate LSM at boot time.
>> + *	-The passed LSM is on the list of LSMs specified at boot time,
>> + *	-or no boot list was specified.
>>   * Otherwise, return false.
>>   */
>>  int __init security_module_enable(struct security_operations *ops)
>>  {
>> -	return !strcmp(ops->name, chosen_lsm);
>> -}
>> +	struct security_operations *sop;
>> +	int i;
>>  
>> -/**
>> - * register_security - registers a security framework with the kernel
>> - * @ops: a pointer to the struct security_options that is to be registered
>> - *
>> - * This function allows a security module to register itself with the
>> - * kernel security subsystem.  Some rudimentary checking is done on the @ops
>> - * value passed to this function. You'll need to check first if your LSM
>> - * is allowed to register its @ops by calling security_module_enable(@ops).
>> - *
>> - * If there is already a security module registered with the kernel,
>> - * an error will be returned.  Otherwise %0 is returned on success.
>> - */
>> -int __init register_security(struct security_operations *ops)
>> -{
> This change makes security_module_enable() to imply register_security(), but
> do we want to continue booting (i.e. "return 0;" rather than "panic();" if
> security_module_enable() failed by "Too many" or "LSM conflict on ..." cases?

I'm personally sensitive to people screaming that "every time I try to
configure security the system breaks!" so I am disinclined to introduce
a hard failure.

> John Johansen wrote:
>> Stephen Smalley wrote:
>>> IIRC, the AppArmor devs indicated that they plan to start using secids,
>>> which would mean that it would not be possible to stack AppArmor with Smack
>>> or SELinux using this mechanism.  So eventually that would have to be
>>> addressed in order for this to even support the AppArmor+Smack or
>>> AppArmor+SELinux use cases.
>>>
>> We do intend to use secids, but it is being done so that its
>> configurable. Configuring it off means you loose apparmor
>> mediation for the bits that need secids. Solving the secids
>> issue is of interest but its not required atm.
> If "configuration" means runtime degeneracy rather than compile time choice, we
> need to be able to distinguish "AppArmor should be enabled only when no
> conflict", "AppArmor should be enabled with degeneracy when conflict" and
> "AppArmor should not be enabled". How do we tell the administrator's choice to
> AppArmor, and how can security_module_enable() tell the situation to AppArmor?
>
> I guess security_module_enable() need to return something like
>
>   -ENOENT if that module's name is not passed to security= argument,
>   -EBUSY if that module's name is passed to security= argument but cannot be
>   loaded due to conflicts,
>   -ENOSPC if that module's name is passed to security= argument but cannot be
>   loaded due to out of blob slot,
>   0 if that module's name is passed to security= argument and successfully
>   loaded
>
> so that the caller of security_module_enable() can "panic();" for -ENOSPC case
> and "return 0;" for -ENOENT case and "continue initialization" for 0 case and
> optionally "retry security_module_enable() with degenerated security ops" for
> -EBUSY case.
>
> In this case, we want to specify default name of LSM modules (which will be
> used when security= argument is not specified) via kernel config.

I am not considering runtime degeneracy.

> Casey Schaufler wrote:
>> -	if (verify(ops)) {
>> -		printk(KERN_DEBUG "%s could not verify "
>> -		       "security_operations structure.\n", __func__);
>> -		return -EINVAL;
>> +	/*
>> +	 * Set up the operation vector early, but only once.
>> +	 * This allows LSM specific file systems to check to see if they
>> +	 * should come on line.
>> +	 */
>> +	if (ops == NULL) {
>> +		pr_debug("%s could not verify security_operations.\n",
>> +				__func__);
>> +		return 0;
>>  	}
>> +	/*
>> +	 * Return success if the LSM is already resistered
>> +	 */
>> +	for_each_hook(sop, name)
>> +		if (sop == ops)
>> +			return 1;
>>  
>> -	if (security_ops != &default_security_ops)
>> -		return -EAGAIN;
>> +	/*
>> +	 * This LSM has not yet been ordered.
>> +	 */
>> +	ops->order = -1;
>>  
>> -	security_ops = ops;
>> +	if (lsm_count >= COMPOSER_MAX) {
>> +		pr_warn("Too many security modules. %s not loaded.\n",
>> +				ops->name);
>> +		return 0;
>> +	}
>>  
>> -	return 0;
>> +	if (specified_lsms[0][0] != '\0') {
> We can do "specified_lsms[0][0] = '\0';" after "do_security_initcalls();" so
> that LKM-based LSMs can be loaded without depending on security= argument?

You are going to have to introduce more mechanism if you want to
provide for LKM-based LSMs. How about we consider a change here until
you can propose that mechanism in its entirety.

>> +		for (i = 0; specified_lsms[i][0] != '\0'; i++) {
>> +			if (strcmp(ops->name, specified_lsms[i]) == 0) {
>> +				ops->order = i;
>> +				break;
>> +			}
>> +		}
>> +		if (ops->order == -1) {
>> +			pr_notice("LSM %s declined by boot options.\n",
>> +					ops->name);
>> +			return 0;
>> +		}
>> +	}
>> +	/*
>> +	 * Check for conflicting LSMs.
>> +	 */
>> +#ifdef CONFIG_SECURITY_NETWORK_XFRM
>> +	if (ops->xfrm_policy_alloc_security &&
>> +	    !list_empty(&lsm_hooks[lsm_xfrm_policy_alloc_security])) {
>> +		pr_warn("LSM conflict on %s. %s not loaded.\n",
>> +				"xfrm_policy_alloc_security", ops->name);
>> +		return 0;
>> +	}
>> +#endif
>> +	if (ops->secid_to_secctx &&
>> +	    !list_empty(&lsm_hooks[lsm_secid_to_secctx])) {
>> +		pr_warn("LSM conflict on %s. %s not loaded.\n",
>> +			"secid_to_secctx", ops->name);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * The order will already be set if the command line
>> +	 * includes "security=".
>> +	 *
>> +	 * Do this before the enlisting. If there is an error
>> +	 * (Very unlikely!) that prevents the enlisting from
>> +	 * completing it is still necessary to have a blob slot
>> +	 * for it.
>> +	 */
> I think "If there is an error (Very unlikely!)" never happens after this point.
>
>> +	if (ops->order == -1)
>> +		ops->order = lsm_count;
>> +	lsm_count++;
>> +
>> +	/*
>> +	 * Use the LSM specified by CONFIG_SECURITY_PRESENT for
>> +	 * [gs]etprocattr. If the LSM specified is PRESENT_FIRST
>> +	 * use the first LSM to register that has the hooks.
>> +	 * If the specified LSM lacks the hooks treat it as if
>> +	 * there is no LSM registered that supplied them.
>> +	 */
>> +	if (ops->getprocattr && ops->setprocattr &&
>> +	    (!strcmp(ops->name, present_lsm) ||
>> +	     (!lsm_present && !strcmp(PRESENT_FIRST, present_lsm)))) {
>> +		lsm_present = ops;
>> +		present_getprocattr = ops->getprocattr;
>> +		present_setprocattr = ops->setprocattr;
>> +		pr_info("Security Module %s is presented in /proc.\n",
>> +			ops->name);
>> +	}
>> +	/*
>> +	 * Return success after registering the LSM.
>> +	 */
>> +	lsm_enlist_ops(ops);
>> +
>> +	return 1;
>>  }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
