Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8028AC32757
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581152229C
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fRyxvKE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbfHGTob (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:31 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:46061
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729960AbfHGToa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207069; bh=CbZU5iRe+yH1VCf2y2WYC0jsmwdjRjXMBNn1U3uoaKg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fRyxvKE52VcRh0Cklxveqx/5FSj4hHNmxFJyyEhNmsu5whLFjqjpmegKknBYEAfzMJUeFUdHDV/MvBlprupoUuEraXAmlfqHywy3AFJ9Ra/nX2veAv1gLHCKo48qpnjbmotmUcsxl61icxiSpoedXwgHWNUFcvtqUAZC/A6zPsR0XrOV6Aw3dQLlt0gIqtcPUvyNtiqPJEvmmNoVt8+AZbB74M9dadLULjWZKT+2wFgXyLp/ydgLJG6k0X0WwmrDQmlWjxB3gGsshWbcNLQ24hnfbCXXdNajz/1kEPK9JT51JqblZ1yA70Q9Z/Vx25Dq/8ABu70blQW6fvtpJPp3kQ==
X-YMail-OSG: 8E75v_kVM1lH_vLRlFPFSqjDsHsplpmM64Rfw8TPuOy.tCT1HxFGB6f_umoLzCh
 c.yhu3pOEctSEsncsCwsspCX1psbhqVkIDstKJLS3b6MHT.GzMtdvRKVCu1p_jcERqveK5Vj8ZRo
 q2ONI2XCaZtqC_hN4QMqKV.OlO4wsIFCE6Z4koGWa5hloseyVN2YA3traXXWxl3GpT57HAQX0ssG
 xv0fYbDpiaDRZbM5mv8qx0cAE3XidRA2uGJhji1o33kPxAqHTUhfZ_FkQolimbq2hE0xclr67Kbz
 O__e2arsIQ8vrWXDRnwUEiTuXLLgjatWa1OtZ8M6amzq0Cf4IH0BpT9JOevuAEGDvRq8DzgfBcbU
 JubnV_lFWxdaNnfLs5g.7_puDb6EGv9hB5vv09SYquWlgDly8kzlSln3vPinQ0F5butaeXxemFMJ
 Gt4n5cNeX1BFtIimyYT0IrdGGrP6ee25hGRAmChCwdUeU.iIrYK_iLZiaQGPT4mYwpd18fGWEwSL
 QuDXvscBO2HZF3Y6.kSCJm2QbZ2yl29YMPtqzVCOpmpJlK1ooOOD5cXgL.t9dO7xaabKm7fE4rBI
 kenBkm87Gi8N2y92kCf1aZKFEmyd2f0Hw0Nt5M16JHyhdMxvls2RTB3hZIDBcLB2_DSPpKYl6S1B
 .z_QZ5gTAVwnW9Ex22dLfH7q1kBJY3lPEWkRuKHuIjbaHTc7g_twwGMm5Dl99pxZlC_p4zbfVnAO
 VyBsTIoR7XXmQgd2TKv4DT2YwDmmgyGbK0fQxmGNfVIiRfMEOxpFalA9xzRnPbHjY_sQ_IPv_NAz
 zKFy1cFFK0IBetBFQADlCeqVU4tz7_qeV1VCsOWrckfVUg3MV0sMPVWuvTRsEnm8siVd1Xs1W9Ib
 LGLL_k6EKMREtwy1qW9U3fHRLnkMKb3jG.ZlVQBtyc0S6LuhxQdmRLNBHsZSUjodOYY3X7nNVtHD
 Cm3kiJ8ZAIR3U2IV6pyTNItUYHoYsjiDQHqtutqgwKMjWAFmMzn7HljmJfzSvujvLUQbdfppy5Sh
 fSJ1fg7lQuqwSy6Pe6xL4t_ZEl1uTyrV.YbCFPTUXNcN5Ua2PqwkTJJf43Dao8ESqSPSIOHpbKKP
 zUbxS9dwIMmlY9E9zmVrKM8bDnHU5h0pNJed3.Io9u43YXQk6l3r_eRohR8nAxBMfMbiO_4usKrt
 uCImzqJ_G52BA6KWCQ3h59Ki8Ec8FLVIPLC_WrXPixM.zDEOYFNjuTDBtFgPvh4dKXpazoGZpGe5
 .9MA3VISJ_A3ahSLt3E5cng9Y.FzJiDMuFijqazX0yO09iBY3sXNI.jA5SSIQrUbpqdA3X2qO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:29 +0000
Received: by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 58c279a944991d666e27c38577be4792;
          Wed, 07 Aug 2019 19:44:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 05/28] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  7 Aug 2019 12:43:47 -0700
Message-Id: <20190807194410.9762-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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
index 5bb8b9a6fa84..4f8b478bc3a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1761,7 +1761,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1777,8 +1778,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 27e2db3d6b04..fa6e425e6f29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -424,7 +424,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2433,9 +2433,21 @@ void security_audit_rule_free(void *lsmrule)
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

