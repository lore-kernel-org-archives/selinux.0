Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AE4C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B923206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="V5MTlBS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLXXWh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:22:37 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:46308
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfLXXWh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229755; bh=Vw5PzqK2k4wespl9dNFvI58s/wyRhq2FOJ5+UO2Nnnc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V5MTlBS+NrMap3hIZtXm3LtlQpHP+cV05yyMelgOh9dLtaN3wnYSXxmnFNxZX18jNtHmoHRyfgc6ut5OA2wMHaEJ/a0Y5QNSKizYF1lIqlRMIRkQdbXdVmfKSDklqh9hPwzp2SEvAhzfrbToKG6otQNPzWhdIJ2+Qac2OvXJDAY6yCshSPsldWrM40SsjwRJoGHWQDaJCB+/aUrDd0hRr/Pj9I5IAL6pFYQqPE0vLsEMXmvIGU/IObwFdNztlitLIyh6jzTGppX6fkws1ywEzgdDu0C3tGNuS2ixAiGaO/eYtksW7qxUxxC44d0M7NCUXnMSO/PYidCAe/LAUBrh/g==
X-YMail-OSG: gszbd8EVM1m3msUGhBgw7ARf9Jj1kAPlOcbjpKZdLIfi5aLE8y8OoJjxLJMxSg9
 5nkqcJCCk_2CTGJZMCaJ7cdlafljYwnQEb3fOIbT5HxVRwaniDZHSrC3Qz6oqrnXqwXSQzmLdJeG
 mFJkHef0vSjabWU7WCLgMuNhjiTfksvPI4ajufs6IKhB8KzXsTjn_F9k.ESXIKaZ_eVVl7vjPvju
 MXxDrQU8qPFxD5PavKq8jWzOuc9MDIunBj6uPiAi19GsdERaMjPn.O2YUCxqpwGq08PbQ.6fucpG
 HhfKTx6sY_8XfI3KuMjAZb5arYh3y__UXKbyTsOrzilUAE8aYTIIAGzQVhVIRttGKIEKDd2l5NS6
 Zx7DGd8kME7z3SJlCyTKFNmkxro9DTzYST.slEEmHYgc.f4kunY7YlT0q_NIhQxnvUOV0D.jr0st
 UKrjuLXWSSKgSzn3cKPFXe6MSNU7FkKaoaPRRAnLvWhWkh3CgXmqYkxivr3nTRIsgVLNRSuyOPi0
 VHJTDD32bnHjpzF6VO9rDeTBy60Pu4pjgCJk9R3QIVQoD0XybcD3rr7MIsvcG5AHi_WOeBj.H4qz
 .TrGRZDMRRgu2K7xIQpGpLwMlFrcxtVh.4tMXt9RLPgLZAGaJEvd.G3V_yZjHxIa4.1n2xLA3PKv
 c5A1nj806l2C4rP6uEDwi4h1xTcF_Tw5fO.s9f7RvWl20syT05R_oBQqWyga0rmgjVp8CfjsZ7NP
 _WDU9nuAIGO7CG_WyprhCMlhQUiKKH1LVOU3iz76IIDEb.QnyQteWQa39xmUgPNCibGTo_VJGzal
 XF_43gjpEHiD9fkts7j1eyfmLvRi1UjmEnQ_biwJwjNyvc3uWAOJnliI0yE0ObR6P4rp5QIeuqxb
 Qe3fhPa71jOLjulROs8FJoSkWoOd7NvN1HiKYpD_FCYancoepOfB.YAIOi8ejgYXjnOkEuWzeUa.
 eMqI0g7V6GkY1C0Kg5nzCYqeV1utlAw0v7hHe.nFwvoSBVeQfJvjGtVMxhmiUQbzm46cU6Fy5zAf
 PyOXuUVj8s7vTxPtzLlT6EZhlazDF4ZTjak4hl9pZdWMjH4ACcSapPL3Fm9ra8mSTNnFkJOdIHKy
 JK8.GtVvSFMOoiWmUS8q72hbt8iKDNj_OcFhd6Qit8LofR7ACken6ZevnVHAQvdFKTz3_nz_yQ0U
 KPFRDArU.NPftR5IqJj.wKWl4ZEFfRhEGxndvnHkdRdXfs2WA.J9przlx2NMxt5f9sngV_Glg49Z
 rkwtAFWef9Wlla2MR1HC7on0Fu1o58ZXKlK6qnPSanEl82ggYRv1dauWWYR0iQ.RgdHsNrBgSAkI
 4g5VukN9Kn5GShAMLscvDSg_hERD39aEkxBhQCWmifN6SRgzTvWipN3yJn.5krIhuWlKYkfAMJ9U
 Dv6zouuryRVI8DMFHHwTX35BSI2ugPUMHcNcPZkNjhi0j.0XfJZ2PfDtjKMjq3qA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:22:35 +0000
Received: by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58f74ae18f1da4948908388d565971e4;
          Tue, 24 Dec 2019 23:22:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 20/25] LSM: Verify LSM display sanity in binder
Date:   Tue, 24 Dec 2019 15:19:10 -0800
Message-Id: <20191224231915.7208-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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

