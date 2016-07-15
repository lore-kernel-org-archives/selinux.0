Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6FHpmBn000872
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 13:51:48 -0400
Received: by mail-yw0-f175.google.com with SMTP id v186so46795652ywd.0
 for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2016 10:51:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468603460-17034-2-git-send-email-john.stultz@linaro.org>
References: <1468603460-17034-1-git-send-email-john.stultz@linaro.org>
 <1468603460-17034-2-git-send-email-john.stultz@linaro.org>
From: Nick Kralevich <nnk@google.com>
Date: Fri, 15 Jul 2016 10:51:25 -0700
Message-ID: <CAFJ0LnExf1L=JaGwW5=qyZsutVucx7b8f0Ti63oLB-NuMr20yA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2 v2] security: Add task_settimerslack LSM hook
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Dmitry Shmidt <dimitrysh@google.com>,
 Elliott Hughes <enh@google.com>,
 Android Kernel Team <kernel-team@android.com>,
 linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On Fri, Jul 15, 2016 at 10:24 AM, John Stultz <john.stultz@linaro.org> wrote:
> As requested, this patch implements a task_settimerslack LSM hook
> so that the /proc/<tid>/timerslack_ns interface can have finer
> grained security policies applied to it.
>
> Don't really know what I'm doing here, so close review would be
> appreciated!
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Oren Laadan <orenl@cellrox.com>
> Cc: Ruchi Kandoi <kandoiruchi@google.com>
> Cc: Rom Lemarchand <romlem@android.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Nick Kralevich <nnk@google.com>
> Cc: Dmitry Shmidt <dimitrysh@google.com>
> Cc: Elliott Hughes <enh@google.com>
> Cc: Android Kernel Team <kernel-team@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Initial swing at adding LSM hook
>
>  fs/proc/base.c            | 7 +++++++
>  include/linux/lsm_hooks.h | 7 +++++++
>  include/linux/security.h  | 6 ++++++
>  security/security.c       | 7 +++++++
>  security/selinux/hooks.c  | 6 ++++++
>  5 files changed, 33 insertions(+)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8f4f8d7..7f10b37 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2284,6 +2284,12 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>         if (!p)
>                 return -ESRCH;
>
> +       err = security_task_settimerslack(current, slack_ns);

The first argument should be "p", not "current". "p" is the target
process you're trying to adjust.

> +       if (err) {
> +               count = err;
> +               goto out;
> +       }
> +
>         task_lock(p);
>         if (slack_ns == 0)
>                 p->timer_slack_ns = p->default_timer_slack_ns;
> @@ -2291,6 +2297,7 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>                 p->timer_slack_ns = slack_ns;
>         task_unlock(p);
>
> +out:
>         put_task_struct(p);
>
>         return count;
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7ae3976..ed546c4 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -627,6 +627,11 @@
>   *     Check permission before moving memory owned by process @p.
>   *     @p contains the task_struct for process.
>   *     Return 0 if permission is granted.
> + * @task_settimerslack:
> + *     Check permission before setting timerslack value of @p to @slack.
> + *     @p contains the task_struct of a process.
> + *     @slack contains the new slack value.
> + *     Return 0 if permission is granted.
>   * @task_kill:
>   *     Check permission before sending signal @sig to @p.  @info can be NULL,
>   *     the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
> @@ -1473,6 +1478,7 @@ union security_list_options {
>         int (*task_setscheduler)(struct task_struct *p);
>         int (*task_getscheduler)(struct task_struct *p);
>         int (*task_movememory)(struct task_struct *p);
> +       int (*task_settimerslack)(struct task_struct *p, u64 slack);
>         int (*task_kill)(struct task_struct *p, struct siginfo *info,
>                                 int sig, u32 secid);
>         int (*task_wait)(struct task_struct *p);
> @@ -1732,6 +1738,7 @@ struct security_hook_heads {
>         struct list_head task_setscheduler;
>         struct list_head task_getscheduler;
>         struct list_head task_movememory;
> +       struct list_head task_settimerslack;
>         struct list_head task_kill;
>         struct list_head task_wait;
>         struct list_head task_prctl;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 14df373..1736e2b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -325,6 +325,7 @@ int security_task_setrlimit(struct task_struct *p, unsigned int resource,
>  int security_task_setscheduler(struct task_struct *p);
>  int security_task_getscheduler(struct task_struct *p);
>  int security_task_movememory(struct task_struct *p);
> +int security_task_settimerslack(struct task_struct *p, u64 slack);
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
>                         int sig, u32 secid);
>  int security_task_wait(struct task_struct *p);
> @@ -950,6 +951,11 @@ static inline int security_task_movememory(struct task_struct *p)
>         return 0;
>  }
>
> +static inline int security_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +       return 0;
> +}
> +
>  static inline int security_task_kill(struct task_struct *p,
>                                      struct siginfo *info, int sig,
>                                      u32 secid)
> diff --git a/security/security.c b/security/security.c
> index 7095693..45f15cb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -977,6 +977,11 @@ int security_task_movememory(struct task_struct *p)
>         return call_int_hook(task_movememory, 0, p);
>  }
>
> +int security_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +       return call_int_hook(task_settimerslack, 0, p, slack);
> +}
> +
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
>                         int sig, u32 secid)
>  {
> @@ -1720,6 +1725,8 @@ struct security_hook_heads security_hook_heads = {
>                 LIST_HEAD_INIT(security_hook_heads.task_getscheduler),
>         .task_movememory =
>                 LIST_HEAD_INIT(security_hook_heads.task_movememory),
> +       .task_settimerslack =
> +               LIST_HEAD_INIT(security_hook_heads.task_settimerslack),
>         .task_kill =    LIST_HEAD_INIT(security_hook_heads.task_kill),
>         .task_wait =    LIST_HEAD_INIT(security_hook_heads.task_wait),
>         .task_prctl =   LIST_HEAD_INIT(security_hook_heads.task_prctl),
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a86d537..e7c04322 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3849,6 +3849,11 @@ static int selinux_task_movememory(struct task_struct *p)
>         return current_has_perm(p, PROCESS__SETSCHED);
>  }
>
> +static int selinux_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +       return current_has_perm(p, PROCESS__SETSCHED);
> +}
> +
>  static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
>                                 int sig, u32 secid)
>  {
> @@ -6092,6 +6097,7 @@ static struct security_hook_list selinux_hooks[] = {
>         LSM_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
>         LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
>         LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
> +       LSM_HOOK_INIT(task_settimerslack, selinux_task_settimerslack),
>         LSM_HOOK_INIT(task_kill, selinux_task_kill),
>         LSM_HOOK_INIT(task_wait, selinux_task_wait),
>         LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
> --
> 1.9.1
>



-- 
Nick Kralevich | Android Security | nnk@google.com | 650.214.4037
