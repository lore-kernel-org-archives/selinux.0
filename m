Return-Path: <SRS0=g6d+=UX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6064DC43613
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2F920645
	for <selinux@archiver.kernel.org>; Mon, 24 Jun 2019 18:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfFXSb6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:31:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfFXSb6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Jun 2019 14:31:58 -0400
Received: from static-50-53-46-226.bvtn.or.frontiernet.net ([50.53.46.226] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hfTkm-00084v-Iw; Mon, 24 Jun 2019 18:31:44 +0000
From:   John Johansen <john.johansen@canonical.com>
Subject: [PATCH v3 01/24] LSM: Infrastructure management of the superblock
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
References: <20190621185233.6766-1-casey@schaufler-ca.com>
 <20190621185233.6766-2-casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <4e963683-2caa-2074-4887-931d20f61b87@canonical.com>
Date:   Mon, 24 Jun 2019 11:31:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621185233.6766-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/21/19 11:52 AM, Casey Schaufler wrote:
> Move management of the superblock->sb_security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

with small fix below

Reviewed-by:John Johansen <john.johansen@canonical.com>

> ---
>  include/linux/lsm_hooks.h         |  1 +
>  security/security.c               | 46 ++++++++++++++++++++----
>  security/selinux/hooks.c          | 58 ++++++++++++-------------------
>  security/selinux/include/objsec.h |  6 ++++
>  security/selinux/ss/services.c    |  3 +-
>  security/smack/smack.h            |  6 ++++
>  security/smack/smack_lsm.c        | 35 +++++--------------
>  7 files changed, 85 insertions(+), 70 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a240a3fc5fc4..f9222a04968d 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2047,6 +2047,7 @@ struct lsm_blob_sizes {
>  	int	lbs_cred;
>  	int	lbs_file;
>  	int	lbs_inode;
> +	int	lbs_superblock;
>  	int	lbs_ipc;
>  	int	lbs_msg_msg;
>  	int	lbs_task;
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..550988a0f024 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -172,6 +172,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>  	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
>  	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
>  	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>  	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>  }
>  
> @@ -300,12 +301,13 @@ static void __init ordered_lsm_init(void)
>  	for (lsm = ordered_lsms; *lsm; lsm++)
>  		prepare_lsm(*lsm);
>  
> -	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
> -	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
> -	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
> -	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
> -	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
> -	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
> +	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
> +	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
> +	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
> +	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
> +	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
> +	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
> +	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>  
>  	/*
>  	 * Create any kmem_caches needed for blobs
> @@ -603,6 +605,27 @@ static void __init lsm_early_task(struct task_struct *task)
>  		panic("%s: Early task alloc failed.\n", __func__);
>  }
>  
> +/**
> + * lsm_superblock_alloc - allocate a composite superblock blob
> + * @sb: the superblock that needs a blob
> + *
> + * Allocate the superblock blob for all the modules
> + *
> + * Returns 0, or -ENOMEM if memory can't be allocated.
> + */
> +int lsm_superblock_alloc(struct super_block *sb)


should be static


> +{
> +	if (blob_sizes.lbs_superblock == 0) {
> +		sb->s_security = NULL;
> +		return 0;
> +	}
> +
> +	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
> +	if (sb->s_security == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>  /*
>   * Hook list operation macros.
>   *
> @@ -776,12 +799,21 @@ int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *
>  
>  int security_sb_alloc(struct super_block *sb)
>  {
> -	return call_int_hook(sb_alloc_security, 0, sb);
> +	int rc = lsm_superblock_alloc(sb);
> +
> +	if (unlikely(rc))
> +		return rc;
> +	rc = call_int_hook(sb_alloc_security, 0, sb);
> +	if (unlikely(rc))
> +		security_sb_free(sb);
> +	return rc;
>  }
>  
>  void security_sb_free(struct super_block *sb)
>  {
>  	call_void_hook(sb_free_security, sb);
> +	kfree(sb->s_security);
> +	sb->s_security = NULL;
>  }
>  
>  void security_free_mnt_opts(void **mnt_opts)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1d0b37af2444..7478d8eda00a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -335,7 +335,7 @@ static void inode_free_security(struct inode *inode)
>  
>  	if (!isec)
>  		return;
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	/*
>  	 * As not all inode security structures are in a list, we check for
>  	 * empty list outside of the lock to make sure that we won't waste
> @@ -366,11 +366,7 @@ static int file_alloc_security(struct file *file)
>  
>  static int superblock_alloc_security(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec;
> -
> -	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> -	if (!sbsec)
> -		return -ENOMEM;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  
>  	mutex_init(&sbsec->lock);
>  	INIT_LIST_HEAD(&sbsec->isec_head);
> @@ -379,18 +375,10 @@ static int superblock_alloc_security(struct super_block *sb)
>  	sbsec->sid = SECINITSID_UNLABELED;
>  	sbsec->def_sid = SECINITSID_FILE;
>  	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> -	sb->s_security = sbsec;
>  
>  	return 0;
>  }
>  
> -static void superblock_free_security(struct super_block *sb)
> -{
> -	struct superblock_security_struct *sbsec = sb->s_security;
> -	sb->s_security = NULL;
> -	kfree(sbsec);
> -}
> -
>  struct selinux_mnt_opts {
>  	const char *fscontext, *context, *rootcontext, *defcontext;
>  };
> @@ -507,7 +495,7 @@ static int selinux_is_genfs_special_handling(struct super_block *sb)
>  
>  static int selinux_is_sblabel_mnt(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  
>  	/*
>  	 * IMPORTANT: Double-check logic in this function when adding a new
> @@ -535,7 +523,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
>  
>  static int sb_finish_set_opts(struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	struct dentry *root = sb->s_root;
>  	struct inode *root_inode = d_backing_inode(root);
>  	int rc = 0;
> @@ -648,7 +636,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  				unsigned long *set_kern_flags)
>  {
>  	const struct cred *cred = current_cred();
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	struct dentry *root = sbsec->sb->s_root;
>  	struct selinux_mnt_opts *opts = mnt_opts;
>  	struct inode_security_struct *root_isec;
> @@ -881,8 +869,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  static int selinux_cmp_sb_context(const struct super_block *oldsb,
>  				    const struct super_block *newsb)
>  {
> -	struct superblock_security_struct *old = oldsb->s_security;
> -	struct superblock_security_struct *new = newsb->s_security;
> +	struct superblock_security_struct *old = selinux_superblock(oldsb);
> +	struct superblock_security_struct *new = selinux_superblock(newsb);
>  	char oldflags = old->flags & SE_MNTMASK;
>  	char newflags = new->flags & SE_MNTMASK;
>  
> @@ -914,8 +902,9 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
>  					unsigned long *set_kern_flags)
>  {
>  	int rc = 0;
> -	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
> -	struct superblock_security_struct *newsbsec = newsb->s_security;
> +	const struct superblock_security_struct *oldsbsec =
> +						selinux_superblock(oldsb);
> +	struct superblock_security_struct *newsbsec = selinux_superblock(newsb);
>  
>  	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
>  	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
> @@ -1085,7 +1074,7 @@ static int show_sid(struct seq_file *m, u32 sid)
>  
>  static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
>  {
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	int rc;
>  
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
> @@ -1377,7 +1366,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
>  	if (isec->sclass == SECCLASS_FILE)
>  		isec->sclass = inode_mode_to_security_class(inode->i_mode);
>  
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SE_SBINITIALIZED)) {
>  		/* Defer initialization until selinux_complete_init,
>  		   after the initial policy is loaded and the security
> @@ -1767,7 +1756,8 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
>  				 const struct qstr *name, u16 tclass,
>  				 u32 *_new_isid)
>  {
> -	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
> +	const struct superblock_security_struct *sbsec =
> +						selinux_superblock(dir->i_sb);
>  
>  	if ((sbsec->flags & SE_SBINITIALIZED) &&
>  	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
> @@ -1798,7 +1788,7 @@ static int may_create(struct inode *dir,
>  	int rc;
>  
>  	dsec = inode_security(dir);
> -	sbsec = dir->i_sb->s_security;
> +	sbsec = selinux_superblock(dir->i_sb);
>  
>  	sid = tsec->sid;
>  
> @@ -1947,7 +1937,7 @@ static int superblock_has_perm(const struct cred *cred,
>  	struct superblock_security_struct *sbsec;
>  	u32 sid = cred_sid(cred);
>  
> -	sbsec = sb->s_security;
> +	sbsec = selinux_superblock(sb);
>  	return avc_has_perm(&selinux_state,
>  			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
>  }
> @@ -2578,11 +2568,6 @@ static int selinux_sb_alloc_security(struct super_block *sb)
>  	return superblock_alloc_security(sb);
>  }
>  
> -static void selinux_sb_free_security(struct super_block *sb)
> -{
> -	superblock_free_security(sb);
> -}
> -
>  static inline int opt_len(const char *s)
>  {
>  	bool open_quote = false;
> @@ -2653,7 +2638,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
>  {
>  	struct selinux_mnt_opts *opts = mnt_opts;
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	u32 sid;
>  	int rc;
>  
> @@ -2877,7 +2862,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>  	int rc;
>  	char *context;
>  
> -	sbsec = dir->i_sb->s_security;
> +	sbsec = selinux_superblock(dir->i_sb);
>  
>  	newsid = tsec->create_sid;
>  
> @@ -3115,7 +3100,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>  		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
>  	}
>  
> -	sbsec = inode->i_sb->s_security;
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> @@ -3296,13 +3281,14 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
>  				     const void *value, size_t size, int flags)
>  {
>  	struct inode_security_struct *isec = inode_security_novalidate(inode);
> -	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
> +	struct superblock_security_struct *sbsec;
>  	u32 newsid;
>  	int rc;
>  
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
>  
> +	sbsec = selinux_superblock(inode->i_sb);
>  	if (!(sbsec->flags & SBLABEL_MNT))
>  		return -EOPNOTSUPP;
>  
> @@ -6647,6 +6633,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
>  	.lbs_inode = sizeof(struct inode_security_struct),
>  	.lbs_ipc = sizeof(struct ipc_security_struct),
>  	.lbs_msg_msg = sizeof(struct msg_security_struct),
> +	.lbs_superblock = sizeof(struct superblock_security_struct),
>  };
>  
>  static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> @@ -6675,7 +6662,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>  
>  	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
> -	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
>  	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 231262d8eac9..d08d7e5d2f93 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -188,4 +188,10 @@ static inline struct ipc_security_struct *selinux_ipc(
>  	return ipc->security + selinux_blob_sizes.lbs_ipc;
>  }
>  
> +static inline struct superblock_security_struct *selinux_superblock(
> +					const struct super_block *superblock)
> +{
> +	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
> +}
> +
>  #endif /* _SELINUX_OBJSEC_H_ */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ec62918521b1..e3f5d6aece66 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -50,6 +50,7 @@
>  #include <linux/audit.h>
>  #include <linux/mutex.h>
>  #include <linux/vmalloc.h>
> +#include <linux/lsm_hooks.h>
>  #include <net/netlabel.h>
>  
>  #include "flask.h"
> @@ -2751,7 +2752,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
>  	struct sidtab *sidtab;
>  	int rc = 0;
>  	struct ocontext *c;
> -	struct superblock_security_struct *sbsec = sb->s_security;
> +	struct superblock_security_struct *sbsec = selinux_superblock(sb);
>  	const char *fstype = sb->s_type->name;
>  
>  	read_lock(&state->ss->policy_rwlock);
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index cf52af77d15e..caecbcba9942 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -375,6 +375,12 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
>  	return ipc->security + smack_blob_sizes.lbs_ipc;
>  }
>  
> +static inline struct superblock_smack *smack_superblock(
> +					const struct super_block *superblock)
> +{
> +	return superblock->s_security + smack_blob_sizes.lbs_superblock;
> +}
> +
>  /*
>   * Is the directory transmuting?
>   */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5c1613519d5a..807eff2ccce9 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -540,12 +540,7 @@ static int smack_syslog(int typefrom_file)
>   */
>  static int smack_sb_alloc_security(struct super_block *sb)
>  {
> -	struct superblock_smack *sbsp;
> -
> -	sbsp = kzalloc(sizeof(struct superblock_smack), GFP_KERNEL);
> -
> -	if (sbsp == NULL)
> -		return -ENOMEM;
> +	struct superblock_smack *sbsp = smack_superblock(sb);
>  
>  	sbsp->smk_root = &smack_known_floor;
>  	sbsp->smk_default = &smack_known_floor;
> @@ -554,22 +549,10 @@ static int smack_sb_alloc_security(struct super_block *sb)
>  	/*
>  	 * SMK_SB_INITIALIZED will be zero from kzalloc.
>  	 */
> -	sb->s_security = sbsp;
>  
>  	return 0;
>  }
>  
> -/**
> - * smack_sb_free_security - free a superblock blob
> - * @sb: the superblock getting the blob
> - *
> - */
> -static void smack_sb_free_security(struct super_block *sb)
> -{
> -	kfree(sb->s_security);
> -	sb->s_security = NULL;
> -}
> -
>  struct smack_mnt_opts {
>  	const char *fsdefault, *fsfloor, *fshat, *fsroot, *fstransmute;
>  };
> @@ -781,7 +764,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
>  {
>  	struct dentry *root = sb->s_root;
>  	struct inode *inode = d_backing_inode(root);
> -	struct superblock_smack *sp = sb->s_security;
> +	struct superblock_smack *sp = smack_superblock(sb);
>  	struct inode_smack *isp;
>  	struct smack_known *skp;
>  	struct smack_mnt_opts *opts = mnt_opts;
> @@ -880,7 +863,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
>   */
>  static int smack_sb_statfs(struct dentry *dentry)
>  {
> -	struct superblock_smack *sbp = dentry->d_sb->s_security;
> +	struct superblock_smack *sbp = smack_superblock(dentry->d_sb);
>  	int rc;
>  	struct smk_audit_info ad;
>  
> @@ -917,7 +900,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
>  	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
>  		return 0;
>  
> -	sbsp = inode->i_sb->s_security;
> +	sbsp = smack_superblock(inode->i_sb);
>  	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&
>  	    isp->smk_task != sbsp->smk_root)
>  		return 0;
> @@ -1168,7 +1151,7 @@ static int smack_inode_rename(struct inode *old_inode,
>   */
>  static int smack_inode_permission(struct inode *inode, int mask)
>  {
> -	struct superblock_smack *sbsp = inode->i_sb->s_security;
> +	struct superblock_smack *sbsp = smack_superblock(inode->i_sb);
>  	struct smk_audit_info ad;
>  	int no_block = mask & MAY_NOT_BLOCK;
>  	int rc;
> @@ -1410,7 +1393,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
>  	 */
>  	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
>  		struct super_block *sbp = dentry->d_sb;
> -		struct superblock_smack *sbsp = sbp->s_security;
> +		struct superblock_smack *sbsp = smack_superblock(sbp);
>  
>  		isp->smk_inode = sbsp->smk_default;
>  	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
> @@ -1680,7 +1663,7 @@ static int smack_mmap_file(struct file *file,
>  	isp = smack_inode(file_inode(file));
>  	if (isp->smk_mmap == NULL)
>  		return 0;
> -	sbsp = file_inode(file)->i_sb->s_security;
> +	sbsp = smack_superblock(file_inode(file)->i_sb);
>  	if (sbsp->smk_flags & SMK_SB_UNTRUSTED &&
>  	    isp->smk_mmap != sbsp->smk_root)
>  		return -EACCES;
> @@ -3288,7 +3271,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  		goto unlockandout;
>  
>  	sbp = inode->i_sb;
> -	sbsp = sbp->s_security;
> +	sbsp = smack_superblock(sbp);
>  	/*
>  	 * We're going to use the superblock default label
>  	 * if there's no label on the file.
> @@ -4575,6 +4558,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>  	.lbs_inode = sizeof(struct inode_smack),
>  	.lbs_ipc = sizeof(struct smack_known *),
>  	.lbs_msg_msg = sizeof(struct smack_known *),
> +	.lbs_superblock = sizeof(struct superblock_smack),
>  };
>  
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> @@ -4586,7 +4570,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(fs_context_parse_param, smack_fs_context_parse_param),
>  
>  	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
> -	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
>  	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
>  	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
> 



