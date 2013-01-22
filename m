Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0M2A2bt008032
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2013 21:10:02 -0500
Message-ID: <50FDF4FC.1010308@schaufler-ca.com>
Date: Mon, 21 Jan 2013 18:10:04 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v12 3/9] LSM: Multiple concurrent LSMs
References: <50ED9A22.1090300@schaufler-ca.com> <201301212142.FGF86433.OVQJFMHFLtFSOO@I-love.SAKURA.ne.jp> <50FDC1B2.2080309@schaufler-ca.com> <201301220819.AFB21360.OFOQHJFSFVtLMO@I-love.SAKURA.ne.jp> <50FDD315.7090606@schaufler-ca.com> <201301221009.JDB30838.tFFMVFLOQJSOOH@I-love.SAKURA.ne.jp>
In-Reply-To: <201301221009.JDB30838.tFFMVFLOQJSOOH@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 1/21/2013 5:09 PM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> True enough, but the one example we have of LSM unloading is going
>> to leave droppings. I don't want to go anywhere near module unloading,
>> even for LSMs that don't use the official mechanisms, without a story
>> on how they're going to get cleaned up.
>> I'm not sure that we're missing anything beyond locking
>> (as you have pointed out) and cleaning up, which you're
>> less concerned about than I. What I am *not* ready to do
>> is stand up and say that I believe all the bases are covered.
> You want to make sure that all blobs used by a LSM module are cleaned up before
> unloading that module, don't you?

That is necessary, but not sufficient. The lsm_blob needs to
be cleaned up as well. And the rub is that you need to use the
LSM provided free functions, but you can't count on them
working once the LSM is disabled because the LSM is, after
all, disabled.

> I think "clean unloading" (i.e. cleaning up blobs used by that module) makes
> sense only after "safe unloading" (i.e. making sure that that module is no
> longer referenced) is implemented.
>
> And if we want to implement "safe unloading", I think we need to add
> "struct module *owner;" to "struct security_operations" and use refcounter like
>
> #define call_void_hook(FUNC, ...)					\
> 	do {								\
> 		struct security_operations *sop;			\
> 		struct module *module;					\
> 									\
> 		list_for_each_entry(sop, &lsm_hooks[lsm_##FUNC],	\
> 					list[lsm_##FUNC]) {		\
> 			if (!try_module_get(sop->owner))		\
> 				continue;				\
> 			sop->FUNC(__VA_ARGS__);				\
> 			module_put(sop->owner);				\
> 	} while (0)

I'm not familiar with try_module_get(), but unless it is trivial,
and maybe even then, I have no interest in adding its overhead
in that loop.

> Given that a mechanism for "safe unloading" is implemented, below is my answer
> for "clean unloading".
>
>   TOMOYO can manage blobs without using "void *security;" embedded into various
>   objects. In other words, TOMOYO can manage blobs using linked lists (which
>   are fully reachable from module unloading function) embedded into TOMOYO.
>   Thus, it is trivially easy to release blobs used by TOMOYO upon unloading.
>   Ditto for TOMOYO-like LKM-based LSM modules.

I'm willing to look at this later.

> I haven't added module_exit() function because "safe unloading" mechanism is
> missing. If "safe unloading" mechanism is implemented, TOMOYO can support both
> runtime loading/registration and unregistration/unloading.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
