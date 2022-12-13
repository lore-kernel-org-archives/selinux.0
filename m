Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2ADC4332F
	for <selinux@archiver.kernel.org>; Tue, 13 Dec 2022 03:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiLMDk1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Dec 2022 22:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiLMDkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Dec 2022 22:40:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C5B1BEA1;
        Mon, 12 Dec 2022 19:40:18 -0800 (PST)
Received: from dggpemm500011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWPPL0YhkzRpvB;
        Tue, 13 Dec 2022 11:39:18 +0800 (CST)
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 11:40:14 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
To:     <linux-security-module@vger.kernel.org>
CC:     <paul@paul-moore.com>, <jamorris@linux.microsoft.com>,
        <selinux@vger.kernel.org>, <stephen.smalley.work@gmail.com>,
        <artem.kuzin@huawei.com>, <hw.likun@huawei.com>,
        <alexander.kozhevnikov@huawei-partners.com>,
        <xiujianfeng@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [PATCH 1/1] [RFC] SELINUX: Remove obsolete deferred inode security init list.
Date:   Tue, 13 Dec 2022 11:39:48 +0800
Message-ID: <20221213033948.73512-2-alexander.kozhevnikov@huawei-partners.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213033948.73512-1-alexander.kozhevnikov@huawei-partners.com>
References: <20221213033948.73512-1-alexander.kozhevnikov@huawei-partners.com>
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

This patch is a proposed code optimization for SELinux:

1) Each inode has SELinux security structure attached
   to it, this one need to be initialized at some point.
2) This initialization is done by the function
   inode_doinit_with_dentry ( ).
3) In the kernel releases started from some point in the past
   this function (2) is always called normally from function
   __inode_security_revalidate ( ).
4) Which in turn is always called  from inode_security ( ), which
   is a base point for any selinux calls and always called on
   any access to any inode except a few special cases when
   _inode_security_novalidate ( ) is used.
5) Inode security structure initialization can be done only after
   SELinux is fully initialized and policy is loaded.
6) So, for this purpose there was a special defeferred inode security
   initialization list protected by a spinlock implemented, which was
   populated instead of isec initialization in function
   inode_doinit_with_dentry ( ), if it was called before SELinux full
   initialization, and processed at the time when SELinux policy load
   occurred by calling again inode_doinit_with_dentry ( ) on each inode
   in this list.
7) This list was a part of a default initialization logic before (3) was
   implemented, but now, taking into account new mechanism implemented
   with current approach of inode security revalidation on each access
   (4)-(3)-(2), it looks obsolete and not needed anymore.
8) So deferred initialization, this list and code associated with it can
   be safely removed now, as anyway, if inode isec was not initialized
   before it will be processed on any next inode access.
9) Another case for calling inode_doinit_with_dentry( ) is when a new
   dentry is created. This is done by call from d_instantiate( ). When
   the deferred initialization list is removed it would be useful to
   also check for SELinux initialization status here before calling
   inode_doinit_with_dentry( ) like it is done in
   __inode_security_revalidate( ).
10) There are two possible positive consequences from this removal:
     a. More clean and simple code, less memory consumption;
     b. This deferred initialization in some cases (for example SELinux
        was switched on manually after system was up quite a long time)
        could take some significant time to process, i.e. system looks
        hung for some notable time. And now this is avoided.

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
---
 security/selinux/hooks.c          | 91 ++++---------------------------
 security/selinux/include/objsec.h |  3 -
 2 files changed, 11 insertions(+), 83 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f553c370397e..88da9068a29e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -314,31 +314,6 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 	return selinux_inode(inode);
 }
 
-static void inode_free_security(struct inode *inode)
-{
-	struct inode_security_struct *isec = selinux_inode(inode);
-	struct superblock_security_struct *sbsec;
-
-	if (!isec)
-		return;
-	sbsec = selinux_superblock(inode->i_sb);
-	/*
-	 * As not all inode security structures are in a list, we check for
-	 * empty list outside of the lock to make sure that we won't waste
-	 * time taking a lock doing nothing.
-	 *
-	 * The list_del_init() function can be safely called more than once.
-	 * It should not be possible for this function to be called with
-	 * concurrent list_add(), but for better safety against future changes
-	 * in the code, we use list_empty_careful() here.
-	 */
-	if (!list_empty_careful(&isec->list)) {
-		spin_lock(&sbsec->isec_lock);
-		list_del_init(&isec->list);
-		spin_unlock(&sbsec->isec_lock);
-	}
-}
-
 struct selinux_mnt_opts {
 	u32 fscontext_sid;
 	u32 context_sid;
@@ -549,30 +524,7 @@ static int sb_finish_set_opts(struct super_block *sb)
 		sbsec->flags &= ~SBLABEL_MNT;
 
 	/* Initialize the root inode. */
-	rc = inode_doinit_with_dentry(root_inode, root);
-
-	/* Initialize any other inodes associated with the superblock, e.g.
-	   inodes created prior to initial policy load or inodes created
-	   during get_sb by a pseudo filesystem that directly
-	   populates itself. */
-	spin_lock(&sbsec->isec_lock);
-	while (!list_empty(&sbsec->isec_head)) {
-		struct inode_security_struct *isec =
-				list_first_entry(&sbsec->isec_head,
-					   struct inode_security_struct, list);
-		struct inode *inode = isec->inode;
-		list_del_init(&isec->list);
-		spin_unlock(&sbsec->isec_lock);
-		inode = igrab(inode);
-		if (inode) {
-			if (!IS_PRIVATE(inode))
-				inode_doinit_with_dentry(inode, NULL);
-			iput(inode);
-		}
-		spin_lock(&sbsec->isec_lock);
-	}
-	spin_unlock(&sbsec->isec_lock);
-	return rc;
+	return inode_doinit_with_dentry(root_inode, root);
 }
 
 static int bad_option(struct superblock_security_struct *sbsec, char flag,
@@ -1378,6 +1330,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->initialized == LABEL_INITIALIZED)
 		return 0;
 
+	sbsec = selinux_superblock(inode->i_sb);
+	if (!(sbsec->flags & SE_SBINITIALIZED))
+		return 0;
+
 	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
@@ -1385,18 +1341,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
-	sbsec = selinux_superblock(inode->i_sb);
-	if (!(sbsec->flags & SE_SBINITIALIZED)) {
-		/* Defer initialization until selinux_complete_init,
-		   after the initial policy is loaded and the security
-		   server is ready to handle calls. */
-		spin_lock(&sbsec->isec_lock);
-		if (list_empty(&isec->list))
-			list_add(&isec->list, &sbsec->isec_head);
-		spin_unlock(&sbsec->isec_lock);
-		goto out_unlock;
-	}
-
 	sclass = isec->sclass;
 	task_sid = isec->task_sid;
 	sid = isec->sid;
@@ -1429,12 +1373,10 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		}
 		if (!dentry) {
 			/*
-			 * this is can be hit on boot when a file is accessed
-			 * before the policy is loaded.  When we load policy we
-			 * may find inodes that have no dentry on the
-			 * sbsec->isec_head list.  No reason to complain as these
+			 * This is can be hit on boot when a file is accessed
+			 * before the policy is loaded. No reason to complain as these
 			 * will get fixed up the next time we go through
-			 * inode_doinit with a dentry, before these inodes could
+			 * inode_doinit_with_dentry(), before these inodes could
 			 * be used again by userspace.
 			 */
 			goto out_invalid;
@@ -1486,11 +1428,9 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			}
 			/*
 			 * This can be hit on boot when a file is accessed
-			 * before the policy is loaded.  When we load policy we
-			 * may find inodes that have no dentry on the
-			 * sbsec->isec_head list.  No reason to complain as
+			 * before the policy is loaded. No reason to complain as
 			 * these will get fixed up the next time we go through
-			 * inode_doinit() with a dentry, before these inodes
+			 * inode_doinit_with_dentry(), before these inodes
 			 * could be used again by userspace.
 			 */
 			if (!dentry)
@@ -2543,8 +2483,6 @@ static int selinux_sb_alloc_security(struct super_block *sb)
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 
 	mutex_init(&sbsec->lock);
-	INIT_LIST_HEAD(&sbsec->isec_head);
-	spin_lock_init(&sbsec->isec_lock);
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
@@ -2808,7 +2746,6 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	u32 sid = current_sid();
 
 	spin_lock_init(&isec->lock);
-	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
@@ -2818,11 +2755,6 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	return 0;
 }
 
-static void selinux_inode_free_security(struct inode *inode)
-{
-	inode_free_security(inode);
-}
-
 static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 					const struct qstr *name,
 					const char **xattr_name, void **ctx,
@@ -6325,7 +6257,7 @@ static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
-	if (inode)
+	if (selinux_initialized(&selinux_state) && inode)
 		inode_doinit_with_dentry(inode, dentry);
 }
 
@@ -7067,7 +6999,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
 	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
 
-	LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
 	LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
 	LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
 	LSM_HOOK_INIT(inode_create, selinux_inode_create),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 2953132408bf..58f752af38cf 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -45,7 +45,6 @@ enum label_initialized {
 
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
-	struct list_head list;	/* list of inode_security_struct */
 	u32 task_sid;		/* SID of creating task */
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
@@ -67,8 +66,6 @@ struct superblock_security_struct {
 	unsigned short behavior;	/* labeling behavior */
 	unsigned short flags;		/* which mount options were specified */
 	struct mutex lock;
-	struct list_head isec_head;
-	spinlock_t isec_lock;
 };
 
 struct msg_security_struct {
-- 
2.31.1

