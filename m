Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBL2bdrB024376
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 21:37:39 -0500
Received: by mail-ua0-f196.google.com with SMTP id i68so469058uad.1
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 18:37:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Dec 2016 21:37:36 -0500
Message-ID: <CAHC9VhTCtL3nT1ThPK9aa0fgVQYphk0Ax3xXSf0SbUSr33XC7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Dec 16, 2016 at 12:41 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Processes can only alter their own security attributes via
> /proc/pid/attr nodes.  This is presently enforced by each individual
> security module and is also imposed by the Linux credentials
> implementation, which only allows a task to alter its own credentials.
> Move the check enforcing this restriction from the individual
> security modules to proc_pid_attr_write() before calling the security hook,
> and drop the unnecessary task argument to the security hook since it can
> only ever be the current task.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  fs/proc/base.c             | 13 +++++++++----
>  include/linux/lsm_hooks.h  |  3 +--
>  include/linux/security.h   |  4 ++--
>  security/apparmor/lsm.c    |  7 ++-----
>  security/security.c        |  4 ++--
>  security/selinux/hooks.c   | 13 +------------
>  security/smack/smack_lsm.c | 11 +----------
>  7 files changed, 18 insertions(+), 37 deletions(-)

Merged into the selinux#next branch.

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6eae4d0..7b228ea 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2485,6 +2485,12 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>         length = -ESRCH;
>         if (!task)
>                 goto out_no_task;
> +
> +       /* A task may only write its own attributes. */
> +       length = -EACCES;
> +       if (current != task)
> +               goto out;
> +
>         if (count > PAGE_SIZE)
>                 count = PAGE_SIZE;
>
> @@ -2500,14 +2506,13 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>         }
>
>         /* Guard against adverse ptrace interaction */
> -       length = mutex_lock_interruptible(&task->signal->cred_guard_mutex);
> +       length = mutex_lock_interruptible(&current->signal->cred_guard_mutex);
>         if (length < 0)
>                 goto out_free;
>
> -       length = security_setprocattr(task,
> -                                     (char*)file->f_path.dentry->d_name.name,
> +       length = security_setprocattr(file->f_path.dentry->d_name.name,
>                                       page, count);
> -       mutex_unlock(&task->signal->cred_guard_mutex);
> +       mutex_unlock(&current->signal->cred_guard_mutex);
>  out_free:
>         kfree(page);
>  out:
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 558adfa..0dde959 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1547,8 +1547,7 @@ union security_list_options {
>         void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
>
>         int (*getprocattr)(struct task_struct *p, char *name, char **value);
> -       int (*setprocattr)(struct task_struct *p, char *name, void *value,
> -                               size_t size);
> +       int (*setprocattr)(const char *name, void *value, size_t size);
>         int (*ismaclabel)(const char *name);
>         int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
>         int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c2125e9..f4ebac1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -361,7 +361,7 @@ int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
>                         unsigned nsops, int alter);
>  void security_d_instantiate(struct dentry *dentry, struct inode *inode);
>  int security_getprocattr(struct task_struct *p, char *name, char **value);
> -int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size);
> +int security_setprocattr(const char *name, void *value, size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1106,7 +1106,7 @@ static inline int security_getprocattr(struct task_struct *p, char *name, char *
>         return -EINVAL;
>  }
>
> -static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
> +static inline int security_setprocattr(char *name, void *value, size_t size)
>  {
>         return -EINVAL;
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 41b8cb1..8202e55 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -495,8 +495,8 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>         return error;
>  }
>
> -static int apparmor_setprocattr(struct task_struct *task, char *name,
> -                               void *value, size_t size)
> +static int apparmor_setprocattr(const char *name, void *value,
> +                               size_t size)
>  {
>         struct common_audit_data sa;
>         struct apparmor_audit_data aad = {0,};
> @@ -506,9 +506,6 @@ static int apparmor_setprocattr(struct task_struct *task, char *name,
>
>         if (size == 0)
>                 return -EINVAL;
> -       /* task can only write its own attributes */
> -       if (current != task)
> -               return -EACCES;
>
>         /* AppArmor requires that the buffer must be null terminated atm */
>         if (args[size - 1] != '\0') {
> diff --git a/security/security.c b/security/security.c
> index f825304..32052f5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1170,9 +1170,9 @@ int security_getprocattr(struct task_struct *p, char *name, char **value)
>         return call_int_hook(getprocattr, -EINVAL, p, name, value);
>  }
>
> -int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
> +int security_setprocattr(const char *name, void *value, size_t size)
>  {
> -       return call_int_hook(setprocattr, -EINVAL, p, name, value, size);
> +       return call_int_hook(setprocattr, -EINVAL, name, value, size);
>  }
>
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9992626..762276b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5859,8 +5859,7 @@ static int selinux_getprocattr(struct task_struct *p,
>         return error;
>  }
>
> -static int selinux_setprocattr(struct task_struct *p,
> -                              char *name, void *value, size_t size)
> +static int selinux_setprocattr(const char *name, void *value, size_t size)
>  {
>         struct task_security_struct *tsec;
>         struct cred *new;
> @@ -5868,16 +5867,6 @@ static int selinux_setprocattr(struct task_struct *p,
>         int error;
>         char *str = value;
>
> -       if (current != p) {
> -               /*
> -                * A task may only alter its own credentials.
> -                * SELinux has always enforced this restriction,
> -                * and it is now mandated by the Linux credentials
> -                * infrastructure; see Documentation/security/credentials.txt.
> -                */
> -               return -EACCES;
> -       }
> -
>         /*
>          * Basic control over ability to set these attributes at all.
>          */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4d90257..9bde7f8 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3620,7 +3620,6 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>
>  /**
>   * smack_setprocattr - Smack process attribute setting
> - * @p: the object task
>   * @name: the name of the attribute in /proc/.../attr
>   * @value: the value to set
>   * @size: the size of the value
> @@ -3630,8 +3629,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_setprocattr(struct task_struct *p, char *name,
> -                            void *value, size_t size)
> +static int smack_setprocattr(const char *name, void *value, size_t size)
>  {
>         struct task_smack *tsp = current_security();
>         struct cred *new;
> @@ -3639,13 +3637,6 @@ static int smack_setprocattr(struct task_struct *p, char *name,
>         struct smack_known_list_elem *sklep;
>         int rc;
>
> -       /*
> -        * Changing another process' Smack value is too dangerous
> -        * and supports no sane use case.
> -        */
> -       if (p != current)
> -               return -EPERM;
> -
>         if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>                 return -EPERM;
>
> --
> 2.7.4
>



-- 
paul moore
www.paul-moore.com
