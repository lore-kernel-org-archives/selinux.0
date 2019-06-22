Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F2C43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8002084E
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BH1YvM/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVWne (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:43:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46155 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfFVWne (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:43:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so5364405pfy.13
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sb/DDpm1HJTp52sjjyWqtpYS6I12/DkrFr0yO+Z2bPg=;
        b=BH1YvM/g/OCQu/5xd5iGzGZHLbXDCSIYpMITAsoPK/x2YDFVDmuZ0j4eBMtNvalVQU
         qtv3oh1XnjxysHjsE446BiFxGIRatSxXMGgvLSDFo6iGZxI68U55Ozhjdkn7Fxdnynit
         sI+FbMtLQc1BwgvL8bctOpXcR2aQYu9lU8+4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sb/DDpm1HJTp52sjjyWqtpYS6I12/DkrFr0yO+Z2bPg=;
        b=NjM+VYCAJOMy/vL1jzdMXHQpmbZ/i9sTPv4e8djTGrrHfK/kN0jS1NBSvnPkOgethN
         FYSvo6gXAzSkwsXsSInrzAaoTqTs+t6VTkeVw7g7iScaqh1nA12HxHKl66P8N60tJPAJ
         9WWKSsDZefmkqXOA+SJOMIOxMG7I2Agbu+3JZJRn9Jl4HavT7M46ejfhUaf9/KdG2x7T
         FnFPhZgpImMJ2sWNcavu+ThH7co0aK4Yaxf9QGTGH2Tka7uTemcpFW2R2eQw4TXfdOlu
         m73iq5F2MyiV+n5g4x0nP/RALtylRVlOOKFmv8rcPoWL2c0hVmF+p9GTjgyjDr5owYUi
         pJQQ==
X-Gm-Message-State: APjAAAXjHGzUxG+P7qo9Wk+TFZiyLPDonN0KmTOx5pp9divuP+/h3u65
        SYs86+7iBeIvU2FgLapmNziYWV5mWFA=
X-Google-Smtp-Source: APXvYqx2h3IQrpEkJMdmYArR0MnL7SXsW92WMKzfJ/XexNcpJz3Oht1e67hGVQSXmLoUhMPNHr6WUA==
X-Received: by 2002:a17:90a:cd03:: with SMTP id d3mr14683597pju.127.1561243412688;
        Sat, 22 Jun 2019 15:43:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a3sm9305595pfi.63.2019.06.22.15.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:43:31 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:43:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 06/24] LSM: Use lsmblob in security_kernel_act_as
Message-ID: <201906221543.C399BEC@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-7-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:15AM -0700, Casey Schaufler wrote:
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
>  security/security.c      | 12 ++++++++++--
>  4 files changed, 21 insertions(+), 9 deletions(-)
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
> index 52d89c4a9594..4a78516cc74a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -384,7 +384,7 @@ void security_cred_free(struct cred *cred);
>  int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
>  void security_transfer_creds(struct cred *new, const struct cred *old);
>  void security_cred_getsecid(const struct cred *c, u32 *secid);
> -int security_kernel_act_as(struct cred *new, u32 secid);
> +int security_kernel_act_as(struct cred *new, struct lsmblob *blob);
>  int security_kernel_create_files_as(struct cred *new, struct inode *inode);
>  int security_kernel_module_request(char *kmod_name);
>  int security_kernel_load_data(enum kernel_load_data_id id);
> @@ -967,7 +967,8 @@ static inline void security_transfer_creds(struct cred *new,
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
> index 4692f44718c6..43f8018b9e13 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1646,9 +1646,17 @@ void security_cred_getsecid(const struct cred *c, u32 *secid)
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
> +		rc = hp->hook.kernel_act_as(new, blob->secid[hp->slot]);
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
