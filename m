Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9JLdspJ010863
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2012 17:39:54 -0400
Message-ID: <5081C88E.7090002@schaufler-ca.com>
Date: Fri, 19 Oct 2012 14:39:26 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        SE Linux <selinux@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5] LSM: Multiple concurrent LSMs
References: <5081B30F.6090009@schaufler-ca.com> <CAGXu5jJKWZMJbX+kQZb1Qe64EjuZMEubCgtiV4COXWo9=hqPiQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJKWZMJbX+kQZb1Qe64EjuZMEubCgtiV4COXWo9=hqPiQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/19/2012 2:16 PM, Kees Cook wrote:
> On Fri, Oct 19, 2012 at 1:07 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Here's my post vacation update. I am considering
>> moving away from the array of LSM vectors to lists
>> within each hook. The primary advantage would be
>> that multiple sparse LSMs would spend less time
>> checking on NULL hooks. Thoughts?
> I had actually been working up to suggesting this, so yes, I'm in
> favor of it. Much nicer for the likely sparse condition.
>
>> It would also make security_reset_ops
>> considerably less pleasant, but that is code that
>> gets ifdefed out except for one configuration of
>> one LSM.
> That seems fine to me.
>
>> Version 5 of the patch addresses:
>> 1. Tetsuo Handa pointed out that handling of failures
>>    alloc hooks was still not correct in v4. The code
>>    now only calls the free hook for LSMs that have
>>    had their alloc hook successfully called. The alloc
>>    hooks have been de-macro-ized, too.
> Excellent.
>
>> 2. Removed the Yama special case. It is no longer
>>    necessary.
> :)
>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> +/*
>> + * Only SELinux calls reset_security_ops.
>> + */
>> +#ifdef CONFIG_SECURITY_SELINUX_DISABLE
>> +int reset_security_ops(struct security_operations *ops)
>>  {
>> -       security_ops = &default_security_ops;
>> +       struct security_operations *empty;
>> +
>> +       /*
>> +        * This LSM is configured to own /proc/.../attr.
>> +        * Don't leave that important interface unattended.
>> +        */
>> +       if (lsm_present == ops->order)
>> +               return -EBUSY;
>> +
>> +       empty = kzalloc(sizeof(struct security_operations), GFP_KERNEL);
>> +       if (empty == NULL)
>> +               return -ENOMEM;
>> +
>> +       strcpy(empty->name, ops->name);
>> +       empty->order = ops->order;
>> +       composer_ops[ops->order] = empty;
>> +       return 0;
>>  }
>> +#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> Won't this leak if called more than once?

Sure will. It leaks if called once for that matter.
SELinux blobs that have been allocated but not freed
never will be after reset_security_ops is called.
The calling code does what it can to minimize the
impact, but it will be there. I could add a flags
field to security_operations that indicates the LSM
has been reset to prevent this problem, but it seems
wasteful.

>
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
>> -       if (verify(ops)) {
>> -               printk(KERN_DEBUG "%s could not verify "
>> -                      "security_operations structure.\n", __func__);
>> -               return -EINVAL;
>> +       if (lsm_count >= COMPOSER_MAX) {
>> +               pr_warn("Too many security modules. %s not loaded.\n",
>> +                               ops->name);
>> +               return 0;
>> +       }
>> +       /*
>> +        * Set up the operation vector early, but only once.
>> +        * This allows LSM specific file systems to check to see if they
>> +        * should come on line.
>> +        */
>> +       if (ops == NULL) {
>> +               pr_debug("%s could not verify security_operations.\n",
>> +                               __func__);
>> +               return 0;
>>         }
>> +       if (allowed_lsms[0] != '\0' && strstr(allowed_lsms, ops->name) == NULL)
>> +               return 0;
> This means we must always avoid LSMs that could be substrings of
> another LSM. Should this check maybe be improved to test for start/end
> and commas?
>
> Off the top of my head, and seems horrible. Maybe there's a cleaner way:
>
> if (allowed_lsms[0] != '\0') {
>     char * found;
>     int len;
>
>     found = strstr(allowed_lsms, ops->name);
>     if (!found)
>         return 0;
>     if (found != allowed_lsms && found[-1] != ',')
>         return 0;
>     len = strlen(ops->name);
>     if (strlen(found) < len || (found[len] != '\0' && found[len] != ','))
>         return 0;
> }

Yes, and I agree it's worth doing, if ugly.

>> +#define call_int_hook(RC, FUNC, ...)                                   \
>> +       do {                                                            \
>> +               int called = 0;                                         \
>> +               int thisrc;                                             \
>> +               int i;                                                  \
>> +                                                                       \
>> +               RC = 0;                                                 \
>> +               for (i = 1; i < lsm_count; i++) {                       \
>> +                       if (!composer_ops[i]->FUNC)                     \
>> +                               continue;                               \
>> +                       thisrc = composer_ops[i]->FUNC(__VA_ARGS__);    \
>> +                       if (thisrc)                                     \
>> +                               RC = thisrc;                            \
>> +                       called = 1;                                     \
>> +               }                                                       \
>> +               if (!called && composer_ops[0]->FUNC)                   \
>> +                       RC = composer_ops[0]->FUNC(__VA_ARGS__);        \
>> +       } while (0)
>> [...]
>>  int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
>>                          unsigned long arg4, unsigned long arg5)
>>  {
>> -#ifdef CONFIG_SECURITY_YAMA_STACKED
>>         int rc;
>> -       rc = yama_task_prctl(option, arg2, arg3, arg4, arg5);
>> -       if (rc != -ENOSYS)
>> -               return rc;
>> -#endif
>> -       return security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
>> +       call_int_hook(rc, task_prctl, option, arg2, arg3, arg4, arg5);
>> +       return rc;
>>  }
> prctl control needs special handling. When an option is unhandled,
> it'll return -ENOSYS. Also, some prctls return non-zero results, so
> they could mask each other. I think it would make sense to walk the
> composer list as long as the return value is -ENOSYS. As soon as it
> isn't, then stop the call chain and return the value. Ultimately, this
> means that the LSM order defines who get access to a given prctl
> option (though with caps last).
>
> int i, rc, called = 0;
> for (i = 1; i < lsm_count; i++) {
>     if (!composer_ops[i]->task_prctl)
>         continue;
>     rc = composer_ops[i]->task_prctl(option, arg2, arg3, arg4, arg5);
>     called = 1;
>     if (rc != -ENOSYS)
>         return rc;
> }
> if (!called and composer_ops[0]->task_prctl)
>     return composer_ops[0]->task_prctl(option, arg2, arg3, arg4, arg5);
> return rc;

I'll investigate further and revise.

>
>
> -Kees
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
