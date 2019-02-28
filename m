Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151F8C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94C820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KQ47U1Fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfB1WUO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:14 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:35814
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730046AbfB1WUL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392410; bh=gXaiM7XH8RUd8pmwKjPkAxsoZLt7mPjTPZXaSl2vT8M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KQ47U1Fccexl+NIp8q0tXuJkSG2NgsSYxzPvyd5B9tR4KmMSOXiimuFKtQlqweXy6T45Ex7xqpMlfl4IJOBscoctKiG01GAoZklyKw3au//vqZeGyfB9a39d2YemjaClgslbaXS71d+4ajqvSIUoa66l3unz9AuKXpCerZTxBVGk8Sz8bqMDtEtVbbz8221XnFhFHW/zTlFuITKuoULGIgCyX0uGE13+GqHHH1eLRIbwRW0BW1gYQGvY9pvQbeKrytSaMitnMe+LSqPScXuJuGrIew3bNeQ9CLesprpX5j0nRMUtxl2wePl/+Og4ZaZ0hOSSMGj1vCNTQLIWTPbbdg==
X-YMail-OSG: 3wNmhGgVM1mpZlZo1NDV_.JyeANPNiV.hRCbyff1oUl_HTj6Sn.sHiPGd0oIT7z
 V3qyfULsL3tsesjY3m_2ZVDfgZk79t8Nios6mYtqscOhhkJVv38CzPhuaEkYkvU5efe5zK7yq0PP
 1_BNWvMKJ9bo_O1TYflSQcqhmdpnR9m3T3Bms5yFuclfN.oSdeKpIQjR8Lb6X1.oN_3f0_CElK9b
 x2TMFBDh07iLjY9yYMbEQlG9RV4zOxyq8N9h20TRZ3405suOBd8UIzM4CVANd44UQUjztWcgFlqj
 xx0Wmkg4pigQSeGsWsDdLGxyBBtL_aEXFS7PPDEwvnBf6ZrP1aYtccBK3kbdLy8oAiKjSXQT5eGD
 mDFffaNGb6pURsy897i1hoUTD8RTXjXHB1zz4v4W_mw_pGfZfZT5eaDXsR_rTsh0cdAwElFBUufZ
 qphToZedHDFfkI8AQcCI.MNJZ.tCs8XGnuAqv7r99c0L4c.tHvxnHdUnoI2eMFVBZY7W.THAJlUK
 0OHSvNk2rkyAmu.JqoENN7LTdL5isTYMuLA_0v3HdSpDCMSmCW9dXOLwv8GHQkhv77cXi89pYzho
 V3SHzvPzZZDECC4qYWvmHJpIRIYXz3Usqe3DT6Q5uXS2VHNhfzfjYZL3ZhgIM_bIktsU8yB.w4HO
 YPcpinDz1W5UnszfZgQ45zQ7WAcoMOhAmHE8qSczSjHlFC_U_ijVPddyz9I7hvqxYH1yKCZNIcmL
 hHhaR9PxbluxVXwi7fAI9UDJO9_e5KY6TCp10zUvA5wviXafBHAaYC7WXFok7MbGjM0DrM.qobyE
 tH.j6A81gX5QEFBzlFwEFh9Orqe2QFC8u2EnnNk.6wE2ScxlOminsJVA8Tu2NvhcTIfcvlQZovjp
 ozxUQLAGHS5mDVf8756m9Dcs.GV9ha2Pw7s_vcIm_TJHthk0aXwd7HFLLFMuX_41p9sFuC13fjFR
 l6TKA.ApBZGQCyXDuFmDt7iegBXnZccGlm4F1VNH8R6Tgpf6IBlbl48Ke0XdZ4mhpY7RIDxuqmgE
 4p6uBOBIZQaUteQ5w5zqLPjND.fh7zUTYztxa.gJkKky7r2BVkd0GafeB5VMVr3V32VcC8hKhEd_
 2Qbsu_XGLjQbVc1gy6tQhmFU0jWqA9___3Y.pMt43kfqhoBs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 39/97] IMA: FIXUP prototype using lsm_export
Date:   Thu, 28 Feb 2019 14:18:35 -0800
Message-Id: <20190228221933.2551-40-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 2edaf4c41300..c46e856b077b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -308,8 +308,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule,
+static inline int security_filter_rule_match(struct lsm_export *l, u32 field,
+					     u32 op, void *lsmrule,
 					     struct audit_context *actx)
 {
 	return -EINVAL;
-- 
2.17.0

