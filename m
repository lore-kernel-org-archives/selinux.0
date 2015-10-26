Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFgib009697
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:51 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 6/7] selinux: Revalidate invalid inode security labels
Date: Mon, 26 Oct 2015 22:15:27 +0100
Message-Id: <1445894128-6765-7-git-send-email-agruenba@redhat.com>
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When fetching inode's security label, check if they are still valid, and try
reloading invalid labels.  Reloading will fail when we are in RCU context which
doesn't allow sleeping, or when we can't find a dentry for the inode.
(Reloading happens via iop->getxattr which takes a dentry parameter.)

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f93dafd..61aead9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -241,22 +241,51 @@ static int inode_alloc_security(struct inode *inode)
 	return 0;
 }
 
+static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
+
 /*
- * Get the security label of a dentry's inode.
+ * Get an inode's security label.  When the label has been marked as invalid,
+ * try to reload it.  The @opt_dentry parameter should be set to a dentry of
+ * the inode; when no dentry is available, set it to NULL instead.  The @rcu
+ * parameter indicates when sleeping and thus reloading labels is not allowed;
+ * in that case, this function will return ERR_PTR(-ECHILD).
+ */
+static struct inode_security_struct *__inode_security(struct inode *inode,
+						      struct dentry *opt_dentry,
+						      bool rcu)
+{
+	struct inode_security_struct *isec = inode->i_security;
+
+	if (isec->initialized == LABEL_INVALID) {
+		if (rcu)
+			return ERR_PTR(-ECHILD);
+
+		/*
+		 * Try reloading the inode security label.  This will fail if
+		 * @opt_dentry is NULL and no dentry for this inode can be
+		 * found; in that case, we will continue using the old label.
+		 */
+		inode_doinit_with_dentry(inode, opt_dentry);
+	}
+	return isec;
+}
+
+/*
+ * Get the security label of a dentry's inode.  Function may block.
  */
 static struct inode_security_struct *dentry_security(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	return inode->i_security;
+	return __inode_security(inode, dentry, false);
 }
 
 /*
- * Get the security label of an inode.
+ * Get the security label of an inode.  Function may block.
  */
 static struct inode_security_struct *inode_security(struct inode *inode)
 {
-	return inode->i_security;
+	return __inode_security(inode, NULL, false);
 }
 
 static void inode_free_rcu(struct rcu_head *head)
@@ -362,8 +391,6 @@ static const char *labeling_behaviors[7] = {
 	"uses native labeling",
 };
 
-static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
-
 static inline int inode_doinit(struct inode *inode)
 {
 	return inode_doinit_with_dentry(inode, NULL);
@@ -2858,7 +2885,9 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct inode *inode,
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
 	sid = cred_sid(cred);
-	isec = inode_security(inode);
+	isec = __inode_security(inode, NULL, rcu);
+	if (IS_ERR(isec))
+		return PTR_ERR(isec);
 
 	return avc_has_perm_flags(sid, isec->sid, isec->sclass, FILE__READ, &ad,
 				  rcu ? MAY_NOT_BLOCK : 0);
@@ -2910,7 +2939,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 	perms = file_mask_to_av(inode->i_mode, mask);
 
 	sid = cred_sid(cred);
-	isec = inode_security(inode);
+	isec = __inode_security(inode, NULL, flags & MAY_NOT_BLOCK);
+	if (IS_ERR(isec))
+		return PTR_ERR(isec);
 
 	rc = avc_has_perm_noaudit(sid, isec->sid, isec->sclass, perms, 0, &avd);
 	audited = avc_audit_required(perms, &avd, rc,
-- 
2.5.0
