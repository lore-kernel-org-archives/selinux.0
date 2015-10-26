Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9QLFgiX009697
 for <selinux@tycho.nsa.gov>; Mon, 26 Oct 2015 17:15:45 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 4/7] selinux: Push dentry down from {dentry, path,
 file}_has_perm
Date: Mon, 26 Oct 2015 22:15:25 +0100
Message-Id: <1445894128-6765-5-git-send-email-agruenba@redhat.com>
In-Reply-To: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In dentry_has_perm, path_has_perm, and file_has_perm, push the dentry down
to before avc_has_perm so that dentry_security can be used instead of
inode_security.  Since inode_has_perm now takes a dentry, rename it to
__dentry_has_perm.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 security/selinux/hooks.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d6b4dc9..2a04729 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1621,56 +1621,54 @@ static int task_has_system(struct task_struct *tsk,
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
-/* Check whether a task has a particular permission to an inode.
-   The 'adp' parameter is optional and allows other audit
+/* Check whether a task has a particular permission to a dentry's
+   inode.  The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
-static int inode_has_perm(const struct cred *cred,
-			  struct inode *inode,
-			  u32 perms,
-			  struct common_audit_data *adp)
+static int __dentry_has_perm(const struct cred *cred,
+			     struct dentry *dentry,
+			     u32 perms,
+			     struct common_audit_data *adp)
 {
 	struct inode_security_struct *isec;
 	u32 sid;
 
 	validate_creds(cred);
 
-	if (unlikely(IS_PRIVATE(inode)))
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
 
 	sid = cred_sid(cred);
-	isec = inode_security(inode);
+	isec = dentry_security(dentry);
 
 	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
 }
 
-/* Same as inode_has_perm, but pass explicit audit data containing
+/* Same as __dentry_has_perm, but pass explicit audit data containing
    the dentry to help the auditing code to more easily generate the
    pathname if needed. */
 static inline int dentry_has_perm(const struct cred *cred,
 				  struct dentry *dentry,
 				  u32 av)
 {
-	struct inode *inode = d_backing_inode(dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
 	ad.u.dentry = dentry;
-	return inode_has_perm(cred, inode, av, &ad);
+	return __dentry_has_perm(cred, dentry, av, &ad);
 }
 
-/* Same as inode_has_perm, but pass explicit audit data containing
+/* Same as __dentry_has_perm, but pass explicit audit data containing
    the path to help the auditing code to more easily generate the
    pathname if needed. */
 static inline int path_has_perm(const struct cred *cred,
 				const struct path *path,
 				u32 av)
 {
-	struct inode *inode = d_backing_inode(path->dentry);
 	struct common_audit_data ad;
 
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = *path;
-	return inode_has_perm(cred, inode, av, &ad);
+	return __dentry_has_perm(cred, path->dentry, av, &ad);
 }
 
 /* Check whether a task can use an open file descriptor to
@@ -1686,7 +1684,6 @@ static int file_has_perm(const struct cred *cred,
 			 u32 av)
 {
 	struct file_security_struct *fsec = file->f_security;
-	struct inode *inode = file_inode(file);
 	struct common_audit_data ad;
 	u32 sid = cred_sid(cred);
 	int rc;
@@ -1706,7 +1703,7 @@ static int file_has_perm(const struct cred *cred,
 	/* av is zero if only checking access to the descriptor. */
 	rc = 0;
 	if (av)
-		rc = inode_has_perm(cred, inode, av, &ad);
+		rc = __dentry_has_perm(cred, file->f_path.dentry, av, &ad);
 
 out:
 	return rc;
-- 
2.5.0
