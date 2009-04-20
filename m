Subject: [RFC PATCH] access(2) vs. SELinux
From: Eric Paris <eparis@redhat.com>
To: Chad Sellers <csellers@tresys.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <C6122AAA.A6957%csellers@tresys.com>
References: <C6122AAA.A6957%csellers@tresys.com>
Content-Type: text/plain
Date: Mon, 20 Apr 2009 14:11:14 -0400
Message-Id: <1240251074.2562.80.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-04-20 at 13:35 -0400, Chad Sellers wrote:
> On 4/20/09 1:21 PM, "Eric Paris" <eparis@redhat.com> wrote:
> <snip>
> > 
> > I'm going to spend a couple minutes and try to prototype an all in
> > kernel solution such that on access() we will check the permission:
> > 
> > allow process_t file_t:file read
> > 
> > if there is a dontaudit rule for EITHER "read" or "access_read" we will
> > NOT print an avc denial.
> > 
> > on the actual usage we will ONLY check for the "read" dontaudit.
> > 
> That sounds like a better solution than anything we've talked about so far.
> It would mean the policy author would only have to worry about the access_*
> perms if they cared about the issue they're designed to solve. Hopefully you
> can find an acceptable way to pull it off in the kernel. I'm rooting for
> you!

So James, Stephen what do we think of something like this?  Lot of code
bloat and pain on the access+denial path, but shouldn't hurt us any in
the hot case...

---

 fs/namei.c                                |   37 +++++++----
 fs/open.c                                 |    2 
 include/linux/fs.h                        |    1 
 include/linux/security.h                  |    7 +-
 security/capability.c                     |    2 
 security/security.c                       |    4 -
 security/selinux/hooks.c                  |  100 ++++++++++++++++++++++++++----
 security/selinux/include/av_permissions.h |    6 +
 security/smack/smack_lsm.c                |    2 
 9 files changed, 128 insertions(+), 33 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b8433eb..5a5eeab 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -228,17 +228,7 @@ int generic_permission(struct inode *inode, int mask,
 	return -EACCES;
 }
 
-/**
- * inode_permission  -  check for access rights to a given inode
- * @inode:	inode to check permission on
- * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
- *
- * Used to check for read/write/execute permissions on an inode.
- * We use "fsuid" for this, letting us set arbitrary permissions
- * for filesystem access without changing the "normal" uids which
- * are used for other things.
- */
-int inode_permission(struct inode *inode, int mask)
+static int __inode_permission(struct inode *inode, int mask, bool from_access)
 {
 	int retval;
 
@@ -272,7 +262,28 @@ int inode_permission(struct inode *inode, int mask)
 		return retval;
 
 	return security_inode_permission(inode,
-			mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND));
+			mask & (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND),
+			from_access);
+}
+
+int inode_access_permission(struct inode *inode, int mask)
+{
+	return __inode_permission(inode, mask, 1);
+}
+
+/**
+ * inode_permission  -  check for access rights to a given inode
+ * @inode:	inode to check permission on
+ * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ *
+ * Used to check for read/write/execute permissions on an inode.
+ * We use "fsuid" for this, letting us set arbitrary permissions
+ * for filesystem access without changing the "normal" uids which
+ * are used for other things.
+ */
+int inode_permission(struct inode *inode, int mask)
+{
+	return __inode_permission(inode, mask, 0);
 }
 
 /**
@@ -456,7 +467,7 @@ static int exec_permission_lite(struct inode *inode)
 
 	return -EACCES;
 ok:
-	return security_inode_permission(inode, MAY_EXEC);
+	return security_inode_permission(inode, MAY_EXEC, 0);
 }
 
 /*
diff --git a/fs/open.c b/fs/open.c
index 377eb25..485cfd8 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -493,7 +493,7 @@ SYSCALL_DEFINE3(faccessat, int, dfd, const char __user *, filename, int, mode)
 			goto out_path_release;
 	}
 
-	res = inode_permission(inode, mode | MAY_ACCESS);
+	res = inode_access_permission(inode, mode | MAY_ACCESS);
 	/* SuS v2 requires we report a read only fs too */
 	if (res || !(mode & S_IWOTH) || special_file(inode->i_mode))
 		goto out_path_release;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e766be0..0ac6e6b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2091,6 +2091,7 @@ extern int do_remount_sb(struct super_block *sb, int flags,
 extern sector_t bmap(struct inode *, sector_t);
 #endif
 extern int notify_change(struct dentry *, struct iattr *);
+extern int inode_access_permission(struct inode *, int);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int,
 		int (*check_acl)(struct inode *, int));
diff --git a/include/linux/security.h b/include/linux/security.h
index d5fd616..98a0ac7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1423,7 +1423,7 @@ struct security_operations {
 			     struct inode *new_dir, struct dentry *new_dentry);
 	int (*inode_readlink) (struct dentry *dentry);
 	int (*inode_follow_link) (struct dentry *dentry, struct nameidata *nd);
-	int (*inode_permission) (struct inode *inode, int mask);
+	int (*inode_permission) (struct inode *inode, int mask, bool from_access);
 	int (*inode_setattr)	(struct dentry *dentry, struct iattr *attr);
 	int (*inode_getattr) (struct vfsmount *mnt, struct dentry *dentry);
 	void (*inode_delete) (struct inode *inode);
@@ -1682,7 +1682,7 @@ int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry);
 int security_inode_readlink(struct dentry *dentry);
 int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd);
-int security_inode_permission(struct inode *inode, int mask);
+int security_inode_permission(struct inode *inode, int mask, bool from_access);
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(struct vfsmount *mnt, struct dentry *dentry);
 void security_inode_delete(struct inode *inode);
@@ -2095,7 +2095,8 @@ static inline int security_inode_follow_link(struct dentry *dentry,
 	return 0;
 }
 
-static inline int security_inode_permission(struct inode *inode, int mask)
+static inline int security_inode_permission(struct inode *inode, int mask,
+					    bool from_access)
 {
 	return 0;
 }
diff --git a/security/capability.c b/security/capability.c
index 21b6cea..672d87a 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -206,7 +206,7 @@ static int cap_inode_follow_link(struct dentry *dentry,
 	return 0;
 }
 
-static int cap_inode_permission(struct inode *inode, int mask)
+static int cap_inode_permission(struct inode *inode, int mask, bool from_access)
 {
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 5284255..19e2d41 100644
--- a/security/security.c
+++ b/security/security.c
@@ -516,11 +516,11 @@ int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd)
 	return security_ops->inode_follow_link(dentry, nd);
 }
 
-int security_inode_permission(struct inode *inode, int mask)
+int security_inode_permission(struct inode *inode, int mask, bool from_access)
 {
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_permission(inode, mask);
+	return security_ops->inode_permission(inode, mask, from_access);
 }
 
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ba808ef..e791970 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1518,23 +1518,93 @@ static int task_has_system(struct task_struct *tsk,
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
+/* given an avd | the access_XXX perm dontaudit bit onto the XXX bit */
+static void compute_access_dontaudit(struct av_decision *avd, u32 sclass)
+{
+	u32 auditdeny = avd->auditdeny;
+
+	switch (sclass) {
+	case SECCLASS_FILE:
+		if (auditdeny & FILE__ACCESS_READ)
+			auditdeny |= FILE__READ;
+		if (auditdeny & FILE__ACCESS_WRITE)
+			auditdeny |= FILE__WRITE;
+		if (auditdeny & FILE__ACCESS_EXECUTE)
+			auditdeny |= FILE__EXECUTE;
+		break;
+	case SECCLASS_DIR:
+		if (auditdeny & DIR__ACCESS_READ)
+			auditdeny |= DIR__READ;
+		if (auditdeny & DIR__ACCESS_WRITE)
+			auditdeny |= DIR__WRITE;
+		if (auditdeny & DIR__ACCESS_EXECUTE)
+			auditdeny |= DIR__EXECUTE;
+		break;
+/*
+	case SECCLASS_CHR_FILE:
+		if (auditdeny & CHR_FILE__ACCESS_READ)
+			auditdeny |= CHR_FILE__READ;
+		if (auditdeny & CHR_FILE__ACCESS_WRITE)
+			auditdeny |= CHR_FILE__WRITE;
+		if (auditdeny & CHR_FILE__ACCESS_EXECUTE)
+			auditdeny |= CHR_FILE__EXECUTE;
+		break;
+	case SECCLASS_BLK_FILE:
+		if (auditdeny & BLK_FILE__ACCESS_READ)
+			auditdeny |= BLK_FILE__READ;
+		if (auditdeny & BLK_FILE__ACCESS_WRITE)
+			auditdeny |= BLK_FILE__WRITE;
+		if (auditdeny & BLK_FILE__ACCESS_EXECUTE)
+			auditdeny |= BLK_FILE__EXECUTE;
+		break;
+	case SECCLASS_FIFO_FILE:
+		if (auditdeny & FIFO_FILE__ACCESS_READ)
+			auditdeny |= FIFO_FILE__READ;
+		if (auditdeny & FIFO_FILE__ACCESS_WRITE)
+			auditdeny |= FIFO_FILE__WRITE;
+		if (auditdeny & FIFO_FILE__ACCESS_EXECUTE)
+			auditdeny |= FIFO_FILE__EXECUTE;
+		break;
+	case SECCLASS_SOCK_FILE:
+		if (auditdeny & SOCK_FILE__ACCESS_READ)
+			auditdeny |= SOCK_FILE__READ;
+		if (auditdeny & SOCK_FILE__ACCESS_WRITE)
+			auditdeny |= SOCK_FILE__WRITE;
+		if (auditdeny & SOCK_FILE__ACCESS_EXECUTE)
+			auditdeny |= SOCK_FILE__EXECUTE;
+		break;
+	default:
+		BUG();
+*/
+	}
+
+	avd->auditdeny = auditdeny;
+}
+
 /* Check whether a task has a particular permission to an inode.
    The 'adp' parameter is optional and allows other audit
    data to be passed (e.g. the dentry). */
 static int inode_has_perm(const struct cred *cred,
 			  struct inode *inode,
 			  u32 perms,
-			  struct avc_audit_data *adp)
+			  struct avc_audit_data *adp,
+			  bool from_access)
 {
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
-	u32 sid;
+        struct av_decision avd;
+        int rc;
+	u32 ssid, tsid;
+	u16 tclass;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	sid = cred_sid(cred);
+	ssid = cred_sid(cred);
+
 	isec = inode->i_security;
+	tsid = isec->sid;
+	tclass = isec->sclass;
 
 	if (!adp) {
 		adp = &ad;
@@ -1542,7 +1612,13 @@ static int inode_has_perm(const struct cred *cred,
 		ad.u.fs.inode = inode;
 	}
 
-	return avc_has_perm(sid, isec->sid, isec->sclass, perms, adp);
+        rc = avc_has_perm_noaudit(ssid, tsid, tclass, perms, 0, &avd);
+
+	if (unlikely(rc && from_access))
+		compute_access_dontaudit(&avd, tclass);
+
+        avc_audit(ssid, tsid, tclass, perms, &avd, rc, adp);
+        return rc;
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1559,7 +1635,7 @@ static inline int dentry_has_perm(const struct cred *cred,
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.path.mnt = mnt;
 	ad.u.fs.path.dentry = dentry;
-	return inode_has_perm(cred, inode, av, &ad);
+	return inode_has_perm(cred, inode, av, &ad, 0);
 }
 
 /* Check whether a task can use an open file descriptor to
@@ -1595,7 +1671,7 @@ static int file_has_perm(const struct cred *cred,
 	/* av is zero if only checking access to the descriptor. */
 	rc = 0;
 	if (av)
-		rc = inode_has_perm(cred, inode, av, &ad);
+		rc = inode_has_perm(cred, inode, av, &ad, 0);
 
 out:
 	return rc;
@@ -2255,8 +2331,8 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 			   interested in the inode-based check here. */
 			file = list_first_entry(&tty->tty_files, struct file, f_u.fu_list);
 			inode = file->f_path.dentry->d_inode;
-			if (inode_has_perm(cred, inode,
-					   FILE__READ | FILE__WRITE, NULL)) {
+			if (inode_has_perm(cred, inode, FILE__READ | FILE__WRITE,
+					   NULL, 0)) {
 				drop_tty = 1;
 			}
 		}
@@ -2702,7 +2778,7 @@ static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *na
 	return dentry_has_perm(cred, NULL, dentry, FILE__READ);
 }
 
-static int selinux_inode_permission(struct inode *inode, int mask)
+static int selinux_inode_permission(struct inode *inode, int mask, bool from_access)
 {
 	const struct cred *cred = current_cred();
 
@@ -2711,8 +2787,8 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 		return 0;
 	}
 
-	return inode_has_perm(cred, inode,
-			      file_mask_to_av(inode->i_mode, mask), NULL);
+	return inode_has_perm(cred, inode, file_mask_to_av(inode->i_mode, mask),
+			      NULL, from_access);
 }
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
@@ -3204,7 +3280,7 @@ static int selinux_dentry_open(struct file *file, const struct cred *cred)
 	 * new inode label or new policy.
 	 * This check is not redundant - do not remove.
 	 */
-	return inode_has_perm(cred, inode, open_file_to_av(file), NULL);
+	return inode_has_perm(cred, inode, open_file_to_av(file), NULL, 0);
 }
 
 /* task security operations */
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index d645192..48e9d5d 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -80,6 +80,9 @@
 #define DIR__SEARCH                               0x00100000UL
 #define DIR__RMDIR                                0x00200000UL
 #define DIR__OPEN                                 0x00400000UL
+#define DIR__ACCESS_READ                          0x00800000UL
+#define DIR__ACCESS_WRITE                         0x01000000UL
+#define DIR__ACCESS_EXECUTE                       0x02000000UL
 #define FILE__IOCTL                               0x00000001UL
 #define FILE__READ                                0x00000002UL
 #define FILE__WRITE                               0x00000004UL
@@ -101,6 +104,9 @@
 #define FILE__ENTRYPOINT                          0x00040000UL
 #define FILE__EXECMOD                             0x00080000UL
 #define FILE__OPEN                                0x00100000UL
+#define FILE__ACCESS_READ                         0x00200000UL
+#define FILE__ACCESS_WRITE                        0x00400000UL
+#define FILE__ACCESS_EXECUTE                      0x00800000UL
 #define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__READ                            0x00000002UL
 #define LNK_FILE__WRITE                           0x00000004UL
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0d030b4..3c2d321 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -601,7 +601,7 @@ static int smack_inode_rename(struct inode *old_inode,
  *
  * Returns 0 if access is permitted, -EACCES otherwise
  */
-static int smack_inode_permission(struct inode *inode, int mask)
+static int smack_inode_permission(struct inode *inode, int mask, bool from_access)
 {
 	struct smk_audit_info ad;
 	/*



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
