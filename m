Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6IKNLZQ011467
 for <selinux@tycho.nsa.gov>; Mon, 18 Jul 2016 16:23:26 -0400
Date: Mon, 18 Jul 2016 15:23:20 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: John Stultz <john.stultz@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Oren Laadan <orenl@cellrox.com>, Ruchi Kandoi <kandoiruchi@google.com>,
 Rom Lemarchand <romlem@android.com>, Todd Kjos <tkjos@google.com>,
 Colin Cross <ccross@android.com>, Nick Kralevich <nnk@google.com>,
 Dmitry Shmidt <dimitrysh@google.com>, Elliott Hughes <enh@google.com>,
 Android Kernel Team <kernel-team@android.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH 2/2 v3] security: Add
 task_settimerslack/task_gettimerslack LSM hook
Message-ID: <20160718202320.GB24233@mail.hallyn.com>
References: <1468872671-9002-1-git-send-email-john.stultz@linaro.org>
 <1468872671-9002-2-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468872671-9002-2-git-send-email-john.stultz@linaro.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Quoting John Stultz (john.stultz@linaro.org):
> As requested, this patch implements a task_settimerslack and
> task_gettimerslack LSM hooks so that the /proc/<tid>/timerslack_ns
> interface can have finer grained security policies applied to it.
> 
> I've kept the CAP_SYS_NICE check in the timerslack_ns_write/show
> functions, as hiding it in the LSM hook seems too opaque, and doesn't
> seem like a widely enough adopted practice.
> 
> Don't really know what I'm doing here, so close review would be
> appreciated!
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

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
> Cc: linux-security-module@vger.kernel.org
> Cc: selinux@tycho.nsa.gov
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
>  * Initial swing at adding settimerslack LSM hook
> v3:
>  * Fix current/p switchup bug noted by NickK
>  * Add gettimerslack hook suggested by NickK
> 
>  fs/proc/base.c            | 10 ++++++++++
>  include/linux/lsm_hooks.h | 13 +++++++++++++
>  include/linux/security.h  | 12 ++++++++++++
>  security/security.c       | 14 ++++++++++++++
>  security/selinux/hooks.c  | 12 ++++++++++++
>  5 files changed, 61 insertions(+)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c94abae..cc66aa8 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2286,6 +2286,12 @@ static ssize_t timerslack_ns_write(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> +	err = security_task_settimerslack(p, slack_ns);
> +	if (err) {
> +		count = err;
> +		goto out;
> +	}
> +
>  	task_lock(p);
>  	if (slack_ns == 0)
>  		p->timer_slack_ns = p->default_timer_slack_ns;
> @@ -2314,6 +2320,10 @@ static int timerslack_ns_show(struct seq_file *m, void *v)
>  		goto out;
>  	}
>  
> +	ret = security_task_gettimerslack(p);
> +	if (ret)
> +		goto out;
> +
>  	task_lock(p);
>  	seq_printf(m, "%llu\n", p->timer_slack_ns);
>  	task_unlock(p);
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7ae3976..290483e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -627,6 +627,15 @@
>   *	Check permission before moving memory owned by process @p.
>   *	@p contains the task_struct for process.
>   *	Return 0 if permission is granted.
> + * @task_settimerslack:
> + *	Check permission before setting timerslack value of @p to @slack.
> + *	@p contains the task_struct of a process.
> + *	@slack contains the new slack value.
> + *	Return 0 if permission is granted.
> + * @task_gettimerslack:
> + *	Check permission before returning the timerslack value of @p.
> + *	@p contains the task_struct of a process.
> + *	Return 0 if permission is granted.
>   * @task_kill:
>   *	Check permission before sending signal @sig to @p.  @info can be NULL,
>   *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
> @@ -1473,6 +1482,8 @@ union security_list_options {
>  	int (*task_setscheduler)(struct task_struct *p);
>  	int (*task_getscheduler)(struct task_struct *p);
>  	int (*task_movememory)(struct task_struct *p);
> +	int (*task_settimerslack)(struct task_struct *p, u64 slack);
> +	int (*task_gettimerslack)(struct task_struct *p);
>  	int (*task_kill)(struct task_struct *p, struct siginfo *info,
>  				int sig, u32 secid);
>  	int (*task_wait)(struct task_struct *p);
> @@ -1732,6 +1743,8 @@ struct security_hook_heads {
>  	struct list_head task_setscheduler;
>  	struct list_head task_getscheduler;
>  	struct list_head task_movememory;
> +	struct list_head task_settimerslack;
> +	struct list_head task_gettimerslack;
>  	struct list_head task_kill;
>  	struct list_head task_wait;
>  	struct list_head task_prctl;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 14df373..ab70f47 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -325,6 +325,8 @@ int security_task_setrlimit(struct task_struct *p, unsigned int resource,
>  int security_task_setscheduler(struct task_struct *p);
>  int security_task_getscheduler(struct task_struct *p);
>  int security_task_movememory(struct task_struct *p);
> +int security_task_settimerslack(struct task_struct *p, u64 slack);
> +int security_task_gettimerslack(struct task_struct *p);
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
>  			int sig, u32 secid);
>  int security_task_wait(struct task_struct *p);
> @@ -950,6 +952,16 @@ static inline int security_task_movememory(struct task_struct *p)
>  	return 0;
>  }
>  
> +static inline int security_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +	return 0;
> +}
> +
> +static inline int security_task_gettimerslack(struct task_struct *p)
> +{
> +	return 0;
> +}
> +
>  static inline int security_task_kill(struct task_struct *p,
>  				     struct siginfo *info, int sig,
>  				     u32 secid)
> diff --git a/security/security.c b/security/security.c
> index 7095693..4ced236 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -977,6 +977,16 @@ int security_task_movememory(struct task_struct *p)
>  	return call_int_hook(task_movememory, 0, p);
>  }
>  
> +int security_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +	return call_int_hook(task_settimerslack, 0, p, slack);
> +}
> +
> +int security_task_gettimerslack(struct task_struct *p)
> +{
> +	return call_int_hook(task_gettimerslack, 0, p);
> +}
> +
>  int security_task_kill(struct task_struct *p, struct siginfo *info,
>  			int sig, u32 secid)
>  {
> @@ -1720,6 +1730,10 @@ struct security_hook_heads security_hook_heads = {
>  		LIST_HEAD_INIT(security_hook_heads.task_getscheduler),
>  	.task_movememory =
>  		LIST_HEAD_INIT(security_hook_heads.task_movememory),
> +	.task_settimerslack =
> +		LIST_HEAD_INIT(security_hook_heads.task_settimerslack),
> +	.task_gettimerslack =
> +		LIST_HEAD_INIT(security_hook_heads.task_gettimerslack),
>  	.task_kill =	LIST_HEAD_INIT(security_hook_heads.task_kill),
>  	.task_wait =	LIST_HEAD_INIT(security_hook_heads.task_wait),
>  	.task_prctl =	LIST_HEAD_INIT(security_hook_heads.task_prctl),
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a86d537..aac9599 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3849,6 +3849,16 @@ static int selinux_task_movememory(struct task_struct *p)
>  	return current_has_perm(p, PROCESS__SETSCHED);
>  }
>  
> +static int selinux_task_settimerslack(struct task_struct *p, u64 slack)
> +{
> +	return current_has_perm(p, PROCESS__SETSCHED);
> +}
> +
> +static int selinux_task_gettimerslack(struct task_struct *p)
> +{
> +	return current_has_perm(p, PROCESS__GETSCHED);
> +}
> +
>  static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
>  				int sig, u32 secid)
>  {
> @@ -6092,6 +6102,8 @@ static struct security_hook_list selinux_hooks[] = {
>  	LSM_HOOK_INIT(task_setscheduler, selinux_task_setscheduler),
>  	LSM_HOOK_INIT(task_getscheduler, selinux_task_getscheduler),
>  	LSM_HOOK_INIT(task_movememory, selinux_task_movememory),
> +	LSM_HOOK_INIT(task_settimerslack, selinux_task_settimerslack),
> +	LSM_HOOK_INIT(task_gettimerslack, selinux_task_gettimerslack),
>  	LSM_HOOK_INIT(task_kill, selinux_task_kill),
>  	LSM_HOOK_INIT(task_wait, selinux_task_wait),
>  	LSM_HOOK_INIT(task_to_inode, selinux_task_to_inode),
> -- 
> 1.9.1
