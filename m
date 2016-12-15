Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBFLAYhp026532
 for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2016 16:10:34 -0500
Received: by mail-vk0-f68.google.com with SMTP id p9so8664676vkd.1
 for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2016 13:10:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481318475-7288-1-git-send-email-sds@tycho.nsa.gov>
References: <1481318475-7288-1-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Dec 2016 16:10:04 -0500
Message-ID: <CAHC9VhQ_VpmLPuJOoE9OY0aawHW_=Ka_=+M3Yghao9HmjDnxMA@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up cred usage and simplify
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 9, 2016 at 4:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> SELinux was sometimes using the task "objective" credentials when
> it could/should use the "subjective" credentials.  This was sometimes
> hidden by the fact that we were unnecessarily passing around pointers
> to the current task, making it appear as if the task could be something
> other than current, so eliminate all such passing.  Given that
> tasks may only alter their own credentials, we likely should move
> the check from selinux_setprocattr() to security_setprocattr() or even
> to proc_pid_attr_write() and drop the task argument to the security hook
> altogether; it can only serve to confuse things.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 154 +++++++++++++++++++++++------------------------
>  1 file changed, 76 insertions(+), 78 deletions(-)

No substantial objections, just some style nit picks below.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 8a90a0b..3f99480 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1696,23 +1696,27 @@ static int cred_has_perm(const struct cred *actor,
>  }
>
>  /*
> - * Check permission between a pair of tasks, e.g. signal checks,
> - * fork check, ptrace check, etc.
> - * tsk1 is the actor and tsk2 is the target
> - * - this uses the default subjective creds of tsk1
> + * Check permission between a task and the current task.
>   */
> -static int task_has_perm(const struct task_struct *tsk1,
> -                        const struct task_struct *tsk2,
> -                        u32 perms)
> +static int task_has_perm_to_current(const struct task_struct *tsk,
> +                                   u32 perms)
>  {
> -       const struct task_security_struct *__tsec1, *__tsec2;
> -       u32 sid1, sid2;
> +       u32 ssid, tsid;
>
> -       rcu_read_lock();
> -       __tsec1 = __task_cred(tsk1)->security;  sid1 = __tsec1->sid;
> -       __tsec2 = __task_cred(tsk2)->security;  sid2 = __tsec2->sid;
> -       rcu_read_unlock();
> -       return avc_has_perm(sid1, sid2, SECCLASS_PROCESS, perms, NULL);
> +       ssid = task_sid(tsk);
> +       tsid = current_sid();
> +       return avc_has_perm(ssid, tsid, SECCLASS_PROCESS, perms, NULL);
> +}

Why not just get rid of both ssid and tsid and turn this into a one
line function?

  avc_has_perm(task_sid(tsk), current_sid(), ...);

> +/*
> + * Check permission between current and itself.
> + */
> +static int self_has_perm(u32 perms)
> +{
> +       u32 sid;
> +
> +       sid = current_sid();

Nit picky, but if you're respining the patch for the above, why not
change this too ...

  u32 sid = current_sid();

> +       return avc_has_perm(sid, sid, SECCLASS_PROCESS, perms, NULL);
>  }
>
>  /*
> @@ -1772,13 +1776,10 @@ static int cred_has_capability(const struct cred *cred,
>         return rc;
>  }
>
> -/* Check whether a task is allowed to use a system operation. */
> -static int task_has_system(struct task_struct *tsk,
> -                          u32 perms)
> +/* Check whether the current task is allowed to use a system operation. */
> +static int current_has_system(u32 perms)

We should have a little more naming consistentcy between
current_has_system() and self_has_perm().  Something like
current_has_process/current_has_system,
self_has_process/self_has_system, or something else along the lines
... I think you get the idea.

>  {
> -       u32 sid = task_sid(tsk);
> -
> -       return avc_has_perm(sid, SECINITSID_KERNEL,
> +       return avc_has_perm(current_sid(), SECINITSID_KERNEL,
>                             SECCLASS_SYSTEM, perms, NULL);
>  }

-- 
paul moore
www.paul-moore.com
