Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF864CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B349C21929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RsQbOxO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfJXUyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:08 -0400
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:36005
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728692AbfJXUyI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950446; bh=F12XTVh9ZAFZSlr9OBSgmSb0u22QgxFH5gxNFFe2rBM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RsQbOxO9wcQGcIEa/Xy3p5kiMLY18/4L5rYhUlHo/Wl5+qr+GpccUJBeZWe7RRWjrPeSwP3PtcZuJzoGxEl5OaNw11CvqVeZx7dBVxq2Gmk7koafVg1p/zJL13WdYOGmkkFCopn1pioxf45vK5xEh9LqQ1674OdizLWzzrbrFXCiwDamW5FvGnLb2UC46CDt5juecocwFUQJ+XTwUt+GCf6utsaYXR0LcGqmjsi0hta5XujHar5WnVRAPPAH4j4dqkpEj4SjeEm7as1x61GTVf0xWeeaUBTaqz4/otdEPnZMw1wDikhJLqnuGcF5a75dYff94vSMkI/NsoArdvWWXQ==
X-YMail-OSG: Wh9y.3EVM1kiZUiIumEC5zXpg1oBxKj_fSNy4WWjI0thdHWNp8CeTH2gX9V6qte
 Ni._LYwDV3y7JxVqkvNOIE2rjE0nX0LTH_woUF5V1snKvpaZdob5YDYX.suAXukUb.CeDWQEOmoQ
 KxMRU1iUvsHug3oZ1Scma5o9ERhf6Zn1eZTk9sK5sllAxj8ebOzoXOcRAccCZjcZ09xrlJjXUv8O
 KMQmXtoxzOqJ4Nz0PsW6pwfhEdPwgNYEa4aDR9.LrlphV_tkDC4p2IsQGyH.QDU4L3xEfbLRwi8C
 jKKhGxB0IB_XkRHb4jrH3QvVF5nzsiRoLjQBv82pbqwJDmHduxbAm4hiZsxhBb_xsA6mZuYnWhjY
 _bY8l.822Sg_DBvgxZUTEoNyDYxXS4gmCJjQnHKWbOyHC0Xmg9pKfYw9OR8aQrwmkP8NXIW3iO9Y
 2chNDN0M.B9Mj75KuWdLnL8mBEL4SAxK3n2JkiwOlSOYJRurmgG9MFGanvWX9BQz1IWP0NwKUi4Y
 hJvFCOoa2EQrm7D4_0SG2vG0cSJRNIclJnXj4B16kTfeTYu3wnZZF0UIF4.edyyVxL12KXXoDnKZ
 ACLUZsnRIyB0J28skmehPHvwVR0UDY9nEUFpW14GYLmN7NIMkpOMsNRvdUZgGZiccPwMOc0OEEZL
 TyU_VPQCVjYVXfLOElzVqAFokaEsX5LjFxVLjCWPhaxiyEEsXNmAVKv92x7rKN3H3QdGlxTo2GhY
 3YfPZm8Y7MBnMdlDgYSlaT9rzZiOVIyLt_WsrnarOtJ55HKXcytNQGr4B5lQ4TEqKWzH1hal9dH2
 FltT9o6_lHZoXv1.Cf9kEYfDe4uWb4LpSQz3r0ruF2rfZ.uWgTqz3oZpg1c.eCSF4Nxdz8P5ntPj
 diEL0J76qYh4eW5D89n_7CYm2JesMojMVtJvGGmciRQMRBDhHhAQI8LLKRe_0veRe3iRHD2xE1bv
 xHOgkySy6E4NaHbitC26VnI7VsfnZg0OstVBly11s4B.wy10lS9Kqew9WRzZvMWhe9hmYY25fn1r
 eYCWUnwv6Qss5oWGCU.We12.YnTmhSZvbs49yRkRCZsYUipapqJJuDwhmGDm8AQ3K0SisYsPUjjR
 4GsN.iAAS4G3FfWoPWuG7l4Vn0oMmHL50O5ACwVX2uOIL6saXyv2dcTs8os6BMlYakqEuc9eDzSP
 f46v2yIhyOBi363.2GI25LlGVI23YAYJk04Z4TSiMEVkIaExRYtaMzBjR_hrIwYlLNH7qxONmSbX
 rrLJqYucWXdM1zucWJR0FgZEskethAEMi8DHTAvuM10LX0b0.tmH4AyX16miCnd0XjSyb2IyO_zD
 0PiYD0hhiOBnEo95.GRuxO84q1OO1_pdI2Dzg4yFlqq7HVZ4z6Yu0P4hIMT2Soemlc19lJROoWZ3
 X56BOn4NFUmPcFJwoYwg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:06 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 656d248acb5116d5cebde187ab2fdbab;
          Thu, 24 Oct 2019 20:54:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 20/25] LSM: Verify LSM display sanity in binder
Date:   Thu, 24 Oct 2019 13:52:23 -0700
Message-Id: <20191024205228.6922-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index 30b0a04f14a2..ebbe7fac48d8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -706,9 +706,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

