Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBD1DEFF0
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495354; cv=none; b=BwJzzKSB8mrrz36rcsfyEN/pEm6x4d8rHPMb5LDihOsHdzCNFOkBERPgXVNH0wnHcao46gyQPGer3ZjmNMVTqVcD1Eq9I743PNZf7ZNgPeX/wSqHqm/P808//lTQsRZJbxWgwFWCTbsGtxUlxgxlo8mkG9UlTaaQYR4psKlEKKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495354; c=relaxed/simple;
	bh=aUW4xA+Wx1ncwxJVWsFDXPzjBY+M2H/fWTJDCHhD/qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmxgiZtezqb+hJRD+mAPKpfggGD1NmA0sjcR6m2YKGur+jS9fcoafc+1yUeXDnjw4vYZaxVf19uLJwNzEtrqLuN+rcfgWFYZkRDml05+OGmjriakUeAEFlb6lJ4nZ7mWZxUUqqfZ5Y5Xdo4NbvhzWX4/isjBTP5mF9V0b7Ofqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=T0Qy+NES; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T0Qy+NES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495351; bh=+Hv67XsvWeSVX0aZAA+tmxcn6ViNbCsachPardsd6lc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=T0Qy+NESnXLapWafrx5rq6SXKE3YbJd9xYdb4YSeTepTMNtDv4kZO7LfKAZiOqvzMpYNgzC5WNAbt+1GL2IjNa6aNzqPNzvOZxzEV+QUrsDeo14ePUMttfDI154dvf0NCJmgE+S5lPD2gPIX6sNrDm5qvCMzJXE9FK0oPWDQv9SKja7Wfx+1VzRh8Jp8B6DWhwgRJcvEv4AW9rWjEhJWIDDRb9F10moAYui8SQYnJJKQ7I7MTYit/tS8VwaM0IMefaPOCI9A1A4Pa7NTKOIIG20NwD/Uh9jv7o4haVdiMFBWIJyNG2udOT422uT/qJNWpBpDjJF1rYyJpeiBOaMkBQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495351; bh=5Cw+UtjBCGcSqu54YQiePqvNkTnSVLcz/9Ty1GuhUdR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=W39rHLJrncluKzLsPZgLxjQN9DlKoQFMTDdu0BWsJlxlGV3ZUNaNE37KKWg8BEnWszzY76yo6d6Jw+5vaMIaHmCMhJS5qCUE7f8nZDQVQSjIK6Pltw7949ntWNodP5b2jLIosOLtQL+r2l4xjHkoLREM4QlRYODGANbpUY+fH7N2PsUKGJ3SOeJ21IU6Go3F+7eU13RT+mxNhNzr16iJnMtvlOS+g2ULKGDydkDxVfwaEzAqpF4cAVI/efl4BcOJTkQpJ+ezRevwW/4aJh8yXH7XWmjmrIMuxP1qaJplyb0vpjU6qwUPWfUs5FC5nOxpZrfbTDDothgmf4oIGd+s4Q==
X-YMail-OSG: Ybi2eCMVM1kukE.0PO0CVVVO.g3AVRwv09WjEXvst6DTnj9VgicWVV4ScQLXmOn
 O2V.uYrNr3TuN0WEKM6HeXl69K2tdVYT8uIuGODPQGnf390bBROK.9q35Sy7jipwge.R6pu.lbaH
 TnIvuWc9jhHK2Ye1lIIG_gaj.oW5urzC7BvQbXaRFyHVzTnYdZmaNhvs9lCv.BYepCrYTA.b6nt6
 kPYZ2Q2NzIldrzJUeykDkvhLz1c2s8d3L78J.adr13huu6C0Y6q3FulWKB8drpPB3XKmuL2fPgy.
 KJUVbgySDxvYDR6svreyJ6wBZBKqwveBtSiaJ4MqPM4TQnpkGzJjSnZHFtrpmGltok5bnZ64Lifi
 CIspkmAl4vXVQjgl986aBnDiArojazvKrw2dVGYwVyJjP3gSJj1JHlecg9klp4Y72DjLtULtb0Xf
 RbytX4qKMxTWPwg76HZeXTrqD0bYny6lOZmrVl52QFpzy9PKH3IJ5fBTC.bEUrm1VkrTqHcFmK3i
 JDu7T6eOJvc3crQRVhfN8YZ3POMkzrn1vZAgi48Gb8zB5Lh6zOTrKDju7zepNEN9_Rr1QFZl4AEV
 OYlRR.t3mIqmIPbDfs2BxWJQQmUVS.x4RxixQ54F_L.ZxmtoAYHSMpsQJa1sU2IyumhMb82Yj7Bp
 FMulyUmfQ6aS821heKm9BWnfEVtUktL8qzvt0fZKvX3V.At7FVXqiuuyVXtMLXhFf19CVlOzXzQB
 .BltL3q1bz1hA4KWo6dEa802m.IwYkieMxXOnDwPfX_zCGszsBPmm1T5Kjez0iWlVHQvLHCVaeEi
 yc1AIgG.Bm5qfAexk7hLjfJ4FBIKsd_A.TSSU8CIwzsBlQSCNd_o_RuDNclBNbzdbFjFenmc9b2E
 Us4rRcTB8Z.nU9hXZkSp5_EioWfw36PY7b4QfIqzubbWY.lw_k2mFuJsGn9a6KhRe0LOTQ7oQe9p
 .33hRkdddulz5HWkgIo_5JtpohdbNQa39SndD5tc0Cog51i_rB_ylZ23ErXJTTD_fDL9dJD4644k
 IiUojFL9RHvLrhXTOLomqEH7XDGTCRW4dCS0PMwxFsI50ZpfRrowYxHqkOgIml_eksj94iGiHo4M
 zDQ5G7SOy7IO4RRyd9uOlkiE1IdW292pLrZZHz_z5UMa7pDz__jIv0pEQYboWMo8GZ7IaNEaobVq
 pcFbdivTY8FxKg7iTJrEaYiueKNuBKLiLRK9OMh5sSmUcKQpbtVhMj9Q5skucfyYZlpvnY3KNVB4
 KWpodm4FP3cshWDTBuZfqGEKdDDumeNHINwNSrTUM7XuxShotMv3B2s.n62yWpRWsy.Zz..kHn2M
 fk.tj8630539K1SAA7wcBOqOGDvlqk1XCGp7OhV_YYe2Vxm_m76g8blKB3MJoNfgzPql9XpdnufH
 6FDDjNkHiT.Ev6raXxdno3L_7DQA4gAwtlVh78SZWD02I4QHSzo8CWpfeAP.pkgUNrHT6wXTz1wo
 zCIZF53CXYcUPRGewpGqfk6I3k0ebhlcs_BtOvJTaa5M1vkvLHQXmp2j60YavsJM.N2SnOTuxQcR
 809.Qh_eQ3pJWctGgoaDhMoN6UVtYY8_A7G58mBEAj842FooJSLscCDqgYNfsvy_.LT6zFU_Ghpc
 961AyksO4KS8LrIHnXjAbC7PnBFCfxsRLQxE4M8UONW9rIjXdWN1VMoXTtSUw65K.F_6DSdFLa_b
 RGvp01q_PSi67BtZOVyTycjzPCp5F39w4XZUTjrmtYQPtZrLsMFuGpqaExWxaaaRF2xprw.NaTEx
 KA0gyEYSt6jhq1Xar7sPZvZAXxYbGPPt_iNp0egyMJOfgtFC5JJ5XIAUrR7C6dXDVhyGJIMuUEzY
 aURhu4q829K.58lzppqHMGjYvAA_vmNVKNfDjz0pLlD78UgWEDQIyKTtfCNySz89elqKjJe5Is_p
 zAX_i_UDny32MHWk2sDo994dgj8e.Qu8.tNbv19op9efvCriIQBoopPb664TXLrl8JeXOGYYAQUN
 ngrE3Diei_cirhMx1vSde6wh.Lt4odTyJV8_01DxGe89jG1qLtsNHWMUFQSE9G4qgBF3kgNwKxhj
 sbxCMr0put.Zgm0Uj89g1wR7fU8X2dOMHDD4QtxJaD_Thq3Wu8xnlGaXQr8KSIeP0yykhrmD2JYQ
 z4tyqnKLa3C76PUK6j90eszlragPNWbdryslyIOLGTfxhyLKlqjjjMrYnoxsn7J5KwRFwSWFKBVu
 VieuLxcxwR7X_7Qc34jAWHhZ8SHkLAMIJVV80rTGhrJO3qfDl2sOSThaOsgzRBU8QkUhhlxRWXLp
 nHBOM6uWdL2XDEhfmrd1KP0ZnfUilD_s9rkzu74zpWmAK7m4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 007089bb-01d0-41eb-980b-00009281c11c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:35:51 +0000
Received: by hermes--production-gq1-5d95dc458-rvnnh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 502c2859a32e83ed73c2b19ff921ebf0;
          Wed, 09 Oct 2024 17:35:48 +0000 (UTC)
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
Subject: [PATCH v4 11/13] Audit: Change context data from secid to lsm_prop
Date: Wed,  9 Oct 2024 10:32:19 -0700
Message-ID: <20241009173222.12219-12-casey@schaufler-ca.com>
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

Change the LSM data stored in the audit transactions from a secid
to an LSM prop. This is done in struct audit_context and struct
audit_aux_data_pids. Several cases of scaffolding can be removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h       |  2 +-
 kernel/auditfilter.c |  1 -
 kernel/auditsc.c     | 31 ++++++++++++-------------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 8e6f886a83a4..0211cb307d30 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -144,7 +144,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsm_prop	    target_ref;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index a7de3dabe6e1..bceb9f58a09e 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1370,7 +1370,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					/* scaffolding */
 					security_current_getlsmprop_subj(&prop);
 					result = security_audit_rule_match(
 						   &prop, f->type, f->op,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 53fbd2e5d934..f28fd513d047 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -100,7 +100,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsm_prop		target_ref[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -1019,7 +1019,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmprop_init(&ctx->target_ref);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1093,8 +1093,9 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid, struct lsm_prop *prop,
+				 char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
@@ -1108,8 +1109,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+	if (lsmprop_is_set(prop)) {
+		if (security_lsmprop_to_secctx(prop, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1778,7 +1779,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_ref[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1787,7 +1788,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_ref, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2722,15 +2723,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsm_prop prop;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmprop_obj(t, &prop);
-	/* scaffolding */
-	context->target_sid = prop.scaffold.secid;
+	security_task_getlsmprop_obj(t, &context->target_ref);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2746,7 +2744,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsm_prop prop;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2758,9 +2755,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmprop_obj(t, &prop);
-		/* scaffolding */
-		ctx->target_sid = prop.scaffold.secid;
+		security_task_getlsmprop_obj(t, &ctx->target_ref);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2781,9 +2776,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getlsmprop_obj(t, &prop);
-	/* scaffolding */
-	axp->target_sid[axp->pid_count] = prop.scaffold.secid;
+	security_task_getlsmprop_obj(t, &axp->target_ref[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.46.0

