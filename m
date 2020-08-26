Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BCCC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A992075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dT9+X8g3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgHZPWa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:22:30 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com ([66.163.186.211]:36633
        "EHLO sonic310-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728008AbgHZPW3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598455347; bh=x30nPZLpFPTTON9xwug49FDlGI4IQDIqcRfVllA7iMU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dT9+X8g35TiPkzYybXrzx8DP0GGrqs3MjXhBikeP5hZMV2c14cshTDXa7EtH/Clh/8T4JRI5qoCFHBZ4jSO/MiHJyh4peYkyNxOBWYNy/pJu/6rsftWJbPL1j+uLJ5VjpZa0ew0P7Hn54PYS2QBPUpQW+P5DvSkUFGQGAIf0kitPpSielz1GFYLazOzt+L6MhmkIDeQWiJoaB98IihE8oirxtbzCuauJDG2EsyZCMC26rbGBBnKc5Jzervy7Epddd9oHg3wzPSB67+dOjGvvniOtgtc/TU7tYUtBGaVD4PWhgS9nwh0E+0JZafG1ntAPMFKkAEYszlVY8MjuqdzO6Q==
X-YMail-OSG: 5IcbxjgVM1lmlk3ezubrvSl7kP_1wa_t8ow8aFSryOPnjYfQ9j_YaHtZ3pHdV1T
 IUZ_NhWr4j2qbDiFZ0kiIAgwuN_I9X0hO9tm3I256DABDOf9YowFGSzoSR9U0t21.TLGA4qka3O.
 x0Spr9PjCcZW22DYnOCxkfue0m79GR2f6JI8e_uXk.Sn0lMV5ddsLmyOBAJAqtpX5zcLd.i2wQaJ
 zOA.xd93e4kQbBxMk_vckfIhJ6TYWzViYc07NyZxNIzjg6p5UO5kYjUGr01fgiJcIFSddeNekCY1
 9rlqF_oL0JnANiHjHAul2AJqK_4BeKmjripIBlu0Ii9C9K0CVKmSI7f530M6TdWktD2qNbuN2lWG
 V3hx6XKNpaK6vBxShBPFNb7QUhtBUSPLdHVyPQphV.AB7IyRKtOwctoUY1JhOlhtighJi_eiV7OL
 hkleqXBHdod1o7rcDzHN7iva2LiGHOUUcOACpYMybZ4GJnp_6LDOULZhw1b7mOaA8GpXAhsmG9Yw
 BTqdwkItLjukXYfnDqWqCDF7sa.3ewmctYfjYUwERL4QbeTNBp0nwQDWXlre8gLBaBPwGlKGeyGR
 qzjTgVjOwAcnVqfiZrHZZl8SXR9Z6W0SyCzqTlTk9IYYn3qugjX5SZjXF6UBAdSlgiyLh0QTWyfZ
 Thh15fOAriN00XXtDaIOw81bOoc2JgqHu_7hRaXHNb3Wcrs7cTJ_lr7K35dZXxiMG6juCsR_iCuM
 JWMLBRXffr8dx_8eKtKD0g3P1hjQt39e553WVCQhZG5m9st6zQ5cPP6fE8KpByon1KkgM28Ri7Cr
 LAPy3E1o6YZ.g1HfOQJKDo7vqlTGVjGAL3mkOcH.zQCfcJfCrQ9aBvFrmfven7sljETONlJxMwsB
 P_j8xJBh6qPlmUOjNIdMYeFg46c3rxMKNJxANQWTLySwgi75Ib7IniBFiX4KrRo0.afEybrizB6T
 RBbIajuxgJ.NcIS6zsnM8faTlP2u9ZTg1XY_qngSq5PQI5ofGzyqm5eT1fgxdMDt55tu33yQguef
 0Tm9BZhirK1njK_WsiDrOi3MDV0HsgnqKyQKqUUTFK3iGXf3CDE3.qAFquRH4.E_GfWOozh1vufK
 c1PUDJ3vG9ib3.qQBNgyO8D8JEBMygYg7cjyN8Ct1aosxF9I655FDu8UxOlpDRmHSQo_T5nn27Ut
 TvtCaxt.2mSFYzH4.xEmBNSuHzIac.aI4tjAtxKJUhEX2TSlX0SvdzLCXyGaZ_YOpF_3h7Uny6B4
 HrMbTy27yj.mc4wGZnvauK8EwZy7xkiT.cTdDL7VQDYhDOzR2bZq2cu_QHf2EX4SNHlZTj94ao_b
 NvJTJCZj.HjwUEtxUyqMRyzdVle92rjULjFgoCArPB8EeipdnQCxd31_l6cBvtiItxkmwsDyEqyA
 tqNy2w2E9Lf2YDjrwXMQW_HNsnuIc9xxvtBDo5hIHa8uLM5n3FDUHRz3esxvVLQMq03PrNZfoBtu
 P8Uq4ObRyxnObxs1anXdNlethvIxnTLmZglz3QVVofVLvYFaCHhu20skw52hsRhurdQzoBxy9qHk
 yGopcd03296xt4yw4tG_4tZzE4xX_853EsO2HEeIQZ.k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:22:27 +0000
Received: by smtp422.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4e2715e5e80abc834d7fac6d2c42f5da;
          Wed, 26 Aug 2020 15:22:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 19/23] LSM: Verify LSM display sanity in binder
Date:   Wed, 26 Aug 2020 07:52:43 -0700
Message-Id: <20200826145247.10029-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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

