Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0EMJ8Rb029578
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 17:19:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0EMJ5iV025854
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 22:19:05 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i0EMJ406025850 for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 22:19:04 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0EMJ4mV018163
	for <selinux@tycho.nsa.gov>; Wed, 14 Jan 2004 17:19:04 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i0EMJ488018161
	for selinux@tycho.nsa.gov; Wed, 14 Jan 2004 17:19:04 -0500
Subject: Announce: Updated SELinux conditional policy extensions
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Cc: Selinux Dev <selinux-dev@tresys.com>
Content-Type: multipart/mixed; boundary="=-3Q3ILB4ZzMVKg+uHxavj"
Message-Id: <1074114393.10070.42.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Wed, 14 Jan 2004 16:06:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3Q3ILB4ZzMVKg+uHxavj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A new release of the conditional policy extensions to SELinux is
available from our website:

http://www.tresys.com/selinux/index.html

Patches are also attached to this email. The conditional policy
extensions to SELinux allow runtime modification of the security policy
without having to load a new policy. Using boolean variables and
expressions, it is possible to define sections of policy that are
conditionally applied. Please see the website for more information.

This release includes modifications to the linux kernel, checkpolicy,
libselinux, and the default policy and allows the creation and loading
of conditional policies. Any testing or feedback would be greatly
appreciated.

Thanks,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134

--=-3Q3ILB4ZzMVKg+uHxavj
Content-Disposition: attachment; filename=conditional-linux-2.6-snapshot-1-14-2004.patch
Content-Type: text/x-patch; name=conditional-linux-2.6-snapshot-1-14-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru a/linux-2.6/security/selinux/include/conditional.h b/linux-2.6/security/selinux/include/conditional.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/linux-2.6/security/selinux/include/conditional.h	Wed Jan 14 14:07:24 2004
@@ -0,0 +1,22 @@
+/*
+ * Interface to booleans in the security server. This is exported
+ * for the selinuxfs.
+ *
+ * Author: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _SELINUX_CONDITIONAL_H_
+#define _SELINUX_CONDITIONAL_H_
+
+int security_get_bools(int *len, char ***names, int **values);
+
+int security_set_bools(int len, int *values);
+
+int security_get_bool_value(int bool);
+
+#endif
diff -Nru a/linux-2.6/security/selinux/include/security.h b/linux-2.6/security/selinux/include/security.h
--- a/linux-2.6/security/selinux/include/security.h	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/include/security.h	Wed Jan 14 14:07:24 2004
@@ -2,7 +2,9 @@
  * Security server interface.
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ *
  */
+
 #ifndef _SELINUX_SECURITY_H_
 #define _SELINUX_SECURITY_H_
 
@@ -13,7 +15,8 @@
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #define SELINUX_MAGIC 0xf97cff8c
-#define POLICYDB_VERSION 15
+#define POLICYDB_VERSION 16
+#define POLICYDB_VERSION_COMPAT 15
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
diff -Nru a/linux-2.6/security/selinux/selinuxfs.c b/linux-2.6/security/selinux/selinuxfs.c
--- a/linux-2.6/security/selinux/selinuxfs.c	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/selinuxfs.c	Wed Jan 14 14:07:24 2004
@@ -1,5 +1,16 @@
+/* Updated: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
@@ -7,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
+#include <asm/semaphore.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
@@ -16,6 +28,14 @@
 #include "avc_ss.h"
 #include "security.h"
 #include "objsec.h"
+#include "conditional.h"
+
+static DECLARE_MUTEX(sel_sem);
+
+/* global data for booleans */
+static struct dentry *bool_dir = NULL;
+static int bool_num = 0;
+static int *bool_pending_values = NULL;
 
 /* Check whether a task is allowed to use a security operation. */
 int task_has_security(struct task_struct *tsk,
@@ -38,7 +58,8 @@
 	SEL_CREATE,	/* compute create labeling decision */
 	SEL_RELABEL,	/* compute relabeling decision */
 	SEL_USER,	/* compute reachable user contexts */
-	SEL_POLICYVERS	/* return policy version for this kernel */
+	SEL_POLICYVERS,	/* return policy version for this kernel */
+	SEL_COMMIT_BOOLS
 };
 
 static ssize_t sel_read_enforce(struct file *filp, char *buf,
@@ -166,24 +187,34 @@
 	.read		= sel_read_policyvers,
 };
 
+/* declaration for sel_write_load */
+static int sel_make_bools(void);
+
 static ssize_t sel_write_load(struct file * file, const char * buf,
 			      size_t count, loff_t *ppos)
 
 {
+	int ret;
 	ssize_t length;
-	void *data;
+	void *data = NULL;
+
+	down(&sel_sem);
 
 	length = task_has_security(current, SECURITY__LOAD_POLICY);
 	if (length)
-		return length;
+		goto out;
 
 	if (*ppos != 0) {
 		/* No partial writes. */
-		return -EINVAL;
+		length = -EINVAL;
+		goto out;
 	}
 
-	if ((count < 0) || (count > 64 * 1024 * 1024) || (data = vmalloc(count)) == NULL)
-		return -ENOMEM;
+	if ((count < 0) || (count > 64 * 1024 * 1024)
+	    || (data = vmalloc(count)) == NULL) {
+		length = -ENOMEM;
+		goto out;
+	}
 
 	length = -EFAULT;
 	if (copy_from_user(data, buf, count) != 0)
@@ -193,8 +224,13 @@
 	if (length)
 		goto out;
 
-	length = count;
+	ret = sel_make_bools();
+	if (ret)
+		length = ret;
+	else
+		length = count;
 out:
+	up(&sel_sem);
 	vfree(data);
 	return length;
 }
@@ -598,9 +634,297 @@
 	return length;
 }
 
+static struct inode *sel_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret = new_inode(sb);
+
+	if (ret) {
+		ret->i_mode = mode;
+		ret->i_uid = ret->i_gid = 0;
+		ret->i_blksize = PAGE_CACHE_SIZE;
+		ret->i_blocks = 0;
+		ret->i_atime = ret->i_mtime = ret->i_ctime = CURRENT_TIME;
+	}
+	return ret;
+}
+
+#define BOOL_INO_OFFSET 30
+
+static ssize_t sel_read_bool(struct file *filep, char *buf,
+			     size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length;
+	ssize_t end;
+	ssize_t ret;
+	int cur_enforcing;
+	struct inode *inode;
+	
+	down(&sel_sem);
+	
+	ret = -EFAULT;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count > PAGE_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!(page = (char*)__get_free_page(GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(page, 0, PAGE_SIZE);
+	
+	inode = filep->f_dentry->d_inode;
+	cur_enforcing = security_get_bool_value(inode->i_ino - BOOL_INO_OFFSET);
+	if (cur_enforcing < 0) {
+		ret = cur_enforcing;
+		goto out;
+	}
+
+	length = snprintf(page, PAGE_SIZE, "%d %d", cur_enforcing,
+			  bool_pending_values[inode->i_ino - BOOL_INO_OFFSET]);
+	if (length < 0) {
+		ret = length;
+		goto out;
+	}
+
+	if (*ppos >= length) {
+		ret = 0;
+		goto out;
+	}
+	if (count + *ppos > length)
+		count = length - *ppos;
+	end = count + *ppos;
+	if (copy_to_user(buf, (char *) page + *ppos, count)) {
+		ret = -EFAULT;
+		goto out;
+	}
+	*ppos = end;
+	ret = count;
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long)page);
+	return ret;
+}
+
+static ssize_t sel_write_bool(struct file *filep, const char *buf,
+			      size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length = -EFAULT;
+	int new_value;
+	struct inode *inode;
+
+	down(&sel_sem);
+	
+	length = task_has_security(current, SECURITY__SETENFORCE);
+	if (length)
+		goto out;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count >= PAGE_SIZE) {
+		length = -ENOMEM;
+		goto out;
+	}
+	if (*ppos != 0) {
+		/* No partial writes. */
+		goto out;
+	}
+	page = (char*)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	memset(page, 0, PAGE_SIZE);
+
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value)
+		new_value = 1;
+
+	inode = filep->f_dentry->d_inode;
+	bool_pending_values[inode->i_ino - BOOL_INO_OFFSET] = new_value;
+	length = count;
+
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long) page);
+	return length;
+}
+
+static struct file_operations sel_bool_ops = {
+	.read           = sel_read_bool,
+	.write          = sel_write_bool,
+};
+
+static ssize_t sel_commit_bools_write(struct file *filep, const char *buf,
+				      size_t count, loff_t *ppos)
+{
+	char *page = NULL;
+	ssize_t length = -EFAULT;
+	int new_value;
+
+	down(&sel_sem);
+
+	length = task_has_security(current, SECURITY__SETENFORCE);
+	if (length)
+		goto out;
+
+	/* check to see if this file has been deleted */
+	if (!filep->f_op)
+		goto out;
+
+	if (count < 0 || count >= PAGE_SIZE) {
+		length = -ENOMEM;
+		goto out;
+	}
+	if (*ppos != 0) {
+		/* No partial writes. */
+		goto out;
+	}
+	page = (char*)__get_free_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;	       
+
+	memset(page, 0, PAGE_SIZE);
+
+	if (copy_from_user(page, buf, count))
+		goto out;
+
+	length = -EINVAL;
+	if (sscanf(page, "%d", &new_value) != 1)
+		goto out;
+
+	if (new_value) {
+		security_set_bools(bool_num, bool_pending_values);
+	}
+
+	length = count;
+
+out:
+	up(&sel_sem);
+	if (page)
+		free_page((unsigned long) page);
+	return length;
+}
+
+static struct file_operations sel_commit_bools_ops = {
+	.write          = sel_commit_bools_write,
+};
+
+/* delete booleans - partial revoke() from
+ * fs/proc/generic.c proc_kill_inodes */
+static int sel_remove_bools(struct dentry *de)
+{
+	struct list_head *p, *node;
+	struct super_block *sb = de->d_sb;
+	
+	spin_lock(&dcache_lock);
+	node = de->d_subdirs.next;
+	while (node != &de->d_subdirs) {
+		struct dentry *d = list_entry(node, struct dentry, d_child);
+		list_del_init(node);
+
+		if (d->d_inode) {
+			d = dget_locked(d);
+			spin_unlock(&dcache_lock);
+			d_delete(d);
+			simple_unlink(de->d_inode, d);
+			dput(d);
+			spin_lock(&dcache_lock);
+		}
+		node = de->d_subdirs.next;
+	}
+
+	spin_unlock(&dcache_lock);
+
+	file_list_lock();
+	list_for_each(p, &sb->s_files) {
+		struct file * filp = list_entry(p, struct file, f_list);
+		struct dentry * dentry = filp->f_dentry;
+
+		if (dentry->d_parent != de) {
+			continue;
+		}
+		filp->f_op = NULL;
+	}
+	file_list_unlock();
+
+	return 0;
+}
+
+static int sel_make_bools(void)
+{
+	int i, ret = 0;
+	struct dentry *dentry = NULL;
+	struct dentry *dir = bool_dir;
+	struct inode *inode = NULL;
+	struct qstr qname;
+	char **names = NULL;
+	int num;
+	int *values = NULL;
+
+	/* remove any existing files */
+	if (bool_pending_values)
+		kfree(bool_pending_values);
+	
+	sel_remove_bools(dir);
+	
+
+	ret = security_get_bools(&num, &names, &values);
+	if (ret != 0)
+		goto out;
+	
+	for (i = 0; i < num; i++) {
+		qname.name = names[i];
+		qname.len = strlen(qname.name);
+		qname.hash = full_name_hash(qname.name, qname.len);
+		dentry = d_alloc(dir, &qname);
+		if (!dentry)
+			goto err;
+		inode = sel_make_inode(dir->d_sb, S_IFREG | S_IRUGO | S_IWUSR);
+		if (!inode)
+			goto err;
+		inode->i_fop = &sel_bool_ops;
+		inode->i_ino = i + BOOL_INO_OFFSET;
+		d_add(dentry, inode);
+	}
+	bool_num = num;
+	bool_pending_values = values;
+out:
+	if (names) {
+		for (i = 0; i < num; i++) {
+			if (names[i])
+				kfree(names[i]);
+		}
+		kfree(names);
+	}
+	return ret;
+err:
+	d_genocide(dir);
+	ret = -ENOMEM;
+	goto out;
+}
 
 static int sel_fill_super(struct super_block * sb, void * data, int silent)
 {
+	int ret;
+	struct dentry *dentry;
+	struct inode *inode;
+	struct qstr qname;
+
 	static struct tree_descr selinux_files[] = {
 		[SEL_LOAD] = {"load", &sel_load_ops, S_IRUSR|S_IWUSR},
 		[SEL_ENFORCE] = {"enforce", &sel_enforce_ops, S_IRUSR|S_IWUSR},
@@ -610,9 +934,36 @@
 		[SEL_RELABEL] = {"relabel", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_USER] = {"user", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_POLICYVERS] = {"policyvers", &sel_policyvers_ops, S_IRUGO},
+		[SEL_COMMIT_BOOLS] = {"commit_pending_bools", &sel_commit_bools_ops, S_IWUSR},
 		/* last one */ {""}
 	};
-	return simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
+	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
+	if (ret)
+		return ret;
+
+	qname.name = "booleans";
+	qname.len = strlen(qname.name);
+	qname.hash = full_name_hash(qname.name, qname.len);
+	dentry = d_alloc(sb->s_root, &qname);
+	if (!dentry)
+		return -ENOMEM;
+
+	inode = sel_make_inode(sb, S_IFDIR | S_IRUGO | S_IXUGO);
+	if (!inode)
+		goto out;
+	inode->i_op = &simple_dir_inode_operations;
+	inode->i_fop = &simple_dir_operations;
+	d_add(dentry, inode);
+	bool_dir = dentry;
+	ret = sel_make_bools();
+	if (ret)
+		goto out;
+
+	return 0;
+out:
+	dput(dentry);
+	printk(KERN_ERR "security:	error creating conditional out_dput\n");
+	return -ENOMEM;
 }
 
 static struct super_block *sel_get_sb(struct file_system_type *fs_type,
diff -Nru a/linux-2.6/security/selinux/ss/Makefile b/linux-2.6/security/selinux/ss/Makefile
--- a/linux-2.6/security/selinux/ss/Makefile	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/Makefile	Wed Jan 14 14:07:24 2004
@@ -5,7 +5,7 @@
 EXTRA_CFLAGS += -Isecurity/selinux/include 
 obj-y := ss.o
 
-ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
+ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o
 
 ifeq ($(CONFIG_SECURITY_SELINUX_MLS),y)
 ss-objs += mls.o
diff -Nru a/linux-2.6/security/selinux/ss/avtab.c b/linux-2.6/security/selinux/ss/avtab.c
--- a/linux-2.6/security/selinux/ss/avtab.c	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/avtab.c	Wed Jan 14 14:07:24 2004
@@ -3,10 +3,22 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/errno.h>
+
 #include "avtab.h"
 #include "policydb.h"
 
@@ -16,6 +28,29 @@
  (keyp->source_type << 9)) & \
  AVTAB_HASH_MASK)
 
+static struct avtab_node*
+avtab_insert_node(struct avtab *h, int hvalue, struct avtab_node * prev, struct avtab_node * cur,
+		  struct avtab_key *key, struct avtab_datum *datum)
+{
+	struct avtab_node * newnode;
+	newnode = (struct avtab_node *) kmalloc(sizeof(struct avtab_node),GFP_KERNEL);
+	if (newnode == NULL)
+		return NULL;
+	memset(newnode, 0, sizeof(struct avtab_node));
+	newnode->key = *key;
+	newnode->datum = *datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return newnode;
+}
+
 int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
 {
 	int hvalue;
@@ -44,24 +79,48 @@
 			break;
 	}
 
-	newnode = kmalloc(sizeof(*newnode), GFP_KERNEL);
-	if (newnode == NULL)
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	if(!newnode)
 		return -ENOMEM;
-	memset(newnode, 0, sizeof(*newnode));
-	newnode->key = *key;
-	newnode->datum = *datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
 
-	h->nel++;
 	return 0;
 }
 
+/* Unlike avtab_insert(), this function allow multiple insertions of the same 
+ * key/specified mask into the table, as needed by the conditional avtab.  
+ * It also returns a pointer to the node inserted.
+ */
+struct avtab_node *
+avtab_insert_nonunique(struct avtab * h, struct avtab_key * key, struct avtab_datum * datum)
+{
+	int hvalue;
+	struct avtab_node *prev, *cur, *newnode;
+
+	if (!h)
+		return NULL;
+	hvalue = AVTAB_HASH(key);
+	for (prev = NULL, cur = h->htable[hvalue];
+	     cur;
+	     prev = cur, cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (datum->specified & cur->datum.specified))
+			break;
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	
+	return newnode;
+}
 
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key, int specified)
 {
@@ -93,6 +152,67 @@
 	return NULL;
 }
 
+/* This search function returns a node pointer, and can be used in
+ * conjunction with avtab_search_next_node()
+ */
+struct avtab_node*
+avtab_search_node(struct avtab *h, struct avtab_key *key, int specified)
+{
+	int hvalue;
+	struct avtab_node *cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = AVTAB_HASH(key);
+	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
+
+struct avtab_node*
+avtab_search_node_next(struct avtab_node *node, int specified)
+{
+	struct avtab_node *cur;
+
+	if (!node)
+		return NULL;
+		
+	for (cur = node->next; cur; cur = cur->next) {
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (node->key.source_type < cur->key.source_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type < cur->key.target_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
+
 void avtab_destroy(struct avtab *h)
 {
 	int i;
@@ -178,13 +298,72 @@
 	       max_chain_len);
 }
 
+int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey)
+{
+	__u32 *buf;
+	__u32 items, items2;
+
+	memset(avkey, 0, sizeof(struct avtab_key));
+	memset(avdatum, 0, sizeof(struct avtab_datum));
+	
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf) {
+		printk(KERN_ERR "security: avtab: truncated entry\n");
+		goto bad;
+	}
+	items2 = le32_to_cpu(buf[0]);
+	buf = next_entry(fp, sizeof(__u32)*items2);
+	if (!buf) {
+		printk(KERN_ERR "security: avtab: truncated entry\n");
+		goto bad;
+	}
+	items = 0;
+	avkey->source_type = le32_to_cpu(buf[items++]);
+	avkey->target_type = le32_to_cpu(buf[items++]);
+	avkey->target_class = le32_to_cpu(buf[items++]);
+	avdatum->specified = le32_to_cpu(buf[items++]);
+	if (!(avdatum->specified & (AVTAB_AV | AVTAB_TYPE))) {
+		printk(KERN_ERR "security: avtab: null entry\n");
+		goto bad;
+	}
+	if ((avdatum->specified & AVTAB_AV) &&
+	    (avdatum->specified & AVTAB_TYPE)) {
+		printk(KERN_ERR "security: avtab: entry has both access vectors and types\n");
+		goto bad;
+	}
+	if (avdatum->specified & AVTAB_AV) {
+		if (avdatum->specified & AVTAB_ALLOWED)
+			avtab_allowed(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITDENY) 
+			avtab_auditdeny(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITALLOW) 
+			avtab_auditallow(avdatum) = le32_to_cpu(buf[items++]);
+	} else {		
+		if (avdatum->specified & AVTAB_TRANSITION)
+			avtab_transition(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_CHANGE)
+			avtab_change(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_MEMBER)
+			avtab_member(avdatum) = le32_to_cpu(buf[items++]);
+	}	
+	if (items != items2) {
+		printk(KERN_ERR "security: avtab: entry only had %d items, expected %d\n",
+		       items2, items);
+		goto bad;
+	}
+	
+	return 0;
+bad:
+	return -1;
+}
+
 int avtab_read(struct avtab *a, void *fp, u32 config)
 {
 	int i, rc = -EINVAL;
 	struct avtab_key avkey;
 	struct avtab_datum avdatum;
 	u32 *buf;
-	u32 nel, items, items2;
+	u32 nel;
 
 
 	buf = next_entry(fp, sizeof(u32));
@@ -198,55 +377,8 @@
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		memset(&avkey, 0, sizeof(avkey));
-		memset(&avdatum, 0, sizeof(avdatum));
-
-		buf = next_entry(fp, sizeof(u32));
-		if (!buf) {
-			printk(KERN_ERR "security: avtab: truncated entry\n");
-			goto bad;
-		}
-		items2 = le32_to_cpu(buf[0]);
-		buf = next_entry(fp, sizeof(u32)*items2);
-		if (!buf) {
-			printk(KERN_ERR "security: avtab: truncated entry\n");
-			goto bad;
-		}
-		items = 0;
-		avkey.source_type = le32_to_cpu(buf[items++]);
-		avkey.target_type = le32_to_cpu(buf[items++]);
-		avkey.target_class = le32_to_cpu(buf[items++]);
-		avdatum.specified = le32_to_cpu(buf[items++]);
-		if (!(avdatum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-			printk(KERN_ERR "security: avtab: null entry\n");
-			goto bad;
-		}
-		if ((avdatum.specified & AVTAB_AV) &&
-		    (avdatum.specified & AVTAB_TYPE)) {
-			printk(KERN_ERR "security: avtab: entry has both "
-			       "access vectors and types\n");
+		if (avtab_read_item(fp, &avdatum, &avkey))
 			goto bad;
-		}
-		if (avdatum.specified & AVTAB_AV) {
-			if (avdatum.specified & AVTAB_ALLOWED)
-				avtab_allowed(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITDENY)
-				avtab_auditdeny(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITALLOW)
-				avtab_auditallow(&avdatum) = le32_to_cpu(buf[items++]);
-		} else {
-			if (avdatum.specified & AVTAB_TRANSITION)
-				avtab_transition(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_CHANGE)
-				avtab_change(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_MEMBER)
-				avtab_member(&avdatum) = le32_to_cpu(buf[items++]);
-		}
-		if (items != items2) {
-			printk(KERN_ERR "security: avtab: entry only had %d "
-			       "items, expected %d\n", items2, items);
-			goto bad;
-		}
 		rc = avtab_insert(a, &avkey, &avdatum);
 		if (rc) {
 			if (rc == -ENOMEM)
diff -Nru a/linux-2.6/security/selinux/ss/avtab.h b/linux-2.6/security/selinux/ss/avtab.h
--- a/linux-2.6/security/selinux/ss/avtab.h	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/avtab.h	Wed Jan 14 14:07:24 2004
@@ -7,6 +7,16 @@
  *
  *  Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
 #ifndef _SS_AVTAB_H_
 #define _SS_AVTAB_H_
 
@@ -25,6 +35,7 @@
 #define AVTAB_MEMBER     32
 #define AVTAB_CHANGE     64
 #define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+#define AVTAB_ENABLED    0x80000000 /* reserved for used in cond_avtab */
 	u32 specified;	/* what fields are specified */
 	u32 data[3];	/* access vectors or types */
 #define avtab_allowed(x) (x)->data[0]
@@ -56,7 +67,16 @@
 			    void *args),
 	      void *args);
 void avtab_hash_eval(struct avtab *h, char *tag);
+
+int avtab_read_item(void *fp, struct avtab_datum *avdatum, struct avtab_key *avkey);
 int avtab_read(struct avtab *a, void *fp, u32 config);
+
+struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
+					  struct avtab_datum *datum);
+
+struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key, int specified);
+
+struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
 #define AVTAB_HASH_BITS 15
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
diff -Nru a/linux-2.6/security/selinux/ss/conditional.c b/linux-2.6/security/selinux/ss/conditional.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/linux-2.6/security/selinux/ss/conditional.c	Wed Jan 14 14:07:24 2004
@@ -0,0 +1,484 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+#include <linux/slab.h>
+
+#include "security.h"
+#include "conditional.h"
+
+/*
+ * cond_evaluate_expr evaluates a conditional expr
+ * in reverse polish notation. It returns true (1), false (0),
+ * or undefined (-1). Undefined occurs when the expression
+ * exceeds the stack depth of COND_EXPR_MAXDEPTH.
+ */
+static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
+{
+
+	struct cond_expr *cur;
+	int s[COND_EXPR_MAXDEPTH];
+	int sp = -1;
+
+	for (cur = expr; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			if (sp == (COND_EXPR_MAXDEPTH - 1))
+				return -1;
+			sp++;
+			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
+			break;
+		case COND_NOT:
+			if (sp < 0)
+				return -1;
+			s[sp] = !s[sp];
+			break;
+		case COND_OR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] |= s[sp + 1];
+			break;
+		case COND_AND:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] &= s[sp + 1];
+			break;
+		case COND_XOR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] ^= s[sp + 1];
+			break;
+		case COND_EQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] == s[sp + 1]);
+			break;
+		case COND_NEQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] != s[sp + 1]);
+			break;
+		default:
+			return -1;
+		}
+	}
+	return s[0];
+}
+
+/*
+ * evaluate_cond_node evaluates the conditional stored in
+ * a struct cond_node and if the result is different than the
+ * current state of the node it sets the rules in the true/false
+ * list appropriately. If the result of the expression is undefined
+ * all of the rules are disabled for safety.
+ */
+int evaluate_cond_node(struct policydb *p, struct cond_node *node)
+{
+	int new_state;
+	struct cond_av_list* cur;
+
+	new_state = cond_evaluate_expr(p, node->expr);
+	if (new_state != node->cur_state) {
+		node->cur_state = new_state;
+		if (new_state == -1)
+			printk(KERN_ERR "security: expression result was undefined - disabling all rules.\n");
+		/* turn the rules on or off */
+		for (cur = node->true_list; cur != NULL; cur = cur->next) {
+			if (new_state <= 0) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+
+		for (cur = node->false_list; cur != NULL; cur = cur->next) {	
+			/* -1 or 1 */
+			if (new_state) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+	}
+	return 0;
+}
+
+int cond_policydb_init(struct policydb *p)
+{
+	p->bool_val_to_struct = NULL;
+	p->cond_list = NULL;
+	if (avtab_init(&p->te_cond_avtab))
+		return -1;
+
+	return 0;
+}
+
+static void cond_av_list_destroy(struct cond_av_list *list)
+{
+	struct cond_av_list *cur, *next;
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		/* the avtab_ptr_t node is destroy by the avtab */
+		kfree(cur);
+	}
+}
+
+static void cond_node_destroy(struct cond_node *node)
+{
+	struct cond_expr *cur_expr, *next_expr;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = next_expr) {
+		next_expr = cur_expr->next;
+		kfree(cur_expr);
+	}
+	cond_av_list_destroy(node->true_list);
+	cond_av_list_destroy(node->false_list);
+	kfree(node);
+}
+
+static void cond_list_destroy(struct cond_node *list)
+{
+	struct cond_node *next, *cur;
+	
+	if (list == NULL)
+		return;
+
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		cond_node_destroy(cur);
+	}
+}
+
+void cond_policydb_destroy(struct policydb *p)
+{
+	if (p->bool_val_to_struct != NULL)
+		kfree(p->bool_val_to_struct);
+	avtab_destroy(&p->te_cond_avtab);
+	cond_list_destroy(p->cond_list);
+}
+
+int cond_init_bool_indexes(struct policydb *p)
+{
+	if (p->bool_val_to_struct)
+		kfree(p->bool_val_to_struct);
+	p->bool_val_to_struct = (struct cond_bool_datum**)
+		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum*), GFP_KERNEL);
+	if (!p->bool_val_to_struct)
+		return -1;
+	return 0;
+}
+
+int cond_destroy_bool(void *key, void *datum, void *p)
+{
+	if (key)
+		kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+int cond_index_bool(void *key, void *datum, void *datap)
+{
+	struct policydb *p;
+	struct cond_bool_datum *booldatum;
+
+	booldatum = datum;
+	p = datap;
+	
+	p->p_bool_val_to_name[booldatum->value - 1] = key;
+	p->bool_val_to_struct[booldatum->value -1] = booldatum;
+
+	return 0;
+}
+
+int bool_isvalid(struct cond_bool_datum *b)
+{
+	if (!(b->state == 0 || b->state == 1))
+		return 0;
+	return 1;
+}
+
+int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
+{
+	char *key = 0;
+	struct cond_bool_datum *booldatum;
+	__u32 *buf, len;
+
+	booldatum = kmalloc(sizeof(struct cond_bool_datum), GFP_KERNEL);
+	if (!booldatum)
+		return -1;
+	memset(booldatum, 0, sizeof(struct cond_bool_datum));
+
+	buf = next_entry(fp, sizeof(__u32) * 3);
+	if (!buf)
+		goto err;
+
+	booldatum->value = le32_to_cpu(buf[0]);
+	booldatum->state = le32_to_cpu(buf[1]);
+	
+	if (!bool_isvalid(booldatum))
+		goto err;
+
+	len = le32_to_cpu(buf[2]);
+	
+	buf = next_entry(fp, len);
+	if (!buf)
+		goto err;
+	key = kmalloc(len + 1, GFP_KERNEL);
+	if (!key)
+		goto err;
+	memcpy(key, buf, len);
+	key[len] = 0;
+	if (hashtab_insert(h, key, booldatum))
+		goto err;
+	
+	return 0;
+err:
+	cond_destroy_bool(key, booldatum, 0);
+	return -1;
+}
+
+static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list **ret_list,
+			     struct cond_av_list *other)
+{
+	struct cond_av_list *list, *last = NULL, *cur;
+	struct avtab_key key;
+	struct avtab_datum datum;
+	struct avtab_node *node_ptr;
+	int len, i;
+	__u32 *buf;
+	__u8 found;
+
+	*ret_list = NULL;
+
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+	if (len == 0) {
+		return 0;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (avtab_read_item(fp, &datum, &key))
+			goto err;
+
+		/*
+		 * For type rules we have to make certain there aren't any
+		 * conflicting rules by searching the te_avtab and the
+		 * cond_te_avtab.
+		 */
+		if (datum.specified & AVTAB_TYPE) {
+			if (avtab_search(&p->te_avtab, &key, AVTAB_TYPE)) {
+				printk("security: type rule already exists outside of a conditional.");
+				goto err;
+			}
+			/*
+			 * If we are reading the false list other will be a pointer to
+			 * the true list. We can have duplicate entries if there is only
+			 * 1 other entry and it is in our true list.
+			 *
+			 * If we are reading the true list (other == NULL) there shouldn't
+			 * be any other entries.
+			 */
+			if (other) {
+				node_ptr = avtab_search_node(&p->te_cond_avtab, &key, AVTAB_TYPE);
+				if (node_ptr) {
+					if (avtab_search_node_next(node_ptr, AVTAB_TYPE)) {
+						printk("security: too many conflicting type rules.");
+						goto err;
+					}
+					found = 0;
+					for (cur = other; cur != NULL; cur = cur->next) {
+						if (cur->node == node_ptr) {
+							found = 1;
+							break;
+						}
+					}
+					if (!found) {
+						printk("security: conflicting type rules.");
+						goto err;
+					}
+				}
+			} else {    
+				if (avtab_search(&p->te_cond_avtab, &key, AVTAB_TYPE)) {
+					printk("security: conflicting type rules when adding type rule for true.");
+					goto err;
+				}
+			}
+		}
+		node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, &key, &datum);
+		if (!node_ptr) {
+			printk("security: could not insert rule.");
+			goto err;
+		}
+
+		list = kmalloc(sizeof(struct cond_av_list), GFP_KERNEL);
+		if (!list)
+			goto err;
+		memset(list, 0, sizeof(struct cond_av_list));
+
+		list->node = node_ptr;
+		if (i == 0)
+			*ret_list = list;
+		else
+			last->next = list;
+		last = list;
+
+	}
+
+	return 0;
+err:
+	cond_av_list_destroy(*ret_list);
+	*ret_list = NULL;
+	return -1;
+}
+
+static int expr_isvalid(struct policydb *p, struct cond_expr *expr)
+{
+	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
+		printk("security: conditional expressions uses unknown operator.\n");
+		return 0;
+	}
+	
+	if (expr->bool > p->p_bools.nprim) {
+		printk("security: conditional expressions uses unknown bool.\n");
+		return 0;
+	}
+	return 1;
+}
+
+static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+{
+	__u32 *buf;
+	int len, i;
+	struct cond_expr *expr = NULL, *last = NULL;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	node->cur_state = le32_to_cpu(buf[0]);
+	
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	/* expr */
+	len = le32_to_cpu(buf[0]);
+	
+	for (i = 0; i < len; i++ ) {
+		buf = next_entry(fp, sizeof(__u32) * 2);
+		if (!buf)
+			goto err;
+
+		expr = kmalloc(sizeof(struct cond_expr), GFP_KERNEL);
+		if (!expr) {
+			goto err;
+		}
+		memset(expr, 0, sizeof(struct cond_expr));
+
+		expr->expr_type = le32_to_cpu(buf[0]);
+		expr->bool = le32_to_cpu(buf[1]);
+		
+		if (!expr_isvalid(p, expr))
+			goto err;
+
+		if (i == 0) {
+			node->expr = expr;
+		} else {
+			last->next = expr;
+		}
+		last = expr;
+	}
+	
+	if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
+		goto err;
+	if (cond_read_av_list(p, fp, &node->false_list, node->true_list) != 0)
+		goto err;
+	return 0;
+err:
+	cond_node_destroy(node);
+	return -1;
+}
+
+int cond_read_list(struct policydb *p, void *fp)
+{
+	struct cond_node *node, *last = NULL;
+	__u32 *buf;
+	int i, len;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+
+	for (i = 0; i < len; i++) {
+		node = kmalloc(sizeof(struct cond_node), GFP_KERNEL);
+		if (!node)
+			goto err;
+		memset(node, 0, sizeof(struct cond_node));
+		
+		if (cond_read_node(p, node, fp) != 0)
+			goto err;
+
+		if (i == 0) {
+			p->cond_list = node;
+		} else {
+			last->next = node;
+		}
+		last = node;			
+	}
+	return 0;
+err:
+	cond_list_destroy(p->cond_list);
+	return -1;
+}
+
+/* Determine whether additional permissions are granted by the conditional
+ * av table, and if so, add them to the result 
+ */
+void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd)
+{
+	struct avtab_node *node;
+	
+	if(!ctab || !key || !avd) 
+		return;
+		
+	for(node = avtab_search_node(ctab, key, AVTAB_AV); node != NULL; 
+				node = avtab_search_node_next(node, AVTAB_AV)) {
+		if ( (__u32) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+			avd->allowed |= avtab_allowed(&node->datum);
+		if ( (__u32) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+			/* Since a '0' in an auditdeny mask represents a 
+			 * permission we do NOT want to audit (dontaudit), we use
+			 * the '&' operand to ensure that all '0's in the mask
+			 * are retained (much unlike the allow and auditallow cases).
+			 */
+			avd->auditdeny &= avtab_auditdeny(&node->datum);
+		if ( (__u32) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+			avd->auditallow |= avtab_auditallow(&node->datum);
+	}
+	return;	
+}
diff -Nru a/linux-2.6/security/selinux/ss/conditional.h b/linux-2.6/security/selinux/ss/conditional.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/linux-2.6/security/selinux/ss/conditional.h	Wed Jan 14 14:07:24 2004
@@ -0,0 +1,77 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _CONDITIONAL_H_
+#define _CONDITIONAL_H_
+
+#include "avtab.h"
+#include "symtab.h"
+#include "policydb.h"
+
+#define COND_EXPR_MAXDEPTH 10
+
+/*
+ * A conditional expression is a list of operators and operands
+ * in reverse polish notation.
+ */
+struct cond_expr {
+#define COND_BOOL	1 /* plain bool */
+#define COND_NOT	2 /* !bool */
+#define COND_OR		3 /* bool || bool */
+#define COND_AND	4 /* bool && bool */
+#define COND_XOR	5 /* bool ^ bool */
+#define COND_EQ		6 /* bool == bool */
+#define COND_NEQ	7 /* bool != bool */
+#define COND_LAST	8
+	__u32 expr_type;
+	__u32 bool;
+	struct cond_expr *next;
+};
+
+/*
+ * Each cond_node contains a list of rules to be enabled/disabled
+ * depending on the current value of the conditional expression. This 
+ * struct is for that list.
+ */
+struct cond_av_list {
+	struct avtab_node *node;
+	struct cond_av_list *next;
+};
+
+/*
+ * A cond node represents a conditional block in a policy. It
+ * contains a conditional expression, the current state of the expression,
+ * two lists of rules to enable/disable depending on the value of the
+ * expression (the true list corresponds to if and the false list corresponds
+ * to else)..
+ */
+struct cond_node {
+	int cur_state;
+	struct cond_expr *expr;
+	struct cond_av_list *true_list;
+	struct cond_av_list *false_list;
+	struct cond_node *next;
+};
+
+int cond_policydb_init(struct policydb* p);
+void cond_policydb_destroy(struct policydb* p);
+
+int cond_init_bool_indexes(struct policydb* p);
+int cond_destroy_bool(void *key, void *datum, void *p);
+
+int cond_index_bool(void *key, void *datum, void *datap);
+
+int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
+int cond_read_list(struct policydb *p, void *fp);
+
+void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decision *avd);
+
+int evaluate_cond_node(struct policydb *p, struct cond_node *node);
+
+#endif /* _CONDITIONAL_H_ */
diff -Nru a/linux-2.6/security/selinux/ss/policydb.c b/linux-2.6/security/selinux/ss/policydb.c
--- a/linux-2.6/security/selinux/ss/policydb.c	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/policydb.c	Wed Jan 14 14:07:24 2004
@@ -3,12 +3,25 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/errno.h>
 #include "security.h"
+
 #include "policydb.h"
+#include "conditional.h"
 #include "mls.h"
 
 #define _DEBUG_HASHES
@@ -19,7 +32,8 @@
 	"classes",
 	"roles",
 	"types",
-	"users"
+	"users",
+	"bools"
 	mls_symtab_names
 };
 #endif
@@ -29,7 +43,8 @@
 	32,
 	16,
 	512,
-	128
+	128,
+	16
 	mls_symtab_sizes
 };
 
@@ -95,6 +110,10 @@
 	if (rc)
 		goto out_free_avtab;
 
+	rc = cond_policydb_init(p);
+	if (rc)
+		goto out_free_avtab;
+
 out:
 	return rc;
 
@@ -184,7 +203,8 @@
 	class_index,
 	role_index,
 	type_index,
-	user_index
+	user_index,
+	cond_index_bool
 	mls_index_f
 };
 
@@ -256,8 +276,8 @@
 {
 	int i, rc = 0;
 
-	printk(KERN_INFO "security:  %d users, %d roles, %d types",
-	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim);
+	printk(KERN_INFO "security:  %d users, %d roles, %d types, %d bools",
+	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
 	mls_policydb_index_others(p);
 	printk("\n");
 
@@ -285,6 +305,11 @@
 		goto out;
 	}
 
+	if (cond_init_bool_indexes(p)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] =
 			kmalloc(p->symtab[i].nprim * sizeof(char *), GFP_KERNEL);
@@ -391,7 +416,8 @@
 	class_destroy,
 	role_destroy,
 	type_destroy,
-	user_destroy
+	user_destroy,
+	cond_destroy_bool
 	mls_destroy_f
 };
 
@@ -456,6 +482,8 @@
 		kfree(gtmp);
 	}
 
+	cond_policydb_destroy(p);
+
 	return;
 }
 
@@ -1025,7 +1053,8 @@
 	class_read,
 	role_read,
 	type_read,
-	user_read
+	user_read,
+	cond_read_bool
 	mls_read_f
 };
 
@@ -1042,7 +1071,7 @@
 	struct role_trans *tr, *ltr;
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
-	int i, j, rc;
+	int i, j, rc, policy_ver, num_syms;
 	u32 *buf, len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 
@@ -1107,7 +1136,8 @@
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	if (buf[0] != POLICYDB_VERSION) {
+	policy_ver = buf[0];
+	if (policy_ver != POLICYDB_VERSION && policy_ver != POLICYDB_VERSION_COMPAT) {
 		printk(KERN_ERR "security:  policydb version %d does not match "
 		       "my version %d\n", buf[0], POLICYDB_VERSION);
 		goto bad;
@@ -1119,18 +1149,30 @@
 		       mls_config(config));
 		goto bad;
 	}
-	if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
-		printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
-		       "not match mine (%d,%d)\n",
-		       buf[2], buf[3], SYM_NUM, OCON_NUM);
-		goto bad;
+
+	if (policy_ver == POLICYDB_VERSION_COMPAT) {
+		if (buf[2] != (SYM_NUM - 1) || buf[3] != OCON_NUM) {
+			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM - 1;
+	} else {
+		if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
+			printk(KERN_ERR "security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM;
 	}
 
 	rc = mls_read_nlevels(p, fp);
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < SYM_NUM; i++) {
+	for (i = 0; i < num_syms; i++) {
 		buf = next_entry(fp, sizeof(u32)*2);
 		if (!buf) {
 			rc = -EINVAL;
@@ -1150,6 +1192,12 @@
 	rc = avtab_read(&p->te_avtab, fp, config);
 	if (rc)
 		goto bad;
+
+	if (policy_ver == POLICYDB_VERSION) {
+		rc = cond_read_list(p, fp);
+		if (rc)
+			goto bad;
+	}
 
 	buf = next_entry(fp, sizeof(u32));
 	if (!buf) {
diff -Nru a/linux-2.6/security/selinux/ss/policydb.h b/linux-2.6/security/selinux/ss/policydb.h
--- a/linux-2.6/security/selinux/ss/policydb.h	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/policydb.h	Wed Jan 14 14:07:24 2004
@@ -4,6 +4,17 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #ifndef _SS_POLICYDB_H_
 #define _SS_POLICYDB_H_
 
@@ -100,6 +111,13 @@
 };
 #endif
 
+/* Boolean data type */
+struct cond_bool_datum {
+	__u32 value;		/* internal type value */
+	int state;
+};
+
+struct cond_node;
 
 /*
  * The configuration data includes security contexts for
@@ -145,9 +163,11 @@
 #ifdef CONFIG_SECURITY_SELINUX_MLS
 #define SYM_LEVELS  5
 #define SYM_CATS    6
-#define SYM_NUM     7
+#define SYM_BOOLS   7
+#define SYM_NUM     8
 #else
-#define SYM_NUM     5
+#define SYM_BOOLS   5
+#define SYM_NUM     6
 #endif
 
 /* object context array indices */
@@ -170,6 +190,7 @@
 #define p_users symtab[SYM_USERS]
 #define p_levels symtab[SYM_LEVELS]
 #define p_cats symtab[SYM_CATS]
+#define p_bools symtab[SYM_BOOLS]
 
 	/* symbol names indexed by (value - 1) */
 	char **sym_val_to_name[SYM_NUM];
@@ -180,6 +201,7 @@
 #define p_user_val_to_name sym_val_to_name[SYM_USERS]
 #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]
 #define p_cat_val_to_name sym_val_to_name[SYM_CATS]
+#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	struct class_datum **class_val_to_struct;
@@ -191,6 +213,13 @@
 
 	/* role transitions */
 	struct role_trans *role_tr;
+
+	/* bools indexed by (value - 1) */
+	struct cond_bool_datum **bool_val_to_struct;
+	/* type enforcement conditional access vectors and transitions */
+	struct avtab te_cond_avtab;
+	/* linked list indexing te_cond_avtab by conditional */
+	struct cond_node* cond_list;
 
 	/* role allows */
 	struct role_allow *role_allow;
diff -Nru a/linux-2.6/security/selinux/ss/services.c b/linux-2.6/security/selinux/ss/services.c
--- a/linux-2.6/security/selinux/ss/services.c	Wed Jan 14 14:07:24 2004
+++ b/linux-2.6/security/selinux/ss/services.c	Wed Jan 14 14:07:24 2004
@@ -9,6 +9,15 @@
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
  *      as published by the Free Software Foundation.
+ *
+ * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -25,6 +34,7 @@
 #include "policydb.h"
 #include "sidtab.h"
 #include "services.h"
+#include "conditional.h"
 #include "mls.h"
 
 static rwlock_t policy_rwlock = RW_LOCK_UNLOCKED;
@@ -222,6 +232,9 @@
 			avd->auditallow = avtab_auditallow(avdatum);
 	}
 
+	/* Check conditional av table for additional permissions */
+	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
+
 	/*
 	 * Remove any permissions prohibited by the MLS policy.
 	 */
@@ -570,6 +583,7 @@
 	struct role_trans *roletr = 0;
 	struct avtab_key avkey;
 	struct avtab_datum *avdatum;
+	struct avtab_node *node;
 	unsigned int type_change = 0;
 	int rc = 0;
 
@@ -636,6 +650,18 @@
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_TYPE);
+
+	/* If no permanent rule, also check for enabled conditional rules */
+	if(!avdatum) {
+		node = avtab_search_node(&policydb.te_cond_avtab, &avkey, specified);
+		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
+			if (node->datum.specified & AVTAB_ENABLED) {
+				avdatum = &node->datum;
+				break;
+			}
+		}
+	}
+
 	type_change = (avdatum && (avdatum->specified & specified));
 	if (type_change) {
 		/* Use the type from the type transition/member/change rule. */
@@ -997,6 +1023,7 @@
 			return -EINVAL;
 		}
 		ss_initialized = 1;
+
 		LOAD_UNLOCK;
 		selinux_complete_init();
 		return 0;
@@ -1043,6 +1070,7 @@
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
 	sidtab_set(&sidtab, &newsidtab);
 	seqno = ++latest_granting;
+
 	POLICY_WRUNLOCK;
 	LOAD_UNLOCK;
 
@@ -1420,6 +1448,117 @@
 		}
 	}
 
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+}
+
+int security_get_bools(int *len, char ***names, int **values)
+{
+	int i, rc = -ENOMEM;
+
+	POLICY_RDLOCK;
+	*names = NULL;
+	*values = NULL;
+	
+	*len = policydb.p_bools.nprim;
+	if (!*len) {
+		rc = 0;
+		goto out;
+	}
+
+	*names = (char**)kmalloc(sizeof(char*) * *len, GFP_ATOMIC);
+	if (!*names)
+		goto err;
+	memset(*names, 0, sizeof(char*) * *len);
+
+	*values = (int*)kmalloc(sizeof(int) * *len, GFP_ATOMIC);
+	if (!*values)
+		goto err;
+
+	for (i = 0; i < *len; i++) {
+		size_t name_len;
+		(*values)[i] = policydb.bool_val_to_struct[i]->state;
+		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
+		(*names)[i] = (char*)kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
+		if (!(*names)[i])
+			goto err;
+		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
+		(*names)[i][name_len - 1] = 0;
+	}
+	rc = 0;
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+err:
+	if (*names) {
+		for (i = 0; i < *len; i++)
+			if ((*names)[i])
+				kfree((*names)[i]);
+	}
+	if (*values)
+		kfree(*values);
+	goto out;
+}
+
+
+int security_set_bools(int len, int *values)
+{
+	int i, rc = 0;
+	int lenp, seqno = 0;
+	struct cond_node *cur;
+
+	POLICY_WRLOCK;
+
+	lenp = policydb.p_bools.nprim;
+	if (len != lenp) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	printk(KERN_INFO "security: committed booleans { ");
+	for (i = 0; i < len; i++) {
+		if (values[i]) {
+			policydb.bool_val_to_struct[i]->state = 1;
+		} else {
+			policydb.bool_val_to_struct[i]->state = 0;
+		}
+		if (i != 0)
+			printk(", ");
+		printk("%s:%d", policydb.p_bool_val_to_name[i],
+		       policydb.bool_val_to_struct[i]->state);
+	}
+	printk(" }\n");
+
+	for (cur = policydb.cond_list; cur != NULL; cur = cur->next) {
+		rc = evaluate_cond_node(&policydb, cur);
+		if (rc)
+			goto out;
+	}
+
+	seqno = ++latest_granting;
+
+out:
+	POLICY_WRUNLOCK;
+	if (!rc)
+		avc_ss_reset(seqno);
+	return rc;
+}
+
+int security_get_bool_value(int bool)
+{
+	int rc = 0;
+	int len;
+	
+	POLICY_RDLOCK;
+	
+	len = policydb.p_bools.nprim;
+	if (bool >= len) {
+		rc = -EFAULT;
+		goto out;
+	}
+
+	rc = policydb.bool_val_to_struct[bool]->state;
 out:
 	POLICY_RDUNLOCK;
 	return rc;

--=-3Q3ILB4ZzMVKg+uHxavj
Content-Disposition: attachment; filename=conditional-policy-snapshot-1-14-2004.patch
Content-Type: text/x-patch; name=conditional-policy-snapshot-1-14-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru a/selinux-usr/policy/types/booleans.te b/selinux-usr/policy/types/booleans.te
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/policy/types/booleans.te	Wed Jan 14 15:16:16 2004
@@ -0,0 +1,11 @@
+#
+# Author: Karl MacMillan <kmacmillan@tresys.com>
+#
+
+#
+# disable_dontaudit is a boolean that can be used
+# to disable all of the dontaudit rules in the
+# policy. This is primarily useful for debugging.
+#
+
+bool disable_dontaudit false;
\ No newline at end of file
diff -Nru a/selinux-usr/policy/domains/program/chkpwd.te b/selinux-usr/policy/domains/program/chkpwd.te
--- a/selinux-usr/policy/domains/program/chkpwd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/chkpwd.te	Wed Jan 14 15:17:12 2004
@@ -10,7 +10,10 @@
 type chkpwd_exec_t, file_type, sysadmfile, exec_type;
 
 chkpwd_domain(system)
-dontaudit system_chkpwd_t privfd:fd use;
+if (!disable_dontaudit)
+{
+	dontaudit system_chkpwd_t privfd:fd use;
+}
 
 # Everything else is in the chkpwd_domain macro in
 # macros/program/chkpwd_macros.te.
diff -Nru a/selinux-usr/policy/domains/program/crond.te b/selinux-usr/policy/domains/program/crond.te
--- a/selinux-usr/policy/domains/program/crond.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/crond.te	Wed Jan 14 15:17:12 2004
@@ -37,7 +37,10 @@
 ')
 
 # to stop killall type operations from filling our logs
-dontaudit system_crond_t domain:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit system_crond_t domain:dir search;
+}
 
 # read files in /etc
 allow system_crond_t etc_t:{ file lnk_file } r_file_perms;
@@ -189,7 +192,10 @@
 
 # /sbin/runlevel ask for w access to utmp, but will operate
 # correctly without it.  Do not audit write denials to utmp.
-dontaudit system_crond_t initrc_var_run_t:file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit system_crond_t initrc_var_run_t:file { read write };
+}
 
 # Access accounting summary files.
 allow system_crond_t var_log_sa_t:file create_file_perms;
@@ -206,6 +212,8 @@
 allow system_crond_t var_spool_t:dir rw_dir_perms;
 
 # Do not audit attempts to search unlabeled directories (e.g. slocate).
-dontaudit system_crond_t unlabeled_t:dir r_dir_perms;
-dontaudit system_crond_t unlabeled_t:file r_file_perms;
-
+if (!disable_dontaudit)
+{
+	dontaudit system_crond_t unlabeled_t:dir r_dir_perms;
+	dontaudit system_crond_t unlabeled_t:file r_file_perms;
+}
diff -Nru a/selinux-usr/policy/domains/program/ifconfig.te b/selinux-usr/policy/domains/program/ifconfig.te
--- a/selinux-usr/policy/domains/program/ifconfig.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/ifconfig.te	Wed Jan 14 15:17:12 2004
@@ -30,7 +30,10 @@
 
 # Use capabilities.
 allow ifconfig_t self:capability net_admin;
-dontaudit ifconfig_t self:capability sys_module;
+if (!disable_dontaudit)
+{
+	dontaudit ifconfig_t self:capability sys_module;
+}
 
 # Inherit and use descriptors from init.
 allow ifconfig_t init_t:fd use;
@@ -53,7 +56,10 @@
 # ifconfig attempts to search some sysctl entries.
 # Do not audit those attempts; comment out these rules if it is desired to
 # see the denials.
-dontaudit ifconfig_t { sysctl_t sysctl_net_t }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit ifconfig_t { sysctl_t sysctl_net_t }:dir search;
+}
 
 allow ifconfig_t fs_t:filesystem getattr;
 
diff -Nru a/selinux-usr/policy/domains/program/init.te b/selinux-usr/policy/domains/program/init.te
--- a/selinux-usr/policy/domains/program/init.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/init.te	Wed Jan 14 15:17:12 2004
@@ -126,4 +126,7 @@
 can_exec(init_t,etc_t)
 
 # for initrd pivot_root seems to access this
-dontaudit init_t file_labels_t:dir { search };
+if (!disable_dontaudit)
+{
+	dontaudit init_t file_labels_t:dir { search };
+}
diff -Nru a/selinux-usr/policy/domains/program/ldconfig.te b/selinux-usr/policy/domains/program/ldconfig.te
--- a/selinux-usr/policy/domains/program/ldconfig.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/ldconfig.te	Wed Jan 14 15:17:12 2004
@@ -15,7 +15,10 @@
 role system_r types ldconfig_t;
 
 domain_auto_trans({ sysadm_t initrc_t ifdef(`dpkg.te', `dpkg_t') }, ldconfig_exec_t, ldconfig_t)
-dontaudit ldconfig_t device_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit ldconfig_t device_t:dir search;
+}
 allow ldconfig_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 allow ldconfig_t privfd:fd use;
 
diff -Nru a/selinux-usr/policy/domains/program/login.te b/selinux-usr/policy/domains/program/login.te
--- a/selinux-usr/policy/domains/program/login.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/login.te	Wed Jan 14 15:17:12 2004
@@ -18,7 +18,10 @@
 type $1_login_t, domain, privuser, privrole, privlog, auth_chkpwd, privowner, mlstrustedreader, mlstrustedwriter, mlstrustedobject, privfd;
 role system_r types $1_login_t;
 
-dontaudit $1_login_t shadow_t:file { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit $1_login_t shadow_t:file { getattr read };
+}
 
 general_domain_access($1_login_t);
 
@@ -114,17 +117,22 @@
 login_spawn_domain(local_login, userdomain)
 
 # Do not audit denied attempts to access devices.
-dontaudit local_login_t fixed_disk_device_t:blk_file { getattr setattr };
-dontaudit local_login_t removable_device_t:blk_file { getattr setattr };
-dontaudit local_login_t device_t:{ chr_file blk_file lnk_file } { getattr setattr };
-dontaudit local_login_t misc_device_t:{ chr_file blk_file lnk_file } { getattr setattr };
-dontaudit local_login_t framebuf_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
-dontaudit local_login_t apm_bios_t:chr_file { getattr setattr };
-dontaudit local_login_t v4l_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
-dontaudit local_login_t v4l_device_t:dir { read search getattr };
-
+if (!disable_dontaudit)
+{
+	dontaudit local_login_t fixed_disk_device_t:blk_file { getattr setattr };
+	dontaudit local_login_t removable_device_t:blk_file { getattr setattr };
+	dontaudit local_login_t device_t:{ chr_file blk_file lnk_file } { getattr setattr };
+	dontaudit local_login_t misc_device_t:{ chr_file blk_file lnk_file } { getattr setattr };
+	dontaudit local_login_t framebuf_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
+	dontaudit local_login_t apm_bios_t:chr_file { getattr setattr };
+	dontaudit local_login_t v4l_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
+	dontaudit local_login_t v4l_device_t:dir { read search getattr };
+}
 # Do not audit denied attempts to access /mnt.
-dontaudit local_login_t file_t:dir r_dir_perms;
+if (!disable_dontaudit)
+{
+	dontaudit local_login_t file_t:dir r_dir_perms;
+}
 
 
 # Create lock file.
diff -Nru a/selinux-usr/policy/domains/program/logrotate.te b/selinux-usr/policy/domains/program/logrotate.te
--- a/selinux-usr/policy/domains/program/logrotate.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/logrotate.te	Wed Jan 14 15:17:12 2004
@@ -82,7 +82,10 @@
 # Change ownership on log files.
 allow logrotate_t self:capability { chown dac_override dac_read_search kill fsetid fowner };
 # for mailx
-dontaudit logrotate_t self:capability { setuid setgid };
+if (!disable_dontaudit)
+{
+	dontaudit logrotate_t self:capability { setuid setgid };
+}
 
 ifdef(`mta.te', `
 allow { system_mail_t mta_user_agent } logrotate_tmp_t:file r_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/modutil.te b/selinux-usr/policy/domains/program/modutil.te
--- a/selinux-usr/policy/domains/program/modutil.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/modutil.te	Wed Jan 14 15:17:12 2004
@@ -124,13 +124,22 @@
 domain_auto_trans(privmodule, insmod_exec_t, insmod_t)
 can_exec(insmod_t, insmod_exec_t)
 allow insmod_t privmodule:process sigchld;
-dontaudit sysadm_t self:capability sys_module;
+if (!disable_dontaudit)
+{
+	dontaudit sysadm_t self:capability sys_module;
+}
 
 # for when /var is not mounted early in the boot
-dontaudit insmod_t file_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit insmod_t file_t:dir search;
+}
 
 # kernel threads inherit from shared descriptor table used by init
-dontaudit insmod_t initctl_t:fifo_file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit insmod_t initctl_t:fifo_file { read write };
+}
 
 ifdef(`crond.te', `
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)
@@ -155,7 +164,10 @@
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
 allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
-dontaudit update_modules_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit update_modules_t sysadm_home_dir_t:dir search;
+}
 
 uses_shlib(update_modules_t)
 allow update_modules_t self:process { fork sigchld };
diff -Nru a/selinux-usr/policy/domains/program/newrole.te b/selinux-usr/policy/domains/program/newrole.te
--- a/selinux-usr/policy/domains/program/newrole.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/newrole.te	Wed Jan 14 15:17:12 2004
@@ -83,10 +83,16 @@
 allow newrole_t fs_t:filesystem getattr;
 
 # for some PAM modules and for cwd
-dontaudit newrole_t { home_root_t home_type }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit newrole_t { home_root_t home_type }:dir search;
+}
 
 allow newrole_t proc_t:dir search;
 allow newrole_t proc_t:file { getattr read };
 
 # for when the network connection is killed
-dontaudit unpriv_userdomain newrole_t:process signal;
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain newrole_t:process signal;
+}
diff -Nru a/selinux-usr/policy/domains/program/passwd.te b/selinux-usr/policy/domains/program/passwd.te
--- a/selinux-usr/policy/domains/program/passwd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/passwd.te	Wed Jan 14 15:17:12 2004
@@ -40,20 +40,32 @@
 allow $1_t { ttyfile ptyfile }:chr_file rw_file_perms;
 allow $1_t devtty_t:chr_file rw_file_perms;
 
-dontaudit $1_t devpts_t:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t devpts_t:dir getattr;
+}
 
 # /usr/bin/passwd asks for w access to utmp, but it will operate
 # correctly without it.  Do not audit write denials to utmp.
-dontaudit $1_t initrc_var_run_t:file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit $1_t initrc_var_run_t:file { read write };
+}
 
 # user generally runs this from their home directory, so do not audit a search
 # on user home dir
-dontaudit $1_t { user_home_dir_type user_home_type }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t { user_home_dir_type user_home_type }:dir search;
+}
 
 # When the wrong current passwd is entered, passwd, for some reason, 
 # attempts to access /proc and /dev, but handles failure appropriately. So
 # do not audit those denials.
-dontaudit $1_t { proc_t device_t }:dir { search read };
+if (!disable_dontaudit)
+{
+	dontaudit $1_t { proc_t device_t }:dir { search read };
+}
 
 allow $1_t device_t:dir getattr;
 ')
@@ -76,7 +88,10 @@
 # can exec /sbin/unix_chkpwd
 allow chfn_t sbin_t:dir search;
 # uses unix_chkpwd for checking passwords
-dontaudit chfn_t shadow_t:file read;
+if (!disable_dontaudit)
+{
+	dontaudit chfn_t shadow_t:file read;
+}
 allow chfn_t etc_t:dir rw_dir_perms;
 
 in_user_role(passwd_t)
@@ -92,15 +107,24 @@
 domain_auto_trans(userdomain, chfn_exec_t, chfn_t)
 domain_auto_trans(sysadm_t, admin_passwd_exec_t, sysadm_passwd_t)
 
-dontaudit chfn_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit chfn_t var_t:dir search;
+}
 
 ifdef(`crack.te', `
 allow passwd_t var_t:dir search;
-dontaudit passwd_t var_run_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit passwd_t var_run_t:dir search;
+}
 allow passwd_t crack_db_t:dir r_dir_perms;
 allow passwd_t crack_db_t:file r_file_perms;
 ', `
-dontaudit passwd_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit passwd_t var_t:dir search;
+}
 ')
 
 # allow vipw to exec the editor
@@ -112,12 +136,18 @@
 allow sysadm_passwd_t var_t:dir search;
 tmp_domain(sysadm_passwd)
 # for vipw - vi looks in the root home directory for config
-dontaudit sysadm_passwd_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit sysadm_passwd_t sysadm_home_dir_t:dir { getattr search };
+}
 # for /etc/alternatives/vi
 allow sysadm_passwd_t etc_t:lnk_file read;
 
 # for nscd lookups
-dontaudit sysadm_passwd_t var_run_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit sysadm_passwd_t var_run_t:dir search;
+}
 
 # make sure that getcon succeeds
 allow passwd_t userdomain:dir search;
diff -Nru a/selinux-usr/policy/domains/program/setfiles.te b/selinux-usr/policy/domains/program/setfiles.te
--- a/selinux-usr/policy/domains/program/setfiles.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/setfiles.te	Wed Jan 14 15:17:12 2004
@@ -50,7 +50,10 @@
 allow setfiles_t etc_runtime_t:file read;
 allow setfiles_t etc_t:file read;
 allow setfiles_t proc_t:file { getattr read };
-dontaudit setfiles_t proc_t:lnk_file { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit setfiles_t proc_t:lnk_file { getattr read };
+}
 
 # for config files in a home directory
 allow setfiles_t home_type:file r_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/ssh.te b/selinux-usr/policy/domains/program/ssh.te
--- a/selinux-usr/policy/domains/program/ssh.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/ssh.te	Wed Jan 14 15:17:12 2004
@@ -25,17 +25,26 @@
 # auth_chkpwd is for running unix_chkpwd and unix_verify.
 type $1_t, domain, privuser, privrole, privlog, privowner, privfd, auth_chkpwd;
 role system_r types $1_t;
-dontaudit $1_t shadow_t:file { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit $1_t shadow_t:file { getattr read };
+}
 uses_shlib($1_t)
 allow $1_t self:unix_dgram_socket create_socket_perms;
 allow $1_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_t self:fifo_file rw_file_perms;
 allow $1_t self:process { fork sigchld setsched signal };
 
-dontaudit $1_t self:lnk_file read;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t self:lnk_file read;
+}
 
 # do not allow statfs()
-dontaudit $1_t fs_type:filesystem getattr;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t fs_type:filesystem getattr;
+}
 
 allow $1_t bin_t:dir search;
 allow $1_t bin_t:lnk_file read;
@@ -49,7 +58,10 @@
 # Read /etc.
 allow $1_t etc_t:dir search;
 # ioctl is for pam_console
-dontaudit $1_t etc_t:file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t etc_t:file ioctl;
+}
 allow $1_t etc_t:file { getattr read };
 allow $1_t etc_t:lnk_file { getattr read };
 allow $1_t etc_runtime_t:file { getattr read };
@@ -138,7 +150,10 @@
 sshd_spawn_domain(sshd_extern, user_mini_domain, mini_pty_type)
 
 # for when the network connection breaks after running newrole -r sysadm_r
-dontaudit sshd_t sysadm_devpts_t:chr_file setattr;
+if (!disable_dontaudit)
+{
+	dontaudit sshd_t sysadm_devpts_t:chr_file setattr;
+}
 
 # Allow checking users mail at login
 allow sshd_t { var_spool_t mail_spool_t }:dir search;
diff -Nru a/selinux-usr/policy/domains/program/unused/acct.te b/selinux-usr/policy/domains/program/unused/acct.te
--- a/selinux-usr/policy/domains/program/unused/acct.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/acct.te	Wed Jan 14 15:17:12 2004
@@ -50,13 +50,22 @@
 allow acct_t { sysctl_kernel_t sysctl_t }:dir search;
 allow acct_t sysctl_kernel_t:file read;
 
-dontaudit acct_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit acct_t sysadm_home_dir_t:dir { getattr search };
+}
 
 # for nscd
-dontaudit acct_t var_run_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit acct_t var_run_t:dir search;
+}
 
 # not sure why we need this, the command "last" is reported as using it
-dontaudit acct_t self:capability kill;
+if (!disable_dontaudit)
+{
+	dontaudit acct_t self:capability kill;
+}
 
 allow acct_t devtty_t:chr_file { read write };
 
diff -Nru a/selinux-usr/policy/domains/program/unused/amanda.te b/selinux-usr/policy/domains/program/unused/amanda.te
--- a/selinux-usr/policy/domains/program/unused/amanda.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/amanda.te	Wed Jan 14 15:17:12 2004
@@ -204,10 +204,12 @@
 ###########
 # Dontaudit
 ###########
-dontaudit amanda_t file_labels_t:dir { getattr read search };
-dontaudit amanda_t file_labels_t:file { getattr read };
-dontaudit amanda_t lost_found_t:dir { getattr read };
-	
+if (!disable_dontaudit)
+{
+	dontaudit amanda_t file_labels_t:dir { getattr read search };
+	dontaudit amanda_t file_labels_t:file { getattr read };
+	dontaudit amanda_t lost_found_t:dir { getattr read };
+}
 	
 ##############################################################################
 # AMANDA RECOVER DECLARATIONS
diff -Nru a/selinux-usr/policy/domains/program/unused/amavis.te b/selinux-usr/policy/domains/program/unused/amavis.te
--- a/selinux-usr/policy/domains/program/unused/amavis.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/amavis.te	Wed Jan 14 15:17:12 2004
@@ -82,6 +82,9 @@
 allow amavisd_t etc_runtime_t:file { getattr read };
 
 # broken stuff
-dontaudit amavisd_t sysadm_home_dir_t:dir search;
-dontaudit amavisd_t shadow_t:file { getattr read };
-dontaudit amavisd_t sysadm_devpts_t:chr_file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit amavisd_t sysadm_home_dir_t:dir search;
+	dontaudit amavisd_t shadow_t:file { getattr read };
+	dontaudit amavisd_t sysadm_devpts_t:chr_file { read write };
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/apache.te b/selinux-usr/policy/domains/program/unused/apache.te
--- a/selinux-usr/policy/domains/program/unused/apache.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/apache.te	Wed Jan 14 15:17:12 2004
@@ -94,9 +94,11 @@
 
 ifdef(`mta.te', `
 # apache should set close-on-exec
-dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
-dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };
-')
+if (!disable_dontaudit)
+{
+	dontaudit httpd_suexec_t httpd_t:unix_stream_socket { read write };
+	dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };
+}
 
 uses_shlib(httpd_t)
 
@@ -109,7 +111,10 @@
 # Allow httpd to search users diretories
 ######################
 allow httpd_t home_root_t:dir { getattr search };
-dontaudit httpd_t sysadm_home_dir_t:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit httpd_t sysadm_home_dir_t:dir getattr;
+}
 
 ############################################################################
 # Allow the httpd_t the capability to bind to a port and various other stuff
diff -Nru a/selinux-usr/policy/domains/program/unused/apmd.te b/selinux-usr/policy/domains/program/unused/apmd.te
--- a/selinux-usr/policy/domains/program/unused/apmd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/apmd.te	Wed Jan 14 15:17:12 2004
@@ -66,13 +66,15 @@
 
 # to quiet fuser and ps
 # setuid for fuser, dac* for ps
-dontaudit apmd_t self:capability { setuid dac_override dac_read_search };
-dontaudit apmd_t domain:{ socket_class_set } getattr;
-dontaudit apmd_t { file_type fs_type }:dir_file_class_set getattr;
-dontaudit apmd_t home_type:dir { search getattr };
-dontaudit apmd_t domain:key_socket getattr;
-dontaudit apmd_t domain:dir search;
-
+if (!disable_dontaudit)
+{
+	dontaudit apmd_t self:capability { setuid dac_override dac_read_search };
+	dontaudit apmd_t domain:{ socket_class_set } getattr;
+	dontaudit apmd_t { file_type fs_type }:dir_file_class_set getattr;
+	dontaudit apmd_t home_type:dir { search getattr };
+	dontaudit apmd_t domain:key_socket getattr;
+	dontaudit apmd_t domain:dir search;
+}
 
 ifdef(`rpm.te', `
 can_exec(apmd_t, apmd_var_run_t)
@@ -85,5 +87,8 @@
 ifdef(`netutils.te', `domain_auto_trans(apmd_t, netutils_exec_t, netutils_t)')
 ', `
 # for ifconfig which is run all the time
-dontaudit apmd_t sysctl_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit apmd_t sysctl_t:dir search;
+}
 ')
diff -Nru a/selinux-usr/policy/domains/program/unused/automount.te b/selinux-usr/policy/domains/program/unused/automount.te
--- a/selinux-usr/policy/domains/program/unused/automount.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/automount.te	Wed Jan 14 15:17:12 2004
@@ -46,6 +46,9 @@
 can_exec(automount_t, mount_exec_t)
 
 allow mount_t autofs_t:dir getattr;
-dontaudit automount_t var_t:dir write;
+if (!disable_dontaudit)
+{
+	dontaudit automount_t var_t:dir write;
+}
 
 allow userdomain autofs_t:dir r_dir_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/bootloader.te b/selinux-usr/policy/domains/program/unused/bootloader.te
--- a/selinux-usr/policy/domains/program/unused/bootloader.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/bootloader.te	Wed Jan 14 15:17:12 2004
@@ -22,7 +22,10 @@
 allow bootloader_t var_log_t:file write;
 
 # for nscd
-dontaudit bootloader_t var_run_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit bootloader_t var_run_t:dir search;
+}
 
 domain_auto_trans(sysadm_t, bootloader_exec_t, bootloader_t)
 allow bootloader_t { initrc_t privfd }:fd use;
@@ -54,7 +57,10 @@
 allow bootloader_t { bin_t sbin_t }:lnk_file read;
 
 allow bootloader_t { modules_dep_t modules_object_t }:file read;
-dontaudit bootloader_t modules_dep_t:file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit bootloader_t modules_dep_t:file ioctl;
+}
 allow bootloader_t modules_object_t:dir { read search };
 allow bootloader_t modules_conf_t:file read;
 
@@ -66,7 +72,10 @@
 allow bootloader_t insmod_exec_t:file { rx_file_perms execute_no_trans };
 ')
 
-dontaudit bootloader_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit bootloader_t sysadm_home_dir_t:dir search;
+}
 
 allow bootloader_t boot_t:dir rw_dir_perms;
 allow bootloader_t boot_t:{ file lnk_file } create_file_perms;
@@ -93,7 +102,10 @@
 allow bootloader_t self:capability { fsetid sys_rawio sys_admin mknod chown };
 # allow bootloader to get attributes of any device node
 allow bootloader_t file_type:dir_file_class_set getattr;
-dontaudit bootloader_t devpts_t:dir create_dir_perms;
+if (!disable_dontaudit)
+{
+	dontaudit bootloader_t devpts_t:dir create_dir_perms;
+}
 
 allow bootloader_t self:process { fork signal_perms };
 allow bootloader_t self:lnk_file read;
diff -Nru a/selinux-usr/policy/domains/program/unused/calamaris.te b/selinux-usr/policy/domains/program/unused/calamaris.te
--- a/selinux-usr/policy/domains/program/unused/calamaris.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/calamaris.te	Wed Jan 14 15:17:12 2004
@@ -49,9 +49,11 @@
 allow calamaris_t self:udp_socket create_socket_perms;
 allow calamaris_t { etc_t resolv_conf_t }:file { getattr read };
 allow calamaris_t etc_t:lnk_file read;
-dontaudit calamaris_t etc_t:file ioctl;
-dontaudit calamaris_t sysadm_home_dir_t:dir { getattr search };
-can_network(calamaris_t)
+if (!disable_dontaudit)
+{
+	dontaudit calamaris_t etc_t:file ioctl;
+	dontaudit calamaris_t sysadm_home_dir_t:dir { getattr search };
+}
 ifdef(`named.te', `
 can_udp_send(calamaris_t, named_t)
 can_udp_send(named_t, calamaris_t)
diff -Nru a/selinux-usr/policy/domains/program/unused/ciped.te b/selinux-usr/policy/domains/program/unused/ciped.te
--- a/selinux-usr/policy/domains/program/unused/ciped.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ciped.te	Wed Jan 14 15:17:12 2004
@@ -25,4 +25,7 @@
 
 allow ciped_t random_device_t:chr_file { getattr read };
 
-dontaudit ciped_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit ciped_t var_t:dir search;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/clamav.te b/selinux-usr/policy/domains/program/unused/clamav.te
--- a/selinux-usr/policy/domains/program/unused/clamav.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/clamav.te	Wed Jan 14 15:17:12 2004
@@ -50,4 +50,7 @@
 allow clamd_t self:fifo_file rw_file_perms;
 
 allow clamd_t random_device_t:chr_file { getattr read };
-dontaudit clamd_t random_device_t:chr_file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit clamd_t random_device_t:chr_file ioctl;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/courier.te b/selinux-usr/policy/domains/program/unused/courier.te
--- a/selinux-usr/policy/domains/program/unused/courier.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/courier.te	Wed Jan 14 15:17:12 2004
@@ -75,7 +75,10 @@
 # should not be needed!
 allow courier_authdaemon_t home_root_t:dir search;
 allow courier_authdaemon_t user_home_dir_type:dir search;
-dontaudit courier_authdaemon_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit courier_authdaemon_t sysadm_home_dir_t:dir search;
+}
 allow courier_authdaemon_t self:unix_stream_socket connectto;
 allow courier_authdaemon_t self:capability { setuid setgid };
 allow courier_authdaemon_t resolv_conf_t:file { read getattr };
diff -Nru a/selinux-usr/policy/domains/program/unused/crack.te b/selinux-usr/policy/domains/program/unused/crack.te
--- a/selinux-usr/policy/domains/program/unused/crack.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/crack.te	Wed Jan 14 15:17:12 2004
@@ -39,4 +39,7 @@
 
 allow crack_t fs_t:filesystem getattr;
 
-dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit crack_t sysadm_home_dir_t:dir { getattr search };
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/cups.te b/selinux-usr/policy/domains/program/unused/cups.te
--- a/selinux-usr/policy/domains/program/unused/cups.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/cups.te	Wed Jan 14 15:17:12 2004
@@ -24,7 +24,10 @@
 
 allow cupsd_t printer_device_t:chr_file rw_file_perms;
 allow cupsd_t random_device_t:chr_file { getattr read };
-dontaudit cupsd_t random_device_t:chr_file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit cupsd_t random_device_t:chr_file ioctl;
+}
 
 # temporary solution, we need something better
 allow cupsd_t tty_device_t:chr_file rw_file_perms;
@@ -59,7 +62,10 @@
 allow cupsd_t { sysctl_kernel_t sysctl_dev_t }:file { getattr read };
 
 # for /etc/printcap
-dontaudit cupsd_t etc_t:file write;
+if (!disable_dontaudit)
+{
+	dontaudit cupsd_t etc_t:file write;
+}
 
 # allow cups to execute its backend scripts
 can_exec(cupsd_t, cupsd_exec_t)
diff -Nru a/selinux-usr/policy/domains/program/unused/devfsd.te b/selinux-usr/policy/domains/program/unused/devfsd.te
--- a/selinux-usr/policy/domains/program/unused/devfsd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/devfsd.te	Wed Jan 14 15:17:12 2004
@@ -77,7 +77,10 @@
 allow devfsd_t self:unix_stream_socket connect;
 
 allow devfsd_t devfs_control_t:chr_file { getattr read ioctl };
-dontaudit userdomain devfs_control_t:chr_file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit userdomain devfs_control_t:chr_file getattr;
+}
 
 # allow resolv.conf and UDP access for LDAP or other NSS data source
 allow devfsd_t resolv_conf_t:file r_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/dhcpc.te b/selinux-usr/policy/domains/program/unused/dhcpc.te
--- a/selinux-usr/policy/domains/program/unused/dhcpc.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/dhcpc.te	Wed Jan 14 15:17:12 2004
@@ -38,10 +38,12 @@
 ifdef(`ping.te', `
 domain_auto_trans(dhcpc_t, ping_exec_t, ping_t)
 # because dhcpc is buggy and leaves file handles open...
-dontaudit ping_t dhcpc_state_t:file read;
-dontaudit ping_t dhcpc_t:packet_socket { read write };
-dontaudit ping_t dhcpc_t:udp_socket { read write };
-ifdef(`hotplug.te', `
+if (!disable_dontaudit)
+{
+	dontaudit ping_t dhcpc_state_t:file read;
+	dontaudit ping_t dhcpc_t:packet_socket { read write };
+	dontaudit ping_t dhcpc_t:udp_socket { read write };
+}
 allow ping_t hotplug_t:fd use;
 ') dnl end if hotplug
 ifdef(`cardmgr.te', `
@@ -65,7 +67,10 @@
 allow dhcpc_t self:capability { net_admin net_raw net_bind_service };
 
 # for access("/etc/bashrc", X_OK) on Red Hat
-dontaudit dhcpc_t self:capability dac_read_search;
+if (!disable_dontaudit)
+{
+	dontaudit dhcpc_t self:capability dac_read_search;
+}
 
 # for udp port 68
 allow dhcpc_t dhcpc_port_t:udp_socket name_bind;
@@ -83,9 +88,11 @@
 ifdef(`ifconfig.te', `
 domain_auto_trans(dhcpc_t, ifconfig_exec_t, ifconfig_t)
 # because dhclient is buggy and does not close file handles
-dontaudit ifconfig_t dhcpc_t:{ packet_socket udp_socket } { read write };
-dontaudit ifconfig_t dhcpc_state_t:file { read write };
-')
+if (!disable_dontaudit)
+{
+	dontaudit ifconfig_t dhcpc_t:{ packet_socket udp_socket } { read write };
+	dontaudit ifconfig_t dhcpc_state_t:file { read write };
+}
 
 # Allow dhcpc_t to use packet sockets
 allow dhcpc_t self:packet_socket create_socket_perms;
@@ -99,7 +106,10 @@
 allow dhcpc_t bin_t:lnk_file read;
 can_exec(dhcpc_t, { bin_t shell_exec_t })
 
-dontaudit dhcpc_t domain:packet_socket recvfrom;
-dontaudit dhcpc_t { netmsg_t icmp_socket_t tcp_socket_t igmp_packet_t }:packet_socket recvfrom;
-dontaudit dhcpc_t icmp_socket_t:rawip_socket recvfrom;
-dontaudit dhcpc_t any_socket_t:rawip_socket sendto;
+if (!disable_dontaudit)
+{
+	dontaudit dhcpc_t domain:packet_socket recvfrom;
+	dontaudit dhcpc_t { netmsg_t icmp_socket_t tcp_socket_t igmp_packet_t }:packet_socket recvfrom;
+	dontaudit dhcpc_t icmp_socket_t:rawip_socket recvfrom;
+	dontaudit dhcpc_t any_socket_t:rawip_socket sendto;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/dhcpd.te b/selinux-usr/policy/domains/program/unused/dhcpd.te
--- a/selinux-usr/policy/domains/program/unused/dhcpd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/dhcpd.te	Wed Jan 14 15:17:12 2004
@@ -62,7 +62,10 @@
 # allow reading /proc
 allow dhcpd_t proc_t:{ file lnk_file } r_file_perms;
 
-dontaudit dhcpd_t domain:packet_socket recvfrom;
-dontaudit dhcpd_t { netmsg_t icmp_socket_t tcp_socket_t igmp_packet_t }:packet_socket recvfrom;
-dontaudit dhcpd_t icmp_socket_t:rawip_socket recvfrom;
-dontaudit dhcpd_t any_socket_t:rawip_socket sendto;
+if (!disable_dontaudit)
+{
+	dontaudit dhcpd_t domain:packet_socket recvfrom;
+	dontaudit dhcpd_t { netmsg_t icmp_socket_t tcp_socket_t igmp_packet_t }:packet_socket recvfrom;
+	dontaudit dhcpd_t icmp_socket_t:rawip_socket recvfrom;
+	dontaudit dhcpd_t any_socket_t:rawip_socket sendto;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/dictd.te b/selinux-usr/policy/domains/program/unused/dictd.te
--- a/selinux-usr/policy/domains/program/unused/dictd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/dictd.te	Wed Jan 14 15:17:12 2004
@@ -16,7 +16,10 @@
 type etc_dictd_t, file_type, sysadmfile;
 
 # for checking for nscd
-dontaudit dictd_t var_run_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit dictd_t var_run_t:dir search;
+}
 
 # read config files
 allow dictd_t { etc_t etc_dictd_t resolv_conf_t etc_runtime_t }:file r_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/dpkg.te b/selinux-usr/policy/domains/program/unused/dpkg.te
--- a/selinux-usr/policy/domains/program/unused/dpkg.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/dpkg.te	Wed Jan 14 15:17:12 2004
@@ -145,9 +145,11 @@
 
 allow { apt_t dpkg_t install_menu_t } device_t:dir { getattr search };
 
-dontaudit apt_t var_log_t:dir getattr;
-dontaudit apt_t var_run_t:dir search;
-
+if (!disable_dontaudit)
+{
+	dontaudit apt_t var_log_t:dir getattr;
+	dontaudit apt_t var_run_t:dir search;
+}
 # for rc files such as ~/.less
 r_dir_file(apt_t, sysadm_home_t)
 allow apt_t sysadm_home_dir_t:dir { search getattr };
@@ -186,7 +188,10 @@
 ')
 
 # for kernel-image postinst
-dontaudit dpkg_t fixed_disk_device_t:blk_file read;
+if (!disable_dontaudit)
+{
+	dontaudit dpkg_t fixed_disk_device_t:blk_file read;
+}
 
 # allow user domains to execute dpkg
 allow userdomain dpkg_exec_t:dir r_dir_perms;
@@ -215,7 +220,10 @@
 
 # Inherit and use descriptors from open_init_pty
 allow { apt_t dpkg_t install_menu_t } initrc_t:fd use;
-dontaudit dpkg_t privfd:fd use;
+if (!disable_dontaudit)
+{
+	dontaudit dpkg_t privfd:fd use;
+}
 allow { apt_t dpkg_t install_menu_t } devpts_t:dir search;
 allow { apt_t dpkg_t install_menu_t } initrc_devpts_t:chr_file rw_file_perms;
 
@@ -249,7 +257,10 @@
 ifdef(`devfsd.te', `', `
 allow dpkg_t file_type:{ chr_file blk_file } { create setattr rename };
 ')
-dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
+if (!disable_dontaudit)
+{
+	dontaudit dpkg_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
+}
 allow dpkg_t proc_kmsg_t:file getattr;
 allow dpkg_t root_dir_type:dir getattr;
 
@@ -277,7 +288,10 @@
 allow apt_t tcp_socket_t:tcp_socket connectto;
 
 allow { apt_t dpkg_t } var_t:dir { search getattr };
-dontaudit apt_t { fs_type file_type }:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit apt_t { fs_type file_type }:dir getattr;
+}
 allow { apt_t dpkg_t } { var_lib_t bin_t }:dir r_dir_perms;
 
 allow { apt_t dpkg_t } dpkg_lock_t:file { setattr rw_file_perms };
@@ -314,7 +328,10 @@
 type debian_menu_t, file_type, sysadmfile;
 
 r_dir_file(userdomain, debian_menu_t)
-dontaudit install_menu_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit install_menu_t sysadm_home_dir_t:dir search;
+}
 allow install_menu_t debian_menu_t:dir create_dir_perms;
 allow install_menu_t debian_menu_t:{ file lnk_file } create_file_perms;
 allow install_menu_t dpkg_lock_t:file { setattr rw_file_perms };
diff -Nru a/selinux-usr/policy/domains/program/unused/fingerd.te b/selinux-usr/policy/domains/program/unused/fingerd.te
--- a/selinux-usr/policy/domains/program/unused/fingerd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/fingerd.te	Wed Jan 14 15:17:12 2004
@@ -35,7 +35,10 @@
 
 allow fingerd_t self:capability { setgid setuid };
 # for gzip from logrotate
-dontaudit fingerd_t self:capability fsetid;
+if (!disable_dontaudit)
+{
+	dontaudit fingerd_t self:capability fsetid;
+}
 
 # cfingerd runs shell scripts
 allow fingerd_t { bin_t sbin_t }:dir search;
@@ -61,7 +64,10 @@
 allow fingerd_t user_home_type:file { getattr read };
 # stop it accessing sub-directories, prevents checking a Maildir for new mail,
 # have to change this when we create a type for Maildir
-dontaudit fingerd_t user_home_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit fingerd_t user_home_t:dir search;
+}
 
 # for mail
 allow fingerd_t { var_spool_t mail_spool_t }:dir search;
@@ -70,7 +76,10 @@
 
 # see who is logged in and when users last logged in
 allow fingerd_t { initrc_var_run_t lastlog_t }:file { read getattr };
-dontaudit fingerd_t initrc_var_run_t:file lock;
+if (!disable_dontaudit)
+{
+	dontaudit fingerd_t initrc_var_run_t:file lock;
+}
 allow fingerd_t devpts_t:dir search;
 allow fingerd_t ptyfile:chr_file getattr;
 
diff -Nru a/selinux-usr/policy/domains/program/unused/ftpd.te b/selinux-usr/policy/domains/program/unused/ftpd.te
--- a/selinux-usr/policy/domains/program/unused/ftpd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ftpd.te	Wed Jan 14 15:17:12 2004
@@ -81,5 +81,8 @@
 allow ftpd_t { etc_t resolv_conf_t etc_runtime_t }:file { getattr read };
 allow ftpd_t proc_t:file { getattr read };
 
-dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
-dontaudit ftpd_t random_device_t:chr_file read;
+if (!disable_dontaudit)
+{
+	dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
+	dontaudit ftpd_t random_device_t:chr_file read;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/hotplug.te b/selinux-usr/policy/domains/program/unused/hotplug.te
--- a/selinux-usr/policy/domains/program/unused/hotplug.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/hotplug.te	Wed Jan 14 15:17:12 2004
@@ -69,10 +69,16 @@
 allow hotplug_t modules_dep_t:file { getattr read ioctl };
 
 # for lsmod
-dontaudit hotplug_t self:capability sys_module;
+if (!disable_dontaudit)
+{
+	dontaudit hotplug_t self:capability sys_module;
+}
 
 # for access("/etc/bashrc", X_OK) on Red Hat
-dontaudit hotplug_t self:capability dac_read_search;
+if (!disable_dontaudit)
+{
+	dontaudit hotplug_t self:capability dac_read_search;
+}
 
 ifdef(`fsadm.te', `
 domain_auto_trans(hotplug_t, fsadm_exec_t, fsadm_t)
@@ -81,9 +87,11 @@
 allow hotplug_t var_log_t:dir search;
 
 # for ps
-dontaudit hotplug_t domain:dir { getattr search };
-dontaudit hotplug_t { init_t kernel_t }:file read;
-ifdef(`initrc.te', `
+if (!disable_dontaudit)
+{
+	dontaudit hotplug_t domain:dir { getattr search };
+	dontaudit hotplug_t { init_t kernel_t }:file read;
+}
 can_ps(hotplug_t, initrc_t)
 ')
 ifdef(`modutil.te', `
@@ -91,10 +99,16 @@
 ')
 
 # for when /var is not mounted early in the boot
-dontaudit hotplug_t file_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit hotplug_t file_t:dir search;
+}
 
 # kernel threads inherit from shared descriptor table used by init
-dontaudit hotplug_t initctl_t:fifo_file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit hotplug_t initctl_t:fifo_file { read write };
+}
 
 # Read /usr/lib/gconv/.*
 allow hotplug_t lib_t:file { getattr read };
diff -Nru a/selinux-usr/policy/domains/program/unused/ipsec.te b/selinux-usr/policy/domains/program/unused/ipsec.te
--- a/selinux-usr/policy/domains/program/unused/ipsec.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ipsec.te	Wed Jan 14 15:17:12 2004
@@ -111,12 +111,17 @@
 allow ipsec_mgmt_t system_map_t:file { read getattr };
 
 # denials when ps tries to search /proc. Do not audit these denials.
-dontaudit ipsec_mgmt_t domain:dir r_dir_perms;
+if (!disable_dontaudit)
+{
+	dontaudit ipsec_mgmt_t domain:dir r_dir_perms;
+}
 
 # suppress audit messages about unnecessary socket access
-dontaudit ipsec_mgmt_t domain:key_socket { read write };
-dontaudit ipsec_mgmt_t domain:udp_socket { read write };
-
+if (!disable_dontaudit)
+{
+	dontaudit ipsec_mgmt_t domain:key_socket { read write };
+	dontaudit ipsec_mgmt_t domain:udp_socket { read write };
+}
 # from rbac
 role system_r types { ipsec_t ipsec_mgmt_t };
 
@@ -139,9 +144,11 @@
 allow ipsec_t bin_t:dir { search };
 allow ipsec_t device_t:dir { getattr search };
 allow ipsec_mgmt_t device_t:dir { getattr search read };
-dontaudit ipsec_mgmt_t tty_device_t:chr_file getattr;
-dontaudit ipsec_mgmt_t devpts_t:dir getattr;
-allow ipsec_mgmt_t etc_t:lnk_file read;
+if (!disable_dontaudit)
+{
+	dontaudit ipsec_mgmt_t tty_device_t:chr_file getattr;
+	dontaudit ipsec_mgmt_t devpts_t:dir getattr;
+}
 allow ipsec_mgmt_t var_t:dir { search };
 allow ipsec_mgmt_t sbin_t:dir { search };
 allow ipsec_mgmt_t bin_t:dir { search };
diff -Nru a/selinux-usr/policy/domains/program/unused/loadkeys.te b/selinux-usr/policy/domains/program/unused/loadkeys.te
--- a/selinux-usr/policy/domains/program/unused/loadkeys.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/loadkeys.te	Wed Jan 14 15:17:12 2004
@@ -16,7 +16,10 @@
 domain_auto_trans(unpriv_userdomain, loadkeys_exec_t, loadkeys_t)
 
 uses_shlib(loadkeys_t)
-dontaudit loadkeys_t proc_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit loadkeys_t proc_t:dir search;
+}
 allow loadkeys_t proc_t:file { getattr read };
 allow loadkeys_t self:process { fork sigchld };
 
@@ -27,7 +30,10 @@
 
 read_locale(loadkeys_t)
 
-dontaudit loadkeys_t etc_runtime_t:file { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit loadkeys_t etc_runtime_t:file { getattr read };
+}
 
 # Use capabilities.
 allow loadkeys_t self:capability { setuid sys_tty_config };
diff -Nru a/selinux-usr/policy/domains/program/unused/lpd.te b/selinux-usr/policy/domains/program/unused/lpd.te
--- a/selinux-usr/policy/domains/program/unused/lpd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/lpd.te	Wed Jan 14 15:17:12 2004
@@ -76,7 +76,10 @@
 allow lpd_t proc_t:file { getattr read };
 
 # gs-gnu wants to read some sysctl entries, it seems to work without though
-dontaudit lpd_t { sysctl_t sysctl_kernel_t }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit lpd_t { sysctl_t sysctl_kernel_t }:dir search;
+}
 
 # for defoma
 r_dir_file(lpd_t, var_lib_t)
diff -Nru a/selinux-usr/policy/domains/program/unused/mailman.te b/selinux-usr/policy/domains/program/unused/mailman.te
--- a/selinux-usr/policy/domains/program/unused/mailman.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/mailman.te	Wed Jan 14 15:17:12 2004
@@ -44,7 +44,10 @@
 allow mailman_queue_t sysadm_home_dir_t:dir { getattr search };
 
 mailman_domain(mail)
-dontaudit mailman_mail_t mta_delivery_agent:tcp_socket { read write };
+if (!disable_dontaudit)
+{
+	dontaudit mailman_mail_t mta_delivery_agent:tcp_socket { read write };
+}
 allow mailman_mail_t mta_delivery_agent:fd use;
 ifdef(`qmail.te', `
 allow mailman_mail_t qmail_spool_t:file { read ioctl getattr };
@@ -64,7 +67,10 @@
 allow httpd_t mailman_data_t:dir search;
 r_dir_file(mailman_cgi_t, mailman_archive_t)
 
-dontaudit mailman_cgi_t httpd_log_t:file append;
+if (!disable_dontaudit)
+{
+	dontaudit mailman_cgi_t httpd_log_t:file append;
+}
 allow httpd_t mailman_cgi_t:process signal;
 allow mailman_cgi_t httpd_t:process sigchld;
 allow mailman_cgi_t httpd_t:fd use;
diff -Nru a/selinux-usr/policy/domains/program/unused/mrtg.te b/selinux-usr/policy/domains/program/unused/mrtg.te
--- a/selinux-usr/policy/domains/program/unused/mrtg.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/mrtg.te	Wed Jan 14 15:17:12 2004
@@ -46,7 +46,10 @@
 ')
 
 allow mrtg_t proc_t:file { read getattr };
-dontaudit mrtg_t proc_t:file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t proc_t:file ioctl;
+}
 
 allow mrtg_t { var_lock_t var_lib_t }:dir search;
 rw_dir_create_file(mrtg_t, var_lib_mrtg_t)
@@ -54,13 +57,22 @@
 
 # read config files
 allow mrtg_t { etc_t etc_mrtg_t resolv_conf_t }:file { read getattr };
-dontaudit mrtg_t etc_mrtg_t:file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t etc_mrtg_t:file ioctl;
+}
 allow mrtg_t etc_mrtg_t:dir { read search getattr };
-dontaudit mrtg_t etc_mrtg_t:dir write;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t etc_mrtg_t:dir write;
+}
 read_locale(mrtg_t)
 
 # for /.autofsck
-dontaudit mrtg_t root_t:file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t root_t:file getattr;
+}
 
 allow mrtg_t { sysctl_t sysctl_kernel_t }:dir search;
 allow mrtg_t sysctl_kernel_t:file read;
@@ -68,15 +80,27 @@
 # for uptime
 allow mrtg_t var_run_t:dir search;
 allow mrtg_t initrc_var_run_t:file read;
-dontaudit mrtg_t initrc_var_run_t:file { write lock };
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t initrc_var_run_t:file { write lock };
+}
 allow mrtg_t etc_runtime_t:file { getattr read };
 
 allow mrtg_t tmp_t:dir getattr;
 
 # should not need this!
 allow mrtg_t sysadm_home_dir_t:dir { search read getattr };
-dontaudit mrtg_t { boot_t device_t file_labels_t file_t lost_found_t }:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t { boot_t device_t file_labels_t file_t lost_found_t }:dir getattr;
+}
 ifdef(`quota.te', `
-dontaudit mrtg_t quota_db_t:file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t quota_db_t:file getattr;
+}
 ')
-dontaudit mrtg_t root_t:lnk_file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit mrtg_t root_t:lnk_file getattr;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/named.te b/selinux-usr/policy/domains/program/unused/named.te
--- a/selinux-usr/policy/domains/program/unused/named.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/named.te	Wed Jan 14 15:17:12 2004
@@ -118,7 +118,10 @@
 allow ndc_t named_zone_t:dir search;
 
 # for chmod in start script
-dontaudit initrc_t named_var_run_t:dir setattr;
+if (!disable_dontaudit)
+{
+	dontaudit initrc_t named_var_run_t:dir setattr;
+}
 
 # for ndc_t to be used for restart shell scripts
 ifdef(`ndc_shell_script', `
@@ -131,5 +134,8 @@
 allow ndc_t named_var_run_t:file getattr;
 allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
-dontaudit ndc_t sysadm_home_t:dir { getattr search read };
+if (!disable_dontaudit)
+{
+	dontaudit ndc_t sysadm_home_t:dir { getattr search read };
+}
 ')
diff -Nru a/selinux-usr/policy/domains/program/unused/netsaint.te b/selinux-usr/policy/domains/program/unused/netsaint.te
--- a/selinux-usr/policy/domains/program/unused/netsaint.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/netsaint.te	Wed Jan 14 15:17:12 2004
@@ -21,9 +21,11 @@
 tmp_domain(netsaint)
 allow system_mail_t netsaint_tmp_t:file { getattr read };
 # for open file handles
-dontaudit system_mail_t etc_netsaint_t:file read;
-dontaudit system_mail_t netsaint_log_t:fifo_file read;
-
+if (!disable_dontaudit)
+{
+	dontaudit system_mail_t etc_netsaint_t:file read;
+	dontaudit system_mail_t netsaint_log_t:fifo_file read;
+}
 # Use the network.
 allow netsaint_t self:fifo_file rw_file_perms;
 allow netsaint_t self:unix_stream_socket create_socket_perms;
@@ -70,7 +72,10 @@
 r_dir_file(netsaint_cgi_t, { proc_t self netsaint_t })
 allow netsaint_cgi_t boot_t:dir search;
 allow netsaint_cgi_t system_map_t:file { getattr read };
-dontaudit netsaint_cgi_t domain:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit netsaint_cgi_t domain:dir getattr;
+}
 allow netsaint_cgi_t self:unix_stream_socket create_socket_perms;
 
 ifdef(`apache.te', `
@@ -82,6 +87,8 @@
 ifdef(`ping.te', `
 domain_auto_trans(netsaint_t, ping_exec_t, ping_t)
 allow netsaint_t ping_t:process { sigkill signal };
-dontaudit ping_t etc_netsaint_t:file read;
-dontaudit ping_t netsaint_log_t:fifo_file read;
-')
+if (!disable_dontaudit)
+{
+	dontaudit ping_t etc_netsaint_t:file read;
+	dontaudit ping_t netsaint_log_t:fifo_file read;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/nscd.te b/selinux-usr/policy/domains/program/unused/nscd.te
--- a/selinux-usr/policy/domains/program/unused/nscd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/nscd.te	Wed Jan 14 15:17:12 2004
@@ -32,4 +32,7 @@
 # for when /etc/passwd has just been updated and has the wrong type
 allow nscd_t shadow_t:file getattr;
 
-dontaudit nscd_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit nscd_t sysadm_home_dir_t:dir search;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/ntpd.te b/selinux-usr/policy/domains/program/unused/ntpd.te
--- a/selinux-usr/policy/domains/program/unused/ntpd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ntpd.te	Wed Jan 14 15:17:12 2004
@@ -23,7 +23,10 @@
 allow ntpd_t self:capability { setgid setuid sys_time net_bind_service ipc_lock };
 allow ntpd_t self:process { setcap setsched };
 # ntpdate wants sys_nice
-dontaudit ntpd_t self:capability { fsetid sys_nice };
+if (!disable_dontaudit)
+{
+	dontaudit ntpd_t self:capability { fsetid sys_nice };
+}
 
 # for some reason it creates a file in /tmp
 tmp_domain(ntpd)
@@ -58,7 +61,10 @@
 allow ntpd_t proc_t:file r_file_perms;
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
 allow ntpd_t self:file read;
-dontaudit ntpd_t domain:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit ntpd_t domain:dir search;
+}
 ')
 
 allow ntpd_t devtty_t:chr_file rw_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/ping.te b/selinux-usr/policy/domains/program/unused/ping.te
--- a/selinux-usr/policy/domains/program/unused/ping.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ping.te	Wed Jan 14 15:17:12 2004
@@ -51,7 +51,13 @@
 ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')
 allow ping_t privfd:fd use;
 
-dontaudit ping_t fs_t:filesystem getattr;
+if (!disable_dontaudit)
+{
+	dontaudit ping_t fs_t:filesystem getattr;
+}
 
 # it tries to access /var/run
-dontaudit ping_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit ping_t var_t:dir search;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/postfix.te b/selinux-usr/policy/domains/program/unused/postfix.te
--- a/selinux-usr/policy/domains/program/unused/postfix.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/postfix.te	Wed Jan 14 15:17:12 2004
@@ -104,7 +104,10 @@
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
 allow postfix_master_t postfix_spool_t:file rw_file_perms;
 
-dontaudit postfix_master_t man_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit postfix_master_t man_t:dir search;
+}
 
 define(`postfix_server_domain', `
 postfix_domain($1, `$2')
@@ -140,7 +143,10 @@
 ifdef(`procmail.te', `
 domain_auto_trans(postfix_local_t, procmail_exec_t, procmail_t)
 # for a bug in the postfix local program
-dontaudit procmail_t postfix_local_t:tcp_socket { read write };
+if (!disable_dontaudit)
+{
+	dontaudit procmail_t postfix_local_t:tcp_socket { read write };
+}
 ')
 allow postfix_local_t etc_aliases_t:file r_file_perms;
 allow postfix_local_t self:fifo_file rw_file_perms;
@@ -218,7 +224,10 @@
 allow postfix_postdrop_t user_mail_domain:unix_stream_socket rw_socket_perms;
 allow postfix_postdrop_t postfix_public_t:dir search;
 allow postfix_postdrop_t postfix_public_t:fifo_file rw_file_perms;
-dontaudit postfix_postdrop_t { ptyfile ttyfile }:chr_file { read write };
+if (!disable_dontaudit)
+{
+	dontaudit postfix_postdrop_t { ptyfile ttyfile }:chr_file { read write };
+}
 allow postfix_master_t postfix_postdrop_exec_t:file getattr;
 ifdef(`crond.te',
 `allow postfix_postdrop_t { crond_t system_crond_t }:fd use;
diff -Nru a/selinux-usr/policy/domains/program/unused/postgresql.te b/selinux-usr/policy/domains/program/unused/postgresql.te
--- a/selinux-usr/policy/domains/program/unused/postgresql.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/postgresql.te	Wed Jan 14 15:17:12 2004
@@ -22,10 +22,16 @@
 can_exec(postgresql_t, dpkg_exec_t)
 ')
 
-dontaudit postgresql_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit postgresql_t sysadm_home_dir_t:dir search;
+}
 
 # quiet ps
-dontaudit postgresql_t domain:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit postgresql_t domain:dir getattr;
+}
 
 # for currect directory of scripts
 allow postgresql_t { var_spool_t cron_spool_t }:dir search;
diff -Nru a/selinux-usr/policy/domains/program/unused/procmail.te b/selinux-usr/policy/domains/program/unused/procmail.te
--- a/selinux-usr/policy/domains/program/unused/procmail.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/procmail.te	Wed Jan 14 15:17:12 2004
@@ -53,6 +53,9 @@
 allow procmail_t var_run_t:dir { getattr search };
 
 # Do not audit attempts to access /root.
-dontaudit procmail_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit procmail_t sysadm_home_dir_t:dir { getattr search };
+}
 
 allow procmail_t devtty_t:chr_file { read write };
diff -Nru a/selinux-usr/policy/domains/program/unused/qmail.te b/selinux-usr/policy/domains/program/unused/qmail.te
--- a/selinux-usr/policy/domains/program/unused/qmail.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/qmail.te	Wed Jan 14 15:17:12 2004
@@ -55,7 +55,10 @@
 allow qmail_lspawn_t qmail_spool_t:file { read getattr };
 allow qmail_lspawn_t etc_t:file { getattr read };
 allow qmail_lspawn_t tmp_t:dir getattr;
-dontaudit qmail_lspawn_t user_home_dir_type:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit qmail_lspawn_t user_home_dir_type:dir { getattr search };
+}
 
 qmail_daemon_domain(send)
 rw_dir_create_file(qmail_send_t, qmail_spool_t)
@@ -68,7 +71,10 @@
 qmail_daemon_domain(splogger)
 allow qmail_splogger_t self:unix_dgram_socket create_socket_perms;
 allow qmail_splogger_t etc_t:lnk_file read;
-dontaudit qmail_splogger_t initrc_t:fd use;
+if (!disable_dontaudit)
+{
+	dontaudit qmail_splogger_t initrc_t:fd use;
+}
 read_locale(qmail_splogger_t)
 
 qmail_daemon_domain(rspawn)
diff -Nru a/selinux-usr/policy/domains/program/unused/quota.te b/selinux-usr/policy/domains/program/unused/quota.te
--- a/selinux-usr/policy/domains/program/unused/quota.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/quota.te	Wed Jan 14 15:17:12 2004
@@ -44,7 +44,10 @@
 
 # for /quota.*
 allow quota_t quota_db_t:file { read write };
-dontaudit unpriv_userdomain quota_db_t:file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain quota_db_t:file getattr;
+}
 allow quota_t quota_db_t:file quotaon;
 
 # Read /etc/mtab.
diff -Nru a/selinux-usr/policy/domains/program/unused/radius.te b/selinux-usr/policy/domains/program/unused/radius.te
--- a/selinux-usr/policy/domains/program/unused/radius.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/radius.te	Wed Jan 14 15:17:12 2004
@@ -22,7 +22,10 @@
 
 allow radiusd_t proc_t:file { read getattr };
 
-dontaudit radiusd_t sysadm_home_dir_t:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit radiusd_t sysadm_home_dir_t:dir getattr;
+}
 
 # allow pthreads to read kernel version
 allow radiusd_t sysctl_kernel_t:dir r_dir_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/rpm.te b/selinux-usr/policy/domains/program/unused/rpm.te
--- a/selinux-usr/policy/domains/program/unused/rpm.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/rpm.te	Wed Jan 14 15:17:12 2004
@@ -53,10 +53,16 @@
 ')
 
 # for a bug in rm
-dontaudit initrc_t pidfile:file write;
+if (!disable_dontaudit)
+{
+	dontaudit initrc_t pidfile:file write;
+}
 
 # bash tries ioctl for some reason
-dontaudit initrc_t pidfile:file ioctl;
+if (!disable_dontaudit)
+{
+	dontaudit initrc_t pidfile:file ioctl;
+}
 
 allow rpm_t device_t:dir rw_dir_perms;
 allow rpm_t sysadmfile:dir create_dir_perms;
@@ -69,7 +75,10 @@
 allow rpm_t sysctl_kernel_t:file { getattr read };
 allow rpm_t devpts_t:dir getattr;
 allow rpm_t { devpts_t proc_t usbdevfs_t fs_t }:filesystem getattr;
-dontaudit rpm_t security_t:filesystem getattr;
+if (!disable_dontaudit)
+{
+	dontaudit rpm_t security_t:filesystem getattr;
+}
 can_getcon(rpm_t)
 allow rpm_t self:file getattr;
 
diff -Nru a/selinux-usr/policy/domains/program/unused/scannerdaemon.te b/selinux-usr/policy/domains/program/unused/scannerdaemon.te
--- a/selinux-usr/policy/domains/program/unused/scannerdaemon.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/scannerdaemon.te	Wed Jan 14 15:17:12 2004
@@ -54,6 +54,9 @@
 allow scannerdaemon_t self:fifo_file { read write };
 
 # broken stuff
-dontaudit scannerdaemon_t sysadm_home_dir_t:dir search;
-dontaudit scannerdaemon_t devtty_t:chr_file { read write };
-dontaudit scannerdaemon_t shadow_t:file { read getattr };
+if (!disable_dontaudit)
+{
+	dontaudit scannerdaemon_t sysadm_home_dir_t:dir search;
+	dontaudit scannerdaemon_t devtty_t:chr_file { read write };
+	dontaudit scannerdaemon_t shadow_t:file { read getattr };
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/sendmail.te b/selinux-usr/policy/domains/program/unused/sendmail.te
--- a/selinux-usr/policy/domains/program/unused/sendmail.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/sendmail.te	Wed Jan 14 15:17:12 2004
@@ -55,14 +55,20 @@
 # /usr/sbin/sendmail asks for w access to utmp, but it will operate
 # correctly without it.  Do not audit write and lock denials to utmp.
 allow sendmail_t initrc_var_run_t:file { getattr read };
-dontaudit sendmail_t initrc_var_run_t:file { lock write };
+if (!disable_dontaudit)
+{
+	dontaudit sendmail_t initrc_var_run_t:file { lock write };
+}
 
 # When sendmail runs as user_mail_domain, it needs some extra permissions
 # to update /etc/mail/statistics.
 allow user_mail_domain etc_mail_t:file rw_file_perms;
 
 # Silently deny attempts to access /root.
-dontaudit system_mail_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit system_mail_t sysadm_home_dir_t:dir { getattr search };
+}
 
 # Run procmail in its own domain, if defined.
 ifdef(`procmail.te',`
diff -Nru a/selinux-usr/policy/domains/program/unused/squid.te b/selinux-usr/policy/domains/program/unused/squid.te
--- a/selinux-usr/policy/domains/program/unused/squid.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/squid.te	Wed Jan 14 15:17:12 2004
@@ -70,4 +70,7 @@
 can_exec(squid_t, { lib_t squid_exec_t } )
 allow squid_t { bin_t sbin_t }:dir search;
 
-dontaudit squid_t home_root_t:dir getattr;
+if (!disable_dontaudit)
+{
+	dontaudit squid_t home_root_t:dir getattr;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/sxid.te b/selinux-usr/policy/domains/program/unused/sxid.te
--- a/selinux-usr/policy/domains/program/unused/sxid.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/sxid.te	Wed Jan 14 15:17:12 2004
@@ -43,18 +43,30 @@
 allow sxid_t devtty_t:chr_file rw_file_perms;
 
 allow sxid_t self:capability { dac_override dac_read_search fsetid };
-dontaudit sxid_t self:capability { setuid setgid };
+if (!disable_dontaudit)
+{
+	dontaudit sxid_t self:capability { setuid setgid };
+}
 
 ifdef(`mta.te', `
 # sxid leaves an open file handle to /proc/mounts
-dontaudit { system_mail_t mta_user_agent } sxid_t:file { read getattr };
+if (!disable_dontaudit)
+{
+	dontaudit { system_mail_t mta_user_agent } sxid_t:file { read getattr };
+}
 
 # allow mta to read the log files
 allow { system_mail_t mta_user_agent } { sxid_tmp_t sxid_log_t }:file { getattr read };
 # stop warnings if mailx is passed a read/write file handle
-dontaudit { system_mail_t mta_user_agent } { sxid_tmp_t sxid_log_t }:file write;
+if (!disable_dontaudit)
+{
+	dontaudit { system_mail_t mta_user_agent } { sxid_tmp_t sxid_log_t }:file write;
+}
 ')
 
 allow logrotate_t sxid_t:file { getattr write };
 
-dontaudit sxid_t security_t:dir { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit sxid_t security_t:dir { getattr read };
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/sysstat.te b/selinux-usr/policy/domains/program/unused/sysstat.te
--- a/selinux-usr/policy/domains/program/unused/sysstat.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/sysstat.te	Wed Jan 14 15:17:12 2004
@@ -22,9 +22,15 @@
 #for date
 can_exec(sysstat_t, { sysstat_exec_t bin_t })
 allow sysstat_t bin_t:dir r_dir_perms;
-dontaudit sysstat_t sbin_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit sysstat_t sbin_t:dir search;
+}
 
-dontaudit sysstat_t self:capability sys_admin;
+if (!disable_dontaudit)
+{
+	dontaudit sysstat_t self:capability sys_admin;
+}
 
 allow sysstat_t devtty_t:chr_file rw_file_perms;
 # for mtab
@@ -32,7 +38,10 @@
 # for fstab
 allow sysstat_t etc_t:file { read getattr };
 
-dontaudit sysstat_t sysadm_home_dir_t:dir r_dir_perms;
+if (!disable_dontaudit)
+{
+	dontaudit sysstat_t sysadm_home_dir_t:dir r_dir_perms;
+}
 
 allow sysstat_t self:fifo_file rw_file_perms;
 
diff -Nru a/selinux-usr/policy/domains/program/unused/tcpd.te b/selinux-usr/policy/domains/program/unused/tcpd.te
--- a/selinux-usr/policy/domains/program/unused/tcpd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/tcpd.te	Wed Jan 14 15:17:12 2004
@@ -19,7 +19,10 @@
 allow tcpd_t fs_t:filesystem getattr;
 
 # no good reason for this, probably nscd
-dontaudit tcpd_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit tcpd_t var_t:dir search;
+}
 
 can_network(tcpd_t)
 allow tcpd_t self:unix_dgram_socket create_socket_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/traceroute.te b/selinux-usr/policy/domains/program/unused/traceroute.te
--- a/selinux-usr/policy/domains/program/unused/traceroute.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/traceroute.te	Wed Jan 14 15:17:12 2004
@@ -45,5 +45,8 @@
 allow traceroute_t privfd:fd use;
 
 # dont need this
-dontaudit traceroute_t fs_t:filesystem getattr;
-dontaudit traceroute_t var_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit traceroute_t fs_t:filesystem getattr;
+	dontaudit traceroute_t var_t:dir search;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/updfstab.te b/selinux-usr/policy/domains/program/unused/updfstab.te
--- a/selinux-usr/policy/domains/program/unused/updfstab.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/updfstab.te	Wed Jan 14 15:17:12 2004
@@ -26,9 +26,11 @@
 
 # not sure what the sysctl_kernel_t file is, or why it wants to write it, so
 # I will not allow it
-dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
-dontaudit updfstab_t sysctl_kernel_t:file write;
-allow updfstab_t modules_conf_t:file { getattr read };
+if (!disable_dontaudit)
+{
+	dontaudit updfstab_t { sysctl_t sysctl_kernel_t }:dir search;
+	dontaudit updfstab_t sysctl_kernel_t:file write;
+}
 allow updfstab_t sbin_t:dir search;
 allow updfstab_t sbin_t:lnk_file read;
 allow updfstab_t { var_t var_log_t }:dir search;
diff -Nru a/selinux-usr/policy/domains/program/unused/userhelper.te b/selinux-usr/policy/domains/program/unused/userhelper.te
--- a/selinux-usr/policy/domains/program/unused/userhelper.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/userhelper.te	Wed Jan 14 15:17:12 2004
@@ -82,13 +82,19 @@
 allow userhelper_t fs_t:filesystem getattr;
 
 # for some PAM modules and for cwd
-dontaudit userhelper_t { home_root_t home_type }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit userhelper_t { home_root_t home_type }:dir search;
+}
 
 allow userhelper_t proc_t:dir search;
 allow userhelper_t proc_t:file { getattr read };
 
 # for when the network connection is killed
-dontaudit unpriv_userdomain userhelper_t:process signal;
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain userhelper_t:process signal;
+}
 
 type run_init_conf_t, file_type, sysadmfile;
 allow userhelper_t run_init_conf_t:file rw_file_perms;
diff -Nru a/selinux-usr/policy/domains/program/unused/watchdog.te b/selinux-usr/policy/domains/program/unused/watchdog.te
--- a/selinux-usr/policy/domains/program/unused/watchdog.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/watchdog.te	Wed Jan 14 15:17:12 2004
@@ -50,4 +50,7 @@
 allow watchdog_t wtmp_t:file append;
 
 # do not care about saving the random seed
-dontaudit watchdog_t random_device_t:chr_file read;
+if (!disable_dontaudit)
+{
+	dontaudit watchdog_t random_device_t:chr_file read;
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/xdm.te b/selinux-usr/policy/domains/program/unused/xdm.te
--- a/selinux-usr/policy/domains/program/unused/xdm.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/xdm.te	Wed Jan 14 15:17:12 2004
@@ -31,7 +31,10 @@
 # NB we do NOT allow xdm_xserver_t xdm_var_lib_t:dir, only access to an open
 # handle of a file inside the dir!!!
 allow xdm_xserver_t xdm_var_lib_t:file { getattr read };
-dontaudit xdm_xserver_t xdm_var_lib_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit xdm_xserver_t xdm_var_lib_t:dir search;
+}
 type xsession_exec_t, file_type, sysadmfile, exec_type;
 type etc_xdm_t, file_type, sysadmfile;
 
@@ -158,26 +161,39 @@
 allow xdm_xserver_t home_root_t:dir search;
 
 # Do not audit denied attempts to access devices.
-dontaudit xdm_t fixed_disk_device_t:blk_file rw_file_perms;
-dontaudit xdm_t removable_device_t:blk_file rw_file_perms;
-dontaudit xdm_t device_t:file_class_set rw_file_perms;
-dontaudit xdm_t misc_device_t:file_class_set rw_file_perms;
-
+if (!disable_dontaudit)
+{
+	dontaudit xdm_t fixed_disk_device_t:blk_file rw_file_perms;
+	dontaudit xdm_t removable_device_t:blk_file rw_file_perms;
+	dontaudit xdm_t device_t:file_class_set rw_file_perms;
+	dontaudit xdm_t misc_device_t:file_class_set rw_file_perms;
+}
 # Do not audit denied probes of /proc.
-dontaudit xdm_t domain:dir r_dir_perms;
-dontaudit xdm_t domain:{ file lnk_file } r_file_perms;
-
+if (!disable_dontaudit)
+{
+	dontaudit xdm_t domain:dir r_dir_perms;
+	dontaudit xdm_t domain:{ file lnk_file } r_file_perms;
+}
 # Read /usr/share/terminfo/l/linux and /usr/share/icons/default/index.theme...
 allow xdm_t usr_t:{ lnk_file file } { getattr read };
 
 # Do not audit attempts to write to index files under /usr
-dontaudit xdm_t usr_t:file write;
+if (!disable_dontaudit)
+{
+	dontaudit xdm_t usr_t:file write;
+}
 
 # Do not audit access to /root
-dontaudit xdm_t sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit xdm_t sysadm_home_dir_t:dir { getattr search };
+}
 
 # Do not audit user access to the X log files due to file handle inheritance
-dontaudit unpriv_userdomain xserver_log_t:file { write append };
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain xserver_log_t:file { write append };
+}
 
 # Access sound device.
 allow xdm_t sound_device_t:chr_file { setattr getattr };
diff -Nru a/selinux-usr/policy/domains/program/unused/xserver.te b/selinux-usr/policy/domains/program/unused/xserver.te
--- a/selinux-usr/policy/domains/program/unused/xserver.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/unused/xserver.te	Wed Jan 14 15:17:12 2004
@@ -29,7 +29,10 @@
 allow initrc_xserver_t self:unix_stream_socket create_socket_perms;
 
 # for nscd
-dontaudit initrc_xserver_t { var_t var_run_t }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit initrc_xserver_t { var_t var_run_t }:dir search;
+}
 
 
 role system_r types initrc_xserver_t;
diff -Nru a/selinux-usr/policy/domains/program/useradd.te b/selinux-usr/policy/domains/program/useradd.te
--- a/selinux-usr/policy/domains/program/useradd.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/program/useradd.te	Wed Jan 14 15:17:12 2004
@@ -48,7 +48,10 @@
 
 # useradd/userdel request read/write for /var/log/lastlog, and read of /dev, 
 # but will operate without them.
-dontaudit $1_t { device_t var_t var_log_t }:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t { device_t var_t var_log_t }:dir search;
+}
 
 # For userdel and groupadd
 allow $1_t fs_t:filesystem getattr;
@@ -59,7 +62,10 @@
 ifdef(`gnome-pty-helper.te', `allow $1_t gphdomain:fd use;')
 
 # for when /root is the cwd
-dontaudit $1_t sysadm_home_dir_t:dir search;
+if (!disable_dontaudit)
+{
+	dontaudit $1_t sysadm_home_dir_t:dir search;
+}
 ')
 user_group_add_program(useradd)
 
@@ -83,6 +89,9 @@
 user_group_add_program(groupadd)
 
 # some apps ask for these accesses, but seems to work regardless
-dontaudit groupadd_t initrc_var_run_t:file write;
-dontaudit groupadd_t var_run_t:dir search;
-dontaudit groupadd_t self:capability fsetid;
+if (!disable_dontaudit)
+{
+	dontaudit groupadd_t initrc_var_run_t:file write;
+	dontaudit groupadd_t var_run_t:dir search;
+	dontaudit groupadd_t self:capability fsetid;
+}
diff -Nru a/selinux-usr/policy/domains/user.te b/selinux-usr/policy/domains/user.te
--- a/selinux-usr/policy/domains/user.te	Wed Jan 14 15:17:12 2004
+++ b/selinux-usr/policy/domains/user.te	Wed Jan 14 15:17:12 2004
@@ -18,7 +18,10 @@
 
 # lots of user programs accidentally search /root, and also the admin often
 # logs in as UID=0 domain=user_t...
-dontaudit unpriv_userdomain sysadm_home_dir_t:dir { getattr search };
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain sysadm_home_dir_t:dir { getattr search };
+}
 
 # change from role $1_r to $2_r and relabel tty appropriately
 define(`role_tty_type_change', `
@@ -37,4 +40,7 @@
 ')
 
 # "ps aux" and "ls -l /dev/pts" make too much noise without this
-dontaudit unpriv_userdomain ptyfile:chr_file getattr;
+if (!disable_dontaudit)
+{
+	dontaudit unpriv_userdomain ptyfile:chr_file getattr;
+}

--=-3Q3ILB4ZzMVKg+uHxavj
Content-Disposition: attachment; filename=conditional-selinux-usr-snapshot-1-14-2004.patch
Content-Type: text/x-patch; name=conditional-selinux-usr-snapshot-1-14-2004.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Nru a/selinux-usr/checkpolicy/Makefile b/selinux-usr/checkpolicy/Makefile
--- a/selinux-usr/checkpolicy/Makefile	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/Makefile	Wed Jan 14 13:39:12 2004
@@ -17,9 +17,10 @@
 endif
 
 CFLAGS = -g $(OPTIONS) -Wall -O2 -pipe
+
 override CFLAGS += -include global.h -I. -Iinclude
 
-OBJS += ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
+OBJS += ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o conditional.o
 
 LIBS=-lfl
 
diff -Nru a/selinux-usr/checkpolicy/avtab.c b/selinux-usr/checkpolicy/avtab.c
--- a/selinux-usr/checkpolicy/avtab.c	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/avtab.c	Wed Jan 14 13:39:12 2004
@@ -1,6 +1,16 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+ 
 /* FLASK */
 
 /* 
@@ -16,6 +26,30 @@
  (keyp->source_type << 9)) & \
  AVTAB_HASH_MASK)
 
+static avtab_ptr_t 
+   avtab_insert_node(avtab_t *h, int hvalue, avtab_ptr_t prev, avtab_ptr_t cur, avtab_key_t *key, avtab_datum_t *datum)
+{
+	avtab_ptr_t newnode;
+	newnode = (avtab_ptr_t) kmalloc(sizeof(struct avtab_node),GFP_KERNEL);
+	if (newnode == NULL)
+		return NULL;
+	memset(newnode, 0, sizeof(struct avtab_node));
+	newnode->key = *key;
+	newnode->datum = *datum;
+	if (prev) {
+		newnode->next = prev->next;
+		prev->next = newnode;
+	} else {
+		newnode->next = h->htable[hvalue];
+		h->htable[hvalue] = newnode;
+	}
+
+	h->nel++;
+	return newnode;
+}
+
+
+
 int avtab_insert(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
 {
 	int hvalue;
@@ -44,24 +78,69 @@
 			break;
 	}
 
-	newnode = (avtab_ptr_t) kmalloc(sizeof(struct avtab_node),GFP_KERNEL);
-	if (newnode == NULL)
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	if(!newnode)
 		return -ENOMEM;
-	memset(newnode, 0, sizeof(struct avtab_node));
-	newnode->key = *key;
-	newnode->datum = *datum;
-	if (prev) {
-		newnode->next = prev->next;
-		prev->next = newnode;
-	} else {
-		newnode->next = h->htable[hvalue];
-		h->htable[hvalue] = newnode;
-	}
 
-	h->nel++;
 	return 0;
 }
 
+/* Unlike avtab_insert(), this function allow multiple insertions of the same 
+ * key/specified mask into the table, as needed by the conditional avtab.  
+ * It also returns a pointer to the node inserted.
+ */
+avtab_ptr_t
+  avtab_insert_nonunique(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum)
+{
+	int hvalue;
+	avtab_ptr_t prev, cur, newnode;
+
+	if (!h)
+		return NULL;
+	hvalue = AVTAB_HASH(key);
+	for (prev = NULL, cur = h->htable[hvalue];
+	     cur;
+	     prev = cur, cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (datum->specified & cur->datum.specified))
+			break;
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	newnode = avtab_insert_node(h, hvalue, prev, cur, key, datum);
+	
+	return newnode;
+}
+
+/* Unlike avtab_insert(), this function stores a caller-provided parse_context pointer, AND
+ * allow multiple insertions of the same key/specified mask into the table, AND returns
+ * a pointer to the new node added, all as needed by the conditional avtab.  
+ */
+avtab_ptr_t
+ avtab_insert_with_parse_context(avtab_t *h, avtab_key_t *key, avtab_datum_t *datum, void *parse_context)
+{
+	avtab_ptr_t newnode;
+
+	if (!h)
+		return NULL;
+
+	newnode = avtab_insert_nonunique(h, key, datum);
+	if(!newnode)
+		return NULL;
+		
+	newnode->parse_context = parse_context;
+		
+	return newnode;			
+}
 
 avtab_datum_t *
  avtab_search(avtab_t * h, avtab_key_t * key, int specified)
@@ -95,6 +174,66 @@
 	return NULL;
 }
 
+/* This search function returns a node pointer, and can be used in
+ * conjunction with avtab_search_next_node()
+ */
+avtab_ptr_t 
+ avtab_search_node(avtab_t * h, avtab_key_t * key, int specified)
+{
+	int hvalue;
+	avtab_ptr_t cur;
+
+	if (!h)
+		return NULL;
+
+	hvalue = AVTAB_HASH(key);
+	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (key->source_type < cur->key.source_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type < cur->key.target_type)
+			break;
+		if (key->source_type == cur->key.source_type && 
+		    key->target_type == cur->key.target_type &&
+		    key->target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
+
+avtab_ptr_t
+  avtab_search_node_next(avtab_ptr_t node, int specified)
+{
+	avtab_ptr_t cur;
+
+	if (!node)
+		return NULL;
+		
+	for (cur = node->next; cur; cur = cur->next) {
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class == cur->key.target_class &&
+		    (specified & cur->datum.specified))
+			return cur;
+
+		if (node->key.source_type < cur->key.source_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type < cur->key.target_type)
+			break;
+		if (node->key.source_type == cur->key.source_type && 
+		    node->key.target_type == cur->key.target_type &&
+		    node->key.target_class < cur->key.target_class)
+			break;
+	}
+	return NULL;
+}
 
 void avtab_destroy(avtab_t * h)
 {
@@ -185,6 +324,60 @@
 	       tag, h->nel, slots_used, AVTAB_SIZE, max_chain_len);
 }
 
+int avtab_read_item(void *fp, avtab_datum_t *avdatum, avtab_key_t *avkey)
+{
+	__u32 *buf;
+	__u32 items, items2;
+
+	memset(avkey, 0, sizeof(avtab_key_t));
+	memset(avdatum, 0, sizeof(avtab_datum_t));
+	
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf) {
+		printk("security: avtab: truncated entry\n");
+		return -1;
+	}
+	items2 = le32_to_cpu(buf[0]);
+	buf = next_entry(fp, sizeof(__u32)*items2);
+	if (!buf) {
+		printk("security: avtab: truncated entry\n");
+		return -1;
+	}
+	items = 0;
+	avkey->source_type = le32_to_cpu(buf[items++]);
+	avkey->target_type = le32_to_cpu(buf[items++]);
+	avkey->target_class = le32_to_cpu(buf[items++]);
+	avdatum->specified = le32_to_cpu(buf[items++]);
+	if (!(avdatum->specified & (AVTAB_AV | AVTAB_TYPE))) {
+		printk("security: avtab: null entry\n");
+		return -1;
+	}
+	if ((avdatum->specified & AVTAB_AV) &&
+	    (avdatum->specified & AVTAB_TYPE)) {
+		printk("security: avtab: entry has both access vectors and types\n");
+		return -1;
+	}
+	if (avdatum->specified & AVTAB_AV) {
+		if (avdatum->specified & AVTAB_ALLOWED)
+			avtab_allowed(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITDENY) 
+			avtab_auditdeny(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_AUDITALLOW) 
+			avtab_auditallow(avdatum) = le32_to_cpu(buf[items++]);
+	} else {		
+		if (avdatum->specified & AVTAB_TRANSITION)
+			avtab_transition(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_CHANGE)
+			avtab_change(avdatum) = le32_to_cpu(buf[items++]);
+		if (avdatum->specified & AVTAB_MEMBER)
+			avtab_member(avdatum) = le32_to_cpu(buf[items++]);
+	}	
+	if (items != items2) {
+		printk("security: avtab: entry only had %d items, expected %d\n", items2, items);
+		return -1;
+	}	
+	return 0;
+}
 
 int avtab_read(avtab_t * a, void * fp, __u32 config __attribute__ ((unused)))
 {
@@ -193,7 +386,7 @@
 	avtab_key_t avkey;
 	avtab_datum_t avdatum;
 	__u32 *buf;
-	__u32 nel, items, items2;
+	__u32 nel;
 
 
 	buf = next_entry(fp, sizeof(__u32));
@@ -207,53 +400,8 @@
 		goto bad;
 	}
 	for (i = 0; i < nel; i++) {
-		memset(&avkey, 0, sizeof(avtab_key_t));
-		memset(&avdatum, 0, sizeof(avtab_datum_t));
-
-		buf = next_entry(fp, sizeof(__u32));
-		if (!buf) {
-			printk("security: avtab: truncated entry\n");
-			goto bad;
-		}
-		items2 = le32_to_cpu(buf[0]);
-		buf = next_entry(fp, sizeof(__u32)*items2);
-		if (!buf) {
-			printk("security: avtab: truncated entry\n");
+		if (avtab_read_item(fp, &avdatum, &avkey))
 			goto bad;
-		}
-		items = 0;
-		avkey.source_type = le32_to_cpu(buf[items++]);
-		avkey.target_type = le32_to_cpu(buf[items++]);
-		avkey.target_class = le32_to_cpu(buf[items++]);
-		avdatum.specified = le32_to_cpu(buf[items++]);
-		if (!(avdatum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-			printk("security: avtab: null entry\n");
-			goto bad;
-		}
-		if ((avdatum.specified & AVTAB_AV) &&
-		    (avdatum.specified & AVTAB_TYPE)) {
-			printk("security: avtab: entry has both access vectors and types\n");
-			goto bad;
-		}
-		if (avdatum.specified & AVTAB_AV) {
-			if (avdatum.specified & AVTAB_ALLOWED)
-				avtab_allowed(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITDENY) 
-				avtab_auditdeny(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_AUDITALLOW) 
-				avtab_auditallow(&avdatum) = le32_to_cpu(buf[items++]);
-		} else {
-			if (avdatum.specified & AVTAB_TRANSITION)
-				avtab_transition(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_CHANGE)
-				avtab_change(&avdatum) = le32_to_cpu(buf[items++]);
-			if (avdatum.specified & AVTAB_MEMBER)
-				avtab_member(&avdatum) = le32_to_cpu(buf[items++]);
-		}
-		if (items != items2) {
-			printk("security: avtab: entry only had %d items, expected %d\n", items2, items);
-			goto bad;
-		}
 		rc = avtab_insert(a, &avkey, &avdatum);
 		if (rc) {
 			if (rc == -ENOMEM)
diff -Nru a/selinux-usr/checkpolicy/avtab.h b/selinux-usr/checkpolicy/avtab.h
--- a/selinux-usr/checkpolicy/avtab.h	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/avtab.h	Wed Jan 14 13:39:12 2004
@@ -1,6 +1,16 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+ 
 /* FLASK */
 
 /*
@@ -29,6 +39,7 @@
 #define AVTAB_MEMBER     32
 #define AVTAB_CHANGE     64
 #define AVTAB_TYPE       (AVTAB_TRANSITION | AVTAB_MEMBER | AVTAB_CHANGE)
+#define AVTAB_ENABLED    0x80000000 /* reserved for used in cond_avtab */
 	__u32 specified;	/* what fields are specified */
         __u32 data[3];          /* access vectors or types */
 #define avtab_allowed(x) (x)->data[0]
@@ -45,6 +56,8 @@
 	avtab_key_t key;
 	avtab_datum_t datum;
 	avtab_ptr_t next;
+	void *parse_context;	/* generic context pointer used by parser;
+				 * not saved in binary policy */
 };
 
 typedef struct avtab {
@@ -68,7 +81,18 @@
 
 void avtab_hash_eval(avtab_t * h, char *tag);
 
+int avtab_read_item(void *fp, avtab_datum_t *avdatum, avtab_key_t *avkey);
+
 int avtab_read(avtab_t * a, void * fp, __u32 config);
+
+avtab_ptr_t avtab_insert_nonunique(avtab_t * h, avtab_key_t * key, avtab_datum_t * datum);
+
+avtab_ptr_t avtab_insert_with_parse_context(avtab_t *h, avtab_key_t *key,
+					    avtab_datum_t *datum, void *parse_context);
+
+avtab_ptr_t avtab_search_node(avtab_t * h, avtab_key_t * key, int specified);
+
+avtab_ptr_t avtab_search_node_next(avtab_ptr_t node, int specified);
 
 #define AVTAB_HASH_BITS 15
 #define AVTAB_HASH_BUCKETS (1 << AVTAB_HASH_BITS)
diff -Nru a/selinux-usr/checkpolicy/checkpolicy.c b/selinux-usr/checkpolicy/checkpolicy.c
--- a/selinux-usr/checkpolicy/checkpolicy.c	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/checkpolicy.c	Wed Jan 14 13:39:12 2004
@@ -3,6 +3,16 @@
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
  */
 
+/* Updated: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 /* FLASK */
 
 /* 
@@ -23,12 +33,17 @@
  * If '-d' is specified, then checkpolicy permits the user 
  * to interactively test the security server functions with 
  * the loaded policy configuration.
+ *
+ * If '-c' is specified, then a version 15 binary is produced
+ * for compatibility with older kernels. If any booleans or
+ * conditional rules are thrown away a warning in printed.
  */
 
 #include "policydb.h"
 #include "services.h"
 #include "queue.h"
 #include "checkpolicy.h"
+#include "conditional.h"
 #include <getopt.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -37,7 +52,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <sys/mman.h>
-
 extern char *optarg;
 extern int optind;
 
@@ -48,7 +62,7 @@
 extern unsigned int pass;
 extern unsigned int ss_initialized;
 
-extern int policydb_write(policydb_t * p, FILE * fp);
+extern int policydb_write(policydb_t * p, FILE * fp, int output_version15);
 
 extern FILE *yyin;
 extern int yyparse(void);
@@ -64,7 +78,7 @@
 
 void usage(char *progname)
 {
-	printf("usage:  %s [-b] [-d] [-o output_file] [input_file]\n", progname);
+	printf("usage:  %s [-b] [-d] [-c] [-o output_file] [input_file]\n", progname);
 	exit(1);
 }
 
@@ -242,6 +256,41 @@
 }
 #endif 
 
+static void cond_check_type_rules_list(cond_av_list_t *list)
+{
+	cond_av_list_t *cur = list;
+
+	while (cur) {
+		if (cur->node->datum.specified & AVTAB_TYPE) {
+			if (avtab_search(&policydbp->te_avtab, &cur->node->key, AVTAB_TYPE)) {
+				fprintf(stderr, "conditional type rule for (%s, %s : %s) conflicts with entry in base policy; "
+					"conditional rule discarded.\n", policydbp->p_type_val_to_name[cur->node->key.source_type],
+					policydbp->p_type_val_to_name[cur->node->key.target_type],
+					policydbp->p_class_val_to_name[cur->node->key.target_class]);
+				cur->node->parse_context = (void*)0;
+			} else {
+				cur->node->parse_context = (void*)1;
+			}
+		} else {
+			cur->node->parse_context = (void*)1;
+		}
+		cur = cur->next;
+	}
+}
+
+/* check for duplicate type rules - this has to be done after all of
+ * the parsing is finished because the conditional and base type rules
+ * are collected in the same pass */
+static void cond_check_type_rules(void)
+{
+	cond_list_t *node;
+
+	for (node = policydbp->cond_list; node != NULL; node = node->next) {
+		cond_check_type_rules_list(node->true_list);
+		cond_check_type_rules_list(node->false_list);
+	}
+}
+
 extern char *av_to_string(__u32 tclass, access_vector_t av);
 
 void check_assertion_helper(unsigned int stype, unsigned int ttype, ebitmap_t *tclasses, 
@@ -301,6 +350,77 @@
 	}
 }
 
+int display_bools()
+{
+	int i;
+
+	for (i = 0; i < policydbp->p_bools.nprim; i++) {
+		printf("%s : %d\n", policydbp->p_bool_val_to_name[i],
+			policydbp->bool_val_to_struct[i]->state);
+	}
+	return 0;
+}
+
+void display_expr(cond_expr_t *exp)
+{
+
+	cond_expr_t *cur;
+	for (cur = exp; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			printf("%s ", policydbp->p_bool_val_to_name[cur->bool - 1]);
+			break;
+		case COND_NOT:
+			printf("! ");
+			break;
+		case COND_OR:
+			printf("|| ");
+			break;
+		case COND_AND:
+			printf("&& ");
+			break;
+		case COND_XOR:
+			printf("^ ");
+			break;
+		case COND_EQ:
+			printf("== ");
+			break;
+		case COND_NEQ:
+			printf("!= ");
+			break;
+		default:
+			printf("error!");
+			break;
+		}
+	}
+}
+
+int display_cond_expressions()
+{
+	cond_node_t *cur;
+
+	for (cur = policydbp->cond_list; cur != NULL; cur = cur->next) {
+		printf("expression: ");
+		display_expr(cur->expr);
+		printf("current state: %d\n", cur->cur_state);
+	}
+	return 0;
+}
+
+int change_bool(char *name, int state)
+{
+	cond_bool_datum_t *bool;
+
+	bool = hashtab_search(policydbp->p_bools.table, name);
+	if (bool == NULL) {
+		printf("Could not find bool %s\n", name);
+		return -1;
+	}
+	bool->state = state;
+	evaluate_conds(policydbp);
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	security_class_t tclass;
@@ -312,15 +432,18 @@
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port, addr;
-	unsigned int binary = 0, debug = 0;
+	unsigned int binary = 0, debug = 0, output_version15 = 0;
 	struct val_to_name v;
 	int ret, ch, fd;
 	unsigned int nel;
 	struct stat sb;
 	void *map;
 	FILE *outfp = NULL;
+	char *name;
+	int state;
+
 
-	while ((ch = getopt(argc, argv, "o:dbV")) != EOF) {
+	while ((ch = getopt(argc, argv, "o:dbVc")) != EOF) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -339,6 +462,9 @@
 			printf("%d\n", POLICYDB_VERSION);
 #endif
 			exit(0);
+		case 'c':
+			output_version15 = 1;
+			break;
 		default:
 			usage(argv[0]);
 		}
@@ -375,6 +501,7 @@
 			fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
 			exit(1);
 		}
+		policydbp = &policydb;
 	} else {
 		yyin = fopen(file, "r");
 		if (!yyin) {
@@ -408,6 +535,9 @@
 		}
 		queue_destroy(id_queue);
 
+		cond_check_type_rules();
+		cond_optimize_lists(policydb.cond_list);
+
 		check_assertions();
 		if (policydb_errors) 
 			exit(1);
@@ -424,14 +554,19 @@
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
 	if (outfile) {
-		printf("%s:  writing binary representation (version %d) to %s\n",
-		       argv[0], POLICYDB_VERSION, outfile);
+		if (output_version15) {
+			printf("%s:  writing binary representation (version %d) to %s\n",
+			       argv[0], POLICYDB_VERSION_COMPAT, outfile);
+		} else {
+			printf("%s:  writing binary representation (version %d) to %s\n",
+			       argv[0], POLICYDB_VERSION, outfile);
+		}
 		outfp = fopen(outfile, "w");
 		if (!outfp) {
 			perror(outfile);
 			exit(1);
 		}
-		ret = policydb_write(&policydb, outfp);
+		ret = policydb_write(&policydb, outfp, output_version15);
 		if (ret) {
 			fprintf(stderr, "%s:  error writing %s\n",
 				argv[0], outfile);
@@ -461,6 +596,9 @@
 	printf("c)  Call fs_use\n");
 	printf("d)  Call genfs_sid\n");
 	printf("e)  Call get_user_sids\n");
+	printf("f)  display conditional bools\n");
+	printf("g)  display conditional expressions\n");
+	printf("h)  change a boolean value\n");
 #ifdef EQUIVTYPES
 	printf("z)  Show equivalent types\n");
 #endif
@@ -791,6 +929,37 @@
 				printf("\nerror\n");
 				break;
 			}
+			break;
+		case 'f':
+			display_bools();
+			break;
+		case 'g':
+			display_cond_expressions();
+			break;
+		case 'h':
+			printf("name? ");
+			fgets(ans, sizeof(ans), stdin);
+			ans[strlen(ans) - 1] = 0;
+			
+			name = malloc((strlen(ans) + 1) * sizeof(char));
+			if (name == NULL) {
+				fprintf(stderr, "couldn't malloc string.\n");
+				break;
+			}
+			strcpy(name, ans);
+
+
+			printf("state? ");
+			fgets(ans, sizeof(ans), stdin);
+			ans[strlen(ans) - 1] = 0;
+
+			if (atoi(ans))
+				state = 1;
+			else
+				state = 0;
+
+			change_bool(name, state);
+			free(name);
 			break;
 #ifdef EQUIVTYPES
 		case 'z':
diff -Nru a/selinux-usr/checkpolicy/conditional.c b/selinux-usr/checkpolicy/conditional.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/checkpolicy/conditional.c	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,715 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *          David Caplan <dac@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#include "include/security.h"
+#include "conditional.h"
+
+
+/* move all type rules to top of t/f lists to help kernel on evaluation */
+static void cond_optimize(cond_av_list_t **l) {
+	cond_av_list_t *top, *p,*cur;
+
+	top = p = cur = *l;
+
+	while(cur) {
+		if ((cur->node->datum.specified & AVTAB_TYPE) && (top != cur)) {
+			p->next = cur->next;
+			cur->next = top;
+			top = cur;
+			cur = p->next;
+		} else {
+			p = cur;
+			cur = cur->next; 
+		}
+	}
+	*l = top;
+}
+
+/* reorder t/f lists for kernel */
+void cond_optimize_lists(cond_list_t* cl) {
+	cond_list_t *n;
+
+	for (n = cl; n != NULL; n = n->next) {
+		cond_optimize(&n->true_list);
+		cond_optimize(&n->false_list);
+	}
+}
+
+
+static int bool_present(int target, int bools[], int num_bools) {
+	int i = 0;
+	int ret = 1;
+
+	if (num_bools > COND_MAX_BOOLS) {
+		return 0;
+	}
+	while( i < num_bools && target != bools[i]) i++;
+	if (i == num_bools) ret = 0; /* got to end w/o match */
+	return ret;
+}
+
+static int same_bools(cond_node_t *a, cond_node_t *b) {
+	int i, x;
+	
+	x = a->nbools;
+
+	/* same number of bools? */
+	if (x != b->nbools) return 0;
+
+	/* make sure all the bools in a are also in b */
+	for(i = 0; i < x; i++) if (!bool_present(a->bool_ids[i], b->bool_ids, x)) return 0;
+	return 1;
+}
+
+/*
+ * Determine if two conditional expressions are equal. 
+ */
+static int cond_expr_equal(cond_node_t *a, cond_node_t *b)
+{
+	cond_expr_t *cur_a, *cur_b;
+		
+	if (a == NULL || b == NULL)
+		return 0;
+
+	if(a->nbools != b->nbools) return 0;
+
+	/* if exprs have <= COND_MAX_BOOLS we can check the precompute values
+	 * for the expressions.
+	 */
+	if (a->nbools <= COND_MAX_BOOLS && b->nbools <= COND_MAX_BOOLS)	    
+	{
+		if(!same_bools(a,b)) return 0;
+		return (a->expr_pre_comp == b->expr_pre_comp);
+	}
+
+	/* for long expressions we check for exactly the same expression */
+	cur_a = a->expr;
+	cur_b = b->expr;
+	while (1) {
+		if (cur_a == NULL && cur_b == NULL)
+			return 1;
+		else if (cur_a == NULL || cur_b == NULL)
+			return 0;
+		if (cur_a->expr_type != cur_b->expr_type)
+			return 0;
+		if (cur_a->expr_type == COND_BOOL) {
+			if (cur_a->bool != cur_b->bool)
+				return 0;
+		}
+		cur_a = cur_a->next;
+		cur_b = cur_b->next;
+	}
+	return 1;
+}
+
+/* return either a pre-existing matching node or create a new node */
+cond_node_t *cond_node_search(policydb_t *p, cond_node_t *cn)
+{
+	cond_node_t *list,*new;
+	int i;
+
+	list = p->cond_list;
+
+	while(list) {
+		if (cond_expr_equal(cn,list)) break;
+		list = list->next;
+	}
+	if (list) return list;
+	else {
+		new = (cond_node_t *)malloc(sizeof (cond_node_t));
+		if (!new) {
+			return NULL;
+		}
+		new->expr = cn->expr;
+		new->cur_state = cond_evaluate_expr(p, new->expr);
+		new->nbools = cn->nbools;
+		for (i = 0; i < cn->nbools; i++)
+			new->bool_ids[i] = cn->bool_ids[i];
+		new->expr_pre_comp = cn->expr_pre_comp;
+		new->true_list = NULL;
+		new->false_list = NULL;
+		/* add conditional node to policy list */
+		new->next = p->cond_list;
+		p->cond_list = new;
+		return new;
+	}
+}
+
+/*
+ * cond_evaluate_expr evaluates a conditional expr
+ * in reverse polish notation. It returns true (1), false (0),
+ * or undefined (-1). Undefined occurs when the expression
+ * exceeds the stack depth of COND_EXPR_MAXDEPTH.
+ */
+int cond_evaluate_expr(policydb_t *p, cond_expr_t *expr)
+{
+
+	cond_expr_t *cur;
+	int s[COND_EXPR_MAXDEPTH];
+	int sp = -1;
+
+	for (cur = expr; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			if (sp == (COND_EXPR_MAXDEPTH - 1))
+				return -1;
+			sp++;
+			s[sp] = p->bool_val_to_struct[cur->bool - 1]->state;
+			break;
+		case COND_NOT:
+			if (sp < 0)
+				return -1;
+			s[sp] = !s[sp];
+			break;
+		case COND_OR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] |= s[sp + 1];
+			break;
+		case COND_AND:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] &= s[sp + 1];
+			break;
+		case COND_XOR:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] ^= s[sp + 1];
+			break;
+		case COND_EQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] == s[sp + 1]);
+			break;
+		case COND_NEQ:
+			if (sp < 1)
+				return -1;
+			sp--;
+			s[sp] = (s[sp] != s[sp + 1]);
+			break;
+		default:
+			return -1;
+		}
+	}
+	return s[0];
+}
+
+/*
+ * evaluate_cond_node evaluates the conditional stored in
+ * a cond_node_t and if the result is different than the
+ * current state of the node it sets the rules in the true/false
+ * list appropriately. If the result of the expression is undefined
+ * all of the rules are disabled for safety.
+ */
+static int evaluate_cond_node(policydb_t *p, cond_node_t *node)
+{
+	int new_state;
+	cond_av_list_t* cur;
+
+	new_state = cond_evaluate_expr(p, node->expr);
+	if (new_state != node->cur_state) {
+		node->cur_state = new_state;
+		if (new_state == -1)
+			printk("expression result was undefined - disabling all rules.\n");
+		/* turn the rules on or off */
+		for (cur = node->true_list; cur != NULL; cur = cur->next) {
+			if (new_state <= 0) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+
+		for (cur = node->false_list; cur != NULL; cur = cur->next) {	
+			/* -1 or 1 */
+			if (new_state) {
+				cur->node->datum.specified &= ~AVTAB_ENABLED;
+			} else {
+				cur->node->datum.specified |= AVTAB_ENABLED;
+			}
+		}
+	}
+	return 0;
+}
+
+/* precompute and simplify an expression if possible.  If left with !expression, change 
+ * to expression and switch t and f. precompute expression for expressions with limited
+ * number of bools.
+ */
+int normalize_expr(policydb_t *p, cond_node_t *cn)
+{
+	cond_expr_t *ne,*e;
+	cond_av_list_t *tmp;
+	int i, j, k, orig_value[COND_MAX_BOOLS];
+	__u32 test = 0x0;
+	
+
+	cn->nbools = 0;
+
+	memset(cn->bool_ids, 0,sizeof(cn->bool_ids) );
+	cn->expr_pre_comp = 0x0;
+
+	/* take care of !expr case */
+	ne = NULL;
+	e = cn->expr;
+        
+        /* becuase it's RPN look at last element */
+	while(e->next != NULL) { 
+		ne = e; e = e->next;
+	}
+	if (e->expr_type == COND_NOT) {
+		if (ne) {
+			ne->next = NULL; 
+		} else { /* ne should never be NULL */
+			printk("Found expr with no bools and only a ! - this should never happen.\n");
+			return -1;
+		}
+		/* swap the true and false lists */
+		tmp = cn->true_list;
+		cn->true_list = cn->false_list;
+		cn->false_list = tmp;
+		/* free the "not" node in the list */
+		free(e);
+	}
+
+	/* find all the bools in the expression */
+	for(e = cn->expr; e != NULL; e = e->next) {
+		switch(e->expr_type) { 
+		case COND_BOOL:
+			i = 0;
+			/* see if we've already seen this bool */
+			if (!bool_present(e->bool, cn->bool_ids, cn->nbools)) {
+				/* count em all but only record up to COND_MAX_BOOLS */
+				if (cn->nbools < COND_MAX_BOOLS)
+					cn->bool_ids[cn->nbools++] = e->bool;
+				else
+					cn->nbools++;
+			}
+			break;
+		default:
+			break;
+		}
+	} 
+ 
+	/* only precompute for exprs with <= COND_AX_BOOLS */
+	if (cn->nbools <=  COND_MAX_BOOLS) {
+		/* save the default values for the bools so we can play with them */
+		for(i = 0; i < cn->nbools; i++) {
+			orig_value[i] = p->bool_val_to_struct[cn->bool_ids[i] - 1]->state;
+		}
+		
+		/* loop through all possible combinations of values for bools in expression */
+		for(test = 0x0; test < (0x1 << cn->nbools) ; test++) {
+			/* temporarily set the value for all the bools in the
+			 * expression using the corr.  bit in test */
+			for(j = 0; j < cn->nbools; j++) {
+				p->bool_val_to_struct[cn->bool_ids[j] - 1]->state =
+					( test & (0x1 << j) ) ? 1 : 0;
+			}
+			k = cond_evaluate_expr(p, cn->expr);
+			if (k == -1) {
+				printk("While testing expression, expression result "
+				       "was undefined - this should never happen.\n");
+				return -1;
+			}
+			/* set the bit if expression evaluates true */
+			if (k) cn->expr_pre_comp |= 0x1 << test;
+		}
+		
+		/* restore bool default values */
+		for(i = 0; i < cn->nbools; i++)
+			p->bool_val_to_struct[cn->bool_ids[i] - 1]->state = orig_value[i] ;
+	}
+	return 0;
+}
+
+int evaluate_conds(policydb_t *p)
+{
+	int ret;
+	cond_node_t *cur;
+
+	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
+		ret = evaluate_cond_node(p, cur);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+int cond_policydb_init(policydb_t *p)
+{
+	p->bool_val_to_struct = NULL;
+	p->cond_list = NULL;
+	if (avtab_init(&p->te_cond_avtab))
+		return -1;
+
+	return 0;
+}
+
+static void cond_av_list_destroy(cond_av_list_t *list)
+{
+	cond_av_list_t *cur, *next;
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		/* the avtab_ptr_t node is destroy by the avtab */
+		kfree(cur);
+	}
+}
+
+static void cond_node_destroy(cond_node_t *node)
+{
+	cond_expr_t *cur_expr, *next_expr;
+
+	if (!node)
+		return;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = next_expr) {
+		next_expr = cur_expr->next;
+		kfree(cur_expr);
+	}
+	cond_av_list_destroy(node->true_list);
+	cond_av_list_destroy(node->false_list);
+	kfree(node);
+}
+
+static void cond_list_destroy(cond_list_t *list)
+{
+	cond_node_t *next, *cur;
+	
+	if (list == NULL)
+		return;
+
+	for (cur = list; cur != NULL; cur = next) {
+		next = cur->next;
+		cond_node_destroy(cur);
+	}
+}
+
+void cond_policydb_destroy(policydb_t *p)
+{
+	if (p->bool_val_to_struct != NULL)
+		kfree(p->bool_val_to_struct);
+	avtab_destroy(&p->te_cond_avtab);
+	cond_list_destroy(p->cond_list);
+}
+
+int cond_init_bool_indexes(policydb_t *p)
+{
+	if (p->bool_val_to_struct)
+		kfree(p->bool_val_to_struct);
+	p->bool_val_to_struct = (cond_bool_datum_t**)
+		kmalloc(p->p_bools.nprim * sizeof(cond_bool_datum_t*), GFP_KERNEL);
+	if (!p->bool_val_to_struct)
+		return -1;
+	return 0;
+}
+
+int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+	if (key)
+		kfree(key);
+	kfree(datum);
+	return 0;
+}
+
+int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap)
+{
+	policydb_t *p;
+	cond_bool_datum_t *booldatum;
+
+	booldatum = datum;
+	p = datap;
+	
+	p->p_bool_val_to_name[booldatum->value - 1] = key;
+	p->bool_val_to_struct[booldatum->value -1] = booldatum;
+
+	return 0;
+}
+
+int bool_isvalid(cond_bool_datum_t *b)
+{
+	if (!(b->state == 0 || b->state == 1))
+		return 0;
+	return 1;
+}
+
+int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp)
+{
+	char *key = 0;
+	cond_bool_datum_t *booldatum;
+	__u32 *buf, len;
+
+	booldatum = kmalloc(sizeof(cond_bool_datum_t), GFP_KERNEL);
+	if (!booldatum)
+		return -1;
+	memset(booldatum, 0, sizeof(cond_bool_datum_t));
+
+	buf = next_entry(fp, sizeof(__u32) * 3);
+	if (!buf)
+		goto err;
+
+	booldatum->value = le32_to_cpu(buf[0]);
+	booldatum->state = le32_to_cpu(buf[1]);
+	
+	if (!bool_isvalid(booldatum))
+		goto err;
+
+	len = le32_to_cpu(buf[2]);
+	
+	buf = next_entry(fp, len);
+	if (!buf)
+		goto err;
+	key = kmalloc(len + 1, GFP_KERNEL);
+	if (!key)
+		goto err;
+	memcpy(key, buf, len);
+	key[len] = 0;
+	if (hashtab_insert(h, key, booldatum))
+		goto err;
+	
+	return 0;
+err:
+	cond_destroy_bool(key, booldatum, 0);
+	return -1;
+}
+
+static int cond_read_av_list(policydb_t *p, void *fp, cond_av_list_t **ret_list, cond_av_list_t *other)
+{
+	cond_av_list_t *list, *last = NULL, *cur;
+	avtab_key_t key;
+	avtab_datum_t datum;
+	avtab_ptr_t node_ptr;
+	int len, i;
+	__u32 *buf;
+	__u8 found;
+
+	*ret_list = NULL;
+
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+	if (len == 0) {
+		return 0;
+	}
+
+	for (i = 0; i < len; i++) {
+		if (avtab_read_item(fp, &datum, &key))
+			goto err;
+
+		/*
+		 * For type rules we have to make certain there aren't any
+		 * conflicting rules by searching the te_avtab and the
+		 * cond_te_avtab.
+		 */
+		if (datum.specified & AVTAB_TYPE) {
+			if (avtab_search(&p->te_avtab, &key, AVTAB_TYPE)) {
+				printk("security: type rule already exists outside of a conditional.");
+				goto err;
+			}
+			/*
+			 * If we are reading the false list other will be a pointer to
+			 * the true list. We can have duplicate entries if there is only
+			 * 1 other entry and it is in our true list.
+			 *
+			 * If we are reading the true list (other == NULL) there shouldn't
+			 * be any other entries.
+			 */
+			if (other) {
+				node_ptr = avtab_search_node(&p->te_cond_avtab, &key, AVTAB_TYPE);
+				if (node_ptr) {
+					if (avtab_search_node_next(node_ptr, AVTAB_TYPE)) {
+						printk("security: too many conflicting type rules.");
+						goto err;
+					}
+					found = 0;
+					for (cur = other; cur != NULL; cur = cur->next) {
+						if (cur->node == node_ptr) {
+							found = 1;
+							break;
+						}
+					}
+					if (!found) {
+						printk("security: conflicting type rules.\n");
+						goto err;
+					}
+				}
+			} else {    
+				if (avtab_search(&p->te_cond_avtab, &key, AVTAB_TYPE)) {
+					printk("security: conflicting type rules when adding type rule for true.\n");
+					goto err;
+				}
+			}
+		}
+		node_ptr = avtab_insert_nonunique(&p->te_cond_avtab, &key, &datum);
+		if (!node_ptr) {
+			printk("security: could not insert rule.");
+			goto err;
+		}
+
+		list = kmalloc(sizeof(cond_av_list_t), GFP_KERNEL);
+		if (!list)
+			goto err;
+		memset(list, 0, sizeof(cond_av_list_t));
+
+		list->node = node_ptr;
+		if (i == 0)
+			*ret_list = list;
+		else
+			last->next = list;
+		last = list;
+
+	}
+
+	return 0;
+err:
+	cond_av_list_destroy(*ret_list);
+	*ret_list = NULL;
+	return -1;
+}
+
+static int expr_isvalid(policydb_t *p, cond_expr_t *expr)
+{
+	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
+		printk("security: conditional expressions uses unknown operator.\n");
+		return 0;
+	}
+	
+	if (expr->bool > p->p_bools.nprim) {
+		printk("security: conditional expressions uses unknown bool.\n");
+		return 0;
+	}
+	return 1;
+}
+
+static int cond_read_node(policydb_t *p, cond_node_t *node, void *fp)
+{
+	__u32 *buf;
+	int len, i;
+	cond_expr_t *expr = NULL, *last = NULL;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	node->cur_state = le32_to_cpu(buf[0]);
+	
+	len = 0;
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	/* expr */
+	len = le32_to_cpu(buf[0]);
+	
+	for (i = 0; i < len; i++ ) {
+		buf = next_entry(fp, sizeof(__u32) * 2);
+		if (!buf)
+			goto err;
+
+		expr = kmalloc(sizeof(cond_expr_t), GFP_KERNEL);
+		if (!expr) {
+			goto err;
+		}
+		memset(expr, 0, sizeof(cond_expr_t));
+
+		expr->expr_type = le32_to_cpu(buf[0]);
+		expr->bool = le32_to_cpu(buf[1]);
+		
+		if (!expr_isvalid(p, expr))
+			goto err;
+
+		if (i == 0) {
+			node->expr = expr;
+		} else {
+			last->next = expr;
+		}
+		last = expr;
+	}
+	
+	if (cond_read_av_list(p, fp, &node->true_list, NULL) != 0)
+		goto err;
+	if (cond_read_av_list(p, fp, &node->false_list, node->true_list) != 0)
+		goto err;
+	return 0;
+err:
+	cond_node_destroy(node);
+	return -1;
+}
+
+int cond_read_list(policydb_t *p, void *fp)
+{
+	cond_node_t *node, *last = NULL;
+	__u32 *buf;
+	int i, len;
+
+	buf = next_entry(fp, sizeof(__u32));
+	if (!buf)
+		return -1;
+
+	len = le32_to_cpu(buf[0]);
+
+	for (i = 0; i < len; i++) {
+		node = kmalloc(sizeof(cond_node_t), GFP_KERNEL);
+		if (!node)
+			goto err;
+		memset(node, 0, sizeof(cond_node_t));
+		
+		if (cond_read_node(p, node, fp) != 0)
+			goto err;
+
+		if (i == 0) {
+			p->cond_list = node;
+		} else {
+			last->next = node;
+		}
+		last = node;			
+	}
+	return 0;
+err:
+	return -1;
+}
+
+/* Determine whether additional permissions are granted by the conditional
+ * av table, and if so, add them to the result 
+ */
+void cond_compute_av(avtab_t *ctab, avtab_key_t *key, struct av_decision *avd)
+{
+	avtab_ptr_t node;
+	
+	if(!ctab || !key || !avd) 
+		return;
+		
+	for(node = avtab_search_node(ctab, key, AVTAB_AV); node != NULL; 
+				node = avtab_search_node_next(node, AVTAB_AV)) {
+		if ( (__u32) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+			avd->allowed |= avtab_allowed(&node->datum);
+		if ( (__u32) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+			/* Since a '0' in an auditdeny mask represents a 
+			 * permission we do NOT want to audit (dontaudit), we use
+			 * the '&' operand to ensure that all '0's in the mask
+			 * are retained (much unlike the allow and auditallow cases).
+			 */
+			avd->auditdeny &= avtab_auditdeny(&node->datum);
+		if ( (__u32) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		     (node->datum.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+			avd->auditallow |= avtab_auditallow(&node->datum);
+	}
+	return;	
+}
+
diff -Nru a/selinux-usr/checkpolicy/conditional.h b/selinux-usr/checkpolicy/conditional.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/checkpolicy/conditional.h	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,106 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Frank Mayer <mayerf@tresys.com>
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#ifndef _CONDITIONAL_H_
+#define _CONDITIONAL_H_
+
+#include "avtab.h"
+#include "symtab.h"
+#include "policydb.h"
+
+#define COND_EXPR_MAXDEPTH 10
+
+/* this is the max unique bools in a conditional expression
+ * for which we precompute all outcomes for the expression.
+ *
+ * NOTE - do _NOT_ use value greater than 5 because
+ * cond_node_t->expr_pre_comp can only hold at most 32 values
+ */
+#define COND_MAX_BOOLS 5
+
+/*
+ * A conditional expression is a list of operators and operands
+ * in reverse polish notation.
+ */
+typedef struct cond_expr {
+#define COND_BOOL	1 /* plain bool */
+#define COND_NOT	2 /* !bool */
+#define COND_OR		3 /* bool || bool */
+#define COND_AND	4 /* bool && bool */
+#define COND_XOR	5 /* bool ^ bool */
+#define COND_EQ		6 /* bool == bool */
+#define COND_NEQ	7 /* bool != bool */
+#define COND_LAST	8
+	__u32 expr_type;
+	__u32 bool;
+	struct cond_expr *next;
+} cond_expr_t;
+
+/*
+ * Each cond_node_t contains a list of rules to be enabled/disabled
+ * depending on the current value of the conditional expression. This 
+ * struct is for that list.
+ */
+typedef struct cond_av_list {
+	avtab_ptr_t node;
+	struct cond_av_list *next;
+} cond_av_list_t;
+
+/* 
+ * We need the following so we have a valid error return code in yacc
+ * when we have a parse error for a conditional rule.  We can't check 
+ * for NULL (ie 0) because that is a potentially valid return.
+ */
+cond_av_list_t *conditional_unused_error_code;
+#define COND_ERR (cond_av_list_t *)&conditional_unused_error_code
+
+/*
+ * A cond node represents a conditional block in a policy. It
+ * contains a conditional expression, the current state of the expression,
+ * two lists of rules to enable/disable depending on the value of the
+ * expression (the true list corresponds to if and the false list corresponds
+ * to else)..
+ */
+typedef struct cond_node {
+	int cur_state;
+	cond_expr_t *expr;
+	/* these fields are not written to binary policy */
+	int nbools;
+	__u32 bool_ids[COND_MAX_BOOLS];
+	__u32 expr_pre_comp;
+	/*                                               */
+	cond_av_list_t *true_list;
+	cond_av_list_t *false_list;
+	struct cond_node *next;
+} cond_node_t;
+
+extern int yyerror(char *msg);
+
+int cond_evaluate_expr(policydb_t *p, cond_expr_t *expr);
+
+int normalize_expr(policydb_t *p, cond_node_t *cn);
+cond_node_t *cond_node_search(policydb_t *p,cond_node_t *cn);
+int evaluate_conds(policydb_t *p);
+
+void cond_optimize_lists(cond_list_t *cl);
+
+int cond_policydb_init(policydb_t* p);
+void cond_policydb_destroy(policydb_t* p);
+
+int cond_init_bool_indexes(policydb_t* p);
+int cond_destroy_bool(hashtab_key_t key, hashtab_datum_t datum, void *p);
+
+int cond_index_bool(hashtab_key_t key, hashtab_datum_t datum, void *datap);
+
+int cond_read_bool(policydb_t *p, hashtab_t h, struct policy_file *fp);
+int cond_read_list(policydb_t *p, void *fp);
+
+void cond_compute_av(avtab_t *ctab, avtab_key_t *key, struct av_decision *avd);
+
+#endif /* _CONDITIONAL_H_ */
diff -Nru a/selinux-usr/checkpolicy/policy_parse.y b/selinux-usr/checkpolicy/policy_parse.y
--- a/selinux-usr/checkpolicy/policy_parse.y	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/policy_parse.y	Wed Jan 14 13:39:12 2004
@@ -3,6 +3,16 @@
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
  */
 
+/* Updated: David Caplan, <dac@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 /* FLASK */
 
 %{
@@ -10,6 +20,7 @@
 #include "services.h"
 #include "queue.h"
 #include "checkpolicy.h"
+#include "conditional.h"
 #include <stdint.h>
 
 #define TRUE 1
@@ -49,6 +60,14 @@
 static int define_role_trans(void);
 static int define_role_allow(void);
 static int define_constraint(constraint_expr_t *expr);
+static int define_bool();
+static int define_conditional(cond_expr_t *expr,cond_av_list_t *t_list, cond_av_list_t *f_list );
+static cond_expr_t *define_cond_expr(__u32 expr_type, void *arg1, void* arg2);
+static cond_av_list_t *define_cond_pol_list(cond_av_list_t *avlist, cond_av_list_t *stmt);
+static cond_av_list_t *define_cond_compute_type(int which);
+static cond_av_list_t *define_cond_te_avtab(int which);
+static cond_av_list_t *cond_list_append(cond_av_list_t *sl, avtab_key_t *key, avtab_datum_t *datum);
+static void cond_reduce_insert_list(cond_av_list_t *new, cond_av_list_t **active, cond_av_list_t **inactive, int state ); 
 static uintptr_t define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2);
 static int define_user(void);
 static int parse_security_context(context_struct_t *c);
@@ -67,6 +86,9 @@
 	void *ptr;
 }
 
+%type <ptr> cond_expr cond_expr_prim cond_pol_list
+%type <ptr> cond_allow_def cond_auditallow_def cond_auditdeny_def cond_dontaudit_def
+%type <ptr> cond_transition_def cond_te_avtab_def cond_rule_def
 %type <ptr> role_def roles
 %type <valptr> cexpr cexpr_prim op roleop
 %type <val> ipv4_addr_def number
@@ -84,6 +106,9 @@
 %token TYPES
 %token ALIAS
 %token ATTRIBUTE
+%token BOOL
+%token IF
+%token ELSE
 %token TYPE_TRANSITION
 %token TYPE_MEMBER
 %token TYPE_CHANGE
@@ -107,7 +132,8 @@
 %token FSUSEXATTR FSUSETASK FSUSETRANS
 %token GENFSCON
 %token U1 U2 R1 R2 T1 T2
-%token NOT AND OR 
+%token NOT AND OR XOR
+%token CTRUE CFALSE
 %token IDENTIFIER
 %token USER_IDENTIFIER
 %token NUMBER
@@ -115,14 +141,16 @@
 %token NOTEQUAL
 
 %left OR
+%left XOR
 %left AND
 %right NOT
 %left EQUALS NOTEQUAL
 %%
-policy			: classes initial_sids access_vectors 
+policy			: classes initial_sids access_vectors
                           { if (pass == 1) { if (policydb_index_classes(policydbp)) return -1; } }
 			  opt_mls te_rbac users opt_constraints 
-			  { if (pass == 2) { if (policydb_index_others(policydbp)) return -1;} } 
+                         { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
+			   if (pass == 2) { if (policydb_index_others(policydbp)) return -1;} } 
 			  initial_sid_contexts opt_fs_contexts fs_uses opt_genfs_contexts net_contexts 
 			;
 classes			: class_def 
@@ -196,7 +224,7 @@
 			{if (define_level()) return -1;}
 			| LEVEL identifier ';' 
 			{if (define_level()) return -1;}
-			;
+						;
 base_perms		: opt_common_base av_base
 			;
 opt_common_base         : common_base
@@ -238,8 +266,10 @@
 			;
 te_decl			: attribute_def
                         | type_def
+                        | bool_def 
                         | transition_def
                         | te_avtab_def
+                        | cond_stmt_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}
@@ -252,6 +282,91 @@
 opt_attr_list           : ',' id_comma_list
 			| 
 			;
+bool_def                : BOOL identifier bool_val ';'
+                        {if (define_bool()) return -1;}
+                        ;
+bool_val                : CTRUE
+ 			{ if (insert_id("T",0)) return -1; }
+                        | CFALSE
+			{ if (insert_id("F",0)) return -1; }
+                        ;
+cond_stmt_def           : IF cond_expr '{' cond_pol_list '}'
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2, (cond_av_list_t*)$4,(cond_av_list_t*) 0) < 0) return -1;  }}
+                        | IF cond_expr '{' cond_pol_list '}' ELSE '{' cond_pol_list '}'
+                        { if (pass == 2) { if (define_conditional((cond_expr_t*)$2,(cond_av_list_t*)$4,(cond_av_list_t*)$8) < 0 ) return -1;  }}       
+                        ;
+cond_expr               : '(' cond_expr ')'
+			{ $$ = $2;}
+			| NOT cond_expr
+			{ $$ = define_cond_expr(COND_NOT, $2, 0);
+			  if ($$ == 0) return -1; }
+			| cond_expr AND cond_expr
+			{ $$ = define_cond_expr(COND_AND, $1, $3);
+			  if ($$ == 0) return  -1; }
+			| cond_expr OR cond_expr
+			{ $$ = define_cond_expr(COND_OR, $1, $3);
+			  if ($$ == 0) return   -1; }
+			| cond_expr XOR cond_expr
+			{ $$ = define_cond_expr(COND_XOR, $1, $3);
+			  if ($$ == 0) return  -1; }
+			| cond_expr EQUALS cond_expr
+			{ $$ = define_cond_expr(COND_EQ, $1, $3);
+			  if ($$ == 0) return  -1; }
+			| cond_expr NOTEQUAL cond_expr
+			{ $$ = define_cond_expr(COND_NEQ, $1, $3);
+			  if ($$ == 0) return  -1; }
+			| cond_expr_prim
+			{ $$ = $1; }
+			;
+cond_expr_prim          : identifier
+                        { $$ = define_cond_expr(COND_BOOL,0, 0);
+			  if ($$ == COND_ERR) return   -1; }
+                        ;
+cond_pol_list           : cond_rule_def
+                        { $$ = define_cond_pol_list((cond_av_list_t *) 0, (cond_av_list_t *)$1);}
+                        | cond_pol_list cond_rule_def 
+                        { $$ = define_cond_pol_list((cond_av_list_t *)$1, (cond_av_list_t *)$2); }
+			;
+cond_rule_def           : cond_transition_def
+                        { $$ = $1; }
+                        | cond_te_avtab_def
+                        { $$ = $1; }
+                        ;
+cond_transition_def	: TYPE_TRANSITION names names ':' names identifier ';'
+                        { $$ = define_cond_compute_type(AVTAB_TRANSITION) ;
+                          if ($$ == COND_ERR) return -1;}
+                        | TYPE_MEMBER names names ':' names identifier ';'
+                        { $$ = define_cond_compute_type(AVTAB_MEMBER) ;
+                          if ($$ ==  COND_ERR) return -1;}
+                        | TYPE_CHANGE names names ':' names identifier ';'
+                        { $$ = define_cond_compute_type(AVTAB_CHANGE) ;
+                          if ($$ == COND_ERR) return -1;}
+    			;
+cond_te_avtab_def	: cond_allow_def
+                          { $$ = $1; }
+			| cond_auditallow_def
+			  { $$ = $1; }
+			| cond_auditdeny_def
+			  { $$ = $1; }
+			| cond_dontaudit_def
+			  { $$ = $1; }
+			;
+cond_allow_def		: ALLOW names names ':' names names  ';'
+			{ $$ = define_cond_te_avtab(AVTAB_ALLOWED) ;
+                          if ($$ == COND_ERR) return -1; }
+		        ;
+cond_auditallow_def	: AUDITALLOW names names ':' names names ';'
+			{ $$ = define_cond_te_avtab(AVTAB_AUDITALLOW) ;
+                          if ($$ == COND_ERR) return -1; }
+		        ;
+cond_auditdeny_def	: AUDITDENY names names ':' names names ';'
+			{ $$ = define_cond_te_avtab(AVTAB_AUDITDENY) ;
+                          if ($$ == COND_ERR) return -1; }
+		        ;
+cond_dontaudit_def	: DONTAUDIT names names ':' names names ';'
+			{ $$ = define_cond_te_avtab(-AVTAB_AUDITDENY);
+                          if ($$ == COND_ERR) return -1; }
+		        ;
 transition_def		: TYPE_TRANSITION names names ':' names identifier ';'
                         {if (define_compute_type(AVTAB_TRANSITION)) return -1;}
                         | TYPE_MEMBER names names ':' names identifier ';'
@@ -573,6 +688,8 @@
 			{ $$ = strtoul(yytext,NULL,0); }
 			;
 %%
+#define DEBUG 1
+
 static int insert_separator(int push)
 {
 	int error;
@@ -1845,6 +1962,186 @@
 	return -1;
 }
 
+static cond_av_list_t *define_cond_compute_type(int which)
+{
+	char *id;
+	cond_av_list_t *sub_list;
+	avtab_key_t avkey;
+	avtab_datum_t avdatum, *avdatump;
+	type_datum_t *datum;
+	class_datum_t *cladatum;
+	ebitmap_t stypes, ttypes, tclasses;
+	__u32 newtype = 0;
+	int i, j, k;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		id = queue_remove(id_queue);
+		free(id);
+		return (cond_av_list_t *)1; /* any non-NULL value */
+	}
+	
+	ebitmap_init(&stypes);
+	ebitmap_init(&ttypes);
+	ebitmap_init(&tclasses);
+
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&stypes, id))
+			return  COND_ERR;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&ttypes, id))
+			return COND_ERR;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		cladatum = hashtab_search(policydbp->p_classes.table, id);
+		if (!cladatum) {
+			sprintf(errormsg, "unknown class %s", id);
+			yyerror(errormsg);
+			goto bad;
+		}
+		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);
+		free(id);
+	}
+
+	id = (char *) queue_remove(id_queue);
+	if (!id) {
+		yyerror("no newtype?");
+		goto bad;
+	}
+	datum = (type_datum_t *) hashtab_search(policydbp->p_types.table,
+						(hashtab_key_t) id);
+	if (!datum || datum->isattr) {
+		sprintf(errormsg, "unknown type %s", id);
+		yyerror(errormsg);
+		goto bad;
+	}
+
+	/* create sub_list to be passed back and appended to true or false list */
+	sub_list = (cond_av_list_t *) 0;
+
+	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
+		if (!ebitmap_get_bit(&stypes, i)) 
+			continue;
+		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
+			if (!ebitmap_get_bit(&ttypes, j)) 
+				continue;
+			for (k = ebitmap_startbit(&tclasses); k < ebitmap_length(&tclasses); k++) {
+				if (!ebitmap_get_bit(&tclasses, k)) 
+					continue;
+				avkey.source_type = i + 1;
+				avkey.target_type = j + 1;
+				avkey.target_class = k + 1;
+				avdatump = avtab_search(&policydbp->te_avtab, &avkey, AVTAB_TYPE);
+				
+				/* does rule exist in base policy? */
+				if ((avdatump) && (avdatump->specified & which)) {
+					switch (which) {
+					case AVTAB_TRANSITION:
+						newtype = avtab_transition(avdatump);
+						break;
+					case AVTAB_MEMBER:
+						newtype = avtab_member(avdatump);
+						break;
+					case AVTAB_CHANGE:
+						newtype = avtab_change(avdatump);
+						break;
+					}
+					if ( (newtype != datum->value) ) {
+						sprintf(errormsg, "conflicting type rule for conditional "
+							"(%s, %s:%s) in base: default is %s, conditional %s "
+							"will be ignored", 
+							type_val_to_name(i+1), 
+							type_val_to_name(j+1), 
+							policydbp->p_class_val_to_name[k],
+							type_val_to_name(newtype),
+							type_val_to_name(datum->value));
+						yywarn(errormsg);
+					} else {
+						sprintf(errormsg, "conditional type rule (%s, %s:%s): "
+							"has same default, %s, as rule in base policy; "
+							"conditional %s will be ignored", 
+							type_val_to_name(i+1), 
+							type_val_to_name(j+1), 
+							policydbp->p_class_val_to_name[k],
+							type_val_to_name(newtype),
+							type_val_to_name(datum->value));
+						yywarn(errormsg);
+					}
+				}
+				/* rule does not exist in base policy */
+				else {
+					
+					memset(&avdatum, 0, sizeof avdatum);
+					avdatum.specified |= which;
+					switch (which) {
+					case AVTAB_TRANSITION:
+					        avtab_transition(&avdatum) = datum->value;
+						break;
+					case AVTAB_MEMBER:
+						avtab_member(&avdatum) = datum->value;
+						break;
+					case AVTAB_CHANGE:
+						avtab_change(&avdatum) = datum->value;
+						break;
+					}
+					/* add rule to sub list */
+					sub_list = cond_list_append(sub_list, &avkey, &avdatum);
+					if (sub_list == COND_ERR) {
+						yyerror("list overflow");
+						goto bad;
+					}
+				}
+			}
+		}
+	}
+	
+	return sub_list;
+
+      bad:
+	return COND_ERR;
+}
+
+static cond_av_list_t *cond_list_append(cond_av_list_t *sl, avtab_key_t *key, avtab_datum_t *datum) {
+
+	cond_av_list_t  *n, *end;
+
+	n = (cond_av_list_t *) malloc(sizeof(cond_av_list_t));
+	if (!n) {
+		  yyerror("out of memory");
+		  return COND_ERR;
+	}
+	memset(n, 0, sizeof(cond_av_list_t));
+	if (sl) {
+		for(end=sl; end->next != NULL; end = end->next);
+		end->next = n;
+	}
+	else sl = n;
+	n->next = NULL;
+	
+	/* construct new node */
+	n->node = (avtab_ptr_t) malloc(sizeof(struct avtab_node));
+	if (!n->node) {
+		yyerror("out of memory");
+		return COND_ERR;
+	}
+	memset(n->node, 0, sizeof(struct avtab_node));
+	n->node->key = *key;
+	n->node->datum = *datum;
+	/* the next two fields get filled in when we add to true/false list  */
+	n->node->next = (avtab_ptr_t) 0;
+	n->node->parse_context = (void *) 0;
+	
+	return(sl);
+}
+
 
 static int perm_name(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
@@ -1895,6 +2192,86 @@
 	return avbuf;
 }
 
+static int define_bool()
+{
+	char *id, *name;
+	cond_bool_datum_t *datum;
+	int ret;
+
+
+	if (pass == 2) {
+		while ((id = queue_remove(id_queue)))
+			free(id);
+		return 0;
+	}		
+
+	id = (char *) queue_remove(id_queue);
+	if (!id) {
+		yyerror("no identifier for bool definition?");
+		return -1;
+	}
+	name = id;
+
+	id = (char *) queue_remove(id_queue);
+	if (!id) {
+		yyerror("no default value for bool definition?");
+		free(name);
+		return -1;
+	}
+
+	datum = (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t));
+	if (!datum) {
+		yyerror("out of memory");
+		free(id);
+		free(name);
+		return -1;
+	}
+	memset(datum, 0, sizeof(cond_bool_datum_t));
+	datum->state = (int)(id[0] == 'T') ? 1 : 0;
+	datum->value = ++policydbp->p_bools.nprim;
+
+	ret = hashtab_insert(policydbp->p_bools.table,
+			     (hashtab_key_t) name, (hashtab_datum_t) datum);
+
+	if (ret == HASHTAB_PRESENT) {
+		--policydbp->p_bools.nprim;
+		free(datum);
+		sprintf(errormsg, "name conflict for bool %s", id);
+		yyerror(errormsg);
+		free(id);
+		free(name);
+		return -1;
+	}
+	if (ret == HASHTAB_OVERFLOW) {
+		yyerror("hash table overflow");
+		free(datum);
+		free(id);
+		free(name);
+		return -1;
+	}
+	return 0;
+}
+
+static cond_av_list_t *define_cond_pol_list( cond_av_list_t *avlist, cond_av_list_t *sl )
+{
+	cond_av_list_t *end;
+
+	if (pass == 1) {
+		/* return something so we get through pass 1 */
+		return (cond_av_list_t *)1;
+	}
+
+	/* if we've started collecting sub lists, prepend to start of collection
+	   because it's probably less iterations than appending. */
+	if (!sl) return avlist;
+	else if (!avlist) return sl;
+	else {
+		end = sl;
+		while (end->next) end = end->next;
+		end->next = avlist;
+	} 
+	return sl;
+}
 
 static int te_avtab_helper(int which, unsigned int stype, unsigned int ttype, 
 			   ebitmap_t *tclasses, access_vector_t *avp)
@@ -1956,6 +2333,198 @@
 	return 0;
 }
 
+static  cond_av_list_t *cond_te_avtab_helper(int which, int stype, int ttype, 
+			   ebitmap_t *tclasses, access_vector_t *avp )
+
+{
+	cond_av_list_t *sl;
+	avtab_key_t avkey;
+	avtab_datum_t avdatum;
+	int  k;
+
+	if (which == -AVTAB_ALLOWED) {
+		yyerror("neverallow should not reach this function.");
+		return COND_ERR;
+	}
+
+	/* create sub_list to be passed back and appended to true or false list */
+	sl = (cond_av_list_t *) 0;
+
+	for (k = ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++) {
+		if (!ebitmap_get_bit(tclasses, k)) 
+			continue;
+		/* build the key */
+		avkey.source_type = stype + 1;
+		avkey.target_type = ttype + 1;
+		avkey.target_class = k + 1;
+		
+		/* build the datum */
+		memset(&avdatum, 0, sizeof avdatum);
+		avdatum.specified = (which > 0) ? which : -which;
+
+		switch (which) {
+		case AVTAB_ALLOWED:
+			avtab_allowed(&avdatum) = avp[k];
+			break;
+		case AVTAB_AUDITALLOW:
+			avtab_auditallow(&avdatum) = avp[k];
+			break;
+		case AVTAB_AUDITDENY:
+			yyerror("AUDITDENY statements are not allowed in a conditional block; use DONTAUDIT");
+			return COND_ERR;
+		case -AVTAB_AUDITDENY:
+			avtab_auditdeny(&avdatum) = ~avp[k];
+			break;
+		}
+
+		/* add to temporary list */
+		sl = cond_list_append(sl, &avkey, &avdatum);
+
+		if (sl == COND_ERR) {
+			yyerror("list overflow");
+			return COND_ERR;
+		}
+	}
+
+	return sl;
+}
+
+static cond_av_list_t *define_cond_te_avtab(int which)
+{
+	char *id;
+	cond_av_list_t *sub_list, *self_list, *n;
+	class_datum_t *cladatum;
+	perm_datum_t *perdatum;
+	ebitmap_t stypes, ttypes, tclasses;
+	access_vector_t *avp;
+	int i, j, hiclass, self = 0;
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		return (cond_av_list_t *) 1; /* any non-NULL value */
+	}
+
+	ebitmap_init(&stypes);
+	ebitmap_init(&ttypes);
+	ebitmap_init(&tclasses);
+
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&stypes, id))
+			return COND_ERR;
+	}
+
+	while ((id = queue_remove(id_queue))) {
+		if (strcmp(id, "self") == 0) {
+			self = 1;
+			continue;
+		}
+		if (set_types(&ttypes, id))
+			return COND_ERR;
+	}
+
+	hiclass = 0;
+	while ((id = queue_remove(id_queue))) {
+		cladatum = hashtab_search(policydbp->p_classes.table, id);
+		if (!cladatum) 	{
+			sprintf(errormsg, "unknown class %s used in rule", id);
+			yyerror(errormsg);
+			goto bad;
+		}
+		ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE);	
+		if (cladatum->value > hiclass)
+			hiclass = cladatum->value;
+		free(id);
+	}
+
+	avp = malloc(hiclass * sizeof(access_vector_t));
+	if (!avp) {
+		yyerror("out of memory");
+		return COND_ERR;
+	}
+	for (i = 0; i < hiclass; i++)
+		avp[i] = 0;
+	while ((id = queue_remove(id_queue))) {
+		for (i = ebitmap_startbit(&tclasses); i < ebitmap_length(&tclasses); i++) {
+			if (!ebitmap_get_bit(&tclasses, i)) 
+				continue;
+			cladatum = policydbp->class_val_to_struct[i];
+
+			if (strcmp(id, "*") == 0) {
+				/* set all permissions in the class */
+				avp[i] = ~0;
+				continue;
+			}
+
+			if (strcmp(id, "~") == 0) {
+				/* complement the set */
+				if (which == -AVTAB_AUDITDENY) 
+					yywarn("dontaudit rule with a ~?");
+				avp[i] = ~avp[i];
+				continue;
+			}
+
+			perdatum = hashtab_search(cladatum->permissions.table,
+						  id);
+			if (!perdatum) {
+				if (cladatum->comdatum) {
+					perdatum = hashtab_search(cladatum->comdatum->permissions.table,
+								  id);
+				}
+			}
+			if (!perdatum) {
+				sprintf(errormsg, "permission %s is not defined for class %s", id, policydbp->p_class_val_to_name[i]);
+				yyerror(errormsg);
+				continue;
+			}
+
+			avp[i] |= (1 << (perdatum->value - 1));
+		}
+
+		free(id);
+	}
+
+	sub_list = (cond_av_list_t *) 0;
+	self_list = (cond_av_list_t *) 0;
+	for (i = ebitmap_startbit(&stypes); i < ebitmap_length(&stypes); i++) {
+		if (!ebitmap_get_bit(&stypes, i)) 
+			continue;
+		if (self) {
+			if ((self_list = cond_te_avtab_helper(which, i, i, &tclasses, avp )) == COND_ERR)
+				return COND_ERR;
+		}
+		for (j = ebitmap_startbit(&ttypes); j < ebitmap_length(&ttypes); j++) {
+			if (!ebitmap_get_bit(&ttypes, j)) 
+				continue;
+			if ((sub_list = cond_te_avtab_helper(which, i, j, &tclasses, avp)) == COND_ERR)
+				return COND_ERR;
+			/* add the self_list, if any, and the sub_list */
+			if (self_list) {
+				n = self_list;
+				while (n->next != (cond_av_list_t *)0) n = n->next;
+				n->next = sub_list;
+			} else {
+				self_list = sub_list;
+			}
+		}
+	}
+
+	ebitmap_destroy(&stypes);
+	ebitmap_destroy(&ttypes);
+	ebitmap_destroy(&tclasses);
+	free(avp);
+	
+	return self_list;
+ bad:
+	return COND_ERR;
+}
+
 
 static int define_te_avtab(int which)
 {
@@ -2580,7 +3149,6 @@
 	return 0;
 }
 
-
 static uintptr_t
  define_cexpr(__u32 expr_type, uintptr_t arg1, uintptr_t arg2)
 {
@@ -2706,6 +3274,328 @@
 	yyerror("invalid constraint expression");
 	free(expr);
 	return 0;
+}
+
+static int define_conditional(cond_expr_t *expr, cond_av_list_t *t, cond_av_list_t *f )
+{
+	cond_expr_t *e;
+	cond_node_t *cn, tmp, *cn_new;
+	int depth;
+
+
+	/* expression cannot be NULL */
+	if ( !expr) {
+		yyerror("illegal conditional expression");
+		return -1;
+	}
+	/* Must have at least one rule in true list */
+	if (!t) {
+		yyerror("must have at least one rule in true list");
+		return -1;
+	}
+
+
+	/* verify expression */
+	depth = -1;
+	for (e = expr; e; e = e->next) {
+		switch (e->expr_type) {
+		case COND_NOT:
+			if (depth < 0) {
+				yyerror("illegal conditional expression; Bad NOT");
+				return -1;
+			}
+			break;
+		case COND_AND:
+		case COND_OR:
+		case COND_XOR:
+		case COND_EQ:
+		case COND_NEQ:
+			if (depth < 1) {
+				yyerror("illegal conditional expression; Bad binary op");
+				return -1;
+			}
+			depth--;
+			break;
+		case COND_BOOL:
+			if (depth == (COND_EXPR_MAXDEPTH-1)) {
+				yyerror("conditional expression is like totally too deep");
+				return -1;
+			}
+			depth++;
+			break;
+		default:
+			yyerror("illegal conditional expression");
+			return -1;
+		}
+	}
+	if (depth != 0) {
+		yyerror("illegal conditional expression");
+		return -1;
+	}
+
+        /*  use tmp conditional node to partially build new node */
+	cn = &tmp;
+	cn->expr = expr;
+	cn->true_list = t;
+	cn->false_list = f;
+      
+	/* normalize/precompute expression */
+	if (normalize_expr(policydbp, cn) < 0) {
+		yyerror("problem normalizing conditional expression");
+		return -1;
+	}
+
+	/* get the existing conditional node, or a new one*/
+	cn_new = cond_node_search(policydbp, cn);
+	if(cn_new) {
+		cond_reduce_insert_list (cn->true_list, &cn_new->true_list, &cn_new->false_list, cn_new->cur_state);
+		cond_reduce_insert_list (cn->false_list, &cn_new->false_list, &cn_new->true_list, !cn_new->cur_state);
+	} else { 
+		yyerror("could not get a conditional node");
+		return -1;
+	}
+
+
+	return 0;
+}
+
+
+/*  Set the ENABLE bit and parse_context for each rule and check rules to see if they already exist.
+ * Insert rules into the conditional db when appropriate.
+ *  
+ * new - list of rules to potentially add/insert
+ * active - list to add rule to, and address to use as parse_context
+ * inactive - opposite rule list in same conditional
+ * state - whether rules in new are on or off by default.
+ *
+ * There are 4 possible conditions for a TYPE_* rule.  Allow rules are always inserted or
+ * OR'd with existing allow rules on the same side of the same conditional.
+ *
+ * 1) Not present anywhere -> add it
+ * 2) Already in cond, same side -> warn, replace default in prev rule, delete this rule
+ * 3) Just added to opp side -> search again (we may still add this rule)
+ * 4) In another conditional (either side) -> warn, delete this rule
+ */
+static void cond_reduce_insert_list(cond_av_list_t *new, cond_av_list_t **active, cond_av_list_t **inactive, int state)
+{
+	int add_rule = 1;
+	cond_av_list_t *c, *top;
+	avtab_ptr_t dup;
+	__u32 old_data = 0, new_data = 0;
+
+	top = c = new; 
+	/* loop through all the rules in the list */
+	while(c) {
+
+                /* is conditional rule a TYPE_* rule that's already in a conditional? */
+                /* [note that we checked to see if it's in the base when we parsed the rule] */
+		if ((c->node->datum.specified & AVTAB_TYPE) &&
+		    ((dup = avtab_search_node(&policydbp->te_cond_avtab, &c->node->key, c->node->datum.specified & AVTAB_TYPE)) != NULL) ){
+			do {
+				/* is the rule we found in the current rule list or the equivalent */
+				if (dup->parse_context == active) {
+					/* change original default */
+					switch(c->node->datum.specified & AVTAB_TYPE) {
+					case AVTAB_TRANSITION:
+						old_data = avtab_transition(&dup->datum);
+						new_data = avtab_transition(&c->node->datum);
+						avtab_transition(&dup->datum) = new_data;
+						break;
+					case AVTAB_MEMBER:
+						old_data = avtab_member(&dup->datum);
+						new_data = avtab_member(&c->node->datum);
+						avtab_member(&dup->datum) = new_data;
+						break;
+					case AVTAB_CHANGE:
+						old_data = avtab_change(&dup->datum);
+						new_data = avtab_change(&c->node->datum);
+						avtab_change(&dup->datum) = new_data;
+						break;
+					}
+					sprintf(errormsg, "duplicate type rule on same side of conditional for (%s, %s:%s); overwrote original default %s with %s",
+						type_val_to_name(c->node->key.source_type), 
+						type_val_to_name(c->node->key.target_type), 
+						policydbp->p_class_val_to_name[c->node->key.target_class],
+						type_val_to_name(old_data),
+						type_val_to_name(new_data));					
+					yywarn(errormsg);
+					add_rule = 0;
+					break;
+				}
+				/* if the rule we found is in the opposite rule list that's OK*/
+				if (dup->parse_context == inactive) {
+					continue;
+				} else {
+					/* the rule we found must be in another conditional */
+					sprintf(errormsg, "discarding conflicting conditional type rule for (%s, %s:%s); may only be in one conditional",
+						type_val_to_name(c->node->key.source_type), 
+						type_val_to_name(c->node->key.target_type), 
+						policydbp->p_class_val_to_name[c->node->key.target_class]);
+					yywarn(errormsg);
+					add_rule = 0;
+					break;
+				}
+			} while ( (dup = avtab_search_node_next(dup, c->node->datum.specified & AVTAB_TYPE)) != NULL);
+
+		} /* end dealing with TYPE_* rules */
+		else if ( (c->node->datum.specified & AVTAB_AV ) &&
+		     ((dup = avtab_search_node(&policydbp->te_cond_avtab, &c->node->key, c->node->datum.specified & AVTAB_AV)) != NULL) ){
+			do {
+				/* we only care if the same AV rule is on the same side of the same conditional */
+				if (dup->parse_context == active) {
+					/* add to original */
+					switch(c->node->datum.specified & AVTAB_AV) {
+					case AVTAB_ALLOWED:
+						new_data = avtab_allowed(&c->node->datum);
+						avtab_allowed(&dup->datum) |= new_data;
+						break;
+					case AVTAB_AUDITALLOW:
+						new_data = avtab_auditallow(&c->node->datum);
+						avtab_auditallow(&dup->datum) |= new_data;
+						break;
+					case AVTAB_AUDITDENY:
+						new_data = avtab_auditdeny(&c->node->datum);
+						/* Since a '0' in an auditdeny mask represents a 
+						 * permission we do NOT want to audit (dontaudit), we use
+						 * the '&' operand to ensure that all '0's in the mask
+						 * are retained (much unlike the allow and auditallow cases).
+						 */
+						avtab_auditdeny(&dup->datum) &= new_data;
+						break;
+					}
+					add_rule = 0;
+					break;
+				}
+			} while ( (dup = avtab_search_node_next(dup, c->node->datum.specified & AVTAB_AV)) != NULL);
+		} /* end dealing with ALLOW rules */
+
+		top = c->next;
+		/* Either insert the rule into the policy and active list, or discard the rule */
+		if (add_rule) {
+			c->node = avtab_insert_with_parse_context(&policydbp->te_cond_avtab, 
+								  &c->node->key,
+								  &c->node->datum,
+								  active);
+			/* set whether the rule is enabled/disabled */
+			if (state) {
+				c->node->datum.specified |= AVTAB_ENABLED;
+			} else {
+				c->node->datum.specified &= ~AVTAB_ENABLED;
+			}
+
+			/* prepend new rule to active list */
+ 			c->next = *active; 
+ 			*active = c; 
+		} else {
+			/* discard rule */
+			free(c->node);
+			free(c);
+			
+			add_rule = 1;
+		}
+                /* next rule */
+		c = top;
+		
+	} /* while */
+}
+
+static cond_expr_t *
+ define_cond_expr(__u32 expr_type, void* arg1, void* arg2)
+{
+	struct cond_expr *expr, *e1 = NULL, *e2;
+	cond_bool_datum_t *bool_var;
+	char *id;
+
+	/* expressions are handled in the second pass */
+	if (pass == 1) {
+		if (expr_type == COND_BOOL) {
+			while ((id = queue_remove(id_queue))) {
+				free(id);
+			}
+		}
+		return (cond_expr_t *)1; /* any non-NULL value */
+	}
+
+	/* create a new expression struct */
+	expr = malloc(sizeof(struct cond_expr));
+	if (!expr) {
+		yyerror("out of memory");
+		return NULL;
+	}
+	memset(expr, 0, sizeof(cond_expr_t));
+	expr->expr_type = expr_type;
+
+	/* create the type asked for */
+	switch (expr_type) {
+	case COND_NOT:
+		e1 = NULL;
+		e2 = (struct cond_expr *) arg1;
+		while (e2) {
+			e1 = e2;
+			e2 = e2->next;
+		}
+		if (!e1 || e1->next) {
+			yyerror("illegal conditional NOT expression");
+			free(expr);
+			return NULL;
+		}
+		e1->next = expr;
+		return (struct cond_expr *) arg1;
+	case COND_AND:
+	case COND_OR:
+	case COND_XOR:
+	case COND_EQ:
+	case COND_NEQ:
+		e1 = NULL;
+		e2 = (struct cond_expr *) arg1;
+		while (e2) {
+			e1 = e2;
+			e2 = e2->next;
+		}
+		if (!e1 || e1->next) {
+			yyerror("illegal left side of conditional binary op expression");
+			free(expr);
+			return NULL;
+		}
+		e1->next = (struct cond_expr *) arg2;
+
+		e1 = NULL;
+		e2 = (struct cond_expr *) arg2;
+		while (e2) {
+			e1 = e2;
+			e2 = e2->next;
+		}
+		if (!e1 || e1->next) {
+			yyerror("illegal right side of conditional binary op expression");
+			free(expr);
+			return NULL ;
+		}
+		e1->next = expr;
+		return (struct cond_expr *) arg1;
+	case COND_BOOL:
+		id = (char *) queue_remove(id_queue) ;
+		if (!id) {
+			yyerror("bad conditional; expected boolean id");
+			free(id);
+			free(expr);
+			return NULL;
+		}
+		bool_var = (cond_bool_datum_t *) hashtab_search(policydbp->p_bools.table,
+								(hashtab_key_t) id);
+		if (!bool_var) {
+			sprintf(errormsg, "unknown boolean %s in conditional expression", id);
+			yyerror(errormsg);
+			free(expr);
+			free(id);
+			return NULL ;
+		}
+		expr->bool = bool_var->value;
+		free(id);
+		return expr;
+	default:
+		yyerror("illegal conditional expression");
+		return NULL;
+	}
 }
 
 
diff -Nru a/selinux-usr/checkpolicy/policy_scan.l b/selinux-usr/checkpolicy/policy_scan.l
--- a/selinux-usr/checkpolicy/policy_scan.l	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/policy_scan.l	Wed Jan 14 13:39:12 2004
@@ -3,6 +3,16 @@
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
  */
 
+/* Updated: David Caplan, <dac@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 /* FLASK */
 
 %{
@@ -10,6 +20,7 @@
 
 static char linebuf[2][255];
 static unsigned int lno = 0;
+int yywarn(char *msg);
 
 unsigned long policydb_lineno = 1;
 
@@ -44,6 +55,12 @@
 types				{ return(TYPES); }
 TYPE |
 type				{ return(TYPE); }
+BOOL |
+bool                            { return(BOOL); }
+IF |
+if                         { return(IF); }
+ELSE |
+else                         { return(ELSE); }
 ALIAS |
 alias				{ return(ALIAS); }
 ATTRIBUTE |
@@ -90,8 +107,14 @@
 and				{ return(AND);}
 NOT |
 not				{ return(NOT);}
+xor |
+XOR                             { return(XOR); }
 eq |
 EQ				{ return(EQUALS);}
+true |
+TRUE                            { return(CTRUE); } 
+false |
+FALSE                           { return(CFALSE); } 
 dom |
 DOM				{ return(DOM);}
 domby |
@@ -137,6 +160,7 @@
 "&&"				{ return (AND); }
 "||"				{ return (OR); }
 "!"				{ return (NOT); }
+"^"                             { return (XOR); }
 "," |
 ":" |
 ";" |
@@ -172,5 +196,4 @@
 			linebuf[0], linebuf[1]);
 	return 0;
 }
-
 
diff -Nru a/selinux-usr/checkpolicy/policydb.c b/selinux-usr/checkpolicy/policydb.c
--- a/selinux-usr/checkpolicy/policydb.c	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/policydb.c	Wed Jan 14 13:39:12 2004
@@ -1,6 +1,16 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 /* FLASK */
 
 /*
@@ -9,6 +19,7 @@
 
 #include "policydb.h"
 #include "mls.h"
+#include "conditional.h"
 
 #if 0
 static char *symtab_name[SYM_NUM] = {
@@ -16,8 +27,10 @@
 	"classes",
 	"roles",
 	"types",
-	"users"
+	"users",
+	"bools"
 	mls_symtab_names
+	cond_symtab_names
 };
 #endif
 
@@ -26,7 +39,8 @@
 	32,
 	16,
 	512,
-	128
+	128,
+	16
 	mls_symtab_sizes
 };
 
@@ -80,6 +94,7 @@
 	memset(p, 0, sizeof(policydb_t));
 
 	for (i = 0; i < SYM_NUM; i++) {
+		p->sym_val_to_name[i] = NULL;
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
 		if (rc)
 			goto out_free_symtab;
@@ -93,6 +108,9 @@
 	if (rc)
 		goto out_free_avtab;
 
+	rc = cond_policydb_init(p);
+	if (rc)
+		goto out_free_avtab;
 out:
 	return rc;
 
@@ -199,7 +217,8 @@
 	class_index,
 	role_index,
 	type_index,
-	user_index
+	user_index,
+	cond_index_bool
 	mls_index_f
 };
 
@@ -231,9 +250,26 @@
 
 	if (hashtab_map(p->p_classes.table, class_index, p))
 		return -1;
+
 	return 0;
 }
 
+int policydb_index_bools(policydb_t * p)
+{
+
+	if (cond_init_bool_indexes(p) == -1)
+		return -1;
+	p->p_bool_val_to_name = (char **)
+		kmalloc(p->p_bools.nprim * sizeof(char *),GFP_KERNEL);
+	if (!p->p_bool_val_to_name)
+		return -1;
+	if (hashtab_map(
+		    p->p_bools.table, 
+		    cond_index_bool, 
+		    p))
+		return -1;
+	return 0;
+}
 
 /*
  * Define the other val_to_name and val_to_struct arrays
@@ -244,8 +280,8 @@
 	int i;
 
 
-	printk("security:  %d users, %d roles, %d types",
-	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim);
+	printk("security:  %d users, %d roles, %d types, %d bools",
+	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
 	mls_policydb_index_others(p);
 	printk("\n");
 
@@ -268,7 +304,11 @@
 	if (!p->user_val_to_struct)
 		return -1;
 
+	cond_init_bool_indexes(p);
+
 	for (i = SYM_ROLES; i < SYM_NUM; i++) {
+		if (p->sym_val_to_name[i])
+			kfree(p->sym_val_to_name[i]);
 		p->sym_val_to_name[i] = (char **)
 		    kmalloc(p->symtab[i].nprim * sizeof(char *),GFP_KERNEL);
 		if (!p->sym_val_to_name[i])
@@ -381,7 +421,8 @@
 	class_destroy,
 	role_destroy,
 	type_destroy,
-	user_destroy
+	user_destroy,
+	cond_destroy_bool
 	mls_destroy_f
 };
 
@@ -442,7 +483,7 @@
 		g = g->next;
 		kfree(gtmp);
 	}
-
+	cond_policydb_destroy(p);
 	return;
 }
 
@@ -957,7 +998,8 @@
 	class_read,
 	role_read,
 	type_read,
-	user_read
+	user_read,
+	cond_read_bool
 	mls_read_f
 };
 
@@ -974,7 +1016,7 @@
 	struct role_trans *tr, *ltr;
 	ocontext_t *l, *c, *newc;
 	genfs_t *genfs_p, *genfs, *newgenfs;
-	unsigned int i, j;
+	unsigned int i, j, policy_ver, num_syms;
 	__u32 *buf, config;
 	size_t len, len2, nprim, nel, nel2;
 	char *policydb_str;
@@ -1030,25 +1072,43 @@
 	for (i = 0; i < 4; i++)
 		buf[i] = le32_to_cpu(buf[i]);
 
-	if (buf[0] != POLICYDB_VERSION) {
-		printk("security:  policydb version %d does not match my version %d\n", buf[0], POLICYDB_VERSION);
+	policy_ver = buf[0];
+	if (policy_ver != POLICYDB_VERSION && policy_ver != POLICYDB_VERSION_COMPAT) {
+		printk("security:  policydb version %d does not match "
+		       "my version %d\n", buf[0], POLICYDB_VERSION);
 		goto bad;
 	}
+
 	if (buf[1] != config) {
 		printk("security:  policydb configuration (%s) does not match my configuration (%s)\n",
 		       mls_config(buf[1]),
 		       mls_config(config));
 		goto bad;
 	}
-	if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
-		printk("security:  policydb table sizes (%d,%d) do not match mine (%d,%d)\n", buf[2], buf[3], SYM_NUM, OCON_NUM);
-		goto bad;
+
+	
+	if (policy_ver == POLICYDB_VERSION_COMPAT) {
+		if (buf[2] != (SYM_NUM - 1) || buf[3] != OCON_NUM) {
+			printk("security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM - 1;
+	} else {
+		if (buf[2] != SYM_NUM || buf[3] != OCON_NUM) {
+			printk("security:  policydb table sizes (%d,%d) do "
+			       "not match mine (%d,%d)\n",
+			       buf[2], buf[3], SYM_NUM, OCON_NUM);
+			goto bad;
+		}
+		num_syms = SYM_NUM;
 	}
 
 	if (mls_read_nlevels(p, fp)) 
 		goto bad;
 
-	for (i = 0; i < SYM_NUM; i++) {
+	for (i = 0; i < num_syms; i++) {
 		buf = next_entry(fp, sizeof(__u32)*2);
 		if (!buf)
 			goto bad;
@@ -1064,6 +1124,9 @@
 
 	if (avtab_read(&p->te_avtab, fp, config))
 		goto bad;
+	if (policy_ver == POLICYDB_VERSION)
+		if (cond_read_list(p, fp))
+			goto bad;
 
 	buf = next_entry(fp, sizeof(__u32));
 	if (!buf)
diff -Nru a/selinux-usr/checkpolicy/policydb.h b/selinux-usr/checkpolicy/policydb.h
--- a/selinux-usr/checkpolicy/policydb.h	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/policydb.h	Wed Jan 14 13:39:12 2004
@@ -1,6 +1,16 @@
 
 /* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
 
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 /* FLASK */
 
 /*
@@ -17,7 +27,6 @@
 #include "context.h"
 #include "constraint.h"
 
-
 /*
  * A datum type is defined for each kind of symbol 
  * in the configuration data:  individual permissions, 
@@ -109,6 +118,15 @@
 } cat_datum_t;
 #endif
 
+/* Boolean data type */
+typedef struct cond_bool_datum {
+	__u32 value;		/* internal type value */
+	int state;
+} cond_bool_datum_t;
+
+struct cond_node;
+
+typedef struct cond_node cond_list_t;
 
 /*
  * The configuration data includes security contexts for 
@@ -154,9 +172,11 @@
 #ifdef CONFIG_SECURITY_SELINUX_MLS
 #define SYM_LEVELS  5
 #define SYM_CATS    6
-#define SYM_NUM     7
+#define SYM_BOOLS   7
+#define SYM_NUM     8
 #else
-#define SYM_NUM     5
+#define SYM_BOOLS   5
+#define SYM_NUM     6
 #endif
 
 /* object context array indices */
@@ -179,6 +199,7 @@
 #define p_users symtab[SYM_USERS]
 #define p_levels symtab[SYM_LEVELS]
 #define p_cats symtab[SYM_CATS]
+#define p_bools symtab[SYM_BOOLS]
 
 	/* symbol names indexed by (value - 1) */
 	char **sym_val_to_name[SYM_NUM];
@@ -189,6 +210,7 @@
 #define p_user_val_to_name sym_val_to_name[SYM_USERS]
 #define p_sens_val_to_name sym_val_to_name[SYM_LEVELS]
 #define p_cat_val_to_name sym_val_to_name[SYM_CATS]
+#define p_bool_val_to_name sym_val_to_name[SYM_BOOLS]
 
 	/* class, role, and user attributes indexed by (value - 1) */
 	class_datum_t **class_val_to_struct;
@@ -198,6 +220,13 @@
 	/* type enforcement access vectors and transitions */
 	avtab_t te_avtab;
 
+	/* bools indexed by (value - 1) */
+	cond_bool_datum_t **bool_val_to_struct;
+	/* type enforcement conditional access vectors and transitions */
+	avtab_t te_cond_avtab;
+	/* linked list indexing te_cond_avtab by conditional */
+	cond_list_t* cond_list;
+
 	/* role transitions */
 	role_trans_t *role_tr;
 
@@ -227,6 +256,8 @@
 
 extern int policydb_index_classes(policydb_t * p);
 
+extern int policydb_index_bools(policydb_t * p);
+
 extern int policydb_index_others(policydb_t * p);
 
 extern int constraint_expr_destroy(constraint_expr_t * expr);
@@ -242,8 +273,9 @@
 extern int policydb_read(policydb_t * p, struct policy_file * fp);
 
 #define PERM_SYMTAB_SIZE 32
+#define POLICYDB_VERSION 16
+#define POLICYDB_VERSION_COMPAT 15
 
-#define POLICYDB_VERSION 15
 #define POLICYDB_CONFIG_MLS    1
 
 #define OBJECT_R "object_r"
diff -Nru a/selinux-usr/checkpolicy/services.c b/selinux-usr/checkpolicy/services.c
--- a/selinux-usr/checkpolicy/services.c	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/services.c	Wed Jan 14 13:39:12 2004
@@ -2,7 +2,17 @@
 /*
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil> 
  */
-
+/* Updated: Frank Mayer <mayerf@tresys.com>
+ *          and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+ 
 /* FLASK */
 
 /*
@@ -14,6 +24,7 @@
 #include "sidtab.h"
 #include "services.h"
 #include "mls.h"
+#include "conditional.h"
 
 static rwlock_t policy_rwlock = RW_LOCK_UNLOCKED;
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
@@ -211,6 +222,9 @@
 		if (avdatum->specified & AVTAB_AUDITALLOW)
 			avd->auditallow = avtab_auditallow(avdatum);
 	}
+	
+	/* Check conditional av table for additional permissions */
+	cond_compute_av(&policydb.te_cond_avtab, &avkey, avd);
 
 	/*
 	 * Remove any permissions prohibited by the MLS policy.
@@ -536,6 +550,7 @@
 	struct role_trans *roletr = 0;
 	avtab_key_t avkey;
 	avtab_datum_t *avdatum;
+	avtab_ptr_t node;
 	unsigned int type_change = 0;
 	int rc = 0;
 
@@ -600,6 +615,18 @@
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avdatum = avtab_search(&policydb.te_avtab, &avkey, AVTAB_TYPE);
+
+	/* If no permanent rule, also check for enabled conditional rules */
+	if(!avdatum) {
+		node = avtab_search_node(&policydb.te_cond_avtab, &avkey, specified);
+		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
+			if (node->datum.specified & AVTAB_ENABLED) {
+				avdatum = &node->datum;
+				break;
+			}
+		}
+	}
+
 	type_change = (avdatum && (avdatum->specified & specified));
 	if (type_change) {
 		/* Use the type from the type transition/member/change rule. */
diff -Nru a/selinux-usr/checkpolicy/test/Makefile b/selinux-usr/checkpolicy/test/Makefile
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/checkpolicy/test/Makefile	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,38 @@
+#
+# Makefile for building the dispol program
+#
+PREFIX=/usr/local/selinux/
+BINDIR=$(PREFIX)/bin
+
+CFLAGS = -g -Wall -O2 -pipe
+#CFLAGS = -g -Wall -O2 -pipe
+override CFLAGS += -include global.h -I. -I.. -I../include
+
+# Set to y if MLS is enabled in the module.
+MLS=n
+
+ifeq ($(MLS),y)
+OPTIONS = -DCONFIG_SECURITY_SELINUX_MLS
+else
+OPTIONS = 
+endif
+
+OBJS = ebitmap.o queue.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o dispol.o 
+
+ifeq ($(MLS),y)
+OBJS += mls.o
+endif
+
+LIBS=-lfl
+
+all: dispol
+
+dispol: $(OBJS)
+	$(CC) -o $@ $^ $(LIBS)
+
+%.o: ../%.c 
+	$(CC) $(CFLAGS) -o $@ -c $<
+
+clean:
+	rm -f dispol *.o 
+
diff -Nru a/selinux-usr/checkpolicy/test/dispol.c b/selinux-usr/checkpolicy/test/dispol.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/checkpolicy/test/dispol.c	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,415 @@
+
+/* Authors: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+ 
+/* 
+ * displaypol.c
+ *
+ * Test program to the contents of a binary policy in text
+ * form.  This program currently only displays the
+ * avtab (including conditional avtab) rules.
+ *
+ * 	displaypol binary_pol_file
+ */
+
+#include "../policydb.h"
+#include "../avtab.h"
+#include "../services.h"
+#include "../conditional.h"
+#include <getopt.h>
+#include <assert.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+
+extern policydb_t policydb;
+extern unsigned int ss_initialized;
+
+/* hack! */
+int avc_ss_reset(__u32 seqno)
+{
+	return 0;
+}
+
+void usage(char *progname)
+{
+	printf("usage:  %s binary_pol_file\n\n", progname);
+	exit(1);
+}
+
+/* borrowed from avtab.c */
+#define HASH_BITS 15
+#define HASH_BUCKETS (1 << HASH_BITS)
+#define HASH_MASK (HASH_BUCKETS-1)
+
+/* borrowed from checkpolicy.c */
+static int find_perm(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+	unsigned int *valuep;
+	perm_datum_t *perdatum;
+
+	valuep = (unsigned int *) p;
+	perdatum = (perm_datum_t *) datum;
+
+	if (*valuep == perdatum->value)
+		return (int) key;
+
+	return 0;
+}
+
+int render_access_mask(__u32 mask, avtab_key_t *key, policydb_t *p, FILE *fp)
+{
+	unsigned int i;
+	class_datum_t *cladatum;
+	char *perm;
+	cladatum = p->class_val_to_struct[key->target_class -1];
+	fprintf(fp, "{");
+	for (i = 1; i <= sizeof(mask) * 8; i++) {
+		if (mask & (1 << (i - 1))) {
+			perm = (char *) hashtab_map(cladatum->permissions.table,
+				  find_perm, &i);
+
+			if (!perm && cladatum->comdatum) {
+				perm = (char *) hashtab_map(cladatum->comdatum->permissions.table,
+				  find_perm, &i);
+			}
+			if (perm)
+				fprintf(fp, " %s", perm);
+		}
+	}
+	fprintf(fp, " }");
+	return 0;
+}
+
+int render_type(__u32 type, policydb_t *p, FILE *fp)
+{
+	fprintf(fp, "%s", p->p_type_val_to_name[type - 1]);
+	return 0;
+}
+
+int render_key(avtab_key_t *key, policydb_t *p, FILE *fp)
+{
+	fprintf(fp, "%s %s : %s ", p->p_type_val_to_name[key->source_type - 1], 
+			p->p_type_val_to_name[key->target_type - 1],
+			p->p_class_val_to_name[key->target_class - 1]);
+	return 0;
+}
+
+/* 'what' values for this function */
+#define	RENDER_UNCONDITIONAL	0x0001	/* render all regardless of enabled state */
+#define RENDER_ENABLED		0x0002
+#define RENDER_DISABLED		0x0004
+#define RENDER_CONDITIONAL	(RENDER_ENABLED|RENDER_DISABLED)
+
+int render_av_rule(avtab_key_t *key, avtab_datum_t *datum, __u32 what, policydb_t *p, FILE *fp)
+{
+	if(!(what & RENDER_UNCONDITIONAL)) {
+		if(what != RENDER_CONDITIONAL &&
+		   (((what & RENDER_ENABLED) && !(datum->specified & AVTAB_ENABLED)) ||
+		   ((what & RENDER_DISABLED) && (datum->specified & AVTAB_ENABLED)))) {
+		   	return 0; /* doesn't match selection criteria */
+		} 
+	}
+
+	if(!(what & RENDER_UNCONDITIONAL)) {
+		if(datum->specified & AVTAB_ENABLED) 
+			fprintf(fp, "[enabled] ");
+		else if(!(datum->specified & AVTAB_ENABLED))
+			fprintf(fp, "[disabled] ");
+	} 
+
+	if( datum->specified & AVTAB_AV) {
+		if(datum->specified & AVTAB_ALLOWED) {
+			fprintf(fp, "allow ");			
+			render_key(key, p, fp);
+			render_access_mask(avtab_allowed(datum),key, p, fp);
+			fprintf(fp, ";\n");
+		}
+		if(datum->specified & AVTAB_AUDITALLOW) {
+			fprintf(fp, "auditallow ");
+			render_key(key, p, fp);
+			render_access_mask(avtab_auditallow(datum),key, p, fp);
+			fprintf(fp, ";\n");
+		}
+		if(datum->specified & AVTAB_AUDITDENY) {
+			fprintf(fp, "dontaudit ");
+			render_key(key, p, fp);
+			/* We inverse the mask for dontaudit since the mask is internally stored
+			 * as a auditdeny mask */
+			render_access_mask(~avtab_auditdeny(datum),key, p, fp);
+			fprintf(fp, ";\n");
+		}
+	}
+	else if( datum->specified & AVTAB_TYPE){
+		if(datum->specified & AVTAB_TRANSITION) {
+			fprintf(fp, "type_transition ");
+			render_key(key, p, fp);
+			render_type(avtab_transition(datum), p, fp);
+			fprintf(fp, ";\n");
+		}
+		if(datum->specified & AVTAB_MEMBER) {
+			fprintf(fp, "type_member ");
+			render_key(key, p, fp);
+			render_type(avtab_member(datum), p, fp);
+			fprintf(fp, ";\n");
+		}
+		if(datum->specified & AVTAB_CHANGE) {
+			fprintf(fp, "type_change ");
+			render_key(key, p, fp);
+			render_type(avtab_change(datum), p, fp);
+			fprintf(fp, ";\n");
+		}
+	}
+	else {
+		fprintf(fp, "     ERROR: no valid rule type specified\n");
+		return -1;
+	}
+	return 0;
+}
+
+int display_avtab(avtab_t *a, __u32 what, policydb_t *p, FILE *fp)
+{
+	int i;
+	avtab_ptr_t cur;
+
+	for (i = 0; i < AVTAB_SIZE; i++) {
+		for (cur = a->htable[i]; cur; cur = cur->next) {
+			render_av_rule(&cur->key, &cur->datum, what, p, fp);
+		}
+	}
+	fprintf(fp, "\n");
+	return 0;
+}
+
+int display_bools(policydb_t *p, FILE *fp)
+{
+	int i;
+
+	for (i = 0; i < p->p_bools.nprim; i++) {
+		fprintf(fp, "%s : %d\n", p->p_bool_val_to_name[i],
+			p->bool_val_to_struct[i]->state);
+	}
+	return 0;
+}
+
+void display_expr(policydb_t *p, cond_expr_t *exp, FILE *fp)
+{
+
+	cond_expr_t *cur;
+	for (cur = exp; cur != NULL; cur = cur->next) {
+		switch (cur->expr_type) {
+		case COND_BOOL:
+			fprintf(fp, "%s ", p->p_bool_val_to_name[cur->bool - 1]);
+			break;
+		case COND_NOT:
+			fprintf(fp, "! ");
+			break;
+		case COND_OR:
+			fprintf(fp, "|| ");
+			break;
+		case COND_AND:
+			fprintf(fp, "&& ");
+			break;
+		case COND_XOR:
+			fprintf(fp, "^ ");
+			break;
+		case COND_EQ:
+			fprintf(fp, "== ");
+			break;
+		case COND_NEQ:
+			fprintf(fp, "!= ");
+			break;
+		default:
+			fprintf(fp, "error!");
+			break;
+		}
+	}
+}
+
+int display_cond_expressions(policydb_t *p, FILE *fp)
+{
+	cond_node_t *cur;
+	cond_av_list_t *av_cur;
+	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
+		fprintf(fp, "expression: ");
+		display_expr(p, cur->expr, fp);
+		fprintf(fp, "current state: %d\n", cur->cur_state);
+		fprintf(fp, "True list:\n");
+		for (av_cur = cur->true_list; av_cur != NULL; av_cur = av_cur->next) {
+			fprintf(fp, "\t");
+			render_av_rule(&av_cur->node->key, &av_cur->node->datum,
+				       RENDER_CONDITIONAL, p, fp);
+		}
+		fprintf(fp, "False list:\n");
+		for (av_cur = cur->false_list; av_cur != NULL; av_cur = av_cur->next) {
+			fprintf(fp, "\t");
+			render_av_rule(&av_cur->node->key, &av_cur->node->datum,
+				       RENDER_CONDITIONAL, p, fp);
+		}
+	}
+	return 0;
+}
+
+int change_bool(char *name, int state, policydb_t *p, FILE *fp)
+{
+	cond_bool_datum_t *bool;
+
+	bool = hashtab_search(p->p_bools.table, name);
+	if (bool == NULL) {
+		fprintf(fp, "Could not find bool %s\n", name);
+		return -1;
+	}
+	bool->state = state;
+	evaluate_conds(p);
+	return 0;
+}
+
+int menu() {
+	printf("\nSelect a command:\n");
+	printf("1)  display unconditional AVTAB\n");
+	printf("2)  display conditional AVTAB (entirely)\n");
+	printf("3)  display conditional AVTAG (only ENABLED rules)\n");
+	printf("4)  display conditional AVTAB (only DISABLED rules)\n");
+	printf("5)  display conditional bools\n");
+	printf("6)  display conditional expressions\n");
+	printf("7)  change a boolean value\n");
+	printf("\n");
+	printf("f)  set output file\n");
+	printf("m)  display menu\n");
+	printf("q)  quit\n");
+	return 0;
+}
+
+
+int main(int argc, char **argv)
+{
+	FILE *out_fp = stdout;
+	char ans[81], OutfileName[121];
+	int fd, ret;
+	struct stat sb;
+	void *map;
+	char *name;
+	int state;
+
+
+	if(argc != 2) 
+		usage(argv[0]);
+		
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		fprintf(stderr, "Can't open '%s':  %s\n",
+			argv[1], strerror(errno));
+		exit(1);
+	}
+	if (fstat(fd, &sb) < 0) {
+		fprintf(stderr, "Can't stat '%s':  %s\n",
+			argv[1], strerror(errno));
+		exit(1);
+	}
+	map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED) {
+		fprintf(stderr, "Can't map '%s':  %s\n",
+			argv[1], strerror(errno));
+		exit(1);
+	}
+	
+	/* read the binary policy */
+	fprintf(out_fp, "Reading policy...\n");
+	ret = security_load_policy(map,sb.st_size);
+	if (ret) {
+		fprintf(stderr, "%s:  error(s) encountered while parsing configuration\n", argv[0]);
+		exit(1);
+	}
+
+	fprintf(stdout, "binary policy file loaded\n\n");
+	close(fd);
+	
+	menu();
+	for(;;) {
+		printf("\nCommand (\'m\' for menu):  ");
+		fgets(ans, sizeof(ans), stdin);	
+		switch(ans[0]) {
+			
+		case '1':
+			display_avtab(&policydb.te_avtab, RENDER_UNCONDITIONAL, &policydb, out_fp);
+			break;
+		case '2':
+			display_avtab(&policydb.te_cond_avtab, RENDER_CONDITIONAL, &policydb, out_fp);
+			break;
+		case '3':
+			display_avtab(&policydb.te_cond_avtab, RENDER_ENABLED, &policydb, out_fp);
+			break;
+		case '4':
+			display_avtab(&policydb.te_cond_avtab, RENDER_DISABLED, &policydb, out_fp);
+			break;
+		case '5':
+			display_bools(&policydb, out_fp);
+			break;
+		case '6':
+			display_cond_expressions(&policydb, out_fp);
+			break;
+		case '7':
+			printf("name? ");
+			fgets(ans, sizeof(ans), stdin);
+			ans[strlen(ans) - 1] = 0;
+			
+			name = malloc((strlen(ans) + 1) * sizeof(char));
+			if (name == NULL) {
+				fprintf(stderr, "couldn't malloc string.\n");
+				break;
+			}
+			strcpy(name, ans);
+
+
+			printf("state? ");
+			fgets(ans, sizeof(ans), stdin);
+			ans[strlen(ans) - 1] = 0;
+
+			if (atoi(ans))
+				state = 1;
+			else
+				state = 0;
+
+			change_bool(name, state, &policydb, out_fp);
+			free(name);
+			break;
+		case 'f':
+			printf("\nFilename for output (<CR> for screen output): ");
+			fgets(OutfileName, sizeof(OutfileName), stdin);	
+			OutfileName[strlen(OutfileName)-1] = '\0'; /* fix_string (remove LF) */
+			if (strlen(OutfileName) == 0) 
+				out_fp = stdout;
+			else if ((out_fp = fopen(OutfileName, "w")) == NULL) {
+				fprintf (stderr, "Cannot open output file %s\n", OutfileName);
+				out_fp = stdout;
+			}
+			if (out_fp != stdout) 
+				printf("\nOutput to file: %s\n", OutfileName);
+			break;
+		case 'q':
+			policydb_destroy(&policydb);
+			exit(0);
+			break;
+		case 'm':
+			menu();
+			break;
+		default:
+			printf("\nInvalid choice\n");
+			menu();
+			break;
+		
+		}
+	}
+}
+
+/* FLASK */
+
diff -Nru a/selinux-usr/checkpolicy/write.c b/selinux-usr/checkpolicy/write.c
--- a/selinux-usr/checkpolicy/write.c	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/checkpolicy/write.c	Wed Jan 14 13:39:12 2004
@@ -1,7 +1,21 @@
+
+/* Author : Stephen Smalley, <sds@epoch.ncsc.mil> */
+
+/* Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * 	Added conditional policy language extensions
+ *
+ * Copyright (C) 2003 - 2004 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
 #include "ebitmap.h"
 #include "avtab.h"
 #include "mls.h"
 #include "policydb.h"
+#include "conditional.h"
 
 int ebitmap_write(ebitmap_t * e, FILE * fp)
 {
@@ -37,13 +51,54 @@
 	return 0;
 }
 
+int avtab_write_item(avtab_ptr_t cur, FILE *fp)
+{
+	__u32 buf[32];
+	size_t items, items2;
+
+	items = 1;	/* item 0 is used for the item count */
+	buf[items++] = cpu_to_le32(cur->key.source_type);
+	buf[items++] = cpu_to_le32(cur->key.target_type);
+	buf[items++] = cpu_to_le32(cur->key.target_class);
+	buf[items++] = cpu_to_le32(cur->datum.specified);
+	if (!(cur->datum.specified & (AVTAB_AV | AVTAB_TYPE))) {
+		printf("security: avtab: null entry\n");
+		return -1;
+	}
+	if ((cur->datum.specified & AVTAB_AV) &&
+	    (cur->datum.specified & AVTAB_TYPE)) {
+		printf("security: avtab: entry has both access vectors and types\n");
+		return -1;
+	}
+	if (cur->datum.specified & AVTAB_AV) {
+		if (cur->datum.specified & AVTAB_ALLOWED)
+			buf[items++] = cpu_to_le32(avtab_allowed(&cur->datum));
+		if (cur->datum.specified & AVTAB_AUDITDENY)
+			buf[items++] = cpu_to_le32(avtab_auditdeny(&cur->datum));
+		if (cur->datum.specified & AVTAB_AUDITALLOW)
+			buf[items++] = cpu_to_le32(avtab_auditallow(&cur->datum));
+	} else {
+		if (cur->datum.specified & AVTAB_TRANSITION)
+			buf[items++] = cpu_to_le32(avtab_transition(&cur->datum));
+		if (cur->datum.specified & AVTAB_CHANGE)
+			buf[items++] = cpu_to_le32(avtab_change(&cur->datum));
+		if (cur->datum.specified & AVTAB_MEMBER)
+			buf[items++] = cpu_to_le32(avtab_member(&cur->datum));
+	}
+	buf[0] = cpu_to_le32(items - 1);
+	
+	items2 = fwrite(buf, sizeof(__u32), items, fp);
+	if (items != items2)
+		return -1;
+	return 0;
+}
+
 int avtab_write(avtab_t * a, FILE * fp)
 {
 	int i;
 	avtab_ptr_t cur;
-	__u32 buf[32];
 	__u32 nel;
-	size_t items, items2;
+	size_t items;
 
 	nel = cpu_to_le32(a->nel);
 	items = fwrite(&nel, sizeof(__u32), 1, fp);
@@ -52,41 +107,9 @@
 
 	for (i = 0; i < AVTAB_SIZE; i++) {
 		for (cur = a->htable[i]; cur; cur = cur->next) {
-			items = 1;	/* item 0 is used for the item count */
-			buf[items++] = cpu_to_le32(cur->key.source_type);
-			buf[items++] = cpu_to_le32(cur->key.target_type);
-			buf[items++] = cpu_to_le32(cur->key.target_class);
-			buf[items++] = cpu_to_le32(cur->datum.specified);
-			if (!(cur->datum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-				printf("security: avtab: null entry\n");
-				return -1;
-			}
-			if ((cur->datum.specified & AVTAB_AV) &&
-			    (cur->datum.specified & AVTAB_TYPE)) {
-				printf("security: avtab: entry has both access vectors and types\n");
-				return -1;
-			}
-			if (cur->datum.specified & AVTAB_AV) {
-				if (cur->datum.specified & AVTAB_ALLOWED)
-					buf[items++] = cpu_to_le32(avtab_allowed(&cur->datum));
-				if (cur->datum.specified & AVTAB_AUDITDENY)
-					buf[items++] = cpu_to_le32(avtab_auditdeny(&cur->datum));
-				if (cur->datum.specified & AVTAB_AUDITALLOW)
-					buf[items++] = cpu_to_le32(avtab_auditallow(&cur->datum));
-			} else {
-				if (cur->datum.specified & AVTAB_TRANSITION)
-					buf[items++] = cpu_to_le32(avtab_transition(&cur->datum));
-				if (cur->datum.specified & AVTAB_CHANGE)
-					buf[items++] = cpu_to_le32(avtab_change(&cur->datum));
-				if (cur->datum.specified & AVTAB_MEMBER)
-					buf[items++] = cpu_to_le32(avtab_member(&cur->datum));
-			}
-			buf[0] = cpu_to_le32(items - 1);
-
-			items2 = fwrite(buf, sizeof(__u32), items, fp);
-			if (items != items2)
-				return -1;
-		}
+			if (avtab_write_item(cur, fp))
+			    return -1;
+		}	
 	}
 
 	return 0;
@@ -285,6 +308,126 @@
 #define mls_write_trusted(p, fp) 0
 #endif
 
+
+int cond_write_bool(hashtab_key_t key, hashtab_datum_t datum, void *p)
+{
+	cond_bool_datum_t *booldatum;
+	__u32 buf[3], len;
+	int items, items2;
+	FILE *fp = p;
+
+	booldatum = (cond_bool_datum_t*)datum;
+
+	len = strlen(key);
+	items = 0;
+	buf[items++] = cpu_to_le32(booldatum->value);
+	buf[items++] = cpu_to_le32(booldatum->state);
+	buf[items++] = cpu_to_le32(len);
+	items2 = fwrite(buf, sizeof(__u32), items, fp);
+	if (items != items2)
+		return -1;
+	items = fwrite(key, 1, len, fp);
+	if (items != len)
+		return -1;
+	return 0;
+}
+
+/*
+ * cond_write_cond_av_list doesn't write out the av_list nodes.
+ * Instead it writes out the key/value pairs from the avtab. This
+ * is necessary because there is no way to uniquely identifying rules
+ * in the avtab so it is not possible to associate individual rules
+ * in the avtab with a conditional without saving them as part of
+ * the conditional. This means that the avtab with the conditional
+ * rules will not be saved but will be rebuilt on policy load.
+ */
+int cond_write_av_list(cond_av_list_t *list, FILE *fp)
+{
+	__u32 buf[4];
+	cond_av_list_t *cur_list;
+	__u32 len, items;
+
+	len = 0;
+	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
+		if (cur_list->node->parse_context)
+			len++;
+	}
+	
+	buf[0] = cpu_to_le32(len);
+	items = fwrite(buf, sizeof(__u32), 1, fp);
+	if (items != 1)
+		return -1;
+	if (items == 0)
+		return 0;
+
+	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
+		if (cur_list->node->parse_context)
+			if (avtab_write_item(cur_list->node, fp))
+				return -1;
+	}
+	return 0;
+}
+
+int cond_write_node(cond_node_t *node, FILE *fp)
+{
+	cond_expr_t *cur_expr;
+	__u32 buf[2];
+	__u32 items, items2, len;
+
+	buf[0] = cpu_to_le32(node->cur_state);
+	items = fwrite(buf, sizeof(__u32), 1, fp);
+	if (items != 1)
+		return -1;
+
+	/* expr */
+	len = 0;
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next)
+		len++;
+
+	buf[0] = cpu_to_le32(len);
+	items = fwrite(buf, sizeof(__u32), 1, fp);
+	if (items != 1)
+		return -1;
+
+	for (cur_expr = node->expr; cur_expr != NULL; cur_expr = cur_expr->next) {
+		items = 0;
+		buf[items++] = cpu_to_le32(cur_expr->expr_type);
+		buf[items++] = cpu_to_le32(cur_expr->bool);
+		items2 = fwrite(buf, sizeof(__u32), items, fp);
+		if (items2 != items)
+			return -1;
+	}
+
+	if (cond_write_av_list(node->true_list, fp) != 0)
+		return -1;
+	if (cond_write_av_list(node->false_list, fp) != 0)
+		return -1;
+	
+	return 0;
+}
+
+int cond_write_list(cond_list_t *list, void *p)
+{
+	FILE *fp = p;
+	cond_node_t *cur;
+	__u32 len, items;
+	__u32 buf[1];
+
+	len = 0;
+	for (cur = list; cur != NULL; cur = cur->next)
+		len++;
+	buf[0] = cpu_to_le32(len);
+	items = fwrite(buf, sizeof(__u32), 1, fp);
+	if (items != 1)
+		return -1;
+
+	for (cur = list; cur != NULL; cur = cur->next) {
+		if (cond_write_node(cur, p) != 0)
+			return -1;
+	}
+	return 0;
+}
+
 /*
  * Write a security context structure
  * to a policydb binary representation file.
@@ -544,7 +687,8 @@
 	class_write,
 	role_write,
 	type_write,
-	user_write
+	user_write,
+	cond_write_bool
 	mls_write_f
 };
 
@@ -554,13 +698,13 @@
  * structure to a policy database binary representation
  * file.
  */
-int policydb_write(policydb_t * p, FILE * fp)
+int policydb_write(policydb_t * p, FILE * fp, int output_version15)
 {
 	struct role_allow *ra;
 	struct role_trans *tr;
 	ocontext_t *c;
 	genfs_t *genfs;
-	int i, j;
+	int i, j, num_syms;
 	__u32 buf[32], config;
 	size_t items, items2, len, nel;
 	char *policydb_str = POLICYDB_STRING;
@@ -582,10 +726,17 @@
 
 	/* Write the version, config, and table sizes. */
 	items = 0;
-	buf[items++] = cpu_to_le32(POLICYDB_VERSION);
-	buf[items++] = cpu_to_le32(config);
-	buf[items++] = cpu_to_le32(SYM_NUM);
-	buf[items++] = cpu_to_le32(OCON_NUM);
+	if (output_version15) {
+		buf[items++] = cpu_to_le32(POLICYDB_VERSION_COMPAT);
+		buf[items++] = cpu_to_le32(config);
+		buf[items++] = cpu_to_le32(SYM_NUM - 1);
+		buf[items++] = cpu_to_le32(OCON_NUM);
+	} else {
+		buf[items++] = cpu_to_le32(POLICYDB_VERSION);
+		buf[items++] = cpu_to_le32(config);
+		buf[items++] = cpu_to_le32(SYM_NUM);
+		buf[items++] = cpu_to_le32(OCON_NUM);
+	}
 	items2 = fwrite(buf, sizeof(__u32), items, fp);
 	if (items != items2)
 		return -1;
@@ -593,7 +744,12 @@
 	if (mls_write_nlevels(p, fp))
 		return -1;
 
-	for (i = 0; i < SYM_NUM; i++) {
+	if (output_version15)
+		num_syms = SYM_NUM - 1;
+	else
+		num_syms = SYM_NUM;
+
+	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
 		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
 		items = fwrite(buf, sizeof(__u32), 2, fp);
@@ -605,6 +761,15 @@
 
 	if (avtab_write(&p->te_avtab, fp))
 		return -1;
+
+	if (output_version15) {
+		if (p->p_bools.nprim)
+			fprintf(stderr, "warning: discarding booleans and conditional rules\n");
+
+	} else {
+		if (cond_write_list(p->cond_list, fp))
+			return -1;
+	}
 
 	nel = 0;
 	for (tr = p->role_tr; tr; tr = tr->next) 
diff -Nru a/selinux-usr/libselinux/include/selinux/selinux.h b/selinux-usr/libselinux/include/selinux/selinux.h
--- a/selinux-usr/libselinux/include/selinux/selinux.h	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/libselinux/include/selinux/selinux.h	Wed Jan 14 13:39:12 2004
@@ -122,6 +122,20 @@
 /* Get the policy version number. */
 extern int security_policyvers(void);
 
+/* Get the boolean names */
+extern int security_get_boolean_names(char ***names, int *len);
+
+/* Get the pending value for the boolean */
+extern int security_get_boolean_pending(const char *name);
+
+/* Get the active value for the boolean */
+extern int security_get_boolean_active(const char *name);
+
+/* Set the pending value for the boolean */
+extern int security_set_boolean(const char *name, int value);
+
+/* Commit the pending values for the booleans */
+extern int security_commit_booleans(void);
 
 /* Common helpers */
 
diff -Nru a/selinux-usr/libselinux/src/booleans.c b/selinux-usr/libselinux/src/booleans.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/libselinux/src/booleans.c	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,206 @@
+/*
+ * Author: Karl MacMillan <kmacmillan@tresys.com>
+ *
+ * Copyright (C) 2003 Tresys Technology, LLC
+ *	This program is free software; you can redistribute it and/or modify
+ *  	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fnmatch.h>
+
+#include <selinux/selinux.h>
+
+#define SELINUX_BOOL_DIR SELINUXMNT "/booleans/"
+
+static int filename_select(const struct dirent *d)
+{
+	int len;
+
+	len = strlen(d->d_name);
+	if (len == 1 && d->d_name[0] == '.')
+		return 0;
+	if (len == 2 && d->d_name[0] == '.' &&
+	    d->d_name[1] == '.')
+		return 0;
+	return 1;
+}
+
+int security_get_boolean_names(char ***names, int *len)
+{
+	int i, rc;
+	struct dirent **namelist;
+	char **n;
+
+	assert(len);
+
+	*len = scandir(SELINUX_BOOL_DIR, &namelist, &filename_select,
+		       alphasort);
+	if (*len <= 0) {
+		return -1;
+	}
+
+	n = (char**)malloc(sizeof(char*) * *len);
+	if (!n) {
+		rc = -1;
+		goto bad;
+	}
+
+	memset(n, 0, sizeof(char*) * *len);
+	
+	for (i = 0; i < *len; i++) {
+		n[i] = (char*)malloc(sizeof(char)
+				     * (namelist[i]->d_reclen + 1));
+		if (!n[i]) {
+			rc = -1;
+			goto bad;
+		}
+		strncpy(n[i], namelist[i]->d_name, namelist[i]->d_reclen + 1);
+	}
+	rc = 0;
+	*names = n;
+out:
+	for (i = 0; i < *len; i++) {
+		free(namelist[i]);
+	}
+	free(namelist);
+	return rc;
+bad:
+	for (i = 0; i < *len; i++) {
+		if (n[i])
+			free(n[i]);
+	}
+	free(n);
+	goto out;
+}
+
+#define STRBUF_SIZE 3
+static int get_bool_value(const char *name, char **buf)
+{
+	int fd, len;
+	char *fname = NULL;
+
+	*buf = (char*)malloc(sizeof(char) * STRBUF_SIZE);
+	if (!*buf)
+		goto out;
+
+	len = strlen(name) + 128;
+	fname = (char*)malloc(sizeof(char) * len);
+	if (!fname)
+		goto out;
+	snprintf(fname, len, "%s%s", SELINUX_BOOL_DIR, name);
+
+	fd = open(fname, O_RDONLY);
+	if (fd < 0)
+		goto out;
+
+	len = read(fd, *buf, STRBUF_SIZE);
+	close(fd);
+	if (len != STRBUF_SIZE)
+		goto out;
+
+	return 0;
+out:
+	if (*buf)
+		free(*buf);
+	if (fname)
+		free(fname);
+	return -1;
+}
+
+int security_get_boolean_pending(const char *name)
+{
+	char *buf;
+	int val;
+
+	if (get_bool_value(name, &buf))
+		return -1;
+
+	if (atoi(&buf[1]))
+		val = 1;
+	else
+		val = 0;
+	free(buf);
+	return val;
+}
+
+int security_get_boolean_active(const char *name)
+{
+	char *buf;
+	int val;
+
+	if (get_bool_value(name, &buf))
+		return -1;
+
+	buf[1] = '\0';
+	if (atoi(buf))
+		val = 1;
+	else
+		val = 0;
+	free(buf);
+	return val;
+}
+
+int security_set_boolean(const char *name, int value)
+{
+	int fd, ret, len;
+	char buf[2], *fname;
+
+	len = strlen(name) + strlen(SELINUX_BOOL_DIR) + 1;
+	fname = (char*)malloc(sizeof(char) * len);
+	if (!fname)
+		return -1;
+	snprintf(fname, len, "%s%s", SELINUX_BOOL_DIR, name);
+
+	fd = open(fname, O_WRONLY);
+	if (fd < 0) {
+		ret = -1;
+		goto out;
+	}
+
+	if (value)
+		buf[0] = '1';
+	else
+		buf[0] = '0';
+	buf[1] = '\0';
+	
+	ret = write(fd, buf, 1);
+	close(fd);
+out:
+	free(fname);
+	if (ret)
+		return 0;
+	else
+		return ret;
+}
+
+int security_commit_booleans(void)
+{
+	int fd, ret;
+	char buf[2];
+
+	fd = open(SELINUXMNT "commit_pending_bools", O_WRONLY);
+	if (fd < 0)
+		return -1;
+
+	buf[0] = '1';
+	buf[1] = '\0';
+	
+	ret = write(fd, buf, 2);
+	close(fd);
+
+	if (ret)
+		return 0;
+	else
+		return ret;
+}
+
diff -Nru a/selinux-usr/libselinux/utils/change_bool.c b/selinux-usr/libselinux/utils/change_bool.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/libselinux/utils/change_bool.c	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,38 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <selinux/selinux.h>
+
+
+int main(int argc, char **argv)
+{
+	int rc, value;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage:  %s boolean value\n", argv[0]);
+		exit(1);
+	}
+
+	if (strcmp(argv[2], "1") == 0 || strcmp(argv[2], "true") == 0)
+		value = 1;
+	else
+		value = 0;
+
+	rc = security_set_boolean(argv[1], value);
+
+	if (rc) {
+		fprintf(stderr, "error setting boolean %s to value %d\n",
+			argv[1], value);
+		exit(1);
+	}
+
+	rc = security_commit_booleans();
+
+	if (rc) {
+		fprintf(stderr, "error committing booleans\n");
+		exit(1);
+	}
+
+	exit(0);
+}
diff -Nru a/selinux-usr/libselinux/utils/show_bools.c b/selinux-usr/libselinux/utils/show_bools.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/libselinux/utils/show_bools.c	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,42 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <selinux/selinux.h>
+
+
+int main(int argc, char **argv)
+{
+	int i, rc = 0, active, pending, len;
+	char **names;
+
+	rc = security_get_boolean_names(&names, &len);
+	if (rc) {
+		fprintf(stderr, "Error getting boolean names\n");
+		exit(1);
+	}
+
+	for (i = 0; i < len; i++) {
+		active = security_get_boolean_active(names[i]);
+		if (active < 0) {
+			fprintf(stderr, "Error getting active value for %s\n",
+				names[i]);
+			rc = -1;
+			goto out;
+		}
+		pending = security_get_boolean_pending(names[i]);
+		if (pending < 0) {
+			fprintf(stderr, "Error getting active value for %s\n",
+				names[i]);
+			rc = -1;
+			goto out;
+		}
+		printf("%s --> active: %d pending: %d\n", names[i],
+		       active, pending);
+	}
+
+out:
+	for (i = 0; i < len; i++)
+		free(names[i]);
+	free(names);
+	exit(rc);
+}
diff -Nru a/selinux-usr/policy/domains/program/unused/ping.te b/selinux-usr/policy/domains/program/unused/ping.te
--- a/selinux-usr/policy/domains/program/unused/ping.te	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/policy/domains/program/unused/ping.te	Wed Jan 14 13:39:12 2004
@@ -14,7 +14,18 @@
 type ping_t, domain, privlog;
 role sysadm_r types ping_t;
 role system_r types ping_t;
+role user_r types ping_t;
 type ping_exec_t, file_type, sysadmfile, exec_type;
+
+bool user_ping false;
+
+if (user_ping) {
+	domain_auto_trans(user_t, ping_exec_t, ping_t)
+	# allow access to the terminal
+	allow ping_t user_tty_device_t:chr_file rw_file_perms;
+	allow ping_t user_devpts_t:chr_file rw_file_perms;
+	ifdef(`gnome-pty-helper.te', `allow ping_t user_gph_t:fd use;')
+}
 
 # Transition into this domain when you run this program.
 domain_auto_trans(sysadm_t, ping_exec_t, ping_t)
diff -Nru a/selinux-usr/selinux-doc/README.CONDITIONAL b/selinux-usr/selinux-doc/README.CONDITIONAL
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/selinux-usr/selinux-doc/README.CONDITIONAL	Wed Jan 14 13:39:12 2004
@@ -0,0 +1,325 @@
+Readme -- SE Linux Conditional Policy Language Extensions
+---------------------------------------------------------
+
+1. Overview
+
+  The conditional policy extensions to SELinux allow runtime 
+modification of the security policy without having to load a new 
+policy. Using boolean variables and expressions, it is possible to 
+define sections of policy that are conditionally applied.
+
+
+2. Defining/Setting Booleans
+
+  Boolean variables are defined using the 'bool' statements, which 
+take a variable name and initial value as arguments. The syntax for 
+the 'bool' statement is:
+
+	bool varname true|false ;
+
+As an example, 
+
+	bool docked true ;
+
+defines a boolean variable named 'docked' and sets the initial value 
+to 'true'.
+
+  The values of boolean variables can be controlled at runtime by
+writing to files corresponding to each variable. These files are
+located in the directory /selinux/booleans. By writing the characters
+"1" (true) or "0" (false) to these files, the values are set. Some
+examples are:
+	
+	echo 1 > /selinux/booleans/docked
+	echo 0 > /selinux/booleans/audit_on
+
+After setting the values it is necessary to commit them in order to
+make them active. This is done by writing to a file.
+
+	echo 1 > /selinux/commit_pending_bools
+
+There are also two programs to help viewing and setting booleans. The
+program change_bool will change the value of a boolean and commit the
+value (as well as all other pending boolean value changes).
+
+	change_bool docked 1
+
+The program show_bools will show the values of all of the booleans in
+the policy.
+
+
+3. Conditional Expressions
+
+  Conditional expressions use an if/else structure with a "C-like" 
+syntax, and expressions may be nested. The operators which are 
+available are all logical operators. These include:
+
+	&&	(AND)
+	||	(OR)
+	!	(NOT)
+	^	(XOR)
+	==	(Equivalence)
+	!=	(NOT EQUAL)
+
+Some examples of using these expressions and operators follow:
+
+	if (docked) {
+		<policy statements>
+	}
+
+	if (docked && network_on) {
+		<policy statements>
+	}
+
+	if (docked || network_on) {
+		<policy statements>
+	}
+
+	if (!network_on) {
+		<policy statements>
+	}
+
+	if (!boolean1 && (boolean2 == boolean3)) {
+		<policy statements>
+	} else {
+		<policy statements>
+	}
+
+
+4. Restrictions / Limitations / Rules
+
+  - Stack Depth
+
+      Boolean expressions are evaluated in the kernel using RPN 
+      (Reverse polish notation). Since parentheses used in boolean 
+      expressions can control the number of operands pushed onto the 
+      stack before computation begins, it is possible to overload the 
+      RPN stack. The current limit for the stack is 10. The following 
+      expression would overload the stack:
+
+      if (boolean01 && boolean02 && (boolean03 && (boolean04 && (boolean05 &&
+	 (boolean06 && (boolean07 && (boolean08 && (boolean09 && (boolean10 &&
+	 (boolean11 && boolean12)))))))))) {
+	  allow seltest_t policy_src_t:dir search;
+ 	  allow seltest_t seltest_data_t:file { read write getattr };
+	  auditallow seltest_t policy_src_t:dir search;
+	  auditallow seltest_t seltest_data_t:file { read write getattr };
+      }
+
+
+  - Valid policy statements
+
+      Currently, only the following types of statements are allowed 
+      inside of conditional policy blocks:
+
+	allow
+	auditallow
+	dontaudit
+	type_transition
+	type_change
+
+ 
+      Note that auditdeny statements are not permitted inside
+      conditional policy blocks.  Their logic may be expressed with
+      dontaudit statements.  This decision was made because, while all
+      dontaudit statements are converted internally to auditdeny's, a
+      problem arises when multiple conditional auditdeny/dontaudit fields
+      need to be combined.  Logically, auditdeny bit fields need to be OR'd
+      together to define which permission DENYs need to be audited.
+      Dontaudit bitfields express the policy writer's desire to turn _off_
+      the auditing of certain permission DENYs, and thus need to be AND'd
+      together.
+
+  - Policy conflicts with policy
+
+      Non-conditional policy rules take preference over conditional 
+      rules.  In most cases, a conflicting conditional rule is 
+      discarded. In some cases, the policy compiler will exit with an 
+      error. The list below describes the conflicts and the results:
+
+      - A conditional type rule conflicts with a non-conditional type 
+        rule
+
+	  The conditional type rule is discarded and the compiler issues
+	a warning.
+
+      - A conditional type rule in one conditional policy block 
+	conflicts with 	a conditional type rule in a different 
+	conditional policy block.
+
+	  The previously processed rule is kept, the second is discarded.
+
+5. Labeling of selinuxfs
+
+The files under /selinux/booleans are meant to be labeled using genfs. This
+would allow the policy writer fine-grained control over the access to these
+files and the policy modifications they enable. Unfortunately, the selinuxfs
+doesn't currently support genfs. To provide some policy protection to the
+boolean files (including commit_pending_bools), writing to those files is
+limited to those domains that have the enable permission on the security
+object. Reading is not protected.
+
+Example
+-------
+
+  As an example of how to use the conditional policy extensions, we 
+will modify the policy for the ping program. In the base policy, the 
+ping program can only be executed by processes that have the sysadm_r 
+or system_r roles.
+
+  It could be necessary, under certain conditions, to allow processes 
+that have the user_r (generic user) role to also execute /bin/ping. 
+This is a situation that lends itself well to a solution implemented 
+with the conditional policy extensions.
+
+The base ping policy (with added line numbers) looks like this:
+
+-------------------------------------------------------------------------------
+
+01  type ping_t, domain, privlog;
+02  type ping_exec_t, file_type, sysadmfile, exec_type;
+03  role sysadm_r types ping_t;
+04  role system_r types ping_t;
+05
+06  # Transition into this domain when you run this program.
+07  domain_auto_trans(sysadm_t, ping_exec_t, ping_t)
+08. domain_auto_trans(initrc_t, ping_exec_t, ping_t)
+09 
+10  uses_shlib(ping_t)
+11  can_network(ping_t)
+12  general_domain_access(ping_t)
+13  allow ping_t { etc_t resolv_conf_t }:file { getattr read };
+14  allow ping_t self:unix_stream_socket create_socket_perms;
+15 
+16  # Let ping create raw ICMP packets.
+17  allow ping_t self:rawip_socket {create ioctl read write bind getopt setopt};
+18  allow ping_t any_socket_t:rawip_socket sendto;
+19 
+20  auditallow ping_t any_socket_t:rawip_socket sendto;
+21
+22  # Let ping receive ICMP replies.
+23  allow ping_t { self icmp_socket_t }:rawip_socket recvfrom;
+24 
+25  # Use capabilities.
+26  allow ping_t self:capability { net_raw setuid };
+27  
+28  # Access the terminal.
+29  allow ping_t admin_tty_type:chr_file rw_file_perms;
+30  ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')
+31  allow ping_t privfd:fd use;
+32 
+33  dontaudit ping_t fs_t:filesystem getattr;
+34 
+35  # it tries to access /var/run
+36  dontaudit ping_t var_t:dir search;
+
+-------------------------------------------------------------------------------
+
+  The first change that is necessary is to add a boolean variable that 
+will be used to control the conditional policy. We will add a 
+conditional policy statement to define a variable called 'userping' 
+with an initial value of 'false'. The statement could be placed after 
+line 5 and would look something like this:
+
+	  bool userping false;
+
+
+  The second change that needs to be made it to allow processes with 
+the user_r role to execute in the ping_t domain, which is the domain 
+where ping runs. Lines 3 and 4 handle the necessary setup for the 
+sysadm_r and system_r roles, so all that is needed is to add the 
+following line after line 4:
+
+	role user_r types ping_t;
+
+It should be noted that no features of the conditional policy 
+extensions are involved in this change since "role" statements are not 
+allowed inside of conditionals.
+
+
+  If you look at the policy, you can see that almost the only changes that 
+need to be made to allow other roles and types to execute ping concern 
+role statements and domain transition statements. The third change 
+that is necessary is to allow the user_t (generic user type/domain) to 
+transition to the ping_t domain when executing files that have the 
+ping_exec_t type. The only other minor addition is to allow ping_t to access
+the user console. In order to do this conditionally, the following 
+conditional statements could be added after line 9:
+
+	if (userping) {
+		domain_auto_trans(user_t, ping_exec_t, ping_t)
+		# allow access to the terminal
+		allow ping_t user_tty_device_t:chr_file rw_file_perms;
+		allow ping_t user_devpts_t:chr_file rw_file_perms;
+		ifdef(`gnome-pty-helper.te', `allow ping_t user_gph_t:fd use;')
+	}
+
+
+After making the necessary changes, the policy now looks like this:
+
+-------------------------------------------------------------------------------
+
+type ping_t, domain, privlog;
+type ping_exec_t, file_type, sysadmfile, exec_type;
+role sysadm_r types ping_t;
+role system_r types ping_t;
+role user_r types ping_t;
+
+bool userping false;
+
+# Transition into this domain when you run this program.
+domain_auto_trans(sysadm_t, ping_exec_t, ping_t)
+domain_auto_trans(initrc_t, ping_exec_t, ping_t)
+
+if (userping) {
+	domain_auto_trans(user_t, ping_exec_t, ping_t)
+	# allow access to the terminal
+	allow ping_t user_tty_device_t:chr_file rw_file_perms;
+	allow ping_t user_devpts_t:chr_file rw_file_perms;
+	ifdef(`gnome-pty-helper.te', `allow ping_t user_gph_t:fd use;')
+}
+
+uses_shlib(ping_t)
+can_network(ping_t)
+general_domain_access(ping_t)
+allow ping_t { etc_t resolv_conf_t }:file { getattr read };
+allow ping_t self:unix_stream_socket create_socket_perms;
+
+# Let ping create raw ICMP packets.
+allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
+allow ping_t any_socket_t:rawip_socket sendto;
+
+auditallow ping_t any_socket_t:rawip_socket sendto;
+
+# Let ping receive ICMP replies.
+allow ping_t { self icmp_socket_t }:rawip_socket recvfrom;
+
+# Use capabilities.
+allow ping_t self:capability { net_raw setuid };
+
+# Access the terminal.
+allow ping_t admin_tty_type:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')
+allow ping_t privfd:fd use;
+
+dontaudit ping_t fs_t:filesystem getattr;
+
+# it tries to access /var/run
+dontaudit ping_t var_t:dir search;
+
+-------------------------------------------------------------------------------
+
+  At this point, all that needs to be done is set the value of 'userping' to
+whatever gives the desired effect.
+
+The command
+
+    change_bool userping 1
+
+will allow normal users to execute the ping program. The command
+
+    change_bool userping 0
+
+will restore the default behavior.
+
+
diff -Nru a/selinux-usr/selinux-doc/selinux-doc.spec b/selinux-usr/selinux-doc/selinux-doc.spec
--- a/selinux-usr/selinux-doc/selinux-doc.spec	Wed Jan 14 13:39:12 2004
+++ b/selinux-usr/selinux-doc/selinux-doc.spec	Wed Jan 14 13:39:12 2004
@@ -34,7 +34,7 @@
 %install
 rm -rf ${RPM_BUILD_ROOT}
 mkdir -p ${RPM_BUILD_ROOT}/usr/share/SELinux
-install -m644 CREDITS PORTING README README.MLS ${RPM_BUILD_ROOT}/usr/share/SELinux
+install -m644 CREDITS PORTING README README.MLS README.CONDITIONAL ${RPM_BUILD_ROOT}/usr/share/SELinux
 	
 %clean
 rm -rf ${RPM_BUILD_ROOT}

--=-3Q3ILB4ZzMVKg+uHxavj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
