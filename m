Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EFBC282E2
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E372084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ftgsKBJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfDITTT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:19 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:41179
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ftgsKBJDlSA7vkxZDHM6QPTCuIIP7eGCHvBnZyul8Hpw6mmYAgYLN/ocvo98DVGGXLz9dD4d+YvbZdgcPMExm/j5qaN3tW+zy1mAefRlIsRAI1eQi7DXISRIJHXVtEi+V3mmN0iIhaH6AqyPejcJewpTAh1SGrRPQXxsw28JCC7aSmBXX4aI7XcO4DrvERq2VvQ6Z66Nn36DRAksNyQAUxBXqgSWz+Wpk19jQRbO4oJdQuDXoir9F4mgH2cw3zvBNg/Z2MBpAD9qIxR5QIlajG6JTFZAti3vFS4U0MGuoBnQAAf0GoTgT6EVgK6tzJDqMxWVqDHpbia3oR5AiyVP8g==
X-YMail-OSG: WnHKRRsVM1nHavz8TTySgZ2KOMN3wr85pwvQ9DOn652z34CxPt1kxa5x5KgfqYw
 _Bl4fMcMCRjJjq9U4DEL_87p0nOKMm4WksoR8ICKlUKgw0WUn_icyeCMAkT_q.3qv45RtqfUNcdt
 Xx2zS6W9u1CPrgaMLBaELznrS9.DrRpeFzUizoHFdLnVXcc0e_L.VYB6fH4PWd6TnTMRMAgVsTIs
 j9CsbEXrD.D5aceizsrEsqqfyG07HKoKHS_13XqYt064EmlavAu.lPax6geQ9ZrOS4z67Z1vA.ok
 qNyCsorLwGXNN4eO40HvlWMOVaa2SIgmpSWc9L3QjaKbxYhBLidb1IAwrsIwn3EccRxmOC91eFqG
 J8wzuNn232UjxlnfM_VdwzlvWgtYdAaDOEu_lF1M_o9s6BBnVU_MY7Bp38LnHwhbKInncro7GYNf
 hHfDA0t6qDhHiXt80fjGdRmvRmEGVWOzVs829QPbHSAUFksuUUw4KtkeunLZkCJg5PgbeYp2fFHJ
 6bKeuPhhFMyytBRJTtQdyDyD._596MMHOJ29gQkx1x1PJPFWH_P.2Ggef7rCnTiA2dOn3c5W4y1O
 I.oG4vPUYTCwxCsnbqlko2AphEKFptipdISZ4j91VWcWPSc3GQpdRfsZx68NdgVFeiEXI_EGZBfP
 95prCccrl4ugQtis_eg6_g8VSugP7dGIt9aEJy73paSbhUC1VKu17fCA0o2k9uSdeEMOqRCBaJeJ
 w0s8fcG4pK78fBX8gq1PlCDxKgGilkXxZfPH8XfuB6Qc4UfmBX4c0UbSw9aC2HyouNhfN6DSxNAf
 ZquF7liWDplF5SnSCcEj7RF403H9aI6u6NcZpvXqsiLG7L1GbD6LIDABsDQDZkQSNm0yChO3.Hfb
 an7jzkmYmj4IDpZHBVpeSdIWX1Y0DtOnMkA8boPqtlIp7CncdDh9uPhttm9pYRmGtKZi1sETXtmc
 XKR4wg3YMYe7Jogg6mbbv2NGJGZn2fRESJfT4FBAwYZddXL8W..WzMvIDilKgIJFsGmWqag0BmJW
 fdZp2Nt4W34d0fS9Kk2BXGmCXTaiISy2S.sbodHibD_En6bSPv.mmaIeBQ39qmnVzLxo8IPe8thZ
 5pygf6O2bluXNzg3.GNZgzEG4xOOkStA9Y4ypk4QkuFgc1PtBB2rUMZk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 29/59] NET: Remove scaffolding on new secmarks
Date:   Tue,  9 Apr 2019 12:18:18 -0700
Message-Id: <20190409191848.1380-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

