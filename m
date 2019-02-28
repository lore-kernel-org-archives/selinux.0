Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1EBC10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ndtkm+7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfB1WUb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:31 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:41817
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732148AbfB1WU1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392426; bh=6keeEmCLQfJG32h3AdVJECQl7pkaNKOlaO2Xnn12UQo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ndtkm+7g7uXxgLe/AGeJuKhtF6jbXFUBV0GL3jIR8reVXXRBhK2J8a3xNqsGZ35gpRVSeKz+HrQ95izPt+mjr6VjsqxZdWWWswZMnjtz0zoULseLvtaer328Lk+eeR+lAcOXYOyR1pyBXQS5KTp+PH3LVzbK+0QF+i5EtGH/OVL+jGHhBYBR/u5XJ3pR+DJuOG9XDUwgguJ0whpOHWvqHepHtGTdgTtoqsQUPwILqAAbNoy6/jzTGrED/R4Xxdac6xxZiUHtvSpxjOzuUpstre3rmOgcNmzshcmDD4POrJZMJoFuS4snQzJwqWiKr8a0xW2fVKJZLeWlPZ5ArZhobQ==
X-YMail-OSG: W7zpiD0VM1mRavnWfdh8eQkyN8iHPgaUVUxwb_IgMhSFopnpxjqEBLaypfOO7eL
 iL9G8OLKmTOMo6xQ7zzrDQLgN2yqc38CJAyfEkheIlg4gxG4b4qvpe9NOi_pjvm6V21Wlr59hCAO
 nrX_51a.KYzTtXMg26nACjasFfqCOXjK3sKSD4_XgzBaYPkfceoE5CREZO8IZT0nZAs_x_bj3vQ7
 t2ieGY5AVerncaY.cHKWebPLbc7J1.21oa2Nnb4u7jF_10BxN485ganqoSXFCUKSKUQViOK1UEwk
 M7ikydsf3fzQHj5LZEzKSAcksGqXOGTU9Otwp9H2cE.1XT5ImJX1GtCIt9q.DbryUqfeyQktmNHX
 0Kf8xsBmZ0mzXCZOXbXaClQ3OBrua54gPALa26WUoNiCHfZugZABQfxJPtCiwIALFSQZAXj66c5w
 lf4W0NkEf5lp79.wkFEHk4JJPhYZo5YsxUGwEqRbCM6Ds7i86IR8OReD1gd4ebWNc30_iO1oh7A6
 j5w6lZ1USkO_vzgAuHsWTXzffd0ve_UsqdbLDjcTmuEatSEMlnuvyNADTdtS8kkNpZRUdftRnz4b
 ESYaS49BQPPnyWUc3WGZ87psy5asH3cH2vmcpsLBnewtm_dPE.6DhBmDLOr.Sfjd9peShQMQd6Tn
 sDxYJokKyp94CrqlCJ5RzCqnEvdxin8oOvI_inplq3G7BbJ6p6hReSLM9lg1g7uvX8h9IlidlQBk
 jroV2HkpMDd2uYkrqfMsHoGDEhw1e3iS41B_BI99s5MU4aR01r1An0jkAFsr45g51CghZIVGqUZp
 dN00btsWTAQm_Iecu2CF6RLXcMAjswhH1D.wh90U0DOhnkkAWSpYNxFNRuhYwlzBtpe_seGff6fZ
 OJVTEu_QefxVeV7stWGKoz3T6W72Kg0m1rcw8q1GUFdIWbnQgn0jGINRLNDyne_SXwkiFd5A1iUN
 fPQJBxzVBX2SF.NjVAhhajIZIZr6V_3UrESSe_TRcy_KsX5pkUby7jdoZzGCFKd.FcVOGt8rYtOU
 UUpiE6xmdmBgJCadyPDhqFulZ58R6o._nn8z8M7bdkzGTL8C.l6E.Zn5F4cvSFNhgKjck0d.TnLE
 DfWKKIZvSH7kaPlsX1A.f7v30I1qQv2BwM10Cw27XMMRLpHY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:26 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d90148b291d74b44c78573c559ceeae0;
          Thu, 28 Feb 2019 22:20:22 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 61/97] LSM: Remove unused macro
Date:   Thu, 28 Feb 2019 14:18:57 -0800
Message-Id: <20190228221933.2551-62-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index b45136a8fd81..257b7ff4b434 100644
--- a/security/security.c
+++ b/security/security.c
@@ -709,16 +709,6 @@ int lsm_superblock_alloc(struct super_block *sb)
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
2.17.0

