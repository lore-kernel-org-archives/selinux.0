Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C933DC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97602217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TD8b2eBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDSAsg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:36 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:43736 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbfDSAsg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634915; bh=mIUpIvzdXdT+Bhe9HVyLHFmBoIk5UXgAItDFEpi4VkQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TD8b2eBYAEum0r5FJgY1+91qCCrnZZf1Xjd3eEQ1jIhfaXKRQ7sCzY8DlG71SvTNs8OnvC4vH/0aWVCwmJ/EWJqKsRYqfc4YCzfTHH+hzMaBGTisOa9ftIKhlEOV2yZ/cZRkJawpcEfyqYPWdvPVF/adLS8SEs0jBXO2T0fNfssXhPNQbwZTpiZGLXxfYGiHMF7Q1sRhOhrpyRAkt7isnshn1Srb88EsQSIpCiliSPIw6SjT82hMMtIecjSoEIHfZsbBtHB+1D4E6fX6JKfWbFWMZxq4lONn6np1f6RIDXiNUOV4b0GARO8RZdKChas6cg2GNd9pJktr6fTWnm/xGQ==
X-YMail-OSG: mu8mkSgVM1kXYF2bOZLnDkb_EHnGqeaYie9Q8eLRyROIhjUwGHJMKZ5zW9mudgz
 bRFV_rJ5CE4AtKjcZZg0umejAL64kxEeM0AG2UiBG0.tO9KC.Mtk9BN4bwEEUXUho6r2PXv5EiRv
 J7OPmd28NEGV2kdqSdHz0w7IOQvjdBKP.Y3Dtv3SyVnJst9GXXMn3Wb9S7zKjyWWaqxdxPXqI.Ky
 RQdAdtt20a4zMAfrAm.W5Flmpwf9ixwL1BFJw7B0V1EtLud9dSuxK7rGv8Grp1yc4QW9GXEvHp29
 AKOMK967282RVlPMxLsmry_nJZMLWhXb0VoGqC9TWUFbJWV6yfjG92.OK.UtSslAcaZJ40a4jo6y
 Ey7SQiTpr2nimRuF3TG9kczabarzCKk.vIZkeMWtcuHVsLKckCkMbg1r3_v7WYRg6boYJ0KJ6_58
 sUQyROIzUNCGD37CgchfrfN0flV9AmKYFGvE9RbkTeKb.4zVGZkqunZYz_hkLRHsYJkjwnPRjFxb
 kny5kidnWksHJzZnB8jdbPSwD8u7l2R0o0ZXTHkyfmFmqohLKeBNf7QAL7VSRPSWcavQZBV9Obgm
 a9Yx3HfLjzc5qqCHKZz5VWAAwQmaBZBf.iUDlV.jMeLobqYMwKBV1LM4zVd0wI755wLBlYp10Rpf
 cuu9CgkG_Uq2NGz.msfzL3TpvDz2tw6_THfue0TMPOrMWoKAU0v5iB3ZUc1Juz5qOtR1APewJ202
 EyG0H5z6b59e6NTqsFSycqDUruNxPvL7kjTS9WpIIOGKQGjbns5Eb_iDQu8Ox2k.8KRYI_xMdA5q
 _tpSRfHbPVPgIc1irtT2Tgi5muLq0xP57nATQ7wtt81YpgkXRaQta4WWFcH.mt6GNHbVZwVL3Jxa
 q7qJamY_lIWETtGc4KptuSvsHAsavy5JefGPoq592nnmXAxnGUKc7_.MYEY4HUjOMFyZNaNG6lt.
 oc2lhhygkNpXt9EkmbOWmP5ae.3iEiD9OxR8.EpVlvvu4Fahto0f7UYNQHrji_E392SFz82IrlFz
 jYxiZNxnei0QoXxG50X1sNxoN7GPXJyuOrvsaUBL3xeRHyAPVTw7K0VqA7PICKVnLyEaIInnhULq
 fYYcYPpjTJljFsax6hlV09yUukzNOlAPFxuZdy3aoUbn.vNaGrz0Rk7QaUtyWvHn.DqMpAzPkh56
 Cmi9_98wNG.zz.w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:35 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 828306e040049ab0082b23fbf6722cca;
          Fri, 19 Apr 2019 00:48:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 56/90] LSM: Special handling for secctx lsm hooks
Date:   Thu, 18 Apr 2019 17:45:43 -0700
Message-Id: <20190419004617.64627-57-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index 014791349bbd..0653f295897a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,6 +2040,16 @@ struct security_hook_list {
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
index ae43735575d6..b05265ec24f0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -420,6 +420,9 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
+/* Base list of once-only hooks */
+struct lsm_one_hooks lsm_base_one;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -436,6 +439,25 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -714,14 +736,8 @@ int lsm_superblock_alloc(struct super_block *sb)
 
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
2.19.1

