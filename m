Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA63BY1Q030925
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2012 22:11:34 -0500
Message-ID: <50987FC0.1030004@schaufler-ca.com>
Date: Mon, 05 Nov 2012 19:10:56 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v6] LSM: Multiple concurrent LSMs
References: <50986053.9060105@schaufler-ca.com> <CAGXu5j+vyGrHSp8nBb8kevqe6cXFEzXXt3NuziJQPBSFcRj_JQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+vyGrHSp8nBb8kevqe6cXFEzXXt3NuziJQPBSFcRj_JQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/5/2012 5:52 PM, Kees Cook wrote:
> On Mon, Nov 5, 2012 at 4:56 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Version 6 of the patch addresses:
>>
>> 1. The array based hook calling loops have been
>>    replaced by hook lists. The blobs remain array
>>    based.
> I wonder if the entire security structure could be made into an array
> instead of named fields. Then instead of having these repeated giant
> lists of field names, we could trivially do for (i = 0; i <
> LSM_MAX_FUNC; i++) to walk them all. Solving the function prototyping
> part is, however, UGLY, and we lose mis-match detection if an LSM
> author messes up a declaration. This probably isn't worth it,

Believe me, when I was knee deep in security.c I thought about it.
In the end I decided that any given hook might end up having a special
behavior of some sort and it would be better to spell each hook out
than to have the next person who comes through have to deal with
pulling code out of macros.

A thought that I had was to move some of the registration logic into
the LSMs. Instead of passing a security_operations vector the LSM would
call the lsm_enlist function with the appropriate list for each hook
the LSM supports. If the LSM wanted reset_security_ops it could
lsm_delist all of its hooks. There would still have to be a way to
get the ops->order value set.

I think the modularity in place today makes it easier for the
LSM system to control things and easier for the LSM writer to
make things work right. I would hesitate to change it at this
point.

>  but
> here's what I was thinking:
>
> enum lsm_function {
>     LSM_PTRACE_ACCESS_CHECK = 0,
> ...
>     LSM_AUDIT_RULE_MATCH,
>     LSM_MAX_FUNC
> };
>
> struct security_operations {
>     char name[SECURITY_NAME_MAX + 1];
>     int order;
>     void (*func)(void)[LSM_MAX_FUNC];
> }
>
> ...
>
>
> static int __init lsm_enlist_ops(struct security_operations *sop)
> {
>     enum lsm_function func;
>
>     for (func = 0; func < LSM_MAX_FUNC; func++)
>         if (lsm_enlist(sop, func, sop->[func]))
>             return 1;
> }
>
> ...
>
> static lsm_ops[LSM_MAX_FUNCS];
>
> int __init security_init(void)
> {
>     enum lsm_functions func;
>
>     for (func = 0; func < LSM_MAX_FUNCS; func++)
>         INIT_LIST_HEAD(lsm_ops[func]);
>
>     do_security_initcalls();
>
>     pr_info("Security Framework initialized\n");
>
>     return 0;
> }
>
> ...
>
> int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
> {
>     /* The function prototypes would live in the security_* callers... */
>     int (*func)(struct task_struct *child, unsigned int mode);
>     struct lsm_list *lp;
>     int rc = 0;
>     int thisrc;
>
>     if (list_empty(lsm_ops[LSM_PTRACE_ACCESS_CHECK])) {
>         func =  capability_ops.func[LSM_PTRACE_ACCESS_CHECK];
>         return func(child, mode);
>
>     list_for_each_entry(lp, lsm_ops[LSM_PTRACE_ACCESS_CHECK], list) {
>         func =  lp->ops->func[LSM_PTRACE_ACCESS_CHECK];
>         thisrc = func(child, mode);
>         if (thisrc)
>             rc = thisrc;
>     }
>     return rc;
> }

That's an awful lot of "stuff" just to hide a few lines of code
that the developer ought to be looking at anyway.

>
>> 4. The security_hook funtions have been un-macroed.
>>    This should make dealing with special cases
>>    easier at the cost of code bulk.
> It seems like there are enough calls doing the same thing that leaving
> the common cases as macros is fine. As Tetsuo pointed out, they'll all
> get optimized.

I could be persuaded to go back to macros for trivial cases I suppose,
but now that it's all out in the open I kind of like it this way.

>
> Other than these thoughts, I say ship it! :)

I'll wait until Stephen points out the obvious configuration
issue that I've missed, and to see who points out the fundamental
flaw in my list handling.

Seriously though, suggestions on the XFRM and secid hook issues
would be greatly appreciated. I'm not sure that audit is completely
robust, either. And the whole [gs]etprocattr processing is too
clever by half. I deserve a serious flame on that and hope someone
can provide it and the follow-on correct code.

>
> Acked-by: Kees Cook <keescook@chromium.org>

Thanks. I think I may be getting close.

>
> -Kees
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
