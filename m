Return-Path: <SRS0=qCpE=US=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83324C31E49
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439B620B1F
	for <selinux@archiver.kernel.org>; Wed, 19 Jun 2019 04:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEwpusmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfFSEdR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:33:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42679 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSEdR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Jun 2019 00:33:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so4411089plb.9
        for <selinux@vger.kernel.org>; Tue, 18 Jun 2019 21:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zErfkhG4VIHcuXdoC+0+X9WxjZtYHXAWzmAt37MQQA=;
        b=eEwpusmFDsy0y6BIYyhmhm340qp5siYNyzoz5/BqCeCA+MGsB2KGpdW7KM3uC1ynFc
         8NG/2NZoq90jItyVzmmaEtiL02IXBPHYvZXt0bNNR4Fqr2VvmbKVtCQPrYAXNh9ExOL8
         112uqau8n5ZvegdjM1Q9a8ahteF4H8I7w2P2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zErfkhG4VIHcuXdoC+0+X9WxjZtYHXAWzmAt37MQQA=;
        b=lmJ2i29eFHQp9MwFERuQodp8DWL9WHm4gJbs9Ua7gG3eaf0+FEFy4OoxSeuCiVgfel
         qeHQT/IJzTd9yqLPaWX+VyaYg1Gbp5YuWQqS3oANRZGVgrn1KekJiEXRwOzN3vYUAi97
         Gz7icN9+K9VzxEPMGGNyAIpXnI/6q2S+UlG1ZtZfMUbndtv9T//8zs4tyDJtnorm/iB9
         ekNeOgzaoXz2ssieuZToLvuxVqoAtfayfKjdpd4vEvaHmHUeNv0/wnzgE563MaWrE++m
         Wfv/Bq2Uxg/NEXwn29QVCPlHeOp9pgxbEEgj+2U6Npdxu/CbUu+sUQXgn0U21z1uc5sh
         o5iQ==
X-Gm-Message-State: APjAAAWxbqdX4M1ZTL/MxA/UX1FHJ6honOjE5GAI4Xh4KmoUsy6oThxE
        ASGEJrxLmnZKVJka8grbFm/G4g==
X-Google-Smtp-Source: APXvYqzLYrPL2birJIf8z+J7AINko3mqRUpgKqCiYVW876aLiwcb/1rCurdRjbCs4bFXt8O6tQH+Vw==
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr112627315plc.272.1560918796505;
        Tue, 18 Jun 2019 21:33:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l1sm15844192pgi.91.2019.06.18.21.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 21:33:15 -0700 (PDT)
Date:   Tue, 18 Jun 2019 21:33:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 15/25] LSM: Specify which LSM to display
Message-ID: <201906182127.073A9D7@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-16-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-16-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 18, 2019 at 04:05:41PM -0700, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of
> the LSM currently in use can be read from "display".
> At this point there can only be one LSM capable of display
> active.
> 
> This affects /proc/.../attr/current and SO_PEERSEC.

What happened to creating /proc/$pid/lsm/$lsm_name/current for "modern"
LSM libraries to start using (instead of possibly fighting over the
/proc/$pid/attr/display)? (Obviously "display" is needed for "old"
libraries, and I'm fine with it.)

Similarly, is there something that can be done for SO_PEERSEC that
doesn't require using "display" for "modern" libraries?

-Kees

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/proc/base.c      |   1 +
>  security/security.c | 108 +++++++++++++++++++++++++++++++++++---------
>  2 files changed, 88 insertions(+), 21 deletions(-)
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
> index 46f6cf21d33c..9cfdc664239e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -46,7 +46,9 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),
> +};
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> @@ -578,6 +580,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *display;
> +
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
>  		return 0;
> @@ -586,6 +590,10 @@ static int lsm_task_alloc(struct task_struct *task)
>  	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>  	if (task->security == NULL)
>  		return -ENOMEM;
> +
> +	display = task->security;
> +	*display = LSMDATA_INVALID;
> +
>  	return 0;
>  }
>  
> @@ -1574,14 +1582,27 @@ int security_file_open(struct file *file)
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
> +	if (ndisplay == NULL)
> +		return 0;
> +
> +	if (odisplay != NULL)
> +		*ndisplay = *odisplay;
> +
> +	return 0;
>  }
>  
>  void security_task_free(struct task_struct *task)
> @@ -1967,10 +1988,28 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	if (!strcmp(name, "display")) {
> +		hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx,
> +				     list) {
> +			if (*display == LSMDATA_INVALID ||
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
> +		if (lsm == NULL && *display != LSMDATA_INVALID &&
> +		    *display != hp->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return -EINVAL;
> @@ -1980,10 +2019,27 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
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
> +		if (lsm == NULL && *display != LSMDATA_INVALID &&
> +		    *display != hp->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return -EINVAL;
> @@ -2002,38 +2058,41 @@ EXPORT_SYMBOL(security_ismaclabel);
>  
>  int security_secid_to_secctx(struct lsmblob *l, char **secdata, u32 *seclen)
>  {
> +	int *display = current->security;
>  	struct security_hook_list *hp;
> -	int rc;
>  
> -	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
> -		rc = hp->hook.secid_to_secctx(l->secid[hp->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> -	}
> +	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list)
> +		if (*display == LSMDATA_INVALID || *display == hp->slot)
> +			return hp->hook.secid_to_secctx(l->secid[hp->slot],
> +							secdata, seclen);
>  	return 0;
>  }
>  EXPORT_SYMBOL(security_secid_to_secctx);
>  
>  int security_secctx_to_secid(const char *secdata, u32 seclen, struct lsmblob *l)
>  {
> +	int *display = current->security;
>  	struct security_hook_list *hp;
> -	int rc;
>  
>  	lsmblob_init(l, 0);
> -	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &l->secid[hp->slot]);
> -		if (rc != 0)
> -			return rc;
> -	}
> +	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list)
> +		if (*display == LSMDATA_INVALID || *display == hp->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +							&l->secid[hp->slot]);
>  	return 0;
>  }
>  EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	int *display = current->security;
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (*display == LSMDATA_INVALID || *display == hp->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2158,8 +2217,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
> +		if (*display == LSMDATA_INVALID || *display == hp->slot)
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
