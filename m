Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8821F9A8D
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734477651; cv=none; b=Op/8rdGtlWeC+7Pzm3tKEnR1Cz+08E81P6sG+Z4+iT07HRPMr7ybCNoE7XtBY2uejXGPbNQdtgrxlh/Q8OrJ7L7wwOUOUZYcL+43eWzEuZmbaqQO3awLBI5b2fTwllKi+p2hKhIFTzovWR5DUGhKyoPIDYD1il1xF7D0EvvoISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734477651; c=relaxed/simple;
	bh=I0fP6cgLlnip3XnnM5vVpq71S0hf/wDaANto21OycjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKAqXbquwzJneLQRfsj6NeA00JEPp2QaKgwC0aChyy7+JKzynDo31WswyJ1/6asokRuUbApi3Sm+HB5RxGdUbQ6+wC0pCBuV1EHze5TiDylOnB/lB6E4Sgw8SkmYwtD+LvUxU+NAJUjoM/nIbp7QayEy1fyjMXTbcAhFLt0h9LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UPxQ7WPq; arc=none smtp.client-ip=66.163.184.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UPxQ7WPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477648; bh=dK8El51AlxK7y+iABHZevEdQs9y2ZJ26xdxULCuBIVs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=UPxQ7WPqOhKzphtPdZocGW0NfFq40wyQAspkXoYtZCrVPkhtM2rE7bA14O7hD/sszYseB6hFuMQToS5mL8/Of0g0i8sKZUdqXlNedMt2Jrc+FF4rKNpnw7PnVyF/8eDxgqG2pbfvRC7vuCbXx/o1CQfKzqBrw5bhwyhd/7bjWwo8wkFVNtroe7nwqfuLjT1ZoRogZ8T4QFRHGQaqVQmI3WwTmEFqmSoIqJ9T8I9oHuPkD+tHGSBSu+biHGzXUiXN9p089kvJe6FiZC1WTn/L+293TUzwrUNDLxhqn4SI3E0Xs9VV9Gt8HLz2GGYbPTiQnfTGbsLyVwDT/Z8suqKUUg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734477648; bh=gjqUz4cS+JseF4go4vsENi0VAAV1sNZT+00Rhz8SP1K=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rpjKjLvvFpEpQ7Uehp2EZzfqsLuw/uVCKhYN5av+iAhxn9qSccY+Ff/a0z32EsFg1tU0UHU9m3ncRXFQgPF3jSIiV5QY5TLf134Ctj333/2iQpk1WJ2C1d80FsaTbz1IN1asR1wfIOKwGvBWDDyjltH/RVhPCucUG4ggcgCsyLojgzhHEo5MVuwu9ksHveGBJnag8b6rCRZzjMyxblaFL2UM3Q5xMwJOn3GWM1u8UpUUC7zCBWtHSCzXgwcWC+Q0LlAJQIYXMsOvONxLZTUXXC3Z97WyD9ENVyt22XAtlbAGFdQlc3aGILOlB3VcWCvBKzp3FB2WTFV589NjnQCcRA==
X-YMail-OSG: 1jCZQy8VM1kgdG.oOVlcWRBYUNubCqaUPyy0iUQbiQkWqFTSf7wqtE7P8HvyERg
 jj_m.oraJNhkgNZY4cBZAaiMYuePmhRa58O48eGGfg8EQK9UqR7iuZgXNTcj5rurZOUCsJGLRkTU
 4uUHZvIItrMVqd.Ahno9NAaaLjrwekxFk84PMzhbGAE4HvWBOZGm2qKz5Qru53IIt7RkZB8.82Ao
 O1EuO9oKugcJoPacyV1HN6.DpIMLdiqGJ7AEuy_eBDy5_jtDgjw97nD_Ww7P_oIzZR5ojk0Xbn1l
 b9Lliy8tJga.8qmGx1Ap2iPk0.V2EjlrhRwqs.M4nDBvPe1DiC.cpn0OKr6i7BAEuBhGHkd8KXVl
 4EJ4cQC8x3V7CERaTN7zCETzbpnbJw15X1LAbQKAj..YkGlFrmeCkN4SQRVgJno8DbVMx_YZbA.5
 Gr2QrntUZXWnXfE1OK0KkCAYWqlz055Tu8DzHApozS75N0DcWNyTPs4.HIBEU2Rux8bcCPCqDx_P
 HK06grnhvLID3DIRlkEwfPtDsuawtyYy_guLhWZybuaE23Afih4iWyobLSRseXai3Z8KouJpnS6L
 rR3XZlIS1nl2sxvmRQQUak18i2R5wGXl7DGIx2ckTq3uB4HU7n3hcQ8VfBkwp_rNR.NneJijQYrO
 jEs4sNurxBWUO5VOj9D1_HAFqIty1LstXFI6cbcfftyiHsfR5zP6CBZHMWpclH.nmYlUGTH5Bd1b
 .FFgTcUWo17ix_FdzI9vIXiG4Y9e4fbXH3iKY6WXYG8hQsiyG6T_UtxXYxw0Son8N_hGGNHp8OrV
 UIgoF9ehkIYS4K1YkDuDX2yusu.JhIXItOBhO3LAiostQ3NvdKpjYqGqxdsbF23xUKd2wyeaj4qu
 qfGE0qW7__klLTeT.51UQTqXkJ6zMPGvnXqh2v8fvIkSY3z7Z6.jmEEeSDqNW5fCuKT57aefZWwA
 GiBfE__1vYnluD.jQfdhxfrgeilBHUDg6441PPckqApqY5j00NLpvExYkfxAHOnC.22W0BKZ3fzd
 km_97EMAwVmcIgjp.SCoI3YMIzsibOCEk7J._fP_zGSYZx3kaFZyQj4UDN6FpyY24K.hdqRHSAXR
 yhrD3diZruib4VvcSTz.MNV9TjfNKGlGWR9Qtd3i4srBL_nAavqa0p0VHJKii29A7MQ4dz.7c.Wt
 _fZm_cmPxOuoKrzuOTQaNUSTE12V.FLn9CGOyKVIfV7RrtfF5KR4AATIDwftFfHJz1j5mLLGA3pd
 yyVMqIdS9.EOa_sfCiD46RpLhmuMrfuJqkSlMVBXYzIhNy.bJK5I4RWnN26DTIrnVgSiAwc0XaOV
 7OXexkJ19O632DwqzSSaNneR6_BzrHNybSUYrYA_8XA1LpKKIovgk9w5NhSb3EEeP6BY4FQ2KRKO
 B0tyK8OJad_kWDCMs6GV3LDrgJelUxMBlWRsMLpsQk7b82_.SsQUrVUHS8E.z.DBqlDZ_oodzv96
 i1nUcuDTkMYwz.fVBUdNaDsqsFCZ9hShA_MljAR6EA7nSNMNB.5Pu8LQ9hWtWzEBizQWror78c44
 _.tCYH1Dmtya9GaGRcmF6sqPNHaU3tRWXRMA.hmNg15Ve3x9OFR4mI6m_T3vXY9szrm0u0y7J9aB
 ePbX84BijMnEkV1ZXEtgopDUjdA6x0BEBi1o9J8U0lyvonH7v05hnKDRFocSwkAgTirRpv3SeJ2G
 jPivU7KinoO6lR9LauCm7.0Mio6Vhxt42Fz70Qia2WxVXRi7xpx_xpFeiAxgThsWrMXWCJXx6YRw
 nnPXiHXXDOTa3GVTk2f3x1Ey2ErJSnIRPAk92deqHr.dphEUCcY79kJfSJEKnkckeApLmJ.VSfob
 T9sFmXl8hs8_LMRJqQ6o616wbsitvJT.RuO2L2ildDnFpy2zs8Q16v1KliUxe_GvrHTopRuBgmRd
 cFPuXbONsNHtvXtJgG9Yx_d6n7aX3qe_sxYEN7EtGzPmnj9VN1d7qSjoiRZj3SXkl1rfdXWrs63d
 vjdvSxQM_f9WT5aBoCYCyv_N2dbDUgGsCVLbycUL1xCYrlUNQ54EGCuXk1colNW.mTA3.v3MLZ.z
 LR4AEfTJOy6Slx2yyPANVJzY0rqQpX65wlOrLq3CycwL1XkOJfwhYhcOCvH2cz3s2jTAF9ZVU10O
 ge8Qkf_BZqj2DbYujsj5zvE1xHkrKvcS62DOR.z04NT.fMdTZ1EmoZqLk2ozUUtymwKD0dNKu9CO
 0Smh886lKXQ6b.508gwzLdNYpP6EOWVFyqlGVF4DGopoWvPY8ovwBPYssiGyn0tyxIE_3W_QnO5q
 KzQOLgdXisTiBEfPRChfgJDBTyRn2Iw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3409acd7-d02f-424f-a121-8995ee43740b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 23:20:48 +0000
Received: by hermes--production-gq1-5dd4b47f46-5qmz7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5db27b1e04260d36afba83cfa77500a5;
          Tue, 17 Dec 2024 23:10:39 +0000 (UTC)
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
Subject: [PATCH 4/6] Audit: Add record for multiple task security contexts
Date: Tue, 17 Dec 2024 15:08:52 -0800
Message-ID: <20241217230854.6588-5-casey@schaufler-ca.com>
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

Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
An example of the MAC_TASK_CONTEXTS (1423) record is:

    type=MAC_TASK_CONTEXTS[1423]
    msg=audit(1600880931.832:113)
    subj_apparmor=unconfined
    subj_smack=_

When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record
the "subj=" field in other records in the event will be "subj=?".
An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
multiple security modules that may make access decisions based
on a subject security context.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  1 +
 include/linux/security.h   |  1 +
 include/uapi/linux/audit.h |  1 +
 kernel/audit.c             | 45 ++++++++++++++++++++++++++++++++------
 security/apparmor/lsm.c    |  1 +
 security/bpf/hooks.c       |  1 +
 security/security.c        |  3 +++
 security/selinux/hooks.c   |  1 +
 security/smack/smack_lsm.c |  1 +
 9 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fe..68aeab69dd02 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -81,6 +81,7 @@ struct lsm_static_calls_table {
 struct lsm_id {
 	const char *name;
 	u64 id;
+	bool lsmprop;
 };
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 540894695c4b..fd930a74a6b6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -168,6 +168,7 @@ struct lsm_prop {
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
 extern u32 lsm_active_cnt;
+extern u32 lsm_prop_cnt;
 extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 75e21a135483..49bbae475c35 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -146,6 +146,7 @@
 #define AUDIT_IPE_ACCESS	1420	/* IPE denial or grant */
 #define AUDIT_IPE_CONFIG_CHANGE	1421	/* IPE config change */
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
+#define AUDIT_MAC_TASK_CONTEXTS	1423	/* Multiple LSM task contexts */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/kernel/audit.c b/kernel/audit.c
index 5fe328f8fe22..e8661be573a3 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -54,6 +54,7 @@
 #include <net/netlink.h>
 #include <linux/skbuff.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
@@ -2241,21 +2242,51 @@ int audit_log_task_context(struct audit_buffer *ab)
 {
 	struct lsm_prop prop;
 	struct lsm_context ctx;
+	bool space = false;
 	int error;
+	int i;
 
 	security_current_getlsmprop_subj(&prop);
 	if (!lsmprop_is_set(&prop))
 		return 0;
 
-	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
-	if (error < 0) {
-		if (error != -EINVAL)
-			goto error_path;
+	if (lsm_prop_cnt < 2) {
+		error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
+		if (error < 0) {
+			if (error != -EINVAL)
+				goto error_path;
+			return 0;
+		}
+		audit_log_format(ab, " subj=%s", ctx.context);
+		security_release_secctx(&ctx);
 		return 0;
 	}
-
-	audit_log_format(ab, " subj=%s", ctx.context);
-	security_release_secctx(&ctx);
+	/* Multiple LSMs provide contexts. Include an aux record. */
+	audit_log_format(ab, " subj=?");
+	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
+	if (error)
+		goto error_path;
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (!lsm_idlist[i]->lsmprop)
+			continue;
+		error = security_lsmprop_to_secctx(&prop, &ctx,
+						   lsm_idlist[i]->id);
+		if (error < 0) {
+			if (error == -EOPNOTSUPP)
+				continue;
+			audit_log_format(ab, "%ssubj_%s=?", space ? " " : "",
+					 lsm_idlist[i]->name);
+			if (error != -EINVAL)
+				audit_panic("error in audit_log_task_context");
+		} else {
+			audit_log_format(ab, "%ssubj_%s=%s", space ? " " : "",
+					 lsm_idlist[i]->name, ctx.context);
+			security_release_secctx(&ctx);
+		}
+		space = true;
+	}
+	audit_buffer_aux_end(ab);
 	return 0;
 
 error_path:
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1edc12862a7d..771bef511a38 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1427,6 +1427,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init = {
 static const struct lsm_id apparmor_lsmid = {
 	.name = "apparmor",
 	.id = LSM_ID_APPARMOR,
+	.lsmprop = true,
 };
 
 static struct security_hook_list apparmor_hooks[] __ro_after_init = {
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 3663aec7bcbd..64a11392856e 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -19,6 +19,7 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 static const struct lsm_id bpf_lsmid = {
 	.name = "bpf",
 	.id = LSM_ID_BPF,
+	.lsmprop = false, /* property exists, but will not be used */
 };
 
 static int __init bpf_lsm_init(void)
diff --git a/security/security.c b/security/security.c
index 82fa08e0e125..3c3cc65ba637 100644
--- a/security/security.c
+++ b/security/security.c
@@ -320,6 +320,7 @@ static void __init initialize_lsm(struct lsm_info *lsm)
  * Current index to use while initializing the lsm id list.
  */
 u32 lsm_active_cnt __ro_after_init;
+u32 lsm_prop_cnt __ro_after_init;
 const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
@@ -626,6 +627,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		if (lsm_active_cnt >= MAX_LSM_COUNT)
 			panic("%s Too many LSMs registered.\n", __func__);
 		lsm_idlist[lsm_active_cnt++] = lsmid;
+		if (lsmid->lsmprop)
+			lsm_prop_cnt++;
 	}
 
 	for (i = 0; i < count; i++) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a2e72f1212a3..05b857ef18a5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7141,6 +7141,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
 static const struct lsm_id selinux_lsmid = {
 	.name = "selinux",
 	.id = LSM_ID_SELINUX,
+	.lsmprop = true,
 };
 
 /*
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 55a556f17ade..adb052b1b5e6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -5073,6 +5073,7 @@ struct lsm_blob_sizes smack_blob_sizes __ro_after_init = {
 static const struct lsm_id smack_lsmid = {
 	.name = "smack",
 	.id = LSM_ID_SMACK,
+	.lsmprop = true,
 };
 
 static struct security_hook_list smack_hooks[] __ro_after_init = {
-- 
2.47.0

