Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0LNjLHQ002538
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 18:45:22 -0500
Message-ID: <50FDD315.7090606@schaufler-ca.com>
Date: Mon, 21 Jan 2013 15:45:25 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50EB7FCD.3030107@schaufler-ca.com> <201301092211.CGF18746.LMOHJFOOFQtVSF@I-love.SAKURA.ne.jp> <50ED9A22.1090300@schaufler-ca.com> <201301212142.FGF86433.OVQJFMHFLtFSOO@I-love.SAKURA.ne.jp> <50FDC1B2.2080309@schaufler-ca.com> <201301220819.AFB21360.OFOQHJFSFVtLMO@I-love.SAKURA.ne.jp>
In-Reply-To: <201301220819.AFB21360.OFOQHJFSFVtLMO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/21/2013 3:19 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 1/21/2013 4:42 AM, Tetsuo Handa wrote:
>>> Below is what I think we need for "current v12 patchset" + "LKM-based LSM
>>> support" + "Require a valid ->order value to all LSM" approach.
>>> What other mechanism we are missing?
>> The big trouble is cleaning up blobs that an LSM has allocated
>> at the time an LSM is unloaded. I am only including the ability
>> to unregister via reset_security_ops (which I plan to rename,
>> more on that later) because SELinux depends on it.
> Right. I agree that it is difficult to clean up blobs that an LSM has allocated
> at the time an LSM is unloaded. But not all LSM modules want to allocate blobs.

True enough, but the one example we have of LSM unloading is going
to leave droppings. I don't want to go anywhere near module unloading,
even for LSMs that don't use the official mechanisms, without a story
on how they're going to get cleaned up.

>> I'm renaming reset_security_ops to security_module_disable to match
>> up with security_module_enable. I know it's unnecessary, but I think
>> it's the right thing to do.
> I think that unregister_security() is better named, for we want both
> security_module_enable() and register_security() (since built-in LSM modules in
> Ubuntu kernels need to be able to distinguish whether to try to load or not).

I'm addressing this is v13 without introducing unregister_security.
Patch coming later this week most likely.

> I'm OK to rename reset_security_ops() to security_module_disable() if
> security_module_enable() is changed to return "0 or -ve" so that
> security_module_enable() can return the caller the reason of registration
> failure.

I'm doing that in v13 as well.

>>> +EXPORT_SYMBOL_GPL(security_module_enable);
>> I am disinclined to put in what might appear to be support
>> for dynamic security modules when I'm not yet willing to
>> sign up for that.
> I'm ready to convert TOMOYO into LKM-based LSM and TOMOYO-like modules as well.
> Sorry, I still have not understood what other mechanism we are missing...

I'm not sure that we're missing anything beyond locking
(as you have pointed out) and cleaning up, which you're
less concerned about than I. What I am *not* ready to do
is stand up and say that I believe all the bases are covered.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
