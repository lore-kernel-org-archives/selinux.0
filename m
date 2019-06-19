Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFF7C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159E8208CB
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCF+h9cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfFSEz7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:55:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38746 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSEz7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 00:55:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so8930236pgl.5
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 21:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NegLd6433/LPisiJT0Sc8QezeDICKIf/eBu+jht3WcI=;
        b=MCF+h9cvW407LShSLOGTc95Z0Vt8lE+jJWo//UvBhbIFqGra/palm9KAk1gtXKNqny
         Qs8dXghd0UEZD3XAqdL7PmfVhlUfSpsVeGfrjk9GPY8Qa2UwVzMfbYNgyvBkMxiOzoXN
         JjH/sl/vQaGrAsIY9UyVopI5vYwPz61wu83lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NegLd6433/LPisiJT0Sc8QezeDICKIf/eBu+jht3WcI=;
        b=TRtkk8UtM8dDAn503OvuYNFxLnBhtC4MjKp/qgv32+VD5r1jbUkPcF4sYY1s6mgHjv
         eqqJTTDKC0f/ZNN9JcJCcbjL+Mjltx5jhd5lXG7qoZOaTsE/GybyiwmJDYh2DVqQy7HV
         9J1m0eXyS2ALAyx38TcXJtFgZxABhUuk3I5LxWimcFTbyDzQ4dnpNDFTG5e4WgwIVlK4
         TPEYrQmXCei1Eg8VE93r7ImURHrs849smM/c67Rw5+r0Ona4EP4oaDtocA5iuVbtlX3R
         K+0Lv1wd8DrevPlEDFVgT3T45QLqcULU/AJGaa82ry9NIejxazG3S6oueqax8mZ9Z/vq
         7FEQ==
X-Gm-Message-State: APjAAAV3blq5oeuXBbG//x8+yrKzilaXB5CA/oqCHZLHK+Gg8R1YCaF3
        0FZl8WkV9IeZSSD2tlxMMZN5EA==
X-Google-Smtp-Source: APXvYqz2+mb0oa6iXiz8mFFpG2gmtrRSaSfenOCdZ6xk/xBJDtZxoJWmH2hSdRKKV5nZGEY3cI2xCg==
X-Received: by 2002:a65:418d:: with SMTP id a13mr6070919pgq.332.1560920158635;
        Tue, 18 Jun 2019 21:55:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e22sm16913923pgb.9.2019.06.18.21.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 21:55:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 21:55:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 05/25] Use lsmblob in security_audit_rule_match
Message-ID: <201906182154.E9766F5@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-6-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:31PM -0700, Casey Schaufler wrote:
> Change the secid parameter of security_audit_rule_match
> to a lsmblob structure pointer. Pass the entry from the
> lsmblob structure for the approprite slot to the LSM hook.
> 
> Change the users of security_audit_rule_match to use the
> lsmblob instead of a u32. In some cases this requires a
> temporary conversion using lsmblob_init() that will go
> away when other interfaces get converted.

I like this much better with the LSM-infrastructure "slot" logic.

I do think it's be easier to read if the lsmblob instances were called
"blob" instead of "le" and "l"...

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditfilter.c                |  4 +++-
>  kernel/auditsc.c                    | 13 +++++++++----
>  security/integrity/ima/ima.h        |  4 ++--
>  security/integrity/ima/ima_policy.c |  7 +++++--
>  security/security.c                 | 14 ++++++++++++--
>  6 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 28d074866895..067fabc63e51 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1757,7 +1757,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  #ifdef CONFIG_SECURITY
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +int security_audit_rule_match(struct lsmblob *l, u32 field, u32 op,
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
> +static inline int security_audit_rule_match(struct lsmblob *l, u32 field,
> +					    u32 op, void *lsmrule)
>  {
>  	return 0;
>  }
> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 63f8b3f26fab..934ceae1ff70 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			struct audit_field *f = &e->rule.fields[i];
>  			pid_t pid;
>  			u32 sid;
> +			struct lsmblob le;
>  
>  			switch (f->type) {
>  			case AUDIT_PID:
> @@ -1354,7 +1355,8 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
>  					security_task_getsecid(current, &sid);
> -					result = security_audit_rule_match(sid,
> +					lsmblob_init(&le, sid);
> +					result = security_audit_rule_match(&le,
>  						   f->type, f->op, f->lsm_rule);
>  				}
>  				break;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d1eab1d4a930..93c74205ef40 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
>  	const struct cred *cred;
>  	int i, need_sid = 1;
>  	u32 sid;
> +	struct lsmblob le;
>  	unsigned int sessionid;
>  
>  	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
> @@ -630,7 +631,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>  					security_task_getsecid(tsk, &sid);
>  					need_sid = 0;
>  				}
> -				result = security_audit_rule_match(sid, f->type,
> +				lsmblob_init(&le, sid);
> +				result = security_audit_rule_match(&le, f->type,
>  								   f->op,
>  								   f->lsm_rule);
>  			}
> @@ -645,15 +647,17 @@ static int audit_filter_rules(struct task_struct *tsk,
>  			if (f->lsm_rule) {
>  				/* Find files that match */
>  				if (name) {
> +					lsmblob_init(&le, name->osid);
>  					result = security_audit_rule_match(
> -								name->osid,
> +								&le,
>  								f->type,
>  								f->op,
>  								f->lsm_rule);
>  				} else if (ctx) {
>  					list_for_each_entry(n, &ctx->names_list, list) {
> +						lsmblob_init(&le, n->osid);
>  						if (security_audit_rule_match(
> -								n->osid,
> +								&le,
>  								f->type,
>  								f->op,
>  								f->lsm_rule)) {
> @@ -665,7 +669,8 @@ static int audit_filter_rules(struct task_struct *tsk,
>  				/* Find ipc objects that match */
>  				if (!ctx || ctx->type != AUDIT_IPC)
>  					break;
> -				if (security_audit_rule_match(ctx->ipc.osid,
> +				lsmblob_init(&le, ctx->ipc.osid);
> +				if (security_audit_rule_match(&le,
>  							      f->type, f->op,
>  							      f->lsm_rule))
>  					++result;
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d213e835c498..fe5e921d621d 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -307,8 +307,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
>  	return -EINVAL;
>  }
>  
> -static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
> -					     void *lsmrule)
> +static inline int security_filter_rule_match(struct lsmblob *l, u32 field,
> +					     u32 op, void *lsmrule)
>  {
>  	return -EINVAL;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..ae525a89e07f 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
>  		u32 osid;
> +		struct lsmblob le;
>  		int retried = 0;
>  
>  		if (!rule->lsm[i].rule)
> @@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
>  			security_inode_getsecid(inode, &osid);
> -			rc = security_filter_rule_match(osid,
> +			lsmblob_init(&le, osid);
> +			rc = security_filter_rule_match(&le,
>  							rule->lsm[i].type,
>  							Audit_equal,
>  							rule->lsm[i].rule);
> @@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
> -			rc = security_filter_rule_match(secid,
> +			lsmblob_init(&le, secid);
> +			rc = security_filter_rule_match(&le,
>  							rule->lsm[i].type,
>  							Audit_equal,
>  							rule->lsm[i].rule);
> diff --git a/security/security.c b/security/security.c
> index 5aa3c052d702..45541053df89 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2447,9 +2447,19 @@ void security_audit_rule_free(void *lsmrule)
>  	call_void_hook(audit_rule_free, lsmrule);
>  }
>  
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int security_audit_rule_match(struct lsmblob *l, u32 field, u32 op,
> +			      void *lsmrule)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
> +		rc = hp->hook.audit_rule_match(l->secid[hp->slot], field,
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
