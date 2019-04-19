Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A1C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745B221736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eWrPBUW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfDSAsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:45 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:35673 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfDSAsp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634923; bh=IGbdibcUV8Ae5bpYVLlCyrn2lcUru6UOWag6V1sFgNk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eWrPBUW5yTSFjkAabaAUX7nWTmsNrAgsFbkrVdWZ56zXK5ZHr4D95/eDJEAHuiNRxxrlPhOgNixMaH6SZbSi7p0o7oGEpgJRjU9vb4gVZvJMbv+y6uSuW5VBshhhSbvKRuymELIxW9CcuHppSGG1ilqsPw4nfIxYr9fkxc8MOEytwjftre/jVVN2NV6Pm2qqE2hE3Q1+MnPMGrZHt2KlsflZLuvRZh0uIazbqLiSD626OFeTdiUH0/XznYALcz2q5/ytSQLzpqI4LRT51jvFxq6JKEaEi0jW0RDe7sBv4Jitk2QKBNGKMb/JMtJ/U3qX5oSaz1U44tXT8e2M3BKxaQ==
X-YMail-OSG: qJtbDJgVM1kuXEBvY_gyA594Qy04sC.qVfzAo8z8xcJDtJx.cnKTkXvXLKA9XIL
 BLljZ6YQFmj_XEC96n6q7ZsPE.7NZxHvm7p058_10p1EhyiAvCIt8KRMC4ZFO29NrTn4FLxxrY7c
 0wWE65MgSGX1ODTrIK0nECqB9.XkwPK0Wk8t42q4z9vjInX4sOHE2mho_HDec0TCBQSDK1WtAu2O
 B4gzz4q1sc37_5mrbpTw2kPh3TLPXmH6BWW2Dg0ktXI7BMCen35sMrx23Yksfa6opHqS2Migb4BC
 08FMJpVx27LMmLvHxWtrRXf7xlcF4dfIlCo9H6rHTh.T.Tof_ot0BDL8hrb8KkVpryib8fG0cxmF
 MCaVuuTJyYuY1Runs2G7J_lsSui0hsr7mFEQmQ6WnIEy.LRV4miXtLULbPJMVEIMrfo1frfwZdrq
 B6kmXwD87NOx7oN0g4BKmswa9VISoUZBDNGfgBBOtKvZwBvFTSeOXqulPS7w3wLBeSIKhGDiCzRF
 .vPx5z7ZtTe2WsxHEb.akoWgTk1aNUClG2.hNhexZou9EVy9Bq9lbuvOogkDUIZTSB12G4kMQRSH
 jo1iZJVUA0Re9QkASUPdc6SNcGxQiwGMi4E6wKicklh3qWs7FFLdOBlDocG9Y5jRRcqZk4Apfo_k
 NHzY2embLqrT1Z.9G0IuL2lHC_CkgWLlWI5wqtqhcNna4IDk44lmVNKUJppWfeQ3IfNfMH15jLt8
 hbndwlV3BK1gifW9jcN57prnoM_OqJnwtD5yAUPs2XSy71sgIVGiLDC8rpv7m3sZEKv8.amqyFLu
 t3QJ1qhruvb2rX1Nj6wriHyhs71epV39.6FTIiPry3GAN8NU8UAFaC.Ri6hUEvKHAqrk1aSaCn5o
 D0svfjylllICxG1z.jEMSc0dO11kAJSgS_fBzNI46KN2fFwZAavhyGIlGXcyZ_oCO.KfEBCHRW.s
 HMb4q7gv.CqkmzutrxM0hairssO9NOlUZ9FG679GGKCt61I1x5jR6UuMv4t.0u6kK65AI3IGH8YU
 DB46bFfCSVFIdSOSEcQlHB42mXTrnWRlzHTq0_Vtj_Y9ekp9dC9u9hw.u5ww5c71jlFuxAd2Bdss
 oa3V0IC.bLFTIXcDgYMJmoqH_FsLsHo35uaVD8lmLY5dLMGaCdtWE9F6Fy60ZOQaJMIMHYUzRILl
 x_LKTkd9ke17QKA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:43 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33cedab91c06b09a1d8646eb41267569;
          Fri, 19 Apr 2019 00:48:42 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 61/90] LSM: Make getting the secmark right cleaner
Date:   Thu, 18 Apr 2019 17:45:48 -0700
Message-Id: <20190419004617.64627-62-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Getting the u32 secmark from the result of security_secctx_to_secid()
requires knowledge about which LSM interpreted the context. Add a
function lsm_export_one_secid() that finds the active secid in a
lsm_export structure. Use it in secmark processing.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h   | 16 ++++++++++++++++
 net/netfilter/nft_meta.c   |  7 +------
 net/netfilter/xt_SECMARK.c |  7 +------
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0be6eadd0110..8eb849d71e9d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,22 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
+/*
+ * After calling security_secctx_to_secid() one, and only one
+ * of the LSM fields will be set in the lsm_export. Return
+ * whichever one was set. Used to supply secmarks.
+ */
+static inline u32 lsm_export_one_secid(struct lsm_export *l)
+{
+	if (l->flags & LSM_EXPORT_SELINUX)
+		return l->selinux;
+	if (l->flags & LSM_EXPORT_SMACK)
+		return l->smack;
+	if (l->flags & LSM_EXPORT_APPARMOR)
+		return l->apparmor;
+	return 0;
+}
+
 /* Text representation of LSM specific security information - a "context" */
 struct lsm_context {
 	char	*context;
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index f25b26318d72..ef8db0fb0af1 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -588,12 +588,7 @@ static int nft_secmark_compute_secid(struct nft_secmark *priv)
 	if (err)
 		return err;
 
-	/* Use the "best" secid */
-	if (le.selinux)
-		tmp_secid = le.selinux;
-	else
-		tmp_secid = le.smack;
-
+	tmp_secid = lsm_export_one_secid(&le);
 	if (!tmp_secid)
 		return -ENOENT;
 
diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index a06e50535194..b20753957e8d 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -67,12 +67,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	/* Smack is cheating, using SECMARK_MODE_SEL */
-	if (le.selinux)
-		info->secid = le.selinux;
-	else
-		info->secid = le.smack;
-
+	info->secid = lsm_export_one_secid(&le);
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.19.1

