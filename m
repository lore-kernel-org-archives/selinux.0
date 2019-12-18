Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB3BC43603
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9755324676
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="HMRd7AgR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfLRPRY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:17:24 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:18185 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLRPRX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 10:17:23 -0500
X-EEMSG-check-017: 61956077|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="61956077"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Dec 2019 15:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576682242; x=1608218242;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=E8rOYNK8qdKrfCt6GJPTdM7l1HpsaG9z/8qrqED1sBg=;
  b=HMRd7AgR2EcTNiOySXmOf2PkIW6PlJX76fz/cHk6+p7gKfcU1tolk2gE
   4wa/9B2WjwHaAwxThg2cFQyQfKiZ5d1ral/IJ7NMuMEHuPDJjH2XNt1c6
   irhXhIZKgCSWI9dClwvZgeWZsHla46TCBNxpODnJjE7C4UVgEtSzYwQpp
   ZapD+DH6FbO6nvQ3MKAXNk3emOOSCnTaAWtQDGdw9r5CDSB0UhJhBGuP/
   wS2dgFGAldPEFuqvW5ad7inUewMdIw7FAWLXvQhJOUYicIEY+rqsRDe/N
   8Y9PoT6+SMkyvaLoXw+V3HIOw7PYMcYy74T41CA3utqnpXOzXhVnNdFP4
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,330,1571702400"; 
   d="scan'208";a="31233832"
IronPort-PHdr: =?us-ascii?q?9a23=3ANVOnPxaso+8d5scdPuyJGl7/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsi9ZR7h7PlgxGXEQZ/co6odzbaP6Oa6AT1Lv8fJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUKhYZuJac8xx?=
 =?us-ascii?q?/UqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezCw2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opIBb4bO/L8RE/wucfDDhAlMwy72fvnCNt51owAQ2KDG7?=
 =?us-ascii?q?OWP7nIvVCU4eIvJvGGZJUJtzblN/gl+/nugGclllAHZqmmw5sWZGqjHvt6I0?=
 =?us-ascii?q?WWe2fsgtkFEWgUpAozV+3qiFueUTFNY3a+Rb4z5jY+CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWZGVGCleWEXfydoWEQOwBaCSILc9kjDMEVKKtS4g71RGhrAX60aZoLv?=
 =?us-ascii?q?LI+i0EspLuzNx15+zVlREv+j14Ft+d3H+RQGFphGMIRiM23aBmrUx4zVeMzL?=
 =?us-ascii?q?V4g/hGGtFI+fNJXRk1NYTGw+x5Fd/yQATBccmNSFq8RdWmGz4xRMorw9ASe0?=
 =?us-ascii?q?Z9B8mijhfb0iqxHbAVk72LBJop8qPTxHXxOcl9xGjc1KU7jFkpXNFPNWu4ia?=
 =?us-ascii?q?577QTTAJTJk0qBnaawaascxDLN9HuEzWeWv0FXThB/Ub7ZUnAYYUvWrs/06V?=
 =?us-ascii?q?/CT7+0DrQnNwpBydOHKqdQbd3pl1pGTu/5ONvCe2Kxh3uwBRGQy7OOa4rqe2?=
 =?us-ascii?q?Md0D/fCEgDkwAc53CGNRMgCSenuG/RECZhFVToY0Pq8OlxtGm0Tksuww6WaE?=
 =?us-ascii?q?1h0qK/+gQJivyEV/MTwrUEtT85qzpqGla90M/WC9uGpwZ4f6VTf8k94FFZ2m?=
 =?us-ascii?q?LdrAF9P4WsL6Rlhl4AbQt7pVju2A90CoVdi8gltmkmzAxsJq6C0lNBbyuS3Y?=
 =?us-ascii?q?rsNb3PNmny4BevZrbO2l7EzdaW/rwC6OwipFX+uAGlD08i83Jg09lPzXSQ/I?=
 =?us-ascii?q?nFDA0XUcG5bkFi3BFhqqCSWSI97p7a0XB2ef2/uyTPyvoyD+ss1xikcs0aO6?=
 =?us-ascii?q?rCHwj3RYlSDMG1Jf1sgFOpZw8KOO1I3K8yI86iMfCB3erjPuNnhiinlkxB6Y?=
 =?us-ascii?q?Vw0wSL7SU4AurJ2YsVhuqV1RadVivtyVKmvt3zlKhaajwIWGmy0y7pAMhWfK?=
 =?us-ascii?q?I2NZ0GDWaoPt2f2NpzndjuVmRe+VrlAEkJi+Gzfh/HVEDwxQ1d0wwspHWjnS?=
 =?us-ascii?q?aph2hvnyoBsruU3CuIxf/rMhUAJDgYFyFZkV7wLN3s3JghV0+yYl1szUD06A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BXAACQQfpd/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYF8gXaBbSASKoQEiQOGVQEBAQEBBoE3gQGIaY9egWcJAQEBAQEBA?=
 =?us-ascii?q?QEBNwEBhEACgj04EwIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQECASMEE?=
 =?us-ascii?q?UEFCwsYAgImAgJXBgEMBgIBAYJfP4JTBSCsdHV/M4VPg0WBQYEOKIwyeYEHg?=
 =?us-ascii?q?REnD4IoNT6EMoMngl4EjT+IbmFGlzWCP4JDk0oGG4JDjDqLUY5OgUabGSKBW?=
 =?us-ascii?q?CsIAhgIIQ87gmxQGA2NHheBBAEOjS4jAzCMXyqCFwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Dec 2019 15:17:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBIFGsGW259802;
        Wed, 18 Dec 2019 10:16:56 -0500
Subject: Re: [PATCH v12 13/25] LSM: Specify which LSM to display
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-14-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cb93ecc4-97aa-770d-25c8-ec128f3bedc2@tycho.nsa.gov>
Date:   Wed, 18 Dec 2019 10:17:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-14-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
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
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   fs/proc/base.c                       |   1 +
>   include/linux/lsm_hooks.h            |  15 +++
>   security/apparmor/include/apparmor.h |   3 +-
>   security/apparmor/lsm.c              |  32 +++++
>   security/security.c                  | 169 ++++++++++++++++++++++++---
>   security/selinux/hooks.c             |  11 ++
>   security/selinux/include/classmap.h  |   2 +-
>   security/smack/smack_lsm.c           |   7 ++
>   8 files changed, 221 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..950c200cb9ad 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2652,6 +2652,7 @@ static const struct pid_entry attr_dir_stuff[] = {
>   	ATTR(NULL, "fscreate",		0666),
>   	ATTR(NULL, "keycreate",		0666),
>   	ATTR(NULL, "sockcreate",	0666),
> +	ATTR(NULL, "display",		0666),
>   #ifdef CONFIG_SECURITY_SMACK
>   	DIR("smack",			0555,
>   	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7eb808cde051..2bf82e1cf347 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2186,4 +2186,19 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
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
> index 1fbabdb565a8..b1622fcb4394 100644
> --- a/security/apparmor/include/apparmor.h
> +++ b/security/apparmor/include/apparmor.h
> @@ -28,8 +28,9 @@
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
> index 146d75e5e021..16b992235c11 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -612,6 +612,25 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
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
> @@ -623,6 +642,19 @@ static int apparmor_setprocattr(const char *name, void *value,
>   	if (size == 0)
>   		return -EINVAL;
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
>   	/* AppArmor requires that the buffer must be null terminated atm */
>   	if (args[size - 1] != '\0') {
>   		/* null terminate */
> diff --git a/security/security.c b/security/security.c
> index 32354942b7e8..aaac748e4d83 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -27,6 +27,7 @@
>   #include <linux/backing-dev.h>
>   #include <linux/string.h>
>   #include <linux/msg.h>
> +#include <linux/binfmts.h>
>   #include <net/flow.h>
>   #include <net/sock.h>
>   
> @@ -43,7 +44,14 @@ static struct kmem_cache *lsm_file_cache;
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
> @@ -438,8 +446,10 @@ static int lsm_append(const char *new, char **result)
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
> @@ -459,6 +469,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	if (lsmid->slot == LSMBLOB_NEEDED) {
>   		if (lsm_slot >= LSMBLOB_ENTRIES)
>   			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_slotlist[lsm_slot] = lsmid;
>   		lsmid->slot = lsm_slot++;
>   		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
>   			   lsmid->slot);
> @@ -588,6 +599,8 @@ int lsm_inode_alloc(struct inode *inode)
>    */
>   static int lsm_task_alloc(struct task_struct *task)
>   {
> +	int *display;
> +
>   	if (blob_sizes.lbs_task == 0) {
>   		task->security = NULL;
>   		return 0;
> @@ -596,6 +609,15 @@ static int lsm_task_alloc(struct task_struct *task)
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
> @@ -1551,14 +1573,26 @@ int security_file_open(struct file *file)
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
> @@ -1955,23 +1989,110 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
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

This makes me slightly nervous; I see that it is correct currently but 
worry about cp being changed at some point to no longer refer to the 
start of the allocated buffer. I'd favor not mutating term (i.e. pass a 
temporary to strsep) and freeing it.

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
> @@ -1991,15 +2112,15 @@ EXPORT_SYMBOL(security_ismaclabel);
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
> @@ -2009,16 +2130,15 @@ int security_secctx_to_secid(const char *secdata, u32 seclen,
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
> @@ -2026,7 +2146,15 @@ EXPORT_SYMBOL(security_secctx_to_secid);
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

I was wondering why you didn't use lsm_task_display() here and retain 
the same pattern as the other hooks?

>   EXPORT_SYMBOL(security_release_secctx);
>   
> @@ -2151,8 +2279,15 @@ EXPORT_SYMBOL(security_sock_rcv_skb);
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
> index 97f2ee6e4080..b8501ca3c8f3 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6323,6 +6323,17 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
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
> index 7db24855e12d..323da8a38c43 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -52,7 +52,7 @@ struct security_class_mapping secclass_map[] = {
>   	    "execmem", "execstack", "execheap", "setkeycreate",
>   	    "setsockcreate", "getrlimit", NULL } },
>   	{ "process2",
> -	  { "nnp_transition", "nosuid_transition", NULL } },
> +	  { "nnp_transition", "nosuid_transition", "setdisplay", NULL } },
>   	{ "system",
>   	  { "ipc_info", "syslog_read", "syslog_mod",
>   	    "syslog_console", "module_request", "module_load", NULL } },
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 82cbb3eeec76..9737ead06b39 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3518,6 +3518,13 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
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

