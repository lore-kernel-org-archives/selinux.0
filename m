Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24244C2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C771D20730
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="As7Y9LIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDGSn5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:43:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42742 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSn5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:43:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id v2so189516plp.9
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fTiDneXmJHXWR79FocZB97LPz5VyRes0dVnQaJxwFe8=;
        b=As7Y9LImlrQFgBdZ5j4HBDFcW004/Vt+dv8CxnBIVO6i702jSkcAY3gwxT7GxDVEuB
         IdSVyO80C1LajDyHMqXgtlzSLb3/v3K4pI4MYCDdB48RJdbXSrKX37ZnPWmMUPSm/rqb
         UD/nXSJx6k1F5tBAzIFZ3Y8Qz5Bjqp39hiYHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fTiDneXmJHXWR79FocZB97LPz5VyRes0dVnQaJxwFe8=;
        b=QWl7jIt2Efj5XHovaiHMjI49wOzDzRuu14DNPe97qS9xutDgbmk6uN1OBZn7WYYE3a
         o9TUv54Vy9ACKOcrDxVd5IpVrkrvn/l174xQ3TuJf79Zg8zDTh1DliIJ28jPSGcILk6D
         VZHSkub++MerkWgvD7zvkZv4xnDRvufQiNK/kylrltt8hqhz+n54qTCt+s4ehUrF/bAE
         moCAHfChmuL4ygpZjm7mPL8njETWNYm8iMMn8VacYRkvurALYlo153OfqebzS2WTCnfx
         KaNHNsSLzJ7Pn/0vZAUaDpd5idVxicqXt4psDfjRDSk2XXVdsKPafKo50jsB62VHuQds
         9uTw==
X-Gm-Message-State: AGi0PuZcgG+eE4UwiM6e+fQIrSQqD4AAoawcYxumNclu4+rgdsu5JGlZ
        VjpeRNvHS6pyvoBxUXuNI7gKRg==
X-Google-Smtp-Source: APiQypISlujf12Z+gZJsUCR9+GqyLL4yBrdWMACVoU/iHcPSICucyaiyFo7ztUupmf/+vP86R6upEw==
X-Received: by 2002:a17:90a:7785:: with SMTP id v5mr808169pjk.120.1586285034092;
        Tue, 07 Apr 2020 11:43:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h64sm14258601pfg.191.2020.04.07.11.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:43:53 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:43:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 21/23] Audit: Add a new record for multiple object
 LSM attributes
Message-ID: <202004071143.067D340B9@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-22-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-22-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:57PM -0700, Casey Schaufler wrote:
> Create a new audit record type to contain the object information
> when there are multiple security modules that require such data.
> This record is emitted before the other records for the event, but
> is linked with the same timestamp and serial number.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/audit.h      |  2 ++
>  include/uapi/linux/audit.h |  1 +
>  kernel/audit.c             | 53 +++++++++++++++++++++++++++++
>  kernel/audit.h             |  4 +--
>  kernel/auditsc.c           | 70 +++++---------------------------------
>  5 files changed, 67 insertions(+), 63 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 8e1c759fd1ff..4c7c0ee867a1 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -163,6 +163,8 @@ extern void		    audit_log_path_denied(int type,
>  extern void		    audit_log_lost(const char *message);
>  
>  extern int audit_log_task_context(struct audit_buffer *ab);
> +extern int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsmblob *blob);
>  extern void audit_log_task_info(struct audit_buffer *ab);
>  
>  extern int		    audit_update_lsm_rules(void);
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 2e6dbf907ee3..2269100ba0ca 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -139,6 +139,7 @@
>  #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
>  #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
>  #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM contexts */
> +#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM object contexts */
>  
>  #define AUDIT_FIRST_KERN_ANOM_MSG   1700
>  #define AUDIT_LAST_KERN_ANOM_MSG    1799
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 00a4fbecfdf7..6a6146a34cc9 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2113,6 +2113,59 @@ int audit_log_task_context(struct audit_buffer *ab)
>  }
>  EXPORT_SYMBOL(audit_log_task_context);
>  
> +int audit_log_object_context(struct audit_buffer *ab,
> +				    struct lsmblob *blob)
> +{
> +	int i;
> +	int error;
> +	bool sep = false;
> +	struct lsmcontext lsmdata;
> +	struct audit_buffer *lsmab = NULL;
> +	struct audit_context *context = NULL;
> +
> +	/*
> +	 * If there is more than one security module that has a
> +	 * object "context" it's necessary to put the object data
> +	 * into a separate record to maintain compatibility.
> +	 */
> +	if (security_lsm_slot_name(1) != NULL) {
> +		audit_log_format(ab, " obj=?");
> +		context = ab->ctx;
> +		if (context)
> +			lsmab = audit_log_start(context, GFP_KERNEL,
> +						AUDIT_MAC_OBJ_CONTEXTS);
> +	}
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
> +		if (blob->secid[i] == 0)
> +			continue;
> +		error = security_secid_to_secctx(blob, &lsmdata, i);
> +		if (error && error != -EINVAL) {
> +			audit_panic("error in audit_log_object_context");
> +			return error;
> +		}
> +
> +		if (context) {
> +			audit_log_format(lsmab, "%sobj_%s=%s",
> +					 sep ? " " : "",
> +					 security_lsm_slot_name(i),
> +					 lsmdata.context);
> +			sep = true;
> +		} else
> +			audit_log_format(ab, " obj=%s", lsmdata.context);
> +
> +		security_release_secctx(&lsmdata);
> +		if (!context)
> +			break;
> +	}
> +
> +	if (context)
> +		audit_log_end(lsmab);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(audit_log_object_context);
> +
>  void audit_log_d_path_exe(struct audit_buffer *ab,
>  			  struct mm_struct *mm)
>  {
> diff --git a/kernel/audit.h b/kernel/audit.h
> index f65f516913c6..9a26ba213f6a 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -78,7 +78,7 @@ struct audit_names {
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	dev_t			rdev;
> -	u32			osid;
> +	struct lsmblob		oblob;
>  	struct audit_cap_data	fcap;
>  	unsigned int		fcap_ver;
>  	unsigned char		type;		/* record type */
> @@ -152,7 +152,7 @@ struct audit_context {
>  			kuid_t			uid;
>  			kgid_t			gid;
>  			umode_t			mode;
> -			u32			osid;
> +			struct lsmblob		oblob;
>  			int			has_perm;
>  			uid_t			perm_uid;
>  			gid_t			perm_gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 4df540c32581..f567f3776ca5 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -659,14 +659,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			if (f->lsm_isset) {
>  				/* Find files that match */
>  				if (name) {
> -					/*
> -					 * lsmblob_init sets all values in the
> -					 * lsmblob to sid. This is temporary
> -					 * until name->osid is converted to a
> -					 * lsmblob, which happens later in
> -					 * this patch set.
> -					 */
> -					lsmblob_init(&blob, name->osid);
>  					result = security_audit_rule_match(
>  								&blob,
>  								f->type,
> @@ -674,7 +666,6 @@ static int audit_filter_rules(struct task_struct *tsk,
>  								f->lsm_rules);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> -						lsmblob_init(&blob, name->osid);
>  						if (security_audit_rule_match(
>  								&blob,
>  								f->type,
> @@ -688,8 +679,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				lsmblob_init(&blob, ctx->ipc.osid);
> -				if (security_audit_rule_match(&blob,
> +				if (security_audit_rule_match(&ctx->ipc.oblob,
>  							      f->type, f->op,
>  							      f->lsm_rules))
>  					++result;
> @@ -969,7 +959,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  				 struct lsmblob *blob, char *comm)
>  {
>  	struct audit_buffer *ab;
> -	struct lsmcontext lsmctx;
>  	int rc = 0;
>  
>  	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
> @@ -979,15 +968,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
>  			 from_kuid(&init_user_ns, auid),
>  			 from_kuid(&init_user_ns, uid), sessionid);
> -	if (lsmblob_is_set(blob)) {
> -		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " obj=(none)");
> -			rc = 1;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	rc = audit_log_object_context(ab, blob);
>  	audit_log_format(ab, " ocomm=");
>  	audit_log_untrustedstring(ab, comm);
>  	audit_log_end(ab);
> @@ -1214,26 +1195,14 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				context->socketcall.args[i]);
>  		break; }
>  	case AUDIT_IPC: {
> -		u32 osid = context->ipc.osid;
> +		struct lsmblob *oblob = &context->ipc.oblob;
>  
>  		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
>  				 from_kuid(&init_user_ns, context->ipc.uid),
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
> -		if (osid) {
> -			struct lsmcontext lsmcxt;
> -			struct lsmblob blob;
> -
> -			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt,
> -						     LSMBLOB_FIRST)) {
> -				audit_log_format(ab, " osid=%u", osid);
> -				*call_panic = 1;
> -			} else {
> -				audit_log_format(ab, " obj=%s", lsmcxt.context);
> -				security_release_secctx(&lsmcxt);
> -			}
> -		}
> +		if (audit_log_object_context(ab, oblob))
> +			*call_panic = 1;
>  		if (context->ipc.has_perm) {
>  			audit_log_end(ab);
>  			ab = audit_log_start(context, GFP_KERNEL,
> @@ -1373,20 +1342,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 from_kgid(&init_user_ns, n->gid),
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
> -	if (n->osid != 0) {
> -		struct lsmblob blob;
> -		struct lsmcontext lsmctx;
> -
> -		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
> -			audit_log_format(ab, " osid=%u", n->osid);
> -			if (call_panic)
> -				*call_panic = 2;
> -		} else {
> -			audit_log_format(ab, " obj=%s", lsmctx.context);
> -			security_release_secctx(&lsmctx);
> -		}
> -	}
> +	if (audit_log_object_context(ab, &n->oblob) && call_panic)
> +		*call_panic = 2;
>  
>  	/* log the audit_names record type */
>  	switch (n->type) {
> @@ -1935,17 +1892,13 @@ static void audit_copy_inode(struct audit_names *name,
>  			     const struct dentry *dentry,
>  			     struct inode *inode, unsigned int flags)
>  {
> -	struct lsmblob blob;
> -
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
>  	name->mode  = inode->i_mode;
>  	name->uid   = inode->i_uid;
>  	name->gid   = inode->i_gid;
>  	name->rdev  = inode->i_rdev;
> -	security_inode_getsecid(inode, &blob);
> -	/* scaffolding until osid is updated */
> -	name->osid = blob.secid[0];
> +	security_inode_getsecid(inode, &name->oblob);
>  	if (flags & AUDIT_INODE_NOEVAL) {
>  		name->fcap_ver = -1;
>  		return;
> @@ -2291,16 +2244,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
>  	struct audit_context *context = audit_context();
> -	struct lsmblob blob;
>  	context->ipc.uid = ipcp->uid;
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &blob);
> -	/* context->ipc.osid will be changed to a lsmblob later in
> -	 * the patch series. This will allow auditing of all the object
> -	 * labels associated with the ipc object. */
> -	context->ipc.osid = lsmblob_value(&blob);
> +	security_ipc_getsecid(ipcp, &context->ipc.oblob);
>  	context->type = AUDIT_IPC;
>  }
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
