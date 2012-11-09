Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA91T4wa002556
	for <selinux@tycho.nsa.gov>; Thu, 8 Nov 2012 20:29:04 -0500
Message-ID: <509C5C3F.1050800@schaufler-ca.com>
Date: Thu, 08 Nov 2012 17:28:31 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v6] LSM: Multiple concurrent LSMs
References: <50986053.9060105@schaufler-ca.com> <201211062144.CFB09368.JOQMFHFFVSOLtO@I-love.SAKURA.ne.jp> <5099BB81.6000506@schaufler-ca.com> <201211072215.FFD82885.HLVJFMSOOtFFOQ@I-love.SAKURA.ne.jp>
In-Reply-To: <201211072215.FFD82885.HLVJFMSOOtFFOQ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/7/2012 5:15 AM, Tetsuo Handa wrote:
> Reordering the message for explanation...
>
> Casey Schaufler wrote:
>> On 11/6/2012 4:44 AM, Tetsuo Handa wrote:
>>> sizeof(*lp) should be 32 rather than 12 on x86_32 unless CONFIG_SLOB=y .
>> So the reality is that I'd be happy to report the number of lsm_list
>> blobs rather than the size, if that would be more palatable. Or, not
>> report a quantity at all, just say "Leaked some bytes while delisting
>> an LSM" and be done. Do you feel strongly one way or the other? Does
>> anyone else care?
> ksize(lp) returns exact size compared to sizeof(*lp).

That was easy to adopt.

> But another approach is
> to embed "struct list_head" into "struct security_operations", something like
>
> 	struct security_operations {
> 		char name[SECURITY_NAME_MAX + 1];
> 	
> 		int (*ptrace_access_check) (struct task_struct *child, unsigned int mode);
> 		struct list_head ptrace_access_check_list;
> 		int (*ptrace_traceme) (struct task_struct *parent);
> 		struct list_head ptrace_traceme_list;
> 		int (*capget) (struct task_struct *target,
> 			       kernel_cap_t *effective,
> 			       kernel_cap_t *inheritable, kernel_cap_t *permitted);
> 		struct list_head capget_list;
> 		(...snipped...)
> 	};
>
> so that we can avoid kmalloc()/kfree() upon registration/unregistration.

How does one go about adding the hooks to the appropriate lists?
I came up with one macro based method that made Eric's hair fall
out, and he never even saw it. I don't think embedding a list for
each hook into the security_operations structure gets anything 
other than bloat. Because of typing you would need a separate
enlist and delist function for each hook. Try it if you don't
believe me.


>>> Seems unsafe list deletion. I think we need to use _rcu version since somebody
>>> (kernel threads) may be walking on the list when lsm_delist_ops() is called by
>>> the init process.
>> Here's the question, and I don't know the answer. lsm_delist() gets called
>> under two conditions: an early memory allocation failure that will almost
>> certainly precede a fatal memory allocation error, or a call to
>> security_reset_ops(), which is strictly a one-time thing. Might it be
>> better to have a lock of some sort to deal with the unlikely case of a
>> call to lsm_delist than to use the _rcu versions? I honestly don't know
>> what the cost of using _rcu is, so it may not matter.
> Is list_for_each_entry() safe against concurrent list_del() without locks?
> If I understand correctly, it isn't safe to call list_for_each_entry() without
> locks if list elements can be removed by list_del().
>
> I considered singly linked list (rather than using doubly linked list with _rcu
> primitives) so that list traversal without locks becomes safe with regard to
> list addition/deletion. Concurrent list addition/deletion is not safe, but we
> can afford using locks only for protecting such case because list
> addition/deletion happens only upon registration/unregistration.

That would entail fighting with the list macro use purists.

>>> Maybe we want noinline attribute, for inlining lsm_delist() into
>>> lsm_delist_ops() is a bloat. And so does noinline attribute to lsm_enlist().
>> I'm hesitant to try to second guess the compilers on this. If a
>> performance expert told me to do it, I would, but I'd hate to be too
>> clever.
> Thinking from how frequently lsm_enlist()/lsm_delist() is called, I think
> it does not worth inlining lsm_enlist()/lsm_delist() calls.

I agree, I also don't think is worth specifying noinline.
 

>>> Overall, this version can eliminate overhead caused by unimplemented hooks.
>>> Then, I think we can afford allowing legal registration of trivial LKM-based
>>> LSM modules after the init process starts; LSM modules which wants to use
>>> lsm_blobs are limited to COMPOSER_MAX but LSM modules which do not need
>>> lsm_blobs are allowed to chain as many as the administrator wants.
>> So if an LSM includes no hooks that use blobs none would get
>> allocated. Yama, for example. There would have to be a separate
>> load order from blob slot number. I'm tempted to say it's too
>> rare a case to worry about, but we have the example of Yama
>> sitting there challenging that assertion.
>>
>> I will consider this.
> Thank you.
> Does adding 'bool use_blobs' field to "struct security_operations" help?

Only if LSM writers are trustworthy and careful.
I expect that a check at registration on the hooks that use blobs
would be sufficient. I will check all the inode, file, cred and such
hooks and if any are called the LSM gets a slot.
 

>
> There are three reasons I want to allow legal registration of LKM-based LSM
> modules after the init process starts.
>
> First is that many distributions nowadays enable multiple LSM modules. Since
> LSM modules cannot be a LKM, all possible LSM modules have to be built-in,
> bloating the vmlinuz file. If LSM modules are allowed to be a LKM, distributors
> can reduce the size of vmlinuz (making the kernel load time shorter). TOMOYO is
> sitting here waiting for legal registration of LKM-based LSM modules.
>
> Second is that several distributions (e.g. Fedora and RHEL) enable only one LSM
> module (e.g. SELinux). On such distributions, users who want to use other LSM
> modules at their own risk have to replace the kernel package; this limitation
> is a strong psychological barrier and maintenance burden for such users. I'm
> using AKARI (which is a LKM-based TOMOYO) for troubleshooting RHEL systems
> because replacing the kernel package (in order to use TOMOYO) is unlikely
> acceptable for RHEL users.
>
> Third is that LSM is not the tool for thought control. LSM should be the tool
> for minimizing the burden of all subsystems' maintainers.
> I hope LSM folks have learned that "not everybody can configure SELinux" and
> "even AppArmor is not configurable for somebody"
> ( http://events.linuxfoundation.org/images/stories/pdf/lcna_co2012_handa.pdf )
> and "Yama is sufficient for some users" and other (not yet in-tree) modules may
> be sufficient for some other users
> ( http://events.linuxfoundation.org/images/stories/pdf/lcna_co2012_henderson.pdf ).
>
> For accelerating the development of custom LSM module which users really want,
> LSM interface should be opened to allow LKM-based LSM modules.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
