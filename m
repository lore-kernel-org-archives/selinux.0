Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TM8LOi029939
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 18:08:22 -0400
Received: by mail-vk0-f65.google.com with SMTP id j137so4322232vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 15:08:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201703282308.BHJ95808.MFFHVQLOOtJFOS@I-love.SAKURA.ne.jp>
References: <1490706772-8013-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1490707796.6046.1.camel@tycho.nsa.gov>
 <201703282308.BHJ95808.MFFHVQLOOtJFOS@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 18:08:19 -0400
Message-ID: <CAHC9VhTxG95_iBy6WMtWj_xR1-=_=meykw1cTxN8-XepP8oo2w@mail.gmail.com>
Subject: Re: [PATCH] selinux: Use task_alloc hook rather than task_create hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 28, 2017 at 10:08 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> >From b43bd0fc0cc267b91f51ad118f6fabd13efb921e Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 28 Mar 2017 22:09:38 +0900
> Subject: [PATCH v2] selinux: Use task_alloc hook rather than task_create hook
>
> This patch is a preparation for getting rid of task_create hook because
> task_alloc hook which can do what task_create hook can do was revived.
>
> Creating a new thread is unlikely prohibited by security policy, for
> fork()/execve()/exit() is fundamental of how processes are managed in
> Unix. If a program is known to create a new thread, it is likely that
> permission to create a new thread is given to that program. Therefore,
> a situation where security_task_create() returns an error is likely that
> the program was exploited and lost control. Even if SELinux failed to
> check permission to create a thread at security_task_create(), SELinux
> can later check it at security_task_alloc(). Since the new thread is not
> yet visible from the rest of the system, nobody can do bad things using
> the new thread. What we waste will be limited to some initialization
> steps such as dup_task_struct(), copy_creds() and audit_alloc() in
> copy_process(). We can tolerate these overhead for unlikely situation.
>
> Therefore, this patch changes SELinux to use task_alloc hook rather than
> task_create hook so that we can remove task_create hook.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

When are you planning to remove the task_create() hook?

I have no objection to this patch, and I plan to merge it, but merging
it now would require rebasing the selinux/next and I try to keep from
rebasing during the development cycle unless absolutely necessary.  I
think this can wait until after the next merge window, what do you
think?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d37a723..d850b7f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3710,7 +3710,8 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
>
>  /* task security operations */
>
> -static int selinux_task_create(unsigned long clone_flags)
> +static int selinux_task_alloc(struct task_struct *task,
> +                             unsigned long clone_flags)
>  {
>         u32 sid = current_sid();
>
> @@ -6205,7 +6206,7 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>
>         LSM_HOOK_INIT(file_open, selinux_file_open),
>
> -       LSM_HOOK_INIT(task_create, selinux_task_create),
> +       LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
>         LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
>         LSM_HOOK_INIT(cred_free, selinux_cred_free),
>         LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
> --
> 1.8.3.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
www.paul-moore.com
