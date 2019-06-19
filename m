Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FFFC31E5E
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD8C208CB
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 05:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DC8AGOyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfFSFLL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:11:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40419 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFLL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 01:11:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so6692458pla.7
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=luHH/GEEctWD3MMilvBup9jUkSjGKM92ajlMSYTsUXE=;
        b=DC8AGOyv40ZTdgG1ADfzZxpeQzBP1UoIIfO/+yKOctf3LhPvWWW+9iKjmbxDGrxW4E
         x+UXa/EvqD5ia457Su1dehiFQmy/lu/bbIJL0+b8Eba1EuXoDmzfZn6OzxQiL5eG4/LW
         I/0XHfYbuo4T008B4HRrbNLA6rmxJjKyubyMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=luHH/GEEctWD3MMilvBup9jUkSjGKM92ajlMSYTsUXE=;
        b=WCIbgqDAbCU+CMI9wWt8Hu/sk8gY2Ejw3E5g4CtBi974eDkgQkYN2ov6qpo60Ue6Do
         ccAVkcPRGVKAeA2PXG8YjEraR17Bh2FxBXCJ/bnbx+7EPdW9/jMFWAsQC3aVhkZrEv1o
         ayW4cnGVqkZKPL+GV1H/WjXvH+anwMwimzFLOgdNkhxFRRAwg4bPT3nQ1D+dELxgkMQv
         WpCJAD2gHYHBPvjsY0jCWBQPudC+Wf6g0UzjxK14TbY5NK3nsOzTQyH83YEEIxTNnyre
         It77nginiRuh2DEdKOoMxjmazCHtplu2JPqPmV18QbfaZHEHAA/6l2cyXoqP4+dUVnM+
         c/jA==
X-Gm-Message-State: APjAAAVAQtriJusUBiDXuEK5rx+L/PEetvFVvVs+lNWPLrrjaJGIbtwK
        uoe8vNs8KYrQB8B1RwViqJ6zLg==
X-Google-Smtp-Source: APXvYqyendG1T2b1kbPFyv91FmoNqXdqgLfZICdVUQcXDQcoftMea9LF4VBJXKAD9i5c8VENZwkS2w==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr95697577plo.225.1560921070313;
        Tue, 18 Jun 2019 22:11:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4sm450668pji.24.2019.06.18.22.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:11:09 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:11:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 13/25] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <201906182210.8765003E11@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-14-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:39PM -0700, Casey Schaufler wrote:
> Change the security_cred_getsecid() interface to fill in a
> lsmblob instead of a u32 secid. The associated data elements
> in the audit sub-system are changed from a secid to a lsmblob
> to accomodate multiple possible LSM audit users.

Cool, cool. I'm digging the clean conversions all the way through this
patch. I didn't see patch 14/25 for some reason, though...

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h          |  2 +-
>  kernel/audit.c                    | 14 +++++-------
>  kernel/audit.h                    |  5 +++--
>  kernel/auditsc.c                  | 37 +++++++++++--------------------
>  security/integrity/ima/ima_main.c |  6 ++---
>  security/security.c               |  9 +++++---
>  6 files changed, 32 insertions(+), 41 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b28d4f9c7714..07a239292e02 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -383,7 +383,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
>  void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred *old);
> -void security_cred_getsecid(const struct cred *c, u32 *secid);
> +void security_cred_getsecid(const struct cred *c, struct lsmblob *l);
>  int security_kernel_act_as(struct cred *new, struct lsmblob *l);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 3ab2a1c0ba61..a52f8772477f 100644
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
> -			struct lsmblob le;
> -
> -			lsmblob_init(&le, audit_sig_sid);
> -			err = security_secid_to_secctx(&le, &ctx, &len);
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
> index cdd1dd9e0eec..ebdd7eab9247 100644
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
> @@ -937,14 +937,14 @@ static inline void audit_free_context(struct audit_context *context)
>  }
>  
>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> -				 kuid_t auid, kuid_t uid, unsigned int sessionid,
> -				 u32 sid, char *comm)
> +				 kuid_t auid, kuid_t uid,
> +				 unsigned int sessionid,
> +				 struct lsmblob *l, char *comm)
>  {
>  	struct audit_buffer *ab;
>  	char *ctx = NULL;
>  	u32 len;
>  	int rc = 0;
> -	struct lsmblob le;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
>  	if (!ab)
> @@ -953,9 +953,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (sid) {
> -		lsmblob_init(&le, sid);
> -		if (security_secid_to_secctx(&le, &ctx, &len)) {
> +	if (lsmblob_is_set(l)) {
> +		if (security_secid_to_secctx(l, &ctx, &len)) {
>  			audit_log_format(ab, " obj=(none)");
>  			rc = 1;
>  		} else {
> @@ -1525,7 +1524,7 @@ static void audit_log_exit(void)
>  						  axs->target_auid[i],
>  						  axs->target_uid[i],
>  						  axs->target_sessionid[i],
> -						  axs->target_sid[i],
> +						  &axs->target_lsm[i],
>  						  axs->target_comm[i]))
>  				call_panic = 1;
>  	}
> @@ -1534,7 +1533,7 @@ static void audit_log_exit(void)
>  	    audit_log_pid_context(context, context->target_pid,
>  				  context->target_auid, context->target_uid,
>  				  context->target_sessionid,
> -				  context->target_sid, context->target_comm))
> +				  &context->target_lsm, context->target_comm))
>  			call_panic = 1;
>  
>  	if (context->pwd.dentry && context->pwd.mnt) {
> @@ -1711,7 +1710,7 @@ void __audit_syscall_exit(int success, long return_code)
>  	context->aux = NULL;
>  	context->aux_pids = NULL;
>  	context->target_pid = 0;
> -	context->target_sid = 0;
> +	lsmblob_init(&context->target_lsm, 0);
>  	context->sockaddr_len = 0;
>  	context->type = 0;
>  	context->fds[0] = -1;
> @@ -2365,15 +2364,12 @@ int __audit_sockaddr(int len, void *a)
>  void __audit_ptrace(struct task_struct *t)
>  {
>  	struct audit_context *context = audit_context();
> -	struct lsmblob le;
>  
>  	context->target_pid = task_tgid_nr(t);
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &le);
> -	/* scaffolding - until target_sid is converted */
> -	context->target_sid = le.secid[1];
> +	security_task_getsecid(t, &context->target_lsm);
>  	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>  }
>  
> @@ -2390,7 +2386,6 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	struct audit_aux_data_pids *axp;
>  	struct audit_context *ctx = audit_context();
>  	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
> -	struct lsmblob le;
>  
>  	if (auditd_test_task(t) &&
>  	    (sig == SIGTERM || sig == SIGHUP ||
> @@ -2401,9 +2396,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  			audit_sig_uid = auid;
>  		else
>  			audit_sig_uid = uid;
> -		security_task_getsecid(current, &le);
> -		/* scaffolding until audit_sig_sid is converted */
> -		audit_sig_sid = le.secid[1];
> +		security_task_getsecid(current, &audit_sig_lsm);
>  	}
>  
>  	if (!audit_signals || audit_dummy_context())
> @@ -2416,9 +2409,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &le);
> -		/* scaffolding until target_sid is converted */
> -		ctx->target_sid = le.secid[1];
> +		security_task_getsecid(t, &ctx->target_lsm);
>  		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>  		return 0;
>  	}
> @@ -2439,9 +2430,7 @@ int audit_signal_info(int sig, struct task_struct *t)
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &le);
> -	/* scaffolding until target_sid is converted */
> -	axp->target_sid[axp->pid_count] = le.secid[1];
> +	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
>  	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>  	axp->pid_count++;
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 99870a6286a9..9959d7cbe42e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -363,7 +363,6 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>  int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
> -	u32 secid;
>  	struct lsmblob le;
>  
>  	security_task_getsecid(current, &le);
> @@ -373,8 +372,9 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  	if (ret)
>  		return ret;
>  
> -	security_cred_getsecid(bprm->cred, &secid);
> -	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
> +	security_cred_getsecid(bprm->cred, &le);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(bprm->file, bprm->cred, le.secid[1], NULL, 0,
>  				   MAY_EXEC, CREDS_CHECK);
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index e82994667263..46f6cf21d33c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1638,10 +1638,13 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
>  	call_void_hook(cred_transfer, new, old);
>  }
>  
> -void security_cred_getsecid(const struct cred *c, u32 *secid)
> +void security_cred_getsecid(const struct cred *c, struct lsmblob *l)
>  {
> -	*secid = 0;
> -	call_void_hook(cred_getsecid, c, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(l, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.cred_getsecid, list)
> +		hp->hook.cred_getsecid(c, &l->secid[hp->slot]);
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
