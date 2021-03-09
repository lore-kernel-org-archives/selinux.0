Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7861C433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5AC86527B
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 15:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhCIPIl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:08:41 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:45774
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231835AbhCIPIb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 10:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302511; bh=34OImH0tt9TH4rWio7ZBezCl5gVdglbH/vkf4ejGI04=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eUhj/MmXJVCeBbKumLY332uPa9KA6SXqpwXaU4UEWCQcrVTzK54Hsurm1XqdPuJnz8zyP5hT/6aoScKxUmZr0OoFH6J9MYpx7nn+H+b8RF9Ka2BOR1VJmX0NRzvjn/mJCCvWjLT/TuvdLh6cNj7rEB/GmLJTfy2HdFUMW6eqHz6/6XRAU3E/qib8LFgflIQkEve6TZJjcUrDU76PDhHqWjh+mJk/jSM5fK0+OQoHGJbWIMyLiCVWGnHWeFLW474xqJMwmySROToSYfjhF4AQCMBGK3XA0wo19fYy4RQwE+HpxGCcYjd+zkx7IF6Mkj9BWMPqTR/1icXkaxzpJHRiQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615302511; bh=D8sw2onNgNYuG0dQn/4lYx49MYtIv/1ivsN8ukjkMB6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VrrBYznUsm8CMneDe7KidwklJdy0u0XGpjhPMTQ6AzUNtJv5IYh82GXFEra39dWE/1R9HVO7aRQAV1Xmod9jqhXAWu1NTvEdVS+Dcp14qI32hdfhGMfsFQZHnEZ1eLGABhvQP1+UC2zNlSxwPJA/1/tLlmvNaIuHxjRraGUk+a3XSeZBveeLw/RvUVapPgBrh+HJ3vb8URRhtyTHi1+XkWRdRlmiITbhePm16MC2cCj9dWhoXOmNMWGhNsJO5AySXSGnqfQ5e7rgDgTXZlCrzYPITeF64xfqrqWO2am/RTQIubep4wyKNWeLndrdBX7vCWKzoeIWAMKEBVTIs/725w==
X-YMail-OSG: lE2uueUVM1nhEURl3dF_2LjlbJQRaqN6Zt855UGBVK9A0Z.oqbEOFDZkeTQ.e.A
 wJNSUWZg06FavZLG5RJwVKhao3nF2cOW3Yhj_XoJV7TsIPf_5U0E7BkQYvQUvsALuoTzvdl.xIQc
 .8ZeekCivo9Mm9HX9TNv5ZTfZQABY9AGLHRn1NT9iwluGC.p3zx5cl5CKkGKWOivT1ARgwk8DwpI
 UGwxYPeWHbzhWv2KW1AMjQhy6vEGaGEqEVUsMeeUh6rHvR_VqVw3mzH8zCdxuEr0xB1isT.rkKlh
 AwOnfXPw.MDw30QucFakWVOOU6YRtsFCiAQ51f7D_Tf8t4OzdBiH2erI8bXBb5854CU.TSiAu_rE
 Cw3swZvX61V1q.o6w2YanTHUczqXAIR4yEXWCv88GJizvRM9QIR97OdKvukfMVkrNTM0w1hp1Isn
 aQww7p0yNvp4DK_Iyr3gAWj6_kQEUy.iR2XiiiPPodTrZPtgji0cZ_bPYB8fboQvuSb5WmkN1ubK
 Lpmuf1JNCRDU6OOUr8mHw_oLA7uBA44G8dh8WKwAnjRKm3wvS2IHC858jnmAMdrptI_TLqc8vfni
 fBSapQ2cXyQ5p6VwwspPOS12Uc7x.dIjkuSYpS4EM0L1b2tZZYvUdOFTMWVkd2OoR050linwGj2z
 g8w9dJdex0JS_bB00bVTuv16hdUnxAgO1uF7r_lTxJfXMzIcpl1A36lyfYk2zinbsMzSDt_leCVU
 v.hHi3.sCleVpTJsD8ayHYSPlViymJymCNVAxGnfzXELfuuWZP5jguGKa5ClrEyl5jSGsLmZCn.U
 F_aPWaXzgsAP70kaztxYRgtMCvhiX3wOxV5iWDfH0IuIZzGWtq5wOZ08TKt1AqVcnp0JGZ_1jExt
 FDH4WndwtlkI9mbutITKu3eRnToq.VsUuZFtjT9PTUQfAPQcVvcl1NbnAE5NkUIKjjuU_uxtAsp7
 KkWCvuw3SX2.YrJFy4WfvobO6z4qd1IrcJ0UDPD0TdA85iAO5AsYbhJOJ1YcelQ4EBc2E08SqPKj
 a_vAlaBo0CUUZu6xRL2Wzi4iw5blzto8Jl9fRsR1J0hngrbR744NIxri9Gbsmsot8mfD2MARxbJN
 d92grmnvW6H6TL7iys2xetz.dLCWaMqiN3WjJdeqc2O2VnLGfWZnHS_TyhSVjhnMtF8dBQsb23Qj
 271yGQrYuDcI5AZeWMPLrSru49FFObXwqa_8s.NeI5qPgYziIy0vI3np3Oj.WT9fBrie7.zdkGme
 FvNdmtJJD87xr2Fjpsk1KwZjxRJuvxHA32cpwwjCKwBcBb20FtTjMs52NYMtTi.J3V_PaGN0DVLL
 dBPsDagPatE.nI74RmCh5EgD_SlfH103n9T9tdXS_XKbPWcoTbk0u5mTkUETYZWERyaJfaHGcEU2
 INOPmC19U5frWM3PR0PvQJ9oL.PGnuyml0Fd.z8wvXerTehqdOmjMgZ46cPzkR_Ezhky9h.dLI_s
 5lm2_9G8aRjMJx7HSMc9ACdlAznl5CdwiyvF0ZUFUyMMSGKUU.hNpf7jdi4ZCy9osh4WkJHbZmhT
 GkFcX7ASGAHGwDNWrdPIgZHAshdKanj0bPGw08IQANDrv.Q1WnUc3SrJQH_O0EOQMy20pfn.shJv
 I83eOa__xkJQHmB4a2ImmjWqxoMd0xqwoQw1MOOIcqN1HN_WKGdqDRMUeuBhFU_4qbFiHARmRD2d
 4k0zyRqMBAvgPnovc1mzDrcoMnXvhBzzy.IM7vWYj7pQ2pS5_TKpBWa42QSgHcQVqC.QWt5FXYAJ
 dj_mbEL7vnMHuKaCPC8YVtFkHZ8IAFclwGoNlxarCXXoBwStr9fVzmB.kk1OXYZsgXl77jnlA3tH
 PFSh0BM0GONzQEszQPbwucuSSmyOPHyrl_ACU6N_99wwl7MGTyQVpbXiVYlf5cptabFYfAHmfMqX
 fUFMY.5WxcvWM7bohPSRVz8kl8qd0fIB4I0JblXGcCYjZVURE0TS2wAtiKTHxadAvlp1fUMbD5kp
 ubJcokqr5MNOUZrB9BX9OJku8_vT1AHI2fySItiyHJj3Lc127jXH2w6NLniQs2OPWCOkwDY5yby4
 yt49m.kInUKUqsTBvRgsx8WjJBCWFNt8wiEvYd1WVcQsb5VcYetPT6hFfSRfgZPTaGsz16cvm2GE
 7GYii9JW1FbqbGWqW3WyuMA.r8WpOYAxXZiSln26rDIxXgCqfV0dejeM5vJWIZswV7AZmYGpg5SP
 sisvHG5CYZCLa27pnWaznFHiZX4aRdagktG.sDbVzrmevjDHnvt3Kyu5J1ksDbHkheYRoZxU._D8
 jERca0VR6hOEZhuHsxv_XT6pTAoZ2cgvzUtacIdIDaVMeK8uTV1f1DcHC.60Cy4oIrWe2ADyXtEv
 qupTYO_zPdxW3ohmZgyxoRTV4_kfnZSzLktCcASKBmMRrAlZuNfN.sGhPVJH8OD27pliTFkiubjO
 8_.6SDuPvjluJCMrSfZiHQ0xc85nmMT.c9iO0_YM_hh8Zv6C.UfYZycFBHQwJVYLkZnrm7Qx7Ql7
 FCW1.gC6t71y92.lYfZLD5efoqR7oP08JIvoFfl5YQ_KULEQ1Cq_sAcyz77Z.5kdlJ54a2XLfetS
 9QtuUsIraB228KZaTMVJvim0gOIZvb_95FgYAoFjFjVJCNpg.v37.7vBfB20mXN.aLHYJJwYrpjV
 rhtkqc6vb.7Q.BFZ3V9J9brX9eJPXrok3T966RSF_2nB9NgoC2d.nkZA89X6HvOt5GxIysbypTv4
 c.b_Dv.myHER5yKaGQiY3Nh3zpoBQ4nwaHKrK1U30xQ3v6yw.VUZ7lBbM7ewy.gaLQeLZUIi4pHs
 srDksCcPm3VtIoOtZ5GKjOd6tx0UHS73a8AwRor4b8YnThXWo4NlLoDWst2WtRY4EZo6_tJRxYsH
 2TXC2gjAhBsjmep7ix4zPABaWAvxKX5OvZ2.kneVLrQnl2X96lSD7UJsIctdWnRCXQN8tMMl.XJa
 CyA8YzxBEdsVLw.mriWubvcHqSKxTaXfCAFoVCZmznuULLOPy967jktXNVrGj_vbbSmT97QzMjnL
 fk9Qzehncecc_ahXtxl_0P395vLO5362pIhz5kObzUlkCrOiMr3U8Luxp4vINBAQ4BUA7sDEsy6M
 JGyMftITEvaLatOopkxie7yH50g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 15:08:31 +0000
Received: by kubenode528.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ba8fde34efdc4e8cb9b59879afe81ecc;
          Tue, 09 Mar 2021 15:08:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 23/25] Audit: Add a new record for multiple object LSM attributes
Date:   Tue,  9 Mar 2021 06:42:41 -0800
Message-Id: <20210309144243.12519-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create a new audit record type to contain the object information
when there are multiple security modules that may require such data.
This record is linked with the same timestamp and serial number.

An example of the MAC_OBJ_CONTEXTS (1421) record is:

        type=UNKNOWN[1421]
        msg=audit(1601152467.009:1050):
        obj_selinux=unconfined_u:object_r:user_home_t:s0

Not all security modules that can provide object information
do so in all cases. It is possible that a security module won't
apply an object attribute in all cases.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
To: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  7 ++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 53 +++++++++++++++++++++++++++
 kernel/audit.h             |  4 +--
 kernel/auditsc.c           | 73 +++++++-------------------------------
 5 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 229cd71fbf09..b92ad58bc97d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -189,6 +189,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 extern void audit_log_lsm(struct audit_context *context);
 
@@ -256,6 +258,11 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
 }
+static inline int audit_log_object_context(struct audit_buffer *ab,
+					   struct lsmblob *blob)
+{
+	return 0;
+}
 static inline void audit_log_task_info(struct audit_buffer *ab)
 { }
 static void audit_log_lsm(struct audit_context *context)
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 2a63720e56f6..dbb1dce16962 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -140,6 +140,7 @@
 #define AUDIT_MAC_CALIPSO_ADD	1418	/* NetLabel: add CALIPSO DOI entry */
 #define AUDIT_MAC_CALIPSO_DEL	1419	/* NetLabel: del CALIPSO DOI entry */
 #define AUDIT_MAC_TASK_CONTEXTS	1420	/* Multiple LSM contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1421	/* Multiple LSM object contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 5b29a350df78..88479459b6e0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2171,6 +2171,59 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob)
+{
+	int i;
+	int error;
+	bool sep = false;
+	struct lsmcontext lsmdata;
+	struct audit_buffer *lsmab = NULL;
+	struct audit_context *context = NULL;
+
+	/*
+	 * If there is more than one security module that has a
+	 * object "context" it's necessary to put the object data
+	 * into a separate record to maintain compatibility.
+	 */
+	if (lsm_multiple_contexts()) {
+		audit_log_format(ab, " obj=?");
+		context = ab->ctx;
+		if (context)
+			lsmab = audit_log_start(context, GFP_KERNEL,
+						AUDIT_MAC_OBJ_CONTEXTS);
+	}
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++) {
+		if (blob->secid[i] == 0)
+			continue;
+		error = security_secid_to_secctx(blob, &lsmdata, i);
+		if (error && error != -EINVAL) {
+			audit_panic("error in audit_log_object_context");
+			return error;
+		}
+
+		if (context) {
+			audit_log_format(lsmab, "%sobj_%s=%s",
+					 sep ? " " : "",
+					 lsm_slot_to_name(i),
+					 lsmdata.context);
+			sep = true;
+		} else
+			audit_log_format(ab, " obj=%s", lsmdata.context);
+
+		security_release_secctx(&lsmdata);
+		if (!context)
+			break;
+	}
+
+	if (context)
+		audit_log_end(lsmab);
+
+	return 0;
+}
+EXPORT_SYMBOL(audit_log_object_context);
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/audit.h b/kernel/audit.h
index 4f245c3dac0c..c65f40a1d308 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -78,7 +78,7 @@ struct audit_names {
 	kuid_t			uid;
 	kgid_t			gid;
 	dev_t			rdev;
-	u32			osid;
+	struct lsmblob		oblob;
 	struct audit_cap_data	fcap;
 	unsigned int		fcap_ver;
 	unsigned char		type;		/* record type */
@@ -155,7 +155,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4d0f3fa0bcb0..4a74fc774ada 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -686,14 +686,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
-					/*
-					 * lsmblob_init sets all values in the
-					 * lsmblob to sid. This is temporary
-					 * until name->osid is converted to a
-					 * lsmblob, which happens later in
-					 * this patch set.
-					 */
-					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
 								&blob,
 								f->type,
@@ -701,7 +693,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -715,8 +706,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -1028,7 +1018,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1038,15 +1027,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmblob_is_set(blob)) {
-		if (security_secid_to_secctx(blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(blob))
+		rc = audit_log_object_context(ab, blob);
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1273,26 +1255,15 @@ static void show_special(struct audit_context *context, int *call_panic)
 				context->socketcall.args[i]);
 		break; }
 	case AUDIT_IPC: {
-		u32 osid = context->ipc.osid;
+		struct lsmblob *oblob = &context->ipc.oblob;
 
 		audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (osid) {
-			struct lsmcontext lsmcxt;
-			struct lsmblob blob;
-
-			lsmblob_init(&blob, osid);
-			if (security_secid_to_secctx(&blob, &lsmcxt,
-						     LSMBLOB_FIRST)) {
-				audit_log_format(ab, " osid=%u", osid);
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmcxt.context);
-				security_release_secctx(&lsmcxt);
-			}
-		}
+		if (lsmblob_is_set(oblob) &&
+		    audit_log_object_context(ab, oblob))
+			*call_panic = 1;
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1435,20 +1406,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (n->osid != 0) {
-		struct lsmblob blob;
-		struct lsmcontext lsmctx;
-
-		lsmblob_init(&blob, n->osid);
-		if (security_secid_to_secctx(&blob, &lsmctx, LSMBLOB_FIRST)) {
-			audit_log_format(ab, " osid=%u", n->osid);
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", lsmctx.context);
-			security_release_secctx(&lsmctx);
-		}
-	}
+	if (lsmblob_is_set(&n->oblob) &&
+	    audit_log_object_context(ab, &n->oblob) && call_panic)
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -2038,17 +1998,13 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
-	struct lsmblob blob;
-
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &blob);
-	/* scaffolding until osid is updated */
-	name->osid = blob.secid[0];
+	security_inode_getsecid(inode, &name->oblob);
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
@@ -2394,16 +2350,11 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &blob);
-	/* context->ipc.osid will be changed to a lsmblob later in
-	 * the patch series. This will allow auditing of all the object
-	 * labels associated with the ipc object. */
-	context->ipc.osid = lsmblob_value(&blob);
+	security_ipc_getsecid(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
-- 
2.29.2

