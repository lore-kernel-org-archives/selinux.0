Date: Wed, 13 Jun 2018 10:19:21 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Joe Perches <joe@perches.com>
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@tycho.nsa.gov
Message-ID: <20180613151921.GA27375@mail.hallyn.com>
References: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e91f8e10ce76d3208239b6b5899aab76d1543ff.1528743633.git.joe@perches.com>
Subject: Re: [-next PATCH] security: use octal not symbolic
 permissions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Joe Perches (joe@perches.com):
> Currently security files use a mixture of octal and symbolic styles
> for permissions.
> 
> Using octal and not symbolic permissions is preferred by many as more
> readable.
> 
> see: https://lkml.org/lkml/2016/8/2/1945

Heh, well see also https://lkml.org/lkml/2016/8/2/2062 .  Your patch
definately improves readability, but will doubtless make backpointing
future important patches more painful.

> Prefer the direct use of octal for permissions.
> 
> Done using:
> 
> $ git ls-files security | \
>   xargs ./scripts/checkpatch.pl -f --fix-inplace --types=symbolic_perms --strict
> 
> and some typing.
> 
> Before:	 $ git grep -P -w "0[0-7]{3,3}" security | wc -l
> 53
> After:	 $ git grep -P -w "0[0-7]{3,3}" security | wc -l
> 136
> 
> Miscellanea:
> 
> o Whitespace neatening and line wrapping around these conversions.
> o Remove now superfluous parentheses around direct use of 0600
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/apparmor/apparmorfs.c  |  5 ++--
>  security/apparmor/lsm.c         | 23 ++++++++---------
>  security/integrity/ima/ima.h    |  4 +--
>  security/integrity/ima/ima_fs.c | 13 +++++-----
>  security/selinux/hooks.c        |  4 +--
>  security/selinux/selinuxfs.c    | 57 ++++++++++++++++++++---------------------
>  security/smack/smack_lsm.c      |  6 ++---
>  security/smack/smackfs.c        | 46 ++++++++++++++++-----------------
>  security/tomoyo/condition.c     | 18 ++++++-------
>  9 files changed, 85 insertions(+), 91 deletions(-)
> 
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 949dd8a48164..c09dc0f3c3fe 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -2426,10 +2426,9 @@ static int aa_mk_null_file(struct dentry *parent)
>  	}
>  
>  	inode->i_ino = get_next_ino();
> -	inode->i_mode = S_IFCHR | S_IRUGO | S_IWUGO;
> +	inode->i_mode = S_IFCHR | 0666;
>  	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> -	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO,
> -			   MKDEV(MEM_MAJOR, 3));
> +	init_special_inode(inode, S_IFCHR | 0666, MKDEV(MEM_MAJOR, 3));
>  	d_instantiate(dentry, inode);
>  	aa_null.dentry = dget(dentry);
>  	aa_null.mnt = mntget(mount);
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index fbb08bc78bee..6759a70918de 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1255,45 +1255,42 @@ static int param_get_mode(char *buffer, const struct kernel_param *kp);
>  /* AppArmor global enforcement switch - complain, enforce, kill */
>  enum profile_mode aa_g_profile_mode = APPARMOR_ENFORCE;
>  module_param_call(mode, param_set_mode, param_get_mode,
> -		  &aa_g_profile_mode, S_IRUSR | S_IWUSR);
> +		  &aa_g_profile_mode, 0600);
>  
>  /* whether policy verification hashing is enabled */
>  bool aa_g_hash_policy = IS_ENABLED(CONFIG_SECURITY_APPARMOR_HASH_DEFAULT);
>  #ifdef CONFIG_SECURITY_APPARMOR_HASH
> -module_param_named(hash_policy, aa_g_hash_policy, aabool, S_IRUSR | S_IWUSR);
> +module_param_named(hash_policy, aa_g_hash_policy, aabool, 0600);
>  #endif
>  
>  /* Debug mode */
>  bool aa_g_debug = IS_ENABLED(CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES);
> -module_param_named(debug, aa_g_debug, aabool, S_IRUSR | S_IWUSR);
> +module_param_named(debug, aa_g_debug, aabool, 0600);
>  
>  /* Audit mode */
>  enum audit_mode aa_g_audit;
> -module_param_call(audit, param_set_audit, param_get_audit,
> -		  &aa_g_audit, S_IRUSR | S_IWUSR);
> +module_param_call(audit, param_set_audit, param_get_audit, &aa_g_audit, 0600);
>  
>  /* Determines if audit header is included in audited messages.  This
>   * provides more context if the audit daemon is not running
>   */
>  bool aa_g_audit_header = true;
> -module_param_named(audit_header, aa_g_audit_header, aabool,
> -		   S_IRUSR | S_IWUSR);
> +module_param_named(audit_header, aa_g_audit_header, aabool, 0600);
>  
>  /* lock out loading/removal of policy
>   * TODO: add in at boot loading of policy, which is the only way to
>   *       load policy, if lock_policy is set
>   */
>  bool aa_g_lock_policy;
> -module_param_named(lock_policy, aa_g_lock_policy, aalockpolicy,
> -		   S_IRUSR | S_IWUSR);
> +module_param_named(lock_policy, aa_g_lock_policy, aalockpolicy, 0600);
>  
>  /* Syscall logging mode */
>  bool aa_g_logsyscall;
> -module_param_named(logsyscall, aa_g_logsyscall, aabool, S_IRUSR | S_IWUSR);
> +module_param_named(logsyscall, aa_g_logsyscall, aabool, 0600);
>  
>  /* Maximum pathname length before accesses will start getting rejected */
>  unsigned int aa_g_path_max = 2 * PATH_MAX;
> -module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
> +module_param_named(path_max, aa_g_path_max, aauint, 0400);
>  
>  /* Determines how paranoid loading of policy is and how much verification
>   * on the loaded policy is done.
> @@ -1301,11 +1298,11 @@ module_param_named(path_max, aa_g_path_max, aauint, S_IRUSR);
>   * that none root users (user namespaces) can load policy.
>   */
>  bool aa_g_paranoid_load = true;
> -module_param_named(paranoid_load, aa_g_paranoid_load, aabool, S_IRUGO);
> +module_param_named(paranoid_load, aa_g_paranoid_load, aabool, 0444);
>  
>  /* Boot time disable flag */
>  static bool apparmor_enabled = CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE;
> -module_param_named(enabled, apparmor_enabled, bool, S_IRUGO);
> +module_param_named(enabled, apparmor_enabled, bool, 0444);
>  
>  static int __init apparmor_enabled_setup(char *str)
>  {
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 354bb5716ce3..3f7707b8aaa7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -314,9 +314,9 @@ static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
>  #endif /* CONFIG_IMA_LSM_RULES */
>  
>  #ifdef	CONFIG_IMA_READ_POLICY
> -#define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
> +#define	POLICY_FILE_FLAGS	0600
>  #else
> -#define	POLICY_FILE_FLAGS	S_IWUSR
> +#define	POLICY_FILE_FLAGS	0200
>  #endif /* CONFIG_IMA_READ_POLICY */
>  
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index ae9d5c766a3c..81700df83f51 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -439,7 +439,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
>  	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
>  #elif defined(CONFIG_IMA_READ_POLICY)
> -	inode->i_mode &= ~S_IWUSR;
> +	inode->i_mode &= ~0200;
>  #endif
>  	return 0;
>  }
> @@ -465,28 +465,29 @@ int __init ima_fs_init(void)
>  
>  	binary_runtime_measurements =
>  	    securityfs_create_file("binary_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> +				   0440, ima_dir, NULL,
>  				   &ima_measurements_ops);
>  	if (IS_ERR(binary_runtime_measurements))
>  		goto out;
>  
>  	ascii_runtime_measurements =
>  	    securityfs_create_file("ascii_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> +				   0440, ima_dir, NULL,
>  				   &ima_ascii_measurements_ops);
>  	if (IS_ERR(ascii_runtime_measurements))
>  		goto out;
>  
>  	runtime_measurements_count =
>  	    securityfs_create_file("runtime_measurements_count",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> +				   0440, ima_dir, NULL,
>  				   &ima_measurements_count_ops);
>  	if (IS_ERR(runtime_measurements_count))
>  		goto out;
>  
>  	violations =
> -	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
> -				   ima_dir, NULL, &ima_htable_violations_ops);
> +		securityfs_create_file("violations",
> +				       0440, ima_dir, NULL,
> +				       &ima_htable_violations_ops);
>  	if (IS_ERR(violations))
>  		goto out;
>  
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a85fac3345df..8ae043be8782 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6336,9 +6336,9 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
>  	u32 av = 0;
>  
>  	av = 0;
> -	if (flag & S_IRUGO)
> +	if (flag & 0444)
>  		av |= IPC__UNIX_READ;
> -	if (flag & S_IWUGO)
> +	if (flag & 0222)
>  		av |= IPC__UNIX_WRITE;
>  
>  	if (av == 0)
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f3d374d2ca04..bfecac19ba92 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1376,7 +1376,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
>  			goto out;
>  
>  		ret = -ENOMEM;
> -		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
> +		inode = sel_make_inode(dir->d_sb, S_IFREG | 0644);
>  		if (!inode)
>  			goto out;
>  
> @@ -1582,10 +1582,10 @@ static int sel_make_avc_files(struct dentry *dir)
>  	int i;
>  	static const struct tree_descr files[] = {
>  		{ "cache_threshold",
> -		  &sel_avc_cache_threshold_ops, S_IRUGO|S_IWUSR },
> -		{ "hash_stats", &sel_avc_hash_stats_ops, S_IRUGO },
> +		  &sel_avc_cache_threshold_ops, 0644 },
> +		{ "hash_stats", &sel_avc_hash_stats_ops, 0444 },
>  #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
> -		{ "cache_stats", &sel_avc_cache_stats_ops, S_IRUGO },
> +		{ "cache_stats", &sel_avc_cache_stats_ops, 0444 },
>  #endif
>  	};
>  
> @@ -1643,7 +1643,7 @@ static int sel_make_initcon_files(struct dentry *dir)
>  		if (!dentry)
>  			return -ENOMEM;
>  
> -		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> +		inode = sel_make_inode(dir->d_sb, S_IFREG | 0444);
>  		if (!inode)
>  			return -ENOMEM;
>  
> @@ -1744,7 +1744,7 @@ static int sel_make_perm_files(char *objclass, int classvalue,
>  			goto out;
>  
>  		rc = -ENOMEM;
> -		inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> +		inode = sel_make_inode(dir->d_sb, S_IFREG | 0444);
>  		if (!inode)
>  			goto out;
>  
> @@ -1774,7 +1774,7 @@ static int sel_make_class_dir_entries(char *classname, int index,
>  	if (!dentry)
>  		return -ENOMEM;
>  
> -	inode = sel_make_inode(dir->d_sb, S_IFREG|S_IRUGO);
> +	inode = sel_make_inode(dir->d_sb, S_IFREG | 0444);
>  	if (!inode)
>  		return -ENOMEM;
>  
> @@ -1870,7 +1870,7 @@ static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
>  	if (!dentry)
>  		return ERR_PTR(-ENOMEM);
>  
> -	inode = sel_make_inode(dir->d_sb, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = sel_make_inode(dir->d_sb, S_IFDIR | 0555);
>  	if (!inode) {
>  		dput(dentry);
>  		return ERR_PTR(-ENOMEM);
> @@ -1899,25 +1899,24 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>  	struct inode_security_struct *isec;
>  
>  	static const struct tree_descr selinux_files[] = {
> -		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
> -		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUGO|S_IWUSR},
> -		[SEL_CONTEXT] = {"context", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_ACCESS] = {"access", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_CREATE] = {"create", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
> -		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
> -		[SEL_MLS] = {"mls", &sel_mls_ops, S_IRUGO},
> -		[SEL_DISABLE] = {"disable", &sel_disable_ops, S_IWUSR},
> -		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
> -		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
> -		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, S_IRUGO},
> -		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, S_IRUGO},
> -		[SEL_STATUS] = {"status", &sel_handle_status_ops, S_IRUGO},
> -		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
> -		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
> -					S_IWUGO},
> +		[SEL_LOAD] = {"load", &sel_load_ops, 0600},
> +		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, 0644},
> +		[SEL_CONTEXT] = {"context", &transaction_ops, 0666},
> +		[SEL_ACCESS] = {"access", &transaction_ops, 0666},
> +		[SEL_CREATE] = {"create", &transaction_ops, 0666},
> +		[SEL_RELABEL] = {"relabel", &transaction_ops, 0666},
> +		[SEL_USER] = {"user", &transaction_ops, 0666},
> +		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, 0444},
> +		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, 0200},
> +		[SEL_MLS] = {"mls", &sel_mls_ops, 0444},
> +		[SEL_DISABLE] = {"disable", &sel_disable_ops, 0200},
> +		[SEL_MEMBER] = {"member", &transaction_ops, 0666},
> +		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, 0644},
> +		[SEL_REJECT_UNKNOWN] = {"reject_unknown", &sel_handle_unknown_ops, 0444},
> +		[SEL_DENY_UNKNOWN] = {"deny_unknown", &sel_handle_unknown_ops, 0444},
> +		[SEL_STATUS] = {"status", &sel_handle_status_ops, 0444},
> +		[SEL_POLICY] = {"policy", &sel_policy_ops, 0444},
> +		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops, 0222},
>  		/* last one */ {""}
>  	};
>  
> @@ -1943,7 +1942,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>  		goto err;
>  
>  	ret = -ENOMEM;
> -	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
> +	inode = sel_make_inode(sb, S_IFCHR | 0666);
>  	if (!inode)
>  		goto err;
>  
> @@ -1953,7 +1952,7 @@ static int sel_fill_super(struct super_block *sb, void *data, int silent)
>  	isec->sclass = SECCLASS_CHR_FILE;
>  	isec->initialized = LABEL_INITIALIZED;
>  
> -	init_special_inode(inode, S_IFCHR | S_IRUGO | S_IWUGO, MKDEV(MEM_MAJOR, 3));
> +	init_special_inode(inode, S_IFCHR | 0666, MKDEV(MEM_MAJOR, 3));
>  	d_add(dentry, inode);
>  
>  	dentry = sel_make_dir(sb->s_root, "avc", &fsi->last_ino);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index dcb976f98df2..8953440c6559 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2945,11 +2945,11 @@ static int smack_flags_to_may(int flags)
>  {
>  	int may = 0;
>  
> -	if (flags & S_IRUGO)
> +	if (flags & 0444)
>  		may |= MAY_READ;
> -	if (flags & S_IWUGO)
> +	if (flags & 0222)
>  		may |= MAY_WRITE;
> -	if (flags & S_IXUGO)
> +	if (flags & 0111)
>  		may |= MAY_EXEC;
>  
>  	return may;
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index f6482e53d55a..270cd3a308f0 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -2857,55 +2857,53 @@ static int smk_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	static const struct tree_descr smack_files[] = {
>  		[SMK_LOAD] = {
> -			"load", &smk_load_ops, S_IRUGO|S_IWUSR},
> +			"load", &smk_load_ops, 0644},
>  		[SMK_CIPSO] = {
> -			"cipso", &smk_cipso_ops, S_IRUGO|S_IWUSR},
> +			"cipso", &smk_cipso_ops, 0644},
>  		[SMK_DOI] = {
> -			"doi", &smk_doi_ops, S_IRUGO|S_IWUSR},
> +			"doi", &smk_doi_ops, 0644},
>  		[SMK_DIRECT] = {
> -			"direct", &smk_direct_ops, S_IRUGO|S_IWUSR},
> +			"direct", &smk_direct_ops, 0644},
>  		[SMK_AMBIENT] = {
> -			"ambient", &smk_ambient_ops, S_IRUGO|S_IWUSR},
> +			"ambient", &smk_ambient_ops, 0644},
>  		[SMK_NET4ADDR] = {
> -			"netlabel", &smk_net4addr_ops, S_IRUGO|S_IWUSR},
> +			"netlabel", &smk_net4addr_ops, 0644},
>  		[SMK_ONLYCAP] = {
> -			"onlycap", &smk_onlycap_ops, S_IRUGO|S_IWUSR},
> +			"onlycap", &smk_onlycap_ops, 0644},
>  		[SMK_LOGGING] = {
> -			"logging", &smk_logging_ops, S_IRUGO|S_IWUSR},
> +			"logging", &smk_logging_ops, 0644},
>  		[SMK_LOAD_SELF] = {
> -			"load-self", &smk_load_self_ops, S_IRUGO|S_IWUGO},
> +			"load-self", &smk_load_self_ops, 0666},
>  		[SMK_ACCESSES] = {
> -			"access", &smk_access_ops, S_IRUGO|S_IWUGO},
> +			"access", &smk_access_ops, 0666},
>  		[SMK_MAPPED] = {
> -			"mapped", &smk_mapped_ops, S_IRUGO|S_IWUSR},
> +			"mapped", &smk_mapped_ops, 0644},
>  		[SMK_LOAD2] = {
> -			"load2", &smk_load2_ops, S_IRUGO|S_IWUSR},
> +			"load2", &smk_load2_ops, 0644},
>  		[SMK_LOAD_SELF2] = {
> -			"load-self2", &smk_load_self2_ops, S_IRUGO|S_IWUGO},
> +			"load-self2", &smk_load_self2_ops, 0666},
>  		[SMK_ACCESS2] = {
> -			"access2", &smk_access2_ops, S_IRUGO|S_IWUGO},
> +			"access2", &smk_access2_ops, 0666},
>  		[SMK_CIPSO2] = {
> -			"cipso2", &smk_cipso2_ops, S_IRUGO|S_IWUSR},
> +			"cipso2", &smk_cipso2_ops, 0644},
>  		[SMK_REVOKE_SUBJ] = {
> -			"revoke-subject", &smk_revoke_subj_ops,
> -			S_IRUGO|S_IWUSR},
> +			"revoke-subject", &smk_revoke_subj_ops, 0644},
>  		[SMK_CHANGE_RULE] = {
> -			"change-rule", &smk_change_rule_ops, S_IRUGO|S_IWUSR},
> +			"change-rule", &smk_change_rule_ops, 0644},
>  		[SMK_SYSLOG] = {
> -			"syslog", &smk_syslog_ops, S_IRUGO|S_IWUSR},
> +			"syslog", &smk_syslog_ops, 0644},
>  		[SMK_PTRACE] = {
> -			"ptrace", &smk_ptrace_ops, S_IRUGO|S_IWUSR},
> +			"ptrace", &smk_ptrace_ops, 0644},
>  #ifdef CONFIG_SECURITY_SMACK_BRINGUP
>  		[SMK_UNCONFINED] = {
> -			"unconfined", &smk_unconfined_ops, S_IRUGO|S_IWUSR},
> +			"unconfined", &smk_unconfined_ops, 0644},
>  #endif
>  #if IS_ENABLED(CONFIG_IPV6)
>  		[SMK_NET6ADDR] = {
> -			"ipv6host", &smk_net6addr_ops, S_IRUGO|S_IWUSR},
> +			"ipv6host", &smk_net6addr_ops, 0644},
>  #endif /* CONFIG_IPV6 */
>  		[SMK_RELABEL_SELF] = {
> -			"relabel-self", &smk_relabel_self_ops,
> -				S_IRUGO|S_IWUGO},
> +			"relabel-self", &smk_relabel_self_ops, 0666},
>  		/* last one */
>  			{""}
>  	};
> diff --git a/security/tomoyo/condition.c b/security/tomoyo/condition.c
> index 8d0e1b9c9c57..2069f5912469 100644
> --- a/security/tomoyo/condition.c
> +++ b/security/tomoyo/condition.c
> @@ -874,31 +874,31 @@ bool tomoyo_condition(struct tomoyo_request_info *r,
>  				value = S_ISVTX;
>  				break;
>  			case TOMOYO_MODE_OWNER_READ:
> -				value = S_IRUSR;
> +				value = 0400;
>  				break;
>  			case TOMOYO_MODE_OWNER_WRITE:
> -				value = S_IWUSR;
> +				value = 0200;
>  				break;
>  			case TOMOYO_MODE_OWNER_EXECUTE:
> -				value = S_IXUSR;
> +				value = 0100;
>  				break;
>  			case TOMOYO_MODE_GROUP_READ:
> -				value = S_IRGRP;
> +				value = 0040;
>  				break;
>  			case TOMOYO_MODE_GROUP_WRITE:
> -				value = S_IWGRP;
> +				value = 0020;
>  				break;
>  			case TOMOYO_MODE_GROUP_EXECUTE:
> -				value = S_IXGRP;
> +				value = 0010;
>  				break;
>  			case TOMOYO_MODE_OTHERS_READ:
> -				value = S_IROTH;
> +				value = 0004;
>  				break;
>  			case TOMOYO_MODE_OTHERS_WRITE:
> -				value = S_IWOTH;
> +				value = 0002;
>  				break;
>  			case TOMOYO_MODE_OTHERS_EXECUTE:
> -				value = S_IXOTH;
> +				value = 0001;
>  				break;
>  			case TOMOYO_EXEC_ARGC:
>  				if (!bprm)
> -- 
> 2.15.0
