Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFACC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6420672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="l7UlgiZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E6420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLKWru (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:50 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:34707
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726347AbeLKWnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568211; bh=3G/0Iu5/iSQ8/k2ikHUQ1H+/0emXlDEGaLq/9ZDn1eo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=l7UlgiZ6KPYII1fymTwmFTGgGMC7kFZxWMMUViZ60ztHO83H/nONs41FtmL+IxMUKJDgeODwKyOPGsmwVYITDm4U7xf5qX02V19EJi4jaCxK1rGqQBXVplq9dZ8C+Q8IFRd87Z8daEbuaw4Q2DAOGLcw3uqdZgyzylEzaa9vRb1akPLCILCoyGHP9aXvGC9v6gco090Lo/SgaUsK0dWgLsGEjledQV4kEt8ue0YeYPyVfuvRzKZtIoz3TX0L2xU4hwKmC+trnv9ebolRbpIabMa1Ju6rLuX2cwX6XDHfjR4C2ZJLtzVey1/UEJYcPQG/eulm9Q1R8hBSj7LFQvauWA==
X-YMail-OSG: u1EvFLUVM1kG4N4MjNjMNDe6y8fVT7w022tnlnsrQUGUhLtEqM3mWu7RK44tc8N
 JI86Mh2FxH.NcCi9hjxXuIOyZ6iCFfj1yJVnbBwTl0K7VKyYc1GArWu9eOhGwsDo.VXVoV3P.dEn
 riSr2qrU2Zxu6ZGg.RrsBq_IgljxIEdpMHAqNWUr9xPT3_36YxjrW7KT1CmNjn6mYt3yIJ2XJxtO
 KFmrdF3vzPbiZztwwK1ah8axjpOMa_XBFPokwnVJD5fse.hc9BfoXQi6DFwc8wX1GJYNgO1iCMjH
 XHvFwp8rfZ4kovmEP6rJlgiXCcRbCoN.nE2Df4dXYj0F1Qgo5CghNU_XdcHlEqVhBHpUWhQXWz36
 04KSRIYQiMdgD7fTSuzUbupirQtiLz_SGjGoQvTmq2uzMxVW1gIZKTjPGJF_8KmuQBSsO22SteKy
 uvyonlQhdrR.QCeYWksi36DLQSzPzRE.6DJdp_VjYDmdJPC7FCTU40dwc.nz21tYbdT4s87kt9fB
 9m1khgLs0EDO5T6XURx2sNwa5lsKHgRIDMgiIr4CWv_jvqiD_VOpqI9G0AxW96U52b7VCoIIvp9k
 KpsFrmd9wZs171rD4YksiP7rvr6bONrD4zPCa3qbnk6daMfZZWMsWBKKw0ACQDzkA2XRflPByyAE
 k68UsblOvo1hSXEu41.9ywOV.3__b2on0MrCOa58A_w0hT4BN.Mqc_7Z9Ym8o1YdZqn1KpXa6k7V
 GjzuMgIEgFm1lshybZ5I3Dqa9QNMhSUyO8mPcja6EVtJfQyEOQ2TPqp5helIULaLoTXCgckC4h9x
 pB5_BBkuCv.qXlhwA9eDrYpekAIhuKHrEFS3H8dIt70E6LtMMqId4B9LAXzTFchudomIZF1vVwrq
 Wb6qLtqiFOACoi.mDYEOcC5CFEoWFMaUgfTY2QR2M3fsub6T015O3Qmu4YFtXGE4q1aEse9iG_xH
 R57XSelvxVA7gXExStoLxTBcr2Jc..iSWQfTiVeHHLOXCt7k_RVkTmNpClkEgdNskQjU.7aFDj9L
 GbUwK20YuyKx7GgwjbPy_QKgdzJ5dZPneN5cRvY5k_zv7LCVtxNtKhi3ry8k5RvJcEXlWDLCylgg
 g_z4CnUoH6b1FQgxtjPv9IH8fkWO2KWqF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 05/38] LSM: Build ordered list of LSMs to initialize
Date:   Tue, 11 Dec 2018 14:42:41 -0800
Message-Id: <20181211224314.22412-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This constructs an ordered list of LSMs to initialize, using a hard-coded
list of only "integrity": minor LSMs continue to have direct hook calls,
and major LSMs continue to initialize separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/security/security.c b/security/security.c
index 7562da854b62..4c193aba4531 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,6 +37,9 @@
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
 
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -45,6 +48,9 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info **ordered_lsms;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -85,6 +91,34 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 	}
 }
 
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	ordered_lsms[last_lsm++] = lsm;
+	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
+		   is_enabled(lsm) ? "en" : "dis");
+}
+
 /* Is an LSM allowed to be initialized? */
 static bool __init lsm_allowed(struct lsm_info *lsm)
 {
@@ -121,18 +155,32 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-static void __init ordered_lsm_init(void)
+/* Populate ordered LSMs list from single LSM name. */
+static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
 	struct lsm_info *lsm;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
-			continue;
-
-		maybe_initialize_lsm(lsm);
+		if (strcmp(lsm->name, order) == 0)
+			append_ordered_lsm(lsm, origin);
 	}
 }
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info **lsm;
+
+	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
+				GFP_KERNEL);
+
+	ordered_lsm_parse("integrity", "builtin");
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		maybe_initialize_lsm(*lsm);
+
+	kfree(ordered_lsms);
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.14.5

