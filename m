Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E77C2D0D2
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77CA2053B
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="axpUicHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLXXTn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:19:43 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:38828
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726271AbfLXXTn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229582; bh=1geWvs7GfSFx9csTS2THo8vohI1Xi608jxOz2eEL/1Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=axpUicHP6ZspD45eVBwUbhIQgDB66mhGLdikshvaUcp5pdiW4DulI4soMQpnItxHQCu+eRoneCuyHyLJH8Yjc6wwk9anmC9m3uUeMIddBRvF0xgMlVlgjnF/p2MzReuNrK8GsPVUc/CVUN9IVfIGuStx1JYO4poPR/+9VmhdWcSIV8S7cejjsUX+r8nzede7YT46xaCkCmfaT+km9CcyL1vmYNSPViHvxI58Y1enUmcAc68O87PNoLpN+monjiPOT5wG57iNUbvuX2h2hUaX3C4BmQnNDs+UIzGgZCZZHxeNChVeoFF/W+eejjvSjGFRwUbzcUE2r4Kd+zA8MMegGw==
X-YMail-OSG: p8eihVcVM1mKiBNslThg2OG7CNLxgtF4fS4nMmfBjPca6VW1w7DZS_YfMICJJny
 xd5tbQQnkjzFRwlBllm3AJcAq2BSqM6DAkKxnNwgbn4FmFvOknXq_TsRVpkFdZFaXvxUXGqq6fL4
 YAWaFrJDR0Z7C6Lp.BqWB422rLAJ84AIZej94Z_J1_QKvxuiDW.JE9exwfQ81tvOgxnM7lsQIMhF
 Quf.75GJmbtjWQGIjWiP_p8jocs3PXzD0zTKUs9uTWMdEiF9mNuElC2dbKoNuxoSD7QX0vDmVK5V
 9mwQ6pg8mwuJxWL4HdJDgT8Ve92.xWli93wiDNXooL6enGWFdW9tIB44APvRLRyd3L0exmROzPwB
 C2RW6uX7xinqKLntMsxLAQS6S2DhLzMbyP6tzUJYtp0hsGOgKVSH4Aax0NcGmmjjJLvj5PniKyzW
 LbRFJjdzpnQvvunmsYmAz2T.UcJivc0MsT7q9G2ItPNx0SLEkprPTiWTQj70NkncCuLdBvXahdxG
 fWihgRQpa4gkmM6BaU4yNi197xWMLnh3qfWCNFeKlZUVEjHeskouDqDpPevIOjqM3baPA9YXKjnM
 l96ZecazcoU703BSlkopGuVGSoTfJF5ZIcbvHTVTKOaFZnOg3NwnDlQuoSPTbvgqCy3Mvz9hJSfx
 VG_qoCgzX1um3CG38aCmmHlf_n_.FHY9c18TDwPlOUHob4L2tKigf4OT0dM.Moj1AeLMWQRORQex
 XEoG94DHu9xpYeWnyDkfbQ.LZ9qGQk5ldqJzteIqhT8yjWhZoKhb.czC6rnQcB3BMCaK6P4J9uCN
 ALWdWr.kbkW5HL5OlcKJ_t3sDdYRxe2JHUF9AsLxBAZlSvQTaNXxJ0UU_LV.mT.FuVxuYJCk41IP
 jDD8DzEqwcR3cike98RD3JNPLmB_w4LtWWhcH4lrRGoDFsijYbl8Hh8r74DQYwp2TUjVie52068J
 56X8Xn4lH3oWEzK2btDh.NsrULHhVXBMu8cmZU82W0cqWe6u2wxivc9UM13ShCCzRMT2nojtGp58
 LHeME8gvTFpYbpGmipETxK7uty35kEEYgz79HaahXV7.6R6Bd0CfBan5XvRtZDOg.TMuRN8BN3mM
 v4Caj96VUxjyCCLL0cGF0CifwbtaLkM9VEeZc1df7cC9rXEcsRuQtFWywNqQkswRo5KokGjyAwMr
 N5Gn2LAqkzI9mN.dNf5gwp6gbP6rvusNIVfmJF.G0IJI2ru_aLFWuPKqvf87eESkVXct9EQ6OH2F
 .GaRCTaz1twJxg8ZmUTWMI6hzkLMjWSyWmtESz64oPX5u4rY6krr_2VNcAwOTDSeype9zufkv7L5
 pgKZU5zYBsj4N0TuS3kB.hKcaLHPPvdEY0du6WNiREAAf1Lrvn0apK_n7bdEA47uig.57ikobgcL
 xjUHpSJ3CyLje1P5KbXVsMPV8hPBWAFSOG1bKrw7DcAcw6nCKSoZU9LHFZ6Hy2JUxptjfFQ_1sw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:19:42 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 233eb75228958db4fcb67c284b099539;
          Tue, 24 Dec 2019 23:19:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 24 Dec 2019 15:18:53 -0800
Message-Id: <20191224231915.7208-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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

