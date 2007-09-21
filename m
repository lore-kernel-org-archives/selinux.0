Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LDwVKr025995
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:58:31 -0400
Received: from e3.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8LDwUL2002219
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 13:58:30 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8LDwUR1010556
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:58:30 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8LDwUuS565706
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:58:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8LDwUZq005243
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:58:30 -0400
Subject: [RFC] [Patch 1/4] integrity: LIM api, hooks, and dummy provider
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
Cc: zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Content-Type: text/plain
Date: Fri, 21 Sep 2007 10:04:22 -0400
Message-Id: <1190383462.11091.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch provides an integrity framework (API and set of hooks), placement
of the integrity hooks in the appropriate places in the fs directory, and a
dummy provider for an integrity service. 

The three integrity API calls provided are:
	integrity_verify_metadata, integrity_verity_data, integrity_measure

The seven integrity hooks are:
	inode_setxattr, inode_post_setxattr, 
	inode_alloc_integrity, inode_free_integrity, inode_init_integrity,
	file_free_integrity, d_instantiate

(Details on the calls and their exact arguments are in linux/integrity.h,
included in the patch.)

Initially, the integrity_verify_metadata API is called by an LSM module 
to retrieve a requested dentry's label (xattr, such as security.selinux, 
or security.slim.level), along with the result of integrity verification 
of the label.

Based on the result of this call, the LSM module may also choose to use
integrity_verify_data to request a verification of the file's data, and
integrity_measure, to commit the file's measurement to some form of
logging/attestation service, such as a TPM.

The latter two functions are separate calls, so that the LSM module can
optimize performance by using them only as needed.  For example, if the
integrity_verify_metadata call shows that the label is not trustworthy, it is
probably not necessary to hash and measure the file, as the current LSM check
will likely be denied anyway.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---

Index: linux-2.6.23-rc6-mm1/include/linux/integrity.h
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/include/linux/integrity.h
@@ -0,0 +1,266 @@
+/*
+ * integrity.h
+ *
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#ifndef _LINUX_INTEGRITY_H
+#define _LINUX_INTEGRITY_H
+
+#include <linux/fs.h>
+
+void integrity_audit_msg(int audit_msgno, struct inode *inode,
+			const unsigned char *fname, char *op,
+			char *cause, int result);
+
+/**
+ * struct integrity_operations - main integrity structure
+ *
+ * @verify_data:
+ *	Verify the integrity of a dentry.
+ *	@dentry contains the dentry structure to be verified.
+ *	@file or contains the file structure to be verified.
+ *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
+ * 		INTEGRITY_NOLABEL
+ *	Return 0 on success or errno values
+ *
+ * @verify_metadata:
+ *	Verify the integrity of a dentry's metadata; return the value
+ * 	of the requested xattr_name and the verification result of the
+ *	dentry's metadata.
+ *	@dentry contains the dentry structure of the metadata to be verified.
+ *	@xattr_name, if not null, contains the name of the xattr
+ *		 being requested.
+ *	@xattr_value, if not null, is a pointer for the xattr value.
+ *	@xattr_val_len will be set to the length of the xattr value.
+ *	@status contains INTEGRITY_PASS, INTEGRITY_FAIL, or
+ * 		INTEGRITY_NOLABEL
+ *	Return 0 on success or errno values
+ *
+ * @measure:
+ *	Update an aggregate integrity value with the inode's measurement.
+ *	The aggregate integrity value is maintained in secure storage such
+ *	as in a TPM PCR.
+ * 	@inode to be measured.
+ *	@dentry contains the dentry structure of the inode to be measured.
+ *	@file or contains the file structure of the inode to be measured.
+ *	@filename either contains the full pathname/short file name.
+ *	@mask contains the filename permission status(i.e. read, write, append).
+ *
+ * @inode_setxattr:
+ *	Check permission before permitting an integrity extended attribute
+ * 	to be set.
+ *	@value identified by @name for @dentry.
+ *	Return 0 if permission is granted.
+ *
+ * @inode_post_setxattr:
+ *	Update inode integrity xattr after successful setxattr operation.
+ * 	identified by @name for @dentry.
+ *
+ * @inode_alloc_integrity:
+ *	Allocate and attach an integrity structure to @inode->i_integrity.  The
+ * 	i_integrity field is initialized to NULL when the inode structure is
+ * 	allocated.
+ * 	@inode contains the inode structure.
+ * 	Return 0 if operation was successful.
+ *
+ * @inode_free_integrity:
+ *	@inode contains the inode structure.
+ * 	Deallocate the inode integrity structure and set @inode->i_integrity to
+ * 	NULL.
+ *
+ * @inode_init_integrity:
+ *	Create inode integrity xattr for a new inode based on the new security
+ * 	xattr information.
+ *	@inode contains the inode structure of the newly created inode.
+ *	@dir contains the inode structure of the parent directory.
+ * 	@name contains the security xattr name suffix.
+ *	@value contains the security attribute value.
+ *	@len contains the length of the security attribute value.
+ *
+ * @file_free_integrity:
+ *	Update the integrity xattr value as necessary.
+ * 	*file contains the file structure being closed.
+ *
+ * @d_instantiate:
+ *	Initialize the integrity structure of an inode for a dentry.
+ *	@dentry to complete.
+ *	@inode to attach to this dentry.
+ */
+
+#define PASS_STR "INTEGRITY_PASS"
+#define FAIL_STR "INTEGRITY_FAIL"
+#define NOLABEL_STR "INTEGRITY_NOLABEL"
+
+struct integrity_operations {
+	int (*verify_metadata) (struct dentry *dentry, char *xattr_name,
+			char **xattr_value, int *xattr_val_len, int *status);
+	int (*verify_data) (struct dentry *dentry, struct file *file,
+				int *status);
+	void (*measure) (struct inode *inode,
+			struct dentry *dentry, struct file *file,
+			const unsigned char *filename, int mask);
+	int (*inode_setxattr) (struct dentry *dentry, char *name, void *value,
+			       size_t size, int flags);
+	void (*inode_post_setxattr) (struct dentry *dentry, char *name);
+	int (*inode_alloc_integrity) (struct inode *inode);
+	void (*inode_free_integrity) (struct inode *inode);
+	void (*inode_init_integrity) (struct inode *inode, struct inode *dir,
+				    char **name, void **value, size_t *len);
+	void (*file_free_integrity) (struct file *file);
+	void (*d_instantiate) (struct dentry *dentry, struct inode *inode);
+};
+extern int register_integrity(struct integrity_operations *ops);
+extern int unregister_integrity(struct integrity_operations *ops);
+
+/* global variables */
+extern struct integrity_operations *integrity_ops;
+enum integrity_status {
+	INTEGRITY_PASS = 0, INTEGRITY_FAIL = -1, INTEGRITY_NOLABEL = -2
+};
+
+/* inline stuff */
+#ifdef CONFIG_INTEGRITY
+static inline int integrity_verify_metadata(struct dentry *dentry,
+			char *xattr_name, char **xattr_value,
+			int *xattr_val_len, int *status)
+{
+	return integrity_ops->verify_metadata(dentry, xattr_name,
+			xattr_value, xattr_val_len, status);
+}
+
+static inline int integrity_verify_data(struct dentry *dentry,
+					struct file *file, int *status)
+{
+	return integrity_ops->verify_data(dentry, file, status);
+}
+
+static inline void integrity_measure(struct inode *inode,
+			struct dentry *dentry, struct file *file,
+			const unsigned char *filename, int mask)
+{
+	integrity_ops->measure(inode, dentry, file, filename, mask);
+}
+
+static inline int integrity_inode_setxattr(struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return 0;
+	return integrity_ops->inode_setxattr(dentry, name, value, size, flags);
+}
+
+static inline void integrity_inode_post_setxattr(struct dentry *dentry,
+						char *name)
+{
+	if (unlikely (IS_PRIVATE (dentry->d_inode)))
+		return;
+	integrity_ops->inode_post_setxattr(dentry, name);
+}
+
+static inline int integrity_inode_alloc(struct inode *inode)
+{
+	return integrity_ops->inode_alloc_integrity(inode);
+}
+
+static inline void integrity_inode_free(struct inode *inode)
+{
+	integrity_ops->inode_free_integrity(inode);
+}
+
+static inline void integrity_inode_init_integrity(struct inode *inode,
+						struct inode *dir,
+						char **name,
+						void **value,
+						size_t *len)
+{
+	if (unlikely (IS_PRIVATE (inode)))
+		return;
+	integrity_ops->inode_init_integrity(inode, dir, name, value, len);
+	return;
+}
+
+static inline void integrity_file_free(struct file *file)
+{
+	integrity_ops->file_free_integrity(file);
+}
+
+static inline void integrity_d_instantiate(struct dentry *dentry,
+						struct inode *inode)
+{
+	if (unlikely (inode && IS_PRIVATE(inode)))
+		return;
+	integrity_ops->d_instantiate(dentry, inode);
+}
+#else
+static inline int integrity_verify_metadata(struct dentry *dentry,
+			char *xattr_name, char **xattr_value,
+			int *xattr_val_len, int *status)
+{
+	status = INTEGRITY_PASS;
+	return 0;
+}
+
+static inline int integrity_verify_data(struct dentry *dentry,
+					struct file *file, int *status)
+{
+	status = INTEGRITY_PASS;
+	return 0;
+}
+
+static inline void integrity_measure(struct inode *inode,
+			struct dentry *dentry, struct file *file,
+			const unsigned char *filename, int mask)
+{
+}
+
+static inline int integrity_inode_setxattr(struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static inline void integrity_inode_post_setxattr(struct dentry *dentry,
+						char *name)
+{ }
+
+static inline int integrity_inode_alloc(struct inode *inode)
+{
+	return 0;
+}
+
+static inline void integrity_inode_free(struct inode *inode)
+{ }
+
+static inline int integrity_inode_init_integrity(struct inode *inode,
+						struct inode *dir,
+						char **name,
+						void **value,
+						size_t *len)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int integrity_file_permission(struct file *file, int mask)
+{
+	return 0;
+}
+
+static inline void integrity_file_free(struct file *file)
+{
+	return;
+}
+
+static inline void integrity_d_instantiate(struct dentry *dentry,
+						struct inode *inode)
+{
+	return;
+}
+
+#endif
+#endif
Index: linux-2.6.23-rc6-mm1/security/Kconfig
===================================================================
--- linux-2.6.23-rc6-mm1.orig/security/Kconfig
+++ linux-2.6.23-rc6-mm1/security/Kconfig
@@ -39,6 +39,14 @@ config KEYS_DEBUG_PROC_KEYS
 
 	  If you are unsure as to whether this is required, answer N.
 
+config INTEGRITY
+	bool "Enable different integrity models"
+	help
+	  This allows you to choose different integrity modules to be
+	  configured into your kernel.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
Index: linux-2.6.23-rc6-mm1/security/Makefile
===================================================================
--- linux-2.6.23-rc6-mm1.orig/security/Makefile
+++ linux-2.6.23-rc6-mm1/security/Makefile
@@ -12,6 +12,8 @@ endif
 
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
+obj-$(CONFIG_INTEGRITY)			+= integrity.o integrity_dummy.o \
+						integrity_audit.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
Index: linux-2.6.23-rc6-mm1/security/integrity.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/integrity.c
@@ -0,0 +1,46 @@
+/*
+ * integrity.c
+ *
+ * register integrity subsystem
+ *
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/integrity.h>
+
+#include "integrity_dummy.h"
+
+struct integrity_operations *integrity_ops = &dummy_integrity_ops;
+
+int register_integrity(struct integrity_operations *ops)
+{
+	if (integrity_ops != &dummy_integrity_ops)
+		return -EAGAIN;
+
+	integrity_ops = ops;
+	integrity_fixup_ops(integrity_ops);
+	return 0;
+}
+
+int unregister_integrity(struct integrity_operations *ops)
+{
+	if (ops != integrity_ops)
+		return -EINVAL;
+
+	integrity_ops = &dummy_integrity_ops;
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(register_integrity);
+EXPORT_SYMBOL_GPL(unregister_integrity);
+EXPORT_SYMBOL_GPL(integrity_ops);
+
Index: linux-2.6.23-rc6-mm1/security/integrity_dummy.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/integrity_dummy.c
@@ -0,0 +1,166 @@
+/*
+ * integrity_dummy.c
+ *
+ * Instantiate integrity subsystem
+ *
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/capability.h>
+#include <linux/integrity.h>
+#include <linux/xattr.h>
+#include "integrity_dummy.h"
+
+/*
+ *  Return the extended attribute, if requested.
+ */
+static int dummy_verify_metadata(struct dentry *dentry, char *xattr_name,
+				 char **xattr_value, int *xattr_value_len,
+				 int *status)
+{
+	char *value = NULL;
+	int size = 0;
+	int error = 0;
+
+	if (!status)
+		return -EINVAL;
+
+	/* Getting the requested extended attribute using
+	 * getxattr directly, without the extraneous VFS
+	 * processing necessary for userspace xattr requests,
+	 * but not necessary for an internal kernel request.
+	 */
+	if (xattr_name && xattr_value && xattr_value_len) {
+		if (*xattr_value_len > 0) {
+			size = *xattr_value_len;
+			value = kzalloc(size + 1, GFP_KERNEL);
+			if (!value)
+				return -ENOMEM;
+
+			error = dentry->d_inode->i_op->getxattr(dentry,
+							xattr_name,
+							value, size);
+			if (error == -ERANGE) {
+				kfree(value);
+				error = 0;
+			} else
+				goto out;
+		}
+		size = dentry->d_inode->i_op->getxattr(dentry,
+						xattr_name, NULL, 0);
+		if (size < 0) {
+			if (size == -ENODATA)
+				*status = INTEGRITY_NOLABEL;
+			return size;
+		}
+
+		value = kzalloc(size + 1, GFP_KERNEL);
+		if (!value)
+			return -ENOMEM;
+		error = dentry->d_inode->i_op->getxattr(dentry,
+					xattr_name, value, size);
+	}
+out:
+	if (xattr_value_len)
+		*xattr_value_len = size;
+	if (xattr_value)
+		*xattr_value = value;
+	if (status)
+		*status = INTEGRITY_PASS;
+	return error;
+}
+
+static int dummy_verify_data(struct dentry *dentry, struct file *file,
+			     int *status)
+{
+	if (status)
+		*status = INTEGRITY_PASS;
+	return 0;
+}
+
+static void dummy_measure(struct inode *inode,
+			  struct dentry *dentry, struct file *file,
+			  const unsigned char *filename, int mask)
+{
+	return;
+}
+
+static int dummy_inode_alloc_integrity(struct inode *inode)
+{
+	return 0;
+}
+
+static void dummy_inode_free_integrity(struct inode *inode)
+{
+	return;
+}
+
+static void dummy_inode_init_integrity(struct inode *inode, struct inode *dir,
+				       char **name, void **value, size_t *len)
+{
+	return;
+}
+
+static void dummy_file_free_integrity(struct file *file)
+{
+	return;
+}
+
+static int dummy_inode_setxattr(struct dentry *dentry, char *name, void *value,
+				size_t size, int flags)
+{
+	return 0;
+}
+
+static void dummy_inode_post_setxattr(struct dentry *dentry, char *name)
+{
+}
+
+static void dummy_d_instantiate(struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
+struct integrity_operations dummy_integrity_ops = {
+	.verify_metadata = dummy_verify_metadata,
+	.verify_data = dummy_verify_data,
+	.measure = dummy_measure,
+	.inode_setxattr = dummy_inode_setxattr,
+	.inode_post_setxattr = dummy_inode_post_setxattr,
+	.inode_alloc_integrity = dummy_inode_alloc_integrity,
+	.inode_init_integrity = dummy_inode_init_integrity,
+	.inode_free_integrity = dummy_inode_free_integrity,
+	.file_free_integrity = dummy_file_free_integrity,
+	.d_instantiate = dummy_d_instantiate
+};
+
+#define set_to_dummy_if_null(ops, function)				\
+	do {								\
+		if (!ops->function) {					\
+			ops->function = dummy_##function;		\
+			printk(KERN_INFO "Had to override the " #function \
+			" security operation with the dummy one.\n");\
+			}						\
+	} while (0)
+
+void integrity_fixup_ops(struct integrity_operations *ops)
+{
+	set_to_dummy_if_null(ops, verify_metadata);
+	set_to_dummy_if_null(ops, verify_data);
+	set_to_dummy_if_null(ops, measure);
+	set_to_dummy_if_null(ops, inode_setxattr);
+	set_to_dummy_if_null(ops, inode_post_setxattr);
+	set_to_dummy_if_null(ops, inode_alloc_integrity);
+	set_to_dummy_if_null(ops, inode_init_integrity);
+	set_to_dummy_if_null(ops, inode_free_integrity);
+	set_to_dummy_if_null(ops, file_free_integrity);
+	set_to_dummy_if_null(ops, d_instantiate);
+}
Index: linux-2.6.23-rc6-mm1/security/integrity_dummy.h
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/integrity_dummy.h
@@ -0,0 +1,13 @@
+/*
+ * integrity_dummy.h
+ *
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+extern struct integrity_operations dummy_integrity_ops;
+extern void integrity_fixup_ops(struct integrity_operations *ops);
Index: linux-2.6.23-rc6-mm1/fs/dcache.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/dcache.c
+++ linux-2.6.23-rc6-mm1/fs/dcache.c
@@ -28,6 +28,7 @@
 #include <linux/file.h>
 #include <asm/uaccess.h>
 #include <linux/security.h>
+#include <linux/integrity.h>
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
@@ -987,6 +988,7 @@ void d_instantiate(struct dentry *entry,
 	entry->d_inode = inode;
 	fsnotify_d_instantiate(entry, inode);
 	spin_unlock(&dcache_lock);
+	integrity_d_instantiate(entry, inode);
 	security_d_instantiate(entry, inode);
 }
 
@@ -1051,6 +1053,7 @@ struct dentry *d_instantiate_unique(stru
 	spin_unlock(&dcache_lock);
 
 	if (!result) {
+		integrity_d_instantiate(entry, inode);
 		security_d_instantiate(entry, inode);
 		return NULL;
 	}
@@ -1188,6 +1191,7 @@ struct dentry *d_splice_alias(struct ino
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
 			fsnotify_d_instantiate(new, inode);
 			spin_unlock(&dcache_lock);
+			integrity_d_instantiate(new, inode);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
 			d_move(new, dentry);
@@ -1198,6 +1202,7 @@ struct dentry *d_splice_alias(struct ino
 			dentry->d_inode = inode;
 			fsnotify_d_instantiate(dentry, inode);
 			spin_unlock(&dcache_lock);
+			integrity_d_instantiate(dentry, inode);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
 		}
@@ -1749,6 +1754,7 @@ found:
 	spin_unlock(&dcache_lock);
 out_nolock:
 	if (actual == dentry) {
+		integrity_d_instantiate(dentry, inode);
 		security_d_instantiate(dentry, inode);
 		return NULL;
 	}
Index: linux-2.6.23-rc6-mm1/fs/ext3/xattr_security.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/ext3/xattr_security.c
+++ linux-2.6.23-rc6-mm1/fs/ext3/xattr_security.c
@@ -9,6 +9,7 @@
 #include <linux/ext3_jbd.h>
 #include <linux/ext3_fs.h>
 #include <linux/security.h>
+#include <linux/integrity.h>
 #include "xattr.h"
 
 static size_t
@@ -57,12 +58,19 @@ ext3_init_security(handle_t *handle, str
 
 	err = security_inode_init_security(inode, dir, &name, &value, &len);
 	if (err) {
+		/* Even if creation of the security xattr fails, must
+		 * indicate this is a new inode. */
+		integrity_inode_init_integrity(inode, dir, NULL, NULL, NULL);
 		if (err == -EOPNOTSUPP)
 			return 0;
 		return err;
 	}
 	err = ext3_xattr_set_handle(handle, inode, EXT3_XATTR_INDEX_SECURITY,
 				    name, value, len, 0);
+
+	integrity_inode_init_integrity(inode, dir, &name, &value, &len);
+	err = ext3_xattr_set_handle(handle, inode, EXT3_XATTR_INDEX_SECURITY,
+				    name, value, len, 0);
 	kfree(name);
 	kfree(value);
 	return err;
Index: linux-2.6.23-rc6-mm1/fs/file_table.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/file_table.c
+++ linux-2.6.23-rc6-mm1/fs/file_table.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/integrity.h>
 #include <linux/eventpoll.h>
 #include <linux/rcupdate.h>
 #include <linux/mount.h>
@@ -167,6 +168,7 @@ void fastcall __fput(struct file *file)
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
 	security_file_free(file);
+	integrity_file_free(file);
 	if (unlikely(S_ISCHR(inode->i_mode) && inode->i_cdev != NULL))
 		cdev_put(inode->i_cdev);
 	fops_put(file->f_op);
@@ -238,6 +240,7 @@ void put_filp(struct file *file)
 {
 	if (atomic_dec_and_test(&file->f_count)) {
 		security_file_free(file);
+		integrity_file_free(file);
 		file_kill(file);
 		file_free(file);
 	}
Index: linux-2.6.23-rc6-mm1/fs/inode.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/inode.c
+++ linux-2.6.23-rc6-mm1/fs/inode.c
@@ -17,6 +17,7 @@
 #include <linux/hash.h>
 #include <linux/swap.h>
 #include <linux/security.h>
+#include <linux/integrity.h>
 #include <linux/pagemap.h>
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
@@ -151,6 +152,14 @@ static struct inode *alloc_inode(struct 
 			return NULL;
 		}
 
+		if (integrity_inode_alloc(inode)) {
+			if (inode->i_sb->s_op->destroy_inode)
+				inode->i_sb->s_op->destroy_inode(inode);
+			else
+				kmem_cache_free(inode_cachep, (inode));
+			return NULL;
+		}
+
 		mapping->a_ops = &empty_aops;
  		mapping->host = inode;
 		mapping->flags = 0;
@@ -181,6 +190,7 @@ void destroy_inode(struct inode *inode) 
 {
 	BUG_ON(inode_has_buffers(inode));
 	security_inode_free(inode);
+	integrity_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
 	else
Index: linux-2.6.23-rc6-mm1/fs/xattr.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/xattr.c
+++ linux-2.6.23-rc6-mm1/fs/xattr.c
@@ -13,6 +13,7 @@
 #include <linux/xattr.h>
 #include <linux/namei.h>
 #include <linux/security.h>
+#include <linux/integrity.h>
 #include <linux/syscalls.h>
 #include <linux/module.h>
 #include <linux/fsnotify.h>
@@ -82,11 +83,17 @@ vfs_setxattr(struct dentry *dentry, char
 	error = security_inode_setxattr(dentry, name, value, size, flags);
 	if (error)
 		goto out;
+
+	error = integrity_inode_setxattr(dentry, name, value, size, flags);
+	if (error)
+		goto out;
+
 	error = -EOPNOTSUPP;
 	if (inode->i_op->setxattr) {
 		error = inode->i_op->setxattr(dentry, name, value, size, flags);
 		if (!error) {
 			fsnotify_xattr(dentry);
+			integrity_inode_post_setxattr(dentry, name);
 			security_inode_post_setxattr(dentry, name, value,
 						     size, flags);
 		}
@@ -179,6 +186,8 @@ vfs_removexattr(struct dentry *dentry, c
 
 	mutex_lock(&inode->i_mutex);
 	error = inode->i_op->removexattr(dentry, name);
+	if (!error)
+		integrity_inode_post_setxattr(dentry, name);
 	mutex_unlock(&inode->i_mutex);
 
 	if (!error)
Index: linux-2.6.23-rc6-mm1/include/linux/fs.h
===================================================================
--- linux-2.6.23-rc6-mm1.orig/include/linux/fs.h
+++ linux-2.6.23-rc6-mm1/include/linux/fs.h
@@ -657,6 +657,9 @@ struct inode {
 #ifdef CONFIG_SECURITY
 	void			*i_security;
 #endif
+#ifdef CONFIG_INTEGRITY
+	void			*i_integrity;
+#endif
 	void			*i_private; /* fs or device private pointer */
 };
 
Index: linux-2.6.23-rc6-mm1/include/linux/audit.h
===================================================================
--- linux-2.6.23-rc6-mm1.orig/include/linux/audit.h
+++ linux-2.6.23-rc6-mm1/include/linux/audit.h
@@ -120,6 +120,11 @@
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
 #define AUDIT_ANOM_PROMISCUOUS      1700 /* Device changed promiscuous mode */
 #define AUDIT_ANOM_ABEND            1701 /* Process ended abnormally */
+#define AUDIT_INTEGRITY_DATA	    1800 /* Data integrity verification */
+#define AUDIT_INTEGRITY_METADATA    1801 /* Metadata integrity verification */
+#define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
+#define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
+#define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
@@ -409,6 +414,7 @@ extern void auditsc_get_stamp(struct aud
 extern int  audit_set_loginuid(struct task_struct *task, uid_t loginuid);
 extern uid_t audit_get_loginuid(struct audit_context *ctx);
 extern void audit_log_task_context(struct audit_buffer *ab);
+extern void audit_log_inode_context(struct audit_buffer *ab, struct inode *inode);
 extern int __audit_ipc_obj(struct kern_ipc_perm *ipcp);
 extern int __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t gid, mode_t mode);
 extern int audit_bprm(struct linux_binprm *bprm);
@@ -488,6 +494,7 @@ extern int audit_signals;
 #define auditsc_get_stamp(c,t,s) do { BUG(); } while (0)
 #define audit_get_loginuid(c) ({ -1; })
 #define audit_log_task_context(b) do { ; } while (0)
+#define audit_log_inode_context(b,a) do { ; } while (0)
 #define audit_ipc_obj(i) ({ 0; })
 #define audit_ipc_set_perm(q,u,g,m) ({ 0; })
 #define audit_bprm(p) ({ 0; })
Index: linux-2.6.23-rc6-mm1/security/integrity_audit.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/integrity_audit.c
@@ -0,0 +1,81 @@
+/*
+ * integrity_audit.c
+ *
+ * Audit calls for the integrity subsystem
+ *
+ * Copyright (C) 2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/audit.h>
+#include <linux/fs.h>
+
+void integrity_audit_msg(int audit_msgno, struct inode *inode,
+			const unsigned char *fname, char *op,
+			char *cause, int result);
+
+#ifdef CONFIG_INTEGRITY_AUDIT
+static int integrity_audit = 1;
+
+static int __init integrity_audit_setup(char *str)
+{
+	char *op;
+
+	integrity_audit = simple_strtol(str, NULL, 0);
+	op = integrity_audit ? "integrity_audit_enabled" :
+				"integrity_audit_not_enabled";
+	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL, NULL, op, 0);
+	return 1;
+}
+
+__setup("integrity_audit=", integrity_audit_setup);
+#else
+static int integrity_audit = 1;
+#endif
+
+void integrity_audit_msg(int audit_msgno, struct inode *inode,
+			const unsigned char *fname, char *op,
+			char *cause, int result)
+{
+	struct audit_buffer *ab;
+
+	if (!integrity_audit && result == 1)
+		return;
+
+	ab = audit_log_start(current->audit_context,
+				GFP_ATOMIC, audit_msgno);
+	audit_log_format(ab, "integrity: pid=%d uid=%u auid=%u",
+			current->pid, current->uid,
+			audit_get_loginuid(current->audit_context));
+	audit_log_task_context(ab);
+	switch (audit_msgno) {
+	case AUDIT_INTEGRITY_DATA:
+	case AUDIT_INTEGRITY_METADATA:
+	case AUDIT_INTEGRITY_PCR:
+		audit_log_format(ab, " op=%s cause=%s", op, cause);
+		break;
+	case AUDIT_INTEGRITY_HASH:
+		audit_log_format(ab, " op=%s hash=%s", op, cause);
+		break;
+	case AUDIT_INTEGRITY_STATUS:
+	default:
+		audit_log_format(ab, " op=%s", op);
+	}
+	audit_log_format(ab, " comm=");
+	audit_log_untrustedstring(ab, current->comm);
+	if (fname) {
+		audit_log_format(ab, " name=");
+		audit_log_untrustedstring(ab, fname);
+	}
+	if (inode) {
+		audit_log_format(ab, " dev=%s ino=%lu",
+				 inode->i_sb->s_id, inode->i_ino);
+		audit_log_inode_context(ab, inode);
+	}
+	audit_log_format(ab, " res=%d", result);
+	audit_log_end(ab);
+}
Index: linux-2.6.23-rc6-mm1/kernel/auditsc.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/kernel/auditsc.c
+++ linux-2.6.23-rc6-mm1/kernel/auditsc.c
@@ -862,6 +862,35 @@ static inline void audit_free_context(st
 		printk(KERN_ERR "audit: freed %d contexts\n", count);
 }
 
+void audit_log_inode_context(struct audit_buffer *ab, struct inode *inode)
+{
+	char *ctx = NULL;
+	unsigned len;
+	int error;
+	u32 sid;
+
+	selinux_get_inode_sid(inode, &sid);
+	if (!sid)
+		return;
+
+	error = selinux_sid_to_string(sid, &ctx, &len);
+	if (error) {
+		if (error != -EINVAL)
+			goto error_path;
+		return;
+	}
+
+	audit_log_format(ab, " obj=%s", ctx);
+	kfree(ctx);
+	return;
+
+error_path:
+	audit_panic("error in audit_log_inode_context");
+	return;
+}
+
+EXPORT_SYMBOL(audit_log_inode_context);
+
 void audit_log_task_context(struct audit_buffer *ab)
 {
 	char *ctx = NULL;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
