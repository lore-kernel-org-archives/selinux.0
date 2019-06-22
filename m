Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6352C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7904C20673
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PV8+guwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFVWtx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:49:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33858 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFVWtx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:49:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so4760885plt.1
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JT/yXh+HNgCMePl9SLI0WQnVrvuNsVC/n90eobSvwc=;
        b=PV8+guwIhgAfLD46JFvEV/GdwI5ZspOGQVqT4g+fnpOUK8FMc7QxuK/ZlNG8yLOLn3
         sjwlnU1mM0UXG05mL8yA1Zk/aPULP/H5BV6ziurjJmz7GI9TrvJdTOd7at6D6hMCJxiH
         djsBYUWoz7NtO7O+wPZEo/dgjmDlu1dkgxmeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JT/yXh+HNgCMePl9SLI0WQnVrvuNsVC/n90eobSvwc=;
        b=MNhWzmV3kAoreIN4ZUnPfjHiEBHDtJ2xTG5AeXlHaKoZjsKyHS2ga12E9LTLo54F5Y
         jr7gfWtam2uK//Mw9LvSmgbGR0XzEBfcRawbzdmXeeTy7waoA0a0Rchl/4d1Qn7MXVA9
         JugUlx5ig+sJt4tLYvS4nMhDKLKDNUQ9+pGdTU3iARV5DX0rCmHyi204mDuC7F9nEdhn
         HIqueKF2CTq5xG7+3XeB72iMJwLTZpPaNEbHW5wd69OnwfFFxzQfO13qx/ST1oE5v5Kw
         BYiRxgE7BIbIHF0wuJkBDhyd8/knjM31uhxUOtZRmCzWr5Guvh1zWh+yZpa4NwaXkuF7
         FWTQ==
X-Gm-Message-State: APjAAAX2br1uORYPw8Zodw+dcbL7fdCwoBpkXqKxQA3pHl4dD2H9EJmi
        wsRCn8t3yGBL6d9qotc4VIK6dA==
X-Google-Smtp-Source: APXvYqzlcCXlY4X86faX5RbsZ3VliwadyFg6DorAT4Apo0vuM7jMg1mDATBX7j6z4S+WYpzbfwfuJA==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr79785628pls.72.1561243791766;
        Sat, 22 Jun 2019 15:49:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c130sm9921763pfc.184.2019.06.22.15.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:49:51 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:49:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 12/24] LSM: Use lsmblob in security_inode_getsecid
Message-ID: <201906221549.301446E19@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-13-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-13-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:21AM -0700, Casey Schaufler wrote:
> Change the security_inode_getsecid() interface to fill in a
> lsmblob structure instead of a u32 secid. This allows for its
> callers to gather data from all registered LSMs. Data is provided
> for IMA and audit.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/security.h            | 7 ++++---
>  kernel/auditsc.c                    | 6 +++++-
>  security/integrity/ima/ima_policy.c | 4 +---
>  security/security.c                 | 8 ++++++--
>  4 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c5fdaaff8806..6eb64b7f878a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -358,7 +358,7 @@ int security_inode_killpriv(struct dentry *dentry);
>  int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
>  int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
>  int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
> -void security_inode_getsecid(struct inode *inode, u32 *secid);
> +void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
>  int security_file_permission(struct file *file, int mask);
> @@ -854,9 +854,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
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
> index 1184ef092bce..6f0635b51180 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1423,9 +1423,13 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
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
> +	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list)
> +		hp->hook.inode_getsecid(inode, &blob->secid[hp->slot]);
>  }
>  
>  int security_inode_copy_up(struct dentry *src, struct cred **new)
> -- 
> 2.20.1
> 

-- 
Kees Cook
