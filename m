Subject: Re: [PATCH] repost: new sockcreate interface to specify context of
	socket when they are created
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, kmacmillan@tresys.com, jmorris@namei.org
In-Reply-To: <1150902506.27852.35.camel@localhost.localdomain>
References: <1150902506.27852.35.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 12:03:19 -0400
Message-Id: <1150905799.27531.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-06-21 at 11:08 -0400, Eric Paris wrote:
> Updated to fix the style problems James pointed out.  Retested to make
> sure it was still working.
> 
> Below is a patch to add a new /proc/self/attr/sockcreate   A process may
> write a context into this interface and all subsequent sockets created
> will be labeled with that context.  This is the same idea as the
> fscreate interface where a process can specify the label of a file about
> to be created.  At this time one envisioned user of this will be xinetd.
> It will be able to better label sockets for the actual services.  At
> this time all sockets take the label of the creating process, so all
> xinitd sockets would just be labeled the same.
> 
> I tested this by creating a tcp sender and listener.  The sender was
> able to write to this new proc file and then create sockets with the
> specified label.  I am able to be sure the new label was used since the
> avc denial messages kicked out by the kernel included both the new
> security permission setsockcreate and all the socket denials were for
> the new label, not the label of the running process.
> 
> I would like to propose this for 2.6.18

/proc/self/attr/keycreate is in -mm, so this patch won't apply relative
to it.  Permission definition also has to be regenerated relative to the
keycreate refpolicy patch, as that took the same permission slot.

> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
>  fs/proc/base.c                               |    6 ++++++
>  security/selinux/hooks.c                     |   20 ++++++++++++++++----
>  security/selinux/include/av_perm_to_string.h |    1 +
>  security/selinux/include/av_permissions.h    |    1 +
>  security/selinux/include/objsec.h            |    1 +
>  5 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 6cc77dc..4f9bf8f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -121,6 +121,7 @@ #ifdef CONFIG_SECURITY
>  	PROC_TGID_ATTR_PREV,
>  	PROC_TGID_ATTR_EXEC,
>  	PROC_TGID_ATTR_FSCREATE,
> +	PROC_TGID_ATTR_SOCKCREATE,
>  #endif
>  #ifdef CONFIG_AUDITSYSCALL
>  	PROC_TGID_LOGINUID,
> @@ -162,6 +163,7 @@ #ifdef CONFIG_SECURITY
>  	PROC_TID_ATTR_PREV,
>  	PROC_TID_ATTR_EXEC,
>  	PROC_TID_ATTR_FSCREATE,
> +	PROC_TID_ATTR_SOCKCREATE,
>  #endif
>  #ifdef CONFIG_AUDITSYSCALL
>  	PROC_TID_LOGINUID,
> @@ -275,6 +277,7 @@ static struct pid_entry tgid_attr_stuff[
>  	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
>  	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
>  	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TGID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
>  	{0,0,NULL,0}
>  };
>  static struct pid_entry tid_attr_stuff[] = {
> @@ -282,6 +285,7 @@ static struct pid_entry tid_attr_stuff[]
>  	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
>  	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
>  	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TID_ATTR_SOCKCREATE, "sockcreate", S_IFREG|S_IRUGO|S_IWUGO),
>  	{0,0,NULL,0}
>  };
>  #endif
> @@ -1800,6 +1804,8 @@ #ifdef CONFIG_SECURITY
>  		case PROC_TGID_ATTR_EXEC:
>  		case PROC_TID_ATTR_FSCREATE:
>  		case PROC_TGID_ATTR_FSCREATE:
> +		case PROC_TID_ATTR_SOCKCREATE:
> +		case PROC_TGID_ATTR_SOCKCREATE:
>  			inode->i_fop = &proc_pid_attr_operations;
>  			break;
>  #endif
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 90b4cdc..33e035c 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1518,8 +1518,9 @@ static int selinux_bprm_set_security(str
>  	/* Default to the current task SID. */
>  	bsec->sid = tsec->sid;
>  
> -	/* Reset create SID on execve. */
> +	/* Reset create and sockcreate SID on execve. */
>  	tsec->create_sid = 0;
> +	tsec->sockcreate_sid = 0;
>  
>  	if (tsec->exec_sid) {
>  		newsid = tsec->exec_sid;
> @@ -2571,9 +2572,10 @@ static int selinux_task_alloc_security(s
>  	tsec2->osid = tsec1->osid;
>  	tsec2->sid = tsec1->sid;
>  
> -	/* Retain the exec and create SIDs across fork */
> +	/* Retain the exec, create, and sock SIDs across fork */
>  	tsec2->exec_sid = tsec1->exec_sid;
>  	tsec2->create_sid = tsec1->create_sid;
> +	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
>  
>  	/* Retain ptracer SID across fork, if any.
>  	   This will be reset by the ptrace hook upon any
> @@ -2913,12 +2915,14 @@ static int selinux_socket_create(int fam
>  {
>  	int err = 0;
>  	struct task_security_struct *tsec;
> +	u32 newsid;
>  
>  	if (kern)
>  		goto out;
>  
>  	tsec = current->security;
> -	err = avc_has_perm(tsec->sid, tsec->sid,
> +	newsid = tsec->sockcreate_sid ? : tsec->sid;
> +	err = avc_has_perm(tsec->sid, newsid,
>  			   socket_type_to_security_class(family, type,
>  			   protocol), SOCKET__CREATE, NULL);
>  
> @@ -2931,12 +2935,14 @@ static void selinux_socket_post_create(s
>  {
>  	struct inode_security_struct *isec;
>  	struct task_security_struct *tsec;
> +	u32 newsid;
>  
>  	isec = SOCK_INODE(sock)->i_security;
>  
>  	tsec = current->security;
> +	newsid = tsec->sockcreate_sid ? : tsec->sid;
>  	isec->sclass = socket_type_to_security_class(family, type, protocol);
> -	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
> +	isec->sid = kern ? SECINITSID_KERNEL : newsid;
>  	isec->initialized = 1;
>  
>  	return;
> @@ -4114,6 +4120,8 @@ static int selinux_getprocattr(struct ta
>  		sid = tsec->exec_sid;
>  	else if (!strcmp(name, "fscreate"))
>  		sid = tsec->create_sid;
> +	else if (!strcmp(name, "sockcreate"))
> +		sid = tsec->sockcreate_sid;
>  	else
>  		return -EINVAL;
>  
> @@ -4146,6 +4154,8 @@ static int selinux_setprocattr(struct ta
>  		error = task_has_perm(current, p, PROCESS__SETEXEC);
>  	else if (!strcmp(name, "fscreate"))
>  		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
> +	else if (!strcmp(name, "sockcreate"))
> +		error = task_has_perm(current, p, PROCESS__SETSOCKCREATE);
>  	else if (!strcmp(name, "current"))
>  		error = task_has_perm(current, p, PROCESS__SETCURRENT);
>  	else
> @@ -4175,6 +4185,8 @@ static int selinux_setprocattr(struct ta
>  		tsec->exec_sid = sid;
>  	else if (!strcmp(name, "fscreate"))
>  		tsec->create_sid = sid;
> +	else if (!strcmp(name, "sockcreate"))
> +		tsec->sockcreate_sid = sid;
>  	else if (!strcmp(name, "current")) {
>  		struct av_decision avd;
>  
> diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
> index 591e98d..ce3a55d 100644
> --- a/security/selinux/include/av_perm_to_string.h
> +++ b/security/selinux/include/av_perm_to_string.h
> @@ -63,6 +63,7 @@
>     S_(SECCLASS_PROCESS, PROCESS__GETATTR, "getattr")
>     S_(SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec")
>     S_(SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate")
> +   S_(SECCLASS_PROCESS, PROCESS__SETSOCKCREATE, "setsockcreate")
>     S_(SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure")
>     S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
>     S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
> diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
> index d7f02ed..2a9a9b3 100644
> --- a/security/selinux/include/av_permissions.h
> +++ b/security/selinux/include/av_permissions.h
> @@ -467,6 +467,7 @@ #define PROCESS__SETCURRENT             
>  #define PROCESS__EXECMEM                          0x02000000UL
>  #define PROCESS__EXECSTACK                        0x04000000UL
>  #define PROCESS__EXECHEAP                         0x08000000UL
> +#define PROCESS__SETSOCKCREATE                    0x10000000UL
>  
>  #define IPC__CREATE                               0x00000001UL
>  #define IPC__DESTROY                              0x00000002UL
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 54c0307..1873451 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -32,6 +32,7 @@ struct task_security_struct {
>  	u32 sid;             /* current SID */
>  	u32 exec_sid;        /* exec SID */
>  	u32 create_sid;      /* fscreate SID */
> +	u32 sockcreate_sid;  /* fscreate SID */
>  	u32 ptrace_sid;      /* SID of ptrace parent */
>  };
>  
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
