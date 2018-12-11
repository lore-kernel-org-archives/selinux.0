Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8A5C67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F7320672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aeL+4OhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F7320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLKWqm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:46:42 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:37918
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeLKWnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568226; bh=7Xaws2W0yIQV8FjcW558fLYKeVIf6r+5nGjJUAMugHA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aeL+4OhSWYlAUrOFeHGFo8K4h6Tp1gpcLynecbQY2x06kMRjsofmO3n7KIxUAPqncHuJg8eOXX6hHt/VTRPSskbyCK+anoAk+Bcvo3rwDwtPCjR1gI8Q0Aluf/5k1pLDzPO1+w4HrON7W9gDbL73T11uIkpYTIxfDhSQ8PcJSm1Ij6z2NUxsGCZaGZbHMqhPwQ/vWSM9vdPe4PlnN4aWiIyYw8y+kYrDRJg5wiea4yxw4M5Uiysh7lu+0VxStaHZsly8pCLCndQiQsVLYwCREq6ae0EQKem4Ul2dVvT8Im8wV0I0cIjxWOSL7+s+7IeI3Wxi1mS9Bifna9kE709hFA==
X-YMail-OSG: j.KV8C8VM1nKyDRJymu5Ts81qxBtU83lSf0k6UZV1utFT0W7Hi8c6PpkxoCRUoq
 VEMgfpW5mm0nWCcVV_p7gYk4m_v7LtfbOV6fy14peAGWdlA45gLc30jYiHoqloyMGmJzKN6RxAho
 P791hHkhvuIoilH5sgDmT9Dp.j8t5FVil4I1E2s4vxMFBbaYYBX1Q8OCGedLjlR1xdHbf.sCBWvP
 DSo01g2u7eJZuv.OnNcmHBvJ9eVqp409ADIW4Bmv3pL1Y5uk5edWCx1TW85sd6GTQw4tFKn4XNr6
 8_TIq_4CMpswA687cULJxsE38CdXvnVGxqaSaRr.Lr5RMnFEunNk2T5KL27KsZqHOp9d9k88ydBl
 Rd8vc0d_zA7dAftrv78xEAnxenn15oct531jA7B4vfjVEWbric0d6elDfJqJsmZ.89mK66A9bpie
 o2uljL7W2q8MYVFu_Pj9g3sJgoYrAtarv7ELUOArNw0VIjZ2lYUNNHjleEljafFlgNwFw8dnL1jU
 N9y.479BhMxqyRqy7x.D0bRlWd2cnK5vMdw83vigDIKCL2sA89120PbawdokjlHq3_.Lw05mTDTq
 X5Hqwnc8ffAVXt2SxFCIZkzW3YFL2mNa3CeWz0Q.VyNJsB6E7oC3V4DfzLt6Lg_RPx5it5F64kv.
 5hD_uThNNsZFGOxi2wLADS3hG3867xD1vn2k.vkDi83V.tHjc3BJWLifcvszjQZqxN2LR0b64eQ0
 7N7DBu9NtEZ8SaA3CNvGu7mBDfesnE88lOkusULvrAn.9fNCkeCkfdZXmZzeiTM9dY8om.Jm.lLj
 aaRb95nvWAuxDrMCok5nDhZ4NKqxeu0NiyQqEmREQTETpRn8XiXLQhOg1l2HP9xZk6GAkQGjtfue
 QIWJ.xULe7xlUzynLkJW3OkO18RFBMNIBbf2cHGjDIUudG.KFEk2ib4WMJ.2sQDAQ7vIxzgZSVYp
 _pmL62uI7Tnfps3T1f7nKa6FVMSrwOR.W1w2IdTCgahb2vr5wmwYG7Xafa0Fbeomaph6it.GVJR1
 IlaOFrTJH11Ee_wp70JcrqNEScxqDvikDJMebHe_Ilxjkd4e1JJE06c.VLwJHdXs6MRprkMm9r9D
 kfdwSAr9_n2LtE85np.4dG7sCzlosp1QhyoAxcA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 16/38] LoadPin: Initialize as ordered LSM
Date:   Tue, 11 Dec 2018 14:42:52 -0800
Message-Id: <20181211224314.22412-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/Kconfig           | 39 +--------------------------------------
 security/loadpin/loadpin.c |  8 +++++++-
 security/security.c        |  1 -
 4 files changed, 8 insertions(+), 45 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7d04a0c32011..b565c0c10269 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,10 +2092,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 41aa0be6142f..566d54215cbe 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,46 +239,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
-choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_DAC
-
-	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
-		bool "SELinux" if SECURITY_SELINUX=y
-
-	config DEFAULT_SECURITY_SMACK
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
-
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
-		bool "AppArmor" if SECURITY_APPARMOR=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
-
-endchoice
-
-config DEFAULT_SECURITY
-	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "" if DEFAULT_SECURITY_DAC
-
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "integrity"
+	default "loadpin,integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 48f39631b370..055fb0a64169 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -187,13 +187,19 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforce ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin) = {
+	.name = "loadpin",
+	.init = loadpin_init,
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index 3fac0ff39944..0c092d62cc47 100644
--- a/security/security.c
+++ b/security/security.c
@@ -275,7 +275,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
-- 
2.14.5

