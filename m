Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5611C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AB620739
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HcERmM75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgGIAVM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:21:12 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:36839
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgGIAVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594254069; bh=i2QQRg79JdkzCREajGgn17V+iiB1eOsUqVCsHE62TT4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=HcERmM75/M2p1YqJrmAANzSZIH5oarzpRPvuCYGCr//DHZ0G2dQm6YGQ/5cqtX/R4uI5NWZvoDG4G5xIRs1Zx2+0rQoCnf1JfOppdphTtpisQK/rLF26vPHMlh+rRN74LxjrdS6hOi8mNAAHMntvYl9Kd4Wq4SFt7pgmHaTfCLoLQN1nlb+Smh1bB5YOy0uMhvJS8UjFzZb+VNU6SkIUgq++D51emCC3luTaN+QTSEvxSy14hONzE5iHad2I+QvZaEMEnD2dKHQQcHIgG4tMPEdQx1PU8aoADZnBYVttuGTP/kHRG08ci2vPrppaXicxExQiU7uEOGC5KJDSgs+Jkg==
X-YMail-OSG: pqarv7AVM1mxbAGLyjq8FXmVkDQDAg4NCpVMrIr8VrtlXCd240PXfS7LNWm4oWn
 SwWsWviLSISSLWakqbLCp0VP44LykSflmZeT2SMJqWsxM0rCsXRGL168yvQSl4udTPfojL_8NO5E
 xPUL55l0mL_9AQfS2kvZNG7BeP87h4oo8C_KJr2lMR4bFkP3XAytR96_6W9Tu_trYFPmpJejCU8Z
 5p9WI3PoevCKsukzErUpO877qRpAnlm0AAmVPzNhd2kFERHDijNnN1Iahzwr6yV2O3oqJCp5XY.c
 aFonXqc0EY6LnGCkAdGXNcjynL1F4Gc_Z7oCwgOVdyVEhj_rHR0ORMnjjP_xYj9rXlbdMwLdQ05V
 xo2.pzZjch_59B9fhxo0drzRoMgHNo0R0J_aWBxkfEF3F2hgBABlwOx2rgaucmHsxx1g2YMFZo1Z
 acwQdPKQLfgbrhKVs4gmg1dUmmYzJdJUby_RPWq9xSRFTgU7Xih_SSZEfvNvSpSAIhigZbd4754W
 KL5cSgEBwjLMhjjCfwVTY7PP9BVzy92C9mXAs8Pu68M6HJ8e7uxuFSF2YNH3FiBM2BAOYmLbRUah
 OCspf.youcrcWjXF3DVf0lDeWyppsA06JBDEDgmmfSFPKTdax2RxMj_EEXY4gntW_F9G._nT_BhS
 1zXAlRHIjusBeRWBhmFqqRf.7FSRQ.3fmxudMfqZCxQcwaNBf8K8RxigaS1kz1bZ0WU5gUdBZWg0
 I8QEOX77zG9IyuOK9b0qOUalVEWmeJMG7G2YLYx7G_Smg0S7QCku9ECkG4iiX9w7FG4RKZ4Q.4DF
 m5Q.C.0tsQ9X07BVv9aupb.cAMftVnVYhVaU3V1rqLDcIO71gzPF_Mho7LnVLOic48QZqwPv14dR
 bNSDJ7tTsj0g5XltQjCZ8TFSS1M3LVuDJD3DxWYaYD9h3dsbcwiCoMoaHnjUVxmIxIpZh7uE1JyQ
 rqWhpYLqnvHEHZQImElM.F03PHebMKku7Erlh9qrHaXsZ52bLbxUrxG8OdUX28FryjPXQbw9DFmM
 asfOGbtd_WM8skNhXpceNQJMCdyX6C768gEngcvZs8F.2LfozpP1qpPaUA6HJL4jM0GaNoVOp1Mw
 eRdPYctW9PlpZsFNcUTOaVSkzIc8.fhV5xzguLfx68ZTrDWWup.TeiXrZLutcRoMdBoMWBgFYWZ4
 5Uuf3ZsGRz5aaSVyZP4rXLgIzS.GKcHE4nA0KnlcEzvunGOiuT0clawmZBRq5cDW5MQkH0ZJmaHO
 QLXlu_0dbu4fdIqKjmEwYx0na0qRynXDBZOjtfTVRvgix5TFQgCGOXRYTiczOmUD2Dugba3KbyJZ
 3xbPh6kaovX3VKEXXBJz.nEwdJnKEwCSL.TsI51BsbdyLuYr62A.9FwjuMrIV_twOJhIrnMGAY2h
 stSPozy3Vb4nP4KGB1M7utKW4ho80laxy1w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:21:09 +0000
Received: by smtp420.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d0befc6873b4b43b784f5f3267220a61;
          Thu, 09 Jul 2020 00:21:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  8 Jul 2020 17:12:14 -0700
Message-Id: <20200709001234.9719-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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
index 591dae299c6f..294410533b51 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1878,7 +1878,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1894,8 +1895,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index bafa03a5c866..975c3b8c8d0d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -456,6 +456,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob;
 	unsigned int sessionid;
 
 	cred = rcu_dereference_check(tsk->cred, tsk == current || task_creation);
@@ -654,7 +655,9 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -669,15 +672,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -689,7 +694,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index df93ac258e01..64bff42f5d56 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -414,8 +414,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index a442b8940e93..9a0f462e8891 100644
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
index d05090bf63c6..3bbd01e8192e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2527,11 +2527,14 @@ void security_audit_rule_free(void **lsmrule)
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
@@ -2539,7 +2542,10 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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

