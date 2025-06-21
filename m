Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3A2222576
	for <selinux@vger.kernel.org>; Sat, 21 Jun 2025 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526441; cv=none; b=Fgw2NshQOvz2K+hMk0ttJcptRBhN8/92bFFUJCx7Ebf8NI4jeEY6+9VhCvhj92hf5f9b4IkB/mvv9UYHesspMhmjwoFTfZWZQwzfM5fra030fLlOIAzguOZQEmg2sH7t837UiuwSWxgs/nq+U/2ZXHVo58nd1X+4QHN7BdDJlpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526441; c=relaxed/simple;
	bh=uxdl6HPPepE9Rfhyzvk3fi6XCcHGqhuy9H9ghgPKdmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjdyV7KA1ruji89/LtpV40PoRforvbPm6/FuUq0AsTts8j9FQiYHgWxdleByp12FGbBGReon9wmqCZBQ/P9965wHBa/DF3hTHmrkp/gGa/PfJt8xI/2BeWCJiqNlqLldFZu9sHqCVJfxy+L9t8im4rlHXOM7xkfnhd38EGkl8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=L6OYr/z1; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="L6OYr/z1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526439; bh=joJHcHA7u9kgwFCUsrI7feQ1Z7H7Da38zdGYGgG+MQ0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=L6OYr/z1Ti79UWvGk7/Jsh8Ao/qwtvvJ3aKLsaeziOv2jKsgjE7zlvWLEu+sltY8C3vU79AfKG0aDHF2+Xgixk1ax2pafQNHUTYG2vR70MxM2ogZH7QRou+92rgVswbTbXFarpgq71+K7aO0O3JGervUoZ+RRFrIc04QzYE9RcW9I2le3F54P6ZllrnXpWslP+DMWTYnOem28m6BiBN/1getn5kKnqhkxROq/iDicleNDhynpMbGMaG5nrkuaG6JbZBIqrTrzy/GQLhVh2wS4CmSur14QZ1fv94EWVpJ/BSVP8oDBg2fBu56MEI7Fi8IzjIMJIYEGnuDkJ8DvWwUfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750526439; bh=mUHrLd6RasGuMmp5MKXDUWxSyLY2Y07Wz5mhHwLxxbr=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=mW4ai1Gy+LnwjXSKDCDR3gVbQfdZVzIFO7rbAE5rcwAlrWDEmjgRIuRu7DznbCUTbSLMkZrdvNNYijCaHItJmLl0wvpeasw8u0ZpocYgf+S7HzGxPfqNwWjWu6wocx4+hJt4UEHs+r7ZUj8B8dqGqUrOmIgoZ6LANoXp+b0pk7+L13K+XrUee2rm2smARsDVYwqaUZXbHjlZ/qf6xrcYfajaSXAIoZA/o8D6UEDYEOHfXsCSuJMO3l3A2cnw0HzaF6IfcsCD0Qc7kzz8ZQ6SqSjBKSVXxMmZSC857v2Xr03QIAwX1wX+jzGKJYjGTLTJZ73WFsDBo3JBImrSChh5tQ==
X-YMail-OSG: kpZdxYMVM1lqmg1QFmVlo_uFKCzM3_cshu9upO25UIMndO4LKXhJTXTiCIEHYrl
 yMKc4Zjl4ZdWTNKkiDszCx_XYSoi3jQN6Kr6DWvOUbSnSnC2tNOLqVMtPMEjRwvjitpRFqNbid76
 GJwWD6Ne8yARu.wxAE8TM3pEPBg.JL9bhb6gmkiwWpGgK4tGCnDHE.HFCq7Jrk1_FHO4b_3PcJD5
 zuYeLYhEvxw0oBasCCeHlz7gkjRSdxViI2jqCwsYUNXkE27sLk9AMzh1SHr3twPhHJxGWVDvSwEm
 D9gWEIs0cC_kwzWxFTqr6eFmo_xPTOYV.Vo2Tcqm9zLGQdi88YY7BV4U4kEtEx_fwmowDxP6podx
 zEkNSkwWjY8AI8BpxHEOOW2dVtIMv3U.byCF1se442okTWTtInMCzm7FdwD0VYvH_vRz_Otswa9b
 70cjG332Xxv9PVdRmGazpBzdLQMyhqlOdi.YmxKM5T4s9kRlV74xDM.tZstm0NDZktWDQgJC2LlK
 fZ_EcuAL.mL3DI9qbM67PTqUisgImDwgRlrCrOHPdRCXUG8RUukBTFFiXDM6AzbhkaZNRFUw5Tfp
 qIqMmnsJfHhKHEHFYVSkh0okOQdOpqaCwhJH82JJ4Zm.zJAqWmG.WYBLwjdndB2ppUWavnDJvXRD
 wWS.mpNzNyLYclgaG27TBPi9_XsfZLCLslIMusHIqs.8HcpBv6Nu6Jwxemb9kO.dkz5_bLB54SBZ
 oXnGErZCWRHtfN_k8VWDCvYST38cBfJFbhlAYEKGNOvYw__IuTQSJtXZ5fXifh1xSSMJmdNjyFz6
 72xwe1owx3.BLS2CazzD99v8PwY1jhF6fqZDHA99OdK.OlqKiXJbcKN3M0ENotkxqzZu6_hx1XCA
 IU_K1Afb3WtVcFq84b4EQfAI9rpVl12VJ9xxvf91WEb8l7povE.6UwNkmcsUQ3mWhKUhC0gt_Aoz
 d6YDgCLX.jVC2Ms1KX6MFgqmHK3rlz_w1Tey1fz9NHKw_BzNpQhUcpr1tWUcwYhombrOBp6RPUVU
 Mzk3N5DlpCPEao9Izv.gOFMuaN.vE9gWwP8MPIuUj271xJhiLYbsp0Z97ZaaU.5273_Fu2DIJofW
 k1GgNTKZ2C59zebhvDr6S4tcDlPxcfa5o46ru5.xnLqnFIQsbErDKYwsNLLEM_QOW8K5aOJj3ExX
 MdIsp_K.I0iTfuDJ51xHX1dyy4X4JLdZ9LB1_a0S0x7Mq17tkyB4w2QoIF1.63m.eGqqxWBGTKBV
 31TzSLUKcqPCnq2gX.DPjWmDN4rPyh_wfKTg0v7VcS_r8y1GkxtDUea1cd3jAc13UUgtZlJFE5xV
 .D.Zn3AczI5fUNCXT8Dysr.hsdh0vW6.M_tgEgoKK9jne5Crjra18pb3VAskXaF1YL7Uf5eStMHS
 qYQTEXGZTbWz9ja7EqIp0VhAg3mqpiSIvVQjYHFA7A92SKjODT.r0oYmqo3KxXU7zkOlFUWWfABe
 3xL7rZFBKg.7ximW_u0cU80F3_ykrIJnTuFxcr8ktPF.iCQc7LYMxnbSWhgK28ozcFqkFvsscEgZ
 KuCNeTaJrbp07G3Fbkcv0C4RjPflPfsJipEHof35758iIt83i9VUV9iHjcpOL_QOU75WJuhMft5M
 GbMoz.9.qTpAvX5B9MNFPp0Uc3maQ8jFo0dCa3Sd_9mHv14aCP9QRk_6LhnA3Wfdln4p3J7UiCsN
 uKeqZEQpB_c2YA1_71TajOb9y_WNc6YFn.pBXDNQtosMgTN7jSSnp905rG8ofr3smQcSQPnKOU59
 lKUTYmznle9llCnWNczzX.wt0ATkAYLOZPabls9aoeNWoK00Jng41o_LxLMf7pTD_W_SrFdaG_ve
 wdGnt7FPHdWUCSOzr40nr_jegZb7MQ38caHdFb9LPbGAiaHddA_2pB.WVPoOvSPNyx3aDEm2c4F0
 3sDWFH7pa2.7zLeL4NdVZGLYOkM87hemIMLNG7UyTAgZcywsDPchY7Q2zkGHo6F6gHzWkkE4Rbi4
 PNkqmZgAhFwncJVDTrRmiHLfBQ4A58iU0vb_nIQrF8gXmPi9tpoAuoCArFwMMJjv7NE2WFKAhtaG
 frznUP7zXDmaaJN_lwMt3rray0tnsuy5q9hA9RYtcxXkmhojj7AcgIB7zEcDe.U5DrlYjcL5J9SV
 6LVCgh5dO7XroAn6d0WvsdDvc4lhqLsahSmtNR9jVzJLzGo8CCAhO6NSISZfnf1A_tEnYvz4u8bV
 rlyVkaRtPPYQJPjPoafFNJFhqL5UfzB.pN7lPiiBBmwV0qXdVdAWC1HVt2VRTZ0HQoiEfPR3hGef
 OZ4HXRA0..xOCKECd6S.ZRaRy37Ei
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8bb049ea-8a8b-4edc-9944-06f7b73509eb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Sat, 21 Jun 2025 17:20:39 +0000
Received: by hermes--production-gq1-74d64bb7d7-cmxx8 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 311260ab82870132bd75579510690963;
          Sat, 21 Jun 2025 17:20:34 +0000 (UTC)
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
Subject: [RFC PATCH 04/15] Audit: Add record for multiple object contexts
Date: Sat, 21 Jun 2025 10:18:39 -0700
Message-ID: <20250621171851.5869-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250621171851.5869-1-casey@schaufler-ca.com>
References: <20250621171851.5869-1-casey@schaufler-ca.com>
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
index 2ddb5d7696da..fbb991dec717 100644
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
index 9a64c76839da..9f816e25198a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7595,7 +7595,8 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	/* Inform the audit system that secctx is used */
-	audit_lsm_secctx(&selinux_lsmid, AUDIT_SECCTX_SUBJECT);
+	audit_lsm_secctx(&selinux_lsmid,
+			 AUDIT_SECCTX_SUBJECT | AUDIT_SECCTX_OBJECT);
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3a8d9324d040..d363adead435 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5269,7 +5269,8 @@ static __init int smack_init(void)
 	init_smack_known_list();
 
 	/* Inform the audit system that secctx is used */
-	audit_lsm_secctx(&smack_lsmid, AUDIT_SECCTX_SUBJECT);
+	audit_lsm_secctx(&smack_lsmid,
+			 AUDIT_SECCTX_SUBJECT | AUDIT_SECCTX_OBJECT);
 
 	return 0;
 }
-- 
2.47.0

