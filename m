Return-Path: <SRS0=BI9l=UV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DFBC43613
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FA320673
	for <selinux@archiver.kernel.org>; Sat, 22 Jun 2019 22:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e4zEs18R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfFVWvv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 22 Jun 2019 18:51:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41117 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVWvv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 22 Jun 2019 18:51:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id m7so4738172pls.8
        for <selinux@vger.kernel.org>; Sat, 22 Jun 2019 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ocgfQ56wm4nUS7BHqlmUQs1PFL6br1iRDRZo29C08RU=;
        b=e4zEs18RR1ep4ydMEqyG6i5VzkrJ1lqLE7c60t0VtgccNIHB/RNzEfDMGrjggOoVbn
         mjgfQyloqibJp93rhzgIVHtd6ExX7+r1ZdB1TGkvtQKgtJixkuTlw1tO2XVVQHIK2LvD
         X+1bSH1q+SHrIr6CdKtxFMlG9kzqHM/BR8vGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocgfQ56wm4nUS7BHqlmUQs1PFL6br1iRDRZo29C08RU=;
        b=jh/AdA6hanliPXrlJR0kZ67CO0TmLHvusBA2MiaDebwfs0rM2ExxfOaGqwX/e0C2xZ
         OAfEoSMLdBIclYT7IafPXs3Bx9BO7Dzh42TeKlxjZ3RMt0egO9NQh65v+4irmQd6ubkU
         xAVIr9GbyHvOmOjbq4+rlrd6nz7KtZFZG6K9h8JWZvyvAXtkuv+Zy93PAvwqQ9TvquKF
         eSmOrqnV48JckUJ7bVvz2JlLTo72PlJMkhDRW9MCYVg57rDpa4WZSDJzTf+juSvBWNc4
         X/Co7+Gl5LFL8eWMhTNsXTB9QcMwHI+FBbWWB9Z3vrxThJVF3o8+6GXgLDHKV7PwRvk5
         DFsA==
X-Gm-Message-State: APjAAAWs8U8Nc1jWQMaI+5w77rgP1LSryPD4dHEZpR14YE7N8umWeCmg
        sbzBTa12Ctd68mlNiaC+V6ML6g==
X-Google-Smtp-Source: APXvYqw1idqmaXLyVUsmdQovJUWHvFDX2Ep4CcQ+C/9LHGNSoPujBwNHIo7vW92EHsus0vhkoGOaSw==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr47271906plo.42.1561243910752;
        Sat, 22 Jun 2019 15:51:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 137sm6978526pfz.116.2019.06.22.15.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 15:51:50 -0700 (PDT)
Date:   Sat, 22 Jun 2019 15:51:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v3 15/24] LSM: Specify which LSM to display
Message-ID: <201906221551.E15AC5472D@keescook>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-16-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621185233.6766-16-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 21, 2019 at 11:52:24AM -0700, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of
> the LSM currently in use can be read from "display".
> At this point there can only be one LSM capable of display
> active.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/proc/base.c      |   1 +
>  security/security.c | 110 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..7bf70e041315 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "fscreate",		0666),
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/security/security.c b/security/security.c
> index aa8e1c73a062..92c5aa427b53 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),	/* slot number for the "display" LSM */
> +};
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> @@ -583,6 +585,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *display;
> +
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
>  		return 0;
> @@ -591,6 +595,15 @@ static int lsm_task_alloc(struct task_struct *task)
>  	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>  	if (task->security == NULL)
>  		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "display" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	display = task->security;
> +	*display = LSMBLOB_INVALID;
> +
>  	return 0;
>  }
>  
> @@ -1579,14 +1592,24 @@ int security_file_open(struct file *file)
>  
>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
> +	int *odisplay = current->security;
> +	int *ndisplay;
>  	int rc = lsm_task_alloc(task);
>  
> -	if (rc)
> +	if (unlikely(rc))
>  		return rc;
> +
>  	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>  		security_task_free(task);
> -	return rc;
> +		return rc;
> +	}
> +
> +	ndisplay = task->security;
> +	if (ndisplay && odisplay)
> +		*ndisplay = *odisplay;
> +
> +	return 0;
>  }
>  
>  void security_task_free(struct task_struct *task)
> @@ -1972,10 +1995,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	if (!strcmp(name, "display")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
> +				     list) {
> +			if (*display == LSMBLOB_INVALID ||
> +			    hp->slot == *display) {
> +				*value = kstrdup(hp->lsm, GFP_KERNEL);
> +				if (*value)
> +					return strlen(hp->lsm);
> +				return -ENOMEM;
> +			}
> +		}
> +		return -EINVAL;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return -EINVAL;
> @@ -1985,10 +2026,27 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	int *display = current->security;
> +	int len;
> +
> +	if (!strcmp(name, "display")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
> +				     list) {
> +			len = strlen(hp->lsm);
> +			if (size >= len && !strncmp(value, hp->lsm, len)) {
> +				*display = hp->slot;
> +				return size;
> +			}
> +		}
> +		return -EINVAL;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return -EINVAL;
> @@ -2008,14 +2066,12 @@ EXPORT_SYMBOL(security_ismaclabel);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> -	}
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
> +		if (*display == LSMBLOB_INVALID || *display == hp->slot)
> +			return hp->hook.secid_to_secctx(blob->secid[hp->slot],
> +							secdata, seclen);
>  	return 0;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
> @@ -2024,22 +2080,27 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>  
>  	lsmblob_init(blob, 0);
> -	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->slot]);
> -		if (rc != 0)
> -			return rc;
> -	}
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
> +		if (*display == LSMBLOB_INVALID || *display == hp->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +							&blob->secid[hp->slot]);
>  	return 0;
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (*display == LSMBLOB_INVALID || *display == hp->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2164,8 +2225,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (*display == LSMBLOB_INVALID || *display == hp->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>  }
>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> -- 
> 2.20.1
> 

-- 
Kees Cook
