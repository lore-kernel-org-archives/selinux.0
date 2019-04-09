Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D625C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A820820
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XUFR2zBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfDITTd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:33 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42144
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbfDITTT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837558; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XUFR2zBRFVjKOsbioIUVJJ0SZCyjZzqLJNLynhWoUkqF5fEJDcQ+2O5EFbpAMVDD4Ln8kY2e2jo1gQa7kOxVmIbGQ3YQeq+l5DMORWDRxOGBywy687UeIwGooG9PHG4Weji0ZKN96eXJSWJnkD9VJRnwZFhnGmSOMPPlNf2nmIJiRmnBFJi6tyWTctGAqMbDDCA+WaxR/whflBo/dUydqYYpVR5YbUTjn5PIqkXx7oXpCtCr7qsAUkOin1jGLY03nOy516sLoY6qIlkqvaqJ7UJtyMmGIH+RHX3FN1Rv84lhQNccl6e8FwgZd2hc+WyJZhMpd3jP3tJ4rlz5rop91g==
X-YMail-OSG: UOMOIo4VM1nZcyFAkQE_2Fnfr4mcmQrlvBhAjo77xm6ZSnfqPYbJJU3O5VDP8rh
 CM9sq0k25hM1Dhb8PcPKaM098ELWb5.cMsYuTECAcRglQ86DWu2SXawBST6nD2j.8SfbnxNRZzaP
 4wNrxWfZhMulDUJGznJAZu0rysKw1Wkgr8Ar06545BYlgHKiOyUDkna8jQKDzei5RMu0aQ9EDOcI
 nJFQv4B3NhSWZ7BMz0Iz5AmH4m.Y.R4uFIvNduMUf0kUsoIYZsHz8XJGWb99dNSg7V9lfD6T.xtn
 M1HjaLoGOmkAD6PZZSnN.uiOKV8egTPUpWtzV9ud7k_zGW9kchshxX5WMah717IFjioSMeonaUyc
 WdzQJCuJbQgbAF9KAD4_4gR7BECneIALHb0YGWkoJfuA2J3ZJpMA4dWQ2KZuzFi650Qps3HpLmVU
 CZTXM_a9MnDic4rVJpWcXzeok9ROGsxoChQxq7SGkUFh4TPiLIjL2ENxtafwKl1EBun4Pj..Wvl3
 1vvSrcu4HaRchsD5ZIIW_ioc1BUYk9C7.lVlkzt3mp1C_0MrOrtLHk4FfUE85n2zgew2Emu5H7DJ
 bAhwVcZtapuEnd.nhRXitZEvDoop_iCryWU24HYBOb1qn841UvAVdjEfsk2n7RyzxGtPU_dpUBij
 QCsj6dn3mEJvEpKy61tFHiApInPWd2CpKOubmbfWiWFS_Y1pcPbyDKHK8Bdj4lWyNdkpyHB7ggie
 5jW5myUoulk0uTzsPrzjQHjky2NYx038qKkxfWwA.uWtyRRn.TjE0CCB5Fk7hruj5djSHUo_GkVj
 fVk25KK9zkZEJA.9cgKV91CSWu9VtIxouSGyrZyHxJUL.FSbtMzHM1i._hYQCsApiOWQnKkgo3OF
 _bp0RpdHG4S7hZPPYis3wjvLOUyf2SqyANoxuMMopHziJzatvmI9QXZZVV799UKC8xcwso8v8iHm
 wzgTzf1lbGeh0RZdauXmBZohZ8XIvb7qO68v7HzsWP_T1vayrIuZd1i2YEbsaKlWmQh5K9vk.GHW
 sUbOMbAkhfetQ7fC5bh93NUb.WvC7jIED3Weqkp7jV.4ewswsqiNkiH8Q259sgd7vaPExjDNlbbd
 0wKBOk0EHkrQ0F4UbLljHeEJKonEgbNPgCy5xDDzajm8UXKXc41Thjwc-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 33/59] IMA: FIXUP prototype using lsm_export
Date:   Tue,  9 Apr 2019 12:18:22 -0700
Message-Id: <20190409191848.1380-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

