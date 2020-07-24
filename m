Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D6C433E0
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EE9206D7
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 20:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QRKfWklV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgGXUxo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:53:44 -0400
Received: from sonic315-22.consmr.mail.bf2.yahoo.com ([74.6.134.196]:36308
        "EHLO sonic315-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbgGXUxo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 16:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595624023; bh=x30nPZLpFPTTON9xwug49FDlGI4IQDIqcRfVllA7iMU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QRKfWklVKDKu4Xc/FRdyNU+1wt97tTLfar//634ep5Qt3QOQ5A3Gp4bCOQsKEMSj8hF/E+8SsHrw+lrzYgRxZdHVyuZxTUN5O+aeqZZLOihuzqbT8DIm0pPc4kZwMVjghSfFEtWxbmDOc9yxiCjlHWBXkqDnb2APGwucBnMBGsUu7pK1kNJLPA6pFAoGcUvMU90zXL+8YSA3+ol2JNjp2vFkjl35Me0h5nMDe0UfatENgBW6yizDyKoM39IsRKI3TVCTvwXJYMjSio1DyGBNrow9MlnzE9d4QEc993/BLh2B1rZZZ/5msvafnEksDblnSWhFBxznKn1Agh1jNRE+eA==
X-YMail-OSG: ZLVs4.sVM1mKlYaCvqZ4crhUxaVxA_UvdwODwzg40g2jnCr7BdMX0qMVJY1o4zQ
 LNTQ8Y5ILlctli1TPRLhp5OUHQh3n9EzQBu3ux_gD1WtJs8caiB1cl6CmGh6f91Pp0ZJUkj3TVyD
 9ChBPsWiocr.ARWZRS5XsQvGGzFaZ59IcCuWVz4crwi8xv4DjMmqXrHSfCMq4ApwuDiQ2XGYOSD9
 kOZ3ahN2wnqNqJwTq5PRYohycpDOurR82w7ikbpBHJTzFmfYsS7XGS_clVXZgPr.59E0wR707eNC
 .yFC_q7nOHvd51L5tA8vWSalloL4rNVVRMoJzwxpVZRmw6d4u8151I7FcGe7kFh4bWX_QBwQ7zD8
 hRzWEz7Iiz149KLzavKWGw8PAPqKg6LYJchtwIjGguYtJs5vgS_X3GCPblRtRp5_1u79E2wc.WAN
 L0zCOKFfPkbmMxSOA9HxwrEZ4jxYmR8BO1vTGNunJD1bIGtJuGJ3q7n5D2Ihw5F.2p2ZkeKFJHBU
 LubDKKQGrOjNcXTgaO0Lt5GJCc27WnpCmAbdKyenkvHgdCbBgPlxPexbVYKWCUmMTszmJ6kKQmwQ
 a8Vzh3363W.pM7a1MfG5EqroSHYJRHcYM0pTlLTOOGV_c30HcEKf7rN6gvDhv5tuN5_HCw6gXF5H
 GJGjvU2IetqbW_2x.gfoAXmR9.4fWEuy5VwyPS9Ibx8K7Bpvthn2Iu8aET8xHp2DPThDHSS4N0nV
 uMw4q9MVm1kMub2tNtAkQS8.k5_IT2SZInxclGCvzS.kLXEKMokKZ88Ab7NL9OXcMzwIIrfR.cDx
 yYD8Hd9337RRXuRF1C4kvhOCxaRqqJuJ0QTAZP.2HfdwlUwew2JY.N1bVleXc.jOTf05zSOtI1Gc
 MkpnUbbJ6DiZfEBBIDA5EqwEHMZNqcjf75gZVkL.pj8uz_PL3mGLvWbN.qr_iQdAHqrcGLH64pgR
 0NO2liB4.dMtFfjRe0OSOqhawsPSUwtVSf1XHcYobswE1gyJFXfJmJw69Hda8JSDPO6qTTJ94l9t
 2bhA6MOMMo3daQ.U8DTvJjX0Xu.7tZp64ItEwXk1aoxlE1R7.vGM0LDxziYtwv93T4GAhO7QxPMj
 iyVe3o1XNzcjpYD0B2y41iE9JNEIp89IIZzMhh2H3A9IC1JFAxiZQ9.wNfjt5TldCWVrchDPE_v3
 2hcmwvIjV7VLtGEHlFYULEKR2ik456CMa0sLJZB0W6Wt3fMfZymlnbvFQXwR4z8ZfTEmYdYmNeO2
 Ygf5w0p7l63oE8wQnYW2qNGKSM9FNArdt.1Sz3bbrxFw4WeuI0vMIBdrU99zGVqfbcvn.0SOnn.L
 Dc0Bc9MmBctnflBnlU6keQaKDeU.c1nTMa7LoUm8yPaF0SMPn0hBG35PLFIGLt9_MESx3Iv5h9d1
 mNzAALNZXr9o9LEnq7SWRlZhNgMemryHV4pNv6mnc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 24 Jul 2020 20:53:43 +0000
Received: by smtp426.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 85512d92fef433638dcf6811c543efee;
          Fri, 24 Jul 2020 20:53:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v19 19/23] LSM: Verify LSM display sanity in binder
Date:   Fri, 24 Jul 2020 13:32:22 -0700
Message-Id: <20200724203226.16374-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200724203226.16374-1-casey@schaufler-ca.com>
References: <20200724203226.16374-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index ddbaf2073b02..95b48721fb17 100644
--- a/security/security.c
+++ b/security/security.c
@@ -788,9 +788,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction - Binder driver transaction check
+ * @from: source of the transaction
+ * @to: destination of the transaction
+ *
+ * Verify that the tasks have the same LSM "display", then
+ * call the security module hooks.
+ *
+ * Returns -EINVAL if the displays don't match, or the
+ * result of the security module checks.
+ */
 int security_binder_transaction(struct task_struct *from,
 				struct task_struct *to)
 {
+	int from_display = lsm_task_display(from);
+	int to_display = lsm_task_display(to);
+
+	/*
+	 * If the display is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_display == LSMBLOB_INVALID)
+		from_display = 0;
+	if (to_display == LSMBLOB_INVALID)
+		to_display = 0;
+	if (from_display != to_display)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.24.1

