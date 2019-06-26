Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB220C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7CC20665
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b1y7l0tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfFZXHH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:07:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35282 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfFZXHH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:07:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so82418pgl.2
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ogy6qzntWCyU0DiPK1gM5YcZl8rMnHCErskNP9/Ua40=;
        b=b1y7l0traTOyiuPFnavfNGD4lzC1yu2hZsXqty0CPHNreYu1ip7YyzAsxTE8tXREmC
         cPeQb4jHOwzfhVLIn1jLlq85nSgWsRtxcvQATLQglvlh47okEVH26eYoLehc2KcdsLUl
         RGZgq5p28ZjRbooXR3aXWZkZ0MmoOFBqbeuaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ogy6qzntWCyU0DiPK1gM5YcZl8rMnHCErskNP9/Ua40=;
        b=RrVS4M2ZYTu9NUMivQxPAvzBApAeSvysgwnjjv+9NWfVdBcQ9GS9Dokkforld3fd+A
         dA4NunU9nhNxMAFwHKcFAN24TC97d66h1X73iYunzv87S1yVYZY/niV+B61JxegBLxE0
         Jj01Yq9eccrG38lPr/4RapSmCLnbr34XCEr+L+ATl6UX2pUYjqQD3FSHNZQr5MEL+cV5
         ZyRi7T+yb9HIfdqwBHaU592INzjOahUMa4tNm/BCFEenfaUObblE6SYe//imxfA7s1Lo
         Y0mpledHPl5DUF+2P16E+REchh81DsmJ9NgYydZ6zGutJ+2RL1LyBUYI1NskKntGM28L
         oClA==
X-Gm-Message-State: APjAAAUT+Gaqib4teOXxrHqgx+VSNPXL4w8je1bfyunSvi1kTx43XPd3
        QRHWJLe+lQHPIbZ1pAhyD59+MA==
X-Google-Smtp-Source: APXvYqzz70jVmLB8E4uCKShr1gLR/kKGwPYmTy/jS7+RBHqnvwfglo5liF61WNBEvQt3BKaekWZrHQ==
X-Received: by 2002:a63:c344:: with SMTP id e4mr486636pgd.204.1561590424667;
        Wed, 26 Jun 2019 16:07:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s12sm297544pfe.143.2019.06.26.16.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:07:03 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:07:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 05/23] LSM: Use lsmblob in security_audit_rule_match
Message-ID: <201906261606.12CF19E4E4@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-6-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:16PM -0700, Casey Schaufler wrote:
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
> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditfilter.c                |  7 +++++--
>  kernel/auditsc.c                    | 14 ++++++++++----
>  security/integrity/ima/ima.h        |  4 ++--
>  security/integrity/ima/ima_policy.c |  7 +++++--
>  security/security.c                 | 18 +++++++++++++++---
>  6 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 5bb8b9a6fa84..4f8b478bc3a1 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1761,7 +1761,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
>  #ifdef CONFIG_SECURITY
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>  int security_audit_rule_known(struct audit_krule *krule);
> -int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
> +			      void *lsmrule);
>  void security_audit_rule_free(void *lsmrule);
>  
>  #else
> @@ -1777,8 +1778,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
> index 63f8b3f26fab..8786b95b60bd 100644
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
> @@ -1354,8 +1355,10 @@ int audit_filter(int msgtype, unsigned int listtype)
>  			case AUDIT_SUBJ_CLR:
>  				if (f->lsm_rule) {
>  					security_task_getsecid(current, &sid);
> -					result = security_audit_rule_match(sid,
> -						   f->type, f->op, f->lsm_rule);
> +					lsmblob_init(&blob, sid);
> +					result = security_audit_rule_match(
> +							&blob, f->type,
> +							f->op, f->lsm_rule);
>  				}
>  				break;
>  			case AUDIT_EXE:
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
> index 27e2db3d6b04..46ca4b85ad96 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -424,7 +424,7 @@ static int lsm_append(const char *new, char **result)
>  /*
>   * Current index to use while initializing the lsmblob secid list.
>   */
> -static int lsm_slot __initdata;
> +static int lsm_slot;

This should be __ro_after_init now.

>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -2433,9 +2433,21 @@ void security_audit_rule_free(void *lsmrule)
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
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
> +					       field, op, lsmrule);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  #endif /* CONFIG_AUDIT */

Thanks for the WARN()s! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
