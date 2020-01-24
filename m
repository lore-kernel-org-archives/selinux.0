Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CFC35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB62214AF
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YAi4IgWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgAXAXj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:23:39 -0500
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:44078
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729516AbgAXAXj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825417; bh=UIYk2lo/4C4YgySCWdfz+ZkuKqKHQIG1r+HGavT4EVk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YAi4IgWdPWFWdh4DocLnGyDKmPNEzf/OxgkRN89+fxPkWjQjg1nH4tdcC/9n9WDpZf9h5qPhxYx30rBEoackD1kCAkelteSHPrurjbMycqBFoKeINVZZkMUSanDSDstuJ7tSwBTTD49I+eIlDFiC2CopsMuzl8tXqYroB52HKrcwCF4Xo6bt+aR+28Dbz5wlKPtn2WY2lenEnHXDProNI8ghpIoM3d4VNz3aIO/HOibJJYYbwmSBg50s3Dc7aBhrVdxR0EuHDqi/I1h+yuZfFuSZCDtDgzoAMYCF9kYhQFTfjQb38REgZxJPpjRpjYmx//ULqZMh47rDRKiOMYQhtQ==
X-YMail-OSG: 72ttp6cVM1kFUVEHxXIdDnEELSi6LeWgHgHp9T43NRzBejliKtgNgvXD3iiIB_3
 dzWCJaNGcb2th_X3DmM7Wec9_1HWqlgPO_nfLmk2XFZ9is_51civKzLolTGdhC.871LKDesBD0kZ
 zrZ78BDph..lzzyu5VJrmtmVgotsF3YPz8UpeJHgYDKI2lLGgG0yeYWZhdI2nr2kJpNTpFlkIQKn
 WunOxAQeCSiksyehRTo6HQualT3DoqOTny2hBClwXTZqa_jWucGGrjah_3WCJp.3vOhR3Fe4iAZ_
 66aKyUCctZhwGwoTuf_NRfKQcryP2CtR2VW6FePmPUDZyyCY34RpO_c.CKw8XzQ37dWLE7F6E8xW
 4d0A0KyhpP35SQqR5emhxf.TwwSG_UFhYQ3KHaesDfec1wi9OlHCobKMYLzJb0XsSe83Fxm5c7lm
 fV6T1hgwZH2LePQnPXszn3IZTicfHUXSDCrE7.l6jn4g4WvzzGsCfnzEIqSE5aRBDC3bQbAkQYiS
 bKmDxu58hmVoAj8SG8lzd6U0_nGAkwMr2Yvc6YWkr4RKFBH3WPALtHsOriAAXs4mviAAsYgFOB14
 c4z.jPK7OfOG1qTBJpwiMXp0zQVMDHDA5HAx_FvtyHoYn7bhbeEsALsx7Ny2TDqWdWY4JOOmQmfU
 D7wtMfHk.HXtldURfprj58JJnF1moVGwA414EUlyoVfE62mz8fV7mQQjOdPi_iO2FxNgRsP808au
 8Wx035hiDTvzuUd39tl1S85Ue4i50lVmoIS2Evo3LL4WssDt_UyKH2LTwDF7BJTR1hls0IJGbFXz
 7gmrw_XiUX4sSAFjzdD2X0S2aN_XXs_.D_oPacg2dFf4lMA121Ra.yD4mVvL7UwUUI3THr_z4N8X
 AIkAmD_pphVuPZ9vLdzHxBf.Zp9tYNfqELuxtjoXvrkWd_ucugtSD4U7T67aSvR.qHTR9aXZYL8Z
 yB.LbqJ28_tpUUaeXggwe7OxXn6FBkU4KyJSABdQq5KK8hf5ScWsACMnNJhrDd4ct0xKHOuZ5k2S
 PQ3X7Y6xUU3F0u2P9RrkFTWKv5dohc6gBz7RtOnrGbDH36kALF3aKbU5UHE6b8XUGg17e28KDa.g
 x5b32r_h8wPUrmt_G2OlPCbUD3NxPgNM8jEI0QAL_vlHFrPRvoCt3AzCDSP0.8Lfo0wZS_maEmSJ
 CxSdW2mJ2kpbq0rk6TxwUfzKoL2XBQUDguXCCZ1e4_ebETeg2f7Fdj6vMNpxo_ojzXDU4qaB63d6
 BhEoIF4CdxQvskiNzfxaxP1_8Rstcn7iIG8GOy_3vsTNRmCo4t.Iu7YTmgGrc.dHC640r1msBzF4
 mxSTIMIC5Tba_MKnN71OQDFMm95hx6gfY8tInJd2i4VYoOhLT6QootyoXtvJiozZA6bLjRPXY2lI
 lKgMQgivh0qeH5JVhc9FmHcDVV_knliIKDrqVJBjPkzBOh30.2JocPuk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:23:37 +0000
Received: by smtp414.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e5f705e051cbd06816d6d32e048b9ccb;
          Fri, 24 Jan 2020 00:23:32 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 03/23] LSM: Use lsmblob in security_audit_rule_match
Date:   Thu, 23 Jan 2020 16:22:46 -0800
Message-Id: <20200124002306.3552-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
 kernel/auditfilter.c                |  6 ++++--
 kernel/auditsc.c                    | 14 ++++++++++----
 security/integrity/ima/ima.h        |  4 ++--
 security/integrity/ima/ima_policy.c |  7 +++++--
 security/security.c                 |  8 +++++---
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 3422726268d2..1988b728eb3a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1837,7 +1837,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 #ifdef CONFIG_SECURITY
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule);
 void security_audit_rule_free(void **lsmrule);
 
 #else
@@ -1853,8 +1854,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 3a44abf4fced..509eb21eff7f 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1327,6 +1327,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
 			u32 sid;
+			struct lsmblob blob;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1357,8 +1358,9 @@ int audit_filter(int msgtype, unsigned int listtype)
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
index 808c2515fc6a..27257af4a8cd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -426,6 +426,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		struct lsmblob blob;
 
 		if (!ima_lsm_isset(rule->lsm[i].rules))
 			continue;
@@ -435,7 +436,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = security_filter_rule_match(osid,
+			lsmblob_init(&blob, osid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
@@ -443,7 +445,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = security_filter_rule_match(secid,
+			lsmblob_init(&blob, secid);
+			rc = security_filter_rule_match(&blob,
 							rule->lsm[i].type,
 							Audit_equal,
 							rule->lsm[i].rules);
diff --git a/security/security.c b/security/security.c
index 214404a78db1..3a2529f36269 100644
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
@@ -2435,7 +2435,8 @@ void security_audit_rule_free(void **lsmrule)
 	} 
 }
 
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void **lsmrule)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2443,7 +2444,8 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void **lsmrule)
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

