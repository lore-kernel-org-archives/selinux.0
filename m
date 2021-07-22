Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E745DC6377B
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C737161249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 01:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhGVAdF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:33:05 -0400
Received: from sonic313-16.consmr.mail.ne1.yahoo.com ([66.163.185.39]:38990
        "EHLO sonic313-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhGVAdE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916420; bh=LolF5q/70QBnc7/4zTQony9YAaqgeX4sPLn2alIKSBE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kJVN8dWadVKVhtw5gs/ZhdkmJ9OCBtgbffeYfGrk5xtpHKyKOoSginFCs/S8c/3I9Cs40BJqIn89vXKmBVvFBuYCQMHbiSPWtjCqj663BhAnI8h6v171Akl29J35yVk6WewzVhM/UGnWEKHagsESreEHJRYAtCuhJDZolgNw2/1w8Vzhpr9qlOLnLQ6BK9lD8OKPRgZhgDE1KjV2eFKRjTSur3/+6R0JvszaIta28jSqPnNRqnxeZgUotOhshN4grBzrbU6Lm9DmPxDNGrzocOjI1l0fU+5WgmNk8qqPrLE3YVNVzGTVyVUPaBcidA9unH8vTdIZw7nCaFzzP5xzqQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626916420; bh=pnBI2aTaz1s1PhZCI/qRQCbpIY3MfUVLoV1GlZoQiHQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=QFH2CLQh7a4CyKah+fAw3GxnNUI+zMPt6GC/tF2muMo1Aq8SgGUgVxDzEOsmUovMT3pVcQJnAGRd/Zyu/PI2/qJ9dRNNGfV8XSRaMttruU2mZd51/RoNDvvOC6n24Kqku2DhkuAg6hGUdRWtx4IEGlUDuRnxqlyhwN8/hP4+1+NeKPlWN9xTwQGTiNcOkPoiGXZa5uq4x4fBzxc6hgL3imriXHQtMtl65pJZYJxv0BFWIus1MuZ+TyiSIZZSFkJeF+OtmWnd3P2nO0MJoGJNTyTqzYg1qyUfFo7n3UWWgQSGkdN5OYxOj9OBqeSJ6BPnDT63jIC/oLslbpAmECqzeQ==
X-YMail-OSG: kJ427cMVM1kvBuZ6_UysSBhnNSHwX8QlL685NX628nB_fq8EPu4wAMUH2HDvkLL
 tYCXm7yahkCyr2AC7fdgdESs4yaEXhmRnAWTcOVbp8sdl0DvkfEUnHewUYPdKx2W4EQrPWSYa_44
 NdIQlAinb2LCpylxuOAhD7x4oMQeU96DOxEUB1twtWyptxONfdKMFDzzEitlOxzRR8o1J776FXFG
 m.NHyAVq1b_aWFFJp1L6IMKBZHpMRYyaBsUeqaIsiLqXOqkN8CXwRHVsVCxHf4roJTGuD92VNfRr
 3MoiSMsk5R5gSw56bum8vzXoCq5p769Q8YFfUJInJS37tRYLA4pp_odPyhUhl6xlG7A5dVGmEtrm
 NRT14SB0KsFC2eJsOcVBiA4M_th3_pv3OcP4tU_fuqOnfSUaFcZM6i8Ak.WCJc88TMuvHAcJnib6
 x4R4vbVNRc4.Qq5W7hmtOjfMxsC.dgxEjBODEnw34jNZoXZbmgwWCNcxCQWYxoROjJH8HOke5vlU
 nL0INzi7FScbCPqx195GQlL_wVTaGvMpPgGk0tN0lrOIGJBglRD_j4ebH43zVa7YLwkSww5q0pEA
 eZlQ0llYGJu4eAM59aziw07oC7f8IH8UjWjepWm9qDNBXb72yggpa8GVnlFxJRDyJU4IkAF7tBo2
 9VaFvWdwJxRbu9ZJFdVZ1OiouHLjLbpdOLl_je1XA7n6kIVqzu5hjauc0AsSvQeBkYxYP5iQNwk5
 owviz5ayYf_jQnfVtgdJZ8Xz4RgIDYtkoydcMw1P5p7nkAZjQxEdHmR2nCyZHBxBJXJZFtBUhDAT
 DtAlZcqlb_MYMUoGsIXrb5fr95geGql7SJLtGQDsGKDW_nrBZmB7EFKNulaLO38U_gSVyzKJAkN3
 7Xgc4QkSx4uF58W4jY6ufeqhbE14tOAlGrhGNAIxCwCM_46Rup31h7jFLZICXgSKEw6w1u2adGNn
 3a467ZwYsXqAgCqSKA3yGc.Ly021blTx6icmKAsrIO3qUoy.GWpjqpYl8ZuCp0Bh8LKdHbf7a1RX
 dfIL3WpwVlg9ZoxMgO.b_KIj8NLGPFivaBKuVhPoba0kZdVrmDuHLhqRKEYVD8gBa5KoN8DmumI4
 PocRmKMbdlSxD5oWzJaOXGjKPqvdUKpHfn6rqjRv00XsJFH5j97BT3de3WRVoBUawYJEajR1SmBI
 4i4LeErSrGaF.sa0RkT48yokS5dS.pb8nnS.uYN_m2yfJK81xNAsXq7TXQ8JYfhN5dgtiKzsE2rG
 esNHg0ZRf78ukIxJsYJ1wUOVCWqZpa5HGoOXsvYzLTLCoT2Z_RAYhqBtqN._xso3fQWbo9zKeruz
 uzanxS6n4oSKE1yYtW9yC9ZN2iFGX01ArhP.swda9BACgsLsojoAjxb1LrdGxlG6fAtOZEJhFyFU
 EiUclfjeEZm3KG1JyDXZ7GkHDgePwq1kFy8P4EjdWYhi_3rjEjHtgHCsSS6fDIs9jh6UpLy6FvzO
 JGyivq9gQ6kjYGy0LVp9pH_Cl.Mz4nrpYoxzxyLfRIwtK.SKTe2pce0aabGY5R.2WbRuaUGnXwMz
 mG98CcbImeQowV98o4hf1nw1ZQZGKq.Di8MphgwTM7mgaaKptGTQYLGJg4qmPJEz7NlpFxO_hFx5
 y8zy_QyUfzxrzyJz2CB0E5Ybhqmuit43OXm9Jqtb9cSwU.cWbTbsv7ukU5S1SeY.UD7.z0bjWrpc
 y0EsbQGTUSz_5AyfUB7g5ecSnuz4vIlFxYfclZ_dhlPOnQlfLC5xj1B8DhfiNqLlFQi38H3_TaNO
 LZhLyFbRX_aF5u_VwYje.1poEcG9FJd0zresfUPS6ChuEVaDarTs1wS6k3b9DRccxcXxzeyT_W4d
 8oaE66H4Ew5Z.jYxwh9zlHIqixcQRxvHioRDgScqLL93IEQ._xCEmptMewHrxudThWT_uUCE00Jr
 RSIxw8mWRIJ7dINlVPbHx9FEzpGXaDwA5vDUcodEy0q.5ijH_jNkNgvbURhcns3TPMzSIu_R5f5Q
 r9hWy59R65Gzbh2pecDAKF7mUzy2chhRn0WTA0hkZbCp5P86UlGVTURW0RmvlbbGM5AmsCaz74GQ
 sHI.n6JE1JlR0adIjJu9otc6T3LpHBkt6zJEh9drRzM5bDnTmdNlaZSaiBLS9fKjiwU8tZtRoI2e
 5H88C024LUSQM9AH8Anq.y9kS.gvzhrVCmhtRxYye2KZdMbG32yp0ir7FqkdWf0EKAqiHIUlZ9ZJ
 hYcp8yiHjZyZcepSk9Dg677p98EecNei2s6po8ziqUSyDoLXTc4vqoCrGGRuYwaPpAqaRSYVkjl1
 3V9OHy5zfv7DcPpT4bzhMbDrEhHEkFmbaBKTPlXi3lTBo7G7AYJFDiYOZhvChKp2vmvtidnIj2F1
 rzDDmBdgZ3cw3ASWdmwPjACbIjF0N.3ufL78e9KCCZVmXDPyHPhxWGELsfORQgmFEsK3r606xioV
 GBzNZCMp0.4s0n54EwZ7VWovN_xfJetZkTQL9Thnzz0NLRYoGGr.osieLLNWPrfrNUWc.aetcPbG
 gONBMGCQxi7G_2EcLAUy31lScQz2nHxUj_9fxfWgq5Nn6v7xTVgkQKj631_pIFnNAdBkmfUpbSi5
 YnQXI25_17ZhUXpc0ybjsg349OC0PT0M.u4OaidfM9hAK2zvJruzfKhcnnYJp8q4F_ecgqn1WEOB
 IOWoEAwlynoi8xHuDv3FhsUV0sqXLvBzlJpAOVD7TmioMcFyRm7bF5cPtDHL1.7I_BiCdpD.BHRT
 _oyXKWIvASKP9qeXNJQsDzyCtfwSx09gOxdm89h8oRQTjEy6Ep4Zs9yZ4tkj0EIxl_joOokrygjg
 xRq46h2DWjK0OV45_jX3DYnh_da0.kMM5ugIIEy3pDbHRGavrSo647b.eBCoTWyFrae4FGBcwFfC
 IJljbAkHTYVbGkAEcK2LJuN5_ymCRwzYct62p_g7ecHlkR4PtgER5xD1loJTte3UFXGxxgC8ei0t
 okfb_dK2Jw2TqEiwYNK4ULn9ab9wMuljIGL4HjHHFuT8eWiTt7vCGoum7kkd696FEc6UsicT83WW
 hC2pg.jgW6DML7d4.9A4g45p1uS4k_LM10QVbjz85Gx6V3g6Z_2U_6JQlaDx5I9aaPg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 01:13:40 +0000
Received: by kubenode532.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2fc765c43d5a306eaddb85061762472d;
          Thu, 22 Jul 2021 01:13:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 23/25] Audit: Add record for multiple object LSM attributes
Date:   Wed, 21 Jul 2021 17:47:56 -0700
Message-Id: <20210722004758.12371-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
        obj_selinux="unconfined_u:object_r:user_home_t:s0"

Not all security modules that can provide object information
do so in all cases. It is possible that a security module won't
apply an object attribute in all cases.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
To: Paul Moore <paul@paul-moore.com>
---
 include/linux/audit.h      |  7 ++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 54 ++++++++++++++++++++++++++++
 kernel/audit.h             |  4 +--
 kernel/auditsc.c           | 73 +++++++-------------------------------
 5 files changed, 76 insertions(+), 63 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 85eb87f6f92d..6bf0c86fcbc9 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -187,6 +187,8 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_task_context(struct audit_buffer *ab);
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsmblob *blob);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
 extern int		    audit_update_lsm_rules(void);
@@ -250,6 +252,11 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
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
 
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 4432a8bed8e0..4efed1abcd54 100644
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
index cba63789a164..c500b303e39f 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2204,6 +2204,60 @@ int audit_log_task_context(struct audit_buffer *ab)
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
+		WARN_ONCE(!context, "Context not set for object\n");
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
+			audit_log_format(lsmab, "%sobj_%s=\"%s\"",
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
index ddc1a69edc79..d62f3cb09278 100644
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
@@ -153,7 +153,7 @@ struct audit_context {
 			kuid_t			uid;
 			kgid_t			gid;
 			umode_t			mode;
-			u32			osid;
+			struct lsmblob		oblob;
 			int			has_perm;
 			uid_t			perm_uid;
 			gid_t			perm_gid;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 01fdcbf468c0..5261a69a050a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -691,14 +691,6 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -706,7 +698,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -720,8 +711,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -1031,7 +1021,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1041,15 +1030,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1277,26 +1259,15 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1441,20 +1412,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2001,17 +1961,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2358,17 +2314,12 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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
2.31.1

