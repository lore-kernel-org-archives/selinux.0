From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, jmorris@namei.org, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon,  2 Oct 2017 11:58:22 -0400
Message-Id: <20171002155825.28620-8-sds@tycho.nsa.gov>
In-Reply-To: <20171002155825.28620-1-sds@tycho.nsa.gov>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
Subject: [RFC 07/10] selinux: support per-namespace inode security structures
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Extend the inode security structure to include a reference to the
associated selinux namespace, and turn it into a list so that we
can maintain per-inode security state for each namespace.  This is
necessary since the inode SIDs are per-namespace and multiple namespaces
may access the same inodes.

Introduce a find_isec() helper to find the correct inode security
structure for the current selinux namespace, creating one if one
does not already exist.  Update the existing inode_security*()
helpers to use this helper, to pass the per-namespace inode security
structure for initialization, and to return the resulting inode security
structure to the caller.  Replace direct references to inode->i_security
with the appropriate helper or to use the returned result.

This change is problematic in several respects, so it is unclear
it will survive in the final implementation.  Some of the issues are:
1) The inode security structures pin the selinux namespace in memory
for all namespaces that ever access the inode, preventing timely
(or possibly ever) freeing of the namespace.

2) Not everything in the inode security structure needs to be replicated
per namespace, so this is wasteful and potentially confusing (e.g. inode
back pointer, rcu head - but that overlaps with the list which does need
to be per-namespace, sclass unless we anticipate policy-driven file class
assignments in the future as we already have for sockets).

3) It is not safe to sleep from all callers of inode_security*(), and
thus we cannot always allocate a security blob for the namespace or
fetch the xattr on demand.  Thus, we could encounter a memory allocation
failure or fail to fetch the xattr and map it to a SID in the caller's
namespace.   This is not handled safely currently!

4) We only support a single security.selinux xattr, which must be mappable
to a SID in every namespace that accesses the inodes (or it will be mapped
to the unlabeled SID, which must then be accessible if we wish to permit
access from that namespace).

5) We do not yet properly handle setxattr of security.selinux; at present,
it will modify the on-disk xattr but will only update the in-core SID for
the current namespace and could leave other namespaces out of sync until
the inode is evicted and refetched.

Not-signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c          | 137 +++++++++++++++++++++++++++-----------
 security/selinux/include/objsec.h |   4 ++
 security/selinux/selinuxfs.c      |   2 +-
 3 files changed, 104 insertions(+), 39 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efe8083..8a52e71 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -263,28 +263,83 @@ static inline u32 task_sid(const struct task_struct *task)
 
 /* Allocate and free functions for each kind of security blob. */
 
-static int inode_alloc_security(struct inode *inode)
+static struct inode_security_struct *isec_alloc(bool may_sleep)
 {
 	struct inode_security_struct *isec;
 	u32 sid = current_sid();
+	gfp_t flags = may_sleep ? GFP_NOFS : GFP_NOWAIT;
 
-	isec = kmem_cache_zalloc(sel_inode_cache, GFP_NOFS);
+	isec = kmem_cache_zalloc(sel_inode_cache, flags);
 	if (!isec)
-		return -ENOMEM;
+		return NULL;
 
 	spin_lock_init(&isec->lock);
 	INIT_LIST_HEAD(&isec->list);
-	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
 	isec->task_sid = sid;
 	isec->initialized = LABEL_INVALID;
-	inode->i_security = isec;
+	isec->ns = get_selinux_ns(current_selinux_ns);
+	INIT_LIST_HEAD(&isec->isec_list);
+	return isec;
+}
+
+static int inode_alloc_security(struct inode *inode)
+{
+	struct inode_security_struct *isec = isec_alloc(true);
+
+	if (!isec)
+		return -ENOMEM;
 
+	isec->inode = inode;
+	inode->i_security = isec;
 	return 0;
 }
 
-static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
+static int inode_doinit_with_dentry(struct inode *inode,
+				    struct dentry *opt_dentry,
+				    struct inode_security_struct *isec);
+
+static struct inode_security_struct *find_isec(struct inode *inode,
+					       bool may_sleep)
+{
+	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *cur, *new;
+
+	if (isec->ns == current_selinux_ns)
+		return isec;
+
+	spin_lock(&isec->lock);
+
+	list_for_each_entry(cur, &isec->isec_list, isec_list) {
+		if (cur->ns == current_selinux_ns)
+			goto out;
+	}
+
+	spin_unlock(&isec->lock);
+
+	new = isec_alloc(may_sleep);
+	if (!new) {
+		cur = NULL;
+		goto out;
+	}
+	new->inode = inode;
+
+	spin_lock(&isec->lock);
+
+	list_for_each_entry(cur, &isec->isec_list, isec_list) {
+		if (cur->ns == current_selinux_ns) {
+			kmem_cache_free(sel_inode_cache, new);
+			goto out;
+		}
+	}
+
+	list_add(&new->isec_list, &isec->isec_list);
+	cur = new;
+out:
+	spin_unlock(&isec->lock);
+	return cur;
+}
 
 /*
  * Try reloading inode security labels that have been marked as invalid.  The
@@ -293,57 +348,52 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
  * invalid.  The @opt_dentry parameter should be set to a dentry of the inode;
  * when no dentry is available, set it to NULL instead.
  */
-static int __inode_security_revalidate(struct inode *inode,
-				       struct dentry *opt_dentry,
-				       bool may_sleep)
+static struct inode_security_struct *
+__inode_security_revalidate(struct inode *inode,
+			    struct dentry *opt_dentry,
+			    bool may_sleep)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = find_isec(inode, may_sleep);
 
 	might_sleep_if(may_sleep);
 
 	if (ss_initialized && isec->initialized != LABEL_INITIALIZED) {
 		if (!may_sleep)
-			return -ECHILD;
+			return ERR_PTR(-ECHILD);
 
 		/*
 		 * Try reloading the inode security label.  This will fail if
 		 * @opt_dentry is NULL and no dentry for this inode can be
 		 * found; in that case, continue using the old label.
 		 */
-		inode_doinit_with_dentry(inode, opt_dentry);
+		inode_doinit_with_dentry(inode, opt_dentry, isec);
 	}
-	return 0;
+	return isec;
 }
 
 static struct inode_security_struct *inode_security_novalidate(struct inode *inode)
 {
-	return inode->i_security;
+	return find_isec(inode, false);
 }
 
 static struct inode_security_struct *inode_security_rcu(struct inode *inode, bool rcu)
 {
-	int error;
-
-	error = __inode_security_revalidate(inode, NULL, !rcu);
-	if (error)
-		return ERR_PTR(error);
-	return inode->i_security;
+	return __inode_security_revalidate(inode, NULL, !rcu);
 }
 
 /*
  * Get the security label of an inode.
  */
-static struct inode_security_struct *inode_security(struct inode *inode)
+struct inode_security_struct *inode_security(struct inode *inode)
 {
-	__inode_security_revalidate(inode, NULL, true);
-	return inode->i_security;
+	return __inode_security_revalidate(inode, NULL, true);
 }
 
 static struct inode_security_struct *backing_inode_security_novalidate(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	return inode->i_security;
+	return find_isec(inode, false);
 }
 
 /*
@@ -353,15 +403,22 @@ static struct inode_security_struct *backing_inode_security(struct dentry *dentr
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	__inode_security_revalidate(inode, dentry, true);
-	return inode->i_security;
+	return __inode_security_revalidate(inode, dentry, true);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
 {
-	struct inode_security_struct *isec;
+	struct inode_security_struct *isec, *entry, *tmp;
 
 	isec = container_of(head, struct inode_security_struct, rcu);
+
+	list_for_each_entry_safe(entry, tmp, &isec->isec_list, isec_list) {
+		put_selinux_ns(entry->ns);
+		kmem_cache_free(sel_inode_cache, entry);
+	}
+
+	put_selinux_ns(isec->ns);
+
 	kmem_cache_free(sel_inode_cache, isec);
 }
 
@@ -450,7 +507,7 @@ static void superblock_free_security(struct super_block *sb)
 
 static inline int inode_doinit(struct inode *inode)
 {
-	return inode_doinit_with_dentry(inode, NULL);
+	return inode_doinit_with_dentry(inode, NULL, find_isec(inode, true));
 }
 
 enum {
@@ -579,7 +636,8 @@ static int sb_finish_set_opts(struct super_block *sb)
 		sbsec->flags &= ~SBLABEL_MNT;
 
 	/* Initialize the root inode. */
-	rc = inode_doinit_with_dentry(root_inode, root);
+	rc = inode_doinit_with_dentry(root_inode, root, find_isec(root_inode,
+								  true));
 
 	/* Initialize any other inodes associated with the superblock, e.g.
 	   inodes created prior to initial policy load or inodes created
@@ -1529,10 +1587,11 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 }
 
 /* The inode's security attributes must be initialized before first use. */
-static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
+static int inode_doinit_with_dentry(struct inode *inode,
+				    struct dentry *opt_dentry,
+				    struct inode_security_struct *isec)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
 	u32 task_sid, sid = 0;
 	u16 sclass;
 	struct dentry *dentry;
@@ -1552,7 +1611,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 
 	sbsec = inode->i_sb->s_security;
-	if (!(sbsec->flags & SE_SBINITIALIZED)) {
+	if (!current_selinux_ns->initialized ||
+	    !(sbsec->flags & SE_SBINITIALIZED)) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
 		   server is ready to handle calls. */
@@ -1821,7 +1881,7 @@ static int inode_has_perm(const struct cred *cred,
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode->i_security;
+	isec = inode_security_novalidate(inode);
 
 	return avc_has_perm(cred_selinux_ns(cred),
 			    sid, isec->sid, isec->sclass, perms, adp);
@@ -3033,7 +3093,8 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
-		struct inode_security_struct *isec = inode->i_security;
+		struct inode_security_struct *isec =
+			inode_security_novalidate(inode);
 		isec->sclass = inode_mode_to_security_class(inode->i_mode);
 		isec->sid = newsid;
 		isec->initialized = LABEL_INITIALIZED;
@@ -3133,7 +3194,7 @@ static noinline int audit_inode_permission(struct inode *inode,
 					   unsigned flags)
 {
 	struct common_audit_data ad;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode_security_novalidate(inode);
 	int rc;
 
 	ad.type = LSM_AUDIT_DATA_INODE;
@@ -4189,7 +4250,7 @@ static int selinux_task_kill(struct task_struct *p, struct siginfo *info,
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode_security(inode);
 	u32 sid = task_sid(p);
 
 	spin_lock(&isec->lock);
@@ -6072,7 +6133,7 @@ static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (inode)
-		inode_doinit_with_dentry(inode, dentry);
+		inode_doinit_with_dentry(inode, dentry, find_isec(inode, true));
 }
 
 static int selinux_getprocattr(struct task_struct *p,
@@ -6289,7 +6350,7 @@ static void selinux_release_secctx(char *secdata, u32 seclen)
 
 static void selinux_inode_invalidate_secctx(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode_security_novalidate(inode);
 
 	spin_lock(&isec->lock);
 	isec->initialized = LABEL_INVALID;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 051b804..04514ee 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -56,6 +56,8 @@ struct inode_security_struct {
 	u16 sclass;		/* security class of this object */
 	unsigned char initialized;	/* initialization flag */
 	spinlock_t lock;
+	struct selinux_ns *ns;
+	struct list_head isec_list;
 };
 
 struct file_security_struct {
@@ -141,4 +143,6 @@ struct pkey_security_struct {
 	u32	sid;	/* SID of pkey */
 };
 
+struct inode_security_struct *inode_security(struct inode *inode);
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 90424454..a7e6bdb 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1387,7 +1387,7 @@ static int sel_make_bools(struct selinux_fs_info *fsi)
 		if (len >= PAGE_SIZE)
 			goto out;
 
-		isec = (struct inode_security_struct *)inode->i_security;
+		isec = inode_security(inode);
 		ret = security_genfs_sid(fsi->ns, "selinuxfs", page,
 					 SECCLASS_FILE, &sid);
 		if (ret) {
-- 
2.9.5
