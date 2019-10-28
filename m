Return-Path: <SRS0=r+0f=YV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8450BCA9EC0
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 15:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D5B21783
	for <selinux@archiver.kernel.org>; Mon, 28 Oct 2019 15:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="bMS9QAas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJ1P0S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:26:18 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:54389 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfJ1P0R (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Oct 2019 11:26:17 -0400
X-EEMSG-check-017: 21571342|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="21571342"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 28 Oct 2019 15:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572276360; x=1603812360;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/nNMf9m/pKesGvd6ihSsTA8CnVwJL3RcBPybzmKN0XU=;
  b=bMS9QAasrrY6jXSRs7+1fIJXUs+7Gl6xXrioU2HbiS9V+zmWKRzMMdBb
   ZauUhQUTcz1HJEi/abhOXShLOQ4Mv8Z1qbYrgEsDwE4y9brOKtlYh1jYp
   rsxpmfotTJtWdfLsuzTceX2NEvJ/WWbxYhrK+U4/g5htbfxTJbdrzGDLr
   Ix0seLvxwmN3BEweMyBq/sD4CDms+ceNVsyiC0ygcSYzEicYQowNhdZeX
   OaZg+3q/qFX+cbLRaf3aW3jFvyAdStav3y67lPaqWrmK94WGRDSlZmlyf
   AtpswvcnjAjuTRmIPAejrji4tgl8jcFMdysIrwQic3kj5cHIU3m8WhopZ
   g==;
X-IronPort-AV: E=Sophos;i="5.68,240,1569283200"; 
   d="scan'208";a="29460244"
IronPort-PHdr: =?us-ascii?q?9a23=3AV2bH+BcNRpyoGgzzDQjNPVkAlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YRaN2/xhgRfzUJnB7Loc0qyK6vumCD1LvsrJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/Vu8QSjodvKKk8wQ?=
 =?us-ascii?q?bVr3VVfOhb2XlmLk+JkRbm4cew8p9j8yBOtP8k6sVNT6b0cbkmQLJBFDgpPH?=
 =?us-ascii?q?w768PttRnYUAuA/WAcXXkMkhpJGAfK8hf3VYrsvyTgt+p93C6aPdDqTb0xRD?=
 =?us-ascii?q?+v4btnRAPuhSwaLDMy7n3ZhdJsg6JauBKhpgJww4jIYIGOKfFyerrRcc4GSW?=
 =?us-ascii?q?ZdW8pcUSJOApm4b4ASEeQPO+hWpJT5q1cXoxazAQygCeXywTFKm3D2x7U33f?=
 =?us-ascii?q?k/HwHI3AIuHNwAv3rbo9r3KKgcXvu4zLXKwDjZc/9axTnw5YrOfxs8of+MR7?=
 =?us-ascii?q?Vwcc/JxEcyCwPKkE2QqYz7MDOTy+8Drm2b4PBkVeKrlWEmqxx6rz+0xsgxkY?=
 =?us-ascii?q?nEnZ4Vy1DY+iV5x4Y5P9u4SFVhbtK+H5tQsD+aOpJwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I73r4xlo?=
 =?us-ascii?q?YcsUTEHiPsnkX5kLSWeVk+9uit6uTnZq3qpp6aN4BqlgHzKrkil8OwDOgiMg?=
 =?us-ascii?q?UCQnKX9fqz2bH950H1Xa1GjvgsnanYtJDaK94bpqm8AwJNyYYs9g2/Aiy60N?=
 =?us-ascii?q?UYgXYHLFVFdAiBj4jyIV7COv/4DfChg1i0ijdk2+jGPqH9ApXKNnXMjK3ufa?=
 =?us-ascii?q?1j5E9c0wcz1sxQ55JOBbEcLvLzXlH+tMbBAhAlKQO42froCNJ41okGQ2KAHr?=
 =?us-ascii?q?eZML/OsV+P/u8gP/ODZJQLtzf9MfQl/OLhjX8jll8Ac6mp2YUYaGqjE/RnJU?=
 =?us-ascii?q?WZfWTjgtMbHWgWuQo+SfTgiEeeXj5Le3ayQ6U86yk5CIKjCofDXJqtgL2a3C?=
 =?us-ascii?q?qgGJ1ZfGVGBU6NEXvycIWEQfgMYjqIIsB9ijwESaShS4g52BGqtQ/6zadnL+?=
 =?us-ascii?q?XN9i0Dq53syMV15/fSlREu9T14FsGd02aQQGFpmmMHWSQ73L5woUNj0FePy6?=
 =?us-ascii?q?t4jOJCFdxV+fxJVh02NZnGz+x1E9ryQB7Ofs+VSFa6RdWrGSoxQcw1w98PZU?=
 =?us-ascii?q?Z9Btqjgwvd3yqlHbAVjaaHBJ8q/aLG2Xj+OcJ9x2zB1Kk7gFksWtFPOnG+hq?=
 =?us-ascii?q?5j6wjTAJbEk0aHmKm0bqQTwCnN9GCAzWeVoE5YUBRwUaLAXXAee0vWqM715k?=
 =?us-ascii?q?TYT7+hEb4nKBdOydaeKqtWbd3klVdGRPDjONTYeW6xmWCwBRaSybOKd4rlZW?=
 =?us-ascii?q?Md0T7BB0celQAT+nCGNQkiCSi7p2LSFiBhFVXqY0n06+lxtGu7TlMozwGNd0?=
 =?us-ascii?q?Bhz6S6+hgahfyBSvMT2KsIuCQ/pDVuGlaywdbWBsGBpwZ4eKVcZs0970ld2W?=
 =?us-ascii?q?LCrQN9PYGgL7p4iVIEdQR4oVni1xdvCo9Yi8glsGsqzBZuKaKfyF5BbymX3Y?=
 =?us-ascii?q?30OrDMMmn95g2va6rP1lHb19aW/b0P5+oip1r/uwGpExlqz3Iy+NBO3mrU3Z?=
 =?us-ascii?q?7KBRccVZ/rGhI8/gN3tpnBaSk0+o3Q2GcpOqDyuTjHjZZhD+I+xwfmZNxfOb?=
 =?us-ascii?q?6KEALoO8wcG8WqbuctnhzhbBcDJvpT74YyNsardr2BwqHvdOJhmi+2yH9K65?=
 =?us-ascii?q?1n016dsi97RvPM0r4bzPyCmAiKTTHxiBGmqM+z0ZtJYTAUA3qX1yfpHshSa7?=
 =?us-ascii?q?d0cIJNDn2hcOOtwdArvILgQ35V8haYAloC3MK4MU6JY0fVwRxb1UNRp2eu3y?=
 =?us-ascii?q?S/0WonwHkSsqOD0XmWkKzZfx0dNzsOHTIzgA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BhAQAUCLdd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F0LIFBMiqEKI9YBoE2f4hkj0qBZwkBAQEBAQEBAQE0AQIBAYRAAoNKJ?=
 =?us-ascii?q?DgTAgwBAQEEAQEBAQEFAwEBbIVDgjspAYJtAQUjBBFBEAsYAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJfP4JTJbB1fzOFToM3gUiBDiiMDxh4gQeBESeCNjU+hC6DJ4JeBI0Mi?=
 =?us-ascii?q?ElhlzKCLoIzknUGG4I8jAeLF44/gUCaGSKBWCsIAhgIIQ87gmxQEBSDEheOP?=
 =?us-ascii?q?yUDMIEFAQGPTQEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 28 Oct 2019 15:25:39 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9SFPZgs008373;
        Mon, 28 Oct 2019 11:25:36 -0400
Subject: Re: [PATCH v10 13/25] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191024205228.6922-1-casey@schaufler-ca.com>
 <20191024205228.6922-14-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0e3b9f63-bd85-de08-7f31-c05702c140d0@tycho.nsa.gov>
Date:   Mon, 28 Oct 2019 11:25:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024205228.6922-14-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/24/19 4:52 PM, Casey Schaufler wrote:
> Create a new entry "display" in /proc/.../attr for controlling
> which LSM security information is displayed for a process.
> The name of an active LSM that supplies hooks for human readable
> data may be written to "display" to set the value. The name of the
> LSM currently in use can be read from "display". At this point there
> can only be one LSM capable of display active. A helper function
> lsm_task_display() is provided to get the display slot for a task_struct.
> 
> Setting the "display" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
> 
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/proc/base.c                       |   1 +
>   include/linux/lsm_hooks.h            |  15 +++
>   security/apparmor/include/apparmor.h |   3 +-
>   security/apparmor/lsm.c              |  36 ++++++
>   security/security.c                  | 159 ++++++++++++++++++++++++---
>   security/selinux/hooks.c             |  11 ++
>   security/selinux/include/classmap.h  |   2 +-
>   security/smack/smack_lsm.c           |   7 ++
>   8 files changed, 215 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ddef482f1334..7bf70e041315 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2618,6 +2618,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "fscreate",		0666),
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 24b7d78a36b2..706fd6d3d46e 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2132,4 +2132,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>   
>   extern int lsm_inode_alloc(struct inode *inode);
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
>   #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/apparmor/include/apparmor.h b/security/apparmor/include/apparmor.h
> index 73d63b58d875..aaebfe979a68 100644
> --- a/security/apparmor/include/apparmor.h
> +++ b/security/apparmor/include/apparmor.h
> @@ -32,8 +32,9 @@
>   #define AA_CLASS_SIGNAL		10
>   #define AA_CLASS_NET		14
>   #define AA_CLASS_LABEL		16
> +#define AA_CLASS_DISPLAY_LSM	17
>   
> -#define AA_CLASS_LAST		AA_CLASS_LABEL
> +#define AA_CLASS_LAST		AA_CLASS_DISPLAY_LSM
>   
>   /* Control parameters settable through module/boot flags */
>   extern enum audit_mode aa_g_audit;
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index ec2e39aa9a84..c4835d05c5ea 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -603,6 +603,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
>   	return error;
>   }
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
>   static int apparmor_setprocattr(const char *name, void *value,
>   				size_t size)
>   {
> @@ -614,6 +633,23 @@ static int apparmor_setprocattr(const char *name, void *value,
>   	if (size == 0)
>   		return -EINVAL;
>   
> +	/* ToDo: Decide on the AppArmor policy for switching the display */
> +	if (!strcmp(name, "display"))
> +		return 0;

Leftover from before jj's patch.

> +
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
>   	/* AppArmor requires that the buffer must be null terminated atm */
>   	if (args[size - 1] != '\0') {
>   		/* null terminate */
> diff --git a/security/security.c b/security/security.c
> index 8368d1e726a0..687a5e184e57 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -31,6 +31,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/string.h>
>   #include <linux/msg.h>
> +#include <linux/binfmts.h>
>   #include <net/flow.h>
>   #include <net/sock.h>
>   
> @@ -46,7 +47,14 @@ static struct kmem_cache *lsm_file_cache;
>   static struct kmem_cache *lsm_inode_cache;
>   
>   char *lsm_names;
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
>   /* Boot-time LSM user choice */
>   static __initdata const char *chosen_lsm_order;
> @@ -415,8 +423,10 @@ static int lsm_append(const char *new, char **result)
>   
>   /*
>    * Current index to use while initializing the lsmblob secid list.
> + * Pointers to the LSM id structures for local use.
>    */
>   static int lsm_slot __lsm_ro_after_init;
> +static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES];
>   
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
> @@ -436,6 +446,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	if (lsmid->slot == LSMBLOB_NEEDED) {
>   		if (lsm_slot >= LSMBLOB_ENTRIES)
>   			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>   		lsmid->slot = lsm_slot++;
>   		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>   			   lsmid->slot);
> @@ -556,6 +567,8 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> +	int *display;
> +
>   	if (blob_sizes.lbs_task == 0) {
>   		task->security = NULL;
>   		return 0;
> @@ -564,6 +577,15 @@ static int lsm_task_alloc(struct task_struct *task)
>   	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
>   	if (task->security == NULL)
>   		return -ENOMEM;
> +
> +	/*
> +	 * The start of the task blob contains the "display" LSM slot number.
> +	 * Start with it set to the invalid slot number, indicating that the
> +	 * default first registered LSM be displayed.
> +	 */
> +	display = task->security;
> +	*display = LSMBLOB_INVALID;
> +
>   	return 0;
>   }
>   
> @@ -1502,14 +1524,26 @@ int security_file_open(struct file *file)
>   
>   int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>   {
> +	int *odisplay = current->security;
> +	int *ndisplay;
>   	int rc = lsm_task_alloc(task);
>   
> -	if (rc)
> +	if (unlikely(rc))
>   		return rc;
> +
>   	rc = call_int_hook(task_alloc, 0, task, clone_flags);
> -	if (unlikely(rc))
> +	if (unlikely(rc)) {
>   		security_task_free(task);
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
>   }
>   
>   void security_task_free(struct task_struct *task)
> @@ -1906,23 +1940,100 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   				char **value)
>   {
>   	struct security_hook_list *hp;
> +	int display = lsm_task_display(current);
> +	int slot = 0;
> +
> +	if (!strcmp(name, "display")) {
> +		/*
> +		 * lsm_slot will be 0 if there are no displaying modules.
> +		 */
> +		if (lsm_slot == 0)
> +			return -EINVAL;
> +		if (display != LSMBLOB_INVALID)
> +			slot = display;
> +		*value = kstrdup(lsm_slotlist[slot]->lsm, GFP_KERNEL);
> +		if (*value)
> +			return strlen(*value);
> +		return -ENOMEM;
> +	}
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && display != LSMBLOB_INVALID &&
> +		    display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
>   	return -EINVAL;
>   }
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
>   int security_setprocattr(const char *lsm, const char *name, void *value,
>   			 size_t size)
>   {
>   	struct security_hook_list *hp;
> +	char *term;
> +	char *cp;
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
> +		term = kmemdup_nul(value, size, GFP_KERNEL);
> +		if (term == NULL)
> +			return -ENOMEM;
> +
> +		cp = strsep(&term, " \n");
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
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
>   		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
> +		if (lsm == NULL && *display != LSMBLOB_INVALID &&
> +		    *display != hp->lsmid->slot)
> +			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
>   	return -EINVAL;
> @@ -1942,15 +2053,15 @@ EXPORT_SYMBOL(security_ismaclabel);
>   int security_secid_to_secctx(struct lsmblob *blob, char **secdata, u32 *seclen)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.secid_to_secctx, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secid_to_secctx(blob->secid[hp->lsmid->slot],
> -					      secdata, seclen);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secid_to_secctx(
> +					blob->secid[hp->lsmid->slot],
> +					secdata, seclen);
>   	}
>   	return 0;
>   }
> @@ -1960,16 +2071,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
>   			     struct lsmblob *blob)
>   {
>   	struct security_hook_list *hp;
> -	int rc;
> +	int display = lsm_task_display(current);
>   
>   	lsmblob_init(blob, 0);
>   	hlist_for_each_entry(hp, &security_hook_heads.secctx_to_secid, list) {
>   		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
>   			continue;
> -		rc = hp->hook.secctx_to_secid(secdata, seclen,
> -					      &blob->secid[hp->lsmid->slot]);
> -		if (rc != 0)
> -			return rc;
> +		if (display == LSMBLOB_INVALID || display == hp->lsmid->slot)
> +			return hp->hook.secctx_to_secid(secdata, seclen,
> +						&blob->secid[hp->lsmid->slot]);
>   	}
>   	return 0;
>   }
> @@ -1977,7 +2087,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
>   
>   void security_release_secctx(char *secdata, u32 seclen)
>   {
> -	call_void_hook(release_secctx, secdata, seclen);
> +	struct security_hook_list *hp;
> +	int *display = current->security;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.release_secctx, list)
> +		if (display == NULL || *display == LSMBLOB_INVALID ||
> +		    *display == hp->lsmid->slot) {
> +			hp->hook.release_secctx(secdata, seclen);
> +			return;
> +		}
>   }
>   EXPORT_SYMBOL(security_release_secctx);
>   
> @@ -2102,8 +2220,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
>   int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
>   				      int __user *optlen, unsigned len)
>   {
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
>   }
>   
>   int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 7592b95b43c4..c9e377d13f0e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6170,6 +6170,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>   	/*
>   	 * Basic control over ability to set these attributes at all.
>   	 */
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
>   	if (!strcmp(name, "exec"))
>   		error = avc_has_perm(&selinux_state,
>   				     mysid, mysid, SECCLASS_PROCESS,
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index bd5fe0d3204a..eda6f6a7a666 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -50,7 +50,7 @@ struct security_class_mapping secclass_map[] = {
>   	    "execmem", "execstack", "execheap", "setkeycreate",
>   	    "setsockcreate", "getrlimit", NULL } },
>   	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>   	{ "system",
>   	  { "ipc_info", "syslog_read", "syslog_mod",
>   	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 61e05fe86013..1a3041463c46 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3516,6 +3516,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>   	struct smack_known_list_elem *sklep;
>   	int rc;
>   
> +	/*
> +	 * Allow the /proc/.../attr/current and SO_PEERSEC "display"
> +	 * to be reset at will.
> +	 */
> +	if (strcmp(name, "display") == 0)
> +		return 0;
> +
>   	if (!smack_privileged(CAP_MAC_ADMIN) && list_empty(&tsp->smk_relabel))
>   		return -EPERM;
>   
> 

