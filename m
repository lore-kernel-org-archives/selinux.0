Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E0BC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B62206B7
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 23:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUdBl++/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfFVXMF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 19:12:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46538 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfFVXMF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 19:12:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5380641pfy.13
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNwTZTD3fsg66NUnhAl08GAZgaRIV1IL32blGDT0coU=;
        b=QUdBl++/va6LmanVstXGpRtfMqS3bqdrjVjmHJMlK2qzxOcwnM9rE5wfro4wv3uW+8
         Y0DFEc6ssD6dqpFcqYeGkgjNEChUtLTRZp7fzAtQ4RLBwf+xiuuoFdA/hHwJEC79pOVW
         gomvbOV8zhoztKnuaXnlDO/6aJ7Req8bd27UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dNwTZTD3fsg66NUnhAl08GAZgaRIV1IL32blGDT0coU=;
        b=TliJYGl8mGS8XHRWG+5+GGEwz+dvyfUF3T/rV5FwqA/1vfStTevdTgH5O/KPdciKyu
         1GtT4i2ssAa0E93RrbuqTt3fzKtNEzvTI4xECZIcfTJ+h5RhMPTveUidRhjkEHwa/CCE
         3WJdogAHCCkzmv7MPYWXUL9eaNw9estUSLP9ZbFd9910xoSZV8RhEmnoTRGt7l1V5x3H
         DG4cqCoNjxbUdkzALGgaiNr9M9KcTtf7gEuAAle/6Z4CI5Zo0pv5xhu6A4Zt05a8LDC4
         B9adMJDr9BwwVXaRYkPA3pCPP2Bo/D9f1yxNYk944rdUaE0wBG76J1qg0mcCYH3xktIv
         hTXw==
X-Gm-Message-State: APjAAAUDLffcUwjqQljV9rjigE230wjLWmdslcmH1qi+dHYGEGmdUsRZ
        I7uXNfDsP0LvcDpmoMkZJA03RA==
X-Google-Smtp-Source: APXvYqy87fECkpPfnI9OElbTAgTDr6Dw31SxmTSomB0Ldy9F2WTZMRZAga3K1MY7vyxZHcFnTYmPbQ==
X-Received: by 2002:a63:2a0f:: with SMTP id q15mr25974287pgq.163.1561245124227;
        Sat, 22 Jun 2019 16:12:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm6200168pgd.50.2019.06.22.16.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:12:03 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:12:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
Message-ID: <201906221611.88844FB@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-22-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-22-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:30AM -0700, Casey Schaufler wrote:
> Change the audit code to store full lsmblob data instead of
> a single u32 secid. This allows for multiple security modules
> to use the audit system at the same time. It also allows the
> removal of scaffolding code that was included during the
> revision of LSM interfaces.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.h   |  6 +++---
>  kernel/auditsc.c | 38 +++++++++++---------------------------
>  2 files changed, 14 insertions(+), 30 deletions(-)
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
> index 0478680cd0a8..d3ad13f11788 100644
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
> @@ -1187,21 +1184,18 @@ static void show_special(struct audit_context *context, int *call_panic)
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

Should this (and the other) audit_log_format() calls actually be
removed?

-Kees

> +			if (security_secid_to_secctx(olsm, &lsmcxt))
>  				*call_panic = 1;
> -			} else {
> +			else {
>  				audit_log_format(ab, " obj=%s", lsmcxt.context);
>  				security_release_secctx(&lsmcxt);
>  			}
> @@ -1346,13 +1340,10 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
>  			if (call_panic)
>  				*call_panic = 2;
>  		} else {
> @@ -1906,17 +1897,13 @@ static inline int audit_copy_fcaps(struct audit_names *name,
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
> @@ -2266,14 +2253,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
