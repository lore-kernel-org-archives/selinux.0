Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LDxVsH026097
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:59:31 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8LDxSo4005213
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 13:59:29 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8LDx8eA028009
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 09:59:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l8LDx8x6427266
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 07:59:08 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l8LDx8Ni013864
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 07:59:08 -0600
Subject: [RFC] [Patch 2/4] integrity: IMA as an integrity service provider
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: selinux@tycho.nsa.gov
Cc: zohar@us.ibm.com, safford@watson.ibm.com, sailer@us.ibm.com
Content-Type: text/plain
Date: Fri, 21 Sep 2007 10:04:59 -0400
Message-Id: <1190383499.11091.29.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a re-release of Integrity Measurement Architecture(IMA) as 
a standalone method of providing support for the Linunx Integrity
Module(LIM) API integrity_measure() call.  When integrity_measure()
is called, IMA submits the measurement (hash) of the file to the TPM
chip, for inclusion in one of the chip's Platform Configuration
Registers (PCR).  IMA also keeps a list of all file names and hashes
that have been submitted to the TPM, which can be viewed through
securityfs. By separately requesting a TPM_Quote from the chip, an
application can get a chip-signed value of the PCR, which, along with
the list of measurements from IMA, can be used to attest, or prove to
a third party, the validity of the hash list.  (Refer to 
http://trousers.sourceforge.net package for TPM userspace utilities.)

IMA can be included or excluded in the kernel configuration.  If
included in the kernel and the IMA_BOOTPARAM is selected, IMA can 
also be enabled/disabled on the kernel command line with 'ima='.

The mtime is currently not being updated promptly for mmapped files. 
There are currently two proposals to resolve this problem.  When it
is fixed, there will be a performance improvement.

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
---

Index: linux-2.6.23-rc6-mm1/security/Kconfig
===================================================================
--- linux-2.6.23-rc6-mm1.orig/security/Kconfig
+++ linux-2.6.23-rc6-mm1/security/Kconfig
@@ -47,6 +47,17 @@ config INTEGRITY
 
 	  If you are unsure how to answer this question, answer N.
 
+config INTEGRITY_AUDIT
+	bool "Integrity audit boot parameter"
+	depends on INTEGRITY
+	default y
+	help
+	  This option adds a kernel parameter 'integrity_audit', which
+	  allows integrity auditing to be disabled at boot.  If this
+	  option is selected, integrity auditing can be disabled with
+	  'integrity_audit=0' on the kernel command line.
+source security/ima/Kconfig
+
 config SECURITY
 	bool "Enable different security models"
 	depends on SYSFS
Index: linux-2.6.23-rc6-mm1/include/linux/magic.h
===================================================================
--- linux-2.6.23-rc6-mm1.orig/include/linux/magic.h
+++ linux-2.6.23-rc6-mm1/include/linux/magic.h
@@ -6,6 +6,7 @@
 #define AFS_SUPER_MAGIC                0x5346414F
 #define AUTOFS_SUPER_MAGIC	0x0187
 #define CODA_SUPER_MAGIC	0x73757245
+#define DEBUGFS_MAGIC		0x64626720
 #define EFS_SUPER_MAGIC		0x414A53
 #define EXT2_SUPER_MAGIC	0xEF53
 #define EXT3_SUPER_MAGIC	0xEF53
@@ -39,6 +40,7 @@
 #define UNIONFS_SUPER_MAGIC 0xf15f083d
 
 #define SMB_SUPER_MAGIC		0x517B
+#define SYSFS_MAGIC		0x62656572
 #define USBDEVICE_SUPER_MAGIC	0x9fa2
 #define CONTAINER_SUPER_MAGIC	0x27e0eb
 
Index: linux-2.6.23-rc6-mm1/security/ima/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/Kconfig
@@ -0,0 +1,62 @@
+#
+# IBM Integrity Measurement Architecture
+#
+
+config IMA_MEASURE
+	bool "TCG run-time Integrity Measurement Architecture(IMA)"
+	depends on INTEGRITY
+	depends on ACPI
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_MD5
+	select CRYPTO_SHA1
+	select TCG_TPM
+	help
+	  IMA maintains a list of hash values of executables and
+	  other sensitive system files loaded into the run-time
+	  of this system. If your system has a TPM chip, then IMA
+	  also maintains an aggregate integrity value over this
+	  list inside the TPM hardware.  These measurements and
+	  the aggregate (signed inside the TPM) can be retrieved
+	  and presented to remote parties to establish system
+	  properties. If unsure, say N.
+
+config IMA_BOOTPARAM
+	bool "IMA boot parameter"
+	depends on IMA_MEASURE
+	default n
+	help
+	  This option adds a kernel parameter 'ima', which allows IMA
+	  to be disabled at boot.  If this option is selected, IMA
+	  functionality can be disabled with ima=0 on the kernel
+	  command line.  The purpose of this option is to allow a single
+	  kernel image to be distributed with IMA built in, but not
+	  necessarily enabled.
+
+	  If you are unsure how to answer this question, answer N.
+
+config IMA_BOOTPARAM_VALUE
+	int "IMA boot parameter default value"
+	depends on IMA_BOOTPARAM
+	range 0 1
+	default 0
+	help
+	  This option sets the default value for the kernel parameter
+	  'ima=', which allows IMA to be disabled at boot.  If this
+	  option is set to 0 (zero), the IMA kernel parameter will
+	  default to 0, disabling IMA at bootup.  If this option is
+	  set to 1 (one), the IMA kernel parameter will default to 1,
+	  enabling IMA at bootup.
+
+	  If you are unsure how to answer this question, answer 0.
+
+config IMA_MEASURE_PCR_IDX
+	int "PCR for Aggregate (8<= Index <= 14)"
+	depends on IMA_MEASURE
+	range 8 14
+	default 10
+	help
+	  IMA_MEASURE_PCR_IDX determines the TPM PCR register index
+	  that IMA uses to maintain the integrity aggregate of the
+	  measurement list.  If unsure, use the default 10.
+
Index: linux-2.6.23-rc6-mm1/security/ima/Makefile
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/Makefile
@@ -0,0 +1,6 @@
+
+obj-$(CONFIG_IMA_MEASURE) += ima.o
+
+ifeq ($(CONFIG_IMA_MEASURE), y)
+ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o
+endif
Index: linux-2.6.23-rc6-mm1/security/ima/ima.h
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima.h
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ *
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * IBM Integrity Measurement Architecture
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima.h
+ *		internal ima definitions
+ */
+
+#ifndef __LINUX_IMA_H
+#define __LINUX_IMA_H
+
+#include <linux/types.h>
+#include <linux/crypto.h>
+#include <linux/security.h>
+#include <linux/hash.h>
+#include <linux/tpm.h>
+
+#define ima_printk(level, format, arg...)		\
+	printk(level "ima (%s): " format, __func__, ## arg)
+
+#define ima_error(format, arg...)	\
+	ima_printk(KERN_ERR, format, ## arg)
+
+#define ima_info(format, arg...)	\
+	ima_printk(KERN_INFO, format, ## arg)
+
+/* digest size for IMA, fits SHA1 or MD5 */
+#define IMA_DIGEST_SIZE		20
+#define IMA_EVENT_NAME_LEN_MAX	255
+
+#define IMA_HASH_BITS 9
+#define IMA_MEASURE_HTABLE_SIZE (1 << IMA_HASH_BITS)
+#define IMA_HASH_KEY(digest) (hash_long(\
+	(unsigned long)(*digest), IMA_HASH_BITS));
+
+/* set during initialization */
+extern int ima_used_chip;
+extern char *ima_hash;
+
+struct ima_measure_entry {
+	u32 measure_flags;
+	u8 digest[IMA_DIGEST_SIZE];	/* sha1 or md5 measurement hash */
+	char file_name[IMA_EVENT_NAME_LEN_MAX + 1];	/* name + \0 */
+};
+
+struct ima_queue_entry {
+	struct hlist_node hnext;	/* place in hash collision list */
+	struct list_head later;		/* place in ima_measurements list */
+	struct ima_measure_entry *entry;
+};
+
+extern struct list_head ima_measurements;	/* list of all measurements */
+
+/* declarations */
+int ima_fs_init(void);
+void ima_fs_cleanup(void);
+void ima_create_htable(void);
+int ima_add_measure_entry(struct ima_measure_entry *entry, int violation);
+struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest);
+int ima_init(void);
+void ima_cleanup(void);
+int ima_calc_hash(struct dentry *dentry, struct file *file, char *digest);
+void ima_add_violation(struct inode *inode, const unsigned char *fname,
+			char *op, char *cause);
+
+/*
+ * used to protect h_table and sha_table
+ */
+extern spinlock_t ima_queue_lock;
+
+struct ima_h_table {
+	atomic_t len;		/* number of stored measurements in the list */
+	atomic_t violations;
+	unsigned int max_htable_size;
+	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
+	atomic_t queue_len[IMA_MEASURE_HTABLE_SIZE];
+};
+extern struct ima_h_table ima_htable;
+
+/* TPM "Glue" definitions */
+
+#define IMA_TPM ((((u32)TPM_ANY_TYPE)<<16) | (u32)TPM_ANY_NUM)
+static inline void ima_extend(const u8 *hash)
+{
+	if (!ima_used_chip)
+		return;
+
+	if (tpm_pcr_extend(IMA_TPM, CONFIG_IMA_MEASURE_PCR_IDX, hash) != 0)
+		ima_error("Error Communicating to TPM chip\n");
+}
+
+static inline void ima_pcrread(int idx, u8 *pcr, int pcr_size)
+{
+	if (!ima_used_chip)
+		return;
+
+	if (tpm_pcr_read(IMA_TPM, idx, pcr, pcr_size) != 0)
+		ima_error("Error Communicating to TPM chip\n");
+}
+#endif
Index: linux-2.6.23-rc6-mm1/security/ima/ima_crypto.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima_crypto.c
@@ -0,0 +1,115 @@
+/*
+ * ima_crypto.c
+ *
+ * Calculate a file's hash.
+ *
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ * Author: Mimi Zohar <zohar@us.ibm.com>
+ * 	   Kylene Hall <kjhall@us.ibm.com>
+ *
+ *      This program is free software; you can redistribute it and/or modify
+ *      it under the terms of the GNU General Public License as published by
+ *      the Free Software Foundation, version 2 of the License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/crypto.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include "ima.h"
+
+static int update_file_hash(struct dentry *dentry, struct file *f,
+			    struct hash_desc *desc)
+{
+	struct file *file = f;
+	struct scatterlist sg[1];
+	loff_t i_size;
+	int error = 0;
+
+	char *rbuf = NULL;
+	int rbuf_len = 0;
+	int offset = 0;
+
+	if (!file) {
+		struct dentry *de = dget(dentry);
+		if (!de)
+			goto out;
+
+		file = dentry_open(de, NULL, O_RDONLY);
+		if (IS_ERR(file)) {
+			printk(KERN_INFO "%s: dentry_open failed\n",
+			       __FUNCTION__);
+			error = -ENOENT;
+			dput(de);
+			file = NULL;
+			goto out;
+		}
+	}
+
+	if (!file || !file->f_dentry || !file->f_dentry->d_inode) {
+		printk(KERN_INFO "%s: missing file\n", __FUNCTION__);
+		goto out;
+	}
+
+	rbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!rbuf) {
+		error = -ENOMEM;
+		goto out;
+	}
+	i_size = i_size_read(file->f_dentry->d_inode);
+	while (offset < i_size) {
+		rbuf_len = kernel_read(file, offset, rbuf, PAGE_SIZE);
+		if (rbuf_len <= 0)
+			break;
+		offset += rbuf_len;
+		sg[0].page = virt_to_page(rbuf);
+		sg[0].offset = ((long)rbuf & ~PAGE_MASK);
+		sg[0].length = rbuf_len;
+
+		error = crypto_hash_update(desc, sg, rbuf_len);
+		if (error)
+			break;
+	}
+
+	kfree(rbuf);
+out:
+	if (file && !f)
+		fput(file);	/* clean up dentry_open() */
+	return error;
+}
+
+/*
+ * Calculate the MD5/SHA1 digest
+ */
+int ima_calc_hash(struct dentry *dentry, struct file *file, char *digest)
+{
+	struct crypto_hash *tfm;
+	struct hash_desc desc;
+	int error = 0;
+
+	if (!dentry && !file)
+		return -ENOENT;
+
+	tfm = crypto_alloc_hash(ima_hash, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		printk(KERN_INFO "%s: failed to load %s transform: %ld\n",
+		       __FUNCTION__, ima_hash, PTR_ERR(tfm));
+		return -ENOSYS;
+	}
+	desc.tfm = tfm;
+	desc.flags = 0;
+	error = crypto_hash_init(&desc);
+	if (error)
+		goto out;
+
+	error = update_file_hash(dentry, file, &desc);
+	if (!error)
+		error = crypto_hash_final(&desc, digest);
+
+out:
+	crypto_free_hash(tfm);
+	return error;
+}
Index: linux-2.6.23-rc6-mm1/security/ima/ima_fs.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima_fs.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ *
+ * Kylene Hall <kjhall@us.ibm.com>
+ * Reiner Sailer <sailer@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_fs.c
+ *		implemenents security file system for reporting
+ *              current measurement list and IMA statistics
+ */
+#include <linux/module.h>
+#include <linux/seq_file.h>
+
+#include "ima.h"
+
+#define TMPBUFLEN 12
+static ssize_t ima_show_htable_value(char __user *buf, size_t count,
+				     loff_t *ppos, atomic_t *val)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, TMPBUFLEN, "%i\n", atomic_read(val));
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_show_htable_violations(struct file *filp,
+					  char __user *buf,
+					  size_t count, loff_t *ppos)
+{
+	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
+}
+
+static struct file_operations ima_htable_violations_ops = {
+	.read = ima_show_htable_violations
+};
+
+static ssize_t ima_show_measurements_count(struct file *filp,
+					   char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
+
+}
+
+static struct file_operations ima_measurements_count_ops = {
+	.read = ima_show_measurements_count
+};
+
+/* returns pointer to hlist_node */
+static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+{
+	struct list_head *lpos;
+	loff_t l = *pos;
+	/* we need a lock since pos could point beyond last element */
+	rcu_read_lock();
+	list_for_each_rcu(lpos, &ima_measurements) {
+		if (!l--) {
+			rcu_read_unlock();
+			return lpos;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+
+static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	/* lock protects when reading beyond last element
+	 * against concurrent list-extension */
+	struct list_head *lpos = (struct list_head *)v;
+
+	rcu_read_lock();
+	lpos = rcu_dereference(lpos->next);
+	rcu_read_unlock();
+	(*pos)++;
+
+	return (lpos == &ima_measurements) ? NULL : lpos;
+}
+
+static void ima_measurements_stop(struct seq_file *m, void *v)
+{
+}
+
+/* print format:
+ *       32bit-le=pcr#
+ *       32bit-le=type# << flag
+ *       char[20]=digest
+ *       32bit-le=eventDataSize n
+ *       eventdata[n] = filename
+ *
+ *       flags bits:
+ *         31-16 application flags,
+ *         15-3  kernel flags,
+ *          2-0  hook
+ */
+static int ima_measurements_show(struct seq_file *m, void *v)
+{
+	/* the list never shrinks, so we don't need a lock here */
+	struct list_head *lpos = v;
+	struct ima_queue_entry *qe;
+	struct ima_measure_entry *e;
+	int filename_len;
+	int i;
+	u32 pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	char data[4];
+
+	/* get entry */
+	qe = list_entry(lpos, struct ima_queue_entry, later);
+	e = qe->entry;
+	if (e == NULL)
+		return -1;
+
+	/*
+	 * 1st: PCRIndex
+	 * PCR used is always the same (config option) in
+	 * little-endian format
+	 */
+	memcpy(data, &pcr, 4);
+	for (i = 0; i < 4; i++)
+		seq_putc(m, data[i]);
+
+	/* 2nd: eventtype (=flags) */
+	memcpy(data, &e->measure_flags, 4);
+	for (i = 0; i < 4; i++)
+		seq_putc(m, data[i]);
+
+	/* 3rd: digest */
+	for (i = 0; i < 20; i++)
+		seq_putc(m, e->digest[i]);
+
+	/* 4th: eventDataSize */
+	filename_len = strlen(e->file_name);
+	if (filename_len > IMA_EVENT_NAME_LEN_MAX)
+		filename_len = IMA_EVENT_NAME_LEN_MAX;
+
+	memcpy(data, &filename_len, 4);
+	for (i = 0; i < 4; i++)
+		seq_putc(m, data[i]);
+
+	/* 5th:  filename  */
+
+	for (i = 0; i < filename_len; i++)
+		seq_putc(m, e->file_name[i]);
+
+	return 0;
+}
+
+static struct seq_operations ima_measurments_seqops = {
+	.start = ima_measurements_start,
+	.next = ima_measurements_next,
+	.stop = ima_measurements_stop,
+	.show = ima_measurements_show
+};
+
+static int ima_measurements_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ima_measurments_seqops);
+}
+
+static struct file_operations ima_measurements_ops = {
+	.open = ima_measurements_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+/* print in ascii */
+static int ima_ascii_measurements_show(struct seq_file *m, void *v)
+{
+	/* the list never shrinks, so we don't need a lock here */
+	struct list_head *lpos = v;
+	struct ima_queue_entry *qe;
+	struct ima_measure_entry *e;
+	int i;
+
+	/* get entry */
+	qe = list_entry(lpos, struct ima_queue_entry, later);
+	e = qe->entry;
+	if (e == NULL)
+		return -1;
+
+	/* 1st: PCR used (config option) */
+	seq_printf(m, "%2d ", CONFIG_IMA_MEASURE_PCR_IDX);
+
+	/* 2nd: SHA1 */
+	for (i = 0; i < 20; i++)
+		seq_printf(m, "%02x", e->digest[i]);
+
+	/* 3th:  filename <= max + \'0' delimiter */
+	seq_printf(m, " %s\n", e->file_name);
+
+	return 0;
+}
+
+static struct seq_operations ima_ascii_measurements_seqops = {
+	.start = ima_measurements_start,
+	.next = ima_measurements_next,
+	.stop = ima_measurements_stop,
+	.show = ima_ascii_measurements_show
+};
+
+static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &ima_ascii_measurements_seqops);
+}
+
+static struct file_operations ima_ascii_measurements_ops = {
+	.open = ima_ascii_measurements_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static struct dentry *ima_dir;
+static struct dentry *binary_runtime_measurements;
+static struct dentry *ascii_runtime_measurements;
+static struct dentry *runtime_measurements_count;
+static struct dentry *violations;
+
+int ima_fs_init(void)
+{
+	ima_dir = securityfs_create_dir("ima", NULL);
+	if (!ima_dir || IS_ERR(ima_dir))
+		return -1;
+
+	binary_runtime_measurements =
+	    securityfs_create_file("binary_runtime_measurements",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_measurements_ops);
+	if (!binary_runtime_measurements || IS_ERR(binary_runtime_measurements))
+		goto out;
+
+	ascii_runtime_measurements =
+	    securityfs_create_file("ascii_runtime_measurements",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_ascii_measurements_ops);
+	if (!ascii_runtime_measurements || IS_ERR(ascii_runtime_measurements))
+		goto out;
+
+	runtime_measurements_count =
+	    securityfs_create_file("runtime_measurements_count",
+				   S_IRUSR | S_IRGRP, ima_dir, NULL,
+				   &ima_measurements_count_ops);
+	if (!runtime_measurements_count || IS_ERR(runtime_measurements_count))
+		goto out;
+
+	violations =
+	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
+				   ima_dir, NULL, &ima_htable_violations_ops);
+	if (!violations || IS_ERR(violations))
+		goto out;
+	return 0;
+
+out:
+	securityfs_remove(runtime_measurements_count);
+	securityfs_remove(ascii_runtime_measurements);
+	securityfs_remove(binary_runtime_measurements);
+	securityfs_remove(ima_dir);
+	return -1;
+}
+
+void __exit ima_fs_cleanup(void)
+{
+	securityfs_remove(violations);
+	securityfs_remove(runtime_measurements_count);
+	securityfs_remove(ascii_runtime_measurements);
+	securityfs_remove(binary_runtime_measurements);
+	securityfs_remove(ima_dir);
+}
Index: linux-2.6.23-rc6-mm1/security/ima/ima_init.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima_init.c
@@ -0,0 +1,103 @@
+/*
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ *
+ * Reiner Sailer      <sailer@watson.ibm.com>
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_init.c
+ *             initialization and cleanup functions
+ */
+#include <linux/module.h>
+#include <linux/scatterlist.h>
+#include "ima.h"
+
+/* name for boot aggregate entry */
+static char *boot_aggregate_name = "boot_aggregate";
+static const char version[] = "v7.6 02/27/2007";
+
+int ima_used_chip;
+
+static void ima_add_boot_aggregate(void)
+{
+	/* cumulative sha1 over tpm registers 0-7 */
+	struct ima_measure_entry *entry;
+	size_t count;
+	int err;
+
+	/* create new entry for boot aggregate */
+	entry = kzalloc(sizeof(struct ima_measure_entry), GFP_ATOMIC);
+	if (entry == NULL) {
+		ima_add_violation(NULL, boot_aggregate_name,
+				"add_measure", "ENOMEM");
+		return;
+	}
+	count = strlen(boot_aggregate_name);
+	if (count > IMA_EVENT_NAME_LEN_MAX)
+		count = IMA_EVENT_NAME_LEN_MAX;
+	memcpy(entry->file_name, boot_aggregate_name, count);
+	entry->file_name[count] = '\0';
+	if (ima_used_chip) {
+		int i;
+		u8 pcr_i[20];
+		struct hash_desc desc;
+		struct crypto_hash *tfm;
+		struct scatterlist sg;
+
+		tfm = crypto_alloc_hash("sha1", 0, CRYPTO_ALG_ASYNC);
+		if (!tfm || IS_ERR(tfm)) {
+			kfree(entry);
+			ima_error("error initializing digest.\n");
+			return;
+		}
+		desc.tfm = tfm;
+		desc.flags = 0;
+		crypto_hash_init(&desc);
+
+		for (i = 0; i < 8; i++) {
+			ima_pcrread(i, pcr_i, sizeof(pcr_i));
+			/* now accumulate with current aggregate */
+			sg_init_one(&sg, (u8 *) pcr_i, 20);
+			crypto_hash_update(&desc, &sg, 20);
+		}
+		crypto_hash_final(&desc, entry->digest);
+		crypto_free_hash(tfm);
+	} else
+		memset(entry->digest, 0xff, 20);
+
+	/* now add measurement; if TPM bypassed, we have a ff..ff entry */
+	err = ima_add_measure_entry(entry, 0);
+	if (err < 0) {
+		kfree(entry);
+		ima_add_violation(NULL, boot_aggregate_name,
+				"add_measure", " ");
+	}
+}
+
+int ima_init(void)
+{
+	int rc;
+
+	ima_used_chip = 0;
+	rc = tpm_pcr_read(IMA_TPM, 0, NULL, 0);
+	if (rc == 0)
+		ima_used_chip = 1;
+
+	if (!ima_used_chip)
+		ima_info("No TPM chip found(rc = %d), activating TPM-bypass!\n",
+			 rc);
+
+	ima_create_htable();	/* for measurements */
+	ima_add_boot_aggregate(); /* boot aggregate must be very first entry */
+
+	return ima_fs_init();
+}
+
+void __exit ima_cleanup(void)
+{
+	ima_fs_cleanup();
+}
Index: linux-2.6.23-rc6-mm1/security/ima/ima_main.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima_main.c
@@ -0,0 +1,511 @@
+/*
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ *
+ * Authors:
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Serge Hallyn <serue@us.ibm.com>
+ * Kylene Hall <kylene@us.ibm.com>
+ * Mimi Zohar <zohar@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_main.c
+ *             implements file measurements and their storage
+ */
+#include <linux/module.h>
+#include <linux/integrity.h>
+#include <linux/magic.h>
+#include <linux/writeback.h>
+#include <linux/audit.h>
+
+#include "ima.h"
+
+#define SHA1_DIGEST_SIZE 	20	/* SHA1 is 160-bits */
+
+struct ima_iint_cache {
+	struct timespec mtime;
+	int measured;
+	struct mutex mutex;
+};
+
+#ifdef CONFIG_IMA_BOOTPARAM
+static int ima_enabled = CONFIG_IMA_BOOTPARAM_VALUE;
+
+static int __init ima_enabled_setup(char *str)
+{
+	char *op;
+
+	ima_enabled = simple_strtol(str, NULL, 0);
+	op = ima_enabled ? "ima_enabled" : "ima_not_enabled";
+	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL, NULL, op, 0);
+	return 1;
+}
+
+__setup("ima=", ima_enabled_setup);
+#else
+static int ima_enabled = 1;
+integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL, NULL, "ima_enabled", 0);
+#endif
+
+char *ima_hash = "sha1";
+static int __init hash_setup(char *str)
+{
+	char *op = "setup";
+	char *hash = "sha1";
+
+	if (strncmp(str, "md5", 3) == 0) {
+		op = "setup";
+		hash = "md5";
+		ima_hash = str;
+	} else if (strncmp(str, "sha1", 4) != 0) {
+		op = "hash_setup";
+		hash = "invalid_hash_type";
+	}
+	integrity_audit_msg(AUDIT_INTEGRITY_HASH, NULL, NULL, op, hash, 0);
+	return 1;
+}
+
+__setup("ima_hash=", hash_setup);
+
+
+/*
+ * ima_add_measure - collect and protect measurements
+ * @name:ascii file name associated with the measurement hash
+ * @hash_len:length of hash value in bytes (16 for MD5, 20 for SHA1)
+ * @hash:actual hash value pre-calculated
+ *
+ * Description:ima_add_measure creates a new measurement entry out of @hash
+ *		and @name and adds this entry to an ordered list of
+ *		measurements entries maintained inside the kernel. If
+ *		@hash_len is less than 20 then the remaining digest bytes
+ *		will be zero. It also updates the aggregate integrity value
+ *		(maintained inside the configured TPM PCR) over the hashes
+ *		of the current list of measurement entries.
+ *
+ *		Applications retrieve the current kernel-held measurement
+ *		list through the securityfs entries in
+ *		/sys/kernel/security/ima. The signed aggregate TPM PCR
+ *		(called quote) can be retrieved using a TPM user space
+ *		library and is used to validate the measurement list.
+ */
+static int ima_add_measure(struct inode *inode, const unsigned char *name,
+				int hash_len, char *hash, int violation)
+{
+	struct ima_measure_entry *entry;
+	u8 digest[IMA_DIGEST_SIZE];
+	int err = 0, count;
+	struct ima_queue_entry *qe;
+	char *op = "add_measure";
+	char *cause = " ";
+	int result;
+
+	memset(digest, 0, IMA_DIGEST_SIZE);
+	if (!violation) {
+		if (hash_len > IMA_DIGEST_SIZE) {
+			op = "add_measure";
+			cause = "long_digest";
+			hash_len = IMA_DIGEST_SIZE;
+		}
+
+		if (!memcmp(digest, hash, IMA_DIGEST_SIZE)) {
+			op = "add_measure";
+			cause = "null_hash";
+		}
+
+		memcpy(digest, hash, hash_len);
+
+		/* hash exists already? */
+		qe = ima_lookup_digest_entry(digest);
+		if (qe) {
+			op = "add_measure";
+			cause = "hash_exists";
+			result = 1;
+			goto out;
+		}
+	}
+
+	/* create new entry and add to measurement list */
+	entry = kzalloc(sizeof(struct ima_measure_entry), GFP_ATOMIC);
+	if (!entry) {
+		op = "add_measure";
+		cause = "ENOMEM";
+		result=0;
+		goto out;
+	}
+
+	entry->measure_flags = 0;
+	if (!name) {
+		op = "add_measure";
+		cause = "null_name";
+		count = 1;
+	} else {
+		count = strlen(name);
+		if (count > IMA_EVENT_NAME_LEN_MAX)
+			count = IMA_EVENT_NAME_LEN_MAX;
+		memcpy(entry->file_name, name, count);
+	}
+	entry->file_name[count] = '\0';
+	memcpy(entry->digest, digest, IMA_DIGEST_SIZE);
+
+	err = ima_add_measure_entry(entry, violation);
+	if (err < 0) {
+		kfree(entry);
+		result = (!EEXIST) ? 0 : 1;
+	} else
+		result = 1;
+out:
+	if (result == 0)
+		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
+			name, op, cause, result);
+	return(result);
+}
+
+/* general violation function called by the measurement code */
+void ima_add_violation(struct inode *inode, const unsigned char *fname,
+			char *op, char *cause)
+{
+	int result;
+
+	/* can overflow, only indicator */
+	atomic_inc(&ima_htable.violations);
+
+	/*
+	 * Violations are flagged in the measurement list
+	 * with zero hash values.  By extending the PCR
+	 * with 0xFF's instead of with zeroes, the PCR
+	 * value is invalidated.
+	 */
+	result = ima_add_measure(inode, fname, 0, NULL, 1);
+
+	integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode,
+				fname, op, cause, result);
+}
+
+/*
+ * Quick sanity check to make sure that only regular files opened for
+ * read-only or execute are measured.
+ */
+static int skip_measurement(struct inode *inode, int mask)
+{
+	/* skip pseudo/virtual devices */
+	if ((inode->i_sb->s_magic == PROC_SUPER_MAGIC)
+	    || (inode->i_sb->s_magic == SYSFS_MAGIC)
+	    || (inode->i_sb->s_magic == DEBUGFS_MAGIC)
+	    || S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		return 1;	/* can't measure */
+
+	if (special_file(inode->i_mode) || S_ISLNK(inode->i_mode))
+		return 1;	/* don't measure */
+
+	if (S_ISREG(inode->i_mode))
+		return 0;	/* measure */
+	return 1;		/* don't measure */
+}
+
+static char *get_fname(struct dentry *dentry, struct vfsmount *mnt, char **buf)
+{
+	char *fname = NULL;
+	char *path = NULL;
+
+	path = (char *)__get_free_page(GFP_KERNEL);
+	if (path) {
+		fname = d_path(dentry, mnt, path, PAGE_SIZE);
+		*buf = path;
+	}
+
+	if (!fname)		/* no choice, use short name */
+		fname = (!dentry->d_name.name) ?
+		    (char *)dentry->d_iname : (char *)dentry->d_name.name;
+	return fname;
+}
+
+static void free_fname(char *path)
+{
+	if (path)
+		free_page((unsigned long)path);
+}
+
+static void setup_ptrs(struct inode **p_inode, struct dentry **p_dentry,
+			struct file **p_file)
+{
+	struct inode *inode = *p_inode;
+	struct dentry *dentry = *p_dentry;
+	struct file *file = *p_file;
+	int rc = 0;
+
+	if (file && file->f_dentry && file->f_dentry->d_inode) {
+		if (!inode)
+			inode = file->f_dentry->d_inode;
+		if (!dentry)
+			dentry = file->f_dentry;
+	} else if (dentry && dentry->d_inode) {
+		if (!inode)
+			inode = dentry->d_inode;
+	} else {
+		dentry = d_find_alias(inode);
+		if (!dentry) {
+			/* Unlikely, but could have been
+			   removed from dcache */
+			printk(KERN_INFO "%s: null dentry \n",
+				__FUNCTION__);
+			rc = -1;
+			goto out;
+		}
+		inode = dentry->d_inode;
+	}
+
+	if (!inode) {
+		rc = -1;
+		printk(KERN_INFO "%s: null inode\n", __FUNCTION__);
+	}
+out:
+	*p_inode = inode;
+	*p_dentry = dentry;
+	*p_file = file;
+	return;
+}
+
+/*
+ * The calling routine is responsible for measuring appropriate files.
+ *
+ * Can be called with an inode, dentry or a file.
+ * Attempt to use the open file descriptor, if available, otherwise
+ * need to open the file using dentry_open(), in order to calculate
+ * the hash.
+ */
+static void ima_measure(struct inode *inode, struct dentry *dentry,
+			struct file *file,
+			const unsigned char *filename, int mask)
+{
+	struct ima_iint_cache *iint;
+
+	if (!ima_enabled)
+		return;
+
+	if (!inode && !dentry && (!file || !file->f_dentry))
+		return; /* Nothing to measure */
+
+	setup_ptrs(&inode, &dentry, &file);
+	if (!inode || !dentry)
+		return;
+
+	/* Invalidate PCR, if file already open for read */
+	if ((mask == MAY_WRITE) || (mask == MAY_APPEND)) {
+		if (atomic_read(&(dentry->d_count)) - 1 >
+		    atomic_read(&(inode->i_writecount)))
+			ima_add_violation(inode, filename ? filename
+					  : dentry->d_name.name,
+					  "invalid_pcr", "ToMToU");
+		return;
+	}
+
+	if (skip_measurement(inode, mask))
+		return;
+
+	/* Invalidate PCR, if file already open for write */
+	if (mask == MAY_READ) {
+		if (atomic_read(&(inode->i_writecount)) > 0)
+			ima_add_violation(inode, filename ? filename
+					  : dentry->d_name.name,
+					  "invalid_pcr", "open_writers");
+	}
+
+	iint = inode->i_integrity;
+	mutex_lock(&iint->mutex);
+	if (!iint->measured) {
+		char hash[SHA1_DIGEST_SIZE];
+		int rc;
+
+		memset(hash, 0, SHA1_DIGEST_SIZE);
+		rc = ima_calc_hash(dentry, file, hash);
+		if (!rc) {
+			char *path = NULL;
+			int result;
+
+			if (!filename && file)
+				filename = get_fname(file->f_dentry,
+						     file->f_path.mnt, &path);
+			else if (!filename && dentry)
+				filename = dentry->d_name.name;
+			result = ima_add_measure(inode, filename,
+						SHA1_DIGEST_SIZE, hash, 0);
+			if (result)
+				iint->measured = 1;
+			free_fname(path);
+		}
+	}
+	mutex_unlock(&iint->mutex);
+	return;
+}
+
+/*
+ * When files are opened/closed in quick succession, the mtime
+ * might not be granular enough, resulting in the mtime remaining
+ * unchanged.
+ *
+ * Use to prevent changes from not being detected.
+ */
+static inline int timespec_recent(struct timespec *a)
+{
+	return CURRENT_TIME.tv_sec - a->tv_sec <= 1 ? 1 : 0;
+}
+
+static inline void timespec_set(struct timespec *to, struct timespec *from)
+{
+	to->tv_sec = from->tv_sec;
+	to->tv_nsec = from->tv_nsec;
+}
+
+/*
+ * Called on close
+ *  - If a file changes, mark it as not having been measured.
+ */
+static void ima_file_free(struct file *file)
+{
+	struct inode *inode = NULL;
+	struct ima_iint_cache *iint;
+
+	if (!file->f_dentry)	/* can be NULL */
+		return;
+
+	inode = file->f_dentry->d_inode;
+	if (S_ISDIR(inode->i_mode))
+		return;
+	if ((file->f_mode & FMODE_WRITE) &&
+	    (atomic_read(&inode->i_writecount) == 1)) {
+		iint = inode->i_integrity;
+		mutex_lock(&iint->mutex);
+		/* The mtime is currently not being updated promptly
+		 * for mapped files. Instead of flagging all files
+		 * opened for write to be re-measured, when the mtime
+		 * is fixed, for performance improvement, uncomment
+		 * the following lines.
+
+		if ((!timespec_equal(&iint->mtime, &inode->i_mtime))
+		    || timespec_recent(&iint->mtime))
+		      iint->measured = 0;
+		 */
+		iint->measured = 0;
+		mutex_unlock(&iint->mutex);
+	}
+}
+
+/*
+ * Indicate a new file
+ */
+static void ima_inode_init(struct inode *inode, struct inode *dir,
+			   char **name, void **value, size_t *len)
+{
+	struct ima_iint_cache *iint = inode->i_integrity;
+
+	mutex_lock(&iint->mutex);
+	iint->mtime.tv_sec = 0;
+	mutex_unlock(&iint->mutex);
+	return;
+}
+
+static struct ima_iint_cache *ima_alloc_integrity(void)
+{
+	struct ima_iint_cache *iint;
+
+	iint = kzalloc(sizeof(struct ima_iint_cache), GFP_KERNEL);
+	if (!iint)
+		return NULL;
+
+	mutex_init(&iint->mutex);
+	return iint;
+}
+
+static int ima_inode_alloc_integrity(struct inode *inode)
+{
+	struct ima_iint_cache *iint;
+
+	iint = ima_alloc_integrity();
+	if (!iint)
+		return -ENOMEM;
+
+	inode->i_integrity = iint;
+	timespec_set(&iint->mtime, &inode->i_mtime);
+	return 0;
+}
+
+static void ima_inode_free_integrity(struct inode *inode)
+{
+	struct ima_iint_cache *iint = inode->i_integrity;
+
+	if (iint) {
+		inode->i_integrity = NULL;
+		kfree(iint);
+	}
+}
+
+/*
+ * For all inodes allocate inode->i_integrity(iint), before the integrity
+ * subsystem is enabled.
+ */
+static void ima_fixup_inodes(void)
+{
+	struct super_block *sb;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		struct inode *inode;
+
+		spin_unlock(&sb_lock);
+
+		spin_lock(&inode_lock);
+		list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+			spin_unlock(&inode_lock);
+
+			spin_lock(&inode->i_lock);
+			if (!inode->i_integrity)
+				ima_inode_alloc_integrity(inode);
+			spin_unlock(&inode->i_lock);
+
+			spin_lock(&inode_lock);
+		}
+		spin_unlock(&inode_lock);
+
+		spin_lock(&sb_lock);
+	}
+	spin_unlock(&sb_lock);
+}
+
+static struct integrity_operations ima_integrity_ops = {
+	.measure = ima_measure,
+	.inode_init_integrity = ima_inode_init,
+	.inode_alloc_integrity = ima_inode_alloc_integrity,
+	.inode_free_integrity = ima_inode_free_integrity,
+	.file_free_integrity = ima_file_free
+};
+
+static struct crypto_hash *tfm_hash;	/* preload crypto alg */
+static int __init init_ima(void)
+{
+	int error;
+	tfm_hash = crypto_alloc_hash(ima_hash, 0, CRYPTO_ALG_ASYNC);
+
+	error = ima_init();
+	if (error)
+		goto out;
+	ima_fixup_inodes();
+	error = register_integrity(&ima_integrity_ops);
+out:
+	return error;
+}
+
+static void __exit cleanup_ima(void)
+{
+	unregister_integrity(&ima_integrity_ops);
+	ima_cleanup();
+	crypto_free_hash(tfm_hash);
+}
+
+late_initcall(init_ima);
+module_exit(cleanup_ima);
+
+MODULE_DESCRIPTION("Integrity Measurement Architecture");
+MODULE_LICENSE("GPL");
Index: linux-2.6.23-rc6-mm1/security/ima/ima_queue.c
===================================================================
--- /dev/null
+++ linux-2.6.23-rc6-mm1/security/ima/ima_queue.c
@@ -0,0 +1,124 @@
+/*
+ * Copyright (C) 2005,2006,2007 IBM Corporation
+ *
+ * Serge Hallyn <serue@us.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_queue.c
+ *             implements queues that store IMA measurements and
+ *             maintains aggregate over the stored measurements
+ *             in the pre-configured TPM PCR (if available)
+ *             The measurement list is append-only. No entry is
+ *             ever removed or changed during the boot-cycle.
+ */
+#include <linux/module.h>
+
+#include "ima.h"
+
+struct list_head ima_measurements;	/* list of all measurements */
+struct ima_h_table ima_htable;	/* key: inode (before secure-hashing a file) */
+
+/* mutex protects atomicity of extending measurement list
+ * and extending the TPM PCR aggregate. Since tpm_extend can take
+ * long (and the tpm driver uses a mutex), we can't use the spinlock.
+ */
+static DEFINE_MUTEX(ima_extend_list_mutex);
+
+void ima_create_htable(void)
+{
+	int i;
+
+	INIT_LIST_HEAD(&ima_measurements);
+	atomic_set(&ima_htable.len, 0);
+	atomic_set(&ima_htable.violations, 0);
+	ima_htable.max_htable_size = IMA_MEASURE_HTABLE_SIZE;
+
+	for (i = 0; i < ima_htable.max_htable_size; i++) {
+		INIT_HLIST_HEAD(&ima_htable.queue[i]);
+		atomic_set(&ima_htable.queue_len[i], 0);
+	}
+
+	mutex_init(&ima_extend_list_mutex);
+}
+
+struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value)
+{
+	struct ima_queue_entry *qe, *ret = NULL;
+	unsigned int key;
+	struct hlist_node *pos;
+
+	key = IMA_HASH_KEY(digest_value);
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(qe, pos, &ima_htable.queue[key], hnext) {
+		if (memcmp(qe->entry->digest, digest_value, 20) == 0) {
+			ret = qe;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
+/* Called with mutex held */
+static int ima_add_digest_entry(struct ima_measure_entry *entry)
+{
+	struct ima_queue_entry *qe;
+	unsigned int key;
+
+	key = IMA_HASH_KEY(entry->digest);
+	qe = kmalloc(sizeof(struct ima_queue_entry), GFP_ATOMIC);
+	if (qe == NULL) {
+		ima_error("OUT OF MEMORY ERROR creating queue entry.\n");
+		return -ENOMEM;
+	}
+	qe->entry = entry;
+
+	hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
+	atomic_inc(&ima_htable.queue_len[key]);
+	return 0;
+}
+
+int ima_add_measure_entry(struct ima_measure_entry *entry, int violation)
+{
+	struct ima_queue_entry *qe;
+	int error = 0;
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (!violation) {
+		if (ima_lookup_digest_entry(entry->digest)) {
+			error = -EEXIST;
+			goto out;
+		}
+	}
+	qe = kmalloc(sizeof(struct ima_queue_entry), GFP_ATOMIC);
+	if (qe == NULL) {
+		ima_error("OUT OF MEMORY in %s.\n", __func__);
+		error = -ENOMEM;
+		goto out;
+	}
+	qe->entry = entry;
+
+	INIT_LIST_HEAD(&qe->later);
+	list_add_tail_rcu(&qe->later, &ima_measurements);
+
+	atomic_inc(&ima_htable.len);
+	if (ima_add_digest_entry(entry)) {
+		error = -ENOMEM;
+		goto out;
+	}
+	if (violation) { /* Replace 0x00 with 0xFF */
+		u8 digest[IMA_DIGEST_SIZE];
+
+		memset(digest, 0xff, sizeof digest);
+		ima_extend(digest);
+	} else
+		ima_extend(entry->digest);
+out:
+	mutex_unlock(&ima_extend_list_mutex);
+	return error;
+}
Index: linux-2.6.23-rc6-mm1/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.23-rc6-mm1.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.23-rc6-mm1/Documentation/kernel-parameters.txt
@@ -42,6 +42,7 @@ parameter is applicable:
 	FB	The frame buffer device is enabled.
 	HW	Appropriate hardware is enabled.
 	IA-64	IA-64 architecture is enabled.
+	IMA	Integrity measurement architecture is enabled.
 	IOSCHED	More than one I/O scheduler is enabled.
 	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	ISAPNP	ISA PnP code is enabled.
@@ -767,6 +768,17 @@ and is between 256 and 4096 characters. 
 	ihash_entries=	[KNL]
 			Set number of hash buckets for inode cache.
 
+	ima=		[IMA] Disable or enable IMA at boot time.
+			Format: { "0" | "1" }
+			See security/ima/Kconfig help text.
+			0 -- disable.
+			1 -- enable.
+			Default value is set via kernel config option.
+
+	ima_hash=	[IMA] runtime ability to define hash crypto alg.
+			Format: { "MD5" | "SHA1" }
+			Default is "SHA1".
+
 	in2000=		[HW,SCSI]
 			See header of drivers/scsi/in2000.c.
 
Index: linux-2.6.23-rc6-mm1/fs/debugfs/inode.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/debugfs/inode.c
+++ linux-2.6.23-rc6-mm1/fs/debugfs/inode.c
@@ -26,8 +26,7 @@
 #include <linux/debugfs.h>
 #include <linux/fsnotify.h>
 #include <linux/string.h>
-
-#define DEBUGFS_MAGIC	0x64626720
+#include <linux/magic.h>
 
 /* declared over in file.c */
 extern struct file_operations debugfs_file_operations;
Index: linux-2.6.23-rc6-mm1/fs/sysfs/mount.c
===================================================================
--- linux-2.6.23-rc6-mm1.orig/fs/sysfs/mount.c
+++ linux-2.6.23-rc6-mm1/fs/sysfs/mount.c
@@ -6,14 +6,12 @@
 
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/magic.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 
 #include "sysfs.h"
 
-/* Random magic number */
-#define SYSFS_MAGIC 0x62656572
-
 struct vfsmount *sysfs_mount;
 struct super_block * sysfs_sb = NULL;
 struct kmem_cache *sysfs_dir_cachep;
Index: linux-2.6.23-rc6-mm1/security/Makefile
===================================================================
--- linux-2.6.23-rc6-mm1.orig/security/Makefile
+++ linux-2.6.23-rc6-mm1/security/Makefile
@@ -14,6 +14,7 @@ endif
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o inode.o
 obj-$(CONFIG_INTEGRITY)			+= integrity.o integrity_dummy.o \
 						integrity_audit.o
+obj-$(CONFIG_IMA_MEASURE)		+= ima/
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
