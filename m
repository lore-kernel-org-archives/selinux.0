Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F5BC2BB85
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB4A2072A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mw+rFdTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFUlJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:41:09 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35400
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgDFUlJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586205667; bh=qdZi5+OinyEciEGRlKKbPpckElz+tRGZ86CINhJ2MJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mw+rFdTFtU/z/56DF/MGeFqpRhs/VyQHjaBATMOQvNwsl+4hq442bu3IC/VSpbX9Rr4uEerTG4jBk+k3uqyeD2wp+KqYhgZBQFGeIxVxKJ0GE03HZIizpbfMPaUNMAwfaX6zAXqq6Wdirut+8uFhW4JWv75LsiEWeaIHMatHwEniVuEILhy0e8HrVloDwdri3SgvDxh7WH6duAFoBVdXOxFFFVzo1zovMpH2yHVvtV1/ez/oqLkBqIul+u3YZ2U9KgXU/dvwsMWcKMw+CId9hTS1HyBxImCcJOxupW5rXOP/0Ig9FgtDcSXYgZK8Qf2wqCckHEzWmVasnq64Mvz53Q==
X-YMail-OSG: nQd9SjcVM1lwzI3sqqAQ1DU2s5BjYvlqm.lRk8AZ6DjaF_Iow0QAnjyLG3WcFUj
 9i3QGwft8B5njt7EotY4D8IqaYDaKYH6Yq_.9YGd0R9YqVQCo6Z7pVdGe.7wTN4mj4OyXIE1SvKS
 FQQ4Q057mLxTgKa_7Jwh6uyhEqx0UiISF0LL5btb3TleKRiwxM2pKFibfc_sM1mtV65NcNKF7BEq
 nox0TB._BYh7nxh5QYxEbEhalP_BKmFMPWLyt2wge2pAUlGvcF0pskjbf6SPfkzK5CvaCP6AN1up
 Cc6pjdzA.TBgQR86d7cUQqEf4WvWvMcOQRpRjeP5PuWpawq0KaEbin1H8I4BiOc8eh_HD0PWyouJ
 .rzeAiRwKg_w365gS2DSgB6XH13E6pFnmV4.9UNaG_fENGkKQnowZbHtcMPbWeLTQp3mpC323zxG
 jJFgMoWALaPYu.X7b0XT4kZHTBD8YEfcbq3LDJXFp2ss5ggfacROJH.2eR.GoeM1L7c1mL.EYFff
 nKKY5iaJFEtj4vITN7TDxkjMqrHY0l7W5ewybcmXjobG1HvayCWTqAlcbaWM7eycMrhmV3m75fky
 9Ez77LI.uhA1vXjf.5rPSJdwIfaxpgD3PHMPSOClJ8gOC3E40oWjT9bZrdRjlkjmTWdGqcXhjRif
 e7HmDnsOk5W9UoDW77NHXbpniP9PnrgWvEp4WFjsPxjWPe25uHedjdcVm1BjPf1O7b_As1NVmGwW
 l8WDMvOQMo.CwocFJx43NCEUwSkyuJTR0bPlpjfuzHfaCibnuuGPGjaAsFchj1LpsaUUzA1m4WyO
 OLGbNzvJpo8DiLKsAL5rdalcM5MBNwQuU08rbQwp02wD8h.zzK4tE8H3D2G8mCzpfzOinwbRHzRg
 _fcZiu1j4x0KkUH27jVteG8eAPklu9pE5OEcTy8TnnqtFyauc0TtlO9KKNMH6APSA3DZ1IKBleHU
 IZscf7X.NSC10WBW.PNKREXRYkuUgbonpFonS4j6n5dNRPu_aavd5Nihh9HD7cVEt7hBntxt_5Rz
 H4xRBor3z4Oiv345rWY_4e2TpiczJoNDmems1dziORdYgCSqZ.IYL2Z.smC9jtDfS0OwVOtmxDw9
 w3Zx_lb_W8WQk9MWmgvTiyZu2F_S9sH5UFCpStVPDKqTjoRwvhk2sI_g2b4Eo59qL0ThQVfdXApb
 n.Mf88_kngqMmSPECek7LcBgONs_fPQl00SREFexaADqVVmxC9rRD.EwVIONoDiv.x8XQm3Bsm50
 8gpGVmXfqz9te09fPugKQRwZV9p2P7B2qZMUM0LZUJNV9ZD_ssxRjS0RXkWQeDWxD..MO0.y3yOD
 8XYxWjuftzkJ8hSC3emK99z8HqrNdhc2lszTua_JVrSDYbmyqpkgE4cSGTJhWRynOmbmeLQNOWbU
 R2ZdUi8HYNrpcPP0E4dmXtKgJZulzIkuU9r8_IZd9Q_nEPRcPScrF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:41:07 +0000
Received: by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 895c2f4d00ab73c47ceb9ff9b5749957;
          Mon, 06 Apr 2020 20:41:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon,  6 Apr 2020 13:40:17 -0700
Message-Id: <20200406204037.42262-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406204037.42262-1-casey@schaufler-ca.com>
References: <20200406204037.42262-1-casey@schaufler-ca.com>
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
index 8c2751763c52..9d83c6832bae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1839,7 +1839,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1855,8 +1856,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 0c239c29a9d5..ef2f5e7eec7b 100644
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
index 006447d6c366..55cca6a57178 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -482,6 +482,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules)) {
 			if (!rule->lsm[i].args_p)
@@ -494,7 +495,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&lsmdata, osid);
+			rc = security_filter_rule_match(&lsmdata,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -502,7 +504,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 8e66f27d6adb..b3fab8fdbb57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2467,7 +2467,8 @@ void security_audit_rule_free(void **lsmrule)
 	} 
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2475,7 +2476,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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

