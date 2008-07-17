Subject: [PATCH] SELinux: /proc/mounts shoudl show what it can
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov, marc.c.dionne@gmail.com,
        mszeredi@suse.cz
Content-Type: text/plain
Date: Wed, 16 Jul 2008 21:42:30 -0400
Message-Id: <1216258950.3070.78.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Given a hosed SELinux config in which a system never loads policy or
disables SELinux we currently just return -EINVAL for anyone trying to
read /proc/mounts.  This is a configuration problem but we can certainly
be more graceful.  This patch just ignores errors from displaying LSM
options and causes /proc/mounts display everything else it can.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

Marc I hope this fixes your problem.

I could continue to fail showing /proc/mounts rather than skip them on
-ENOMEM but -EINVAL errors actually indicate there are no SELinux
options so just skipping along is the right thing to do.  I lean towards
just skipping on any error like this patch does.  The alternative is
selinux_sb_show_options() we can check if the error was -EINVAL and just
return 0 and return the actual error if it was anything else.  James,
Steve, anyone have feelings on this?

 fs/namespace.c           |   13 ++++---------
 include/linux/security.h |   10 ++++------
 security/capability.c    |    6 ++----
 security/security.c      |    4 ++--
 security/selinux/hooks.c |    9 ++++-----
 5 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 4f6f763..3d2d48f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -750,7 +750,7 @@ struct proc_fs_info {
 	const char *str;
 };
 
-static int show_sb_opts(struct seq_file *m, struct super_block *sb)
+static void show_sb_opts(struct seq_file *m, struct super_block *sb)
 {
 	static const struct proc_fs_info fs_info[] = {
 		{ MS_SYNCHRONOUS, ",sync" },
@@ -765,7 +765,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 			seq_puts(m, fs_infop->str);
 	}
 
-	return security_sb_show_options(m, sb);
+	security_sb_show_options(m, sb);
 }
 
 static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
@@ -808,14 +808,11 @@ static int show_vfsmnt(struct seq_file *m, void *v)
 	seq_putc(m, ' ');
 	show_type(m, mnt->mnt_sb);
 	seq_puts(m, __mnt_is_readonly(mnt) ? " ro" : " rw");
-	err = show_sb_opts(m, mnt->mnt_sb);
-	if (err)
-		goto out;
+	show_sb_opts(m, mnt->mnt_sb);
 	show_mnt_opts(m, mnt);
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
-out:
 	return err;
 }
 
@@ -870,9 +867,7 @@ static int show_mountinfo(struct seq_file *m, void *v)
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_puts(m, sb->s_flags & MS_RDONLY ? " ro" : " rw");
-	err = show_sb_opts(m, sb);
-	if (err)
-		goto out;
+	show_sb_opts(m, sb);
 	if (sb->s_op->show_options)
 		err = sb->s_op->show_options(m, mnt);
 	seq_putc(m, '\n');
diff --git a/include/linux/security.h b/include/linux/security.h
index 31c8851..c72f4f6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1323,7 +1323,7 @@ struct security_operations {
 	void (*sb_free_security) (struct super_block *sb);
 	int (*sb_copy_data) (char *orig, char *copy);
 	int (*sb_kern_mount) (struct super_block *sb, void *data);
-	int (*sb_show_options) (struct seq_file *m, struct super_block *sb);
+	void (*sb_show_options) (struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs) (struct dentry *dentry);
 	int (*sb_mount) (char *dev_name, struct path *path,
 			 char *type, unsigned long flags, void *data);
@@ -1596,7 +1596,7 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
 int security_sb_kern_mount(struct super_block *sb, void *data);
-int security_sb_show_options(struct seq_file *m, struct super_block *sb);
+void security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(char *dev_name, struct path *path,
 		      char *type, unsigned long flags, void *data);
@@ -1872,11 +1872,9 @@ static inline int security_sb_kern_mount(struct super_block *sb, void *data)
 	return 0;
 }
 
-static inline int security_sb_show_options(struct seq_file *m,
+static inline void security_sb_show_options(struct seq_file *m,
 					   struct super_block *sb)
-{
-	return 0;
-}
+{ }
 
 static inline int security_sb_statfs(struct dentry *dentry)
 {
diff --git a/security/capability.c b/security/capability.c
index 5b01c0b..368c53a 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -69,10 +69,8 @@ static int cap_sb_kern_mount(struct super_block *sb, void *data)
 	return 0;
 }
 
-static int cap_sb_show_options(struct seq_file *m, struct super_block *sb)
-{
-	return 0;
-}
+static void cap_sb_show_options(struct seq_file *m, struct super_block *sb)
+{ }
 
 static int cap_sb_statfs(struct dentry *dentry)
 {
diff --git a/security/security.c b/security/security.c
index 59f23b5..e81ba4d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -258,9 +258,9 @@ int security_sb_kern_mount(struct super_block *sb, void *data)
 	return security_ops->sb_kern_mount(sb, data);
 }
 
-int security_sb_show_options(struct seq_file *m, struct super_block *sb)
+void security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return security_ops->sb_show_options(m, sb);
+	security_ops->sb_show_options(m, sb);
 }
 
 int security_sb_statfs(struct dentry *dentry)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 63f131f..4b67e65 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -992,20 +992,19 @@ void selinux_write_opts(struct seq_file *m, struct security_mnt_opts *opts)
 	}
 }
 
-static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
+static void selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
 	struct security_mnt_opts opts;
 	int rc;
 
-	rc = selinux_get_mnt_opts(sb, &opts);
-	if (rc)
-		return rc;
+	if (selinux_get_mnt_opts(sb, &opts))
+		return;
 
 	selinux_write_opts(m, &opts);
 
 	security_free_mnt_opts(&opts);
 
-	return rc;
+	return;
 }
 
 static inline u16 inode_mode_to_security_class(umode_t mode)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
