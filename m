Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB7C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CFB21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dpwL7HMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfDSAq4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:46:56 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:35631 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbfDSAq4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634814; bh=kBs6xavdKLksOJrpeyZAKYy1l7B4qvl4+o1ibk1YtLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=dpwL7HMRwYSuj3jV4nKSVJCka619XuLLuBNmSFlMc1r2/eajZH37p9OgntaywxiCx5fb3W9ZaTww1Z6offk3vQDJyTdrTJ1S2Xmv/dbYFMG2g8onCW3VOmEXEMagZ1ceCsnr8IuujUseM/H2Uc9xbGq6bcDPCsckHcwUGEjyJwDs+kGLdAo2aJ7IGxqHQ8McedOx25qUjKGk8PG3tMcCRhtHHv96CNfESDWnv523xOMDlPJWpGq55ujQhdx5Z/xua6EiBrj1Z/ovWbqGm3Z+DYcqJUMByvPTnvalF1RXPhUc3TUpDKPRE79bkjmt4x7V6NuunDwH3gEunI/1lFOfwg==
X-YMail-OSG: DBgAQVIVM1nad1uZ3DFtrS5RjMJw4duATAqe5DHHDn3PKcLUza9WeWnZIgbFFk0
 BMUf6M5vqsOP_ybeXqg_l5RGVGfgDdHFIA_2pyxYRTDRI4cSg4HpeFWU4CnvPZlfv2xpU..LtnVJ
 L8XudZAmCfEEFumUdIgBTCB5cKhv.p6v4FcL315ncoxqQ95gaWGytN4gW7BIEGYTZSY6HtF1ozKp
 UY5SbP7cut00V4hsNImwV5eHVnTZrTd3nQlra_iIhIFbBV1E4YhbYkurByOemtlQXmsd7jeWN.mk
 MbE0XA7yZj3bN7Lu8z2zhd3OdB3.Fa3qXXEktFbkccmy_7eF9SDCKnZ.A.wc0q1r_flGFSRi8txo
 vtj1S5rnCIXVSE4NHVolL6QCAsdSM0fLQMfiYADnXGVoLIHkhmzPKhy2tO5D12YExriTliLhGXH2
 hnD5hJ_1aVqZP6.ytk2WkJyIhgXT7z1myNw8AgRwK1EPkyOOmbsV25E5NeE1hmN2iQJ.c2KT0BIS
 IZyROEqK_GA71mUJ5Wfn2HjFzc02F6lnFt5p24suGThMaoQ6PLDZwI06W0jR1d891REqjNR_WhT3
 KjNgs6iGZqpZ5SzGcB.v3mS0SgiE7x1QFW29rdHnXiVojOqm9utkQswsys6pyv6LCKNoU8DPypoV
 4Uk8MEq.XSioupU.jixtYbfM8sKy0fJsWBhCFVYaIonc0EalXdSoiljpTur9bamUc7Ic3zE0SH2f
 fo1mxLhDFsvuQ.GDJ1nBPGcc6gYftyjEUwh64dv2mzcnz6aaoigh2vdwnUE3LZenoqbX2r6tFdyr
 m4wVZFMR9iTss5hj7uoPm3C9iXM3Ej.b1ZADWNwpWYNuDa00tGKQEn7geD3x8SviTBaBRdcedGu.
 mrWAkagH711S7xXNSKW1SQpyGuS_Y3xtDMdrClC8tonwm7rcV06cfDQhctbmtW0xBEeb4dRY6saG
 i9d4gH6P3FZTkC6rdt_nEpZwRDMt67wZKWkQHlchyfjMRA9Im1g3tstSipe1yhpIlKJzL3vSIveH
 3E.NjwQ43HbdYyx.tgRNZA7PvKGcjSi8FRJxyCQaX6Lud6yeiOwXbiE5pG6bfaDRXWJXb6Pshoku
 ZPYXwyOfjA9MRYQ40rCsrOmX1pPnpf11JZCRHofy6dZwWImrtPd3qublVdl6wZw97gmgmcE7RRJo
 uc_pKkX2AsfjYvQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:46:54 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID db33df77ae90d094534f9c2fe92816eb;
          Fri, 19 Apr 2019 00:46:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 14/90] LSM: Use lsm_export in security_audit_rule_match
Date:   Thu, 18 Apr 2019 17:45:01 -0700
Message-Id: <20190419004617.64627-15-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_audit_rule_match to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved that
will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            | 46 +++++++++++++++++++++++++--
 kernel/auditfilter.c                |  4 ++-
 kernel/auditsc.c                    | 13 +++++---
 security/integrity/ima/ima_policy.c |  7 +++--
 security/security.c                 | 48 ++---------------------------
 5 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fb19f41d630b..ea2c6c4e88db 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -93,6 +93,45 @@ static inline void lsm_export_init(struct lsm_export *l)
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
@@ -1712,7 +1751,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1728,8 +1768,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsm_export *l, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f26fab..15771102919d 100644
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
 						   f->type, f->op, f->lsm_rule);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1eab1d4a930..822ba35e4e64 100644
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
 								   f->lsm_rule);
 			}
@@ -645,15 +647,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsm_export_to_all(&le, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&le,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsm_export_to_all(&le, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&le,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -665,7 +669,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsm_export_to_all(&le, ctx->ipc.osid);
+				if (security_audit_rule_match(&le,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..090ef8ceb116 100644
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
 							rule->lsm[i].rule);
@@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsm_export_to_all(&le, secid);
+			rc = security_filter_rule_match(&le,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 1645ebe06715..1e819ecf26ff 100644
--- a/security/security.c
+++ b/security/security.c
@@ -712,45 +712,6 @@ int lsm_superblock_alloc(struct super_block *sb)
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
@@ -2482,14 +2443,11 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsm_export *l, u32 field, u32 op,
+			      void *lsmrule)
 {
-	int rc;
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
 
-	rc = call_int_hook(audit_rule_match, 0, &data, field, op, lsmrule);
-	lsm_export_secid(&data, &secid);
-	return rc;
+	return call_int_hook(audit_rule_match, 0, l, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.19.1

