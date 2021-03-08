Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5695C433DB
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 19:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DAF652AC
	for <selinux@archiver.kernel.org>; Mon,  8 Mar 2021 19:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHT0v (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhCHT0e (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Mar 2021 14:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615231593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjVBZ03JjRGL0VfbWh/n5AoZvSbTHOO/DXT1gI3vfJY=;
        b=ZKQnuuLnnoOvfW+ACNEDbBv0s+5YCqSppYt7ycyavMaAUd72uCHc5MlL7iKHhJcuQcZDnu
        UjBS6AAIvqnsgIBwmNbaZq7spjSLCMpXlUPstzUIXQPAPw2aKSMsP0qzfgerPEZg1y5KsU
        ofDCW/oP0jsHvAJDhHTOf0gC1PHFQss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-h6gKArTBPny3buj8Y4s2HQ-1; Mon, 08 Mar 2021 14:26:31 -0500
X-MC-Unique: h6gKArTBPny3buj8Y4s2HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F17A10866A5;
        Mon,  8 Mar 2021 19:26:30 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5891A5D9CD;
        Mon,  8 Mar 2021 19:26:22 +0000 (UTC)
Date:   Mon, 8 Mar 2021 14:26:19 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: [RFC PATCH 2/4] selinux: clarify task subjective and objective
 credentials
Message-ID: <20210308192619.GZ2015948@madcap2.tricolour.ca>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
 <161377735153.87807.7492842242100187888.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161377735153.87807.7492842242100187888.stgit@sifl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-02-19 18:29, Paul Moore wrote:
> SELinux has a function, task_sid(), which returns the task's
> objective credentials, but unfortunately is used in a few places
> where the subjective task credentials should be used.  Most notably
> in the new security_task_getsecid_subj() LSM hook.
> 
> This patch fixes this and attempts to make things more obvious by
> introducing a new function, task_sid_subj(), and renaming the
> existing task_sid() function to task_sid_obj().
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

FWIW Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  security/selinux/hooks.c |   85 +++++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 36 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f311541c4972e..1c53000d28e37 100644
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
> @@ -2034,11 +2047,8 @@ static inline u32 open_file_to_av(struct file *file)
>  
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid = current_sid();
> -	u32 mgrsid = task_sid(mgr);
> -
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid_obj(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
>  
> @@ -2046,8 +2056,8 @@ static int selinux_binder_transaction(struct task_struct *from,
>  				      struct task_struct *to)
>  {
>  	u32 mysid = current_sid();
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> +	u32 fromsid = task_sid_subj(from);
> +	u32 tosid = task_sid_subj(to);
>  	int rc;
>  
>  	if (mysid != fromsid) {
> @@ -2066,11 +2076,9 @@ static int selinux_binder_transaction(struct task_struct *from,
>  static int selinux_binder_transfer_binder(struct task_struct *from,
>  					  struct task_struct *to)
>  {
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> -
>  	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
> +			    task_sid_subj(from), task_sid_obj(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
>  }
>  
> @@ -2078,7 +2086,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  					struct task_struct *to,
>  					struct file *file)
>  {
> -	u32 sid = task_sid(to);
> +	u32 sid = task_sid_subj(to);
>  	struct file_security_struct *fsec = selinux_file(file);
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct inode_security_struct *isec;
> @@ -2114,10 +2122,10 @@ static int selinux_binder_transfer_file(struct task_struct *from,
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
> @@ -2130,15 +2138,15 @@ static int selinux_ptrace_access_check(struct task_struct *child,
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
> @@ -2263,7 +2271,7 @@ static u32 ptrace_parent_sid(void)
>  	rcu_read_lock();
>  	tracer = ptrace_parent(current);
>  	if (tracer)
> -		sid = task_sid(tracer);
> +		sid = task_sid_obj(tracer);
>  	rcu_read_unlock();
>  
>  	return sid;
> @@ -3916,7 +3924,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  				       struct fown_struct *fown, int signum)
>  {
>  	struct file *file;
> -	u32 sid = task_sid(tsk);
> +	u32 sid = task_sid_obj(tsk);
>  	u32 perm;
>  	struct file_security_struct *fsec;
>  
> @@ -4135,47 +4143,52 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
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
> @@ -4206,7 +4219,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  	   upon context transitions.  See selinux_bprm_committing_creds. */
>  	if (old_rlim->rlim_max != new_rlim->rlim_max)
>  		return avc_has_perm(&selinux_state,
> -				    current_sid(), task_sid(p),
> +				    current_sid(), task_sid_obj(p),
>  				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
>  
>  	return 0;
> @@ -4215,21 +4228,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
> @@ -4248,14 +4261,14 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
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
> @@ -6148,7 +6161,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = task_sid(target);
> +	u32 sid = task_sid_subj(target);
>  	int rc;
>  
>  	isec = selinux_ipc(msq);
> @@ -7143,8 +7156,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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

