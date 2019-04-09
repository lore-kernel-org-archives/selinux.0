Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF990C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7192082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nvxznKSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDIVlv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:51 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:37146
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbfDIVlp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=fGxfp/CN22PmumS7bLwAFMtRgSd8WhnZOIiNQimjmvQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nvxznKSE6eXsaplQwxwglVie6+pYwMy0EKnlVpQ79jVxi1mM0Wf5VfQPPEAnY9KrANDwogExjt30QJGLG/Eb5AJuYux4gXb1OtA+UwrLOVX+GOhhWtSv/RvmcrKM70onPkYg5XWrgWJBmjqNF/MFcn5rwNewfowgwDexKckRCymmk61JXdnUDs/FHIXJHw2hY63Yzy2F7wH7cuaJosfcZy1/0pYI56qqmDQnMrAnqZaeQHlf92HdnnClmfWeru0eYhBFr4PUBh1+6H/ZNzhdB0Gy1BsSn56dONsnewqAGQl+zkmjiHgliO3lREiTelJC4mmW8oD+HHG4qwssMdkZnQ==
X-YMail-OSG: OEZq2KgVM1l59GHVuZE1vRJue8wYMJ7lw5V2tnCt2yTEWQZDJt9Anef.kkrjBr8
 a5TxZ.oSVtCFABOzs_gipyrm4T_u.myQxQEdtJG4O07QoNeL6BA2YLA3EDBBhVl7aI._Cv0Y2zjU
 mH3KlDf83buHefR2CMjTzIi.BpS2tXBKwUEn7XDyX..OL_CuGGN2XYC6WJjL4Dr_10NI8NowLWVA
 kCE.6yy646iQkjuuAO389nnA1dpwG0PJ14ra.P2uwHfTK2pRsfA0BvnyIIMhdKoxM93UNjLKaH4D
 QIbI.Fba6wLHPZRc2TrQH5IAwShA_NNuvZCGTwMIncOJQexWtek4N9bR.MI1Nvd0GSbguiDNbLyS
 g2WZg_4Q1yUvJ8Dutd4EJVp_ePQ2KvztYNN9XeYAL8CfOT.7qhn2QrhGQ0M5q1EKk_4meBKycnzl
 TfehKwzMbkaV3ojOchtw0vDsrto3fPdTw9gVq6BipluvHjJkbY1dLlGhAAhJsrlBmbTtGcQAi7hT
 L39dl8S9zMAuS2OL4KqXuBBCLpIByPFI7Fbv3sUMmf2z4KuqVXlC132PXXhW88_PWDUjehyt88NF
 yRjlGhzUqNc6gpYHNUVyL1l.pw0zH0X.lq56ubOEN.1oIBy0bigXEaGXgUCi2pf1MoVBeUBo.2jI
 UfiLvUAGHHUxKkzkYWSGdTQWklpYmCUtR8mkKlwgDuWB3hds0Jf63yFlmilLBAKcHmZG3R4or17R
 76Hrue2n9kO0QARAeIDWfaw_UemwRNbgjFNzn_rrUyNMT4bcdrWhZbh9ljXFOk_27hm3bPY7Q4PR
 2YH00IAaD7nVaW9vzPuhKQw_t9NZGo05sSGpGvM87gkqpiJlRGMT1R5jAtZgytc4p.3lPi0pSQtS
 oLZe5cA09qLD0wt_fCjeDz6qEZES68GMU6nq6ZgTz0j40vwQdXJfvbBuHPWVX8LmZ3YUdqW0w7je
 3tFGJBJFuLBNFaUz5dFYHNUYaqPlvXGdzsX.S._rgBmwxzdUEER.Q72.3m4IfgHaO70jDBr7lRqu
 SAkWVO4cJVNMxCNoeJJhtMWWCRn34v7qVTr7Awrno_hDDiwA8yMxwUtmacefB09LSeYC.vG_w.o1
 NNA7WDHgvdDRvJy1DA6qgHOEr.Rprr0PoGdsWNJR.BDe6704VZb1US5oXpwWrLw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4c017142cf03fa35170466cff726262b;
          Tue, 09 Apr 2019 21:40:44 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 32/59] LSM: Remove lsm_export scaffolding functions
Date:   Tue,  9 Apr 2019 14:39:19 -0700
Message-Id: <20190409213946.1667-33-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index c413dcc1905a..6c44aca19c65 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,49 +117,6 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
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
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
 /* These functions are in security/commoncap.c */
-- 
2.19.1

