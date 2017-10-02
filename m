From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:23 -0400
Message-Id: <20171002155825.28620-9-sds@tycho.nsa.gov>
In-Reply-To: <20171002155825.28620-1-sds@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 08/10] selinux: support per-namespace superblock security
 structures
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

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
---
 security/selinux/hooks.c            | 109 ++++++++++++++++++++++++++++--------
 security/selinux/include/objsec.h   |   5 +-
 security/selinux/include/security.h |   3 +-
 security/selinux/ss/services.c      |  19 ++++---
 4 files changed, 102 insertions(+), 34 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8a52e71..3daad14 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -478,33 +478,90 @@ static void file_free_security(struct file *file)
 	kmem_cache_free(file_security_cache, fsec);
 }
 
-static int superblock_alloc_security(struct super_block *sb)
+static struct superblock_security_struct *sbsec_alloc(
+	const struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec;
 
-	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
+	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_NOFS);
 	if (!sbsec)
-		return -ENOMEM;
+		return NULL;
 
 	mutex_init(&sbsec->lock);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
-	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
 	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
-	sb->s_security = sbsec;
+	sbsec->sb = sb;
+	sbsec->ns = get_selinux_ns(current_selinux_ns);
+	INIT_LIST_HEAD(&sbsec->sbsec_list);
+	return sbsec;
+}
+
+static int superblock_alloc_security(struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = sbsec_alloc(sb);
+
+	if (!sbsec)
+		return -ENOMEM;
 
+	sb->s_security = sbsec;
 	return 0;
 }
 
 static void superblock_free_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = sb->s_security, *entry, *tmp;
 	sb->s_security = NULL;
+	put_selinux_ns(sbsec->ns);
+	list_for_each_entry_safe(entry, tmp, &sbsec->sbsec_list, sbsec_list) {
+		put_selinux_ns(entry->ns);
+		kfree(entry);
+	}
 	kfree(sbsec);
 }
 
+static struct superblock_security_struct *superblock_security(
+	const struct super_block *sb)
+{
+	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *cur, *new;
+
+	if (sbsec->ns == current_selinux_ns)
+		return sbsec;
+
+	spin_lock(&sbsec->sbsec_list_lock);
+
+	list_for_each_entry(cur, &sbsec->sbsec_list, sbsec_list) {
+		if (cur->ns == current_selinux_ns)
+			goto out;
+	}
+
+	spin_unlock(&sbsec->sbsec_list_lock);
+
+	new = sbsec_alloc(sb);
+	if (!new) {
+		cur = NULL;
+		goto out;
+	}
+
+	spin_lock(&sbsec->sbsec_list_lock);
+
+	list_for_each_entry(cur, &sbsec->sbsec_list, sbsec_list) {
+		if (cur->ns == current_selinux_ns) {
+			kfree(new);
+			goto out;
+		}
+	}
+
+	list_add(&new->sbsec_list, &sbsec->sbsec_list);
+	cur = new;
+out:
+	spin_unlock(&sbsec->sbsec_list_lock);
+	return cur;
+}
+
 static inline int inode_doinit(struct inode *inode)
 {
 	return inode_doinit_with_dentry(inode, NULL, find_isec(inode, true));
@@ -572,7 +629,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 
 static int selinux_is_sblabel_mnt(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = superblock_security(sb);
 
 	return sbsec->behavior == SECURITY_FS_USE_XATTR ||
 		sbsec->behavior == SECURITY_FS_USE_TRANS ||
@@ -591,7 +648,7 @@ static int selinux_is_sblabel_mnt(struct super_block *sb)
 
 static int sb_finish_set_opts(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = superblock_security(sb);
 	struct dentry *root = sb->s_root;
 	struct inode *root_inode = d_backing_inode(root);
 	int rc = 0;
@@ -675,7 +732,7 @@ static int selinux_get_mnt_opts(const struct super_block *sb,
 				struct security_mnt_opts *opts)
 {
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = superblock_security(sb);
 	char *context = NULL;
 	u32 len;
 	char tmp;
@@ -796,7 +853,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 {
 	const struct cred *cred = current_cred();
 	int rc = 0, i;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = superblock_security(sb);
 	const char *name = sb->s_type->name;
 	struct dentry *root = sbsec->sb->s_root;
 	struct inode_security_struct *root_isec;
@@ -932,7 +989,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 		 * Determine the labeling behavior to use for this
 		 * filesystem type.
 		 */
-		rc = security_fs_use(current_selinux_ns, sb);
+		rc = security_fs_use(current_selinux_ns, sb->s_type->name,
+				     &sbsec->behavior, &sbsec->sid);
 		if (rc) {
 			printk(KERN_WARNING
 				"%s: security_fs_use(%s) returned %d\n",
@@ -1051,8 +1109,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 static int selinux_cmp_sb_context(const struct super_block *oldsb,
 				    const struct super_block *newsb)
 {
-	struct superblock_security_struct *old = oldsb->s_security;
-	struct superblock_security_struct *new = newsb->s_security;
+	struct superblock_security_struct *old = superblock_security(oldsb);
+	struct superblock_security_struct *new = superblock_security(newsb);
 	char oldflags = old->flags & SE_MNTMASK;
 	char newflags = new->flags & SE_MNTMASK;
 
@@ -1084,8 +1142,10 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 					unsigned long *set_kern_flags)
 {
 	int rc = 0;
-	const struct superblock_security_struct *oldsbsec = oldsb->s_security;
-	struct superblock_security_struct *newsbsec = newsb->s_security;
+	const struct superblock_security_struct *oldsbsec =
+		superblock_security(oldsb);
+	struct superblock_security_struct *newsbsec =
+		superblock_security(newsb);
 
 	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
 	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
@@ -1122,7 +1182,8 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 	if (newsbsec->behavior == SECURITY_FS_USE_NATIVE &&
 		!(kern_flags & SECURITY_LSM_NATIVE_LABELS) && !set_context) {
-		rc = security_fs_use(current_selinux_ns, newsb);
+		rc = security_fs_use(current_selinux_ns, newsb->s_type->name,
+				     &newsbsec->behavior, &newsbsec->sid);
 		if (rc)
 			goto out;
 	}
@@ -1603,6 +1664,8 @@ static int inode_doinit_with_dentry(struct inode *inode,
 	if (isec->initialized == LABEL_INITIALIZED)
 		return 0;
 
+	sbsec = superblock_security(inode->i_sb);
+
 	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
@@ -1610,7 +1673,6 @@ static int inode_doinit_with_dentry(struct inode *inode,
 	if (isec->sclass == SECCLASS_FILE)
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
-	sbsec = inode->i_sb->s_security;
 	if (!current_selinux_ns->initialized ||
 	    !(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
@@ -1980,7 +2042,8 @@ selinux_determine_inode_label(const struct task_security_struct *tsec,
 				 const struct qstr *name, u16 tclass,
 				 u32 *_new_isid)
 {
-	const struct superblock_security_struct *sbsec = dir->i_sb->s_security;
+	const struct superblock_security_struct *sbsec =
+		superblock_security(dir->i_sb);
 
 	if ((sbsec->flags & SE_SBINITIALIZED) &&
 	    (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)) {
@@ -2011,7 +2074,7 @@ static int may_create(struct inode *dir,
 	int rc;
 
 	dsec = inode_security(dir);
-	sbsec = dir->i_sb->s_security;
+	sbsec = superblock_security(dir->i_sb);
 
 	sid = tsec->sid;
 
@@ -2160,7 +2223,7 @@ static int superblock_has_perm(const struct cred *cred,
 	struct superblock_security_struct *sbsec;
 	u32 sid = cred_sid(cred);
 
-	sbsec = sb->s_security;
+	sbsec = superblock_security(sb);
 	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, sbsec->sid, SECCLASS_FILESYSTEM, perms, ad);
 }
@@ -2885,7 +2948,7 @@ static int selinux_sb_remount(struct super_block *sb, void *data)
 	int rc, i, *flags;
 	struct security_mnt_opts opts;
 	char *secdata, **mount_options;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec = superblock_security(sb);
 
 	if (!(sbsec->flags & SE_SBINITIALIZED))
 		return 0;
@@ -3079,7 +3142,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	int rc;
 	char *context;
 
-	sbsec = dir->i_sb->s_security;
+	sbsec = superblock_security(dir->i_sb);
 
 	sid = tsec->sid;
 	newsid = tsec->create_sid;
@@ -3332,7 +3395,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	if (strcmp(name, XATTR_NAME_SELINUX))
 		return selinux_inode_setotherxattr(dentry, name);
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = superblock_security(inode->i_sb);
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 04514ee..dba80d3 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -68,7 +68,7 @@ struct file_security_struct {
 };
 
 struct superblock_security_struct {
-	struct super_block *sb;		/* back pointer to sb object */
+	const struct super_block *sb;	/* back pointer to sb object */
 	u32 sid;			/* SID of file system superblock */
 	u32 def_sid;			/* default SID for labeling */
 	u32 mntpoint_sid;		/* SECURITY_FS_USE_MNTPOINT context for files */
@@ -77,6 +77,9 @@ struct superblock_security_struct {
 	struct mutex lock;
 	struct list_head isec_head;
 	spinlock_t isec_lock;
+	struct selinux_ns *ns;
+	struct list_head sbsec_list;
+	spinlock_t sbsec_list_lock;
 };
 
 struct msg_security_struct {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 005d65c..b80f9bd 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -324,7 +324,8 @@ int security_get_allow_unknown(struct selinux_ns *ns);
 #define SECURITY_FS_USE_NATIVE		7 /* use native label support */
 #define SECURITY_FS_USE_MAX		7 /* Highest SECURITY_FS_USE_XXX */
 
-int security_fs_use(struct selinux_ns *ns, struct super_block *sb);
+int security_fs_use(struct selinux_ns *ns,
+		    const char *fstype, unsigned short *behavior, u32 *sid);
 
 int security_genfs_sid(struct selinux_ns *ns,
 		       const char *fstype, char *name, u16 sclass,
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e1c3881..abc5383 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2770,16 +2770,17 @@ int security_genfs_sid(struct selinux_ns *ns,
 
 /**
  * security_fs_use - Determine how to handle labeling for a filesystem.
- * @sb: superblock in question
+ * @fstype: filesystem type
+ * @behavior: labeling behavior
+ * @sid: SID for filesystem (superblock)
  */
-int security_fs_use(struct selinux_ns *ns, struct super_block *sb)
+int security_fs_use(struct selinux_ns *ns, const char *fstype,
+		    unsigned short *behavior, u32 *sid)
 {
 	struct policydb *policydb;
 	struct sidtab *sidtab;
 	int rc = 0;
 	struct ocontext *c;
-	struct superblock_security_struct *sbsec = sb->s_security;
-	const char *fstype = sb->s_type->name;
 
 	read_lock(&ns->ss->policy_rwlock);
 
@@ -2794,22 +2795,22 @@ int security_fs_use(struct selinux_ns *ns, struct super_block *sb)
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
 		rc = __security_genfs_sid(ns, fstype, "/", SECCLASS_DIR,
-					  &sbsec->sid);
+					  sid);
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
2.9.5
