Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690EAC2D0C8
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 20:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BDF2072A
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 20:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLYUkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Dec 2019 15:40:07 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:34218 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLYUkH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Dec 2019 15:40:07 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 15:39:58 EST
Received: from smtp-2-0001.mail.infomaniak.ch ([10.5.36.108])
        by smtp-sh.infomaniak.ch (8.14.5/8.14.5) with ESMTP id xBPKYIjw005037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Dec 2019 21:34:19 +0100
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id ACBFF100BB3CD;
        Wed, 25 Dec 2019 21:34:14 +0100 (CET)
Subject: Re: [PATCH v13 02/25] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-3-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <b7ad7c0d-bf83-c37f-1248-f6ea27939ccc@digikod.net>
Date:   Wed, 25 Dec 2019 21:34:12 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


On 25/12/2019 00:59, Casey Schaufler wrote:
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
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   include/linux/lsm_hooks.h    | 12 ++++++--
>   include/linux/security.h     | 58 ++++++++++++++++++++++++++++++++++++
>   security/apparmor/lsm.c      |  7 ++++-
>   security/commoncap.c         |  7 ++++-
>   security/loadpin/loadpin.c   |  8 ++++-
>   security/lockdown/lockdown.c |  7 ++++-
>   security/safesetid/lsm.c     |  8 ++++-
>   security/security.c          | 28 +++++++++++++----
>   security/selinux/hooks.c     |  8 ++++-
>   security/smack/smack_lsm.c   |  7 ++++-
>   security/tomoyo/tomoyo.c     |  8 ++++-
>   security/yama/yama_lsm.c     |  7 ++++-
>   12 files changed, 148 insertions(+), 17 deletions(-)
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
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index b2f87015d6e9..91662325e450 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -102,6 +102,11 @@ static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>   };
>   
> +static struct lsm_id lockdown_lsmid __lsm_ro_after_init = {
> +	.lsm = "landlock",

Working on it but not there yet ;)
