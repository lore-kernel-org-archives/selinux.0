Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCFAC433FE
	for <selinux@archiver.kernel.org>; Mon, 18 Apr 2022 09:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiDRJtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Apr 2022 05:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiDRJtG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Apr 2022 05:49:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50B2165AD;
        Mon, 18 Apr 2022 02:46:25 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Khhs70KhHzhXXL;
        Mon, 18 Apr 2022 17:46:19 +0800 (CST)
Received: from dggpemm500011.china.huawei.com (7.185.36.110) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:24 +0800
Received: from mscphmkozh00002.huawei.com (10.219.174.70) by
 dggpemm500011.china.huawei.com (7.185.36.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 17:46:22 +0800
From:   Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
To:     <paul@paul-moore.com>
CC:     <alexander.kozhevnikov@huawei.com>, <artem.kuzin@huawei.com>,
        <hw.likun@huawei.com>, <igor.baranov@huawei.com>,
        <jamorris@linux.microsoft.com>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <stephen.smalley.work@gmail.com>, <xiujianfeng@huawei.com>,
        <yusongping@huawei.com>, <anton.sirazetdinov@huawei.com>
Subject: [RFC PATCH 4/7] SELINUXNS: Namespacing for xattrs
Date:   Mon, 18 Apr 2022 17:45:49 +0800
Message-ID: <20220418094552.128898-5-alexander.kozhevnikov@huawei.com>
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

In the original S. Smalley's inode_security_struct turned into a list
(see
https://github.com/stephensmalley/selinux-kernel/commit/efb2ddadfdd0e10e75b6aa5da2ed9841df6ef2f6)

This approach has a number of problems described in the commit-message
there. Besides, it dramatically increases implementation complexity (the
height of the Tower of Babel) and the resulting code had a number of
bugs, such as memory leaks.

We decided to try a completely different approach as an experiment.

So we introduced a unique identifier into the namespace. It is a 64-bit
number which grows monotonically each time you create a new namespace.

In inode_security_structure the pointer to the selinux state is replaced
by this ID, which is needed only for comparison: we need to determine
whether some inode_security_struct belongs to "our" namespace or not.
This got rid of the pointers.

Next is the most interesting part.
Instead of making a list of inode_security_struct, we decided to keep
only one instance of this structure.
It stores information about inode security from the namespace we last
read it from.
When we want to get the SID of a structure, we first compare its
namespace id with the id of the current namespace. If they match, we
just use the stored SID. If not, we re-read the SID from the xattr of
our namespace. All this logic is implemented in the update_sid()
function and its variations. We call this mechanism "carousel switch"
and it is somewhat similar to LRU-cache.

Among other changes in this commit:

* Instead of current_creds(), we decided to use current_real_creds().
This is because the credentials of the task can be spoofed (e.g. ovl_xattr_get).
Although objective and subjective credentials have different purposes,
they are almost always the same (see task_struct->real_creds).

* We drastically changed the way xattr's suffixes are handled.
While the original patchset modified the VFS subsystem code for this
(see
https://github.com/stephensmalley/selinux-kernel/commit/cf673d0f46ae88241f49f3d193403d40405d03a9),
we decided to intercept the set() and get() handlers in
super_block->s_xattr.

* Added README.SELINUX-NAMESPACES

Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei.com>
Signed-off-by: Igor Baranov <igor.baranov@huawei.com>
---
 README.SELINUX-NAMESPACES           |  22 ++
 security/selinux/hooks.c            | 349 +++++++++++++++++++++++-----
 security/selinux/include/objsec.h   |   7 +-
 security/selinux/include/security.h |   8 +-
 security/selinux/selinuxfs.c        |  98 +++++---
 5 files changed, 388 insertions(+), 96 deletions(-)
 create mode 100644 README.SELINUX-NAMESPACES

diff --git a/README.SELINUX-NAMESPACES b/README.SELINUX-NAMESPACES
new file mode 100644
index 000000000000..401f702bb583
--- /dev/null
+++ b/README.SELINUX-NAMESPACES
@@ -0,0 +1,22 @@
+Introduction.
+This experimental patch is designed to enable namespaces mode for LSM SELinux.
+
+This work is based on Stephen Smalley's patches https://github.com/stephensmalley/selinux-kernel/tree/working-selinuxns
+Some of which have been applied here, some of which have been reworked/fixed.
+
+Usage
+# create new namespace with name "ns", unshare previous one
+echo "ns" > /sys/fs/selinux/unshare; unshare --fork -m
+
+# remount selinuxfs, load policy
+umount /sys/fs/selinux; mount -t selinuxfs none /sys/fs/selinux/; load_policy
+
+# relabel everything
+restorecon / -Rv
+
+# check xattr's
+ls -Z
+
+# now enter enforcing mode
+setenforce 1
+
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f02e31edae7c..b618c4e0ef36 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -106,6 +106,9 @@
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
+/* Sequential namespace id */
+static atomic64_t selinux_namespace_id = ATOMIC_INIT(0);
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 static int selinux_enforcing_boot __initdata;
 
@@ -279,7 +282,8 @@ static int __inode_security_revalidate(struct inode *inode,
 	might_sleep_if(may_sleep);
 
 	if (selinux_initialized(current_selinux_state) &&
-	    isec->initialized != LABEL_INITIALIZED) {
+	    (isec->initialized != LABEL_INITIALIZED ||
+	     current_selinux_state->id != isec->namespace_id)) {
 		if (!may_sleep)
 			return -ECHILD;
 
@@ -288,6 +292,7 @@ static int __inode_security_revalidate(struct inode *inode,
 		 * @opt_dentry is NULL and no dentry for this inode can be
 		 * found; in that case, continue using the old label.
 		 */
+		isec->initialized = LABEL_INVALID;
 		inode_doinit_with_dentry(inode, dentry);
 	}
 	return 0;
@@ -497,6 +502,44 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 	}
 }
 
+#define for_each_xattr_handler(handlers, handler)		\
+		for ((handler) = *(handlers)++;			\
+			(handler) != NULL;			\
+			(handler) = *(handlers)++)
+static const char *
+strcmp_prefix(const char *a, const char *a_prefix)
+{
+	while (*a_prefix && *a == *a_prefix) {
+		a++;
+		a_prefix++;
+	}
+	return *a_prefix ? NULL : a;
+}
+
+static int
+selinux_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
+		struct inode *inode, const char *name, void *value, size_t size)
+{
+	struct superblock_security_head *sbsech = selinux_head_of_superblock(inode->i_sb);
+
+	if (strcmp(name, XATTR_SELINUX_SUFFIX) == 0 && selinux_initialized(current_selinux_state))
+		name = current_selinux_state->xattr_name;
+
+	return sbsech->xattr_handler->get(sbsech->xattr_handler, unused, inode, name, value, size);
+}
+
+static int selinux_xattr_set(const struct xattr_handler *handler, struct dentry *unused,
+		struct inode *inode, const char *name, const void *value,
+		size_t size, int flags)
+{
+	struct superblock_security_head *sbsech = selinux_head_of_superblock(inode->i_sb);
+
+	if (strcmp(name, XATTR_SELINUX_SUFFIX) == 0 && selinux_initialized(current_selinux_state))
+		name = current_selinux_state->xattr_name;
+
+	return sbsech->xattr_handler->set(sbsech->xattr_handler, unused, inode, name, value, size, flags);
+}
+
 static int sb_finish_set_opts(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
@@ -505,29 +548,77 @@ static int sb_finish_set_opts(struct super_block *sb)
 	int rc = 0;
 
 	if (sbsec->behavior == SECURITY_FS_USE_XATTR) {
-		/* Make sure that the xattr handler exists and that no
-		   error other than -ENODATA is returned by getxattr on
-		   the root directory.  -ENODATA is ok, as this may be
-		   the first boot of the SELinux kernel before we have
-		   assigned xattr values to the filesystem. */
-		if (!(root_inode->i_opflags & IOP_XATTR)) {
-			pr_warn("SELinux: (dev %s, type %s) has no "
-			       "xattr support\n", sb->s_id, sb->s_type->name);
-			rc = -EOPNOTSUPP;
-			goto out;
-		}
+		struct superblock_security_head *sbsech = selinux_head_of_superblock(sb);
+
+		/* Should check xattr support only once */
+		if (!sbsech->xattr_handler) {
+			const struct xattr_handler **handlers, *handler;
+			const struct xattr_handler *sec_handler = NULL;
+			const struct xattr_handler **s_xattr;
+			size_t count = 0;
+
+			/* Make sure that the xattr handler exists and that no
+			   error other than -ENODATA is returned by getxattr on
+			   the root directory.  -ENODATA is ok, as this may be
+			   the first boot of the SELinux kernel before we have
+			   assigned xattr values to the filesystem. */
+			if (!(root_inode->i_opflags & IOP_XATTR)) {
+				pr_warn("SELinux: (dev %s, type %s) has no "
+					   "xattr support\n", sb->s_id, sb->s_type->name);
+				rc = -EOPNOTSUPP;
+				goto out;
+			}
 
-		rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
-		if (rc < 0 && rc != -ENODATA) {
-			if (rc == -EOPNOTSUPP)
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) has no security xattr handler\n",
-				       sb->s_id, sb->s_type->name);
-			else
-				pr_warn("SELinux: (dev %s, type "
-				       "%s) getxattr errno %d\n", sb->s_id,
-				       sb->s_type->name, -rc);
-			goto out;
+			rc = __vfs_getxattr(root, root_inode, XATTR_NAME_SELINUX, NULL, 0);
+			if (rc < 0 && rc != -ENODATA) {
+				if (rc == -EOPNOTSUPP)
+					pr_warn("SELinux: (dev %s, type "
+					   "%s) has no security xattr handler\n",
+						   sb->s_id, sb->s_type->name);
+				else
+					pr_warn("SELinux: (dev %s, type "
+						   "%s) getxattr errno %d\n", sb->s_id,
+						   sb->s_type->name, -rc);
+				goto out;
+			}
+
+			handlers = sb->s_xattr;
+			for_each_xattr_handler(handlers, handler) {
+				count++;
+			}
+
+			s_xattr = kzalloc((1 + count) * sizeof(struct xattr_handler *) +
+							sizeof(struct xattr_handler),
+					GFP_KERNEL);
+			memcpy(s_xattr, sb->s_xattr, count * sizeof(struct xattr_handler *));
+			handlers = s_xattr;
+			for_each_xattr_handler(handlers, handler) {
+				const char *n = strcmp_prefix(XATTR_NAME_SELINUX, xattr_prefix(handler));
+				if (n) {
+					if (!handler->prefix ^ !*n) {
+						if (*n)
+							continue;
+						break;
+					}
+					sec_handler = handler;
+					break;
+				}
+			}
+
+			if (sec_handler) {
+				struct xattr_handler *hooked_handler = (void *)(s_xattr + count + 1);
+
+				*hooked_handler = *sec_handler;
+				hooked_handler->set = selinux_xattr_set;
+				hooked_handler->get = selinux_xattr_get;
+				sbsech->xattr_handler = sec_handler;
+				sbsech->old_s_xattr = sb->s_xattr;
+				*--handlers = hooked_handler;
+				sb->s_xattr = s_xattr;
+				pr_info("SELinux: (dev %s, type %s) installed xattr hook\n", sb->s_id, sb->s_type->name);
+			} else {
+				kfree(s_xattr);
+			}
 		}
 	}
 
@@ -812,6 +903,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			goto out;
 
 		root_isec->sid = rootcontext_sid;
+		root_isec->namespace_id = current_selinux_state->id;
 		root_isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -1395,6 +1487,102 @@ static int inode_doinit_use_xattr(struct inode *inode, struct dentry *dentry,
 	return 0;
 }
 
+static int read_sid(struct inode *inode, u32 *psid)
+{
+	int rc;
+	struct superblock_security_struct *sbsec;
+	struct dentry *dentry;
+
+	sbsec = selinux_superblock(inode->i_sb);
+
+	if (sbsec->behavior == 0) {
+		*psid = SECINITSID_UNLABELED;
+		return 0;
+	}
+	if (sbsec->behavior != SECURITY_FS_USE_XATTR)
+		return -EINVAL;
+
+	dentry = d_find_alias(inode);
+
+	if (!dentry)
+		dentry = d_find_any_alias(inode);
+
+	if (!dentry)
+		return -EINVAL;
+
+	rc = inode_doinit_use_xattr(inode, dentry, sbsec->def_sid, psid);
+
+	dput(dentry);
+	return rc;
+}
+
+static void update_sid_and_lock(struct inode_security_struct *isec)
+{
+	u32 sid;
+	u64 nsid, cnsid = current_selinux_state->id;
+
+//	TODO: atomic???
+	spin_lock(&isec->lock);
+	nsid = isec->namespace_id;
+	sid = isec->sid;
+	if (nsid != cnsid) {
+		spin_unlock(&isec->lock);
+		if (read_sid(isec->inode, &sid) == 0) {
+			spin_lock(&isec->lock);
+			isec->namespace_id = cnsid;
+			isec->sid = sid;
+		}
+	}
+}
+static u32 update_sid(struct inode_security_struct *isec)
+{
+	u32 sid;
+	u64 nsid, cnsid = current_selinux_state->id;
+
+//	TODO: atomic???
+	spin_lock(&isec->lock);
+	nsid = isec->namespace_id;
+	sid = isec->sid;
+	spin_unlock(&isec->lock);
+	if (nsid != cnsid) {
+		if (read_sid(isec->inode, &sid) == 0) {
+			spin_lock(&isec->lock);
+			isec->namespace_id = cnsid;
+			isec->sid = sid;
+			spin_unlock(&isec->lock);
+		}
+	}
+	return sid;
+}
+
+static int update_sid_rcu(struct inode_security_struct *isec, u32 *psid, bool rcu)
+{
+	u64 nsid, cnsid = current_selinux_state->id;
+
+//	TODO: atomic???
+	spin_lock(&isec->lock);
+	nsid = isec->namespace_id;
+	*psid = isec->sid;
+	spin_unlock(&isec->lock);
+	if (nsid != cnsid) {
+		int err;
+
+		if (rcu)
+			return -ECHILD;
+
+		err = read_sid(isec->inode, psid);
+		if (err == 0) {
+			spin_lock(&isec->lock);
+			isec->namespace_id = cnsid;
+			isec->sid = *psid;
+			spin_unlock(&isec->lock);
+		} else {
+			return err;
+		}
+	}
+	return 0;
+}
+
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
@@ -1555,6 +1743,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 
 		isec->initialized = LABEL_INITIALIZED;
 		isec->sid = sid;
+		isec->namespace_id = current_selinux_state->id;
 	}
 
 out_unlock:
@@ -1651,7 +1840,7 @@ static int inode_has_perm(const struct cred *cred,
 	isec = selinux_inode(inode);
 
 	return avc_has_perm(cred_selinux_state(cred),
-			    sid, isec->sid, isec->sclass, perms, adp);
+			    sid, update_sid(isec), isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1781,7 +1970,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct task_security_struct *tsec = selinux_cred(current_real_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1844,7 +2033,7 @@ static int may_link(struct inode *dir,
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
 	rc = avc_has_perm(current_selinux_state,
-			  sid, dsec->sid, SECCLASS_DIR, av, &ad);
+			  sid, update_sid(dsec), SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1865,7 +2054,7 @@ static int may_link(struct inode *dir,
 	}
 
 	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid, isec->sclass, av, &ad);
+			  sid, update_sid(isec), isec->sclass, av, &ad);
 	return rc;
 }
 
@@ -1890,18 +2079,18 @@ static inline int may_rename(struct inode *old_dir,
 
 	ad.u.dentry = old_dentry;
 	rc = avc_has_perm(current_selinux_state,
-			  sid, old_dsec->sid, SECCLASS_DIR,
+			  sid, update_sid(old_dsec), SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
 	rc = avc_has_perm(current_selinux_state,
-			  sid, old_isec->sid,
+			  sid, update_sid(old_isec),
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
 		rc = avc_has_perm(current_selinux_state,
-				  sid, old_isec->sid,
+				  sid, update_sid(old_isec),
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
@@ -1912,14 +2101,14 @@ static inline int may_rename(struct inode *old_dir,
 	if (d_is_positive(new_dentry))
 		av |= DIR__REMOVE_NAME;
 	rc = avc_has_perm(current_selinux_state,
-			  sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
+			  sid, update_sid(new_dsec), SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
 		new_isec = backing_inode_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
 		rc = avc_has_perm(current_selinux_state,
-				  sid, new_isec->sid,
+				  sid, update_sid(new_isec),
 				  new_isec->sclass,
 				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
 		if (rc)
@@ -2089,7 +2278,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 
 	isec = backing_inode_security(dentry);
 	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, isec->sclass, file_to_av(file),
+			    sid, update_sid(isec), isec->sclass, file_to_av(file),
 			    &ad);
 }
 
@@ -2340,7 +2529,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 	} else {
 		/* Check for a default transition on this program. */
 		rc = security_transition_sid(current_selinux_state, old_tsec->sid,
-					     isec->sid, SECCLASS_PROCESS, NULL,
+					     update_sid(isec), SECCLASS_PROCESS, NULL,
 					     &new_tsec->sid);
 		if (rc)
 			return rc;
@@ -2359,7 +2548,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 
 	if (new_tsec->sid == old_tsec->sid) {
 		rc = avc_has_perm(current_selinux_state,
-				  old_tsec->sid, isec->sid,
+				  old_tsec->sid, update_sid(isec),
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
@@ -2372,7 +2561,7 @@ static int selinux_bprm_creds_for_exec(struct linux_binprm *bprm)
 			return rc;
 
 		rc = avc_has_perm(current_selinux_state,
-				  new_tsec->sid, isec->sid,
+				  new_tsec->sid, update_sid(isec),
 				  SECCLASS_FILE, FILE__ENTRYPOINT, &ad);
 		if (rc)
 			return rc;
@@ -2570,6 +2759,8 @@ static void sbsec_head_init(struct super_block *sb,
 {
 	INIT_LIST_HEAD(&sbsech->head);
 	spin_lock_init(&sbsech->lock);
+	sbsech->xattr_handler = NULL;
+	sbsech->old_s_xattr = NULL;
 }
 
 static struct superblock_security_struct *
@@ -2651,6 +2842,12 @@ static void selinux_sb_free_security(struct super_block *sb)
 		put_selinux_state(entry->state);
 		kfree(entry);
 	}
+	if (sbsech->old_s_xattr) {
+		const struct xattr_handler **s_xattr = sb->s_xattr;
+
+		sb->s_xattr = sbsech->old_s_xattr;
+		kfree(s_xattr);
+	}
 }
 
 static inline int opt_len(const char *s)
@@ -2910,6 +3107,7 @@ static int selinux_inode_alloc_security(struct inode *inode)
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
 	isec->initialized = LABEL_INVALID;
+	isec->namespace_id = current_selinux_state->id;
 
 	return 0;
 }
@@ -2984,6 +3182,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		struct inode_security_struct *isec = selinux_inode(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
+		isec->namespace_id = current_selinux_state->id;
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
@@ -3060,7 +3259,8 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	const struct cred *cred = current_cred();
 	struct common_audit_data ad;
 	struct inode_security_struct *isec;
-	u32 sid;
+	u32 sid, isid;
+	int rc;
 
 	validate_creds(cred);
 
@@ -3071,8 +3271,12 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
+	rc = update_sid_rcu(isec, &isid, rcu);
+	if (rc != 0)
+		return rc;
+
 	return avc_has_perm_flags(cred_selinux_state(cred),
-				  sid, isec->sid, isec->sclass, FILE__READ, &ad,
+				  sid, isid, isec->sclass, FILE__READ, &ad,
 				  rcu ? MAY_NOT_BLOCK : 0);
 }
 
@@ -3088,7 +3292,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 	ad.u.inode = inode;
 
 	rc = slow_avc_audit(current_selinux_state,
-			    current_sid(), isec->sid, isec->sclass, perms,
+			    current_sid(), update_sid(isec), isec->sclass, perms,
 			    audited, denied, result, &ad);
 	if (rc)
 		return rc;
@@ -3102,7 +3306,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	bool from_access;
 	bool no_block = mask & MAY_NOT_BLOCK;
 	struct inode_security_struct *isec;
-	u32 sid;
+	u32 sid, isid;
 	struct av_decision avd;
 	int rc, rc2;
 	u32 audited, denied;
@@ -3126,8 +3330,12 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	if (IS_ERR(isec))
 		return PTR_ERR(isec);
 
+	rc = update_sid_rcu(isec, &isid, no_block);
+	if (rc != 0)
+		return rc;
+
 	rc = avc_has_perm_noaudit(cred_selinux_state(cred),
-				  sid, isec->sid, isec->sclass, perms,
+				  sid, isid, isec->sclass, perms,
 				  no_block ? AVC_NONBLOCKING : 0,
 				  &avd);
 	audited = avc_audit_required(perms, &avd, rc,
@@ -3198,7 +3406,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
-	u32 newsid, sid = current_sid();
+	u32 newsid, backsid, sid = current_sid();
 	int rc = 0;
 
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
@@ -3225,8 +3433,9 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	ad.u.dentry = dentry;
 
 	isec = backing_inode_security(dentry);
+	backsid = update_sid(isec);
 	rc = avc_has_perm(current_selinux_state,
-			  sid, isec->sid, isec->sclass,
+			  sid, backsid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
@@ -3270,7 +3479,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(current_selinux_state, isec->sid, newsid,
+	rc = security_validate_transition(current_selinux_state, backsid, newsid,
 					  sid, isec->sclass);
 	if (rc)
 		return rc;
@@ -3319,6 +3528,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 
@@ -3432,13 +3642,14 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 	 * and lack of permission just means that we fall back to the
 	 * in-core context value, not a denial.
 	 */
+	//TODO: optimize sequence. need to read xattr only once
 	isec = inode_security(inode);
 	if (has_cap_mac_admin(false))
 		error = security_sid_to_context_force(current_selinux_state,
-						      isec->sid, &context,
+						      update_sid(isec), &context,
 						      &size);
 	else
-		error = security_sid_to_context(current_selinux_state, isec->sid,
+		error = security_sid_to_context(current_selinux_state, update_sid(isec),
 						&context, &size);
 	if (error)
 		return error;
@@ -3478,6 +3689,7 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 	return 0;
@@ -3494,7 +3706,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
 static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
 {
 	struct inode_security_struct *isec = inode_security_novalidate(inode);
-	*secid = isec->sid;
+	*secid = update_sid(isec);
 }
 
 static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
@@ -3620,7 +3832,7 @@ static int selinux_file_permission(struct file *file, int mask)
 		return 0;
 
 	isec = inode_security(inode);
-	if (sid == fsec->sid && fsec->isid == isec->sid &&
+	if (sid == fsec->sid && fsec->isid == update_sid(isec) &&
 	    fsec->pseqno == avc_policy_seqno(current_selinux_state))
 		/* No change since file_open check. */
 		return 0;
@@ -3676,7 +3888,7 @@ static int ioctl_has_perm(const struct cred *cred, struct file *file,
 
 	isec = inode_security(inode);
 	rc = avc_has_extended_perms(current_selinux_state,
-				    ssid, isec->sid, isec->sclass,
+				    ssid, update_sid(isec), isec->sclass,
 				    requested, driver, xperm, &ad);
 out:
 	return rc;
@@ -3947,6 +4159,7 @@ static int selinux_file_open(struct file *file)
 	 * Task label is already saved in the file security
 	 * struct as its SID.
 	 */
+	//TODO: namespace?
 	fsec->isid = isec->sid;
 	fsec->pseqno = avc_policy_seqno(current_selinux_state);
 	/*
@@ -4046,21 +4259,23 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
  * set the file creation context in a security record to the same as the
  * objective context of the specified inode
  */
+//TODO: namespace?
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
 	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
+	u32 isid = update_sid(isec);
 	int ret;
 
 	ret = avc_has_perm(tsec->state,
-			   sid, isec->sid,
+			   sid, isid,
 			   SECCLASS_KERNEL_SERVICE,
 			   KERNEL_SERVICE__CREATE_FILES_AS,
 			   NULL);
 
 	if (ret == 0)
-		tsec->create_sid = isec->sid;
+		tsec->create_sid = isid;
 	return ret;
 }
 
@@ -4105,7 +4320,7 @@ static int selinux_kernel_module_from_file(struct file *file)
 
 	isec = inode_security(file_inode(file));
 	return avc_has_perm(current_selinux_state,
-			    sid, isec->sid, SECCLASS_SYSTEM,
+			    sid, update_sid(isec), SECCLASS_SYSTEM,
 				SYSTEM__MODULE_LOAD, &ad);
 }
 
@@ -4267,6 +4482,7 @@ static void selinux_task_to_inode(struct task_struct *p,
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = sid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 	spin_unlock(&isec->lock);
 }
@@ -4633,6 +4849,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 
 	isec->sclass = sclass;
 	isec->sid = sid;
+	isec->namespace_id = current_selinux_state->id;
 	isec->initialized = LABEL_INITIALIZED;
 
 	if (sock->sk) {
@@ -4921,7 +5138,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 		return err;
 
 	isec = inode_security_novalidate(SOCK_INODE(sock));
-	spin_lock(&isec->lock);
+	update_sid_and_lock(isec);
 	sclass = isec->sclass;
 	sid = isec->sid;
 	spin_unlock(&isec->lock);
@@ -4929,6 +5146,7 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	newisec = inode_security_novalidate(SOCK_INODE(newsock));
 	newisec->sclass = sclass;
 	newisec->sid = sid;
+	newisec->namespace_id = current_selinux_state->id;
 	newisec->initialized = LABEL_INITIALIZED;
 
 	return 0;
@@ -5213,7 +5431,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 	if (sock && family == PF_UNIX) {
 		isec = inode_security_novalidate(SOCK_INODE(sock));
-		peer_secid = isec->sid;
+		peer_secid = update_sid(isec);
 	} else if (skb)
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
@@ -5280,8 +5498,11 @@ static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 	struct sk_security_struct *sksec = sk->sk_security;
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
-	    sk->sk_family == PF_UNIX)
+	    sk->sk_family == PF_UNIX) {
 		isec->sid = sksec->sid;
+		//TODO: namespace?
+		//isec->namespace_id = ?
+	}
 	sksec->sclass = isec->sclass;
 }
 
@@ -7331,7 +7552,13 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
-int selinux_state_create(struct selinux_state *parent, struct selinux_state **state)
+u64 selinux_new_state_id(void)
+{
+	return atomic64_fetch_add(1, &selinux_namespace_id);
+}
+
+int selinux_state_create(struct selinux_state *parent, struct selinux_state **state,
+						const char *suffix)
 {
 	struct selinux_state *newstate;
 	int rc;
@@ -7340,6 +7567,7 @@ int selinux_state_create(struct selinux_state *parent, struct selinux_state **st
 	if (!newstate)
 		return -ENOMEM;
 
+	newstate->id = selinux_new_state_id();
 	refcount_set(&newstate->count, 1);
 	INIT_WORK(&newstate->work, selinux_state_free);
 
@@ -7352,7 +7580,12 @@ int selinux_state_create(struct selinux_state *parent, struct selinux_state **st
 
 	if (parent)
 		newstate->parent = get_selinux_state(parent);
-
+	strcpy(newstate->xattr_name, XATTR_SELINUX_SUFFIX);
+	rc = strlen(suffix);
+	if (rc) {
+		strcat(newstate->xattr_name, ".");
+		strncat(newstate->xattr_name, suffix, rc);
+	}
 	*state = newstate;
 	return 0;
 err:
@@ -7385,7 +7618,7 @@ static __init int selinux_init(void)
 {
 	pr_info("SELinux:  Initializing.\n");
 
-	if (selinux_state_create(NULL, &init_selinux_state))
+	if (selinux_state_create(NULL, &init_selinux_state, ""))
 		panic("SELinux: Could not create initial namespace\n");
 	enforcing_set(init_selinux_state, selinux_enforcing_boot);
 	init_selinux_state->checkreqprot = selinux_checkreqprot_boot;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 6ad1db45b0d9..21566a1541f4 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -42,8 +42,10 @@ struct inode_security_struct {
 	u16 sclass;		/* security class of this object */
 	unsigned char initialized;	/* initialization flag */
 	spinlock_t lock;
+	u64 namespace_id;	/* pointer to selinux_state */
 };
 
+//TODO: namespace?
 struct file_security_struct {
 	u32 sid;		/* SID of open file description */
 	u32 fown_sid;		/* SID of file owner (for SIGIO) */
@@ -54,6 +56,9 @@ struct file_security_struct {
 struct superblock_security_head {
 	struct list_head head;		/* list head of superblock_security_struct */
 	spinlock_t lock;
+
+	const struct xattr_handler **old_s_xattr;
+	const struct xattr_handler *xattr_handler;
 };
 
 struct superblock_security_struct {
@@ -178,7 +183,7 @@ static inline struct ipc_security_struct *selinux_ipc(
  */
 static inline u32 current_sid(void)
 {
-	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	const struct task_security_struct *tsec = selinux_cred(current_real_cred());
 
 	return tsec->sid;
 }
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index a5b698aae38c..0ab6b433dc9c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,9 +111,13 @@ struct selinux_state {
 	struct selinux_policy __rcu *policy;
 	struct mutex policy_mutex;
 	struct selinux_state *parent;
+	u64 id;
+	char xattr_name[XATTR_NAME_MAX];
 } __randomize_layout;
 
-int selinux_state_create(struct selinux_state *parent, struct selinux_state **state);
+u64 selinux_new_state_id(void);
+int selinux_state_create(struct selinux_state *parent, struct selinux_state **state,
+						const char *suffix);
 void __put_selinux_state(struct selinux_state *state);
 
 void selinux_policy_free(struct selinux_policy *policy);
@@ -151,7 +155,7 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 	return cred->security + selinux_blob_sizes.lbs_cred;
 }
 
-#define current_selinux_state (selinux_cred(current_cred())->state)
+#define current_selinux_state (selinux_cred(current_real_cred())->state)
 
 #define cred_selinux_state(cred) (selinux_cred(cred)->state)
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9892527f2269..2da27f2fc2e3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -31,6 +31,7 @@
 #include <linux/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/ctype.h>
+#include <linux/xattr.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -347,10 +348,10 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 {
 	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
 	struct selinux_state *state = fsi->state;
-	char *page;
-	ssize_t length;
-	bool set;
-	int rc;
+	struct cred *cred;
+	struct task_security_struct *tsec;
+	char *suffix, *p;
+	ssize_t len;
 
 	if (state != current_selinux_state)
 		return -EPERM;
@@ -362,49 +363,76 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 	if (*ppos != 0)
 		return -EINVAL;
 
-	rc = avc_has_perm(current_selinux_state, current_sid(),
+	len = avc_has_perm(current_selinux_state, current_sid(),
 			  SECINITSID_SECURITY, SECCLASS_SECURITY,
 			  SECURITY__UNSHARE, NULL);
-	if (rc)
-		return rc;
+	if (len)
+		return len;
 
-	page = memdup_user_nul(buf, count);
-	if (IS_ERR(page))
-		return PTR_ERR(page);
+	if (count > XATTR_NAME_MAX - sizeof(XATTR_NAME_SELINUX) - 2)
+		return -EINVAL;
 
-	length = -EINVAL;
-	if (kstrtobool(page, &set))
-		goto out;
+	suffix = memdup_user_nul(buf, count);
+	if (IS_ERR(suffix))
+		return PTR_ERR(suffix);
 
-	if (set) {
-		struct cred *cred = prepare_creds();
-		struct task_security_struct *tsec;
+	len = strnlen(suffix, count);
 
-		if (!cred) {
-			length = -ENOMEM;
-			goto out;
-		}
-		tsec = selinux_cred(cred);
-		if (selinux_state_create(state, &tsec->state)) {
-			abort_creds(cred);
-			length = -ENOMEM;
-			goto out;
-		}
-		tsec->osid = tsec->sid = SECINITSID_KERNEL;
-		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
-			tsec->sockcreate_sid = SECSID_NULL;
-		tsec->parent_cred = get_current_cred();
-		commit_creds(cred);
+	/* cleanup some trash at the end of string */
+	for (p = suffix + len - 1; p >= suffix && isspace(*p); p--)
+		*p = 0;
+
+	len = p - suffix + 1;
+
+
+	/* TODO: check for uniqueness! */
+/*
+	if (!strcmp("", suffix)) {
+		len = -EINVAL;
+		goto out;
 	}
+*/
+
+	cred = prepare_creds();
+	if (!cred) {
+		len = -ENOMEM;
+		goto out;
+	}
+	tsec = cred->security;
+	if (selinux_state_create(state, &tsec->state, suffix)) {
+		abort_creds(cred);
+		len = -ENOMEM;
+		goto out;
+	}
+
+	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
+		tsec->sockcreate_sid = SECSID_NULL;
+	tsec->parent_cred = get_current_cred();
+	commit_creds(cred);
 
-	length = count;
 out:
-	kfree(page);
-	return length;
+	kfree(suffix);
+	return len < 0 ? len : count;
+}
+
+static ssize_t sel_read_unshare(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	size_t slen = sizeof(XATTR_SELINUX_SUFFIX);
+
+	if (state->id != current_selinux_state->id)
+		return -EPERM;
+
+	return simple_read_from_buffer(buf, count, ppos, state->xattr_name + slen,
+									strlen(state->xattr_name + slen));
 }
 
 static const struct file_operations sel_unshare_ops = {
 	.write		= sel_write_unshare,
+	.read		= sel_read_unshare,
 	.llseek		= generic_file_llseek,
 };
 
@@ -2174,7 +2202,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		/* last one */ {""}
 	};
 
-- 
2.34.1

