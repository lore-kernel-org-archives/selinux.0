Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1M4vJiL024815
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 23:57:20 -0500
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m1M4vJKi000712
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 04:57:19 GMT
Date: Thu, 21 Feb 2008 20:57:18 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 07/37] Security: De-embed task security record from task and use refcounting
To: David Howells <dhowells@redhat.com>, Trond.Myklebust@netapp.com,
        chuck.lever@oracle.com, casey@schaufler-ca.com
Cc: nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, dhowells@redhat.com
In-Reply-To: <20080220160635.4715.81967.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <847728.57737.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Remove the temporarily embedded task security record from task_struct. 
> Instead
> it is made to dangle from the task_struct::sec and task_struct::act_as
> pointers
> with references counted for each.
> 
> ...
> 
> The LSM hooks for dealing with task security are modified to deal with the
> task
> security struct directly rather than going via the task_struct as appopriate.
> 
> ...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index a49d94f..dbce607 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -957,9 +957,22 @@ static int smack_task_alloc_security(struct task_struct
> *tsk)
>   * points to an immutable list. The blobs never go away.
>   * There is no leak here.
>   */
> -static void smack_task_free_security(struct task_struct *task)
> +static void smack_task_free_security(struct task_security *sec)
>  {
> -	task->sec->security = NULL;
> +	sec->security = NULL;
> +}
> +
> +/**
> + * task_dup_security - Duplicate task security
> + * @p points to the task_security struct that has been copied
> + *
> + * Duplicate the security structure currently attached to the p->security
> field
> + * and attach back to p->security (the pointer itself was copied, so there's
> + * nothing to be done here).
> + */
> +static int smack_task_dup_security(struct task_security *sec)
> +{
> +	return 0;
>  }

Thank you for adding this hook. The comment is helpful.
  
>  /**
> @@ -2276,17 +2289,17 @@ static int smack_inet_conn_request(struct sock *sk,
> struct sk_buff *skb,
>  /**
>   * smack_key_alloc - Set the key security blob
>   * @key: object
> - * @tsk: the task associated with the key
> + * @context: the task security associated with the key
>   * @flags: unused
>   *
>   * No allocation required
>   *
>   * Returns 0
>   */
> -static int smack_key_alloc(struct key *key, struct task_struct *tsk,
> +static int smack_key_alloc(struct key *key, struct task_security *context,
>  			   unsigned long flags)
>  {
> -	key->security = tsk->act_as->security;
> +	key->security = context->security;
>  	return 0;
>  }
>  
> @@ -2304,14 +2317,14 @@ static void smack_key_free(struct key *key)
>  /*
>   * smack_key_permission - Smack access on a key
>   * @key_ref: gets to the object
> - * @context: task involved
> + * @context: task security involved
>   * @perm: unused
>   *
>   * Return 0 if the task has read and write to the object,
>   * an error code otherwise
>   */
>  static int smack_key_permission(key_ref_t key_ref,
> -				struct task_struct *context, key_perm_t perm)
> +				struct task_security *context, key_perm_t perm)
>  {
>  	struct key *keyp;
>  
> @@ -2327,10 +2340,10 @@ static int smack_key_permission(key_ref_t key_ref,
>  	/*
>  	 * This should not occur
>  	 */
> -	if (context->act_as->security == NULL)
> +	if (context->security == NULL)
>  		return -EACCES;
>  
> -	return smk_access(context->act_as->security, keyp->security,
> +	return smk_access(context->security, keyp->security,
>  			  MAY_READWRITE);
>  }
>  #endif /* CONFIG_KEYS */
> @@ -2430,6 +2443,7 @@ static struct security_operations smack_ops = {
>  
>  	.task_alloc_security = 		smack_task_alloc_security,
>  	.task_free_security = 		smack_task_free_security,
> +	.task_dup_security =		smack_task_dup_security,
>  	.task_post_setuid =		cap_task_post_setuid,
>  	.task_setpgid = 		smack_task_setpgid,
>  	.task_getpgid = 		smack_task_getpgid,

No objections from the Smack side. Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
