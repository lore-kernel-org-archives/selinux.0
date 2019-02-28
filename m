Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7537BC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37460206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NYYtVxv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfB1WoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:21 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:41840 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728480AbfB1WoU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393858; bh=X8dakGkeNpqur+BQP5PaaGQJmiw+2TNbyOx7dWZIpL4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NYYtVxv79sDcel9zo0Bk2HC78EdMN+YvUWqLZ5JEvShdxy5z1K22lWUV1B2CAX5qJYHTxLfAUmpiTxq+tMXPWuI2UdP1YZ0HtZ79GO8XVqkMxCz9ru1MXzXmB1F/2rGuc8dcIGQzdnIIo4X1jh5ZlnkM1qG379f7qFMPMzTGXdA2DMirEPzmf0Gvt8o6v6WGyuNwBwf8IoID3FwG4eerg4GezH0QM5jJDg/WQEngW/C1cT0pa6aGOBz86CqHmcU82H/isMiYJPwEYr96U8mzz0X7OsZRaDivGyVoSCLMIctmFfHxSdhalBh/5hHH8oaIGTZ0C/rjXzGlYs+BVAQ/LQ==
X-YMail-OSG: QZHTLLYVM1nMZwrUtlLmodjlC4s29QGc2F2PaehC2pIHN47I6__nD9Y3TFhLqSy
 W6u7Ynm1QqtgM652byczGbx1X_UdvaqU4_yoFD4h.Hi_VaWvDPohcrOrvYxHG7l47FFcDYURphfj
 Vb0aql.jaMqnhCuqFSkgyThv8xcSjvXJxJAcIOFY9.LlEhGyjMiw4LIEc47zvNALoxE6FHAnbWBw
 kmakiKjnhoqXyeHOWzF.1qTVwzNTKVByXPXLtJoh.emUO4..ccwiHBD7IOnF0TWvkWuDS1BcHPL2
 4OfoyHfzqYESRVZjZ6LPIIOdz_4c8F85U9O5pswdMfqOdD5R6pwqjN4uPhfOJmq_YdetmTIWc.r7
 OWOVeCw3l2uXHr9bhKclZcDjJhZHQ9PJZ6Uv5.5iof6_E0zFlR5S.STAoHK1.1fB7W.9s7tqdRDN
 gCgLjor4eAocnOrCiByANk5oVwLOyCPAmDZffP4aslutjysL.COQOzJJYnl.6eX72QSvLx7ZIafR
 5xUL6MGW4VHSvEvoUKvMFf3YP0yTLHW9ZURvRrFFq0ulPdp0h8Xdifjxa_s5eI534zGEH7olT_M_
 .ZezB0beQihCSR5IJ4EorRcQrjTA6n3lUd8Ms3KKb8dovGdLweqKWjJo3WyaXVyjfbkXsi87SGD1
 BmbHErpAOExAax4.xwwg8L7qAN2IOvk3deWjzcIcPmoxLx.oS9YcsMp4NKySVTZx.I25blsaI44D
 2IjhO6014amx6Ji7fVTbgaigV2UEqmlsKKyjtdBQHABqnKB0YzTjAI9SdnerX0Z858H.I2Lhx6co
 l_htjMoxODJyzh8jrwppSXQKpZj6gUTyAKQFfmSlfxNRxi07yW.RTbU2KhO2N4YAJZzAeCbJZN1r
 oMec8JO0Wdl2h4AcLKZH8qlDxTD3qklA_C90rZhF69rD5vAQjqO_yQHdnmAflhfl.z11q1PtXN2H
 I0gbcKxoMoSE_E3nVTom3klPhivZkJNB1SNykiqNQNwVEFQcO_RIYhB5vIQb3MkNaiUxyrEVJQ4X
 ZYas7WBBTdddhEVBw7j9KMb.35YYT_xAAMNIt2LjcFK678NON0gJafVKle_XOSxd_eDAgTTsYVBk
 _Z7Hzz8nJdB9JZnsAJHYnAJmG5NwqJT1z6ySEzexpMFEkNzzWPAOcFCUn
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 78/97] LSM: Infrastructure security blobs for mount options
Date:   Thu, 28 Feb 2019 14:43:37 -0800
Message-Id: <20190228224356.2608-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index 4020e13f0669..58e5465fdd79 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2046,6 +2046,7 @@ struct lsm_blob_sizes {
 	int	lbs_key;
 	int	lbs_msg_msg;
 	int	lbs_task;
+	int	lbs_mnt_opts;
 };
 
 /*
@@ -2119,4 +2120,8 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 
 extern int lsm_inode_alloc(struct inode *inode);
 
+#ifdef CONFIG_SECURITY
+void *lsm_mnt_opts_alloc(void);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/security.c b/security/security.c
index 105b5ee22bcf..780c914df9fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -194,6 +194,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 #ifdef CONFIG_KEYS
 	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
 #endif
+	lsm_set_blob_size(&needed->lbs_mnt_opts, &blob_sizes.lbs_mnt_opts);
 	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
 	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
 	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
@@ -328,6 +329,7 @@ static void __init ordered_lsm_init(void)
 #ifdef CONFIG_KEYS
 	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
 #endif /* CONFIG_KEYS */
+	init_debug("mnt_opts blob size   = %d\n", blob_sizes.lbs_mnt_opts);
 	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
@@ -738,6 +740,21 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -941,6 +958,7 @@ void security_free_mnt_opts(void **mnt_opts)
 	if (!*mnt_opts)
 		return;
 	call_void_hook(sb_free_mnt_opts, *mnt_opts);
+	kfree(*mnt_opts);
 	*mnt_opts = NULL;
 }
 EXPORT_SYMBOL(security_free_mnt_opts);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 501aed18f100..e149be6226d6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -381,14 +381,20 @@ struct selinux_mnt_opts {
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
@@ -614,7 +620,7 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 	const struct cred *cred = current_cred();
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	struct dentry *root = sbsec->sb->s_root;
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct inode_security_struct *root_isec;
 	u32 fscontext_sid = 0, context_sid = 0, rootcontext_sid = 0;
 	u32 defcontext_sid = 0;
@@ -629,7 +635,8 @@ static int selinux_set_mnt_opts(struct super_block *sb,
 			   server is ready to handle calls. */
 			goto out;
 		}
-		rc = -EINVAL;
+		/* Don't set any SELinux options. Allow any other LSM
+		   that's on the stack to do so. */
 		pr_warn("SELinux: Unable to set superblock options "
 			"before the security server is initialized\n");
 		goto out;
@@ -953,16 +960,17 @@ static int selinux_sb_clone_mnt_opts(const struct super_block *oldsb,
 
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
@@ -1015,10 +1023,8 @@ static int selinux_add_mnt_opt(const char *option, const char *val, int len,
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
@@ -2583,10 +2589,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
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
@@ -2609,7 +2613,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 
 static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)
 {
-	struct selinux_mnt_opts *opts = mnt_opts;
+	struct selinux_mnt_opts *opts = selinux_mnt_opts(mnt_opts);
 	struct superblock_security_struct *sbsec = selinux_superblock(sb);
 	u32 sid;
 	int rc;
@@ -6532,6 +6536,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct key_security_struct),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct selinux_mnt_opts),
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 	.lbs_sock = sizeof(struct sk_security_struct),
 	.lbs_superblock = sizeof(struct superblock_security_struct),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index c84c71a31b80..f1e0f1378666 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -573,26 +573,33 @@ struct smack_mnt_opts {
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
@@ -654,7 +661,6 @@ static int smack_sb_eat_lsm_opts(char *options, void **mnt_opts)
 				kfree(arg);
 				if (*mnt_opts)
 					smack_free_mnt_opts(*mnt_opts);
-				*mnt_opts = NULL;
 				return rc;
 			}
 		} else {
@@ -697,7 +703,7 @@ static int smack_set_mnt_opts(struct super_block *sb,
 	struct superblock_smack *sp = smack_superblock(sb);
 	struct inode_smack *isp;
 	struct smack_known *skp;
-	struct smack_mnt_opts *opts = mnt_opts;
+	struct smack_mnt_opts *opts = smack_mnt_opts(mnt_opts);
 	bool transmute = false;
 
 	if (sp->smk_flags & SMK_SB_INITIALIZED)
@@ -4501,6 +4507,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
 #ifdef CONFIG_KEYS
 	.lbs_key = sizeof(struct smack_known *),
 #endif /* CONFIG_KEYS */
+	.lbs_mnt_opts = sizeof(struct smack_mnt_opts),
 	.lbs_msg_msg = sizeof(struct smack_known *),
 	.lbs_sock = sizeof(struct socket_smack),
 	.lbs_superblock = sizeof(struct superblock_smack),
-- 
2.17.0

