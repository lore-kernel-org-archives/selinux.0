Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5A3OYm1016349
	for <selinux@tycho.nsa.gov>; Tue, 9 Jun 2009 23:24:34 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n5A3OOD8010178
	for <selinux@tycho.nsa.gov>; Wed, 10 Jun 2009 03:24:24 GMT
Message-ID: <4A2F275E.2090309@schaufler-ca.com>
Date: Tue, 09 Jun 2009 20:24:14 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Linux Containers <containers@lists.osdl.org>,
        Oren Laadan <orenl@cs.columbia.edu>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 09/10] cr: restore LSM credentials
References: <20090610014412.GA5628@us.ibm.com> <20090610014637.GH5658@us.ibm.com>
In-Reply-To: <20090610014637.GH5658@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Checkpoint and restore task and ipc struct ->security info.
> (files->f_security yet to be done).
>
> LSM contexts (a string representation of obj->security) are
> checkpointed as shared objects before any object referencing
> it.  The object's checkpoint header struct has a reference
> (h->sec_ref) to the shared object.  A NULL ->security is indicated
> by h->sec_ref = -1.
>
> At checkpoint time, for each obj->security to be checkpointed,
> the LSM will be asked (once) to convert it to a string, in memory
> which the checkpoint subsystem will kfree.  At restart time,
> the LSM will first return some meaningful token given the
> checkpointed string.  That token will be passed to per-object-type
> restore functions (task_restore_context(), shm_restore_security(),
> etc) where the LSM can determine based on the object type, the
> caller, and the token, whether to allow the object restore, and
> what value to actually assign to ->security.  In smack, the
> token is the actual imported label.  In SELinux, it is a temporary
> pointer to the sid which the checkpointed context referred to.
>
> In smack, the checkpointed labels are used for both tasks and
> ipc objects so long as the task calling sys_restart() has
> CAP_MAC_ADMIN.  Otherwise, if the checkpointed label is different
> from current_security(), -EPERM is returned.
>
> The basics of SELinux support are there (enough to demonstrate working
> c/r with SELinux enforcing), but there will need to be new object
> permissions for restore, so the precise nature of those needs to be
> discussed.  For instance, do we want to define process:restore
> and ipc_msg_msg:restore, in which case
>         allow root_t user_t:process restore
> would mean that root_t may restart a task and label it user_t?
>
> Since we are potentially skipping several allowed domain transitions
> (resulting in an illegal short-cut domain transition or type creation),
> I have a fear that the only sane way to proceed would be to have
> one all-powerful domain, checkpoint_restore_t, which can effectively
> transition to any domain it wants to by (ab)using the checkpoint
> image.
>
> Or, perhaps we can define intermediate domains...  So if we want
> user_t to be able to restart a server of type X_t, then we create
> a X_restore_t type, allow user_t to transition to it using a
> program which does sys_restart(), which in turn may transition to
> X_t?
>
> Obviously this needs discussion.
>
> Tomoyo has not been updated or tested.  Given its path-based
> domain name model, I'm not sure what the tomoyo maintainers
> would prefer - that the restart program be reflected in the
> domain name, or that the original domain name be restored.
>
> This is the first posting of this patch.  There are testcases
> in git://git.sr71.net/~hallyn/cr_tests.git , in particular
> under (the slightly mis-named) cr_tests/userns/ directory.
> All pass fine with all LSMS (except Tomoyo, not tested).
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
>  checkpoint/objhash.c           |   56 ++++++++++++
>  include/linux/checkpoint_hdr.h |   15 +++
>  include/linux/security.h       |  105 +++++++++++++++++++++
>  ipc/checkpoint.c               |   19 +++--
>  ipc/checkpoint_msg.c           |   30 ++++++-
>  ipc/checkpoint_sem.c           |   12 +++-
>  ipc/checkpoint_shm.c           |   12 +++-
>  ipc/util.h                     |    3 +-
>  kernel/cred.c                  |   29 ++++++-
>  security/capability.c          |   47 ++++++++++
>  security/security.c            |   39 ++++++++
>  security/selinux/hooks.c       |  196 ++++++++++++++++++++++++++++++++++++++++
>  security/smack/smack_lsm.c     |  135 +++++++++++++++++++++++++++
>  13 files changed, 686 insertions(+), 12 deletions(-)
>   

> ...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 98b3195..dfc0f7a 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1608,6 +1608,32 @@ static int smack_msg_msg_alloc_security(struct msg_msg *msg)
>  }
>  
>  /**
> + * smack_msg_msg_restore_security - Set the security blob for msg_msg
> + * @msg: the object
> + * @stored: the checkpointed label
> + *
> + * Returns 0
>   

Comment ought to reflect the actual behavior.

> + */
> +static int smack_msg_msg_restore_security(struct msg_msg *msg,
> +					void *stored)
> +{
> +	struct kern_ipc_perm *isp = &sma->sem_perm;
> +	char *str = smk_import(stored, 0);
>   

To be really nit-picky, I'd prefer a variable name that indicates
it's a Smack label rather than just any old character string. Perhaps

    char *smack = smk_import(stored, 0);

> +
> +	if (str == NULL)
> +		return -EINVAL;
> +
> +	msg->security = current_security();
> +	if (current_security() != str) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		msg->security = str;
> +	}
> +	return 0;
> +	return 0;
>   

Returning once is sufficient.

> +}
> +
> +/**
>   * smack_msg_msg_free_security - Clear the security blob for msg_msg
>   * @msg: the object
>   *
> @@ -1644,6 +1670,30 @@ static int smack_shm_alloc_security(struct shmid_kernel *shp)
>  }
>  
>  /**
> + * smack_shm_restore_security - retore the security blob for shm
> + * @shp: the object
> + * @stored: the checkpointed label
> + *
> + * Returns 0
>   

Previous comment comment applies here as well.

> + */
> +static int smack_shm_restore_security(struct shmid_kernel *shp, void *stored)
> +{
> +	struct kern_ipc_perm *isp = &shp->shm_perm;
> +	char *str = smk_import(stored, 0);
> +
> +	if (str == NULL)
> +		return -EINVAL;
> +
> +	isp->security = current_security();
> +	if (current_security() != str) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		isp->security = str;
> +	}
> +	return 0;
> +}
> +
> +/**
>   * smack_shm_free_security - Clear the security blob for shm
>   * @shp: the object
>   *
> @@ -1753,6 +1803,31 @@ static int smack_sem_alloc_security(struct sem_array *sma)
>  }
>  
>  /**
> + * smack_sem_restore_security - Set the security blob for sem
> + * @sma: the object
> + * @stored: the label stored in checkpoint image
> + *
> + * Returns 0
>   

Or an error if the label is bad, as above.

> + */
> +static int smack_sem_restore_security(struct sem_array *sma,
> +				void *stored)
> +{
> +	struct kern_ipc_perm *isp = &sma->sem_perm;
> +	char *str = smk_import(stored, 0);
> +
> +	if (str == NULL)
> +		return -EINVAL;
> +
> +	isp->security = current_security();
> +	if (current_security() != str) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		isp->security = str;
> +	}
> +	return 0;
> +}
> +
> +/**
>   * smack_sem_free_security - Clear the security blob for sem
>   * @sma: the object
>   *
> @@ -1857,6 +1932,31 @@ static int smack_msg_queue_alloc_security(struct msg_queue *msq)
>  }
>  
>  /**
> + * smack_msg_restore_security - Set the security blob for msg
> + * @msq: the object
> + * @stored: the stored label
> + *
> + * Returns 0
>   

And again ...

> + */
> +static int smack_msg_queue_restore_security(struct msg_queue *msq,
> +					void *stored)
> +{
> +	struct kern_ipc_perm *kisp = &msq->q_perm;
> +	char *str = smk_import(stored, 0);
> +
> +	if (str == NULL)
> +		return -EINVAL;
> +
> +	kisp->security = current_security();
> +	if (current_security() != str) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		kisp->security = str;
> +	}
> +	return 0;
> +}
> +
> +/**
>   * smack_msg_free_security - Clear the security blob for msg
>   * @msq: the object
>   *
> @@ -2823,6 +2923,33 @@ static void smack_release_secctx(char *secdata, u32 seclen)
>  {
>  }
>  
> +/* checkpoint/restore hooks */
> +static char *smack_context_to_str(void *security)
> +{
> +	return kstrdup((char *)security, GFP_KERNEL);
> +}
> +
> +static void *smack_context_from_str(char *str)
> +{
> +	char *newsmack = smk_import(str, 0);
> +
> +	if (newsmack == NULL)
> +		return ERR_PTR(-EINVAL);
> +
> +	return newsmack;
> +}
> +
> +static int smack_task_restore_context(struct cred *cred, void *stored,
> +					void *f_security)
> +{
> +	if (cred->security != stored) {
> +		if (!capable(CAP_MAC_ADMIN))
> +			return -EPERM;
> +		cred->security = stored;
> +	}
> +	return 0;
> +}
> +
>  struct security_operations smack_ops = {
>  	.name =				"smack",
>  
> @@ -2902,9 +3029,11 @@ struct security_operations smack_ops = {
>  	.ipc_getsecid =			smack_ipc_getsecid,
>  
>  	.msg_msg_alloc_security = 	smack_msg_msg_alloc_security,
> +	.msg_msg_restore_security = 	smack_msg_msg_restore_security,
>  	.msg_msg_free_security = 	smack_msg_msg_free_security,
>  
>  	.msg_queue_alloc_security = 	smack_msg_queue_alloc_security,
> +	.msg_queue_restore_security = 	smack_msg_queue_restore_security,
>  	.msg_queue_free_security = 	smack_msg_queue_free_security,
>  	.msg_queue_associate = 		smack_msg_queue_associate,
>  	.msg_queue_msgctl = 		smack_msg_queue_msgctl,
> @@ -2912,12 +3041,14 @@ struct security_operations smack_ops = {
>  	.msg_queue_msgrcv = 		smack_msg_queue_msgrcv,
>  
>  	.shm_alloc_security = 		smack_shm_alloc_security,
> +	.shm_restore_security = 	smack_shm_restore_security,
>  	.shm_free_security = 		smack_shm_free_security,
>  	.shm_associate = 		smack_shm_associate,
>  	.shm_shmctl = 			smack_shm_shmctl,
>  	.shm_shmat = 			smack_shm_shmat,
>  
>  	.sem_alloc_security = 		smack_sem_alloc_security,
> +	.sem_restore_security = 	smack_sem_restore_security,
>  	.sem_free_security = 		smack_sem_free_security,
>  	.sem_associate = 		smack_sem_associate,
>  	.sem_semctl = 			smack_sem_semctl,
> @@ -2964,6 +3095,10 @@ struct security_operations smack_ops = {
>  	.secid_to_secctx = 		smack_secid_to_secctx,
>  	.secctx_to_secid = 		smack_secctx_to_secid,
>  	.release_secctx = 		smack_release_secctx,
> +
> +	.context_to_str =		smack_context_to_str,
> +	.context_from_str =		smack_context_from_str,
> +	.task_restore_context =		smack_task_restore_context,
>  };
>  
>  
>   

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
