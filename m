Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B25C48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AF621738
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QKLcPUKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFZXI6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:08:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32968 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFZXI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:08:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so88449pgk.0
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22QdeMwSJD3OM2e71/fklkJ67Uw0MpwXZ9o7bDuYpRE=;
        b=QKLcPUKMwOOhtMymEuW8CNse2bfhEAgOzkfdRBs2JXva/n7Yr7QOeb8UpEqA7RswWK
         GwHLn0khvbJZzUKma5LwCBEr/TT+DQNaSAIzMrv7zx5eQusks3lu6gpICq9hEg542ox9
         kDIe/qsi1OgF4b/yomFZOOFfz/0Drrf+gAvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22QdeMwSJD3OM2e71/fklkJ67Uw0MpwXZ9o7bDuYpRE=;
        b=I/8YIff3dRAfgJai3uZa9brSZQqUO01Gt4JOwgT5ZmWrqbJ0fhhRXAsv2WBesJuERs
         91J+/V/oYVW9qMwS9fPEB+K/OVREX0Zi7SDyqzOufX3n4+7NullZtke86uR96/zJPfJ/
         AWBjy0FHhCa1rjdq0RkzXnOW0T/dAMHzEWjhyHG6tVc2J17sz1L+YLreT/MDbXr/C1ps
         TBZrPuIQZkBV7uQl66oovMJVNJWZ1s/WvjpNpt/f84+AoLf74CZoRzfhzKV1tPtUag2L
         RedS+Qg0Z9d1FqKMr04/wNT1YS37WhghMQyDhn6fq/tcmSSAzv6FkJ3mvxw5WeODSWpz
         z2Sg==
X-Gm-Message-State: APjAAAU1nXGRsSeEHm1ke2n+EsoXFR3ptwmiZVS+tsF6SOyLkGE73BD6
        NLdOIV685SIAsJWwieL0S2yxWQ==
X-Google-Smtp-Source: APXvYqxFeHfzoCpYaQ8tWsgHeEkK84h9KqzCNA6ufIxteBafXoDIJfP4jh9UW0rHAXm5LRY6wZzEJw==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr405002pgq.399.1561590537309;
        Wed, 26 Jun 2019 16:08:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6sm2892925pjp.18.2019.06.26.16.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:08:56 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:08:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 12/23] LSM: Use lsmblob in security_inode_getsecid
Message-ID: <201906261608.BCAC7ED@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-13-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-13-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:23PM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h            |  7 ++++---
>  kernel/auditsc.c                    |  6 +++++-
>  security/integrity/ima/ima_policy.c |  4 +---
>  security/security.c                 | 11 +++++++++--
>  4 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index cfd7cf4b0be9..2d81cac418e3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -362,7 +362,7 @@ int security_inode_killpriv(struct dentry *dentry);
>  int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
>  int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
>  int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
> -void security_inode_getsecid(struct inode *inode, u32 *secid);
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
>  int security_file_permission(struct file *file, int mask);
> @@ -858,9 +858,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
> index 7112fe31684d..54797c0fc3b7 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1910,13 +1910,17 @@ static inline int audit_copy_fcaps(struct audit_names *name,
>  void audit_copy_inode(struct audit_names *name, const struct dentry *dentry,
>  		      struct inode *inode, unsigned int flags)
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
> index e7b8ce942950..92ee3d984c73 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -326,7 +326,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  		return false;
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
> -		u32 osid;
>  		struct lsmblob blob;
>  		int retried = 0;
>  
> @@ -337,8 +336,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
> index 2f123003b0b3..91388553d3d7 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1404,9 +1404,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
> -- 
> 2.20.1
> 

-- 
Kees Cook
