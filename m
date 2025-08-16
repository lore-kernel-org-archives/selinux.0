Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5D12512D7
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755362522; cv=none; b=CgxxiC1vZp9wGHTZI9Mr6WOwQ41i73ssk7Jc8ROGrOx91BrJOiBuaYdMcKdZAbqJvmJAFNTm1Tw0/yziuZkC0H2eJLpsslXiiiEwpHByl/tsFNhfShdhbkuX6NwKAFemKYDNvp/0FyBGh5ivI5luPlBDTbJjrpkN4ex8HMVFOoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755362522; c=relaxed/simple;
	bh=6PjmHY4cpAHpOARa8kLOQ1jiAFaJnl7h2LGdmKUvhLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srXMFmUc4K3bjcIFx5mMqtiGSrutW/YwkmCmT2eA7DARZxU0puRUZkCneXjlu0FLslMiphwPz4rs3HoLTDH//RE7UGmkss3NmHUc3pdLyaPsztJAV+IuFISHS8h+5FNuj5xqXQmPcVi8MWNp9y5tMX1oylTxmdYYz6j3xZILbdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VuepXiiW; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VuepXiiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362518; bh=jQ2l4IGcb1jUpQ9XYp/bJiyWkpV23maYwL0DEquE310=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=VuepXiiWT/d8fQX3So9J8c9IGbd+aUts4mcQbnvnxVoQsNv1y8855dOkw1OOuVqcRMXmfrhtyhP1kFtwW+9NLiCDA4gGJ2EKRr5yyPA3EBTF/NM7a7xfZhLycd8sH1BJUm/wjGUxhbEhtbOr+iHpHOXnNlS3uB2NhobrtdqaDPbSpzayMpX2GEdslSsYC8JDhlvN/eONcsrysNrr8YixWI2oXVWiz8TDerwzjm6UNrkO5O4XNCZXkO3pf2K+HqVwgeNvgbJO0jG/djkd4wVhqZM39Q+p5Me7i+LdDa2lSL7Ful+8GA5+64z/wos4+vSaibzeI2V3KDYHcQYDokSp3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755362518; bh=dVN8Tud5OvumkkgcAUJiq43P1jr1vQUmWD1mB6HrNVm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WRKAHU3TxAWgqoxMst709ojdjE/8MzYyGGQZ5k7zRM3s5mOWfgXddrZptSz36PdrFo8n/6Oi0PIdo68gYF9Oubh1MeuE3lHqZzBRwWKtYsSVSn8Bue/ONw2hgMUlRl6uylg2lDLP0VI1g+nNzPmTRZgr1sYcaRmQKnuD18O+juavBJIVD0RiIAi0z6qQh3taSv9H3tIWUa0+6rfFYVkHZGWmJG2cIJRKPg6xGXl5FmCJzETkZPYvidZTpPlIUXZs83ur36wpqGQeJMdZHEigd7dtq7KrpgwhBOuQEG9w2DAVqNPAvqvDOeOGBIiRmDp7uyUq1+sDWhS2ffWzcCKBNg==
X-YMail-OSG: qAUq0WAVM1ltfFDokGvW1INue4gnqrSZaKufFroNcnoL2NWj3aJK67KgBnfpwQQ
 NbyHXUYKG8v6mTzu3TzD7m7mB7HF_4MYc8BLN5Ngp27tEW_UR.4ByyqCdOnUOjswxJulBsb0V9G0
 UpJNdJRPWd5zEfub_L5CQuyqQa5YlOcM_hIF3fxArX2Nx1tlUG2ymqF2nhxmvr8fCputo.gwgRBv
 3LSKpkxzOO5cr9by1HjjB2qFJdlKfW1fMGQvVQrz7qtRP3oE5FLhWFe2IqYuJlE3C1MV9ZmJI4Ky
 El_7KDWzXAtX83jHD.7SojEi.VZp7XIhDn6SBLIyWbj8f6bkkD1KJSbPtJaUcryrIkvJROFR5DHH
 aGEZhqJm1xWXE.a3qHemkIGvm5aIBq0eXFYQNa9I5.tL0Cm9KYeKwGr1lomGJ7HsgSdh8DB5hOoW
 YQ.vBxcUT_jXplU8T9vEl7FeAreVlHDoOTASR4dDEGcCkx2a.KiGJcc8JX8cLz8_UK67WlhQfSAX
 yDxPcnV0_GYbVcWDfcXc6Q2cJhKIV2F60j6MDajYXaa6HdWTVCw9BlMMZa9_eHudD208LHsKwt55
 mcWxIhnQyfS.ilZt8K7BLLGMF6UYeYgHipOU52NyhX1rtZ4gdGXFBAw1NNX5Dd4nA7E.jwlZJ.h_
 64RstEZHNjfM98tPyN0JGx9l487tUfYvicUgTdKqQi0mSYvdQ3kp8K8UVxdAIkTl.bLaTvgoV2fD
 xrxkGw0fPDbg8U5Jw5MQjloi53k2GhC8FxOJJiAJ_nXmIrcEMryjt9SO7aIAahd.ubXsYqNiAm72
 nAFt2yznDZ1QkjTgYylHIRGeUMOjWMHkoG7HwO2_os95TRcAJRqzr35Y9ISIHgc2wW_tB0Iz553G
 SYxPM8NRi_wIn13m576vw4ormi7lnlIWOSJeDLX1qr2OSAttkyBg.DsylkvANAYJNKEdOqLPuelh
 0kSPAHtOHzpyzEweXcPbrLxeAY2u_djkQebI7Zgusc0.e9WIdYixQSuok.954yTodnomHZj4.ZMy
 0Hs4fT.5NIZQ_7m67sDphJ3O6H.orspF3SnEYlejZokZkUd13_qHnCwS.Ttkql.r2pjz39vRE5fR
 8Gdb4jAmgoOXedMjMtHqHQfMY4cKRGtXMwVwHT_1bIZ3cheMc3K0_9GMeHavpH9JwMiQeb1tNOUs
 hb.yAtZpmpAlb09hgQJwvEdXPPDuqQ6ehYKCFCQ2HF5lZA9C0MmRSr8VWH.TiWxWfZLEaNdzd2CN
 bjKN83ltZ_jZUauYrNWQc.XiSteRXoo6mla4Dx4q8T9jeFTQKe1kwKK67gBDBjKIcgb3K10DvjX_
 QkQAFybYkPlVkfZnlgMzkUryYS4_bAmNwB_l7leyYOQ.C_b_EUtn_6UOE38cHf_.g.UTYqHRk527
 kQmgwo8SalBKaV4GeROJ6eIyXl3bht7X2uCsTKtYorwvQeSGiq86LTAmzfYOHkojpzDwTxiy2LE2
 qUIPrjt5JqNx64TlIuYQewD4eAM.idHtj3Uc3d969rMIEzGMgLkgIrZWxkULS70AFGM2O.vSuGqI
 Iapp2X.EDlDtmmzDY9vh6ibl.y1xIPIBWR9RgutWKJT9hNJ5bYmqtGa3EIBKPxALv3I_em8EOUNI
 0EsZ3Svqc8eXP9r2mLMVfGQLmvPny1s6DVPyqYPh56vwHyLZnXKny5G9otpfGLx9R.n0w.9ji7IU
 Y9L2gkHutSg7B3uIbMYCpd.1xsSsjnGRzC4LDX4xKVguEOIkww4xRMjXmfefu6xBIMpOP9Zs5POF
 5qc8Gue4aD_ZZi7KWWNKUTtiMPoKgdxgTkyHWPbYLD0la5nrXTJtRTWMnOrOhgYhFycRLJro8Dry
 kWPnpbwni.rtpjqfL36sXuTUEX6ZythgJDVT0Kh_SgnYkxSBiECDKuYueQq_H0uvLpdfSsmHevgd
 tH7gVuraQddv_KhCl62UfXx_iQAsydAbv3toY7Zyc5.bStSAKrOGa1XPEdD2LHRbGA_EqLT9bdlW
 Ogua8ysIF9CjPppIfrPSk4tUx_zFavfd9vg_Ba49kYP1sLRedgEDW1UKihwEF5CPsfw1rACGdDjt
 Fp6XvjnOCFNvz4aKv5vVvyuNorTjmO35qGngXYgQbSGGQw9D.A4wOJ6hTjrdXDA59sm71Aje4wZV
 PgsRhKaihdT3jK5PzqPuzliycPkHJRM0p3LK8t5na.cbkkwVa4tLoGQ6wioVOoXTf36H1rFpn5Hc
 Ffk0Sj7Z.cpXsAc_7wa.ilCqMZzixpMoDiajboggJXMSNQrgvZr3cWxowEkfVOz0JpS5gt7ub_9L
 _BR5d25ARFoupawjGjzbxpQNhgkI-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cb959517-86d2-44bb-8bad-46ddce210943
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 16:41:58 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12cf07a2fbb9800c7a9ea9632f3a0835;
          Sat, 16 Aug 2025 16:41:55 +0000 (UTC)
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
Date: Sat, 16 Aug 2025 09:41:37 -0700
Message-ID: <20250816164140.6045-3-casey@schaufler-ca.com>
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

