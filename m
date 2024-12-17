Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB21F8F10
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734477049; cv=none; b=d+zObrxzYtomoOMXzeIClx5WG/kWCjy6QICl0zRy2RfxEimudSkSCMIknI9Iz7Rm/SpnoaFwS19rm88L5lQnY24J0f1iyUsQHW+30ect1GTniiv3cfdxLTbIer13GoyKtCw+D7oMZunASX2Shu6wVnebib7h+1Wm1yi+EZGKx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734477049; c=relaxed/simple;
	bh=qX+OFbrUNN8oXf9MBad7xVOOtkZ2I2WKCJ6llialqCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osqQZf9KrnXq/s1TyPjG6aqAeWZ/p+uu+1oFdKj6PbR/TV4sf4R0fvwUBGZmwfbo8nWieRVID1TxXIeKRm5qdzE9OvEoi5+Tb+a0pWuz0c8ieNXBDMEJp/8a1l6ZYW3KUDoI585ot4vaM3npdox9WgSW5rsmatOp7anfnP9jIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lryFGRuY; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lryFGRuY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477047; bh=TqGe56loa1w3C+AMDAGOL3FmR+EcN/OyGFaC0qH2kGg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=lryFGRuYjARyaDRF0Q7sXfjNzFKDDX+tjs4zIg0UNheS8/C+xnHqiKGPXlzjs6o4+inCRP+z/PgA8pusCGbgUJ9AelDmdQA9OPnX7sKg3E7Wcisy2lkVpAgj6nd2FPyI0JksMtZ+DpklmLtbFtQ2feZtneUk4u2WyVDf+KBZtxDh3lhaREOhSvGfPnzeeY/9d+UjMVwIwQ//CEachjorzPOoiIneQJ7m0MzvVSNdOldyXssbE3gCwSEVFzXZiAjlkZ4Ab5fB0y2tDVrfA98Eexbu9DH06N9ekvt+cF/h5U7s343ghk/f65eNe4l/FrU+4xWf9Z/HfGfbZQvj7C8JXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477047; bh=2T65U/Pcp3lObzK4TINVtYDCSfxL0+DIKPS5Ym5g5ZX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ExXLMe7ZyKMiu6FPSBv8TP6Z+OWCdL+W9x/FaTM9oJ0M7RbJhu1rGEN0M9W7YNRQXJLOplA4NaRjbFMH1nwfXrhRvQ9e2mRIIOZTuiEgYNIkLZRUfQ9dzX8y1bhlIhpo0zerv5eRLEs2G5erCRU6mR9JDl9fUUhN81mphpuH3E50100txVAapeXrwnyWl4SvccGZP0ccE/VV/ellJ+ejPSKydiXd5oZRNUOgm+blXW3rZnsMc6xXLJWmADG2Hq5jeBal35ZYw0GZL4cb4dMY1LuGJ8SeFvnF3FuQtg/5ambwYSzuP2DuqE+d4twCHBLaLPDCQPdl+D2DnqqlDl678g==
X-YMail-OSG: QM2omh0VM1n6zQysOAWIFWGcOQ3HjOdoplxENQVw4jEUU_96dzjxBgliSIV6ZL0
 DqmyudpHpfV5jFoa1Uqj.JxLwCSSkFwo2lZUPgTyyKp9B3IXK98F57xKw_Eu1y07CqsyjXwhiYGc
 .rvhxGxGBQS_uwXANx4tdQTalukjNjTRJmG7B6BbYN3Gb29vmqg2HbL4GO.BcjLNR1__M1PP_19i
 KMgx_MgP9dK4tzb0jHvEyDJwmhWuFSTnNZGmPJykoTXXccqUKPMsM18agrB1jsu1S_MM35LYU5p.
 Eqf92VorCiP2JbnInrqlqQaziJFztKMsRHhppv_1.UrLOtRwKM8ucxvAUQ2kq.jXdXWELa941Rvb
 k0ipKsZnVEpyGfLUaBF62.OyNBNZsEqBHW3Gah1RpnwTCx7BqQmwO1Bcs_YkMe5UefFNqAsrWfpP
 HxkXbCep0IoarhuYIGmZlpd7d9C_ZDv3O7Oyu9sCA1oc0iCgkp._P8h_QZz0yHogfNi.5_Lx.YDF
 rVwZW6VO4nZbMo8B2SqVuoEr6CovRJ2Bc9EoIR7KEEYJzBlokEgxulMy2TvNGMgGCSkIjSdvgiQP
 JfvQt_ne_xvrBkGV7E2yDQE4DVOUiKI_LsNVtBkUFKOa0.bMYKhf_0btsaIhO6XHQQNuSQYa9big
 uNU.kt_J4dentAdvClva3jc0BhGX4Qb41jK1G4OrzKeeFkpxp8LOKWYcGTDAnFdZVhZgHfkrmg1J
 j1l8M2qFcZQKdiO6iR4OLAXQVbWyTtIJEF6U5Bg17acXoMIiznljNNmCid1U9nZ5bnnjSxB2VNC_
 hHZbSeoLH7WlVGxH9Z6la9nWRwtOfyDEcpqPGOe4Z_hVIHxVdQunHKadmDVHyGUNf3dGlQrXijDK
 ajXrCNKpGG8fJqPYdh7MyvxXaxQTKa.SINNH6dspDS75gi7FfJ4BnjT6DfnWkPxFRWVm0vSH0fKs
 8leqmPo8yX7ZPuYOQqjw9gyft_4ihGiy1SaXox5EoCK.Xtr50j9Hx0Dy9bMcLPVPJAqWizenRdNE
 USs3l_fpWSVkXO4w8XCvXKzdpkU8tNL9LKfNFoP22RW5STyyspECAa8vDzVgGIZwIANlDCmeQjyx
 gl2asIWMgEh14UcpGdi3KbAdjf0MmTq5t__f8qc6DGWzPZKzz4.IW3IlfAQinCdk55xomghznOvR
 6pQBo1cC0GZ.YZWyZt14ndOg_VLWMDkTqzO6xq9zVT20jWxmZ_1r6GBXqATHPHfluOEDcx2Xobd6
 VPqXWLsaRXc64A6XjXkoEfk8DH_7uLQSo_.P9_U.8iSXlqU9TIVqtSuVYth34rt7AXvK0CkTirim
 ycFvIaNVfdGBhww5YujDh.bdEjVswQxfI1uvltO0J2I45PeNJInzUPuRpzz8PtVj86FO4c48Xnz5
 HptUnu_slMe6n46WibnLRyn_cXEC6iys.nOnXCSllgQ7QW1WdnG.nSSdxBqorDG3G_VKeU0b4Nmm
 GkUQcYyZ0zIobWQGxcOpGj6G8Bf5TvMb3eIKrGC4JdpBF7rMel03wQQx70mRQAFwIBsQq15fslZS
 nEO.3XUbE76Xb_ZTGoLieUZbkJp14phxyvH1SHiEFj_zejCHDfCmj020UJSyVsR2tB.VN9LP3Nt2
 B5ei58RaQxM8aita3RlZ7s6vM6yt.WwNqPXpa7FHWyHYSyI7AUS3BwaBCUXYEfDhE0oRvptWmp_N
 jXKXhBCpijuEV2QnxeM2LqJCqAsKsQPCDsYixgE6FEHNe31jLQvVL2kiG8YBJPMczVl9wcH.rPDm
 8dTMiGj0YlDpiSFRKiiJBGv2tOMqTu7Q3AWM6QmGzi8W6PqrmE_5wZloQv0OwkcRcP15C9RrNHMH
 Xp68sbTg25u8eqx0XKYeaRfu3jXY0xMNnzDBbqiyeXPbCAFNP7R0jTCYTQh41QpD5nMUgKFlY7q.
 txiCqVmI7SwnxXZ2UXuLs6rUHePSpH.CanVhkd5kK9l9HCj5wcr.zUgdp_OJsW.3zblCIIbHQvLt
 jgABb4TQC2cI4bTjtAofR_FKZvPeyqz9lBIBGeYBugmYBwKSKQyv9PGWsQI8cyit9MkDSVmaKaYu
 UXH9vExfho8awroNgkjtGTBv_UF1wzVtXFB0tmJZxEpOS8uNylVc2bPiK4hYjiW_ElbElYJ.49gC
 P5Lt2ik3ayat2cPJE6XSs3uj2VsrWEyOSAqh1zgO094UneRetTWav.qjhvB1_L81DM1zj8gnN8G5
 .Tud5jajF9O.IVrxIZ_5k7NK...AgvYHcj1gGxRTe8M3GsRRN4uoUlFEKcq0aTknuE3MIrtxYpYM
 XpVgZi0zE6nRjyhpJHkd2fMeTqiJC
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: caadaba1-6e42-4a81-b642-653891c8820f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:10:47 +0000
Received: by hermes--production-gq1-5dd4b47f46-5qmz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5db27b1e04260d36afba83cfa77500a5;
          Tue, 17 Dec 2024 23:10:43 +0000 (UTC)
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
Subject: [PATCH 6/6] Audit: Add record for multiple object contexts
Date: Tue, 17 Dec 2024 15:08:54 -0800
Message-ID: <20241217230854.6588-7-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217230854.6588-1-casey@schaufler-ca.com>
References: <20241217230854.6588-1-casey@schaufler-ca.com>
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
 include/linux/audit.h      |  7 +++-
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 51 ++++++++++++++++++++++-
 kernel/auditsc.c           | 85 ++++++++++++--------------------------
 4 files changed, 83 insertions(+), 61 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index ee3e2ce70c45..16b89cbd6ac7 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -186,8 +186,10 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern void audit_log_object_context(struct audit_buffer *ab,
+				     struct lsm_prop *prop);
 extern int audit_log_subject_context(struct audit_buffer *ab,
-				     struct lsm_prop *blob);
+				     struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -248,6 +250,9 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline  void audit_log_object_context(struct audit_buffer *ab,
+					     struct lsm_prop *prop)
+{ }
 static inline int audit_log_subject_context(struct audit_buffer *ab,
 					    struct lsm_prop *prop)
 {
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 49bbae475c35..3e7462f9d80e 100644
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
index f58bfa5c9635..62041cea6aba 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1116,7 +1116,6 @@ static int is_audit_feature_set(int i)
 	return af.features & AUDIT_FEATURE_TO_MASK(i);
 }
 
-
 static int audit_get_feature(struct sk_buff *skb)
 {
 	u32 seq;
@@ -2302,6 +2301,56 @@ int audit_log_task_context(struct audit_buffer *ab)
 }
 EXPORT_SYMBOL(audit_log_task_context);
 
+void audit_log_object_context(struct audit_buffer *ab, struct lsm_prop *prop)
+{
+	int i;
+	int error;
+	bool space = false;
+	struct lsm_context context;
+
+	if (lsm_prop_cnt < 2) {
+		error = security_lsmprop_to_secctx(prop, &context,
+						   LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return;
+		}
+		audit_log_format(ab, " obj=%s", context.context);
+		security_release_secctx(&context);
+		return;
+	}
+	audit_log_format(ab, " obj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_OBJ_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_prop_cnt; i++) {
+		if (!lsm_idlist[i]->lsmprop)
+			continue;
+		error = security_lsmprop_to_secctx(prop, &context,
+						   lsm_idlist[i]->id);
+		if (error < 0) {
+			audit_log_format(ab, "%sobj_%s=?",
+					 space ? " " : "", lsm_idlist[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_object_context");
+		} else {
+			audit_log_format(ab, "%sobj_%s=%s",
+					 space ? " " : "", lsm_idlist[i]->name,
+					 context.context);
+			security_release_secctx(&context);
+		}
+		space = true;
+	}
+
+	audit_buffer_aux_end(ab);
+	return;
+
+error_path:
+	audit_panic("error in audit_log_object_context");
+}
+
 void audit_log_d_path_exe(struct audit_buffer *ab,
 			  struct mm_struct *mm)
 {
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 3fbb1578b820..e5faeab03a56 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1092,36 +1092,24 @@ static inline void audit_free_context(struct audit_context *context)
 	kfree(context);
 }
 
-static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid,
-				 unsigned int sessionid, struct lsm_prop *prop,
-				 char *comm)
+static void audit_log_pid_context(struct audit_context *context, pid_t pid,
+				  kuid_t auid, kuid_t uid,
+				  unsigned int sessionid, struct lsm_prop *prop,
+				  char *comm)
 {
 	struct audit_buffer *ab;
-	struct lsm_context ctx;
-	int rc = 0;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
-		return rc;
+		return;
 
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
-	audit_log_format(ab, " ocomm=");
-	audit_log_untrustedstring(ab, comm);
-	audit_log_end(ab);
+	if (lsmprop_is_set(prop))
+		audit_log_object_context(ab, prop);
 
-	return rc;
+	return;
 }
 
 static void audit_log_execve_info(struct audit_context *context,
@@ -1391,18 +1379,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (lsmprop_is_set(&context->ipc.oprop)) {
-			struct lsm_context lsmctx;
-
-			if (security_lsmprop_to_secctx(&context->ipc.oprop,
-						       &lsmctx,
-						       LSM_ID_UNDEF) < 0) {
-				*call_panic = 1;
-			} else {
-				audit_log_format(ab, " obj=%s", lsmctx.context);
-				security_release_secctx(&lsmctx);
-			}
-		}
+		if (lsmprop_is_set(&context->ipc.oprop))
+			audit_log_object_context(ab, &context->ipc.oprop);
 		if (context->ipc.has_perm) {
 			audit_log_end(ab);
 			ab = audit_log_start(context, GFP_KERNEL,
@@ -1558,18 +1536,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
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
+	if (lsmprop_is_set(&n->oprop))
+		audit_log_object_context(ab, &n->oprop);
 
 	/* log the audit_names record type */
 	switch (n->type) {
@@ -1774,21 +1742,20 @@ static void audit_log_exit(void)
 		struct audit_aux_data_pids *axs = (void *)aux;
 
 		for (i = 0; i < axs->pid_count; i++)
-			if (audit_log_pid_context(context, axs->target_pid[i],
-						  axs->target_auid[i],
-						  axs->target_uid[i],
-						  axs->target_sessionid[i],
-						  &axs->target_ref[i],
-						  axs->target_comm[i]))
-				call_panic = 1;
-	}
-
-	if (context->target_pid &&
-	    audit_log_pid_context(context, context->target_pid,
-				  context->target_auid, context->target_uid,
-				  context->target_sessionid,
-				  &context->target_ref, context->target_comm))
-			call_panic = 1;
+			audit_log_pid_context(context, axs->target_pid[i],
+					      axs->target_auid[i],
+					      axs->target_uid[i],
+					      axs->target_sessionid[i],
+					      &axs->target_ref[i],
+					      axs->target_comm[i]);
+	}
+
+	if (context->target_pid)
+		audit_log_pid_context(context, context->target_pid,
+				      context->target_auid, context->target_uid,
+				      context->target_sessionid,
+				      &context->target_ref,
+				      context->target_comm);
 
 	if (context->pwd.dentry && context->pwd.mnt) {
 		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
-- 
2.47.0

