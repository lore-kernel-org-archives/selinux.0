Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C62417C3
	for <selinux@vger.kernel.org>; Fri,  7 Mar 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741372738; cv=none; b=aYz3GkdpVSZw3EW7OAXDEWPlxW/oKZ75gAUk1fWXovf0Vg92Uy0I3FaMx/LE9Ny0eaGQdqhduCSxu76tLLVLOMffQe/Pn1CRRMibXF4ssbDPA/iXrLBepP8j3tbRXtq+WWroIT07WxATnH5weNr0HWWx/Bflim/7eHw1/4nLFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741372738; c=relaxed/simple;
	bh=a42n1s+VWPRtyE3Sl9hkkLv1dafasepGqLQ4YT5lLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg32GFk09PxIvPTQzFpl/yxi9hyn7WAUdWC3DV0bfL8L1MRNvB91hjmAxYsC9LDpxVg9udkTRAQUMMHSa3pU29m0WkbdwXj3myR+UhXuOxoFLACa6RsJVY70V5SUBkRxcizdIZKOrTd2K8ESyDROkpsqZzR4a953KXBfXbbKpOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=S097tbpb; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="S097tbpb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372735; bh=0iPBfsQ0COUDj9DZCSGt4GDlspCeYC9Uy3b95YoJUYc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=S097tbpb8NJAawYs92Tm/KLDuL3dEFUSL3Di7M+H4THPR4jsUa8SLLq2HQGNfAvPW0nUpSJFv4l2yIX/YXrwRZw8q9vYaGaWYIaCryRF8fs2e79LL9aFozQsoz3m1KT/4QAo19R+KvVMWSrU/RpL3VPCa/IMFV4x4CsJV43QIHx3tq8wesEabfshsRBXQEmg6vLrudFjDtsG5+4VDnZ41f9rw15avXdRSjsdDA2fr2W7xuGo+CS0Gy3eX2xQuZ96ZAYnC6W8oW6nAiQ/TPMjwAJt6ItEb4bd1iU+lLNPDlH3pduLr82A+vhQzclixETYSvk5H6am0FoIwnGkk3mR5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1741372735; bh=g4osgIhVmDA3LLFYhF0eCwXfopOcq85WB1daRoHZFJn=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=pjoiU3B0jGGtMotNepRC+WHWjb9Qlzd8QTQK5P59+UDRiCbPFQ86JAEzjgvGlg+xe0OPqiIqLJ0HvLliGA60AGs3zZknJ9yEwAnCq+kSV+jZm/dakTGBTwJ9iu52shftt9+UEBIji/dvjgIeJBIU4qrOiZrw1C41kfVBwYWof6Gt35an/0vU/Jmp8OQoTJEfXMCTS6gBBa3cSpvMR6obPCOZumw5+19FKjU2AdVBJkspliiIuOqF8yFkDJSQ0s4uT8J+BdehQKr/f1JMpVPrW1J4LuPascfcqdzsMvBR4hXwQX9mSi2lXSCKHwGg0313ZExCk4xVsb/6uOFZUBxSuQ==
X-YMail-OSG: dFqsXZ0VM1n9qw8n33XuKftAa0wW3KqyfjeAn1IqLyoIx5JK5CgacDZSjvQdiij
 z9EM8ohxUWeFBZNQ1sWOv0NRo3vtEaFvxxKMnrZiB59ryT.ZJATBsJiJ5tGO59C6Deqsal1.B9r7
 p1jbOXW_NO.MwCKp.OVMr7W8lXjYzp9EAudjX7Jbh_liIuOl.Rk0Rzapit6552SDILV7AX8OiZUa
 kKqxySFBBBsHin83fxU2OpcEMuBna_J1Fk7uBaVjIpCx_.JMHYe3EkQqxhuJ.kMNZIR_rlUCwdKx
 zjxY7d81DaR7DE_lB0bS43M8G.z0wMVSuRH.s2pURGc_gp4QXB6lFtx1ZBn2S4LaqRyVZxtael3.
 Nk5O1V1ZkBpNaaye32lSr1wb1pvyitcCrcXPr2ugnoXNRBmphrztwDYfg_Nt9I5lWia5bpCXoGat
 S4LWtyVQEejbnXPu4urH.k0qESCPI2rrNvntAw7GIEt2c_PQt3qVUXe.QIhWK1XJ3D.SlSgglmMa
 bv0giQ4ichkC1tpU9yGxhPPN_zXtTTuJW7uaryvgWkToYcwQ4ncxeT0KeB7OETNnaX9MHU7hCt31
 zg_Ahpai73Xw3LYauxjLExyZrM62BdcGufI0Fpl.ef9bISiB6m9RPGqwLvV7_0Oi_RzFDsNBNAGb
 MTJG5VAiY0Q_0ScOBN7Egrtp_4bpQhuwF9jgBlgGyaKTHNpSRN3WNtH6nvHyarYoYKYx7tZ2DjC4
 nP2sRq25wTz6.3ZriVqXWYTl4VCIu2XQDy04EirV_7zlqPUVuuqn3uR9b.VDGBg4N8mWK4WkDD9O
 8JZ81g20ajS.C.JekaEHqCCIAjG13wcQ2FcBEELGP9D8zByHwFxKkcA1eL02IE0I.CP862b7T8u3
 dkyzvRSVe1HZH6F.wuJEsImvKJeLDsUa7NJfEsHsvpBlo6AuHQBL1_jEoqe.PL16JehifEIR4t8z
 tPg6Gz.MwnLuC6YVoSQ1sTBpCZ1TfBplnzfcGQ18DRQPRlR0K3G1podJiLVePBvvcfeLppFrTW.m
 5PsO8s.ojbMNvPdO.ElIG7SlmKOxlu1tabvDHF7rkSeBEpD7yTCqp7YyLQBPoEb72GHCUxC9PHsk
 Dy1fiYQkRHsWASjh9vHBDvK.f.sSjLMzjLvkURWCcxxqomPNiMzXq0t.JTrxAPqe.h8BLOZlnViH
 mc1JG76nSomtLgHvExAOR2420SBHM3RxvQ1eoc5TyRGKkwrXx583zCUieUYhotkN.nEVQJgc4NON
 6euQw469CqC0Q3YCZ9jOa5Am8Vz5Dj0B0I723kJGH2sFgzdd93flkO.oczhx4YUv0wxuX.m_kx.P
 3y_eyqWCjXvcHJkxn.M0txaAJLuJ3pY0PdjrZHa2xY9_eNqJY0PtydhoboX9fUVbBow6YnusFMKZ
 484o1iLClmmKxSR_r1DSeTVJYjNpJpkRxgB8sc4pi4IeQLJLrUc12x1fBJFGX4fMK1dju.3g2UKP
 C_S2egL0B_e6tbIw4ll_dWLKfRMWQlhHhuYdhjY7ZvxK72d5ajHOPGjS0tZvnUmqJ7PNIrTgzY40
 hwce._ka6vkTmT0hCtbEFLLEzRCWF7BFJGsQ01ikZMGBqsOqOAjvF0toGMBO8rbmbOXdcWJgef4U
 mjVvAuqTc9dD92krlk_HuWKKCsH8hrk3nhbyRqw41ipFWcLpuwupLs6FokKnKBb3oE8R_qbP4nge
 knE_phNHXBfXYuQR912UBK3llzXna1JLjU3DO5TLQhGYRqJTDp4eXDwm1lx7wfMnWDt9hqMilo_P
 VFHEdYYEqSbCL._wTiaFi5AMMJf2Byh.io9P7bg_8h8swGEzfcoRaZf92giaQycRMnBpOOKEpXCb
 Hif2eSkGfJqouadKxcDe.dys2kBE9c8SpADnFh2_C_a8UqVmPSBQboQnBTMgHif1W5XdatxeVAbQ
 wL5NymPqZ2BpT3nXmuiLtCQRYWIMoAeCFB20XcNptcxH4jeM88bYQHsbZd1bMGBoPFGZiQ7eRCr5
 iniTzebU2zm7vsZAoP5xr0fgrzv2ddoJhjvbiOqXpGurjesXNYkvZgdhxmLTbROwIMSbKRqrfKfs
 TWPUcCKpRbb85LDGoxfWcKnPWMDkWRGBtj1EjIwZiJVJhYI4xGAp1y7UF.Oj6gH11ix5AYv9LyCx
 FlCJ11z6cftRfP8JTptLKoXHfStL1hP19E8_y9uvYzkVCod8qZHtFfOpgVZXyf7Kq5if2V45t8sE
 YKkAmZkdBWxsZ1PVbQ70plNd0JBHs4hKIvnZbxQ7DJTgZhPAR0_otvyEWhaMHpsLq6nYOQoQ9WRc
 yyRh6Tan4WcS77bIeQa6tJ7Eg.Ok-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7add6132-3db4-439b-9809-d825a1469f44
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Mar 2025 18:38:55 +0000
Received: by hermes--production-gq1-7d5f4447dd-mxg2z (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84a3ec74d8bfe114e53660abafd57a8a;
          Fri, 07 Mar 2025 18:38:51 +0000 (UTC)
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
Subject: [PATCH v2 5/6] Audit: multiple subject lsm values for netlabel
Date: Fri,  7 Mar 2025 10:37:00 -0800
Message-ID: <20250307183701.16970-6-casey@schaufler-ca.com>
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

Refactor audit_log_task_context(), creating a new
audit_log_subject_context(). This is used in netlabel auditing
to provide multiple subject security contexts as necessary.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/audit.h        |  8 ++++++++
 kernel/audit.c               | 21 ++++++++++++++-------
 net/netlabel/netlabel_user.c |  9 +--------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 0050ef288ab3..ee3e2ce70c45 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -37,6 +37,7 @@ struct audit_watch;
 struct audit_tree;
 struct sk_buff;
 struct kern_ipc_perm;
+struct lsm_prop;
 
 struct audit_krule {
 	u32			pflags;
@@ -185,6 +186,8 @@ extern void		    audit_log_path_denied(int type,
 						  const char *operation);
 extern void		    audit_log_lost(const char *message);
 
+extern int audit_log_subject_context(struct audit_buffer *ab,
+				     struct lsm_prop *blob);
 extern int audit_log_task_context(struct audit_buffer *ab);
 extern void audit_log_task_info(struct audit_buffer *ab);
 
@@ -245,6 +248,11 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_path_denied(int type, const char *operation)
 { }
+static inline int audit_log_subject_context(struct audit_buffer *ab,
+					    struct lsm_prop *prop)
+{
+	return 0;
+}
 static inline int audit_log_task_context(struct audit_buffer *ab)
 {
 	return 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index 59eaf69ee8ac..f0c1f0c0b250 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2238,20 +2238,18 @@ static void audit_buffer_aux_end(struct audit_buffer *ab)
 	ab->skb = skb_peek(&ab->skb_list);
 }
 
-int audit_log_task_context(struct audit_buffer *ab)
+int audit_log_subject_context(struct audit_buffer *ab, struct lsm_prop *prop)
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
 
 	if (lsm_subjctx_cnt < 2) {
-		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
+		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
 		if (error < 0) {
 			if (error != -EINVAL)
 				goto error_path;
@@ -2270,7 +2268,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	for (i = 0; i < lsm_active_cnt; i++) {
 		if (!lsm_idlist[i]->subjctx)
 			continue;
-		error = security_lsmprop_to_secctx(&prop, &ctx,
+		error = security_lsmprop_to_secctx(prop, &ctx,
 						   lsm_idlist[i]->id);
 		if (error < 0) {
 			if (error == -EOPNOTSUPP)
@@ -2290,9 +2288,18 @@ int audit_log_task_context(struct audit_buffer *ab)
 	return 0;
 
 error_path:
-	audit_panic("error in audit_log_task_context");
+	audit_panic("error in audit_log_subject_context");
 	return error;
 }
+EXPORT_SYMBOL(audit_log_subject_context);
+
+int audit_log_task_context(struct audit_buffer *ab)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return audit_log_subject_context(ab, &prop);
+}
 EXPORT_SYMBOL(audit_log_task_context);
 
 void audit_log_d_path_exe(struct audit_buffer *ab,
diff --git a/net/netlabel/netlabel_user.c b/net/netlabel/netlabel_user.c
index 6d6545297ee3..3d46ea6a8bb8 100644
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
+	audit_log_subject_context(audit_buf, &audit_info->prop);
 
 	return audit_buf;
 }
-- 
2.47.0

