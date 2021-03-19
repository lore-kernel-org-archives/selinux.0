Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3057C433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74A664EEE
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 13:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSNhG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 09:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41123 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229866AbhCSNgm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 09:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616161002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6V3yNWMZ1aDj0B0PeA0TJCqd/uZv8Y6AZM0tzj5XX0U=;
        b=ZM95EM+Kj5AYwwmsUV7SLlh4zB4+kgU3rV1g0xdnrKW5ka2cHOdhDqU33jcdoAJHDX7BQI
        aSADrX5isYAaSr3Ww51nQPBTpG2NyBHNJ1muHBgn286AL9V8v6MBUWWNqULTtp99KTvZaU
        rGHWD/Jeg+3jAAxstX7GFTx3YEMVVYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-9Ib2fQtsMTeta-tQGxixBA-1; Fri, 19 Mar 2021 09:36:38 -0400
X-MC-Unique: 9Ib2fQtsMTeta-tQGxixBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26964190A7A1;
        Fri, 19 Mar 2021 13:36:37 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8201B19C79;
        Fri, 19 Mar 2021 13:36:28 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:36:25 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH v2 2/3] selinux: clarify task subjective and objective
 credentials
Message-ID: <20210319133625.GD2781019@madcap2.tricolour.ca>
References: <161609713992.55424.6906498317563652734.stgit@olly>
 <161610014979.55424.673449459081578214.stgit@olly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161610014979.55424.673449459081578214.stgit@olly>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-03-18 16:42, Paul Moore wrote:
> SELinux has a function, task_sid(), which returns the task's
> objective credentials, but unfortunately is used in a few places
> where the subjective task credentials should be used.  Most notably
> in the new security_task_getsecid_subj() LSM hook.
> 
> This patch fixes this and attempts to make things more obvious by
> introducing a new function, task_sid_subj(), and renaming the
> existing task_sid() function to task_sid_obj().
> 
> This patch also adds an interesting function in task_sid_binder().
> The task_sid_binder() function has a comment which hopefully
> describes it's reason for being, but it basically boils down to the
> simple fact that we can't safely access another task's subjective
> credentials so in the case of binder we need to stick with the
> objective credentials regardless.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  security/selinux/hooks.c |  112 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 73 insertions(+), 39 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 24ca545c6e1b..901a3ce453f1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -229,10 +229,23 @@ static inline u32 cred_sid(const struct cred *cred)
>  	return tsec->sid;
>  }
>  
> +/*
> + * get the subjective security ID of a task
> + */
> +static inline u32 task_sid_subj(const struct task_struct *task)
> +{
> +	u32 sid;
> +
> +	rcu_read_lock();
> +	sid = cred_sid(rcu_dereference(task->cred));
> +	rcu_read_unlock();
> +	return sid;
> +}
> +
>  /*
>   * get the objective security ID of a task
>   */
> -static inline u32 task_sid(const struct task_struct *task)
> +static inline u32 task_sid_obj(const struct task_struct *task)
>  {
>  	u32 sid;
>  
> @@ -242,6 +255,29 @@ static inline u32 task_sid(const struct task_struct *task)
>  	return sid;
>  }
>  
> +/*
> + * get the security ID of a task for use with binder
> + */
> +static inline u32 task_sid_binder(const struct task_struct *task)
> +{
> +	/*
> +	 * In many case where this function is used we should be using the
> +	 * task's subjective SID, but we can't reliably access the subjective
> +	 * creds of a task other than our own so we must use the objective
> +	 * creds/SID, which are safe to access.  The downside is that if a task
> +	 * is temporarily overriding it's creds it will not be reflected here;
> +	 * however, it isn't clear that binder would handle that case well
> +	 * anyway.
> +	 *
> +	 * If this ever changes and we can safely reference the subjective
> +	 * creds/SID of another task, this function will make it easier to
> +	 * identify the various places where we make use of the task SIDs in
> +	 * the binder code.  It is also likely that we will need to adjust
> +	 * the main drivers/android binder code as well.
> +	 */
> +	return task_sid_obj(task);
> +}
> +
>  static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
>  
>  /*
> @@ -2035,11 +2071,8 @@ static inline u32 open_file_to_av(struct file *file)
>  
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid = current_sid();
> -	u32 mgrsid = task_sid(mgr);
> -
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid_binder(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
>  
> @@ -2047,8 +2080,7 @@ static int selinux_binder_transaction(struct task_struct *from,
>  				      struct task_struct *to)
>  {
>  	u32 mysid = current_sid();
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> +	u32 fromsid = task_sid_binder(from);
>  	int rc;
>  
>  	if (mysid != fromsid) {
> @@ -2059,19 +2091,16 @@ static int selinux_binder_transaction(struct task_struct *from,
>  			return rc;
>  	}
>  
> -	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__CALL,
> -			    NULL);
> +	return avc_has_perm(&selinux_state, fromsid, task_sid_binder(to),
> +			    SECCLASS_BINDER, BINDER__CALL, NULL);
>  }
>  
>  static int selinux_binder_transfer_binder(struct task_struct *from,
>  					  struct task_struct *to)
>  {
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> -
>  	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
> +			    task_sid_binder(from), task_sid_binder(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
>  }
>  
> @@ -2079,7 +2108,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  					struct task_struct *to,
>  					struct file *file)
>  {
> -	u32 sid = task_sid(to);
> +	u32 sid = task_sid_binder(to);
>  	struct file_security_struct *fsec = selinux_file(file);
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct inode_security_struct *isec;
> @@ -2115,10 +2144,10 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  }
>  
>  static int selinux_ptrace_access_check(struct task_struct *child,
> -				     unsigned int mode)
> +				       unsigned int mode)
>  {
>  	u32 sid = current_sid();
> -	u32 csid = task_sid(child);
> +	u32 csid = task_sid_obj(child);
>  
>  	if (mode & PTRACE_MODE_READ)
>  		return avc_has_perm(&selinux_state,
> @@ -2131,15 +2160,15 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>  static int selinux_ptrace_traceme(struct task_struct *parent)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
> -			    PROCESS__PTRACE, NULL);
> +			    task_sid_subj(parent), task_sid_obj(current),
> +			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>  
>  static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(target), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
>  			    PROCESS__GETCAP, NULL);
>  }
>  
> @@ -2264,7 +2293,7 @@ static u32 ptrace_parent_sid(void)
>  	rcu_read_lock();
>  	tracer = ptrace_parent(current);
>  	if (tracer)
> -		sid = task_sid(tracer);
> +		sid = task_sid_obj(tracer);
>  	rcu_read_unlock();
>  
>  	return sid;
> @@ -3921,7 +3950,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  				       struct fown_struct *fown, int signum)
>  {
>  	struct file *file;
> -	u32 sid = task_sid(tsk);
> +	u32 sid = task_sid_obj(tsk);
>  	u32 perm;
>  	struct file_security_struct *fsec;
>  
> @@ -4140,47 +4169,52 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETPGID, NULL);
>  }
>  
>  static int selinux_task_getpgid(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETPGID, NULL);
>  }
>  
>  static int selinux_task_getsid(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSESSION, NULL);
>  }
>  
> -static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
> +static void selinux_task_getsecid_subj(struct task_struct *p, u32 *secid)
> +{
> +	*secid = task_sid_subj(p);
> +}
> +
> +static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
>  {
> -	*secid = task_sid(p);
> +	*secid = task_sid_obj(p);
>  }
>  
>  static int selinux_task_setnice(struct task_struct *p, int nice)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_setioprio(struct task_struct *p, int ioprio)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_getioprio(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
>  }
>  
> @@ -4211,7 +4245,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  	   upon context transitions.  See selinux_bprm_committing_creds. */
>  	if (old_rlim->rlim_max != new_rlim->rlim_max)
>  		return avc_has_perm(&selinux_state,
> -				    current_sid(), task_sid(p),
> +				    current_sid(), task_sid_obj(p),
>  				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
>  
>  	return 0;
> @@ -4220,21 +4254,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  static int selinux_task_setscheduler(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
>  static int selinux_task_getscheduler(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
>  }
>  
>  static int selinux_task_movememory(struct task_struct *p)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    current_sid(), task_sid(p), SECCLASS_PROCESS,
> +			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
>  }
>  
> @@ -4253,14 +4287,14 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  	else
>  		secid = cred_sid(cred);
>  	return avc_has_perm(&selinux_state,
> -			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
> +			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
>  }
>  
>  static void selinux_task_to_inode(struct task_struct *p,
>  				  struct inode *inode)
>  {
>  	struct inode_security_struct *isec = selinux_inode(inode);
> -	u32 sid = task_sid(p);
> +	u32 sid = task_sid_obj(p);
>  
>  	spin_lock(&isec->lock);
>  	isec->sclass = inode_mode_to_security_class(inode->i_mode);
> @@ -6153,7 +6187,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = task_sid(target);
> +	u32 sid = task_sid_subj(target);
>  	int rc;
>  
>  	isec = selinux_ipc(msq);
> @@ -7149,8 +7183,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
>  	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
>  	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
> -	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid),
> -	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid),
> +	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid_subj),
> +	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
>  	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
>  	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
>  	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

