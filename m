Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBDC4646B
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D817420862
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mABtMoyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVWnL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:43:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38389 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVWnL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:43:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id z75so2467588pgz.5
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=msRXhMb/DBmDXP0Jg1Kzk7SsxD9mnnwChpMQfiWlHuo=;
        b=mABtMoyl3yg7Wz9lytOu/wMSdtkao9PlmaaK1Ts+TnLZZ6uj98XFCWfsDOizCK89hM
         owSP3MpPWw/kYxxpS2r8TSr83Ovrmb2B8zru3ah62EulIX9r02Jeds5RmslRHsY+/ZhS
         KlEkpDrCJY0XXA1R+IuLmyk8ez7kN7z6Dd8Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=msRXhMb/DBmDXP0Jg1Kzk7SsxD9mnnwChpMQfiWlHuo=;
        b=kRnc7qp3vE7OD0mQFn4DnBfkeZte0eTZjPEpxZOdSof37FX2M6d7q3qauE6JoVj2Lx
         J4jbM627QuFF6URBS4dEQ0wC7lU2f2FWMaykFNgJ6kUfX25lu4dnc62JyOKquq3Wy7yQ
         jhU/Zwom8rv5vgAV5AwBEPhgV4BaSTIaB4fkD3nO0PWHIQdhsJu6A9avJb1nmkVyelFy
         zHz4nwzo9r3/AtZjD5naTy8qQvBHZekRORpgWPYoxneJZrjwSenNdgyx6FuymvZ5FqL8
         XkJ52FyJ91Pl3LXt396sqOWPXs5z1gGgCiZLza49Z4NUQa6Bfnvxe/QWpnVJSBRNUHgv
         m43Q==
X-Gm-Message-State: APjAAAV2GmJpVdjO3uFeTuxkWu1+kZy5k7GohLNlySjdkjPlge8w8BSZ
        ix4fIqt7o5sRKH8BmPbk2S3tOQ==
X-Google-Smtp-Source: APXvYqwI8XIxxA0Qc2WVSesVr5BpWADswEYVZYBygPWKUPI19tx9HK2sgWqjCqx8gPE1MXOpg2nw6A==
X-Received: by 2002:a63:fc15:: with SMTP id j21mr25125828pgi.217.1561243389769;
        Sat, 22 Jun 2019 15:43:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k22sm6317445pfk.157.2019.06.22.15.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:43:09 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:43:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 05/24] Use lsmblob in security_audit_rule_match
Message-ID: <201906221543.4C410077B8@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-6-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:14AM -0700, Casey Schaufler wrote:
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
> 
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. In some cases this requires a
> temporary conversion using lsmblob_init() that will go
> away when other interfaces get converted.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditfilter.c                |  4 +++-
>  kernel/auditsc.c                    | 14 ++++++++++----
>  security/integrity/ima/ima.h        |  4 ++--
>  security/integrity/ima/ima_policy.c |  7 +++++--
>  security/security.c                 | 14 ++++++++++++--
>  6 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0aa9417a5762..52d89c4a9594 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1757,7 +1757,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  #ifdef CONFIG_SECURITY
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule);
>  void security_audit_rule_free(void *lsmrule);
>  
>  #else
> @@ -1773,8 +1774,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
>  	return 0;
>  }
>  
> -static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
> +					    u32 op, void *lsmrule)
>  {
>  	return 0;
>  }
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f26fab..da211065160f 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			struct audit_field *f = &e->rule.fields[i];
>  			pid_t pid;
>  			u32 sid;
> +			struct lsmblob blob;
>  
>  			switch (f->type) {
>  			case AUDIT_PID:
> @@ -1354,7 +1355,8 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
>  					security_task_getsecid(current, &sid);
> -					result = security_audit_rule_match(sid,
> +					lsmblob_init(&blob, sid);
> +					result = security_audit_rule_match(&blob,
>  						   f->type, f->op, f->lsm_rule);
>  				}
>  				break;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1eab1d4a930..18ee5556c086 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  	const struct cred *cred;
>  	int i, need_sid = 1;
>  	u32 sid;
> +	struct lsmblob blob;
>  	unsigned int sessionid;
>  
>  	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> @@ -630,7 +631,9 @@ static int audit_filter_rules(struct task_struct *tsk,
>  					security_task_getsecid(tsk, &sid);
>  					need_sid = 0;
>  				}
> -				result = security_audit_rule_match(sid, f->type,
> +				lsmblob_init(&blob, sid);
> +				result = security_audit_rule_match(&blob,
> +								   f->type,
>  								   f->op,
>  								   f->lsm_rule);
>  			}
> @@ -645,15 +648,17 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			if (f->lsm_rule) {
>  				/* Find files that match */
>  				if (name) {
> +					lsmblob_init(&blob, name->osid);
>  					result = security_audit_rule_match(
> -								name->osid,
> +								&blob,
>  								f->type,
>  								f->op,
>  								f->lsm_rule);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> +						lsmblob_init(&blob, n->osid);
>  						if (security_audit_rule_match(
> -								n->osid,
> +								&blob,
>  								f->type,
>  								f->op,
>  								f->lsm_rule)) {
> @@ -665,7 +670,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				if (security_audit_rule_match(ctx->ipc.osid,
> +				lsmblob_init(&blob, ctx->ipc.osid);
> +				if (security_audit_rule_match(&blob,
>  							      f->type, f->op,
>  							      f->lsm_rule))
>  					++result;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..5a337239d9e4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -307,8 +307,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
>  	return -EINVAL;
>  }
>  
> -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> -					     void *lsmrule)
> +static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
> +					     u32 op, void *lsmrule)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..e7b8ce942950 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
>  		u32 osid;
> +		struct lsmblob blob;
>  		int retried = 0;
>  
>  		if (!rule->lsm[i].rule)
> @@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
>  			security_inode_getsecid(inode, &osid);
> -			rc = security_filter_rule_match(osid,
> +			lsmblob_init(&blob, osid);
> +			rc = security_filter_rule_match(&blob,
>  							rule->lsm[i].type,
>  							Audit_equal,
>  							rule->lsm[i].rule);
> @@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			rc = security_filter_rule_match(secid,
> +			lsmblob_init(&blob, secid);
> +			rc = security_filter_rule_match(&blob,
>  							rule->lsm[i].type,
>  							Audit_equal,
>  							rule->lsm[i].rule);
> diff --git a/security/security.c b/security/security.c
> index 7618c761060d..4692f44718c6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2452,9 +2452,19 @@ void security_audit_rule_free(void *lsmrule)
>  	call_void_hook(audit_rule_free, lsmrule);
>  }
>  
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +		rc = hp->hook.audit_rule_match(blob->secid[hp->slot], field,
> +					       op, lsmrule);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  #endif /* CONFIG_AUDIT */
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
