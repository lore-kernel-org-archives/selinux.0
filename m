Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9826C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840442078A
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 15:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fFC7nUrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHZPEw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:04:52 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:41340
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726831AbgHZPEv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 11:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598454289; bh=jHFjtMYnerRhY0vaNMV4cNEGMxSrJDDpoJLKkxgNgqQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fFC7nUrVRnFI10xbhxrWgyBsIr3XIYjDKvuPRoQ7rlPLZGu2rYrk3dVPDOE2aiPaQ04Y39pfaazJz+qBuOVGyldlJ9RkU8pBJLTE/r1Nlxw6LLF38B8omCjdZDa/lh//3eR8/oHHFJTFKFCSjATy2Wxrkd3EFfwO0cLSiRCY4H4vvJ1SxP6qQtdaoh2w9tXw4nHmfYqYgXArmiR0RcgrFEW/5XnlCsfzEF3NsKzDJpn6r/QFX3yXgHPgxzJt7mt1TCXgqanDXyTTwVCkuTef7q+XbAfalhCGhMH0Bx5MfD+zfqhzRfaa6Mv4vYuz00QPlLNYoxtL7sFdaUpg9s7WWQ==
X-YMail-OSG: ukJq9ocVM1l18pqPCcl1JxAowAI_DhnpeiG3cvwTHi9yPrNsFx3fAy3gg6JapUH
 7ftKwnj_VUhwoGWVr6SJ3EgoxCy5NNSJLH6lZwg9CjrOkLLMCdlphn2yGCHP4TwA2WZ.PtIqGQsi
 1frIpEQ58CnlAmMHxXp9QQ0QF3BREfMtX4o7Gycv.6tuJVcIPO8taAXVzOTKeb9LKU790yvDyPOB
 Lrpl7dyByDpaOfHBIB6ZrWpiU5V.q5Y8z933UGYQ5jFQN1KbCBhDbD1t3aaSSpVOGHHFb6NfehXR
 l9f8AFiv2hZoQCZvkKHi.uC6UPNy88wP70MxF14IBFjhbxoylHoKQo2DEXdzZOhyOi.yX9F7hcWw
 msnaZ0qrzA3y8PdCk4UUV8q6nNX.draQ0b42g2tasFVQVM4VgwSS2KtR2y0URLciqgiPfDR82hM2
 U8kQptpSctn4mKHj1q1iHC8Pmzx_Ac5Cwd0Aj5wWs19LyrFcFXfr0h5qHra1F4EQotGYNSWCT_Mt
 Xh4in2HfNWafOV14TIDb4xqASqcpUB_Crkw3xhd1wFreZtz5X2bA6GJw7M24Z9yPpHujU4JuGrJU
 hihtVv_dHcjQdIRg3CF1hM15jD43kKqKM9bCc7_vpLZFd.Nazmm2LXO_XSkeIW2JeNxlB4rgIyvr
 odfkubSk3FW.wWcibnbblqrAe3W0I_NqywsI0CgwoA9s8pRJSr4nC55PzEAbAe5Tq7f0Ea.RFdrq
 sEPNykHb55diaC3wHic1kMghEIK3sbAHR5COA6DscEcTvnqlr8ifrh9DaoSVK5.xriSA1aFYy4Gl
 Zj9iy2eXym.tshyT42q1tNU8Qxum_5PRmp9XaSagbTnSX74m2piFEh42PlMQ0M6i.0XuKvIw9Yv3
 dB8t_Z5RckyAAHt7sZbsZ5eD4IYqUndhho6Wg_QAeG8D4BvMxFCQTBtVm54XnTnilbHUucQ5Fl61
 3t.w2EG9xd3tsMCVn5xy9Ua5Hj.zM7_CrrCH_C10sGVwr8DGGpFjUVlS7BM5kpM349rE1M2w3FRw
 zmj.HcJKV7oVvn5UjDeYodjaRRWg00cv.B9WttpxQexme_wloG4IK95mO7Qr.Yjbn8V4g3KZTzbL
 PtgQXwVbGr84ZC1E7Kf0EjOl.qkUw5cJs48lTUuQjtHXtch7HXcA6QbniHWYWOFNx30GRFjWFwIL
 AjK62q3tF1SHyrcNTOW1CnGWpDU4LcDEJHkhRSZ5nvOPHByconNPGjTgDljVnEdVkULKeq0dJsX9
 QV6rcrfcYxKI77e2v.YwN0WMIWjkSQmEDGsq3ICChLd21eNUF76aAZh.s39euoCNTEjE6d7KTGvb
 laHoUgcq52AI7U1wuWUrWOz93yQLWkHD03RXi3T9eLKi5169MBbnHiffde4q0GoScsVGTbVCSDtl
 YPRZAWeLEFpNuOPn5211moHUQxzjjS0UDD_Awo8JPm3RxH74chY31oC6Gcs69YO012S8lF69S9qu
 y7gvP_HVUQakmHeMJZ8sgsojockd1tJ.AY0vnAEQi9DxVgURiYg61WBn0gHekGzFFRSx.qZymkZc
 B1xLhRBCQqGMuMVcL
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Aug 2020 15:04:49 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c75e18f21caacf8587eb91df3e64e9af;
          Wed, 26 Aug 2020 15:04:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v20 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed, 26 Aug 2020 07:52:27 -0700
Message-Id: <20200826145247.10029-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200826145247.10029-1-casey@schaufler-ca.com>
References: <20200826145247.10029-1-casey@schaufler-ca.com>
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
 security/security.c                 | 10 ++++++++--
 6 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c91389d7aebc..cbf1eea42e72 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1879,7 +1879,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1895,8 +1896,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index f9a632ae7be1..15a7fb80d6a7 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1331,6 +1331,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1361,8 +1362,9 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index 16e3430f7d07..7dd6b815a9eb 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -474,6 +474,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -672,7 +673,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -687,15 +690,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -707,7 +712,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index 38043074ce5e..d7fe1d5ee8c9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -429,8 +429,8 @@ static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
+static inline int ima_filter_rule_match(struct lsmblob *blob, u32 field,
+					u32 op, void *lsmrule)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 5a647eba96dd..3b30105113df 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -500,6 +500,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -512,14 +513,16 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, osid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			lsmblob_init(&lsmdata, secid);
+			rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rules);
 		default:
diff --git a/security/security.c b/security/security.c
index 17d701cd7f69..f9a249a93215 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2542,11 +2542,14 @@ void security_audit_rule_free(void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_free, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
 		hp->hook.audit_rule_free(lsmrule[hp->lsmid->slot]);
 	}
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2554,7 +2557,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
 	hlist_for_each_entry(hp, &security_hook_heads.audit_rule_match, list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.audit_rule_match(secid, field, op,
+		if (lsmrule[hp->lsmid->slot] == NULL)
+			continue;
+		rc = hp->hook.audit_rule_match(blob->secid[hp->lsmid->slot],
+					       field, op,
 					       &lsmrule[hp->lsmid->slot]);
 		if (rc)
 			return rc;
-- 
2.24.1

