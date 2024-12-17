Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8B1FA8EF
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476952; cv=none; b=dHPxxtHpeZ8+O6c4/o3IeAHNnYh+UzLZsz8t2DKQDyCLtyU1i2gHeqrr4rt8jMe6aOWDRUS7PF+rssVW3rPPBUJXcWqLPJ4+akOxC5rr1zyRca/AMwGrE0ryGXVTsZWCgl7HjvvDZduYx8QIghzY+pAwhiCQvobcmMKeaMBfbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476952; c=relaxed/simple;
	bh=0aUGZASX0cHnq0alUMV4EmQsrOdVtGYRn1+UNt10Z4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDHh3Q0pBJIyFbPxKRQ2L+IapuhG+QB91Ic4j3bNMhRVfejVL3fWFbUVGjG5o9bylOMlg0PBuGjqoB/jRKa4ihyhc40poS+iaIPMW9nr/CTEEqZ+67QfNpFniM5cRp7ZAYpZZOOW9DHGY5wokJCuRaDxhW8qg2/qDOK7Zgae/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GZese+IG; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GZese+IG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476950; bh=9fwhqKxHZL/pjS3niq00ET0sPNYXuD0VCb5CRUqx04M=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=GZese+IGGcsufSWqqG4S51DjFg7bayi0Lsp2jddqir53iiIT9PoG/pZD8E9Mffktru6+U9Web5Pk4heerFUdvbrH6bJR7CpZZN5VZqOOAG1sWNMSxgqgIx33bMM+0m2lJsuiUL/FOARwdEYn2e6+/b6x9H9DNmT1NmQ9vGG6a+U1hMpEr8/zryjd1cbdNWTPkBWhR4hatNjM9e+Wq74bj9MUngR3xbgeLlltVaG+f6/Vz0GsESLLC+Dlaa26fIGaYEU64jZ+DwEoXKA20PfDHrw/P+sN49gQqsKg9jDqj5kWjxnNd98k2l3Zaj3YZSi6bHaqHuoJ5KEJNHlTBqsyMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734476950; bh=70trqtAUSqK0wJuZCcc2ctDlN5F6yVjNZroynS2R7LI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=oEp3lKuzhe8/LadFFZkUVe5iM60PKjLlwXp0foVG9edvxyvRbU/zP37/LHRrC3wNktMZ+PDWh0SITFTihCuv67QuR+9Lt7NVvIxdZobJxhIRUEYjYp7eurtzwqoqEJZOYhwaBYNrVz7g9CmIiw4PonA7P+z4VIN0QaboUVDq3SpXkIzj+8YP2iuJdT5ifyB8IU4jx5EYUlR4Q6jj+mvgzWsEg6ItpIgk5ffTKkIZqpVPawaSK/mOSkJRv2f1vv+H8ywbjIkThOm6N//WJ2ztRXQqDUc+/nzHYzOSTeeV7aA4G5FkuqX2+QDpcUtzewEGa6FdPpXoDt+o5fZ6lVF3tg==
X-YMail-OSG: HOLJPnsVM1nlpCZ.rcNzFg.fPu1n9tu.nF9__uvfjX2IFOCj19qtvqil__Hred8
 le6b5petKPjpqCenN7Ray8rCbwk.EqnzMICqlYMYVcpxcRFz..ocnYEKbJhgNiqixfbL5CrYZfMc
 qt9K.NrX7RIY62SgllYotKrLM2ey1fw8TLdRVpPJ6UH2m67nLuV_jS0NuGgp9JewPuwv1IJTN_PD
 a3t1UpI9LmWpX2tzVno7rQUnj95mtw7mqB7iHBwOsLMaPnFpYsWQ2utpIuy2uEPvn0D7XMyz5IpK
 9lToedU33Wh1B0R6n5lG794Szb.QRWoL6G4oBGKhurabvJxrLSZ0jS6XnQ4JgKISUp4kZL_FVzi0
 q3EE7Htc_N_x07fpP9XFTK5taGMEYMPnUteYramhHWh7lJVcDEL9yQa5gY9JG4pZ15TRgwK2l9yi
 f.T34ZWRvVXxGCWkO0YQZKcEfCNj8LAeAsLfgqt7NDajdPX2HsbsHPmqOl3KLBtT1pAuEUpx7yRS
 BUxH_RLsNgy5yMZcro5ZqQo.h0fzsNwgEAjWWxk3SxExIb5kU4FJaNCVOSFGEZZJkwZMWlfuLe8s
 zYHc2yPiuWdvL04A9bM.p5q4SQc6K.KLRuCvxKMirohDO8r645nh9fcQKvKUQY86_MfVotTqCZGH
 E7tYpzPPjvHksektmh7N_HfMHyMzhLY.y4cjpuE7m5v_NXuu5tU6OxkXknJF7YoQIq4msjqtYs5d
 p1dOV0Zeo_Uh_SVBjhFv4lmHWLQ1lmKd05lS9T_K1V9RZmG_slivFBaRBWPmZJ9_mC6Go9dssdvc
 jC8yesx23anNICDo2ahzoCm1f1KKFuSQOLki.L1F23XR0AQ4JKEQOdhQY_zytyetmlS4FYIstPvt
 4UyRt2Lj61iYRZRbhBxR0brMsFjRjbizzanOQGzlcRI7KJAWpkuuWTvKfl6a6ySRLVdevA5DtIkb
 YSOoPfLL7trat.ngUplORxYInca1Zur1eqtvFkmrJQHPKhp9w.IKJpeNba3tRpCu0j9gcgBGd52Y
 ShnKH4Hn1zX4.cC9bsmR..mLvupeLbvtAi83M1.JmWnaqXC6wKzQCOSl13puw1h6DONxtcKeJbN9
 Xf7Ms6DAbH5rOBz7PKOPYT4JcEBl5JydSdaFFzIFU5k99ODsiwWRMkpDhhK1.gP8grVNRbH.3IVW
 23YFfxNTEVRxrNejh4KJoSA5m872y3VNPzzuE1SoAst93t8qxXLmmhGoFiz4_HcG8pzIhJkwJVwa
 BcpDS4UHDApmXsyY3IFCstDuXHTCM1Y1AQAfiUHms.nhFxN.hQ_Ty16SiJyroJFY8KrN3fe4WgPz
 uEuq7XCVou0wI2ivVOO2Lv04jaSO5oCfsUMPTbeGTHPWlLWiRDspPo4aMggHdmkkJDevNcl65Y71
 U5kc_enDAAwlWnN_UliR0leAuGWkgFPDFArC950llFtw4zbU7dhxZXTLaDHqniBqazEjLb2SBvNe
 9tcuS.Dfd1Cifik5pe9xgg3aaLArUJNcCvOKnbw.6FZ7bgPlCjHLEzTTqV.bXTWV6oieXREkyZ.E
 ALKKfFOrkwC2JzGAIMmo0Al.evi3MCPuRob8EoUXcUhoZ4MogxL54lv8DDGZW3jzT.Nmz.0bkv_p
 wL5PxKbwrqqis6RvbvydpLkcU8Z1TTb_lKuziZYNUg215ZSq6ebwBMbrIdu97iDusfVCen.E.ian
 28U2OE8bx4JyaWjIDghoqDN2uj5tjgV9S_n8sGYDaX6XR1Or7n7zTMSTsZb1vWFXzn70MTUJeJpc
 FDd9C4wG7qZ_nVylcI4343xCUyhmW5qQAEe7QS5IrS0PA369NhVBIC2ywyJPXYl7vDUPQ7wcz0i_
 FgnEs9h8C0yVd7__1xkBTGGaSGfFzG3qL9QTze8NFY9sBU7xvBfiFeHyYzelL.4_fUs1S7an_iLt
 hXYtqKTYW7J2A0.bpfv1w6K_4CCkqZUiOaUamfJPlTZG5rU_HR1mgb7d0uF3cNUDRGEIJpxt1qfc
 rY_Ilokt72PWFRPbHVq2NCQTxN7tcBQHwN3ANwG5bcRAf5DcvtJ6bzOgSKN7iVtRGLLb_8YjrFL9
 YrfyIQXgMV.GQKAa0q8TWV0LXxPgXLc7bYM63VZmrGc0z1BK2zz94SqN1NFzz.AFPdIiX23xBVPu
 VP_KK99BKR2NSlq1o5thsTmba9r0YY_QBLj6ZP_RytU6UTyYIaV8bjXWMyj2cIaiv75xwnCTjXgW
 vhjratia_46ALEGnoI1jCVXnHTtF4nDDNw4mF0h8DLFtRZKIEn45B6xenr4crL8d.DsUZoT.ELlV
 z7wIrNwJ2CJ.lCrES71b.3.JSXHfN
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5f5567d2-ae52-427b-984f-6832a11dffea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:09:10 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 617dfd7e8dbc08c7e277f225736da47f;
          Tue, 17 Dec 2024 23:09:05 +0000 (UTC)
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
Subject: [PATCH 3/6] LSM: security_lsmblob_to_secctx module selection
Date: Tue, 17 Dec 2024 15:08:51 -0800
Message-ID: <20241217230854.6588-4-casey@schaufler-ca.com>
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
 security/security.c          | 13 +++++++++++--
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 980b6c207cad..540894695c4b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -566,7 +566,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1543,7 +1544,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
 }
 
 static inline int security_lsmprop_to_secctx(struct lsm_prop *prop,
-					     struct lsm_context *cp)
+					     struct lsm_context *cp,
+					     int lsmid)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index e259c48d6148..5fe328f8fe22 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1475,7 +1475,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	case AUDIT_SIGNAL_INFO:
 		if (lsmprop_is_set(&audit_sig_lsm)) {
 			err = security_lsmprop_to_secctx(&audit_sig_lsm,
-							 &lsmctx);
+							 &lsmctx, LSM_ID_UNDEF);
 			if (err < 0)
 				return err;
 		}
@@ -2247,7 +2247,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx);
+	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
 	if (error < 0) {
 		if (error != -EINVAL)
 			goto error_path;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6e16208c2968..3fbb1578b820 100644
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
index 7523d14f31fb..82fa08e0e125 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4304,6 +4304,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert secid to security context.  If @cp is NULL the length of the
  * result will be returned, but no data will be returned.  This
@@ -4330,9 +4331,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
  *
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
+		if (lsmid != 0 && lsmid != scall->hl->lsmid->id)
+			continue;
+		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+	}
+	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmprop_to_secctx);
 
-- 
2.47.0

