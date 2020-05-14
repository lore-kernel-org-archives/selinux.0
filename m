Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6360C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90072065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IZYh5k0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENWPQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:15:16 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com ([66.163.190.39]:44708
        "EHLO sonic307-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbgENWPQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589494514; bh=/H9fByMfZik97ycdfPp48EG3y3WCtKUYLiCBXyQ8jZY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IZYh5k0e8ZaF40KigzwOHUxQbkPjm9VuWAxIZpu0vYvgcvlXN5o19f+a+7JTef5Qc3dRgG1R6V6U73pbZAusCK38MlNTHw+YnT4UNX0X9tV1w7rjwwvfv8WaZ6E/w+KyVeX1ksgouYgUJ6kxYljGfvd0Py/ro7lh3quq4L+9qXPE84tW9HiXYvTWbG+BJJfwoGVpIS+wz8dxdKykw387vZAr3NunCXzhLNfZU4xVbeXZRhOMcpYmxcpSGdBpUnptllnaZcj8/JMLDvAHpLhYx1EgFtIZl7DeLrDtKXjfpAsnoQX99WfdPRmUB9Rnhp4PsZheotgBGSK79L8Fb+fJCg==
X-YMail-OSG: 1uDkwhEVM1n1lcF0R65LV0aBgqL5BgyX6Ser7c6xA4ArIHypYRXPtSERDK.HemD
 PQqovqa0FcgjhRH544zqta_qEntTfoulNivwjyYEEQnwHmJdqnnxxzA.Ha.ElOr62b5GRn47U.W2
 psrsVLjzto3sVqw5IlzH0xkr3Wma949ydOG3KODnqRPYOKlkNyVKCopT3r2qgV51J1AMdrPBn86n
 BRA9acd2QIJwYQwu5gC8A27Fu6LEyRtKlNI.E5MV4DEZ84TF1X8h51RyZ1LI3sjEYiliscboirOH
 xm3B6FadwjZQeNQeOAvSZJjj1yKzWxzsQi0D_yMEvE40ThPr4LerktWmmsO7Bln6ND3LasJ_46al
 aMfGeGm3KwQGBrAstPruLQqFUE7Fmy9h1EW3IrVc.c7KFgcqqKw8aTBnB9GBXPZHS.fJcKcvSn1p
 VtYlo1Wknt2Oc3TUP8AgSwg5GPaeY.Qx8wgyxexwnObLqu00nuXJ9BstOsVX_MD2U94VyZYZkQ5D
 4mlaBZWZtt0BF4VdAzY7ZbJ0DsZUWF1rZlgpvtusd2RXcVYVtOmp49bPg2jNISqZluO3BTh9VpS9
 VIe_y7HATYG1Mkm1Q2ujbHNDdMvN7T1M1rSwteYDlThINO2BCB6RmrzOltl8N6ufkOQy_RFvH5tF
 fuYD59zZ6tgyhp5jEAHQdUetB.B2HWN353RSmbw1NVUbbMR8YL5xDW8lGx2PWP8gVX.zNm7DHWWk
 DGMhFe3rdgr.nvMyrx3nhgk.XKx1a3BoISvES_PXHSOGsoZClnUPJwSwgX_xRHmAHCxZBLwYtKGc
 CLG9vaFst67Nwi5wfmPPs1fYaZNCwOcbJeUxL8hFLCpXy82tnoeEMAA.iMCHJxjp5rt1l2r5lpHk
 WHtnLErFllNalSV8tr2FWT9pCJN6EDvim2Gv31suKSlSmp6LhG.61nP80Wqcv6yNqS2t.u7lMwde
 QNdi2bciLv4a5EXteicuov.UkBX6IPH907w_8EhKxFWmTWZ75WxYC8TA.7.zi2AzWDTJTk4dHaWJ
 2e.GVGQULLy_6PeBoRSRYgjFP8uiXKc2rOuRNoj5XWio.axMqvEJYGi5qMjIjKu1lrO7SxVJn3TB
 mTHmsSwHk.rmMj.nt8nZ4v_F7D7xhvjnsgrzo8GLq8L7Ctns.f1GltOqj1wXJsLM6xDhjdL11jnQ
 nbmAQg_O.5X8EkYRP_9CPwhDI.U_h9Jz_6lhLDM0MKdVuYEkILgKQ7t.gCJqbPIvy1VnqQHIsQGn
 p2C9cx7Nwg3DYeaNs9VjUMJ8iptz.keEZy7BN0kwz8CCbQjh_w0CbvRuBpOcd8MNBb9W_g4OexnC
 Fp1c6dprQFZmJqnodx9qx_jUolb9w38FZ19inr1EWQpp9HINuAe4wDX8wjd4tdfIAjn9WJ5J7nfL
 TMG8_FgYf997wA_QVEO9cpjnvmDwkzCyNfJs0PD7ib5bddQnhmUq9_LQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:15:14 +0000
Received: by smtp405.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c05acd8f7c5bb2850db99d6d8e7c31a6;
          Thu, 14 May 2020 22:15:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 14 May 2020 15:11:22 -0700
Message-Id: <20200514221142.11857-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
lsmblob instead of a u32. The scaffolding function lsmblob_init()
fills the blob with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the blob structure later in the series.
At the point the use of lsmblob_init() is dropped.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 |  6 ++++--
 6 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 94e90d7150ca..ad8e29486ebe 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1838,7 +1838,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1854,8 +1855,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void **lsmrule)
+static inline int security_audit_rule_match(struct lsmblob *blob, u32 field,
+					    u32 op, void **lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 978051c498d5..542eee7ad882 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1333,6 +1333,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1363,8 +1364,9 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_isset) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
 						   f->lsm_rules);
 				}
 				break;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 03cb9841d1a4..c4f718fd858b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -445,6 +445,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -643,7 +644,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_task_getsecid(tsk, &sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				lsmblob_init(&blob, sid);
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rules);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_isset) {
 				/* Find files that match */
 				if (name) {
+					lsmblob_init(&blob, name->osid);
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						lsmblob_init(&blob, name->osid);
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rules)) {
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				lsmblob_init(&blob, ctx->ipc.osid);
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rules))
 					++result;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64317d95363e..f9e3ca96fa52 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -408,8 +408,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index db6b62c5c035..2c1a92cc1bf8 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -480,6 +480,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -492,7 +493,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&lsmdata, osid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -500,7 +502,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&lsmdata, secid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
diff --git a/security/security.c b/security/security.c
index 8d92c88d0da5..11ff3f3beec1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2486,7 +2486,8 @@ void security_audit_rule_free(void **lsmrule)
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2494,7 +2495,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.24.1

