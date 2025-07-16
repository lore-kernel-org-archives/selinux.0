Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBD28FAA8
	for <selinux@vger.kernel.org>; Wed, 16 Jul 2025 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752701278; cv=none; b=p0y+EGiQ1A7LZ93NlC55jILTijzgiRx0EwEFjuwePnIHcRGev987/woJRV0cUmcRucEJtXvRMjizAPRW7RDy5VARceFz/fSQEVvqFZSynzPHe7uxG/u5iGy6QEsQu/paOSBgbYKlnYUrB9KvFOYlf9BMvEUmKAaye+3FfhLs9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752701278; c=relaxed/simple;
	bh=6PjmHY4cpAHpOARa8kLOQ1jiAFaJnl7h2LGdmKUvhLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGtGFTjNYACT8n17KTySplWVsbLFDMJzPVuJuc1QSMTSUUQVzQRvcVX8AS9q+slr2pMxeEzETx5GDZveXo7lB5sKLa7YW/weRpwpbj2J0zRQ2XZq85SbRu4LHLH4wmdPqS2imzoZTiMvzp1iN+50K9l0Kv7GGRwN1ztKCF9ifgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=uKw9/KXn; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="uKw9/KXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701270; bh=jQ2l4IGcb1jUpQ9XYp/bJiyWkpV23maYwL0DEquE310=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uKw9/KXn3cBXAenhqvGrlD/nfc7NpkB9voWIHJhJgcqtJ/pHAnCOvkYNKVaO7rdTG4F8URpLKBns0pmjeFP0qiaYw7a3H12DXm3YJScBrFEGrMV/GKR3EYeW1/Y8JWRXDO+go9keIrfHP4z2AbjgPxxH1szP4hVHSH/J0cdpK3Tsdx9ZKVLHeSzHDWT/DxHw9QUx0D/l4npqqbRIIcXgOFF8qr4koAc2pCayyM0foa/0jFX0BUaBLXWoRy7Wyg0nzO23/9U79RwTkeXcd8KhtHkbjO2fHeuUOVy6uACI0X2HTB9f2TWZcdMU7yqyTRu4ZGdb0yNuHoQYfv9N7pHpKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1752701270; bh=NdpbqjB5ZT/+vrlPJBMpCVtzL5YDqyUuLLt6NQbjKba=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qb7cuzrRJ2YWijWFZH+5A29ND3Vy8WiWZsQTxn/cuIuKQk3Qos19bu8EFo9mEs5hYlU8ch/JL9EQCen2p8zhfWDsecHfZlLaeIfDbww2hYpZGSK+H4CynAU+PwNziiv/d9w9WktZwwQI45t6lSKFWBb1xy9PFCR9kFxZGQYZgCE3iozsEpHop3i+cnba1G76bbvKv8bgD/zN5NzmzALg8ZrVi9fgCnBCuSvlJLFmzTqrXmwKM9/iWyi98pm7nuwUxJfFmwpern4SPVdn69x0pV6l909BfL51dOgrvB/3WsyVYiVroUuT6pB6lp2vHcogVqFVO7QwjWM7JM+1D+Kkug==
X-YMail-OSG: ABXBZ_cVM1ljSwniSDyze9FxO.Df2eoAWe6TYC4ld0lICj2MfewZz4Bf0Ea2D.K
 v3Ik9eQWvdriD_ZKRjITYjJYkwD4.NjjVS3_fKTHDJyRhgdcHigmbOD4FnthYg3oyKYENdlZ2fR0
 gA7iM5PxaZtbQ5J7g2n74KUXUCDyA0GTiurhyXaDrakWRt7pUjiMKVjcL881qFRZrIx7W2F6pz9P
 7R1t1ZwOSvHS.VmoD66RPqqtLw8.1s6cFhrRjy0hyMSvT7g9yuPQ6l5XDMdcqv.7B3L0nA4aXbt6
 J7ANolj93TCvLRRteEFDbvLltVrtRSgR82GvGwwbys.E6xrBoGntKeM87JM1P2oGj_nmmMvLlu_o
 TTalkONqgfmuUJl.exysZARwBYQsGWgsUdtPZjFYWa4pwCqJHy5YFI9H8JOyxyVVOVAdqD8cKo_M
 BHZRIeT2XK2C1iR6mIiDv9h3LCM2DR6vOfg7nkwt54uYO8TAzpzjPTOyiN2ffchGl0uCDQEEPh5e
 4XUGg37EYUwe7z7gvwAhubJbvYTwQ70F0UwWoSMxTn4GvtbBlILOqvy7QNXbGYgwEV3tfupqNbu1
 .uHzzT.rqOq.aBtWnZHm1JYsgdeC.GRzngZPDZcBxVdKrGSWZQaKDO_JY_Nt49B0cYXY8MnXJWR8
 II3ylSi0aiaWrRsfal4GVV9l6VIjr2A4rK5Ys20KJ_oEW6sW91xhyBWSyZk2P2ZjsU.LLXpmN2R7
 Y8b7hFC.cfmSJeGzoqkrzMl5VIJXGCQvwT5UrMqgyzqKJnDgC0Wy3oR5keIjHp7wPE2yK_Psy2NR
 YHDIO8RWqL5IJLdgfPZcBnEtzq1a1QSclUzTU_lbWnVuuZRJE7YOJIfPpxCTV0Y3Kioo_eF6Y3di
 sNqFTUWH3bKWCd66D6sVllaInn49_BUfzLv7OzmHsGooAnijT4qEBqG.2CHSiZ5MpfvMW67X1BhD
 tpmhYX7yTkaDb7BbiLZtTx_v4P6H8vxoHEfrkQsKC1LB.eQvz5KNtNXz5S8cvKQccT2LvF0B9rNC
 Lkix_GrRmnqQPjalyNlRalji0OgFYJgAQ7ubAQyikfazuv.Ii.O1.GoA06r32fNZcM9CvDwqhqMx
 oC5n3N.0cXZi5hngEXLcdlaT8WYYhKpzqX2ajiiZM5L1SX0KZTsMZ8ULDGymy9q3_uOU6y27rEll
 CbL_OQXSt5.5PfAYHduIAiq0IPSuXx2NT2CiMaKNouuaTfccPw8AdtYH.RIRa0zdSBF.Z3fTO4dl
 xHe_6rTYAQi3AA2mUFPtGTB_jWF9hFYNyLWNH3jZynL5NtM7I5XTgvVyVDDqmi_lPl4bcVdFbQEe
 SRRjb3oCx7GOnvMJWh5hrtjng4zuc46cfkk4WV4YVjL9aA5wfXQlFDgeLlWY6IGLF74NfXLGntaM
 .YViru5WlbfemteuiQvUeWlALlkG2_YMsUazjL369z4A8cK.T09ZkhHzFUD.znnTZ4rWhkHN8Fll
 _mEiEDMq2HTmdztzBbM3xbJZ2eZcAmTcGTaq07kwqDg870ke2W1EaEaE0nAQG3OTx9KRrI8t.xbU
 7DdF9Rg2S1mvqFdRx2Ohyn7EzvJl.ydFhx6p674xauqdVJ4xMgD7iqFrvYAexNuwcPHUaF5eGqX_
 jVgx5v7QAG4VTL9KSH4kgDK2QCesysOjCmnyf7rI2rjUz2FfADCbxGt410QreiuX3wiUx2K3j4_3
 H0cKpZpSWITr53pDyO9fkIXFM9XqG_0Qs2PetZ8xx4s_2NZqRVautrucfhVbV7GBfeEIRcFYKZ19
 gZT2O.FjoUhDgn2Q8I8xrJPl_rXawFBY6I_nRXW4GL6VS7PQaiy7qwiCWpiLZ_ykzXi6jgTwtLF9
 YM2PifTKeF7ctrMoj5mzzdHQnpDk8WF6eRTdod6gixf8WlKmsM.FMfCIUcg.qpewTqJJ3YhDDXsL
 OArN8oraL22F.NixQF.LDXq4Mo_5lwWUbaPFQt288ur8azH_AF6R4XgLuUbAmodA8eg2jMxVO9pN
 Z2SWRvslJLMrrL9y2YOesGAmb2_9x4DAMDbMpCJ.Py3L8qFTdRu4he9_efTwUCO9dVuR6Wc2zhbE
 MtDovt.o2hfhOZRvYZn6wv98e_CkrL163k275BKEGOCGhrAeWR7gCaAf8ht3PDUEFSShrxiTRL0Y
 OCsSwEB856L41GhJXQGgM6xbQb.sly0agqWOtIuTv0.gZKm1rWzwNrl1rfNds6D_5.6cB3n6SNPk
 szEz2mKOvSt6xpfJVbY1E6N9uue3y6KGE4_TzivZofmWh84U_mBdEVqFisWhHmnaBD5mrZhXgLb6
 qZeL2SleaiHSbdiNypnZ7DQr8Jsa6
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: c7553f38-ef5b-483e-ae35-8d05a5066590
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 16 Jul 2025 21:27:50 +0000
Received: by hermes--production-gq1-74d64bb7d7-lbnk4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c82aa99504a499c14c18b1238d973034;
          Wed, 16 Jul 2025 21:27:45 +0000 (UTC)
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
Subject: [PATCH v5 2/5] LSM: security_lsmblob_to_secctx module selection
Date: Wed, 16 Jul 2025 14:27:28 -0700
Message-ID: <20250716212731.31628-3-casey@schaufler-ca.com>
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

Add a parameter lsmid to security_lsmblob_to_secctx() to identify which
of the security modules that may be active should provide the security
context. If the value of lsmid is LSM_ID_UNDEF the first LSM providing
a hook is used. security_secid_to_secctx() is unchanged, and will
always report the first LSM providing a hook.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h     |  6 ++++--
 kernel/audit.c               |  4 ++--
 kernel/auditsc.c             |  8 +++++---
 net/netlabel/netlabel_user.c |  3 ++-
 security/security.c          | 18 ++++++++++++++++--
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index c032ec4e95ff..5fbe38521938 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -564,7 +564,8 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1536,7 +1537,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
 }
 
 static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
-					     struct lsm_context *cp)
+					     struct lsm_context *cp,
+					     int lsmid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 547967cb4266..226c8ae00d04 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1473,7 +1473,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case AUDIT_SIGNAL_INFO:
 		if (lsmprop_is_set(&audit_sig_lsm)) {
 			err = security_lsmprop_to_secctx(&audit_sig_lsm,
-							 &lsmctx);
+							 &lsmctx, LSM_ID_UNDEF);
 			if (err < 0)
 				return err;
 		}
@@ -2188,7 +2188,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx);
+	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
 	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 528b6d2f5cb0..322d4e27f28e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1109,7 +1109,7 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
 	if (lsmprop_is_set(prop)) {
-		if (security_lsmprop_to_secctx(prop, &ctx) < 0) {
+		if (security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF) < 0) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1395,7 +1395,8 @@ static void show_special(struct audit_context *context, int *call_panic)
 			struct lsm_context lsmctx;
 
 			if (security_lsmprop_to_secctx(&context->ipc.oprop,
-						       &lsmctx) < 0) {
+						       &lsmctx,
+						       LSM_ID_UNDEF) < 0) {
 				*call_panic = 1;
 			} else {
 				audit_log_format(ab, " obj=%s", lsmctx.context);
@@ -1560,7 +1561,8 @@ static void audit_log_name(struct audit_context *context, struct audit_names *n,
 	if (lsmprop_is_set(&n->oprop)) {
 		struct lsm_context ctx;
 
-		if (security_lsmprop_to_secctx(&n->oprop, &ctx) < 0) {
+		if (security_lsmprop_to_secctx(&n->oprop, &ctx,
+					       LSM_ID_UNDEF) < 0) {
 			if (call_panic)
 				*call_panic = 2;
 		} else {
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 0d04d23aafe7..6d6545297ee3 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -98,7 +98,8 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 			 audit_info->sessionid);
 
 	if (lsmprop_is_set(&audit_info->prop) &&
-	    security_lsmprop_to_secctx(&audit_info->prop, &ctx) > 0) {
+	    security_lsmprop_to_secctx(&audit_info->prop, &ctx,
+				       LSM_ID_UNDEF) > 0) {
 		audit_log_format(audit_buf, " subj=%s", ctx.context);
 		security_release_secctx(&ctx);
 	}
diff --git a/security/security.c b/security/security.c
index 8a4e0f70e49d..2cc832dc8a45 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3774,17 +3774,31 @@ EXPORT_SYMBOL(security_secid_to_secctx);
  * security_lsmprop_to_secctx() - Convert a lsm_prop to a secctx
  * @prop: lsm specific information
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert a @prop entry to security context.  If @cp is NULL the
  * length of the result will be returned. This does mean that the
  * length could change between calls to check the length and the
  * next call which actually allocates and returns the @cp.
  *
+ * @lsmid identifies which LSM should supply the context.
+ * A value of LSM_ID_UNDEF indicates that the first LSM suppling
+ * the hook should be used. This is used in cases where the
+ * ID of the supplying LSM is unambiguous.
+ *
  * Return: Return length of data on success, error on failure.
  */
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp)
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid)
 {
-	return call_int_hook(lsmprop_to_secctx, prop, cp);
+	struct lsm_static_call *scall;
+
+	lsm_for_each_hook(scall, lsmprop_to_secctx) {
+		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
+			continue;
+		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+	}
+	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmprop_to_secctx);
 
-- 
2.50.1

