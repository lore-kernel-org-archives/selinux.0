Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38D7C6783C
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF71C20851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UdCnmtlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF71C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbeLKWrH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:07 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:41724
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbeLKWnq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568226; bh=q22d4rrFaTt8aTp3VyIyxlI3Zk8optLiXa/YsJkyyVs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UdCnmtloPcX8tXBg5edoWRewlFJuiF6cXekf+tqYVoHlcf9JlnKoIO2wgbNDzCLPNnL/2Dz/PGbSWo9p9WGbQTQpA7wqeKiS4zfMnSKbp1CgHbJaAEGwv8PLItBKAEwccfiy8KEO48s/45HyzTWkZ5AEPMVh04ygtSmBmcMfnWowxxmopR3758MwAlfbdlTw6q+MrZV26wfyimB9GGyr67MOvRw5Q2b4Ar36SLqnFR+Cd6v6FUiF8+/+sx77FGXqCIK30DE3iempl8V/4YOm5a3QPoZfR7Kch5+zlbMsqya6hV0jFoJUwbmsTcvA4h2pdc9dRm+HWc0mTynsIpAlag==
X-YMail-OSG: gCVeihAVM1n78BNwXMoioU3.Kr.V6KBEh5DaRdY3AAX.RaXMznKplXYRzTsP11U
 tjcmCrfy2N99z97UNc3vJp7wwRSHD1QTXw.zO5HhxVzNBfUTcaJGgwq96YImf_vfkWlzr3z1TnwW
 Hq2JST.RbPOlCOV17bCXxCREZOe1GJ3lrtp5F9mjKJnaST7tiICUzo8hudomEmCotbMivf4Qpj_S
 S0gILHDqG.PL2R7HZKoj9J6w7Z1RIFpLyLWiUgrlnWdZuet8Cd5DqrKrSgDu8Z60ryUIVs_fTAiF
 Eimwn6853SOMxIZ7mC6qHCm_NzBfxuR99SMvPfZcyKDQTgS8Tj0fttLse4M722cqT8sN61KTPWHP
 5NcmlpNK4T5YWzP0vB.vU7eAT3u0kdRfGEoP4mBMr3vbSY1gfEWDXad418bJIcxLFnPKYcrJjp0X
 3k5..u3oQDunOeSFqbT6SHernSzxMXRdq8mHE7lC4.c6ftKPJg2az1Qy979_weNdjubwnhew4P2w
 loq4ej5mZPTDRfwblGogAOo.jixSXYHVR4EYaqiNFwFX3mR31F0CWw02ul3FwD3b_0PwYFwGDOGC
 40KlCDXJTSFudb7EVABIborII2.eaq2PXlttpq7hfKb0Akp6.KvfjnA7jJetCp9wR2CUiFV3iwv6
 YRIZCRcjz2FxGXjEAgFyzZ0sCEsxOcIn_FNOvygXn4o7uVVYcwYC5O9XJHuI9jcNfDke7hZefvKI
 io69ozetEdmAJA2t3U.pDAwtP6fW7SYD_YjGUblz.PNZ..YDkqdnbJ2c.y9TaPvVa5XGxVp4QR5I
 6y8oEn2ilZ6SfBvQjE2sD0GI5evFELn9vHpHzqYwuXB.mmJFCB3B4J.BE8MgC.X.RuBiuKvqi44J
 ixZgpe5ko.FuDcQUekBo4C.tES3Uo.stX0ngC9znB.yNNWq6VAQfT9vhDNnm..kod7HxrKwBDhuR
 L8BIzz6IGaKVBe2PgUQDVs0dg.3mFU_.RTF9emXqPoQjd8AM0RxKsdqeFOwh1o9vlJp_LE9PAXpY
 Y1YesLJgcmXyu186i3NiOpHvacWc_3k8OQYX.Mhu4qB2YuprbAC75z76NJs8uWd11QtCkEyUR8gu
 5MsefPYkZmB9uH9_KS9tlMXyvAPC2uE8yKw8aWsLRAm0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 17/38] Yama: Initialize as ordered LSM
Date:   Tue, 11 Dec 2018 14:42:53 -0800
Message-Id: <20181211224314.22412-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 8 +++++++-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b565c0c10269..6cfbd7d78a89 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2087,10 +2087,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 566d54215cbe..94a71e022b79 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -241,7 +241,7 @@ source security/integrity/Kconfig
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
+	default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/security.c b/security/security.c
index 0c092d62cc47..0c3c66dbf51c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -274,7 +274,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..eb1da1303d2e 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,15 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+DEFINE_LSM(yama) = {
+	.name = "yama",
+	.init = yama_init,
+};
-- 
2.14.5

