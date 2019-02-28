Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677CEC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2939D2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AFPXz+bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfB1WTs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:48 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:41164
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728107AbfB1WTr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392385; bh=R9Cl382zwabtlYbHrBE+YOkLeuWWJbLiCPDXQYnLx3k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AFPXz+bpMLIFOoeCr/HDa5j3Vx+DIGTRRWm9InPmP4rsAzxItIFZJ3pzo6l8O/ArYm+T+dwV6n+uxV2+PjHlnY5FnwUa1QveEs9+cRkpIqKLxKukKaHEtfg3+DtblYQsTp4rfFW2xmG6L3kd3nS0JgkAAvx1zfqyQ56OgC9wDlzpAymtjffFjIk2xeJugnj3vPgrXsFzG2vZbGUl2UoGyFTPBHOoBC94ZcglGN8t43GLPZgGViJJN12tTbDuBH4dI6l37EPZIKmbwQRfH4nbmnj86vRuGBJMkepKO4OWEvZ/Q5vWd9l/izD8M7DRMZdr9M7wsB+xfUud+MypGAvVjg==
X-YMail-OSG: 1t_zGY4VM1my8L6VYQNI7W9ZbSfRItYgRKQQvHmvfrj2e9Z4odIk5b_4AOspuOS
 zXlaCBti_UlBxnR3Tmwa_X89vb_OCRbzhYIdXJRF0RWlUnBL3AZryUPsvjpcLLttIS6Ciy12RTgk
 TkIv1x02AZtpEVFKFz2fBxZegP8d3oaOtmahyLickGEmqsjoUtCt8Ecm.vJXDzzNCNR5sgXXEYl8
 SfvjgHiiMjiWWEZYS2s4rS8yNHqqKG6JGMA1t9LepHJfFiqbeHRSf1Y5Eoccj57D6S_WUU5i8y.X
 lzcAVcu5R.swF5IVGIhKvCFTmkhN.5NDJMORYfT7eICii1UoliQmyIalYpJWBM4A4aiItWhOkHDV
 aHBgDOKx69XF4.jKmyEGshDj8ANqX0dm7uNH1ghNdqVO0i8xYVdd6vQOw4SvgrOqoUXGNuwxDXmW
 YIRm9u8nm7iyvTVQH3RQTXHCezJQa0zQrsLFRI1hfiMNpcSouwAQegmwCg5Wxj.e_h61sa8Bbljn
 gH_VR13viMmYD4B0Qc3kHHeIgB9t8waeUZ6DKPTbuFY8PKxGTJVoGoA6cRre8nxHSrznKnmz07fO
 m9nqwOwPYBp6Ny6hXTe6MJ_i4J_8XAAfXlGnhkN2RCGInIQ6095LH5gODPYMMChkiLvxruuUx.2x
 rnGxo6wchggSyKhmVQ9cGOWW7e9yc4Kf4MUuQr9vRjOrEaePciAXDHw4toD7BmpLfc5WPFCRYrZj
 mgkhfF9GlEaxRp8oxNm10SW4WmIdZqkV5Xaq8o22QKI4KGngywmaHeKjr2YtFq.16USADnEt1Bov
 zSM5SKGtP7hJcOX0ytWQGxZgKmyYOMBDAvuHk_ysayNYZjSVIsF9goQunls2tFNsNSodXxk8kuVi
 .SR2D2wgUbSet_I6JqGM67mgkCnxO6iUVgMZpwVWVQ1wAXgT3U5rM9sTvu8P8MaShew8q1tD6K8T
 7J73WIhBLqvD5xw8wwjMeoS163xCyhAyixjeRn7NpqHCfRMUzEskfuRBwu6s6ow3OML_0v5WHcto
 n4R_tvciFF5O23BEM735vsTFncZm4.O8BBtPIeAhErnZRa7D2dPwq2RyBiNNbCXAN6CaBRk7DwTn
 Fe8Gg5d4o8OUmFrSnucOyII5.0NhvgLe5ZvPCK_4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:45 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eca90f2e660dab57d5d3726b0a8f0373;
          Thu, 28 Feb 2019 22:19:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 03/97] LSM: Infrastructure management of the key security blob
Date:   Thu, 28 Feb 2019 14:17:59 -0800
Message-Id: <20190228221933.2551-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Casey Schaufler <cschaufler@schaufler-ca.com>

Move management of the key->security blob out of the
individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  1 +
 security/security.c               | 40 ++++++++++++++++++++++++++++++-
 security/selinux/hooks.c          | 23 +++++-------------
 security/selinux/include/objsec.h |  7 ++++++
 security/smack/smack.h            |  7 ++++++
 security/smack/smack_lsm.c        | 33 ++++++++++++-------------
 6 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 22145f2a6464..f19751dc53be 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,6 +2039,7 @@ struct lsm_blob_sizes {
 	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
+	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
 };
diff --git a/security/security.c b/security/security.c
index 43bed5fd6da3..750b1b63edbb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -172,6 +172,9 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
 	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
+#endif
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -303,6 +306,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -569,6 +575,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
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
@@ -2325,12 +2354,21 @@ EXPORT_SYMBOL(security_skb_classify_flow);
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
index 6133bf4b737d..54b8a42ed3a3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6243,11 +6243,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
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
@@ -6255,18 +6251,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
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
@@ -6284,7 +6271,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = selinux_key(key);
 
 	return avc_has_perm(&selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
@@ -6292,7 +6279,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -6517,6 +6504,9 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct key_security_struct),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -6729,7 +6719,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, selinux_key_alloc),
-	LSM_HOOK_INIT(key_free, selinux_key_free),
 	LSM_HOOK_INIT(key_permission, selinux_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, selinux_key_getsecurity),
 #endif
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 29f02b8f8f31..3b78aa4ee98f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -194,6 +194,13 @@ static inline struct superblock_security_struct *selinux_superblock(
 	return superblock->s_security + selinux_blob_sizes.lbs_superblock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct key_security_struct *selinux_key(const struct key *key)
+{
+	return key->security + selinux_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 static inline struct sk_security_struct *selinux_sock(const struct sock *sock)
 {
 	return sock->sk_security + selinux_blob_sizes.lbs_sock;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 010236b198d9..f623d059421d 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -395,6 +395,13 @@ static inline struct superblock_smack *smack_superblock(
 	return superblock->s_security + smack_blob_sizes.lbs_superblock;
 }
 
+#ifdef CONFIG_KEYS
+static inline struct smack_known **smack_key(const struct key *key)
+{
+	return key->security + smack_blob_sizes.lbs_key;
+}
+#endif /* CONFIG_KEYS */
+
 /*
  * Is the directory transmuting?
  */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b09b19e6466f..d748c709f31a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4093,23 +4093,13 @@ static void smack_inet_csk_clone(struct sock *sk,
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
@@ -4122,6 +4112,8 @@ static void smack_key_free(struct key *key)
 static int smack_key_permission(key_ref_t key_ref,
 				const struct cred *cred, unsigned perm)
 {
+	struct smack_known **blob;
+	struct smack_known *skp;
 	struct key *keyp;
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_task(smack_cred(cred));
@@ -4141,7 +4133,9 @@ static int smack_key_permission(key_ref_t key_ref,
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
@@ -4161,8 +4155,8 @@ static int smack_key_permission(key_ref_t key_ref,
 		request |= MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
 		request |= MAY_WRITE;
-	rc = smk_access(tkp, keyp->security, request, &ad);
-	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
+	rc = smk_access(tkp, skp, request, &ad);
+	rc = smk_bu_note("key access", tkp, skp, request, rc);
 	return rc;
 }
 
@@ -4177,11 +4171,12 @@ static int smack_key_permission(key_ref_t key_ref,
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
@@ -4466,6 +4461,9 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct smack_known *),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -4584,7 +4582,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #endif /* CONFIG_KEYS */
-- 
2.17.0

