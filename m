Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBBFVq98020555
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2012 10:31:52 -0500
Message-ID: <50C751D3.60409@schaufler-ca.com>
Date: Tue, 11 Dec 2012 07:31:31 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v10] LSM: Multiple concurrent LSMs
References: <50C65DE2.5090909@schaufler-ca.com> <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
In-Reply-To: <201212112128.ADI26010.OQJVLOFSOFtHMF@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/11/2012 4:28 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> The /proc/*/attr interfaces are given to one LSM. This
>> can be done by setting CONFIG_SECURITY_PRESENT.
> I don't like CONFIG_SECURITY_PRESENT.
>
>>  int security_getprocattr(struct task_struct *p, char *name, char **value)
>>  {
>> -	return security_ops->getprocattr(p, name, value);
>> +	if (lsm_present)
>> +		return present_getprocattr(p, name, value);
>> +	return -EINVAL;
>>  }
>>  
>> -int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
>> +int security_setprocattr(struct task_struct *p, char *name, void *value,
>> +				size_t size)
>>  {
>> -	return security_ops->setprocattr(p, name, value, size);
>> +	if (lsm_present)
>> +		return present_setprocattr(p, name, value, size);
>> +	return -EINVAL;
>>  }
> is what I meant but
>
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
> is not what I meant.
>
> CONFIG_SECURITY_PRESENT must be always PRESENT_FIRST and only one LSM module
> which provides ops->getprocattr and/or ops->setprocattr is allowed to register.

No.
Absolutely not.

That restriction would make composing security modules completely
useless. At least for me. Sorry, but Smack + AppArmor is one of my
success criteria. I have introduced a smackfs/current interface
in this patch, but I plan to abandon that in favor of the enhanced
proc/.../attr entries we've been discussing.

I have not given up hope on secid using LSM combinations, either.
I really would prefer that there be no limitations.


> This is a mandatory requirement for not to break userspace tools for
> non-present LSM modules by supplying /proc/pid/attr/ interface that is
> malfunction for non-present LSM modules.
>
> 	/*
> 	 * Check for conflicting LSMs.
> 	 */
> #ifdef CONFIG_SECURITY_NETWORK_XFRM
> 	if (ops->xfrm_policy_alloc_security &&
> 	    !list_empty(&lsm_hooks[LSM_xfrm_policy_alloc_security])) {
> 		pr_warn("LSM conflict on %s. %s not loaded.\n",
> 				"xfrm_policy_alloc_security", ops->name);
> 		return 0;
> 	}
> #endif
> 	if (ops->secid_to_secctx &&
> 	    !list_empty(&lsm_hooks[LSM_secid_to_secctx])) {
> 		pr_warn("LSM conflict on %s. %s not loaded.\n",
> 			"secid_to_secctx", ops->name);
> 		return 0;
> 	}
> 	if ((ops->getprocattr && !list_empty(&lsm_hooks[LSM_getprocattr])) ||
> 	    (ops->setprocattr && !list_empty(&lsm_hooks[LSM_setprocattr]))) {
> 		pr_warn("LSM conflict on %s. %s not loaded.\n",
> 			"getprocattr/setprocattr", ops->name);
> 		return 0;
> 	}
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
