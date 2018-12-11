Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3F9C6783C
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF81220851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="meeH0ZEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF81220851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLKWo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:56 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:46051
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbeLKWoD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568241; bh=LLC+kO5vVrGkpb8+XiusWEcN5YP2bfPWb69cQmSh7Xk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=meeH0ZEar7aeARk5FqNL7Bv39W19/+SxPw3xxNhbUkSSknyR7gpZL0i98K1MLXuk2SrB2Bht+bVdXCAhU4sRychuQf6KhimhKxGJ9vX9xejE27RomzBwaTmR8uCgJ4tE5o9OS46OLxOzH98yCgBPZ6J3ujsUFiTADOJkLa1Hrwj0TLWck6ilBLF8ZVshtH2TmqiJEBszkWz+qHLxbOHhG6gqhnxF8gFpKdtSZ5L0iZIL62Ma6ycCT/4iA4WbP2WiaRyan9XEzAm7GYKb9hwO7xiONwWnlm4a23OaZeHye+ltZVo/pl55chip64K7aJV1j4iSfFmJ5gggNLOeGMungQ==
X-YMail-OSG: ojkgujIVM1kmf0AOkoMbigeSSVg_WLO2MZy5gcP6TOxgALnncmK5Y80URoZROBm
 TtJk5_z6_qtLJqrX7C1FG7H7lw5n86jSV7IaXf_5n4mi5NmraCrbWYPjlUwL2CkIPzmY.bCfIwGz
 0Y2.js0fKW7xZS2c_n_UkpXrCBx62Abgad6I8dn4QCucIPvy7K8goqYKG_8pzGruUCVcNWpwZHCa
 wkSM7ZeIU3CuLEb.xh8u25b3Y4hBHG_QNOYmWJsUj_x84iioywqd04WAcvEg8vqPWXECo6p5YXeW
 1mhxJghXHXYw9YHYCscua31jDV7qg7IObLMGWgNns_SeWUAORIAx8Bv7tIDA_wTqquM_lh8eEbIq
 JY7w3bL_NYti9uGLQm0fVhj8d1CzwJRFDgXWy4Wof9iIsJSVNHrKF7v2cn35CwhOsCpWHPIlfO5T
 VuTrQ9Tl8.dnIgRSJE0W9pfHpwjfbjKWbZ9OJPTRDw3kTanwStJ78fku2Ir0OLklQnFt2ttRC1bL
 oKZCFpnn.JQ8iNXpeetQwfV3oGt6yTLkdBwmtdzaREAw5OF38PYDMeMltamKL6EN0TP4YKQS.MgS
 d9F3IhcF1Ljl.cN6oICmid.fxKfFW_IC8RbR_4x77gOhJdCyd0b8yW2hL6aZ9JgdhTOXxKKPXVoR
 vJ4DQJP8.pd3qdhwyD8x5WFFeq4SPModu_1kp2MC_2sdKjn1u58FUx.lyz6nrkfyxdigZefmNOTC
 N6i12tUF8Dsi41h9_hBcJrMq3Lz0Avi_LBVncssSlfkExedkMQvZuSKTZOS1xA6x4kSpr2HItiPh
 7m.ZdwwB2NfYdwZ9POJr9d7ToeOcbIWR9vjn.vy0yAq.8v3Re8.nr4KlRr9xxlEQbJTBcW_3HwsF
 4FZ.ok5kTbhp3eqFLpTN87IjEYrh1khzzv3UO_9vrN.bQ2_nSoM0AV7pEERCchb0KQwqzEMPQ1TP
 1UbQojJFttLUj63DBSKdoOWW99wJwWX.4HARhlbm3mH6oPsyMyP8tNWAWQhU9PCoVCkNAS6YMf_6
 nZUD5rZEC32nEGk0Jd6xpO_60z3QrcjXFqrwHY1xPAkpeEeKWf1ds1ZYsmDWeUn5G8f7yHq1p.R6
 ccybx5k1pGuak.jPqjywuWShXjMYQsHFQ280NPw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:01 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:43:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 30/38] LSM: Infrastructure management of the file security
Date:   Tue, 11 Dec 2018 14:43:06 -0800
Message-Id: <20181211224314.22412-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move management of the file->f_security blob out of the
individual security modules and into the infrastructure.
The modules no longer allocate or free the data, instead
they tell the infrastructure how much space they require.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h         |  1 +
 security/apparmor/include/file.h  |  5 +++-
 security/apparmor/lsm.c           | 19 +++++++-------
 security/security.c               | 54 ++++++++++++++++++++++++++++++++++++---
 security/selinux/hooks.c          | 25 ++----------------
 security/selinux/include/objsec.h |  2 +-
 security/smack/smack.h            |  3 ++-
 security/smack/smack_lsm.c        | 14 +---------
 8 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c9458280214e..64499c2d44cd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2029,6 +2029,7 @@ struct security_hook_list {
  */
 struct lsm_blob_sizes {
 	int	lbs_cred;
+	int	lbs_file;
 };
 
 /*
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 4c2c8ac8842f..8be09208cf7c 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -32,7 +32,10 @@ struct path;
 				 AA_MAY_CHMOD | AA_MAY_CHOWN | AA_MAY_LOCK | \
 				 AA_EXEC_MMAP | AA_MAY_LINK)
 
-#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
+static inline struct aa_file_ctx *file_ctx(struct file *file)
+{
+	return file->f_security + apparmor_blob_sizes.lbs_file;
+}
 
 /* struct aa_file_ctx - the AppArmor context the file was opened in
  * @lock: lock to update the ctx
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 70669e676212..3ae8c902d740 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -433,21 +433,21 @@ static int apparmor_file_open(struct file *file)
 
 static int apparmor_file_alloc_security(struct file *file)
 {
-	int error = 0;
-
-	/* freed by apparmor_file_free_security */
+	struct aa_file_ctx *ctx = file_ctx(file);
 	struct aa_label *label = begin_current_label_crit_section();
-	file->f_security = aa_alloc_file_ctx(label, GFP_KERNEL);
-	if (!file_ctx(file))
-		error = -ENOMEM;
-	end_current_label_crit_section(label);
 
-	return error;
+	spin_lock_init(&ctx->lock);
+	rcu_assign_pointer(ctx->label, aa_get_label(label));
+	end_current_label_crit_section(label);
+	return 0;
 }
 
 static void apparmor_file_free_security(struct file *file)
 {
-	aa_free_file_ctx(file_ctx(file));
+	struct aa_file_ctx *ctx = file_ctx(file);
+
+	if (ctx)
+		aa_put_label(rcu_access_pointer(ctx->label));
 }
 
 static int common_file_perm(const char *op, struct file *file, u32 mask)
@@ -1155,6 +1155,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
  */
 struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
+	.lbs_file = sizeof(struct aa_file_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index c49d4a18c75f..499842ece0fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -40,6 +40,8 @@
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
+static struct kmem_cache *lsm_file_cache;
+
 char *lsm_names;
 static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
 
@@ -158,6 +160,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 		return;
 
 	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
 }
 
 /* Prepare LSM for initialization. */
@@ -279,6 +282,15 @@ static void __init ordered_lsm_init(void)
 		prepare_lsm(*lsm);
 
 	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
+
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		initialize_lsm(*lsm);
@@ -448,6 +460,27 @@ void __init lsm_early_cred(struct cred *cred)
 		panic("%s: Early cred alloc failed.\n", __func__);
 }
 
+/**
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
+ *
+ * Allocate the file blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+static int lsm_file_alloc(struct file *file)
+{
+	if (!lsm_file_cache) {
+		file->f_security = NULL;
+		return 0;
+	}
+
+	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
+	if (file->f_security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1131,12 +1164,27 @@ int security_file_permission(struct file *file, int mask)
 
 int security_file_alloc(struct file *file)
 {
-	return call_int_hook(file_alloc_security, 0, file);
+	int rc = lsm_file_alloc(file);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(file_alloc_security, 0, file);
+	if (unlikely(rc))
+		security_file_free(file);
+	return rc;
 }
 
 void security_file_free(struct file *file)
 {
+	void *blob;
+
 	call_void_hook(file_free_security, file);
+
+	blob = file->f_security;
+	if (blob) {
+		file->f_security = NULL;
+		kmem_cache_free(lsm_file_cache, blob);
+	}
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -1254,7 +1302,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(cred);
 	return rc;
 }
@@ -1275,7 +1323,7 @@ int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 		return rc;
 
 	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
-	if (rc)
+	if (unlikely(rc))
 		security_cred_free(new);
 	return rc;
 }
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ce1d37378eb5..9669a059ce0f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -145,7 +145,6 @@ static int __init checkreqprot_setup(char *str)
 __setup("checkreqprot=", checkreqprot_setup);
 
 static struct kmem_cache *sel_inode_cache;
-static struct kmem_cache *file_security_cache;
 
 /**
  * selinux_secmark_enabled - Check to see if SECMARK is currently enabled
@@ -377,27 +376,15 @@ static void inode_free_security(struct inode *inode)
 
 static int file_alloc_security(struct file *file)
 {
-	struct file_security_struct *fsec;
+	struct file_security_struct *fsec = selinux_file(file);
 	u32 sid = current_sid();
 
-	fsec = kmem_cache_zalloc(file_security_cache, GFP_KERNEL);
-	if (!fsec)
-		return -ENOMEM;
-
 	fsec->sid = sid;
 	fsec->fown_sid = sid;
-	file->f_security = fsec;
 
 	return 0;
 }
 
-static void file_free_security(struct file *file)
-{
-	struct file_security_struct *fsec = selinux_file(file);
-	file->f_security = NULL;
-	kmem_cache_free(file_security_cache, fsec);
-}
-
 static int superblock_alloc_security(struct super_block *sb)
 {
 	struct superblock_security_struct *sbsec;
@@ -3559,11 +3546,6 @@ static int selinux_file_alloc_security(struct file *file)
 	return file_alloc_security(file);
 }
 
-static void selinux_file_free_security(struct file *file)
-{
-	file_free_security(file);
-}
-
 /*
  * Check whether a task has the ioctl permission and cmd
  * operation to an inode.
@@ -6857,6 +6839,7 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
+	.lbs_file = sizeof(struct file_security_struct),
 };
 
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
@@ -6927,7 +6910,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
@@ -7112,9 +7094,6 @@ static __init int selinux_init(void)
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL);
-	file_security_cache = kmem_cache_create("selinux_file_security",
-					    sizeof(struct file_security_struct),
-					    0, SLAB_PANIC, NULL);
 	avc_init();
 
 	avtab_cache_init();
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index e0ac2992e059..96374dbf4ace 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -167,7 +167,7 @@ static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
-	return file->f_security;
+	return file->f_security + selinux_blob_sizes.lbs_file;
 }
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 50854969a391..2007d38d0e46 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -364,7 +364,8 @@ static inline struct task_smack *smack_cred(const struct cred *cred)
 
 static inline struct smack_known **smack_file(const struct file *file)
 {
-	return (struct smack_known **)&file->f_security;
+	return (struct smack_known **)(file->f_security +
+				       smack_blob_sizes.lbs_file);
 }
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3e11be8cce7e..c560cb8e155c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1579,18 +1579,6 @@ static int smack_file_alloc_security(struct file *file)
 	return 0;
 }
 
-/**
- * smack_file_free_security - clear a file security blob
- * @file: the object
- *
- * The security blob for a file is a pointer to the master
- * label list, so no memory is freed.
- */
-static void smack_file_free_security(struct file *file)
-{
-	file->f_security = NULL;
-}
-
 /**
  * smack_file_ioctl - Smack check on ioctls
  * @file: the object
@@ -4637,6 +4625,7 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 
 struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_smack),
+	.lbs_file = sizeof(struct smack_known *),
 };
 
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
@@ -4674,7 +4663,6 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_getsecid, smack_inode_getsecid),
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
-	LSM_HOOK_INIT(file_free_security, smack_file_free_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
-- 
2.14.5

