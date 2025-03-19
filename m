Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4221B9C5
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423282; cv=none; b=fAzrBvcxg/ODJBUJ0NHI5TYikwG3PchcOWFd924uoYlVnMM/K2H1F1Gyk8xciEKeuoldG5ID0TnwEezwyiqnvgnElmq0kA+PKmVAdRJ0x6zUr/OFjPiovqWpG7jLurPB1ufyo7dDQtyl+bKdNhweukZnL9VwQLw4vKYkmwIIXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423282; c=relaxed/simple;
	bh=UNW+YvCPp0c7mxj3odVP2Cv7e9rx2hHtMfO3CmqQB8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HN+De8NquolFhvU5kLeomeKasmbKUCqk/7T5/Mf3TVyeAK0/Cz5f7vPB+gos5ACokF9UZtOzEZi6qSB0XYoif0xFPr8yHg75C0qs0xqaVEt7sF66KFXdebJYgi6eTFR35k21YiIlXU9esPRpOvyEOksL2LtI3sg4BYI4d2oYgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H7qk/SFZ; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H7qk/SFZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423273; bh=n0BKJUlkPGnWX75lq/PcNvJf0pe2ZlGotvHrvtbzhJg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=H7qk/SFZkcggiZartdsirA6IWdB6puQnXqa9EHblXCkIDUnhmhfcXSe4WHn0gYj4i59uDmqsikhQmpfB61K+mYpabuuk976bPQE+BGUAAJODshNThREHYTcLCm8nsjqfXGpzRpNtFkLU6+U91twiJJU9dNgl2CWuhsqxNPVFg2HhptOWATAfPkiLqvQSCzMr31hgTxlRk/7Y9H7cO45wvvKGKeXd6ahaSY7OsBJmJrQMCxnM2lxLmtZP2uzjnl1GtYAP+2dFZmH53iX+irRfXkjI8kqS11jsRJi2E4mScGhgMjF5PacUp4xahbEodms7xtAlPgnehN7N6fCBSQq+0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423273; bh=e0tf8pGPVgh74IEJJDSoG+nskp3FXi5Ygg0derl0s3K=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=OSi/HJ/aRGA0P7K35vQiVRF1I6hqYBQGJfCE/uPKcJIw5oFez0naQHxaAdeJFsc1WnL1HeYz9cDFViiJzWWkpB3GEJoUHL5sQsjovNL2ivSoMfIyX1nevztslkfPrnms/fx5QpKGqCbRUrIkzj8n1WTBJorOuKyR7r6pz3VJylYJHAJQ8tZMGOclXJ2T18tHmhq8iTcMYPCgg21eJ0+rgir3hhQUl8YTfO1pCVIv74HBnNbPsiOvkKLWXB466jiOMLDaFcWupJq0HfsFXVvRYTqvtJt1SctVlEB5WLR/aKiAz9p5pcBRoaoGpjoktVYjwmPX0DxlUUuBE1i4riIBkA==
X-YMail-OSG: C1JLUosVM1kntn3C9ZYW.dQsb8.afZXPVaSMxoreRteySF8Yo3ZXX6fp9mvUhCs
 P73Ut5P2eB7CU0eMEeaRpcshCs.KsnIc8vkPt5x1CCRfCPmtKWHtSDF9cpoX6J8M5Dj22Yjrh6kJ
 1G.eldhADjeQ_jfExCa2A_wWtxfNZTyZmhIOmr9lo2xjy3VKI0oHvWt54PUhevjRhjJJlA_eJuhG
 RiSI_9U9lxzuGowG1PK_zNOxiSy27zqCx2zuvmZmyySWfupypNgtGT8Fab0uiUEHz8Hp3RwRkLg1
 5YdhYL0WA3Zg4tcST4jlal6NVRdsqIn1CyudFc9wXt6MeI7QjbZeqEQsnrCgDaq.RlEIn1BxRPIN
 FP5gpkprU1PZeu1A0Poc7ZIbC7H4GPrUPvb2hj4rJzo1W7MBtEO7BB5N82X77JYgCTjf9o6SxArg
 fkB9I3dLz3ZjDeBhsUzqduS7VWuxuWfM11dXMmv_VmAPDCqDenbknLtP.VkW8wNX4Ws7bo4qvZMW
 0yIGee5LHOD73kn8L_u4IDXaZ4Am9z.PrO5XAH5A5qa2tc22IVy5ZRiN9ylhUpWetdeSEkNT7VSl
 NMeLm5ZstMClICyhASC3_CR_ULIjdXt9MSj2hxiAbBUdbM223PfbOFeDOBwSZN9EV7kNLxdK9NxO
 IAXoxr2F1Rrg0smMzLXj_p.Jasve1JJfT2DfF.PrI8Wx13hxt_nyHatBkJy8VB5oA3kL4dEGlWYf
 1rBBxn9Dhg6vHDqpZMO7KKHGmrJtwi5Uzcu9sOoGFvrTuIwIyC5.8CoutIH8N6Nl_UCuaklnsB0z
 e4Q.H5CN83W9y122oSE40tEiwuoyxbD2cKvR3UKxu9RWhQlDFGHC9adiZfp93tKO8swuVLLHIbbh
 hohlHQLai3OUuD4FyBUOubrVApb3WKL7fAS_.o4Rcum.SPd1HncFaHmnwGC6E3tvnqrFZcDGHttQ
 wA453y5nCZ5wLqAg3bLxeEBU8tQ4gpqT90Mi2HL.AYTyCjtwtugwvVPDL4vTug6o1q398roIofMe
 BCFA9CCPhtJVuNKMdu.RaCkaFZbkvjpcCXC5.tCfnz9gUKChQTsHj7_r7Ux8IBNNRS7d4baUNt9A
 btiskZcFeRblX1JzvVDCihSo2fTN0pS5Ci4U_eDlEGwnk4jwc7JMRj2MBDIwmxtEJWpNzO4nA.1t
 r5aOsPMmKvcAKB1B7KxbYzps.tc6EzyZKqAJ3W3CyaPJfO3Nx_bviVlIyuX0hPFaG8VK_4wOd5QG
 hnt51vY0azALA8aTCq3mNJSxV3H2JE7eiNsRa7xX3Dn2sW0wi6vwk6yQS_zQBdhGY4uy1fyittvP
 y40Yf4owh2pbA9qOeHa1PNUtBeCdWJOjueDHJ0ZJ8MxTBzhGXfoUEvwWbYsz8Bg.toj5bveolvz3
 YydrZAS0iSRdRucbVi0cch0cytv562ukA7.jOYjS8bfqbwp8ugcgstpYZLYA9ENGz9r8_gzi5d49
 uhjGfFEmPA1.pv5Qu9s5q0bT4ZANp_9lG6Z1Bk7wxCSpVZiiMsyrN2ckej7xHlwLCFgfy9RFceJu
 t2nOPhC3LfxuFh7EFkmi54Lw7bfr7NHS4HmGOx4Vfpgz1QyEK60wCad_res0aWCpNsk2.EnbyX5n
 vSvzbeRWhNgs4rQbXEsSZKL6iSp4O1.wKSrSlcXdSK73Jisqiw2CexJBnpVZWennOTTdx2Ux.ONx
 x4k97ra0toPQTK4bPBsHr7w5fZcJAXKu3O.SaZWVr9HsyLWRSkg6Ro8oEEXdj1Q1.IFjPMzK.Of1
 8N2n2ZIn7dg8p0ygbae.WTiL8goCoe3yQb1GQ4pNA4allweod9_C8hfS_njsXNAhap5qypPe.GXs
 j1.kU02e0ciSLE9uG5LgRvGDfLzRTsea_F4qc218k0HAB0NFwOcDQUk4fAvxSyAXdzR8xe.KlB7u
 jLhDhpFVG7_T7dif3IBiJDbUBu1eHIGsZRb9nJ.Y6d1Q3vnPfJ9BBiMn0T3C48bSeFLJDN9nduMX
 F0C8pYstYE_JeWrmyjH0UNREwYxyTTOnW7m1reWSzzN8uhp3V87c4S6onHpNxlPsMG0TvYxw2lmj
 qwKSSzAYuoUPM4tPyVX573JyMZKwhT5s0ghJ6O_oxw2xP.nL3q828X8GA83aho_RyLAs65j2a3az
 ICi1mF.8_PWkxqOO4miAVpaqcnv8VyaRRAIv82JE02SV7V1iuiWGDbF9OYs3VMHdGQVQBo6sF9zq
 n3rcabL_VK8ICPKV2LmbevoRA0UYSFGAQD5XZPzqg4kLL7wf3j9uOY9W0EmGp4.5xbYDrmkEbQQH
 oVcmHW6u.jHRYQMCusx2GQg9VObc-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ac7c40c9-cbba-4a38-9664-9373dee065b8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:27:53 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:51 +0000 (UTC)
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
Subject: [PATCH v3 2/5] LSM: security_lsmblob_to_secctx module selection
Date: Wed, 19 Mar 2025 15:27:41 -0700
Message-ID: <20250319222744.17576-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250319222744.17576-1-casey@schaufler-ca.com>
References: <20250319222744.17576-1-casey@schaufler-ca.com>
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
index 2a567f667528..6bbadb605ca3 100644
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
index 60f2c927afd7..dc3f7e9666f2 100644
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
index 143561ebc3e8..55f9c7ad3f89 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4312,6 +4312,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert secid to security context.  If @cp is NULL the length of the
  * result will be returned, but no data will be returned.  This
@@ -4338,9 +4339,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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

