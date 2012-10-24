Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9OIXK1f003842
	for <selinux@tycho.nsa.gov>; Wed, 24 Oct 2012 14:33:20 -0400
Message-ID: <50883450.8040301@schaufler-ca.com>
Date: Wed, 24 Oct 2012 11:32:48 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: keescook@chromium.org, jmorris@namei.org,
        linux-security-module@vger.kernel.org, john.johansen@canonical.com,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5] LSM: Multiple concurrent LSMs
References: <5081B30F.6090009@schaufler-ca.com> <CAGXu5jJKWZMJbX+kQZb1Qe64EjuZMEubCgtiV4COXWo9=hqPiQ@mail.gmail.com> <201210242225.EFC43782.FLFQMHOOVFJOSt@I-love.SAKURA.ne.jp>
In-Reply-To: <201210242225.EFC43782.FLFQMHOOVFJOSt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2012 6:25 AM, Tetsuo Handa wrote:
> Kees Cook wrote:
>> prctl control needs special handling. When an option is unhandled,
>> it'll return -ENOSYS. Also, some prctls return non-zero results, so
>> they could mask each other. I think it would make sense to walk the
>> composer list as long as the return value is -ENOSYS. As soon as it
>> isn't, then stop the call chain and return the value. Ultimately, this
>> means that the LSM order defines who get access to a given prctl
>> option (though with caps last).

I don't see why you think prctl is a special case. For starters,
only Yama does anything with it, and Yama does the expected
"call cap if you care" thingy. Yes, the -ENOSYS return is there,
but the current implementation will handle it correctly because
it's in cap_task_prctl.

What am I missing?

>>
>> int i, rc, called = 0;
>> for (i = 1; i < lsm_count; i++) {
>>     if (!composer_ops[i]->task_prctl)
>>         continue;
>>     rc = composer_ops[i]->task_prctl(option, arg2, arg3, arg4, arg5);
>>     called = 1;
>>     if (rc != -ENOSYS)
>>         return rc;
>> }
>> if (!called and composer_ops[0]->task_prctl)
>>     return composer_ops[0]->task_prctl(option, arg2, arg3, arg4, arg5);
>> return rc;
> With optimization, security_task_prctl() would look like below? I removed
> "int called" usage so that LSM modules which implement ->task_prctl need not to
> call cap_task_prctl(). Also, I assume "for (i = 1; i < lsm_count; i++)" will be
> changed to "for (i = 0; i < lsm_count; i++)" if this optimization is accepted.
>
> int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
> 			unsigned long arg4, unsigned long arg5)
> {
> 	int i;
> 	for (i = 1; i < lsm_count; i++) {
> 		int rc;
> 		if (!composer_ops[i]->task_prctl)
> 			continue;
> 		rc = composer_ops[i]->task_prctl(option, arg2, arg3, arg4, arg5);
> 		if (rc != -ENOSYS)
> 			return rc;
> 	}
> 	return cap_task_prctl(option, arg2, arg3, arg4, arg5);
> }
>
> Same thing applies to security_bprm_set_creds() etc. so that LSM modules which
> implement ->bprm_set_creds need not to call cap_bprm_set_creds()?
>
> int security_bprm_set_creds(struct linux_binprm *bprm)
> {
> 	int i;
> 	for (i = 1; i < lsm_count; i++) {
> 		int rc;
> 		if (!composer_ops[i]->bprm_set_creds)
> 			continue;
> 		rc = composer_ops[i]->bprm_set_creds(bprm);
> 		if (rc)
> 			return rc;
> 	}
> 	return cap_bprm_set_creds(bprm);
> }
>
> Casey Schaufler wrote:
>> I still think that we want to "call all" rather than "bail on fail".
> If prctl() is "bail out upon handled" and security_bprm_set_creds() is
> "bail out upon fail", wouldn't it look natural to do like below?
>
> int security_inode_permission(struct inode *inode, int mask)
> {
>  	if (unlikely(IS_PRIVATE(inode)))
>  		return 0;
> 	for (i = 1; i < lsm_count; i++) {
> 		int rc;
> 		if (!composer_ops[i]->inode_permission)
> 			continue;
> 		rc = composer_ops[i]->inode_permission(inode, mask);
> 		if (rc)
> 			return rc;
> 	}
> 	return 0;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
