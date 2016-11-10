From: Andreas Gruenbacher <agruenba@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, selinux@tycho.nsa.gov
Subject: [PATCH 2/4] proc: Pass file mode to proc_pid_make_inode
Date: Thu, 10 Nov 2016 22:18:28 +0100
Message-Id: <1478812710-17190-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
References: <1478812710-17190-1-git-send-email-agruenba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Pass the file mode of the proc inode to be created to
proc_pid_make_inode.  In proc_pid_make_inode, initialize inode->i_mode
before calling security_task_to_inode.  This allows selinux to set
isec->sclass right away without introducing "half-initialized" inode
security structs.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/proc/base.c           | 23 +++++++++--------------
 fs/proc/fd.c             |  6 ++----
 fs/proc/internal.h       |  2 +-
 fs/proc/namespaces.c     |  3 +--
 security/selinux/hooks.c |  1 +
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ca651ac..6eae4d0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1664,7 +1664,8 @@ const struct inode_operations proc_pid_link_inode_operations = {
 
 /* building an inode */
 
-struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *task)
+struct inode *proc_pid_make_inode(struct super_block * sb,
+				  struct task_struct *task, umode_t mode)
 {
 	struct inode * inode;
 	struct proc_inode *ei;
@@ -1678,6 +1679,7 @@ struct inode *proc_pid_make_inode(struct super_block * sb, struct task_struct *t
 
 	/* Common stuff */
 	ei = PROC_I(inode);
+	inode->i_mode = mode;
 	inode->i_ino = get_next_ino();
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_op = &proc_def_inode_operations;
@@ -2004,7 +2006,9 @@ proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK |
+				    ((mode & FMODE_READ ) ? S_IRUSR : 0) |
+				    ((mode & FMODE_WRITE) ? S_IWUSR : 0));
 	if (!inode)
 		return -ENOENT;
 
@@ -2013,12 +2017,6 @@ proc_map_files_instantiate(struct inode *dir, struct dentry *dentry,
 
 	inode->i_op = &proc_map_files_link_inode_operations;
 	inode->i_size = 64;
-	inode->i_mode = S_IFLNK;
-
-	if (mode & FMODE_READ)
-		inode->i_mode |= S_IRUSR;
-	if (mode & FMODE_WRITE)
-		inode->i_mode |= S_IWUSR;
 
 	d_set_d_op(dentry, &tid_map_files_dentry_operations);
 	d_add(dentry, inode);
@@ -2372,12 +2370,11 @@ static int proc_pident_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, p->mode);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = p->mode;
 	if (S_ISDIR(inode->i_mode))
 		set_nlink(inode, 2);	/* Use getattr to fix if necessary */
 	if (p->iop)
@@ -3059,11 +3056,10 @@ static int proc_pid_instantiate(struct inode *dir,
 {
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 	if (!inode)
 		goto out;
 
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tgid_base_inode_operations;
 	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
@@ -3352,11 +3348,10 @@ static int proc_task_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
 	struct inode *inode;
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
 
 	if (!inode)
 		goto out;
-	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
 	inode->i_op = &proc_tid_base_inode_operations;
 	inode->i_fop = &proc_tid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index d21dafe..4274f83 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -183,14 +183,13 @@ proc_fd_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
 	ei->fd = fd;
 
-	inode->i_mode = S_IFLNK;
 	inode->i_op = &proc_pid_link_inode_operations;
 	inode->i_size = 64;
 
@@ -322,14 +321,13 @@ proc_fdinfo_instantiate(struct inode *dir, struct dentry *dentry,
 	struct proc_inode *ei;
 	struct inode *inode;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFREG | S_IRUSR);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
 	ei->fd = fd;
 
-	inode->i_mode = S_IFREG | S_IRUSR;
 	inode->i_fop = &proc_fdinfo_file_operations;
 
 	d_set_d_op(dentry, &tid_fd_dentry_operations);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 5378441..f4494dc 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,7 +162,7 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
 extern const struct dentry_operations pid_dentry_operations;
 extern int pid_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int proc_setattr(struct dentry *, struct iattr *);
-extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *);
+extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern int pid_revalidate(struct dentry *, unsigned int);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 51b8b0a..766f0c6 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -92,12 +92,11 @@ static int proc_ns_instantiate(struct inode *dir,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dir->i_sb, task);
+	inode = proc_pid_make_inode(dir->i_sb, task, S_IFLNK | S_IRWXUGO);
 	if (!inode)
 		goto out;
 
 	ei = PROC_I(inode);
-	inode->i_mode = S_IFLNK|S_IRWXUGO;
 	inode->i_op = &proc_ns_link_inode_operations;
 	ei->ns_ops = ns_ops;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b98ab2a..e4527d9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3954,6 +3954,7 @@ static void selinux_task_to_inode(struct task_struct *p,
 	struct inode_security_struct *isec = inode->i_security;
 	u32 sid = task_sid(p);
 
+	isec->sclass = inode_mode_to_security_class(inode->i_mode);
 	isec->sid = sid;
 	isec->initialized = LABEL_INITIALIZED;
 }
-- 
2.7.4
