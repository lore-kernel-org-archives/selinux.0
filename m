Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC0C433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2939D61421
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhEMUbf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:31:35 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:38623
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhEMUbb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937821; bh=orfoMgYFn03ogh8eLHzt9UObSJhiXDRYegGSymMkcVU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qy7Y8ui1KlCc2KmV5xG6B2RmnANpO782BWBYnZ5kbx1DBSeKY0OQHyfAzIXhXUchTuRJmDy6vu60eQ4gW4yXjFHQu2z69zBNoGNqx7+Ap7iZ+jfNfWF0xnc0JOGtwWjWAnkemQXYexYbS066xRxPSPm4vLE/29WhFZ5Yc3kn5Oi60rmV2oVYTkQ89kl416/tvxg5TuDZUjGXeoB7tduEFq2iOoJj/b7+1nUOS7BlRaBx0lW7P9fd8KoQ6mniw6kTV8RgXkmvEBkvIDlxS6d0hvbTtOiS1+2Ta9DgsZF8gx1EUOY01R2SkxZaWvZvPr80Ez/5QnUgtj6JRSaU6THfqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620937821; bh=q8opedQtQtFp0+Nb2+M3pJvNaS+IGkA2SOcYzdX16hZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mBryKm2/NvINAj40VVK37ii2mqLnWNDRbEO/SM9DapFoEQFAkcaWabbx9crVkpIg/I2qRqsf3uilc0hKo6lFo2XYxXw3UU6tMAlx+N0LTY59daehW3677L9BoVIw1xuqG+wob3vtGgcUwrZvGFWkrGV757XRrNtlRz9kz1Niu5hfP/YfwpNpteUfAijkOA2OEXIdtsW+5Kn5ibTRH5iK4nAecm4sBPshpNu6E1ajn3+1M69V4+uGMN+81Fs+z1CmChl+1Z0ltx+EntbJbA2dxZsiHApG9XGMKgPVJTglSYiKGSzOHReCgREbHDK53E7asq/8G2Dj0cHXfdemM/e2zg==
X-YMail-OSG: dsbIvbwVM1nfj78dPnEu1.RyyhY7xJWASJ1au56bVLfKNhAVJuLlZVJNLmeVsFp
 1DSScpnyw1Rjr8vnC9Mj6Gtq8fvb6xNZV1.o6b6lmQYLGjn0FpZonESdNK2qlCpP0Bf9qBSF94JB
 nMSTON3wWBXfcZsplR9fbz1ZL1oBdTYywX8RfRsXwfC90PSWJ0gv.1TKW4kEMvckjl2b4qcew0GZ
 Tg3z1ejoH4f8q2pjhB1b3GoEuWuVmbs2SgGgWSASDw37.pPg6a3cTkvVEIii5Ob5iPvIjW8F3iWM
 qmer6o7CxlTE1AdVKriIfbDrIVE7NXSe_rPLmpZ_NC0JhTPWAaEgRQjqodv21m42RBnMT4YijhMp
 TxvJx_DL9kzLW9SNPlZnUecw9cwQvGLj4b8tAWkaBOfblm_ttighg_I7i3XKGUiAuvhcLkUqg4.N
 Ec3_PY2lMSl_8tRzasSGjC7EfkX2EYDmhBIZbK3Ta0f8dYxpjGUO_nNjv7JLXoFc9dP9IDSoM_Vh
 HWT8ml3I6nz18kloL8TJJZlTUWRRrMyAWYDdX74UQ7_cJame4ZKhMGR9aywp000Ym6PtuzX4jtuT
 4wMo8hfFB5ef_1ni6I3j7ezJqaHqL2nXGQzdflA6ej.nbjkwynDtzybGConxFF7ISbYwrXf1FCeG
 mMm7Fh0VSXJlLk41uiUXfhaptV322bUfi9oYu.T6xK25Y0XCrWjKypjZBpz88Icj6EQMaGZdesC.
 HSnLmkP4sMqH5AjbWclqxxieEUvMdnyCwpLKf_OCxg5DWdIkmLbO9sWspxsPrK4DLsYfPJ3yzau9
 6nj2GIFduO0RXM6dFVktjGNVWF.VkPugHVzLVhIt8C0sqvQtEy6vnhdjOc0VTyuoWszLijwxRvAP
 L.CkxvbKREyBqOZMOBhd4IbndNUvx8RU9xnDntvjMQEpBNbIVEJieWSeOJvwK8aOUsuXkpHyV6N_
 SPitAIeUY1_9uV90gAWLlbZH70mkIDEq2ETHslQrzWzTLCU6P7384WhaH8lGMLOdXtdLbQQoUj5V
 fGN7SO6gNy4HKWtC2plWWk904LBEzcK1DsjwqLhdkUfIT0rlLtX.A2iN7drX4VuAt2mPgpnyz_Tf
 94fQXykDA3CkYf41Iat1fH35kb112RU0I52wg0sF6HEX6yp26Nhdztop2aMNJjom9PdpOrHWtlwb
 o.kus1WWwpmbdIB_FxqyXqWSHRsyp8r63obxChomc7VH4y4tbZ118v2sw9GHI_PgY9mCVWjPR5qU
 y9IvqtmIP3uNnsssXmPhX2L4AcOXRDPYZOfzYf_v9PigMwvh7.yCrDpbAkwwD30T7BDgCfDceeFn
 nJSd6Pz5CBSIbkbF0NppDmDb_CFqOwN6i5Js8txBa..BkFOy2vwspa0C9rR0A_w6u1.NtO4s7Zsc
 _TMdOLEx9_LVfB4_KfqIBeCF3YHRGxfAKn9C8nSHCG4VbRJTsHNub7hz_.vqnAU6D62XCYE9nyuo
 _FymeA_85mq28WFdCtUVafxIOkcofgeLpNaEpUG.nLBvO0Q05o6U.ftReRUDwtCyM6Kv6a1Z51On
 RLwiRhicTdwmZuNIkJrYLxi__1xdoaarh1kAJ9g5ewJx9waCBhDvdoszbJlctLN5eu4HP.yTGnJL
 ICD1o1iQAHnYuNOeL5.mFVMmk9IliqY7Vxtr9lC178bmizR1DR7WA8ii0.r3lFKDo3ETHvfmtJ0z
 mx7wHT_RFNcDzLhbtI0Rh1PUktmmmHvbxfx4pHqS4We1nDeI1jaIbWUSkE1y3ErZ56pObNoas2kC
 naoEcT0OWy1j90_eOKCsC63ebz5QC9MJhx.Pf.cJlBsJP6msmhf4V4F9DSRRmkDsCbsxMIJcWZP3
 1gTLV47VwZxE186aW9x6M6yBwq151L0frxOzKFE3YEfbya6RonYODpN64gpGhSFuhxe8fJiCCbdq
 8aDFtHm8KPwtYFxvPgjZeAdMVQx7AeTwEuKC0P9mRROyBeO.X7AfKeBhDxePgUDBxkahlJ9DdyJQ
 6Ebfp4BwKsS1nWliGXtn1ymv17YYnc24TRAkFZZp5r6wt8aNnXWEozAjF3gn.p8lxf5.uRjUEWqp
 _n_JTq5U03dFSrIrnBdb4IRUfSY2CLtvNpfg0BNCyg1NPv.juyxKibD5u8ChIp91iYVZZ2FVNaR1
 MvVbPg45Or6pOhv9BVRkZhCdXxF6rc8UD2Hy48JdGSXkCOQKzLJms4p0td8sFtJ.gTzHQKhoRns9
 8lTsJs3su7nwQK_HN71_zzToZU7r80coW3LmwlUKgMrCLEy4Hxr4x_cZx2YLQgJ8l_jjVL1oFRg8
 Keifq9r7njrTTRBK9iQEjlb9MYJuDw_Mt7Oj6IT6TCwjH1_j5AJoKromSbu_JoEqpDBIhLwF6._j
 rw0yZW3wGVcRgPYwzNa5mgF5.uyz.mmKtjXCSyHRXrEEmsHtnnkcmTtK3SyGw_WC5fOK3fv6.la5
 c9rUwOqZ8.7NpcjiluFUciWx78GvP8LDgAaeweVfBPCYjoex.hV8_T8RWYy6a02w_g8gTLWS.gtN
 b1eBGmih74dQ6Zi2M3MSB2rzwN9Ak5r1Q5b1T9nzMgI1zccLRf4ADoM0XQg3YoI33oZPf4D47miZ
 gz1yoiMDfDU.a0.YoBduOoIUVadvhmaVVQ.QtHVqpAkB4Levvso4D4DVS7VT8jbizGveNKl1tWum
 WT.BsvRSw_6n5xJUjcCE_x9hmsBL.YwulSPLZ_oPg6UTn0HOvUiafUWMUn3ZWhvpUoTgLpdUyqcO
 OA_OsSRjrl4G4HvHp_bdEuI7HN_54UTEqXNZJCu3YgeoFEoWlfLvUeTiJpYC3OXPvc.I2LGdN98Z
 XK0VbAod1IwETz_4jzR5tEpJpeyxYonEzZRPxV6TOp_ZGQd7GgVcjM6znpLoGH9n1T.A6tbFlsnh
 4Hpg970SKmvTqswP6_hkGR2KTU101WQeKF609NHrvwdunX9jojkJ_UvsNaUMcBR2ekyMGAVGuCjd
 3Tv3I5uJP1JB4Q9XsZJt3RTYd1cqggfaG7FUmyappkA0z7DF4MTB0zts6OdZeTWC9YHTWKipYhY4
 BDTaLqZt5k1xmR3CXKrPoQoJeenAyQzQmYtxtY1nkMxM65qHIdB_NKB42BdGh3GdmgoNz0aXOa_3
 NCWYBjHgoNls59ykhLQTxkOG_7UU5a._uYv.h
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:30:21 +0000
Received: by kubenode581.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 27a9153262f58f2e7e1ce912bb0ce8b7;
          Thu, 13 May 2021 20:30:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 20/25] LSM: Verify LSM display sanity in binder
Date:   Thu, 13 May 2021 13:08:02 -0700
Message-Id: <20210513200807.15910-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "interface_lsm" security module. This prevents
confusion of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 1e441c3491b5..d1e9a54e22b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -857,9 +857,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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
+	int from_ilsm = lsm_task_ilsm(from);
+	int to_ilsm = lsm_task_ilsm(to);
+
+	/*
+	 * If the ilsm is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_ilsm == LSMBLOB_INVALID)
+		from_ilsm = 0;
+	if (to_ilsm == LSMBLOB_INVALID)
+		to_ilsm = 0;
+	if (from_ilsm != to_ilsm)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.29.2

