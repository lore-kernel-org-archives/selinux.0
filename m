Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A610BC433FE
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 857E46054E
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 18:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348027AbhIXSSk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:18:40 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:33726
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348024AbhIXSSj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 14:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507426; bh=3o/gYp9R1FqTT4YKi/xz/1vzAZtuq9lFg4B2d7iBOHk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TXvz0DzW+HnQCrwHYaXcsK0212V63NNasig90Z44SMkrB/2k/KdGfObzdLMi8cPSJTdDa/QEHetBcxYlEoA64fBfNy/MdnfAcFXfgU6UOSCTfD5ecgxh0IonHSu9ivBuxHB2XFmDjG9kNUEZ7J4R8RNJoluydXH2eoKnF7sDrfDPUjjBPTHLZLmrO7jcDNOxuSuO3AjKCRhAianl+32GMnir2xQVEuMOdz3h5pKtw9apcgOIH72WsaCACM8EG2V/dkUyIXt/FAjxzkpdzZewj51nxV8ZBTHLI9jyaqWDsrmg/qPbJe0cO+ibUDNqX3cgtre94teu2O8y+CAFJZ2WBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632507426; bh=m33FgLytvz0fzG+QrvJKfdl4cieJvmn7V9AagHXiFSD=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Kdn8hdHonCoe0kOQrXxPIVKnxK9jiPldHLMJaqSDHB4oznT4yfBp9g7MrFWohwI0nF+LpaCW0mtBlu7JqxAe/prE2CMvSLX72GgOx6jsZyQh3hNbB4veicyXTgRfs86qctT92tnMTMkqVCgBcxSBpw3OdcaOcssGemReFr1miaAAStFTdW7ZIkC6UGp1uFcrdbsHUD8oCsK9P+RbmzcA9mqJ2Rm+It7ixVHy3RcDRmF8J7JNCX6fEiofxJmqB5gLLztxn/r4k4tJDN3hF94O/YRy0FETqGj2E/cVZp4iTUiEN4OymlHCGQ6Sn8VJkMoA4c6efXCMyhEujuq8K74DPg==
X-YMail-OSG: 3vxk.AgVM1mcfqnuAShuHv5kW5p1LhjKSN891gsA_qsxrWmZjM9DwtBcOKaLPin
 Z.clx_N52CmuK8F2ijU0lYuZ39FJMQ3yVGsptY93hCfv_z0h.ZQ0i2td9pOHZrZ5z6oi0voMJtts
 4ooUbme.PoawBW._bmdOyfUs6yPRibJyP_FBEFJUgqRkiiaALh4lo7XFoD4.ONdILBFLhcg6eHWK
 hHcDEpqapzAdiOJux70UHmFtZRluK.ER73_dusJVzITTQY121Muhf3lW0e9_sHUtFl_th1JdRG3o
 vsZJ7XFk63CBq2i_Nuoeies28Doe9X7nyWCxWNgfLQrMPQ6Bty.xYeb2tkhRweDOGuuYf9eCKeHr
 6PDJh4bBVhsF11fTXfYs4d1Q1gFeWM9UXFZemWmolQNVPXA88Z_YrxsAJ09qaWeHRzoL4UOS7Y_y
 hTJ_EVZyuKP.ePBlKmoivTcrnWSWyu4MsZESvY0O.fP17x4.Vxy_dED8PYSVG6nbjZddH9pE0FoK
 1abcdNMCFKxRvPZ8D2WDmNgqQFwbzcm_jTi89hwOutsgranevOG3rYcZcj7yC7v_m7Yk_T1bjhs6
 yucEAUgMSjus_xnsSFK6x3RdTQ8Yg7yGW_m_d0HH6FK4EJPEtcFhSO1kNmW6riR8oZkCljC3ySl.
 czXNG7eueqEWllMHwBbjFuf53DUlzUQeUO6YVLXXTnjes6xy462Vk7wfSWt03RLoS.3WkPeWmtfl
 u1QqqK2S5rxYDAjNHKG1sHay2XB247L5X11tpl29KoZHfbG1XARplXbhULlCLxqftKITfG2_dVDq
 7dwMDu6pCgA5WHzPpltgHOdvuzZe1LV47urkma1TOVVIudXPSuPfkDbiZj8oXIDMrb._8yojEBIH
 24mbgoe5_DRmLCpowS.fF3wHZVkQzUCHuqvsNKH5WNjYLdVdL5m.iJDsRZSKLpTj30kbK0arzU_h
 iXnuD4AZubqaMK.vXvHgsiJhMC7MnUMPN_oZP..0LnJD1bzYj9LW5Vetsryd2VCtyhOcRTj.WKLe
 etMHX2HBmi8eboKBVsYS1dLFuzItx.MNDUPk4XO59r_xWPtt0fIjblgOSO4cXOWqXzkNc5Cn0BGp
 eBP7jNNuxp2sHYMgJdx1_mH2iQQB_iC39cKGPyM8njT.a18J9jswZpKQBrLOLdnHjpZlDf4slHzw
 JmCbPgWlCjMZTuJx805Fwf8r.qBs5qv.3Td.FUFZmPueC8UWHWTVZBCXFGa5zvC5KzhmAo_Kw4JA
 PpenvFmi3u3ikrpe2PagEUO8jSAvJ71ese5.7cVNYAddzcU3CdVykfNLYRMkAxyRlBPJ03qyNhgE
 eG7M4TFG.gdYfmDmdi7Q3JjZDqYPNiV62ivTr_2n8tlxNxyy51b40vXMwRq9B0tr71mh2t0zVeFe
 w0_Iiz6zJozVuKArRp2c4PLMU2DjJKPbkEXEHMqiRsqHZd9uHw65iAoon03_tvDQgyVEna_5Cw0w
 7hcS0O3TM81v4ZQAX9nsxqiwzIfaWzb3h3Sz74RIt6yp8IAVE1owsU6RtmKqiikvc60WW6d3Sm.p
 7Nwuj37psnHz9DCTfrVF7zIZk8o6vlnOr5q8lkDzfqjMUti5fzMcLAOLtizF71SAmVpPbVhMHeKj
 NURus3gcA8GIWAeJzmoKQ8K9p0ktQ80At1MZzKTHFidWXzcpbs1aTgWjDokboQz65a79QeUkVyyT
 Mq3M_g_0iVBy2xv5eMfZISHxy.TB81SFporCNd.S5eH1Xny8C5amAaWDRDdWH5QpOWrTRLud__rG
 viBzH2wMbNYOF.FStxL1ZQYI4uqYQABRNO5Sydqvben1AoveDbEtyNksmoK7jCSf.Fc4bETUdzQK
 rJ5DPBpFjoLtyjaEgqfmtGRVKmzlGaB50mrYtm5aUT1L0B6kWCZAaQOH2veCYehClKmrjkAIaZkj
 e9BmPYFePuZO81KTVzW2TMoKBMfnvxBB7sM6evpgK_7RPiZs55IT2_3CnVmdY5_FV3izjTQP.4o3
 _pPW.miGUmFN4B1L4tTkkfda0KQ2vYVKlS71Ef_cCxawOZ8CyRQzIDfQFP2FBnxXDqdIqTLU9Ivv
 JbBTVJzGezURmR3UFWxaqaFoguB4nsj.RBUrZPT89H9PmoH5KeVNyjLw_hk.wlsiD7lyDWY_tff8
 TEf77paSpOoXMydB9CLzhDvy_lWLMUWd.I9stCe665J379FkXbuvE3RnqL9bJMV_FdBuJjz7.4on
 ywwiy7f_UXQwlbe_fb8Lv1D6W3q42zGLKrCRZ8THTlQWHu.nwLQljPt9mAPi4tHumFpEAMCCegj0
 Aw_H9J6SJVIr9TAzfqwcKcbKb1cXYFcvvXkjVH3ZTZaTGxsNzeb97dBP2Zwd2fCLnJOBmw0wedL5
 PHKJ8YLjxfLU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 18:17:06 +0000
Received: by kubenode520.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 84bc1450383e59aca3126902a17a8bab;
          Fri, 24 Sep 2021 18:17:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v29 20/28] LSM: Verify LSM display sanity in binder
Date:   Fri, 24 Sep 2021 10:54:33 -0700
Message-Id: <20210924175441.7943-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index a61477c6b0f6..155da0e9b778 100644
--- a/security/security.c
+++ b/security/security.c
@@ -860,9 +860,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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
2.31.1

