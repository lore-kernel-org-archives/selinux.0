Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B6125D5
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978673; cv=none; b=iJMRLSdfGlzy24GS2hVmlj1r0ON02AdKlZ7GE8iqFrMRZRQ/uTA4bZAm2Zvg/H9g4Zf9Qz6oDOCOQK7ZjBU5cCUL0QQ74lLPuggy+ztHT9ZOnMRfBy4/pPZCSf4p5RipaSNYANKo9KCSeUsmwSrkn48ysTYvUZkOtaPYeDFCoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978673; c=relaxed/simple;
	bh=QCnWlrmiO+vpGz6umOAjYsHnufaGaApdJ15R98gx+0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N49TussLk1w4WZRJR2TPGhFMGC+Om1vnaDst1jJS+W/ib92MCaYjflZU8XI6rL2LDwyFLEokAqPSBcjATkR4hhRTTnB9dmEiwra1sH34uuyYDfUMy/oba/WDl6WPGTAJeRvYcIMkDJnpxYj8UyCTGdxL5skjc+4Ias3mtqEAS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fPVZyGVg; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fPVZyGVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978670; bh=ami00LGpMvU4beTg/vfyDHWjTsQNNUSgMQ0zod8cCc8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=fPVZyGVgoBist3zN5SkGpq5ad3ycK04xMAzqsGg1tX0Q+h6fkyE3BemCH4KhGR2tpc5HAibl4/bU/ZoxGcTrnGnuFb3YSeeFQ9jEj6pfcKj4G5HDz74BkvOUPAg6iOiHQcxDeb9gk6EMyKzjGyMsxwyL3VtZjBAKM36yvbGclq6+anun9mcLr1DmiHW3G3sKZd0ohEWZ/tj8bmMJHn8vGGtvkp1+mzBk6YGYiaKM8MsYp1icM2Cx08iIR68Q0zzhKZg01g30P9hF8ji6UJk78qOFbUW3FKXi0QYJLQH+0H0PDOybpc8BP3qq5e/uMWSNoZwqKB7m6VrQYWfdru8tYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978670; bh=DeTKBeO/nBwaYZcNV2dh87ocSpPxjjeW+hhIqaF76LG=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=RcrGmpVnjnSa94ehH3+Dcwxk9MmbSO8qCPTXbXISokj0L3XkGIyCIJbNtEWv13hFQ3Of/kjzNSYM/SxOqjpXz5GyCL6td+nnklmuW+lzshe9x4cb8oI2DYWbjUFR9F/TtJSfu6C0XQ5MVo3/HGh/VVqeOJlfQP97ttY+0eSlbUAZfNR2VX+O4fDCfru1hHdLVV3ucKzVXlSgvH0u20v7qJVdNUwJ86XRwMp15DAP1iJE/8A+RXJqoKc5TzR0tleIn33L9eI3qmlqaFu2bvRK7uJbiuUty8RxaN/Wr2aPpU0m0ZiW2ZBum2ytbP1ms4721B2dH75Wkak1ZNG20z8kiA==
X-YMail-OSG: gluS_kgVM1noljVvoasNApEUSyxnB5iodHEC8x3vSesyyBdyX2r72P2IyrLmTcR
 JnjzDiCTSkKxAql1int2mLv_6WAjaPAJoBitINZQOuleUldAWW9CK_reMzQtS1TF7kMi6dCwQRc8
 PS_T9zY0FLL6iE1InUOR8ZXCBgWpPXM.V9wSZoMzwSbDYTGpcQEyp_vZKsSKL5Sm5E8ocdtUf4lH
 NCrbmoXGgTJzDQyxN6xDsRNgy9i_Ow2Q6Ke5nLWN98Vvdx1MWlrKF82j591rlhTwvyl0kdeoPrSW
 AyPkt4mYNGszxAsVL7aLUWPkKbKPN06H_CVZW60TKJ1.WAbSKwe.G2RwRrfseWk9MbjBDmZVLVuO
 I01apig1_JrPXrlTeRLrhY8du79avH_lykUjLGJrSKBRAiBoVv3Nl450_OPBlTNXPAymLjhs1kf0
 NiIEyf.XFk3iV5R8xyCQXS58n5gUsR5bmEnma32AaueOjK34nxr3vCQDzk1po0exhCj6d1ad1dm4
 sz4G5McOS1TbB0tw77t19uk9Tk0lJ3FIy.eBLfYN2r3UM4fipyImosF90pJHvnF_YEpU1mNZyMRW
 i3S5m85uLRgPzW.q5GTAvi72sWnhXeKcLsuhRrdsiRgNlTRBFIOwc.zbk.7_rQcdKEu2OCQfZPeT
 owVIPZh5spqfH3VwbFbH6ER9C6dXZkja1TaRuT19JC8g.czTxqUMRULAVGPHS6MF53cdeyfvHgby
 M3ihLWg8SlJVG.thDW_8PHjtQOswjxM2BRpyfj66ZS3aP_9D90lUwlQp5.N_vdp8an2W6IyUHK4A
 6VhKTszv8mjTo77.RotyVuRkWPmcUy_RMC6xWoulXdK4DKx7_.ujMl8JCleEzVnH3132VZ35nwru
 5Bab5u3UE8LBtvyJI1JLJ0Ct_4cHzvwiloX1PoCh9n5bJclJ3E.DDoKjCldK_2ZtRXZnQY.vQiu5
 dnRwDfnPnI1GxR9z6tOXpqXqdvdN2ywp.Cffn2uyUUpCLO8VgXiVAFM_OoInl6Xr710G9ICK0VXz
 YvpJXhGBUbRISMdRKXUlLAtrKmfq1UMnZWI2imsrxv4o05JZEAdNnj2jRRfpWNEmAQxz8mbDFC9x
 LNhduV7fAKLgk4G9_WpyUsQoOBPFxCyutw184i8d9aw1WJtFJHo_9EvlaTdbfOuLe9ACE_oWK8YO
 dBaSD0MhTcWagCrRX0ClOvrZP3cP6TFs3i83Atm9PpvxigQpTaTXbrYe6PEhecDd.5haNbO5r8yp
 5n4VR4NFSjjTofRq8yFFu9feQ5Bv_nUMAAF89JiM9hxWMwLqhUvVuqUddHPeKxpQvhzwoLqso0XH
 s9tHVgq2RtHElNdPYwL2jF6hF9fE6mmP7qmE4MffGXk5jTJUn9Xy_oZr6h3gzg7S8i7YkJzOiRBq
 YdaJMxAkWqPbxTbDSD6m7sYYL1mv5OwrwmC1BE3hL9_MShoEWuD_LDBjP4yIesUwx0e13DFzYyFW
 xr2v.dd8SvjX5fwlWXVOp6ZBUCUfZflemj455WcDj65__BBbzZGyrOdGUE0O8GreiJZUzYsMocHH
 slxnHgqgWD4bxgB855gMcIUAwIzTRPs1L7CnDL2HkQpmej57vd8wqn6V6k.l5KDYjZ1QWnmRChyj
 gGJ9lG3PjpJFY5t8jlOmwGf8y4VVUFu.a3qc4QfhAvSjPLtC7Nr1Cy3deZ8Zq_CgJe6xFgafgkFc
 J8ScJ8iUJFcJbE6eyvU76nWtaNlpnffKZNOfFKkDCv.1PwJ06IC31USzgBI.I64u8QLeZB6FJutn
 fSsQ21onC4.QUCMzhpzvJ_hocBi5_OqhRWe2QtVT8II8vaUi1H8LmIyXJMuUb.kguWkYbjg8m8pW
 5VEtIcZK_wft0DHtubYQn4P25rphHFJuP3_l1Q.tQzslbbGkWNiYBdWBqd4PWIS6oxu7ZBaxeMmj
 dBu2o_4ZBRLpeVxx2w_LvjlXd3UiImQ6pplE4dT64cKlkkzHzb7YqQjAnAWs2OVWshd.KJMe7uio
 UEsoCAgLVqxxudUO55RPfxSS1q1j0indypvaI7QGMVnBOPdwq6ioDlLwofHQ2exUMFzHDiXA4.2r
 pkZFJjM6UZeauV_L_4Sf.0CQf5PIYdLspXplDbAYES6NciwbgLOL4QWwujwAe4zAdeGQirTEWNRN
 B368dWLLXA2UPRtOPABmmU7tXsMEaSI0uHbyjOxojfEWxRoT8pf0GN1J8j8dBaXcEPO4orqvj..d
 l.XaDOtljg21od9iUs4AwcAyq7VfCL5qS4gyvsCab9vSZ0dTLVTaZZrZfjLbqKjtYGwE0tc8p2oz
 1wddFjy2t3D4Aw.YlwQFV1jqM2_6RGxki.lY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eceda524-66c5-44e8-9a5b-569566a78d06
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:44:30 +0000
Received: by hermes--production-gq1-5d95dc458-gnv6n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5da78dbe3e0c562970426cfb16ce357c;
          Fri, 30 Aug 2024 00:34:17 +0000 (UTC)
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
Subject: [PATCH v2 02/13] LSM: Use lsmblob in security_audit_rule_match
Date: Thu, 29 Aug 2024 17:34:00 -0700
Message-ID: <20240830003411.16818-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hook_defs.h       |  3 ++-
 include/linux/security.h            |  7 ++++---
 kernel/auditfilter.c                | 11 +++++++----
 kernel/auditsc.c                    | 18 ++++++++++++++----
 security/apparmor/audit.c           |  8 ++++++--
 security/apparmor/include/audit.h   |  2 +-
 security/integrity/ima/ima_policy.c | 11 +++++++----
 security/security.c                 |  7 ++++---
 security/selinux/include/audit.h    |  5 +++--
 security/selinux/ss/services.c      | 11 ++++++++---
 security/smack/smack_lsm.c          | 11 ++++++++---
 11 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..1d3bdf71109e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -416,7 +416,8 @@ LSM_HOOK(void, LSM_RET_VOID, key_post_create_or_update, struct key *keyring,
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
 	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
-LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
+LSM_HOOK(int, 0, audit_rule_match, struct lsmblob *blob, u32 field, u32 op,
+	 void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 #endif /* CONFIG_AUDIT */
 
diff --git a/include/linux/security.h b/include/linux/security.h
index 0057a22137e8..c0ed2119a622 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2071,7 +2071,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -2087,8 +2088,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index d6ef4f4f9cba..c4c7cda3b846 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1339,8 +1339,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
+			struct lsmblob blob = { };
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
+							&blob.scaffold.secid);
+					result = security_audit_rule_match(
+						   &blob, f->type, f->op,
+						   f->lsm_rule);
 				}
 				break;
 			case AUDIT_EXE:
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6f0d6fb6523f..23adb15cae43 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -471,6 +471,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 	const struct cred *cred;
 	int i, need_sid = 1;
 	u32 sid;
+	struct lsmblob blob = { };
 	unsigned int sessionid;
 
 	if (ctx && rule->prio <= ctx->prio)
@@ -681,7 +682,10 @@ static int audit_filter_rules(struct task_struct *tsk,
 					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
-				result = security_audit_rule_match(sid, f->type,
+				/* scaffolding */
+				blob.scaffold.secid = sid;
+				result = security_audit_rule_match(&blob,
+								   f->type,
 								   f->op,
 								   f->lsm_rule);
 			}
@@ -696,15 +700,19 @@ static int audit_filter_rules(struct task_struct *tsk,
 			if (f->lsm_rule) {
 				/* Find files that match */
 				if (name) {
+					/* scaffolding */
+					blob.scaffold.secid = name->osid;
 					result = security_audit_rule_match(
-								name->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule);
 				} else if (ctx) {
 					list_for_each_entry(n, &ctx->names_list, list) {
+						/* scaffolding */
+						blob.scaffold.secid = n->osid;
 						if (security_audit_rule_match(
-								n->osid,
+								&blob,
 								f->type,
 								f->op,
 								f->lsm_rule)) {
@@ -716,7 +724,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 				/* Find ipc objects that match */
 				if (!ctx || ctx->type != AUDIT_IPC)
 					break;
-				if (security_audit_rule_match(ctx->ipc.osid,
+				/* scaffolding */
+				blob.scaffold.secid = ctx->ipc.osid;
+				if (security_audit_rule_match(&blob,
 							      f->type, f->op,
 							      f->lsm_rule))
 					++result;
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 6b5181c668b5..758b75a9c1c5 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -264,13 +264,17 @@ int aa_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule)
 {
 	struct aa_audit_rule *rule = vrule;
 	struct aa_label *label;
 	int found = 0;
 
-	label = aa_secid_to_label(sid);
+	/* scaffolding */
+	if (!blob->apparmor.label && blob->scaffold.secid)
+		label = aa_secid_to_label(blob->scaffold.secid);
+	else
+		label = blob->apparmor.label;
 
 	if (!label)
 		return -ENOENT;
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 0c8cc86b417b..c5a516e61318 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -202,6 +202,6 @@ static inline int complain_error(int error)
 void aa_audit_rule_free(void *vrule);
 int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
-int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
+int aa_audit_rule_match(struct lsmblob *blob, u32 field, u32 op, void *vrule);
 
 #endif /* __AA_AUDIT_H */
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 09da8e639239..40119816b848 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -635,7 +635,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob blob = { };
 
 		if (!lsm_rule->lsm[i].rule) {
 			if (!lsm_rule->lsm[i].args_p)
@@ -649,15 +649,18 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			security_inode_getsecid(inode, &blob.scaffold.secid);
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
+			/* scaffolding */
+			blob.scaffold.secid = secid;
+			rc = ima_filter_rule_match(&blob, lsm_rule->lsm[i].type,
 						   Audit_equal,
 						   lsm_rule->lsm[i].rule);
 			break;
diff --git a/security/security.c b/security/security.c
index 8cee5b6c6e6d..64a6d6bbd1f4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5399,7 +5399,7 @@ void security_audit_rule_free(void *lsmrule)
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
- * @secid: security label
+ * @lsmblob: security label
  * @field: LSM audit field
  * @op: matching operator
  * @lsmrule: audit rule
@@ -5410,9 +5410,10 @@ void security_audit_rule_free(void *lsmrule)
  * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
  *         failure.
  */
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+int security_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			      void *lsmrule)
 {
-	return call_int_hook(audit_rule_match, secid, field, op, lsmrule);
+	return call_int_hook(audit_rule_match, blob, field, op, lsmrule);
 }
 #endif /* CONFIG_AUDIT */
 
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 29c7d4c86f6d..104165e4c931 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -41,7 +41,7 @@ void selinux_audit_rule_free(void *rule);
 
 /**
  *	selinux_audit_rule_match - determine if a context ID matches a rule.
- *	@sid: the context ID to check
+ *	@blob: includes the context ID to check
  *	@field: the field this rule refers to
  *	@op: the operator the rule uses
  *	@rule: pointer to the audit rule to check against
@@ -49,7 +49,8 @@ void selinux_audit_rule_free(void *rule);
  *	Returns 1 if the context id matches the rule, 0 if it does not, and
  *	-errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *rule);
 
 /**
  *	selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e33e55384b75..43eb1d46942c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3633,7 +3633,8 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+			     void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3659,10 +3660,14 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
 		goto out;
 	}
 
-	ctxt = sidtab_search(policy->sidtab, sid);
+	/* scaffolding */
+	if (!blob->selinux.secid && blob->scaffold.secid)
+		blob->selinux.secid = blob->scaffold.secid;
+
+	ctxt = sidtab_search(policy->sidtab, blob->selinux.secid);
 	if (unlikely(!ctxt)) {
 		WARN_ONCE(1, "selinux_audit_rule_match: unrecognized SID %d\n",
-			  sid);
+			  blob->selinux.secid);
 		match = -ENOENT;
 		goto out;
 	}
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 4164699cd4f6..52d5ef986db8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4776,7 +4776,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @blob: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4784,7 +4784,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(struct lsmblob *blob, u32 field, u32 op,
+				  void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4797,7 +4798,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
 	if (field != AUDIT_SUBJ_USER && field != AUDIT_OBJ_USER)
 		return 0;
 
-	skp = smack_from_secid(secid);
+	/* scaffolding */
+	if (!blob->smack.skp && blob->scaffold.secid)
+		skp = smack_from_secid(blob->scaffold.secid);
+	else
+		skp = blob->smack.skp;
 
 	/*
 	 * No need to do string comparisons. If a match occurs,
-- 
2.46.0

