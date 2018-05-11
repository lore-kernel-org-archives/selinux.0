Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4B0tANr001841
 for <selinux@tycho.nsa.gov>; Thu, 10 May 2018 20:55:10 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 LKLM <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 James Morris <jmorris@namei.org>
References: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1104b03d-c4c9-6245-6b5c-766b7d6c3a5d@schaufler-ca.com>
Date: Thu, 10 May 2018 17:54:57 -0700
MIME-Version: 1.0
In-Reply-To: <7e8702ce-2598-e0a3-31a2-bc29157fb73d@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 14/23] LSM: Infrastructure management of the key security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 10 May 2018 14:32:32 -0700
Subject: [PATCH 14/23] LSM: Infrastructure management of the key security blob

Move management of the key->security blob out of the
individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 40 ++++++++++++++++++++++++++++++++++++++-
 security/selinux/hooks.c          | 23 ++++++----------------
 security/selinux/include/objsec.h |  7 +++++++
 security/smack/smack.h            |  7 +++++++
 security/smack/smack_lsm.c        | 33 +++++++++++++++-----------------
 6 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 42535da852bc..5428485750b6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2019,6 +2019,7 @@ struct lsm_blob_sizes {
 	int	lbs_file;
 	int	lbs_inode;
 	int	lbs_ipc;
+	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_sock;
 	int	lbs_superblock;
diff --git a/security/security.c b/security/security.c
index 9414d1a78ee5..359ed1137c00 100644
--- a/security/security.c
+++ b/security/security.c
@@ -117,6 +117,9 @@ int __init security_init(void)
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
 	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
 	pr_info("LSM: ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	pr_info("LSM: key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	pr_info("LSM: msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	pr_info("LSM: sock blob size       = %d\n", blob_sizes.lbs_sock);
 	pr_info("LSM: superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -297,6 +300,9 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	lsm_set_size(&needed->lbs_key, &blob_sizes.lbs_key);
+#endif
 	lsm_set_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -432,6 +438,29 @@ int lsm_ipc_alloc(struct kern_ipc_perm *kip)
 	return 0;
 }
 
+#ifdef CONFIG_KEYS
+/**
+ * lsm_key_alloc - allocate a composite key blob
+ * @key: the key that needs a blob
+ *
+ * Allocate the key blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_key_alloc(struct key *key)
+{
+	if (blob_sizes.lbs_key == 0) {
+		key->security = NULL;
+		return 0;
+	}
+
+	key->security = kzalloc(blob_sizes.lbs_key, GFP_KERNEL);
+	if (key->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+#endif /* CONFIG_KEYS */
+
 /**
  * lsm_msg_msg_alloc - allocate a composite msg_msg blob
  * @mp: the msg_msg that needs a blob
@@ -2137,12 +2166,21 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return call_int_hook(key_alloc, 0, key, cred, flags);
+	int rc = lsm_key_alloc(key);
+
+	if (unlikely(rc))
+		return rc;
+	rc = call_int_hook(key_alloc, 0, key, cred, flags);
+	if (unlikely(rc))
+		security_key_free(key);
+	return rc;
 }
 
 void security_key_free(struct key *key)
 {
 	call_void_hook(key_free, key);
+	kfree(key->security);
+	key->security = NULL;
 }
 
 int security_key_permission(key_ref_t key_ref,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3911e28e3907..f3531e5bc3d9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6407,11 +6407,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 			     unsigned long flags)
 {
 	const struct task_security_struct *tsec;
-	struct key_security_struct *ksec;
-
-	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
-	if (!ksec)
-		return -ENOMEM;
+	struct key_security_struct *ksec = selinux_key(k);
 
 	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
@@ -6419,18 +6415,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	else
 		ksec->sid = tsec->sid;
 
-	k->security = ksec;
 	return 0;
 }
 
-static void selinux_key_free(struct key *k)
-{
-	struct key_security_struct *ksec = k->security;
-
-	k->security = NULL;
-	kfree(ksec);
-}
-
 static int selinux_key_permission(key_ref_t key_ref,
 				  const struct cred *cred,
 				  unsigned perm)
@@ -6448,7 +6435,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = selinux_key(key);
 
 	return avc_has_perm(&selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
@@ -6456,7 +6443,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -6681,6 +6668,9 @@ struct lsm_blob_sizes selinux_blob_sizes = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct key_security_struct),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -6890,7 +6880,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
-	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index d1d883f8c552..6092786c5828 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -192,6 +192,13 @@ static inline struct ipc_security_struct *selinux_ipc(
 	return ipc->security;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct key_security_struct *selinux_key(const struct key *key)
+{
+	return key->security;
+}
+#endif /* CONFIG_KEYS */
+
 static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 {
 	return sock->sk_security;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 42c36e37b0bd..e50ed4945a40 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -393,6 +393,13 @@ static inline struct smack_known **smack_ipc(const struct kern_ipc_perm *ipc)
 	return ipc->security;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct smack_known **smack_key(const struct key *key)
+{
+	return key->security;
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a419953c1004..c15861eb3606 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4136,23 +4136,13 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
+	struct smack_known **blob = smack_key(key);
 	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
-	key->security = skp;
+	*blob = skp;
 	return 0;
 }
 
-/**
- * smack_key_free - Clear the key security blob
- * @key: the object
- *
- * Clear the blob pointer
- */
-static void smack_key_free(struct key *key)
-{
-	key->security = NULL;
-}
-
 /**
  * smack_key_permission - Smack access on a key
  * @key_ref: gets to the object
@@ -4165,6 +4155,8 @@ static void smack_key_free(struct key *key)
 static int smack_key_permission(key_ref_t key_ref,
 				const struct cred *cred, unsigned perm)
 {
+	struct smack_known **blob;
+	struct smack_known *skp;
 	struct key *keyp;
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_task(smack_cred(cred));
@@ -4178,7 +4170,9 @@ static int smack_key_permission(key_ref_t key_ref,
 	 * If the key hasn't been initialized give it access so that
 	 * it may do so.
 	 */
-	if (keyp->security == NULL)
+	blob = smack_key(keyp);
+	skp = *blob;
+	if (skp == NULL)
 		return 0;
 	/*
 	 * This should not occur
@@ -4198,8 +4192,8 @@ static int smack_key_permission(key_ref_t key_ref,
 		request = MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
 		request = MAY_WRITE;
-	rc = smk_access(tkp, keyp->security, request, &ad);
-	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
+	rc = smk_access(tkp, skp, request, &ad);
+	rc = smk_bu_note("key access", tkp, skp, request, rc);
 	return rc;
 }
 
@@ -4214,11 +4208,12 @@ static int smack_key_permission(key_ref_t key_ref,
  */
 static int smack_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct smack_known *skp = key->security;
+	struct smack_known **blob = smack_key(key);
+	struct smack_known *skp = *blob;
 	size_t length;
 	char *copy;
 
-	if (key->security == NULL) {
+	if (skp == NULL) {
 		*_buffer = NULL;
 		return 0;
 	}
@@ -4505,6 +4500,9 @@ struct lsm_blob_sizes smack_blob_sizes = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct smack_known *),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -4623,7 +4621,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #endif /* CONFIG_KEYS */
-- 
2.14.3
