Subject: Re: [PATCH] selinux: add /proc/pid/attr/keycreate to convey key
	creation context
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        dhowells@redhat.com
In-Reply-To: <1149792912.14467.24.camel@moss-tarheels.epoch.ncsc.mil>
References: <1149792912.14467.24.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 12:18:51 -0400
Message-Id: <1150129131.8086.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-06-08 at 14:55 -0400, Michael LeMay wrote:
> David (and the rest of the list),

Please cc James and me as well.

> This patch adds the /proc/<pid>/attr/keycreate entry that Steve discussed earlier.
> It's very simple, but please check it out and make sure it does what you think it
> should.  Essentially, the intended usage of this entry is to have all of the
> various login programs (util-linux/login, ssh, gdm, ...) extract a user's default
> context and store it in this entry before invoking setuid to initiate their session.
> Then, when setuid eventually invokes alloc_uid -> keyring_alloc -> selinux_key_alloc, 
> the default keyrings will be assigned the default context for the user, rather than
> the context of the login program.  The entry could potentially be used for other
> purposes, since it is checked every time the security structure for a new key is
> allocated, but I can't think of any interesting examples right now.
> 
> Of course, this change sends ripples through quite a few other systems, which is why
> it's taken me so long to get this patch out.  First, I had to add a "setkeycreate"
> permission to the "process" security class in serefpolicy.  Then, I had to augment
> the SELinux library with a "setkeycreatecon" operation, which is analogous to
> "setfscreatecon" (it seems those functions requires some refactoring, but I haven't
> done anything yet).
> 
> Then, I concentrated on GDM, login, and SSH, to make sure they're compatible with the
> new entry.  Surprisingly, SSH sets its execution context early enough that this patch
> isn't necessary.  However, the other two programs don't, so I had to add a simple invocation
> to each of them to set the entry before performing setuid.
> 
> I'll send the other patches along after we discuss this one.
> 
> ---<snip>---
> From: Michael LeMay <mdlemay@epoch.ncsc.mil>
> 
> Add a /proc/<pid>/attr/keycreate entry that stores the appropriate
> context for newly-created keys.  Modify the selinux_key_alloc
> hook to make use of the new entry.  Update the flask headers to
> include a new "setkeycreate" permission for processes.  Update the
> documentation to reflect these changes.
> 
> Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
> 
> ---
> 
>  Documentation/keys.txt                       |    2 +-
>  fs/proc/base.c                               |   22 ++++++++++++++--------
>  security/selinux/hooks.c                     |   11 ++++++++++-
>  security/selinux/include/av_perm_to_string.h |    1 +
>  security/selinux/include/av_permissions.h    |    1 +
>  security/selinux/include/objsec.h            |    1 +
>  6 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt linux-2.6.17-rc6-mm1/Documentation/keys.txt
> --- linux-2.6.17-rc6-mm1.orig/Documentation/keys.txt	2006-06-08 09:41:42.000000000 -0400
> +++ linux-2.6.17-rc6-mm1/Documentation/keys.txt	2006-06-08 14:46:07.000000000 -0400
> @@ -250,7 +250,7 @@ The default keyrings are handled differe
>  intuitive:
>  
>   (*) The user and user session keyrings that are created when the user logs in
> -     are currently labeled with the context of the login manager.
> +     are labeled with the user's default context.

Only if the login manager is instrumented to use the new API, so you
likely need to note this fact.

>  
>   (*) The keyrings associated with new threads are each labeled with the context
>       of their associated thread, and both session and process keyrings are
> diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/fs/proc/base.c linux-2.6.17-rc6-mm1/fs/proc/base.c
> --- linux-2.6.17-rc6-mm1.orig/fs/proc/base.c	2006-06-08 09:41:47.000000000 -0400
> +++ linux-2.6.17-rc6-mm1/fs/proc/base.c	2006-06-08 10:14:50.000000000 -0400
> @@ -285,17 +287,19 @@ static struct pid_entry tid_base_stuff[]
>  
>  #ifdef CONFIG_SECURITY
>  static struct pid_entry tgid_attr_stuff[] = {
> -	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
> -	E(PROC_TGID_ATTR_PREV,     "prev",     S_IFREG|S_IRUGO),
> -	E(PROC_TGID_ATTR_EXEC,     "exec",     S_IFREG|S_IRUGO|S_IWUGO),
> -	E(PROC_TGID_ATTR_FSCREATE, "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TGID_ATTR_CURRENT,   "current",   S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TGID_ATTR_PREV,      "prev",      S_IFREG|S_IRUGO),
> +	E(PROC_TGID_ATTR_EXEC,      "exec",      S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TGID_ATTR_FSCREATE,  "fscreate",  S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TGID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
>  	{0,0,NULL,0}

Not sure why you are changing all of the other lines as well in this
patch.

>  };
>  static struct pid_entry tid_attr_stuff[] = {
> -	E(PROC_TID_ATTR_CURRENT,   "current",  S_IFREG|S_IRUGO|S_IWUGO),
> -	E(PROC_TID_ATTR_PREV,      "prev",     S_IFREG|S_IRUGO),
> -	E(PROC_TID_ATTR_EXEC,      "exec",     S_IFREG|S_IRUGO|S_IWUGO),
> -	E(PROC_TID_ATTR_FSCREATE,  "fscreate", S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TID_ATTR_CURRENT,   "current",   S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TID_ATTR_PREV,      "prev",      S_IFREG|S_IRUGO),
> +	E(PROC_TID_ATTR_EXEC,      "exec",      S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TID_ATTR_FSCREATE,  "fscreate",  S_IFREG|S_IRUGO|S_IWUGO),
> +	E(PROC_TID_ATTR_KEYCREATE, "keycreate", S_IFREG|S_IRUGO|S_IWUGO),
>  	{0,0,NULL,0}

Likewise.

> diff -uprN -X linux-2.6.17-rc6-mm1/Documentation/dontdiff linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c linux-2.6.17-rc6-mm1/security/selinux/hooks.c
> --- linux-2.6.17-rc6-mm1.orig/security/selinux/hooks.c	2006-06-08 09:41:50.000000000 -0400
> +++ linux-2.6.17-rc6-mm1/security/selinux/hooks.c	2006-06-08 10:14:50.000000000 -0400
> @@ -4177,6 +4179,8 @@ static int selinux_setprocattr(struct ta
>  		error = task_has_perm(current, p, PROCESS__SETEXEC);
>  	else if (!strcmp(name, "fscreate"))
>  		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
> +	else if (!strcmp(name, "keycreate"))
> +		error = task_has_perm(current, p, PROCESS__SETKEYCREATE);
>  	else if (!strcmp(name, "current"))
>  		error = task_has_perm(current, p, PROCESS__SETCURRENT);
>  	else
> @@ -4206,6 +4210,8 @@ static int selinux_setprocattr(struct ta
>  		tsec->exec_sid = sid;
>  	else if (!strcmp(name, "fscreate"))
>  		tsec->create_sid = sid;
> +	else if (!strcmp(name, "keycreate"))
> +		tsec->keycreate_sid = sid;
>  	else if (!strcmp(name, "current")) {
>  		struct av_decision avd;
>  
> @@ -4269,7 +4275,10 @@ static int selinux_key_alloc(struct key 
>  		return -ENOMEM;
>  
>  	ksec->obj = k;
> -	ksec->sid = tsec->sid;
> +	if (tsec->keycreate_sid)
> +		ksec->sid = tsec->keycreate_sid;
> +	else
> +		ksec->sid = tsec->sid;
>  	k->security = ksec;
>  
>  	return 0;

The setkeycreate permission check only checks between the task setting
the attribute and the target task (which ends up being a task->self
check since we only allow a task to set its own attributes).
At some point, you need a permission check between the allocating task
SID and the keycreate_sid; otherwise, a task authorized for setkeycreate
can set arbitrary SIDs on its keys.  For file creation, may_create
applies a file create check between the creating task SID and the SID to
be applied to the file.  For execve, selinux_bprm_set_security applies a
process transition check between the old and new task SIDs, and for
setcon, setprocattr directly applies a dyntransition check between the
SID pair.  You need a similar check in selinux_key_alloc, along with a
corresponding new key permission for creation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
