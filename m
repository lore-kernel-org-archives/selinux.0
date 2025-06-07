Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDEAEEC8
	for <selinux@vger.kernel.org>; Sat,  7 Jun 2025 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749258112; cv=none; b=M3VBgcWlfoInS711RfM2c6lz9C392m4fTQVuc2RtRg/8HJt838APEGxSFOtMQnGB+l1nicmy0zfZn65kcm+QdbW+4Xbe31Xs0wlwbfFqU6S5vHcMV0EplQeR/Bb2t/F6sXQHNhWUrYHX25pOHh2r3W5uiHbSIjfr0xhmIkpEx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749258112; c=relaxed/simple;
	bh=f+VG72yA/9T00NO5XecApQNOq7FGbanG93lY5CQ5PiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuwOSFZPYozMxB8OYUxSmUGOV1IN5AwjHXXki+rjvY2fbpgrATXlgSrRoyIPJ+7uUStUg2Fv83gsCT7CFy0EWyjpDchJz3sVSrrqkFM6BsoKcq4+oQy2W99vnz4DFUcX4Sy583r82uxkWsuLozqMjgH34qS8JJH0uPvNPvfiaCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=R1ndSfw/; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="R1ndSfw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258110; bh=O9MvVXnnEISjr9pVZvv/llW9gwDfpO8uAVzxHg2LCSk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=R1ndSfw/wTO71XmRU5la+pNeCC1OEWW7BBdj9WxTm3G6goo5DfE/tTfCYFSKDlwap6z4CfRv7GJgrp62Dor58EYu5rM5HLOtu0Cb73bAd1k3hhTq0zbCYAVvfQaUxsN3PzvbF/thBbKOkPUL6x9d3keGQlguckRNemwMnKXydVWOf+LvAfaig9+7H/l0Z98/jJu1QTUp/TIuFl9eApXbGbnsSVx/bV84WWgbQPeIntAMYKsQ0Hf0Yvd0zCL0RC5n4qwiZhgFuFGAxQVLR/vG55++79GpxOdvcshNS5phVoOTauVtTqVTf9pTxF3c0xYRx6UNRIWwHHcqAIyYykkE0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258110; bh=i6RR7CIAISeF7yh92TdX2AkCuDdjsM2w0N6cMOZw5vT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=fRYpE3MY29ZpY8ZSPK7GbDkoGj7ZX35kOe9Gh/N4O8bkB7swS4VqpPAqPfo+FVCS9WeB+Tnq4eEMJvnNOGnBJhRtoJs49u4rS+ll1jmNtq5deaeJz/o/T8subQ5WyoKQs38Q+1GinPUJ4rVxNumxnh3oqEj3gjtl4u8pRJhOEGloww0HaYkPq119RAcsWrcpLktz0L52ENkAUv8A8AJfrAyHWZoWGyJtc8O9fdkhUUDYd8edUYyufspMmhZp37C/sfqY0xaPBN4RItjHFx8q73RuEYfFhVd7IsC6QTEeGifzP78NdTOV5fvEpVBk9FJJrCEdcfRUedIUztmf6/CdMA==
X-YMail-OSG: vJ4JTX8VM1kCmzlA7AujyLVGA743S0s26eeyOC23IvayHwWhwj2EtKIity9FEjT
 vkiOJ4MeT_75GmQiqypzpMiFEa.AD26dQGAYN.P7WNoDAY4EKb0oAJjWW8fUDb2C2dK4.00ql4Ie
 oHKWa7_fWUT5ou0XUktnSsNErw.TnfKbAgYzy4i2bmQDsfATZL9yQ.CvbN_eUOHleRlF7LUFEW.i
 CyUPKBR3GorO_FAMgnYYouF57ULc.VzDAWmngZyTIjraX0ixhARiqtUojqrmr0cC.we2yUXYEDNB
 9Amm77wuX72rqYHNnSm.hAelQOEPAFER3IJFKOtgeh7RX9bLSNUdFYOmzxaJGV5JYP7UhuYiQty9
 xXjGu9DZf39q2tcZyYIteO2M7.CETqWHlmtd9eBTCJKe6rTWei3PNapakuG7V6dwAaqwBDtL8mBQ
 5EYOrKh4p_potIcuBRADNv6JEFoUNIh8xA60I94nvnAVwwyzk5J1cGqmTJ_ehLQb.uszz46urpTe
 av2qGhUlVK7u_5_OhKqHR3nMyaffSs_hGH_G80_e_Ui4BAPIZAK9nEPppzmYrpdU85ZUz3o7DQW6
 5WQvFLq1FpDva2IkyIxeu85wjoIBekzyt9wV_XPaDw8N50JMSlXFrQm4DmaIY1JErpeD0WzKeHh5
 AoYf0czj7ug8E04Eoyzh9Uq8gvOHTfRYsDSWNV9aFq3jegONqIgHm_4Ui6E5fqdnHnHmCu2GdOHd
 s._XFd9ff7XKd.bFdoqJrufWKhgrU3NXmUXDPvExnNr_pQhafMRlmWx2Rz26twFnib62s.E.Rq0Y
 wVgY6l47N2KYXQ81mr7SLWbsvfhp5ohKYyfkwdhnPZ8fTip9sYKOfJeIxgZnbavNPM6ZmG84PX3H
 J7uB3w_EDOxP49YMJBud.KXnmwOft0_8Hpa0ZF2dFz.KGTdZmf77sKFsyanVX0oRYEXThiW2QD3o
 JvofKr7E5hiRrIkqOjlKN490pqGKeTVhkaF41o59Vi_y6O8VO2XVef2ZZ00ZEeVLUehtOLL7nu24
 5tLM2vRWd_prpRs_j9ZxrDCfRc7OvKD2uwoS1FcOvTT6AWzZoJp09K29GkGR4n2Wo3H8byTXZPTR
 dcvDg9aWKOnFpLd3MQYB2WFZuiZ2K8YQ_r9QAJYRTw_qgqK6PhAiXyDaL9.D5sqg_SMKVjAOzJzr
 tbyEZbkjtYr3uMBFp.9RyUVdtFZI1wvcnTxmhRa9dyMmCOTDWl92e3WJf9jHXgni.Fvnhp733mia
 vyutfBgKirYSwuaehYxS_U4Mt2gdT9xKE_GHK0CH.aBm_l7Tr1X8Phe5itFyol3lOOFc6TLm2hTo
 RiLe6tgmHCTQpM_zJdgCju63b_XrM2CBjJjcQRJGSkeN5lfnnDmn3ThWtxHwFhymqP9dz7OWnB7B
 V1Xz2Q5uNrGQKzB_RMcxy674sMWvSsH7XTJ7ycJn2cULs0FFZaFd24k_Ax.T1CLocLIXug7ZDE0A
 V_YqsxfqjGj16FPCPWzv61WENnYbjtzKQwx0FwoMAd4hW3G_PSfuFGnm4bHxUTfblfG9I8khNsZh
 IqfnrKy2DZhT03fzCEvvZa6LT67uZ8mnpnSWiKCsORgqFsWi_2lazj.g6k9HGtfWsDma0CHXBN4n
 0Q_7FmyoYL.DGpuQQboDPAXBYPhcYxA82rurUgaqSKZzlTQl_XZuNiM51uUHUvLLKooayUUvHixR
 S5cfhsY8WA72fkagXcK9RQg.C6lJZ6HW.8_KuDnxVm_Irok6W6VBMMsRiUj.J7kd65ghOYX5RYxp
 VvGgMKVSewknvhhtx9QBc_QX4M_nKK82kpCIes0CitEylOHVsKdhHn5jLcM3fE9t2QXp2LvRz8eB
 4m4QxgM3uDxI2w.8CWFShikIk5yixbHne66x1AKWOeVYCWoumcp9B_PssWwVHVFK3rr0Y6aIdcqT
 ui9C6uCFQkAmospAxTvN1pr6XM422bBU6mUm_7rUPLOZk.nu2J1z2lRfcUpT7VR6jBb6hMDn.VZ7
 taTf5U7K65ne9GmrqDjryeI3808LsdvQJwVQZGZwUB2LiLcm8DncviG7nK0lmsgNNwQr6RZsa_a0
 AhBPPF5_RIShYnSmY3fi3SLGxvWfMUUenhvTC04ORX7.wUM.fiYpDfsr3H8_7lJ6GaBlZZQYvM0c
 Zfb1PrICBo0MFSTDRSjta1muMFyd3sImjIQyJymTz150iBs6n0DmB.RY__H89rBDT0y4H3mkOL_g
 brNqOKeHb_oiDEN_BjLU2HdZ.pKwoIfpDGStje6KitwZiDt7lsAuTx3Ez13XuzeGnL5Gj4.cmIQR
 pvKGB28lv9JtvettdlTECOGkB6TY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 27deef14-fe58-42dc-87e1-fbb32ce10e4e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Jun 2025 01:01:50 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7461f2feac0d1a8decd03521522bae75;
          Sat, 07 Jun 2025 00:51:41 +0000 (UTC)
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
Subject: [PATCH v4 2/4] LSM: security_lsmblob_to_secctx module selection
Date: Fri,  6 Jun 2025 17:51:32 -0700
Message-ID: <20250607005134.10488-3-casey@schaufler-ca.com>
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
index a0ff4fc69375..2707b514670f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -565,7 +565,8 @@ int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
 int security_netlink_send(struct sock *sk, struct sk_buff *skb);
 int security_ismaclabel(const char *name);
 int security_secid_to_secctx(u32 secid, struct lsm_context *cp);
-int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp);
+int security_lsmprop_to_secctx(struct lsm_prop *prop, struct lsm_context *cp,
+			       int lsmid);
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
 void security_release_secctx(struct lsm_context *cp);
 void security_inode_invalidate_secctx(struct inode *inode);
@@ -1542,7 +1543,8 @@ static inline int security_secid_to_secctx(u32 secid, struct lsm_context *cp)
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
index 2b9dde02f4de..306860434200 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3774,6 +3774,7 @@ EXPORT_SYMBOL(security_ismaclabel);
  * security_secid_to_secctx() - Convert a secid to a secctx
  * @secid: secid
  * @cp: the LSM context
+ * @lsmid: which security module to report
  *
  * Convert secid to security context.  If @cp is NULL the length of the
  * result will be returned, but no data will be returned.  This
@@ -3800,9 +3801,17 @@ EXPORT_SYMBOL(security_secid_to_secctx);
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
+		if (lsmid != LSM_ID_UNDEF && lsmid != scall->hl->lsmid->id)
+			continue;
+		return scall->hl->hook.lsmprop_to_secctx(prop, cp);
+	}
+	return LSM_RET_DEFAULT(lsmprop_to_secctx);
 }
 EXPORT_SYMBOL(security_lsmprop_to_secctx);
 
-- 
2.47.0

