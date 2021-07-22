Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1AAC6377B
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA03161249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhGVA3m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:29:42 -0400
Received: from sonic309-28.consmr.mail.ne1.yahoo.com ([66.163.184.154]:42579
        "EHLO sonic309-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229953AbhGVA3l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916217; bh=b12ERVlT9S4eYvBwPCEeUwivFDGtvbIegsUNYemMVwo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=MM+ygjobUaaHiC8Wy+5+HqX+tXzmMtzvMaT8e5uVF7dVn/+EEKFU0xfDO0GJ9cIWkB7k08b/04e94tm7ZRvZOQE+0SGVUvfMbOfnnLM5XdF1Np7UanAH8L2e0BPIfZ7Zl0neSqoEJq6bd7eFDnvx9a2423IdDJfE4Ctl0KEtzBuoW+1TpbReIlOk11S2rgldUzq5kdEglzTd8KrXmlXe1ds6seydSzl0w46acqPWA/voMUI15F5mxKXhrg9p0m/qDL2HQafIF3shubtqX7b3cU33Dkmv+NIVTuajutzYDEZ1YUTGxZwEPatkR3bcKWhqUwZBnfzOmQ2B0fHDw/VcTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916217; bh=S49dCPt6PKnUV9OAiBiHXqDlUEWb7A5r/0y9CouQyr0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qIfkTsMnxN9QAx18Eh1nBqzUISNDfxSBwucKAcmZOFVzYiGpY6fUUwxnqW4gQLO6ftomOMjlh167MOIRSwQ/MJ0QGpOXVB1we6jubyiO+lOhH3BF26ZdklX3CGqLLHQ7peCYCU2Hk+WEEGXaVzESwM0rnkCNNhCEWKT7dKu4FjsQFcdKEEDQ94/EyCj3wQeWNAUMpXCuLOE3GlEr5ZIgORtbweyYoI67JwYF8/9lxtudhy1TQzwSzKSgp8Ferj6+zgWbm0hghA6E0d7OiWMJOVAeEpCK8B29v+/RKdepZqVX/1uj1/PTOZIAaW7xtqk2/wG3LdD22x5gj+P8/46BYw==
X-YMail-OSG: eOk6FRsVM1nS4Cf.zmon8LXLR_l_qsW.DwKEmlJNcT_go0E0ngz5juAlSwWuSUX
 pnnwZFIPyRa0q9nM1avgjAxswHGlFuYhmatMOFg77_GTTm0WA4kV5i0TdKnLKfLUlwBuzI3qccwh
 2L.merS.sjPrQvvZEZ3bBQ6uI7DpJlFFIyvmfSy1wHM_IJF0HnNHENHeTyZ6vFZ6WBK094v6F8sy
 d_xjgjZlqVHf5Pu84m23wRqS7Pi2pN5WJDXE1t07A1Es4ieDx0N6m1P432AxYYilH_YW27Qah5Fk
 8tps25racpF2ZqSJLTOypB0RlSCo4gpoRD63sqkn6rhMWWu169QprzaKgU9UJbakCMoPm0xM3BDb
 ieS3tYQmxJJ1ecJy6zxdbMICGGjhQip1xRcvEGPS6h0PWVBfJ6CCB4HQEFpGTF9M6DOJmMFZrdXN
 2NAIunE0nmcOv_u5LEq.EqW6rQhu8W53YekjGiEv49ulBrvtAeB7FEjqZLYnOJ0BuZIuZ8inW94m
 ZwEngBQzeVe_bT9ohSGiUFkQdy2avzWnJklVkl7.o0XNdsb.z3C5ThWW8IgtbOXYjQFu8F.CC3GX
 76FlPkfqrVXJv63InBaId8AEjPPyF7_HiNqiqta0yFVw6d.84DUCBeGM1qVwoo7H30gph_EvizJi
 QK9HhFCIthWrVkepyuqauPbqUHSQ1PUWiJ0ZIZNTDsJ.9_jKbSU1IkWiYWJDdukPsUXPViq8i0fu
 xw171fe.kRyVHzVfBDd1oSzu7Ni.ewPeIv_gNudhHIZVkrm6wrXRCbY2r87U97WNe7I4xECanroq
 oKzdGwO_th7dCGIl2rZJ.58roomZkP27VnKMQiSd2kisa5VXrwSH0EJUSQA_H8Qxqt7Th7HCRVLk
 l7A1J49oMDeN3vtymUANxRQ7mjbHsLWQ1fbmRyzV4xMNSmxYC8q7gdlMovhQIm.1jnx.FqS4k0Zw
 eR79UFbXTtz211a4SJKbQi2zQhnYe3wbsjl2VOjt7V0Bv4m98uyY5LQZoKm7CK9E9g5ugHKfLMd5
 E8svjNdWbLpTsXvDNtFnml1cRVNdcCYT5t5bpH_AaPBFhsaApJdtZIs6ZcpOYf4sHKaJh8PYKBHu
 6etltcy5Cbtiqr5zfullm49BW4Ym_k9zX3Pg0Xkp8wh2sAvP_rVgdoIJM6uAKU3Twd9Dd0MBiU55
 Scw2EDQTRtDy5yv7u05LCOEa2s89QNSfaiu5BS.5T5sre.ReOElBqTtyRq7giLFNtmr8Ipmo9AEM
 hPZ6g9UjDRP.oHfh8S7DMLIf84emGlrB2n1f7YyzQpE4xFiNX102Qnm3ahB0E20i7myT4XFjCOAR
 .iZ1ROq4.J8Vq6rY4XVegYsAmYypZWXzqrRFVNhkeDxCVfBzBe5KTu.SLF3DuTlyTm1Buxy0grd6
 dUERzRMlLZyfm8tF5G6X5fET0fIX.0RewaWhRzsxA.KAmu1gVgRNHBGnSg5OZ6CVgHwmJuxA.Mv2
 5RpWSCKttzj.L6h1sHWKc44ylWj0OfwEd0hMZ7BeCaOhK69easSxoJVLeP64uhM6Yu09Gc5pnbzK
 M7xh13BCsPOp4NZqAaECGxe8zFVkm6IgQ6uCZQizlddtBYh5e3XEB_xDbYn_QAzRGxHmh9WOVIwD
 WJGUhJlAGvoUMlBMve4eDHNG62sTtQMVQTm_415HedHVud56jvi7O7.oHMge45KYMP8Z8Ll0xrnX
 n_4.ZtKJ3__miofDLfXucp2P5fDuRQF8s4cfSBfP3ItLH7psfqBXGQo.nx0bsefHvhi1z0r3DlYa
 bD4JPBawm4fy9T9iTx8sfJE9Tjs_TqK8qs_.x.gs1f3EzjL96CK7J5QufuI8E3NDphy15VGTwegW
 gYBsq1gRdNgYZjERjRz3ZYSDEvu29v0wjY8Qey4mPU.bw_EGiUUORTTqRj4dSD5VSTM3JHzgDXV6
 Oo_wmH5Dr2v05Or6634jAphpU1rfcIA3MkzPpNT1TIm.DVkAghdpTSHWME80SgiG.OtdIzXO_5Wl
 t3fGpKfKhEjqtT_V08Ovb4emkZAGKmEqmaY390QaOn3u56yUbrRhCCpIwlczXfQ2d.BAi59J5kYE
 wx4zG5FFeYbV4rZE7gjsa2YGv95JQWqAWfYYGLCfDc_MYaq2vuRkTtlT3oc_6EKl1RhAhaw7b3ky
 hw3_gV7UCJIpPxkqXTKRlDu3F7x_16LEJb.dDTp7._LXm2MthvJwa3z7DFXQ06PqEXGnV9sI9XG0
 K4Ps_.wFaWKzmXm5g_vzy5BcEc9UPK0Cr5.7j7lclc4gHHJU_MY4zFDlpNDFxRy5SX90Sr6IvlZJ
 fw9x30FuiV_EvuRRUZLCxE6ReWzfm4qCeAlQa.JBebm6lnMAJM.QnQNVRDSGhUfAZLai_d.fbmm3
 NdDnjKgXozFkwsYKeXM.sHg4cesVjIu5PEFEV1WANvojev33hl_VDgXrUeLdebCdxOjgP7yvsD0C
 xtQNEvkdRyYV3oSycswkwpyOqaSlrAG.9aayoQQyIwk6Inpa0AnlxdH2Hv3alrczG2zEo65ABvQ_
 s1fl6b.JUY9z2krfmTxS2ineNG0Q1MVAk4SeS9SQgMJN_WiTPQ8YKMv13KVkRopiExKYS2S2CrIp
 A9RpVEObE4YkEaYmcNJt3ZP4clhit0uev2L6w6skkLfNNbD4_SXDvssfRICACiy1yRKeJUNe_Ntv
 02IsVCJ1ccOyWIQig.Ensjnu3nWYuKMuSSN2l4NrzIeknY5BdRzBMwYxlr8yAwJJgnFA.zNrOTwW
 ZfxAg8mUutK9bqCznruIyDS0vbAnKGcFwI72COEm27q5YoWMs8SBdIFDEnbWoraHc1DoKfYR0s25
 BS_vdYcUrlkjuM4A3Ul2OlYHlMWiOu9F8Ju8BdVrEBzlOWnLqfAYrG_dk.DGCfwX6lBKSqz.Sgxy
 b1e3QaC_tqTC0rPRbGXQ1ZKmxco0iAOBIe7VjTHvLFIyoPiz8kKKSRc2_ulFjhChF4pShxmZS2FE
 XVmFCbwVMuczuUeucHEDBozpIaMIyaBAnI_pEbYC7DjjcH9AyXoTfO6b4uhWxAVXIS4bdLF1A3Wy
 fLx_e9LCh2WYEC8Mn1sAlQMsIFTpxEiSlXf8AswqT9_iM_F2gnd9TQb1h8F.4uGBroT80MgphFBI
 AEFwTf5vtK.15cJQu5dGNLIWroiC9DNiB
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:10:17 +0000
Received: by kubenode550.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 71b7637e4e3d198acd7e7fcdbb55fc7f;
          Thu, 22 Jul 2021 01:10:13 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 20/25] LSM: Verify LSM display sanity in binder
Date:   Wed, 21 Jul 2021 17:47:53 -0700
Message-Id: <20210722004758.12371-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index 13ded9c55344..cb359e185d1a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -859,9 +859,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

