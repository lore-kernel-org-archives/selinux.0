Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DCC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD6020672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kak8/ksn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD6020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLKWrx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:53 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:36076
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbeLKWnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568210; bh=bInYQOh6cBsw3E5L/f2WPwm7yV5jdN8/7KmSgERt3k0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kak8/ksnUUTaJZnNvmHkdRdYVEO2k+7zrcF5ukNIS3p6aWanTudSGtiY6ZKkLQc6yxCd5Z07bZp2VdAOZ7tJrHsbc/+sZrNx/anskMyuffw0mDb7fPwcBwwPD7eFUW3oYBzXWrIWqRNdpiem0tJemUxoxWKleEg04nJNGbgNTObWs1X79uXTWNNnNlXaZrnWL45C4z6Scj0fdA6KaLoBPcGDRIOCdo5LGuQVWKZKPiwX4P0jDQ0oKC/WVw4TpDDmUT7N6WONvm+PG8li3Ff+1N1ZT6GB7fzKNuOx3xwo21ES9rAUDNgenBKKyV8qyiIezx+srr0vIzjnDM10vCLkig==
X-YMail-OSG: xyeZGBIVM1kFu99u_7Dmt6tu1KMy09I2rWrhhL2TRFdj_okx5nca.JI2OpKSQGE
 QZJN_slpZWdZitfVbWxLvw9YCMvCKY8YFteQtDC7dlPZ0xKG70iBjGt56aAfoNdmWpmpDJJe8v1H
 RW2h.JbfCHj.GhupnrOxx0Yz9svIjsCueVsoT_QJdvZ.16FSI1LIWhZTUnOKlSC6snh.XBoGGBnH
 _kZzHfcleYr5iCS.ces9juXneMrIIk2tott1IIa_ClNYfLZ3r4MVKs.Pom6Wstp1oT6e3Ey1ad2_
 pZyBcAszD1W5.rdk2IIMiG_brTQNF7LFXxpFyofp0Nyp47pVUrUW8DK6MNcZ84XFjcj6k7jJESr2
 hsHuDS4RiKjKm8Z20VnGzVgXFCq1GVcdEQe5iFaicIX4w.u7jgtALLAYxG593ebAARnShmz1XgbG
 smtAlRs99aAVN2Hdhh_z6vAZNVQP.RxWND2onCYajsvgLvggPkRkGbgJak_ZY0pJ5_nlHsN06JwS
 MtSFijh6fqmvoBwLooBykkKcjty0OEZuxd1.3SY9pRtgKQFdnxVchn9cAz9GxpPq2J5srUUUro8l
 5h7UWHWordtM_1PMNn9QtF9AT704EkDORybAHMuMjMNmsfRtnYR5dj_Lt40U0qU_VieUfHMMz6Ml
 KVUg6Ivccmf69n7q0DOOEm1G.dQjlOZsf_VFk2Im3.VjnGRoCrKU_xAGERI2avGlaS2WuUs0ei1G
 FI3e5xuSqHkb16ynrTe4Q2kTXkevmN_gxVRW8CvQ7YsUu9uAz73RSd01kzACbR1hjWis4pyRblGA
 e_o5emFLX7ZR9Yyzf9Biof7j2D4.Gk34AK7vw7XmUge5qLH6qcqVf7A5Py1607E8zc8eaVue_8IK
 WtidyKU046BCDXsyvDbtvRRPCFy6kGZX.O7c6wdCqMjD8Chg5abQDqwkFOW__BhhMjPWIsV7ugHB
 P1hIdRXaRhBDq8bmem2c0D4diMlL1UjyPFhtQWVelyJLn67vLiUUB.n3k.kFkZfrxGkadjETQb9u
 FiX2ytyN0gsvJt.FS8I0histKVCW7fasp3RzB75Xlx43wmlf.bod5FQfquBi2_q3KPeAwBLnT23p
 FvwGH4nI0nwioFfh0vY_mV7R7Cw_fJscchBnAixRU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 04/38] LSM: Lift LSM selection out of individual LSMs
Date:   Tue, 11 Dec 2018 14:42:40 -0800
Message-Id: <20181211224314.22412-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

As a prerequisite to adjusting LSM selection logic in the future, this
moves the selection logic up out of the individual major LSMs, making
their init functions only run when actually enabled. This considers all
LSMs enabled by default unless they specified an external "enable"
variable.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 include/linux/lsm_hooks.h  |   1 -
 security/apparmor/lsm.c    |   6 ---
 security/security.c        | 102 +++++++++++++++++++++++++++++++--------------
 security/selinux/hooks.c   |  10 -----
 security/smack/smack_lsm.c |   3 --
 security/tomoyo/tomoyo.c   |   2 -
 6 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4e2e9cdf78c6..dabd2761acfc 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2085,7 +2085,6 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 127a540ef63a..d840c1ef3e4d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1662,12 +1662,6 @@ static int __init apparmor_init(void)
 {
 	int error;
 
-	if (!apparmor_enabled || !security_module_enable("apparmor")) {
-		aa_info_message("AppArmor disabled by boot time parameter");
-		apparmor_enabled = false;
-		return 0;
-	}
-
 	aa_secids_init();
 
 	error = aa_setup_dfa_engine();
diff --git a/security/security.c b/security/security.c
index 0688dfd57e95..7562da854b62 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,33 +52,96 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static bool __init is_enabled(struct lsm_info *lsm)
+{
+	if (!lsm->enabled || *lsm->enabled)
+		return true;
+
+	return false;
+}
+
+/* Mark an LSM's enabled flag. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	/*
+	 * When an LSM hasn't configured an enable variable, we can use
+	 * a hard-coded location for storing the default enabled state.
+	 */
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
+		*lsm->enabled = enabled;
+	}
+}
+
+/* Is an LSM allowed to be initialized? */
+static bool __init lsm_allowed(struct lsm_info *lsm)
+{
+	/* Skip if the LSM is disabled. */
+	if (!is_enabled(lsm))
+		return false;
+
+	/* Skip major-specific checks if not a major LSM. */
+	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		return true;
+
+	/* Disabled if this LSM isn't the chosen one. */
+	if (strcmp(lsm->name, chosen_lsm) != 0)
+		return false;
+
+	return true;
+}
+
+/* Check if LSM should be initialized. */
+static void __init maybe_initialize_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_allowed(lsm);
+
+	/* Record enablement (to handle any following exclusive LSMs). */
+	set_enabled(lsm, enabled);
+
+	/* If selected, initialize the LSM. */
+	if (enabled) {
+		int ret;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init ordered_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			continue;
 
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+		maybe_initialize_lsm(lsm);
 	}
 }
 
@@ -168,29 +231,6 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
-/**
- * security_module_enable - Load given security module on boot ?
- * @module: the name of the module
- *
- * Each LSM must pass this method before registering its own operations
- * to avoid security registration races. This method may also be used
- * to check if your LSM is currently loaded during kernel initialization.
- *
- * Returns:
- *
- * true if:
- *
- * - The passed LSM is the one chosen by user at boot time,
- * - or the passed LSM is configured as the default and the user did not
- *   choose an alternate LSM at boot time.
- *
- * Otherwise, return false.
- */
-int __init security_module_enable(const char *module)
-{
-	return !strcmp(module, chosen_lsm);
-}
-
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index efc0ac1b5019..b81239a09dbb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7138,16 +7138,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
-	if (!security_module_enable("selinux")) {
-		selinux_enabled = 0;
-		return 0;
-	}
-
-	if (!selinux_enabled) {
-		pr_info("SELinux:  Disabled at boot.\n");
-		return 0;
-	}
-
 	pr_info("SELinux:  Initializing.\n");
 
 	memset(&selinux_state, 0, sizeof(selinux_state));
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3639e55b1f4b..56a114c1d750 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4841,9 +4841,6 @@ static __init int smack_init(void)
 	struct cred *cred;
 	struct task_smack *tsp;
 
-	if (!security_module_enable("smack"))
-		return 0;
-
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 09f7af130d3a..a46f6bc1e97c 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -540,8 +540,6 @@ static int __init tomoyo_init(void)
 {
 	struct cred *cred = (struct cred *) current_cred();
 
-	if (!security_module_enable("tomoyo"))
-		return 0;
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-- 
2.14.5

