Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90021CC7C
	for <selinux@vger.kernel.org>; Wed, 19 Mar 2025 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423286; cv=none; b=ZYuEbowqR0z1l+goUK5vVCyVFG8e06aePQ0t4yjqonfvN3FnIGdVLOxkOIIt2XOeAIwOsZRIm2zQqLnTCW1iIhJXYg9wafMJGc5wwREg9rqOxZRinxIOfmmjD5vYW0FY0ClyM2bStGoI1s9AyEiAlvu0YfdsbeZ0j8dzdAqmwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423286; c=relaxed/simple;
	bh=qL4g3N6FXuJsUsttnv4TNIXfAGBc2L0P8lBjLNTyqiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvsSJBg6hhjrgTKDn6zaAEhQ/yv6O/oMAOoq4K81/OU1h6s+zOT1TsRPgdvB6jVSsz1cf0uBZNR7N0NpCxwP38SQR5xdRJrPYblfsrgQyENbxf/ncU55K9ZMBC8rAkpUHBruIJpzHMNDv1QcfNh+Ph/tYIKfyGuMBK0SOSMzmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TEopHSps; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TEopHSps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423278; bh=zMeGIPdD6eYIwJBXge0SosqRCob/X0LuII/yQlL0eE8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=TEopHSpsdZqbKMwD6UHGhLrlN2/qv0Ht/721pAYOS+YkTKv6pXbJfOCBnopjSgBeJ9xPPLNw3tRDcszE0nRum/S4SfIq9HWBFdi+YUQnMfuK4j8hmv+raVCTX76kJ/nJPFz+g3GavBgSKQbmC+gwfQ7J1xDt0fOjpAJc9M3dCGWurJ+/jYWUeDOpdKRKRvGeX2XvOaT93mYoIQc64RUxWVCFnz+mbiK2rllk7vJPmpWmJIk6esNgAblRNnpCErumGBUm0ll+ltTSjgVAdK/c3ZZhHMXMVoEK9OssG5YB0Jatkl65I0I1KfGOXh2jZeczonWOPkKvYrUw+ed1wIdMVQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1742423278; bh=5Fadfbdv9uwsPdUDgzEIVm0LncbQnXR04DbDjaV8WG3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tQhEyDGPw3YTq3vzAOikvsGzwNKt2NTyA4orD050heTeXXZjMs/zMkmo4TYI8E0AyLRYkhZMWivg0KYOKK4w6XC1g6mwH+lGzVZfyXuxR+WfXse7ODJrj13ZsojUMHnXbUmzU6MxHS/9yTIDUDBzcsQ+mWfr0mlmVBwms7yKvmg/o3XFE0cMNzH5WTpsmr6QrhiylYr491kqCQuwY7GKxzUZwngWHRCiJIRqO+KhfxpHH8RXLiRkEuu/MEErdTLxdqq/fFIxxYjCCxSCWpitscd+bBSgZoUCoLvC3nEb0OCbQBIST8b/xWEGs9NOHZziQN8gZyAQ0njQ7IvqTHVsQQ==
X-YMail-OSG: eSdttM0VM1lfNn17QcxN3K8OvvmVOpNwHQL.q0ZgbrjB0HiG7WjC_j54nzEfn3Q
 IcfrS55yJNxtLKjgAn1lBvnQtj_LA.S4_g0gTOqFt1gbJC613XSzRPrFaP40176fAFmKASwz6R8r
 pKnaRauT_5uqd28W1lScq6X9rjtGFKSyh0uEjAWxJPJZZPcZaYkHkrd2bLzpHCSRj.b1xxkl43Sd
 1lJ01EvjsyDmPQ6Gn6t9ba4sO0DYcLJmIMv0zK.f7y8ftlxcvevpxUyX4qO1NpBzukCo1H30p8JT
 Gu5qChsvgMsIkInTNvO0i9yoQCDxZcGysWS3Vy3zd.DwlRItADHBdAB2hav8ohpASnaD7N2blGhp
 n5RxdiaXYHYpixF.47Xd_tU5RHUQ5XNU8HAnlIAreVXT14ww2z9TxZQgcxVzouVmk.9RGKTgVpIG
 bb4MDYt25NzurH.addPtGKvZkb7gZ.rXHKRfaDIaTAj3xNrmMsohIV.vlugh3mqPeBfD0W5O9vBB
 fQfIRrD.JofP8FkUWddCD_AejmLVHmG7yHMthBYgai2iqkXMTLhQdx52w82MmA0N8QnFEtmqboO4
 Wy23_30OEXNqdWBHchmH9daDr5UeFtq3IDKPrMrXS8yqmlsWenvDfgCigb60rpdLmaw9WNY9vZze
 XfcnyQg7ChdbQfu4IpiGUDydV9po2_8mxJzhvvNMwgAPeBZmKHhjazXplGgU3Am6XufaMhO44EzE
 n7xlfajKxbkYh6TrJJInjoXLn6oL.80A_kNC6Vq6Ys6.CnXw0Ey.DnMmnYj6lvkHWpptBqIACwbg
 4SQ5ZAjElFDZseHs.cmKcDuxjzfkqkOjSkEacDZYCp0R6jhaTIVkvIZZX8GXZFELdwZTL3x7hG3R
 Exybz0up.vyjByOxCZAxsD7ec4FgPWCHiQPlhUhPQWEvy2EXdvATKDugYH5.ZYyP7PewRkHFq0LS
 CcqWu6wZWSs3sTr39NJmDVxaQybm0RvwJa7yxA9MKF0DD16KAtYNi2aWGfuhspLbjb8sZwetm9p1
 _0E.k5WGVqruXFfvt_vUpHypzKEwZyC_VV24_FHVLEdKHkyJMGIemya0NozqxKs06BDPEU2ebwBA
 awvQtTiXN4fHbq4.aZy4I7tDbUVsQZKXkr3dfkY6hahcrRuPwaX5YJpqtRkJiZNn8KUQ2V5qZqWF
 qKEZd6oedrO06pes2yiy46grKvrOWSDu4eRezLoji_4DkIxVQSlip35nXDasf978GdOyurn9a7rv
 Cz4e9_dyGm.3Riqi2SzCwxgMf.ieJx6qiIFroxsNJ_.TYd.1y5hPttmZr4wjYuCnxC3xFuKS74yK
 UmgJMnIWyemjLuaM9MlciHuSE1VCK_U4z_PJC5YcV7ioVylk3HRz_UKwTPabjnfGt9_b2eyWGYE2
 xXYUFfsN0bRNSXV.gUBk_SOmm6MXi8y_HWZdK2vG4MG25XhSHAu8PJBPts1y5wzDIdMbfip20nTm
 cuAVBbvFQqgIchScYN9pMeV7W_CU5W25AOQaevOCTPE2LQJXNjX_ntW70L1kfSHMiXtuH76zUrsl
 Xei_X_rxA7QgH60LW1qc.7B8dXdPxiOiKVXpE0WahiUuT1jX.bWMIzNFWOQCbP3Xku82Ur2dHEYH
 QO__PfH91Bo85qwpmESBTjV1b2WUtLb9jw19mwpOdDR9aL9FFvPrM9k081GuwQCeliSaM.7bcRdU
 inj6FMYTIW4HaBqZTI__5jEU_gM6r_ZKEtiGdeAbxkDrWIS_KHK_J2l9.shmOingEAUfCZ4wuWad
 ZyLc3bHeLhNKUFsKm1Tn9KgycGj.8CdcqOTGontGuMFL9hRNrHgdhrrTLit.ng4ZAoulElG_uPAp
 8AijPuFvPjWATrh6cjHKr_1xt6ZlhF8TvqtR3me0UOSiXkba1Cm.zshhgZAwTTmYlZM2WpX1JYxU
 ezbOQR1UEe1R_34jkZsZ8xo26D6W4g80wIVoND9foF5hKAOZ3Kdev7s8HCSBYJvdMMJW4tDyOuPU
 dbWyBlatvudCf.78SQlBwZl1nKqk.HQWgP2R0rnnmSoOOamB_Ms9plQhbxGhYzmmxHxPwTv0GB6J
 z6qCPzlPARDcWBJl6E6R6g2FbQZOqrTsnU3lxrARia84tgb6azFiua17W4wnbMQydkJ.fRaN0Bha
 wUGbMURMYQ4bfBMBGkleU3kVv3Hp4pVedDCbww.J5ARr2dt_LT9xcyIMCKDb4MJCzeLKHxfKA6lj
 ORu_Tu4Zi3wTE83hqLISq8wLHeAIt8rlP1CBW7oFm6rRTrR0UGRtiFVgj4B0LavC8AA.kAAp1THF
 BPl5n9Gd9iuS.nIcyPk.aTRnGZg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d3bfbc97-27c9-4eb1-a37e-8baa6e24db61
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Mar 2025 22:27:58 +0000
Received: by hermes--production-gq1-7d5f4447dd-jcqz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e9bd32085bcf3fce38fe3767fad9b05;
          Wed, 19 Mar 2025 22:27:54 +0000 (UTC)
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
Subject: [PATCH v3 4/5] Audit: multiple subject lsm values for netlabel
Date: Wed, 19 Mar 2025 15:27:43 -0700
Message-ID: <20250319222744.17576-5-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
This is used in netlabel auditing to provide multiple subject security
contexts as necessary.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  7 +++++++
 kernel/audit.c               | 28 +++++++++++++++++++++-------
 net/netlabel/netlabel_user.c |  9 +--------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index b493ca5976cf..3402e3ca43c6 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -38,6 +38,7 @@ struct audit_tree;
 struct sk_buff;
 struct kern_ipc_perm;
 struct lsm_id;
+struct lsm_prop;
 
 struct audit_krule {
 	u32			pflags;
@@ -186,6 +187,7 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -248,6 +250,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subj_ctx(struct audit_buffer *ab,
+				     struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index 7ec3919ae925..8ce453f6dc7d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2255,20 +2255,25 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+/**
+ * audit_log_subj_ctx - Add LSM subject information
+ * @ab: audit_buffer
+ * @prop: LSM subject properties.
+ *
+ * Add a subj= field and, if necessary, a AUDIT_MAC_TASK_CONTEXTS record.
+ */
+int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
 {
-	struct lsm_prop prop;
 	struct lsm_context ctx;
 	bool space = false;
 	int error;
 	int i;
 
-	security_current_getlsmprop_subj(&prop);
-	if (!lsmprop_is_set(&prop))
+	if (!lsmprop_is_set(prop))
 		return 0;
 
 	if (audit_secctx_cnt < 2) {
-		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
+		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
 		if (error < 0) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2285,7 +2290,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 		goto error_path;
 
 	for (i = 0; i < audit_secctx_cnt; i++) {
-		error = security_lsmprop_to_secctx(&prop, &ctx,
+		error = security_lsmprop_to_secctx(prop, &ctx,
 						   audit_lsms[i]->id);
 		if (error < 0) {
 			if (error == -EOPNOTSUPP)
@@ -2305,9 +2310,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subj_ctx");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subj_ctx);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return audit_log_subj_ctx(ab, &prop);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 6d6545297ee3..0da652844dd6 100644
--- a/net/netlabel/netlabel_user.c
+++ b/net/netlabel/netlabel_user.c
@@ -84,7 +84,6 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 					       struct netlbl_audit *audit_info)
 {
 	struct audit_buffer *audit_buf;
-	struct lsm_context ctx;
 
 	if (audit_enabled == AUDIT_OFF)
 		return NULL;
@@ -96,13 +95,7 @@ struct audit_buffer *netlbl_audit_start_common(int type,
 	audit_log_format(audit_buf, "netlabel: auid=%u ses=%u",
 			 from_kuid(&init_user_ns, audit_info->loginuid),
 			 audit_info->sessionid);
-
-	if (lsmprop_is_set(&audit_info->prop) &&
-	    security_lsmprop_to_secctx(&audit_info->prop, &ctx,
-				       LSM_ID_UNDEF) > 0) {
-		audit_log_format(audit_buf, " subj=%s", ctx.context);
-		security_release_secctx(&ctx);
-	}
+	audit_log_subj_ctx(audit_buf, &audit_info->prop);
 
 	return audit_buf;
 }
-- 
2.47.0

