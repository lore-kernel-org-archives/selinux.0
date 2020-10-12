Return-Path: <SRS0=npki=DT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFCC433E7
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FBD2087E
	for <selinux@archiver.kernel.org>; Mon, 12 Oct 2020 20:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QpQT2pft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbgJLUWx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:22:53 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46754
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726848AbgJLUWx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Oct 2020 16:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534172; bh=MegHnJUS1BCHJAr5dabkshpnT7wwfTOL3Mp7335aTBw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QpQT2pftzvq9f6t2euAbPlX1HODPprA6H2HfOMPYfEJv2Pzx/aOXrOKxTYWHIc5bU4ReGWCmrN0NNtG8kcUDlW8KdOdMu8/3xdKzgcRRlbsiUxh9XTd61wvrLi4bt4kEeSW9mFGmGbCjOYyFXV4aJ2Y7R4/v8xf2N9i3C/IG9TwO1jp3c1M56flsevwUzJapICtjoJVKBmaPV9ZM5jL7DO8e2Rpg/q80a1CPlR/8s3+mxDZw7I46EKakjCjGjKTNoy065u0h9egEwQU+O9QTCxA6xV/KEXTiOHZNWNwcvxtUh76dPzN/cVkVcP4dEOGw2rEVtM1NTsf9HNHLzzpLzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602534172; bh=lK6X0S8GaLx/VtFsAiYHPkWDHji22ONDn6fMvGYps6t=; h=From:To:Subject:Date; b=a5z7gnW443dHRZVHhffqZEVYDOjBMn/eWaUMbWfabM/hTEVs7jnOufovJPehhldGvoUSw9SaZu8EXEneBVEINykgJmDnbyj2EUx/po5VSO3PgqiuDk2NP8z0tq5Aq4RwHRV9XqGvynsYHkWkVUy4OI8KA45tMMh94KeecTyPHvCnF7bIwKQqSoHabvDstjNrd4S7tgGNSvxuPjZicy4q+M4J8UaxdS9JrqPq8kI0kGcGnt1XoGGHJbi1wh2x9m52JdJWlgiP8JXbCRqyHDUQZKvh87LleXoxsXUMq1kdsmNMxDWn2TJ7bpOGNB+N5ZecxRpbG5NQq6BLAKn5LkPtwQ==
X-YMail-OSG: 2OANYZcVM1mBTVsCljR9vTKDUtg9fcqmTwUENz.s9JQL7lgj7mr8l82PQqfGFIC
 tYnmZNIA6IHx_ahifYOjKBo.7nRzZ2ZkznJG527TsRT.dVlPjqssQzz3PNzGLmxRzQXhoMnHjqtb
 H4VpTNIi9f1jW5V6fxtIPi7o9hN51dd1G19GQNiKZ6W3ITIQQIEctS_ceZBrbNSYGyJFcpPlNE4k
 r.R_ktwXmhfUgA0VzNqT6IqXRFRFvfDdIxXgXOY8lFMH.vYFIMw.bdXCIoUru0YKI0ic4HgB.BTY
 BaMZoM_eYjstyCWy44onMk7DCIbxpDPQ0W4Q0y5XCJzl3kRPF_74ZZy82_A0L816I9WPaisB_P4.
 EETIiP4kjdQNEt46Of8JKtF2ck9AiLDvW_r1Q_YOCLU7IAtyi.DSqljfN4NNBwlHfOSxY3wWwbdh
 OvH6PuRgrMw0vPmkn37sV5Kt6mq5WF6MigZAGdXDgacasp1CUztXAUI8mnnU88RjCXFqD7NJAv4r
 33LmfellP_LSVTVsYASdJ8_FL8l8N2w3PIPQYz4uLkJ661wTkNy4e3gg8vjgBcngZv7waUtAOpUt
 5PD1fKebx9WGdccbyzJlHCLUlFf0wHjYc_RTf5hbcZNbgPBfr2hvRROHZYzbOqglpmQMlr_cvpe0
 wGJ26zb5a6mlhdeIa23E6XrZnduHssomtZ.l18Wsi0sJzLlT4byviUo7EqKJpIWK3RRNQY6hhbUL
 SA08ukQEkCQIi.qhF8KP.ZEhtUY3PjXzlxLXatxiYmrqa6KFy4MJneKN_8l_x0CWUMG193JB1_7Z
 z5SASjRnxETVAtQNs6xRxNkXXi7Kn2kszbVASqQOMMpLAML7JTHlbHwgLI3UDsbOQGO3qbEXn_5s
 9Z0vU8dWiP.rtArrpQ3lwAqZX3Zgt1J1aEtbhk3uiL..jpawlA_FL8Q0fXB_vQiPIkh0oZEzm9QZ
 uCMO75MJ2WQhqPe7mTYBKaR06pjveIu2tabekJTDceDM8lQbAj3T3qGAk95zPYrc5hVjBhY9RLd2
 zt8rRE_7yzAZzc0hj8wJVhcA4rdK_rkJkn_r71aClMeA89V70bLiMLzokE16nxu6DPEfFm84_Cj9
 rNidJ07EhOVUCoi7c9i0MRqF7FR4LixhVt8nsCAG4vWsj3uhznAEYksNBitrx9lqSg6nslSf8v0L
 1zdnfopb3rDE0HJeQQzHJNSRnAEr.Rt.y92Kxy7xhE9aLnrM7P6ZOuih_yU4P04BkVxl4I2Vvs8t
 uJbsGojgu3RkWLxBmS2VChE50fjzCVam4Tat0AlZLhXQnY9udSTuuZbnA0cZEjKb2JPZhp_8v7ej
 A4n8QzXAsUIlROK6XsdHp4f9AdNfsEY5t1OLRn64_EvFBK48fTpK52l7S3qkBNY8Re1v7DeUr70V
 SXFfPskafnZbX.c2oQh2UgKFjP9oQk1gjiLTPhtetbdHxDUYyd_Fx2HiZ6TWMGlu3_iNH__inh8g
 29WntfzrZPyQLHVxc5BoTvaxbuP5PnKx1MhIBqTgUHFRwsCICy19wZogxEwhepqKVAID.JueVcWZ
 VkRodYqmhTSEGllk5VVJPiuoCjihLHMkMPUk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Oct 2020 20:22:52 +0000
Received: by smtp418.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 05209e85b756436189efd23d3a492c15;
          Mon, 12 Oct 2020 20:22:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v21 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Mon, 12 Oct 2020 13:19:04 -0700
Message-Id: <20201012201924.71463-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201012201924.71463-1-casey@schaufler-ca.com>
References: <20201012201924.71463-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Paul Moore <paul@paul-moore.com>
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
index 45da229f9f1f..e27424216159 100644
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
index 50aa77139498..6b43ac22220c 100644
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

