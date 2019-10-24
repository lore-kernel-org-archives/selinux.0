Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD89CA9EBF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615421A4C
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oZPpbLsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfJXUxR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:53:17 -0400
Received: from sonic303-31.consmr.mail.gq1.yahoo.com ([98.137.64.212]:44555
        "EHLO sonic303-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728584AbfJXUxQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950394; bh=ztrsW58eaORni+YYagXeTbVBvEReSvWXp1BcqiLJ7c4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oZPpbLsWiUmP2QqT/OBOhZQ0eppeskxIsrHZEk+Fk+NpJ8DwDQhhGnwzlPynIuE4ynGissRsdVc54vXmBZT8zVqOm3pMIDqQB0wOrKnR0Z5TCAchKpSa//Ci2mYekZQmlz0+USecv3s8qdSQOsmmwEr5iqVthaJtTJgdcS454sBgyRc4kqEQVFcuzrVLPDX0xM6YK/IGXc1Mf57AY9sIz2GXFeODkQitUGtdsoseATgpJLE9v3BX+rosv0w065D7LVFxMgXDTxm7IfEAHkwUIT8Rt6I0dKyA9ve/aYZkBa2f0zt2bod+MjnGfzK9UVz5hGowJ0iBflCrEc8pU8L2xg==
X-YMail-OSG: kAYzWnkVM1nZXzJhpyZ6ftVfNOejlCme_xn33SSFF4Mr2LijYGdByowKfVojrtB
 SK6K2Di.MQ.NLf.IIqzm8PhPKP6TDFwK1DgA.5zRO91CC3VvRCSAbLcGJ1hyZ3GiN4wU.18RrgWj
 AzAZlk.kcsv4efIEuaj.EcZ7Tc8tdwNKvTrYjYJYUVlVosJq.fQz3a_y6F_j5U_pL_RE84mO.dJw
 i1RdGeIoHAx1VxldjJQHbo4WlFsZsqdNRI9XIbKa.1.kDdo.GLX2delpJGT8e1cZzdkQyyCza1kB
 sHR6MAwpThNhjKgclpap4S74umNb1X8eBRUXF1HcugK9.6awSuIseeDShaxIIpce4zNDl7uxrB8c
 4ojRMrj7c13FEq2bxqW2y2spwuLDeUUDITiwFTRxgx..yJ.UBODjvCBkhUyfsUh6_PjH_nHvHQ8v
 gKW2H_6ll18UiLEuuDGp5ZLGnehTKmvmhCT7CISFYHHl.8Bob9PlTXZn4Pp_TVLXXtvyCOe8DrWj
 92bMOfcA7Tx2Z9FEz_bERFMyjzPJ9XApXU9QrwPyQL.BrM2SQf3pI8l29DR6AE.kHPfZwQpYUekl
 560WhsJ0s5id5kB1zPae5jaMdQqf2v80VXc4j6O.hyhM1hWwe2Oji01295YVByiav1JbNTUZi5t4
 keB4eQT8Uqqg82IbIq0QC8G1nJtm5e_CY8RGwNFTUU07QAW3BWt5zsQHO6gBl2UxuWOGlMOituEQ
 2nG5FpMGPPqXCaqkdxHP3zbz8UZ9uoXT4qfQb8qYvbCEaKbKfF1CBaK_MSAf1ax5K9aijo23mdp0
 Q5hfzcLhlAP3YOueHFKqq81NBPXbsy63.eI8vORc2sA7TH5LVKfX174R3Ht65KycrD7Y3QY9o.Jw
 UCQZJEuEIZvMCgFmMeSCd1zHbuOaHY.5MZ7g64l4o_s4jrJUevztd3.jpY7WtLjCVBVVVt4Vjg3.
 W6QXI858s28JkwKnMzn9USgXq6T5JfRtSfGzMNxjm7WDiYwel3BzKaoBRFjfZfAbzKJcelfXxOlJ
 lHVUMVWYfcjiHRAkSG.VCpHDddb0.nKLcQrdib5iadyxLdI27iopyPpmGkzhT5TVXQhGqVx8XLWi
 DZCu2owUPckXDapxOnbuJ4FDPrRhlCFhOEQsUos8kxBeBMxetSZQJlBQB2sc_0yt1q3gKYNdqGX4
 .OQ5l2d7iLOiGHcus9ysUWgNfx.S3U13dWA99VvdoZ.hbgb_uLI4Ao55vYHDw2uvhKGZ.iY6r0w6
 ICm_VXXAkRhv3XQ7kvrshYLZtni.6fK8QIJdlf.yITv_ESKL9gkcPiWIP_cDtz0vj0X.Tq9rCWJY
 tdE_u3ylwnuLuI9UGRRc_miLVvaaYQiS4GmRoa4lEhGA0UZQaSlkwrOVKCgWRof94rkzPyaGfLIu
 aVZTQB0bJq.4CG1CPEu4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:53:14 +0000
Received: by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5303e37f81df37f0f883923f3f0a8567;
          Thu, 24 Oct 2019 20:53:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 24 Oct 2019 13:52:06 -0700
Message-Id: <20191024205228.6922-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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

