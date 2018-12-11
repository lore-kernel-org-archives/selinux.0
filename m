Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AEBC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A15E20672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ejipxJyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A15E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLKWqh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:46:37 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:43117
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbeLKWns (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568226; bh=kZnkfo4eewmWJdduR5L3e/EPe8qWMgQMq8d/TZ6MGio=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ejipxJyDBgrLLjgBaUCabHWnAjP0H35MLh89FPQNwptwGO5GQhOYdBo3gzckkuDRJycMBTatG/SV4XysnSstt9XwyfH3v6QxE2Qtg+7Gf6xbFjttyzYFi98mIWVuDmQFuirTgtv4FpcoYqPTPCPI+ONCVWmViDBxX1qvII61aAKpgW3TdfLUzgSuTjh3tCo0yI56aGge7NVqmAnqFRrMgZT4s8+KSg2TWzBWVB9RPDpV8WaEa0dPP+mPfjtwonWluPzaMBavjqsl6cWlNPa7p161TRVKqFVg+ozpOKPrs76Ugdwd+pV0x/pnEjXtOGBrbQoB74xmsq78JZVrzuWB1g==
X-YMail-OSG: kA1OslEVM1nX8SlcemXJSivjnL_Yvva6XedrvXcUpUu39XaTP9GHVLlYOEmBkgX
 dzeuYwRCB_JRtF.JPIdsVtIchHrn7eduSsjpEnUzZHzQk4kimhSvrt68dS8C91QyVXNX.2wpLITw
 pNTssLY2jNgXQNPxdGMJ_J80MxZNSgld6OVpUxDztKn2YcVmLiVFfEP5WkUXm8WBxl6NoKndfR8T
 LEvcPdbzIaTKcdle83j64UcPheeseoja3y6bF2YQhQ2k5cUyzcspLfmUeH5W9usdXR3ULeEfEpaV
 zZMOyFfgnDdUUcHgjTgp73mixih7O3guMwUiHwNPh7d8uQZV6AJHhs9wdeVu6BAOgmt5MTFeJ9BT
 fNLL5bPVrBVL_mNETp7xpgYKW9Dljiwam.hb4Zl5GKPJnnaXKkex5SwmGRne2fPQWSU1.ruKwjxi
 uhPfhnYGRQM0hcKhAsK4JqcdQIHeNjRB9frsATmkU_mqJ8MzXDIr8mp.G2xAkK6EHfY_5dWeKxND
 cYOIHUvNdK._hg1UDYyC2C7Em4dFaytRzyAY4RtAgxdeGKizPPZkb5bOgZjBjPee6zAqR14ZvgT2
 SyWntyEn99wQmbMicIgJZWGGGnQsKesTKgZ.QmrsoYuQaMxV8LI9aYSGizn1_Y4Ngtz5EWA8uU8k
 ZKjB.6h1ug72cNfgWva1Zvbn6dtQ8Gs1snEMdmxu_Arhg8kZiiOe9Wg.i6GoneShdVKEnNrhI32e
 mywV.p8JWDSWqr7UkV__4HVSgZ.smZShavgJB2KGxOZdOZNQO_oguv3H97nITHC6qDt10O5U2Xfk
 687dVX6oRIvla2drwGbswjIvOqwqmch8pwRLBwIZt9wGk1nyOjJQM4bnWzpWxg8NiHbM0phB_wd1
 NRnHxf3DF3kGfDM8TxYe7qd1IyeGjc6sXkFHhgZoZUoBYOpVGrR0ZsvWugflQX6X0mR7yA6qSjDX
 LeoTdGfMRt0ZmjC6ZfzVDPL_unT1hs_CmY6qCX2.fqpBl.ODb74ARXiWlm6g9qpInYM1SZ4WGh7A
 VSuQh75aafNIFILMJ_xaoE8VMWaDEd4XloC5CNd3HNkoA2nBgZAaPkxRLZXEpAK_zGJCTEk17e79
 gMoSq7f0HDAXaYreO6kqFiTKmSYOI5TOzUm4eyTHCruI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 19/38] capability: Initialize as LSM_ORDER_FIRST
Date:   Tue, 11 Dec 2018 14:42:55 -0800
Message-Id: <20181211224314.22412-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This converts capabilities to use the new LSM_ORDER_FIRST position.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h | 2 --
 security/commoncap.c      | 9 ++++++++-
 security/security.c       | 5 -----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 83858e3df9e5..15fc49ee41a1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,6 +2092,4 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern void __init capability_add_hooks(void);
-
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 18a4fdf6f6eb..ec387535e597 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1363,10 +1363,17 @@ struct security_hook_list capability_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory),
 };
 
-void __init capability_add_hooks(void)
+static int __init capability_init(void)
 {
 	security_add_hooks(capability_hooks, ARRAY_SIZE(capability_hooks),
 				"capability");
+	return 0;
 }
 
+DEFINE_LSM(capability) = {
+	.name = "capability",
+	.order = LSM_ORDER_FIRST,
+	.init = capability_init,
+};
+
 #endif /* CONFIG_SECURITY */
diff --git a/security/security.c b/security/security.c
index 701507174f40..eab64bdc60fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -277,11 +277,6 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
-	/*
-	 * Load minor LSMs, with the capability module always first.
-	 */
-	capability_add_hooks();
-
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-- 
2.14.5

