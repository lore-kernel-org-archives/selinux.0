Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DC295DB2
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701281; cv=none; b=V6q5+gDgDrQqmVu5FqHWBrwqdhB8gSCeTx/51SkEMLVsSlp9kgvhYcqP+XSW+pWORs0UNG/ZpixccitL4TCAHvjFeKpT5WTpZtwlsXmwzz2xZpgcSB4oMaWLz4XvCufG9xqS/ZL51xwUK9QwT0NI8eYk1SixpjXMN+fOzWfFT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701281; c=relaxed/simple;
	bh=yfa9Le4lb5zMC3IdsYbIy/yKf7bgxgvAd+uGw9L5SvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAwF28/WaDF19ixW/vxQScDzv9Js/jv9wePjDId9CCtcrS0CEYw+mThm1e9Sn4xF1OftKTSy2kNgxj/YOMUVB86BoUrIWi1iK/12NAb47O3PLQESlhuwrTvCutrPcEVVAvrdwoR5nkTKHXmUxgeRE7wEMwrx8p+dNH2M1ZidZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N3P/McyS; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N3P/McyS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701272; bh=dYaM+pd3yzaz1nKx5VENYoAhmPuQyeNRspRVe9Ly1ho=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=N3P/McySGMqfm4o3ySM+Sy5c7djIsRtFu0cusszgY+u7b7iBDyug5xekaR5aWEeZCrjtl2FNKphRp+y+EEDlZxImecqWbzSVhAYFtPmyeHGajaURs0K8O6yxiHn+HyNc3DjQMgSD8bQardLG4mumnbxr8mpO6ZFNs7TqfZJJJFrbaYhrRtcIAVarTPdE66AVcBXgZCEptDOtvMsi5jAP2NGMBj+LMSD39/G/i5R0KRgLB7T9waf5u8ELO5QpU7BbKhg+eSHMJr2eZrvdAdGcscxiAn7G4zagI5tY+i0+bbPIHw4iBinzjkcf1eNq/Y3a/9d9N9fkjPVD4QV3qT2l3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701272; bh=JvFPuOD4gD0XB+rCiczY/2ovzU3KyL2tXaq4oiJaFKX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bxos4fpusBV9GVYw4psiUNhrD0rjj1xfMGA5hsBTz3dukbvriAUQbISXqApgzwZzn1bVc3SREoffRh5hPiKGz38NG0tFPubRHMJI6vBdzOe9zxMAzLXG4ZvXx5cwwf+eTdSTygf4nclBavPJcKQEbb+olfLXKQmA8E7CtU7oLK/v9ePIdi3pVQI5qD/Y1R1ddTsLhLG8TZRuuJqsJeJ1UggqPTDnLxUygipcAwk5QHSLvE6ZgszWbHep9d4xhE4m125uWUfx2d9mcL4pPCKqHLzIbSEq5JbERY3F5gNCSBwFxYQnBIgcZkNHIVCziiYfmDtgjFsxV6wLf1tbGEIt9w==
X-YMail-OSG: kBoeytkVM1lcopUAdD3h_aXeZflNLOALwt1UZC82BKxArFWtfHRwxR9qdWLR85a
 YJbeRB4Em4UiWcU_HZoLJ.k_0C.cAwtKWixSdK4s6gThrkppdBlv4Uz5yDEbXxCpcs020C43Ba5e
 8AB6gn3hpU0n9XRFhdT.vB3hSPlYLVbkjPglocQ6N756yRuWcotToemrwHIB.W5XSEu_dQ6xuJyp
 jdJLWHXjeoDWTVdFYFghzN5cCRMVwgn_xYAex0UuBozwdpOyhAT8ks_imJOkqA3O2eMKKyKgSPYM
 8JlZPd1vDjpN12YMMMWdve4no4PUxm5BxsyanLWRZbwwicR59OY7Z4U9GpBjvV.qSbXCi4415inT
 7slBgKzdyqtGOqMgI2yAX7LjGVOnq0wildD3451EPgLuDW0YIhsM3Go2HSgrj08AviqGzoasArWG
 nrfQvfBJ3vNUeoUq9jrDFVeEJHijUE4WbKYK3fJw2kPCVZUfKFsSo1dggS7M7WxaVm9MWaZOF5pi
 ZQhhENPfdX5XdFM99yQC.h4zkYEI9HvlaEnvPirnYvuMYAHBec5vNBHwPk3m1TF2t1UQ95JmdvtY
 QxY9PxFRAzj1ok25qNWZ3hkmZWheNtPZ2Mvt5QIj8DPg.8laEyEv7nUtML0iJS0NixBcbcJr9O7.
 Pu8Ti6ytB.ZO5qvajnuYLGx6zQmB8RSZsgxY2mgSvbH5OOG61VL84MY80gbtAFbsIOewnbIjKCeq
 Nc8.IpWp2s.Ns6vk6GDjrR6aBJXD.4TOlM7hTznrmxXERLhMT6XLdV76R8SDvzcwB8nfOcB6Ppye
 5tL34ronTrbRRWNrx1zU7mzxxMQLuLlQoqNsJ82pcRgFaQT7spB8VNraDbkzZx0u5AqomlWVgBGj
 oJh0WDYBqPOtf7NXkJ8LIPMJNLevCe375N0XWv5w2h93_pzlQhLVzw1l06keNdN9KSYdGLAa2M1o
 sEfA7SsCtGBzchpr_iZXINxG.znK_QTefuZoVHFz.aQPpfOUgB9uuYg59egUv..Ds8OkA1Wd8rRF
 f8dLsbQ3DFJnmEiWdLVFlPzPd.Ws3KxwdOEttnYolLNWhp44oNDs6JPjl7pJYgnr2MErmF7yEWXg
 I0p_muMAK9v8GJ0pVwXCt8bQzY_7qLuUB3agCo6W6_t_rkGGBYaNg6tOzU1oxPZ21z9P3sLOFYbk
 SshEz3mdSx1LetiFg3w8djJKNFC5KnDEgYKig33xUorQor9aGDKTxgqbW0KkX5JON95sgy5jg4Wf
 ccf0HsYc5W4UteJOQ.MS__zJpzGYL35gAWR.rry9ooII1dxkzOTAn47R.RlfothqduUrD82UEf6m
 9fpYxhXZ2l897N.Ae25cD.6ZcQZLA.Hk1MmWaRXfTITjTw9N5q.3mcbXntwl7SVUrueA61hlUMYh
 W56Y4ilzdIZmjh0u5PUNMF0Jz6pv6ewRHPVfeItduJcexew8R9pXtcbZ.1DBzt5Zi3UQEl9v9vh1
 ccIawLE9_u6Q2TvsnjQ8iBP9j0U.VdZ9dyYMXsj3BJKOPFW6Ee21YYrRwpLYbRFk69stejxFNYG9
 .swyfDF7til8BVaEskhnqSwtaNsFHGnKM47nvflGrslkHnyASYEl8BtHoVGqCSIuIXFwpGnSONID
 .nGTruBwKiAxKzQGKtd7L7HRSH5cOPIqJ1A6UN.ZryfF3YiG_DU.SYocGpzG5m1vB4ImAOH5Lreo
 xAowMq4qBT43miNcTMdhccxYDR_STVHVHXd2zLmnEzjEwM9sQvsbZg9y9QcI8XJI0PDVweElKeYd
 bQPMVEi0IA1s25Llphsh2.OU0pe8xbZPL5p4N6Co9SCYXi8vhMorBaEZS7MYsL4zCxiQ0S_rip15
 KO2thtvnBdQQqV8fGqol6QnE7btfV3PJcR3_43zYJXR.nFQ0raS7NnyQU6Lr3XBmwPbsk7iO3X9H
 b.dNaLVRiIWjRVq16GhMg8x0kYpmUSQuahSdSXwhRh036IsVEKSb4bqP7mntbCuCOMB_qhmpWqxr
 8jULpX_R.hyHghDrsxvSwCeySoRYtAOPWywRpgjtGMf_sAkn3s__6GmldvpVCzzflRtGkijKGjpu
 35ud7zEYFjYOXz1ywTjjBf2TgsfWGxKb___WRxTA32C4U9_24ZhLx3flsYSvCJJD4ndWT_pq3MCQ
 w.bAANrDovH8xlMiYHWtDWARZhEVdJtHxGOeoCncYfEt_y6Lz5p9XO23ZMX6nZ8IwXzOlR5qJ.8v
 xc5H4aKSjC.bXo_2OXiSMVYFlb_hVC9Ff3deUG5ssO.uMla.frxjb.jKcgLugt5dcUBmTjx2sThl
 jyxT5ynY4f7p3_w7A7g1bOhSAdWOTNNQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c6793fb6-2e48-484d-b840-4b1e3ce9977f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 21:27:52 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c82aa99504a499c14c18b1238d973034;
          Wed, 16 Jul 2025 21:27:50 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v5 5/5] Audit: Add record for multiple object contexts
Date: Wed, 16 Jul 2025 14:27:31 -0700
Message-ID: <20250716212731.31628-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716212731.31628-1-casey@schaufler-ca.com>
References: <20250716212731.31628-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS record is:

    type=MAC_OBJ_CONTEXTS
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  7 +++++
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 58 +++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c           | 38 +++++--------------------
 security/selinux/hooks.c   |  4 ++-
 security/smack/smack_lsm.c |  4 ++-
 6 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index fb54c1119947..56944fbc1e58 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -151,6 +151,7 @@ extern unsigned compat_signal_class[];
 
 /* bit values for audit_cfg_lsm */
 #define AUDIT_CFG_LSM_SECCTX_SUBJECT	BIT(0)
+#define AUDIT_CFG_LSM_SECCTX_OBJECT	BIT(1)
 
 struct filename;
 
@@ -191,6 +192,7 @@ extern void		    audit_log_path_denied(int type,
 extern void		    audit_log_lost(const char *message);
 
 extern int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
+extern int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -258,6 +260,11 @@ static inline int audit_log_subj_ctx(struct audit_buffer *ab,
 {
 	return 0;
 }
+static inline int audit_log_obj_ctx(struct audit_buffer *ab,
+				    struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 8cad2f307719..14a1c1fe013a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -149,6 +149,7 @@
 #define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
 #define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
 #define AUDIT_MAC_TASK_CONTEXTS	1425	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1426	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index c7dea6bfacdd..63c69db43172 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -85,7 +85,9 @@ static unsigned int audit_net_id;
 /* Number of modules that provide a security context.
    List of lsms that provide a security context */
 static u32 audit_subj_secctx_cnt;
+static u32 audit_obj_secctx_cnt;
 static const struct lsm_id *audit_subj_lsms[MAX_LSM_COUNT];
+static const struct lsm_id *audit_obj_lsms[MAX_LSM_COUNT];
 
 /**
  * struct audit_net - audit private network namespace data
@@ -305,6 +307,12 @@ void audit_cfg_lsm(const struct lsm_id *lsmid, int flags)
 				return;
 		audit_subj_lsms[audit_subj_secctx_cnt++] = lsmid;
 	}
+	if (flags & AUDIT_CFG_LSM_SECCTX_OBJECT) {
+		for (i = 0 ; i < audit_obj_secctx_cnt; i++)
+			if (audit_obj_lsms[i] == lsmid)
+				return;
+		audit_obj_lsms[audit_obj_secctx_cnt++] = lsmid;
+	}
 }
 
 /**
@@ -1142,7 +1150,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2337,6 +2344,55 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+int audit_log_obj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
+{
+	int i;
+	int rc;
+	int error = 0;
+	char *space = "";
+	struct lsm_context ctx;
+
+	if (audit_obj_secctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return error;
+		}
+		audit_log_format(ab, " obj=%s", ctx.context);
+		security_release_secctx(&ctx);
+		return 0;
+	}
+	audit_log_format(ab, " obj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < audit_obj_secctx_cnt; i++) {
+		rc = security_lsmprop_to_secctx(prop, &ctx,
+						audit_obj_lsms[i]->id);
+		if (rc < 0) {
+			audit_log_format(ab, "%sobj_%s=?", space,
+					 audit_obj_lsms[i]->name);
+			if (rc != -EINVAL)
+				audit_panic("error in audit_log_obj_ctx");
+			error = rc;
+		} else {
+			audit_log_format(ab, "%sobj_%s=%s", space,
+					 audit_obj_lsms[i]->name, ctx.context);
+			security_release_secctx(&ctx);
+		}
+		space = " ";
+	}
+
+	audit_buffer_aux_end(ab);
+	return error;
+
+error_path:
+	audit_panic("error in audit_log_obj_ctx");
+	return error;
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 84173d234d4a..0c28fa33d099 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1098,7 +1098,6 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 				 char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsm_context ctx;
 	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
@@ -1108,15 +1107,9 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (lsmprop_is_set(prop)) {
-		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
-			audit_log_format(ab, " obj=(none)");
-			rc = 1;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmprop_is_set(prop) && audit_log_obj_ctx(ab, prop))
+		rc = 1;
+
 	audit_log_format(ab, " ocomm=");
 	audit_log_untrustedstring(ab, comm);
 	audit_log_end(ab);
@@ -1392,16 +1385,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
 		if (lsmprop_is_set(&context->ipc.oprop)) {
-			struct lsm_context lsmctx;
-
-			if (security_lsmprop_to_secctx(&context->ipc.oprop,
-						       &lsmctx,
-						       LSM_ID_UNDEF) < 0) {
+			if (audit_log_obj_ctx(ab, &context->ipc.oprop))
 				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmctx.context);
-				security_release_secctx(&lsmctx);
-			}
 		}
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
@@ -1558,18 +1543,9 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 				 from_kgid(&init_user_ns, n->gid),
 				 MAJOR(n->rdev),
 				 MINOR(n->rdev));
-	if (lsmprop_is_set(&n->oprop)) {
-		struct lsm_context ctx;
-
-		if (security_lsmprop_to_secctx(&n->oprop, &ctx,
-					       LSM_ID_UNDEF) < 0) {
-			if (call_panic)
-				*call_panic = 2;
-		} else {
-			audit_log_format(ab, " obj=%s", ctx.context);
-			security_release_secctx(&ctx);
-		}
-	}
+	if (lsmprop_is_set(&n->oprop) &&
+	    audit_log_obj_ctx(ab, &n->oprop))
+		*call_panic = 2;
 
 	/* log the audit_names record type */
 	switch (n->type) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81b66b4d9695..11cd452c970b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7595,7 +7595,9 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	/* Inform the audit system that secctx is used */
-	audit_cfg_lsm(&selinux_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+	audit_cfg_lsm(&selinux_lsmid,
+		      AUDIT_CFG_LSM_SECCTX_SUBJECT |
+		      AUDIT_CFG_LSM_SECCTX_OBJECT);
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 9a76821b7191..5fe4b53fa40b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5269,7 +5269,9 @@ static __init int smack_init(void)
 	init_smack_known_list();
 
 	/* Inform the audit system that secctx is used */
-	audit_cfg_lsm(&smack_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+	audit_cfg_lsm(&smack_lsmid,
+		      AUDIT_CFG_LSM_SECCTX_SUBJECT |
+		      AUDIT_CFG_LSM_SECCTX_OBJECT);
 
 	return 0;
 }
-- 
2.50.1

