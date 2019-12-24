Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89EC2D0C3
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE8420679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j/Ju5Bk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLYAC4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:02:56 -0500
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:43266
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfLYACz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232174; bh=2w8cClXJzgfUiQBGIEbXmNmNWF+vpCs55OnY6KajUr4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=j/Ju5Bk41kUY/FBdMdtN7BMzkFLZHbxEbVQkrlhDX9k+rdGJwLf02oJIjBQhK/FDYkEc44tVCUL9KrPqLnvVa8lSY0d1r2gu6gUT/GajbhHN+xdDmiXGTHpPRoSH0sbJqZIXmBlP56yy7Gv5hDSKuNQTl98r/pQTVOugzBwBh9GqLP5yriaPB2s2e754McSPuvaVGCutywFAXtXZXmoLfKf0qXDEyTXdJ4Zx4MtzH4vKT9d4TP4ziCDluERyqen7L0mOZkz53YfJtRLAB9r1JGWdZ3wRIwu7R143j73cTZzGBTeFBtlH8F3Gdf1yvoq7+QgNsecAPWLjcAySG8LRhg==
X-YMail-OSG: vT5MN5kVM1kF2Ftffx7Z9vgehuK7u8CkzyX4o4aW5enA8CNDKOmmuc6fCL.Wuod
 Bo8i5dD8Ung6tNs9jYoPCwOfJp9dKJ3FUVuG2xolUmR.zefKuD_UC3Fbqzu9NF3u7aJCXNvSHDMs
 jcHLIRQ76YfEonVmKbc.NzKTKtKmIF8sdu3Ly_SidY2fZ.lz0EqcJ_CnS56USxtTSnMLJPW69ZDj
 jsN64ylA4LgTGQrosK7uwj.vaZ6tstjHVihLAhL_03ExNf9fv6XOtIKZW9ATa4nsnMT4cEJncosm
 Uphhdr57gXcnxRYAW2w3Eb.BIjK2Hq7awlHws1tia2ysKwcBB9IWh_LbJEcP3BRhStC0sdrhtMv0
 xVjtvCVt5KfiAXj4852b8gxSC3OF3wOS0TMnVHXCAkTzJyYkgbRt2sdGjjZOdZ7qOg3qJRFhw5Az
 8MWYo5rl6l_XaK6mOpzvCChW.MM.01uSKZ_apuNcsCwpgrMwScXw4KwjSz8xfCrDqIbnpewJ3Sdl
 HXB2v5QbLxrvhAXfZsxaZRNrBKClGxmksVoCSo03Wv7Cm1W1al7z3cPILphUa9Pio16ZcpiNMcZq
 xHoeY213gPjXeesGueMeeHH01nNQj971uG6_SWy6VJ948s95n3q7DIC.fvOxu2Bc1Ol1s.5UQ97T
 ZTC9bamqR9eSBXcFeLM0Fiawv10VO56D2MkSVXLj2yHCfXH5Gh9utBo_aUuxKEb88SB56Tdcbwbh
 076a5auJEDRtUiEUk8C3UkcTrk5tVCqqw3JM5fZ5rXey1jMyX0.nJu3Syr1nxenNvUI8xjKZHb8V
 ebRZis7d9xvFECev7BCoJ2DbRbAvGIXISo6Iw4xnoCdTxokTqh9.90NOwQJXm7bGHqrbbVgmDOGg
 75JXNbvK8YHierBS_6aXMCIfu_YrcHcA40.XpQC99LTo.9AYydVhSQfvfZ6aIdeJxQIu0wwsqzx4
 keTK5w7FSRrhmYOtHcKvrXfahVivDSXLAsf7l2yNg7.tx2gJGQ0arubTp_4kTAC0v.sSYMcJDpeV
 3K_x0AfSgP4NQFe0uUJhxvUtUE6NFYkraYw8cuM8AIlFXpjw9b0s9tcFIlHILeDkatOt7Ld7s4bS
 aaI2N7kWn.HMknqbj92.t0h3.g5MmGsLUfoSryasW5mCIAeRLEBzcA4Aa2Yv2xdeATH18ynU1U78
 2szHMTjxQyNdsJKdFw7a77OlT3tny6y6DmTHIjdMcMwedn1ef2YFnkmjOT1mo3XZ0rsopHcg6k52
 eTq73Pi0TrvI0POkAfMdlAyerB4wa5BsZWxue_H23lcvXm8Kf67Ao9fOqltErwLAhih64wT921Rc
 upzUKCH__RtyYBRsz02XiKVvgb8G3cKFjQMJO2CDtKxyD0sCDCO5omgQjfDP502KJ1ipCrIizxn7
 k_DErFtwriMuwiGkDW18Q04VAw2HYU6XX2XpFo60J4ul8aKme.ZgAEqlr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:02:54 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4d8acb07bbe0004dd2134ff17c6a0ed8;
          Wed, 25 Dec 2019 00:02:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 20/25] LSM: Verify LSM display sanity in binder
Date:   Tue, 24 Dec 2019 15:59:34 -0800
Message-Id: <20191224235939.7483-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
index affd53f04805..1dc3d2f71a63 100644
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

