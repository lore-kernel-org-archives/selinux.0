Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED6AC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5DE20851
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M866abYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5DE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeLKWrx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:47:53 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:39730
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbeLKWnc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568211; bh=ZlWCjSOSrH+yq5U3bHRSbrGC5WLOGr1E5Vzq7vDN9ik=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M866abYQIiko6ni5d+dQ/xnG0V97dR9JzJYmRq3FeP4vbfjrTg4ywdz7cnaKEeX15b/qs+sE1+QI/wloKObj1Uhw9VoFIZBS4f8n65UNjSmBGAHhruivU7FVCj8Dj7hbwpqmsNYAflvjYPntQVkPvlFD6g5Y7qjFXGgW76rLPBuMbTq3OWeRgUxUA5kORTst2IQpcQtZr2j1B7knIUJkILJyN/YV9XT+I20WWNtIyh4H+SDVabIE90UE6e93znT17V/YmKCexPZUpXKoByKsPFMtW31d0PFBCfmgRGwOAwGMtrJGjjCUcPXmRXC+BQyTwG1TPoxPsPA9t4Kf0t/qiw==
X-YMail-OSG: 7c.3x0AVM1nte80y3kWjrFYohqGJGvE6xCAcyyJ44Dxr4zLxR6jCeblaWeEF0my
 5pF77c6hZ2YcZFQqOOlP3E3GiXDqwoVEo5x6GEcDMMgOtWvB6ZpeV7NAzlt5jCr7hjzrpxE.nJxJ
 7QIzizwVKnYKZBc1n9tjJnSEo7ikhoX5cNNSvfi5EujmGR5tBYKusJTdNAYMPpx7d5wxkveCY5wv
 BZaE2TovjYLyeSdZJyjsAnL4aM0Xed7w6qLfj.FgZsEN0MxylLKkZXldZ.7n2ai6qb.4RG2BE3vB
 XUmxaI3O2uAiTJnx_umEIalwUJzZqLYEarHS3C1HiRSokhCfvqauIZILYNIiW02.P0LSUuj_qY1T
 Z6IsHchiy.RA_zE.JlSANOpReET7.sUZRqFXJxIfutvsjcohvRgoiPTHKe72U33D22.O.0UBr.vG
 sq.Qa4MxKgg9ILiSAs5qxleXlzD_xUZ2lJvFH4ntrewPKJkhmBhSHFv2yPjm4sXKI3MuA1UssZPh
 zrrh_Fws4xeQCciCYta1FqWIKUs2OfYSMlv.nrAQTBXCWzGGkiRNaPiSovzLQ6uGgEf4uWbQMbhk
 nRor3wn7BWj6GGnjDIAPxhcYmSAg47JIbtgOEFZXhrwqBfKsGs5ivEqxUOXp7Mz9yjKFU1Q_VgZ7
 vll5tnsVTY.rx0NBZZ__xzt17UZjXQniA76dFpDR9NW3QmDMEEkSnSshgWZj5mq4sowH4wRALlki
 .vEOLVZC_.jqpWYxgy6rJ2JEoWoGyAK.VJDgETTfXLo.IPpuJeNYI1TEUyWuCs9tfEp4yQaJ4qF2
 jP9VtT.TM3hlw.eqbW8AwI941yAZXWeP6hSlDqgyRtIPcffPW9NLnVX4zbkhVkIHWSPCB6dj9SM6
 .bVpJARULSSRbHs5kwtV4gTNNh6T29U_tAOFu4AIWCFm8QbsEj37Ol64EwjzWZrXdL23xB1jspeZ
 02amgqgByK7.KkG61GZbO8EVFsw_XEgtkYw._2YYv76Bpmv9clbV8FXjrvxcDxaE.jb6Gp7mmL84
 .VcFMADwZOmwvCxmBuqWeIUpyYf3RUcNZMTUMwqw79rcYLsqBEOwiQywxiP0DBUExvkyR27oLwnD
 TNNi.1.utYm.vBajU6838FahR5Wgbh3RStb_lLg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:31 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db48327a3d58729724c38eee90dbab73;
          Tue, 11 Dec 2018 22:43:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 06/38] LSM: Introduce CONFIG_LSM
Date:   Tue, 11 Dec 2018 14:42:42 -0800
Message-Id: <20181211224314.22412-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This provides a way to declare LSM initialization order via the new
CONFIG_LSM. Currently only non-major LSMs are recognized. This will
be expanded in future patches.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    |  9 +++++++++
 security/security.c | 27 ++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index d9aa521b5206..7de42bbacc28 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -276,5 +276,14 @@ config DEFAULT_SECURITY
 	default "apparmor" if DEFAULT_SECURITY_APPARMOR
 	default "" if DEFAULT_SECURITY_DAC
 
+config LSM
+	string "Ordered list of enabled LSMs"
+	default "integrity"
+	help
+	  A comma-separated list of LSMs, in initialization order.
+	  Any LSMs left off this list will be ignored.
+
+	  If unsure, leave this as the default.
+
 endmenu
 
diff --git a/security/security.c b/security/security.c
index 4c193aba4531..96e0b7d057b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -48,6 +48,8 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
+static __initconst const char * const builtin_lsm_order = CONFIG_LSM;
+
 /* Ordered list of LSMs to initialize. */
 static __initdata struct lsm_info **ordered_lsms;
 
@@ -155,15 +157,30 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from single LSM name. */
+/* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
 	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			    strcmp(lsm->name, name) == 0) {
+				append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
 
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (strcmp(lsm->name, order) == 0)
-			append_ordered_lsm(lsm, origin);
+		if (!found)
+			init_debug("%s ignored: %s\n", origin, name);
 	}
+	kfree(sep);
 }
 
 static void __init ordered_lsm_init(void)
@@ -173,7 +190,7 @@ static void __init ordered_lsm_init(void)
 	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
 				GFP_KERNEL);
 
-	ordered_lsm_parse("integrity", "builtin");
+	ordered_lsm_parse(builtin_lsm_order, "builtin");
 
 	for (lsm = ordered_lsms; *lsm; lsm++)
 		maybe_initialize_lsm(*lsm);
-- 
2.14.5

