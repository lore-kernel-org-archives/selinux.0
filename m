Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F38AC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3172184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LT/gKsuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfB1WTs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:48 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:39756
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfB1WTr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392385; bh=osd3P5kfm1TLEBkFX4Ie2FyfoA2vXLSCMcBXhwlXlkQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LT/gKsuoOythHMOOvSPOwkmp1XxsZAightPNkTXBl9AsY2ekLn00HDxNQiuur9cLJCxCV3gdAZaur+TwJZurCKlHiCW53XzDQaBYSFV65tjumpkCgiCNZJgIqne3uLY8kuJcKk7p1qGf/usVyrXhe6oqtNV/qNBGozSqkTLwTMN5VOldxviS+yshCu2HuW+/NSLJGGKOI8E54Fm26QH5/OkSoj2PW2KnJyLNstz/FyyUVA+kJCNGXXAFtraDolJJE8NRWkQMEiytg0f71eN+YwWK7r/ZSQvtjQw8OucuFeLpuyu4OyGB7I6hzUmLFRiWfofDGut/62myj/s5ZBkKvA==
X-YMail-OSG: jrJQEMYVM1mIx412ILWe1sAz6QmXW6IuxrKkDsbu68RPGIKt5MHT5ntGuRVNRJM
 P1EqOqhXq_fM.hPm7A.3Xu5..eceT3xBAyJagytOn4mzWXtVdLQt2gJj7dsBYfi2vWddZhDmXMk8
 40KyteA95rG_fRAqXXZqbcw6KsEEYPbjW3vJ_zAWnBx8tvZC7FTs2s96IDRsfNhaI9TbAS3FJYPS
 cjw2nev_WpBNIMVi6FRTeqj4oRJCIqLLRUg89oPBgxJWb1dH6ATU8GjrTT6mFwr6NCQP322lDcBw
 YnJv4iz664O9dueRnur6mxLop5GEZ7huh.1VzJbmxip9jp2AJ7cdOAVQIhusU712yztikOtZw_Wv
 7edXF_iqNJZy6VNgswy0LN3rReRSe.FiFofAftjk43flO0S52IZXzk7jsMZh2sUUPCOrFqXJ9aSc
 ZrCaNW25MirfI_ptvncAAH3qwYzqrcglpGiYg0gPFilip6KApwfUbFFhYENaKVRi22E4W3HM4V6T
 iKupfiXPFRS.pzOSgULIb7DAPf5XBN.CxCqdAmeK4CtnLGLEYf6ZNe_oXPrjRO.6tgb837eM03aS
 sn97pTTWhqOzG_67VCspbjWkCJPaoIADA4DU0mpWN4b5rP.UbmgNcO6aTvckkCTDzChLiUmzEIK3
 yBxEKy0Odt33Q4kFV6hRKLc6gGjaGVK8DqIUwVtisgkwikWr3Ni1z.IP2MV23oDH90K3NQP4mllt
 PC6uq0lfHxwdlKSr305CYECjjpK3zxcZYi4.wf2CXc6WVaZjQgkO95Tvr7.K.Gywb7fuIapGsZ0K
 jc5QIqXEd8s7DA3w3yMTu95CHs_B_xxB_QUS1ePOeqZDgVzpTD6PnGwwPFx6DzY.PUypTlQ.u.nP
 6tYmoSasvM7zZnEXfi6dqSZLA.gj.qgmqQteeQOJ4ql53tk8eMnl4WG4XE83YJF6quPXEvEbWW1K
 gakC9lUtpeile3er1iX0Lr2YJVWeInkAP68bCS0PFcz7C8tg43FD2afVVraY98Kc8OpRkzn1S.bj
 h5ABf7T3Lq2gvGNF4qqUVkCMPwGoy7zz_9.2U0dkaBqTRRTr4Q3vq0y3GvNNIl.SjpI3LOhwvlFb
 dJEayICLIZDbQ79fDAjIx8yfGHB6o0j7FFNi3ag--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 01/97] LSM: Infrastructure management of the superblock
Date:   Thu, 28 Feb 2019 14:17:57 -0800
Message-Id: <20190228221933.2551-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@localhost.localdomain>

Move management of the superblock->sb_security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 46 ++++++++++++++++++++++----
 security/selinux/hooks.c          | 55 +++++++++++--------------------
 security/selinux/include/objsec.h |  6 ++++
 security/selinux/ss/services.c    |  3 +-
 security/smack/smack.h            |  6 ++++
 security/smack/smack_lsm.c        | 35 +++++---------------
 7 files changed, 83 insertions(+), 69 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 22fc786d723a..97510e9b9288 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2036,6 +2036,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_superblock;
 	int	lbs_ipc;
 	int	lbs_msg_msg;
 	int	lbs_task;
diff --git a/security/security.c b/security/security.c
index b6bff646d373..fd8d7ae967c0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -172,6 +172,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
 	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
@@ -296,12 +297,13 @@ static void __init ordered_lsm_init(void)
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		prepare_lsm(*lsm);
 
-	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
-	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
-	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
-	init_debug("ipc blob size      = %d\n", blob_sizes.lbs_ipc);
-	init_debug("msg_msg blob size  = %d\n", blob_sizes.lbs_msg_msg);
-	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
+	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
+	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -599,6 +601,27 @@ static void __init lsm_early_task(struct task_struct *task)
 		panic("%s: Early task alloc failed.\n", __func__);
 }
 
+/**
+ * lsm_superblock_alloc - allocate a composite superblock blob
+ * @sb: the superblock that needs a blob
+ *
+ * Allocate the superblock blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_superblock_alloc(struct super_block *sb)
+{
+	if (blob_sizes.lbs_superblock == 0) {
+		sb->s_security = NULL;
+		return 0;
+	}
+
+	sb->s_security = kzalloc(blob_sizes.lbs_superblock, GFP_KERNEL);
+	if (sb->s_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -762,12 +785,21 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 
 int security_sb_alloc(struct super_block *sb)
 {
-	return call_int_hook(sb_alloc_security, 0, sb);
+	int rc = lsm_superblock_alloc(sb);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(sb_alloc_security, 0, sb);
+	if (unlikely(rc))
+		security_sb_free(sb);
+	return rc;
 }
 
 void security_sb_free(struct super_block *sb)
 {
 	call_void_hook(sb_free_security, sb);
+	kfree(sb->s_security);
+	sb->s_security = NULL;
 }
 
 void security_free_mnt_opts(void **mnt_opts)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5d92167dbe05..f36cf93695ad 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -333,7 +333,7 @@ static void inode_free_security(struct inode *inode)
 
 	if (!isec)
 		return;
-	sbsec = inode->i_sb->s_security;
+	sbsec = selinux_superblock(inode->i_sb);
 	/*
 	 * As not all inode security structures are in a list, we check for
 	 * empty list outside of the lock to make sure that we won't waste
@@ -364,11 +364,7 @@ static int file_alloc_security(struct file *file)
 
 static int superblock_alloc_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec;
-
-	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
-	if (!sbsec)
-		return -ENOMEM;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	mutex_init(&sbsec->lock);
 	INIT_LIST_HEAD(&sbsec->isec_head);
@@ -377,18 +373,10 @@ static int superblock_alloc_security(struct super_block *sb)
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sb->s_security = sbsec;
 
 	return 0;
 }
 
-static void superblock_free_security(struct super_block *sb)
-{
-	struct superblock_security_struct *sbsec = sb->s_security;
-	sb->s_security = NULL;
-	kfree(sbsec);
-}
-
 struct selinux_mnt_opts {
 	const char *fscontext, *context, *rootcontext, *defcontext;
 };
@@ -492,7 +480,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 
 static int selinux_is_sblabel_mnt(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
 		sbsec->behavior == SECURITY_FS_USE_TRANS ||
@@ -511,7 +499,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 
 static int sb_finish_set_opts(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = d_backing_inode(root);
 	int rc = 0;
@@ -624,7 +612,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 				unsigned long *set_kern_flags)
 {
 	const struct cred *cred = current_cred();
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sbsec->sb->s_root;
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct inode_security_struct *root_isec;
@@ -857,8 +845,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 static int selinux_cmp_sb_context(const struct super_block *oldsb,
 				    const struct super_block *newsb)
 {
-	struct superblock_security_struct *old = oldsb->s_security;
-	struct superblock_security_struct *new = newsb->s_security;
+	struct superblock_security_struct *old = selinux_superblock(oldsb);
+	struct superblock_security_struct *new = selinux_superblock(newsb);
 	char oldflags = old->flags & SE_MNTMASK;
 	char newflags = new->flags & SE_MNTMASK;
 
@@ -890,8 +878,9 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 					unsigned long *set_kern_flags)
 {
 	int rc = 0;
-	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
-	struct superblock_security_struct *newsbsec = newsb->s_security;
+	const struct superblock_security_struct *oldsbsec =
+						selinux_superblock(oldsb);
+	struct superblock_security_struct *newsbsec = selinux_superblock(newsb);
 
 	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
@@ -1057,7 +1046,7 @@ static int show_sid(struct seq_file *m, u32 sid)
 
 static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	int rc;
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
@@ -1349,7 +1338,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = selinux_superblock(inode->i_sb);
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -1739,7 +1728,8 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
 {
-	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
+	const struct superblock_security_struct *sbsec =
+						selinux_superblock(dir->i_sb);
 
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
@@ -1770,7 +1760,7 @@ static int may_create(struct inode *dir,
 	int rc;
 
 	dsec = inode_security(dir);
-	sbsec = dir->i_sb->s_security;
+	sbsec = selinux_superblock(dir->i_sb);
 
 	sid = tsec->sid;
 
@@ -1919,7 +1909,7 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 	u32 sid = cred_sid(cred);
 
-	sbsec = sb->s_security;
+	sbsec = selinux_superblock(sb);
 	return avc_has_perm(&selinux_state,
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
@@ -2550,11 +2540,6 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	return superblock_alloc_security(sb);
 }
 
-static void selinux_sb_free_security(struct super_block *sb)
-{
-	superblock_free_security(sb);
-}
-
 static inline int opt_len(const char *s)
 {
 	bool open_quote = false;
@@ -2625,7 +2610,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
 	struct selinux_mnt_opts *opts = mnt_opts;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	u32 sid;
 	int rc;
 
@@ -2779,7 +2764,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	int rc;
 	char *context;
 
-	sbsec = dir->i_sb->s_security;
+	sbsec = selinux_superblock(dir->i_sb);
 
 	newsid = tsec->create_sid;
 
@@ -3016,7 +3001,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 		return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
 	}
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = selinux_superblock(inode->i_sb);
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
@@ -6538,6 +6523,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
+	.lbs_superblock = sizeof(struct superblock_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6563,7 +6549,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
-	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_free_mnt_opts, selinux_free_mnt_opts),
 	LSM_HOOK_INIT(sb_remount, selinux_sb_remount),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 231262d8eac9..d08d7e5d2f93 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -188,4 +188,10 @@ static inline struct ipc_security_struct *selinux_ipc(
 	return ipc->security + selinux_blob_sizes.lbs_ipc;
 }
 
+static inline struct superblock_security_struct *selinux_superblock(
+					const struct super_block *superblock)
+{
+	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d6e7b4856d93..4190c5e9e66c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -51,6 +51,7 @@
 #include <linux/mutex.h>
 #include <linux/flex_array.h>
 #include <linux/vmalloc.h>
+#include <linux/lsm_hooks.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -2732,7 +2733,7 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	const char *fstype = sb->s_type->name;
 
 	read_lock(&state->ss->policy_rwlock);
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 9c7c95a5c497..e943e0fd3ea1 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -384,6 +384,12 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
 	return ipc->security + smack_blob_sizes.lbs_ipc;
 }
 
+static inline struct superblock_smack *smack_superblock(
+					const struct super_block *superblock)
+{
+	return superblock->s_security + smack_blob_sizes.lbs_superblock;
+}
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 79d6d2a6a0bc..18892df4ecaf 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -539,12 +539,7 @@ static int smack_syslog(int typefrom_file)
  */
 static int smack_sb_alloc_security(struct super_block *sb)
 {
-	struct superblock_smack *sbsp;
-
-	sbsp = kzalloc(sizeof(struct superblock_smack), GFP_KERNEL);
-
-	if (sbsp == NULL)
-		return -ENOMEM;
+	struct superblock_smack *sbsp = smack_superblock(sb);
 
 	sbsp->smk_root = &smack_known_floor;
 	sbsp->smk_default = &smack_known_floor;
@@ -553,22 +548,10 @@ static int smack_sb_alloc_security(struct super_block *sb)
 	/*
 	 * SMK_SB_INITIALIZED will be zero from kzalloc.
 	 */
-	sb->s_security = sbsp;
 
 	return 0;
 }
 
-/**
- * smack_sb_free_security - free a superblock blob
- * @sb: the superblock getting the blob
- *
- */
-static void smack_sb_free_security(struct super_block *sb)
-{
-	kfree(sb->s_security);
-	sb->s_security = NULL;
-}
-
 struct smack_mnt_opts {
 	const char *fsdefault, *fsfloor, *fshat, *fsroot, *fstransmute;
 };
@@ -694,7 +677,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 {
 	struct dentry *root = sb->s_root;
 	struct inode *inode = d_backing_inode(root);
-	struct superblock_smack *sp = sb->s_security;
+	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
 	struct smack_mnt_opts *opts = mnt_opts;
@@ -793,7 +776,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
  */
 static int smack_sb_statfs(struct dentry *dentry)
 {
-	struct superblock_smack *sbp = dentry->d_sb->s_security;
+	struct superblock_smack *sbp = smack_superblock(dentry->d_sb);
 	int rc;
 	struct smk_audit_info ad;
 
@@ -830,7 +813,7 @@ static int smack_bprm_set_creds(struct linux_binprm *bprm)
 	if (isp->smk_task == NULL || isp->smk_task == bsp->smk_task)
 		return 0;
 
-	sbsp = inode->i_sb->s_security;
+	sbsp = smack_superblock(inode->i_sb);
 	if ((sbsp->smk_flags & SMK_SB_UNTRUSTED) &&
 	    isp->smk_task != sbsp->smk_root)
 		return 0;
@@ -1081,7 +1064,7 @@ static int smack_inode_rename(struct inode *old_inode,
  */
 static int smack_inode_permission(struct inode *inode, int mask)
 {
-	struct superblock_smack *sbsp = inode->i_sb->s_security;
+	struct superblock_smack *sbsp = smack_superblock(inode->i_sb);
 	struct smk_audit_info ad;
 	int no_block = mask & MAY_NOT_BLOCK;
 	int rc;
@@ -1323,7 +1306,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 	 */
 	if (strcmp(name, XATTR_NAME_SMACK) == 0) {
 		struct super_block *sbp = dentry->d_sb;
-		struct superblock_smack *sbsp = sbp->s_security;
+		struct superblock_smack *sbsp = smack_superblock(sbp);
 
 		isp->smk_inode = sbsp->smk_default;
 	} else if (strcmp(name, XATTR_NAME_SMACKEXEC) == 0)
@@ -1593,7 +1576,7 @@ static int smack_mmap_file(struct file *file,
 	isp = smack_inode(file_inode(file));
 	if (isp->smk_mmap == NULL)
 		return 0;
-	sbsp = file_inode(file)->i_sb->s_security;
+	sbsp = smack_superblock(file_inode(file)->i_sb);
 	if (sbsp->smk_flags & SMK_SB_UNTRUSTED &&
 	    isp->smk_mmap != sbsp->smk_root)
 		return -EACCES;
@@ -3201,7 +3184,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
 		goto unlockandout;
 
 	sbp = inode->i_sb;
-	sbsp = sbp->s_security;
+	sbsp = smack_superblock(sbp);
 	/*
 	 * We're going to use the superblock default label
 	 * if there's no label on the file.
@@ -4491,6 +4474,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
 	.lbs_msg_msg = sizeof(struct smack_known *),
+	.lbs_superblock = sizeof(struct superblock_smack),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4499,7 +4483,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(syslog, smack_syslog),
 
 	LSM_HOOK_INIT(sb_alloc_security, smack_sb_alloc_security),
-	LSM_HOOK_INIT(sb_free_security, smack_sb_free_security),
 	LSM_HOOK_INIT(sb_free_mnt_opts, smack_free_mnt_opts),
 	LSM_HOOK_INIT(sb_eat_lsm_opts, smack_sb_eat_lsm_opts),
 	LSM_HOOK_INIT(sb_statfs, smack_sb_statfs),
-- 
2.17.0

