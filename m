Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6723C43460
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E826143D
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhEMUew (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:34:52 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42443
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232977AbhEMUew (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938021; bh=7AWaAxB0PKweU7mi6NHi1EuujLQHl/tfii/ELfp3KOg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=PT3CXxrTA2C0RZygmJrktik1Pki5Gbb+ektgKTvZvwv5ISzLnagFT0wuPgtUasvbHY4N8yQyWEo+NWz+l1OVvnmX8iakLoM8Tqeyw/pYHSJq/jZY75I0ai77uDa9budRQtTFhCpvFtgcqHJRFtfdv6poHLgpgEuXsJ62yJvul6WFUuYYHbDKroUA6C4Zozp9ah/suWVlxXGUQ3xd+LEgNP43Wy0SkYGQR8FyrlKtxTMmLoN0eOWu1iX3DjDV/P4yBCp1tSYmZqvV59yiwfbSKMeP91VGJCtYnA4AwoNyKXa0NheqwMkpAbboxpqs10IS+SFc3VjnDSQYWFLX0M2pbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620938021; bh=fiCQaKYiWZAWC2nUv5KZOn4t/qLgHtEwW0z50qYqFC6=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=HSSPcglWxBQXfBTp8ikmKxKwBALseYEYJb82WgBsfV8j1D/Pl9z54u/2K7GmaBQSPd9oBzeXsscIUtINtqIEFnovf6wUEN2+XW/JWGBQ3Fso7CTWZI3wCV6GK8HIOUm9EhMSQUVEiuWbSeG50VW9xQt4NTaH3gFC0nsbzOoqaX+GZsyYfJ4lUiBzyZ11RHI5/szX6YhKJ6GaP7IE26Zhsz45dcKDOQRoUJtKQN3OMXBlnS6hyPuPFbZQ+3iS9kZN4uk7MxVjnCfJ59bx7IyTzX87vNP81N3da6cIofIIw0hJhNlKWw5yEzXvxHgAMjinTG8HQLw6p4+A/jIa/CALLA==
X-YMail-OSG: UAp4DLgVM1lbWvApswB2oghFN6xC4RElwTXWKCnTdHsVwqe38eG9tmeR1DmVR6G
 wywhnX4FdSZCIuFPhySSk4Q5YDFNgVQuF668BRBHQKxHjyGF.hcyKbxbx4vu2AOStdOAqK5Bcufx
 Nuwo0HjFIvjlWrPax1O9_7jv.1GfWQa9njingSNCPcUuaZmKsxIb1zG5.k5yWAX0hu4ptx6O8KPR
 JZyORmqwloThfk3i_h.bvi_QPyxFInr0JDpflrHstoUEGj2_KpRdpiKXO7x1NOeoxiN87usfe_yM
 ykDjMIXPot3lHvcowUzEA4vV5LJRnbZEs.dXb9Hsm9clYQDBKh_j7vDbf.fzERdZqz59jNgDCq3J
 wjUllEAw3TZSEk.ItfaXu1jWtAp50vhFBKhktcYjov46cNBS8fYUZ2j3qyS.ktdrfZCATPvS8ooq
 XVijYBeQtUJHrxhQaN98dgWZXCpYp25jjrhbI30glfRM8Fk5sx3aucZ0ZnjeW2pCmiYHClPL.CY4
 kePoztzBbju8Z0IK0YlW0sarMO.IgcuJKNGPkZGdqlLcjUkPHTuQ.2kvMEmhtgR_VCMQ4cJMYTf.
 SgSX.xY05bxxbUMR0nXIekEhH1rnxCwJOurOK_s_SihWPoiR09syBj0K1BP.w4SB7qQCTwS1QKC7
 cDibeUVBgtLjUlYaR9g6Rw_tEWoBRnm6jOGMCFrNfotQ5kuvURKirOffJir4.8gqnS.ByxnGKZCi
 vxLERufrah6zyGPH8xY4f.UAZ_Mk9fek6837Jr.Hm.gKKTIm8zqZz_7LqlGBZwndy2bla07FQm8b
 egyKzhU4GWy0ihQcJn8xo7.FiCvxWVLvroaVQ0kiC4WJPVZI.Q2E5iWhCQhfYsWunGMdv1PG3kTP
 _W9LIbb42u_DbNlD_13zoXR.uRfqyWGha62FnqWenkJhq3ZY89Kdct1H3ir0oXFPycllk3Uh8h.Z
 gYyy9SZTEkZOLRuFk7AfvM7riuIr1tPQ.AywwwRr1AHUK219Ed9gwQCyLprBUHTwuIt6xBvmpFD0
 f9O42M6bP4t7jLypSuZH9dj3GaaOcqwg.c4N0ULnNOGPK0Llzq9IAIpbGFpSUKzAM2xXTO2yWozc
 BDMDi7X8O5ch2BkbTYDcRvyRKME5Kt_qLlL2uEDaEyGpR7jKD7KYV9Xv_wF5HNkZ0R4OtXgv6YTx
 DG60g9At27rello0Hkjy2E2qvKfRtZQYpV1jKSz5KvshT3losIgK1ozC.rYq3AH7NJELXh2OiCb8
 1itWCShd71oEXvAroiKbCeD1I212ZvMnRCQOC7NjgVTMEk5HSyB.gWnKbcm6hQ8OHuiRv7f5jBwr
 zT1C3LH4SyF4WJwGlMefufc6XfvYYQ0hjHM9p3A5vrMJmUzQym8f2N7MrW3tE3g.EbenDIPTldEa
 BoTuqd4ntEup.58yuypnAXMxQEbrBGa0A7JzPRWkCCwJS2zKQzaIfn0fUBtK.CcuOhGSZOIa2luT
 GkiYakUYLLwPxzSc3dfBw2GESZwC0VIQ8N8fqBDp5lG2tDBhiPyZFBW8qXgJdMPj.C3.oemYiFU1
 UdIgIkQVR1XF7iUoJ9bqihfzYFjFpm5PktYHdSLQmsNHUdMDqwRsiwH8S7pQpvElauHC34guU3OL
 0T1nG.cyuhPyEZx23M6yp6gByHFM92m2Zeu1iwDAyzGNwPJzVby0v_QVkEQqGXC4x2qw2SO7vXIg
 D7dgmXQgXqbNy.S3DdaSiU.QQ3Dpi_BG6I7rUvGYn43W9kKKKlKwQT9n7PdH3QiKqLPlKzrzccml
 YVwaFO.4iIMDWRMMw3JeqdnaOM8w2Ex_GervnHuj22dt7mmfmATkZP4OS_iJRVwGniSqmSwPu7AQ
 ZceahTGmJukAzkhn9lghQAtM2Aj4MvrDH0tb1fOGkJFPjb6IizmFRGU4o9fTCATBM0nPApg9SnE8
 XaPtWqdNI7D90Uhd8ymg4SlQ6W6ZyqFjqPfpJF5Q07Stt8.4sP80_tmSS.Cybk89g.CLgVGKA3TG
 60eGjGbAOpQRZI85wyg0PYSZjty0Nwaz8JbOcu9HxKj_0NeuJjKxN9YuxCiMtHAaGgbk6pHnOfWI
 pF5AdmUlglfl.Tr_ON4rpdCM3RPVR8HZXvU_.s7THTtZdGvRJe2aEAC1b0I5ezOLKmTBdMmG72Ap
 MoTxu3rsrhw9PmM0A1U0TDds42ZuPoYKZyxt5IZTJqVTO9bWE9OGscUH1BwIk.eYRnEk3XlI96KU
 PBgOBaOYax92CltW6ufv5Kr1a0wFPoVnDrH0wtgBB5zUqVi1iNoB47MokYfsKIIdJy92xMvJA.dJ
 slPlLtwZST33TyaGCZ0vI9euowpuut63igKzqla.tMbKBE1k9B61DJaqm81chWhookseSm7orw6L
 IUIQbFmq10bEeeagElmZX25djp8spEw6BfCdsMYJ3brfqGwaYpyWlrK4_LI8ypEfBb2vXH1J82dG
 XeLjrb2IJowDQD1YI7lLG2RN4lRWC7YsksRSBzGGkN3nH0nWnvonP58Oyl8Yys5.mxMeRv16zmrI
 no7EBvW2uCWOMcU3eTEX62T4YHqQtncWUMwHvqP4Qm_USD71iZqWME7Kc_6gFOwbDCmlfRfKPVX0
 Pfjl0nBuiUg5n7suubY0CSykOBbWMIwduqNJtZkBBflaEfO.xhB7DOPp2SdeVucbwhUhKGKxaPg_
 jB8RTf4SAGjnZKm4YkZCq5un5YQ_w8TtbfnCMMNeGiUpuwJmA7SpNyXloxUJ4Qo07iIm0Qki.nK0
 3i0a4WPilpE4p7qBGLEItjIFk3FDZe.5QbG2mxU7Y3gFvRyS9Tc11MRRVncDB57TjLA_8XrHA0fN
 2d_DsWVLtNGBhgZxyUZ4gpnJ1dwdfxWgL9wJ5zcn.ZHI2ObUXMMzk8DeHgzAPovxwYetkJNvuj8c
 1b8PUGVDbKVnUjMUnKTZ54yTvr0fe4Z8JJwnR6edq1LqaaFrt0Em1vHG2bF5sx6xF1vlVsNUROtl
 SRt6ZLAClQLxfxx3r1gtwxDIQbWrr9z_Cn2TTolDwruR7sNA1.K0CLHOLlnozDC8UlOvQVdIRIWs
 1QTEGC5Qq.bWouRIbKhLwlo334qnflzCRn63LSLUgEy0QqYPuivaOUVUbQG0B3jlrBT8uyJP3sRi
 R
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:33:41 +0000
Received: by kubenode570.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5fc27fed877248912438810f41a118f6;
          Thu, 13 May 2021 20:33:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 23/25] Audit: Add a new record for multiple object LSM  attributes
Date:   Thu, 13 May 2021 13:08:05 -0700
Message-Id: <20210513200807.15910-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
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
index 60c027d7759c..5bef8227c526 100644
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
index 5ad0c6819aa8..952c7a1f2f3c 100644
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
index 55509faf5341..71d5da2f0ee3 100644
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
@@ -1026,7 +1016,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 struct lsmblob *blob, char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsmcontext lsmctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1036,15 +1025,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1271,26 +1253,15 @@ static void show_special(struct audit_context *context, int *call_panic)
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
@@ -1433,20 +1404,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
@@ -2034,17 +1994,13 @@ static void audit_copy_inode(struct audit_names *name,
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
@@ -2390,17 +2346,12 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
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

