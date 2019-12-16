Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E98C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C7221835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Cop19Ag/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfLPWiK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:38:10 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44540
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727827AbfLPWiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535889; bh=Vw5PzqK2k4wespl9dNFvI58s/wyRhq2FOJ5+UO2Nnnc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Cop19Ag//8shdZoCgAW0iUzWlaTbp6MtTtXujp2lE82A0zzDj1C/PmfuG3AvlcqY2uHNtGWLr6VOocskgw0Xi2HFERW2PHA4NZSLrlG57/WHtH0GiAM1sK7BzEhIHvHX7hjSRyAR3pDVCaYo1qOKZVItiXY/Cltz0h0yAW3QcDn1qMCOZmAmVIr7FrB8Ug3X1sRghUwY4GvNqy+Ls2iPLhhyTiIzPig7yxmyUtDqMTYHIcbSdMuFBiYni9qyYxRh1OAqNHo4h/sBm4gD/llnqvxsDC0jvaWcH09W34YcrHwjrTlWwF9McqEIqlc2cCuvBUpIuhbiwT9l77f42X9y/w==
X-YMail-OSG: _DLa8aoVM1nCTfAMrOhRIDIfSoe2JqLK6Pwq8EjlbrSmnBwrhUEaWWpkSre8VnC
 MBT3Cy2I6qUj7ox5AsK4npFHx.jRnpkj2zEbgtsy7ELvshz.s4ePAVbp06oQQnOnB07GSfG7Fn_o
 oKgsCYrC3Pjf7wk1.DLMLK6hUTy9r8MR8chE28t_lmDaPFjQ1fgHAvjO3AtDXzYVVbxQzKZNTQoF
 wYUn6yUJWEzCqQAdngyB_oGSUxWc9id6N3znWxUPywOyqaVxLFH8.9b7q2KIL1duK3OTDOnRR4ZV
 WspbMN1rk2pVJepMlnzSZMmg9r5h5zUNFUkofifqKxGFtywgypL7OHI95WJ2j9b5.00FyZbhh3yJ
 RqMc82m6PvaGkUOf80q1Wo7R6ZczNlDU0IXZnGTQbsw.REJFEMk1PFTiEJH3DArafVLLJ3IuyhVY
 ErCHzhJuRONpFQuqewxnuO_R0mzrBiqzRJAmmv5tANhv1BNV.J9X5LDjvonhMYm2LiAwZLOSUhoM
 VPgEIHJXVRqkdo2hOcBvCiLzLgTum0Nj8HXx8p.lcyK6K0wub3GNRtBPC06_4Emjs2YdY2YiWdcE
 wjcid86c5AE0dFsYF..5rRWR21ZtGXeEE8Z7Cr77l_4z7hG9J1WrtKcKlfS9eAusO_qI0zWh8vRe
 xezF3rldLJua8SUKAI8CuDATzXw7YBLFpc5okpNZqzxT3MxJcTPikMMg6H0z7DJTAaXRNcSWTIqE
 EO84oX4Or91VlYsjYdiT6C0Ji5PJotC4KmHIAQjehtTRFjfkehE1LuWfYxd77W896xApR5w42JA3
 qV9xRfEMm2OaxTRm.f39EQKeD.oJKOFagcN.IkAn1U9VKZP.OnfHLYs54wJj0bsFpcvJEKrt2X57
 5ob__cGFVUMCjzaJXj94W1XtB_yHKDALvuATWrikCRU73m5dSH4Bx5Fu7M15iNjQ2KD17x5Zlk2p
 CxX4el7qyQqm98yLFYpTFV6ThU0HBojZjYuRfnD3IZW.qG_M9ELd6JZztf3oNaJxOprf2v2UcvJH
 UvlPWIKqoruzuc8R6L.0gBxpWFzuSukGXyghzlkbuzfY0UGn.DLpvJ_PJ.J5Ce.LrnDpIRkKjUTM
 t1VKjlew_ZVzfK_3.XCKbvGsdq_qeBHA1_X1voLei0jv4QpxOto.1V5XCGTpm3GErTgBEekpelM8
 CY3CvOh9J_XUspJb98iJGyCXtYpZ14k4Z4eQXXNVUDssAmo3WR2siR2_qn8kgpRfq6VIyeblzPCX
 _UmFWosj5r1eE50hEowXrbPXT5YxdLl5ZMnnRTJzFh3vapfmOIN36k7GojdLotSglu23D0t5rDxd
 5zRZdlZPX0kle56VK714.sOVZvs1gt.DFNjA.OdJo7DWzzw4zefMcv8RqrDcC3UC5WvYwC8HrM4h
 ZdkaoG5B6tw9WT_ZGR1bMmJ0iCAIPOhZO8Y2NcZ9jWrejJX2k3EQUwxUZm8._b.Kg2dkz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:38:09 +0000
Received: by smtp424.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 19a4a615975b36081bc636e8892a49d8;
          Mon, 16 Dec 2019 22:38:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 20/25] LSM: Verify LSM display sanity in binder
Date:   Mon, 16 Dec 2019 14:36:16 -0800
Message-Id: <20191216223621.5127-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 963641acf9dc..bca092dd4f00 100644
--- a/security/security.c
+++ b/security/security.c
@@ -738,9 +738,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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
2.20.1

