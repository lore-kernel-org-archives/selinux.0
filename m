Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441841A3BC4
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993793; cv=none; b=PNNxF5uMFfZzvOj0Sv/0AmxfmNEhKR8GmF1LNcWLTVHnpvpK9P1ghKgoyqS/swqZncEtV2jZO2koERmxlx3Nmb3nQgeYRwIkw2RNsH/epKGF7mYqDhdP55VdelnGLai0kIcBT3ulBhoigT/bL3MtvVsEOpX4yHwJdggDYEEpe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993793; c=relaxed/simple;
	bh=VGjyx9B/Z4+kocDkhqMO+H/zICDuO+jZ0NcWrDxEWE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUE+mdWGsmoB1isrZOlvR7apbbYP+1cGMBu/VtwxnZu0WlSCGnx/ILrW+vwicdXxzvdmfwwK6x4kQ+p81aik6X/y6SFY0IEAQQon/idnpVBy9VruWp147H6vSGgdEHPYOs0uICfQCNjIPIIbpL+SeZVAef1meZE8x3dH0NrT5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=o1CcYAEg; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="o1CcYAEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993791; bh=D5unLbLL6pg0Re2Ov6tBETKGM6evFCb7Pkbv24KcTZ4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=o1CcYAEgG02tssR04bQ2CUFanhWNypLIRuzY4Eu0FKgQ+huqtQnQn6x8lARr9gnyGW/+918akh5zHudbbiIcIWqDXhftw/YiMgobQvAw5dozUG+BUhE7ZaADRGfgu2TvXGKZgsNdEHQCl0HBMLBfS0RqxaOvL6+lFwu+qt+4mV0FUVsEV3GrO+y+w9Eh0eWtr2OWPAqQv4jNNOckcvAaCWYQrpnvt5OmRk/x8cE1HdlNoKv6r+hrd2JJSZ8RbXcp9h2e9LqX2njH1XpuhU2rWAwtO2bo7Jjx7lVeeP0lmCsURN3UEHWiX1Az7CMn3H2W5MlqPn/q7cVDjB0sUp65Kw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993791; bh=O+NocvRdikTpSo+L3h9APPt4G7T7zT7S92Bqww+oJOf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Ae30PAX/XS6EiccnX4GBeeqYu4qPWmgXbfMa3pfBVaNQGrU85cTR5wARXmVgIQag5Eu895ljaX6QX6W6hHlHRgW14hhN8HXuHHV7DEyi6AG5wbjfjFGJzLLjHmdxn+FtSbYF3q+tAgjWopV6ED71Psoh7Tz1z9lstj2KKVhj84O4PdMKl1ArehupFPBV5hbs/1JK/rCxCDZL7IM+hV9H36AgcFABUHeaARPkHxF4UWu49avJ+rN6ETKq5xFtb3kut2AcMiqJ/h3N6RO7qU0j2sGH7htydopFeDv71KJHFeY0CuS1m4B9Atw1RqtLMZHJE/LynAc5berYT6Jw0pmsJA==
X-YMail-OSG: .PsKYZgVM1lyw8vg4IibopsqWCVcisrp9DlqO6HoJQw0HVo5PvlSRFOPyVBBrLI
 tm7rgz1dK4Vu90A6V28jm7xe1WdCH9keHb3lMBP.KTgA2vMvgVxeOppkjLEIofJTv0uUPHBQMx1s
 K8.xApGRsmfrOvHQDlmB7MgzylrDtqIpRRQuAfJtjjVOEUq.F4tM3XSXh1dxfIKaYlD9qNIjRAGj
 4f_1BCqRZVMAa.Qo9_BhgqM7EX0deP5SkcUeKmXrrC0RONH6B1eT_UfKPAF0ynqZeqtm8w8YJgB4
 jsNqecxck8Rv7sDFVyBdlFXYAJsRyzuewDD0GaykioYO5Y_pq0d9SSe1u4QZUzjAVR3tTPUedY1t
 2NXL9sP.Kws3u03pw43OySw.EZGSXuyu_CcPUw9mV2fKn4FMOfKnT9Q_PhIW0gHdQF9KL1WNlcMn
 4_Lg2y4u1wcPdFTl8fPl4vMIgKWHsqNKGRUzRKa.TSs.0yNJxxzvc97MqrZr4sekiYL9R0uSzH0U
 RlXNXzJwEGKh_B2qfd4OM3NieFV2fiYbjguM6O3747HqKWBZbI7VmH4ZtPnCbVypzxFTfmZUJLPT
 hRsL_Jv4aRG65NCLwTgLXhtrel3JhtezHuN1BSOhLgVN0QiXJRBwySyvxznADVAQgbeTzC.GRw6d
 g8a9aang4ZEIFirOzv1ebmhzVMSF71whBBOERn03WFnRVYpuSZVMvnZ7E_Sv9hBZasj7fp2dEOAN
 GC6SkUAX_gD.dyAFEEIfnIVDQotcVBQtPiuHMYusy99bsi7hHymv9ItgvgpomYqf8pVjQ3QcLtsb
 mwnI7hROXqjpuSzBLz2ku8T_jIxU0SCgCk0tNuJsIDu8eIihQqcOtwFdMZyXmBbjZrVliAZ5xVLg
 G0nhSGdUpiqHdR1vG_UnVLqPgLXuo_.hGyfzkw_ao2X3hqLbD3H7Htxhswo7FI5XhrobpUGvdhWA
 ICEKNmtcfIROY16onWbzkDNO7P..kuGbE1XzMC_dIHW.S3chcUOcv001JQI2dcOeCGET731mgj7j
 1UkLWJziwUYtvcCLLwt449k0b8NxUcpxBCbnfrO3bR6qSpZuQYwq6PLPPYlx3pRSdHxVWG3dH52B
 UezDsmOMGNDYOvmp5ui4aTzuAT1Szs1yeTSZU4fV3Qp4qGrjY5bCAa9.0IkH4Psw9ssX6srm5DSA
 U_4gPf21AdBlha_Zd2XBjYXIKvtLjDwaA2p5xP_Rfw5Bo.DykzEa3kQ.9uj7h2JuqbKLGBttcIue
 gJs0Bec7rGNuekFh3jYCgS2lPBE727h4NcKPcJH7mV_jsbz725ByxzO73qcwcQ7u1zv8w_uPW4LS
 tGCbUEiLleYvBsQSGYa7kCIC1KLwdR2vjwejYhQymzxOkHnNxaSq4XSbgpM0Mpvj5.SVbti2rylc
 4pObI5lWY8xcJt_7uWDy_MkYDI58PWG55Yv_dpKhw.111LTm6zfBRTm1PS2BcE8CUxEWZwQUTHfF
 q08XFJUBHKUr1_F6U1i_fbEfwmQBjrIEOeSX9cjlkV3RgI2IxAlieM4nr115IaUHmNAKYEoyE6TG
 V1kYiyikvzXJGn5jjzrl3NavRTz0JaNNHVN._BAU28dVab1f6WH0bWr2urtGtE6q0nbUzWHJ3xwy
 M10M3m6o2urQuZSAAFP.0.YXUMoV9QYXKPIn3nmhvHP.dz9ZftFXMNQMw10XqipmBwZz4vLXM24b
 pkHSpQxaKJ.7NCxHJI9_yap9MqPiGyPjnef2tzyernoPHBuFhtWrZG.lBQU9m4mEbcL4c8WsZW4n
 f4Vqx8tlQ8NiTwmyjlej.wuLGOivH7R9.DK.Cw54JCyhOosowEp441JvOChS7wMG0CESRYZBrlhv
 VnHpNTKFukHW29DmVVcGuduqyGMdg0OP_mxQrgqd.HxKso.RIn.MqFrglqP2fGH2bFFsF_yuO03N
 yThd.R6wgJfj2nRaDfhAhNqV91prdLjc6R85h8ufXGxneKJpLqRKlj5MfCvOlT7tvdPd.nFpk4hS
 2vKPmDP8Jokr_yTXb_6vMiZSdD6F4lKHWehKBwFdVVrPmLVl_FOPrD3PzTYIEHc1fZ4ihOfVZnF.
 ghBCVACy7URyuJTOHI5OefHT6_zSnJxqm3RUyjW6tqXd2xR3IUREYssa.sMwAY6PL5XlGpCq.p.7
 K674jk8IPufzjKy9dPBQW9d305gZ8EmvAoaPj3xnyCdnqudD9T36prWZbDSWNmEIc1IpAsDy9x91
 9NcDtMjTgWE2fcvR._Lu956RIVYC97hOJ.yI1gKv.zAcLYG154A4oKJTuKObSqiWjOT_De9AFOJ0
 ic_whHmMM27UhRrQM.LPqfGZVm9gVobZRm7UY
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 90301bce-3976-442a-a013-829a0a5019e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:43:11 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfec55394db9c3ecf7e1196118de0a4c;
          Tue, 10 Sep 2024 18:43:08 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v3 04/13] Audit: maintain an lsm_prop in audit_context
Date: Tue, 10 Sep 2024 11:41:16 -0700
Message-ID: <20240910184125.224651-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the secid value stored in struct audit_context with a struct
lsm_prop. Change the code that uses this value to accommodate the
change. security_audit_rule_match() expects a lsm_prop, so existing
scaffolding can be removed. A call to security_secid_to_secctx()
is changed to security_lsmprop_to_secctx().  The call to
security_ipc_getsecid() is scaffolded.

A new function lsmprop_is_set() is introduced to identify whether
an lsm_prop contains a non-zero value.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 24 ++++++++++++++++++++++++
 kernel/audit.h           |  3 ++-
 kernel/auditsc.c         | 19 ++++++++-----------
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1c3768c9cf30..d739a4cf43d3 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -279,6 +279,19 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 
 #ifdef CONFIG_SECURITY
 
+/**
+ * lsmprop_is_set - report if there is a value in the lsm_prop
+ * @prop: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+{
+	const struct lsm_prop empty = {};
+
+	return !!memcmp(prop, &empty, sizeof(*prop));
+}
+
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
 int register_blocking_lsm_notifier(struct notifier_block *nb);
 int unregister_blocking_lsm_notifier(struct notifier_block *nb);
@@ -532,6 +545,17 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
 		      void *val, size_t val_len, u64 id, u64 flags);
 #else /* CONFIG_SECURITY */
 
+/**
+ * lsmprop_is_set - report if there is a value in the lsm_prop
+ * @prop: Pointer to the exported LSM data
+ *
+ * Returns true if there is a value set, false otherwise
+ */
+static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+{
+	return false;
+}
+
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
 {
 	return 0;
diff --git a/kernel/audit.h b/kernel/audit.h
index a60d2840559e..d14924a887c9 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/audit.h>
+#include <linux/security.h>
 #include <linux/skbuff.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
@@ -160,7 +161,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsm_prop		oprop;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index effb1a7e0405..014d23370384 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -724,9 +724,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				/* scaffolding */
-				prop.scaffold.secid = ctx->ipc.osid;
-				if (security_audit_rule_match(&prop,
+				if (security_audit_rule_match(&ctx->ipc.oprop,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
@@ -1394,19 +1392,17 @@ static void show_special(struct audit_context *context, int *call_panic)
 			audit_log_format(ab, " a%d=%lx", i,
 				context->socketcall.args[i]);
 		break; }
-	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
-
+	case AUDIT_IPC:
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
+		if (lsm_prop_is_set(&context->ipc.oprop)) {
 			char *ctx = NULL;
 			u32 len;
 
-			if (security_secid_to_secctx(osid, &ctx, &len)) {
-				audit_log_format(ab, " osid=%u", osid);
+			if (security_lsmprop_to_secctx(&context->ipc.oprop,
+						       &ctx, &len)) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", ctx);
@@ -1426,7 +1422,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->ipc.perm_gid,
 				context->ipc.perm_mode);
 		}
-		break; }
+		break;
 	case AUDIT_MQ_OPEN:
 		audit_log_format(ab,
 			"oflag=0x%x mode=%#ho mq_flags=0x%lx mq_maxmsg=%ld "
@@ -2642,7 +2638,8 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	/* scaffolding */
+	security_ipc_getsecid(ipcp, &context->ipc.oprop.scaffold.secid);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.46.0

