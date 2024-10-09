Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C301E1C0E
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495764; cv=none; b=CczJNPaBN7owRcZtji1GlY7hZMTHsM1AkqQ72sjkS1A5u2Smv09HvTOGoEyWzcnCfAn0uVoX38JK1wwrinScMji8399CHElef0ojHKlHehUXJ31tNo8AjokZvomJ6xyKbsh9BBpY0nmFNXlmA4zxZJRDgl/cEffs31MwUzap3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495764; c=relaxed/simple;
	bh=q4mjOQYEqtMbTca/19AT8rHt/iY9VcZk7G57jR94iLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNISWlMpzWnFY4tJcZK5u9j/UbjEfYyGdeCXRseaGORq/o/yjw33s/4DgE2EB5/KchTSRDwv5NW4jit0rePqzVXPnhwNOsxXptMQwbNiL0ZnE/KdvPxEsPMLRorR0noBAclQ6t2N0Vx6Yaq8Zynwme4O78p5AsnJiCHLgGxc75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FZRvF1gD; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FZRvF1gD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495760; bh=Kqe3nwRY7L2FLlJFUpkZB5O0bZMH3MXzPtGSPFBiFDc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=FZRvF1gD3tIkCco4gLV7KT7LCEHqagmNB2zJhNK7adjla9rno9I6cWRwwMDcZRQk2qIDjhi869Lphl/oDw+zI4pxDl/UZyUuJy76j5RGguMu1VysaywpQm0DGgEhiB6sKgpNEbs+G8Lfk/7cbir8vxVX/07sX+CZu+ci10+uaD8Forr/Ik0LUDkQTbdXDfsK7N3MlbiL5BpbQnxEOmK2VXLWM3N+Bih5RJq6faxUrpfe/A4bdnMJXM5c6/ElQ95NMPqAm0DOAWouJgTGWvykhCJJvp/EdftrgJSxj3tNVg1JBm2J4I+Q3+3ucLsb8bgXPRpZbkOZ0sVvV4LI07OoBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495760; bh=01SoFnmA78whD4gkv//ZRhrsYVFG36lOP2WRvWjmnnf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YC1Rg45F1ntg3xwFK6miFp9L09Ltk29zxl5fiRjuUQjro8t5SKQqQ6/FR5nF+64u4HbAoQVUU5B64AeZycgkhd6/BtEbiQsunJ8MmXtRRfqPbST1sH90UDgflRrX4l9JiHyp+yov7wjHNMHoxicgyoqbB1zr1MRApv0k+am1mxAbHK8rRbXlE+O1rMS9h80JuPqOkXnr5DbklORfwAi0Sb0sXZ5N1S/O2hrc/tnavhpCoGrKC1tJx856tTVN8twzM8StoRC4Pvdh3llZv59FMftMaxYxuoNdd8YRhIBMelCoL3fHTIQtud9I6iIZyu0Rt+1Ody2uVtHlEtjNIFK6Cw==
X-YMail-OSG: FDKa3.wVM1lebCCsGrhIUdOq37aw17qErvmj9v6JMQSN16p.VvNLvQkLh14mr9U
 xBPpmU8kENpE8CXVr7z5FWnJGgBXilog.rFkMZFF1oRiVHWTPM0OhiDfHpey81LNZ4leVj3y_1yx
 jXeifZi0f.GdDaV3UGUUmHl0B82S_dXyOPL9tTC9xyBEmnH2P2We76HVM_iMqtp1koqtqAcR74CE
 2rjcn_SES9vi5JFh7HWm6MQdHKmn7ABnRcOvafMETwanYsccwmstihSAC.NxRWufDlGzw8HqaRhK
 ZacuJ6hRCZhLxuTK62SFFHzUhuty.alvoy0rv7h5EBoQ452Cpu1nszN2Jm945gbeYdA1BPDWYCFZ
 B_U9r0ovHiO.IepOPUBgubXgpaPwrwwGtG3Uzwf9MXLLopiPfHclk5lxQnY3ku5qq0Dl0YaNqY4_
 _tB4AqchtcDJtj6bFD74NE0M35KjEBEuO4fCV7aGg3y5sFsBNiv.QyGDpelk_vvhO6zYT_5eVD5o
 EYtnJAdZuxxZi69Ea.tcYbHTK3RScaX52hUmaLmu7kY3MjEfP7pcSaC.zWFAWA_OeQATZQMg1URI
 lTiiXPsMHQKbYFvFrtecCZj1KOzxgOJJOR98oQqbHPwjXoaKSbBJ3g5QInTi7fzMD8gmOPRV.vsJ
 IXo2Oe.JqNV.84OM1urCtJGurqmOxWmqvrTovKQXnfcPIqpysbm59MsK5EXRE5hvfm4rCd9LXKxP
 eeQZAuEWSWPnSbTRkLz7j21Jbt8psK.OFpsiPsDOyEhaOvWPgM_XYSg4cxAgJc6vcCPLwMpkiXvW
 lEUDelS1ZCMENzS9MlyIMRZZ4ksESthkALjt0fRMPEY8DDjClS_cYvzVgqX5ixP6uZot6JbtJGc6
 fHaXTlsnQslE_LvlwpO2geOAtB1oVryLoiE4p_D2WOu2uX8omWtT4gyTp7viNzvfDgft4htPVcDx
 CmLZr9b8DBgLivp9f1S72Gc2z444cKkXrZcaz3yZ2gsqEKsGkTdXFfKnoUCt1hefOGmTmJdlJPcC
 BCMFnch90R5SbgAesqP_15..kQ.hB7TLNyGLBIQQr0k9aFE5_5oAXLkcNRtCrv3s1X.7akuEA2d2
 1mDinqTkpC7LrLfRTbX2SlYomV.azRYRyrStUfDIzFS9OZqi1QU48wyFL7UXpzpodD_ObskcJIj8
 kFX6tVyWOwRdomFm7uz0BiDCG..kIinMOcn51bos8qU2PZ7d82zCRJjq3._dBNpartgIaXMHMf6c
 UMHTaygBXr9zWfqR48QzXezNWFTssmcEHcbglCJfxTaU3.8P4s5UTauc5KvYuy1e94d7grISPgz4
 gR6x5g9feks1ExOuMx2.6xzVNsl2C8YJ6yn1Jm5uurc0WG91jf.aghuWaBHHmVUMqrZ8nQhwR4C_
 4xLvoofXR1y9dCWNuLNbe1TAxeM341bfxffHwJq8UHcKsrSVd3mBJdM939yuWjP5MLs9sIZqWhs3
 cTdDnrh.z4D_UGuDA17pEXQjC9PQEjbbN8jQbb7c2mmPNGscogyuhTuxZ66xzHMNGsFH1vF0j2gX
 Y2RC64b2fBPDVUxKy2Vw8ksPUgRRr0Mv6qCga852H6SBm.PHNkDNBeKvqCehpzXFdv1AoGrJe42p
 AG_oYaQ7Kcme7rDYs8p0dTT1LA9JqivLJ.IMK5NsqdPjMrGcDgkuByd5DVr1_lhwB8n6CmcPlZiO
 pNqRuyzJCGXqAirdAbufOJGnu_E8Wyk67CAeUKl.KeYd3zUDAHf9biuLbincuYlJHmkwdVV1yLEs
 rUOTmhKKUolLTuN0cIVymBJ7b1BOdOOu3sArMwA5VqeJhlf2fD6fxXDo4LsrSeg53m80RnQA5VfD
 zbGQU.wUCqG9GmE.YgqdYK_IBJ47syNlYE2RFPmR8FtZfTKqqKznJfm5XQPrCf0HaOSrir23dwtQ
 dqwi_aEurkjQ4aVEsT4W_SRiWgolCwguIiekm.dh6jSfoA0YNCvkm3sq5lgU1d8rN5EVhtkOnO3C
 j8RUsEnYZagyY76N0bIr9Y.jrgGu3CUtQSbeeB485l8fkGNuu7j4bHqMhqrDxeTTV.Q_FJO4h1S8
 RVXTxTx4NUWodMDu1TjjfQJe_mfEovHvNleMHzyF4inTb5lX4yPPjasmMmDlTMYAMI6fGumxqT5j
 UKuu45Lu4D6RJp5nYBLaMPeKtPpraXF_RuNO9zrQuOez54Yf5.79FsDyE0QgVgbEVEde.9C_BgDp
 0pLUfO552DZlQ4hhdgwmpVY4gahY_wUXpZCE2SPF2ZHL.9mm5mIrNsDUDWtr4ox.kWxbjBaDC7w3
 wDvMr9gsh_145vZlJpAQi._f5O8NZjD864_1Rg5M-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ed5a5fd5-3af3-47d6-9082-e6de0ac57df8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:42:40 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5fec0e30966313b56a0d7e944fb52df1;
          Wed, 09 Oct 2024 17:32:29 +0000 (UTC)
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
Subject: [PATCH v4 02/13] LSM: Use lsm_prop in security_audit_rule_match
Date: Wed,  9 Oct 2024 10:32:10 -0700
Message-ID: <20241009173222.12219-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
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
index 9eca013aa5e1..ea7f17e37756 100644
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
index 555249a8d121..a4f020491e7c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2115,7 +2115,8 @@ static inline void security_key_post_create_or_update(struct key *keyring,
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
 			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+int security_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+			      void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
 
 #else
@@ -2131,8 +2132,8 @@ static inline int security_audit_rule_known(struct audit_krule *krule)
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
index 470041c49a44..288a2092fd0d 100644
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
index cd57053b4a69..aaf672a962d6 100644
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
index 3c323ca213d4..cdfe8c8c7bac 100644
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
index 6875eb4a59fc..deab7f912e12 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5570,7 +5570,7 @@ void security_audit_rule_free(void *lsmrule)
 
 /**
  * security_audit_rule_match() - Check if a label matches an audit rule
- * @secid: security label
+ * @prop: security label
  * @field: LSM audit field
  * @op: matching operator
  * @lsmrule: audit rule
@@ -5581,9 +5581,10 @@ void security_audit_rule_free(void *lsmrule)
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
index 168d17be7df3..c745ea2a993d 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -41,7 +41,7 @@ void selinux_audit_rule_free(void *rule);
 
 /**
  * selinux_audit_rule_match - determine if a context ID matches a rule.
- * @sid: the context ID to check
+ * @prop: includes the context ID to check
  * @field: the field this rule refers to
  * @op: the operator the rule uses
  * @rule: pointer to the audit rule to check against
@@ -49,7 +49,7 @@ void selinux_audit_rule_free(void *rule);
  * Returns 1 if the context id matches the rule, 0 if it does not, and
  * -errno on failure.
  */
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *rule);
 
 /**
  * selinux_audit_rule_known - check to see if rule contains selinux fields.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a9830fbfc5c6..e0c14773a7b7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3635,7 +3635,7 @@ int selinux_audit_rule_known(struct audit_krule *rule)
 	return 0;
 }
 
-int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
+int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vrule)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3661,10 +3661,14 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
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
index 370fd594da12..535233ad7203 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4757,7 +4757,7 @@ static int smack_audit_rule_known(struct audit_krule *krule)
 
 /**
  * smack_audit_rule_match - Audit given object ?
- * @secid: security id for identifying the object to test
+ * @prop: security id for identifying the object to test
  * @field: audit rule flags given from user-space
  * @op: required testing operator
  * @vrule: smack internal rule presentation
@@ -4765,7 +4765,8 @@ static int smack_audit_rule_known(struct audit_krule *krule)
  * The core Audit hook. It's used to take the decision of
  * whether to audit or not to audit a given object.
  */
-static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
+static int smack_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op,
+				  void *vrule)
 {
 	struct smack_known *skp;
 	char *rule = vrule;
@@ -4778,7 +4779,11 @@ static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vrule)
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

