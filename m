Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16287C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D101721738
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="APX2tAKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfFZXHU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:07:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34908 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfFZXHU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:07:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so165670plp.2
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J7g5jfpPUiazBSWxNvAJFjh5va8uwd5HxYcLEmaYaIk=;
        b=APX2tAKskrqnlGMuPq0YJR9J6aaMECXdNzVK5uMhV9AKwaH+QKuigf7pNixFUssWzO
         0TIutXjHa4C1E8/qp8jTcxqJdhkl5hUMGTd3ByiLSa9nz8egQkBNlo3hYQqoMUm+EiOX
         jBxl2pQvV8SOZqV3E0NqSHrcecNrJH83YqVNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J7g5jfpPUiazBSWxNvAJFjh5va8uwd5HxYcLEmaYaIk=;
        b=aPQDt6ppo9CuxNI8Kxvme4NC4DLaX9tHhguk8/ZSRcvOdMN5OIPYaPxW1pZatdk6n+
         3fC06uzhQDyFQEN12gtXhZKBbUruXJXgS1bU37CwlruVMJTXA7hIJZo+QZpoznE1EGhi
         5LbZzJqmRaV+GCKtYx7CFGF+HQTfCPWrzTWuDx24lSxS0TQS7lgsO94YFvKY2w+t8muR
         eiP47ACBoRl/5nbmiWsaBXSQlTDUqKaBAniBMvj/EwYdtQRQTo2GMqTG5oBWCmZBliTH
         G81rIhV0qCLliGwFce6OIN8TSd9Tjf1IIaeV4qBj8VpFA6ZyeDxpAPtTQI/oEt7jv0co
         sihg==
X-Gm-Message-State: APjAAAWkogXDgyupnqDqa1O5vHchv2GOtQUbVX4b9vmHWG4RBFRWr1/m
        iMm4QdYyihkmMSQF4nt0cvqn4A==
X-Google-Smtp-Source: APXvYqwP2bfbyX4YV6gqAxbHZ2Y9FKh1wgEEMHY4NrdyYjZX//noHTU8PPPd3KsNa6Fy5bHbyK0X/g==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr697011plb.118.1561590439481;
        Wed, 26 Jun 2019 16:07:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm6956765pjl.18.2019.06.26.16.07.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:07:18 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:07:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 06/23] LSM: Use lsmblob in security_kernel_act_as
Message-ID: <201906261607.27EFA994@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-7-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:17PM -0700, Casey Schaufler wrote:
> Change the security_kernel_act_as interface to use a lsmblob
> structure in place of the single u32 secid in support of
> module stacking. Change it's only caller, set_security_override,
> to do the same. Change that one's only caller,
> set_security_override_from_ctx, to call it with the new
> parameter type.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/cred.h     |  3 ++-
>  include/linux/security.h |  5 +++--
>  kernel/cred.c            | 10 ++++++----
>  security/security.c      | 14 ++++++++++++--
>  4 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index efb6edf32de7..9a21c376ed97 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -22,6 +22,7 @@
>  
>  struct cred;
>  struct inode;
> +struct lsmblob;
>  
>  /*
>   * COW Supplementary groups list
> @@ -165,7 +166,7 @@ extern const struct cred *override_creds(const struct cred *);
>  extern void revert_creds(const struct cred *);
>  extern struct cred *prepare_kernel_cred(struct task_struct *);
>  extern int change_create_files_as(struct cred *, struct inode *);
> -extern int set_security_override(struct cred *, u32);
> +extern int set_security_override(struct cred *, struct lsmblob *);
>  extern int set_security_override_from_ctx(struct cred *, const char *);
>  extern int set_create_files_as(struct cred *, struct inode *);
>  extern int cred_fscmp(const struct cred *, const struct cred *);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 4f8b478bc3a1..313e45a3cac3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -388,7 +388,7 @@ void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred *old);
>  void security_cred_getsecid(const struct cred *c, u32 *secid);
> -int security_kernel_act_as(struct cred *new, u32 secid);
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
>  int security_kernel_load_data(enum kernel_load_data_id id);
> @@ -971,7 +971,8 @@ static inline void security_transfer_creds(struct cred *new,
>  {
>  }
>  
> -static inline int security_kernel_act_as(struct cred *cred, u32 secid)
> +static inline int security_kernel_act_as(struct cred *cred,
> +					 struct lsmblob *blob)
>  {
>  	return 0;
>  }
> diff --git a/kernel/cred.c b/kernel/cred.c
> index 45d77284aed0..71c14dda107e 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -701,14 +701,14 @@ EXPORT_SYMBOL(prepare_kernel_cred);
>  /**
>   * set_security_override - Set the security ID in a set of credentials
>   * @new: The credentials to alter
> - * @secid: The LSM security ID to set
> + * @blob: The LSM security information to set
>   *
>   * Set the LSM security ID in a set of credentials so that the subjective
>   * security is overridden when an alternative set of credentials is used.
>   */
> -int set_security_override(struct cred *new, u32 secid)
> +int set_security_override(struct cred *new, struct lsmblob *blob)
>  {
> -	return security_kernel_act_as(new, secid);
> +	return security_kernel_act_as(new, blob);
>  }
>  EXPORT_SYMBOL(set_security_override);
>  
> @@ -724,6 +724,7 @@ EXPORT_SYMBOL(set_security_override);
>   */
>  int set_security_override_from_ctx(struct cred *new, const char *secctx)
>  {
> +	struct lsmblob blob;
>  	u32 secid;
>  	int ret;
>  
> @@ -731,7 +732,8 @@ int set_security_override_from_ctx(struct cred *new, const char *secctx)
>  	if (ret < 0)
>  		return ret;
>  
> -	return set_security_override(new, secid);
> +	lsmblob_init(&blob, secid);
> +	return set_security_override(new, &blob);
>  }
>  EXPORT_SYMBOL(set_security_override_from_ctx);
>  
> diff --git a/security/security.c b/security/security.c
> index 46ca4b85ad96..f9c8e1926a0b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1627,9 +1627,19 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
>  }
>  EXPORT_SYMBOL(security_cred_getsecid);
>  
> -int security_kernel_act_as(struct cred *new, u32 secid)
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob)
>  {
> -	return call_int_hook(kernel_act_as, 0, new, secid);
> +	struct security_hook_list *hp;
> +	int rc;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.kernel_act_as, list) {
> +		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
> +			continue;
> +		rc = hp->hook.kernel_act_as(new, blob->secid[hp->lsmid->slot]);
> +		if (rc != 0)
> +			return rc;
> +	}
> +	return 0;
>  }
>  
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode)
> -- 
> 2.20.1
> 

-- 
Kees Cook
