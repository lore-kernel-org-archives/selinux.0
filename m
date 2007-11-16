Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lAGK6WWp018352
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 15:06:32 -0500
Subject: [PATCH 02/13] VFS: Reorder vfs_getxattr to avoid unnecessary calls
	to the LSM
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: labeled-nfs@linux-nfs.org
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 15:06:31 -0500
Message-Id: <1195243591.20981.7.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
index 56b5b88..91c7929 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -145,11 +145,6 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
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
@@ -158,9 +153,15 @@ vfs_getxattr(struct dentry *dentry, char *name, void *value, size_t size)
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
1.5.3.4



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
