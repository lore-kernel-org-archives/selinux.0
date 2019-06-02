Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B4EC28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D982794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="n48gwVeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfFBQwz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:55 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:43945
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbfFBQwz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494374; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=n48gwVeFVX0n5/5KntUUwoFVWUsMxXga8a+2JtqaRqdvOKqyKVNck5raEp1VvxrLJDcsLODXX9vBdj2JzDnisoRW6uRPs3Ki397Sy2BujqeV4/qJ3AibZcP7BMJCmwNJrg+qERcx7La/oz08LKYbxBEXEqnIauxmQ2SDwpofDn8wXXGViUXCYpcYx5fvS5vfpcImVBNyfZgGXQWQEnyKhNc6NIzhKe+8r2aDiVsXui8M3XG/AeR9fRwMzRBx9whVqt46UTCyP8b5Urvmy3m9UMiuzPmJ1ZI6tpNNw8Akw+rFm5ZSVY7J91sN0fZoXgN9rFLii9eZzU73SpcSwl3obg==
X-YMail-OSG: pC9PScEVM1l8CwjVfEZ6.ngDIJGDhn3wBv8aBW2lCEP4TWSALaHPgZzQ0pRSUXB
 Uh_Wc8JAtxPQ.FCGZvPM.6dqEAZM5_2kgBigmZXG0wJapUMhP_BmLunbqgRzMisezEmhS_Ci3mw4
 ATUTLb4juKqWql_6t6GW.Z5z_iZdWbin_xtOQi3oYP1HUwyC4soO0XmFIZprXCXjx0CkEFH6fvxt
 Tp0.OcuR.p1UaGUlIeF2DHJoHTxWYJoCR3Jnmwmeqfq3V3dYQBfYb7ySKQSnfhoaKV3Eww.yM12I
 anZWCqKJImnOtkl322Eu9OiGnE2gz8yHGe7jvYikTmvCs63kPm7DRT75PQlkAnZ_FZf8NXzYLxui
 bC8bMWW7ZDGDJw3JUuxo2Kksgl19iX_vb5s_gvdjCi5zdkrj7GPQ01Nbyqdm8obGSBubRbWWJirM
 TRIX.pGs1P6eHvg0xv0lpl0TSTDlA9oIP_iVg79rbPY_SykUwjIuu7jVg9pBwT3vxRnP2UDXPqDt
 dy5SaUcPwf1OS.Kty7VBGo3HSZqDb8FMGeVbbZXvuRNECsh0zp.VBzFt1h.Jm6SOy.NQsGvhVAz8
 xxwY9xdFEwHul677l2zFWG9.m0Iw1qTVQ_wKglLTvOWZsNqbDzYlkcLS4Tf2RAqlOgnGvOulj1ER
 balhPz66p8M5romoRtJvdHm_VcrfA93l2zO5GVDNn_j7Mj607.gs40DGHAANZZrdoU6FxFj1cZls
 Hbqqso7IOW5rbiDMQiCouTaqpkCBfyw3Uy5E_cRou.o2m1kN_Ks2qJY8OiYwWOX3SPiQy2XXb7_O
 OVUuTt_XmfsOT2tU5ZB7ctvng82Ut9utobgijtsJ0UZd__Dpdgq1HaCwN53xvi0UkNKhxuqtsCmH
 MdF5S9SxslKNo.wkxFNBzfNs7D0ecxc7oan6BlwrPsTmA0JxS2CtklUOHrgj.Alcvw9QqKOTAHhY
 QMQUrKejXouO1.tdUlKx4zeu18mWl0yYQYppXNiK4K5lbE1hVw9wYW_Rh8B8O5xB3BXl6iCc302M
 suBQaAlm912e2M3RXGLE1CuJfjZQMs5nz4.yNBjhmS_EVOSVdveO1gGPUYqx0XpKffhB_ggxtu2a
 BtCu5K2fjytUKSTDpqfVBoNpKCxURGar5.ny.J4fCJSZlehdNQn.w.Kqeg5jbDmsMc6Bl4CtgjxA
 0kpdNZ0BMXCCPytRK7Sj1M0AAp._CMd9GrDdHyGLDbOlwHk3O_YKZFp9rZidnXbDNybz7MCi20KG
 msWwAaI_li46OWPKaNMwhO..4rYGFR1kOiu3lcmumg3roTOyrYOiR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp409.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0c0e3da8255eb26ca342a489fa1b8a19;
          Sun, 02 Jun 2019 16:52:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 28/58] NET: Remove scaffolding on new secmarks
Date:   Sun,  2 Jun 2019 09:50:31 -0700
Message-Id: <20190602165101.25079-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

