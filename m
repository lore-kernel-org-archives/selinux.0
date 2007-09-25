Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8PKnB3T032743
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 16:49:11 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8PKnBRe029659
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 20:49:11 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 99D62354BE
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2007 16:48:40 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH 1/2] [SELINUX] Add a functionality version number
To: selinux@tycho.nsa.gov
Date: Tue, 25 Sep 2007 16:48:25 -0400
Message-ID: <20070925204825.13699.85412.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
References: <20070925203856.13699.90782.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a functionality/compatability version number to the policy so that the
kernel can query the policy to see what level of functionality it supports.
---

 security/selinux/include/security.h |   21 +++++++++++++++++++++
 security/selinux/selinuxfs.c        |   18 ++++++++++++++++++
 security/selinux/ss/policydb.c      |   20 ++++++++++++++++++++
 security/selinux/ss/policydb.h      |    6 +++++-
 security/selinux/ss/services.c      |    2 ++
 5 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 83bdd4d..cd45cf0 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -39,6 +39,27 @@ struct netlbl_lsm_secattr;
 extern int selinux_enabled;
 extern int selinux_mls_enabled;
 
+/* Supported functionality/compatibility version */
+extern unsigned int policydb_loaded_compatver;
+#define POLICYDB_COMPATVER_BASE		0
+
+/* Range of supported functionality/compatibility we understand */
+#define POLICYDB_COMPATVER_MIN		POLICYDB_COMPATVER_BASE
+#define POLICYDB_COMPATVER_MAX		POLICYDB_COMPATVER_BASE
+
+/**
+ * security_compat_supported - Check if policy supports certain functionality
+ * @requested: requested functionality (see #define COMPATVERS_*)
+ *
+ * Description:
+ * Query the currently loaded policy, by way of the selinux_compat_vers
+ * variable to see if the requested functionality is supported.
+ *
+ */
+static inline int security_compat_supported(unsigned int requested) {
+	return (policydb_loaded_compatver >= requested);
+}
+
 int security_load_policy(void * data, size_t len);
 
 #define SEL_VEC_MAX 32
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index c9e92da..e5927b9 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -103,6 +103,7 @@ enum sel_inos {
 	SEL_MEMBER,	/* compute polyinstantiation membership decision */
 	SEL_CHECKREQPROT, /* check requested protection, not kernel-applied one */
 	SEL_COMPAT_NET,	/* whether to use old compat network packet controls */
+	SEL_COMPAT_VERS, /* functionality/compatability version */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -452,6 +453,22 @@ static const struct file_operations sel_compat_net_ops = {
 	.write		= sel_write_compat_net,
 };
 
+static ssize_t sel_read_compat_vers(struct file *filp,
+				      char __user *buf,
+				      size_t count,
+				      loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%d", policydb_loaded_compatver);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+static const struct file_operations sel_compat_vers_ops = {
+	.read		= sel_read_compat_vers,
+};
+
 /*
  * Remaining nodes use transaction based IO methods like nfsd/nfsctl.c
  */
@@ -1575,6 +1592,7 @@ static int sel_fill_super(struct super_block * sb, void * data, int silent)
 		[SEL_MEMBER] = {"member", &transaction_ops, S_IRUGO|S_IWUGO},
 		[SEL_CHECKREQPROT] = {"checkreqprot", &sel_checkreqprot_ops, S_IRUGO|S_IWUSR},
 		[SEL_COMPAT_NET] = {"compat_net", &sel_compat_net_ops, S_IRUGO|S_IWUSR},
+		[SEL_COMPAT_VERS] = {"compat_version", &sel_compat_vers_ops, S_IRUGO},
 		/* last one */ {""}
 	};
 	ret = simple_fill_super(sb, SELINUX_MAGIC, selinux_files);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index f05f97a..6c05516 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -47,6 +47,7 @@ static char *symtab_name[SYM_NUM] = {
 #endif
 
 int selinux_mls_enabled = 0;
+unsigned int selinux_compat_version = POLICYDB_COMPATVER_BASE;
 
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
@@ -1531,6 +1532,25 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 	}
 
+	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_COMPATVER)) {
+		__le32 compat_buf;
+		rc = next_entry(&compat_buf, fp, sizeof(compat_buf));
+		if (rc < 0)
+			goto bad;
+
+		p->compat_version = le32_to_cpu(compat_buf);
+		if (p->compat_version < POLICYDB_COMPATVER_MIN ||
+		    p->compat_version > POLICYDB_COMPATVER_MAX) {
+			printk(KERN_ERR
+			       "security:  policydb compat_version %d does not"
+			       " match my version range %d-%d\n",
+			       p->compat_version,
+			       POLICYDB_COMPATVER_MIN,
+			       POLICYDB_COMPATVER_MAX);
+			goto bad;
+		}
+	}
+
 	info = policydb_lookup_compat(p->policyvers);
 	if (!info) {
 		printk(KERN_ERR "security:  unable to find policy compat info "
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 8319d5f..59177d3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -242,6 +242,9 @@ struct policydb {
 	struct ebitmap *type_attr_map;
 
 	unsigned int policyvers;
+
+	/* functionality/compatability version */
+	unsigned int compat_version;
 };
 
 extern void policydb_destroy(struct policydb *p);
@@ -251,7 +254,8 @@ extern int policydb_read(struct policydb *p, void *fp);
 
 #define PERM_SYMTAB_SIZE 32
 
-#define POLICYDB_CONFIG_MLS    1
+#define POLICYDB_CONFIG_MLS		0x00000001
+#define POLICYDB_CONFIG_COMPATVER	0x00000002
 
 #define OBJECT_R "object_r"
 #define OBJECT_R_VAL 1
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 6100fc0..ef557b6 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -58,6 +58,7 @@
 
 extern void selnl_notify_policyload(u32 seqno);
 unsigned int policydb_loaded_version;
+unsigned int policydb_loaded_compatver;
 
 /*
  * This is declared in avc.c
@@ -1304,6 +1305,7 @@ int security_load_policy(void *data, size_t len)
 			return -EINVAL;
 		}
 		policydb_loaded_version = policydb.policyvers;
+		policydb_loaded_compatver = policydb.compat_version;
 		ss_initialized = 1;
 		seqno = ++latest_granting;
 		LOAD_UNLOCK;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
