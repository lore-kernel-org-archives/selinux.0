Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B598C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BD521738
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FtQFzZRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFZXQk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:16:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39108 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFZXQk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:16:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so167260pls.6
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kUJ/sw9AfcoC7VvDFXYhUb+wJr2kVKVf3zgItYsRcg0=;
        b=FtQFzZRX++bt3h7PDycy6Ee47jGMRsZD45/NZl4ZkGITPZfKtZUsPmKfGyHWnnVT6m
         Yydrl5yMbwQXJPzRMdg/8mSzHwtxE7A2WtsJuERpovzi9WCq8CI8KDVUN2anibiFDGQ6
         oluLrPtArm5gn5oJHOV68XZXtFehh2QQK/Q/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kUJ/sw9AfcoC7VvDFXYhUb+wJr2kVKVf3zgItYsRcg0=;
        b=Ix6tBg5eJROzTAU1EL7F0txi+xjUa/50FB1KPyqHnyiaOZZLxly/IDtCAf/XlZHiTs
         74E9Yb+935X+Co6wGwgYnismp9DAQeM9im50uD/oKcbxdqvDgcOx55/hkQpfl9QF+PKI
         etdX8fWx1ahRNjXXV/QN7hh0A0kt+B53MI7D+zeFqTz7icPjAm6H4tW7dYC6mIGQYoRh
         8iWkzdtRgSwR239x44AHufQQUuR+B+qHNDZImGeEeLQKnvBhnrd/NDoF7yQLiBCd646F
         B1nqF67LsSHkZCxT1wrwRJkKvsREb7bKOCBEcYi2bMBbU9x1u9iicEvb2wgG6vee8ny7
         px5A==
X-Gm-Message-State: APjAAAUir49BoeeSkOcNMsYvXBqcxZpnEYZKCmLJbNqC60Q9JrxM50Bx
        WauYOknWaX7CoKEdxAWXzrSIrA==
X-Google-Smtp-Source: APXvYqyIgpK+CDWxsruPAgO77481XtUj92KwLwB7ARNrH4R2S8kFDADTyWmcx8JbR0Goo/l6fGDZIg==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr748413plb.108.1561590999757;
        Wed, 26 Jun 2019 16:16:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm332473pfi.35.2019.06.26.16.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:16:39 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:16:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 21/23] Audit: Store LSM audit information in an lsmblob
Message-ID: <201906261616.274E79D61@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-22-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-22-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:32PM -0700, Casey Schaufler wrote:
> Change the audit code to store full lsmblob data instead of
> a single u32 secid. This allows for multiple security modules
> to use the audit system at the same time. It also allows the
> removal of scaffolding code that was included during the
> revision of LSM interfaces.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  kernel/audit.h   |  6 +++---
>  kernel/auditsc.c | 40 +++++++++++++---------------------------
>  2 files changed, 16 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 29e29c6f4afb..a8dd479e9556 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -91,7 +91,7 @@ struct audit_names {
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	dev_t			rdev;
> -	u32			osid;
> +	struct lsmblob		olsm;
>  	struct audit_cap_data	fcap;
>  	unsigned int		fcap_ver;
>  	unsigned char		type;		/* record type */
> @@ -148,7 +148,7 @@ struct audit_context {
>  	kuid_t		    target_auid;
>  	kuid_t		    target_uid;
>  	unsigned int	    target_sessionid;
> -	struct lsmblob   target_lsm;
> +	struct lsmblob	    target_lsm;
>  	char		    target_comm[TASK_COMM_LEN];
>  
>  	struct audit_tree_refs *trees, *first_trees;
> @@ -165,7 +165,7 @@ struct audit_context {
>  			kuid_t			uid;
>  			kgid_t			gid;
>  			umode_t			mode;
> -			u32			osid;
> +			struct lsmblob		olsm;
>  			int			has_perm;
>  			uid_t			perm_uid;
>  			gid_t			perm_gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 0478680cd0a8..ec8872430fb6 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -646,17 +646,15 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			if (f->lsm_rule) {
>  				/* Find files that match */
>  				if (name) {
> -					lsmblob_init(&blob, name->osid);
>  					result = security_audit_rule_match(
> -								&blob,
> +								&name->olsm,
>  								f->type,
>  								f->op,
>  								f->lsm_rule);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> -						lsmblob_init(&blob, n->osid);
>  						if (security_audit_rule_match(
> -								&blob,
> +								&n->olsm,
>  								f->type,
>  								f->op,
>  								f->lsm_rule)) {
> @@ -668,8 +666,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				lsmblob_init(&blob, ctx->ipc.osid);
> -				if (security_audit_rule_match(&blob,
> +				if (security_audit_rule_match(&ctx->ipc.olsm,
>  							      f->type, f->op,
>  							      f->lsm_rule))
>  					++result;
> @@ -955,7 +952,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>  			 from_kuid(&init_user_ns, uid), sessionid);
>  	if (lsmblob_is_set(blob)) {
>  		if (security_secid_to_secctx(blob, &lsmctx)) {
> -			audit_log_format(ab, " obj=(none)");
> +			audit_log_format(ab, " obj=?");
>  			rc = 1;
>  		} else {
>  			audit_log_format(ab, " obj=%s", lsmctx.context);
> @@ -1187,19 +1184,17 @@ static void show_special(struct audit_context *context, int *call_panic)
>  				context->socketcall.args[i]);
>  		break; }
>  	case AUDIT_IPC: {
> -		u32 osid = context->ipc.osid;
> +		struct lsmblob *olsm = &context->ipc.olsm;
>  
>  		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
>  				 from_kuid(&init_user_ns, context->ipc.uid),
>  				 from_kgid(&init_user_ns, context->ipc.gid),
>  				 context->ipc.mode);
> -		if (osid) {
> +		if (lsmblob_is_set(olsm)) {
>  			struct lsmcontext lsmcxt;
> -			struct lsmblob blob;
>  
> -			lsmblob_init(&blob, osid);
> -			if (security_secid_to_secctx(&blob, &lsmcxt)) {
> -				audit_log_format(ab, " osid=%u", osid);
> +			if (security_secid_to_secctx(olsm, &lsmcxt)) {
> +				audit_log_format(ab, " obj=?");
>  				*call_panic = 1;
>  			} else {
>  				audit_log_format(ab, " obj=%s", lsmcxt.context);
> @@ -1346,13 +1341,11 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
>  				 from_kgid(&init_user_ns, n->gid),
>  				 MAJOR(n->rdev),
>  				 MINOR(n->rdev));
> -	if (n->osid != 0) {
> -		struct lsmblob blob;
> +	if (lsmblob_is_set(&n->olsm)) {
>  		struct lsmcontext lsmctx;
>  
> -		lsmblob_init(&blob, n->osid);
> -		if (security_secid_to_secctx(&blob, &lsmctx)) {
> -			audit_log_format(ab, " osid=%u", n->osid);
> +		if (security_secid_to_secctx(&n->olsm, &lsmctx)) {
> +			audit_log_format(ab, " obj=?");
>  			if (call_panic)
>  				*call_panic = 2;
>  		} else {
> @@ -1906,17 +1899,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
>  		      struct inode *inode, unsigned int flags)
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
> +	security_inode_getsecid(inode, &name->olsm);
>  	if (flags & AUDIT_INODE_NOEVAL) {
>  		name->fcap_ver = -1;
>  		return;
> @@ -2266,14 +2255,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
>  void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
>  	struct audit_context *context = audit_context();
> -	struct lsmblob blob;
>  	context->ipc.uid = ipcp->uid;
>  	context->ipc.gid = ipcp->gid;
>  	context->ipc.mode = ipcp->mode;
>  	context->ipc.has_perm = 0;
> -	security_ipc_getsecid(ipcp, &blob);
> -	/* scaffolding on the [0] - change "osid" to a lsmblob */
> -	context->ipc.osid = blob.secid[0];
> +	security_ipc_getsecid(ipcp, &context->ipc.olsm);
>  	context->type = AUDIT_IPC;
>  }
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
