Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF89C433FF
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F7421743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qep4eTgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbfHGWnF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:05 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:38785
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388681AbfHGWnF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217783; bh=+C9k0HtbRZZvcGeY/seczH/hhVIlVPgfLu6ERMCE/ew=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qep4eTgwlJV03g0gDqyPIKGGLrYgqHjrcD0pMKkpwov4YIjeaALbrQAmhNSopKn/31Ss/Q4VmLNOk3s+cJUkJHSR+JO5Agu1fnvzUKFJTl6FK52jLb04I5lOQbiOnCyOYu3lKxT1F50/DGoV4t+NopcFwlYqa5hC1ebNeIWy8g9lnBO9nmcbsla+v1yJ+PeOUx4Z4FO7+S+5swHk47LNfFepvkkVjMCGAGMCQGIPVE9SY6Ccql0/mFh6mOUimV9E/FbBPswJ1tiprqyGHPUeNa1p4vxaM59ImFZymSzooG1Hi8uHKJihwq0P2E8dTNVrRmpoosKy9wHND5+huuhtZw==
X-YMail-OSG: .vd5G_YVM1mzyi6gxT8nyrNZ_VRmIiHu2LvasaP7P3nNOZqjWZQPDS_r7lV5f6m
 QpXo_9HyfSc8gDM3zVNaD_bH2MpfQ45vAdrH289l9yO6u.jcEinKmtB0KdQagNS8SGwtrK.RkwgG
 OuNiskLJ7yrrRKQAdxVMZU7lOBQKnbgtcDYNP_ezrD8xHGArjBdMFYRusMeiASGZ7hFTcIYFxg2T
 .cY.eqV7hx41OaHqkdjH.hl4yNZ8iztNJNEtD9_nSfDAuPuQ4UNb8aSQmQvsSSJecaCyCVTcZY5x
 1QhkEUQ.0ULWtNcjDknQyn0hvIc72qgytzJxMZeL1tSevKpZ4eGz20sVvZA5Ut0IsE6J9SBxaDNi
 NCuRSiYgqmrtNkh26_lqLFDUczxgamQUDwl_9_nEdLu5j4wkBvGHGuSpGm0BmSDgEqFHEr_WJpuO
 8QCl7h9qAaEZzsh8cawzmVvkFGMt40UfjhwNerRx7F9pquDiU_xWWGfOFnf0nngz1VeJi_EnONo7
 iGon672fKcC8lntCXBNPzJqJE2jxdlLH_p7W5sPpph8c0AGgixfCuag1mkQFtnmX7Y_Wd8Uv0u5I
 Xc_p5pZXDXDzFEgX_Sh749oKfLh5FYd7VaN4iiIu4JVru84zI3xljjwnocV3D27FqboCE5PY6_Hw
 uXBVEn89HwGBeC_Hrdya5_gXwIG3mwtm1tCG0tycj1aSZiWopvlX6_ztYHOlFKwulSPhPf5jfe0Q
 hYMhIxp99B9LjOV52eJOsTezfVDufKsWwJ3OQbcfGgrIndiEX5wYvY0aiLEgQcv.WIt.uNQJZijK
 SI8sfTnGOXs8qj_WBS4F4smgJ0hxCcU773tyZu4PbbEUqHaQF7sMXqc6cwNmwIyXQbhsWTOU3YtN
 scODkv2Du7OEyZpEfz6Ara4gGKIbYByR9z919BfyrjtnqoVKFKMmIlhaeY9RtKem9l.NJ0C.bL1m
 jufQNslWmkR.E0q9LWIZLwN_NQGgMxTU7s8AKGkrOkAb9RwuoLHE81bK5YO1Nwwsi2JsJiWoq1q_
 XBISRJoZ52esVLiJ9ac9jywDyhlXvlskPWoNKQuooQnFSmZsaMtI6g2C1eclkwl4OntDxAlBueF4
 owfiN_lKhBLPhiL_SEay83yN1H7bV1WhdYRmK6LR2HAvzcEWrAEQucksGhze85nLQnlwVFN2oZLD
 czqXQcyU5yD9dyi90UXc_VYdWofY2hlfTFD39EtOxa_lrvrGtTbnJPtOIhXh2VYemAZy5u5vMT8W
 LwLOcgHXN6zZueJZ6eNQzOS.WWWG7NZi8NMxDK_6Ol1q6aHOKHtAxq51oSR9Jff8trFaCDP6gX1f
 Mu0VaUQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:03 +0000
Received: by smtp406.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a922c1f55dc5f6c930e3c4333b468534;
          Wed, 07 Aug 2019 22:43:01 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 08/16] LSM: Infrastructure security blobs for mount options
Date:   Wed,  7 Aug 2019 15:42:37 -0700
Message-Id: <20190807224245.10798-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Manage LSM data for mount options in the infrastructure
rather than in the individual modules. This allows multiple
security modules to provide mount options.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  5 +++++
 security/security.c        | 18 ++++++++++++++++++
 security/selinux/hooks.c   | 31 ++++++++++++++++++-------------
 security/smack/smack_lsm.c | 19 +++++++++++++------
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b0f788bf82b6..a54a2f4788af 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2060,6 +2060,7 @@ struct lsm_blob_sizes {
 	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
+	int	lbs_mnt_opts;
 };
 
 /*
@@ -2148,4 +2149,8 @@ static inline int lsm_task_display(struct task_struct *task)
 	return LSMBLOB_INVALID;
 }
 
+#ifdef CONFIG_SECURITY
+void *lsm_mnt_opts_alloc(void);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index e3ea48c87dba..6dbc7ed2a00d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -183,6 +183,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 #ifdef CONFIG_KEYS
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
+	lsm_set_blob_size(&needed->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -321,6 +322,7 @@ static void __init ordered_lsm_init(void)
 #ifdef CONFIG_KEYS
 	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
 #endif /* CONFIG_KEYS */
+	init_debug("mnt_opts blob size   = %d\n", blob_sizes.lbs_mnt_opts);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -779,6 +781,21 @@ static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
 	return 0;
 }
 
+/**
+ * lsm_mnt_opts_alloc - allocate a composite mnt_opts blob
+ *
+ * Allocate the mount options blob
+ *
+ * Returns the blob, or NULL if memory can't be allocated.
+ */
+void *lsm_mnt_opts_alloc(void)
+{
+	if (blob_sizes.lbs_mnt_opts == 0)
+		return NULL;
+
+	return kzalloc(blob_sizes.lbs_mnt_opts, GFP_KERNEL);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -974,6 +991,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 021694b4aca7..65bd62dca9e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -383,14 +383,20 @@ struct selinux_mnt_opts {
 	const char *fscontext, *context, *rootcontext, *defcontext;
 };
 
+static void *selinux_mnt_opts(void *mnt_opts)
+{
+	if (mnt_opts)
+		return mnt_opts + selinux_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void selinux_free_mnt_opts(void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	kfree(opts->fscontext);
 	kfree(opts->context);
 	kfree(opts->rootcontext);
 	kfree(opts->defcontext);
-	kfree(opts);
 }
 
 static inline int inode_doinit(struct inode *inode)
@@ -638,7 +644,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sbsec->sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -653,7 +659,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			   server is ready to handle calls. */
 			goto out;
 		}
-		rc = -EINVAL;
+		/* Don't set any SELinux options. Allow any other LSM
+		   that's on the stack to do so. */
 		pr_warn("SELinux: Unable to set superblock options "
 			"before the security server is initialized\n");
 		goto out;
@@ -980,16 +987,17 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
 static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct selinux_mnt_opts *opts = *mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(*mnt_opts);
 
 	if (token == Opt_seclabel)	/* eaten and completely ignored */
 		return 0;
 
 	if (!opts) {
-		opts = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
+		opts = lsm_mnt_opts_alloc();
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
+		opts = selinux_mnt_opts(opts);
 	}
 	if (!s)
 		return -ENOMEM;
@@ -1042,10 +1050,8 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
 	rc = selinux_add_opt(token, val, mnt_opts);
 	if (unlikely(rc)) {
 		kfree(val);
-		if (*mnt_opts) {
+		if (*mnt_opts)
 			selinux_free_mnt_opts(*mnt_opts);
-			*mnt_opts = NULL;
-		}
 	}
 	return rc;
 }
@@ -2645,10 +2651,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
 				kfree(arg);
-				if (*mnt_opts) {
+				if (*mnt_opts)
 					selinux_free_mnt_opts(*mnt_opts);
-					*mnt_opts = NULL;
-				}
 				return rc;
 			}
 		} else {
@@ -2671,7 +2675,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	u32 sid;
 	int rc;
@@ -6640,6 +6644,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct key_security_struct),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f253d569dee6..a9fb5f53a248 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -557,26 +557,33 @@ struct smack_mnt_opts {
 	const char *fsdefault, *fsfloor, *fshat, *fsroot, *fstransmute;
 };
 
+static void *smack_mnt_opts(void *opts)
+{
+	if (opts)
+		return opts + smack_blob_sizes.lbs_mnt_opts;
+	return NULL;
+}
+
 static void smack_free_mnt_opts(void *mnt_opts)
 {
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	kfree(opts->fsdefault);
 	kfree(opts->fsfloor);
 	kfree(opts->fshat);
 	kfree(opts->fsroot);
 	kfree(opts->fstransmute);
-	kfree(opts);
 }
 
 static int smack_add_opt(int token, const char *s, void **mnt_opts)
 {
-	struct smack_mnt_opts *opts = *mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(*mnt_opts);
 
 	if (!opts) {
-		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
+		opts = lsm_mnt_opts_alloc();
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
+		opts = smack_mnt_opts(opts);
 	}
 	if (!s)
 		return -ENOMEM;
@@ -724,7 +731,6 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 				kfree(arg);
 				if (*mnt_opts)
 					smack_free_mnt_opts(*mnt_opts);
-				*mnt_opts = NULL;
 				return rc;
 			}
 		} else {
@@ -767,7 +773,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -4561,6 +4567,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct smack_known *),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
-- 
2.20.1

