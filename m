Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEA6C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B32821736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hc4DM13y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfDSAtV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:21 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:37720
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfDSAtV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634960; bh=2VA6uOU/XgMGox11CWNLvwPuLm+p+pPuXxB0AhzGMZ4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hc4DM13yh1kAZBRI1/U0BFgWXEb0WgA7HAfN+39o+NREL5p6ZEDs40hrolVKthvs+Hzm7EFFWi5f9Vzs9XYB9CYPxNJ4pVR1yhd8esF+nZMW+cYARz/B8CJxy6Ho1HSYRGRsyvEdfToRv84s+u1IgwCm/zA0o1bKRxfPehgVnbI90v+H5WT+IQAiC4lL2aQVLjbL031WduKn4vzzQbIckMbNd0uOi/kpuy0R1HT2qhEB/T2QwXkGfg202zfT9lerVJ8RRp1uL99Qx9BpyaDKjP9ZXdvnXHJqOMUT4io4sxGuP1dogP8L5hLx960FWf7hV2zYZHJ7BibDvOnea0M5sg==
X-YMail-OSG: Oh_raLwVM1k6RcadMyWuYLnOoux_iktr1mbSZW9hkfK9JH2y9wTUdymNeBvlD1r
 2DhV5LhX.xK2bHfmnlIVMRitxjk3v8Q6nyf_ZqEANEBZjPE.tgLChPLiu0FC0dgBRD7bNWE.Napo
 krzW3ajsEeFi7bAPFeNFz0T5iRYzHKtLLC03v9fnUI8.L1LI9jogXHy7ouj8KloCt.U6YeACMsAz
 Zc_fPO_J1vIutyn8VyQYWJ7AFV0lBHr5zTgVf2cavsGs_9C1y1XPrMpKuSqzgesLfJclWTiVzciE
 swt0BRfeJswtvAOU.zxyir95YJs2VUig_YfDco68t2hVLq3YSzMgAYlug9YqJrZcS2YPY99e1QqQ
 r2r7Fl2iIo1svU1iuKMA_.sWSAyVn6ytWdZGyJtIhh4jBaM8lHYbdx16FY5O_OAWYLRaPXIj0szZ
 UPIKwgrRZnEbgL7Dimh9ebPXF.eWLgq8bEqXZ0NwUJo547qg6ItABS1MH4eZNFqYKaiQunx0Oo7L
 BZhszatRHxukBv4.yfz49z7vOl_TknvDnuvFy.3XKFjwXDvKyGp6oEzliKCQH.LTux46VPnsLFsW
 BRv4we9V.cK5ym1gF6MWBMf_5zS.Ow1shXorVD8T1.655Z.IN2Nmr2yn6aEFBjrV5j77YTMbUld9
 XYzN9BC4gBtgeLSWLafo656SzfaemrJ9DkY33bL0E1IBTsKmpIwAoC3xTKZqIRJo7Cxh9rMggomX
 SbtDrwwScbKdgGeOf35G_Qu.Z6wjK20OFFv4TJyqvZx8wNdfuLhNo6XhEEaS7QlvQrLzlM5EtZgv
 Zzz8kyq72_mzQQzSno7VUwrfi544DBEVauKRZJh.zBmK9VjkWAzcgyls5l4u5MtcbEVnqihy7qrm
 vviVjV7i1VfdGXBF2143bg0N90sQbxveOw0W5ffDyNdykqrFgdzSscog871b9D00Dvv0qGibMWSg
 QABZjESElF_8DJ8E5zDEg83SlneCsUcTDG3zk_a4XL55JDw2wB.uqAi0gGcrgGi0jvOIUXMNkXio
 Ip_4KG4vn_SP0V6DlU6yGzrvYIm10.HHez0E7ed.jH_yjrU5kI2zaV43MBoL7gh1ZC5_ErTsCBLM
 zs3AiTQJEOgN25xNsNNpGtiKBZdx7FsNbQAQQwBjnfX9CpYrVq8H9DF7xYoySCAQA5ukZiEPZcJB
 dPba79qK0EU9v6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2fce6e68c800904f23626e111be9fc8;
          Fri, 19 Apr 2019 00:49:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 75/90] Smack: Fix setting of the CIPSO MLS_CAT flags
Date:   Thu, 18 Apr 2019 17:46:02 -0700
Message-Id: <20190419004617.64627-76-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't tell CIPSO that a netlabel created by Smack has
categories set when it does not.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_access.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 0764bb85daee..5fe5c6799b27 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -494,8 +494,8 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 	int cat;
 	int rc;
 	int byte;
+	bool has = false;
 
-	sap->flags |= NETLBL_SECATTR_MLS_CAT;
 	sap->attr.mls.lvl = level;
 	sap->attr.mls.cat = NULL;
 
@@ -503,6 +503,7 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 		for (m = 0x80; m != 0; m >>= 1, cat++) {
 			if ((m & *cp) == 0)
 				continue;
+			has = true;
 			rc = netlbl_catmap_setbit(&sap->attr.mls.cat,
 						  cat, GFP_KERNEL);
 			if (rc < 0) {
@@ -511,6 +512,9 @@ int smk_netlbl_mls(int level, char *catset, struct netlbl_lsm_secattr *sap,
 			}
 		}
 
+	if (has)
+		sap->flags |= NETLBL_SECATTR_MLS_CAT;
+
 	return 0;
 }
 
-- 
2.19.1

