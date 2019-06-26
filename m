Return-Path: <SRS0=8O8t=UZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208A0C48BD6
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C051721670
	for <selinux@archiver.kernel.org>; Wed, 26 Jun 2019 23:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFZXje (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:39:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35216 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXje (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Jun 2019 19:39:34 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hgHVb-0001X0-4u; Wed, 26 Jun 2019 23:39:23 +0000
Subject: Re: [PATCH v4 04/23] LSM: Create and manage the lsmblob data
 structure.
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-5-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <19468cf8-8702-b391-fae5-197ddbb6da4d@canonical.com>
Date:   Wed, 26 Jun 2019 16:39:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626192234.11725-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/26/19 12:22 PM, Casey Schaufler wrote:
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
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h  | 12 +++++--
>  include/linux/security.h   | 66 ++++++++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c    |  4 ++-
>  security/commoncap.c       |  7 +++-
>  security/loadpin/loadpin.c |  8 ++++-
>  security/safesetid/lsm.c   |  8 ++++-
>  security/security.c        | 31 ++++++++++++++----
>  security/selinux/hooks.c   |  5 ++-
>  security/smack/smack_lsm.c |  4 ++-
>  security/tomoyo/tomoyo.c   |  8 ++++-
>  security/yama/yama_lsm.c   |  4 ++-
>  11 files changed, 140 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3fe39abccc8f..fe1fb7a69ee5 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2029,6 +2029,14 @@ struct security_hook_heads {
>  #endif /* CONFIG_BPF_SYSCALL */
>  } __randomize_layout;
>  
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;	/* Name of the LSM */
> +	int		slot;	/* Slot in lsmblob if one is allocated */
> +};
> +
>  /*
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
> @@ -2037,7 +2045,7 @@ struct security_hook_list {
>  	struct hlist_node		list;
>  	struct hlist_head		*head;
>  	union security_list_options	hook;
> -	char				*lsm;
> +	struct lsm_id			*lsmid;
>  } __randomize_layout;
>  
>  /*
> @@ -2068,7 +2076,7 @@ extern struct security_hook_heads security_hook_heads;
>  extern char *lsm_names;
>  
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm);
> +			       struct lsm_id *lsmid);
>  
>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..5bb8b9a6fa84 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -76,6 +76,72 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
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
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (blob->secid[i] != 0)
> +			return true;
> +	return false;
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
> +	int i;
> +
> +	for (i = 0; i < LSMBLOB_ENTRIES; i++)
> +		if (bloba->secid[i] != blobb->secid[i])
> +			return false;
> +	return true;
> +}
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
>  		       int cap, unsigned int opts);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 2716e7731279..6d2eefc9b7c1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1138,6 +1138,8 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>  	.lbs_sock = sizeof(struct aa_sk_ctx),
>  };
>  
> +static struct lsm_id apparmor_lsmid = { .lsm="apparmor", .slot=LSMBLOB_NEEDED };

__lsm_ro_after_init


> +
>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> @@ -1679,7 +1681,7 @@ static int __init apparmor_init(void)
>  		goto buffers_out;
>  	}
>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				&apparmor_lsmid);
>  
>  	/* Report that AppArmor successfully initialized */
>  	apparmor_initialized = 1;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index afd9679ca866..305a6088c81e 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1344,6 +1344,11 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> +static struct lsm_id capability_lsmid = {

__lsm_ro_after_init

> +	.lsm="capability",
> +	.slot=LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
> @@ -1368,7 +1373,7 @@ static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
>  static int __init capability_init(void)
>  {
>  	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
> -				"capability");
> +			   &capability_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 055fb0a64169..13db59d5327e 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -181,6 +181,11 @@ static int loadpin_load_data(enum kernel_load_data_id id)
>  	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>  }
>  
> +static struct lsm_id loadpin_lsmid = {

__lsm_ro_after_init


> +	.lsm="loadpin",
> +	.slot=LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
> @@ -191,7 +196,8 @@ static int __init loadpin_init(void)
>  {
>  	pr_info("ready to pin (currently %senforcing)\n",
>  		enforce ? "" : "not ");
> -	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> +	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks),
> +			   &loadpin_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..ca34badde4cf 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -255,6 +255,11 @@ void flush_safesetid_whitelist_entries(void)
>  	}
>  }
>  
> +static struct lsm_id safesetid_lsmid = {

__lsm_ro_after_init


> +	.lsm="safesetid",
> +	.slot=LSMBLOB_NOT_NEEDED
> +};
> +
>  static struct security_hook_list safesetid_security_hooks[] = {
>  	LSM_HOOK_INIT(task_fix_setuid, safesetid_task_fix_setuid),
>  	LSM_HOOK_INIT(capable, safesetid_security_capable)
> @@ -263,7 +268,8 @@ static struct security_hook_list safesetid_security_hooks[] = {
>  static int __init safesetid_security_init(void)
>  {
>  	security_add_hooks(safesetid_security_hooks,
> -			   ARRAY_SIZE(safesetid_security_hooks), "safesetid");
> +			   ARRAY_SIZE(safesetid_security_hooks),
> +			   &safesetid_lsmid);
>  
>  	/* Report that SafeSetID successfully initialized */
>  	safesetid_initialized = 1;
> diff --git a/security/security.c b/security/security.c
> index 7cfedb90210a..27e2db3d6b04 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
>  	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
>  	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>  	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
> +	init_debug("lsmblob size         = %lu\n", sizeof(struct lsmblob));
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -399,7 +400,7 @@ static bool match_last_lsm(const char *list, const char *lsm)
>  	return !strcmp(last, lsm);
>  }
>  
> -static int lsm_append(char *new, char **result)
> +static int lsm_append(const char *new, char **result)
>  {
>  	char *cp;
>  
> @@ -420,24 +421,40 @@ static int lsm_append(char *new, char **result)
>  	return 0;
>  }
>  
> +/*
> + * Current index to use while initializing the lsmblob secid list.
> + */
> +static int lsm_slot __initdata;
> +
>  /**
>   * security_add_hooks - Add a modules hooks to the hook lists.
>   * @hooks: the hooks to add
>   * @count: the number of hooks to add
> - * @lsm: the name of the security module
> + * @lsmid: the identification information for the security module
>   *
>   * Each LSM has to register its hooks with the infrastructure.
> + * If the LSM is using hooks that export secids allocate a slot
> + * for it in the lsmblob.
>   */
>  void __init security_add_hooks(struct security_hook_list *hooks, int count,
> -				char *lsm)
> +			       struct lsm_id *lsmid)
>  {
>  	int i;
>  
> +	if (lsmid->slot == LSMBLOB_NEEDED) {
> +		if (lsm_slot >= LSMBLOB_ENTRIES)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsmid->slot = lsm_slot++;
> +		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
> +			   lsmid->slot);
> +	}

It might be nice (but not required) to add back in the list of hooks that need
secids as a cross check of LSMLOB_NOT_NEEDED. It would allow us to catch
bad registrations upfront instead of crashing the kernel when the hook gets
used.


> +
>  	for (i = 0; i < count; i++) {
> -		hooks[i].lsm = lsm;
> +		hooks[i].lsmid = lsmid;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
>  	}
> -	if (lsm_append(lsm, &lsm_names) < 0)
> +
> +	if (lsm_append(lsmid->lsm, &lsm_names) < 0)
>  		panic("%s - Cannot get early memory.\n", __func__);
>  }
>  
> @@ -1917,7 +1934,7 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
>  		return hp->hook.getprocattr(p, name, value);
>  	}
> @@ -1930,7 +1947,7 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
>  	struct security_hook_list *hp;
>  
>  	hlist_for_each_entry(hp, &security_hook_heads.setprocattr, list) {
> -		if (lsm != NULL && strcmp(lsm, hp->lsm))
> +		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>  			continue;
>  		return hp->hook.setprocattr(name, value, size);
>  	}
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c83ec2652eda..8c93b07bb353 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6622,6 +6622,8 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct superblock_security_struct),
>  };
>  
> +static struct lsm_id selinux_lsmid = { .lsm="selinux", .slot=LSMBLOB_NEEDED };
> +
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> @@ -6877,7 +6879,8 @@ static __init int selinux_init(void)
>  
>  	hashtab_cache_init();
>  
> -	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
> +	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks),
> +			   &selinux_lsmid);
>  
>  	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
>  		panic("SELinux: Unable to register AVC netcache callback\n");
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index e9560b078efe..ad646b865295 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4553,6 +4553,8 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_superblock = sizeof(struct superblock_smack),
>  };
>  
> +static struct lsm_id smack_lsmid = { .lsm="smack", .slot=LSMBLOB_NEEDED };

__lsm_ro_after_init

> +
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
> @@ -4743,7 +4745,7 @@ static __init int smack_init(void)
>  	/*
>  	 * Register with LSM
>  	 */
> -	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
> +	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), &smack_lsmid);
>  	smack_enabled = 1;
>  
>  	pr_info("Smack:  Initializing.\n");
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..57e6b845ea51 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -529,6 +529,11 @@ static void tomoyo_task_free(struct task_struct *task)
>  	}
>  }
>  
> +static struct lsm_id tomoyo_lsmid = {

__lsm_ro_after_init

> +	.lsm="tomoyo",
> +	.slot=LSMBLOB_NOT_NEEDED
> +};
> +
>  /*
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
> @@ -581,7 +586,8 @@ static int __init tomoyo_init(void)
>  	struct tomoyo_task *s = tomoyo_task(current);
>  
>  	/* register ourselves with the security framework */
> -	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
> +	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks),
> +			   &tomoyo_lsmid);
>  	pr_info("TOMOYO Linux initialized\n");
>  	s->domain_info = &tomoyo_kernel_domain;
>  	atomic_inc(&tomoyo_kernel_domain.users);
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index efac68556b45..2263822a4af7 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -425,6 +425,8 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> +static struct lsm_id yama_lsmid = { .lsm="yama", .slot=LSMBLOB_NOT_NEEDED };

__lsm_ro_after_init

> +
>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
> @@ -482,7 +484,7 @@ static inline void yama_init_sysctl(void) { }
>  static int __init yama_init(void)
>  {
>  	pr_info("Yama: becoming mindful.\n");
> -	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
> +	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), &yama_lsmid);
>  	yama_init_sysctl();
>  	return 0;
>  }
> 

I like the change,

Reviewed-by: John Johansen <john.johansen@canonical.com>
