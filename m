Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA9LOlLq025009
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 16:24:47 -0500
Received: from palrel12.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA9LOjax018103
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2007 21:24:46 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v6 07/13] SELinux: Add a capabilities bitmap to SELinux
	policy version 22
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Fri, 09 Nov 2007 16:24:27 -0500
Message-ID: <20071109212427.31738.73798.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
References: <20071109205331.31738.75266.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a new policy capabilities bitmap to SELinux policy version 22.  This bitmap
will enable the security server to query the policy to determine which features
it supports.
---

 security/selinux/Kconfig            |    2 -
 security/selinux/include/security.h |   15 ++++++
 security/selinux/selinuxfs.c        |   89 +++++++++++++++++++++++++++++++++--
 security/selinux/ss/policydb.c      |   18 +++++++
 security/selinux/ss/policydb.h      |    2 +
 security/selinux/ss/services.c      |   67 ++++++++++++++++++++++++++
 6 files changed, 185 insertions(+), 8 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index b32a459..2b517d6 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -145,7 +145,7 @@ config SECURITY_SELINUX_POLICYDB_VERSION_MAX
 config SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 	int "NSA SELinux maximum supported policy format version value"
 	depends on SECURITY_SELINUX_POLICYDB_VERSION_MAX
-	range 15 21
+	range 15 22
 	default 19
 	help
 	  This option sets the value for the maximum policy format version
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 39337af..4d3c0d3 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -25,13 +25,14 @@
 #define POLICYDB_VERSION_MLS		19
 #define POLICYDB_VERSION_AVTAB		20
 #define POLICYDB_VERSION_RANGETRANS	21
+#define POLICYDB_VERSION_POLCAP		22
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
 #ifdef CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX
 #define POLICYDB_VERSION_MAX	CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX_VALUE
 #else
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
 #endif
 
 struct netlbl_lsm_secattr;
@@ -39,8 +40,19 @@ struct netlbl_lsm_secattr;
 extern int selinux_enabled;
 extern int selinux_mls_enabled;
 
+/* Policy capabilities */
+enum {
+	POLICYDB_CAPABILITY_NETPEER,
+	__POLICYDB_CAPABILITY_MAX
+};
+#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+
+extern int selinux_policycap_netpeer;
+
 int security_load_policy(void * data, size_t len);
 
+int security_policycap_supported(unsigned int req_cap);
+
 #define SEL_VEC_MAX 32
 struct av_decision {
 	u32 allowed;
@@ -92,6 +104,7 @@ int security_get_classes(char ***classes, int *nclasses);
 int security_get_permissions(char *class, char ***perms, int *nperms);
 int security_get_reject_unknown(void);
 int security_get_allow_unknown(void);
+int security_get_policycaps(int *len, int **values);
 
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index f5f3e6d..cf583cc 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -2,6 +2,11 @@
  *
  * 	Added conditional policy language extensions
  *
+ *  Updated: Hewlett-Packard <paul.moore@hp.com>
+ *
+ *      Added support for the policy capability bitmap
+ *
+ * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
@@ -35,6 +40,11 @@
 #include "objsec.h"
 #include "conditional.h"
 
+/* Policy capability filenames */
+static char *policycap_names[] = {
+	"network_peer_controls"
+};
+
 unsigned int selinux_checkreqprot = CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE;
 
 #ifdef CONFIG_SECURITY_SELINUX_ENABLE_SECMARK_DEFAULT
@@ -71,6 +81,9 @@ static int *bool_pending_values = NULL;
 static struct dentry *class_dir = NULL;
 static unsigned long last_class_ino;
 
+/* global data for policy capabilities */
+static struct dentry *policycap_dir = NULL;
+
 extern void selnl_notify_setenforce(int val);
 
 /* Check whether a task is allowed to use a security operation. */
@@ -110,10 +123,11 @@ enum sel_inos {
 
 static unsigned long sel_last_ino = SEL_INO_NEXT - 1;
 
-#define SEL_INITCON_INO_OFFSET 	0x01000000
-#define SEL_BOOL_INO_OFFSET	0x02000000
-#define SEL_CLASS_INO_OFFSET	0x04000000
-#define SEL_INO_MASK		0x00ffffff
+#define SEL_INITCON_INO_OFFSET		0x01000000
+#define SEL_BOOL_INO_OFFSET		0x02000000
+#define SEL_CLASS_INO_OFFSET		0x04000000
+#define SEL_POLICYCAP_INO_OFFSET	0x08000000
+#define SEL_INO_MASK			0x00ffffff
 
 #define TMPBUFLEN	12
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
@@ -262,6 +276,7 @@ static const struct file_operations sel_policyvers_ops = {
 /* declaration for sel_write_load */
 static int sel_make_bools(void);
 static int sel_make_classes(void);
+static int sel_make_policycap(void);
 
 /* declaration for sel_make_class_dirs */
 static int sel_make_dir(struct inode *dir, struct dentry *dentry,
@@ -322,6 +337,12 @@ static ssize_t sel_write_load(struct file * file, const char __user * buf,
 	}
 
 	ret = sel_make_classes();
+	if (ret) {
+		length = ret;
+		goto out1;
+	}
+
+	ret = sel_make_policycap();
 	if (ret)
 		length = ret;
 	else
@@ -1408,6 +1429,24 @@ static const struct file_operations sel_perm_ops = {
 	.read		= sel_read_perm,
 };
 
+static ssize_t sel_read_policycap(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	int value;
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+	unsigned long i_ino = file->f_path.dentry->d_inode->i_ino;
+
+	value = security_policycap_supported(i_ino & SEL_INO_MASK);
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", value);
+
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static const struct file_operations sel_policycap_ops = {
+	.read		= sel_read_policycap,
+};
+
 static int sel_make_perm_files(char *objclass, int classvalue,
 				struct dentry *dir)
 {
@@ -1554,6 +1593,36 @@ out:
 	return rc;
 }
 
+static int sel_make_policycap(void)
+{
+	unsigned int iter;
+	struct dentry *dentry = NULL;
+	struct inode *inode = NULL;
+
+	sel_remove_entries(policycap_dir);
+
+	for (iter = 0; iter <= POLICYDB_CAPABILITY_MAX; iter++) {
+		if (iter < ARRAY_SIZE(policycap_names))
+			dentry = d_alloc_name(policycap_dir,
+					      policycap_names[iter]);
+		else
+			dentry = d_alloc_name(policycap_dir, "unknown");
+
+		if (dentry == NULL)
+			return -ENOMEM;
+
+		inode = sel_make_inode(policycap_dir->d_sb, S_IFREG | S_IRUGO);
+		if (inode == NULL)
+			return -ENOMEM;
+
+		inode->i_fop = &sel_policycap_ops;
+		inode->i_ino = iter | SEL_POLICYCAP_INO_OFFSET;
+		d_add(dentry, inode);
+	}
+
+	return 0;
+}
+
 static int sel_make_dir(struct inode *dir, struct dentry *dentry,
 			unsigned long *ino)
 {
@@ -1682,6 +1751,18 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 
 	class_dir = dentry;
 
+	dentry = d_alloc_name(sb->s_root, "policy_capabilities");
+	if (!dentry) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = sel_make_dir(root_inode, dentry, &sel_last_ino);
+	if (ret)
+		goto err;
+
+	policycap_dir = dentry;
+
 out:
 	return ret;
 err:
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 539828b..14b6107 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -13,6 +13,11 @@
  *
  * 	Added conditional policy language extensions
  *
+ * Updated: Hewlett-Packard <paul.moore@hp.com>
+ *
+ *      Added support for the policy capability bitmap
+ *
+ * Copyright (C) 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
@@ -102,6 +107,11 @@ static struct policydb_compat_info policydb_compat[] = {
 		.sym_num        = SYM_NUM,
 		.ocon_num       = OCON_NUM,
 	},
+	{
+		.version	= POLICYDB_VERSION_POLCAP,
+		.sym_num	= SYM_NUM,
+		.ocon_num	= OCON_NUM,
+	}
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -183,6 +193,8 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out_free_symtab;
 
+	ebitmap_init(&p->policycaps);
+
 out:
 	return rc;
 
@@ -673,8 +685,8 @@ void policydb_destroy(struct policydb *p)
 			ebitmap_destroy(&p->type_attr_map[i]);
 	}
 	kfree(p->type_attr_map);
-
 	kfree(p->undefined_perms);
+	ebitmap_destroy(&p->policycaps);
 
 	return;
 }
@@ -1532,6 +1544,10 @@ int policydb_read(struct policydb *p, void *fp)
 	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
 	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
 
+	if (p->policyvers >= POLICYDB_VERSION_POLCAP &&
+	    ebitmap_read(&p->policycaps, fp) != 0)
+		goto bad;
+
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "security:  unable to find policy compat info "
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 844d310..98af085 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -241,6 +241,8 @@ struct policydb {
 	/* type -> attribute reverse mapping */
 	struct ebitmap *type_attr_map;
 
+	struct ebitmap policycaps;
+
 	unsigned int policyvers;
 
 	unsigned int reject_unknown : 1;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 88fcd57..19a60d6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -16,12 +16,13 @@
  * Updated: Hewlett-Packard <paul.moore@hp.com>
  *
  *      Added support for NetLabel
+ *      Added support for the policy capability bitmap
  *
  * Updated: Chad Sellers <csellers@tresys.com>
  *
  *  Added validation of kernel classes and permissions
  *
- * Copyright (C) 2006 Hewlett-Packard Development Company, L.P.
+ * Copyright (C) 2006 - 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
  * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
@@ -59,6 +60,8 @@
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
 
+int selinux_policycap_netpeer;
+
 /*
  * This is declared in avc.c
  */
@@ -1299,6 +1302,12 @@ bad:
 	goto out;
 }
 
+static void security_load_policycaps(void)
+{
+	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
+						  POLICYDB_CAPABILITY_NETPEER);
+}
+
 extern void selinux_complete_init(void);
 static int security_preserve_bools(struct policydb *p);
 
@@ -1346,6 +1355,7 @@ int security_load_policy(void *data, size_t len)
 			avtab_cache_destroy();
 			return -EINVAL;
 		}
+		security_load_policycaps();
 		policydb_loaded_version = policydb.policyvers;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
@@ -1404,6 +1414,7 @@ int security_load_policy(void *data, size_t len)
 	POLICY_WRLOCK;
 	memcpy(&policydb, &newpolicydb, sizeof policydb);
 	sidtab_set(&sidtab, &newsidtab);
+	security_load_policycaps();
 	seqno = ++latest_granting;
 	policydb_loaded_version = policydb.policyvers;
 	POLICY_WRUNLOCK;
@@ -2151,6 +2162,60 @@ int security_get_allow_unknown(void)
 	return policydb.allow_unknown;
 }
 
+/**
+ * security_get_policycaps - Query the loaded policy for its capabilities
+ * @len: the number of capability bits
+ * @values: the capability bit array
+ *
+ * Description:
+ * Get an array of the policy capabilities in @values where each entry in
+ * @values is either true (1) or false (0) depending the policy's support of
+ * that feature.  The policy capabilities are defined by the
+ * POLICYDB_CAPABILITY_* enums.  The size of the array is stored in @len and it
+ * is up to the caller to free the array in @values.  Returns zero on success,
+ * negative values on failure.
+ *
+ */
+int security_get_policycaps(int *len, int **values)
+{
+	int rc = -ENOMEM;
+	unsigned int iter;
+
+	POLICY_RDLOCK;
+
+	*values = kcalloc(POLICYDB_CAPABILITY_MAX, sizeof(int), GFP_ATOMIC);
+	if (*values == NULL)
+		goto out;
+	for (iter = 0; iter < POLICYDB_CAPABILITY_MAX; iter++)
+		(*values)[iter] = ebitmap_get_bit(&policydb.policycaps, iter);
+	*len = POLICYDB_CAPABILITY_MAX;
+
+out:
+	POLICY_RDUNLOCK;
+	return rc;
+}
+
+/**
+ * security_policycap_supported - Check for a specific policy capability
+ * @req_cap: capability
+ *
+ * Description:
+ * This function queries the currently loaded policy to see if it supports the
+ * capability specified by @req_cap.  Returns true (1) if the capability is
+ * supported, false (0) if it isn't supported.
+ *
+ */
+int security_policycap_supported(unsigned int req_cap)
+{
+	int rc;
+
+	POLICY_RDLOCK;
+	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
+	POLICY_RDUNLOCK;
+
+	return rc;
+}
+
 struct selinux_audit_rule {
 	u32 au_seqno;
 	struct context au_ctxt;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
