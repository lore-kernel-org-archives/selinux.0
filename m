Message-ID: <1482162765.28570.33.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Date: Mon, 19 Dec 2016 10:52:45 -0500
In-Reply-To: <1482162073.2178.6.camel@nonadev.net>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482158025.28570.10.camel@tycho.nsa.gov>
 <1482162073.2178.6.camel@nonadev.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 16:41 +0100, José Bollo wrote:
> Le lundi 19 décembre 2016 à 09:33 -0500, Stephen Smalley a écrit :
> > 
> > On Mon, 2016-12-19 at 10:44 +0100, José Bollo wrote:
> > > 
> > > Le vendredi 16 décembre 2016 à 12:41 -0500, Stephen Smalley a
> > > écrit :
> > > > 
> > > > 
> > > > Processes can only alter their own security attributes via
> > > > /proc/pid/attr nodes.  This is presently enforced by each
> > > > individual
> > > > security module and is also imposed by the Linux credentials
> > > > implementation, which only allows a task to alter its own
> > > > credentials.
> > > > Move the check enforcing this restriction from the individual
> > > > security modules to proc_pid_attr_write() before calling the
> > > > security
> > > > hook,
> > > > and drop the unnecessary task argument to the security hook
> > > > since
> > > > it
> > > > can
> > > > only ever be the current task.
> > > 
> > > Hi Stephen,
> > > 
> > > The module PTAGS that I made relies on the ability to write files
> > > in
> > > /proc/pid/attr/...
> > > 
> > > Why did I used this files? Thaere are serious reasons:
> > >  - follows the life cycle of the process
> > >  - implements pid namespace
> > > 
> > > There is absolutely no way to get these features easyly outside
> > > that
> > > implementation context of /proc/pid/attr/xxx.
> > > 
> > > For these reasons I vote against that change.
> > 
> > It is already prohibited by the credentials framework;
> 
> If it were REALLY prohibited, your patch shouldn't exist ;)

You can't do it safely (and your current implementation is unsafe).
 Please, read Documentation/security/credentials.txt in full, and look
at the setprocattr implementations in the upstream security modules for
reference.

> 
> Best regards
> José Bollo
> 
> > 
> >  see
> > Documentation/security/credentials.txt, under ALTERING CREDENTIALS.
> > We are not imposing a new restriction here, just recognizing that
> > it
> > already exists (ever since Linux moved to using cred structures).
> >  You
> > might not agree with that restriction, but we didn't invent it.
> > 
> > > 
> > > You will probably ask me where is PTAGS used and what is is made
> > > for.
> > > 
> > > So it is not used but the principle of its use is benefical to
> > > the
> > > community. It allows a kind of user land implementation of
> > > capabilities.
> > > 
> > > You probably know that the kernel can not do all things for a
> > > good
> > > reason: it is not intended to do all things. So there is a need
> > > for
> > > user land features. PTAGS is an intent to fulfill an empty gap.
> > > 
> > > I made a presentation at FOSDEM on the subject that may allows
> > > you
> > > to
> > > understand the beginning of the issue that I'm writing about
> > > [2]. 
> > > 
> > > [1] https://lkml.org/lkml/2016/11/23/122
> > > [2] https://archive.fosdem.org/2015/schedule/event/sec_enforcemen
> > > t/
> > > 
> > > > 
> > > > 
> > > > 
> > > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > > ---
> > > >  fs/proc/base.c             | 13 +++++++++----
> > > >  include/linux/lsm_hooks.h  |  3 +--
> > > >  include/linux/security.h   |  4 ++--
> > > >  security/apparmor/lsm.c    |  7 ++-----
> > > >  security/security.c        |  4 ++--
> > > >  security/selinux/hooks.c   | 13 +------------
> > > >  security/smack/smack_lsm.c | 11 +----------
> > > >  7 files changed, 18 insertions(+), 37 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > index 6eae4d0..7b228ea 100644
> > > > --- a/fs/proc/base.c
> > > > +++ b/fs/proc/base.c
> > > > @@ -2485,6 +2485,12 @@ static ssize_t
> > > > proc_pid_attr_write(struct
> > > > file
> > > > * file, const char __user * buf,
> > > >  	length = -ESRCH;
> > > >  	if (!task)
> > > >  		goto out_no_task;
> > > > +
> > > > +	/* A task may only write its own attributes. */
> > > > +	length = -EACCES;
> > > > +	if (current != task)
> > > > +		goto out;
> > > > +
> > > >  	if (count > PAGE_SIZE)
> > > >  		count = PAGE_SIZE;
> > > >  
> > > > @@ -2500,14 +2506,13 @@ static ssize_t
> > > > proc_pid_attr_write(struct
> > > > file * file, const char __user * buf,
> > > >  	}
> > > >  
> > > >  	/* Guard against adverse ptrace interaction */
> > > > -	length = mutex_lock_interruptible(&task->signal-
> > > > > 
> > > > > 
> > > > > cred_guard_mutex);
> > > > 
> > > > +	length = mutex_lock_interruptible(&current->signal-
> > > > > 
> > > > > 
> > > > > cred_guard_mutex);
> > > > 
> > > >  	if (length < 0)
> > > >  		goto out_free;
> > > >  
> > > > -	length = security_setprocattr(task,
> > > > -				      (char*)file-
> > > > > 
> > > > > f_path.dentry-
> > > > > 
> > > > > d_name.name,
> > > > 
> > > > +	length = security_setprocattr(file->f_path.dentry-
> > > > > 
> > > > > 
> > > > > d_name.name,
> > > > 
> > > >  				      page, count);
> > > > -	mutex_unlock(&task->signal->cred_guard_mutex);
> > > > +	mutex_unlock(&current->signal->cred_guard_mutex);
> > > >  out_free:
> > > >  	kfree(page);
> > > >  out:
> > > > diff --git a/include/linux/lsm_hooks.h
> > > > b/include/linux/lsm_hooks.h
> > > > index 558adfa..0dde959 100644
> > > > --- a/include/linux/lsm_hooks.h
> > > > +++ b/include/linux/lsm_hooks.h
> > > > @@ -1547,8 +1547,7 @@ union security_list_options {
> > > >  	void (*d_instantiate)(struct dentry *dentry, struct
> > > > inode
> > > > *inode);
> > > >  
> > > >  	int (*getprocattr)(struct task_struct *p, char *name,
> > > > char
> > > > **value);
> > > > -	int (*setprocattr)(struct task_struct *p, char *name,
> > > > void
> > > > *value,
> > > > -				size_t size);
> > > > +	int (*setprocattr)(const char *name, void *value,
> > > > size_t
> > > > size);
> > > >  	int (*ismaclabel)(const char *name);
> > > >  	int (*secid_to_secctx)(u32 secid, char **secdata, u32
> > > > *seclen);
> > > >  	int (*secctx_to_secid)(const char *secdata, u32
> > > > seclen,
> > > > u32
> > > > *secid);
> > > > diff --git a/include/linux/security.h
> > > > b/include/linux/security.h
> > > > index c2125e9..f4ebac1 100644
> > > > --- a/include/linux/security.h
> > > > +++ b/include/linux/security.h
> > > > @@ -361,7 +361,7 @@ int security_sem_semop(struct sem_array
> > > > *sma,
> > > > struct sembuf *sops,
> > > >  			unsigned nsops, int alter);
> > > >  void security_d_instantiate(struct dentry *dentry, struct
> > > > inode
> > > > *inode);
> > > >  int security_getprocattr(struct task_struct *p, char *name,
> > > > char
> > > > **value);
> > > > -int security_setprocattr(struct task_struct *p, char *name,
> > > > void
> > > > *value, size_t size);
> > > > +int security_setprocattr(const char *name, void *value, size_t
> > > > size);
> > > >  int security_netlink_send(struct sock *sk, struct sk_buff
> > > > *skb);
> > > >  int security_ismaclabel(const char *name);
> > > >  int security_secid_to_secctx(u32 secid, char **secdata, u32
> > > > *seclen);
> > > > @@ -1106,7 +1106,7 @@ static inline int
> > > > security_getprocattr(struct
> > > > task_struct *p, char *name, char *
> > > >  	return -EINVAL;
> > > >  }
> > > >  
> > > > -static inline int security_setprocattr(struct task_struct *p,
> > > > char
> > > > *name, void *value, size_t size)
> > > > +static inline int security_setprocattr(char *name, void
> > > > *value,
> > > > size_t size)
> > > >  {
> > > >  	return -EINVAL;
> > > >  }
> > > > diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> > > > index 41b8cb1..8202e55 100644
> > > > --- a/security/apparmor/lsm.c
> > > > +++ b/security/apparmor/lsm.c
> > > > @@ -495,8 +495,8 @@ static int apparmor_getprocattr(struct
> > > > task_struct *task, char *name,
> > > >  	return error;
> > > >  }
> > > >  
> > > > -static int apparmor_setprocattr(struct task_struct *task, char
> > > > *name,
> > > > -				void *value, size_t size)
> > > > +static int apparmor_setprocattr(const char *name, void *value,
> > > > +				size_t size)
> > > >  {
> > > >  	struct common_audit_data sa;
> > > >  	struct apparmor_audit_data aad = {0,};
> > > > @@ -506,9 +506,6 @@ static int apparmor_setprocattr(struct
> > > > task_struct *task, char *name,
> > > >  
> > > >  	if (size == 0)
> > > >  		return -EINVAL;
> > > > -	/* task can only write its own attributes */
> > > > -	if (current != task)
> > > > -		return -EACCES;
> > > >  
> > > >  	/* AppArmor requires that the buffer must be null
> > > > terminated
> > > > atm */
> > > >  	if (args[size - 1] != '\0') {
> > > > diff --git a/security/security.c b/security/security.c
> > > > index f825304..32052f5 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -1170,9 +1170,9 @@ int security_getprocattr(struct
> > > > task_struct
> > > > *p,
> > > > char *name, char **value)
> > > >  	return call_int_hook(getprocattr, -EINVAL, p, name,
> > > > value);
> > > >  }
> > > >  
> > > > -int security_setprocattr(struct task_struct *p, char *name,
> > > > void
> > > > *value, size_t size)
> > > > +int security_setprocattr(const char *name, void *value, size_t
> > > > size)
> > > >  {
> > > > -	return call_int_hook(setprocattr, -EINVAL, p, name,
> > > > value,
> > > > size);
> > > > +	return call_int_hook(setprocattr, -EINVAL, name,
> > > > value,
> > > > size);
> > > >  }
> > > >  
> > > >  int security_netlink_send(struct sock *sk, struct sk_buff
> > > > *skb)
> > > > diff --git a/security/selinux/hooks.c
> > > > b/security/selinux/hooks.c
> > > > index 9992626..762276b 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -5859,8 +5859,7 @@ static int selinux_getprocattr(struct
> > > > task_struct *p,
> > > >  	return error;
> > > >  }
> > > >  
> > > > -static int selinux_setprocattr(struct task_struct *p,
> > > > -			       char *name, void *value, size_t
> > > > size)
> > > > +static int selinux_setprocattr(const char *name, void *value,
> > > > size_t
> > > > size)
> > > >  {
> > > >  	struct task_security_struct *tsec;
> > > >  	struct cred *new;
> > > > @@ -5868,16 +5867,6 @@ static int selinux_setprocattr(struct
> > > > task_struct *p,
> > > >  	int error;
> > > >  	char *str = value;
> > > >  
> > > > -	if (current != p) {
> > > > -		/*
> > > > -		 * A task may only alter its own credentials.
> > > > -		 * SELinux has always enforced this
> > > > restriction,
> > > > -		 * and it is now mandated by the Linux
> > > > credentials
> > > > -		 * infrastructure; see
> > > > Documentation/security/credentials.txt.
> > > > -		 */
> > > > -		return -EACCES;
> > > > -	}
> > > > -
> > > >  	/*
> > > >  	 * Basic control over ability to set these attributes
> > > > at
> > > > all.
> > > >  	 */
> > > > diff --git a/security/smack/smack_lsm.c
> > > > b/security/smack/smack_lsm.c
> > > > index 4d90257..9bde7f8 100644
> > > > --- a/security/smack/smack_lsm.c
> > > > +++ b/security/smack/smack_lsm.c
> > > > @@ -3620,7 +3620,6 @@ static int smack_getprocattr(struct
> > > > task_struct
> > > > *p, char *name, char **value)
> > > >  
> > > >  /**
> > > >   * smack_setprocattr - Smack process attribute setting
> > > > - * @p: the object task
> > > >   * @name: the name of the attribute in /proc/.../attr
> > > >   * @value: the value to set
> > > >   * @size: the size of the value
> > > > @@ -3630,8 +3629,7 @@ static int smack_getprocattr(struct
> > > > task_struct
> > > > *p, char *name, char **value)
> > > >   *
> > > >   * Returns the length of the smack label or an error code
> > > >   */
> > > > -static int smack_setprocattr(struct task_struct *p, char
> > > > *name,
> > > > -			     void *value, size_t size)
> > > > +static int smack_setprocattr(const char *name, void *value,
> > > > size_t
> > > > size)
> > > >  {
> > > >  	struct task_smack *tsp = current_security();
> > > >  	struct cred *new;
> > > > @@ -3639,13 +3637,6 @@ static int smack_setprocattr(struct
> > > > task_struct *p, char *name,
> > > >  	struct smack_known_list_elem *sklep;
> > > >  	int rc;
> > > >  
> > > > -	/*
> > > > -	 * Changing another process' Smack value is too
> > > > dangerous
> > > > -	 * and supports no sane use case.
> > > > -	 */
> > > > -	if (p != current)
> > > > -		return -EPERM;
> > > > -
> > > >  	if (!smack_privileged(CAP_MAC_ADMIN) &&
> > > > list_empty(&tsp-
> > > > > 
> > > > > 
> > > > > smk_relabel))
> > > > 
> > > >  		return -EPERM;
> > > >  
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > security-module" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
