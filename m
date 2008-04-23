Subject: [PATCH -v3] LSM/SELinux: show LSM mount options in /proc/mounts
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: jmorris@namei.org, sds@tycho.nsa.gov, mszeredi@suse.cz,
        casey@schaufler-ca.com
Content-Type: text/plain
Date: Wed, 23 Apr 2008 15:53:57 -0400
Message-Id: <1208980437.2985.120.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch causes SELinux mount options to show up in /proc/mounts.  As
with other code in the area seq_put errors are ignored.  Other LSM's
will not have their mount options displayed until they fill in their own
security_sb_show_options() function.
    
Signed-off-by: Eric Paris <eparis@redhat.com>

---

 fs/namespace.c           |    3 +-
 include/linux/security.h |    9 +++++++
 security/dummy.c         |    6 +++++
 security/security.c      |    5 ++++
 security/selinux/hooks.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1bf302d..35a437e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -716,7 +716,8 @@ static int show_vfsmnt(struct seq_file *m, void *v)
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
-	if (mnt->mnt_sb->s_op->show_options)
+	err = security_sb_show_options(m, mnt->mnt_sb);
+	if (!err && mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
 	return err;
diff --git a/include/linux/security.h b/include/linux/security.h
index 53a3453..a85d429 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -78,6 +78,7 @@ struct xfrm_selector;
 struct xfrm_policy;
 struct xfrm_state;
 struct xfrm_user_sec_ctx;
+struct seq_file;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
 extern int cap_netlink_recv(struct sk_buff *skb, int cap);
@@ -1314,6 +1315,7 @@ struct security_operations {
 	void (*sb_free_security) (struct super_block * sb);
 	int (*sb_copy_data)(char *orig, char *copy);
 	int (*sb_kern_mount) (struct super_block *sb, void *data);
+	int (*sb_show_options) (struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs) (struct dentry *dentry);
 	int (*sb_mount) (char *dev_name, struct path *path,
 			 char *type, unsigned long flags, void *data);
@@ -1592,6 +1594,7 @@ int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, char *copy);
 int security_sb_kern_mount(struct super_block *sb, void *data);
+int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
 int security_sb_mount(char *dev_name, struct path *path,
                        char *type, unsigned long flags, void *data);
@@ -1867,6 +1870,12 @@ static inline int security_sb_kern_mount (struct super_block *sb, void *data)
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
index b0232bb..369a282 100644
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
@@ -1057,6 +1062,7 @@ void security_fixup_ops (struct security_operations *ops)
 	set_to_dummy_if_null(ops, sb_free_security);
 	set_to_dummy_if_null(ops, sb_copy_data);
 	set_to_dummy_if_null(ops, sb_kern_mount);
+	set_to_dummy_if_null(ops, sb_show_options);
 	set_to_dummy_if_null(ops, sb_statfs);
 	set_to_dummy_if_null(ops, sb_mount);
 	set_to_dummy_if_null(ops, sb_check_sb);
diff --git a/security/security.c b/security/security.c
index 8a285c7..4ebe847 100644
--- a/security/security.c
+++ b/security/security.c
@@ -291,6 +291,11 @@ int security_sb_kern_mount(struct super_block *sb, void *data)
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
index 308e2cf..24eb950 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -9,7 +9,8 @@
  *	      James Morris <jmorris@redhat.com>
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
- *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *  Copyright (C) 2003-2008 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *					   Eric Paris <eparis@redhat.com>
  *  Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  *			    <dgoeddel@trustedcs.com>
  *  Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
@@ -955,6 +956,57 @@ out_err:
 	return rc;
 }
 
+void selinux_write_opts(struct seq_file *m, struct security_mnt_opts *opts)
+{
+	int i;
+	char *prefix;
+
+	for (i = 0; i < opts->num_mnt_opts; i++) {
+		char *has_comma = strchr(opts->mnt_opts[i], ',');
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
+		/* we need a comma before each option */
+		seq_putc(m, ',');
+		seq_puts(m, prefix);
+		if (has_comma)
+			seq_putc(m, '\"');
+		seq_puts(m, opts->mnt_opts[i]);
+		if (has_comma)
+			seq_putc(m, '\"');
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
@@ -5328,6 +5380,7 @@ static struct security_operations selinux_ops = {
 	.sb_free_security =		selinux_sb_free_security,
 	.sb_copy_data =			selinux_sb_copy_data,
 	.sb_kern_mount =		selinux_sb_kern_mount,
+	.sb_show_options=		selinux_sb_show_options,
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
