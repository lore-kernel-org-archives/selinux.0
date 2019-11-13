Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365DC17441
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F58206BA
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aVePNCAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKMAAr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:00:47 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:45023
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726953AbfKMAAr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603245; bh=ztrsW58eaORni+YYagXeTbVBvEReSvWXp1BcqiLJ7c4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aVePNCAN3jnC2i+trJIIz7Y1LbOlt4kMyeNto5yAEiLTUmbmFk4AtM+1djYNCfB2AKXU+hVjQuWUXgsLAFkQKWKa1Fe0FfrUXV35wD59B2dRa2V+P5meFne/oZTeqMC2o+xHHyjXWH+D9qajag9Un+VaA+b8DXOReqImhD8FZi7Gc1pkSVsEN2PQHDXr539JZmBGEA06c8vtSHBU6uT2hOOU2qGz51oVTn1WbMh3J1SoFhTw2hQA73to4jV1y/BGVI7O7YlUMp8KU9tHo8ksMlFR5iCHNtnaO/Yl7xwKAHhQ1ip1NdX5ZU/1IUdJdpu3QMcyvBdS1ymvnw85XQ0aXQ==
X-YMail-OSG: 7ZNscZoVM1nZEFPKkicORkvQazI6YyvrHnM5B7erKGvgBMtIAGepdPZV5cWyhaf
 1M_07F8uXTyD6X_HU.EyCam01DiqkX.W1t4OmIAtvsUjWitoMjMvfXrUknMrLADjyI95o_emv37F
 3f4FCDykSN6BdYyk189j.NXz1Mz9sQmOTLqx9Jtbf8xIwtdmOa5YUB4Up86b6qEPHkH6ywbgvf96
 ZLn3TeGwOV5cvpPXoWSSbhLaf5DIZA9XxGHhTK76PmzZD96..AoIDth6GPHycxn3TOoYZfJaih1I
 fUkuTo0AydrYxP3vK4WCsuAq6LVNKcPU_G6Q0HuKtwQW8GMarfXwNEig7caar41jpFc4HrqM6H.j
 pya33tB7JH0Qr6uEL_8Gafx3CMsdASYGGEG.hcttqaUQ9dEMQmmDSIZQiLWhfcdwYFE0ooK1X_.L
 y2o_qe4iyNKTkpHZNJNdUmJ_lHBLapIo6gYrDSXWY5hZfpA6iCLw9SET8X42zs6eh8lYlCn1x8Y3
 6Gr7GlXApI3Dj.dSXwqL4xTbyw3wVKn2lN65l6iEIPQGbZ1CryIknMeWKKoTuq9AeR1ohceYYVAz
 ARIqWctzeTC35uaQA3_L7csCsmp8IlNbzBAlHAI0LQHy.t6DNAd9jcLlLSLCmfdDVj0_.soDkC_1
 1XMtdnvteFYybUKEtK18XDioAlRvd_rM2Acl9IQ0RDQk9Qx3b4P.3TyN_Rzz2.ewPbdHSYeh03GM
 NYBdnIom7NlgiQcQx5duxi2ThNXuGV2BS3mGh.F7lAZjq_iqYGnu6llZy67O12SF86l7UJ4OG06f
 BxstPatCIhy1_XgVWHbnpuXPr16xZJ.rpNJCmGWqteG.u3nr0awK1v7iagVViZZvDIZIzxY_del2
 WN5UNpiUd6znhGSvx_uP4UtXKXcSZ7gp9Lgwy86bf7Co6lDjTwTgRB2fIBm6EsqW8tBFobuBaFRE
 Szc0ykYrSDYGMIuolLQMuArLt83EEQaD4PprkQz3l2ziLs6lG1HswKeihibfJcehNj2lE0HM._cr
 kYe1sJHqhusDfwa.HNwfgMNc4Ob8EncCBWA.evpK_cqS_NqWvPd6LP8qyCjpM9B7PmMbozr16fbc
 jy.MKK0GCVkNwaiLwj6p_rPqgopsMgwaN4lZ7DQpKV60N.dRKLDX6bmh150qtOHiJpW91qZGTzKs
 d4EtLyw0Mqensr1HVSVhBUSvpV8obxWIFHqVdNJMPjfQ8fondgXfuImcqVyOYTTe0o5_u6YPV_Ui
 9gLdtgiwGITbvdjE4DD56XmiW6lr3PSVH_qYKjdvq.b5UGpHH4EAopvHf9.Gk8PhZmNy0OCWtdul
 kcfQawb92vUJnTtIc3Y3LYzJsm80MI82PJGI18.mPvdt6U_LyefkEcM0am4Mb9HBQyJGOtcoFqe8
 _xeB.N5il7.8bJ5_lPKwr.UT0Nfq5yWqXdgKNYzCExFGr3Y7.Mcab1CkU8pJ3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:00:45 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dc9164e8ec7666abe13209391dbbba67;
          Wed, 13 Nov 2019 00:00:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 12 Nov 2019 16:00:00 -0800
Message-Id: <20191113000022.5300-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the secid parameter of security_audit_rule_match
to a lsmblob structure pointer. Pass the entry from the
lsmblob structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsmblob instead of a u32. In some cases this requires a
temporary conversion using lsmblob_init() that will go
away when other interfaces get converted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  7 +++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 18 +++++++++++++++---
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 260760a6f6db..c22fa5bfaad8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1753,7 +1753,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1769,8 +1770,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 63f8b3f26fab..8786b95b60bd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1354,8 +1355,10 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+							&blob, f->type,
+							f->op, f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d1eab1d4a930..18ee5556c086 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -630,7 +631,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -645,15 +648,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, n->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -665,7 +670,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..5a337239d9e4 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -307,8 +307,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
 	return -EINVAL;
 }
 
-static inline int security_filter_rule_match(u32 secid, u32 field, u32 op,
-					     void *lsmrule)
+static inline int security_filter_rule_match(struct lsmblob *blob, u32 field,
+					     u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..e7b8ce942950 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -327,6 +327,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 		int retried = 0;
 
 		if (!rule->lsm[i].rule)
@@ -337,7 +338,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -345,7 +347,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
diff --git a/security/security.c b/security/security.c
index 1cae4faaa279..8fd5c8cd4f50 100644
--- a/security/security.c
+++ b/security/security.c
@@ -416,7 +416,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2363,9 +2363,21 @@ void security_audit_rule_free(void *lsmrule)
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+	struct security_hook_list *hp;
+	int rc;
+
+	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

