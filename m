Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC34C6783B
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C8620672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NUplNcUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C8620672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLKWnn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:43:43 -0500
Received: from sonic308-17.consmr.mail.ne1.yahoo.com ([66.163.187.40]:39343
        "EHLO sonic308-17.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbeLKWnn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568221; bh=aA9ToBwx7EdAqaJKoH0MpMTFJSSXKnw022+5umTtX5A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=NUplNcUt0iSDUQJ+zLEcBS2pij4wOKa5CT/OcVcpXOQYrANDY4cICSenmAYYJeXUuqzHVWu2lfCKTNCyevCm/CEp2ipPCAdYCVZfir/Sh/w8oyu86KdYXqXz1qmcVvGh0Bh2IpcW4aLjnl40ocgfAS1TrJ5wEw/w44r+N8VADtHgWkUsPriJS4MZVMs66LAL6v9FyMie/a4RwthINZS2zWEM5alrwVQq763CyraB5RNYcXEvROlyMUQ3Lyfj1NQLZn39/LDcLt2T1U2dltPxI+tiErqDYBP3g1TD72BvBcxXTT1ElHPpkR3ld3ggmDtctGjrLx9vOzjBrL7clBRhrQ==
X-YMail-OSG: X3ciU5kVM1mNKklmhmnKECfTg1deBrlrXd.Wk8h2mnXCVK5_0F_mvmiI5wDIRMQ
 5XtC72LqWVYM8h39ZVpyxa7XYSmDn0whh5iXBxL.CFZPXTz9O0KSsKiESsH87HoAmoNpeizW.3px
 J_YnmVGRHidOf2Iknt8SqxjxsgdBVoVCYySvwXGHnlKekFutkBE3AAL7ecyHx1pwVfE1P4EcVfFX
 qvs.WhKG14ej3pTB0F0gija_WoLL_b_T66GFv1XwZ3GTH6SkdpCtmo9QRZG_kmAgl1HO9UA4v6as
 fh6efRu6pUt0RsqLroYT8ft7E7OFVXWZULakq3E8lC0fbOEtm2__xmhdhwvLyedHf5ylhXcdWuYx
 1_dQLz0sH_UV4Iw4h8S9yoxE8I1M6a2uc6eZ5_mTwntctVa8yra80mu3ivDr7g5TKySdKwGDtdKv
 Ko4SMOT2mpKM8TqXwRsERj4MPmHftg45v9l2r1RKFBjhAM3eQxvUYI.p.sz4Wa0tou2PKbmNOlsF
 m0hdbb4Cshw6buCHaYQB1ESvmv81hYX3po.H0LbjjJmbFpneil7YB07xELL3mWmrJORLo8VHH0tB
 WtYPUXtDaLVCuiNNptwtjqjFA2nsaylfVbv_CmZkSTfK9y1Mz4812_IdjYS_iKic0mwNTyQXBP7r
 uC4sdPlwIfM1Mvzlr6bOcUPLzfxKn2vflGKQ7Ffhar3bote7qvArQU_gOsz4CWudqXBeAWWeeEE1
 gMJlCekWIlkd1leY9mlK6mzYYzUNTNrQM.idOKsKyXrW2Wpwk8Ndu6t5ZfZIWaLJlAXydQhDUq4n
 QocCpbzw_5BZ4hD8wiyWuo8GidcNhOUzxYAMzPpXpRFkEPSdUmXtnyWl0l5PLhHqs9fLUjQQMwpx
 bitgHrqZWH21OulpgkP8lOzeCGUfmZJSY3NTQb_nAkO3A2xN7jb8EWhA437G3o6xsrmfeHp3e3YV
 m6oVDodAztKTqdLLGOVAOe.nVrp9GX1T6NF9.LU2Ekh.sGyIW9m6AyrRTdwhhlyQ85YfvkFK.BW_
 OjMidZCEYG9.VHlt.NrgBSM42Y3Fzadpk3QuNWs6D.P27jiB9DiP4WvKoJeWb4_7Ic0yMWh6aSkc
 u.ghBEvYTq7Mzmtpb3gHmEjFw6DKIfIcKYmogA.zVcoU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:43:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d92a2db682ecd2e464273bda9352fd0e;
          Tue, 11 Dec 2018 22:43:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 14/38] LSM: Add all exclusive LSMs to ordered initialization
Date:   Tue, 11 Dec 2018 14:42:50 -0800
Message-Id: <20181211224314.22412-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This removes CONFIG_DEFAULT_SECURITY in favor of the explicit ordering
offered by CONFIG_LSM and adds all the exclusive LSMs to the ordered
LSM initialization. The old meaning of CONFIG_DEFAULT_SECURITY is now
captured by which exclusive LSM is listed first in the LSM order. All
LSMs not added to the ordered list are explicitly disabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/security/security.c b/security/security.c
index 0009ef6c83fa..df71b54c1ba4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -169,8 +169,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	char *sep, *name, *next;
 
 	/* Process "security=", if given. */
-	if (!chosen_major_lsm)
-		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
 
@@ -198,8 +196,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
-			    strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
@@ -208,6 +205,25 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (!found)
 			init_debug("%s ignored: %s\n", origin, name);
 	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (exists_ordered_lsm(lsm))
+				continue;
+			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+				append_ordered_lsm(lsm, "security=");
+		}
+	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s disabled: %s\n", origin, lsm->name);
+	}
+
 	kfree(sep);
 }
 
@@ -229,22 +245,6 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
-static void __init major_lsm_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-			continue;
-
-		/* Enable this LSM, if it is not already set. */
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-
-		maybe_initialize_lsm(lsm);
-	}
-}
-
 /**
  * security_init - initializes the security framework
  *
@@ -271,11 +271,6 @@ int __init security_init(void)
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-	/*
-	 * Load all the remaining security modules.
-	 */
-	major_lsm_init();
-
 	return 0;
 }
 
-- 
2.14.5

