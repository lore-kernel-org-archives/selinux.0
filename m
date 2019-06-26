Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBEDC48BD3
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079B221738
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EEQrUzyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfFZXMg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:12:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35580 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXMg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:12:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id s27so87582pgl.2
        for <selinux@vger.kernel.org>; Wed, 26 Jun 2019 16:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bi3dYudpL4QHeYlb1dEjQ71UOwSZdPPMjJGBRIwb3Ts=;
        b=EEQrUzyQ5SpsY7fH3vxibKmq1fdkMh4qZ3FO+xSGC+U2CiPYrhmrgOpAgYuK1AxYl8
         SFD3QK8zx5aeJHCEmWxH2v4q+X3jJnrzYu8o9cNLFLg1iAFDS90UQD1Vl1NDh8tLmFzU
         65cHPfFJgh+ut010MmrAdRSKLKZXlhADfOcXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bi3dYudpL4QHeYlb1dEjQ71UOwSZdPPMjJGBRIwb3Ts=;
        b=VYvfP/RMqD8o8CVz1YAPlDeIWcDUnv6/j3MiF0Lnq2ZjZ/Nc5RoXicWtuQVIjuVR95
         +yTsHe/rud3wE61kX3x7mnlw3PU2HbRV5/pYycJCTSG+aC2pexVVSAzZQBYkOPLYELrr
         x5CosAsN8+ufUlW18Rsn9iH9Tx6fSGkvARY2WnTC9jB/wtgtcdsqIEo6afBdfDUdw4JS
         fKg+hINN4rRzR5+OdWpImnE+/io/f3ci3wOtK3RpF/fwaWsmlCehc1KrssV86qvULsLd
         Noi3ynloB4voXrzvisZqRQM4IsYHMn4x1IgRNWr1mB0FJHXZ5RVWa+yzVgna03yEPTIJ
         yRUg==
X-Gm-Message-State: APjAAAW5A6R7DocgZdRnKwH7NIfxLXF6mbQBy1KBY8uLz3RTst1D6E2z
        aLJywp1/vipXBmQI+0RL9YDKWQ==
X-Google-Smtp-Source: APXvYqyrWLn9gVj8ukTWNwUPY4dDGI6vmDtyCwAv6sVowLFQNytVUQ94AVnjGXByGzzCRkvFBge72w==
X-Received: by 2002:a17:90a:634a:: with SMTP id v10mr2023083pjs.16.1561590755639;
        Wed, 26 Jun 2019 16:12:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm182044pgv.21.2019.06.26.16.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:12:34 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:12:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v4 15/23] LSM: Specify which LSM to display
Message-ID: <201906261612.49AEC4F9CE@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626192234.11725-16-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 26, 2019 at 12:22:26PM -0700, Casey Schaufler wrote:
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
>  security/security.c | 129 ++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 113 insertions(+), 17 deletions(-)
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
> index 3180a6f30625..82e29c477fa4 100644
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
> @@ -423,8 +425,10 @@ static int lsm_append(const char *new, char **result)
>  
>  /*
>   * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>   */
>  static int lsm_slot;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -444,6 +448,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	if (lsmid->slot == LSMBLOB_NEEDED) {
>  		if (lsm_slot >= LSMBLOB_ENTRIES)
>  			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>  		lsmid->slot = lsm_slot++;
>  		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>  			   lsmid->slot);
> @@ -564,6 +569,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *display;
> +
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
>  		return 0;
> @@ -572,6 +579,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
> @@ -1563,14 +1579,24 @@ int security_file_open(struct file *file)
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
> @@ -1967,10 +1993,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int *display = current->security;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +		if (*display != LSMBLOB_INVALID)
> +			slot = *display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return -EINVAL;
> @@ -1980,10 +2025,46 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	char *term;
> +	char *cp;
> +	int *display = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0 || size == 0)
> +			return -EINVAL;
> +		cp = kzalloc(size + 1, GFP_KERNEL);
> +		if (cp == NULL)
> +			return -ENOMEM;
> +		memcpy(cp, value, size);
> +
> +		term = strchr(cp, ' ');
> +		if (term == NULL)
> +			term = strchr(cp, '\n');
> +		if (term != NULL)
> +			*term = '\0';
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(cp, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(cp);
> +		return rc;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
>  	return -EINVAL;
> @@ -2003,15 +2084,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>  	}
>  	return 0;
>  }
> @@ -2021,16 +2102,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int *display = current->security;
>  
>  	lsmblob_init(blob, 0);
>  	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>  	}
>  	return 0;
>  }
> @@ -2038,7 +2118,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (*display == LSMBLOB_INVALID ||
> +		    *display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2163,8 +2251,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
> +		if (*display == LSMBLOB_INVALID || *display == hp->lsmid->slot)
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
