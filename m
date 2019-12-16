Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AF6C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4495A21835
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BqU+Piq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfLPWgq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:36:46 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:44076
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbfLPWgp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535803; bh=1geWvs7GfSFx9csTS2THo8vohI1Xi608jxOz2eEL/1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BqU+Piq/zYbvoI/26ihU18sVO11eO20R3XEauGS0TipMfBpVEcutDRIfoBn/hGCxjNIgwYV+jSNeV8OKGr7eZ0wW0NutG7ucsylsxBZA2xPkYQIkM8i49oZISwuC7jp1ON5JZ99S+pSP0E1g/BTgQ8iuW8TlFBiNK6X0ItDWyalY6CBIpuFJgpQGQHNFo9A+Xk85swvyYbSyRZbekvdqbg0fgxCqre5dAoIQBWRMfjLnMZX2Vrko6iBM2y+oD5ji6Dk+asMEnX7q3rP8g32UOn3eEbtbGu1UTzpgStYiLoEGZ/pqd3IVpG7q7SoxDn8ah0fG6k6NzqgQaORbH5cY1w==
X-YMail-OSG: N46BUZoVM1mWLpkxO48uBQReXAcXukUqYYGyquzPeNjDeiIN0uPPaQLhbaLDq6M
 963.LmLIky0uAayoiq6t9iXTlmJlNH_w16e0JiZIuLvfz8iby48SNhe7ZyTamdGaZGB9.WKpP1bT
 rIBxiFa4BhQ0ta_ls.dBSquQjjugOvMNn_hdu1fjTBMsDeONepArR98B.2sibu6Wc0Qvn0QOrdCE
 AP5QAgdP35e3LI1F4jMsLqchCAXWIMrSBJF03lDIz7TvLnpRiqBbefR12y1bHgDA9EUjuGKj_Hk6
 7qk.yDRSbfmc83suxIhWq8TqrOn70V3LhIkh2vDiLyhqv6flNQF_QErPMcUb9FDkFQmu3hx_pWBs
 hXuHWctdgphmRXOCKWcni.ZQP5LYOmG8URzTDACaZnJzIzc87rmb8a6vMk6GZ9AA97CK0d5cCumH
 fyXAmbZJdnuz.B8QtmlUY66JHDdoISRbt5AzcfCRRK48UxtuFOJYoRS6oWSPx1JV.VffkJLyEgQN
 TfuziCu2FCjgAzWAVtL7dBo1HkrZXU2tfHCkebeaGbpEcFVgNcpDKMlKbWRgPtV8Xnh9Y40KjDll
 p5HSvBEHLmnMtPA_t5rLK8PqhUIfEwJXn0yUaMiUSCHYMWe8NYc0nkqa8bLJZ7qwUg30CbUeQjXP
 lCPFqasrGys5T.PvXoiS5tE_sRR_zL0ttjX1y0MDwPuXc3uWq9hS3dF_bWXcoFEAFB.uSzwR_ldm
 zRYUk43bydpF_YslDKHKWvvqvJaw16QOi7FF0zqSbl1g637BaRyWrmRg6OdLvzqWkDG4Z_dk7.ar
 T3_3RKaxLs3hTfRP6rVllEYRilNMAWwokSWwfFsfZvoyaEjZeVK9kB9ICZRJF6LwX_jYBWFZ9nl2
 Dj0S_UVoN9SqjZ7yMMgz7M8nuNsFERpFgipBWm7W8F1LgXXhnpnHsTNVw0bNuo0Jel0azqsij8Ug
 .8w_h0p6WnjzvYyRC6VPk1Rm4E5g3XQa0KyNXYnp1jkhLTmw8S_3KU4g2YYoyoAuYsWjeeu9.I.U
 sAHOS0K4amOk6dCyb5OBLzR8CIAAsAhm3YKpUX_Z1xMWvspradkJ.70BasledSDHAEWIZXI7R7_b
 aItyzbCCkJhtPOKowzPFaFI9B4KYMczgrKFoSkhorBTFaoju2dPO_F2W8TtYfde_K5uBiIyFWh8M
 m2.09_yCoiD53Qz_fDGRnBlWBnV6JJMPFuez_72SJVEHt5_KhxlEcV0ag3kxnOmRtXP3Hi1lwDgL
 l2mNy4OqJrkjPj4iE2Ef3WmLK1b8uMXvj3bT_43my2VyGTm0kPLE9vqO69jSuIe5L7vyvKgyaGmH
 rxADkV203IizIzw3GiXwiBwoGlG1YIMTmwipX4XUzrxN0vVa0h68VpeCHkJYeesUF.4uVbgQIpuc
 ZJ6wzEl9GY4DrWnP1gEMl7w8kEVpnDunszKCKdOnTpaVMuI22i7dmqmM1Y_NM.B5TZwynRg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:36:43 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d9d1cdd036ab55d1ad38f3162a989ce6;
          Mon, 16 Dec 2019 22:36:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 16 Dec 2019 14:35:59 -0800
Message-Id: <20191216223621.5127-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index f19a895ad7cd..193ddd55420b 100644
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
index a89634af639a..bfea9739c084 100644
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

