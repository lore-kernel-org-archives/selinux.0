Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE4CC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7533120851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="icv0FuRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbfB1WU2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:28 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:36439
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729839AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=emZL0pcrMIen8v9nduBVXLQ5qwmdQMNVPswi+vR0V6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=icv0FuRxNZSVffc2BLYpp19Lo/VT0/rorHx5gRvEmQwBPuebSokFpi15bZHuX/22JDfnPXnJKBKCLweCaZM+ZYJuqshtfLnMLChXDY3kFCTAKLOzra5nJVuYBmLA2jTJqPvjIgiCC8f6mh3Y305HFlbCp1zblCPxO4xGbXUZQ6XLHE6O8s0eKG9gMqfSnadOZQsCycbbb1FX+e5+yU/Epqh3nN6q8iG+5amO5S+yHEqjQbzCj7vWMyKgX9oSbM4VyL8R36EDEg64Qsw1ZvrDAHK67G/0eyTIrmLYGoTaXxsZoEK89A1rdhtJNFA3jgSAQh6fFM+koQhBx2n30us2qA==
X-YMail-OSG: xQFYWtsVM1mcFmeLT1AlPayCGC2Bjv1ippk.SYcBqUBdP21BPcTFcj.o6CsUd1D
 yMQ_L6P.17foBS9xFMB3AlABPUqk_XrYYh9wXFhk_hM_xijOBE_zDeuCiPaq_CKKV996ejrj56Zr
 xuCw93wQBzKixybxu6KUze_qSuA_EfL9XUu7U.XLpZt.HogSqaph_u99qZLhA181tdtnbJ.OeT.B
 EwUbN6.9V5HziHvqqfBuv_K7zGAkWAflZ9iNa49UG6YuGtNGCXCXBN8NsF6OULy_a4QUCR4zGT.S
 DqzB0vrIMsUY1yLxOZM5MeEZlCS0hfrgi1QuY1jXUEGuYYrZWzkw7ZqcuyYt8FAKhT2KlLm22Sdt
 Y0FiKCUt6_Okk.nkfDtaUPcO3Qokj9Em0loD5TcTWFzh4_SUEyzTYmNNFNSDOpv2y3USyQ7hgfh2
 UY.0yKdouhF9COCp0HEr5DpiNv3xeKCu6.xkE2emIRwB5GkhcLpl5rtF3vNjuCkLpg_IVKggEtQp
 cYY39_lraznYLm73WKtry75fHgbPanOaA7qWLG9gLvtw8SSCcNaFiO3biHu.yvt_UjV6TXLv0aaD
 46TUTeXUBdMLdkSqG8LFAGo4uU5IL501OXy1N5p3EXkie2OBLc7nKilYOvl._9qDN3u8EIe.V6Q3
 TcJvaEM_._BlsjSiceOz7DnJ84FQunbiaiTZju_8jIs2EIykHlTLgdJ8tbC9YsLzSzmMdozJmVUV
 K4R7GRtsOvg04dm8I_fSjMuXPA.HzyIX9ih6PhdmR6eM0PRYOgDsTsu1MroF7RcqkYYILgJ8jMVR
 kUXsnwYwofYPsSdMEL75QrXksb.hgoia0RVksNdljMdEWSX.ALX2OULhmPRpDoDFXtLi7Dj8AvuZ
 zg89X3.lrYTT9BZ7uwl1jlsHZEk4wQNkUDUJ6GQ5ofFVtyyQgj.JjoBQrW_RGOqcUh2cGvXSeRdS
 ZRwRZ4tM8zX21sr7Xk1DDclicG.iu3uv.YARu8fN7GkSBiLaVxqCVwuSXBbGSbNNBPI5rAVPi6pw
 dG78UJqb3aiMML3XWnWjOh5rRlBB41Dyf4gCgfwfa7VTQWrE2rqJBmK2Owj4iem_n8pGsCTcoYTJ
 SolQ4z5JjyB2.WR.ERvJeMnxgkjgfS_pxsPUkPVBHfjd1U9o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 62/97] LSM: Special handling for secctx lsm hooks
Date:   Thu, 28 Feb 2019 14:18:58 -0800
Message-Id: <20190228221933.2551-63-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a special set of LSM hooks for the translation
to human readable security data.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 10 ++++++++++
 security/security.c       | 32 ++++++++++++++++++++++++--------
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 84035aea5a2e..fc2a44e04d8e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2020,6 +2020,16 @@ struct security_hook_list {
 	char				*lsm;
 } __randomize_layout;
 
+/*
+ * The set of hooks that may be selected for a specific module.
+ */
+struct lsm_one_hooks {
+	char *lsm;
+	union security_list_options secid_to_secctx;
+	union security_list_options secctx_to_secid;
+	union security_list_options socket_getpeersec_stream;
+};
+
 /*
  * Security blob size or offset data.
  */
diff --git a/security/security.c b/security/security.c
index 257b7ff4b434..217fa9d98699 100644
--- a/security/security.c
+++ b/security/security.c
@@ -431,6 +431,9 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
+/* Base list of once-only hooks */
+struct lsm_one_hooks lsm_base_one;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -447,6 +450,25 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+
+		/*
+		 * Check for the special hooks that are restricted to
+		 * a single module to create the base set. Use the hooks
+		 * from that module for the set, which may not be complete.
+		 */
+		if (lsm_base_one.lsm && strcmp(lsm_base_one.lsm, hooks[i].lsm))
+			continue;
+		if (hooks[i].head == &security_hook_heads.secid_to_secctx)
+			lsm_base_one.secid_to_secctx = hooks[i].hook;
+		else if (hooks[i].head == &security_hook_heads.secctx_to_secid)
+			lsm_base_one.secctx_to_secid = hooks[i].hook;
+		else if (hooks[i].head ==
+				&security_hook_heads.socket_getpeersec_stream)
+			lsm_base_one.socket_getpeersec_stream = hooks[i].hook;
+		else
+			continue;
+		if (lsm_base_one.lsm == NULL)
+			lsm_base_one.lsm = kstrdup(hooks[i].lsm, GFP_KERNEL);
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
@@ -725,14 +747,8 @@ int lsm_superblock_alloc(struct super_block *sb)
 
 #define call_one_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			RC = P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0);						\
+	if (lsm_base_one.FUNC.FUNC)				\
+		RC = lsm_base_one.FUNC.FUNC(__VA_ARGS__);	\
 	RC;							\
 })
 
-- 
2.17.0

