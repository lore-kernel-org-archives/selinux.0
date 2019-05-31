Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2510C28CC4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ACF259B8
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z4FcWqSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEaXd1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:33:27 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:41838
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbfEaXd1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559345605; bh=kBs6xavdKLksOJrpeyZAKYy1l7B4qvl4+o1ibk1YtLg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z4FcWqSOXurB8gTtxBUDQ/UeIHcoJxAy7Tterw6u4en/qVKBNswWGeEDQCW5rv23SKVI7q3alnjNcmTCnqsl6mQUXYAKLyftImRmtSr+IVSfMHTTsutmqnkl0Zbe2GOL71JKmGJWnwVrua5QZq+0A1ZAO8mpjpnOyjwonHTb1KXK8vZHMuvIbF8r8GW7CGAg5S3fank24UxCipU6atkG/XwNTITK/bgaAPh5c9jU5kvRwKl7P/fuxz/kY5aYu6/KQxiH3nCl4Xzg7Xeu/QugiskOEPPPBEN/q/4JrJtTJPRW7cRRmHWOuZXGBMIrF4L8MjBBh9W8xEv6VGSRXJJWtw==
X-YMail-OSG: _4iZfT0VM1nAg0H5aU2yYbYCxMkE2le0ZZKwHY4MuMV0EBwA3wnvyGU2c1lI8hZ
 JbZL5Tgy5T_aGrT4Mk5ZY0st4VarVBDZvj235KVyex4dPiXwMPBMBYzW2iOhRLBbJFi2BBnLszuA
 fk7CFcSVTVT40KufuXYJQINuoqSlDCBOtAKd3W006kEbtFqauCw1hGtYQxAruZX6ePFIwnmDIIE8
 r_n7vLvFUx0VIfPZzOh81Eew8.tGYoCyrCEqah656wpRBHqB1qUTWqBKzasgMCs1U4GDvbRGsyB8
 oRips1cEzHljLrBDb06LtJNHKlMxcxZwlJb5.IsdAwaOcaJ3jUcaFrHmUduAYH6uobs4r1QASuKT
 V7rmJ5zT7PKyB9LySjKGaNgECTW56VeEoXULCIhHwxcp3l1UV4dc0LmpkaYjMA8chlWenOR1fUuj
 Pd1tfXL3IpfzAbZvVJE99oMEFoIbf4kRjLmObEsO9JQK8zd9jkIgIZKkhrsHEbgcNCbgV74lrXA3
 6YQBNBKlqMpB1aW99ALO0LXETKPm1rQhWHvV7nOECbYGl3UcMM.FdrTwmFwV2AYIL0SRkCSo2qn3
 aA8.wykZUlSUQKYRrcbYpkmXEM8FHSjsVy87S5npZj_2q.zLQljosOm8JB3CUFU9_FUIhFywuLLv
 W7f0RBWUz.W5eGjjtpVa5tmxxlUAVawN8Q9Av7YRUesgm1dVJ701176_U2.ABBmBo7IQqEIKGojH
 hOOLgUGSbzvV5lhOSu.DnXv4gnTOdO.IdrEydmqyUj_3tbFr.EQzNKuCrmUqmsQsZZ3NfiijKt6J
 fNf93VOYOuJBIw.zZcAJVCB9S.ysuAaf2zKmU4lUFTuAFY9osZx8a9p6q_XMQGMCz9vDv93JhQ_j
 7tnFx7WbGlseu86.V_g5ThSdygkT.NPYxMA.H5Y0OetXlH1HGdpLPaC9bTQaANkMi5Cak9.2c003
 DYZS6hwCXMqY_i2HDFzvXcTIuzcLRk2goceIiYTfqHoo5MX8jf4aEUU7hxLh8CS9mm9qH3vRNaMm
 ccEp.pmBTlqG.tKK3xhIa7TeL30RWHKukn626Wc.4mcofY58h8CB9TIY1KbHU2cjCwXpMd0ITZFH
 8W2kdC7RYylMCl4JyikV2OzbXxaj3g4IS8CaJhvun85c3n5VfXNkkF0IQFN6xwtPUkHIhgN.I4oI
 9liD_..Dfp5nHDJ0HlvO6TK0jtJt_iqfa4yJH5.xmyiUNJcamLnnoYydJuxw9deX7Hz10f0oHjVc
 a1RKR6cfTIKhjGVc8XTHfwfZQqn8IOz3uMQ.nl0AXALlDJTHppw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 23:33:25 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp423.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2cf64f3b08f75107892893faae290b67;
          Fri, 31 May 2019 23:33:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 13/58] LSM: Use lsm_export in security_audit_rule_match
Date:   Fri, 31 May 2019 16:31:04 -0700
Message-Id: <20190531233149.715-14-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531233149.715-1-casey@schaufler-ca.com>
References: <20190531233149.715-1-casey@schaufler-ca.com>
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

