Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A29DC2D0D0
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA0A20679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Sz+WjRQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfLYAAI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:00:08 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:39574
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLYAAI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232006; bh=a7gP5ojhPalneWu5RFlKAGhZcG4nFIXdq/EolVgpW6k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Sz+WjRQIH0MRF3CHuLaMoaM2PiVFjkguuxujqqskSb9mCIK3jeVWZnXtD01CFVeaM5DmSZ2GsOzyuj11koxHkQJr9IwyxLxPd/SE4svKF2FW0e4H56EzizwljrikBLKP4bVI/sG0rYKnPewz5nXNkYor6vgSGcpGlexjrIjFsAEzrHlmBlmIAPEehmj6WtCOpLsyDaO4LTZzwvkKnAQNgdz7RKIqFTyi2fX6yNuC/pFDF4uaxgJur1VzebtRT7ACFrQMeOCWAhzi7gVxmTVNf3aTDT5zLyJCTS/HZnOQ3BtPkfkvSDW9AD0tFzvK2vOL39Paan8NIX8GwAQyCzApvg==
X-YMail-OSG: ACK7uaAVM1nypnky.dl0Pt11Cv6Y_qA_GQyuQwUuK.rB_SE653A3esubSVSCrzO
 4ViwXDp0eeQH3iCt9uZkk9Uum4OAeHpXWAXXMZ4YvuSGOIpua1tbl_gAjrdn1lDFnQH4P_CqMQ8c
 YLDtBCnADc2fIEuB.2R7q2Li5EQkUClOHzEsP5V7l18BGOAXFih4kkSj9kyqJtF9tNRiB8YdjLVS
 9MnMRW5jj9kF4gcrxtJDKxLCM_90UARBqedYw8yQc2yjFLLdw0DY9w4b3NB8nEo9NSo8jLYSQrUl
 8BYNVCFFP.QyyqGkG_y1DvytFZzDGliBY1RUShZqDRogP7eFLu3OVtYaLHWj0BZcZstGg03SLjZs
 5Vlb7jbzVBwxi3laFNgNvF8EsFnEjh0ihu.5tptYkTv9vwCbRC9eAO1_GL6JqxEQX7eh_dVGfsz7
 ZxCBdftc.VFGaDPs8v7JRoh7rR7T2wcoAzD36EXWu2SgYJ7uzzzq.VISPk60YsyG.wCER1Ou7OG5
 22acSUTlrXystf7dW8cDYJTWwAnDc3CTAtKEK5njHJJ4QrRo5o1DPfWS9pd_S2QXvL7yir_mh2K.
 aLZQUECoi6sW9YN7FAKm.jMFZQlLI72Rir7XuOO0Qmk_T_t2M_Slo_f5EiicB.2CyDg7W2v5Iolw
 UIL58GAOYqJfNzNSR0SG_t.cefTJzWveh6e7qoObauIGPr8pqhdZ82r5zbNOUsh9SnLyr210OMNS
 FY3W94pwu4ZELjWRuF49kZ_VwC7xNqBWTRQSLALca0nvH0W9cjVh3B1V_XYgvXNAmK3vrwJj7kyR
 EK3xJknJwwl.8gcESjyI4QK3RczSiFpa2pnCct1a3TE_62WHXhEy5GnuN34GhIU.kGq..dGW1FLu
 NJ371JvxXZ3l95ErsXo9Lt2x9K84Qyc7z8m6kic75N00Ia3g_9cd76BklQZMthDopXgU0Gtl4Hdq
 rPcAqFlXTwyT9tHujX6jmmzVrH_Gt2r9LCiZ5N.owqBSSC88vj4SVgWtali9UFGYbe4nBtTK9VHk
 7T.1UvcqaqGJsTCylbNl7TTV2uA6EhmrCKkwE_bmZOK_a4kPOD6lu4.g1mH.I31SnpPVTm8oOSTw
 isBRqAmeSDAX51rodub2E5Y6MbxZ6StpFh7MC02.NMmZuvErpVw5GLYBiDHfuDG17vrMdjNfmOlk
 RbST5GWRYNNHFbAHLj_gPIQT.PTH.5gyugYmXSWr_KjTtwfyw.ObRUGFIls8oBnutvSnwXIjH1gE
 qf7.DCPWiiutUnMql_NspFaWS0kp4kloxDuijcN4h7PbKdyz2W.vyJX90MKou.sCJzK2JE7eGn0W
 MhoadukFE5HwX4F_rbIby8u9n17yD2oBc7cDyodFcpl6rRUZEe3TZuaeixa3TGdddZpK5WSl.1H7
 eGrkPp3Y_96VRgYyzgIzw1.k5RZTcWuY0XukzN7uI_5GhDNqr3Kgx_bTH71ZljZzrcAZmAWI2joE
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:00:06 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 001a47d8cb2e601c953a3f6dae1f6bf1;
          Wed, 25 Dec 2019 00:00:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 24 Dec 2019 15:59:17 -0800
Message-Id: <20191224235939.7483-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
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
index b74dc70088ca..9c6dbe248eaf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index b0126e9c0743..356db1dd276c 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1325,6 +1325,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1355,8 +1356,10 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index 4effe01ebbe2..7566e5b1c419 100644
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
 								   f->lsm_rule);
 			}
@@ -658,15 +661,17 @@ static int audit_filter_rules(struct task_struct *tsk,
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
@@ -678,7 +683,8 @@ static int audit_filter_rules(struct task_struct *tsk,
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
index df4ca482fb53..d95b0ece7434 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -381,8 +381,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index ef8dfd47c7e3..68fe533f8a4f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -414,6 +414,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!rule->lsm[i].rule)
 			continue;
@@ -423,7 +424,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rule);
@@ -431,7 +433,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
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
index 87fc70f77660..12e1e6223233 100644
--- a/security/security.c
+++ b/security/security.c
@@ -439,7 +439,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2412,9 +2412,21 @@ void security_audit_rule_free(void *lsmrule)
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

