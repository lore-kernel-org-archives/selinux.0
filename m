Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00929C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906A20659
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUSns (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:43:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59205 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:43:47 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrQd-00036z-Vn; Thu, 21 Nov 2019 18:43:44 +0000
Subject: Re: [PATCH v11 09/25] LSM: Use lsmblob in security_task_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-10-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <1f9b6a99-250c-7495-106c-a7fd0a3bcbde@canonical.com>
Date:   Thu, 21 Nov 2019 10:43:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-10-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> Change the security_task_getsecid() interface to fill in
> a lsmblob structure instead of a u32 secid in support of
> LSM stacking. Audit interfaces will need to collect all
> possible secids for possible reporting.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  drivers/android/binder.c              |  4 +--
>  include/linux/security.h              |  7 ++---
>  kernel/audit.c                        | 11 ++++----
>  kernel/auditfilter.c                  |  4 +--
>  kernel/auditsc.c                      | 18 ++++++++-----
>  net/netlabel/netlabel_unlabeled.c     |  5 +++-
>  net/netlabel/netlabel_user.h          |  6 ++++-
>  security/integrity/ima/ima_appraise.c |  4 ++-
>  security/integrity/ima/ima_main.c     | 39 ++++++++++++++++-----------
>  security/security.c                   | 12 ++++++---
>  10 files changed, 68 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 5f4702b4c507..3a7fcdc8dbe2 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -3108,12 +3108,10 @@ static void binder_transaction(struct binder_proc *proc,
>  	t->priority = task_nice(current);
>  
>  	if (target_node && target_node->txn_security_ctx) {
> -		u32 secid;
>  		struct lsmblob blob;
>  		size_t added_size;
>  
> -		security_task_getsecid(proc->tsk, &secid);
> -		lsmblob_init(&blob, secid);
> +		security_task_getsecid(proc->tsk, &blob);
>  		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
>  		if (ret) {
>  			return_error = BR_FAILED_REPLY;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 9519b4fb43ae..67f95a335b5d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -447,7 +447,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
>  int security_task_setpgid(struct task_struct *p, pid_t pgid);
>  int security_task_getpgid(struct task_struct *p);
>  int security_task_getsid(struct task_struct *p);
> -void security_task_getsecid(struct task_struct *p, u32 *secid);
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
>  int security_task_setnice(struct task_struct *p, int nice);
>  int security_task_setioprio(struct task_struct *p, int ioprio);
>  int security_task_getioprio(struct task_struct *p);
> @@ -1099,9 +1099,10 @@ static inline int security_task_getsid(struct task_struct *p)
>  	return 0;
>  }
>  
> -static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
> +static inline void security_task_getsecid(struct task_struct *p,
> +					  struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_task_setnice(struct task_struct *p, int nice)
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 2f8e89eaf3e5..fd29186ae977 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2062,14 +2062,12 @@ int audit_log_task_context(struct audit_buffer *ab)
>  	char *ctx = NULL;
>  	unsigned len;
>  	int error;
> -	u32 sid;
>  	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &sid);
> -	if (!sid)
> +	security_task_getsecid(current, &blob);
> +	if (!lsmblob_is_set(&blob))
>  		return 0;
>  
> -	lsmblob_init(&blob, sid);
>  	error = security_secid_to_secctx(&blob, &ctx, &len);
>  	if (error) {
>  		if (error != -EINVAL)
> @@ -2276,6 +2274,7 @@ int audit_set_loginuid(kuid_t loginuid)
>  int audit_signal_info(int sig, struct task_struct *t)
>  {
>  	kuid_t uid = current_uid(), auid;
> +	struct lsmblob blob;
>  
>  	if (auditd_test_task(t) &&
>  	    (sig == SIGTERM || sig == SIGHUP ||
> @@ -2286,7 +2285,9 @@ int audit_signal_info(int sig, struct task_struct *t)
>  			audit_sig_uid = auid;
>  		else
>  			audit_sig_uid = uid;
> -		security_task_getsecid(current, &audit_sig_sid);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding until audit_sig_sid is converted */
> +		audit_sig_sid = blob.secid[0];
>  	}
>  
>  	return audit_signal_info_syscall(t);
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 356db1dd276c..19cfbe716f9d 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1324,7 +1324,6 @@ int audit_filter(int msgtype, unsigned int listtype)
>  		for (i = 0; i < e->rule.field_count; i++) {
>  			struct audit_field *f = &e->rule.fields[i];
>  			pid_t pid;
> -			u32 sid;
>  			struct lsmblob blob;
>  
>  			switch (f->type) {
> @@ -1355,8 +1354,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_SEN:
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
> -					security_task_getsecid(current, &sid);
> -					lsmblob_init(&blob, sid);
> +					security_task_getsecid(current, &blob);
>  					result = security_audit_rule_match(
>  							&blob, f->type,
>  							f->op, f->lsm_rule);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ce8bf2d8f8d2..cccb681ad081 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>  {
>  	const struct cred *cred;
>  	int i, need_sid = 1;
> -	u32 sid;
>  	struct lsmblob blob;
>  	unsigned int sessionid;
>  
> @@ -641,10 +640,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			   logged upon error */
>  			if (f->lsm_rule) {
>  				if (need_sid) {
> -					security_task_getsecid(tsk, &sid);
> +					security_task_getsecid(tsk, &blob);
>  					need_sid = 0;
>  				}
> -				lsmblob_init(&blob, sid);
>  				result = security_audit_rule_match(&blob,
>  								   f->type,
>  								   f->op,
> @@ -2382,12 +2380,15 @@ int __audit_sockaddr(int len, void *a)
>  void __audit_ptrace(struct task_struct *t)
>  {
>  	struct audit_context *context = audit_context();
> +	struct lsmblob blob;
>  
>  	context->target_pid = task_tgid_nr(t);
>  	context->target_auid = audit_get_loginuid(t);
>  	context->target_uid = task_uid(t);
>  	context->target_sessionid = audit_get_sessionid(t);
> -	security_task_getsecid(t, &context->target_sid);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding - until target_sid is converted */
> +	context->target_sid = blob.secid[0];
>  	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
>  }
>  
> @@ -2403,6 +2404,7 @@ int audit_signal_info_syscall(struct task_struct *t)
>  	struct audit_aux_data_pids *axp;
>  	struct audit_context *ctx = audit_context();
>  	kuid_t t_uid = task_uid(t);
> +	struct lsmblob blob;
>  
>  	if (!audit_signals || audit_dummy_context())
>  		return 0;
> @@ -2414,7 +2416,9 @@ int audit_signal_info_syscall(struct task_struct *t)
>  		ctx->target_auid = audit_get_loginuid(t);
>  		ctx->target_uid = t_uid;
>  		ctx->target_sessionid = audit_get_sessionid(t);
> -		security_task_getsecid(t, &ctx->target_sid);
> +		security_task_getsecid(t, &blob);
> +		/* scaffolding until target_sid is converted */
> +		ctx->target_sid = blob.secid[0];
>  		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
>  		return 0;
>  	}
> @@ -2435,7 +2439,9 @@ int audit_signal_info_syscall(struct task_struct *t)
>  	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
>  	axp->target_uid[axp->pid_count] = t_uid;
>  	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
> -	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
> +	security_task_getsecid(t, &blob);
> +	/* scaffolding until target_sid is converted */
> +	axp->target_sid[axp->pid_count] = blob.secid[0];
>  	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
>  	axp->pid_count++;
>  
> diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
> index 0cda17cb44a0..e279b81d9545 100644
> --- a/net/netlabel/netlabel_unlabeled.c
> +++ b/net/netlabel/netlabel_unlabeled.c
> @@ -1539,11 +1539,14 @@ int __init netlbl_unlabel_defconf(void)
>  	int ret_val;
>  	struct netlbl_dom_map *entry;
>  	struct netlbl_audit audit_info;
> +	struct lsmblob blob;
>  
>  	/* Only the kernel is allowed to call this function and the only time
>  	 * it is called is at bootup before the audit subsystem is reporting
>  	 * messages so don't worry to much about these values. */
> -	security_task_getsecid(current, &audit_info.secid);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until audit_info.secid is converted */
> +	audit_info.secid = blob.secid[0];
>  	audit_info.loginuid = GLOBAL_ROOT_UID;
>  	audit_info.sessionid = 0;
>  
> diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
> index 3c67afce64f1..438b5db6c714 100644
> --- a/net/netlabel/netlabel_user.h
> +++ b/net/netlabel/netlabel_user.h
> @@ -34,7 +34,11 @@
>  static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
>  					    struct netlbl_audit *audit_info)
>  {
> -	security_task_getsecid(current, &audit_info->secid);
> +	struct lsmblob blob;
> +
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until secid is converted */
> +	audit_info->secid = blob.secid[0];
>  	audit_info->loginuid = audit_get_loginuid(current);
>  	audit_info->sessionid = audit_get_sessionid(current);
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 136ae4e0ee92..7288a574459b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -48,11 +48,13 @@ bool is_ima_appraise_enabled(void)
>  int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>  {
>  	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (!ima_appraise)
>  		return 0;
>  
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid(current, &blob);
> +	lsmblob_secid(&blob, &secid);
>  	return ima_match_policy(inode, current_cred(), secid, func, mask,
>  				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 60027c643ecd..cac654c2faaf 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -380,12 +380,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   */
>  int ima_file_mmap(struct file *file, unsigned long prot)
>  {
> -	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (file && (prot & PROT_EXEC)) {
> -		security_task_getsecid(current, &secid);
> -		return process_measurement(file, current_cred(), secid, NULL,
> -					   0, MAY_EXEC, MMAP_CHECK);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding - until process_measurement changes */
> +		return process_measurement(file, current_cred(), blob.secid[0],
> +					   NULL, 0, MAY_EXEC, MMAP_CHECK);
>  	}
>  
>  	return 0;
> @@ -408,10 +409,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
>  {
>  	int ret;
>  	u32 secid;
> +	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &secid);
> -	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
> -				  MAY_EXEC, BPRM_CHECK);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
> +				  NULL, 0, MAY_EXEC, BPRM_CHECK);
>  	if (ret)
>  		return ret;
>  
> @@ -432,10 +435,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
>   */
>  int ima_file_check(struct file *file, int mask)
>  {
> -	u32 secid;
> +	struct lsmblob blob;
>  
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, NULL, 0,
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
>  				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
>  					   MAY_APPEND), FILE_CHECK);
>  }
> @@ -544,7 +548,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
>  	enum ima_hooks func;
> -	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (!file && read_id == READING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> @@ -566,9 +570,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  	}
>  
>  	func = read_idmap[read_id] ?: FILE_CHECK;
> -	security_task_getsecid(current, &secid);
> -	return process_measurement(file, current_cred(), secid, buf, size,
> -				   MAY_READ, func);
> +	security_task_getsecid(current, &blob);
> +	/* scaffolding until process_measurement changes */
> +	return process_measurement(file, current_cred(), blob.secid[0], buf,
> +				   size, MAY_READ, func);
>  }
>  
>  /**
> @@ -687,11 +692,13 @@ static void process_buffer_measurement(const void *buf, int size,
>  void ima_kexec_cmdline(const void *buf, int size)
>  {
>  	u32 secid;
> +	struct lsmblob blob;
>  
>  	if (buf && size != 0) {
> -		security_task_getsecid(current, &secid);
> +		security_task_getsecid(current, &blob);
> +		/* scaffolding */
>  		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> +					   current_cred(), blob.secid[0]);
>  	}
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index b60c6a51f622..e1f216d453bf 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1700,10 +1700,16 @@ int security_task_getsid(struct task_struct *p)
>  	return call_int_hook(task_getsid, 0, p);
>  }
>  
> -void security_task_getsecid(struct task_struct *p, u32 *secid)
> +void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
>  {
> -	*secid = 0;
> -	call_void_hook(task_getsecid, p, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.task_getsecid(p, &blob->secid[hp->lsmid->slot]);
> +	}
>  }
>  EXPORT_SYMBOL(security_task_getsecid);
>  
> 

