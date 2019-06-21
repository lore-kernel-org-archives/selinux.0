Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692DAC48BE0
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDD62075E
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gD23/lKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFUSw4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:56 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com ([66.163.184.207]:38474
        "EHLO sonic301-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbfFUSw4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143173; bh=390+Hd7ny7sFbJVtRz3vsP6IsT3vyWElWcWJ0xXYlkg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gD23/lKnI53J39WtUinchitgWUWL/KMb0yTifGIGzXzEcd0nxxnaMYkyVqC78FS42tKSTFOVdkYHHxzkHaTUYg15eGOVVxqDv61OyLseXIKPMUhJHNjXXB3ZQxyGJ1Hbu/IE0PspOWn7QOUEbQtOt8NNAzMYAV5uEGSKoQbc+7MiY9vkST++IY2SCSbceL/FtlFfC7NYQTEj/mE24bXczV72N6ri/y87aYcW8/49HpN7151jUi/jn+KTb9LKoGNYp2MVobWirTWvHV1zBVfyPnXcmtDA4WTWiuTlEuMp191RSH8eqx8+DJedEzkqPlgu/MGlfHYNXai+JLZDuF430Q==
X-YMail-OSG: rbmTuLsVM1ljiBed0LJ02eVKZAXaLqEFxyUWoNBD5b07ZDWiiBnXiDsUkDYIs.9
 Ltk6mQVPveXWO9PuhuSCvCmvJeDo0lPD29o4oux3m74Ka8wSUTpwUEDF.npHmbCJpJotoHseeVb_
 4OrORJHQrJ1L0ftXH7izxFvPqLs4EBEFd5ntfvLl2_eYV6RoDT_Xw4l88J2Ui0ZxNxBZH0eKBTO4
 uW.hIE2sokKWPxczwJxf7_PZtJr0Jf.4BOxMktyLMmbBe0D2dpPZ70uHIMtbtpqlFOdIoqEJWw0S
 D3hzkBh_.kAPX5MXi_XHnn.YAW0g2Kc7BEk5vO1_5LoNyTMxBc6Jzi7i43.GoDQjfNO0O4Ll0_GJ
 eugFjzcTn8nGMloKWyZqOWBxxWgtszKt6mv9tCyFPu6ANyRaMBcdmx7m9yn7HzA0nWQRL1_2ZXlU
 aHGUa6BqTLkASEVYUIUeugcNlzoi4TyM5M8vDrIMdoRBnxwYBL8HrajW9uJ_gncashYtfJ61Ca3C
 cEvLUOEjZr8ueMBphm10fAv8GiMx2Jc4k8o8vqdG7fovyqII1iYi0ohwxqbAjzboZzrm22rjXeeI
 PNzXM8xBWf4MvYSWIIc4Q9JlToWSUIyICba1BlMohj.vy5FSKDflgw6cNI6dcEijyHOHitM3pwZ1
 yGqDzrjcEzPSy0Ko0sGBKRJZ7Kmz0m.fdqwybO0mYiGxuwjKBHZkCiYWGySs9ehPGBp.4un1ipaW
 RV7w9yuyfRmsvmrCXbQUEO2aq9PBXhWIhZD90fA91zK2MtNLiSrLgiPaQllIu0uKsfWglr4.qYXL
 dX0Ek0tCh3f_mfqEKQoVPs0WQbP8Pp4kG2XDjpI4sa5Mum7FJoovDeuTHxiZ4lI_LEH9x1LhwKg5
 YfvSvzkIAvVnaOUEEraZzUhxNJBuhs3T5l66pRMTLBjPVlEyzQni56pr3xFSdFJVSimpRAhiVBU8
 RZsashAuhjq1seRsthTgQg76PCQzD0UUgaxDSGpcTRKKKiRUfuvicId0BkusGRdszWkexCO6m8TW
 ob46vEXVA.6x0Qxi3YLkI5gHhWzhkDHP5n6bkttesmMyO82mnAswHVD6jAoT1IYWXo1A16W3CGBO
 BniYJIGP2J.OcO8NXHJaIFFPrXCDtiVILjcXc2WOqJs1ksaEGKgBosEppjEN17iwzS_it5ScpDbb
 YKcCji9pvxy.QEejapOreYFsVHmJ5GtrdYjQRlTQlFEerCdCQUnqWmLBlt0DulTWCa809o1c.mUI
 JAL_76JGVqppmN.911TcrWS2i6xjhSU0ZhcebfpLdfg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:53 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1d10864c45a2fe45d2b5b4a73ef7e245;
          Fri, 21 Jun 2019 18:52:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 05/24] Use lsmblob in security_audit_rule_match
Date:   Fri, 21 Jun 2019 11:52:14 -0700
Message-Id: <20190621185233.6766-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  4 +++-
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 14 ++++++++++++--
 6 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 0aa9417a5762..52d89c4a9594 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1757,7 +1757,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1773,8 +1774,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 63f8b3f26fab..da211065160f 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1324,6 +1324,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1354,7 +1355,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
 					security_task_getsecid(current, &sid);
-					result = security_audit_rule_match(sid,
+					lsmblob_init(&blob, sid);
+					result = security_audit_rule_match(&blob,
 						   f->type, f->op, f->lsm_rule);
 				}
 				break;
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
index 7618c761060d..4692f44718c6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2452,9 +2452,19 @@ void security_audit_rule_free(void *lsmrule)
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
+		rc = hp->hook.audit_rule_match(blob->secid[hp->slot], field,
+					       op, lsmrule);
+		if (rc != 0)
+			return rc;
+	}
+	return 0;
 }
 #endif /* CONFIG_AUDIT */
 
-- 
2.20.1

