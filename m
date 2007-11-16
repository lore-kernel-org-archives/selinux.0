Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK8LMb018688
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:08:21 -0500
Subject: [PATCH 05/13] Security: Add hook to calculate context based on a
	negative dentry.
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:08:20 -0500
Message-Id: <1195243700.20981.13.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is a time where we need to calculate a context without the
inode having been created yet. To do this we take the negative dentry and
calculate a sid based on the process and the parent directory contexts.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 include/linux/security.h |   11 +++++++++++
 security/dummy.c         |    7 +++++++
 security/security.c      |    9 +++++++++
 security/selinux/hooks.c |   46 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8c0d687..6ccb010 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1240,6 +1240,8 @@ struct security_operations {
 	void (*sb_post_pivotroot) (struct nameidata * old_nd,
 				   struct nameidata * new_nd);
 
+	int (*dentry_init_security) (struct dentry *dentry, int mode,
+				     void **ctx, u32 *ctxlen);
 	int (*inode_alloc_security) (struct inode *inode);	
 	void (*inode_free_security) (struct inode *inode);
 	int (*inode_init_security) (struct inode *inode, struct inode *dir,
@@ -1497,6 +1499,7 @@ void security_sb_post_mountroot(void);
 void security_sb_post_addmount(struct vfsmount *mnt, struct nameidata *mountpoint_nd);
 int security_sb_pivotroot(struct nameidata *old_nd, struct nameidata *new_nd);
 void security_sb_post_pivotroot(struct nameidata *old_nd, struct nameidata *new_nd);
+int security_dentry_init_security(struct dentry *dentry, int mode, void **ctx, u32 *ctxlen);
 int security_inode_alloc(struct inode *inode);
 void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
@@ -1793,6 +1796,14 @@ static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
 					       struct nameidata *new_nd)
 { }
 
+static inline int security_dentry_init_security(struct dentry *dentry,
+						 int mode,
+						 void **ctx,
+						 u32 *ctxlen)
+{
+	return 0;
+}
+
 static inline int security_inode_alloc (struct inode *inode)
 {
 	return 0;
diff --git a/security/dummy.c b/security/dummy.c
index c2524ab..9a91650 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -245,6 +245,12 @@ static void dummy_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata
 	return;
 }
 
+static int dummy_dentry_init_security(struct dentry *dentry, int mode,
+				       void **ctx, u32 *ctxlen)
+{
+	return -EOPNOTSUPP;
+}
+
 static int dummy_inode_alloc_security (struct inode *inode)
 {
 	return 0;
@@ -1003,6 +1009,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, sb_post_addmount);
 	set_to_dummy_if_null(ops, sb_pivotroot);
 	set_to_dummy_if_null(ops, sb_post_pivotroot);
+	set_to_dummy_if_null(ops, dentry_init_security);
 	set_to_dummy_if_null(ops, inode_alloc_security);
 	set_to_dummy_if_null(ops, inode_free_security);
 	set_to_dummy_if_null(ops, inode_init_security);
diff --git a/security/security.c b/security/security.c
index cf853a7..c481405 100644
--- a/security/security.c
+++ b/security/security.c
@@ -308,6 +308,15 @@ void security_sb_post_pivotroot(struct nameidata *old_nd, struct nameidata *new_
 	security_ops->sb_post_pivotroot(old_nd, new_nd);
 }
 
+int security_dentry_init_security(struct dentry *dentry,
+						 int mode,
+						 void **ctx,
+						 u32 *ctxlen)
+{
+	return security_ops->dentry_init_security(dentry, mode, ctx, ctxlen);
+}
+EXPORT_SYMBOL(security_dentry_init_security);
+
 int security_inode_alloc(struct inode *inode)
 {
 	inode->i_security = NULL;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9083390..c9f5abc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -60,6 +60,7 @@
 #include <linux/udp.h>
 #include <linux/dccp.h>
 #include <linux/quota.h>
+#include <linux/fsnotify.h>
 #include <linux/un.h>		/* for Unix socket types */
 #include <net/af_unix.h>	/* for Unix socket types */
 #include <linux/parser.h>
@@ -2086,6 +2087,42 @@ static int selinux_umount(struct vfsmount *mnt, int flags)
 
 /* inode security operations */
 
+/*
+ * For now, we need a way to compute a SID for
+ * a dentry as the inode is not yet available
+ * (and under NFSv4 has no label backed by an EA anyway.
+ */
+static int selinux_dentry_init_security(struct dentry *dentry, int mode,
+					void **ctx, u32 *ctxlen)
+{
+	struct task_security_struct *tsec;
+	struct inode_security_struct *dsec;
+	struct superblock_security_struct *sbsec;
+	struct inode *dir = dentry->d_parent->d_inode;
+	u32 newsid;
+	int rc;
+
+	tsec = current->security;
+	dsec = dir->i_security;
+	sbsec = dir->i_sb->s_security;
+
+	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
+		newsid = tsec->create_sid;
+	} else {
+		rc = security_transition_sid(tsec->sid, dsec->sid,
+					     inode_mode_to_security_class(mode),
+					     &newsid);
+		if (rc) {
+			printk(KERN_WARNING "%s:  "
+			       "security_transition_sid failed, rc=%d\n",
+			       __FUNCTION__, -rc);
+			return rc;
+		}
+	}
+
+	return security_sid_to_context(newsid, (char **)ctx, ctxlen);
+}
+
 static int selinux_inode_alloc_security(struct inode *inode)
 {
 	return inode_alloc_security(inode);
@@ -2358,8 +2395,11 @@ static void selinux_inode_post_setxattr(struct dentry *dentry, char *name,
 		       "%s, rc=%d\n", __FUNCTION__, (char*)value, -rc);
 		return;
 	}
-
+	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->initialized = 1;
+
+	fsnotify_change(dentry, ATTR_SECURITY_LABEL);
 	return;
 }
 
@@ -2434,8 +2474,9 @@ static int selinux_inode_setsecurity(struct inode *inode, const char *name,
 	rc = security_context_to_sid((void*)value, size, &newsid);
 	if (rc)
 		return rc;
-
+	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = newsid;
+	isec->initialized = 1;
 	return 0;
 }
 
@@ -4793,6 +4834,7 @@ static struct security_operations selinux_ops = {
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,
 
+	.dentry_init_security = 	selinux_dentry_init_security,
 	.inode_alloc_security =		selinux_inode_alloc_security,
 	.inode_free_security =		selinux_inode_free_security,
 	.inode_init_security =		selinux_inode_init_security,
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
