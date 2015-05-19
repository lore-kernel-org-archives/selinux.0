From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: enable per-file labeling for debugfs files.
Date: Tue, 19 May 2015 15:46:06 -0400
Message-Id: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add support for per-file labeling of debugfs files so that
we can distinguish them in policy.  This is particularly
important in Android where certain debugfs files have to be writable
by apps and therefore the debugfs directory tree can be read and
searched by all.

Since debugfs is entirely kernel-generated, the directory tree is
immutable by userspace, and the inodes are pinned in memory, we can
simply use the same approach as with proc and label the inodes from
policy based on pathname from the root of the debugfs filesystem.
Generalize the existing labeling support used for proc and reuse it
for debugfs too.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 43 ++++++++++++++++++-------------------
 security/selinux/include/security.h |  1 +
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7dade28..56c90dd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -724,7 +724,10 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	}
 
 	if (strcmp(sb->s_type->name, "proc") == 0)
-		sbsec->flags |= SE_SBPROC;
+		sbsec->flags |= SE_SBPROC | SE_SBGENFS;
+
+	if (strcmp(sb->s_type->name, "debugfs") == 0)
+		sbsec->flags |= SE_SBGENFS;
 
 	if (!sbsec->behavior) {
 		/*
@@ -1220,12 +1223,13 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 	return SECCLASS_SOCKET;
 }
 
-#ifdef CONFIG_PROC_FS
-static int selinux_proc_get_sid(struct dentry *dentry,
-				u16 tclass,
-				u32 *sid)
+static int selinux_genfs_get_sid(struct dentry *dentry,
+				 u16 tclass,
+				 u16 flags,
+				 u32 *sid)
 {
 	int rc;
+	struct super_block *sb = dentry->d_inode->i_sb;
 	char *buffer, *path;
 
 	buffer = (char *)__get_free_page(GFP_KERNEL);
@@ -1236,26 +1240,20 @@ static int selinux_proc_get_sid(struct dentry *dentry,
 	if (IS_ERR(path))
 		rc = PTR_ERR(path);
 	else {
-		/* each process gets a /proc/PID/ entry. Strip off the
-		 * PID part to get a valid selinux labeling.
-		 * e.g. /proc/1/net/rpc/nfs -> /net/rpc/nfs */
-		while (path[1] >= '0' && path[1] <= '9') {
-			path[1] = '/';
-			path++;
+		if (flags & SE_SBPROC) {
+			/* each process gets a /proc/PID/ entry. Strip off the
+			 * PID part to get a valid selinux labeling.
+			 * e.g. /proc/1/net/rpc/nfs -> /net/rpc/nfs */
+			while (path[1] >= '0' && path[1] <= '9') {
+				path[1] = '/';
+				path++;
+			}
 		}
-		rc = security_genfs_sid("proc", path, tclass, sid);
+		rc = security_genfs_sid(sb->s_type->name, path, tclass, sid);
 	}
 	free_page((unsigned long)buffer);
 	return rc;
 }
-#else
-static int selinux_proc_get_sid(struct dentry *dentry,
-				u16 tclass,
-				u32 *sid)
-{
-	return -EINVAL;
-}
-#endif
 
 /* The inode's security attributes must be initialized before first use. */
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
@@ -1412,7 +1410,7 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 		/* Default to the fs superblock SID. */
 		isec->sid = sbsec->sid;
 
-		if ((sbsec->flags & SE_SBPROC) && !S_ISLNK(inode->i_mode)) {
+		if ((sbsec->flags & SE_SBGENFS) && !S_ISLNK(inode->i_mode)) {
 			/* We must have a dentry to determine the label on
 			 * procfs inodes */
 			if (opt_dentry)
@@ -1435,7 +1433,8 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 			if (!dentry)
 				goto out_unlock;
 			isec->sclass = inode_mode_to_security_class(inode->i_mode);
-			rc = selinux_proc_get_sid(dentry, isec->sclass, &sid);
+			rc = selinux_genfs_get_sid(dentry, isec->sclass,
+						   sbsec->flags, &sid);
 			dput(dentry);
 			if (rc)
 				goto out_unlock;
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d1e0b23..36993ad 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -56,6 +56,7 @@
 /* Non-mount related flags */
 #define SE_SBINITIALIZED	0x0100
 #define SE_SBPROC		0x0200
+#define SE_SBGENFS		0x0400
 
 #define CONTEXT_STR	"context="
 #define FSCONTEXT_STR	"fscontext="
-- 
2.1.0
