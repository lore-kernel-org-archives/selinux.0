From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] SELinux: introduce path_has_perm
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 28 Apr 2011 16:04:58 -0400
Message-ID: <20110428200458.7831.65713.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We currently have inode_has_perm and dentry_has_perm.  dentry_has_perm just
calls inode_has_perm with additional audit data.  But dentry_has_perm can
take either a dentry or a path.  Split those to make the code obvious and
to fix the previous problem where I thought dentry_has_perm always had a
valid dentry and mnt.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/hooks.c |   46 +++++++++++++++++++++++++++++++---------------
 1 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f84d3d7..54bd9b5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1502,16 +1502,29 @@ static int inode_has_perm(const struct cred *cred,
    the dentry to help the auditing code to more easily generate the
    pathname if needed. */
 static inline int dentry_has_perm(const struct cred *cred,
-				  struct vfsmount *mnt,
 				  struct dentry *dentry,
 				  u32 av)
 {
 	struct inode *inode = dentry->d_inode;
 	struct common_audit_data ad;
 
+	COMMON_AUDIT_DATA_INIT(&ad, DENTRY);
+	ad.u.dentry = dentry;
+	return inode_has_perm(cred, inode, av, &ad, 0);
+}
+
+/* Same as inode_has_perm, but pass explicit audit data containing
+   the path to help the auditing code to more easily generate the
+   pathname if needed. */
+static inline int path_has_perm(const struct cred *cred,
+				struct path *path,
+				u32 av)
+{
+	struct inode *inode = path->dentry->d_inode;
+	struct common_audit_data ad;
+
 	COMMON_AUDIT_DATA_INIT(&ad, PATH);
-	ad.u.path.mnt = mnt;
-	ad.u.path.dentry = dentry;
+	ad.u.path = *path;
 	return inode_has_perm(cred, inode, av, &ad, 0);
 }
 
@@ -1899,7 +1912,7 @@ static int selinux_quota_on(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__QUOTAON);
+	return dentry_has_perm(cred, dentry, FILE__QUOTAON);
 }
 
 static int selinux_syslog(int type)
@@ -2500,8 +2513,7 @@ static int selinux_mount(char *dev_name,
 		return superblock_has_perm(cred, path->mnt->mnt_sb,
 					   FILESYSTEM__REMOUNT, NULL);
 	else
-		return dentry_has_perm(cred, path->mnt, path->dentry,
-				       FILE__MOUNTON);
+		return path_has_perm(cred, path, FILE__MOUNTON);
 }
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
@@ -2634,14 +2646,14 @@ static int selinux_inode_readlink(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
+	return dentry_has_perm(cred, dentry, FILE__READ);
 }
 
 static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *nameidata)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
+	return dentry_has_perm(cred, dentry, FILE__READ);
 }
 
 static int selinux_inode_permission(struct inode *inode, int mask, unsigned flags)
@@ -2685,19 +2697,23 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
-		return dentry_has_perm(cred, NULL, dentry, FILE__SETATTR);
+		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
 	if (ia_valid & ATTR_SIZE)
 		av |= FILE__OPEN;
 
-	return dentry_has_perm(cred, NULL, dentry, av);
+	return dentry_has_perm(cred, dentry, av);
 }
 
 static int selinux_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
+	struct path path;
+
+	path.dentry = dentry;
+	path.mnt = mnt;
 
-	return dentry_has_perm(cred, mnt, dentry, FILE__GETATTR);
+	return path_has_perm(cred, &path, FILE__GETATTR);
 }
 
 static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
@@ -2718,7 +2734,7 @@ static int selinux_inode_setotherxattr(struct dentry *dentry, const char *name)
 
 	/* Not an attribute we recognize, so just check the
 	   ordinary setattr permission. */
-	return dentry_has_perm(cred, NULL, dentry, FILE__SETATTR);
+	return dentry_has_perm(cred, dentry, FILE__SETATTR);
 }
 
 static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
@@ -2805,14 +2821,14 @@ static int selinux_inode_getxattr(struct dentry *dentry, const char *name)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__GETATTR);
+	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
 static int selinux_inode_listxattr(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__GETATTR);
+	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
 static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
@@ -2909,7 +2925,7 @@ static int selinux_lookup(struct dentry *dentry)
 {
 	const struct cred *cred = current_cred();
 
-	return dentry_has_perm(cred, NULL, dentry, FILE__LOOKUP);
+	return dentry_has_perm(cred, dentry, FILE__LOOKUP);
 }
 
 /* file security operations */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
