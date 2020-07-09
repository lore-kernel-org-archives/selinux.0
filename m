Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F53C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2C2078A
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="j9iv21UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgGIAiu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:38:50 -0400
Received: from sonic312-28.consmr.mail.bf2.yahoo.com ([74.6.128.90]:38659 "EHLO
        sonic312-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbgGIAiu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594255128; bh=ZLwVrFCXmf99fQBFfDlaFXPCWAaoi49W0k2oTVfsVr8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=j9iv21UP19mTsuC1Y2wZo7tKuUuAYudBJtQpKTS1BsSTM/GiPEJ2UTTHtNgL0UplxiLPqsejtzE6/2ZyYDr/yy+Y4QveuXDf02QaKyTxAXap06xtnO671M9JcmbjhF6wLA52dxZfiU8iYFuMV/X1fZI3dvJaGQDEQUQylGZ0mnBv4vxz3ux0TyHWdPPdED+1mkupLaKzv4AionWqcUfMZveX0AhL2VE6wlkAjqGpLemSitvJ+Ct3Wv8/Sk2zFdetaXkdr0xJWi9EP7Rx1JMbDQx80G2tPB3vJqBVPA9bqfnfzZZxWvfUFH7D0JGgkG4wOy+xgVDscDCqTalwtOgtLg==
X-YMail-OSG: PwNZSIwVM1lXLQL527Ph8xYbk6OnlbQ4k0GZSZ187ZYKWh7jBtlTmIiPV60xpfm
 wD7barBBOlH_7UMSMuLiZjEZBRPDuEgZWnqND_u.pEU1Sl1gNqR5oNmOkpYEZYsenAp5DFWYF4eh
 RZ88S4xn.l0NCF2RlbhWhcTP0TghupSE38zXZmyIQQBmh2h_NX53MhxALKUPgq6lPVx5uDq8Ck6N
 T0PbQmKGsSGu8ZhO_s.J2dlZwhv2xC0zRgFY_wnkX8jeVLj8i8A59LsKIJ9tf5sSXx7PbcjqQriV
 Yadmy4RB2ytbGbcfi1NA6MEqbCplL3XjcaHq02ILr.uy37rUOFROgy2u0397fcSwgQjuq26o.vQG
 bi3Ye6V46qDOj6DhTyA4DDqMeRd6WgcJVvhxS7UE1YmXNWV9rZSQ6fAM4slrQi.u5iH3yWpQGtY5
 glwI4H6WTtQpNyPzayHsygxI5PiB2dQZZMfeNjJQr1U2DtKzS2EGw1oxOTWU2Fe.PENi.TLIPvur
 EmSic8wpS_4LkKmQtQPYER1FaQVHD47GQQLmkBK25btObVaHdS74SzLovNliYhShmxtEiXg6kFD0
 5THSnxU0GcCeTc_laiaL5UKxwPbluwGbkn4pFQN7nOiL_qpfr.7Vl_S8RH0v14CLZwUBOQX9yup0
 gwMX9ncLWmKEflEEnLNdWjWOEHMeadOvQQKNC1LomGBXgmlONUpAzcmWTZZdN6sYYJvFCxVWZUgw
 C2LbFZLi0DSc6VsRflt91gG5sP94nkUqn6aoFCDeFfRSyq48YN7ZjJSNZbOs9.dUq3xFKzU3XVoo
 kcScS4qN8Y0EZrBUsX3yNAlQd1Utot4nBPQUxgW64yIREn7RQzi7vNh65hAlZWufm5W0TjvuwNaR
 oamvYbEnRdIh90VmyfXtz4vVrxF96hIrkSe6RPLnZTIGVn8Mi2FJgocit.cBnFcs08.cqW1K_rmW
 iCfHhHQqHvl6Ok.UtPvFXfDVNZcaxYmKpyuFrOX7rBY6Jv_iKQ1Tu7Deb5VugcUlsrr8E7LOwAOy
 _SNxZTmYYTrTerDcZ0M_wObx4UlM6hNl_Vyb8_uosrQDHLaCugVorJcUBRmhmn6McFMGqyO.1IPX
 KTIohp7NBSlgKGN4poSfzT4yGq4ULmxHAruc_gr2bqZCPvXANDDY7tZ3fCdEDN2OxyXe3Bg5eejs
 EAXRw96M4BCIK_uAdEZn3aEFwt5sLzfBdWhol0BySWCctn2ZvOuIlP5_g_8Fl0dFedCUGgaPoHUB
 6WKY4mDrBL8ImEGkjiCAT2yFVevwt4Zpdw4RhVBrvsMTV.whgU1icCEevxB8eFvId3y5BOF_e2x6
 0khcsloZIQSvbsOcoJwzj5lbzcMSBy2hPrA3v8u77VIc3COwCyehemPooyT7N4YX41dNms9ybPct
 KyK3iiaP.OJh7NdyeltI8h_erw253nNDsIR32Wg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:38:48 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 943e64489313dc94b871efa014013ab6;
          Thu, 09 Jul 2020 00:38:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 19/23] LSM: Verify LSM display sanity in binder
Date:   Wed,  8 Jul 2020 17:12:30 -0700
Message-Id: <20200709001234.9719-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index d75ad048ffc9..c3fa4b7e9338 100644
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

