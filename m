Received: from sonic303-27.consmr.mail.ne1.yahoo.com (sonic303-27.consmr.mail.ne1.yahoo.com [66.163.188.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AC2EF644
	for <selinux@vger.kernel.org>; Sat, 16 Aug 2025 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755365362; cv=none; b=ivhSbJ2VE92ruoubi52id2jIDUstt2dCB8YJ9slWWtKk7Fk27oH4Bx082X+P0ZtQuplCbkkXskRPYmVzQHO4hBFQ/hiBnUeKCbN+OTO2ZXKWteRFnS6z5ZVDUfQLsrQd0Chmv/VjZs745jSVw12VZtQHeXKYHjtcIJQlRREAZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755365362; c=relaxed/simple;
	bh=C5P+tLu6cIIx04l3pyG49Gdcj/UPcdobRXMvl97foK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqvxqQQqP2NbpUhSnWlvyib8FfxWKYDBHgQ/cnrFkMAQreWIrm/vPpUNsxsZlcuOsKCBho7QOlTUk5UX4EAHf292NyjJj9Gf0g/hrxv24FBIlYn8dkjzKs8dpnTBi3HGC9BywxgBPFQ7U57wlkM0uxDTROacz8V/5lzEAwXXetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=c82MDMh9; arc=none smtp.client-ip=66.163.188.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c82MDMh9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365359; bh=JAOFvb6OihN6QjGeRvcGY3pfNhXgR7xR7SOIfDOj5SU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=c82MDMh9U1iEQcGixMa2pw8Uh6DkOaeQfwn4gJ3MWZM5FKO1Xk46OwMygTUbiyIv9uHgmf8h777V67vVfLWsBB2vcnzvjuiADK5daEQ7iKCdo7yrspvUXgEEOAakH2y6K5MRwTI3SbsDnxU3YtTe76Z0dQsmwrVGvunum7k0KdpOQqHIY+5UP0FTyoRcneftcSd3tddOadiibSX2qw9TdSEwR7V4I4KnkFJuJRCNwo1xompVuWfEAk86tWMpR6E4505v3v5QMQcSSZb9Pgv3MKuUclszG5Vai1bk3wGdIrGi7T6rXVYbSfD3A2+xfbStz3trK+AyqONKcAeCp35+LQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755365359; bh=x7A01OSF8thSw1kzZ+7ZvFXx3fx79+rCd+JIIlNfRxd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=iR0nhhD7EpflxOoHf9uFPS5dpsz8y5Q2OaHlMu4AUHy0WMj0CIUWaOE3A9V4Vbht1BifXgryBd2upY50d1XpdiggBnodwv5Ey0VPInZ/UfwOFRulktFtS+w+S1qvUSV8IPBoHuCw0LARqo2eIEKeW+m/V6UHPDutEAqbG82wvwyPZSbgkhGjy8amvgUm+lU1suKggh9/2vFuBgb72afhWnqHCZ18MX2Q4Dsc9ip0JcCZJAVzAgfPnGcRlWySXGbE48P/LcM8kYp4aQadhDKO161IGviW5g3b9DM6cJm1IzGV0yrpj+aOxYJ/417hPfLwKg+ebQxKQ/lHWyqGGZKoGA==
X-YMail-OSG: L1dGlt0VM1kA5LO8lqdppqbPUysR_yUMZQh1zOu3FFyS5m6OLtMEH3K0ETELUhD
 4AaOt4.6BatNEx1KI5wyJX.xs3LkBeM23xHBl5spLSfnl6ppC3QJw2JPVWXVJjLNTsqgfoJFacVT
 izRsjWiRHm3IhjrcrjLCVH7GLJbP3LntvO1lunIepy48Irxmbsgu7GXtKtVVLi.RGm_o8ewnQgqq
 3HcqOeokg36MVMeXUkYMNI8wL8jjko2wHKuMHTn3SyCeVIePGRcavETD0yVytGA.6nSqmwWLDC_K
 hQ2T2mMevlR1st1Bswto1C_U1FkeX.qi_dNgba9FRH9P6sL7YO0vnryA6TUncXooOvpmqT2s6kiQ
 GV6z2HITxnygfBrdpWJy4LtTWQvbeUIcKFriU8YRG3mcFY0F61L2FyYJ2FciYfdivNY2Tb0RUEUO
 2Q0_R8vXA9EEr0bddeQH5_SGDjELVgY9aJpUGumgYpr9m09DfdRrR3u0_y7tPiwVlqsHndC61qY3
 XQgV3xnft8v68L9JUPgpKD2qaqPfstbK5mzrI9NMZIdCcNum4jqwKt1WKOAo07kN656xWlDdpFRM
 _9juWQA4H7LtQSee.AyIVHvQKu75ZmM.lCkBK5OBGbPQfB3Nscsw2Bkei07OBYVe0HWVK41hWgKu
 na.8i07M.SzurJBvIj2ohltrPG6Fyek.ZoM8O6R4BjCRqlu64pTjlwOJdjYf1ztXXqWzZq8v.evo
 hCYaVWVPu.ApYiid3pGLOSLDsvyete5DENFs1dutLZlpfyoJRwQpLdoDNntnM9Rw97S2nsKGnLxk
 BAJpPbfI21qTUaA5Z.3SrPnkVn7Y7bBsfOcikaef9EDOsqRBj6yk7ZbjK61lJH7Nm0HAQlFaSQwD
 JDZNSq_xPqitv4HrkyRRRjandeMehTgg9IF7Q7W13_RnpAuAx7VaMmC2tRenDPP007G1p5GDNFhA
 7tAU_9SxfoF9CksPkbV.LPqORqJAQjsn8N1KRwHLmCabwwQpZR.FQNhPUAoegKmy9KBfXlbd3tPa
 vqR11VXYnkt.yEUjzqxvoWM_7VHvVRdWKGw2UpmtjpLcv2E_5qLPrBBw3mjvT47vsoz16TsMj4_C
 b7aV3Y5HYjJZzVVrhNGezKHk2RrXcYJEh3sqbdXbMSK_vumjLglHQqfyrq1r8ILkdVehFzqfrHZd
 h.p_eR5nxjkMwmcuOo5ZAIZA4PwkQ33Pr9EOFnhLHp4zQN2W1DDRmCYA5ZxDqk60sC7eWhtNge7q
 FUGaAn2IJLbWrpqR56nxlSHd8pVGGxSQ762pl7dsgk8u60ASZjrtO18BJY3YzxT3DtsmSknCO6GL
 jVmsjxTm3myJn1yyECfsuK4XUxfbwCFqMRJ.KB6uf1vEMN5ldOwKn6fjd.bpG4iJW1XmGoWKKyKB
 5Ot8iT2fXKKogqCF_GGOztZIrGWNdgL52ghJhAwu2y3qN5e840249J6Q1wZRXGM0o.VOAqjmPXYD
 STYMZPeFJRa4OO7h.1DedWUWHnphraFBegOLNimZPikb4JTT4TuF6FNgN5ko1Y9SVuFfLJXQxX3S
 SMhsxL_eYGCz2GGJzEUsQ4eu96o29gREwz2jlw66_VSdG5PFN6klwQwwhm506QHfyABpWHY.ZgQz
 1eIRelhTaAKuLqZmRCM6OXHBwoeTGrMtcTvBCkM.W9gX04LvWsiO9u9qqCCOcKtYDvG9ThwT3Vvi
 BDJJyFk0FG_E49cdqLXGxBVsOZwcxMk_4lZOVMgOkaWw4yy1b5LNr5X0eOd3soy5Ug5VLBS7lY73
 zYXLpGANOgKgtIOKh4I2H15K4qLFBw2EdSS4bsH4K7IAfqJcHCNazratZNJodZwtF1ZWkQ_1tS0k
 sPrsEWY1Bjo2nyqky6ebcSSaTQ24s2FNB99aefQkvzH3r1Kfw.Os1cmnMQ4I.qYaJ495ZXP7Fxbo
 6cbtjKRXFZIktG_x_RHBlJ5ZhOPdldsSEiegMiVbBwvY3D4tupsvZErqdJJ9yp0oNanOej6aOV07
 IHa2PgGjZcHoSmm879P1uggfLTjc0yN2wrRydwzJ6ogDFNeDH464DFsZV6K2piGbpmYOeyBnFXru
 uVwHJC5jWQpQexOPEDXjO8WqKO5wDz6plR.9bVDr.med9YzL8ALm9R9P8r43lSIGd.VK8W3J3yOq
 hjjMGRRgJ6BSldTEMiu3dnQAFWusD9fDnBsnJve.axK2lZ79LYR8aA8fwzh9ALdGOOH5SB.YAEgS
 wHuR67Ix85irdwgZ.uTVD.yYlmPVMWGT1IYQatd4LJB.YSCSXoPmOFugM2vQvcg4CnvEIOVyxDk0
 1Q5jZp2QGFJJlP9hyCBk83HNrYIracTPqwg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9fb33337-403d-4094-8b68-8c0db04d233b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 Aug 2025 17:29:19 +0000
Received: by hermes--production-gq1-74d64bb7d7-45lk9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7374b10bab8e01c99c92e4838c45fe8;
          Sat, 16 Aug 2025 17:29:16 +0000 (UTC)
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
Subject: [PATCH v6 4/4] Audit: Add record for multiple object contexts
Date: Sat, 16 Aug 2025 10:28:59 -0700
Message-ID: <20250816172859.6437-5-casey@schaufler-ca.com>
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
 kernel/auditsc.c           | 38 +++++--------------------
 security/selinux/hooks.c   |  4 ++-
 security/smack/smack_lsm.c |  4 ++-
 6 files changed, 78 insertions(+), 34 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 38e5edffe371..150d34716f85 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -151,6 +151,7 @@ extern unsigned compat_signal_class[];
 
 /* bit values for audit_cfg_lsm */
 #define AUDIT_CFG_LSM_SECCTX_SUBJECT	BIT(0)
+#define AUDIT_CFG_LSM_SECCTX_OBJECT	BIT(1)
 
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
index c924b30f2524..bd7474fd8d2c 100644
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
@@ -305,6 +307,12 @@ void audit_cfg_lsm(const struct lsm_id *lsmid, int flags)
 				return;
 		audit_subj_lsms[audit_subj_secctx_cnt++] = lsmid;
 	}
+	if (flags & AUDIT_CFG_LSM_SECCTX_OBJECT) {
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
index 03f33da8d02e..006273c323dd 100644
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
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 975b84b466b4..3999f58a1842 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7619,7 +7619,9 @@ static __init int selinux_init(void)
 	cred_init_security();
 
 	/* Inform the audit system that secctx is used */
-	audit_cfg_lsm(&selinux_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+	audit_cfg_lsm(&selinux_lsmid,
+		      AUDIT_CFG_LSM_SECCTX_SUBJECT |
+		      AUDIT_CFG_LSM_SECCTX_OBJECT);
 
 	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
 	if (!default_noexec)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index eaff9b8901a7..fdf2f193a291 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5268,7 +5268,9 @@ static __init int smack_init(void)
 	init_smack_known_list();
 
 	/* Inform the audit system that secctx is used */
-	audit_cfg_lsm(&smack_lsmid, AUDIT_CFG_LSM_SECCTX_SUBJECT);
+	audit_cfg_lsm(&smack_lsmid,
+		      AUDIT_CFG_LSM_SECCTX_SUBJECT |
+		      AUDIT_CFG_LSM_SECCTX_OBJECT);
 
 	return 0;
 }
-- 
2.50.1

