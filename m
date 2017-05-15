From: Sebastien Buisson <sbuisson.ddn@gmail.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: [PATCH v4 1/2] selinux: add brief info to policydb
Date: Tue, 16 May 2017 03:22:42 +0900
Message-Id: <1494872563-12467-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add policybrief field to struct policydb. It holds a brief info
of the policydb, made of colon separated name and value pairs
that give information about how the policy is applied in the
security module(s).
Note that the ordering of the fields in the string may change.

Policy brief is computed every time the policy is loaded, and when
enforce or checkreqprot are changed.

Add security_policy_brief hook to give access to policy brief to
the rest of the kernel. Lustre client makes use of this information
to detect changes to the policy, and forward it to Lustre servers.
Depending on how the policy is enforced on Lustre client side,
Lustre servers can refuse connection.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
---
 include/linux/lsm_hooks.h           | 17 +++++++
 include/linux/security.h            |  7 +++
 security/security.c                 |  8 ++++
 security/selinux/hooks.c            |  7 +++
 security/selinux/include/security.h |  2 +
 security/selinux/selinuxfs.c        |  2 +
 security/selinux/ss/policydb.c      | 88 +++++++++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.h      |  3 ++
 security/selinux/ss/services.c      | 68 ++++++++++++++++++++++++++++
 9 files changed, 202 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 1aa6333..4d04144 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1331,6 +1331,21 @@
  *	@inode we wish to get the security context of.
  *	@ctx is a pointer in which to place the allocated security context.
  *	@ctxlen points to the place to put the length of @ctx.
+ *
+ * Security hooks for policy brief
+ *
+ * @policy_brief:
+ *
+ *	Returns a string containing a brief info of the policydb. The string
+ *	contains colon separated name and value pairs that give information
+ *	about how the policy is applied in the security module(s).
+ *	Note that the ordering of the fields in the string may change.
+ *
+ *	@brief: pointer to buffer holding brief
+ *	@len: in: brief buffer length if no alloc, out: brief string len
+ *	@alloc: whether to allocate buffer for brief or not
+ *	On success 0 is returned , or negative value on error.
+ *
  * This is the main security structure.
  */
 
@@ -1562,6 +1577,7 @@
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
 
+	int (*policy_brief)(char **brief, size_t *len, bool alloc);
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
@@ -1806,6 +1822,7 @@ struct security_hook_heads {
 	struct list_head inode_notifysecctx;
 	struct list_head inode_setsecctx;
 	struct list_head inode_getsecctx;
+	struct list_head policy_brief;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct list_head unix_stream_connect;
 	struct list_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 97df7ba..35ac97f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -376,6 +376,8 @@ int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+
+int security_policy_brief(char **brief, size_t *len, bool alloc);
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -1159,6 +1161,11 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int security_policy_brief(char **brief, size_t *len, bool alloc)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index d6d18a3..46052d3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1269,6 +1269,12 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+int security_policy_brief(char **brief, size_t *len, bool alloc)
+{
+	return call_int_hook(policy_brief, -EOPNOTSUPP, brief, len, alloc);
+}
+EXPORT_SYMBOL(security_policy_brief);
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
@@ -1868,6 +1874,8 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init = {
 		LIST_HEAD_INIT(security_hook_heads.inode_setsecctx),
 	.inode_getsecctx =
 		LIST_HEAD_INIT(security_hook_heads.inode_getsecctx),
+	.policy_brief =
+		LIST_HEAD_INIT(security_hook_heads.policy_brief),
 #ifdef CONFIG_SECURITY_NETWORK
 	.unix_stream_connect =
 		LIST_HEAD_INIT(security_hook_heads.unix_stream_connect),
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e67a526..da245e8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6063,6 +6063,11 @@ static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 	*ctxlen = len;
 	return 0;
 }
+
+static int selinux_policy_brief(char **brief, size_t *len, bool alloc)
+{
+	return security_policydb_brief(brief, len, alloc);
+}
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
@@ -6277,6 +6282,8 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 
+	LSM_HOOK_INIT(policy_brief, selinux_policy_brief),
+
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f979c35..a0d4d7d 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -97,6 +97,8 @@ enum {
 int security_load_policy(void *data, size_t len);
 int security_read_policy(void **data, size_t *len);
 size_t security_policydb_len(void);
+int security_policydb_brief(char **brief, size_t *len, bool alloc);
+void security_policydb_update_info(u32 requested);
 
 int security_policycap_supported(unsigned int req_cap);
 
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index ce71718..e8fe914 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -159,6 +159,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current));
 		selinux_enforcing = new_value;
+		security_policydb_update_info(SECURITY__SETENFORCE);
 		if (selinux_enforcing)
 			avc_ss_reset(0);
 		selnl_notify_setenforce(selinux_enforcing);
@@ -621,6 +622,7 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
 		goto out;
 
 	selinux_checkreqprot = new_value ? 1 : 0;
+	security_policydb_update_info(SECURITY__SETCHECKREQPROT);
 	length = count;
 out:
 	kfree(page);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0080122..8ce7f89 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -32,13 +32,20 @@
 #include <linux/errno.h>
 #include <linux/audit.h>
 #include <linux/flex_array.h>
+#include <crypto/hash.h>
 #include "security.h"
 
 #include "policydb.h"
 #include "conditional.h"
 #include "mls.h"
+#include "objsec.h"
 #include "services.h"
 
+static unsigned int policybrief_hash_size;
+static struct crypto_shash *policybrief_tfm;
+static const char policybrief_hash_alg[] = "sha256";
+unsigned int policybrief_len;
+
 #define _DEBUG_HASHES
 
 #ifdef DEBUG_HASHES
@@ -879,6 +886,8 @@ void policydb_destroy(struct policydb *p)
 	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
+
+	kfree(p->policybrief);
 }
 
 /*
@@ -2220,6 +2229,52 @@ static int ocontext_read(struct policydb *p, struct policydb_compat_info *info,
 }
 
 /*
+ * Compute summary of a policy database binary representation file,
+ * and store it into a policy database structure.
+ */
+static int policydb_brief(struct policydb *policydb, void *ptr)
+{
+	struct policy_file *fp = ptr;
+	u8 *hashval;
+	int rc = 0;
+
+	if (policydb->policybrief)
+		return -EINVAL;
+
+	hashval = kmalloc(policybrief_hash_size, GFP_KERNEL);
+	if (hashval == NULL)
+		return -ENOMEM;
+
+	{
+		SHASH_DESC_ON_STACK(desc, policybrief_tfm);
+		desc->tfm = policybrief_tfm;
+		desc->flags = 0;
+		rc = crypto_shash_digest(desc, fp->data, fp->len, hashval);
+		if (rc) {
+			printk(KERN_ERR "Failed crypto_shash_digest: %d\n", rc);
+			goto out_free;
+		}
+	}
+
+	/* policy brief is in the form:
+	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
+	 */
+	policydb->policybrief = kasprintf(GFP_KERNEL,
+					  "selinux(enforce=%d:checkreqprot=%d:%s=%*phN)",
+					  selinux_enforcing,
+					  selinux_checkreqprot,
+					  policybrief_hash_alg,
+					  policybrief_hash_size, hashval);
+	if (policydb->policybrief == NULL)
+		rc = -ENOMEM;
+
+out_free:
+	kfree(hashval);
+
+	return rc;
+}
+
+/*
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
@@ -2238,6 +2293,11 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
+	/* Compute summary of policy, and store it in policydb */
+	rc = policydb_brief(p, fp);
+	if (rc)
+		goto bad;
+
 	/* Read the magic number and string length. */
 	rc = next_entry(buf, fp, sizeof(u32) * 2);
 	if (rc)
@@ -3456,3 +3516,31 @@ int policydb_write(struct policydb *p, void *fp)
 
 	return 0;
 }
+
+static int __init init_policybrief_hash(void)
+{
+	struct crypto_shash *tfm;
+
+	if (!selinux_enabled)
+		return 0;
+
+	tfm = crypto_alloc_shash(policybrief_hash_alg, 0, 0);
+	if (IS_ERR(tfm)) {
+		printk(KERN_ERR "Failed to alloc crypto hash %s\n",
+		       policybrief_hash_alg);
+		return PTR_ERR(tfm);
+	}
+
+	policybrief_tfm = tfm;
+	policybrief_hash_size = crypto_shash_digestsize(policybrief_tfm);
+
+	/* policy brief is in the form:
+	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
+	 */
+	policybrief_len = 35 + strlen(policybrief_hash_alg) +
+		2*policybrief_hash_size;
+
+	return 0;
+}
+
+late_initcall(init_policybrief_hash);
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 725d594..2e5048c 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -293,6 +293,8 @@ struct policydb {
 	size_t len;
 
 	unsigned int policyvers;
+	/* summary computed on the policy */
+	unsigned char *policybrief;
 
 	unsigned int reject_unknown : 1;
 	unsigned int allow_unknown : 1;
@@ -309,6 +311,7 @@ struct policydb {
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
+extern unsigned int policybrief_len;
 
 #define PERM_SYMTAB_SIZE 32
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 60d9b02..32150fb 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2170,6 +2170,74 @@ size_t security_policydb_len(void)
 }
 
 /**
+ * security_policydb_brief - Get policydb brief
+ * @brief: pointer to buffer holding brief
+ * @len: in: brief buffer length if no alloc, out: brief string len
+ * @alloc: whether to allocate buffer for brief or not
+ *
+ * On success 0 is returned , or negative value on error.
+ **/
+int security_policydb_brief(char **brief, size_t *len, bool alloc)
+{
+	if (!ss_initialized || brief == NULL)
+		return -EINVAL;
+
+	if (alloc) {
+		/* *brief must be kfreed by caller in this case */
+		*brief = kzalloc(policybrief_len + 1, GFP_KERNEL);
+	/*
+	 * if !alloc, caller must pass a buffer that
+	 * can hold policybrief_len+1 chars
+	 */
+	} else if (*len < policybrief_len + 1) {
+		/* put in *len the string size we need to write */
+		*len = policybrief_len;
+		return -ENAMETOOLONG;
+	}
+
+	if (*brief == NULL)
+		return -ENOMEM;
+
+	read_lock(&policy_rwlock);
+	*len = policybrief_len;
+	strncpy(*brief, policydb.policybrief, *len);
+	read_unlock(&policy_rwlock);
+
+	return 0;
+}
+
+void security_policydb_update_info(u32 requested)
+{
+	/* policy brief is in the form:
+	 * selinux(enforce=<0 or 1>:checkreqprot=<0 or 1>:<hashalg>=<checksum>)
+	 */
+	char enforce[] = "enforce=";
+	char checkreqprot[] = "checkreqprot=";
+	char *p, *str;
+	int val;
+
+	if (!ss_initialized)
+		return;
+
+	if (requested == SECURITY__SETENFORCE) {
+		str = enforce;
+		val = selinux_enforcing;
+	} else if (requested == SECURITY__SETCHECKREQPROT) {
+		str = checkreqprot;
+		val = selinux_checkreqprot;
+	}
+
+	/* update global policydb, needs write lock */
+	write_lock_irq(&policy_rwlock);
+	p = strstr(policydb.policybrief, str);
+	if (p) {
+		p += strlen(str);
+		*p = '0' + val;
+	}
+	write_unlock_irq(&policy_rwlock);
+}
+
+/**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
  * @port: port number
-- 
1.8.3.1
