Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MJhW9F014136
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 14:43:32 -0500
Message-ID: <50FEEBE6.80605@schaufler-ca.com>
Date: Tue, 22 Jan 2013 11:43:34 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50FDC1B2.2080309@schaufler-ca.com> <201301220819.AFB21360.OFOQHJFSFVtLMO@I-love.SAKURA.ne.jp> <50FDD315.7090606@schaufler-ca.com> <201301221009.JDB30838.tFFMVFLOQJSOOH@I-love.SAKURA.ne.jp> <50FDF4FC.1010308@schaufler-ca.com> <201301221623.JIH35408.LFSJQFOFOOHVMt@I-love.SAKURA.ne.jp>
In-Reply-To: <201301221623.JIH35408.LFSJQFOFOOHVMt@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/21/2013 11:23 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> I'm not familiar with try_module_get(), but unless it is trivial,
>> and maybe even then, I have no interest in adding its overhead
>> in that loop.
> I noticed that try_module_get() is not sufficient, for it may race with
> preemption. Please see srcu lock version submitted 4 minutes before your post.
>
>>> You want to make sure that all blobs used by a LSM module are cleaned up before
>>> unloading that module, don't you?
>> That is necessary, but not sufficient. The lsm_blob needs to
>> be cleaned up as well. And the rub is that you need to use the
>> LSM provided free functions, but you can't count on them
>> working once the LSM is disabled because the LSM is, after
>> all, disabled.
> Yes, cleaning up lsm_blob is necessary if that module used lsm_blobs.
> My answer is I can convert TOMOYO not to use lsm_blob, which means cleaning up
> lsm_blob is unnecessary.

All you're doing is moving the problem into the LSM.

> I wonder why do we need to use the LSM provided free functions and we can't
> count on them?

You need to use the LSM free functions because only the LSM knows
how the data was allocated.

You can't count on them once the LSM is unregistered because the
LSM is out of the hook lists and you can't find the hooks anymore.

> Unloading function which is specified using module_exit() tag (e.g.
>
>   static void __exit foo_exit(void)
>   {
>      /* Do cleanup stuff here. */
>   }
>   module_exit(foo_exit);

Yes, you'd need something like that. I am not ready to write
one for each of the existing LSMs. I am not signing up to do
dynamic security modules. Not at this point, anyway.

>
> ) is called from delete_module().
>
>   SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>                   unsigned int, flags)
>   (...snipped...)
>           if (mod->exit != NULL)
>                   mod->exit();
>   (...snipped...)
>   }
>
> foo_exit() is called from delete_module(), and delete_module() is triggered by
> a request from user space. Thus, foo_exit() is reachable even after foo LSM
> module was unregistered by reset_security_ops().
>
>   /**
>    * reset_security_ops - Unregister given security module.
>    *
>    * @ops: a pointer to the struct security_operations.
>    *
>    * This function must be called before unloading LKM-based LSM module.
>    * Caller can safely release blobs after returning from this function.
>    */
>   void reset_security_ops(struct security_operations *ops)
>   {
>   	/*
>   	 * This LSM is configured to own /proc/.../attr.
>   	 */
>   	if (lsm_present == ops)
>   		lsm_present = NULL;
>   
>   	spin_lock(&lsm_registration_lock);
>   	lsm_delist_ops(ops);
>   	spin_unlock(&lsm_registration_lock);
>   	/* Wait for currently running hooks to complete. */
>   	synchronize_srcu(&lsm_unregistration_lock);
>   }
>
> Thus, foo LSM module can clean up resources using foo_exit().
>
> The only problem is that foo module cannot traverse and clean up lsm_blobs
> associated with various objects from foo_exit() function, for we don't want to
> manage locks and linked list of various objects only for making it possible to
> traverse and clean up lsm_blobs from module exit function.
>
> But the problem does not apply LSM modules which do not use lsm_blobs.

Rubbish. You're masking the problem, not eliminating it.

> My proposal is to allow unloading of LSM modules which do not use lsm_blobs
> (and I'm ready to convert TOMOYO a LKM-based LSM which do not use lsm_blobs).
>
> LKM-based LSM modules which do not use lsm_blobs need only "safe unloading"
> mechanism. LKM-based LSM modules which uses lsm_blobs need both
> "safe unloading" mechanism and "safe cleaning up" mechanism.
>
> I think that implementing "safe cleaning up" mechanism is difficult and
> therefore I'm not expecting LSM infrastructure to support unloading of LSM
> modules which use lsm_blobs.
>
>
>
> My suggestion of getting rid of "Require a valid ->order value to all LSM" for
> making it easier for users to add LKM-based LSM modules which do not use
> lsm_blobs comes from backgrounds explained above.

No! I am yelling at you now! Encouraging LSMs to duplicate the LSM
infrastructure is a bad thing. This is the kind of philosophy that
leads to horrid kludges.

>
> If we cannot accept overhead of srcu locks for "safe unloading" mechanism,
> I'm still happy with "LKM-based LSM support without unloading support"
> implementation.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
