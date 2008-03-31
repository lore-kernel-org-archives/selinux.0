Subject: Re: [RFC] SELinux: display mount options in /proc/mounts
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1206991098.5610.81.camel@moss-spartans.epoch.ncsc.mil>
References: <1206990227.2878.61.camel@localhost.localdomain>
	 <1206991098.5610.81.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 18:33:30 -0400
Message-Id: <1207002810.2878.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-03-31 at 15:18 -0400, Stephen Smalley wrote:
> On Mon, 2008-03-31 at 15:03 -0400, Eric Paris wrote:
> > This patch will display selinux mount options in /proc/mounts.  It does
> > so by building a complete string and then writing it to the seq_file.  I
> > could cut a fair bit of this patch out by just writing things piecemeal
> > to the seq_file but when I did that none of the code looked like it
> > could ever be used again.  Do we think we'll ever have another need to
> > turn a superblock back into an option string?  Should I just make this
> > patch as small as possible?
> 
> Isn't that the point of using seq_file in the first place?  Offhand, I'd
> vote for simplifying the implementation even if it makes the usage
> specialized.

How about something this then?  I can (should?) break this down into a
separate #define changes and new functionality change...   But I'll take
comments on this patch...

-Eric

---

 fs/namespace.c                      |    4 ++
 include/linux/security.h            |    9 +++++
 security/dummy.c                    |    6 +++
 security/security.c                 |    5 +++
 security/selinux/hooks.c            |   69 ++++++++++++++++++++++++++++++-----
 security/selinux/include/security.h |    5 +++
 6 files changed, 89 insertions(+), 9 deletions(-)

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
index c673dfd..2743bf2 100644
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
 
+static inline int security_sb_show_options (struct seq_file *m,
+					    struct super_block *sb)
+{
+	return 0;
+}
+
 static inline int security_sb_statfs (struct dentry *dentry)
 {
 	return 0;
diff --git a/security/dummy.c b/security/dummy.c
index 78d8f92..7f8ac13 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -191,6 +191,11 @@ static int dummy_sb_kern_mount (struct super_block *sb, void *data)
 	return 0;
 }
 
+static int dummy_sb_show_options (struct seq_file *m, struct super_block *sb)
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
index b1387a6..93e6309 100644
--- a/security/security.c
+++ b/security/security.c
@@ -255,6 +255,11 @@ int security_sb_kern_mount(struct super_block *sb, void *data)
 	return security_ops->sb_kern_mount(sb, data);
 }
 
+int security_sb_show_options (struct seq_file *m, struct super_block *sb)
+{
+	return security_ops->sb_show_options(m, sb);
+}
+
 int security_sb_statfs(struct dentry *dentry)
 {
 	return security_ops->sb_statfs(dentry);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 41a049f..d18a674 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -16,10 +16,11 @@
  *                Paul Moore <paul.moore@hp.com>
  *  Copyright (C) 2007 Hitachi Software Engineering Co., Ltd.
  *                     Yuichi Nakamura <ynakam@hitachisoft.jp>
+ *  Copyright (C) 2006-2008 Red Hat, Inc., Eric Paris <eparis@redhat.com>
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
- *      as published by the Free Software Foundation.
+ *	as published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
@@ -324,10 +325,10 @@ enum {
 };
 
 static match_table_t tokens = {
-	{Opt_context, "context=%s"},
-	{Opt_fscontext, "fscontext=%s"},
-	{Opt_defcontext, "defcontext=%s"},
-	{Opt_rootcontext, "rootcontext=%s"},
+	{Opt_context, CONTEXT_STR "%s"},
+	{Opt_fscontext, FSCONTEXT_STR "%s"},
+	{Opt_defcontext, DEFCONTEXT_STR "%s"},
+	{Opt_rootcontext, ROOTCONTEXT_STR "%s"},
 	{Opt_error, NULL},
 };
 
@@ -947,6 +948,55 @@ out_err:
 	return rc;
 }
 
+int selinux_write_opts(struct seq_file *m, struct security_mnt_opts *opts)
+{
+	int i, rc;
+	char *prefix;
+
+	for(i = 0; i < opts->num_mnt_opts; i++) {
+		/* we need a comma before each option */
+		rc = seq_putc(m, ',');
+		if (rc)
+			return rc;
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
+	return 0;
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
+	rc = selinux_write_opts(m, &opts);
+
+	security_free_mnt_opts(&opts);
+
+	return rc;
+}
+
 static inline u16 inode_mode_to_security_class(umode_t mode)
 {
 	switch (mode & S_IFMT) {
@@ -2232,10 +2282,10 @@ static inline int match_prefix(char *prefix, int plen, char *option, int olen)
 
 static inline int selinux_option(char *option, int len)
 {
-	return (match_prefix("context=", sizeof("context=")-1, option, len) ||
-	        match_prefix("fscontext=", sizeof("fscontext=")-1, option, len) ||
-	        match_prefix("defcontext=", sizeof("defcontext=")-1, option, len) ||
-		match_prefix("rootcontext=", sizeof("rootcontext=")-1, option, len));
+	return (match_prefix(CONTEXT_STR, sizeof(CONTEXT_STR)-1, option, len) ||
+	        match_prefix(FSCONTEXT_STR, sizeof(FSCONTEXT_STR)-1, option, len) ||
+	        match_prefix(DEFCONTEXT_STR, sizeof(DEFCONTEXT_STR)-1, option, len) ||
+		match_prefix(ROOTCONTEXT_STR, sizeof(ROOTCONTEXT_STR)-1, option, len));
 }
 
 static inline void take_option(char **to, char *from, int *first, int len)
@@ -5257,6 +5307,7 @@ static struct security_operations selinux_ops = {
 	.sb_free_security =		selinux_sb_free_security,
 	.sb_copy_data =			selinux_sb_copy_data,
 	.sb_kern_mount =	        selinux_sb_kern_mount,
+	.sb_show_options =		selinux_sb_show_options,
 	.sb_statfs =			selinux_sb_statfs,
 	.sb_mount =			selinux_mount,
 	.sb_umount =			selinux_umount,
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f7d2f03..63e0171 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -40,6 +40,11 @@
 #define ROOTCONTEXT_MNT	0x04
 #define DEFCONTEXT_MNT	0x08
 
+#define CONTEXT_STR	"context="
+#define FSCONTEXT_STR	"fscontext="
+#define ROOTCONTEXT_STR	"rootcontext="
+#define DEFCONTEXT_STR	"defcontext="
+
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
