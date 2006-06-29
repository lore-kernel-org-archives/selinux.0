Subject: Re: [PATCH] ioprio: Add security hook definition for getioprio and
	insert hooks
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Quigley <dpquigl@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1151602066.19332.7.camel@moss-terrapins.epoch.ncsc.mil>
References: <1151600677.19332.1.camel@moss-terrapins.epoch.ncsc.mil>
	 <1151602066.19332.7.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 14:21:34 -0400
Message-Id: <1151605294.21450.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-29 at 13:27 -0400, David Quigley wrote:
> This patch adds a new security hook definition for the sys_ioprio_get
> operation. At present, the SELinux hook function implementation for
> this hook is identical to the setscheduler implementation but a

getscheduler?

> separate hook is introduced to allow this check to be specialized in
> the future if necessary. This patch also creates a helper function
> get_task_ioprio which handles the access check in addition to
> performing the get task.

retrieving the ioprio value for the task.

> 
> Signed-Off-By: David Quigley <dpquigl@tycho.nsa.gov>
> 
> ---
> 
> 
>  fs/ioprio.c              |   31 ++++++++++++++++++++++---------
>  include/linux/security.h |   15 +++++++++++++++
>  security/dummy.c         |    6 ++++++
>  security/selinux/hooks.c |    6 ++++++
>  4 files changed, 49 insertions(+), 9 deletions(-)
> 
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/fs/ioprio.c linux-2.6.17-mm3-ioprio/fs/ioprio.c
> --- linux-2.6.17-mm3/fs/ioprio.c	2006-06-28 13:58:56.000000000 -0400
> +++ linux-2.6.17-mm3-ioprio/fs/ioprio.c	2006-06-29 10:32:43.000000000 -0400
> @@ -125,6 +125,25 @@ asmlinkage long sys_ioprio_set(int which
>  	return ret;
>  }
>  
> +static int get_task_ioprio(struct task_struct *p, int prev)
> +{
> +	int ret = 0;

No point in initializing ret here since you immediately set it below.

> +
> +	ret = security_task_getioprio(p);
> +	if (ret)
> +		goto out;
> +	if (!ioprio_valid(prev)) {
> +		ret = p->ioprio;
> +		goto out;
> +	}
> +	if (prev == -ESRCH)
> +		ret = p->ioprio;
> +	else
> +		ret = ioprio_best(prev, p->ioprio);

This seems a bit obscure.  I think that the helper should just return
p->ioprio, and leave the extra logic to the caller.  What happens if
prev == -EACCES or other error from prior call to the security hook?

> +out:
> +	return ret;
> +}
> +
>  asmlinkage long sys_ioprio_get(int which, int who)
>  {
>  	struct task_struct *g, *p;
> @@ -139,16 +158,13 @@ asmlinkage long sys_ioprio_get(int which
>  			else
>  				p = find_task_by_pid(who);
>  			if (p)
> -				ret = p->ioprio;
> +				ret = get_task_ioprio(p, IOPRIO_CLASS_NONE);
>  			break;
>  		case IOPRIO_WHO_PGRP:
>  			if (!who)
>  				who = process_group(current);
>  			do_each_task_pid(who, PIDTYPE_PGID, p) {
> -				if (ret == -ESRCH)
> -					ret = p->ioprio;
> -				else
> -					ret = ioprio_best(ret, p->ioprio);
> +				ret = get_task_ioprio(p, ret);

I think you want to separate the extraction of p->ioprio (w/ permission
check) from the ioprio_best computation, and possibly just skip the task
if the check/extract fails.  IOW, compute the best ioprio for all
accessible tasks.

>  			} while_each_task_pid(who, PIDTYPE_PGID, p);
>  			break;
>  		case IOPRIO_WHO_USER:
> @@ -163,10 +179,7 @@ asmlinkage long sys_ioprio_get(int which
>  			do_each_thread(g, p) {
>  				if (p->uid != user->uid)
>  					continue;
> -				if (ret == -ESRCH)
> -					ret = p->ioprio;
> -				else
> -					ret = ioprio_best(ret, p->ioprio);
> +				ret = get_task_ioprio(p, ret);

Likewise here.

>  			} while_each_thread(g, p);
>  
>  			if (who)
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/include/linux/security.h linux-2.6.17-mm3-ioprio/include/linux/security.h
> --- linux-2.6.17-mm3/include/linux/security.h	2006-06-28 13:58:59.000000000 -0400
> +++ linux-2.6.17-mm3-ioprio/include/linux/security.h	2006-06-28 11:21:37.000000000 -0400
> @@ -582,6 +582,10 @@ struct swap_info_struct;
>   *	@p contains the task_struct of process.
>   *	@ioprio contains the new ioprio value
>   *	Return 0 if permission is granted.
> + * @task_getioprio
> + *	Check permission before getting the ioprio value of @p.
> + *	@p contains the task_struct of process.
> + *	Return 0 if permission is granted.
>   * @task_setrlimit:
>   *	Check permission before setting the resource limits of the current
>   *	process for @resource to @new_rlim.  The old resource limit values can
> @@ -1221,6 +1225,7 @@ struct security_operations {
>  	int (*task_setgroups) (struct group_info *group_info);
>  	int (*task_setnice) (struct task_struct * p, int nice);
>  	int (*task_setioprio) (struct task_struct * p, int ioprio);
> +	int (*task_getioprio) (struct task_struct * p);
>  	int (*task_setrlimit) (unsigned int resource, struct rlimit * new_rlim);
>  	int (*task_setscheduler) (struct task_struct * p, int policy,
>  				  struct sched_param * lp);
> @@ -1853,6 +1858,11 @@ static inline int security_task_setiopri
>  	return security_ops->task_setioprio (p, ioprio);
>  }
>  
> +static inline int security_task_getioprio (struct task_struct *p)
> +{
> +	return security_ops->task_getioprio (p);
> +}
> +
>  static inline int security_task_setrlimit (unsigned int resource,
>  					   struct rlimit *new_rlim)
>  {
> @@ -2505,6 +2515,11 @@ static inline int security_task_setiopri
>  	return 0;
>  }
>  
> +static inline int security_task_getioprio (struct task_struct *p)
> +{
> +	return 0;
> +}
> +
>  static inline int security_task_setrlimit (unsigned int resource,
>  					   struct rlimit *new_rlim)
>  {
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/dummy.c linux-2.6.17-mm3-ioprio/security/dummy.c
> --- linux-2.6.17-mm3/security/dummy.c	2006-06-28 13:58:59.000000000 -0400
> +++ linux-2.6.17-mm3-ioprio/security/dummy.c	2006-06-28 11:23:00.000000000 -0400
> @@ -521,6 +521,11 @@ static int dummy_task_setioprio (struct 
>  	return 0;
>  }
>  
> +static int dummy_task_getioprio (struct task_struct *p)
> +{
> +	return 0;
> +}
> +
>  static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
>  {
>  	return 0;
> @@ -984,6 +989,7 @@ void security_fixup_ops (struct security
>  	set_to_dummy_if_null(ops, task_setgroups);
>  	set_to_dummy_if_null(ops, task_setnice);
>  	set_to_dummy_if_null(ops, task_setioprio);
> +	set_to_dummy_if_null(ops, task_getioprio);
>  	set_to_dummy_if_null(ops, task_setrlimit);
>  	set_to_dummy_if_null(ops, task_setscheduler);
>  	set_to_dummy_if_null(ops, task_getscheduler);
> diff -uprN -X /home/dpquigl/dontdiff linux-2.6.17-mm3/security/selinux/hooks.c linux-2.6.17-mm3-ioprio/security/selinux/hooks.c
> --- linux-2.6.17-mm3/security/selinux/hooks.c	2006-06-28 13:58:59.000000000 -0400
> +++ linux-2.6.17-mm3-ioprio/security/selinux/hooks.c	2006-06-28 11:49:13.000000000 -0400
> @@ -2665,6 +2665,11 @@ static int selinux_task_setioprio(struct
>  	return task_has_perm(current, p, PROCESS__SETSCHED);
>  }
>  
> +static int selinux_task_getioprio(struct task_struct *p)
> +{
> +	return task_has_perm(current, p, PROCESS__GETSCHED);
> +}
> +
>  static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
>  {
>  	struct rlimit *old_rlim = current->signal->rlim + resource;
> @@ -4432,6 +4437,7 @@ static struct security_operations selinu
>  	.task_setgroups =		selinux_task_setgroups,
>  	.task_setnice =			selinux_task_setnice,
>  	.task_setioprio =		selinux_task_setioprio,
> +	.task_getioprio =		selinux_task_getioprio,
>  	.task_setrlimit =		selinux_task_setrlimit,
>  	.task_setscheduler =		selinux_task_setscheduler,
>  	.task_getscheduler =		selinux_task_getscheduler,
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
