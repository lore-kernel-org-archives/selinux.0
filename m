Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DFC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5469421743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o+Nvleav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbfHGWnK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:10 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:46719
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389519AbfHGWnJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217787; bh=oBuorhWhLY+mZRjcw9jSzrMoHev7NoX57JzR1/BKE8Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=o+NvleavV5EtFaBjOoquP5bi2g7WbBfvNHaXbsgz6n/OCJAqPDFdldoDBkrJxdpdzJpygX1i1a+vyDE7PYn9rsThmrS7vN6ZSun2sxTX+2RA7KfganoXmquvU0RJqpDbdW7JRAicoyXLroiPi/8u+E0l4CA79b9mGA6GoMIFbK93smvR0AifZl8r2PKmhvt57pLQVgrlvDVlItoYkm1x78ZhOR+fBHmxqMINlROaI3vhB6DeEMKZRxh6TGeKYZEUd+VducbUP8gQgFTT4BEwl8GEZbMrdOGPe8X//N1Izf5HvfMNvxWMQkQOlJxtYa5oAInPUBtMQJ4unt8zNnUEFg==
X-YMail-OSG: G6ewfYMVM1mydPDKko0vEQoXJkcz7kEB0ViDQG3pnQN40NrfTi6ZFlRVNDWq.4D
 FHe2PLw3GKYHZ2qxwsA5RYjQxiFhR_sWug8LzaOd04QAM6qtbw9ed79VVXtQQeYTa_jKjjx2qb9k
 nKHi9HUOaL.9TknWCZnMtrEZLCQAwzOjRzqAlgiSF_38ToQshs0omtyCHzlpdvyk_dg.cyaFBgf5
 Ua3qqNH35pPKYg3cLFwlplA.n7ABUdluE2W9uMAmmgTU34xZGV_i_e8ycaBc3iJGmHmq2vSaY77q
 kyQ6P..69wGo_.KtRBz7g4rCmk_OFG5PL58YJ0kg6XmwoSqXUguxVAhhooGA6jh2ZxUEIZdOL0ig
 TP7D4fzi9fte29NyO11KoRZXZ7Kd785JGQc1.02LNB7dcoq_qwzuFVklzWUV8kFA3is2E8zlbW7H
 e0YeHVyBERWq_xkRBALx02sYTwX_zDR0MPMNneCwv2AM_8iX2jptFTcXSpTzNHLykbEI4abPXea6
 WOHK28OtyrOJ5w9.1ENnlbdUCOVfkbB9FoMKmxV.gTr7_zdM2DRWuF78vuj3hXTgG0ewYj5WhweC
 YAfYx1IR9bM_4hcSGwtQIlSSN3_V3BIwLtw1YWrX7mdP.naN7omSQxgimyUlChaWHu.a_ext8OyD
 2tURV6EVl36LX5oTUdSgLpogCSjCPQzLk81Oe2BjgH1Ffl6OZ05s_kmmerRoUOpV_95eAHr2Y17Z
 5eWDhY5tieAGTdcGBLPGK52Qs62eT0GGCVdkEpBbX5t_yj2gy3xqH94_LWy_QAUrraMW1M4erTdu
 7lBl2brnrkhWH_XLj3PrgtAdpvucRIUN_q45qaSsDUJRkKHm5Mlq3uIu7Wilt6k6_0DG3ioT2Lwp
 6LVm2XPkNLdh_rTYMfzVJ0TJn9HQ4_yv9zKU.9psybkBPvar9w2ptII3uZhH.2JijsyZRe66eUtd
 GHbXz8tqN9sKoosVwv3j6n2kF3wXi6P2KHX1l0fcAjurqMX1dVtSMx5TofvfJJvU0EHRdJvsB0R2
 MIZSLkJznj0Q9bnn54skFpF2TfjJqXq9OHn34tE_O8QlmkKqrZNoCdaiLPXokO3m9FCu4hlM5G2z
 k1vAXJhZuGdp1EYsvHzx5nj5vCj3Ttyynvt3RALZ8ySUSLk39CMYufDBlJ_U3nVTMwuQHvKmQN_2
 wMWkrUy2yxhvIUvb5Qpz2EiqwLqbUpneNjqkYlwfZEgaEQvFi8oG4VJv.oq9.bNxYw5BXOPyxAvO
 AR8Km9vFdTfULGI8czgdkC6A5UkAIigM5Fkru2NWyOEZCnQKPdjqZQg9X6dMrFU1WDvSBkxzLlym
 tVrDAs__xvA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:07 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90d0e6b59b40235a6b1cae6254f016be;
          Wed, 07 Aug 2019 22:43:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 09/16] LSM: Fix for security_init_inode_security
Date:   Wed,  7 Aug 2019 15:42:38 -0700
Message-Id: <20190807224245.10798-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code assumes you can call evm_init_inode_security more
than once for an inode, but that won't work because security.evm
is a single value attribute. This does not make EVM work properly,
but does allow the security modules to initialize their attributes.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 6dbc7ed2a00d..325e745ac8f5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1158,11 +1158,24 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs) {
+		rc = -EOPNOTSUPP;
+		hlist_for_each_entry(p,
+				     &security_hook_heads.inode_init_security,
+				     list) {
+			rc = p->hook.inode_init_security(inode, dir, qstr,
+							 NULL, NULL, NULL);
+			if (rc == -EOPNOTSUPP) {
+				rc = 0;
+				continue;
+			}
+			if (rc)
+				break;
+		}
+		return rc;
+	}
 
-	repo = kzalloc((LSM_COUNT * 2) * sizeof(*repo), GFP_NOFS);
+	repo = kzalloc((LSM_COUNT + 1) * sizeof(*repo), GFP_NOFS);
 	if (repo == NULL)
 		return -ENOMEM;
 
@@ -1173,18 +1186,20 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		rc = p->hook.inode_init_security(inode, dir, qstr,
 						 &repo[i].name, &repo[i].value,
 						 &repo[i].value_len);
+		if (rc == -EOPNOTSUPP)
+			continue;
 		if (rc)
 			goto out;
 
-		rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
-		if (rc)
-			goto out;
-
-		i += 2;
+		i++;
 	}
+	rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
+	if (rc)
+		goto out;
+
 	rc = initxattrs(inode, repo, fs_data);
 out:
-	for (i-- ; i >= 0; i--)
+	for (i++ ; i >= 0; i--)
 		kfree(repo[i].value);
 	kfree(repo);
 	return (rc == -EOPNOTSUPP) ? 0 : rc;
-- 
2.20.1

