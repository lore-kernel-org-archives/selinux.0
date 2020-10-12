Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80F8C43457
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B9320BED
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qUL6WrAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgJLUjX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:39:23 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:44741
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730088AbgJLUjX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535162; bh=50Di2YGDfMzZWp5gRtTSCixaIGEl3dVN2ZMAcuFZc6Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=qUL6WrASRUvSJErrnaFeLxM+OjggiJuoHQEbzdnzfGq0cu0G9GmzpEXFNikvKfg+dKQ8174hD7M+OhNP8v8ms7lHQoJ3VrS0ySCAc0Clf0ABAjSisVi1VSet1rLPdt7HkORh6ytSYjmitGBOjUntH6TiH4+0XCQ+N28xUZRtgYJqLetKrcgYGPUz0wk8E5QVk1DktyDc6epjTIcviZqB7NBJtePcwfv1nuhd/wpkZayGAzYif0sXItZ84oA+1hsZxB9KMZaA75N4pElfcDIZSmtRch7BhI7UNZym/L9+L4upa6NCnjUofNRwvbwpMEyeBWXc2I/vrWN0VZeAZG83ww==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602535162; bh=0PJ9AFdRMre7GhsH6aN6X2O33I0af5NZeHHH832pqBG=; h=From:To:Subject:Date; b=ttPtl3egXdr6E+0C63JwairKF5OViS7LMqJDvQrAEDO/YSOddiUuox31DY7y4JSQx2RQrh1+MGPKb5yVBDoCyKFsC371MTS+PMvqU2pB4q5pvPM+OvhoizJnZO+/PuQAzu9uXcUS/Ezvb5/vGxMQDjpiAwAiFuqLK+WVsGSzXwzkA4SKxJpGcLKTzodp3N+jbzEH/l2AEWG1a/sa3G55NJMLicDKIg8lWcDOPjCnI3fLfDBE1akLrctrVT3Vvexon4H7D+97xiKfaMxz5cdu52vYyPeZ2gngTn4xDh22iWKkMAC8aiosShzxr11ov6wHRz4SadGFUK11rza87W/Brg==
X-YMail-OSG: aEiVqlMVM1l8p3g88krKllGce5JRt.PyFUUm.QIt6I8Px8tjk7273D7M19Ss6ZO
 T_qLB0YM1lw9kuIdENpJQcSToqtNKdypfQSNe.vGf2jzO1d8x2VsvT76ejBkCpw5EZd1bwQMTKea
 eVc9jm1c1UlyjwrP1_hxkU_Z2uUGhMMx9LmTnKjQJA7zLPo3dHHTXRmYzPGyBnRTR3rR7bmtM3ks
 Ae8p1uLbZlZ8l.8YCcI__T4rSSd3yML2HFeuWliTKhLBzXoJtc4VmG1fdz1lqbGxNuuWcXfO0GPq
 c8N8aK_beSIyM6zbwvp2UGVnf8B3USs_nAovUK6zF6gmqN41flKfUQoiifrogZbIkaSysXhYWmul
 2VYW52tzC_.6G4EnVpVHi1QaAFq4Y.ID0q2oe8d8pVWafNZ_IZOqOAiKn7_LptYC0TgOhR4XBcc2
 3QVc7gSaT__YV8.FCePylIqm7Py_7semi.dH5fEwt9B4RBtYGZ5nBp7Xk2Qa9sk0hwyrf4ym3B9t
 7zQkSz6670bnN1F4cAs8C.ekM4igl_cxiI.39EqnqK1X7Uq1hPAktCCaCw11_A_6OOfUNoX4PwhB
 .7qdvV8unNOPFVLBPVMT8sH6T4DmBc0niqhC.UoiJPvDY5.BJKDSKbiJVfioZdVmbZLAnDrCQ052
 b3lEl7EC2Wck7fmXiBuHreBowb.YyseYSbLwYjw5ec_ItM4SfEBoYz3B8SxzRZMj_zfvAJPbQBIZ
 oWpBuid9qOcCEeiFvD.TOpsy7sYr3CCjHHvcRAPioDVYD_X_e3gny0WKulZwza.ROKgqValWg_B2
 MXFlZCAtBchGXaq4Y7lfXirwBJOhWRvd_RFv6CHDUBUkjJVVbSfaW9sgc5gQu5t_7ZeHIlqHZ_1s
 HNpFsT0ACBYnM_LbCydzxzrJvi7DAloA4Gq9Y22oTpnM3B0pEgLrzygXTxIJNdLiRMA0eysAk5rP
 3D8np2nxs7VdirWtsUbz5soPQfGiCEWLiOXr5pDjOo_kRmlk_8qRDwsTqFsj0GDpgqroJBAKloXb
 wEHC2vHENgeri4JqIB5Aip6hsv6Md6qznoyXml_5rb4kLX3pjcA._jjrIQOpK7v27Scqpk.WMDLm
 KrPbTbz.88SMG_x3HR0CQv.G_aT61tELabp0eFUHlzA9p4i0ASjv3CHD7YI8H9B9IpKVwgwF2Nr4
 zwDO0CUiCVsze1FEC9CRXuxXEoZRVJ3WgGz60whGJlOXxLlmmYNcqjMTzlibKqA8BLkccOIUDn.f
 4v7YDiM4bYl2XDaRhHLcDXyiw5zLjgNBQyaF2DzmwpPmD2q8CAMqAlVBjc3goYtkxhxlSbW6I2eQ
 dltgzzBQGy9ltE0_PANiU2qH9KHhTTc.IzfTeTyZAqgojLgsWG2zBJGrR9Ad1swC2rq6jV2CYhs4
 094ZchHCLcBajCyCkezt3z3jnFzHgW2wIvJktM2_0Q6QWIA2rDMsBZCEaCEj2gZgo5Vq5Jr3DUlJ
 yMHWN31pQFuEePRC0b1BazqxQ_jSaDUIDNWSNXTao2u6yR5nV6faIfi3seJPMbi8K6xE4cfHnuDF
 fCJAgY8IE1Z5U_P05qX70.iOo_LcnvcQnUq4AwB5AYSQ9aOFoHR70gA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:39:22 +0000
Received: by smtp409.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9dd356bd13123518a23f9b8c99e8481d;
          Mon, 12 Oct 2020 20:39:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 18/23] LSM: Verify LSM display sanity in binder
Date:   Mon, 12 Oct 2020 13:19:19 -0700
Message-Id: <20201012201924.71463-19-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 022af5ae8525..d8a813ba076c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -790,9 +790,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

