Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8B1C10F0E
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB7C2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pmTXVN2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfB1WUO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:14 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:33577
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729903AbfB1WUL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392410; bh=nZAPHZHw/8l7c+D0feT3O0gNki/K3iOuAAczB3TsBvE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pmTXVN2rQOIFR+gUlErfX2cNfiLSHpxFQiq/APczeeWyrjePt5NhaYPTOs4zgd7VcA/4FTSP9KnPEN8YaDoWsnTxO+9LajuVSZDIruMDvQIHpOjvkK3t7RuYi2N1WdP7qqUhxGE0Lq021vt3FvwkrHSNTBu+iybFUg6lqhsjfwYoEjvtgcy+MdfHxQgxuYLvB2rv9mc7P8s4T30pWT5TexHOxUigZ5xHESjYwN10J2K6VwjPStFT1SqeAHSR2N4H5XA24pTKn4SWlcIotoYXG/JkKW43Jk9JjYwnbwGBnvx0gCZ0Jzt+OnxmOBqBukeWuPu9tTlJaXXVOqWiFkWyxg==
X-YMail-OSG: jE6ar7cVM1k.8rM6GPwz4h3JU3QFzeealJNPP9AnW6gFSnAyPiA0lC4BUXnxaO0
 YLbG49EYTo0h2yPO6Y_d3E5QnbVLOoZG_LvFnmk2lH89CDc9tJPSHEqEUwveqGby1g81IrZ9vuPu
 SKmwFhu90xpJUApZt3SE0.a8KR7eQMWgXWvDJZ4DMmXhlMSflpqJtcnYH8fjRZEIX0ad71ktylGD
 KaghRLl5ti..C7Da8GJ71Jm61gIooK17vj4zcEDc6FU2wXbxBkCaznXGYVAEchu3y57zen0qeaDW
 KM_q4Wi8Pd_Xkyud__2xgsmphNEUOEu7M6rgkr8Jqx5G0aCJnYITBjeKzF1lVkAex6usacrafmfJ
 lFJFf3YdQcyOVMkEPXMd_FnOC4swwm1UjvNtgCfWXCn46oSnemfMFy3ATrz4q2xYVAzYPY32cLdP
 yyYvxNycygSGqEtjserQya.9VrO1E3qRYyMdb57xsgu1fipi1ENnr59oOlHkK7cWx_7xyXFhhRs.
 7Ekn8cDr6_1TQc_c1rCOqtDBWdwupIFFxNpzmfZ8tRjy1WjHfb196Y5_xU3rkho0BczonRSBZQX5
 bivUDDuKs9L_bZjXVxPj8D0tyhWh7TSf0HKGJag5iwOziTT8JitlBCIheZlUwsUV1sRGC9b_mO1M
 wRMIAQVrQup_SwEz8GFEZdAxltwXhxKZhMm.yvIoMLV1LA6iYz3SlcugErTTuOSbixrsEgdd.dBG
 FvmfTwr_lIui6aIW8N_3810L3ImfVfFOSHg1DBkK9H47ti2fIufabPYj1Pg5JYu9Vr4iJIdAQt59
 tNybYwJWjDtjjDcjWSPeU4WBhsuosk0OAb6rTySFN6O_zhCJkHRKR8jaYmJIdAIJ9pXCgH7SYH_r
 HlzgKKVwbg9h9Eo8rx8EcOM4o1PO4sTUSIbMfuOvk8jq42eu4xuYORkREaqWaqSD72ISoe0EdkQo
 LenKPYQ47iS4GrUeo5HnwDp5a3QbyKNTjQrfilBxIv3GCJm3B1vZuhh5H_3blCBKYrQn7uP0gUp4
 RvrW8MxZXUhlvumYr4xhUj_BPnmGZbiR9ni4qhaXdJ3XrF_kpIkPu2DDoWsmwUNrJiY1RLPJje1R
 pPUwFyDk_0q08BNifBa6Qo0QErx8cGjQr6CxKz8BOy8XS6Scv
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:10 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e588ca5e0935b1286f019b02cb065c6f;
          Thu, 28 Feb 2019 22:20:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 43/97] LSM: Create a data structure for a security context
Date:   Thu, 28 Feb 2019 14:18:39 -0800
Message-Id: <20190228221933.2551-44-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A "security context" is the text representation of
the information used by LSMs. This provides a structure
so that the use can be made consistant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index b8c67da7409e..b60152334d9f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
+/* Text representation of LSM specific security information - a "context" */
+struct lsm_context {
+	char	*context;
+	u32	len;
+};
+
+static inline void lsm_context_init(struct lsm_context *cp)
+{
+	memset(cp, 0, sizeof(*cp));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.17.0

