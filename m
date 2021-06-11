Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1BC48BDF
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932236128A
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFKAcT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:32:19 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:45413
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231271AbhFKAcP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371417; bh=DLyTN6qRJ8a2Jzf9cfjEe8DgIe412JHa9YBX8HYiEsw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=JnCGuRYtfmSE7Hlz/snOd47Iqn6qh8oBhaUy0r4byEJvvQwP+7llPRPO33pqcb/VbVN2DnvNqm33f5ZGqV+4Mj6TqofHj9SAS2k4Sc8n/yiKneiykLUxUTTt74/H1OecApdkAzPs7eVBmQ3hBRsdtjH35d8dbo0z5KndYbbCc3jjf1XXupX6s+mMEb9uuAx6ZPRbbLQ7QXSNBTZ+zkSekIg1XA2U3JvuOPZqmGndUYURMRFg7dSC5MxRb0l/e36MjONcCEQ24zyEKgEwWZR0RcTdgrBd/xPLYXwQBZA4PlbvmSEG2ZS+rCDKjsnPE/ElB/3PlmsgZgf9MzNZh37uOQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623371417; bh=Oj7hFWSEYMFHi6xmTHjAZIdst9tw/pQx09p7RQU77jS=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PfACD1aO5GIvQ+mFMQ9CtVFp4qjvagT4UTqKLYB4Wd0FuvWrPIuG3VrEcZnOVIOe+2zgK/51oXKzVoJW7b7eaCl0PgKlCO54rHhsGvIx87eSNVvSG2Ke17Mmt9S20EjWSP0oDwj/i21qf/+Ql2uteE9OKvEGm9XzFXAxOpa66aXvM2YZwtmJJuIy8iJPYgXGSWxMbq5/ODx1Tfk1UrVyPVSdvjZsKU0XqD/fyQpSfF8MOpuYreE36pf1FpSj0rzMegSQZ8S0vDMS5xz6xzrWwSWvWYLdjJolwR5JEDTb18rbbZBkaOcspkU5RUIcVjn7Wt0VCO5qBcE0/GX4sdpvXQ==
X-YMail-OSG: znTwACMVM1kVQg_3RCWSJYODOfGLO6E_C8j.RJxx4cqEa2ujND_FRR60wQZXVUq
 uG.NydUqvdV6ld_sZpz.iPzBKD3vDdUgmlPXagDiXkKx9cZBNr0MkjD_asPm_Byle3bWA4xuG5LS
 OrLsqYA9D_CMFbCO5zBNnfxxGrTnm3zKeSxFHFvHUpBxF.Y46GOXqA4gpZ7LCW7iVCuz6xIptPMz
 Lk80BxBkfRqEWP8BGZ71KABxyLW_ROFPOzyBpld.r8Y8GqQgXxMazDwT4_PglIm09kum.er1A1BQ
 UUVyCNFKPMTtDJoalEWOKj.1BXTo9Oblfw0xSEC9XQ3lLHZHkP32vOgRoUWnGRGvrC9KlOqwgRg6
 Hshz61czsQ6DnS8vyfoNd.XLTIrJKSgnxQnSkFE6Z09wKbocTfS8_.zK02bPeiQey.5lWor9LhsM
 _OoikTNYzX9eH6mIgtqsmwy4Zjl2zoq2bGPhNQ9v0UvYOEWRZRysf49jTU9UqgZzt82aEr68UqQB
 sbrLimJ19._LZ_9m0cnH030DkFrqOTqHoo_h58NAEbxWwELd1zXVet1DSBjRGOTGeFCcznHPJnfl
 9QgOWjvcr4lPNHq_BPX6Aoq5Z.L7fBZCiA3SNAlBsZdBNVjdi4TkqZgoxZLd_VlHkjEdjaNMPNHN
 gjQ5Txfc7Aen2Pt0768KUwjXBZgzDoO0L9EMjCwEz9I85oalQS3Q3JKjBOlJTShafz_C6.g97ZoW
 d85X8nta24kOKtjkEQ090jj5z6faGG.J9qxutEowtSCdBI9smc02q3_zay_8XcTpYkldweFm_tRQ
 WHdR267X18xmKmCRqqB3vaezg8HcY7L1hIasHZCopQqy0lN.35XlsiIGhdm6HTr8Z2IPSTvfcBPf
 wfYF6KH3hcmg5svJmQveF2njS6n1RN1xAv0Q0zkoWt7AIxOCKSkkjqvjn53M3hgkuCxMQuEuAcD9
 Z_qT_xM2hRVcKstJU8QVWMLrfAeqBJoDP7KWZvIaW8n_2vzyJd4IoBiHyw48Vb.ZfV4B_DWqI8K4
 8TGYLvPheSvfBmsprmIZ5yB2fbt2UYdOJ7A5dD89XhKXHAG548UoZhi6mbxDRZGBIIqCS5Rj1HtH
 ETQoFK6c3fWGOKR8RgEpgkFXxybvK4kZU_QzzbZrqLEUTU_oYiq6gWbkAr.Mnxx9Rj_JnXgeWPQV
 X6rB56kNsSzHSDigYu_WM.M4i3AC8ORY8jJUlhSnxtgWW3KEM7UGeWguJCkS1FarHQmIgn2RfAFu
 Eozk83EQ9crjn33Fws5Jn3Z8yvZkZv3.AToepa_wPXwBma5GPL8TzXB_KsLGo2qj1NXr8jVW_8pv
 gD62EC5cATHWFQDV38bDQ7Gpwe4gjTba5dQ3HYoGM8oQfN_g3BFQJSobjMOtDLgY9OYZGw9WmdCU
 ZD7JJZdCJurDdj_.GJGeqs3Wtf.AxohgetEh6QYceBd2iZE8jZ1cttsBLXqEQSUN5duO5pKJmt7b
 pGaMHLghZK_J7IIM_oGyv_o5yh6g4yu_oR5ZBXbCxo7PmfvT7PQyXMrU74ZG3OsBlN9nsU8qPZ6v
 AZAZ6.hksZ651QkUTFHpFusgDxR_ScxgjTzVNjIvewLKmWLyl8Ikk5eLij0ITF4NhTHx.ieq98GM
 FC0gBm.JNwkPw1ILtSjq3PoZnqdJfsWPCd5ESO1UOfUnkBLokYTbO2wiFnWQpeZ5YkOCxIQ6jFIL
 Atx5KKIbCPRhotvPL5Sozj7AcM4AEZNClXavqUgORiBvmwOYJhGWGOq13S4eL9DvrQLVd40BoolM
 wQlYDKbFI6trrs8IwBWF40L0ltMuq8PLwTaI6hQcn0UDYIXsYoKQom1jI.qcbNy3bxCgsfYE6OUc
 3H8iZ.yaqR4WntXGY61ZxGL3kkZLmF8wjD3GmEj9d3QLb7qqccDABiJvkr.qTlE9B7aEUlFPNitp
 iexWzwN8.3xHs_D4q7jKHrIWoGJeIVYT8KTgoyvFOgFjIVQktOSL_3g4cxLdj4Z3oFdsmi62zQfU
 2O.62Zh.Mo2jzvVQcnObqPvrXRWGl5URgxsH.eqYdfNnQS4yjC3OQjqWosWW7Bx01hiOtyZopXG4
 3pKB3XtPNW6Rau1pNqGbZgm6IbO9.Rho55QllYE_4zPDNb_23PuBusNqhEcNio87PlbzEVm6NdMl
 Ri9L6X.bqFmkqEyvX.G6CEuS9fDXksQTxDn1fotzj7YZ6XXj28eTBJfFgBg3_RfKIuMO_gAaIfHr
 zQ0rgd3KHRT4aYKOrKM5.4R33N7sFRwWv5SbZnYpuvfWsObVMz.g0WE2._lBRVS4FmEpOGFvKwak
 UXeZWb7m8rSW0Ys.TZH57aII3b4hl7bcwOLktj_GcExDUw2itC4641vc95i8QfDkW59I8zxfdqea
 RD.zjzvTiBvPgq_Cn.gcXpodpv5283wCLhVg.bqFkrouhYYCu0gueNL5jzbvAd9r5Jj52L890.hE
 nb59nzkRYfvtjIoKziSEvdNQ99hJExxRC1YV60qzLWWe1Ynk_oktMO7spGxJ_SV8pfzG3DfYeXnD
 rgB6zsaRv93QrTkgkt8c7vmYOeNgGPar0eo6Dr9cgY3xQttxY5WW0JAJ0S1sbhUEjiCxnOMs.s9X
 uCjzivDsmg2q__bmtvp7SD5gpY4BPp5B9sidg26V2V2JmejFXQlrO0x_8o4XmIc1E.Z1VhPEvCyY
 ydvE1j5RayZAMIHPDZp7U6EZ6QLXbEL3yJYmK98c84nXotQj8VeDAAc1FjzUiJgV5xVq7I4t_mfZ
 BGCNGA6jb7_.6zKMXHS9pzd5uCgXo7jZowB.V4GRunokZ28jnltkbeIZrc9nH.6hMs00x8oKvnGj
 qogw_AB0.nS3Qf6Tmyc9MJC7d5VdVkKpjcY6KzNvhqkFtj7_gz1icFH7GgF462EBQ3kPDqOuF2Qy
 qUmJIrKMJcm_a0aBvVz1QlWx_K19eJmzPD5eT8PTryCfKed9puxBA5rdsnvfxFd6T6d4mVAkLWme
 LMjWzhoyuTS6SGu97tp8XKCz8dAUyclNrAW2VDrggr6Tpmq4Q40Qe1uybCG_j.jxHR1PowZhY2cW
 1ezUX.sPdm30IHJqskt6fYWF66_RCLby0gUJteU4FcLtoO987W4UPLWQKfvxcAokbDr16
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:30:17 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 963fc3bd50f67d356f670f88d3348815;
          Fri, 11 Jun 2021 00:30:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 23/25] Audit: Add record for multiple object LSM attributes
Date:   Thu, 10 Jun 2021 17:04:33 -0700
Message-Id: <20210611000435.36398-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index 36249dab3280..481b26770328 100644
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
index 27ef690afd30..43a42dd2a08c 100644
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
index c3e3749328aa..a480b30a14dd 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -685,14 +685,6 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -700,7 +692,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
 								&blob,
 								f->type,
@@ -714,8 +705,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				lsmblob_init(&blob, ctx->ipc.osid);
-				if (security_audit_rule_match(&blob,
+				if (security_audit_rule_match(&ctx->ipc.oblob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
@@ -1025,7 +1015,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1035,15 +1024,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1270,26 +1252,15 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1432,20 +1403,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -1988,17 +1948,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2344,17 +2300,12 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

