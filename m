Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D429C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BDD21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uRyPxd9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfDSArl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:41 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:37395
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbfDSArk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634859; bh=cOt9caKD/749IXNAg082OZdZ8wyzsShJ6Dne6L26IXA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=uRyPxd9qN/HkJ3f3nrrFvg5L3F18r9Sg6RA5GvMDf2zc7n2pyhSlniG9DTtbOTGuUknp7LzDjzNbwPec6lpXmK2K8h0ZMpJU0sIRlzbChbbNwa50FAciZPPV++ZuWxW6t1qLkPyijPwCRV27HTjIvA/f9CQGrb4PVhK20jeZuYmJRWiCqdeJg2nSognfpZHR1eG1BfqfT0pGwb879dXzvtw7hj+s0+ZxMRIbG/FHVfEXbVlN4XaheTciRgUYGBfN0wxL7BviXIlaxk78HAT2XaRF+lCkBeMfyikqjn0ADUtI5g6CRP2vzBBKN+bGgS+aBr5Vk991n7um8hHGfjN8XA==
X-YMail-OSG: 35uvrLsVM1lh_5J1R1gzqyXXxW4rJKZZ99ACDN3_kFk2OLOCcDuQy4Vze9aSAnQ
 rKLoQHnCGqtBPbF.nI789TIFcoNyO3SpzdsJeM3moml9vK4DM5vKYL6GUAItrLDNz2jse9cLBplT
 pAHHuRiYlAjI7jJtB4ITjgmcvEqknj2VlWrf6jUDCouKanSbVzVykfE2EvcYuIgYIJ5q9upJqIAy
 Yn6v03Sjh3foaFb8tTKjZvWs1D57b53kcvQL0I9ldjiATEw2x_IrHuLEYFCPUb4E0hvsM.4rlZlf
 cKe4pO9BTwybqjDBLYOUem1O2xi3_iF41wbsG49l48.oeNL7l2LIfv_Vn4ZpUmDFwET2kw.NeJ09
 8vZf_zfz8_vI5KYlIGBb.N_aG88tBvE5i7ObagCm5BM7xI8MEMjI.z6DUwABJYcrXI7PenKxE2L6
 pp3_pMdbLIjvTraX7DyzcDsRYwC.OdcnT_mnSALUWMjCiv754ehI7aoytGnS2KQjpnlgpBislZlA
 sSI_yTnPFirkbWfWDrhjjRCINzuuNXHXwaBhK9SnnVB0vybTItejuXbN7SyN1XCYBBfdj82uSOoE
 zNkmZ22JoEAWVfNAbQXwqtbN7LDkm0eM.CYtJcoiJ4pcJLl5gWJ1oUTaF0znLbargv0LfTdIWzuz
 hetps5gF62dixw8keE9KWWxTWysQGTnId1Lk___4m6KwJCnkSmXRO2btFj6X08g6MnTNo5g2Hl5Q
 XQEtgLQBMKO6GxTSnGZ.wM85Yt0VaCtTR2bA7TZ1lBoMMYImnB0PYdkSpf1F5F_iBvZ3lZk8thW6
 53z.pYmOMPHkPHPI8euk634cCWWYFFs5phFWNjwbrgWjNbUQ96kGzr..XcBfvCs9E9PKSJehqaoq
 bc0E8ZpQj9DcYbCJCBEVpuENvH5D30mM17qR5FgED2xrwHscTc2vDbHMAaXf2EKFDQDtTvWZrUE8
 CEj29IBZevU_FfhonRsgr1kbqGgyWLYiRzdqlaKizFx8L0DwgAUf0LovHcwmqVik3kTq9SMkryyz
 F0AwDCisCHzJOZPLbYCqBOuiAiZHppdTF5Usv3j2cUUDrDxEHZmH_.zMBxdFTlOkOwegz69j1SHr
 nejnv1Jx3ZHZHhtkovVryNqdX09SS9QLXjGPG1n4fNinOV6k0rvpGv.FMDswaPD8wezc6E5ee7FY
 RrlmZwdRHJo1v4Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3136423b19635411d73e92b6945decf9;
          Fri, 19 Apr 2019 00:47:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 33/90] IMA: FIXUP prototype using lsm_export
Date:   Thu, 18 Apr 2019 17:45:20 -0700
Message-Id: <20190419004617.64627-34-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

