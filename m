Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B4AC43215
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D42206EE
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fMn/HIpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKMSZr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:25:47 -0500
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:46296
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728471AbfKMSZa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Nov 2019 13:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573669529; bh=ZjuBNInN/g4FMmABgmB15RDd9FJ/VNmRPUEUXkskYc0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fMn/HIpO3U+aAPyjs4WKib0hHkuq7X9hznKGKJMB94LufuxMef7K2EO8z1f4UeBCTpqIvwWIJwoecb+el4uXHQn37pTe3/ambcHOyKIdCZfcsynU9WOL9vVKmll9mt5Z7vw27UubPk9noKpjxdRmHJKA21EV0XS3O1tYSKoh347dxwqiZk7248TiydgY6x3cfHov5riP6GtwB3kaNa0UfuLlGoFjohAaDXiCOaFcld5wx2VD6FMvs78qltOha6uUHZWZQh8Z+lq8dIgd+IVmWxF52/+NWu2ENWuqhB9PcC69peYpkF/JhblSz5WO6pQl5wEU8S7UpXfE7PtIUdYrSw==
X-YMail-OSG: ARvFnP0VM1lkZaCKdoE1m2NtL9Kz.ILatCx6UODmFMPe8cYvtDLIdZ.ZDVy9HDL
 Gw1OoPOJJY8obBks02Inilz5CwwDyDbfv_7WB2RzkKMoFIKGhLYlAm8w73zIZMQ.iSyDWvwPPFln
 x3gPqKAEynnKrp7DNwMGWpWCkihPenUP0hvVsCsWfgK7zTmQwgtjopjo7l.kopjRCEtoJZgYQtEn
 pfD797LBw5ikCkhrP5uOk5rtuPZVNqLsVaTaqgCrEEuQRh0JGgmqu.sYGr7VP3gEYWlGclreqOPC
 BzGj1vJ8u4shqeb57L8bA0c5ftudQXltieFwr4vxk3_lBtafk4OMONOWha.PATRj58EnzoGxNYTa
 OVn.yIsh30..w7DOVZzhfbiGVnLS7mtBmSpOPXdE8.YEwfXalAwu0pV1e7ydTgjX7mq6KfWWSRXN
 MRlNAnQoxpydDs92Cv7blxKNLeddO9OyGZHxGC3tPJJ6RK3Wsk866CREJg01SWo5ZfRqCOU0gLkK
 JrjmSqJ_xhmCk4lVjvEgLY.V1RtobUXybUiBu6HjCcTbLd2EBoyTVTDuw1DQ1OYFl8hyvhczWs6w
 u8rfzrVE5RvQmH1UXsv5OE6N79KFCisFddahu55LF_FhMcxC5A0hNP9W89Q7u2IIaeomcDfdGDBq
 kifmc8vEwWN023222YruzAr3I8QQR59mQWVTBZ8Qr6V_pXDrNWVgFngPdcKbdaMjYiYGciOMBS2D
 VggWHke_LAc2KXNZBnJnOW6sNZEGEskYXn1HbkMQTvXKXLrDWDYPyGfd6Y.XIAEeOcOD5Lvir5KH
 06_1KIbqokWS9YU4JLEp9e42WAnfmSjXz70KUSa7ew7Vg4mPV3lRvRITENVeEBp1l4ff733bYvLa
 _DdcPubb_wk1Z2Pucgo2.Le19SQoZR3ZSiAk2PrC3UqJpqB1baIHS8sUPLcSFS62tnA9ihaEFGUo
 8i7u68qp5MCvTY26tAryVx_Pyadui.VPErFYC_ESkEUazg10rhsWxH0.hXyDVTNQC6oNE_benE58
 hQFiqUgx9y5yyTAPt9M7QrD4HhN2QmwNbRfnFS2mdu7GKr8yfPWPw.JxUd5IIMxr7UVfQG4AnIcY
 5nHhxsBhy0dGq_wha14wNn4clLjFCRDiQkYrJ24KvRI5dgvCqRUKwCbF7aKDn9nu.nukIaI2PM4F
 Qy.T88REgUzillVI3brfBtINDN2TKbtWdFP6GAdibSkboqi9X88aQ0beTq5QqfNZzjnNOsBjCGPq
 XxFX9mQf8j5WZbhINkNgDCsb44SsBh0Fmkh2oaoV2kpehyOh9ff53hWLYKKoC61TwXAw1xikRpxB
 zv4dHRrNxNaoa307pDZQa1lhfXE8V0_zvrG_qbkGttBTgoBGCN.nZ4HL0cPnOhy80NZetOvTJdhv
 GnSvTmgQhr7Cyv9uYrFYHei8dn7lHkQQDVK3_tK00B5RyuHu8lSin2b5IxgcIfA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 18:25:29 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 49e6f77245781a0699a1cd8181a84e13;
          Wed, 13 Nov 2019 18:25:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v11 20/25] LSM: Verify LSM display sanity in binder
Date:   Wed, 13 Nov 2019 10:25:01 -0800
Message-Id: <20191113182506.2580-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113182506.2580-1-casey@schaufler-ca.com>
References: <20191113182506.2580-1-casey@schaufler-ca.com>
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
index 101063b00aeb..0e8c61cceecd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -738,9 +738,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction - Binder driver transacton check
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

