Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF7C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C522084F
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PJvuHBmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDIUAk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:40 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:37653
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726864AbfDIUAk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840038; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PJvuHBmxRQu2kzVtg8R79vIkbU0dxOYIpU1Y9Y+HMXZxCsXZ6gAlk6zhQ8BsNIC2SWaLZRw48P/tw9k8qO7EVBAGBORg/4+N8BTno4eg4X9IbK3iKHzdvuZAH4VaW8C5PAlQi1jymAiJJ9r0icsMCV+uhpNfYTfu6PW+YqtNxISKsArQA7fQjjFHzcuB/ztwtQ5JHzA+4zHPje/ndFfX2aWr1FaZjREh6DPeYgr8nxkxNE37Ne/UjgETdWbB7hCzaM/coJkkyoZRdnvF2/OutM0hh4bW/bZ2fGTYGYjhth7m2NhCEznXQSz+oxqCLuDkWIpLh1qOZfqsBuZF4DUq8w==
X-YMail-OSG: fgbywzIVM1ldV6Qeo4k5OtyF.l9GrRAdQexJ_FiIdaKM98mpIr1bqQfZzbrpYTd
 hFbZigEwF_T0ND8reC27ovS7YU8zHn0opNG_NRuiPr5ZKc0RuKimKqI2t4_rkmq4pjZORBPeh1Bw
 QIzpFJILR_Kc4sRYSLRDV8jHk3BczRYgLXTIPVITwudseZQuVjzM2NuSVaP1uKly0ITXi951AZZ2
 zT73C1kiTk91b6mXPrvcFVe7MTQ6ftYDq.GeOhC49ykxamaYOXXj4iVtFg8TXvigONO6rkXTyEas
 LGFeeV5PCOwbeNgYGVK1pSA1X76mXY._TEs95gGPNwHr6L3A3FvqOVfu72Ew7lNofgW.wNQ4lyTo
 G59ryvQK7ldXVaeXRzteSKP.V8LkaOyQNsXEdBmzgrr0nTeDeIp9dEbulZxvspEPohb4ZKaVgLzd
 RFchOwM1mqviNeR3rTB8Oni9xDcua12r0cCJz_u_JBkbCu89uq.kp_pAMPn91D0DZHqB.2NMIqxo
 03a0ZIT1kPUGbCrhQ8ugEPBi2yoGZ2LbLitTzuOBYnxfkgtkE3yXMNijiZOJ_XfqnB0UtbwpA.GB
 Xsiomq5qnnK.e.YB0LXLZOXmiec3dYHZz5M2zK37wP.oRaWggqTH7FKwUJduuS25fnAY.iWaApx0
 DO972CRnjEBHfo3pwX6hFJ5dgCp_gfheHQsiDi3HKi6ElXLxYInNNPCEAfgZDDk2GWrGw6QV0H4s
 ARKooBu.yY2sm3U6oYdt35ljPe3YvwVizZKKlgEBLCbRi.ak9o5rT45Vd3jhSO4otNerZ1Fd1cc0
 ivUtYZyJTQj6Lv4ZsTo9.n602Ht_jZoTV4QQWUUM2tEwn1sY_s_5VrJiXJj_GHN9r0QQfS7sYDz2
 naC43L9JsvE.QbOGVy_55HTKAXYBY2h1WsLQ1kVhl2bUycWP.vMfTdPhM8wp3dMR4yk7jMdqULTV
 pIIhen8RkT0Yy6s7SHAWL0QHdMwLMEGKQRXtLN3Rk0.gBbhNnjRVbKE9kv1Tc564ViTXHZWASd.O
 AUEKtEPhmmvCrcbFAQUvXldWkj6lX8_WJb_g1VfY.9SbKm9jRe2zcdvDjcpo80uQAiHC8m3CH9xw
 QiS8DSvjYfcv3B3LDfvRWijrITB03185a0cC_P0smhGdf3Itb.iAkIibJh1k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd207be9b16b6375049b46b06443493a;
          Tue, 09 Apr 2019 20:00:34 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 33/59] IMA: FIXUP prototype using lsm_export
Date:   Tue,  9 Apr 2019 12:58:58 -0700
Message-Id: <20190409195924.1509-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the prototype on a function stub

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/integrity/ima/ima.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8b109ad0de2e..7ae41218eb07 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -309,8 +309,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsm_export *l, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
-- 
2.19.1

