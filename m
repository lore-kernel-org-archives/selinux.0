Subject: [PATCH] SELinux: cleanup on isle selinuxfs.c
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Content-Type: text/plain
Date: Thu, 17 Apr 2008 14:15:45 -0400
Message-Id: <1208456145.2985.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why would anyone just clean up white space all day?  Because they were
out too late last night and don't want to think for a day.  So here is a
nice clean selinuxfs.c patch.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 security/selinux/selinuxfs.c |  112 +++++++++++++++++++++--------------------
 1 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6c05e30..893b3db 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1,16 +1,16 @@
 /* Updated: Karl MacMillan <kmacmillan@tresys.com>
  *
- * 	Added conditional policy language extensions
+ *	Added conditional policy language extensions
  *
  *  Updated: Hewlett-Packard <paul.moore@hp.com>
  *
- *      Added support for the policy capability bitmap
+ *	Added support for the policy capability bitmap
  *
  * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
 
@@ -58,14 +58,14 @@ int selinux_compat_net = SELINUX_COMPAT_NET_VALUE;
 
 static int __init checkreqprot_setup(char *str)
 {
-	selinux_checkreqprot = simple_strtoul(str,NULL,0) ? 1 : 0;
+	selinux_checkreqprot = simple_strtoul(str, NULL, 0) ? 1 : 0;
 	return 1;
 }
 __setup("checkreqprot=", checkreqprot_setup);
 
 static int __init selinux_compat_net_setup(char *str)
 {
-	selinux_compat_net = simple_strtoul(str,NULL,0) ? 1 : 0;
+	selinux_compat_net = simple_strtoul(str, NULL, 0) ? 1 : 0;
 	return 1;
 }
 __setup("selinux_compat_net=", selinux_compat_net_setup);
@@ -74,17 +74,17 @@ __setup("selinux_compat_net=", selinux_compat_net_setup);
 static DEFINE_MUTEX(sel_mutex);
 
 /* global data for booleans */
-static struct dentry *bool_dir = NULL;
-static int bool_num = 0;
+static struct dentry *bool_dir;
+static int bool_num;
 static char **bool_pending_names;
-static int *bool_pending_values = NULL;
+static int *bool_pending_values;
 
 /* global data for classes */
-static struct dentry *class_dir = NULL;
+static struct dentry *class_dir;
 static unsigned long last_class_ino;
 
 /* global data for policy capabilities */
-static struct dentry *policycap_dir = NULL;
+static struct dentry *policycap_dir;
 
 extern void selnl_notify_setenforce(int val);
 
@@ -143,7 +143,7 @@ static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
+static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
@@ -157,7 +157,7 @@ static ssize_t sel_write_enforce(struct file * file, const char __user * buf,
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	length = -EFAULT;
@@ -214,7 +214,7 @@ static const struct file_operations sel_handle_unknown_ops = {
 };
 
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
-static ssize_t sel_write_disable(struct file * file, const char __user * buf,
+static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
 {
@@ -229,7 +229,7 @@ static ssize_t sel_write_disable(struct file * file, const char __user * buf,
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	length = -EFAULT;
@@ -264,7 +264,7 @@ static const struct file_operations sel_disable_ops = {
 };
 
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
-                                   size_t count, loff_t *ppos)
+				   size_t count, loff_t *ppos)
 {
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
@@ -300,7 +300,7 @@ static const struct file_operations sel_mls_ops = {
 	.read		= sel_read_mls,
 };
 
-static ssize_t sel_write_load(struct file * file, const char __user * buf,
+static ssize_t sel_write_load(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 
 {
@@ -372,7 +372,7 @@ static const struct file_operations sel_load_ops = {
 	.write		= sel_write_load,
 };
 
-static ssize_t sel_write_context(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_context(struct file *file, char *buf, size_t size)
 {
 	char *canon;
 	u32 sid, len;
@@ -414,7 +414,7 @@ static ssize_t sel_read_checkreqprot(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
-static ssize_t sel_write_checkreqprot(struct file * file, const char __user * buf,
+static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
 	char *page;
@@ -431,7 +431,7 @@ static ssize_t sel_write_checkreqprot(struct file * file, const char __user * bu
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	length = -EFAULT;
@@ -463,7 +463,7 @@ static ssize_t sel_read_compat_net(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
-static ssize_t sel_write_compat_net(struct file * file, const char __user * buf,
+static ssize_t sel_write_compat_net(struct file *file, const char __user *buf,
 				    size_t count, loff_t *ppos)
 {
 	char *page;
@@ -480,7 +480,7 @@ static ssize_t sel_write_compat_net(struct file * file, const char __user * buf,
 		/* No partial writes. */
 		return -EINVAL;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	length = -EFAULT;
@@ -505,11 +505,11 @@ static const struct file_operations sel_compat_net_ops = {
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
  */
-static ssize_t sel_write_access(struct file * file, char *buf, size_t size);
-static ssize_t sel_write_create(struct file * file, char *buf, size_t size);
-static ssize_t sel_write_relabel(struct file * file, char *buf, size_t size);
-static ssize_t sel_write_user(struct file * file, char *buf, size_t size);
-static ssize_t sel_write_member(struct file * file, char *buf, size_t size);
+static ssize_t sel_write_access(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_create(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_user(struct file *file, char *buf, size_t size);
+static ssize_t sel_write_member(struct file *file, char *buf, size_t size);
 
 static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 	[SEL_ACCESS] = sel_write_access,
@@ -522,7 +522,7 @@ static ssize_t (*write_op[])(struct file *, char *, size_t) = {
 
 static ssize_t selinux_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
-	ino_t ino =  file->f_path.dentry->d_inode->i_ino;
+	ino_t ino = file->f_path.dentry->d_inode->i_ino;
 	char *data;
 	ssize_t rv;
 
@@ -533,8 +533,8 @@ static ssize_t selinux_transaction_write(struct file *file, const char __user *b
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	rv =  write_op[ino](file, data, size);
-	if (rv>0) {
+	rv = write_op[ino](file, data, size);
+	if (rv > 0) {
 		simple_transaction_set(file, rv);
 		rv = size;
 	}
@@ -553,7 +553,7 @@ static const struct file_operations transaction_ops = {
  * and the length returned.  Otherwise return 0 or and -error.
  */
 
-static ssize_t sel_write_access(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_access(struct file *file, char *buf, size_t size)
 {
 	char *scon, *tcon;
 	u32 ssid, tsid;
@@ -602,7 +602,7 @@ out:
 	return length;
 }
 
-static ssize_t sel_write_create(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_create(struct file *file, char *buf, size_t size)
 {
 	char *scon, *tcon;
 	u32 ssid, tsid, newsid;
@@ -661,7 +661,7 @@ out:
 	return length;
 }
 
-static ssize_t sel_write_relabel(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_relabel(struct file *file, char *buf, size_t size)
 {
 	char *scon, *tcon;
 	u32 ssid, tsid, newsid;
@@ -718,7 +718,7 @@ out:
 	return length;
 }
 
-static ssize_t sel_write_user(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 {
 	char *con, *user, *ptr;
 	u32 sid, *sids;
@@ -779,7 +779,7 @@ out:
 	return length;
 }
 
-static ssize_t sel_write_member(struct file * file, char *buf, size_t size)
+static ssize_t sel_write_member(struct file *file, char *buf, size_t size)
 {
 	char *scon, *tcon;
 	u32 ssid, tsid, newsid;
@@ -873,7 +873,8 @@ static ssize_t sel_read_bool(struct file *filep, char __user *buf,
 		ret = -EINVAL;
 		goto out;
 	}
-	if (!(page = (char*)get_zeroed_page(GFP_KERNEL))) {
+	page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!page) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -924,7 +925,7 @@ static ssize_t sel_write_bool(struct file *filep, const char __user *buf,
 		length = -EINVAL;
 		goto out;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		length = -ENOMEM;
 		goto out;
@@ -952,8 +953,8 @@ out:
 }
 
 static const struct file_operations sel_bool_ops = {
-	.read           = sel_read_bool,
-	.write          = sel_write_bool,
+	.read		= sel_read_bool,
+	.write		= sel_write_bool,
 };
 
 static ssize_t sel_commit_bools_write(struct file *filep,
@@ -978,7 +979,7 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 		/* No partial writes. */
 		goto out;
 	}
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		length = -ENOMEM;
 		goto out;
@@ -992,9 +993,8 @@ static ssize_t sel_commit_bools_write(struct file *filep,
 	if (sscanf(page, "%d", &new_value) != 1)
 		goto out;
 
-	if (new_value && bool_pending_values) {
+	if (new_value && bool_pending_values)
 		security_set_bools(bool_num, bool_pending_values);
-	}
 
 	length = count;
 
@@ -1006,7 +1006,7 @@ out:
 }
 
 static const struct file_operations sel_commit_bools_ops = {
-	.write          = sel_commit_bools_write,
+	.write		= sel_commit_bools_write,
 };
 
 static void sel_remove_entries(struct dentry *de)
@@ -1056,7 +1056,8 @@ static int sel_make_bools(void)
 
 	sel_remove_entries(dir);
 
-	if (!(page = (char*)get_zeroed_page(GFP_KERNEL)))
+	page = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!page)
 		return -ENOMEM;
 
 	ret = security_get_bools(&num, &names, &values);
@@ -1083,8 +1084,9 @@ static int sel_make_bools(void)
 			ret = -ENAMETOOLONG;
 			goto err;
 		}
-		isec = (struct inode_security_struct*)inode->i_security;
-		if ((ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid)))
+		isec = (struct inode_security_struct *)inode->i_security;
+		ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid);
+		if (ret)
 			goto err;
 		isec->sid = sid;
 		isec->initialized = 1;
@@ -1112,7 +1114,7 @@ err:
 
 #define NULL_FILE_NAME "null"
 
-struct dentry *selinux_null = NULL;
+struct dentry *selinux_null;
 
 static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
 					    size_t count, loff_t *ppos)
@@ -1124,8 +1126,8 @@ static ssize_t sel_read_avc_cache_threshold(struct file *filp, char __user *buf,
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
-static ssize_t sel_write_avc_cache_threshold(struct file * file,
-					     const char __user * buf,
+static ssize_t sel_write_avc_cache_threshold(struct file *file,
+					     const char __user *buf,
 					     size_t count, loff_t *ppos)
 
 {
@@ -1144,7 +1146,7 @@ static ssize_t sel_write_avc_cache_threshold(struct file * file,
 		goto out;
 	}
 
-	page = (char*)get_zeroed_page(GFP_KERNEL);
+	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page) {
 		ret = -ENOMEM;
 		goto out;
@@ -1302,7 +1304,7 @@ out:
 	return ret;
 }
 
-static ssize_t sel_read_initcon(struct file * file, char __user *buf,
+static ssize_t sel_read_initcon(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	struct inode *inode;
@@ -1376,7 +1378,7 @@ static inline u32 sel_ino_to_perm(unsigned long ino)
 	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
 }
 
-static ssize_t sel_read_class(struct file * file, char __user *buf,
+static ssize_t sel_read_class(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	ssize_t rc, len;
@@ -1400,7 +1402,7 @@ static const struct file_operations sel_class_ops = {
 	.read		= sel_read_class,
 };
 
-static ssize_t sel_read_perm(struct file * file, char __user *buf,
+static ssize_t sel_read_perm(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
 	ssize_t rc, len;
@@ -1413,7 +1415,7 @@ static ssize_t sel_read_perm(struct file * file, char __user *buf,
 		goto out;
 	}
 
-	len = snprintf(page, PAGE_SIZE,"%d", sel_ino_to_perm(ino));
+	len = snprintf(page, PAGE_SIZE, "%d", sel_ino_to_perm(ino));
 	rc = simple_read_from_buffer(buf, count, ppos, page, len);
 	free_page((unsigned long)page);
 out:
@@ -1641,7 +1643,7 @@ out:
 	return ret;
 }
 
-static int sel_fill_super(struct super_block * sb, void * data, int silent)
+static int sel_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int ret;
 	struct dentry *dentry;
@@ -1697,7 +1699,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		goto err;
 	}
 	inode->i_ino = ++sel_last_ino;
-	isec = (struct inode_security_struct*)inode->i_security;
+	isec = (struct inode_security_struct *)inode->i_security;
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
