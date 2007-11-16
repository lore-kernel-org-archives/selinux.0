Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK71RD018472
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:07:01 -0500
Subject: [PATCH 03/13] Security: Add hook to get full security xattr name
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:07:00 -0500
Message-Id: <1195243620.20981.9.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When a caller wishes to get pull the extended attribute name for the security
module for use they normally concatinate the security namespace segment and the
suffix provided by the lsm. This hook provides a mechanism to obtain the full
LSM xattr name. The patch also provides implementations for the dummy security
module and SELinux.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 include/linux/security.h |    7 +++++++
 security/dummy.c         |    6 ++++++
 security/security.c      |    6 ++++++
 security/selinux/hooks.c |    6 ++++++
 4 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3c4c91e..8c0d687 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1272,6 +1272,7 @@ struct security_operations {
 	int (*inode_removexattr) (struct dentry *dentry, char *name);
 	int (*inode_need_killpriv) (struct dentry *dentry);
 	int (*inode_killpriv) (struct dentry *dentry);
+	const char *(*inode_xattr_getname) (void);
   	int (*inode_getsecurity)(const struct inode *inode, const char *name, void **buffer, bool alloc);
   	int (*inode_setsecurity)(struct inode *inode, const char *name, const void *value, size_t size, int flags);
   	int (*inode_listsecurity)(struct inode *inode, char *buffer, size_t buffer_size);
@@ -1526,6 +1527,7 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct dentry *dentry, char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct dentry *dentry);
+const char *security_inode_xattr_getname(void);
 int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
@@ -1930,6 +1932,11 @@ static inline int security_inode_killpriv(struct dentry *dentry)
 	return cap_inode_killpriv(dentry);
 }
 
+static inline const char *security_inode_xattr_getname(void)
+{
+	return NULL;
+}
+
 static inline int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	return -EOPNOTSUPP;
diff --git a/security/dummy.c b/security/dummy.c
index 7de65dc..c2524ab 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -384,6 +384,11 @@ static int dummy_inode_killpriv(struct dentry *dentry)
 	return 0;
 }
 
+static const char *dummy_inode_xattr_getname(void)
+{
+	return NULL;
+}
+
 static int dummy_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	return -EOPNOTSUPP;
@@ -1022,6 +1027,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, inode_removexattr);
 	set_to_dummy_if_null(ops, inode_need_killpriv);
 	set_to_dummy_if_null(ops, inode_killpriv);
+	set_to_dummy_if_null(ops, inode_xattr_getname);
 	set_to_dummy_if_null(ops, inode_getsecurity);
 	set_to_dummy_if_null(ops, inode_setsecurity);
 	set_to_dummy_if_null(ops, inode_listsecurity);
diff --git a/security/security.c b/security/security.c
index 39de3f4..cf853a7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -478,6 +478,12 @@ int security_inode_killpriv(struct dentry *dentry)
 	return security_ops->inode_killpriv(dentry);
 }
 
+const char *security_inode_xattr_getname(void)
+{
+	return security_ops->inode_xattr_getname();
+}
+EXPORT_SYMBOL(security_inode_xattr_getname);
+
 int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
 	if (unlikely(IS_PRIVATE(inode)))
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 128f363..9083390 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2383,6 +2383,11 @@ static int selinux_inode_removexattr (struct dentry *dentry, char *name)
 	return -EACCES;
 }
 
+static const char *selinux_inode_xattr_getname(void)
+{
+      return XATTR_NAME_SELINUX;
+}
+
 /*
  * Copy the in-core inode security context value to the user.  If the
  * getxattr() prior to this succeeded, check to see if we need to
@@ -4809,6 +4814,7 @@ static struct security_operations selinux_ops = {
 	.inode_getxattr =		selinux_inode_getxattr,
 	.inode_listxattr =		selinux_inode_listxattr,
 	.inode_removexattr =		selinux_inode_removexattr,
+	.inode_xattr_getname =  	selinux_inode_xattr_getname,
 	.inode_getsecurity =            selinux_inode_getsecurity,
 	.inode_setsecurity =            selinux_inode_setsecurity,
 	.inode_listsecurity =           selinux_inode_listsecurity,
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
