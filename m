Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88678C10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FBD2133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SIqkzXkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfB1WT6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:58 -0500
Received: from sonic315-15.consmr.mail.gq1.yahoo.com ([98.137.65.39]:41373
        "EHLO sonic315-15.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729583AbfB1WT5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=unLxnADnjEx2xcS4blM8vSt5ZS/lErleLxE4yKeFPTI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SIqkzXkLPiwDKjsFOiCkTHd+ERGIRRONormJF/1hIACzHZjvqEJpEso0vGpJzqpPFwldLfQyL4TxxVbe/E41B7zvIe5ZqPkxlWRH8j1auxQse5GIlIXJHgH7hcBAnLvcEH+Sb4+P9jbZJrmNz/g3a0Cl1WnytSy5EESTrtIR2RQAwjeGoFQkp6NtpbpK60YoN9O0EwMdfuCli5oHSfPlPRCXVcoLlAfuZA3LI5gmf8TWg/YniN7qimf24CzCyoIJpzlgpyGstiClUw37uAu0ra2tUYPBx2GLANQZ/3J5gB8BcM6sG9Px6qrk4bcNv9Hp+4QnHJlaUdOoK0ogUg7CHQ==
X-YMail-OSG: MdDhCooVM1kKqJqRIRygiiuCZrTEXCFiVS.WSpp9dgCerztCyh4Ek4J_YYo_ALK
 9cgIcSnAkab2oUua2QRDU8qNKBfMSq3WL3ZDcjaKeJIiRcB7PR5JrdQtHMSncbdIjcl0k22xY6c3
 gtaUvWPTNqLqSyobBgtku0ZNER_LjH0FZ3kpfRPxuqFURcv_V9yD8HRdNEMrLC2hw3DVa2mqjgNb
 fWhIQMpi83WBXIC8xtLUutduUBS34oWUPFUuNmxDOsUmKbNFB5GE4GrZb7di8Zwr8OspO2IOfyMj
 U94VQd06bboN_llDOjsag5iHkykA80ntGin1g5IChluKLsBc2XkcdQJSHcSCZb50pSl2txPwqSF2
 RqZY3mwD1ceaLyfzE_UgJ4JWoXDkbuOJDzK1.H5N4O3Es4iU_.lqATVZCzqeK8GS4ZiYsCNbNpZh
 HKFXg_1zIJfFVJ2KkAtE4Z4Qb9hb3Og6lQCsf13SmIw0_AYuj5l3y6xczm3MUcz.c7Nx.pFgPCp9
 K6ZT.hWgG9ArVzSeokVbgifMXAuw5NJcNyvuvoiAgMRuO.Jp_l6Ysxcxncr9nZ.uGzyt97SyylxG
 oLtaHdIY7OS9Ew2qWT5FcOnYgYwuuEeXO4dGUTa_lD_8w.rczuInx__ux7U_scPOTnIYb_3pkOXE
 ynr6RsnZmlSGaw3UD1XIX7QZrDVq.zE6L71YsUEVYCNn7tZEI25dawKtcbh.x_2LVFqLph1Xdn.O
 IS__GXvTbXNKEzeWbZWU_nB6nVG.tdbJCzLHRNaJUrgIVV.cU8O2T98fpOQaGYfoPMK8eMjvmNBK
 D.b_lUdTnwxjGGQlMTyJLdbK6OxLLJmlbhic.9uzqyYaAb2dDLAMYkFDQuoCYIp_Tt3uvjNwP4qd
 GBlnHADIWP02x_9GrT_wvdlxpiBsJQ2d7zt9ONWDVp2ax3hmkDgBgQ_AKskXRl1YKsasoL_.fxai
 UNM3NvW6qq9tAC8IyCDN5oUO2HiUKbeDAHbEYDWQSrHIgqWQ65S93j4xMRlcptBFbGL54k6iTxsK
 ZE0wMDMuTlOStTFgVacukp5BzBnEc_ex5Db5p8ZLYD70Y56tawi3c9_Jp3mi2OSXadxIkvahrioY
 nZR0ZMiWnFWUmhj4zZHlAvINuRwALEFkPYefHENLKDr4Xb8k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 17/97] LSM: Use lsm_export in security_audit_rule_match
Date:   Thu, 28 Feb 2019 14:18:13 -0800
Message-Id: <20190228221933.2551-18-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_audit_rule_match to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved that
will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            | 48 ++++++++++++++++++++++++---
 kernel/auditfilter.c                |  4 ++-
 kernel/auditsc.c                    | 13 +++++---
 security/integrity/ima/ima_policy.c |  7 ++--
 security/security.c                 | 51 ++---------------------------
 5 files changed, 64 insertions(+), 59 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 785d21c81dea..73017c9e937a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -90,6 +90,45 @@ static inline void lsm_export_init(struct lsm_export *l)
 	memset(l, 0, sizeof(*l));
 }
 
+/**
+ * lsm_export_secid - pull the useful secid out of a lsm_export
+ * @data: the containing data structure
+ * @secid: where to put the one that matters.
+ *
+ * Shim that will disappear when all lsm_export conversions are done.
+ */
+static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
+{
+	switch (data->flags) {
+	case LSM_EXPORT_NONE:
+		*secid = 0;
+		break;
+	case LSM_EXPORT_SELINUX:
+		*secid = data->selinux;
+		break;
+	case LSM_EXPORT_SMACK:
+		*secid = data->smack;
+		break;
+	case LSM_EXPORT_APPARMOR:
+		*secid = data->apparmor;
+		break;
+	default:
+		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
+			data->flags);
+		*secid = 0;
+		break;
+	}
+}
+
+static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
+{
+	data->selinux = secid;
+	data->smack = secid;
+	data->apparmor = secid;
+	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
+		      LSM_EXPORT_APPARMOR;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -1696,8 +1735,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx);
+int security_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			      void *lsmrule, struct audit_context *actx);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1713,8 +1752,9 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-				   void *lsmrule, struct audit_context *actx)
+static inline int security_audit_rule_match(struct lsm_export *l, u32 field,
+						u32 op, void *lsmrule,
+						struct audit_context *actx)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bf309f2592c4..c784dfa9fa23 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsm_export le;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1354,7 +1355,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
+					lsm_export_to_all(&le, sid);
+					result = security_audit_rule_match(&le,
 							f->type, f->op, f->lsm_rule, NULL);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6593a5207fb0..5988f4fce7de 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsm_export le;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -630,7 +631,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsm_export_to_all(&le, sid);
+				result = security_audit_rule_match(&le, f->type,
 				                                  f->op,
 				                                  f->lsm_rule,
 				                                  ctx);
@@ -646,12 +648,14 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsm_export_to_all(&le, name->osid);
 					result = security_audit_rule_match(
-					           name->osid, f->type, f->op,
+					           &le, f->type, f->op,
 					           f->lsm_rule, ctx);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
-						if (security_audit_rule_match(n->osid, f->type,
+						lsm_export_to_all(&le, n->osid);
+						if (security_audit_rule_match(&le, f->type,
 									      f->op, f->lsm_rule,
 									      ctx)) {
 							++result;
@@ -662,7 +666,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsm_export_to_all(&le, ctx->ipc.osid);
+				if (security_audit_rule_match(&le,
 							      f->type, f->op,
 							      f->lsm_rule, ctx))
 					++result;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8bc8a1c8cb3f..72eb0efb22ad 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsm_export le;
 		int retried = 0;
 
 		if (!rule->lsm[i].rule)
@@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsm_export_to_all(&le, osid);
+			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule,
@@ -346,7 +348,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsm_export_to_all(&le, secid);
+			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule,
diff --git a/security/security.c b/security/security.c
index f3c29dd51c7a..43afcdf1e424 100644
--- a/security/security.c
+++ b/security/security.c
@@ -708,45 +708,6 @@ int lsm_superblock_alloc(struct super_block *sb)
 	RC;							\
 })
 
-/**
- * lsm_export_secid - pull the useful secid out of a lsm_export
- * @data: the containing data structure
- * @secid: where to put the one that matters.
- *
- * Shim that will disappear when all lsm_export conversions are done.
- */
-static inline void lsm_export_secid(struct lsm_export *data, u32 *secid)
-{
-	switch (data->flags) {
-	case LSM_EXPORT_NONE:
-		*secid = 0;
-		break;
-	case LSM_EXPORT_SELINUX:
-		*secid = data->selinux;
-		break;
-	case LSM_EXPORT_SMACK:
-		*secid = data->smack;
-		break;
-	case LSM_EXPORT_APPARMOR:
-		*secid = data->apparmor;
-		break;
-	default:
-		pr_warn("%s flags=0x%u - not a valid set\n", __func__,
-			data->flags);
-		*secid = 0;
-		break;
-	}
-}
-
-static inline void lsm_export_to_all(struct lsm_export *data, u32 secid)
-{
-	data->selinux = secid;
-	data->smack = secid;
-	data->apparmor = secid;
-	data->flags = LSM_EXPORT_SELINUX | LSM_EXPORT_SMACK |
-		      LSM_EXPORT_APPARMOR;
-}
-
 /* Security operations */
 
 int security_binder_set_context_mgr(struct task_struct *mgr)
@@ -2471,16 +2432,10 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx)
+int security_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			      void *lsmrule, struct audit_context *actx)
 {
-	int rc;
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	rc = call_int_hook(audit_rule_match, 0, &data, field, op, lsmrule,
-				actx);
-	lsm_export_secid(&data, &secid);
-	return rc;
+	return call_int_hook(audit_rule_match, 0, l, field, op, lsmrule, actx);
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.17.0

