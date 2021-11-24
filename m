Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D4C433EF
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 02:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhKXCIv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 21:08:51 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:42673
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240302AbhKXCIu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 21:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719541; bh=3v7/X7hiu4RXF+yQVC1lLkFTnjkaJoiIrnHULXOrI54=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GVYo1R6o0hVGE1b0MEWDtrgO7M7CACnKjKbXJ8OdlKvbO/POhAwJj+1fumLkpbse70FWagjv7eN3obHvmqHXXxp+2M9COu3VubvfHFQKlCfXX/ogQBGOk4wG1TaGK5if0FunVazypLfiJnnaHrB4rQ6AAjUPKx9friHO8Ni7qZ+FnLUxcpLLQIf+9EbI71Gnp7U3Iv7wRlBY6T0i6W1gaO2t2g6XwYTpr/JHG+SbX91HyMBsED+zvakV2mOuM1KW8Rj6s6gOAy2vpq5svOF4QJj4ZD8EIR4NLVEQlTDYs9dspqRtVu21UjmQqtlSMMaqhfsamvjl/NXZj3a5CmZXOw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719541; bh=Y5p4TiosCdAEapx2UxhgKMytWswBPr7B3IFoIc4Fvmo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Z1f4wGkF0E4Mr+jXfSFYMxZBb6CmHSP93u0SK2TG4HXPcZv0kJwR8tkiYZvwtXv7+IoqsZmDMg9tSsaW8IbVSNswhsg2zfdS691um5gvQkXrdhXR69dLUKiWm0tNrjlm7ikeBcmUWuwzz2yfuNXkzmzH6bYgn2AtVv3nCtMEpgSxj6xtTDxeVEK21xwbv1/SYBMw1c3gls9+8j/5R4zSF87adw1RzzJhQlDRS8LgHO60VscqK4hnGKwriboj6GUxKI1c+BbjGCkfqolLKxxqLMfQ7m6wDc5AZSvGTyZJdJJXA3cYxXPcFNbUecW3b/QyCbMPY1VShloWRcSSv82cBQ==
X-YMail-OSG: 4pVm8OQVM1lDr9frRNuzsudlmngMRarX0lN1CPRwo9KIW8vrNWy_PbEPM15LC4c
 HB2ynfPqWREYqyXISb81znylg4QlfzU0vFo1Z3Xm0k7ISKtUT_uzcPA0rrYWnmzENOBN5Qm_UKRv
 GJVPjis6eKNPI2L1Nr0akml1LwmbrBd4gDSu.x_7qwY_64MqR1uPmxVCPHUUIL6S3_TQ.CR2IJ1t
 uE2zVL8ySdUdcavucXbxetARoy6.UmQlMox_wJTYnoUHXOOiByks1iNyOTJKezjxQTZpTcKTTeYe
 qWOyqu0BqUlPXMACn4mF36tg25zjTFBs6YVsygUhn9YFA4cs38z2YOkrMmV_xW9E.yHREkYiCKmO
 zPAbIMhE9GC9ILDT3N1V6LjWQ0AOiKjA8fnfp6lP.FSEePDhgDBtB_WuLVID_ZkB.fLMur6a2Qvg
 SoqoEbUgktHBkcy6KG83ovuu2PIkqlJ6PDB1vZEHr2SlScNK7tfGaaTKyPBAYbCbgfLNvXYgKpmL
 eRWHXCK5FWZFSm9b2W4iUESl0SH9tTc_FMgKhahW70QUFj7KMideYDK3v3KshsfAv18Ac5R1YAlG
 YRa553voPbfrleMGnEMr0MFL4o1vW_TtRTTVsptFZu0s_V8AwsBtXX2eJeoBmp_XoXADvZKak_g_
 3aSa7oHdCv5z7V4tmsg8Ub9oxRfvnI9AJKARIpYCaT7ivYf0NVvQl_3q99YrMJRqecjetm_ykN8b
 VBr4lg9OP_CHiTIRzyJw6wBWh.jiBVgWhjHZp1fKk0Ty1NrQQF898RxaespQHFSerz6HSBFWONRa
 jrl5rFqtnI3ErzxQJW2TVyDIeJzMrsV2A1UvpXpfU41fmBX1tFECnY8UqWkHPcybszINvznK8fhT
 _HbO.U8e0DdmVt_NACEJ9dGNyGiogcBJCA8Zmr1BEE095szpLaSI6Nx4koq9MPZJrMJVDDryTzYF
 RAuQDlcNwmLib1IWI4rSzTCRBkqS4tyXbQT2sDKUOH74oaJJpASAXQetQ8amFyvOsEN7tjauA8WW
 JS_MC5qp6LR1Z3icfZgsBkFHkLNJVyBudxzLAxD5H809D2kksD_iXa8iwMpEquD0MvA2sdrj7QOe
 hqfAlMjM8Zg4xD1EhPFAuofQIrZ6e4gFkGWqr0YmBOzf86t0Jcu4dGNwVdWRT1F8DDFFHL92Nw0i
 DdYgLVjhZoD53SP43P4yVeC2s.lN971_jzxdIan.BVToXvqgcKqcWKYyxqkSHlxpSBg3R2gt4t5V
 uNsJhpOiXP_zxW5ix.wIU8xO0Eiwb9._lA6R1y1n0oaCYthgnqpAnSFKmXW2x2DGoGrNF3JHqMHc
 lmTVnVCbEF_JUJ3Acr8c7Nt.p2d9fRBA6FXKFsHj_9aMG2yMRKqs.9KWtjFTbhMqXUSrhCjshpJn
 iLaWE0MWiDVp1VwBfZyDai_OlLjO3EHcfxylqUee6j6OxRzEgoHPwZtp9dbI6go5wvT_LO6jNzCz
 3mwnFZp200KF_vzAJMjBFcwZ_YmlcUOKzAjSmc7FMPV1XM6HQycITuM0pchpajmVjD4z1vZo9k.i
 QaZJlcitLomuhJC2.Va.pIuiLZIB06dZVw2p7Y6dJ3eTsVricXlyf98DyFK2wTWSx7sJhL75J_ex
 6LX3.3EgoEiisix5d5pdARoyA4Y7ZVYxv72awnsBcl40fPwqscsjQTsjbQ1ugKHIKzy4.RL5PX0R
 WDsFrhMHE8zJm0ckZqYDVWOf2YXEyDc6motz0gZvJiQSJYZ_XzoFxgdHm.mV3lkDiEEwXfM._7iR
 a.ImWwXFSYvNR.S7W67YpAzBgujXpzHAvKF2Jvg1l.zVsIFkSR_rZwMkoDbojUvF9Bd1V3Q3AD2Q
 HXrPod1rnwl5cVhaG.B7eRwOSErGDXJfIxmnhCUlIfybEvj4tP5kuykmRWuNt1ItofhYLVrMb051
 LkO0GaAeYQSCSgafY3TrlYBR4rV4ru9gKoE3lvGK9gWg4E0JiXIcr3NLZuxqOcMcLO.AAjI4mGl.
 85BjE8mNxyhKF62bv5RX3T.SJd78kpCxQ9m2CoU2c5Z9nqgtukO8Ox.Wrj.z8Pu1GHrGnQRAmFh7
 USo4UBqROhldWfK396Mkf4lWkS3n1gYTmKCr3k4X7dHRUlVcCV5KLCDF35Tr_VRGEkzSmd5GOejQ
 ATvScmlbwyXcSJpyxUe.Z714BTaAohMSo9ZPj5rtRAIAxTDUkX_vKLzg_WXQUdzuhzu.KMwT2rw5
 AvDc4xswOjLef42wMi2aVJ2ZqvlX02KXSxdQx3ze0orthJaoSHQmESSgA.CYYfWIvWXJEN87AT6O
 WzBZZE9RevJpWbtN2
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 02:05:41 +0000
Received: by kubenode517.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4dfa065c98a4e0d04bdaf5ccb62b1d1e;
          Wed, 24 Nov 2021 02:05:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 20/28] binder: Pass LSM identifier for confirmation
Date:   Tue, 23 Nov 2021 17:43:24 -0800
Message-Id: <20211124014332.36128-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Send an identifier for the security module interface_lsm
along with the security context. This allows the receiver
to verify that the receiver and the sender agree on which
security module's context is being used. If they don't
agree the message is rejected.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c          | 21 +++++++++++++++++++++
 drivers/android/binder_internal.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index caaee7f95514..7172d864579d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2762,6 +2762,7 @@ static void binder_transaction(struct binder_proc *proc,
 				    ALIGN(extra_buffers_size, sizeof(void *)) -
 				    ALIGN(lsmctx.len, sizeof(u64));
 
+		t->security_interface = lsm_task_ilsm(current);
 		t->security_ctx = (uintptr_t)t->buffer->user_data + buf_offset;
 		err = binder_alloc_copy_to_buffer(&target_proc->alloc,
 						  t->buffer, buf_offset,
@@ -4132,6 +4133,26 @@ static int binder_thread_read(struct binder_proc *proc,
 
 		tr.secctx = t->security_ctx;
 		if (t->security_ctx) {
+			int to_ilsm = lsm_task_ilsm(current);
+			int from_ilsm = t->security_interface;
+
+			if (to_ilsm == LSMBLOB_INVALID)
+				to_ilsm = 0;
+			if (from_ilsm == LSMBLOB_INVALID)
+				from_ilsm = 0;
+			/*
+			 * The sender provided a security context from
+			 * a different security module than the one this
+			 * process wants to report if these don't match.
+			 */
+			if (from_ilsm != to_ilsm) {
+				if (t_from)
+					binder_thread_dec_tmpref(t_from);
+
+				binder_cleanup_transaction(t, "security context mismatch",
+							   BR_FAILED_REPLY);
+				return -EINVAL;
+			}
 			cmd = BR_TRANSACTION_SEC_CTX;
 			trsize = sizeof(tr);
 		}
diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
index d6b6b8cb7346..e3a0718ce17c 100644
--- a/drivers/android/binder_internal.h
+++ b/drivers/android/binder_internal.h
@@ -545,6 +545,7 @@ struct binder_transaction {
 	long    saved_priority;
 	kuid_t  sender_euid;
 	struct list_head fd_fixups;
+	int	security_interface;
 	binder_uintptr_t security_ctx;
 	/**
 	 * @lock:  protects @from, @to_proc, and @to_thread
-- 
2.31.1

