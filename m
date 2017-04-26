From: Sebastien Buisson <sbuisson.ddn@gmail.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Cc: serge@hallyn.com, james.l.morris@oracle.com, eparis@parisplace.org,
 sds@tycho.nsa.gov, paul@paul-moore.com, danielj@mellanox.com,
 Sebastien Buisson <sbuisson@ddn.com>
Subject: [PATCH 2/3] selinux: add checksum to policydb
Date: Thu, 27 Apr 2017 00:02:15 +0900
Message-Id: <1493218936-18522-2-git-send-email-sbuisson@ddn.com>
In-Reply-To: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
References: <1493218936-18522-1-git-send-email-sbuisson@ddn.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add policycksum field to struct policydb. It holds the sha256
checksum computed on the binary policy every time the notifier is
called after a policy change.
Add security_policy_cksum hook to give access to policy checksum to
the rest of the kernel. Lustre client makes use of this information.

Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
---
 include/linux/lsm_hooks.h           |  2 +
 include/linux/security.h            |  7 +++
 security/security.c                 |  6 +++
 security/selinux/hooks.c            | 12 ++++-
 security/selinux/include/security.h |  2 +
 security/selinux/ss/policydb.h      |  4 ++
 security/selinux/ss/services.c      | 91 +++++++++++++++++++++++++++++++++++++
 7 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 080f34e..7aada73 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1568,6 +1568,7 @@
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
 
+	ssize_t (*policy_cksum)(char *cksum, size_t len);
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
@@ -1813,6 +1814,7 @@ struct security_hook_heads {
 	struct list_head inode_notifysecctx;
 	struct list_head inode_setsecctx;
 	struct list_head inode_getsecctx;
+	struct list_head policy_cksum;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct list_head unix_stream_connect;
 	struct list_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 73a9c93..8461d31 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -385,6 +385,8 @@ int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+
+ssize_t security_policy_cksum(char *cksum, size_t len);
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -1189,6 +1191,11 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+
+static inline ssize_t security_policy_cksum(char *cksum, size_t len)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index ef9d9e1..a82c08c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1305,6 +1305,12 @@ int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
+ssize_t security_policy_cksum(char *cksum, size_t len)
+{
+	return call_int_hook(policy_cksum, -EOPNOTSUPP, cksum, len);
+}
+EXPORT_SYMBOL(security_policy_cksum);
+
 #ifdef CONFIG_SECURITY_NETWORK
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a4d36f8..3759198 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -173,8 +173,11 @@ static int selinux_netcache_avc_callback(u32 event)
 
 static int selinux_lsm_notifier_avc_callback(u32 event)
 {
-	if (event == AVC_CALLBACK_RESET)
+	if (event == AVC_CALLBACK_RESET) {
+		if (security_policydb_compute_cksum() != 0)
+			printk(KERN_ERR "Failed to compute policydb cksum\n");
 		call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
+	}
 
 	return 0;
 }
@@ -6071,6 +6074,11 @@ static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 	*ctxlen = len;
 	return 0;
 }
+
+static ssize_t selinux_policy_cksum(char *cksum, size_t len)
+{
+	return security_policydb_cksum(cksum, len);
+}
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, const struct cred *cred,
@@ -6285,6 +6293,8 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 	LSM_HOOK_INIT(inode_setsecctx, selinux_inode_setsecctx),
 	LSM_HOOK_INIT(inode_getsecctx, selinux_inode_getsecctx),
 
+	LSM_HOOK_INIT(policy_cksum, selinux_policy_cksum),
+
 	LSM_HOOK_INIT(unix_stream_connect, selinux_socket_unix_stream_connect),
 	LSM_HOOK_INIT(unix_may_send, selinux_socket_unix_may_send),
 
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f979c35..a329571 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -97,6 +97,8 @@ enum {
 int security_load_policy(void *data, size_t len);
 int security_read_policy(void **data, size_t *len);
 size_t security_policydb_len(void);
+ssize_t security_policydb_cksum(char *cksum, size_t len);
+int security_policydb_compute_cksum(void);
 
 int security_policycap_supported(unsigned int req_cap);
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 725d594..dc29492 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -25,6 +25,7 @@
 #define _SS_POLICYDB_H_
 
 #include <linux/flex_array.h>
+#include <crypto/sha.h>
 
 #include "symtab.h"
 #include "avtab.h"
@@ -293,6 +294,9 @@ struct policydb {
 	size_t len;
 
 	unsigned int policyvers;
+	/* checksum computed on the policy */
+	unsigned char policycksum[SHA256_DIGEST_SIZE*2 + 1];
+	size_t policycksum_len;
 
 	unsigned int reject_unknown : 1;
 	unsigned int allow_unknown : 1;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 60d9b02..a35d294 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -53,6 +53,8 @@
 #include <linux/flex_array.h>
 #include <linux/vmalloc.h>
 #include <net/netlabel.h>
+#include <crypto/hash.h>
+#include <crypto/sha.h>
 
 #include "flask.h"
 #include "avc.h"
@@ -2170,6 +2172,95 @@ size_t security_policydb_len(void)
 }
 
 /**
+ * security_policydb_cksum - Get policydb checksum.
+ * @cksum: string to store checksum to
+ * @len: length of checksum
+ */
+ssize_t security_policydb_cksum(char *cksum, size_t len)
+{
+	int rc;
+
+	read_lock(&policy_rwlock);
+	if (strlcpy(cksum, policydb.policycksum, len) >= len)
+		rc = -ENAMETOOLONG;
+	rc = policydb.policycksum_len;
+	read_unlock(&policy_rwlock);
+
+	return rc;
+}
+
+/**
+ * security_policydb_compute_cksum - Compute checksum of a policy database.
+ */
+int security_policydb_compute_cksum(void)
+{
+	struct crypto_ahash *tfm;
+	struct ahash_request *req;
+	struct scatterlist sl;
+	char hashval[SHA256_DIGEST_SIZE];
+	int idx;
+	unsigned char *p;
+	size_t len;
+	void *data;
+	int rc;
+
+	rc = security_read_policy(&data, &len);
+	if (rc) {
+		printk(KERN_ERR "Failed to read security policy\n");
+		return rc;
+	}
+
+	tfm = crypto_alloc_ahash("sha256", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm)) {
+		printk(KERN_ERR "Failed to alloc crypto hash sha256\n");
+		vfree(data);
+		rc = PTR_ERR(tfm);
+		return rc;
+	}
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		printk(KERN_ERR "Failed to alloc ahash_request for sha256\n");
+		crypto_free_ahash(tfm);
+		vfree(data);
+		rc = -ENOMEM;
+		return rc;
+	}
+
+	ahash_request_set_callback(req, 0, NULL, NULL);
+
+	rc = crypto_ahash_init(req);
+	if (rc) {
+		printk(KERN_ERR "Failed to init ahash\n");
+		ahash_request_free(req);
+		crypto_free_ahash(tfm);
+		vfree(data);
+		return rc;
+	}
+
+	sg_init_one(&sl, (void *)data, len);
+	ahash_request_set_crypt(req, &sl, hashval, sl.length);
+	rc = crypto_ahash_digest(req);
+
+	crypto_free_ahash(tfm);
+	ahash_request_free(req);
+	vfree(data);
+	if (rc) {
+		printk(KERN_ERR "Failed to compute digest\n");
+		return rc;
+	}
+
+	p = policydb.policycksum;
+	for (idx = 0; idx < SHA256_DIGEST_SIZE; idx++) {
+		snprintf(p, 3, "%02x", (unsigned char)(hashval[idx]));
+		p += 2;
+	}
+	policydb.policycksum_len = (size_t)(p - policydb.policycksum);
+
+	return 0;
+}
+
+/**
  * security_port_sid - Obtain the SID for a port.
  * @protocol: protocol number
  * @port: port number
-- 
1.8.3.1
