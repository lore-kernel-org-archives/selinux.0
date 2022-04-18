Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE61FC433F5
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiDRJtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiDRJtE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEED5165A2;
        Mon, 18 Apr 2022 02:46:25 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhhpM02G1zFq5F;
        Mon, 18 Apr 2022 17:43:55 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:20 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:18 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 2/7] selinux: support per-namespace superblock security structures
Date:   Mon, 18 Apr 2022 17:45:47 +0800
Message-ID: <20220418094552.128898-3-alexander.kozhevnikov@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
References: <CAHC9VhTDu1GDxJwFg5gAMWhuMKUWEU5eXuTr_6eG=tGwiGsMTw@mail.gmail.com>
 <20220418094552.128898-1-alexander.kozhevnikov@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.219.174.70]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 dggpemm500011.china.huawei.com (7.185.36.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Igor Baranov <igor.baranov@huawei.com>

This port of commit
https://github.com/stephensmalley/selinux-kernel/commit/3378718ef7d4a837f32c63bdfcc0b70342cdd55d
Rebased to working-selinuxns and refactored.

Extend the superblock security structure to include a reference
to the associated selinux namespace, and turn it into a list so
that we can maintain per-superblock security state for each namespace.
This is necessary because the superblock SIDs and labeling behavior
are per selinux namespace.  It further enables one to context-mount
a filesystem with a particular context in one namespace while using
xattrs in another, e.g. one might context mount a container filesystem
in the init selinux namespace to provide MCS-style isolation of the
containers while using per-file xattrs within the container to support
conventional SELinux targeted policy.

Introduce a superblock_security() helper to return the superblock
security blob for the current selinux namespace and replace direct uses
of sb->s_security with calls to it.

Also revert the changes made by
commit a64c54cf0811b8032fdab8c9d52576f0370837fa ("SELinux: pass a
superblock to security_fs_use") so that access to the superblock
security structure is properly encapsulated and we can support
per-namespace structures.

This change has similar problems as with the inode security structure
change, see the list of issues in that commit.

Not-signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c            | 90 ++++++++++++++++++++++++++---
 security/selinux/include/objsec.h   | 20 ++++++-
 security/selinux/include/security.h |  3 +-
 security/selinux/ss/services.c      | 19 +++---
 4 files changed, 112 insertions(+), 20 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d88b6bec24b..a1716ce534dd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -613,7 +613,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 {
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-	struct dentry *root = sbsec->sb->s_root;
+	struct dentry *root = sb->s_root;
 	struct selinux_mnt_opts *opts = mnt_opts;
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
@@ -730,7 +730,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 * Determine the labeling behavior to use for this
 		 * filesystem type.
 		 */
-		rc = security_fs_use(current_selinux_state, sb);
+		rc = security_fs_use(current_selinux_state, sb->s_type->name,
+				     &sbsec->behavior, &sbsec->sid);
 		if (rc) {
 			pr_warn("%s: security_fs_use(%s) returned %d\n",
 					__func__, sb->s_type->name, rc);
@@ -924,7 +925,8 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
-		rc = security_fs_use(current_selinux_state, newsb);
+		rc = security_fs_use(current_selinux_state, newsb->s_type->name,
+				     &newsbsec->behavior, &newsbsec->sid);
 		if (rc)
 			goto out;
 	}
@@ -1094,7 +1096,7 @@ static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 			return rc;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
-		struct dentry *root = sbsec->sb->s_root;
+		struct dentry *root = sb->s_root;
 		struct inode_security_struct *isec = backing_inode_security(root);
 		seq_putc(m, ',');
 		seq_puts(m, ROOTCONTEXT_STR);
@@ -2564,21 +2566,94 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 
 /* superblock security operations */
 
-static int selinux_sb_alloc_security(struct super_block *sb)
+static void sbsec_head_init(struct super_block *sb,
+			    struct superblock_security_head *sbsech)
 {
-	struct superblock_security_struct *sbsec = selinux_superblock(sb);
+	INIT_LIST_HEAD(&sbsech->head);
+	spin_lock_init(&sbsech->lock);
+}
 
+static struct superblock_security_struct *
+sbsec_alloc(struct superblock_security_head *sbsech)
+{
+	struct superblock_security_struct *sbsec;
+
+	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_NOFS);
+	if (!sbsec)
+		return NULL;
 	mutex_init(&sbsec->lock);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
-	sbsec->sb = sb;
+	sbsec->sbsech = sbsech;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
+	sbsec->state = get_selinux_state(current_selinux_state);
+
+	return sbsec;
+}
+
+struct superblock_security_struct *
+find_sbsec(struct superblock_security_head *sbsech)
+{
+	struct superblock_security_struct *cur, *new;
+
+	cur = container_of(sbsech->head.next, struct superblock_security_struct, sbsec_list);
+	if (cur->state == current_selinux_state)
+		return cur;
 
+	spin_lock(&sbsech->lock);
+	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
+		if (cur->state == current_selinux_state)
+			goto unlock;
+	}
+	spin_unlock(&sbsech->lock);
+
+	new = sbsec_alloc(sbsech);
+	if (!new) {
+		cur = NULL;
+		goto out;
+	}
+
+	spin_lock(&sbsech->lock);
+	list_for_each_entry(cur, &sbsech->head, sbsec_list) {
+		if (cur->state == current_selinux_state)
+			goto unlock;
+	}
+	list_add(&new->sbsec_list, &sbsech->head);
+	cur = new;
+unlock:
+	spin_unlock(&sbsech->lock);
+out:
+	return cur;
+}
+
+static int selinux_sb_alloc_security(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec;
+	struct superblock_security_head *sbsech = selinux_head_of_superblock(sb);
+
+	sbsec_head_init(sb, sbsech);
+	sbsec = sbsec_alloc(sbsech);
+	if (!sbsec)
+		return -ENOMEM;
+	spin_lock(&sbsech->lock);
+	list_add(&sbsec->sbsec_list, &sbsech->head);
+	spin_unlock(&sbsech->lock);
 	return 0;
 }
 
+static void selinux_sb_free_security(struct super_block *sb)
+{
+	struct superblock_security_struct *entry, *tmp;
+	struct superblock_security_head *sbsech = selinux_head_of_superblock(sb);
+
+	list_for_each_entry_safe(entry, tmp, &sbsech->head, sbsec_list) {
+		put_selinux_state(entry->state);
+		kfree(entry);
+	}
+}
+
 static inline int opt_len(const char *s)
 {
 	bool open_quote = false;
@@ -7224,6 +7299,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 		      selinux_msg_queue_alloc_security),
 	LSM_HOOK_INIT(shm_alloc_security, selinux_shm_alloc_security),
 	LSM_HOOK_INIT(sb_alloc_security, selinux_sb_alloc_security),
+	LSM_HOOK_INIT(sb_free_security, selinux_sb_free_security),
 	LSM_HOOK_INIT(inode_alloc_security, selinux_inode_alloc_security),
 	LSM_HOOK_INIT(sem_alloc_security, selinux_sem_alloc_security),
 	LSM_HOOK_INIT(secid_to_secctx, selinux_secid_to_secctx),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index f456bb5782a3..6ad1db45b0d9 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -51,8 +51,13 @@ struct file_security_struct {
 	u32 pseqno;		/* Policy seqno at the time of file open */
 };
 
+struct superblock_security_head {
+	struct list_head head;		/* list head of superblock_security_struct */
+	spinlock_t lock;
+};
+
 struct superblock_security_struct {
-	struct super_block *sb;		/* back pointer to sb object */
+	struct superblock_security_head *sbsech;	/* back pointer to superbock_security_head */
 	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
@@ -61,6 +66,8 @@ struct superblock_security_struct {
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
+	struct selinux_state *state;	/* pointer to selinux_state */
+	struct list_head sbsec_list;
 };
 
 struct msg_security_struct {
@@ -176,10 +183,19 @@ static inline u32 current_sid(void)
 	return tsec->sid;
 }
 
-static inline struct superblock_security_struct *selinux_superblock(
+static inline struct superblock_security_head *selinux_head_of_superblock(
 					const struct super_block *superblock)
 {
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+extern struct superblock_security_struct *
+find_sbsec(struct superblock_security_head *sbsech);
+
+static inline struct superblock_security_struct *selinux_superblock(
+					const struct super_block *superblock)
+{
+	return find_sbsec(selinux_head_of_superblock(superblock));
+}
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1a7d76f0faf3..a5b698aae38c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -410,7 +410,8 @@ int security_get_allow_unknown(struct selinux_state *state);
 #define SECURITY_FS_USE_NATIVE		7 /* use native label support */
 #define SECURITY_FS_USE_MAX		7 /* Highest SECURITY_FS_USE_XXX */
 
-int security_fs_use(struct selinux_state *state, struct super_block *sb);
+int security_fs_use(struct selinux_state *state, const char *fstype,
+		    unsigned short *behavior, u32 *sid);
 
 int security_genfs_sid(struct selinux_state *state,
 		       const char *fstype, char *name, u16 sclass,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 2c9e77ca4754..548acdecafa8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2868,19 +2868,18 @@ int selinux_policy_genfs_sid(struct selinux_policy *policy,
  * security_fs_use - Determine how to handle labeling for a filesystem.
  * @sb: superblock in question
  */
-int security_fs_use(struct selinux_state *state, struct super_block *sb)
+int security_fs_use(struct selinux_state *state, const char *fstype,
+		    unsigned short *behavior, u32 *sid)
 {
 	struct selinux_policy *policy;
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
-	struct superblock_security_struct *sbsec = selinux_superblock(sb);
-	const char *fstype = sb->s_type->name;
 
 	if (!selinux_initialized(state)) {
-		sbsec->behavior = SECURITY_FS_USE_NONE;
-		sbsec->sid = SECINITSID_UNLABELED;
+		*behavior = SECURITY_FS_USE_NONE;
+		*sid = SECINITSID_UNLABELED;
 		return 0;
 	}
 
@@ -2897,22 +2896,22 @@ int security_fs_use(struct selinux_state *state, struct super_block *sb)
 	}
 
 	if (c) {
-		sbsec->behavior = c->v.behavior;
+		*behavior = c->v.behavior;
 		if (!c->sid[0]) {
 			rc = sidtab_context_to_sid(sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
 		}
-		sbsec->sid = c->sid[0];
+		*sid = c->sid[0];
 	} else {
 		rc = __security_genfs_sid(policy, fstype, "/",
-					SECCLASS_DIR, &sbsec->sid);
+					SECCLASS_DIR, sid);
 		if (rc) {
-			sbsec->behavior = SECURITY_FS_USE_NONE;
+			*behavior = SECURITY_FS_USE_NONE;
 			rc = 0;
 		} else {
-			sbsec->behavior = SECURITY_FS_USE_GENFS;
+			*behavior = SECURITY_FS_USE_GENFS;
 		}
 	}
 
-- 
2.34.1

