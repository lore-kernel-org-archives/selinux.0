Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A6219E98
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372738; cv=none; b=UPPZeFoyWVxx3bJTYr0Fp4+tOefMawxBWmwgkavFIzyz7UgGdg5cnpe619LsDGuv+0Loh4a/ErTezvBw88zEsqyyQyqQDZkXjX2z6V7o0F5AF6XxoZ3G1Gt2BzBnj69oi4txokK1R1CEdhxzpenEq1pgI3kD8srUJsFn58FJnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372738; c=relaxed/simple;
	bh=tSKN4Cjx9nrEcfH2HlKBPdEI7fUjiYrOSzZarADa1CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQD365lXF8zszUjaHc/K+bqJ2Hugu3az7cxJtpqzkc68aMqLSpdwlnWlqhbIsglQLoYxJ1PUrhUokU2cdaWJf/tsKIu78aAFQaikXZiaVelu7jJQNMpir+yWoipMZKS8402R2XM7cI/zfVo2C1UnHwbGhmxSw107f6MUBRL+lK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N/Qoqt3d; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N/Qoqt3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372735; bh=ycS8nspkUXFVTGuCN2+zHn8Z6/iu9OemyNtk/iFNowM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=N/Qoqt3dFSXm9ra8iDIX+ZZHmPwaGN20bPwDLRAI7OZNt0EFYAcK5uJfeh2WkDcm78lURsivLkOJKusVxwszSkBxGeU1Pd6XLAQr/05KDxRBKuVr0RY1zvIsPa0UgvB1IjjsyAFZw7YMDda8cNgiPsv9eiZ8x7MVg2UN+Bd0RYa1mfiVlq4ThpvRv1TfQlZz6vv2WwePB1I8SBekGya6wWhGHJUXDi3XoFeoFlxI3u5lo88APy5lTvzP4mZbPaZ+zgz/+mTEty7tEd5a+ykFnez8ZVQ3UJ1AwH4qQUFyQDXB+z/0jEjYzvXUNFH85mDHQ+wX9ZPYhZ2XinQ75/DWIQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372735; bh=JEI8lmmxlDhq8OtrpQrxUy8xQI9L6LexCpQzoMYQUih=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EIV7Xll0DNoXW/R8ePrwpMJS8bQ9JZpHj6WMZo8OlvlIDDXMsdz69pphEXP/pumovOBRT0xFdBLAbUScpPG8oY4MtRDEuEnUSwIAL2ruVyxayysy/B84/tSfT+m70IfUMe5hnTmPLbjKtYjicJ6e4+qKfvXckJlKRktTu8zsyNr5DzAh/jqYRatO8E2B6q1agfhTEdgnXiMVU0u2Rd6KySLzbj2svftZbi0ZgJv6Evc2caFyJNg6BinsckkT1w+FB0Z5QDDVMq1PBvuohpdcldxKQJ6dX9cQ6178S0tmK8Yvr2aQHr2YK6I0SmybfnC+enEPAUjoP9KuR1jY6ZJwwA==
X-YMail-OSG: jgNOR4UVM1mAMLLMRcshYCW29MfuCp_JAq7j7slLtpfWU1Ee_qZBe5.8XCwMvXW
 620aWWoGUyAbHzcBsRH2khqK_jGEXd75irdw7xRcpThXi_PDcFStIiq22PJ8SVmtHlNGimqCUPyu
 x9S0OujzSdE5kKrXh3ty3I1cNJjs2ESXBXhvXSjWTYOtXL1MMMJQZZBpqSaCBqpzCeMLk83R1eZJ
 xwEgQH10vo9deUTiCfMgh5qLjbyMEU856sAz3Y0qNTp7onMcf_T45alJBgWyOc76lSbM.F4wdUVG
 WA_j_kLfQFsobS9A9_ZbJzVbBPlzbK6Oz.AkyCnDHPTBLzlBeO8PDS..EjLxw81DADeHgRlY0v4O
 JMrDq1PlE1ed1vKW1CjQtRMaNy35xdMs.2jyjSwzNeoECGlWatLHqiwO6vpzlzhbYaGdkVasI8yg
 PpKEYQUx6bHivWqKXwJPgQwmxhGAKsRCLmXTWU0o5HJBjVnLmNy4rqLzfuP2gMCsBp0ZqYVZP.Om
 n3I0T7GK7nDvr4cF4hxeCyh1Jg1cr6FqAhEm25UxxGntbWjEzT_VmDg8w5kDSd_bIA3f5aoxhxJ5
 sRx2pabDo2c6kW18JtyGlrAxWYNtmjbRCDSYMAMg_hrJqiPW5VHRrQph_9hg_Rt3gRWcFdKQImeM
 uU73y2R8gvjK77VWinm5Z4ZpC9tnYUivXaEnpPMhNG5UELfLmeFHc6nQ16lY4d1LeN03Tm51b4rf
 IMYJU3i6n3ji3OXhgiaR5a105ZVLiVT3u9wehiJbYVkH2uGlviz.8tWN1ip90l9TvANiZl4hoU_y
 wh7tzUhJVEV.G9XyyF.PnYe6xntkNYn3Okt1tZYJ9onDlc2GVyI7EnYAq.f52rS23AwzTtfm6G4p
 jkitcqEs9eLG.RLevzDwVgEhFIJ1YXHsqrRt1skxA_njLOnEuvkmklE17_D_0Op2cTjN1A0wiOM.
 Lh5ybq7V234lHrvifTnur6cAy5N09lwTlnFUv9XsNCFJiqncaKBslOBiJdgrnKhAXkrksH4U5iKd
 16qSYKjcHV.AB6Q_B3rHQm9EC7KQ2F8h5FXDlvtE.CuJLkXC3XUS0q4bHZpYUTd5w9nLV_iDragd
 R56W02PIW6JJwPgU0vuqpgdteO66BETLdcmSNMMNupiyhj8x7mKIx9PghFxZzRVsJ802aGUpjwP3
 MXi4yP7hPUqjaSIlf2yvMsKCfhhfu7wvmIjpZggKn4SDnezSsSYmQNXLuBS.rPHD_QHVGt76O0fe
 5hBJNFbCs7CndVpAmZU7feXV7i9L6WNzzKwusJ2Smg510Q.8xpJVbckh6KZW4dtVCP1d8s_pY6cL
 FfbthxbBK44BhHV_RN4zjzdZNVWhXD9.x_snom0Te52B1o4DdLDGcrzHpiXnEQgIVvapHuZK_p43
 Xk02nK0A03f6XDdu6SXGc.V1BrkoO5xaI3B5yqtS50T4h77d3kPM2uEDg1fjF1K2g1xCeD07h7DJ
 e.0uj2UVAi40DFDrtBvPm5OiApRWgRsWeJrL8j2oZgbvnXfvhqVbCqzYBZebotLI3XGkRcGF68WM
 DZueVzoi37iklIy1fFf1v_5__pTlXQOIiBigU8Gb3djdLBPCAiptA4bM.cpsW7MkatJC6ZHAwrfO
 Ynr79ZaGDnGRPjvzziDvWJO.eYJWdU1biDaJ4kJGjvJrb6js8zsTr3RSBkFZXqjdW5.EFcmpj3lI
 qtHmCTlWVZlouOeRYK_Yom4y7LAUrY.byFbQN4K7sTWgjq3gNCWDQ22lAIkTglxcrAM5bdAECdTV
 xIO3Suz8CevC.Rnvb5DgaGJKq2N36A3ODyQ.4oZbAzmGoK3khi6yI7BdkST5zuqVGqWVEOH05C0n
 .QRt6oKrr1zOb0eTeZ56gZ25LPa0tMWFxc_7v7l5p3mP4Eq5pD_u7u2C97PnwB4LslY1LnKpB1cb
 gNtsnVc5d7MnwFTlxEjFaEj9KA_W48UZXr9BMoih4LsKBItPYTk4OkMQ7e_LK29nK6_S2ZQF9XC0
 lSBJwgIPgpYB1I2DcfnwsH9PFnadZ9wDiiX81Ps5wafRViJ.GYBceiJY4dQ7uTDPcXs6e0HzpI4i
 in_gLhP5Y9osV8S9bN7K5JKNjVD07GOwvjaBXJSp2Z2L0sWRazKNcL8o_uQs21zVnZCwJFn86ztL
 cavqD.YYBph3OMJqaj1i_i3VCA5d.Gmk0.RPGrBcGfszn_L63pMwAR4tJo7RoEK4tmCYHpl8QMSS
 3pQ.YZKtRxVGwWxVPaFNP7zYIVjDHbGoXoo5LOYJ.ub0cbPgkmdpcSQ3fpRK1gvD6XZd8yQn6QQT
 pxup5zbEu3znVHPk5R3hmTp0YYln5cg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6b73b301-4445-4438-9c82-f034acccee7f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:38:55 +0000
Received: by hermes--production-gq1-7d5f4447dd-mxg2z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84a3ec74d8bfe114e53660abafd57a8a;
          Fri, 07 Mar 2025 18:38:52 +0000 (UTC)
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
Subject: [PATCH v2 6/6] Audit: Add record for multiple object contexts
Date: Fri,  7 Mar 2025 10:37:01 -0800
Message-ID: <20250307183701.16970-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250307183701.16970-1-casey@schaufler-ca.com>
References: <20250307183701.16970-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new audit record AUDIT_MAC_OBJ_CONTEXTS.
An example of the MAC_OBJ_CONTEXTS (1424) record is:

    type=MAC_OBJ_CONTEXTS[1424]
    msg=audit(1601152467.009:1050):
    obj_selinux=unconfined_u:object_r:user_home_t:s0

When an audit event includes a AUDIT_MAC_OBJ_CONTEXTS record
the "obj=" field in other records in the event will be "obj=?".
An AUDIT_MAC_OBJ_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on an object security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h      |  7 ++++-
 include/linux/lsm_hooks.h  |  3 +++
 include/linux/security.h   |  1 +
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 53 +++++++++++++++++++++++++++++++++++++-
 kernel/auditsc.c           | 45 ++++++++------------------------
 security/security.c        |  3 +++
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 9 files changed, 79 insertions(+), 36 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ee3e2ce70c45..0b17acf459f2 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -186,8 +186,10 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_object_context(struct audit_buffer *ab,
+				    struct lsm_prop *prop);
 extern int audit_log_subject_context(struct audit_buffer *ab,
-				     struct lsm_prop *blob);
+				     struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -248,6 +250,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline void audit_log_object_context(struct audit_buffer *ab,
+					    struct lsm_prop *prop)
+{ }
 static inline int audit_log_subject_context(struct audit_buffer *ab,
 					    struct lsm_prop *prop)
 {
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e4d303ab1f20..464bd8ef4045 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -75,6 +75,8 @@ struct lsm_static_calls_table {
  * struct lsm_id - Identify a Linux Security Module.
  * @lsm: name of the LSM, must be approved by the LSM maintainers
  * @id: LSM ID number from uapi/linux/lsm.h
+ * @subjctx: true if LSM supports a subject context
+ * @objctx: true if LSM supports an object context
  *
  * Contains the information that identifies the LSM.
  */
@@ -82,6 +84,7 @@ struct lsm_id {
 	const char *name;
 	u64 id;
 	bool subjctx;
+	bool objctx;
 };
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 79a9bf4a7cdd..7c1a6d99e148 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -169,6 +169,7 @@ struct lsm_prop {
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
 extern u32 lsm_subjctx_cnt;
+extern u32 lsm_objctx_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 5ebb5d80363d..8ca58144bcc6 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -147,6 +147,7 @@
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
+#define AUDIT_MAC_OBJ_CONTEXTS	1424	/* Multiple LSM objext contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index f0c1f0c0b250..054776f29327 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1116,7 +1116,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2302,6 +2301,58 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+int audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
+{
+	int i;
+	int rc;
+	int error = 0;
+	char *space = "";
+	struct lsm_context context;
+
+	if (lsm_objctx_cnt < 2) {
+		error = security_lsmprop_to_secctx(prop, &context,
+						   LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return error;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+		return 0;
+	}
+	audit_log_format(ab, " obj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (!lsm_idlist[i]->objctx)
+			continue;
+		rc = security_lsmprop_to_secctx(prop, &context,
+						lsm_idlist[i]->id);
+		if (rc < 0) {
+			audit_log_format(ab, "%sobj_%s=?", space,
+					 lsm_idlist[i]->name);
+			if (rc != -EINVAL)
+				audit_panic("error in audit_log_object_context");
+			error = rc;
+		} else {
+			audit_log_format(ab, "%sobj_%s=%s", space,
+					 lsm_idlist[i]->name, context.context);
+			security_release_secctx(&context);
+		}
+		space = " ";
+	}
+
+	audit_buffer_aux_end(ab);
+	return error;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+	return error;
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index d98ce7097a2d..82470862ea81 100644
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
+	if (lsmprop_is_set(prop) && audit_log_object_context(ab, prop))
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
+			if (audit_log_object_context(ab, &context->ipc.oprop))
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
+	    audit_log_object_context(ab, &n->oprop))
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
diff --git a/security/security.c b/security/security.c
index 8450cc5f82d5..ed48457f8f24 100644
--- a/security/security.c
+++ b/security/security.c
@@ -321,6 +321,7 @@ static void __init initialize_lsm(struct lsm_info *lsm)
  */
 u32 lsm_active_cnt __ro_after_init;
 u32 lsm_subjctx_cnt __ro_after_init;
+u32 lsm_objctx_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
@@ -629,6 +630,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		lsm_idlist[lsm_active_cnt++] = lsmid;
 		if (lsmid->subjctx)
 			lsm_subjctx_cnt++;
+		if (lsmid->objctx)
+			lsm_objctx_cnt++;
 	}
 
 	for (i = 0; i < count; i++) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1e2e1545eb2e..10b13cd589c5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7143,6 +7143,7 @@ static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
 	.subjctx = true,
+	.objctx = true,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 75bd62fe1513..1b42ac32d815 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5058,6 +5058,7 @@ static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
 	.subjctx = true,
+	.objctx = true,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
-- 
2.47.0

