Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4878C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D75A2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UNmtIOMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfDIVkm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:42 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:33114
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfDIVkk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846039; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UNmtIOMCUt0qtBx7R7oZtgeekVL/I+5gscfFEp6ubf5Zf920ytBIFKti5oXWOyvSduAsZS3aabE2fyfExx//U+ZTw9KTUleoJEKqn34011EUOwF291HmA5RxBsWwlxUWwObk0rpiUb88Yqn6tyG1Q4LDm/1OPf96++yoGI6hHhNKUHXydHMCKcFFUPaGRr6eKc979ozC3vRqBhmi1cc66mBFBECcdp9EkbdH0QZXuhnUcsar8ZtID8LQrPLNZYlI1Kv0G6t2+0UshFZex12uqQMRDCf+9233sNhhSGnkp1fF0Q2chPdJfKIQEhhKGY78bZNoPRbyGnfD7i0yTeDVTg==
X-YMail-OSG: klhnJrsVM1mFCnkU0Kls9h.5E2Fia8TasWTMc6Gtx8H6I08ZbPL7wW5u1X8s7SX
 yeG796lowseN0Y36oBjB4Y9oKEtzFRHASOf.rj1P.Ayw4bKauE9HH1EJOP8pVIbQKJ_56kTIwvjb
 kSDV0sFmq2lNlO_XpWTUd2BG3xhCbd64BdxQIXMMeL8J88cDzU8R6JJ_gSxTWGjF9yFFyvYmRn6Q
 mJddrTQftmzp.d6ZbH10y.Q_IRXWu2qaGUGUzQJ7yh7QDmRjvgEysZ6MrUMmqwrvsa3tqxXWKgKm
 pqv_AATCv9Da78rOUymIZ8ES6uGXd.QUmhALimOxt3jiVa7HiIpsTns9zmLXp.PiWSt56eL0F_07
 sdUTJTgpDHGjHb8R5_I99.89mbszBHu27k1qLu8tWjcAUZUi0QIQRf2AFGc4tWUc2kFHBfJHbGG2
 OB3TyP8VH09VX0CIdvNkV3QZSS.0qMABgq_dnggujYVEYacdZI9WJvUYR_BFWN0rn.FTckD2SDXq
 t1VDm.cUc5I05_bxSWFF.lwnz4XjLu5Px0JnhbJLWWNaaSmfYb5cMQlQWgOGsbpxfF90dDRXFLP6
 AD.oxCorvUVmhSWhw4LINs3fEKw9D.sYkuPKQ62iyqSlmENqqSIuLrXGJwZKMipBRYYWrK03zd8t
 OlCbAETOYrvzhQ2ZG5Jil_3EdMQrOZWIVYZ0BB7vt1GIIdbUI_kC5hfAX2j_eWqzHR7n2HXjMOzz
 ddSMJ1UMwjlktepwWnapQ9UwVv_OGPNmFlxM2xuhXP6Or3gUcWrmbr0GYLsbBoJHaGxXuKWuMybm
 PC1VUyyspg55lD1rf2dhB2gCwZdHrN4.yskDsE4Mxw1fE7owb8rhmRvroQojtli0Q252oz0EepHo
 NZW5sGIE_SUq6R_CRcfQM7yEscq4IsRBRxhMx6W4Bd2vJDThrorqqHrDYems3CY7Z7o_9M7t8XyD
 HYE_jMrb04297ehVpoEC3djNV3vlBG7XzJekgi4YwDR6TN0JtF1x.Ze1mLOYpugbz3lAmXJpPwJd
 VULRFokAj6mMgNEDnWgoeZXXK24zepF5bjAMMefWCscUQh0.DbrQPk80tWx18tq2r429k6a_tP4K
 MZ7FQYHFjSlwR8HlTZt1cGPOt8WxO9TPtk.ARRhy2VTG1GWd7dK4aN08ywGTKPw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0f9fc43d6127678694d9e39aed29be56;
          Tue, 09 Apr 2019 21:40:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 29/59] NET: Remove scaffolding on new secmarks
Date:   Tue,  9 Apr 2019 14:39:16 -0700
Message-Id: <20190409213946.1667-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in nft_meta.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nft_meta.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 598bea8e4799..a1d3dab5bc25 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -580,11 +580,17 @@ static int nft_secmark_compute_secid(struct nft_secmark *priv)
 	u32 tmp_secid = 0;
 	int err;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(priv->ctx, strlen(priv->ctx), &le);
 	if (err)
 		return err;
 
-	lsm_export_secid(&le, &tmp_secid);
+	/* Use the "best" secid */
+	if (le.selinux)
+		tmp_secid = le.selinux;
+	else
+		tmp_secid = le.smack;
+
 	if (!tmp_secid)
 		return -ENOENT;
 
-- 
2.19.1

