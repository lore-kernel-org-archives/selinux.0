From: Andreas Gruenbacher <agruenba@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, linux-fsdevel@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [RFC 2/2] overlayfs: Make getxattr work with inode only
Date: Mon, 30 May 2016 15:59:02 +0200
Message-Id: <1464616742-29271-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
References: <1464616742-29271-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change the getxattr inode operation to only use its inode argument, and
ignore the dentry.  This is possible because on overlayfs, each dentry
has a separate inode and inodes are not shared among dentries.  Allows
SELinux to work on top of overlayfs.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/overlayfs/inode.c     | 26 +++++++++++++++-----------
 fs/overlayfs/overlayfs.h |  1 +
 fs/overlayfs/super.c     | 10 +++++++---
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 8c3f985..7acc145 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -238,29 +238,32 @@ out:
 	return err;
 }
 
-static bool ovl_need_xattr_filter(struct dentry *dentry,
+static bool ovl_need_xattr_filter(struct inode *inode,
 				  enum ovl_path_type type)
 {
 	if ((type & (__OVL_PATH_PURE | __OVL_PATH_UPPER)) == __OVL_PATH_UPPER)
-		return S_ISDIR(dentry->d_inode->i_mode);
+		return S_ISDIR(inode->i_mode);
 	else
 		return false;
 }
 
-ssize_t ovl_getxattr(struct dentry *dentry, struct inode *inode,
+ssize_t ovl_getxattr(struct dentry *unused, struct inode *inode,
 		     const char *name, void *value, size_t size)
 {
-	struct path realpath;
+	struct ovl_entry *oe = inode->i_private;
 	enum ovl_path_type type;
+	struct dentry *realdentry;
+	bool is_upper;
 
-	if (!dentry)
-		return -ECHILD;
+	realdentry = ovl_entry_real(oe, &is_upper);
+	if (!realdentry->d_inode)
+		return -ENOENT;
 
-	type = ovl_path_real(dentry, &realpath);
-	if (ovl_need_xattr_filter(dentry, type) && ovl_is_private_xattr(name))
+	type = __ovl_path_type(oe, inode->i_mode);
+	if (ovl_need_xattr_filter(inode, type) && ovl_is_private_xattr(name))
 		return -ENODATA;
 
-	return vfs_getxattr(realpath.dentry, name, value, size);
+	return vfs_getxattr(realdentry, name, value, size);
 }
 
 ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
@@ -274,7 +277,7 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	if (res <= 0 || size == 0)
 		return res;
 
-	if (!ovl_need_xattr_filter(dentry, type))
+	if (!ovl_need_xattr_filter(dentry->d_inode, type))
 		return res;
 
 	/* filter out private xattrs */
@@ -306,7 +309,8 @@ int ovl_removexattr(struct dentry *dentry, const char *name)
 		goto out;
 
 	err = -ENODATA;
-	if (ovl_need_xattr_filter(dentry, type) && ovl_is_private_xattr(name))
+	if (ovl_need_xattr_filter(dentry->d_inode, type) &&
+	    ovl_is_private_xattr(name))
 		goto out_drop_write;
 
 	if (!OVL_TYPE_UPPER(type)) {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 4bd9b5b..0d1430f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -131,6 +131,7 @@ static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
+enum ovl_path_type __ovl_path_type(struct ovl_entry *oe, umode_t mode);
 enum ovl_path_type ovl_path_type(struct dentry *dentry);
 u64 ovl_dentry_version_get(struct dentry *dentry);
 void ovl_dentry_version_inc(struct dentry *dentry);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ce02f46..d04546e 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -70,9 +70,8 @@ static struct dentry *__ovl_dentry_lower(struct ovl_entry *oe)
 	return oe->numlower ? oe->lowerstack[0].dentry : NULL;
 }
 
-enum ovl_path_type ovl_path_type(struct dentry *dentry)
+enum ovl_path_type __ovl_path_type(struct ovl_entry *oe, umode_t mode)
 {
-	struct ovl_entry *oe = dentry->d_fsdata;
 	enum ovl_path_type type = 0;
 
 	if (oe->__upperdentry) {
@@ -82,7 +81,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 		 * Non-dir dentry can hold lower dentry from previous
 		 * location. Its purity depends only on opaque flag.
 		 */
-		if (oe->numlower && S_ISDIR(dentry->d_inode->i_mode))
+		if (oe->numlower && S_ISDIR(mode))
 			type |= __OVL_PATH_MERGE;
 		else if (!oe->opaque)
 			type |= __OVL_PATH_PURE;
@@ -93,6 +92,11 @@ enum ovl_path_type ovl_path_type(struct dentry *dentry)
 	return type;
 }
 
+enum ovl_path_type ovl_path_type(struct dentry *dentry)
+{
+	return __ovl_path_type(dentry->d_fsdata, dentry->d_inode->i_mode);
+}
+
 static struct dentry *ovl_upperdentry_dereference(struct ovl_entry *oe)
 {
 	return lockless_dereference(oe->__upperdentry);
-- 
2.5.5
