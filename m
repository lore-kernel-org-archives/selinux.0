Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75182F90F7
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362527; cv=none; b=XUBgBa4EEI8MlZJAi41eSoPpyj3pE5OVkadYbJXPO87iEat4xBViHsH06qC3ZLZCx7fLpRzT481VfZxrwNfybGcdLuM+uk4o7Ho+X576XYGwM+sBGEGKDXtk1qLo2DaOgD01xj5taecvRFA6sXwDIQ32B7oOpdNWAwzCGPdhz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362527; c=relaxed/simple;
	bh=yfa9Le4lb5zMC3IdsYbIy/yKf7bgxgvAd+uGw9L5SvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fS7fw6G+ARfILwWbq2eKw3yjjtubfJG9dnIhcoXRRb8ofzLi2RO6vlshnvL+q1RTzjB3QTPAOOJHQwVFgaZlzpsAyPoG0vN/UemoNhNvUNt74TBX5lHcfJX99rijgLR7oC1ZsL8KvB7qMx1y9uYoALHDP3TYE4//OY8CyrnHl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ZNXQVlYb; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZNXQVlYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362525; bh=dYaM+pd3yzaz1nKx5VENYoAhmPuQyeNRspRVe9Ly1ho=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZNXQVlYb/nGdcqsHI+W/ZlEb0tqX7Dcjqf3FnOFToxR1ZzUb7qncU3thIX5NVr2n2XsXjcQoL6bBXGFDZSj/m5EnRa2V2kCmwGKcyP5R9LFnJlvaAf1QPbu3hrA/zGTazBMaxLrwBBbk2mp25esN6O8fIxsq4SkElWky21i48TBf+WCtAFRJ3rRnRh8fEhQwXmojnImdZJZVTGyNE4NZpCMxYIentOr1LG0j+CpoGfijKsDabsEkSd+obj7NYY2IpZ9A543sLNGd/BgSa3Z/bTTg8a8hfAnA5kAHxepv6o4i6h5eLyvRfsIzeG0nCswpQe/XECQMpz/sZ7Fxg6hfuQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362525; bh=H/82xlQyFg8EvPmRJb7TmJAPO3iLNbtwBQNDQaxqXVb=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qPPCoeeLfVOocbsNEsTdWW9YzvsmcgGi/HsE/8zpelwPUFOTuCiYvV6k78e8rj02GeomD4noy5rDHeF3FaR3nAgtAj/IldQSjirKcTx/NunCVvt5OROLaNVgmJfUNY0ekcK4KxPn0m8SOq4jyoQfwOtwG/YnFp9vVOv/JkKsOD5zyiZK98QpXKqde4duzExdNi1veQcGFMa8Ro01hg7i6qNo8LhBs/AgCzEHo/3DLNDaqIlfil40TEEBN+/NakvOEMUH/uI2pIlp+nf2UjhSQE+gU2K5bzxmCopZD++P71i5o3p01B6WWzl57BjSLM6xlMb5MXjAf1n68yDZLX57NQ==
X-YMail-OSG: 7w1Yc9QVM1l6XRZVm9sqZpRtP7KLcVEYt1n14_jZlB0YOMP.ENW38X0ed0M4_Be
 ioJIK6MHc2KYRlZRFWTdyNg3_0Ygqr97qn8PbZJzKrx08ERrzixKYkkoAvx0.aFbxgaWvS3AY.Pa
 0QuR5Ci_NAbB_A5mU2k3ktLDc7T4_uvxJnp3ly2TavoV.R37pnmvJipgIinbeo2g9oRxc70TZQMz
 3Df_fOjgF1mvl861QTO12BhWVWZJhIVmL3Qe5xTU8zedcW1y8zFcWPF9KfGgy07LhhIyqP7b7ciu
 Ri2yhTgwrVMdpXAQnuiH5H.YQVREE5Q8n5NLuWFOku9EuFUkGq8HUsu6l58K_LTl3m9iJHgfBg2i
 yZ7aq2JNA5Xzc_ENfRdrfBXDud.Dd6PnOhDQ.6l4aatLog_PzOHTR7tyn6gW2QJkYSARN2WTmind
 IhsjjOnSt8wavwJN51c0QeooAcKiBeHbKjUlU6sC4_Ej_T7idx5R5ckrXNQxSXuBtw723h7fftNZ
 ls8estrce.iNPgcC5i0jCerb7LVDx5CkZtiejsKVCXJYELHpnpfz.Dz8qs3JGv5B7ngVaRKFvRKq
 enD3x6CuCKLLt4JHo98aJnKxpo._g1yz7SW.E1JXFltie_taxBICRFzc2Mlx91dUTd2ix5E_tSCW
 xT8FGy56pSDAj3jU2.Ve8Jv7Xq3YfjI9q4rzribODQ6DGHQYgFPxi3MdCK0es3jvmR1fn2D44NSU
 Rkfkbq5L0yTlGd3JfcE_c8j0CzbRXgM6xPPhjkkdH8_Sn4kAP33svuBgHCZI6lU1GvqH8VkxA6oX
 qz6r2KtjXtEFlGxCX3DIxgoqV_MyCAI7FNGBLmEiiEMuQ0wPHtGLOPP_pQ1_sWhSfLMkoC4V1ASS
 4ZXgFTia73z9T0KDr2EHAJLMq4lkQ1v.aMz3gWRGShxPbbrXLDZERXU3RT_2BZUcP7uM4_kdIdpR
 qGpd35s4vaDv3m42Qj_Q_KI8Vm_eT7d9fs3Z9e_mV11V0wpUI0hp3W8y54PoSgxgbinek6SwEZGT
 t82lu56N_BcDxbVoKxq5QwMbEMdKPPQ_xusiEzCZCKDAv_ruNk3Znb8EBqrK16dxDIWAnbTX3bX3
 nViequ9Cs7ERdVGJtcIHfANX6LRUgCrimqai5MY7VSGmHdE4HZhrZF7CPyy2JUtOAZMoaOEb3qEo
 0RWHgzlQgXYCL7t0wB63u8oRmiPdNbqLJPV1UuiyjsBUSUac1svCzLRrYfw1LqLOwq1PuzvtNO.z
 rS7XvGYxZOaTbXeUohc_5et_0QxKnAjYbO255JTfhziIhR4cQlrOcAWUnlatu7Nou6iXykU1LgRY
 Aep8q.i53NH.bf6XbtZkf3Bp5DhkS.pcRQYRZwILBB.Cne88jmacVAyiTUTww5_znp.CSSe2GqP0
 lCZg8I5RU2d6PmOMcrdCTWXmUyjeAwonkPcS_GOMBc9ZXzpG4ULiYWHcSo.l3otIHBHpEXwg9JdX
 Ngz9INtoSvWB.EbvkWj5S43kM807xhLuACcXeGjlhNxbNzUn2ZpeicKe3LHkdNBP59gx9kIwmJbg
 JoFUehcblzUfH6gqO0Me1nRpKGbodJ6pritVO_eM2P_6dsTcyDtkyju9ufAgNbnSVh3QsfnkaDaG
 EYNxZ_no5rXI_lTR5PP2B3W8ZZXTDDewVmyF5CxCuAeQwhBJpXejjKmGl_jnIguZ2N6BuhZwk2yN
 nvpTDzqbxaBtUbvNeqI2BAWTFJroJZyYj6A7ZVkgeYtTFuczQwSMPs_QjzGTlRLJkHVXviZ3.lJF
 JxcJBHSlHbifqHzf7PsjdMOeceg6unlXWAEV9iiRDjS.GgwDkxlDvtrYiW5HAFSKNcdZ_tkDtCCy
 u1tW4fgR0BcAkv.akpYO.9Z.cMN8MPPV3SpwNYLILWk8EDmmnzCDc89b2FncYzHfSE2FtmULAqGL
 cdi9T7ZBV8S1Y87LCTXKbO3FfoA9XanKARCcaU.dPaaS2Pxlg4Ftf5a3ABbf7e26SinE0qjFwgos
 FSHxdo46AVH7Ol0l4ZQr2Ltqss06Zmd59qpLeEKIAvyj0AtwCIC_r7mlSeQm4THSIfab3tQLO2Pg
 Auya7Y9OJoT6hWvXYHLnnJcHPup7YbyeEcFPpuVeyIWAWwzLjXBFw3HyXSL9vwJCg7ZHRm7eI7a.
 Pf5RVIK4PIWVxc1BHNqgsLJ3U7u.JzKKB9p5QdjePCUGeWciEjvtXMVcXO1I1nFE7ebTkije_Sno
 fzVN_tUF8zcgHA2NZdLX0EiO127YaxWPFlZ2N3w_AJWStOp1_rNugYYJwbn0xnJ.0DNacqBe.nuD
 DjvMvEYQ8EIHfqmD0FvHd2n1stLIJ
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d67f07ed-e3ba-48e2-87c3-23613d8c5b0d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:42:05 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:59 +0000 (UTC)
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
Date: Sat, 16 Aug 2025 09:41:40 -0700
Message-ID: <20250816164140.6045-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816164140.6045-1-casey@schaufler-ca.com>
References: <20250816164140.6045-1-casey@schaufler-ca.com>
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

