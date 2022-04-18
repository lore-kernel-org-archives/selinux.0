Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1494C433EF
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiDRJtQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiDRJtM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF25165B5;
        Mon, 18 Apr 2022 02:46:31 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KhhsD6bSYzhXZd;
        Mon, 18 Apr 2022 17:46:24 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:30 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:28 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 7/7] SELINUXNS: Fixing concurrency issues
Date:   Mon, 18 Apr 2022 17:45:52 +0800
Message-ID: <20220418094552.128898-8-alexander.kozhevnikov@huawei.com>
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

1) Fix of filesystem info ZERO pointer dereference due to concurrency race.
It was possible for selinuxfs info structure to be cleared when it is still in use.
The decision was not to use locks to avoid this but just add zero pointer checks
in the code and assign NULL to the pointer before actual structure clearance.

2) Fix for selinuxfs mutex concurrency.
As it is possible to have the same selinuxfs filesystem mounted in different states
we need a global mutex lock on all write operations in selinuxns.

3) Inode deferred initialization list removed.
This list attached to sbsec was used to do deferred isec init after selinux state
init was complete.
This functionality is anyway implemented now through revalidate procedure.
List looks obsolete now.

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 security/selinux/hooks.c          |  56 +-----
 security/selinux/include/objsec.h |   1 -
 security/selinux/selinuxfs.c      | 275 +++++++++++++++++++++++-------
 security/selinux/ss/services.c    |  12 +-
 4 files changed, 227 insertions(+), 117 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e17175ff707d..db5bdfd7c3fb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -346,27 +346,7 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 
 static void inode_free_security(struct inode *inode)
 {
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
+ /* NOTHING TO DO NOW */
 }
 
 struct selinux_mnt_opts {
@@ -641,27 +621,6 @@ static int sb_finish_set_opts(struct super_block *sb)
 	/* Initialize the root inode. */
 	rc = inode_doinit_with_dentry(root_inode, root);
 
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
 out:
 	return rc;
 }
@@ -1602,13 +1561,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 	sbsec = selinux_superblock(inode->i_sb);
 	if (!(sbsec->flags & SE_SBINITIALIZED)) {
-		/* Defer initialization until selinux_complete_init,
-		   after the initial policy is loaded and the security
-		   server is ready to handle calls. */
-		spin_lock(&sbsec->isec_lock);
-		if (list_empty(&isec->list))
-			list_add(&isec->list, &sbsec->isec_head);
-		spin_unlock(&sbsec->isec_lock);
 		return 0;
 	}
 
@@ -2786,8 +2738,6 @@ sbsec_alloc(struct superblock_security_head *sbsech)
 	if (!sbsec)
 		return NULL;
 	mutex_init(&sbsec->lock);
-	INIT_LIST_HEAD(&sbsec->isec_head);
-	spin_lock_init(&sbsec->isec_lock);
 	sbsec->sbsech = sbsech;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
@@ -3133,7 +3083,6 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	u32 sid = current_sid();
 
 	spin_lock_init(&isec->lock);
-	INIT_LIST_HEAD(&isec->list);
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
@@ -7654,6 +7603,8 @@ void __put_selinux_state(struct selinux_state *state)
 	schedule_work(&state->work);
 }
 
+extern struct mutex selinuxfs_mutex;
+
 static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
@@ -7664,6 +7615,7 @@ static __init int selinux_init(void)
 	init_selinux_state->checkreqprot = selinux_checkreqprot_boot;
 
 	spin_lock_init(&sb_state_lock);
+	mutex_init(&selinuxfs_mutex);
 
 	/* Set the security state for the initial task. */
 	cred_init_security();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6d9c63c57620..22b577540224 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -36,7 +36,6 @@ enum label_initialized {
 
 struct inode_security_struct {
 	struct inode *inode;	/* back pointer to inode object */
-	struct list_head list;	/* list of inode_security_struct */
 	u32 task_sid;		/* SID of creating task */
 	u32 sid;		/* SID of this object */
 	u16 sclass;		/* security class of this object */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 5a29516d81a8..0cd609744c98 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -43,6 +43,8 @@
 #include "objsec.h"
 #include "conditional.h"
 
+struct mutex selinuxfs_mutex;    /* GLobal mutex for all selinuxfs access */
+
 enum sel_inos {
 	SEL_ROOT_INO = 2,
 	SEL_LOAD,	/* load policy */
@@ -102,15 +104,16 @@ static void selinux_fs_info_free(struct super_block *sb)
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	int i;
 
+	sb->s_fs_info = NULL;
 	if (fsi) {
 		put_selinux_state(fsi->state);
 		for (i = 0; i < fsi->bool_num; i++)
 			kfree(fsi->bool_pending_names[i]);
 		kfree(fsi->bool_pending_names);
 		kfree(fsi->bool_pending_values);
+		kfree(fsi);
 	}
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+
 }
 
 #define SEL_INITCON_INO_OFFSET		0x01000000
@@ -131,6 +134,9 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
 			   enforcing_enabled(fsi->state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -142,11 +148,15 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *page = NULL;
 	ssize_t length;
 	int old_value, new_value;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	if (state != current_selinux_state)
 		return -EPERM;
 
@@ -157,9 +167,13 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
+	mutex_lock(&selinuxfs_mutex);
+
 	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (IS_ERR(page)) {
+		length = PTR_ERR(page);
+		goto out_unlock;
+	}
 
 	length = -EINVAL;
 	if (sscanf(page, "%d", &new_value) != 1)
@@ -192,6 +206,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 	length = count;
 out:
 	kfree(page);
+out_unlock:
+	mutex_unlock(&selinuxfs_mutex);
 	return length;
 }
 #else
@@ -208,11 +224,17 @@ static ssize_t sel_read_handle_unknown(struct file *filp, char __user *buf,
 					size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 	ino_t ino = file_inode(filp)->i_ino;
-	int handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
+	int handle_unknown;
+
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
+	handle_unknown = (ino == SEL_REJECT_UNKNOWN) ?
 		security_get_reject_unknown(state) :
 		!security_get_allow_unknown(state);
 
@@ -228,7 +250,12 @@ static const struct file_operations sel_handle_unknown_ops = {
 static int sel_open_handle_status(struct inode *inode, struct file *filp)
 {
 	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
-	struct page    *status = selinux_kernel_status_page(fsi->state);
+	struct page    *status;
+
+	if (fsi == NULL)
+		return -EINVAL;
+
+	status = selinux_kernel_status_page(fsi->state);
 
 	if (!status)
 		return -ENOMEM;
@@ -290,6 +317,9 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 	int new_value;
 	int enforcing;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
@@ -316,8 +346,10 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 		goto out;
 
 	if (new_value) {
+		mutex_lock(&selinuxfs_mutex);
 		enforcing = enforcing_enabled(fsi->state);
 		length = selinux_disable(fsi->state);
+		mutex_unlock(&selinuxfs_mutex);
 		if (length)
 			goto out;
 		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
@@ -347,31 +379,33 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	struct cred *cred;
 	struct task_security_struct *tsec;
 	char *suffix, *p;
 	ssize_t len;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	if (state != current_selinux_state)
 		return -EPERM;
 
-	if (count >= PAGE_SIZE)
-		return -ENOMEM;
-
 	/* No partial writes. */
 	if (*ppos != 0)
 		return -EINVAL;
 
+	if ((count >= PAGE_SIZE) ||
+	    (count > XATTR_NAME_MAX - sizeof(XATTR_NAME_SELINUX) - 2))
+		return -EINVAL;
+
 	len = avc_has_perm(current_selinux_state, current_sid(),
 			  SECINITSID_SECURITY, SECCLASS_SECURITY,
 			  SECURITY__UNSHARE, NULL);
 	if (len)
 		return len;
 
-	if (count > XATTR_NAME_MAX - sizeof(XATTR_NAME_SELINUX) - 2)
-		return -EINVAL;
-
 	suffix = memdup_user_nul(buf, count);
 	if (IS_ERR(suffix))
 		return PTR_ERR(suffix);
@@ -423,14 +457,19 @@ static ssize_t sel_read_unshare(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	size_t slen = sizeof(XATTR_SELINUX_SUFFIX);
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
+
 	if (state->id != current_selinux_state->id)
 		return -EPERM;
 
 	return simple_read_from_buffer(buf, count, ppos, state->xattr_name + slen,
-									strlen(state->xattr_name + slen));
+						strlen(state->xattr_name + slen));
 }
 
 static const struct file_operations sel_unshare_ops = {
@@ -480,6 +519,9 @@ static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d",
 			   security_mls_enabled(fsi->state));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -498,13 +540,17 @@ struct policy_load_memory {
 static int sel_open_policy(struct inode *inode, struct file *filp)
 {
 	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	struct policy_load_memory *plm = NULL;
 	int rc;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	BUG_ON(filp->private_data);
 
-	mutex_lock(&fsi->state->policy_mutex);
+	mutex_lock(&selinuxfs_mutex);
 
 	rc = avc_has_perm(current_selinux_state,
 			  current_sid(), SECINITSID_SECURITY,
@@ -535,11 +581,11 @@ static int sel_open_policy(struct inode *inode, struct file *filp)
 
 	filp->private_data = plm;
 
-	mutex_unlock(&fsi->state->policy_mutex);
+	mutex_unlock(&selinuxfs_mutex);
 
 	return 0;
 err:
-	mutex_unlock(&fsi->state->policy_mutex);
+	mutex_unlock(&selinuxfs_mutex);
 
 	if (plm)
 		vfree(plm->data);
@@ -552,6 +598,9 @@ static int sel_release_policy(struct inode *inode, struct file *filp)
 	struct selinux_fs_info *fsi = inode->i_sb->s_fs_info;
 	struct policy_load_memory *plm = filp->private_data;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	BUG_ON(!plm);
 
 	fsi->policy_opened = 0;
@@ -726,10 +775,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 	ssize_t length;
 	void *data = NULL;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
-	mutex_lock(&fsi->state->policy_mutex);
+	mutex_lock(&selinuxfs_mutex);
 
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -773,7 +825,7 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
 		from_kuid(&init_user_ns, audit_get_loginuid(current)),
 		audit_get_sessionid(current));
 out:
-	mutex_unlock(&fsi->state->policy_mutex);
+	mutex_unlock(&selinuxfs_mutex);
 	vfree(data);
 	return length;
 }
@@ -786,16 +838,20 @@ static const struct file_operations sel_load_ops = {
 static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *canon = NULL;
 	u32 sid, len;
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__CHECK_CONTEXT, NULL);
 	if (length)
-		goto out;
+		return length;
 
 	length = security_context_to_sid(state, buf, size, &sid, GFP_KERNEL);
 	if (length)
@@ -826,6 +882,9 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", fsi->state->checkreqprot);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
@@ -838,6 +897,9 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	ssize_t length;
 	unsigned int new_value;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
@@ -855,9 +917,13 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
+	mutex_lock(&selinuxfs_mutex);
+
 	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (IS_ERR(page)) {
+		length = PTR_ERR(page);
+		goto out_unlock;
+	}
 
 	length = -EINVAL;
 	if (sscanf(page, "%u", &new_value) != 1)
@@ -875,6 +941,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 	length = count;
 out:
 	kfree(page);
+out_unlock:
+	mutex_unlock(&selinuxfs_mutex);
 	return length;
 }
 static const struct file_operations sel_checkreqprot_ops = {
@@ -888,13 +956,17 @@ static ssize_t sel_write_validatetrans(struct file *file,
 					size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *oldcon = NULL, *newcon = NULL, *taskcon = NULL;
 	char *req = NULL;
 	u32 osid, nsid, tsid;
 	u16 tclass;
 	int rc;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	if (state != current_selinux_state)
 		return -EPERM;
 
@@ -902,16 +974,16 @@ static ssize_t sel_write_validatetrans(struct file *file,
 			  current_sid(), SECINITSID_SECURITY,
 			  SECCLASS_SECURITY, SECURITY__VALIDATE_TRANS, NULL);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = -ENOMEM;
 	if (count >= PAGE_SIZE)
-		goto out;
+		return rc;
 
 	/* No partial writes. */
 	rc = -EINVAL;
 	if (*ppos != 0)
-		goto out;
+		return rc;
 
 	req = memdup_user_nul(buf, count);
 	if (IS_ERR(req)) {
@@ -953,10 +1025,10 @@ static ssize_t sel_write_validatetrans(struct file *file,
 	if (!rc)
 		rc = count;
 out:
-	kfree(req);
-	kfree(oldcon);
-	kfree(newcon);
 	kfree(taskcon);
+	kfree(newcon);
+	kfree(oldcon);
+	kfree(req);
 	return rc;
 }
 
@@ -990,6 +1062,9 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 	char *data;
 	ssize_t rv;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
@@ -1005,6 +1080,7 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 		simple_transaction_set(file, rv);
 		rv = size;
 	}
+
 	return rv;
 }
 
@@ -1024,18 +1100,23 @@ static const struct file_operations transaction_ops = {
 static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid;
 	u16 tclass;
 	struct av_decision avd;
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
+	state = fsi->state;
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_AV, NULL);
 	if (length)
-		goto out;
+		return length;
+
 
 	length = -ENOMEM;
 	scon = kzalloc(size + 1, GFP_KERNEL);
@@ -1075,7 +1156,7 @@ static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *scon = NULL, *tcon = NULL;
 	char *namebuf = NULL, *objname = NULL;
 	u32 ssid, tsid, newsid;
@@ -1085,6 +1166,10 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 	u32 len;
 	int nargs;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_CREATE,
@@ -1179,7 +1264,7 @@ static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
@@ -1187,6 +1272,10 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_RELABEL,
@@ -1240,7 +1329,7 @@ static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *con = NULL, *user = NULL, *ptr;
 	u32 sid, *sids = NULL;
 	ssize_t length;
@@ -1248,6 +1337,10 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int i, rc;
 	u32 len, nsids;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_USER,
@@ -1305,7 +1398,7 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *scon = NULL, *tcon = NULL;
 	u32 ssid, tsid, newsid;
 	u16 tclass;
@@ -1313,6 +1406,10 @@ static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 	char *newcon = NULL;
 	u32 len;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
 			      SECCLASS_SECURITY, SECURITY__COMPUTE_MEMBER,
@@ -1388,7 +1485,10 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
-	mutex_lock(&fsi->state->policy_mutex);
+	if (fsi == NULL)
+		return -EINVAL;
+
+	mutex_lock(&selinuxfs_mutex);
 
 	ret = -EINVAL;
 	if (index >= fsi->bool_num || strcmp(name,
@@ -1407,14 +1507,14 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 	}
 	length = scnprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
 			  fsi->bool_pending_values[index]);
-	mutex_unlock(&fsi->state->policy_mutex);
+	mutex_unlock(&selinuxfs_mutex);
 	ret = simple_read_from_buffer(buf, count, ppos, page, length);
 out_free:
 	free_page((unsigned long)page);
 	return ret;
 
 out_unlock:
-	mutex_unlock(&fsi->state->policy_mutex);
+	mutex_unlock(&selinuxfs_mutex);
 	goto out_free;
 }
 
@@ -1428,6 +1528,9 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	unsigned index = file_inode(filep)->i_ino & SEL_INO_MASK;
 	const char *name = filep->f_path.dentry->d_name.name;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
@@ -1438,11 +1541,13 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	mutex_lock(&selinuxfs_mutex);
 
-	mutex_lock(&fsi->state->policy_mutex);
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page)) {
+		length = PTR_ERR(page);
+		goto out_unlock;
+	}
 
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -1467,8 +1572,10 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 	length = count;
 
 out:
-	mutex_unlock(&fsi->state->policy_mutex);
 	kfree(page);
+out_unlock:
+	mutex_unlock(&selinuxfs_mutex);
+
 	return length;
 }
 
@@ -1487,6 +1594,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	ssize_t length;
 	int new_value;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	if (fsi->state != current_selinux_state)
 		return -EPERM;
 
@@ -1497,11 +1607,13 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (*ppos != 0)
 		return -EINVAL;
 
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	mutex_lock(&selinuxfs_mutex);
 
-	mutex_lock(&fsi->state->policy_mutex);
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page)) {
+		length = PTR_ERR(page);
+		goto out_unlock;
+	}
 
 	length = avc_has_perm(current_selinux_state,
 			      current_sid(), SECINITSID_SECURITY,
@@ -1523,8 +1635,9 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		length = count;
 
 out:
-	mutex_unlock(&fsi->state->policy_mutex);
 	kfree(page);
+out_unlock:
+	mutex_unlock(&selinuxfs_mutex);
 	return length;
 }
 
@@ -1622,10 +1735,14 @@ static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
 					    size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%u",
 			   avc_get_cache_threshold(state->avc));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
@@ -1637,11 +1754,15 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *page;
 	ssize_t ret;
 	unsigned int new_value;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	if (state != current_selinux_state)
 		return -EPERM;
 
@@ -1659,9 +1780,13 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	if (*ppos != 0)
 		return -EINVAL;
 
+	mutex_lock(&selinuxfs_mutex);
+
 	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (IS_ERR(page)) {
+		ret = PTR_ERR(page);
+		goto out_unlock;
+	}
 
 	ret = -EINVAL;
 	if (sscanf(page, "%u", &new_value) != 1)
@@ -1672,6 +1797,8 @@ static ssize_t sel_write_avc_cache_threshold(struct file *file,
 	ret = count;
 out:
 	kfree(page);
+out_unlock:
+	mutex_unlock(&selinuxfs_mutex);
 	return ret;
 }
 
@@ -1679,10 +1806,14 @@ static ssize_t sel_read_avc_hash_stats(struct file *filp, char __user *buf,
 				       size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *page;
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -1699,10 +1830,14 @@ static ssize_t sel_read_sidtab_hash_stats(struct file *filp, char __user *buf,
 					size_t count, loff_t *ppos)
 {
 	struct selinux_fs_info *fsi = file_inode(filp)->i_sb->s_fs_info;
-	struct selinux_state *state = fsi->state;
+	struct selinux_state *state;
 	char *page;
 	ssize_t length;
 
+	if (fsi == NULL)
+		return -EINVAL;
+	state = fsi->state;
+
 	page = (char *)__get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
@@ -1817,6 +1952,9 @@ static int sel_make_avc_files(struct dentry *dir)
 #endif
 	};
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
@@ -1848,6 +1986,9 @@ static int sel_make_ss_files(struct dentry *dir)
 		{ "sidtab_hash_stats", &sel_sidtab_hash_stats_ops, S_IRUGO },
 	};
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	for (i = 0; i < ARRAY_SIZE(files); i++) {
 		struct inode *inode;
 		struct dentry *dentry;
@@ -1878,6 +2019,9 @@ static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 	u32 sid, len;
 	ssize_t ret;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	sid = file_inode(file)->i_ino&SEL_INO_MASK;
 	ret = security_sid_to_context(fsi->state, sid, &con, &len);
 	if (ret)
@@ -1979,6 +2123,9 @@ static ssize_t sel_read_policycap(struct file *file, char __user *buf,
 	ssize_t length;
 	unsigned long i_ino = file_inode(file)->i_ino;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	value = security_policycap_supported(fsi->state, i_ino & SEL_INO_MASK);
 	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
 
@@ -2040,6 +2187,9 @@ static int sel_make_class_dir_entries(struct selinux_policy *newpolicy,
 	struct inode *inode = NULL;
 	int rc;
 
+	if (fsi == NULL)
+		return -EINVAL;
+
 	dentry = d_alloc_name(dir, "index");
 	if (!dentry)
 		return -ENOMEM;
@@ -2218,6 +2368,10 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto err;
 
 	fsi = sb->s_fs_info;
+
+	if (fsi == NULL)
+		goto err;
+
 	fsi->bool_dir = sel_make_dir(sb->s_root, BOOL_DIR_NAME, &fsi->last_ino);
 	if (IS_ERR(fsi->bool_dir)) {
 		ret = PTR_ERR(fsi->bool_dir);
@@ -2309,6 +2463,9 @@ static int selinuxfs_compare(struct super_block *sb, struct fs_context *fc)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 
+	if (fsi == NULL)
+		return 0;
+
 	return (current_selinux_state->id == fsi->state->id);
 }
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 548acdecafa8..5e1f0486add1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -67,6 +67,8 @@
 #include "audit.h"
 #include "policycap_names.h"
 
+extern struct mutex selinuxfs_mutex;    /* GLobal mutex for all selinuxfs access */
+
 /* Forward declaration. */
 static int context_struct_to_string(struct policydb *policydb,
 				    struct context *context,
@@ -2165,7 +2167,7 @@ void selinux_policy_cancel(struct selinux_state *state,
 	struct selinux_policy *oldpolicy;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
+					lockdep_is_held(&selinuxfs_mutex));
 
 	sidtab_cancel_convert(oldpolicy->sidtab);
 	selinux_policy_free(policy);
@@ -2189,7 +2191,7 @@ void selinux_policy_commit(struct selinux_state *state,
 	u32 seqno;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
+					lockdep_is_held(&selinuxfs_mutex));
 
 	/* If switching between different policy types, log MLS status */
 	if (oldpolicy) {
@@ -2283,7 +2285,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len,
 	}
 
 	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
+					lockdep_is_held(&selinuxfs_mutex));
 
 	/* Preserve active boolean values from the old policy */
 	rc = security_preserve_bools(oldpolicy, newpolicy);
@@ -2983,7 +2985,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 		return -EINVAL;
 
 	oldpolicy = rcu_dereference_protected(state->policy,
-					lockdep_is_held(&state->policy_mutex));
+					lockdep_is_held(&selinuxfs_mutex));
 
 	/* Consistency check on number of booleans, should never fail */
 	if (WARN_ON(len != oldpolicy->policydb.p_bools.nprim))
@@ -3888,7 +3890,7 @@ int security_read_policy(struct selinux_state *state,
 	struct policy_file fp;
 
 	policy = rcu_dereference_protected(
-			state->policy, lockdep_is_held(&state->policy_mutex));
+			state->policy, lockdep_is_held(&selinuxfs_mutex));
 	if (!policy)
 		return -EINVAL;
 
-- 
2.34.1

