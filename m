Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E67C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E372B21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bWVVU8By"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfDSAr3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:29 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:39274 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfDSAr3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634848; bh=n7o8QGFhmUAYfuuVtS2cjj7dSkuQxOxyGbWYP+SBOLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=bWVVU8Byzt1gLZXJMCCZZDZyFeJlrFBfE7uqJtbnUUtG/sCd46KmavmSIPdkHxlBx2FISAX3os0PyLOY9gowCciXhyEHvYiXr36hvJJ7rcONdXqzPEch5XOx/Giqai8akY+HcDQthLQS9AhlWuRiL0/UbVdUUwOiF48IXlEUV+LAaA8YtAK/AhpEhd8DCT98Ldy2ebOYqrKTKwBrPO4UxHqHRLU6tmrGr64hyjJlQXkGuMs96FH2+ilVpOsDz9ZAB5zi3+Gq1kcFPDU1dcEEhjEOPoeqqcRh8kUubnR+akpOI6xJwKKhKEBPXf88LbhYutHETdrke7hk2JKLFQI0IA==
X-YMail-OSG: TnmnKLEVM1kRQPkMQLuqcQNomygn28zBmJqR_oqqecfEAVougFHyET5.t7IGhiF
 8l4rRS0CoWnFQ03bMqfH32tFmymp1yq4MlLNqS.zegHxLFNAhcUAy.9.1GxLVo_EVDWpD4QNyWW3
 8D1n2ZHrbknqVO4CuhGzxOs0ElkcKyz0jhTYJadq.VDCeTvuKgDYZ9bz7DtzKhP5DrWZmciLdUG3
 C3rWJvwAXRN9OnlXx3jsG8j.PbKAKnMUGUqr9jfsxgcID2am7qdRPfzyuu_lLu15E5q_RuqIOorU
 2bXJ8yKDtJ1y.HTPK1IQuorBKmT5sKchwcg9MkLBQONkHrH3q3vZhESJMBt04g7UNmigUfIFsOwU
 xqGkCZS9kUcx18cOKeylc5sAkKv5efd4D95meD6Mu1pORVwwjL5xQaQGXN7ubUnLMJr56na.N1BF
 wNktooGzZRmks9150TXFLrmut7Jpu.rFJcCyzenCESyDXBQQt4eD8WjP5ORF0SlKgGGtiITkOj0o
 IffSv3W4ppysYrz7Eal1q95hK__152JZ5WWtq8YjDjnL7LcDlj5uaMvQ3L11jiC4yvE7gr2NiUqh
 AqOD3TUOl5QKZ15GpVjNAyWC884ibbTjB1yjvYuXWnazv6.XglktEyUizaEiKXGwVFasmW8V8BlJ
 Hj2cTkjVNJ5Pnn_kAa.qs3Mw2nKL8n6pnlZEVVGZg0L0jBXwEjlU08IEy5yUrw1qV4RXcFDsMiaJ
 pcrMHt.jZ8W4CPhV5GQUi_RzDYKOYa9doel2Qz5AHNY2M6liKlaomeIE9ilrg2RpaBYiNhwX9QAK
 8jRCzBg2ovom1pn7ewEtgKIf1b81xfp4jURM0EXah.PXq_fx.O4XSe2HGtbgNxHwu2rjJ..aqWvp
 wY6DMPO.W0to3qMg0Xke0_YuO_pBHYbO_WygMBBZxCMn2CXf.X4UPnXmRl8M6XhDKStYhMFptv10
 Y.ODuHI0gLQCtjblSH0BM74xzAeWUaDmnTSYy6r4I63.hYiCDV53XB2wGH2fzO11SmcFTv3e_S9u
 bwpxwQ3mDD.Fl15nqDznhE0GvSyr5NjkqAeF3xUd9h_9ykZBx9MQ17IE.kYCS.fNDmHooHTRVgAb
 Szt8DQSvuwAJb9.TtqScDeML1rqo1V.44oWfufNsAtvrL.ZO0h0JFsAYTG_7SRaTR1EVAnmXKHQQ
 5ePZZvNoeoL.n
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d780a730ba98836fa707a31546db6ad;
          Fri, 19 Apr 2019 00:47:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 29/90] NET: Remove scaffolding on new secmarks
Date:   Thu, 18 Apr 2019 17:45:16 -0700
Message-Id: <20190419004617.64627-30-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

