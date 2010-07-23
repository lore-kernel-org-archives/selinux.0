From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/5] vfs: re-introduce MAY_CHDIR
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Fri, 23 Jul 2010 11:43:51 -0400
Message-ID: <20100723154351.13217.85595.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently MAY_ACCESS means that filesystems must check the permissions
right then and not rely on cached results or the results of future
operations on the object.  This can be because of a call to sys_access() or
because of a call to chdir() which needs to check search without relying on
any future operations inside that dir.  I plan to use MAY_ACCESS for other
purposes in the security system, so I split the MAY_ACCESS and the
MAY_CHDIR cases.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 fs/fuse/dir.c      |    2 +-
 fs/nfs/dir.c       |    2 +-
 fs/open.c          |    6 +++---
 include/linux/fs.h |    1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3978a42..c9627c9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1016,7 +1016,7 @@ static int fuse_permission(struct inode *inode, int mask)
 		   exist.  So if permissions are revoked this won't be
 		   noticed immediately, only after the attribute
 		   timeout has expired */
-	} else if (mask & MAY_ACCESS) {
+	} else if (mask & (MAY_ACCESS | MAY_CHDIR)) {
 		err = fuse_access(inode, mask);
 	} else if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode)) {
 		if (!(inode->i_mode & S_IXUGO)) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e60416d..832e9e2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1953,7 +1953,7 @@ int nfs_permission(struct inode *inode, int mask)
 	if ((mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) == 0)
 		goto out;
 	/* Is this sys_access() ? */
-	if (mask & MAY_ACCESS)
+	if (mask & (MAY_ACCESS | MAY_CHDIR))
 		goto force_lookup;
 
 	switch (inode->i_mode & S_IFMT) {
diff --git a/fs/open.c b/fs/open.c
index b25a74c..b715d06 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -367,7 +367,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_ACCESS);
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -396,7 +396,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!S_ISDIR(inode->i_mode))
 		goto out_putf;
 
-	error = inode_permission(inode, MAY_EXEC | MAY_ACCESS);
+	error = inode_permission(inode, MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &file->f_path);
 out_putf:
@@ -414,7 +414,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_ACCESS);
+	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3ec49c2..f9c08f4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -53,6 +53,7 @@ struct inodes_stat_t {
 #define MAY_APPEND 8
 #define MAY_ACCESS 16
 #define MAY_OPEN 32
+#define MAY_CHDIR 64
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
