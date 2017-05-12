From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: do not check open permission on sockets
Date: Fri, 12 May 2017 12:41:24 -0400
Message-Id: <20170512164124.16981-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

open permission is currently only defined for files in the kernel
(COMMON_FILE_PERMS rather than COMMON_FILE_SOCK_PERMS). Construction of
an artificial test case that tries to open a socket via /proc/pid/fd will
generate a recvfrom avc denial because recvfrom and open happen to map to
the same permission bit in socket vs file classes.

open of a socket via /proc/pid/fd is not supported by the kernel regardless
and will ultimately return ENXIO. But we hit the permission check first and
can thus produce these odd/misleading denials.  Omit the open check when
operating on a socket.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526..dd356ed 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2063,8 +2063,9 @@ static inline u32 file_to_av(struct file *file)
 static inline u32 open_file_to_av(struct file *file)
 {
 	u32 av = file_to_av(file);
+	struct inode *inode = file_inode(file);
 
-	if (selinux_policycap_openperm)
+	if (selinux_policycap_openperm && inode->i_sb->s_magic != SOCKFS_MAGIC)
 		av |= FILE__OPEN;
 
 	return av;
@@ -3059,6 +3060,7 @@ static int selinux_inode_permission(struct inode *inode, int mask)
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	const struct cred *cred = current_cred();
+	struct inode *inode = d_backing_inode(dentry);
 	unsigned int ia_valid = iattr->ia_valid;
 	__u32 av = FILE__WRITE;
 
@@ -3074,8 +3076,10 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
 		return dentry_has_perm(cred, dentry, FILE__SETATTR);
 
-	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
-			&& !(ia_valid & ATTR_FILE))
+	if (selinux_policycap_openperm &&
+	    inode->i_sb->s_magic != SOCKFS_MAGIC &&
+	    (ia_valid & ATTR_SIZE) &&
+	    !(ia_valid & ATTR_FILE))
 		av |= FILE__OPEN;
 
 	return dentry_has_perm(cred, dentry, av);
-- 
2.9.3
