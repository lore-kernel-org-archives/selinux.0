Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05656C2D0DE
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF59321835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="M+Jr7eWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfLPW0I (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:26:08 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:38889
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbfLPW0H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535166; bh=Vw5PzqK2k4wespl9dNFvI58s/wyRhq2FOJ5+UO2Nnnc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=M+Jr7eWbFnJCYxKN6NmCwDOfRbeCshIVCgnR/0gTw36EXb5RhbANJD5nMG5DIGqJqL6Xmz7VN4OmhkyrnvCoMnmXbqW/RGreYKfM0pacTl9EF2q0IsIOg+1sJG8QPzwb/HIc5R9xwYlDdX0nEWMjtwgVSQ6zOrWKN8AWsFmVEzVXHTCEejPT32F4nraO+iGA2J6UhOn5s2KCRjRP8xcMLg/S8q7tqOj/vsZvz3G3psOQhpHuSXGmd8fTOk0tyBJxQ+/nQFgtcjX3kYEy5j0RD8g9Gk+lsGagikU9RTu4hCXwP7EyUti6U47hI3wX5zjtwEn9nCpxSz1LHAoGEIApJg==
X-YMail-OSG: ZwU3JmUVM1l0zja40jSiC44eO26Qvb6Wh_9PRyUfmgwENL5KCZEWRHr4EhXoh74
 bNVPxPho5BOTzd_1.Ep8CTT5qEMrt3BiGWlFXMQcL8b3Qa1nCmFYTpur67FVBsYL7r85dRMVm5UC
 lGsFAizLV5_mbEz.K2QLVcs.UH8i_XjI.olK_cvNFDTD7LRTGvDNN90_D6ZXrxNXM0TmRNPK7rPc
 tcKNs7u3DbfR_Aer6GwXcJrTIjQwR5UInM4YIQRCFm4Du_1FJNCHLCTp8xxZdxnv43mOvitw_XIU
 VLl9t5us.o3B5EeN_qXJ5qqQZQCHQG2plJAbJn3pNGmI6G4WsUg5vHQzT7Yv_m90QMivEvFSjKGQ
 8eC02OFq9VHQQpnLpbcTM9xvSRdzOU1ZsfTUapyFMfzUHTpPCa2JJ5m3KQa_DagWo0KIx1NQw8XV
 4vpNAMm0eO2ChXzrs48SkzueXWGVp2h57_lG49LTigOXdDPaEVGLw84ErcSUDK.pSYZr.Yxtqyto
 I71agZZeJ_FDjG2X0gbS_pCmTggGiHtwlodCO3r70ToLgIHt10HQAg1r6NxCbwFcUUYEiqgvU1tJ
 TcA0aT1G4VwBDLFI_V1ve6l6zUW6WozQajA4_C6VaLkDpCQYMKzWAlyjlzbv7g7VZe3NNJyL65Jq
 G5pmNt2qe0.jpw2MazUOsZF6i9epRMS.BPgQaUxvzdhZQrJYzUdlUT0Bd9rPUywpRM8y9.fDEhEo
 pc9osJwyU6wEmj9bexE.1IHbZTlWUHqyfG0UWHjaa3l6VIPojLlqtLa3_tzLjIHfCRLHscQfHqup
 stRDEwhBNdtS8O_8mIGyDDReuHiOXa8p9ksbNLi3HD94OyhLBynojwftv.A8jvmG9mId0h70tebs
 kozBtEEuKoD.jtjiLvn0qOttPPRnSvrDoYD1kf2to2aEHHrpdzPxQwngQ3nbq0jxTE99n2CDgkVH
 Za13Q.aZpPQpJrV.BmhzGrz6WMgLjLBOpCjVCFUsmpe9B_K5SKObPMNGiVHrKWo.VZ8IvEuuuw9V
 8mY0NKYG9e5wu_ia2c0Kk2mdAwozizh1eDtkY0Xb9k3j2VyWgY3PidFQ4qUe1kqNgGaSR3qupIQN
 _NWzi7nkTF_QHSXOEGQFxhag9c9TDUh_AyHJr7y_zLfGFCTebSO8EpbkxBQFRfOTo8P7N64RjFu0
 ipGwyx8bp1ixmrvZVEQdXhz02bkZ83X_aQkxSCuKWYHPTEwqT6kiRA7WZ_e7CaqWTfYRhme8QjaB
 lehFrqE7JcunAz3_WtLdRxSkFTbkzcOaN5fOncxanzzxkCnx6G.scPJtJbp36l05ZQaqPX0A4vVv
 K7XnkNJvWkgPK_mHsi7yUpfdfrUVXPndCdFy0a5Qj91tjzQWQ5s5vjT7_JaUZN_8oGS09OCuVMIM
 0ed50KHvt9v7bmpDkifrOVLpgseyPN_b7fGDYMIUNv04aP9SbadBpJ9pb93C6oIAwpw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:26:06 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b585332fad2a919f21222be56b5aee9;
          Mon, 16 Dec 2019 22:26:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 20/25] LSM: Verify LSM display sanity in binder
Date:   Mon, 16 Dec 2019 14:24:26 -0800
Message-Id: <20191216222431.4956-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216222431.4956-1-casey@schaufler-ca.com>
References: <20191216222431.4956-1-casey@schaufler-ca.com>
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

