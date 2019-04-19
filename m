Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4746C282E2
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A066620656
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="prcoC2/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfDSAtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:13 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:39210 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfDSAtL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634950; bh=NzIbNj3420MeAfnn4NhgXXttfOBB14E8Boq0C6nczTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=prcoC2/iCKF+27jb05Rbk4mayV4i8GbD1ObfHAJmCFLDNFtsevmeOxSYqVzG+NPQqiN7+qhNIBfvCfuIAx7gXib+E7eQ5S8HU6CWNTY+4m21znthOpt7Iznpk7OIUFPjRqIRBOerJDy8LMCR4UxMOzynxkjK8lFhIQDuezD6h87um3PX4MWIcA/W9fNhqP1YkQf8tQTUfJ65rOrSlRrVUdD54ZLt/EZFqbKe+6tFx3NOEkaAJWFiB8AswZO9lrZa2uWmSOgJ+zhRao8T5c22H02KNkPpKf1YBVZHj4wsQ7+PTDohYjuqywU2Uvq9WcOH5MSUpK6rU+1L/PiN8VeKEg==
X-YMail-OSG: vYUajbMVM1ly1OonIjcNznEpUadDEAXSA6rn7P9Vh8mh60HjN4qZb8aAfT5yqTT
 8DGUCUbFW_NrLFRPUsaT58oAnQN9M8r.mYWdbsW0i5qvg7DlU7c3NGOLP2NiQudeg0KmFpuT_dPu
 2oCps96.w5zy.olzf.WVSQ5HEVrFKL.GMdj4k1tK4UQZ4j.UNQ0v0gqHuzPmJIWZh5JzESe02crK
 FToIbyaxAUS_uqpxwc6UZFg6y2WwiZfj9N2Zs99a.2IBJY8KFvTFJoRoqa0eOLVzAJs33N.dBhYz
 eru23dWuvsBi3SHDMpdxYKRgq88j_Dub5RODLKRt4z5uYi89QtnIkvOl30WvjzZLoam3C3eNXeDB
 nOJRGDUsNLywLb07jB41lFX05R05z9ZGV3jgMKPsPMMWPRDdvdDcyzOSmkoZVhbDlIqrJFN82xjf
 Gn1UO1YZKnxdwxkCbVumXKElmQwBuuSL5zWEe6c2rtsd9YGOXocWash7VbEK9lEiaaGQdVT4KAoA
 oBzTIG._I_4LOLZ1YGua.I.YY3mrNZaHZ9M6CBBlXJd1W0X4jhy6cQu1eHy4doJ6uQXhjeh9K2sR
 Wler9sAJmCN8WyRP.rvaYnPtoYZhqkuaGatXe2ss1A9G4ydrrNg8XWWM8Bdj.l3DXsq5nue5vLrc
 TITpS_k8VDthRYZTZfQYBg1KHz4HMzFquEFo20wdVpI4G3EffyQ6x_UYPzhOAOtsp4JryDokEgY5
 s5nv1JV7MiLIazHQ370FB5DI74dffPVqOef7UR.Lo5pWlM6awolPeNph0wsbq0NEKBbaFkE0ohxz
 yD3KhLv_SrqZ7QFyJnzlQA4Xm6chgdohYYeFrE9T_WiAJoalbDrDu1pSPg1D1qhAe1Mbj31Hepmx
 7p33IRG1saEnaTaJTEhB9qop_PJB265rDxCrb6tCDu5EORmU1Oe9giRipwLysLJASzYFMWaWrd90
 xnrOcXeqP_IAkSenyBDyId7N0KVSW6e_dyAqT71F7CXjPB9.1TputkmMf4vG6BJ5mxZGKUNKFMnt
 I0gNK917yS9T4THPqExwRtYNnGcCrqCLiAS8ChmPU8hDeXucsn81n4rj5aPUv7TsIHCTNuxyFywt
 2sLb95gAwI4ZlctPtk.cMCUAE2djA92ejTUR2.nncVPmd5V2efNSYwkLjt3Yz7uIVq9nKwuwAqx6
 LGi6tArg_mYtq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 524225efee00edb3a1e75559f6c5c8ed;
          Fri, 19 Apr 2019 00:49:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 71/90] LSM: Infrastructure security blobs for mount options
Date:   Thu, 18 Apr 2019 17:45:58 -0700
Message-Id: <20190419004617.64627-72-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Manage LSM data for mount options in the infrastructure
rather than in the individual modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  5 +++++
 security/security.c        | 18 ++++++++++++++++++
 security/selinux/hooks.c   | 31 ++++++++++++++++++-------------
 security/smack/smack_lsm.c | 19 +++++++++++++------
 4 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5135b8d1d759..34f98cfe2ffd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2066,6 +2066,7 @@ struct lsm_blob_sizes {
 	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
+	int	lbs_mnt_opts;
 };
 
 /*
@@ -2139,4 +2140,8 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+#ifdef CONFIG_SECURITY
+void *lsm_mnt_opts_alloc(void);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index f1e2ffe81829..63b001e60b59 100644
--- a/security/security.c
+++ b/security/security.c
@@ -177,6 +177,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 #ifdef CONFIG_KEYS
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
+	lsm_set_blob_size(&needed->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -315,6 +316,7 @@ static void __init ordered_lsm_init(void)
 #ifdef CONFIG_KEYS
 	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
 #endif /* CONFIG_KEYS */
+	init_debug("mnt_opts blob size   = %d\n", blob_sizes.lbs_mnt_opts);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -726,6 +728,21 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -939,6 +956,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 17ba47f9f4e2..86578f7de131 100644
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
@@ -2611,10 +2617,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
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
@@ -2637,7 +2641,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	u32 sid;
 	int rc;
@@ -6641,6 +6645,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct key_security_struct),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0e2f68e5b895..3fd46cd2c4b1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -574,26 +574,33 @@ struct smack_mnt_opts {
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
@@ -741,7 +748,6 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 				kfree(arg);
 				if (*mnt_opts)
 					smack_free_mnt_opts(*mnt_opts);
-				*mnt_opts = NULL;
 				return rc;
 			}
 		} else {
@@ -784,7 +790,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -4586,6 +4592,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct smack_known *),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
-- 
2.19.1

