Subject: [PATCH 2/2] SELinux: display SELinux mount options in /proc/mounts
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org,
        linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu
Content-Type: text/plain
Date: Tue, 01 Apr 2008 13:24:12 -0400
Message-Id: <1207070652.3556.16.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch causes SELinux mount options to show up in /proc/mounts.  As
with other code in the area seq_put errors are ignored.  Other LSM's
will not have their mount options displayed until they fill in their own
security_sb_show_options() function.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

fs/namespace.c           |    4 +++
 include/linux/security.h |    9 ++++++++
 security/dummy.c         |    6 +++++
 security/security.c      |    5 ++++
 security/selinux/hooks.c |   52 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 94f026e..a9748d3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -426,8 +426,12 @@ static int show_vfsmnt(struct seq_file *m, void *v)
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	err = security_sb_show_options(m, mnt->mnt_sb);
+	if (err)
+		goto out;
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
+out:
 	seq_puts(m, " 0 0\n");
 	return err;
 }
diff --git a/include/linux/security.h b/include/linux/security.h
index c673dfd..bb3c7eb 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -74,6 +74,7 @@ struct xfrm_selector;
 struct xfrm_policy;
 struct xfrm_state;
 struct xfrm_user_sec_ctx;
+struct seq_file;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
 extern int cap_netlink_recv(struct sk_buff *skb, int cap);
@@ -1259,6 +1260,7 @@ struct security_operations {
 	void (*sb_free_security) (struct super_block * sb);
 	int (*sb_copy_data)(char *orig, char *copy);
 	int (*sb_kern_mount) (struct super_block *sb, void *data);
+	int (*sb_show_options) (struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs) (struct dentry *dentry);
 	int (*sb_mount) (char *dev_name, struct nameidata * nd,
 			 char *type, unsigned long flags, void *data);
@@ -1527,6 +1529,7 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
 int security_sb_kern_mount(struct super_block *sb, void *data);
+int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(char *dev_name, struct nameidata *nd,
                        char *type, unsigned long flags, void *data);
@@ -1800,6 +1803,12 @@ static inline int security_sb_kern_mount (struct super_block *sb, void *data)
 	return 0;
 }
 
+static inline int security_sb_show_options(struct seq_file *m,
+					   struct super_block *sb)
+{
+	return 0;
+}
+
 static inline int security_sb_statfs (struct dentry *dentry)
 {
 	return 0;
diff --git a/security/dummy.c b/security/dummy.c
index 78d8f92..3aed4bc 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -191,6 +191,11 @@ static int dummy_sb_kern_mount (struct super_block *sb, void *data)
 	return 0;
 }
 
+static int dummy_sb_show_options(struct seq_file *m, struct super_block *sb)
+{
+	return 0;
+}
+
 static int dummy_sb_statfs (struct dentry *dentry)
 {
 	return 0;
@@ -1017,6 +1022,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, sb_free_security);
 	set_to_dummy_if_null(ops, sb_copy_data);
 	set_to_dummy_if_null(ops, sb_kern_mount);
+	set_to_dummy_if_null(ops, sb_show_options);
 	set_to_dummy_if_null(ops, sb_statfs);
 	set_to_dummy_if_null(ops, sb_mount);
 	set_to_dummy_if_null(ops, sb_check_sb);
diff --git a/security/security.c b/security/security.c
index b1387a6..5e3a3bd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -255,6 +255,11 @@ int security_sb_kern_mount(struct super_block *sb, void *data)
 	return security_ops->sb_kern_mount(sb, data);
 }
 
+int security_sb_show_options(struct seq_file *m, struct super_block *sb)
+{
+	return security_ops->sb_show_options(m, sb);
+}
+
 int security_sb_statfs(struct dentry *dentry)
 {
 	return security_ops->sb_statfs(dentry);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d6aa4a6..46b307c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -9,7 +9,8 @@
  *            James Morris <jmorris@redhat.com>
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
- *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *  Copyright (C) 2003-2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *					   Eric Paris <eparis@redhat.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *                          <dgoeddel@trustedcs.com>
  *  Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
@@ -19,7 +20,7 @@
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	as published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
@@ -947,6 +948,52 @@ out_err:
 	return rc;
 }
 
+void selinux_write_opts(struct seq_file *m, struct security_mnt_opts *opts)
+{
+	int i;
+	char *prefix;
+
+	for (i = 0; i < opts->num_mnt_opts; i++) {
+		/* we need a comma before each option */
+		seq_putc(m, ',');
+
+		switch (opts->mnt_opts_flags[i]) {
+		case CONTEXT_MNT:
+			prefix = CONTEXT_STR;
+			break;
+		case FSCONTEXT_MNT:
+			prefix = FSCONTEXT_STR;
+			break;
+		case ROOTCONTEXT_MNT:
+			prefix = ROOTCONTEXT_STR;
+			break;
+		case DEFCONTEXT_MNT:
+			prefix = DEFCONTEXT_STR;
+			break;
+		default:
+			BUG();
+		};
+		seq_puts(m, prefix);
+		seq_puts(m, opts->mnt_opts[i]);
+	}
+}
+
+static int selinux_sb_show_options(struct seq_file *m, struct super_block *sb)
+{
+	struct security_mnt_opts opts;
+	int rc;
+
+	rc = selinux_get_mnt_opts(sb, &opts);
+	if (rc)
+		return rc;
+
+	selinux_write_opts(m, &opts);
+
+	security_free_mnt_opts(&opts);
+
+	return rc;
+}
+
 static inline u16 inode_mode_to_security_class(umode_t mode)
 {
 	switch (mode & S_IFMT) {
@@ -5257,6 +5304,7 @@ static struct security_operations selinux_ops = {
 	.sb_free_security =		selinux_sb_free_security,
 	.sb_copy_data =			selinux_sb_copy_data,
 	.sb_kern_mount =	        selinux_sb_kern_mount,
+	.sb_show_options =		selinux_sb_show_options,
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
