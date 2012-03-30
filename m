Subject: Re: [PATCH] SELinux: apply a different permission to ptrace a
 child vs non-child
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20120330201334.23363.14917.stgit@paris.rdu.redhat.com>
References: <20120330201334.23363.14917.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 30 Mar 2012 16:28:38 -0400
Message-ID: <1333139318.8293.50.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-03-30 at 16:13 -0400, Eric Paris wrote:
> Some applications, like gdb, are able to ptrace both children or other
> completely unrelated tasks.  We would like to be able to discern these two
> things and to be able to allow gdb to ptrace it's children, but not to be
> able to ptrace unrelated tasks for security reasons.
> 
> This patch implements a new permission ptrace_child which is checked
> INSTEAD of ptrace if and ONLY if the ptrace_child policy capability is
> enabled.  We need a seperate policy cap because we are actually reducing
> the scope of ptrace.  If we used the default unknown permission handler we
> would run into trouble as new kernel with old policy would be weaker than
> old kernel with old policy.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/hooks.c            |   38 +++++++++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |    2 +-
>  security/selinux/include/security.h |    2 ++
>  security/selinux/selinuxfs.c        |    3 ++-
>  security/selinux/ss/services.c      |    3 +++
>  5 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ba74635..5cee787 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1805,6 +1805,39 @@ static inline u32 open_file_to_av(struct file *file)
>  
>  /* Hook functions begin here. */
>  
> +/**
> + * task_is_descendant - walk up a process family tree looking for a match
> + * @parent: the process to compare against while walking up from child
> + * @child: the process to start from while looking upwards for parent
> + *
> + * Returns 1 if child is a descendant of parent, 0 if not.
> + */
> +static int task_is_descendant(struct task_struct *parent,
> +			      struct task_struct *child)
> +{
> +	int rc = 0;
> +	struct task_struct *walker = child;
> +
> +	if (!parent || !child)
> +		return 0;
> +
> +	rcu_read_lock();
> +	if (!thread_group_leader(parent))
> +		parent = rcu_dereference(parent->group_leader);
> +	while (walker->pid > 0) {
> +		if (!thread_group_leader(walker))
> +			walker = rcu_dereference(walker->group_leader);
> +		if (walker == parent) {
> +			rc = 1;
> +			break;
> +		}
> +		walker = rcu_dereference(walker->real_parent);
> +	}
> +	rcu_read_unlock();
> +
> +	return rc;
> +}
> +
>  static int selinux_ptrace_access_check(struct task_struct *child,
>  				     unsigned int mode)
>  {

Same function as in yama?  So it should go to common code, ideally in
the core kernel since it is fairly tightly coupled to the process
implementation.

I guess you decide TRACEME wasn't a sufficient distinguisher.  However,
will this suffice?  Seems like yama had to keep adding exceptions and
allow the task to tell the kernel who to allowed to trace it.  Would
hate to add this only to find that it still doesn't allow you to deny
ptrace by default, since that was your motivation, right?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
