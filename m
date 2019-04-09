Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F63C282CE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7152C2082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="k4yE/XsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfDIVl6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:58 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:37721
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbfDIVl5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846104; bh=+7mmd+MXJOKZKn8VAeu6zAtdrRYOBd+PhCBuPJj/JDU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=k4yE/XsFjV7BPXv3xqAAWIUaW94lE+diDQXNSrrV+O3UO5+bqbMXCkCs27mt9k68KMLnysUDOnZQtcMLyOv5S6GSWOPFc6VCsgT0aeNUFz0qsAWm6wCOJUo3vTKI3DWXmzDLIkd6fVSIVALutK9iFW8A74RlSUWqzYuR8bF4cP+pcrLbDH/DF3LLKxa1HXzHK2lZqbxN4qpkO/7kac8PvlZ0WivD4dowc29VmkWLTLNYIqH8+mVsbnV1LKDDN5UbKax2wprDxpfzJ1aqnjEIYyYlWYweFVQCKkwsSDdT0lcNaqgYsh2wruTQJR3Ey+sqf/B79ZkR7BvrJ9Ha+JXomQ==
X-YMail-OSG: ZrxelzAVM1ncVbXXEjJtv7DyD78jzz7vpQGLBYc1ngmVMshl6ULuHJdGSQKYZQ.
 8i6.PdwBnsu1bcQD6BIU7esr4mFt6emTruAPrCjIPBAy16Pr.lbGAq97V.Wf3qefYmoTpicMs7Vo
 VGlG7lNRR9uo7WkZblvUOq.fyiGIyxLCYQBVCu97181NVrBIDXlsaiZCEO8dh8k.NcR1Il2qsVGk
 4oKJ0McjrBqBUTmcM93m5Kcl5GaM9wJYAoUUC.8NK4D4kmzn7x9T7ONSqQ1pbaQTNy7K_QPnyhKy
 suYqoM.zWpjKHsB7jfCdQcUShFg_cjOYlb9AvqtN_5_m.pnqz5hmOzNDD3MC42Qa4O6m38iTHHct
 RZrTt83GnsSXVrfJS6R6Nf.IQyMSzjqsarEVgwGz98l.9Ls_jgDNot7rfhOYguuvQNmFNJe_mO7x
 S1T528euslecBBwPgVQlXAsvSo02wK4mesDvyzw4vBOjR9nB_jbPs0c1WlwUGO3IA2aamwQWaGKJ
 sQIVyyGruRYU1t26_nLqEIELoiApePrUV_a1.tfdxUeZaVfZekYbFs9g42xHeDDDo6.TV9ys_e94
 1COYnSBBWg.fkMGPi33odMM6MXPSvxh.Ni7VoZYz.0roUziM0M8uxXRtaLkH5AJ2vUvBUv67klSR
 EpxPyDKyiGOrLzbQTfhvMMTXtcOuPdV.v2Nol8aAtYhQFzqfGAZ979DfVf2ZTRwWUIHifkOoZJ8C
 Mrjt577RWO1A3kiShQeya2uFR2HQG7XwTTywS209R2qnpUXMDjpyNHzU2yRzl9DMdEDTCXk0Ierl
 FZJM9Uy58WrnZlYPF_7DpJrr4CIStpZ95YSVUuxi_ufnRFPWXYDGVU9sZZuP6ygiJO3Ql8OmgGmT
 LFgS2w6TVjsYuRdJx5afyVUh9Ed2dWT6Bwy1JZFrnLxAImlpQ9CTE3QX_C5bmy94pqbziUkWAck0
 jkn8yO8ZCgObFiXMNBMZKgFKGC3StOFHeBK.AsaTzKdPySGEX7O9oAvWY5EEyx9CKX2jBi3kUMM4
 .4y7yTGZZocn3seDzpRSKzCxDNnVH_biAgDt2XkIBMnu5wkm9qkyRSvVvAG04V6nCZvhM.SBNunw
 u7nOIGAmWWli.IvqRN1PObYr9N2tJEplsFu9eLKJuvQtBgTGyqsrBTtYRaumAgw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:44 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3e563602cfa877b5908e791085320721;
          Tue, 09 Apr 2019 21:41:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 55/59] LSM: Remove unused macro
Date:   Tue,  9 Apr 2019 14:39:42 -0700
Message-Id: <20190409213946.1667-56-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The call_one_void_hook macro is unused since the change
to how releasing a secctx was made. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 1b4b74af0cb7..ce50054f58a0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -713,16 +713,6 @@ int lsm_superblock_alloc(struct super_block *sb)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_one_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0)
-
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
-- 
2.19.1

