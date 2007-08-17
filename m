From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: jmorris@namei.org
Cc: selinux@tycho.nsa.gov, "David P. Quigley" <dpquigl@tycho.nsa.gov>
Subject: [PATCH 2/2] VFS: Reorder vfs_getxattr to avoid unnecessary calls to the LSM
Date: Fri, 17 Aug 2007 13:01:14 -0400
Message-Id: <11873700741876-git-send-email-dpquigl@tycho.nsa.gov>
In-Reply-To: <1187370074408-git-send-email-dpquigl@tycho.nsa.gov>
References: <1187370074408-git-send-email-dpquigl@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: David P. Quigley <dpquigl@tycho.nsa.gov>

	Originally vfs_getxattr would pull the security xattr variable using
the inode getxattr handle and then proceed to clobber it with a subsequent call
to the LSM. This patch reorders the two operations such that when the xattr
requested is in the security namespace it first attempts to grab the value from
the LSM directly. If it fails to obtain the value because there is no module
present or the module does not support the operation it will fall back to using
the inode getxattr operation. In the event that both are inaccessible it
returns EOPNOTSUPP.

Signed-off-by: David P. Quigley <dpquigl@tycho.nsa.gov>
---
 fs/xattr.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 6d59a72..e04a030 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -142,11 +142,6 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
 	if (error)
 		return error;
 
-	if (inode->i_op->getxattr)
-		error = inode->i_op->getxattr(dentry, name, value, size);
-	else
-		error = -EOPNOTSUPP;
-
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 				XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
@@ -155,9 +150,15 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
 		 * Only overwrite the return value if a security module
 		 * is actually active.
 		 */
-		if (ret != -EOPNOTSUPP)
-			error = ret;
+		if (ret == -EOPNOTSUPP)
+			goto nolsm;
+		return ret;
 	}
+nolsm:
+	if (inode->i_op->getxattr)
+		error = inode->i_op->getxattr(dentry, name, value, size);
+	else
+		error = -EOPNOTSUPP;
 
 	return error;
 }
-- 
1.5.2.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
