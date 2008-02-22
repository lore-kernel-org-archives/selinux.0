Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1M56DlU025560
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 00:06:13 -0500
Received: from web36602.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1M56CKi002582
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 05:06:12 GMT
Date: Thu, 21 Feb 2008 21:06:12 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 09/37] Security: Allow kernel services to override LSM settings for task actions
To: David Howells <dhowells@redhat.com>, Trond.Myklebust@netapp.com,
        chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
In-Reply-To: <20080220160646.4715.7268.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <55722.57422.qm@web36602.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Allow kernel services to override LSM settings appropriate to the actions
> performed by a task by duplicating a security record, modifying it and then
> using task_struct::act_as to point to it when performing operations on behalf
> of a task.
> 
> This is used, for example, by CacheFiles which has to transparently access
> the
> cache on behalf of a process that thinks it is doing, say, NFS accesses with
> a
> potentially inappropriate (with respect to accessing the cache) set of
> security data.
> 
> This patch provides two LSM hooks for modifying a task security record:
> 
>  (*) security_kernel_act_as() which allows modification of the security datum
>      with which a task acts on other objects (most notably files).
> 
>  (*) security_create_files_as() which allows modification of the security
>      datum that is used to initialise the security data on a file that a task
>      creates.
> 
> ...

> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -976,6 +976,36 @@ static int smack_task_dup_security(struct task_security
> *sec)
>  }
>  
>  /**
> + * smack_task_kernel_act_as - Set the subjective context in a security
> record
> + * @p points to the task that nominated @secid.
> + * @sec points to the task security record to be modified.
> + * @secid specifies the security ID to be set
> + *
> + * Set the security data for a kernel service.
> + */
> +static int smack_task_kernel_act_as(struct task_struct *p,
> +				    struct task_security *sec, u32 secid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +/**
> + * smack_task_create_files_as - Set the file creation label in a security
> record
> + * @p points to the task that nominated @inode.
> + * @sec points to the task security record to be modified.
> + * @inode points to the inode to use as a reference.
> + *
> + * Set the file creation context in a security record to the same as the
> + * objective context of the specified inode
> + */
> +static int smack_task_create_files_as(struct task_struct *p,
> +				      struct task_security *sec,
> +				      struct inode *inode)
> +{
> +	return -ENOTSUPP;
> +}

Hum. ENOTSUPP is not not very satisfying, is it? I will have to
think on this a bit.

> +
> +/**
>   * smack_task_setpgid - Smack check on setting pgid
>   * @p: the task object
>   * @pgid: unused
> @@ -2444,6 +2474,8 @@ static struct security_operations smack_ops = {
>  	.task_alloc_security = 		smack_task_alloc_security,
>  	.task_free_security = 		smack_task_free_security,
>  	.task_dup_security =		smack_task_dup_security,
> +	.task_kernel_act_as =		smack_task_kernel_act_as,
> +	.task_create_files_as =		smack_task_create_files_as,
>  	.task_post_setuid =		cap_task_post_setuid,
>  	.task_setpgid = 		smack_task_setpgid,
>  	.task_getpgid = 		smack_task_getpgid,

Except for the fact that the hooks don't do anything this
looks fine. I'm not sure that I would want these hooks to
do anything, it requires additional thought to determine if
there is a good behavior for them.

Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
