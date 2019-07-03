Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E03CC0650E
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1708B218A3
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="giC4JLpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfGCVZy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:25:54 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:35886
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbfGCVZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189152; bh=CbZU5iRe+yH1VCf2y2WYC0jsmwdjRjXMBNn1U3uoaKg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=giC4JLpIOIKgWSA9HnwRzHRlZ0z9doN782yAxsYDg3v5AqV3cHyGmprJJ+TNVsIlc0jvU2OViI4+KzkCS62g/Xp5h/QqBB0gNJYMo8i6wek9QLaPVLd1h9dxo/5LXe8RczuJAob1taTRh64Zbkwxe46zzLnJAFzBdiVneaJpqSdF3vqKODxhEniv+TabJTLXYV5xLV5aikn0V1JTBWKDMBZE402GsZaWvXphscQC8D9h8HsST7jph7xbAEHtKK3aMZFuyiutPv9q3kEbeWllTPf+b8p3yMvcUWfNKHlUGwEq6fjnmG97E2huYF7uVDTTGqHuzWBnuDEA7YxA5dw9Zw==
X-YMail-OSG: uP3QoTcVM1kq6MIkVH2zR0T2rDSVmV_oRwLDQ4AMpXD4z_Db864xMZRDllrbHbf
 qQyVVGZGVQxn0BMRym3nHu9YELQQ3lg7uLTN8vY9fXhKuq32cXNkYuzjN5gcpta3s7nqb8qKdIk6
 RbazJCGaNrm1p.Lm5vYc4qGVsfqRSlhAFQr9Zb6PixQmF6IEOiqGJSn7lFBAWwegnY_hs5nMK7xp
 Gwu3CLA.nZNciT.Oz5iompIA0DLuLsGSgPiK9PDUnjWIJexk2ckg1veGqjU2P3OSVBqcbNX.3krj
 WSajLHS_cr88wqeSKJ98LzsHsdAyWrRhO9RnCWOuzX23hxoIBGWtp41ZjRAxISC.XNQBvsIVk.nY
 EDLCRgQKd3fdxJhsbou8daCIIpToLbECquWc7jOl3fWtHHFdiy3kbYqMb8c.167Tx32Hz0BZiFxD
 EHfeJYaRmpXqGEOq0x9_lv5gBEokcAKx6fvEw1wc5sQPfZhYo2DqYlJidgsT5WjURQxiVAxSGiVd
 qsJPJUpARofuNikwf6NM78okGI2FkTowsOevbjIrEqxAuFOiLe9wDNDh.Gy.2g1AVwceuSCLQONx
 uJHdagCEEsHhWhIGO2MWnCIFQcqJatKonFOHzDqrCML6YBHFVqBqTxwuqMBzOzJGELfiJ6Nu8JFK
 1WkR_zUVgi7o9tJTOBHDUoHHRquqJEhWAlrJ5DngAmX.6pKYaWw0uh1uByrVEZsZWnkuxDnYyod.
 1d94RnCZsPFTEH_xyWLJWVQY4SZrtjTAOvb3uTNSP1rYVkI_pLVSxka5zOAbeThIsqQq3.RPb3Dc
 pQHw_97BzgzBTrFNPBV.ngtvnctyGsxkYf16UJ4XsTN3cmcBp__LexnwagMJexfAE1eREoKD_n.6
 dKcbHJXKDscFSp0aHW3_pUDzmEILWU6HCyt_Pv784USWpsLjLxJ28ZpqnWFhl07jYfCfAAgEhBTI
 IodMESsDZ265M.8ghkB5J1MxXFaoPeH5ljRoMgkDU_DYJVzfgBH_6UDfERmZ7Mb_VctaAAoKO2tc
 Vn0dpy.3WqdATKJN_s7_zU.tEZgNvt6cUKWAWp0bn4pQ_XWXSFVBiy2y.2vo00B_AvC50ZT5_BDh
 9SZ0.YBs8RQvlrdgpsD1VRMf7o_q8ZS61oVBwZDIVkmPPmLejfV1YTYU34dix10AcR8_7BZvy_Au
 SWSXBgzWVq7QSzC5lhv3fKOZcdhIM6S.bnY4NrI21uIO.jtwO8_QkAIsuV.pdrjd8wrvMEpHiKe1
 w4_F8Llq8k9B756J7UgIaHEnFcOvRnfJ3EzEbK3i5eQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:25:52 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0d1593ba5df32fb20abdbc1b1b8a4c8;
          Wed, 03 Jul 2019 21:25:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 05/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Wed,  3 Jul 2019 14:25:20 -0700
Message-Id: <20190703212538.7383-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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
index 5bb8b9a6fa84..4f8b478bc3a1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1761,7 +1761,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1777,8 +1778,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 27e2db3d6b04..fa6e425e6f29 100644
--- a/security/security.c
+++ b/security/security.c
@@ -424,7 +424,7 @@ static int lsm_append(const char *new, char **result)
 /*
  * Current index to use while initializing the lsmblob secid list.
  */
-static int lsm_slot __initdata;
+static int lsm_slot __lsm_ro_after_init;
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -2433,9 +2433,21 @@ void security_audit_rule_free(void *lsmrule)
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

