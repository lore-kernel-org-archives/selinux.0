Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBTKrZJ2015250
	for <selinux@tycho.nsa.gov>; Sat, 29 Dec 2012 15:53:35 -0500
Message-ID: <50DF583A.6090809@schaufler-ca.com>
Date: Sat, 29 Dec 2012 12:53:14 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: linux-security-module@vger.kernel.org, jmorris@namei.org,
        john.johansen@canonical.com, eparis@redhat.com, keescook@chromium.org,
        selinux@tycho.nsa.gov, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v11 0/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com> <201212202302.GGH12474.tLSOMOVHFFJQOF@I-love.SAKURA.ne.jp> <50D34CA7.4030908@schaufler-ca.com> <201212222332.AEH86121.SHLFVtJFOOFOMQ@I-love.SAKURA.ne.jp>
In-Reply-To: <201212222332.AEH86121.SHLFVtJFOOFOMQ@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/22/2012 6:32 AM, Tetsuo Handa wrote:
> Casey Schaufler wrote:
>> On 12/20/2012 6:02 AM, Tetsuo Handa wrote:
>>> Several bugfixes for v11 patchset.
>>>
>>>   Fixed off-by-one bug in lsm_read().
>> Where is the off-by-one error?
>>
>   list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
>           strcat(data, sop->name);
>           strcat(data, ","); // <= Here. :-(
>   }
>
> If COMPOSER_MAX == 1, COMPOSER_NAMES_MAX is SECURITY_NAME_MAX+1.
> If strlen(sop->name) == SECURITY_NAME_MAX,
> strcat(data, sop->name) writes data[0...COMPOSER_NAMES_MAX] and
> strcat(data, ",") writes data[COMPOSER_NAMES_MAX...COMPOSER_NAMES_MAX+1].
> data[] needs to be one byte larger for writing trailing '\0'.

Yup, there it is.

>>>  (Changed to use PAGE_SIZE in preparation for LKM-based LSM modules.)
>> How does this help in the LKM-based case? I don't see it.
> If we use ((SECURITY_NAME_MAX + 1) * COMPOSER_MAX) + 1, only up to COMPOSER_MAX
> modules can be shown up. Users might load a few of LKM-based LSM modules, and
> I think that LKM-based LSM modules should also be shown up. I think PAGE_SIZE
> is practically sufficient, for nobody will load hundreds of LKM-based LSM
> modules.

Someone who wants an unreasonably large numbers of LSMs can always boost
COMPOSER_MAX to the value they desire.

> By the way, one entry per a line like
>
>   # cat /sys/kernel/security/lsm
>   smack
>   tomoyo
>   apparmor
>
> might look better. In this case, kmalloc()/kfree()/COMPOSER_NAMES_MAX/PAGE_SIZE
> are not needed.

It's a matter of taste between
	smack,tomoyo,apparmor
and

smack
tomoyo
apparmor

I think which you prefer will depend on whether you're a fan of
grep, awk, sed, bash, perl, python, C or XML. I expect to see just
as many complaints with one as the other.

>
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -224,24 +224,32 @@ static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>  			loff_t *ppos)
>  {
>  	struct security_operations *sop;
> -	char *data;
> -	int len;
> -
> -	data = kzalloc(COMPOSER_NAMES_MAX, GFP_KERNEL);
> -	if (data == NULL)
> -		return -ENOMEM;
> +	int len = 0;
> +	loff_t skip = 0;
> +	const loff_t pos = *ppos;
>  
> +	if (pos < 0)
> +		return -EINVAL;
>  	list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
> -		strcat(data, sop->name);
> -		strcat(data, ",");
> +		const char *cp = sop->name;
> +		char c;
> +		do {
> +			c = *cp++;
> +			if (!c)
> +				c = '\n';
> +			if (skip < pos)
> +				skip++;
> +			else if (!count--)
> +				return len;
> +			else if (put_user(c, buf))
> +				return len ? len : -EFAULT;
> +			else {
> +				len++;
> +				(*ppos)++;
> +				buf++;
> +			}
> +		} while (c != '\n');
>  	}
> -	len = strlen(data);
> -	if (len > 1)
> -		data[len-1] = '\n';
> -
> -	len = simple_read_from_buffer(buf, count, ppos, data, len);
> -	kfree(data);
> -
>  	return len;
>  }

I think I'll leave this as is for the time being.

>>>   Removed redundant specified_lsms[][].
>> It's __init data, and ensures the result is correct.
>> If there's a good reason to change the way boot ordering
>> is done, I'm open to it, but I don't see how your change
>> makes anything better.
> My steps for allowing LKM-based LSM is to change like below.
>
> (step 1) Remove __init from security_module_enable().
> (step 2) Change "char allowed_lsms[]" to "char *allowed_lsms".
> (step 3) Reset allowed_lsms to NULL after calling do_security_initcalls().
>
> Step 1, 2 and 3 mean that LSM modules which are specified via security=
> parameter are enabled before userspace starts. Whether to load other LKM-based
> LSM modules or not is determined by userspace, and permission for loading other
> LKM-based LSM modules after userspace starts is checked by already loaded LSM
> modules.
>
> (step 4) Add checks for whether that LSM module uses blobs or not, and
>          increment lsm_count only when that LSM module uses blobs.
>
> Step 4 means that the number of LSM modules (including LKM-based LSM modules)
> is no longer limited to COMPOSER_MAX constraint as long as LSM modules do not
> use blobs.

I think you have more faith that new LSMs will not use blobs than I do.
Further, I fear the case where an LSM is changed from blobless to blobfull
and is expected to load and unload the way it always has. Maybe that's
an unreasonable fear, but I have learned to respect my fears, especially
the unreasonable ones.

>
> As of your v11 patchset,
>
>   static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
>
> is used by only within
>
>   static int __init choose_lsm(char *str)
>
> . But I will have to drop __initdata when doing steps shown above.

I would expect an implementation of loadable security modules to have
a different mechanism for identifying what modules can be loaded from
the mechanism used to determine which of the compiled in LSMs get used.
I would expect it to ignore allowed_lsms in any case.

>>> LSM modules which do not use lsm_get_blob()/lsm_set_blob() will be able to
>>> use ops->order == -1. By allowing LKM-based LSM modules, users can add
>>> LSM modules with ops->order == -1 regardless of COMPOSER_MAX constraint.)
>> An LSM that uses no blobs (e.g. Yama) does not care what value is in sop->order.
>> An LSM that uses any blobs needs a unique sop->order.
>>
> Exactly. This is important background for my plan. When step 4 is done,
> COMPOSER_MAX means "the max number of LSM modules which use blobs" rather than
> "the max number of LSM modules". Yama-like modules are freely added at runtime.

It's not relevant now, but I oppose the notion that not using blobs
means you don't get a slot for blobs.

I looked at the possibility of only allocating enough slots for the
LSMs that use blobs. The case that made me walk away from it was
reset_security_ops, which decreases the number. If someone did

	security=selinux,apparmor

and SELinux withdrew itself with reset_security_ops you have to leave
a blank slot anyway.

If lsm_blobs are fixed size, you run out of slots. If they are variable size,
accessing the slots requires way too much checking. In either case they're
small. I prefer wasted space to run time checks.

>>> diff --git a/include/linux/lsm.h b/include/linux/lsm.h
>>> index 5f36b6b..fcf852e 100644
>>> --- a/include/linux/lsm.h
>>> +++ b/include/linux/lsm.h
>>> @@ -24,7 +24,6 @@
>>>   * Maximum number of LSMs that can be used at a time.
>>>   */
>>>  #define COMPOSER_MAX		CONFIG_SECURITY_COMPOSER_MAX
>>> -#define COMPOSER_NAMES_MAX	((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)
>>>  
>>>  #include <linux/security.h>
>>>  
>>> diff --git a/security/inode.c b/security/inode.c
>>> index 2c14313..8cebd4b 100644
>>> --- a/security/inode.c
>>> +++ b/security/inode.c
>> No. I'm keeping a safe constant for buffer sizes.
>>
> My opinion is we don't need COMPOSER_NAMES_MAX. I will do
>
> -static __initdata char allowed_lsms[((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)];
> +static char *allowed_lsms;
>
> (or equivalent) in step 2.
>
> Even more,
>
>  struct security_operations {
>  	struct list_head list[LSM_MAX_HOOKS];
> -	char name[SECURITY_NAME_MAX + 1];
> +	const char *name;
>  	int order;
>
> and remove SECURITY_NAME_MAX is possible (provided that name field does not
> change after registration).
>
> sop->order serves for determining blob slot index and priority for linking to
> the lsm_hooks list. For now, index of LKM-based LSM modules in the lsm_hooks
> list is larger than that of LSM modules specified via security= parameter.
> But maybe adding "int priority" for allowing control of priority for linking to
> the lsm_hooks list (like Apache's modules). In that case, sop->order will
> purely represent blob slot index.

I see the point. I think saving that for loadable modules is prudent.

>>> @@ -257,9 +261,10 @@ static ssize_t present_read(struct file *filp, char __user *buf, size_t count,
>>>  	char *raw;
>>>  	char *data;
>>>  	int len;
>>> +	struct security_operations *ops = lsm_present;
>>>  
>>> -	if (lsm_present)
>>> -		raw = lsm_present->name;
>>> +	if (ops)
>>> +		raw = ops->name;
>>>  	else
>>>  		raw = "(none)";
>>>  	len = strlen(raw);
>>> diff --git a/security/security.c b/security/security.c
>>> index 75e2f6e..48597d6 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>> Yes. Have I mentioned how I feel about reset_security_ops?
> If I didn't miss your mails, I think you haven't.

Ah. I dislike reset_security_ops. It is a special case interface.
If it were not present there are a number of issues that would have
never arisen.

>>>   ops->getprocattr && ops->setprocattr in security_module_enable() should be
>>>   ops->getprocattr || ops->setprocattr in case out-of-tree LSM modules provided
>>>   only either one.
>> No. Think it through. It makes no sense whatever for an LSM to supply one
>> without the other. That, and it could cock up the race condition logic for
>> reset_security_ops and those two hooks.
> Oops. I forgot the fact that present_getprocattr() or present_setprocattr()
> triggers oops if we used ops->getprocattr || ops->setprocattr. But I still
> think that there could be out-of-tree LSM modules which provide only
> ops->getprocattr or ops->setprocattr.

That's fine, I suppose. Such an LSM can't be the presenting LSM. It will have to
use it's designated /proc/.../attr interfaces instead. If it's out of tree I
don't really much care. I'll worry about it when I know about it.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
