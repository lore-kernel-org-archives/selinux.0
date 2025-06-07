Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7828413A3F7
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749257512; cv=none; b=liPX0de9ZbTuH12tAxYtEquTZVLaFO9vvDSdznhrmopVjxgrxvPHUbTpnBFshIF1I5gAfy/GpySESntpvGccwVPsUIkp+vUBIX9PaYj94YneRGEMDMCK8mACSF9jyh3/Fz6yb/bSzO6/1ejoeWZwvU9ADc0UzejKg3+DbpKgwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749257512; c=relaxed/simple;
	bh=vGsEpcIPU9W5C09hrCglfhLAg/B4+bFwjnvpYSKNo08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9vjdGXrDMz/mfrq5O7JSAXT+UE/b9AZS3ZIwIzW87SyBqmWL5LnshV+z+zO3uSgMoF91CJN5NoSHNDa7ooOoVfeoa68YCf8durJhvEunXFON9LRejOUSqqagonrYptQjkHe0FNg1wRaHRkYowexYpaexBKWNLlFwgSNo9jWTH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Rtf91VQa; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Rtf91VQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749257510; bh=+KkE7dU6+udHw+pWKo4BbVy1LpUBIWuhx+iNhEuxF8o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Rtf91VQaWBSybcnh03HSDffFJaPtvf++8eDkG7o7DUaHzJS5yy272v1hrE8ORFwaULlTg4t6qc9z9XhMypF1xIPTZSJWacoaif9W9a79WTq49b/Gf8JfvQvyadn34CDLfbIQvu77RfmlieTspEoDPFmPfbZhzU3/5dgPBYyJeyh6BQO3l06LrW0b5d0u3JyapzUwpoRKJHsLGoHIhdaxS3W3wENm+/66BeGIjlXcp43EI2SUDfP2fqR7hDZpxH8xPm6BEI5KgsqLzi8eqLK4grvItNHd0vAJYJBgOEmYnGAFADey1LZuQ9WWSIcRJxJG1GwNfHHn7R85Rn7ClGrH6w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749257510; bh=AA0SY4JFR3aARh3w6ci9+Q3IW1QA2xSzCn2deePagt+=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=YZszLGlf568FC9044CBSgrvhoFIv1gtE8zNQ+0wIfDt2MiX6KhNOFJ9kgDkVyM/X6iY3qs14QTRkdgzy+RZ1dM7pd4HlTlpH4ezwfpvgijRjHM0ms1yw/V4BXknDSzMop86zE3KSiXtusPAUQne1YNra9E0sIC0ntSmUGTcnKrqk2GYPIyaSi4POH5f3/wb7hR/0aiSisWmlKL8o0JMkVqsjmsJRE+UhPjWrkufwEKudC9QeguUQq6tfSRo60ryTCTA2SCh1B3pcTrKgIhbWjUbNhqk0JfDqrfcCiN5N2iNxZaDMU7ekaDD+FSgKU4TnvAUrTDZwdbVWFVVzkVTosA==
X-YMail-OSG: rZv.rQAVM1lYj7JHy8QOKu14m1TZQTkoj2ydzpbgQh7zWfThl3sWZ88jCF30orS
 Y0K8waTHbkXKhcnL.5TUiHJjeMo04gq.nrA1DvpeTxy3QERXMF4hUb7DuhYTd96kWv6J6E4_q4W2
 m7qQporufMHy99IKnph_7hM8rb9lHb9piF0Qo7CmlVGBU4Dm16bhJh5.UuaktjocwZ_bDbS5fLOv
 OJx9tHWGJ3UKv7UWNVG4RllpGWaF8KoBUjHiZR5CFwF8_enNJehgsSK9K5zavDf.9ZMHSkguuHEp
 ePU_1izaYLkwxNkENIXRIRRpXaQXbClM1BMGH8xG_W3h6fbUq884U.d_HMFinDC272vCS6she.TK
 9zI_b2aKAXFSKmWiiqJ2lTXTulDJyHfqUZYTdokfkDaqWZQBnJFOVuJHDjp8eeAIpK8fcX3zyYIt
 jFF7IC.6gJldV80uxV5o_VCGvF.rwgsDhaTlFKRWMBbTtrq_pBL3g5Ee1ZuhIw3.KP1a9qGsmLPi
 krKV74kktxNTCdM1O07ikPBtVPGiIKIGwMvl2O5slNNGbvnH6dxsKbYoFR1ZiEvC5qChaaEtYdrl
 4o3OubsHdF.K2Vw2YlH0i_dMzTVo2HQYZk498tBpS7DAJKv4GkO0UrJemFl158gZMJy_DC6t4ccN
 t7KaXhLv2MOC6vzC2o5anzqks.nt_ncVlh2.dA_mADzblos.pa_je4cdI.uOTuxt1F17IbZoxMLm
 JultLUuqmhwu2RLQXkpr76w5.1FQgwfntfurLUbUHrs0poINBrl_lZ6lAbDAIAlpniYAt8agHulT
 0OzqqGWiedY6n5nCJA1U9NqmESLCi3jirgxrFU4wKQW2GY4iVkOsMTjXVVfMvjiVkeKcI9dhqRlM
 C.4L7djD23sbGsovJwCK__oYaeCQSkuyi8cuPC7r9QTFSlhyspvlkTpHC8y.LGEbm40ZGW8EXfld
 VNRChiwuw2b9CxeEYMnLuMxEx989tOsH2Cr4uWGVlLMiShuUXhLIblZaafrlU03iodRMN0E0ZMRb
 4IUJGe0iFc8XglPk2wZC8x9NoGTN3r8LUCPM2x.qJuzqIkWOwi_FZTtItIB1k1.AEHiVFrznqBC6
 BuC1AROl6LcuvZPTrbcNxcFWS273r5SMMIVTSP8Fpx2EvEmNCeA1PxcN2tK9m0IuAWA4SrXDOJDq
 yc5DMT5j9rlrItg.1J7iNQQh0dW0boAXfsldZT4Ojq2q51BHzMT7yZ3jAuSPerRLyZvN__tk5hK8
 WokpsI5N0n.2UwByilUCrALOF5eI0_usvBZJqrjsUH.pnXB3GbEzUbD1BmRDV9H8rJ1lq2xG0dSm
 n7_jXGSswtCgxUNpBwkSlLHKIJAdTsyRXm3UDpaZ8UpBOIcCizzg6T7LbjQn8eTwDsSgh4rXeNAV
 QbwSNzKOEmRypY8C1R.LkWtTUgFzVf3.B6CTTLolTA21m.7PCjmKmPQrCIoPB7KA0EMLF0Pho3Cy
 3.wvzytabdvh.baECkj00xb9lQ2OXAogkxqynU33kEiR_hdw2k7AcKUX77z1WekHNuU1tqWnc_eo
 6CTigjWePNOOQpj2fn6Pa.zEf9rw07dK6PV5ojoeeR2rKXMMCDFEaGkUJRKMhNir1_gouOSZqYEx
 58mLnKHus2XTlAkcHkYK.JwTtsK88S6C_xqjvCygMAn19_OAimdnbvWNp9LjjKKl4H3eryDpYCJn
 VcbsQ2tjtP9Kkqfa09WPs8v.uJS2C7FrU0IDiB7gWUVxzyf3nWk3Uq_hrQD0lwkCL8hxzo8BAJh5
 DmOYgtqNp9V7Gk_ntua51AfLUmiAc81OQWyUtffH8BiPEGJh2bBth6P4pAzYU956dnXneFsx1ucH
 AwcYdAR4R5hdGmTkDFT29lx3liCZq5afDnvkTYnqNYgck_SrXZMtTPYQ5TldNp72zCqcEcMTmMUr
 tut9iQUt8V3Z34FaZY7RTFcDW7Prm5r9HCfMX9REj2Z0KI_dIQ0Wly6G2plGr3vdxVA6DT1TruIw
 EyjsQDfkrCQS9NNFdclxkVcnTdyOUAH_twYnrW02bQzzdEZUv..PWjDoLWBQNk1Z7KmvAbQwDByR
 1LGAP0_i9PuNnIc6ITVjdoUrhLpSS_uWMJJRr_0BtU5_gvPrzEUtZ7mDcyWbDP5z1wrMD2ad3OOi
 U9o0hcWeEX8h8HJQc_2R61FhyCImr47_UHGJnkM3_J8WM3uhU85w7Azkg1shyhpMvrTCy2J96gAh
 4HRS7GXjWaeCJ6SlsUK549aYyvU9FtxI2SRxv7Ah3FSAs3FawkMcjvkLMSVJB_NtmCwYcMNOzoM3
 uquy52ksX5ETQDPZpsNwEe6PU7nzl
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 17919ce2-3d53-4202-97d5-c9c31b3a2267
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Jun 2025 00:51:50 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7461f2feac0d1a8decd03521522bae75;
          Sat, 07 Jun 2025 00:51:44 +0000 (UTC)
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
Subject: [PATCH v4 4/4] Audit: Add record for multiple object contexts
Date: Fri,  6 Jun 2025 17:51:34 -0700
Message-ID: <20250607005134.10488-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250607005134.10488-1-casey@schaufler-ca.com>
References: <20250607005134.10488-1-casey@schaufler-ca.com>
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
 kernel/auditsc.c           | 45 ++++++++---------------------
 security/selinux/hooks.c   |  3 +-
 security/smack/smack_lsm.c |  3 +-
 6 files changed, 80 insertions(+), 37 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 5020939fb8bc..c507fdfcf534 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -151,6 +151,7 @@ extern unsigned compat_signal_class[];
 
 /* bit values for audit_lsm_secctx */
 #define AUDIT_SECCTX_SUBJECT	BIT(0)
+#define AUDIT_SECCTX_OBJECT	BIT(1)
 
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
index 0987b2f391cc..451c36965889 100644
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
@@ -305,6 +307,12 @@ void audit_lsm_secctx(const struct lsm_id *lsmid, int flags)
 				return;
 		audit_subj_lsms[audit_subj_secctx_cnt++] = lsmid;
 	}
+	if (flags & AUDIT_SECCTX_OBJECT) {
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
index 322d4e27f28e..0c28fa33d099 100644
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
@@ -1780,15 +1756,16 @@ static void audit_log_exit(void)
 						  axs->target_sessionid[i],
 						  &axs->target_ref[i],
 						  axs->target_comm[i]))
-				call_panic = 1;
+			call_panic = 1;
 	}
 
 	if (context->target_pid &&
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  &context->target_ref, context->target_comm))
-			call_panic = 1;
+				  &context->target_ref,
+				  context->target_comm))
+		call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a89561c1fdea..0ffe3a7cacf3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7517,7 +7517,8 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	/* Inform the audit system that secctx is used */
-	audit_lsm_secctx(&selinux_lsmid, AUDIT_SECCTX_SUBJECT);
+	audit_lsm_secctx(&selinux_lsmid,
+			 AUDIT_SECCTX_SUBJECT | AUDIT_SECCTX_OBJECT);
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 06603c328079..b54d93d31600 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5276,7 +5276,8 @@ static __init int smack_init(void)
 	init_smack_known_list();
 
 	/* Inform the audit system that secctx is used */
-	audit_lsm_secctx(&smack_lsmid, AUDIT_SECCTX_SUBJECT);
+	audit_lsm_secctx(&smack_lsmid,
+			 AUDIT_SECCTX_SUBJECT | AUDIT_SECCTX_OBJECT);
 
 	return 0;
 }
-- 
2.47.0

