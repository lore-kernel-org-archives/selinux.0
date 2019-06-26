Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC33C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B1F2083B
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfFZXpq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:45:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35326 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFZXpq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:45:46 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hgHbg-00026q-7I; Wed, 26 Jun 2019 23:45:40 +0000
Subject: Re: [PATCH v4 05/23] LSM: Use lsmblob in security_audit_rule_match
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-6-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <9b0b1075-0660-2170-3ec9-8e72467062fb@canonical.com>
Date:   Wed, 26 Jun 2019 16:45:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626192234.11725-6-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/19 12:22 PM, Casey Schaufler wrote:
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

Reviewed-by: John Johansen <john.johansen@canonical.com>


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
>  
> 

