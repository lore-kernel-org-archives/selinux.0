Return-Path: <SRS0=M/73=ZN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EF3C432C0
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14152206CC
	for <selinux@archiver.kernel.org>; Thu, 21 Nov 2019 18:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUSoS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:44:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59219 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKUSoR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 Nov 2019 13:44:17 -0500
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <john.johansen@canonical.com>)
        id 1iXrR5-00038Y-OW; Thu, 21 Nov 2019 18:44:11 +0000
Subject: Re: [PATCH v11 10/25] LSM: Use lsmblob in security_inode_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20191113181925.2437-1-casey@schaufler-ca.com>
 <20191113181925.2437-11-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <b1d20b58-105d-3171-c7d3-9c590c309443@canonical.com>
Date:   Thu, 21 Nov 2019 10:44:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113181925.2437-11-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/13/19 10:19 AM, Casey Schaufler wrote:
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org

Acked-by: John Johansen <john.johansen@canonical.com>


> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditsc.c                    |  6 +++++-
>  security/integrity/ima/ima_policy.c |  4 +---
>  security/security.c                 | 11 +++++++++--
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 67f95a335b5d..a845254fc415 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -407,7 +407,7 @@ int security_inode_killpriv(struct dentry *dentry);
>  int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
>  int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
>  int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
> -void security_inode_getsecid(struct inode *inode, u32 *secid);
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
> @@ -922,9 +922,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
>  	return 0;
>  }
>  
> -static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
> +static inline void security_inode_getsecid(struct inode *inode,
> +					   struct lsmblob *blob)
>  {
> -	*secid = 0;
> +	lsmblob_init(blob, 0);
>  }
>  
>  static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index cccb681ad081..5752e51883d5 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1931,13 +1931,17 @@ static void audit_copy_inode(struct audit_names *name,
>  			     const struct dentry *dentry,
>  			     struct inode *inode, unsigned int flags)
>  {
> +	struct lsmblob blob;
> +
>  	name->ino   = inode->i_ino;
>  	name->dev   = inode->i_sb->s_dev;
>  	name->mode  = inode->i_mode;
>  	name->uid   = inode->i_uid;
>  	name->gid   = inode->i_gid;
>  	name->rdev  = inode->i_rdev;
> -	security_inode_getsecid(inode, &name->osid);
> +	security_inode_getsecid(inode, &blob);
> +	/* scaffolding until osid is updated */
> +	name->osid = blob.secid[0];
>  	if (flags & AUDIT_INODE_NOEVAL) {
>  		name->fcap_ver = -1;
>  		return;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 7711cc6a3fe3..c5417045e165 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -413,7 +413,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		return false;
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
> -		u32 osid;
>  		struct lsmblob blob;
>  
>  		if (!rule->lsm[i].rule)
> @@ -423,8 +422,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		case LSM_OBJ_USER:
>  		case LSM_OBJ_ROLE:
>  		case LSM_OBJ_TYPE:
> -			security_inode_getsecid(inode, &osid);
> -			lsmblob_init(&blob, osid);
> +			security_inode_getsecid(inode, &blob);
>  			rc = security_filter_rule_match(&blob,
>  							rule->lsm[i].type,
>  							Audit_equal,
> diff --git a/security/security.c b/security/security.c
> index e1f216d453bf..bd279a24adfc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1386,9 +1386,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>  }
>  EXPORT_SYMBOL(security_inode_listsecurity);
>  
> -void security_inode_getsecid(struct inode *inode, u32 *secid)
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
>  {
> -	call_void_hook(inode_getsecid, inode, secid);
> +	struct security_hook_list *hp;
> +
> +	lsmblob_init(blob, 0);
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
> +	}
>  }
>  
>  int security_inode_copy_up(struct dentry *src, struct cred **new)
> 

