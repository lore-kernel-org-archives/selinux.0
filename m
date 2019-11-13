Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0967C43331
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03D52196E
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oyqY5470"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKMAJf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:09:35 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:32993
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfKMAJf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603773; bh=zwtwS+X4xVmleeqnR0L11e8Hd0N9+6mQMB6qAtbcndI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=oyqY54702AtQd+3CcoURzVqaTXE9MCHKR4ddbFG88xirlHoVgj2Nt+CsnO27v5LXUbxISvH+LI0SaHL93tgBYPEL3LZekrnldALQ2oriyjZi+hb2Ldp+e2HB6NWOSZ2PCXPskpFGtQsn5TPe1gJf2T+PP4FFDlYRLTiDWld709xLWiQ3gxYpVLWUbAyIowRCK/4zXYFb4/twhrawceaL2h/ios4RtjCBqsAha7UnZs1RRFUtFJoRm7FVhEch/f/OIrvX76OBLuzqeeqU5FTx17//8LuILlVBYPA5d+O9EcTpcuRChfQb7T0XlF17gyWTHwvJHOZulwjXSyzpdBrIdg==
X-YMail-OSG: 8REAj2sVM1kCKutIkHlwBUoA4h6fNEsu41LmSsQu4TzghMs3g.ZEjQNT_K6Mh5S
 yRDIwSHKGDSQF6yE8CCefvIfK6d8hcOPjUYk8sQcBTgCuyHp47HBUKC7O.EMDviyuNWjWf.15T3j
 l0.UM0pE0CkXcGx_nmJJS7mhkGiDZmzTR5U7jjJTPsfFvPKyQCvLBfNX1OTzNo7sQwTyZk3akGjj
 OD0FEK7U.5e55WT285igb.Pm7rV9l_i4o7aLTuSJq6ZTvnR0CgqrcP_eiVN1hlcBS87S5XuGlCgy
 ehp3T0LeaxBf9vpmbo5Urw9NZkDsjEJ7oH9LdW_i9Ml9hJGXV3kX76NFtBnLlhz1TzTIb9nsHDxZ
 xisNbwtRCnKTAzav8u.jloNnAgFaTy_wzKrkxbkwvjbSwiGE6UcG4epZJXYTMXpjs6aBS.0CCE6s
 nXQi8pwU6ZBJkURZ3cx2bATFhSNEmHEV0hTHrkYbZx.U9CqUHEKYOpXzBG1XrdibWMAbYB4.9ti0
 Qibs01lo5VTUELZ1QQRYpmQvyVktxj9KenBZUlah.k3uu6I1cYrUt_ZMi6RWBpMIy_5kz9CU2NF4
 ovXAfKvSPETE5cBP84vo1lRkyrU88vAtsBaM3LIMjejY_URmqbhSJcs90mswOP7Pmtu0r6S1zgVR
 WRPEcy0bEWeCUM3rgSyjLLHcW.j6G9ao43lA4.BO9h1nmJMxwy5iMZL2a43HbZWppXphtM9bWKX8
 TpphVAkEK79eLYngC6ClxrjOBdGDdVoQCH_oCEVtl4ypHRn.EgyRsMStRx2O9XLFINLSK7VSU2FZ
 wvW7WWupWdtbIqlroLlkklFbkWhIBDQx0XF9h1GLI3Kp1CfK1qqC1s2TS26cCKWVZc8dWXY6_fOi
 LzIjvrZjhFgI3Gx_ekKpn135855y.cMLtVIRJCQPORt8wY6jYrpJir4d_YVskrLHlou4JAh5njCC
 ETsABFryvRjuT0UeRFjt64cNjOHY.qhDiHE.1.UObWCuF1bD0RoUyYy_cyrBgAPO39haXuc9uLea
 UUVkyy.qwsXYgmpm2xmnt4SCjjEN.QGzuU6ZCXCuWkDZWSwISQ3wbuURWIgCT2kDkAZkGEgfoAHm
 QIPb89JPGwEjHWd7RCb7nq.wOzB.9vnhrYR11iu_gDjM9ZG_fLeuOOJqtqzXIjpMQaHqLcEzkpwZ
 Hinv7Bag58M4ID5oAmyoIIifSTlhXhfVS4wlIAnvaYyrheeQ_jgf2_ZUO4lY0pKDMFfEeo7YAdcn
 LPQN9RU1LUsc1xOyYcKIS1cWpEPnzqGtKu7cZlqvzi8aJlw5r1SwJbf.c_2Rm9ZTc5liHEyGfFzl
 29.gSIms3lns1iAeeZghrVeRArNUkFa7to0USMQZ.48WoUtYY.KRmoqM9tjvjiV8HPaRubwUyyyU
 qwlknY.B0wgkowPmw8CkTMTqqzR3s2r7o
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:09:33 +0000
Received: by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f1d82c7e28d32d4ef3c31a06032e5a8;
          Wed, 13 Nov 2019 00:09:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH 03/25] LSM: Use lsmblob in security_audit_rule_match
Date:   Tue, 12 Nov 2019 16:08:51 -0800
Message-Id: <20191113000913.5414-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000913.5414-1-casey@schaufler-ca.com>
References: <20191113000913.5414-1-casey@schaufler-ca.com>
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
cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                |  7 +++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 | 18 +++++++++++++++---
 6 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5eced28fa0c9..2df58448f1f2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1835,7 +1835,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -1851,8 +1852,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 3689081aaf38..5bcd6011ef8c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -370,8 +370,8 @@ static inline int security_filter_rule_init(u32 field, u32 op, char *rulestr,
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
index 5380aca2b351..7711cc6a3fe3 100644
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
index 5f503cadf7f3..7c386cbe4cf3 100644
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

