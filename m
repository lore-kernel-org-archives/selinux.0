Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE051A7050
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994306; cv=none; b=EG4k+HVXMbMD5Jt3Yx0bED1HR6qfZiE2SRd0eN7ClkXUrb7PdrF847INE5aPuRNz5Y5W6MKfWSNAFl8UKuqJc+7UhPCDaVzn990Vyp+pu0cf18IhtdEyXGL3PYSXs7WTrXVGF0Na6StcWiPmsvwiNTjbCO7Q/rqjNo5Rb5rStSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994306; c=relaxed/simple;
	bh=7qc9JorSmfWVdJq1DUXlimW1CCPnpxmdmIckk8hSH4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz+crkduxIIzS1lFbcvSVdNCC3uLZX8N0nGdh2aqxN4sor7Z7Sa+ptLVSjY/ecxYGAxtvAd3pCAr11rbbSysy1bVKXLE+9XYn4bglfGNJHfA1/LVuGOFn2EAfsD4gOSsDX8JUMMTS0Xovw8g9NTyAv52VKA7HWlWQo6cXPTzqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AXUKTCOa; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AXUKTCOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994303; bh=eNIqODIwb5Z0TaDBShDLo+MG6VB6WqmyGov2loH/JmY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=AXUKTCOa1j508cSN/cbwBQQhzH9nEiELSsnXc2lP06BI4k1AwxChReaIQc6G5XogqWJACODndBTr7lVZXziIHmv/PGt9u/G5STosjnG66orC1iXT3pSx4IxUkv8CofFBJ0KTTBWz/ToWEa9XuM6FXAawJL/78bMyA1CwCApihC9oBIr7AxXWTcwFl7DXvodTAJnM0L0/bcm4U68Ncrac0t73wkxTyGnke2sHA67XdwVbSY1ZMJiBwrN5cGOsvg1wH293tI2NqHfh0wj2kqA2+EHaXt66uOjBIKsMzTspnb2ZS+v7SbTAzjHNJjhAwj+6HwQCa5N+/IcJDAiyBUA1Zw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994303; bh=mBO9y9+/cSon3Un7LGcpiXg6yXKw2TTnyAgpC8Fw9Q1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oPHFsVFH09qbk6mIi4u6iU5PnKgvhnN/SAyl0phRBu5AbonIuJfvPyZ3S8Ea5HEKGuTsjtLDXskUZ2yHgu33Zb8ZoGjGIHiN4UA0hG/6fjAaDdKMoP/wYTH3J7tzxHHXU9pXbD3LAj3NPDHgEA5kZ+AefPxcOFALnz++yOOtYSHJBLf6NHbmmbh/RIru9qGAjFtK3e4qNtc0cDUPFsPbG8Kms5KNySbHuAPw2Sy6YN/yhtJ+9/ilZImEpwiH5gvZC57JWE87dCGRb7hfPE0e/cp+VE8N6uppFZHcFLO/89JBjHB26HRahuDyhXGSsW+ltXNl3BQqNr0+vteOlb4OvQ==
X-YMail-OSG: 0ZlHBbAVM1ktOebx5eObZw8W33wctSfPcf1Mkajr4Njw.1y2aRoF45zmCvP0VqF
 fdVMdOw9Hmx8YU2L8fVIuuH6v1vrcVtsjqoSSd4_HlkAVVj47UTHkxzo4PsLLB3iwQ02IbFjTugt
 cxelbIWtdChg1bFK1e.6fCir3Gbsa3zBhM6Whm9VVE6n6Mk1138VbdHeNFOSoGtTsycc1FbEejTM
 uSP1e5JH8OZK5axeuHV9iSGYnevf_FpnmW0B4h5iPtqCKR1df8E6GeSQtzcQi1uUjtDoQ3eTnxmU
 zIS9tcjZipb7sJTPpHuqYCNH9bf3UcYUd59QGMSyJ6qT.fsqGsmcOO0zD_GxkjheRSxD8Ni5nb1i
 6XOCWYZmqPGJcJQDu2_POOP0AIGordJYnVoEFF8DVbJNsjzVDsY9VsupzJMvX0MbT.7uJeBu4Y6U
 TRXODwEyq7Jh6migOvKxxexp_GIHxiFeViPux2L0.FGOSr0So13dI7HaOJzUzGQVAlNeIZfdLUyc
 MMe3WJNe91vZbLr8AzPt2jK9mQJ9Ii8hVfw1_PPp0RBgb2Phavk7mHJ8yZyUinsm7Z5pe.l4hg7A
 GaZbBylctDxXpIafnBuWbUm0egPEfQ7__GdlogxgQZAlLYyqbMl4EYMzFEmcHmd66gh7tzdXZeV8
 O7CqhSNCMbLOPOVseLZlbxTTMrj0Vxji.t4IMwHhsFzBXU8gH2I77t4p1bxHxMXGaQSq1EVEvuDV
 6tB4IvsIWLpMwEDb7Rp59btyJPFNlqYOUPbxGjj1aGhQ3o6.turf3SleS6kK00TAz2hThFRJtKIh
 6J09V52kx26b8YxrBEC3lo2HCwQE19CRNIac56UGRfi6INomb7OAjb1xW7GR8noXSsQgPs9SScIK
 RwzfXR.QNW6lIqcopCMxoWi3g6XBgpueTxeRSlsMQep1FXWJguNvVnMUNeD5R9QUC74Af24bMWLa
 vlW1FQtxQM7u238jz0Q6W0xR8NfAhFNxgfz2SzeqcFCtcNLMGEqMOTDxXqunlxWtWWVdwjy1xyQt
 FgBx_n5KzAw5GQQOFrHsk7Jflupd5LuUK_O.41ke9Q0OmTtjQ_6HV44gQ.smbbsMcC0UDAnzwvya
 QQcnNF0Sy.WRcOEJXuNcubvyFyiaUZKaBPSYfmuklB1F_NKevRv2Hnzx5IB_ssI74h_MlKZAMn0t
 uVkuMHRlfYxEfWyEcJd87bphC1kayrafseKNoOgmtdbLwFv5A9gvU7x0Rlu0jgrzyoLjv4I09vQi
 8AOkXlb1.1s3Z2azsAVmfwjMO3w18SA5Vei2BztWE27zpYkpwol9Xl0pezFfmT6Od7vGhPF0hPKg
 GO5sZE8M1xK6EJGcMw7QAREMoX2tWS8zOImMkCuIXrVgkBM7FLVjjw.iG3f76l53jtxAkY5f7QVH
 3GpjFCmKt9aTbYBNay8PbfdXMwMbmD13hbLEEiInQ14yqaNa4sDCYTIkfqkhfWKshpQSzeSrGN_T
 3ngsK_LZWLoc0qzY6xXZ80iNG2WJQm4qKHJ01dzG.aU5NsEIdf2xRMPF7S8KgLke7gkJWzx0GJsR
 Ll43fIcf_AwcNy4RRvYyw.0VWmzxzAQjX8U0XPg.IA2dRqJWqUyuKiqcP2j9KXDb0io5rkXwmbqo
 CkQ4iQx5hrkLZuKVfeh984E8JkiOimiSuEdzkpreY_mkyo98W8dSiLMTcC4UlX1pJ0M8Ud89Z6Zu
 DLo2pQJSZ8opCvOvMb0XA_c8CuhTfAs8.eCdGUkQk5HrGKYYfWOvPycIj.HwrIn4eZGXY3A5tVjW
 GznfwV7kJeBtteEb.lBXt213FUnmLGlgAfSoH.L.lW3waohatwEOEDIn1ESU3yAPIrHGuw1VgpPE
 __dWTzufvMrUtDuWMysHCX7MX_fvKXV4gbK8fAFXpQfw.Kib.LSU.wEQswuox4ie2.lvjs_lfF.n
 ZYKXIqBcVnUhojIOvsajm.ew.yExWTHdx_D4DZCNRSh54Fq44.lYZ2IUbh1M6sqJiXBZhQo7ZIeW
 kOneskisb9KmH6kLSaOc4HZLpg_s.aC3jfruBM27aXS0qqel7bXTr9swvhlYatyfGLTrHnGiS4sg
 0npOZoVat8B62fks2KUzS9vg2cJEIALbXt7vRA4YXOXsFLL0mktSNQgMQtteXb149xlDEnnbSrlk
 TAz1z5LWi0_NfnkHGhnjFba.TThfIuKAXiHPvPnQVrtD6k1pxWLzRBwSkmTb6kr633XnA8_tTbTF
 WmyepDGkCPVAhgIAFnxkW4l5IczcoMrryf6D3do_yr1fKANJNKxX2PxwKKMCtiCXGrS37zvd3hP7
 PVVXNTwC0U.CEM7tzI1o2tqA1tU1XJEh9y2nI
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 84a4c829-496f-43a6-9fbb-99adbec75e1d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:51:43 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0f4d83cf88f6912abe79246c392d6ed4;
          Tue, 10 Sep 2024 18:41:32 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net
Subject: [PATCH v3 02/13] LSM: Use lsm_prop in security_audit_rule_match
Date: Tue, 10 Sep 2024 11:41:14 -0700
Message-ID: <20240910184125.224651-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the secid parameter of security_audit_rule_match
to a lsm_prop structure pointer. Pass the entry from the
lsm_prop structure for the approprite slot to the LSM hook.

Change the users of security_audit_rule_match to use the
lsm_prop instead of a u32. The scaffolding function lsmprop_init()
fills the structure with the value of the old secid, ensuring that
it is available to the appropriate module hook. The sources of
the secid, security_task_getsecid() and security_inode_getsecid(),
will be converted to use the lsm_prop structure later in the series.
At that point the use of lsmprop_init() is dropped.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h       |  3 ++-
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                | 11 +++++++----
 kernel/auditsc.c                    | 18 ++++++++++++++----
 security/apparmor/audit.c           |  8 ++++++--
 security/apparmor/include/audit.h   |  2 +-
 security/integrity/ima/ima.h        |  2 +-
 security/integrity/ima/ima_policy.c | 11 +++++++----
 security/security.c                 |  7 ++++---
 security/selinux/include/audit.h    |  4 ++--
 security/selinux/ss/services.c      | 10 +++++++---
 security/smack/smack_lsm.c          | 11 ++++++++---
 12 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..0cc3c34f5bdf 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -416,7 +416,8 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_HOOK(int, 0, audit_rule_match, struct lsm_prop *prop, u32 field, u32 op,
+	 void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 1027c802cc8c..736fb1f87bf4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2071,7 +2071,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -2087,8 +2088,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
 	return 0;
 }
 
-static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
-					    void *lsmrule)
+static inline int security_audit_rule_match(struct lsm_prop *prop, u32 field,
+					    u32 op, void *lsmrule)
 {
 	return 0;
 }
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index d6ef4f4f9cba..5b47571ae4ee 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1339,8 +1339,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsm_prop prop = { };
 			pid_t pid;
-			u32 sid;
 
 			switch (f->type) {
 			case AUDIT_PID:
@@ -1370,9 +1370,12 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_current_getsecid_subj(&sid);
-					result = security_audit_rule_match(sid,
-						   f->type, f->op, f->lsm_rule);
+					/* scaffolding */
+					security_current_getsecid_subj(
+							&prop.scaffold.secid);
+					result = security_audit_rule_match(
+						   &prop, f->type, f->op,
+						   f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..effb1a7e0405 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -471,6 +471,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsm_prop prop = { };
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -681,7 +682,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				/* scaffolding */
+				prop.scaffold.secid = sid;
+				result = security_audit_rule_match(&prop,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -696,15 +700,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					/* scaffolding */
+					prop.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								name->osid,
+								&prop,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						/* scaffolding */
+						prop.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								n->osid,
+								&prop,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -716,7 +724,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				/* scaffolding */
+				prop.scaffold.secid = ctx->ipc.osid;
+				if (security_audit_rule_match(&prop,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 6b5181c668b5..87df6fa2a48d 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -264,13 +264,17 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int aa_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
 	int found = 0;
 
-	label = aa_secid_to_label(sid);
+	/* scaffolding */
+	if (!prop->apparmor.label && prop->scaffold.secid)
+		label = aa_secid_to_label(prop->scaffold.secid);
+	else
+		label = prop->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 0c8cc86b417b..e27229349abb 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -202,6 +202,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
+int aa_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index c51e24d24d1e..f17213520c36 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -555,7 +555,7 @@ static inline void ima_filter_rule_free(void *lsmrule)
 {
 }
 
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+static inline int ima_filter_rule_match(struct lsm_prop *prop, u32 field, u32 op,
 					void *lsmrule)
 {
 	return -EINVAL;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 09da8e639239..22a62e675ebc 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -635,7 +635,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsm_prop prop = { };
 
 		if (!lsm_rule->lsm[i].rule) {
 			if (!lsm_rule->lsm[i].args_p)
@@ -649,15 +649,18 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			security_inode_getsecid(inode, &prop.scaffold.secid);
+			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			prop.scaffold.secid = secid;
+			rc = ima_filter_rule_match(&prop, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..e06817ef4304 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5399,7 +5399,7 @@ void security_audit_rule_free(void *lsmrule)
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
- * @secid: security label
+ * @prop: security label
  * @field: LSM audit field
  * @op: matching operator
  * @lsmrule: audit rule
@@ -5410,9 +5410,10 @@ void security_audit_rule_free(void *lsmrule)
  * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
  *         failure.
  */
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, prop, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 29c7d4c86f6d..7313c92d479b 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -41,7 +41,7 @@ void selinux_audit_rule_free(void *rule);
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
+ *	@prop: includes the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -49,7 +49,7 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..74b1aafda399 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3633,7 +3633,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3659,10 +3659,14 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(policy->sidtab, sid);
+	/* scaffolding */
+	if (!prop->selinux.secid && prop->scaffold.secid)
+		prop->selinux.secid = prop->scaffold.secid;
+
+	ctxt = sidtab_search(policy->sidtab, prop->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
-			  sid);
+			  prop->selinux.secid);
 		match = -ENOENT;
 		goto out;
 	}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..7868268032a3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4776,7 +4776,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @prop: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4784,7 +4784,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+				  void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4797,7 +4798,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	skp = smack_from_secid(secid);
+	/* scaffolding */
+	if (!prop->smack.skp && prop->scaffold.secid)
+		skp = smack_from_secid(prop->scaffold.secid);
+	else
+		skp = prop->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
-- 
2.46.0

