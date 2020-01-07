Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5DC33C8C
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04152146E
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 18:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJgLbIsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgAGSKT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:10:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40071 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGSKT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 13:10:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so241102pgt.7
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 10:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x4a42hjuMw+Nj3HMZW7wox7i/V3+YHJKaimtr7RlkX4=;
        b=IJgLbIsVZRjtZPkjcbMdPAPZdrYpI5Bw/vlUHtYlf2/VCv5f3PCGaMkEkmAp4HpKkL
         vJXb02xZfTPA67CV8GrJv8f/U1XqR8bAMkIs0eqbUm0sgo88++ENBtj1WuGYrOVscRj1
         jqeLnT3XeZwFVB5e3+dw7GHR8mdYWQqvzmft8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x4a42hjuMw+Nj3HMZW7wox7i/V3+YHJKaimtr7RlkX4=;
        b=Y49nExrCG0bUzk+RnBygJTW9GPCRHl9aAUD8P9Aa1ejB6nSJ+LrniIg53Qvq6AvBDJ
         D/z1V+H+cO0X1zgHZQffqDx8H536ma/8y6o+ReYEUl5Aq4/lvYGWV/P7d12kZ7fxf3qQ
         L8MV6D0RUcitF153BQW363DfObL7KEHUQ37UWJLVXULd/pucEhhbYzqyrCNyKtI9MtJr
         b7x3l0spbN1X7tfk2cm4uIbxfYRwxZm/KMQZevBYgMCdLYlkSCdcHqNBqSzMr1uR5rz6
         Rx6kBa/9M1vXzvNdCBZ9RCLL+pGYdBQKiAN+2SJx4u3xXmppxi2J3QaGnlUqyXwE+wVl
         kB1A==
X-Gm-Message-State: APjAAAXQcd9vpofhf6jcGr1AyPNrJodNBorBDeTpj34yAXIAkmBlXuMg
        PtSXWOaf/FybzQp/hX5Q6JHQgQ==
X-Google-Smtp-Source: APXvYqwvG7sOP0RMWqCk4JuoU0JHsYK6QCPpwccO1HwR30/ZU8NiTPwmUVduL+TGOO+UJnuyNRmSiA==
X-Received: by 2002:a63:7d8:: with SMTP id 207mr783745pgh.154.1578420616468;
        Tue, 07 Jan 2020 10:10:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm203796pfc.124.2020.01.07.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:10:15 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:10:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 2/2] security,selinux: get rid of security_delete_hooks()
Message-ID: <202001071009.D61992C9B@keescook>
References: <20200107133154.588958-1-omosnace@redhat.com>
 <20200107133154.588958-3-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107133154.588958-3-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 07, 2020 at 02:31:54PM +0100, Ondrej Mosnacek wrote:
> The only user is SELinux, which is hereby converted to check the
> disabled flag in each hook instead of removing the hooks from the list.
> 
> The __lsm_ro_after_init macro is now removed and replaced with
> __ro_after_init directly.
> 
> This fixes a race condition in SELinux runtime disable, which was
> introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> to lists of hooks").
> 
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

I'm a fan of removing the __lsm_ro_after_init special-case, so from
that regard:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/lsm_hooks.h    |  31 --
>  security/Kconfig             |   5 -
>  security/apparmor/lsm.c      |   6 +-
>  security/commoncap.c         |   2 +-
>  security/loadpin/loadpin.c   |   2 +-
>  security/lockdown/lockdown.c |   2 +-
>  security/security.c          |   5 +-
>  security/selinux/Kconfig     |   6 -
>  security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----
>  security/smack/smack_lsm.c   |   4 +-
>  security/tomoyo/tomoyo.c     |   6 +-
>  security/yama/yama_lsm.c     |   2 +-
>  12 files changed, 654 insertions(+), 159 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..5064060ce910 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -27,7 +27,6 @@
>  
>  #include <linux/security.h>
>  #include <linux/init.h>
> -#include <linux/rculist.h>
>  
>  /**
>   * union security_list_options - Linux Security Module hook function list
> @@ -2145,36 +2144,6 @@ extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
>  		__used __section(.early_lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))
>  
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -/*
> - * Assuring the safety of deleting a security module is up to
> - * the security module involved. This may entail ordering the
> - * module's hook list in a particular way, refusing to disable
> - * the module once a policy is loaded or any number of other
> - * actions better imagined than described.
> - *
> - * The name of the configuration option reflects the only module
> - * that currently uses the mechanism. Any developer who thinks
> - * disabling their module is a good idea needs to be at least as
> - * careful as the SELinux team.
> - */
> -static inline void security_delete_hooks(struct security_hook_list *hooks,
> -						int count)
> -{
> -	int i;
> -
> -	for (i = 0; i < count; i++)
> -		hlist_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> -
> -/* Currently required to handle SELinux runtime hook disable. */
> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> -#define __lsm_ro_after_init
> -#else
> -#define __lsm_ro_after_init	__ro_after_init
> -#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> -
>  extern int lsm_inode_alloc(struct inode *inode);
>  
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..456764990a13 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,11 +32,6 @@ config SECURITY
>  
>  	  If you are unsure how to answer this question, answer N.
>  
> -config SECURITY_WRITABLE_HOOKS
> -	depends on SECURITY
> -	bool
> -	default n
> -
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b621ad74f54a..cd83812a440f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  /*
>   * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
>   */
> -struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct aa_task_ctx *),
>  	.lbs_file = sizeof(struct aa_file_ctx),
>  	.lbs_task = sizeof(struct aa_task_ctx),
>  };
>  
> -static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>  	LSM_HOOK_INIT(capget, apparmor_capget),
> @@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_aaintbool = {
>  	.get = param_get_aaintbool
>  };
>  /* Boot time disable flag */
> -static int apparmor_enabled __lsm_ro_after_init = 1;
> +static int apparmor_enabled __ro_after_init = 1;
>  module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
>  
>  static int __init apparmor_enabled_setup(char *str)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4ee0ae106b2..1471d9a5a9bc 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned long reqprot,
>  
>  #ifdef CONFIG_SECURITY
>  
> -static struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list capability_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
>  	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index ee5cb944f4ad..9bbc08bee2c0 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_data_id id)
>  	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>  }
>  
> -static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list loadpin_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 5a952617a0eb..8071d0f542c8 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -71,7 +71,7 @@ static int lockdown_is_locked_down(enum lockdown_reason what)
>  	return 0;
>  }
>  
> -static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list lockdown_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>  };
>  
> diff --git a/security/security.c b/security/security.c
> index 2b5473d92416..3138a5d99813 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -27,6 +27,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/rculist.h>
>  #include <net/flow.h>
>  
>  #define MAX_LSM_EVM_XATTR	2
> @@ -68,14 +69,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
>  
> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +struct security_hook_heads security_hook_heads __ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
>  
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
>  
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __ro_after_init;
>  
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..caa5711478ad 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
>  config SECURITY_SELINUX_DISABLE
>  	bool "NSA SELinux runtime disable"
>  	depends on SECURITY_SELINUX
> -	select SECURITY_WRITABLE_HOOKS
>  	default n
>  	help
>  	  This option enables writing to a selinuxfs node 'disable', which
> @@ -37,11 +36,6 @@ config SECURITY_SELINUX_DISABLE
>  	  portability across platforms where boot parameters are difficult
>  	  to employ.
>  
> -	  NOTE: selecting this option will disable the '__ro_after_init'
> -	  kernel hardening feature for security hooks.   Please consider
> -	  using the selinux=0 boot parameter instead of enabling this
> -	  option.
> -
>  	  If you are unsure how to answer this question, answer N.
>  
>  config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 47ad4db925cf..9ac2b6b69ff9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  {
>  	const struct cred *cred = current_cred();
>  	struct superblock_security_struct *sbsec = sb->s_security;
> -	struct dentry *root = sbsec->sb->s_root;
>  	struct selinux_mnt_opts *opts = mnt_opts;
>  	struct inode_security_struct *root_isec;
>  	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
>  	u32 defcontext_sid = 0;
>  	int rc = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	mutex_lock(&sbsec->lock);
>  
>  	if (!selinux_initialized(&selinux_state)) {
> @@ -693,7 +695,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  	    && !opts)
>  		goto out;
>  
> -	root_isec = backing_inode_security_novalidate(root);
> +	root_isec = backing_inode_security_novalidate(sbsec->sb->s_root);
>  
>  	/*
>  	 * parse the mount options, check if they are valid sids.
> @@ -919,10 +921,14 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	int rc = 0;
>  	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
>  	struct superblock_security_struct *newsbsec = newsb->s_security;
> +	int set_fscontext, set_context, set_rootcontext;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
> -	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
> -	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
> +	set_fscontext =		(oldsbsec->flags & FSCONTEXT_MNT);
> +	set_context =		(oldsbsec->flags & CONTEXT_MNT);
> +	set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
>  
>  	/*
>  	 * if the parent was able to be mounted it clearly had no special lsm
> @@ -1041,6 +1047,9 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
>  	int token = Opt_error;
>  	int rc, i;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	for (i = 0; i < ARRAY_SIZE(tokens); i++) {
>  		if (strcmp(option, tokens[i].name) == 0) {
>  			token = tokens[i].opt;
> @@ -1100,6 +1109,9 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
>  	struct superblock_security_struct *sbsec = sb->s_security;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return 0;
>  
> @@ -2044,22 +2056,27 @@ static inline u32 open_file_to_av(struct file *file)
>  
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid = current_sid();
> -	u32 mgrsid = task_sid(mgr);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
>  
>  static int selinux_binder_transaction(struct task_struct *from,
>  				      struct task_struct *to)
>  {
> -	u32 mysid = current_sid();
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> +	u32 mysid, fromsid, tosid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	mysid = current_sid();
> +	fromsid = task_sid(from);
> +	tosid = task_sid(to);
> +
>  	if (mysid != fromsid) {
>  		rc = avc_has_perm(&selinux_state,
>  				  mysid, fromsid, SECCLASS_BINDER,
> @@ -2076,11 +2093,12 @@ static int selinux_binder_transaction(struct task_struct *from,
>  static int selinux_binder_transfer_binder(struct task_struct *from,
>  					  struct task_struct *to)
>  {
> -	u32 fromsid = task_sid(from);
> -	u32 tosid = task_sid(to);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
> +			    task_sid(from), task_sid(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
>  }
>  
> @@ -2088,13 +2106,18 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  					struct task_struct *to,
>  					struct file *file)
>  {
> -	u32 sid = task_sid(to);
> +	u32 sid;
>  	struct file_security_struct *fsec = selinux_file(file);
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct inode_security_struct *isec;
>  	struct common_audit_data ad;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = task_sid(to);
> +
>  	ad.type = LSM_AUDIT_DATA_PATH;
>  	ad.u.path = file->f_path;
>  
> @@ -2126,19 +2149,26 @@ static int selinux_binder_transfer_file(struct task_struct *from,
>  static int selinux_ptrace_access_check(struct task_struct *child,
>  				     unsigned int mode)
>  {
> -	u32 sid = current_sid();
> -	u32 csid = task_sid(child);
> +	u16 cls = SECCLASS_PROCESS;
> +	u32 perm = PROCESS__PTRACE;
>  
> -	if (mode & PTRACE_MODE_READ)
> -		return avc_has_perm(&selinux_state,
> -				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	if (mode & PTRACE_MODE_READ) {
> +		cls = SECCLASS_FILE;
> +		perm = FILE__READ;
> +	}
>  
>  	return avc_has_perm(&selinux_state,
> -			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> +			    current_sid(), task_sid(child), cls, perm, NULL);
>  }
>  
>  static int selinux_ptrace_traceme(struct task_struct *parent)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
>  			    PROCESS__PTRACE, NULL);
> @@ -2147,6 +2177,9 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
>  static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(target), SECCLASS_PROCESS,
>  			    PROCESS__GETCAP, NULL);
> @@ -2157,6 +2190,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
>  			  const kernel_cap_t *inheritable,
>  			  const kernel_cap_t *permitted)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
>  			    PROCESS__SETCAP, NULL);
> @@ -2175,6 +2211,9 @@ static int selinux_capset(struct cred *new, const struct cred *old,
>  static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
>  			   int cap, unsigned int opts)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return cred_has_capability(cred, cap, opts, ns == &init_user_ns);
>  }
>  
> @@ -2186,6 +2225,9 @@ static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
>  	if (!sb)
>  		return 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmds) {
>  	case Q_SYNC:
>  	case Q_QUOTAON:
> @@ -2210,11 +2252,17 @@ static int selinux_quota_on(struct dentry *dentry)
>  {
>  	const struct cred *cred = current_cred();
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return dentry_has_perm(cred, dentry, FILE__QUOTAON);
>  }
>  
>  static int selinux_syslog(int type)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (type) {
>  	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
>  	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
> @@ -2248,6 +2296,9 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
>  {
>  	int rc, cap_sys_admin = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
>  				 CAP_OPT_NOAUDIT, true);
>  	if (rc == 0)
> @@ -2335,6 +2386,9 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
>  	struct inode *inode = file_inode(bprm->file);
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* SELinux context only depends on initial program or script and not
>  	 * the script interpreter */
>  	if (bprm->called_set_creds)
> @@ -2505,6 +2559,9 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
>  	struct rlimit *rlim, *initrlim;
>  	int rc, i;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	new_tsec = selinux_cred(bprm->cred);
>  	if (new_tsec->sid == new_tsec->osid)
>  		return;
> @@ -2552,6 +2609,9 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  	u32 osid, sid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	osid = tsec->osid;
>  	sid = tsec->sid;
>  
> @@ -2592,11 +2652,17 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  
>  static int selinux_sb_alloc_security(struct super_block *sb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return superblock_alloc_security(sb);
>  }
>  
>  static void selinux_sb_free_security(struct super_block *sb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	superblock_free_security(sb);
>  }
>  
> @@ -2622,6 +2688,9 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  	bool first = true;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	while (1) {
>  		int len = opt_len(from);
>  		int token;
> @@ -2682,6 +2751,9 @@ static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  	u32 sid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return 0;
>  
> @@ -2732,6 +2804,9 @@ static int selinux_sb_kern_mount(struct super_block *sb)
>  	const struct cred *cred = current_cred();
>  	struct common_audit_data ad;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry = sb->s_root;
>  	return superblock_has_perm(cred, sb, FILESYSTEM__MOUNT, &ad);
> @@ -2742,6 +2817,9 @@ static int selinux_sb_statfs(struct dentry *dentry)
>  	const struct cred *cred = current_cred();
>  	struct common_audit_data ad;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry = dentry->d_sb->s_root;
>  	return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &ad);
> @@ -2755,6 +2833,9 @@ static int selinux_mount(const char *dev_name,
>  {
>  	const struct cred *cred = current_cred();
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (flags & MS_REMOUNT)
>  		return superblock_has_perm(cred, path->dentry->d_sb,
>  					   FILESYSTEM__REMOUNT, NULL);
> @@ -2766,6 +2847,9 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
>  {
>  	const struct cred *cred = current_cred();
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return superblock_has_perm(cred, mnt->mnt_sb,
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
> @@ -2776,6 +2860,9 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>  	const struct selinux_mnt_opts *src = src_fc->security;
>  	struct selinux_mnt_opts *opts;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!src)
>  		return 0;
>  
> @@ -2828,6 +2915,9 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
>  	struct fs_parse_result result;
>  	int opt, rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	opt = fs_parse(fc, &selinux_fs_parameters, param, &result);
>  	if (opt < 0)
>  		return opt;
> @@ -2844,11 +2934,17 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
>  
>  static int selinux_inode_alloc_security(struct inode *inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return inode_alloc_security(inode);
>  }
>  
>  static void selinux_inode_free_security(struct inode *inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	inode_free_security(inode);
>  }
>  
> @@ -2859,6 +2955,9 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
>  	u32 newsid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
>  					   d_inode(dentry->d_parent), name,
>  					   inode_mode_to_security_class(mode),
> @@ -2879,6 +2978,9 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
>  	int rc;
>  	struct task_security_struct *tsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc = selinux_determine_inode_label(selinux_cred(old),
>  					   d_inode(dentry->d_parent), name,
>  					   inode_mode_to_security_class(mode),
> @@ -2902,6 +3004,9 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	int rc;
>  	char *context;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sbsec = dir->i_sb->s_security;
>  
>  	newsid = tsec->create_sid;
> @@ -2941,50 +3046,75 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  
>  static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_FILE);
>  }
>  
>  static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, old_dentry, MAY_LINK);
>  }
>  
>  static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, dentry, MAY_UNLINK);
>  }
>  
>  static int selinux_inode_symlink(struct inode *dir, struct dentry *dentry, const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_LNK_FILE);
>  }
>  
>  static int selinux_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mask)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_DIR);
>  }
>  
>  static int selinux_inode_rmdir(struct inode *dir, struct dentry *dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, dentry, MAY_RMDIR);
>  }
>  
>  static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, inode_mode_to_security_class(mode));
>  }
>  
>  static int selinux_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
>  				struct inode *new_inode, struct dentry *new_dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
>  }
>  
>  static int selinux_inode_readlink(struct dentry *dentry)
>  {
> -	const struct cred *cred = current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	return dentry_has_perm(cred, dentry, FILE__READ);
> +	return dentry_has_perm(current_cred(), dentry, FILE__READ);
>  }
>  
>  static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
> @@ -2995,6 +3125,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
>  	struct inode_security_struct *isec;
>  	u32 sid;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	validate_creds(cred);
>  
>  	ad.type = LSM_AUDIT_DATA_DENTRY;
> @@ -3040,6 +3173,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
>  	int rc, rc2;
>  	u32 audited, denied;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	from_access = mask & MAY_ACCESS;
>  	mask &= (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
>  
> @@ -3086,6 +3222,9 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  	unsigned int ia_valid = iattr->ia_valid;
>  	__u32 av = FILE__WRITE;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
>  	if (ia_valid & ATTR_FORCE) {
>  		ia_valid &= ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE |
> @@ -3109,6 +3248,9 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  
>  static int selinux_inode_getattr(const struct path *path)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return path_has_perm(current_cred(), path, FILE__GETATTR);
>  }
>  
> @@ -3131,9 +3273,12 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	struct inode_security_struct *isec;
>  	struct superblock_security_struct *sbsec;
>  	struct common_audit_data ad;
> -	u32 newsid, sid = current_sid();
> +	u32 newsid, sid;
>  	int rc = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		rc = cap_inode_setxattr(dentry, name, value, size, flags);
>  		if (rc)
> @@ -3154,6 +3299,8 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  	if (!inode_owner_or_capable(inode))
>  		return -EPERM;
>  
> +	sid = current_sid();
> +
>  	ad.type = LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry = dentry;
>  
> @@ -3225,6 +3372,9 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  	u32 newsid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		/* Not an attribute we recognize, so nothing to do. */
>  		return;
> @@ -3260,20 +3410,25 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
>  
>  static int selinux_inode_getxattr(struct dentry *dentry, const char *name)
>  {
> -	const struct cred *cred = current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	return dentry_has_perm(cred, dentry, FILE__GETATTR);
> +	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
>  }
>  
>  static int selinux_inode_listxattr(struct dentry *dentry)
>  {
> -	const struct cred *cred = current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	return dentry_has_perm(cred, dentry, FILE__GETATTR);
> +	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
>  }
>  
>  static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		int rc = cap_inode_removexattr(dentry, name);
>  		if (rc)
> @@ -3297,6 +3452,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
>  
>  	struct common_audit_data ad;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_PATH;
>  	ad.u.path = *path;
>  
> @@ -3345,6 +3503,9 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
>  	char *context = NULL;
>  	struct inode_security_struct *isec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
>  
> @@ -3385,6 +3546,9 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  	u32 newsid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
>  
> @@ -3410,6 +3574,10 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
>  {
>  	const int len = sizeof(XATTR_NAME_SELINUX);
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (buffer && len <= buffer_size)
>  		memcpy(buffer, XATTR_NAME_SELINUX, len);
>  	return len;
> @@ -3417,16 +3585,24 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
>  
>  static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
>  {
> -	struct inode_security_struct *isec = inode_security_novalidate(inode);
> +	struct inode_security_struct *isec;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	isec = inode_security_novalidate(inode);
>  	*secid = isec->sid;
>  }
>  
>  static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
>  {
> -	u32 sid;
> +	struct inode_security_struct *isec;
>  	struct task_security_struct *tsec;
>  	struct cred *new_creds = *new;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (new_creds == NULL) {
>  		new_creds = prepare_creds();
>  		if (!new_creds)
> @@ -3435,14 +3611,17 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
>  
>  	tsec = selinux_cred(new_creds);
>  	/* Get label from overlay inode and set it in create_sid */
> -	selinux_inode_getsecid(d_inode(src), &sid);
> -	tsec->create_sid = sid;
> +	isec = inode_security_novalidate(d_inode(src));
> +	tsec->create_sid = isec->sid;
>  	*new = new_creds;
>  	return 0;
>  }
>  
>  static int selinux_inode_copy_up_xattr(const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	/* The copy_up hook above sets the initial context on an inode, but we
>  	 * don't then want to overwrite it by blindly copying all the lower
>  	 * xattrs up.  Instead, we have to filter out SELinux-related xattrs.
> @@ -3466,6 +3645,9 @@ static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
>  	int rc;
>  	char *context;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc = kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
>  	if (rc == -ENODATA)
>  		return 0;
> @@ -3537,14 +3719,16 @@ static int selinux_file_permission(struct file *file, int mask)
>  	struct inode *inode = file_inode(file);
>  	struct file_security_struct *fsec = selinux_file(file);
>  	struct inode_security_struct *isec;
> -	u32 sid = current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	if (!mask)
>  		/* No permission to check.  Existence test. */
>  		return 0;
>  
>  	isec = inode_security(inode);
> -	if (sid == fsec->sid && fsec->isid == isec->sid &&
> +	if (current_sid() == fsec->sid && fsec->isid == isec->sid &&
>  	    fsec->pseqno == avc_policy_seqno(&selinux_state))
>  		/* No change since file_open check. */
>  		return 0;
> @@ -3554,6 +3738,9 @@ static int selinux_file_permission(struct file *file, int mask)
>  
>  static int selinux_file_alloc_security(struct file *file)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return file_alloc_security(file);
>  }
>  
> @@ -3606,6 +3793,9 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
>  	const struct cred *cred = current_cred();
>  	int error = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case FIONREAD:
>  	/* fall through */
> @@ -3692,6 +3882,9 @@ static int selinux_mmap_addr(unsigned long addr)
>  {
>  	int rc = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>  		u32 sid = current_sid();
>  		rc = avc_has_perm(&selinux_state,
> @@ -3708,6 +3901,9 @@ static int selinux_mmap_file(struct file *file, unsigned long reqprot,
>  	struct common_audit_data ad;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (file) {
>  		ad.type = LSM_AUDIT_DATA_FILE;
>  		ad.u.file = file;
> @@ -3729,7 +3925,12 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>  				 unsigned long prot)
>  {
>  	const struct cred *cred = current_cred();
> -	u32 sid = cred_sid(cred);
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = cred_sid(cred);
>  
>  	if (selinux_state.checkreqprot)
>  		prot = reqprot;
> @@ -3768,9 +3969,10 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
>  
>  static int selinux_file_lock(struct file *file, unsigned int cmd)
>  {
> -	const struct cred *cred = current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	return file_has_perm(cred, file, FILE__LOCK);
> +	return file_has_perm(current_cred(), file, FILE__LOCK);
>  }
>  
>  static int selinux_file_fcntl(struct file *file, unsigned int cmd,
> @@ -3779,6 +3981,9 @@ static int selinux_file_fcntl(struct file *file, unsigned int cmd,
>  	const struct cred *cred = current_cred();
>  	int err = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case F_SETFL:
>  		if ((file->f_flags & O_APPEND) && !(arg & O_APPEND)) {
> @@ -3817,6 +4022,9 @@ static void selinux_file_set_fowner(struct file *file)
>  {
>  	struct file_security_struct *fsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	fsec = selinux_file(file);
>  	fsec->fown_sid = current_sid();
>  }
> @@ -3825,10 +4033,12 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  				       struct fown_struct *fown, int signum)
>  {
>  	struct file *file;
> -	u32 sid = task_sid(tsk);
>  	u32 perm;
>  	struct file_security_struct *fsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* struct fown_struct is never outside the context of a struct file */
>  	file = container_of(fown, struct file, f_owner);
>  
> @@ -3840,15 +4050,16 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
>  		perm = signal_to_av(signum);
>  
>  	return avc_has_perm(&selinux_state,
> -			    fsec->fown_sid, sid,
> +			    fsec->fown_sid, task_sid(tsk),
>  			    SECCLASS_PROCESS, perm, NULL);
>  }
>  
>  static int selinux_file_receive(struct file *file)
>  {
> -	const struct cred *cred = current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
> -	return file_has_perm(cred, file, file_to_av(file));
> +	return file_has_perm(current_cred(), file, file_to_av(file));
>  }
>  
>  static int selinux_file_open(struct file *file)
> @@ -3856,6 +4067,9 @@ static int selinux_file_open(struct file *file)
>  	struct file_security_struct *fsec;
>  	struct inode_security_struct *isec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	fsec = selinux_file(file);
>  	isec = inode_security(file_inode(file));
>  	/*
> @@ -3883,7 +4097,12 @@ static int selinux_file_open(struct file *file)
>  static int selinux_task_alloc(struct task_struct *task,
>  			      unsigned long clone_flags)
>  {
> -	u32 sid = current_sid();
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = current_sid();
>  
>  	return avc_has_perm(&selinux_state,
>  			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
> @@ -3898,6 +4117,9 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
>  	const struct task_security_struct *old_tsec = selinux_cred(old);
>  	struct task_security_struct *tsec = selinux_cred(new);
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	*tsec = *old_tsec;
>  	return 0;
>  }
> @@ -3910,11 +4132,17 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
>  	const struct task_security_struct *old_tsec = selinux_cred(old);
>  	struct task_security_struct *tsec = selinux_cred(new);
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*tsec = *old_tsec;
>  }
>  
>  static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*secid = cred_sid(c);
>  }
>  
> @@ -3925,11 +4153,13 @@ static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
>  static int selinux_kernel_act_as(struct cred *new, u32 secid)
>  {
>  	struct task_security_struct *tsec = selinux_cred(new);
> -	u32 sid = current_sid();
>  	int ret;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ret = avc_has_perm(&selinux_state,
> -			   sid, secid,
> +			   current_sid(), secid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__USE_AS_OVERRIDE,
>  			   NULL);
> @@ -3950,11 +4180,13 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
>  {
>  	struct inode_security_struct *isec = inode_security(inode);
>  	struct task_security_struct *tsec = selinux_cred(new);
> -	u32 sid = current_sid();
>  	int ret;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ret = avc_has_perm(&selinux_state,
> -			   sid, isec->sid,
> +			   current_sid(), isec->sid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__CREATE_FILES_AS,
>  			   NULL);
> @@ -3968,6 +4200,9 @@ static int selinux_kernel_module_request(char *kmod_name)
>  {
>  	struct common_audit_data ad;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_KMOD;
>  	ad.u.kmod_name = kmod_name;
>  
> @@ -4012,35 +4247,37 @@ static int selinux_kernel_module_from_file(struct file *file)
>  static int selinux_kernel_read_file(struct file *file,
>  				    enum kernel_read_file_id id)
>  {
> -	int rc = 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	switch (id) {
>  	case READING_MODULE:
> -		rc = selinux_kernel_module_from_file(file);
> -		break;
> +		return selinux_kernel_module_from_file(file);
>  	default:
>  		break;
>  	}
> -
> -	return rc;
> +	return 0;
>  }
>  
>  static int selinux_kernel_load_data(enum kernel_load_data_id id)
>  {
> -	int rc = 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	switch (id) {
>  	case LOADING_MODULE:
> -		rc = selinux_kernel_module_from_file(NULL);
> +		return selinux_kernel_module_from_file(NULL);
>  	default:
>  		break;
>  	}
> -
> -	return rc;
> +	return 0;
>  }
>  
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETPGID, NULL);
> @@ -4048,6 +4285,9 @@ static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  
>  static int selinux_task_getpgid(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETPGID, NULL);
> @@ -4055,6 +4295,9 @@ static int selinux_task_getpgid(struct task_struct *p)
>  
>  static int selinux_task_getsid(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSESSION, NULL);
> @@ -4062,11 +4305,17 @@ static int selinux_task_getsid(struct task_struct *p)
>  
>  static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*secid = task_sid(p);
>  }
>  
>  static int selinux_task_setnice(struct task_struct *p, int nice)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4074,6 +4323,9 @@ static int selinux_task_setnice(struct task_struct *p, int nice)
>  
>  static int selinux_task_setioprio(struct task_struct *p, int ioprio)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4081,6 +4333,9 @@ static int selinux_task_setioprio(struct task_struct *p, int ioprio)
>  
>  static int selinux_task_getioprio(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
> @@ -4091,6 +4346,9 @@ static int selinux_task_prlimit(const struct cred *cred, const struct cred *tcre
>  {
>  	u32 av = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!flags)
>  		return 0;
>  	if (flags & LSM_PRLIMIT_WRITE)
> @@ -4107,6 +4365,9 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  {
>  	struct rlimit *old_rlim = p->signal->rlim + resource;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* Control the ability to change the hard limit (whether
>  	   lowering or raising it), so that the hard limit can
>  	   later be used as a safe reset point for the soft limit
> @@ -4121,6 +4382,9 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
>  
>  static int selinux_task_setscheduler(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4128,6 +4392,9 @@ static int selinux_task_setscheduler(struct task_struct *p)
>  
>  static int selinux_task_getscheduler(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
> @@ -4135,6 +4402,9 @@ static int selinux_task_getscheduler(struct task_struct *p)
>  
>  static int selinux_task_movememory(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4146,6 +4416,9 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
>  	u32 secid;
>  	u32 perm;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!sig)
>  		perm = PROCESS__SIGNULL; /* null signal; existence test */
>  	else
> @@ -4162,11 +4435,13 @@ static void selinux_task_to_inode(struct task_struct *p,
>  				  struct inode *inode)
>  {
>  	struct inode_security_struct *isec = selinux_inode(inode);
> -	u32 sid = task_sid(p);
> +
> +	if (selinux_disabled(&selinux_state))
> +		return;
>  
>  	spin_lock(&isec->lock);
>  	isec->sclass = inode_mode_to_security_class(inode->i_mode);
> -	isec->sid = sid;
> +	isec->sid = task_sid(p);
>  	isec->initialized = LABEL_INITIALIZED;
>  	spin_unlock(&isec->lock);
>  }
> @@ -4506,6 +4781,9 @@ static int selinux_socket_create(int family, int type,
>  	if (kern)
>  		return 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	secclass = socket_type_to_security_class(family, type, protocol);
>  	rc = socket_sockcreate_sid(tsec, secclass, &newsid);
>  	if (rc)
> @@ -4525,6 +4803,9 @@ static int selinux_socket_post_create(struct socket *sock, int family,
>  	u32 sid = SECINITSID_KERNEL;
>  	int err = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!kern) {
>  		err = socket_sockcreate_sid(tsec, sclass, &sid);
>  		if (err)
> @@ -4555,6 +4836,9 @@ static int selinux_socket_socketpair(struct socket *socka,
>  	struct sk_security_struct *sksec_a = socka->sk->sk_security;
>  	struct sk_security_struct *sksec_b = sockb->sk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sksec_a->peer_sid = sksec_b->sid;
>  	sksec_b->peer_sid = sksec_a->sid;
>  
> @@ -4572,6 +4856,9 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>  	u16 family;
>  	int err;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = sock_has_perm(sk, SOCKET__BIND);
>  	if (err)
>  		goto out;
> @@ -4796,6 +5083,9 @@ static int selinux_socket_connect(struct socket *sock,
>  	int err;
>  	struct sock *sk = sock->sk;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = selinux_socket_connect_helper(sock, address, addrlen);
>  	if (err)
>  		return err;
> @@ -4805,6 +5095,9 @@ static int selinux_socket_connect(struct socket *sock,
>  
>  static int selinux_socket_listen(struct socket *sock, int backlog)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__LISTEN);
>  }
>  
> @@ -4816,6 +5109,9 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
>  	u16 sclass;
>  	u32 sid;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = sock_has_perm(sock->sk, SOCKET__ACCEPT);
>  	if (err)
>  		return err;
> @@ -4837,22 +5133,34 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
>  static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  				  int size)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__WRITE);
>  }
>  
>  static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
>  				  int size, int flags)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__READ);
>  }
>  
>  static int selinux_socket_getsockname(struct socket *sock)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETATTR);
>  }
>  
>  static int selinux_socket_getpeername(struct socket *sock)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETATTR);
>  }
>  
> @@ -4860,6 +5168,9 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
>  {
>  	int err;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = sock_has_perm(sock->sk, SOCKET__SETOPT);
>  	if (err)
>  		return err;
> @@ -4870,11 +5181,17 @@ static int selinux_socket_setsockopt(struct socket *sock, int level, int optname
>  static int selinux_socket_getsockopt(struct socket *sock, int level,
>  				     int optname)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETOPT);
>  }
>  
>  static int selinux_socket_shutdown(struct socket *sock, int how)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__SHUTDOWN);
>  }
>  
> @@ -4889,6 +5206,9 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
>  	struct lsm_network_audit net = {0,};
>  	int err;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_NET;
>  	ad.u.net = &net;
>  	ad.u.net->sk = other;
> @@ -4921,6 +5241,9 @@ static int selinux_socket_unix_may_send(struct socket *sock,
>  	struct common_audit_data ad;
>  	struct lsm_network_audit net = {0,};
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type = LSM_AUDIT_DATA_NET;
>  	ad.u.net = &net;
>  	ad.u.net->sk = other->sk;
> @@ -4994,13 +5317,15 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	int err;
>  	struct sk_security_struct *sksec = sk->sk_security;
>  	u16 family = sk->sk_family;
> -	u32 sk_sid = sksec->sid;
>  	struct common_audit_data ad;
>  	struct lsm_network_audit net = {0,};
>  	char *addrp;
>  	u8 secmark_active;
>  	u8 peerlbl_active;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (family != PF_INET && family != PF_INET6)
>  		return 0;
>  
> @@ -5041,7 +5366,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  			return err;
>  		}
>  		err = avc_has_perm(&selinux_state,
> -				   sk_sid, peer_sid, SECCLASS_PEER,
> +				   sksec->sid, peer_sid, SECCLASS_PEER,
>  				   PEER__RECV, &ad);
>  		if (err) {
>  			selinux_netlbl_err(skb, family, err, 0);
> @@ -5051,7 +5376,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  
>  	if (secmark_active) {
>  		err = avc_has_perm(&selinux_state,
> -				   sk_sid, skb->secmark, SECCLASS_PACKET,
> +				   sksec->sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
>  		if (err)
>  			return err;
> @@ -5069,6 +5394,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char __user *op
>  	struct sk_security_struct *sksec = sock->sk->sk_security;
>  	u32 peer_sid = SECSID_NULL;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (sksec->sclass == SECCLASS_UNIX_STREAM_SOCKET ||
>  	    sksec->sclass == SECCLASS_TCP_SOCKET ||
>  	    sksec->sclass == SECCLASS_SCTP_SOCKET)
> @@ -5102,6 +5430,9 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
>  	u16 family;
>  	struct inode_security_struct *isec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (skb && skb->protocol == htons(ETH_P_IP))
>  		family = PF_INET;
>  	else if (skb && skb->protocol == htons(ETH_P_IPV6))
> @@ -5128,6 +5459,9 @@ static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority
>  {
>  	struct sk_security_struct *sksec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sksec = kzalloc(sizeof(*sksec), priority);
>  	if (!sksec)
>  		return -ENOMEM;
> @@ -5145,6 +5479,9 @@ static void selinux_sk_free_security(struct sock *sk)
>  {
>  	struct sk_security_struct *sksec = sk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	sk->sk_security = NULL;
>  	selinux_netlbl_sk_security_free(sksec);
>  	kfree(sksec);
> @@ -5155,6 +5492,9 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
>  	struct sk_security_struct *sksec = sk->sk_security;
>  	struct sk_security_struct *newsksec = newsk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	newsksec->sid = sksec->sid;
>  	newsksec->peer_sid = sksec->peer_sid;
>  	newsksec->sclass = sksec->sclass;
> @@ -5164,6 +5504,9 @@ static void selinux_sk_clone_security(const struct sock *sk, struct sock *newsk)
>  
>  static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (!sk)
>  		*secid = SECINITSID_ANY_SOCKET;
>  	else {
> @@ -5175,10 +5518,14 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
>  
>  static void selinux_sock_graft(struct sock *sk, struct socket *parent)
>  {
> -	struct inode_security_struct *isec =
> -		inode_security_novalidate(SOCK_INODE(parent));
> +	struct inode_security_struct *isec;
>  	struct sk_security_struct *sksec = sk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	isec = inode_security_novalidate(SOCK_INODE(parent));
> +
>  	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
>  	    sk->sk_family == PF_UNIX)
>  		isec->sid = sksec->sid;
> @@ -5200,6 +5547,9 @@ static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
>  	u32 conn_sid;
>  	int err = 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
>  
> @@ -5270,6 +5620,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>  	struct sockaddr *addr;
>  	struct socket *sock;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
>  
> @@ -5346,6 +5699,9 @@ static void selinux_sctp_sk_clone(struct sctp_endpoint *ep, struct sock *sk,
>  	struct sk_security_struct *sksec = sk->sk_security;
>  	struct sk_security_struct *newsksec = newsk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	/* If policy does not support SECCLASS_SCTP_SOCKET then call
>  	 * the non-sctp clone version.
>  	 */
> @@ -5367,6 +5723,9 @@ static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb,
>  	u32 connsid;
>  	u32 peersid;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = selinux_skb_peerlbl_sid(skb, family, &peersid);
>  	if (err)
>  		return err;
> @@ -5384,6 +5743,9 @@ static void selinux_inet_csk_clone(struct sock *newsk,
>  {
>  	struct sk_security_struct *newsksec = newsk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	newsksec->sid = req->secid;
>  	newsksec->peer_sid = req->peer_secid;
>  	/* NOTE: Ideally, we should also get the isec->sid for the
> @@ -5401,6 +5763,9 @@ static void selinux_inet_conn_established(struct sock *sk, struct sk_buff *skb)
>  	u16 family = sk->sk_family;
>  	struct sk_security_struct *sksec = sk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	/* handle mapped IPv4 packets arriving via IPv6 sockets */
>  	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
>  		family = PF_INET;
> @@ -5413,6 +5778,9 @@ static int selinux_secmark_relabel_packet(u32 sid)
>  	const struct task_security_struct *__tsec;
>  	u32 tsid;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	__tsec = selinux_cred(current_cred());
>  	tsid = __tsec->sid;
>  
> @@ -5423,17 +5791,26 @@ static int selinux_secmark_relabel_packet(u32 sid)
>  
>  static void selinux_secmark_refcount_inc(void)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	atomic_inc(&selinux_secmark_refcount);
>  }
>  
>  static void selinux_secmark_refcount_dec(void)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	atomic_dec(&selinux_secmark_refcount);
>  }
>  
>  static void selinux_req_classify_flow(const struct request_sock *req,
>  				      struct flowi *fl)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	fl->flowi_secid = req->secid;
>  }
>  
> @@ -5441,6 +5818,9 @@ static int selinux_tun_dev_alloc_security(void **security)
>  {
>  	struct tun_security_struct *tunsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	tunsec = kzalloc(sizeof(*tunsec), GFP_KERNEL);
>  	if (!tunsec)
>  		return -ENOMEM;
> @@ -5452,12 +5832,20 @@ static int selinux_tun_dev_alloc_security(void **security)
>  
>  static void selinux_tun_dev_free_security(void *security)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	kfree(security);
>  }
>  
>  static int selinux_tun_dev_create(void)
>  {
> -	u32 sid = current_sid();
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = current_sid();
>  
>  	/* we aren't taking into account the "sockcreate" SID since the socket
>  	 * that is being created here is not a socket in the traditional sense,
> @@ -5475,6 +5863,9 @@ static int selinux_tun_dev_attach_queue(void *security)
>  {
>  	struct tun_security_struct *tunsec = security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
>  			    TUN_SOCKET__ATTACH_QUEUE, NULL);
> @@ -5485,6 +5876,9 @@ static int selinux_tun_dev_attach(struct sock *sk, void *security)
>  	struct tun_security_struct *tunsec = security;
>  	struct sk_security_struct *sksec = sk->sk_security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* we don't currently perform any NetLabel based labeling here and it
>  	 * isn't clear that we would want to do so anyway; while we could apply
>  	 * labeling without the support of the TUN user the resulting labeled
> @@ -5501,8 +5895,13 @@ static int selinux_tun_dev_attach(struct sock *sk, void *security)
>  static int selinux_tun_dev_open(void *security)
>  {
>  	struct tun_security_struct *tunsec = security;
> -	u32 sid = current_sid();
>  	int err;
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = current_sid();
>  
>  	err = avc_has_perm(&selinux_state,
>  			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
> @@ -5885,6 +6284,9 @@ static unsigned int selinux_ipv6_postroute(void *priv,
>  
>  static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return selinux_nlmsg_perm(sk, skb);
>  }
>  
> @@ -5922,6 +6324,9 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc_perms,
>  
>  static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return msg_msg_alloc_security(msg);
>  }
>  
> @@ -5930,9 +6335,11 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec = selinux_ipc(msq);
>  	ipc_init_security(isec, SECCLASS_MSGQ);
>  
> @@ -5940,7 +6347,7 @@ static int selinux_msg_queue_alloc_security(struct kern_ipc_perm *msq)
>  	ad.u.ipc_id = msq->key;
>  
>  	rc = avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_MSGQ,
> +			  current_sid(), isec->sid, SECCLASS_MSGQ,
>  			  MSGQ__CREATE, &ad);
>  	return rc;
>  }
> @@ -5949,7 +6356,9 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	isec = selinux_ipc(msq);
>  
> @@ -5957,7 +6366,7 @@ static int selinux_msg_queue_associate(struct kern_ipc_perm *msq, int msqflg)
>  	ad.u.ipc_id = msq->key;
>  
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_MSGQ,
> +			    current_sid(), isec->sid, SECCLASS_MSGQ,
>  			    MSGQ__ASSOCIATE, &ad);
>  }
>  
> @@ -5966,6 +6375,9 @@ static int selinux_msg_queue_msgctl(struct kern_ipc_perm *msq, int cmd)
>  	int err;
>  	int perms;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case MSG_INFO:
> @@ -5997,9 +6409,14 @@ static int selinux_msg_queue_msgsnd(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
> +	u32 sid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = current_sid();
> +
>  	isec = selinux_ipc(msq);
>  	msec = selinux_msg_msg(msg);
>  
> @@ -6045,9 +6462,14 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = task_sid(target);
> +	u32 sid;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = task_sid(target);
> +
>  	isec = selinux_ipc(msq);
>  	msec = selinux_msg_msg(msg);
>  
> @@ -6069,9 +6491,11 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec = selinux_ipc(shp);
>  	ipc_init_security(isec, SECCLASS_SHM);
>  
> @@ -6079,8 +6503,8 @@ static int selinux_shm_alloc_security(struct kern_ipc_perm *shp)
>  	ad.u.ipc_id = shp->key;
>  
>  	rc = avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_SHM,
> -			  SHM__CREATE, &ad);
> +			  current_sid(), isec->sid,
> +			  SECCLASS_SHM, SHM__CREATE, &ad);
>  	return rc;
>  }
>  
> @@ -6088,7 +6512,9 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	isec = selinux_ipc(shp);
>  
> @@ -6096,8 +6522,8 @@ static int selinux_shm_associate(struct kern_ipc_perm *shp, int shmflg)
>  	ad.u.ipc_id = shp->key;
>  
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_SHM,
> -			    SHM__ASSOCIATE, &ad);
> +			    current_sid(), isec->sid,
> +			    SECCLASS_SHM, SHM__ASSOCIATE, &ad);
>  }
>  
>  /* Note, at this point, shp is locked down */
> @@ -6106,6 +6532,9 @@ static int selinux_shm_shmctl(struct kern_ipc_perm *shp, int cmd)
>  	int perms;
>  	int err;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case SHM_INFO:
> @@ -6141,6 +6570,9 @@ static int selinux_shm_shmat(struct kern_ipc_perm *shp,
>  {
>  	u32 perms;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (shmflg & SHM_RDONLY)
>  		perms = SHM__READ;
>  	else
> @@ -6154,9 +6586,11 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec = selinux_ipc(sma);
>  	ipc_init_security(isec, SECCLASS_SEM);
>  
> @@ -6164,8 +6598,8 @@ static int selinux_sem_alloc_security(struct kern_ipc_perm *sma)
>  	ad.u.ipc_id = sma->key;
>  
>  	rc = avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_SEM,
> -			  SEM__CREATE, &ad);
> +			  current_sid(), isec->sid,
> +			  SECCLASS_SEM, SEM__CREATE, &ad);
>  	return rc;
>  }
>  
> @@ -6173,7 +6607,9 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	isec = selinux_ipc(sma);
>  
> @@ -6181,8 +6617,8 @@ static int selinux_sem_associate(struct kern_ipc_perm *sma, int semflg)
>  	ad.u.ipc_id = sma->key;
>  
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_SEM,
> -			    SEM__ASSOCIATE, &ad);
> +			    current_sid(), isec->sid,
> +			    SECCLASS_SEM, SEM__ASSOCIATE, &ad);
>  }
>  
>  /* Note, at this point, sma is locked down */
> @@ -6191,6 +6627,9 @@ static int selinux_sem_semctl(struct kern_ipc_perm *sma, int cmd)
>  	int err;
>  	u32 perms;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case SEM_INFO:
> @@ -6235,6 +6674,9 @@ static int selinux_sem_semop(struct kern_ipc_perm *sma,
>  {
>  	u32 perms;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (alter)
>  		perms = SEM__READ | SEM__WRITE;
>  	else
> @@ -6247,7 +6689,9 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  {
>  	u32 av = 0;
>  
> -	av = 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (flag & S_IRUGO)
>  		av |= IPC__UNIX_READ;
>  	if (flag & S_IWUGO)
> @@ -6261,12 +6705,17 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  
>  static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
>  {
> -	struct ipc_security_struct *isec = selinux_ipc(ipcp);
> -	*secid = isec->sid;
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	*secid = selinux_ipc(ipcp)->sid;
>  }
>  
>  static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (inode)
>  		inode_doinit_with_dentry(inode, dentry);
>  }
> @@ -6279,6 +6728,9 @@ static int selinux_getprocattr(struct task_struct *p,
>  	int error;
>  	unsigned len;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return -EINVAL;
> +
>  	rcu_read_lock();
>  	__tsec = selinux_cred(__task_cred(p));
>  
> @@ -6325,10 +6777,15 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  {
>  	struct task_security_struct *tsec;
>  	struct cred *new;
> -	u32 mysid = current_sid(), sid = 0, ptsid;
> +	u32 mysid, sid = 0, ptsid;
>  	int error;
>  	char *str = value;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return -EINVAL;
> +
> +	mysid = current_sid();
> +
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> @@ -6466,17 +6923,26 @@ abort_change:
>  
>  static int selinux_ismaclabel(const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
>  }
>  
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	return security_sid_to_context(&selinux_state, secid,
>  				       secdata, seclen);
>  }
>  
>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return security_context_to_sid(&selinux_state, secdata, seclen,
>  				       secid, GFP_KERNEL);
>  }
> @@ -6490,6 +6956,9 @@ static void selinux_inode_invalidate_secctx(struct inode *inode)
>  {
>  	struct inode_security_struct *isec = selinux_inode(inode);
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	spin_lock(&isec->lock);
>  	isec->initialized = LABEL_INVALID;
>  	spin_unlock(&isec->lock);
> @@ -6511,6 +6980,9 @@ static int selinux_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen
>   */
>  static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen, 0);
>  }
>  
> @@ -6532,6 +7004,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
>  	const struct task_security_struct *tsec;
>  	struct key_security_struct *ksec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
>  	if (!ksec)
>  		return -ENOMEM;
> @@ -6550,6 +7025,9 @@ static void selinux_key_free(struct key *k)
>  {
>  	struct key_security_struct *ksec = k->security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	k->security = NULL;
>  	kfree(ksec);
>  }
> @@ -6568,6 +7046,9 @@ static int selinux_key_permission(key_ref_t key_ref,
>  	if (perm == 0)
>  		return 0;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sid = cred_sid(cred);
>  
>  	key = key_ref_to_ptr(key_ref);
> @@ -6584,6 +7065,9 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
>  	unsigned len;
>  	int rc;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc = security_sid_to_context(&selinux_state, ksec->sid,
>  				     &context, &len);
>  	if (!rc)
> @@ -6602,6 +7086,9 @@ static int selinux_ib_pkey_access(void *ib_sec, u64 subnet_prefix, u16 pkey_val)
>  	struct ib_security_struct *sec = ib_sec;
>  	struct lsm_ibpkey_audit ibpkey;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = sel_ib_pkey_sid(subnet_prefix, pkey_val, &sid);
>  	if (err)
>  		return err;
> @@ -6625,6 +7112,9 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
>  	struct ib_security_struct *sec = ib_sec;
>  	struct lsm_ibendport_audit ibendport;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err = security_ib_endport_sid(&selinux_state, dev_name, port_num,
>  				      &sid);
>  
> @@ -6645,6 +7135,9 @@ static int selinux_ib_alloc_security(void **ib_sec)
>  {
>  	struct ib_security_struct *sec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
>  	if (!sec)
>  		return -ENOMEM;
> @@ -6656,6 +7149,9 @@ static int selinux_ib_alloc_security(void **ib_sec)
>  
>  static void selinux_ib_free_security(void *ib_sec)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	kfree(ib_sec);
>  }
>  #endif
> @@ -6667,6 +7163,9 @@ static int selinux_bpf(int cmd, union bpf_attr *attr,
>  	u32 sid = current_sid();
>  	int ret;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case BPF_MAP_CREATE:
>  		ret = avc_has_perm(&selinux_state,
> @@ -6734,23 +7233,27 @@ static int bpf_fd_pass(struct file *file, u32 sid)
>  
>  static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
> -	u32 sid = current_sid();
>  	struct bpf_security_struct *bpfsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec = map->security;
>  	return avc_has_perm(&selinux_state,
> -			    sid, bpfsec->sid, SECCLASS_BPF,
> +			    current_sid(), bpfsec->sid, SECCLASS_BPF,
>  			    bpf_map_fmode_to_av(fmode), NULL);
>  }
>  
>  static int selinux_bpf_prog(struct bpf_prog *prog)
>  {
> -	u32 sid = current_sid();
>  	struct bpf_security_struct *bpfsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec = prog->aux->security;
>  	return avc_has_perm(&selinux_state,
> -			    sid, bpfsec->sid, SECCLASS_BPF,
> +			    current_sid(), bpfsec->sid, SECCLASS_BPF,
>  			    BPF__PROG_RUN, NULL);
>  }
>  
> @@ -6758,6 +7261,9 @@ static int selinux_bpf_map_alloc(struct bpf_map *map)
>  {
>  	struct bpf_security_struct *bpfsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>  	if (!bpfsec)
>  		return -ENOMEM;
> @@ -6772,6 +7278,9 @@ static void selinux_bpf_map_free(struct bpf_map *map)
>  {
>  	struct bpf_security_struct *bpfsec = map->security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	map->security = NULL;
>  	kfree(bpfsec);
>  }
> @@ -6780,6 +7289,9 @@ static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
>  {
>  	struct bpf_security_struct *bpfsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec = kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>  	if (!bpfsec)
>  		return -ENOMEM;
> @@ -6794,6 +7306,9 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  {
>  	struct bpf_security_struct *bpfsec = aux->security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	aux->security = NULL;
>  	kfree(bpfsec);
>  }
> @@ -6802,11 +7317,14 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
>  static int selinux_lockdown(enum lockdown_reason what)
>  {
>  	struct common_audit_data ad;
> -	u32 sid = current_sid();
> +	u32 sid;
>  	int invalid_reason = (what <= LOCKDOWN_NONE) ||
>  			     (what == LOCKDOWN_INTEGRITY_MAX) ||
>  			     (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (WARN(invalid_reason, "Invalid lockdown reason")) {
>  		audit_log(audit_context(),
>  			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> @@ -6814,6 +7332,8 @@ static int selinux_lockdown(enum lockdown_reason what)
>  		return -EINVAL;
>  	}
>  
> +	sid = current_sid();
> +
>  	ad.type = LSM_AUDIT_DATA_LOCKDOWN;
>  	ad.u.reason = what;
>  
> @@ -6827,7 +7347,7 @@ static int selinux_lockdown(enum lockdown_reason what)
>  				    LOCKDOWN__CONFIDENTIALITY, &ad);
>  }
>  
> -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct task_security_struct),
>  	.lbs_file = sizeof(struct file_security_struct),
>  	.lbs_inode = sizeof(struct inode_security_struct),
> @@ -6838,7 +7358,12 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  #ifdef CONFIG_PERF_EVENTS
>  static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
>  {
> -	u32 requested, sid = current_sid();
> +	u32 requested, sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid = current_sid();
>  
>  	if (type == PERF_SECURITY_OPEN)
>  		requested = PERF_EVENT__OPEN;
> @@ -6859,6 +7384,9 @@ static int selinux_perf_event_alloc(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
>  	if (!perfsec)
>  		return -ENOMEM;
> @@ -6873,6 +7401,9 @@ static void selinux_perf_event_free(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec = event->security;
>  
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	event->security = NULL;
>  	kfree(perfsec);
>  }
> @@ -6880,23 +7411,27 @@ static void selinux_perf_event_free(struct perf_event *event)
>  static int selinux_perf_event_read(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec = event->security;
> -	u32 sid = current_sid();
>  
> -	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
>  			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
>  }
>  
>  static int selinux_perf_event_write(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec = event->security;
> -	u32 sid = current_sid();
>  
> -	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
>  			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
>  }
>  #endif
>  
> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> @@ -7315,18 +7850,19 @@ int selinux_disable(struct selinux_state *state)
>  		return -EINVAL;
>  	}
>  
> +	/*
> +	 * Unregister netfilter hooks (must be done before
> +	 * selinux_mark_disabled()).
> +	 */
> +	selinux_nf_ip_exit();
> +
>  	selinux_mark_disabled(state);
>  
>  	pr_info("SELinux:  Disabled at runtime.\n");
>  
> -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> -
>  	/* Try to destroy the avc node cache */
>  	avc_disable();
>  
> -	/* Unregister netfilter hooks. */
> -	selinux_nf_ip_exit();
> -
>  	/* Unregister selinuxfs. */
>  	exit_sel_fs();
>  
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ecea41ce919b..de50c69846e0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>  	return 0;
>  }
>  
> -struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
>  	.lbs_cred = sizeof(struct task_smack),
>  	.lbs_file = sizeof(struct smack_known *),
>  	.lbs_inode = sizeof(struct inode_smack),
> @@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_msg_msg = sizeof(struct smack_known *),
>  };
>  
> -static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..9dcdef99d431 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>  	return tomoyo_socket_sendmsg_permission(sock, msg, size);
>  }
>  
> -struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init = {
> +struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init = {
>  	.lbs_task = sizeof(struct tomoyo_task),
>  };
>  
> @@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *task)
>   * tomoyo_security_ops is a "struct security_operations" which is used for
>   * registering TOMOYO.
>   */
> -static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
>  	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
>  	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> @@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
>  
> -int tomoyo_enabled __lsm_ro_after_init = 1;
> +int tomoyo_enabled __ro_after_init = 1;
>  
>  /**
>   * tomoyo_init - Register TOMOYO Linux as a LSM module.
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 94dc346370b1..c47d4e09bfb4 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *parent)
>  	return rc;
>  }
>  
> -static struct security_hook_list yama_hooks[] __lsm_ro_after_init = {
> +static struct security_hook_list yama_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>  	LSM_HOOK_INIT(task_prctl, yama_task_prctl),
> -- 
> 2.24.1
> 

-- 
Kees Cook
