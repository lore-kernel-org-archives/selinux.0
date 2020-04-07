Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EFEC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922C72076E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 18:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oGzd2UrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDGSkN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:40:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46904 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgDGSkK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 14:40:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so1544322plq.13
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=99FZDMCkFG5YdG6oWd91XuVVzSAFyCVJEFhCwcxAXZg=;
        b=oGzd2UrTxJbRc9y9+kb3+z/NpBlKKRZ4cRxWtuYNbCDO5CkCkJmH/lMYXYrx43PMcG
         VfMMW9tazELg+mnJZCu2B3BVPy/YyZ/Tu8yVeMBZu1/3heh8pt0evwmpWOMqH305i0aW
         /ALz2Ml/wnjaiDfeQkblu2aggMu3ET2rxb87U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=99FZDMCkFG5YdG6oWd91XuVVzSAFyCVJEFhCwcxAXZg=;
        b=aRo0ScnX1Oubl1uFD2HYIxUKlXWbQIL9n8RgT/oP0mS3qrpatMB0nsNdsPiAxXwHHB
         ignKDvjfTordNB1MEYiHOWW9jnF7WfiT3HewEtIyjaNNkQxbEamZPe4oPlFYRmoQNzS1
         FEBqUhyLNrn3z+AHZP+kYgxZMxdY0uCP9/emXx/5KzgruZinQWnu/dUYJTCilJOQBObH
         xzT3Glp7J42+aMzrdAkXBtEmL4vgKNBt66CbuGOzin2hZFMD3C1Yuyi5ekUN+JImJml7
         GhzfytfGOBhsD4FgfayBokoj2eAKZsM0ubk586js5q8ixGm9YZjJPCwitJk4jlZveYbU
         00dQ==
X-Gm-Message-State: AGi0PuZIxACMvrvLS2gwNrWYYvnymZoFIGguPq79i02Bl5sf0ucUpcde
        2kXtNInhryJ1M+TGWgn1GnBMGg==
X-Google-Smtp-Source: APiQypK6L/cYyx22qL0SQAAI2o5EOvlb74ZSu8MBbXXrvebHyHGDdMBL//9S2x1LtUCgcG+4olu+MA==
X-Received: by 2002:a17:90a:b003:: with SMTP id x3mr751787pjq.140.1586284809511;
        Tue, 07 Apr 2020 11:40:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f5sm14396636pfq.63.2020.04.07.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:40:08 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:40:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: Re: [PATCH v16 13/23] LSM: Specify which LSM to display
Message-ID: <202004071140.6A9258B1C0@keescook>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
 <20200407000159.43602-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407000159.43602-14-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 06, 2020 at 05:01:49PM -0700, Casey Schaufler wrote:
> Create a new entry "display" in the procfs attr directory for
> controlling which LSM security information is displayed for a
> process. A process can only read or write its own display value.
> 
> The name of an active LSM that supplies hooks for
> human readable data may be written to "display" to set the
> value. The name of the LSM currently in use can be read from
> "display". At this point there can only be one LSM capable
> of display active. A helper function lsm_task_display() is
> provided to get the display slot for a task_struct.
> 
> Setting the "display" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
> 
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/proc/base.c                       |   1 +
>  include/linux/lsm_hooks.h            |  15 +++
>  security/apparmor/include/apparmor.h |   3 +-
>  security/apparmor/lsm.c              |  32 +++++
>  security/security.c                  | 167 ++++++++++++++++++++++++---
>  security/selinux/hooks.c             |  11 ++
>  security/selinux/include/classmap.h  |   2 +-
>  security/smack/smack_lsm.c           |   7 ++
>  8 files changed, 219 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c7c64272b0fa..505331ab7a14 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2743,6 +2743,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>  	ATTR(NULL, "fscreate",		0666),
>  	ATTR(NULL, "keycreate",		0666),
>  	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>  #ifdef CONFIG_SECURITY_SMACK
>  	DIR("smack",			0555,
>  	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7eb808cde051..2bf82e1cf347 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2186,4 +2186,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>  
>  extern int lsm_inode_alloc(struct inode *inode);
>  
> +/**
> + * lsm_task_display - the "display" LSM for this task
> + * @task: The task to report on
> + *
> + * Returns the task's display LSM slot.
> + */
> +static inline int lsm_task_display(struct task_struct *task)
> +{
> +	int *display = task->security;
> +
> +	if (display)
> +		return *display;
> +	return LSMBLOB_INVALID;
> +}
> +
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
> index 1fbabdb565a8..b1622fcb4394 100644
> --- a/security/apparmor/include/apparmor.h
> +++ b/security/apparmor/include/apparmor.h
> @@ -28,8 +28,9 @@
>  #define AA_CLASS_SIGNAL		10
>  #define AA_CLASS_NET		14
>  #define AA_CLASS_LABEL		16
> +#define AA_CLASS_DISPLAY_LSM	17
>  
> -#define AA_CLASS_LAST		AA_CLASS_LABEL
> +#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
>  
>  /* Control parameters settable through module/boot flags */
>  extern enum audit_mode aa_g_audit;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 146d75e5e021..16b992235c11 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>  	return error;
>  }
>  
> +
> +static int profile_display_lsm(struct aa_profile *profile,
> +			       struct common_audit_data *sa)
> +{
> +	struct aa_perms perms = { };
> +	unsigned int state;
> +
> +	state = PROFILE_MEDIATES(profile, AA_CLASS_DISPLAY_LSM);
> +	if (state) {
> +		aa_compute_perms(profile->policy.dfa, state, &perms);
> +		aa_apply_modes_to_perms(profile, &perms);
> +		aad(sa)->label = &profile->label;
> +
> +		return aa_check_perms(profile, &perms, AA_MAY_WRITE, sa, NULL);
> +	}
> +
> +	return 0;
> +}
> +
>  static int apparmor_setprocattr(const char *name, void *value,
>  				size_t size)
>  {
> @@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
>  	if (size == 0)
>  		return -EINVAL;
>  
> +	/* LSM infrastructure does actual setting of display if allowed */
> +	if (!strcmp(name, "display")) {
> +		struct aa_profile *profile;
> +		struct aa_label *label;
> +
> +		aad(&sa)->info = "set display lsm";
> +		label = begin_current_label_crit_section();
> +		error = fn_for_each_confined(label, profile,
> +					     profile_display_lsm(profile, &sa));
> +		end_current_label_crit_section(label);
> +		return error;
> +	}
> +
>  	/* AppArmor requires that the buffer must be null terminated atm */
>  	if (args[size - 1] != '\0') {
>  		/* null terminate */
> diff --git a/security/security.c b/security/security.c
> index bf71066ea19b..0208652ad53a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -75,7 +75,14 @@ static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +
> +/*
> + * The task blob includes the "display" slot used for
> + * chosing which module presents contexts.
> + */
> +static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init = {
> +	.lbs_task = sizeof(int),
> +};
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> @@ -470,8 +477,10 @@ static int lsm_append(const char *new, char **result)
>  
>  /*
>   * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>   */
>  static int lsm_slot __lsm_ro_after_init;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>  
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -491,6 +500,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  	if (lsmid->slot == LSMBLOB_NEEDED) {
>  		if (lsm_slot >= LSMBLOB_ENTRIES)
>  			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>  		lsmid->slot = lsm_slot++;
>  		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>  			   lsmid->slot);
> @@ -620,6 +630,8 @@ int lsm_inode_alloc(struct inode *inode)
>   */
>  static int lsm_task_alloc(struct task_struct *task)
>  {
> +	int *display;
> +
>  	if (blob_sizes.lbs_task == 0) {
>  		task->security = NULL;
>  		return 0;
> @@ -628,6 +640,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
> @@ -1583,14 +1604,26 @@ int security_file_open(struct file *file)
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
> +	if (odisplay) {
> +		ndisplay = task->security;
> +		if (ndisplay)
> +			*ndisplay = *odisplay;
> +	}
> +
> +	return 0;
>  }
>  
>  void security_task_free(struct task_struct *task)
> @@ -1987,23 +2020,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  				char **value)
>  {
>  	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +
> +		/*
> +		 * Only allow getting the current process' display.
> +		 * There are too few reasons to get another process'
> +		 * display and too many LSM policy issues.
> +		 */
> +		if (current != p)
> +			return -EINVAL;
> +
> +		display = lsm_task_display(p);
> +		if (display != LSMBLOB_INVALID)
> +			slot = display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>  		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
> +		if (lsm == NULL && display != LSMBLOB_INVALID &&
> +		    display != hp->lsmid->slot)
> +			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
>  	return -EINVAL;
>  }
>  
> +/**
> + * security_setprocattr - Set process attributes via /proc
> + * @lsm: name of module involved, or NULL
> + * @name: name of the attribute
> + * @value: value to set the attribute to
> + * @size: size of the value
> + *
> + * Set the process attribute for the specified security module
> + * to the specified value. Note that this can only be used to set
> + * the process attributes for the current, or "self" process.
> + * The /proc code has already done this check.
> + *
> + * Returns 0 on success, an appropriate code otherwise.
> + */
>  int security_setprocattr(const char *lsm, const char *name, void *value,
>  			 size_t size)
>  {
>  	struct security_hook_list *hp;
> +	char *termed;
> +	char *copy;
> +	int *display = current->security;
> +	int rc = -EINVAL;
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * Change the "display" value only if all the security
> +		 * modules that support setting a procattr allow it.
> +		 * It is assumed that all such security modules will be
> +		 * cooperative.
> +		 */
> +		if (size == 0)
> +			return -EINVAL;
> +
> +		hlist_for_each_entry(hp, &security_hook_heads.setprocattr,
> +				     list) {
> +			rc = hp->hook.setprocattr(name, value, size);
> +			if (rc < 0)
> +				return rc;
> +		}
> +
> +		rc = -EINVAL;
> +
> +		copy = kmemdup_nul(value, size, GFP_KERNEL);
> +		if (copy == NULL)
> +			return -ENOMEM;
> +
> +		termed = strsep(&copy, " \n");
> +
> +		for (slot = 0; slot < lsm_slot; slot++)
> +			if (!strcmp(termed, lsm_slotlist[slot]->lsm)) {
> +				*display = lsm_slotlist[slot]->slot;
> +				rc = size;
> +				break;
> +			}
> +
> +		kfree(termed);
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
> @@ -2023,15 +2143,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>  int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>  	}
>  	return 0;
>  }
> @@ -2041,16 +2161,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>  			     struct lsmblob *blob)
>  {
>  	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>  
>  	lsmblob_init(blob, 0);
>  	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>  		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>  			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>  	}
>  	return 0;
>  }
> @@ -2058,7 +2177,14 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>  
>  void security_release_secctx(char *secdata, u32 seclen)
>  {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>  }
>  EXPORT_SYMBOL(security_release_secctx);
>  
> @@ -2183,8 +2309,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>  int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>  				      int __user *optlen, unsigned len)
>  {
> -	return call_int_hook(socket_getpeersec_stream, -ENOPROTOOPT, sock,
> -				optval, optlen, len);
> +	int display = lsm_task_display(current);
> +	struct security_hook_list *hp;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_stream,
> +			     list)
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.socket_getpeersec_stream(sock, optval,
> +								 optlen, len);
> +	return -ENOPROTOOPT;
>  }
>  
>  int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 84eef6af53e7..dc5e3bd2b770 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6299,6 +6299,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> +
> +	/*
> +	 * For setting display, we only perform a permission check;
> +	 * the actual update to the display value is handled by the
> +	 * LSM framework.
> +	 */
> +	if (!strcmp(name, "display"))
> +		return avc_has_perm(&selinux_state,
> +				    mysid, mysid, SECCLASS_PROCESS2,
> +				    PROCESS2__SETDISPLAY, NULL);
> +
>  	if (!strcmp(name, "exec"))
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 986f3ac14282..ba36a55b5ea4 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
>  	    "execmem", "execstack", "execheap", "setkeycreate",
>  	    "setsockcreate", "getrlimit", NULL } },
>  	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>  	{ "system",
>  	  { "ipc_info", "syslog_read", "syslog_mod",
>  	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 12e01d450dd4..00a304861657 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3510,6 +3510,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	struct smack_known_list_elem *sklep;
>  	int rc;
>  
> +	/*
> +	 * Allow the /proc/.../attr/current and SO_PEERSEC "display"
> +	 * to be reset at will.
> +	 */
> +	if (strcmp(name, "display") == 0)
> +		return 0;
> +
>  	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>  		return -EPERM;
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
