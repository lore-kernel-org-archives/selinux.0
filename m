Date: Thu, 30 Jul 2015 16:50:30 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Subject: Re: [PATCH v3 03/11] lsm: add file opener's cred to a setprocattr
 arguments
Message-ID: <20150730215030.GC13589@mail.hallyn.com>
References: <1437732285-11524-1-git-send-email-l.pawelczyk@samsung.com>
 <1437732285-11524-4-git-send-email-l.pawelczyk@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437732285-11524-4-git-send-email-l.pawelczyk@samsung.com>
Cc: linux-doc@vger.kernel.org, NeilBrown <neilb@suse.de>,
 linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, selinux@tycho.nsa.gov,
 Jonathan Corbet <corbet@lwn.net>, havner@gmail.com,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jiri Slaby <jslaby@suse.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 Fabian Frederick <fabf@skynet.be>, Al Viro <viro@zeniv.linux.org.uk>,
 James Morris <james.l.morris@oracle.com>,
 John Johansen <john.johansen@canonical.com>,
 Greg KH <gregkh@linuxfoundation.org>, Oleg Nesterov <oleg@redhat.com>,
 Andy Lutomirski <luto@amacapital.net>, linux-security-module@vger.kernel.org,
 Zefan Li <lizefan@huawei.com>, Joe Perches <joe@perches.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 24, 2015 at 12:04:37PM +0200, Lukasz Pawelczyk wrote:
> setprocattr hook for Smack's label_map attribute needs to know the
> capabilities of file opener. Add those credentials to the hook's
> arguments.
> 
> While at it add documentation on get/setprocattr hooks.
> 
> Signed-off-by: Lukasz Pawelczyk <l.pawelczyk@samsung.com>

Acked-by: Serge Hallyn <serge.hallyn@canonical.com>

> ---
>  fs/proc/base.c             |  2 +-
>  include/linux/lsm_hooks.h  | 18 ++++++++++++++++--
>  include/linux/security.h   |  7 +++++--
>  security/apparmor/lsm.c    |  5 +++--
>  security/security.c        |  6 ++++--
>  security/selinux/hooks.c   |  2 +-
>  security/smack/smack_lsm.c |  4 ++--
>  7 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index e5ac827..775372c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2458,7 +2458,7 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
>  	if (length < 0)
>  		goto out_free;
>  
> -	length = security_setprocattr(task,
> +	length = security_setprocattr(task, file->f_cred,
>  				      (char*)file->f_path.dentry->d_name.name,
>  				      (void*)page, count);
>  	mutex_unlock(&task->signal->cred_guard_mutex);
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d347e66..1751864 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1220,6 +1220,20 @@
>   *	Return 0 if @name is to be handled by seq, EOPNOTSUPP if getprocattr()
>   *	should be used. Other errors will be passed to user-space.
>   *
> + * @getprocattr:
> + *	Get a value of a proc security attribute in /proc/$PID/attr/.
> + *	@p a task associated with the proc file.
> + *	@name a name of the file in question.
> + *	@value a pointer where to return the attribute's value.
> + *
> + * @setprocattr:
> + *	Set a value of a proc security attribute in /proc/$PID/attr/.
> + *	@p a task associated with the proc file.
> + *	@f_cred credentials of a file's opener.
> + *	@name a name of the file in question.
> + *	@value a pointer where a value to set is kept.
> + *	@size a number of bytes to read from the @value pointer.
> + *
>   * @secid_to_secctx:
>   *	Convert secid to security context.  If secdata is NULL the length of
>   *	the result will be returned in seclen, but no secdata will be returned.
> @@ -1540,8 +1554,8 @@ union security_list_options {
>  	int (*getprocattr_seq)(struct task_struct *p, const char *name,
>  			       const struct seq_operations **ops);
>  	int (*getprocattr)(struct task_struct *p, char *name, char **value);
> -	int (*setprocattr)(struct task_struct *p, char *name, void *value,
> -				size_t size);
> +	int (*setprocattr)(struct task_struct *p, const struct cred *f_cred,
> +			   char *name, void *value, size_t size);
>  	int (*ismaclabel)(const char *name);
>  	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
>  	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3090bb2..f0d2914 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -348,7 +348,8 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode);
>  int security_getprocattr_seq(struct task_struct *p, const char *name,
>  			     const struct seq_operations **ops);
>  int security_getprocattr(struct task_struct *p, char *name, char **value);
> -int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size);
> +int security_setprocattr(struct task_struct *p, const struct cred *f_cred,
> +			 char *name, void *value, size_t size);
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb);
>  int security_ismaclabel(const char *name);
>  int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
> @@ -1071,7 +1072,9 @@ static inline int security_getprocattr(struct task_struct *p, char *name, char *
>  	return -EINVAL;
>  }
>  
> -static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
> +static inline int security_setprocattr(struct task_struct *p,
> +				       const struct cred *f_cred,
> +				       char *name, void *value, size_t size)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index dec607c..1212927 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -518,8 +518,9 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	return error;
>  }
>  
> -static int apparmor_setprocattr(struct task_struct *task, char *name,
> -				void *value, size_t size)
> +static int apparmor_setprocattr(struct task_struct *task,
> +				const struct cred *f_cred,
> +				char *name, void *value, size_t size)
>  {
>  	struct common_audit_data sa;
>  	struct apparmor_audit_data aad = {0,};
> diff --git a/security/security.c b/security/security.c
> index e348e38..88a3b78 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1137,9 +1137,11 @@ int security_getprocattr(struct task_struct *p, char *name, char **value)
>  	return call_int_hook(getprocattr, -EINVAL, p, name, value);
>  }
>  
> -int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
> +int security_setprocattr(struct task_struct *p, const struct cred *f_cred,
> +			 char *name, void *value, size_t size)
>  {
> -	return call_int_hook(setprocattr, -EINVAL, p, name, value, size);
> +	return call_int_hook(setprocattr, -EINVAL, p, f_cred,
> +			     name, value, size);
>  }
>  
>  int security_netlink_send(struct sock *sk, struct sk_buff *skb)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 564079c..3e1b9f7 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5556,7 +5556,7 @@ invalid:
>  	return -EINVAL;
>  }
>  
> -static int selinux_setprocattr(struct task_struct *p,
> +static int selinux_setprocattr(struct task_struct *p, const struct cred *f_cred,
>  			       char *name, void *value, size_t size)
>  {
>  	struct task_security_struct *tsec;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index d962f88..cdcabf4 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3450,8 +3450,8 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_setprocattr(struct task_struct *p, char *name,
> -			     void *value, size_t size)
> +static int smack_setprocattr(struct task_struct *p, const struct cred *f_cred,
> +			     char *name, void *value, size_t size)
>  {
>  	struct task_smack *tsp;
>  	struct cred *new;
> -- 
> 2.4.3
