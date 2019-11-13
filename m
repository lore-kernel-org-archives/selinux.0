Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E617C17448
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26ACC21872
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BmHHb51c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfKMABa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:01:30 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:33834
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbfKMABa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603289; bh=F12XTVh9ZAFZSlr9OBSgmSb0u22QgxFH5gxNFFe2rBM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BmHHb51cmEsd5j/dg1cFYUdq0Sjgojd9XFSFYCD8lm0OuXbNtcqhFrjvzpUIBqhkoY1uN28JwBH0vapyZWb7fuyfONmce0OaM8miOIr/49mnkuWYU7aZLKF1DveNEPmVYpvOJNdNQaizyXW3x7YMZpvS3CLFs/KvTIFEw+iMQkiB9MvPXi4hrNfbIXQruzmSjXwrfN5oNoATbO44hekS12X+9d+0QOnhPCjU4uYAZqmKWsxnA7m27Fhue2LpYANJXfTMZ8uXDq8jtkPjB8A3YKJTlGI/M9mz10gKzaXyIJQ4b0ZTXMlJF/zKZa9K8BEt8muBzNarEUYqgSPUqP5mbw==
X-YMail-OSG: 2gJD1ZgVM1nZA._XYAuinzkrwE1ZmXW2JBmzvQQXiKyUS2UjrtuTYyGMne1pJAw
 T5KmxgYe0BW1PrQPd3yfChbQ5vqmL69QsZ4FuDmwn58MjmR8T6UJPDy06Fm.tyk4IgjTgovWvsHu
 ORGcsEi8el94OrVR9o8stj4n5ckaOteWNeODPZLlhRcT62gt6ACnrkFU.KasggWxj7ixxEA3yC04
 JWRSojYAJ8MUu3EKYEGPgyQHOQ3dM5ANMHWcKBR8BEEJEPpmlZXDweHbmbxVwP1dk45PibXXXaGL
 cbtjHcqUYLIzp01aNiIBLSvqyZ84EUYc7k9rhK.IpHcEiWowDZPNguVZ96wlhHWvUr_R88_6Zd2t
 9w8GFm_nr3Q7tLBhcc5H2Gok9DbjQBShJUOyOf0U0zhl5BY9dRjt5jtvRDv5dpkRm32CofJUNTxa
 ja.kTm6JkuxXVKo2AxQtD4YSKdIy_lcvBgXoIt6KIEzTO699s8ZDcyrCjAyfK0TndSBmRxiizD4Q
 GHEGca5tQ1r.BoajGSmJ8eDM_tGeKsEalM4zvLpWnXgFCDe5sgDhu_RtW4dh1TGGrE24Z8NoIrTD
 cNmoFw39XfExHo9l04_cXTfRVfH9t_PRVZ1BXM3u4XbeeTqrW9aZzhAgDierscm_9fti3Ek5xvBb
 1fynr7t8fMrQ26.OXxfE_3Uax1bW8KJoFeRDql9ZmX0AzRC.aXtsscro21aC6xtEAKb2dkq2ndMC
 nHdesgBeAI1Pe.peJ93LH_0wc_onJRbxxls1vfd9d12NGBcyfVCE6ljBjjJmVDtl9U5XQ5ogMtN2
 22Okex02SIiKCNmolPusgIhvyQBjZGe7dbhgc.TyX50epkNH4.HrQQovst7Q1XHi7SGsee7XGdfi
 uCyG94nukDPtiKCfZKiPkCbN7wtLKqp4soUZzUzHPfiJP_zFI7S6sQRfsrwWY_.HJ9tdPWOf6z1o
 YV8We8bZx6.e7o1jNsyTh0WO4lEvbUgmV8Z9wMaRm9BUUAKsWbX8sB5c5tnCPxN5zCrhffcIiPpH
 ixBSO1uv7xrcK2pYdV0NbN7Rv3.lcH3jPk3joR9aHPVkTNDnqODJV4DeWc.KuhnnfREqCgfIRVtD
 AdO4DR7MngSHqkabeM5zQ8VOEMlOECvHnJB9XELNUPYS8Q9tCtA7odpCd2Txb2Mzbd3mmkCKZx3B
 xN2yd5v9uP2LHyRh7g5MrivKRPcOSG_pkn8izxZzyyq2fkjodi4Qe48lf09.y7HjUdXi_sfFv09P
 XdU7EZVWt7CkXfWrz8LsrmwSdMTFd7ZZEtVMRAI0qvUBQVxuwEvw9KYKoaLSHqmDX5rJz5zf8H2k
 hCJGdnWzWjyQrDjBHtSIkLsTdHbXvHfD4WT.AKSsrV08Fzqb4tqY5NyBig02a42EKKW56WZMuKOK
 OH2yidvsG55ELDdP_WtPoNshNuNvDxrV0vyEvnc_Gh9nvXPc1X7k2gHRJVBE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:01:29 +0000
Received: by smtp416.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3fc9e96fd936fb81ed3ed6b645523234;
          Wed, 13 Nov 2019 00:01:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 20/25] LSM: Verify LSM display sanity in binder
Date:   Tue, 12 Nov 2019 16:00:17 -0800
Message-Id: <20191113000022.5300-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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

