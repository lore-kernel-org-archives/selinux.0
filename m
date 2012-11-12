Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAC6Gdgb030627
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2012 01:16:39 -0500
From: David Quigley <dpquigl@davequigley.com>
To: bfields@fieldses.org, trond.myklebust@netapp.com, sds@tycho.nsa.gov
Cc: linux-nfs@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        David Quigley <dpquigl@davequigley.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Miguel Rodel Felipe <Rodel_FM@dsi.a-star.edu.sg>,
        Phua Eu Gene <PHUA_Eu_Gene@dsi.a-star.edu.sg>,
        Khin Mi Mi Aung <Mi_Mi_AUNG@dsi.a-star.edu.sg>
Subject: [PATCH 12/13] NFS: Extend NFS xattr handlers to accept the security namespace
Date: Mon, 12 Nov 2012 01:15:46 -0500
Message-Id: <1352700947-3915-13-git-send-email-dpquigl@davequigley.com>
In-Reply-To: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com>
References: <1352700947-3915-1-git-send-email-dpquigl@davequigley.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David Quigley <dpquigl@davequigley.com>

The existing NFSv4 xattr handlers do not accept xattr calls to the security
namespace. This patch extends these handlers to accept xattrs from the security
namespace in addition to the default NFSv4 ACL namespace.

Signed-off-by: Matthew N. Dodd <Matthew.Dodd@sparta.com>
Signed-off-by: Miguel Rodel Felipe <Rodel_FM@dsi.a-star.edu.sg>
Signed-off-by: Phua Eu Gene <PHUA_Eu_Gene@dsi.a-star.edu.sg>
Signed-off-by: Khin Mi Mi Aung <Mi_Mi_AUNG@dsi.a-star.edu.sg>
Signed-off-by: David Quigley <dpquigl@davequigley.com>
---
 fs/nfs/nfs4proc.c   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 security/security.c |  1 +
 2 files changed, 51 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 77d1a29..2c8dd55 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5632,6 +5632,53 @@ static size_t nfs4_xattr_list_nfs4_acl(struct dentry *dentry, char *list,
 	return len;
 }
 
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+static inline int nfs4_server_supports_labels(struct nfs_server *server)
+{
+	return server->caps & NFS_CAP_SECURITY_LABEL;
+}
+
+static int nfs4_xattr_set_nfs4_label(struct dentry *dentry, const char *key,
+				   const void *buf, size_t buflen,
+				   int flags, int type)
+{
+	if (security_ismaclabel(key))
+		return nfs4_set_security_label(dentry, buf, buflen);
+
+	return -EOPNOTSUPP;
+}
+
+static int nfs4_xattr_get_nfs4_label(struct dentry *dentry, const char *key,
+				   void *buf, size_t buflen, int type)
+{
+	if (security_ismaclabel(key))
+		return nfs4_get_security_label(dentry->d_inode, buf, buflen);
+	return -EOPNOTSUPP;
+}
+
+static size_t nfs4_xattr_list_nfs4_label(struct dentry *dentry, char *list,
+				       size_t list_len, const char *name,
+				       size_t name_len, int type)
+{
+	size_t len = 0;
+
+	if (nfs_server_capable(dentry->d_inode, NFS_CAP_SECURITY_LABEL)) {
+		len = security_inode_listsecurity(dentry->d_inode, NULL, 0);
+		if (list && len <= list_len)
+			security_inode_listsecurity(dentry->d_inode, list, len);
+	}
+	return len;
+}
+
+static const struct xattr_handler nfs4_xattr_nfs4_label_handler = {
+	.prefix = XATTR_SECURITY_PREFIX,
+	.list	= nfs4_xattr_list_nfs4_label,
+	.get	= nfs4_xattr_get_nfs4_label,
+	.set	= nfs4_xattr_set_nfs4_label,
+};
+#endif
+
+
 /*
  * nfs_fhget will use either the mounted_on_fileid or the fileid
  */
@@ -7590,6 +7637,9 @@ static const struct xattr_handler nfs4_xattr_nfs4_acl_handler = {
 
 const struct xattr_handler *nfs4_xattr_handlers[] = {
 	&nfs4_xattr_nfs4_acl_handler,
+#ifdef CONFIG_NFS_V4_SECURITY_LABEL
+	&nfs4_xattr_nfs4_label_handler,
+#endif
 	NULL
 };
 
diff --git a/security/security.c b/security/security.c
index 60a6017..310362b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -660,6 +660,7 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 		return 0;
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
 }
+EXPORT_SYMBOL(security_inode_listsecurity);
 
 void security_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-- 
1.7.11.7


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
