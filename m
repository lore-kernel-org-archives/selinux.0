Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D72FC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFA620673
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W1f+FXsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFVWuc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:50:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfFVWuc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:50:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so5395558pfa.4
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kln2YbzoqrX78NbiwWmW/rsYBKcrx8NRG5SUkZXSUjk=;
        b=W1f+FXsI9adzPczPTK/tNhlQOwpSvRMOSylEeAXgo5BwPO3eQfbPN3oWv/yUJScQ72
         5jaZwALuuXbRg6IXS8p8S6cJJ0diXKxg/jFoLwN1R/QwFV1irzYr+SYTQpGW/FZMpqEH
         RTOHSsu5JgCLvxZWc4X3qWLYfTo2PTpD2Cpm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kln2YbzoqrX78NbiwWmW/rsYBKcrx8NRG5SUkZXSUjk=;
        b=oWJO5pt0O1Qq7Yppdlr3KZtlrNM6cxAML0huurWTdRd/sVs8mAkckuQBVCDrd475Cd
         SFVVvexWGSzvutlixQWvRUT1kSQio/Yo+uIYNy+1Cv6mNxuClIDGc8yFB5OOXQJZg3OR
         hASRpKMef4V52YQi98cG6xqu5WxhV3+IJ2P8Fnyh9zPSB1NgsxOm1EA3yoYohmM0WT0+
         PZ3yw1W0SqxB6Lselex/js9sqnbkQ4wNmGjlGngv4/k284xj2RmwQXPYtyR1m0DcQm59
         jGKJqu++HUpqwJIncKnWB+n8MISmOkZDF+dVszZ6/OEAyLmb6/5UB0MVxkg1Ago+uV1B
         QKOw==
X-Gm-Message-State: APjAAAUgo/hBksbdBo1npMJafaKbvcG/z0H329Zy1dFQlDC7JCbLnuDF
        bN3u0GtyejL8vcaXqYVg3K8OAg==
X-Google-Smtp-Source: APXvYqzfGhPNz1nxQrBU+nB4JlcROYyIngDyZBLuSf2PwL6Zu/icGQjJlj/04Vql1K5T8pAMtnwv4A==
X-Received: by 2002:a63:86c7:: with SMTP id x190mr1823915pgd.316.1561243831414;
        Sat, 22 Jun 2019 15:50:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15sm7665717pje.17.2019.06.22.15.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:50:30 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:50:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 13/24] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <201906221550.29753ACE81@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-14-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:22AM -0700, Casey Schaufler wrote:
> Change the security_cred_getsecid() interface to fill in a
> lsmblob instead of a u32 secid. The associated data elements
> in the audit sub-system are changed from a secid to a lsmblob
> to accomodate multiple possible LSM audit users.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h          |  2 +-
>  kernel/audit.c                    | 14 +++++-------
>  kernel/audit.h                    |  5 +++--
>  kernel/auditsc.c                  | 37 +++++++++++--------------------
>  security/integrity/ima/ima_main.c |  8 +++----
>  security/security.c               |  9 +++++---
>  6 files changed, 33 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 6eb64b7f878a..c712fc72b7bd 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -383,7 +383,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
>  void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred *old);
> -void security_cred_getsecid(const struct cred *c, u32 *secid);
> +void security_cred_getsecid(const struct cred *c, struct lsmblob *blob);
>  int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index a0205f3c23c7..1b51e907f131 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -137,7 +137,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
>  /* The identity of the user shutting down the audit system. */
>  kuid_t		audit_sig_uid = INVALID_UID;
>  pid_t		audit_sig_pid = -1;
> -u32		audit_sig_sid = 0;
> +struct lsmblob	audit_sig_lsm;
>  
>  /* Records can be lost in several ways:
>     0) [suppressed in audit_alloc]
> @@ -1429,23 +1429,21 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>  	}
>  	case AUDIT_SIGNAL_INFO:
>  		len = 0;
> -		if (audit_sig_sid) {
> -			struct lsmblob blob;
> -
> -			lsmblob_init(&blob, audit_sig_sid);
> -			err = security_secid_to_secctx(&blob, &ctx, &len);
> +		if (lsmblob_is_set(&audit_sig_lsm)) {
> +			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
> +						       &len);
>  			if (err)
>  				return err;
>  		}
>  		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>  		if (!sig_data) {
> -			if (audit_sig_sid)
> +			if (lsmblob_is_set(&audit_sig_lsm))
>  				security_release_secctx(ctx, len);
>  			return -ENOMEM;
>  		}
>  		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>  		sig_data->pid = audit_sig_pid;
> -		if (audit_sig_sid) {
> +		if (lsmblob_is_set(&audit_sig_lsm)) {
>  			memcpy(sig_data->ctx, ctx, len);
>  			security_release_secctx(ctx, len);
>  		}
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 958d5b8fc1b3..29e29c6f4afb 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -22,6 +22,7 @@
>  #include <linux/fs.h>
>  #include <linux/audit.h>
>  #include <linux/skbuff.h>
> +#include <linux/security.h>
>  #include <uapi/linux/mqueue.h>
>  #include <linux/tty.h>
>  
> @@ -147,7 +148,7 @@ struct audit_context {
>  	kuid_t		    target_auid;
>  	kuid_t		    target_uid;
>  	unsigned int	    target_sessionid;
> -	u32		    target_sid;
> +	struct lsmblob   target_lsm;
>  	char		    target_comm[TASK_COMM_LEN];
>  
>  	struct audit_tree_refs *trees, *first_trees;
> @@ -338,7 +339,7 @@ extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
>  
>  extern pid_t audit_sig_pid;
>  extern kuid_t audit_sig_uid;
> -extern u32 audit_sig_sid;
> +extern struct lsmblob audit_sig_lsm;
>  
>  extern int audit_filter(int msgtype, unsigned int listtype);
>  
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 54797c0fc3b7..c7aa39bda5cc 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -112,7 +112,7 @@ struct audit_aux_data_pids {
>  	kuid_t			target_auid[AUDIT_AUX_PIDS];
>  	kuid_t			target_uid[AUDIT_AUX_PIDS];
>  	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
> -	u32			target_sid[AUDIT_AUX_PIDS];
> +	struct lsmblob	target_lsm[AUDIT_AUX_PIDS];
>  	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
>  	int			pid_count;
>  };
> @@ -938,14 +938,14 @@ static inline void audit_free_context(struct audit_context *context)
>  }
>  
>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> -				 kuid_t auid, kuid_t uid, unsigned int sessionid,
> -				 u32 sid, char *comm)
> +				 kuid_t auid, kuid_t uid,
> +				 unsigned int sessionid,
> +				 struct lsmblob *blob, char *comm)
>  {
>  	struct audit_buffer *ab;
>  	char *ctx = NULL;
>  	u32 len;
>  	int rc = 0;
> -	struct lsmblob blob;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>  	if (!ab)
> @@ -954,9 +954,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (sid) {
> -		lsmblob_init(&blob, sid);
> -		if (security_secid_to_secctx(&blob, &ctx, &len)) {
> +	if (lsmblob_is_set(blob)) {
> +		if (security_secid_to_secctx(blob, &ctx, &len)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1527,7 +1526,7 @@ static void audit_log_exit(void)
>  						  axs->target_auid[i],
>  						  axs->target_uid[i],
>  						  axs->target_sessionid[i],
> -						  axs->target_sid[i],
> +						  &axs->target_lsm[i],
>  						  axs->target_comm[i]))
>  				call_panic = 1;
>  	}
> @@ -1536,7 +1535,7 @@ static void audit_log_exit(void)
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  context->target_sid, context->target_comm))
> +				  &context->target_lsm, context->target_comm))
>  			call_panic = 1;
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
> @@ -1713,7 +1712,7 @@ void __audit_syscall_exit(int success, long return_code)
>  	context->aux = NULL;
>  	context->aux_pids = NULL;
>  	context->target_pid = 0;
> -	context->target_sid = 0;
> +	lsmblob_init(&context->target_lsm, 0);
>  	context->sockaddr_len = 0;
>  	context->type = 0;
>  	context->fds[0] = -1;
> @@ -2367,15 +2366,12 @@ int __audit_sockaddr(int len, void *a)
>  void __audit_ptrace(struct task_struct *t)
>  {
>  	struct audit_context *context = audit_context();
> -	struct lsmblob blob;
>  
>  	context->target_pid = task_tgid_nr(t);
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &blob);
> -	/* scaffolding - until target_sid is converted */
> -	context->target_sid = blob.secid[0];
> +	security_task_getsecid(t, &context->target_lsm);
>  	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>  }
>  
> @@ -2392,7 +2388,6 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	struct audit_aux_data_pids *axp;
>  	struct audit_context *ctx = audit_context();
>  	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
> -	struct lsmblob blob;
>  
>  	if (auditd_test_task(t) &&
>  	    (sig == SIGTERM || sig == SIGHUP ||
> @@ -2403,9 +2398,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  			audit_sig_uid = auid;
>  		else
>  			audit_sig_uid = uid;
> -		security_task_getsecid(current, &blob);
> -		/* scaffolding until audit_sig_sid is converted */
> -		audit_sig_sid = blob.secid[0];
> +		security_task_getsecid(current, &audit_sig_lsm);
>  	}
>  
>  	if (!audit_signals || audit_dummy_context())
> @@ -2418,9 +2411,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &blob);
> -		/* scaffolding until target_sid is converted */
> -		ctx->target_sid = blob.secid[0];
> +		security_task_getsecid(t, &ctx->target_lsm);
>  		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>  		return 0;
>  	}
> @@ -2441,9 +2432,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &blob);
> -	/* scaffolding until target_sid is converted */
> -	axp->target_sid[axp->pid_count] = blob.secid[0];
> +	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
>  	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>  	axp->pid_count++;
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index fefa848cf0c7..1afb75a893af 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -363,7 +363,6 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
> -	u32 secid;
>  	struct lsmblob blob;
>  
>  	security_task_getsecid(current, &blob);
> @@ -373,9 +372,10 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  	if (ret)
>  		return ret;
>  
> -	security_cred_getsecid(bprm->cred, &secid);
> -	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
> -				   MAY_EXEC, CREDS_CHECK);
> +	security_cred_getsecid(bprm->cred, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(bprm->file, bprm->cred, blob.secid[0],
> +				   NULL, 0, MAY_EXEC, CREDS_CHECK);
>  }
>  
>  /**
> diff --git a/security/security.c b/security/security.c
> index 6f0635b51180..aa8e1c73a062 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1643,10 +1643,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
>  	call_void_hook(cred_transfer, new, old);
>  }
>  
> -void security_cred_getsecid(const struct cred *c, u32 *secid)
> +void security_cred_getsecid(const struct cred *c, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(cred_getsecid, c, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.cred_getsecid, list)
> +		hp->hook.cred_getsecid(c, &blob->secid[hp->slot]);
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
