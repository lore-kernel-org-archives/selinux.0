Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828B4C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C1124655
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 17:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="S7RuDfsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLQRay (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:30:54 -0500
Received: from USAT19PA25.eemsg.mail.mil ([214.24.22.199]:64687 "EHLO
        USAT19PA25.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQRay (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 12:30:54 -0500
X-EEMSG-check-017: 61553012|USAT19PA25_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="61553012"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA25.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 17:30:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576603851; x=1608139851;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GAdCssXgOsW/McuBliM3e7q6ZUnEQCtERFxQQd9/hjQ=;
  b=S7RuDfsNXhm5w/fz+JepWIa0AchP7dmGDQ2F9p8Wj7V8oeFN1jx2m4Iv
   +DcfV3x7rGMQ/aQ6BHyZYIuWXSorFKGQdDkptcDlJ7oS76orQfNKrl8wO
   bzsZ8avZuqMfHFuMC3doMk9lphE8XnI7s7EOb/jg/YiebDGHMmMdBaIaK
   ZuJOgLP1+uCU+ab9/3r3AmF1eUZdtEiapA5fqNP79ZKqkWpo6NYj+6f+3
   m5MHn+vWxffl9XZkZfew5KA4bhgPHxmtFJwRnMZqKc6M4zDoSdSP/u2cE
   59n500VUzArlzQXuNznOkOyL+VK9rWUeNTW0p4oc2UNNwLi4dU8OXRcJv
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="36854838"
IronPort-PHdr: =?us-ascii?q?9a23=3AQq15dRa408jjRhsyh4aLKtL/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZpsi9ZR7h7PlgxGXEQZ/co6odzbaP6Oa6ATNLsMbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUKg4ZuJaI8xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
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
X-IPAS-Result: =?us-ascii?q?A2DRAABxEPld/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqEBIkDhnQEBoE3gQGIaZFFCQEBAQEBAQEBATcBAYRAAoI8O?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshUOCOykBgnoBBSMEEUEQCxgCAiYCAlcGAQwGA?=
 =?us-ascii?q?gEBglMMP4JTJa4zfzOFT4M/gUiBDiiMMnmBB4ERJw+CKAcuPoEXhkKCXgSWK?=
 =?us-ascii?q?2FGlzOCPoJCk0gGG5pJjk2cXiKBWCsIAhgIIQ87gmxQERSNHheOQSMDMJEhX?=
 =?us-ascii?q?wEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Dec 2019 17:30:27 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHHU6Cd142283;
        Tue, 17 Dec 2019 12:30:08 -0500
Subject: Re: [PATCH v12 02/25] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-3-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <391bf9d8-3baf-a0bc-7a2f-ad4b167908ff@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 12:30:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:35 PM, Casey Schaufler wrote:
> When more than one security module is exporting data to
> audit and networking sub-systems a single 32 bit integer
> is no longer sufficient to represent the data. Add a
> structure to be used instead.
> 
> The lsmblob structure is currently an array of
> u32 "secids". There is an entry for each of the
> security modules built into the system that would
> use secids if active. The system assigns the module
> a "slot" when it registers hooks. If modules are
> compiled in but not registered there will be unused
> slots.
> 
> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h  | 12 ++++++--
>   include/linux/security.h   | 58 ++++++++++++++++++++++++++++++++++++++
>   security/apparmor/lsm.c    |  7 ++++-
>   security/commoncap.c       |  7 ++++-
>   security/loadpin/loadpin.c |  8 +++++-
>   security/safesetid/lsm.c   |  8 +++++-
>   security/security.c        | 28 ++++++++++++++----
>   security/selinux/hooks.c   |  8 +++++-
>   security/smack/smack_lsm.c |  7 ++++-
>   security/tomoyo/tomoyo.c   |  8 +++++-
>   security/yama/yama_lsm.c   |  7 ++++-
>   11 files changed, 142 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index c2b1af29a8f0..7eb808cde051 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2077,6 +2077,14 @@ struct security_hook_heads {
>   #endif
>   } __randomize_layout;
>   
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;	/* Name of the LSM */
> +	int		slot;	/* Slot in lsmblob if one is allocated */
> +};
> +
>   /*
>    * Security module hook list structure.
>    * For use with generic list macros for common operations.
> @@ -2085,7 +2093,7 @@ struct security_hook_list {
>   	struct hlist_node		list;
>   	struct hlist_head		*head;
>   	union security_list_options	hook;
> -	char				*lsm;
> +	struct lsm_id			*lsmid;
>   } __randomize_layout;
>   
>   /*
> @@ -2114,7 +2122,7 @@ extern struct security_hook_heads security_hook_heads;
>   extern char *lsm_names;
>   
>   extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +			       struct lsm_id *lsmid);
>   
>   #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>   #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 3e8d4bacd59d..b74dc70088ca 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -128,6 +128,64 @@ enum lockdown_reason {
>   	LOCKDOWN_CONFIDENTIALITY_MAX,
>   };
>   
> +/*
> + * Data exported by the security modules
> + *
> + * Any LSM that provides secid or secctx based hooks must be included.
> + */
> +#define LSMBLOB_ENTRIES ( \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
> +
> +struct lsmblob {
> +	u32     secid[LSMBLOB_ENTRIES];
> +};
> +
> +#define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
> +#define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
> +#define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
> +
> +/**
> + * lsmblob_init - initialize an lsmblob structure.
> + * @blob: Pointer to the data to initialize
> + * @secid: The initial secid value
> + *
> + * Set all secid for all modules to the specified value.
> + */
> +static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
> +{
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		blob->secid[i] = secid;
> +}
> +
> +/**
> + * lsmblob_is_set - report if there is an value in the lsmblob
> + * @blob: Pointer to the exported LSM data
> + *
> + * Returns true if there is a secid set, false otherwise
> + */
> +static inline bool lsmblob_is_set(struct lsmblob *blob)
> +{
> +	struct lsmblob empty = {};
> +
> +	return !!memcmp(blob, &empty, sizeof(*blob));
> +}
> +
> +/**
> + * lsmblob_equal - report if the two lsmblob's are equal
> + * @bloba: Pointer to one LSM data
> + * @blobb: Pointer to the other LSM data
> + *
> + * Returns true if all entries in the two are equal, false otherwise
> + */
> +static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
> +{
> +	return !memcmp(bloba, blobb, sizeof(*bloba));
> +}
> +
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>   		       int cap, unsigned int opts);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 61b24f4eb355..146d75e5e021 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1147,6 +1147,11 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>   	.lbs_sock = sizeof(struct aa_sk_ctx),
>   };
>   
> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
> +	.lsm  = "apparmor",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> @@ -1847,7 +1852,7 @@ static int __init apparmor_init(void)
>   		goto buffers_out;
>   	}
>   	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				&apparmor_lsmid);
>   
>   	/* Report that AppArmor successfully initialized */
>   	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4ee0ae106b2..9dcfd2a0e891 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1339,6 +1339,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>   
>   #ifdef CONFIG_SECURITY
>   
> +static struct lsm_id capability_lsmid __lsm_ro_after_init = {
> +	.lsm  = "capability",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(capable, cap_capable),
>   	LSM_HOOK_INIT(settime, cap_settime),
> @@ -1363,7 +1368,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>   static int __init capability_init(void)
>   {
>   	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +			   &capability_lsmid);
>   	return 0;
>   }
>   
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index ee5cb944f4ad..86317e78899f 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -180,6 +180,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
>   	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>   }
>   
> +static struct lsm_id loadpin_lsmid __lsm_ro_after_init = {
> +	.lsm  = "loadpin",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>   	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> @@ -227,7 +232,8 @@ static int __init loadpin_init(void)
>   	pr_info("ready to pin (currently %senforcing)\n",
>   		enforce ? "" : "not ");
>   	parse_exclude();
> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> +	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
> +			   &loadpin_lsmid);
>   	return 0;
>   }
>   
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 7760019ad35d..950dfb7f931e 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -149,6 +149,11 @@ static int safesetid_task_fix_setuid(struct cred *new,
>   	return -EACCES;
>   }
>   
> +static struct lsm_id safesetid_lsmid __lsm_ro_after_init = {
> +	.lsm  = "safesetid",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list safesetid_security_hooks[] = {
>   	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>   	LSM_HOOK_INIT(capable, safesetid_security_capable)
> @@ -157,7 +162,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
>   static int __init safesetid_security_init(void)
>   {
>   	security_add_hooks(safesetid_security_hooks,
> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +			   ARRAY_SIZE(safesetid_security_hooks),
> +			   &safesetid_lsmid);
>   
>   	/* Report that SafeSetID successfully initialized */
>   	safesetid_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index 7fb6e5bcf6ec..a89634af639a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -308,6 +308,7 @@ static void __init ordered_lsm_init(void)
>   	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
>   	init_debug("sock blob size     = %d\n", blob_sizes.lbs_sock);
>   	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size       = %lu\n", sizeof(struct lsmblob));

nit: Use %zu for sizeof.  Otherwise,
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

>   
>   	/*
>   	 * Create any kmem_caches needed for blobs
> @@ -435,21 +436,36 @@ static int lsm_append(const char *new, char **result)
>   	return 0;
>   }
>   
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __initdata;
> +
>   /**
>    * security_add_hooks - Add a modules hooks to the hook lists.
>    * @hooks: the hooks to add
>    * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsmid: the the identification information for the security module
>    *
>    * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>    */
>   void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +			       struct lsm_id *lsmid)
>   {
>   	int i;
>   
> +	if (lsmid->slot == LSMBLOB_NEEDED) {
> +		if (lsm_slot >= LSMBLOB_ENTRIES)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsmid->slot = lsm_slot++;
> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> +			   lsmid->slot);
> +	}
> +
>   	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> +		hooks[i].lsmid = lsmid;
>   		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>   	}
>   
> @@ -458,7 +474,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   	 * and fix this up afterwards.
>   	 */
>   	if (slab_is_available()) {
> -		if (lsm_append(lsm, &lsm_names) < 0)
> +		if (lsm_append(lsmid->lsm, &lsm_names) < 0)
>   			panic("%s - Cannot get early memory.\n", __func__);
>   	}
>   }
> @@ -1906,7 +1922,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
>   		return hp->hook.getprocattr(p, name, value);
>   	}
> @@ -1919,7 +1935,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>   	struct security_hook_list *hp;
>   
>   	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>   			continue;
>   		return hp->hook.setprocattr(name, value, size);
>   	}
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0839b2fbbf9b..97f2ee6e4080 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6860,6 +6860,11 @@ static int selinux_perf_event_write(struct perf_event *event)
>   }
>   #endif
>   
> +static struct lsm_id selinux_lsmid __lsm_ro_after_init = {
> +	.lsm  = "selinux",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>   	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -7128,7 +7133,8 @@ static __init int selinux_init(void)
>   
>   	hashtab_cache_init();
>   
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> +			   &selinux_lsmid);
>   
>   	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>   		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 4cecdfdcd913..82cbb3eeec76 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4585,6 +4585,11 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>   	.lbs_sock = sizeof(struct socket_smack),
>   };
>   
> +static struct lsm_id smack_lsmid __lsm_ro_after_init = {
> +	.lsm  = "smack",
> +	.slot = LSMBLOB_NEEDED
> +};
> +
>   static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> @@ -4783,7 +4788,7 @@ static __init int smack_init(void)
>   	/*
>   	 * Register with LSM
>   	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
>   	smack_enabled = 1;
>   
>   	pr_info("Smack:  Initializing.\n");
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..f1968e80f06d 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *task)
>   	}
>   }
>   
> +static struct lsm_id tomoyo_lsmid __lsm_ro_after_init = {
> +	.lsm  = "tomoyo",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   /*
>    * tomoyo_security_ops is a "struct security_operations" which is used for
>    * registering TOMOYO.
> @@ -581,7 +586,8 @@ static int __init tomoyo_init(void)
>   	struct tomoyo_task *s = tomoyo_task(current);
>   
>   	/* register ourselves with the security framework */
> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
> +			   &tomoyo_lsmid);
>   	pr_info("TOMOYO Linux initialized\n");
>   	s->domain_info = &tomoyo_kernel_domain;
>   	atomic_inc(&tomoyo_kernel_domain.users);
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 94dc346370b1..0f0cf7136929 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -421,6 +421,11 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>   	return rc;
>   }
>   
> +static struct lsm_id yama_lsmid __lsm_ro_after_init = {
> +	.lsm  = "yama",
> +	.slot = LSMBLOB_NOT_NEEDED
> +};
> +
>   static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>   	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> @@ -477,7 +482,7 @@ static inline void yama_init_sysctl(void) { }
>   static int __init yama_init(void)
>   {
>   	pr_info("Yama: becoming mindful.\n");
> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
>   	yama_init_sysctl();
>   	return 0;
>   }
> 

