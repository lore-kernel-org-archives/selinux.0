Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AB3002BA
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365365; cv=none; b=rq/wWT5lyX/KQGFtBHxllUPeL4rTKpvQn6tMieJhEzk7+RPaWFAvWvW7P56ysbJ+IUiIgHNPCWBDkGU735nG+s5eVH7L0R5xr5Qrqb4/Pb33UdYHXY+jymFMJzWDp9Qf6f8Up2Rpagdvl+0A0tm2ecj/jgYkzYs1xHW/RxRdakE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365365; c=relaxed/simple;
	bh=Frtc6a5si9sk7JXgwBC5CMsASJ/uAxfj6+oE6uSIpcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGaF4SpiuB/opV4L9qSOj/oDN65BlEiYZGtmmOgvO25KIzdDEorfMTSlwohfwIzAOmGDEv7Xmkyljhx3FtRMaDRy6A8DJB7vDuBgYgp6QypymhGVxrRXULYHaR+MUM249ismaNJezKtyW+ktf8QX6ZGbAL1mk6ZEVgWZJSNVZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=qf914+37; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="qf914+37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=rsmIdOvOK9h0F5/SyxdyCUE/lfvQbb2ukTNoXJ1AHuA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=qf914+37S42JllSkzyPpdCM4zxoiZ4E6DRBOfGf7m7qxj4TQpioAC3kmyYj5IJ/S1ts9J6+BuUQ3WQFrc6uAKPRi+OtzLmaiNyH3sznD0X3Em0YHmpOHYjgIgAcJGqmdSwwKkBIcpmjqhMW8dCym8yoNjp7HCv+Bm0f3eWy3b/ExsnGg3LIAu1AM/fZk9G670Dbdt3Rb0EDyTnkZmsqrqZMt2O2x4FpV/VEG/C3ke+kN343FUYF9ht5InPY4by2VVoS08GQ66tlj4KpjyFiFKHkrqc4ou0TZMNPZydE9Pzq7G3/nTG+2/lopnXf5vxSfdUlG3g7ca7bwiscQcdGOzA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365356; bh=4isJ5OjS0A8HRupYNn5rmrA6bL1YIJpJNjvzOYcg2Gq=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Fw3/5Q7Ip7tUnav3SdXfPNq6wDEmMu3q1Zd1NhTA3gJJsYaq3SaGZM42mZSoiRq9syQxoeLuPe6lppiIj+NJpH0fu8YusfWgCvTUqWQy16c9ereRhB5vsNdAVQwVLS8a2ZE3wEgHZam7lxY9RxFwtl5lFFuKAIE0SSizRjwoF0sZMsQZ92ic4zXPWNITwmtArBlm932pNSGIBHrns49qlb5oiWYKxBRYlA2Be/eOyM5X1IPjECZcAnyfedkyQ20hvjza1S8NzmnaJfrb0qA8CrZODP8waf85nlW0QTJY2B+iyWLt4N81CZL+17SoZl3s3eIZfcCVNsdBjktYgZ4Z8A==
X-YMail-OSG: 2.07LVYVM1n7ORSYu8Jt.qQPf4D2pPIipTiot8s0LWIAYnmyf.byeDFl3usTQy5
 BnbZuqge3bJxKm5d22VlxexDWC9qnNgjWILIb3Fxs1TuGSWTk9SGf8sc50ATWRK_EnNJxgacn4Hc
 yVQG7LzRMhqZsjtD9ktO1muUW62AUSMPdywz_obzKnzipz9_hKUjc7aPROrVTS4wJhzjyrK1HH45
 kx6rFWLP_lpsfFBRexbKdKQ3jWg6m1BiSVCxo898UTb_m0kKU7RudazguNu_czeTTJ9MvVLdtZQa
 OtEN2R1a8MYuGS2bHtKM.KOPcJeaBjYjvoJePa5oRP13h0NHroR.O.IC2rulj.uPcFMHd9Z.A4mC
 B2eOGNqHNeLkTf_gRrszK9inrJ0wGaLFxDACYXbclnTabDtMfDpIAp3XZ6CDFIczVZE847ppPZG_
 rBmZxY2hka_bXnHne_vXEsRxDU9VdINmrgdEtbUqQImII5nSo.44R7ZtlTXlfau4RdGsLk5sJtsx
 dWoRJsYxNgDdyHXEoeaKzOYs7ZVloWSGJvKd.yHBYZvTMwYreziF1p_jgm24aelI_Ag92Jyg7Wx9
 3B4Y.9SF8XlADvcbROUT3yVnkv7mWRNf3w5ww.h3cxTL0kBw95jbjzG648b2rsgHjdNlsNUrEaCV
 0uQvtRhcU5BYmYAJIhznnieU0LD5mnAYGczMphpghseY_F1Kz9kNeXR02u_CQcDUk6B.y4NnhT9z
 OFPdEwW3hyK5TbEZP5W_qhFLxj61WPFPUBD48Z.NkL6dldJb28uiLN6y1MEPs1EsnIlwVO5IeuQs
 A8NpMwc9aOeoGNvNIS_CfwDT.D1rToGvk9MWY6jWu5dV2goJDwp8kjdZ6X1W9PusVpJE8ZUIKzkz
 mRcT.JSiuYitDtVHPdBV.KEp2K4t9ds1DL3vt0OmAY_WpRdpI2kUYTip0u2_vE8ow6NVG3Aq3DYp
 4nb8k5Dmf.no2e5tGr1lDGSymNS2jkIvsfcVSpNoGFyxKZPdolV1ec9Vgs_VxNRB_oFMNoKX.U7b
 cNgmPPp_QwKSpIaUsKeqdtflpxIwbIYrx9l9wo4egi_FjjjDFxTmdDRRPAr0G.MW8TjRI9EEqQTu
 ZPc_anA0iGw.NR3.THwnrI1WML8j5zJW3aVkVhdCi5CQxeICwAZMMF12mNNtBHOiONLFUPOj7.k1
 1fTmZxOnXrp66mEdtbc_wddPH9yKS0C9tEHdHd3keD0Fgn0djKAp9z1lloYRqruRWBCBc.ONukWa
 VcXVnvfN9eWb0ADGc0uSgzmof7SSKMRdk4p.84SaOQ4_8wRWKjEkYvm_w.q9DCIS8SUHlFg.OAeg
 G9fxVTWvTR6Cenc6xe4F0uHUngWX6AsJLdCpN8xQ8voec2L1oBd6dT7fZZ1YP3WP2TKSh8fSAFfH
 _82RtbU72NCaY3ELG89bnrA9_nLKIp3x9XE7eVYR93YYN.J.zznIkt_5sf.myg.8J2QZ3zE1LAsQ
 mkw0GagvUbD7NvzCMVJs70IVsYHQTjYgL4x3hdFbLv2a4Fu6bqZ2dcWqbh8ttWvCYtqwEXMRDx_8
 Ta.q8YETeZTMuuUSDAYS4NZuiowTZ9wsamiwZQdbe41WP6_pt5OYI_Lq8CH.tuCh.ozDqN2CW2qq
 17GPNMW05IMP01BafDqMPw5BrxE9Fuerl3w_uGfiPpX9Exo2LMPxwDbQCcjzebb2gy6lGBx4DR.F
 0BZZhb7pjE8zo5aRsaJYbjVzCwEJhjga3PmPAWm0r_TR7WP.hjCiLYsYPkuNbI7G4jIMJllCiCZn
 T4u8nezGxEuGup7iGj4RYEMoUIKINkLwHw.XEPrgPneVAPCWHJRMl9LVfypITT5ukBYdH_h5LsH_
 1_V9I4kgV88DDsb_2uWNN7sz26KsJl1VfLN6HgUbQZuwmWjV9aiKdGm3CUxezebF0j7A2o.CUd21
 .6guAr1Xl3P.As03G4fu7nyd1i3zKqd7Fu9EMf3pGwAjisNbfqc8zUK407DmgBBIzZxnGKUXvUvZ
 dBcDPYcsPjQPrUC8of3_EqIlUvFp7qaUA3lBJhQzdTRyRPVnk2BcxJ5JlgrxVZwobNDyOH6w2gyv
 TjhtIzXHA5Eoi.6WzOuDrAjojyUbljOOMHF9gUN0Y6ZYvc5bjQQT14d2a7RPXekFe8ITdF.6T7xS
 cIeTD61ZU9BK.JVp.h0W24rCeoM8.9kALRCFAQNfEVfAiBG_.ZkiDpMk6LUxfXxvHODCBYu4golp
 0VdH7wa0QsZ3TAGv0dpZdVa3mb4q7v2AOLULGx.FcFu.6elNHsHtq8ZmGUoNjwoGZtNtZLD98Wk_
 aQs.acmd9H5RvDWZ1G82azvsgqnPDfZVA
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8366eb74-baae-491f-b9f5-de8cbe0a6202
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:29:16 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7374b10bab8e01c99c92e4838c45fe8;
          Sat, 16 Aug 2025 17:29:13 +0000 (UTC)
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
Subject: [PATCH v6 2/4] LSM: security_lsmblob_to_secctx module selection
Date: Sat, 16 Aug 2025 10:28:57 -0700
Message-ID: <20250816172859.6437-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816172859.6437-1-casey@schaufler-ca.com>
References: <20250816172859.6437-1-casey@schaufler-ca.com>
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
index 521bcb5b9717..6d1ed6e7387b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -567,7 +567,8 @@ int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
 int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1551,7 +1552,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
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
index aa6add4b9e30..03f33da8d02e 100644
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
index ad163f06bf7a..dd588f548a2b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4342,17 +4342,31 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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

