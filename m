Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGKBjcl019227
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:11:45 -0500
Subject: [PATCH 10/13] NFS: Extend nfs xattr handlers to accept the
	security namespace
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:11:32 -0500
Message-Id: <1195243892.20981.23.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The existing nfs4 xattr handlers do not accept xattr calls to the security
namespace. This patch extends these handlers to accept xattrs from the security
namespace in addition to the default nfsv4 acl namespace.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
---
 fs/nfs/nfs4proc.c |   61 ++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47fa612..2d71e44 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3926,14 +3926,18 @@ int nfs4_setxattr(struct dentry *dentry, const char *key, const void *buf,
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (strcmp(key, XATTR_NAME_NFSV4_ACL) != 0)
-		return -EOPNOTSUPP;
-
-	if (!S_ISREG(inode->i_mode) &&
-	    (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
-		return -EPERM;
+	if (strcmp(key, XATTR_NAME_NFSV4_ACL) == 0) {
+		if (!S_ISREG(inode->i_mode) &&
+		   (!S_ISDIR(inode->i_mode) || inode->i_mode & S_ISVTX))
+			return -EPERM;
 
-	return nfs4_proc_set_acl(inode, buf, buflen);
+		return nfs4_proc_set_acl(inode, buf, buflen);
+	}
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (strcmp(key, security_inode_xattr_getname()) == 0)
+		return nfs4_set_security_label(dentry, buf, buflen);
+#endif
+	return -EOPNOTSUPP;
 }
 
 /* The getxattr man page suggests returning -ENODATA for unknown attributes,
@@ -3945,22 +3949,49 @@ ssize_t nfs4_getxattr(struct dentry *dentry, const char *key, void *buf,
 {
 	struct inode *inode = dentry->d_inode;
 
-	if (strcmp(key, XATTR_NAME_NFSV4_ACL) != 0)
-		return -EOPNOTSUPP;
-
-	return nfs4_proc_get_acl(inode, buf, buflen);
+	if (strcmp(key, XATTR_NAME_NFSV4_ACL) == 0)
+		return nfs4_proc_get_acl(inode, buf, buflen);
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (strcmp(key, security_inode_xattr_getname()) == 0)
+		return nfs4_get_security_label(inode, buf, buflen);
+#endif
+	return -EOPNOTSUPP;
 }
 
 ssize_t nfs4_listxattr(struct dentry *dentry, char *buf, size_t buflen)
 {
-	size_t len = strlen(XATTR_NAME_NFSV4_ACL) + 1;
+	size_t len = 0, l;
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	const char *security_name = security_inode_xattr_getname();
+#endif
+	char *p;
 
-	if (!nfs4_server_supports_acls(NFS_SERVER(dentry->d_inode)))
+	if (nfs4_server_supports_acls(NFS_SERVER(dentry->d_inode)))
+		len += strlen(XATTR_NAME_NFSV4_ACL) + 1;
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(dentry->d_inode, NFS_CAP_SECURITY_LABEL))
+		len += strlen(security_name) + 1;
+#endif
+	if (!len)
 		return 0;
 	if (buf && buflen < len)
 		return -ERANGE;
-	if (buf)
-		memcpy(buf, XATTR_NAME_NFSV4_ACL, len);
+	if (!buf)
+		return len;
+
+	p = buf;
+	if (nfs4_server_supports_acls(NFS_SERVER(dentry->d_inode))) {
+		l = strlen(XATTR_NAME_NFSV4_ACL) + 1;
+		memcpy(p, XATTR_NAME_NFSV4_ACL, l);
+		p += l;
+	}
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	if (nfs_server_capable(dentry->d_inode, NFS_CAP_SECURITY_LABEL)) {
+		l = strlen(security_name) + 1;
+		memcpy(p, security_name, l);
+		p += l;
+	}
+#endif
 	return len;
 }
 
-- 
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
