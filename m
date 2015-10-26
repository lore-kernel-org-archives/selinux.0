Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFZXX009657
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:41 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 2/7] selinux: Add accessor functions for inode->i_security
Date: Mon, 26 Oct 2015 22:15:23 +0100
Message-Id: <1445894128-6765-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add functions dentry_security and inode_security for accessing
inode->i_security.  These functions initially don't do much, but they
will later be used to revalidate the security labels when necessary.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 101 ++++++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 44 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc8f626..65e8689 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -241,6 +241,24 @@ static int inode_alloc_security(struct inode *inode)
 	return 0;
 }
 
+/*
+ * Get the security label of a dentry's inode.
+ */
+static struct inode_security_struct *dentry_security(struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	return inode->i_security;
+}
+
+/*
+ * Get the security label of an inode.
+ */
+static struct inode_security_struct *inode_security(struct inode *inode)
+{
+	return inode->i_security;
+}
+
 static void inode_free_rcu(struct rcu_head *head)
 {
 	struct inode_security_struct *isec;
@@ -564,8 +582,8 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 		opts->mnt_opts_flags[i++] = DEFCONTEXT_MNT;
 	}
 	if (sbsec->flags & ROOTCONTEXT_MNT) {
-		struct inode *root = d_backing_inode(sbsec->sb->s_root);
-		struct inode_security_struct *isec = root->i_security;
+		struct dentry *root = sbsec->sb->s_root;
+		struct inode_security_struct *isec = dentry_security(root);
 
 		rc = security_sid_to_context(isec->sid, &context, &len);
 		if (rc)
@@ -620,8 +638,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	int rc = 0, i;
 	struct superblock_security_struct *sbsec = sb->s_security;
 	const char *name = sb->s_type->name;
-	struct inode *inode = d_backing_inode(sbsec->sb->s_root);
-	struct inode_security_struct *root_isec = inode->i_security;
+	struct dentry *root = sbsec->sb->s_root;
+	struct inode_security_struct *root_isec = dentry_security(root);
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
 	char **mount_options = opts->mnt_opts;
@@ -852,8 +870,8 @@ static int selinux_cmp_sb_context(const struct super_block *oldsb,
 	if ((oldflags & DEFCONTEXT_MNT) && old->def_sid != new->def_sid)
 		goto mismatch;
 	if (oldflags & ROOTCONTEXT_MNT) {
-		struct inode_security_struct *oldroot = d_backing_inode(oldsb->s_root)->i_security;
-		struct inode_security_struct *newroot = d_backing_inode(newsb->s_root)->i_security;
+		struct inode_security_struct *oldroot = dentry_security(oldsb->s_root);
+		struct inode_security_struct *newroot = dentry_security(newsb->s_root);
 		if (oldroot->sid != newroot->sid)
 			goto mismatch;
 	}
@@ -903,17 +921,14 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 		if (!set_fscontext)
 			newsbsec->sid = sid;
 		if (!set_rootcontext) {
-			struct inode *newinode = d_backing_inode(newsb->s_root);
-			struct inode_security_struct *newisec = newinode->i_security;
+			struct inode_security_struct *newisec = dentry_security(newsb->s_root);
 			newisec->sid = sid;
 		}
 		newsbsec->mntpoint_sid = sid;
 	}
 	if (set_rootcontext) {
-		const struct inode *oldinode = d_backing_inode(oldsb->s_root);
-		const struct inode_security_struct *oldisec = oldinode->i_security;
-		struct inode *newinode = d_backing_inode(newsb->s_root);
-		struct inode_security_struct *newisec = newinode->i_security;
+		const struct inode_security_struct *oldisec = dentry_security(oldsb->s_root);
+		struct inode_security_struct *newisec = dentry_security(newsb->s_root);
 
 		newisec->sid = oldisec->sid;
 	}
@@ -1623,7 +1638,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = inode_security(inode);
 
 	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
 }
@@ -1712,13 +1727,13 @@ out:
 /*
  * Determine the label for an inode that might be unioned.
  */
-static int selinux_determine_inode_label(const struct inode *dir,
+static int selinux_determine_inode_label(struct inode *dir,
 					 const struct qstr *name,
 					 u16 tclass,
 					 u32 *_new_isid)
 {
 	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
-	const struct inode_security_struct *dsec = dir->i_security;
+	const struct inode_security_struct *dsec = inode_security(dir);
 	const struct task_security_struct *tsec = current_security();
 
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
@@ -1747,7 +1762,7 @@ static int may_create(struct inode *dir,
 	struct common_audit_data ad;
 	int rc;
 
-	dsec = dir->i_security;
+	dsec = inode_security(dir);
 	sbsec = dir->i_sb->s_security;
 
 	sid = tsec->sid;
@@ -1800,8 +1815,8 @@ static int may_link(struct inode *dir,
 	u32 av;
 	int rc;
 
-	dsec = dir->i_security;
-	isec = d_backing_inode(dentry)->i_security;
+	dsec = inode_security(dir);
+	isec = dentry_security(dentry);
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
@@ -1844,10 +1859,10 @@ static inline int may_rename(struct inode *old_dir,
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	old_dsec = old_dir->i_security;
-	old_isec = d_backing_inode(old_dentry)->i_security;
+	old_dsec = inode_security(old_dir);
+	old_isec = dentry_security(old_dentry);
 	old_is_dir = d_is_dir(old_dentry);
-	new_dsec = new_dir->i_security;
+	new_dsec = inode_security(new_dir);
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 
@@ -1875,7 +1890,7 @@ static inline int may_rename(struct inode *old_dir,
 	if (rc)
 		return rc;
 	if (d_is_positive(new_dentry)) {
-		new_isec = d_backing_inode(new_dentry)->i_security;
+		new_isec = dentry_security(new_dentry);
 		new_is_dir = d_is_dir(new_dentry);
 		rc = avc_has_perm(sid, new_isec->sid,
 				  new_isec->sclass,
@@ -2011,8 +2026,8 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 {
 	u32 sid = task_sid(to);
 	struct file_security_struct *fsec = file->f_security;
-	struct inode *inode = d_backing_inode(file->f_path.dentry);
-	struct inode_security_struct *isec = inode->i_security;
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode_security_struct *isec = dentry_security(dentry);
 	struct common_audit_data ad;
 	int rc;
 
@@ -2028,7 +2043,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 			return rc;
 	}
 
-	if (unlikely(IS_PRIVATE(inode)))
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 
 	return avc_has_perm(sid, isec->sid, isec->sclass, file_to_av(file),
@@ -2207,7 +2222,6 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	struct task_security_struct *new_tsec;
 	struct inode_security_struct *isec;
 	struct common_audit_data ad;
-	struct inode *inode = file_inode(bprm->file);
 	int rc;
 
 	/* SELinux context only depends on initial program or script and not
@@ -2217,7 +2231,7 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 
 	old_tsec = current_security();
 	new_tsec = bprm->cred->security;
-	isec = inode->i_security;
+	isec = dentry_security(bprm->file->f_path.dentry);
 
 	/* Default to the current task SID. */
 	new_tsec->sid = old_tsec->sid;
@@ -2642,7 +2656,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 			break;
 		case ROOTCONTEXT_MNT: {
 			struct inode_security_struct *root_isec;
-			root_isec = d_backing_inode(sb->s_root)->i_security;
+			root_isec = dentry_security(sb->s_root);
 
 			if (bad_option(sbsec, ROOTCONTEXT_MNT, root_isec->sid, sid))
 				goto out_bad_option;
@@ -2859,7 +2873,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = inode_security(inode);
 
 	return avc_has_perm_flags(sid, isec->sid, isec->sclass, FILE__READ, &ad,
 				  rcu ? MAY_NOT_BLOCK : 0);
@@ -2911,7 +2925,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = inode_security(inode);
 
 	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
@@ -2980,7 +2994,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = dentry_security(dentry);
 	struct superblock_security_struct *sbsec;
 	struct common_audit_data ad;
 	u32 newsid, sid = current_sid();
@@ -3057,7 +3071,7 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, const char *name,
 					int flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = dentry_security(dentry);
 	u32 newsid;
 	int rc;
 
@@ -3154,7 +3168,7 @@ out_nofree:
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 				     const void *value, size_t size, int flags)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode_security(inode);
 	u32 newsid;
 	int rc;
 
@@ -3205,9 +3219,8 @@ static int selinux_revalidate_file_permission(struct file *file, int mask)
 
 static int selinux_file_permission(struct file *file, int mask)
 {
-	struct inode *inode = file_inode(file);
 	struct file_security_struct *fsec = file->f_security;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = dentry_security(file->f_path.dentry);
 	u32 sid = current_sid();
 
 	if (!mask)
@@ -3241,8 +3254,8 @@ int ioctl_has_perm(const struct cred *cred, struct file *file,
 {
 	struct common_audit_data ad;
 	struct file_security_struct *fsec = file->f_security;
-	struct inode *inode = file_inode(file);
-	struct inode_security_struct *isec = inode->i_security;
+	struct dentry *dentry = file->f_path.dentry;
+	struct inode_security_struct *isec = dentry_security(dentry);
 	struct lsm_ioctlop_audit ioctl;
 	u32 ssid = cred_sid(cred);
 	int rc;
@@ -3263,7 +3276,7 @@ int ioctl_has_perm(const struct cred *cred, struct file *file,
 			goto out;
 	}
 
-	if (unlikely(IS_PRIVATE(inode)))
+	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
 
 	rc = avc_has_extended_perms(ssid, isec->sid, isec->sclass,
@@ -3506,7 +3519,7 @@ static int selinux_file_open(struct file *file, const struct cred *cred)
 	struct inode_security_struct *isec;
 
 	fsec = file->f_security;
-	isec = file_inode(file)->i_security;
+	isec = dentry_security(file->f_path.dentry);
 	/*
 	 * Save inode label and policy sequence number
 	 * at open-time so that selinux_file_permission
@@ -3624,7 +3637,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
  */
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode_security(inode);
 	struct task_security_struct *tsec = new->security;
 	u32 sid = current_sid();
 	int ret;
@@ -4065,7 +4078,7 @@ static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
 	const struct task_security_struct *tsec = current_security();
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	struct inode_security_struct *isec = inode_security(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	int err = 0;
 
@@ -4265,9 +4278,9 @@ static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 	if (err)
 		return err;
 
-	newisec = SOCK_INODE(newsock)->i_security;
+	newisec = inode_security(SOCK_INODE(newsock));
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = inode_security(SOCK_INODE(sock));
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 	newisec->initialized = 1;
@@ -4605,7 +4618,7 @@ static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
 
 static void selinux_sock_graft(struct sock *sk, struct socket *parent)
 {
-	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
+	struct inode_security_struct *isec = inode_security(SOCK_INODE(parent));
 	struct sk_security_struct *sksec = sk->sk_security;
 
 	if (sk->sk_family == PF_INET || sk->sk_family == PF_INET6 ||
-- 
2.5.0
