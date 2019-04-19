Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E805C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F050B217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="It4wecjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDSArl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:41 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:43512 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbfDSArl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634859; bh=gEWZCQzFlqcooAYwsHr2Nt701eG0L+I40RIrEVg4i3g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=It4wecjRGLhJBRQNb1T9OEYBbtNq50nI3iOsL+welBxx37m8t8HrctVsMSOJR/ya0ThT+5pONC9JB1aCwOI9i6gr6YBM7tocADoLMjxRlEJnCPD9m0tZ4K5YNSl0nVEz2PtOOGhpFXoOG9O1jxHAsXxBe4KHkldtnY7LCxKtVP2TPtVO8wIkHqeQ4jpxE+SnObDBW2k8+0G960io5HvfH9r9Tr3e22DAVFze+Rup4N0iaHn23fYsrlhI3DAZ5C8FTGuYN9mch39vmYg7zaMsh2F/JnZ0ZdBsuOz2F6FNa4JaGGwWfPbAAeCLGc2e6bpMxrDYdyR6d2C68onK/3pYmA==
X-YMail-OSG: sF14p58VM1lEXulwth_pfgFyi1eHGhh3wD1GweDjGm1X.UADS3ej0eLb1.O8dKk
 X2N3GQB7y24SKTH5SSRTjnDZsK3OVCq4AY0e7Db8z6EjrL35wnaaOPlfs9FqR7gHkjvxntwjQ2Qr
 cND5AGn3LsH29NKc4xIwpA3042WN2l7jWEjq2WBWWAvikRK1IkrM5SpIR5Ifw6bVCsH79zUY.QgG
 GsJw4vdsIIvYyQdYQMZtKYM9CGNERcXI5CegAwrCr35L4S43gk9odUI0_Cqr4cdrE874X3suECMJ
 33exIKQ6bJr_F8kbwIreHDZhG0MQPvR89.yjEQJ34.ol2vjvQLfLvqYZiQGLkRo1EcqIZnHFZ8kx
 pDel4MIhoKcHnS1H0zDlv7AJxV1hT2MnYxqqwDfKhG2yBdoNeT2jSApvjLyg1hvNxwsYlj0jn3bg
 6b.CzVocbHuRAvS2nMLhyRu3vSv4AEReBDa7CfG3rpWscYaRvxgnBDthsnVT20drVAbNxPAyT7no
 W9pAkPpGO2ba1sX35fT7__g2TjyR1h6IJi_drluWkYm3XrbBXbXV35qpL0ziUeV6xVSieNVzzpq0
 lCmHUx8ESCMOZ.k9D483_OsCGemidbj.fUHfUX2Kv2O0G3u.ItCVuggtVDPNFqhN0oc87sIklK_M
 PW7mQxhUsA2Qs7JIpx2Rl.6O6LzA0sOlTWSO_bb4gUSXCzKVum9qNwJ_RDZYzpglXzzD4O_pP8er
 Wa_bIrdgKwMJYeYumkWvJXaML_xNPKtBY1BwHcqKM.pyzB426Cf.vpjLc7BTDsxwueJ4O6fsVbSC
 93lBjXX1RXlztpMmx8kZpKWFZJzgSo49c5BWvPk6vO1b116F2CRHefKVuSiQqrCE_DC.HTAbToP7
 dYkXzidR16k6sBbtJERIiWQT5FmexVYQlq1lr0nEtEIIlkLw898R9f.z1l1SdmtD86BxGjisjchM
 M3uXziEZqn7d9f8lyohBehPL8Nv8fvX4Of2uyRdzRTpJwuzhkFqQJp5miNXAWyw9O_7UFI4qnnKp
 X.pG6QbDiXekcl3H.7CxWdKzhqFAQZwt5ELEQIHwG.C02TQaKPKWaDBNxQj0OdqalOY9yZlFgtgm
 5xGfAuY3bO3.EgJkLvHOojUUu8bOQP8J5EXGOKGBRbPcEy8yty7w_e8Lp_k9ofLiC6dQUEVCHfvX
 GDYgXH5JBNxn2ZQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3136423b19635411d73e92b6945decf9;
          Fri, 19 Apr 2019 00:47:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 32/90] LSM: Remove lsm_export scaffolding functions
Date:   Thu, 18 Apr 2019 17:45:19 -0700
Message-Id: <20190419004617.64627-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The scaffolding functions lsm_export_secid and lsm_export_to_all
are no longer required. Remove them.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 43 ----------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 9d8115b3d679..dde36e850cf0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,49 +116,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
-/**
- * lsm_export_secid - pull the useful secid out of a lsm_export
- * @data: the containing data structure
- * @secid: where to put the one that matters.
- *
- * Shim that will disappear when all lsm_export conversions are done.
- */
-static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
-{
-	switch (data->flags) {
-	case LSM_EXPORT_NONE:
-		*secid = 0;
-		break;
-	case LSM_EXPORT_SELINUX:
-		*secid = data->selinux;
-		break;
-	case LSM_EXPORT_SMACK:
-		*secid = data->smack;
-		break;
-	case LSM_EXPORT_APPARMOR:
-		*secid = data->apparmor;
-		break;
-	case LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK | LSM_EXPORT_APPARMOR:
-		/* For scaffolding only */
-		*secid = data->selinux;
-		break;
-	default:
-		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
-			data->flags);
-		*secid = 0;
-		break;
-	}
-}
-
-static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
-{
-	data->selinux = secid;
-	data->smack = secid;
-	data->apparmor = secid;
-	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
-		      LSM_EXPORT_APPARMOR;
-}
-
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

