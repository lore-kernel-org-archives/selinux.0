Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC61C67869
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1292C20870
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qUnb0x5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1292C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLKWnc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:32 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:40846
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726346AbeLKWnb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568210; bh=wFIQYZ3HEnVEK848nF65xZO1MyZAz7Uo0oMwuViToQY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qUnb0x5LDFV/elBxUF6Mijy9MyaAmQayyJSU1/gtwU9U8TVnIJynCvp3buk89bfEwbFQRiAHQG8I2Bs2GJPdrvoFDy7gdmSePpL/9q8Nm6YF089u8dzYV7KW555ZYsfpzvOZmUKqQYNTooNEHMSwBXcsT1iYACUH43z7ZVZDmiz5SU3MtBjwEDlY4joqEOKso9Wlat2tIsRElcFQYwsE2RQSH3dtjLdlw7bzI9OLATJlW8CVZd9Joo459GzL8c3QZ8MbEm3mxP1bmAfwPXn75YFMZq2k5YFW3eXc+M8ec9kA2Txm75Xdm4fLyLPTVhkPLBZbqhKy1e2CQEV9lNpapg==
X-YMail-OSG: 9MVgeJkVM1nOQgjXi9JM_WPV.FbgXAwgESQR65NWGUdaEUUz.uuKvvmyRbzKE6A
 5AssK2h7XnynZy2hCQFL8GJjfuZkL2_YAUQ.j6qrP6SiN.n2I7TRH3JZCvAPeAiezMwxFn2br1d2
 WvxmWLjRwNecFe2aJAwmk89D7zXakgqxYwpwEch5M9dDXPRl627hvS0weQGW5Anr.2SiV_yAu6fQ
 yjQ1KQ.THxDOqhEqQGFxPWz1aATinwdZOKaUq5CKBBghAILTewPTd8U2ypCmOCX7zMySoY.vIHPY
 TA5SxYHP_oBPFTKPTongpDhZrnGf4592i6XQ6BaTSHcYKu2BcBE.Ezpyl2X94Qp..b5vcvzVWIIK
 I2AFz6CU__eQNaeXUA4yRxSadGTwbnea1rBcLev._NZvNlmUqDgJGvNj8i6se37ttEugnvrnsdCG
 0N8UJhs7irFqrjuXD.M8IOSGFDjD1qlmDSLZM7DtjT2oMfE1n3Nx97zbNfKGnOgIc75FsPpXSeVr
 B3Vcgi8H.MvOMREj._alDgOJy8yOPfyxJAabZY8SukKx5vUODEuL4Hlxq.TY3hkNR8WJ0vTQAYGE
 SbMVWhRnCkc1xWjeYJ3e1CdXw6Cw128isdJQU9vZAuYZ7_C7TQEo3VKzip23ISRFke3g9gj.YkIN
 9mopSzGYjnA1MqUAUsXw16OP1OjvZeJrFmgwdT1ZALtibfVh4SJLNtxNaN9OQCGZLqpvEp7gr08T
 8iQKkm.cWyU.LYVEUBHFOuPLtm21QSF8ablNbI4sMtUVM_Pb6sOKCCsq5yxXqoduuQCBD09M74Tq
 hNYYH44F5tXF6evNtw6O2b9CMuvxYBKGosjKro7PqRWNk3TztbPrXeLhe0qHqRDjvWNb3DhUoK2Y
 4JeF5STMuFON3ituO11Hqceq2VKcB6tb3U43N6h3ULdkDwX.In_sMl_z4bBeC4JmxmJyX_4qFq.L
 YZcu0HN5oIjv8_AUBo9B_ZVmhBXcx7Wwn5D2WaGHs5eIhIdzQuKSr4Au.84ZnyJpnLO2CQYOy5I6
 hA2GrwUybnaAP_jv40Pbq4IJsZRqvqzMwm4q8jkgwE60MnRzvLfrVt4OwiCSgH8lX95hsSo11kbc
 n5U7TST5efqOlNrqgu22OZgTiPAawuzeoB.8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 07/38] LSM: Introduce "lsm=" for boottime LSM selection
Date:   Tue, 11 Dec 2018 14:42:43 -0800
Message-Id: <20181211224314.22412-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Provide a way to explicitly choose LSM initialization order via the new
"lsm=" comma-separated list of LSMs.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 security/Kconfig                                |  3 ++-
 security/security.c                             | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..ea33bcbaecb2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2302,6 +2302,10 @@
 
 	lsm.debug	[SECURITY] Enable LSM initialization debugging output.
 
+	lsm=lsm1,...,lsmN
+			[SECURITY] Choose order of LSM initialization. This
+			overrides CONFIG_LSM.
+
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
 			Example: machvec=hpzx1_swiotlb
diff --git a/security/Kconfig b/security/Kconfig
index 7de42bbacc28..41aa0be6142f 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -281,7 +281,8 @@ config LSM
 	default "integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
-	  Any LSMs left off this list will be ignored.
+	  Any LSMs left off this list will be ignored. This can be
+	  controlled at boot with the "lsm=" parameter.
 
 	  If unsure, leave this as the default.
 
diff --git a/security/security.c b/security/security.c
index 96e0b7d057b0..38fc436e8b4b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -47,6 +47,7 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_lsm_order;
 
 static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
 
@@ -190,7 +191,10 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse(builtin_lsm_order, "builtin");
+	if (chosen_lsm_order)
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
@@ -252,6 +256,14 @@ static int __init choose_lsm(char *str)
 }
 __setup("security=", choose_lsm);
 
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
 {
-- 
2.14.5

