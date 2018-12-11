Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7CC6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36420672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ca81np26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A36420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeLKWqn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:46:43 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:36661
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbeLKWnr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568226; bh=lZbzrpRCsPhiLDi7Sk9eC9O4yptogW1Y1bVM3UqJEJs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ca81np26tvddk0Krp08PBRF1GH2C5LXC/OSOGPw19g6jbppfrfNds4EG/jUKidbVEAv4IQEKH/6uNulHWZf9HCzgt5T6+S0xAr/dwaUYwmO4pyapelezzdgGhgeLlofXTUJVX9AZvgTtzwYCX3p6rOZzAB5BJFe+/nW0RreZqJJDYbn6i8qoAfhWLHqnigtCy7PHWeLDf7DAeOshtvtMuYiMKzMkHFBMsRRdO1F1PFPYs+e5RES9kq3oZU20xNemxp4iiab5NWcPfcwPBI9/PHYLzzKgezPwDRhIPzgB+4LOUgnAvhjenPF8qiW42hd2N2xJDZbIRdKG3YDJq3mKZw==
X-YMail-OSG: hCAtuysVM1k.EwwbBKA5aGH6hLMq9xoQkIt7RprT9pxazKn_QUQEjb7HZidLeJR
 7BRVQ3ErvE502e0rbiZgdVRQW0b0lD9aWf_c.zggRgMbAuKmyqw9FAJm8_rpkkNEPZ6Nqi9NbeFq
 Pk9iUJjQJIbT3wXwjDLMscZ1K4LegFFUetOwUiO4qDSnm2_rZPhLda4cxPTx_IB3nw4D_2T0vwgL
 egM6rNdxGFxfY.uahUnteXe7s7.vssYrT5vc8eaVHDK2HY4BuKxmvYOXaS7pMNPgPe6HkcrZuS4y
 caieuvWw83waNTV6WtZTxiy9o35kfEKexMSpGh_k1uSeFjwtKkv_3NKiQ8wo9QLX4OjlXwISOsQ8
 u9UtmBZ7Kjmw.VZhE_qOUKu79hOhzY1mohUkXbxTYxQy6Xt6dG4IlcfbY_vecHnQOlyEHa9.xyKp
 Yakx3ppDWjbRJmIVTAKbDZB3dDoJXN07zA70CzlEZ4xozcSdcc4m.BpFe33FMSn4r8gDs.S14KvP
 xv0mVr5r96Qv1rSNrvdW9DkU_XN6k4wVC8KbWUtyHP2XAhI0Gln3cuwEwdHjZJNeBrVjyKKqQWiT
 VDZFNdqHjy_BAjYaODehqsjfWfmJx0.tC6Gf_fpgQ33z7FfBcW4SH710.IY8ih91ZfhkKlhKxOd_
 z9tpFZaHahRHiUkqZ78MCSRVTAVBTyJ6IsG5x9NshF_rIbWT__bk5SVi81mCCmfMM__yxuRwT0UY
 oT0m0pcXi5r_JXW2fCFN8LItnCtj.3jwJ6vYsWkGBOGHwoVp75RpkzBoIJL.70PZ_EFRN9CeEPq8
 jRcrjPfsAZ5__FUmCJN6rvYOkgjwYa_RFNcVXh2jC.aHmWjoL778alC49gvOfYkCev8Im..QgyUD
 .1pQRAA_EAK4Vh8Kpum1JrorkI0dkFeBLVikULJNEUSc.k3jmLQnQxWogRDv9YCKtzjqrl4tNq07
 u7lsP6ldH_VQrzfOlxRdSyUmjpT6Q.3lt7uaJtwG7tLwZWi1bDeLxpQpuHKRpjG6kjjVEwcsWQtk
 n_sFGxJRxG66sUFGWqiV.hN73VEUz9lPM8nvE8_h1vd2Q_wt4CsU5IELBYSQYiTgbHVINP_W1BC1
 aR1VqS_gOvI3uatPnY_kFNS4r_3Edu.L1p7zddQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:46 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 18/38] LSM: Introduce enum lsm_order
Date:   Tue, 11 Dec 2018 14:42:54 -0800
Message-Id: <20181211224314.22412-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

In preparation for distinguishing the "capability" LSM from other LSMs, it
must be ordered first. This introduces LSM_ORDER_MUTABLE for the general
LSMs and LSM_ORDER_FIRST for capability. In the future LSM_ORDER_LAST
for could be added for anything that must run last (e.g. Landlock may
use this).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 6 ++++++
 security/security.c       | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 6cfbd7d78a89..83858e3df9e5 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2042,8 +2042,14 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+};
+
 struct lsm_info {
 	const char *name;	/* Required. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: controlled by CONFIG_LSM */
 	int (*init)(void);	/* Required. */
diff --git a/security/security.c b/security/security.c
index 0c3c66dbf51c..701507174f40 100644
--- a/security/security.c
+++ b/security/security.c
@@ -174,6 +174,12 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	/* Process "security=", if given. */
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
@@ -202,7 +208,8 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
-- 
2.14.5

