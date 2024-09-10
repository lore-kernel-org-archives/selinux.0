Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA671A76BB
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993899; cv=none; b=CNuNWRDm26QmVkzzDki318GeYL2OC7Hj6bP4QeiZcr4Mqt5fVOfjyJ+GbYzi6e3LTVfpjIVa74tnLD0GPqjhrdDC79AhwTKbZhQksgmCu800hubltbezhQQXYgbofJVQCRjtotkUUlIOTEKSz4wQM+5S6uMZxltdjJqBNL9BbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993899; c=relaxed/simple;
	bh=sGltIXfkynShpVqjz2ClAXpQvxLVAHMhGG5s9l6wHX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZTPTkKRiWnv5GnVAGcA5AKPWd+/rO0uudQ74KeT1bWXSc243WWLH+2NXm/ZmvOf/+Jfb2R0TNXvMdxgLGVOIk29acZz3pg0BBTk4ogrAlCEWD0yXn9ZDxDGKcEBz1OAfsTzdDbuhaMt6VnjT2xQKX3YVhN7TNN1BOnu7lAPa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oiSyleAV; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oiSyleAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993895; bh=IKqSZ0+4nxuHpoVrc8hYw+S1iLCZ6SQZzlkRqqhU5T0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=oiSyleAVNCxmyT0gUSJtQRSZob+LBLn7QTFZtnTRWAL/zjGovowOQLecoN38/Q605d6VooMamXbUIQYLJNLBKv1cJmAUByjsagPylyn8Q5jdCzcAI1N8OhIBCxnmXzyDo0OwahTjTo6WhYi28FLFRR3GcReDlz2LSgHOZyYtZNoOMYVxwZGI7iTKUHnGAxIXPt37+LQKDieV4LdonCysmlleUjqcqIFGwX/b+iCyBpRLN9fmaz6Fgt2scfBr00zKKCAhNvJ9ZxcxX3Dmoas1HGJUesCE3r03DxralbnhK860i0o8x4R+lpKSqatep3OVTb7D7omPKETRecOip2XyWw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725993895; bh=g41Y5YFI++8ocF3Kr3QG2W39mIbCYAUPOtbRZCv7Zo2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DwLXevG/Nak2TKzY+772d8RL+d6vvDJjn5mbn6N9VSg9WS1Zk75nesEtoPeU6ECKAvhAsOySIGSPqZV0OF3vcxj+9YwF32pv5TCfYHUtvu0/wzIl8lkjM3yj2+YOKikOyX7q009nvw0vWULO7mAvRRQRREAte7R7MBxsCQFsRtipIf4Z1lgbW+EM5qKZdM/5GBAnOiyoGdyb4G2dg9Hc8YEmBVef/VsWOchV3wz+Tu18k6A32/TsTbg3XENnaZ8pG30GM9HCxE2MTEpMB/QcQJHQkBWVWtrYcdqULoIw7WrG0xHhyrzquYgDab90ntD6BZ6j/Tdbt800uQ41144uyQ==
X-YMail-OSG: 02zfvYMVM1nmQDYRI_uDPa2bTSpttFPKH8VvWU94S5ZIO.8s6zr3BuAZqOKeaWG
 eeF41uuRcDPBsh5G1J619teSCzPctqMJCymzZulAHa4OrqMZiJJMQFOZP0yV8np9qMo4Qp8bADky
 laPNNeA8Lr8gvzx3h9aPOwHnS0YGCa.1e9UnKiido1GcAYbPHFHf2SL2vu1B7hdRMWdAXfUuJb0_
 wlcMvD188BCvqLVYpK0KDibRLhPttocgAEjrfARmqdOx8EDMkhwaV2B8bsYJ2lWY4dLaKFbIPbQH
 h4G_Bugs0haQlXRvxzNGCbEuVPHS3feOjaKeZuWHT3MFdrZiAGdNltU6tvuYzNeL3Pt_NJRgeWuC
 CNi6s7XopO_rLPMEpuOUvfq6Kjk._XVdg3HfDWb6vecirfYzqvwzsoymzPC85D0thxOzysqZClNm
 95cMlHmdWlaD6crCAlY8m0gcb8cIhhRig98on4erfuSjPLfaZU83bLHuhvPnWbjmcYWWCzCXQnR9
 oUtQw11bdYCgjeimAJwwwHwHHhICVvmbsKPAj.sFbcMxkvKEZtNI7DRLB8hyQK2d3aXc2RjQoh0C
 K6iLdEOpWTmC3Z7ljH4oEgnA96px8u7TzMuLisOSF2jEEiuPDUqKPtbLNHDrMnIYrg8u1KN0feMm
 Z6f6MWoBnPrnPSHUMzeYj28pc_QQPbqUD.SSVkolYua6BjshKiRM2xPSeEtA6B1l_BsLqfeORZ7g
 PyzAs96BFq5Ygd4czAgMttn4.UakkEDhgiwLiD7jYZATtTxKcbIQ8qxkJU3gpf6QoDRxzjDy41dR
 yOvr.Wfg9sAmE1HWhjYpT7ZEhDZLd4vFRYjhOstxbA5b94O0KoHFw.FzVs3SqVCy1nndMunimA6G
 jnkeTFCP16vJmdcrnjHlOuaAnzOGRIsLTJCzcXf_IKNZtt6YUsCriLpwsmVL.s6dHX4zYwuVSnuy
 _gBz0cs9M5dxhhvmtO3pXr8RvAWnL2_Q7RND6OR6wvfGhlw9y9c_0hUfaf1kxedkfGbfDdCyGd_0
 cd_G0B00dpj27l7d9pJQl8RJWNVzVOmX9.PuFDoyCm4PBGOdhGqXOIL2c4BVyh.XX8O_5nbLgDFo
 XS1yftgQrpcxyVTsSuY8u9h2zpBT0g1sQFbC0ansLjpOygwGtHaYrVALbn8._jHnTzopdHcQ74Ty
 5Bg3qwNscCLLDoTrbBH4xAKYOGWHWZsffUKH92h4mRNp_9SbHkkpxbOB1WbDPuWkB8ndLjbja2lj
 aj0tXbaWBokz60GWBoRN_Hk68.0Ju_rxSr4aleWqvGx2VvbdqLG77B3A0qCtLqKGLv5DTet68_CR
 gOvYi6s4a4igYIml37bYNi3TPsFsLWJT74K3Zhal_kG28WErIWPo02iTg8Ci2BrmbS_EyinpewAe
 fNQCgLNVQOYO5zdujf..ornBD_DR4jbCmqcU3uHokUpaskiy.ZtnQdjLUZz7ImTignFJNXbN0SVI
 WfO.fHvE6p4BBHZP6rC4XvCippBn5gw2HOX4l6vUK3h.iprxpUghwVoRBdXyxO4JbvWFrfctt1nn
 hpwCy7uCoRjKRizSwPU7Mnxsfs1u_8W3KSvGjwIi3APwFS5JFd_Ya6cpuufrFR3ujJ8A_S9K.UWM
 LiiF4am5AT6SLKPaUlmCzC1lK807b664n5BuWqwIF92m74IMlsifHH1d2hC0P5jNXfaQf2U8MIKU
 Bxbzjur9g7u88ttK0Cc8QhredOEBLdF5h2e.CDTv1jW5_EIPH6.w8O8Kv4GcYvc9GOTQEyJ1NxiJ
 0jcCptN46a_Wts0MQzUS0FjUc3TyoYxMgUyuH4T8kU8ceKgLo4kxObO3YDjolc9gtaNWHwEZ3NI0
 KhYM7jI1RpAHdloxy9sjvlYyI4BQxNqtofwq0tqdw.WDmYPj5nEAZIuFCLsfy_kFeAAeaZBCbsrj
 gIkZew1FxznArh7_y6UYBTAHjkucX64aikgtJrDJ.OpxajX023WVySgyag0TyZixRopAbhS96e11
 JacjKaDa6tYOieP9y91Ey3FNpGSmSU6YBIiSFK6J5vN1xKHVhz4CcYhd7AdHdew3V76ujpqwgztf
 wcYepsFkeWgkVHKugQ71OS6L0dC4oJwCNOfhv04OZ4VIGbcwWVL6e2Uba5Md.Qn8Eb5BQebKOl6u
 1SwEo0bzh18FbyLPjaazqHXe0KPdsONAKxuuyh9XKdlkBGlVF0yc2s2BT5j8EGHSBhdrO8G9UwNY
 FwBNxKojICzqFANzdNb2pRi6lN6hf3Qe3fFZ19OO8i6l4LGJI7aHv_tlU.E9bseXUil0oXj55dzG
 HpVonZOXc0n.4zk7.JY4KlqZkDs6z9Uw6PhSVVJdeApZDNg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ca303ed3-37fb-4265-8236-3e0313d55ac4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:44:55 +0000
Received: by hermes--production-gq1-5d95dc458-s958r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52d00b93a233ef9d46e84b01a7384b7d;
          Tue, 10 Sep 2024 18:44:52 +0000 (UTC)
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
Subject: [PATCH v3 11/13] Audit: Change context data from secid to lsm_prop
Date: Tue, 10 Sep 2024 11:41:23 -0700
Message-ID: <20240910184125.224651-12-casey@schaufler-ca.com>
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
index 7589845cb9ee..1d8381191ffa 100644
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
index 0ff78ad7c97b..3d3a7cbc6c5e 100644
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

