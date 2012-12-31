Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBVIfFvh021563
	for <selinux@tycho.nsa.gov>; Mon, 31 Dec 2012 13:41:20 -0500
Message-ID: <50E1DC30.2040304@schaufler-ca.com>
Date: Mon, 31 Dec 2012 10:40:48 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: linux-security-module@vger.kernel.org, jmorris@namei.org,
        john.johansen@canonical.com, eparis@redhat.com, keescook@chromium.org,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v11 0/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com> <201212202302.GGH12474.tLSOMOVHFFJQOF@I-love.SAKURA.ne.jp> <50D34CA7.4030908@schaufler-ca.com> <201212222332.AEH86121.SHLFVtJFOOFOMQ@I-love.SAKURA.ne.jp> <50DF583A.6090809@schaufler-ca.com> <201212311918.GCC39077.HOFtFVJSOMFQOL@I-love.SAKURA.ne.jp>
In-Reply-To: <201212311918.GCC39077.HOFtFVJSOMFQOL@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/31/2012 2:18 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>>> If we use ((SECURITY_NAME_MAX + 1) * COMPOSER_MAX) + 1, only up to COMPOSER_MAX
>>> modules can be shown up. Users might load a few of LKM-based LSM modules, and
>>> I think that LKM-based LSM modules should also be shown up. I think PAGE_SIZE
>>> is practically sufficient, for nobody will load hundreds of LKM-based LSM
>>> modules.
>> Someone who wants an unreasonably large numbers of LSMs can always boost
>> COMPOSER_MAX to the value they desire.
> There is a critical difference. Those who are using vanilla kernels can do and
> will do. But those who are using distro kernels may not be skillful enough to
> recompile/replace the distro kernels. Enterprise users want to load additional
> security modules but do not want to recompile/replace the distro kernels (also
> do not want to reboot the system only for loading additional security modules).
> Therefore, I want to allow LKM-based LSMs and allow the blobless LSM to run
> with sop->order == -1.

That's the loadable security module case. I am willing to make some
accommodation for the future, but I'm not inclined to address everything
that would need to get handled just yet.

>>> My steps for allowing LKM-based LSM is to change like below.
>>>
>>> (step 1) Remove __init from security_module_enable().
>>> (step 2) Change "char allowed_lsms[]" to "char *allowed_lsms".
>>> (step 3) Reset allowed_lsms to NULL after calling do_security_initcalls().
>>>
>>> Step 1, 2 and 3 mean that LSM modules which are specified via security=
>>> parameter are enabled before userspace starts. Whether to load other LKM-based
>>> LSM modules or not is determined by userspace, and permission for loading other
>>> LKM-based LSM modules after userspace starts is checked by already loaded LSM
>>> modules.
>>>
>>> (step 4) Add checks for whether that LSM module uses blobs or not, and
>>>          increment lsm_count only when that LSM module uses blobs.
>>>
>>> Step 4 means that the number of LSM modules (including LKM-based LSM modules)
>>> is no longer limited to COMPOSER_MAX constraint as long as LSM modules do not
>>> use blobs.
>> I think you have more faith that new LSMs will not use blobs than I do.
> An LSM might change from blobless in current version to blobfull in future
> versions. But I don't think an LSM changes from blobless to blobfull at runtime
> (i.e. after the LSM was registered). Setting sop->order to -1 is for detecting
> bad mannered LSM which pretends to be blobless when it is actually blobfull.

Using -1 in the order means that lsm_set_blob needs to check the passed order
and do something intelligent with -1. The lsm_[ge]et_blob abstraction
introduces overhead and complexity as it is. With error checking and
the potential for badly behaving LSMs in production it gets really hard
to defend.

>> Further, I fear the case where an LSM is changed from blobless to blobfull
>> and is expected to load and unload the way it always has. Maybe that's
>> an unreasonable fear, but I have learned to respect my fears, especially
>> the unreasonable ones.
> If I recall correctly, difficulty of cleanly unloading LSM module is one of
> reasons that made LSM interface static. Although LSM interface does not provide
> mechanism for clean unloading, I think that such limitation doesn't worth
> forbidding loading of LKM-based LSM. While my LKM-based LSM modules (i.e. AKARI
> and CaitSith) don't have unloading mechanism, AKARI and CaitSith are useful for
> those who want to use them.

I don't think that there's anything to preclude loadable security modules
in the current implementation. So long as COMPOSER_MAX is big enough you're
fine. If Fedora sets it to 1 so you can't use anything but SELinux I would
be disappointed, but that's their business after all. I would expect
Ubuntu to use a generous value as they have been much more open to variety
in security modules.

>>> As of your v11 patchset,
>>>
>>>   static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
>>>
>>> is used by only within
>>>
>>>   static int __init choose_lsm(char *str)
>>>
>>> . But I will have to drop __initdata when doing steps shown above.
>> I would expect an implementation of loadable security modules to have
>> a different mechanism for identifying what modules can be loaded from
>> the mechanism used to determine which of the compiled in LSMs get used.
>> I would expect it to ignore allowed_lsms in any case.
> I think allowing runtime registration is sufficient. In case of AKARI, passing
> init=/sbin/akari-init (where the content of /sbin/akari-init looks like
>
>   #! /bin/sh
>   /sbin/modprobe akari && exec /sbin/init "$@"
>
> ) is used. And so does CaitSith (i.e. pass init=/sbin/caitsith-init ).
>
How do you use the two together?
init=/sbin/akari-init;/sbin/caitsith-init ?

I'm not a fan of you lsm-init scheme.

>>>>>   ops->getprocattr && ops->setprocattr in security_module_enable() should be
>>>>>   ops->getprocattr || ops->setprocattr in case out-of-tree LSM modules provided
>>>>>   only either one.
>>>> No. Think it through. It makes no sense whatever for an LSM to supply one
>>>> without the other. That, and it could cock up the race condition logic for
>>>> reset_security_ops and those two hooks.
>>> Oops. I forgot the fact that present_getprocattr() or present_setprocattr()
>>> triggers oops if we used ops->getprocattr || ops->setprocattr. But I still
>>> think that there could be out-of-tree LSM modules which provide only
>>> ops->getprocattr or ops->setprocattr.
>> That's fine, I suppose. Such an LSM can't be the presenting LSM. It will have to
>> use it's designated /proc/.../attr interfaces instead. If it's out of tree I
>> don't really much care. I'll worry about it when I know about it.
> OK. We can use "ops->getprocattr && ops->setprocattr".
>
>
>
>> I looked at the possibility of only allocating enough slots for the
>> LSMs that use blobs. The case that made me walk away from it was
>> reset_security_ops, which decreases the number. If someone did
>>
>> 	security=selinux,apparmor
>>
>> and SELinux withdrew itself with reset_security_ops you have to leave
>> a blank slot anyway.
> I think we don't decrease the lsm_count variable.
> I think it does not worth trying to reassign the blob slot to other LSM modules
> after reset_security_ops() was called.
>
>> If lsm_blobs are fixed size, you run out of slots. If they are variable size,
>> accessing the slots requires way too much checking. In either case they're
>> small. I prefer wasted space to run time checks.
> I agree. I can accept fixed sized lsm_blobs.
> Using sop->order == -1 for blobless LSM will be sufficient.

But why, if it has a slot anyway?

I don't want to do anything that makes it seem hard to use blobs.
I can easily imagine (look at the android binder "driver") LSMs
that do their own blob management because the authors are afraid
of or don't understand the mechanism.

>>> By the way, one entry per a line like
>>>
>>>   # cat /sys/kernel/security/lsm
>>>   smack
>>>   tomoyo
>>>   apparmor
>>>
>>> might look better. In this case, kmalloc()/kfree()/COMPOSER_NAMES_MAX/PAGE_SIZE
>>> are not needed.
>> It's a matter of taste between
>> 	smack,tomoyo,apparmor
>> and
>>
>> smack
>> tomoyo
>> apparmor
>>
>> I think which you prefer will depend on whether you're a fan of
>> grep, awk, sed, bash, perl, python, C or XML. I expect to see just
>> as many complaints with one as the other.
> I thought that one entry per one line allows fancy naming like
>
>   # cat /sys/kernel/security/lsm
>   companyname's productname
>   companyname's productname
>
> with
>
>    struct security_operations {
>    	struct list_head list[LSM_MAX_HOOKS];
>   -	char name[SECURITY_NAME_MAX + 1];
>   +	const char *name;
>    	int order;
>
> change. But I can accept all entries in one line.

We could always add /sys/kernel/security/modules and have
it print things your way.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
