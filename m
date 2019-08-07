Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F52C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918BE21EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oVXJJ1pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbfHGToX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:23 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:43056 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388682AbfHGToX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207061; bh=uDaZK+tmy6XVn6IfwbbUA4ENbB2YjAReMXHmAiytrSQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oVXJJ1pWZiyKXydWvBCuwJXSpilzRpL+8tfLBvXYVd1hXaP/3zJLAeV1Jowsw1io23lfZTOth6vnmYepoP9hGMJa3nWbiTQbD1mKYoyXjYBfIoLvvaBT6kzO1sWRlE5gqSEOuPFS6ihP2xm1YKvCuFEm7EFV7h2FmBpt63ntz8OaTRhI9T9k6N79vpWRige6A0EUY8/8rGNBBdprSuZITY4ggxCTeekhxF5ekN2ZFaWjm8HGO/S2Rc5EB9M9bgiepBI+CfWwE62oTaGelGZKumk0nFB5D0/rTywQIZXElJNe/oTon1YG8/OBopyA4WkGBM4w5KiuhK5gPBd1tY7f6w==
X-YMail-OSG: opCY7ZYVM1llUvulEYQ986UhdIUESMbhp99WyauZZ.JnUhwedgD7cts4e9BFT3c
 AMo9Uskb7T2lsrTQ98.n_KSiuCY4_2BvSCknAx.fvMw1BzxV312u22T8gbfg.1T1Wn.BxdSSRKkX
 E4ERED61UKkEvullZ0kmIZtlNBV.0NuLzrGQMaY0T_JfhFNfwOnVpZlDFvWMF5fNMp6J72GXh6fi
 YBrXkDPCYmTvnZ7._5r5axdpZJ5xs4iHSHr_6GICzT_JNClyvIfKJQ1PHtR0Tf5h7EtxMllFY_jB
 xK43FKc3YWOo2SgCi4xYnTl4HjM3qcfD5LXqkbTdddLLsGVesu3N80nDgIX06xJC2AMkf7MixBIS
 6cqJgkcsyyxnq1xcVvt2V1d4Cf6NThTiPH0L3XIxbkWSTacDv6eXAQwYBSHMi2HM4Mm.HKXP3RaP
 wAnXCWZmnMPVLcqsuH.SCoUBJVTYJFMxo5jUYMwA8CmFnbcKAD5jIIXPgHWgNOsomsyiTsOpXDZ6
 OIsSrE1en.IP65XqgifpwmXUEH3raloMV4NkhJi5HAacpYXFK8foeloDIsWdCT3Jqdn06heIvUMQ
 ycN_tTqyBeFFzhRev0c2jbRXmML0It8EhQMMt9D.D0p3EWQMqIff1R8yVoy2xY6DvUghTV4aUmsl
 Zg9V1K5rGwTvY5CGAVJOevAtc6WepCOfOh1qcgAvCjEL5U1hFbT8C7LMniVmbzMm2cn6245iLA4y
 3hLO8ZRRGCLco.GKYEtzsnPi0JrVKj.faJu4Yt50O59O5O59aDyLSjA78_lw6AuUlQzWXO1OMyk0
 dvIXg6.O5aK1iK1Yzp.2w1g0r0Q1SAx4KRs2rskKDEiuBympJCdziHGwfBVDIqqGMNW48IB1l0Zh
 y5b9Fa2t.WEAGsSJRh5E4SsRICOEkqAEE4q1arA6WsW2CdW1WTkucgMGWm4cFo3CYYSI6Beg3gLF
 t9EAF_dcloDz0w8liWzyIG7hudaRltNWA0AfJL4Mm4A1S82WWOvvtxezLCyuC2AOkEefvl8oGgxG
 q8IVvkCqyrXP.jcOQEQVmEV45aR3ALZdBncEYRqMlv8MYc50hbDYr0dE5HgyXK5X.t.zfh.muxfZ
 yoK7eLnHCxFRS0OdDU_zR_GffAd8DWea3oGur0GplEN52mxc4HwHZ_aXEDjWty.QRxIjGIa_REBL
 nBL1SGjfDqNj.6lX3k.9hVdeIdC71DupLlksEk40Y4DnckmcWgGsByt2_K1TS3pkhcdnI5hkdo9H
 1DiOJ8Eq1XD9WELgEehjtJtk7MlDum71l8BGlZUCT2KA8BnpZxq1ngtphB2UzlS3zbwtFj33gKdf
 y.fD1DPJY58U-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:21 +0000
Received: by smtp431.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5e31aa314e44fa49b0fc0446bd9aa9ca;
          Wed, 07 Aug 2019 19:44:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 03/28] LSM: Infrastructure management of the key blob
Date:   Wed,  7 Aug 2019 12:43:45 -0700
Message-Id: <20190807194410.9762-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <jojn.johansen@canonical.com>
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
index b353482ea348..3fe39abccc8f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2050,6 +2050,7 @@ struct lsm_blob_sizes {
 	int	lbs_sock;
 	int	lbs_superblock;
 	int	lbs_ipc;
+	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
 };
diff --git a/security/security.c b/security/security.c
index 2c0834db7976..7cfedb90210a 100644
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
@@ -307,6 +310,9 @@ static void __init ordered_lsm_init(void)
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
 	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -573,6 +579,29 @@ static int lsm_ipc_alloc(struct kern_ipc_perm *kip)
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
+static int lsm_key_alloc(struct key *key)
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
@@ -2339,12 +2368,21 @@ EXPORT_SYMBOL(security_skb_classify_flow);
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
index 5d74ed35b728..c83ec2652eda 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6353,11 +6353,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
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
@@ -6365,18 +6361,9 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
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
@@ -6394,7 +6381,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
-	ksec = key->security;
+	ksec = selinux_key(key);
 
 	return avc_has_perm(&selinux_state,
 			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
@@ -6402,7 +6389,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
 {
-	struct key_security_struct *ksec = key->security;
+	struct key_security_struct *ksec = selinux_key(key);
 	char *context = NULL;
 	unsigned len;
 	int rc;
@@ -6627,6 +6614,9 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_file = sizeof(struct file_security_struct),
 	.lbs_inode = sizeof(struct inode_security_struct),
 	.lbs_ipc = sizeof(struct ipc_security_struct),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct key_security_struct),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
@@ -6842,7 +6832,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
index 4ac4bf3310d7..7cc3a3382fee 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -386,6 +386,13 @@ static inline struct superblock_smack *smack_superblock(
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
index fd69e1bd841b..e9560b078efe 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4179,23 +4179,13 @@ static void smack_inet_csk_clone(struct sock *sk,
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
@@ -4208,6 +4198,8 @@ static void smack_key_free(struct key *key)
 static int smack_key_permission(key_ref_t key_ref,
 				const struct cred *cred, unsigned perm)
 {
+	struct smack_known **blob;
+	struct smack_known *skp;
 	struct key *keyp;
 	struct smk_audit_info ad;
 	struct smack_known *tkp = smk_of_task(smack_cred(cred));
@@ -4227,7 +4219,9 @@ static int smack_key_permission(key_ref_t key_ref,
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
@@ -4247,8 +4241,8 @@ static int smack_key_permission(key_ref_t key_ref,
 		request |= MAY_READ;
 	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
 		request |= MAY_WRITE;
-	rc = smk_access(tkp, keyp->security, request, &ad);
-	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);
+	rc = smk_access(tkp, skp, request, &ad);
+	rc = smk_bu_note("key access", tkp, skp, request, rc);
 	return rc;
 }
 
@@ -4263,11 +4257,12 @@ static int smack_key_permission(key_ref_t key_ref,
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
@@ -4550,6 +4545,9 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_file = sizeof(struct smack_known *),
 	.lbs_inode = sizeof(struct inode_smack),
 	.lbs_ipc = sizeof(struct smack_known *),
+#ifdef CONFIG_KEYS
+	.lbs_key = sizeof(struct smack_known *),
+#endif /* CONFIG_KEYS */
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
@@ -4671,7 +4669,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
  /* key management security hooks */
 #ifdef CONFIG_KEYS
 	LSM_HOOK_INIT(key_alloc, smack_key_alloc),
-	LSM_HOOK_INIT(key_free, smack_key_free),
 	LSM_HOOK_INIT(key_permission, smack_key_permission),
 	LSM_HOOK_INIT(key_getsecurity, smack_key_getsecurity),
 #endif /* CONFIG_KEYS */
-- 
2.20.1

