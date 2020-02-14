Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0CC3B1BF
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6305B222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VNdxTC2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgBNXpR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:45:17 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:35692
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728389AbgBNXpQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723916; bh=B4wbGcaiLwb5+EB9+xkZV8Fh0rr1qZuc/k0LHtXJsBw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=VNdxTC2Hsz+fvHtT5yMYgzDT5wFIUdObwxEO2QxFAYsYr30oVzDaId89l0ZiiL26O6wMOLPA+FadqMSBHaYcoulRwvyrTPvdsKyDFzUV4xnhibpGGaHfZxxRKybhH4iS5ZYL0VJKSv/8aIEOlNT1ls4afdFRk6JrG9Pj/eTrEWhIs7CHOOHkBczKoz9kFJas0qyU8MRJ3YPYSkuSh9TdEFBscP/gutR7MXmRLVbzZ71ByxPyoKPNnhr6n+uAqDiiqq/M3oaP/vIYW7vxfef7hzBvnqfjKteYPqZNoFXbSnFsLyIieJrtaq4CYOUyNazq13Y37h8CZHVDFsL2VrJrcA==
X-YMail-OSG: SFrpa0gVM1nNnUx9KgrMQ.Shq80JlKa8hV4Io1xpdOG9dHgg4Sdnyi47bCwTGQd
 89q8FPgsO2isDI4v_SLXcDwPHR5KUGd6PYtqnN_X7gxQROEZS6SkTfFRTfXqHdvrunCr07w7oNWb
 axPQc3RmBjfN3QSrYe_HdkQAaB.PpHTX37lI1JDyJcZSFNDfJqFihPoQN65Qt4in45fyL7u8tjlS
 ehIglk1pjECwA_VdQIJUV1VlZSD1PldYO1MYiMbJcfPjMthohJRGsSMYCcdIqOp2rynIQguB6VTK
 4QeRsKko5KiQelLcX8mkFr4GEMA8_QeT_uWSTEsRArKw2G4Q.m45nuRw16Wcx1isAVi1nQbBAJQO
 Wr.Iv.iOpOlV57_zanG4YPLwrjLpqc1.yPJw73Lqp8JMLG1hV7Zej__URhuXezM8Z_e8SGXZVeEC
 dSbRPJFhjeIIgPiQhb4chBd2vVF7i7YapXOVNqbSSnKWLOgb8vMbS.ir0AQo7r_Yce7L0uq4o8lH
 u7hiVmIf_urOtkzPdeZG0AY6VeyuvWUzBJokfdnODWk9MUyjHmP7zqCmCplDlVfe2CXn6qJyji0h
 qa_vVYImUr4feGHoXsTUPEDYfBsi_8CTL94QPL1iL.4kc_IMJFbYFW7vXTgNnwMNoVzD73cEZtsG
 GYOR9fh_TCfteOZduk45.DxLuM7rzHJ1mN04cM9cYFOG2_CzKBay4jRZCxGh.iGwefXyUlOCMTwz
 GLOOu4z6RBli4VVpb5CI5enqpuwciCzruO1Khqnih0I_xEdvmhNlDuEdqYhkldZF7dZj8uNZkMvO
 bxAal0xstYEhICAJO8ek2.485PF4kdYNVTa.tlhl73OkCEyIRT7FZJXdk2Cycqa6SgpT9jASRL3d
 3qcsJHO9rBQLcV9EJcpCfnRTSBdfo3kBhvxbixveJOxzK00Goz_YvkbAzVzUgWqY1wVK.R_sSe5v
 CuUbXuevIAdcFHUdCbNCV1HWOuix2NkppIO_Ltjsw1g7rWfR_yNccrf_Vhbe8Pau2bC3i87IGMQC
 AQ0x6r_TTkLzuHu3nW98qW7Z7mTCaBgB4ifrpnD3Ki.l80gOSO._Fhlm0kn4QMXXfc6Uyenshnt.
 81KczZ5z2AOLjHfmGF8TbQHCu0o76wiSGsHaJvAymeDkYuN_80kmULSVEFZiEIFQdAmN7UdXPgzk
 OPuKe3cz721uI85CCwH5SxrgsZVyiPkBg4My3YjvrOgIVQTNeZquNmq5fahacD2.gS4I1w3Xphqh
 _5vK_vhCG3N4BlztkGtFOFhF_.DNCPQhiIeMaMUgypCJlfB5U3kPn3TOf9Qhf2BPTXgMRJcGyLYL
 oKTFFCncQpH1SCgnjhmxmNPR6BGUx3viJtGizCChrPW8EpeE87UCNVml._uzdX9k_OcsrbjYPk1y
 2PWaNumlaEeGPOY_Z5VNwX.NCsABP6SucNVYXYlRcRpU4m2GjDJbEUw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:45:16 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46059d1118a3773b16a774c9ae68d67b;
          Fri, 14 Feb 2020 23:45:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 19/23] LSM: Verify LSM display sanity in binder
Date:   Fri, 14 Feb 2020 15:41:59 -0800
Message-Id: <20200214234203.7086-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index d663406cba86..d6600bb81829 100644
--- a/security/security.c
+++ b/security/security.c
@@ -769,9 +769,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

