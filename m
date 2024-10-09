Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD221836D9
	for <selinux@vger.kernel.org>; Wed,  9 Oct 2024 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495858; cv=none; b=ONyO0tUQ6njFLhpEpHIbqIMX605hPHoD7aUehlaLqdW+4lTJ0qijV/4PB1xVKDZA6I283ldVu7AAIyJFxcxvDZu6HvY21Kf875DYB6aAXYXCBhitx9WP1iulCt3E/yc7WQrspYN5yqdHIvwfkItkcYTwZ9O13OSPGu1TJGNoB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495858; c=relaxed/simple;
	bh=XvGWfkmcH7nAMpYK2DdAO1sQmGPj7qas5fPpbNt+Mo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWfg38ExtqWwtEKlqBj3tSBSA7KUNTa8GSHFQ/pezZY65T9j+EXUnadjnLLrLdd9a81btP/91wZpllCRqUn1dfb4xbHEYrP4vIpwQ4Pf7ixA1IxfWmfiozu7NaAnGFsN0+3A6cFh6/Z2hCQJY34ZJHIPhfl+fy2AYIiP6hWEFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aDLZOj6u; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aDLZOj6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495856; bh=gzQThXVQy4HIM0mPZcyXyGY6RPyuqTq8g7PaG6aQI1A=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=aDLZOj6upPuHSWF2iw/kiVRQnz+imyh7aGSOkjXOxFO/AYYrJXFwaXm3NJBM6D9nbeWIkQRk8ePTLSu9xhnLO1jKCFVf0O7+YGE0TBtij1ft1L4sbLDys/5vb4H9pf0jl1sTIMSUGx/kPz4pMVrgpRIustZtvpf38H9LlwW9/DoMpP+sPeQ2XAupwF1H3iUUGdRQ8tNkZtjnhxql/fBh6D6dPZoQe4+/o+lW1UWHPCL7ZCXeprscV5A7hfbRZNuBdWQdcvSrzvDIza74+lcziaT9X4Lv5TPkDgIE7vyjlcO3kcYHTI0+Xl8ClrtqONpFZfJTeqz5uV8resWH1mo9pQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728495856; bh=T/BaLJW8cn6Qu+vcJsi0mEEnGPml6v7y9KN5K0/zC2k=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=qN6Fpc6fsdD4PAFNKNqUnXz/7CUldfSwi19NHgSNurqddvdIIi7DfBFGDnab0spJt61suBWcg5BASecTVY1p5dqRtyvy54jrFwJxuTIXfuRFoCDwtLj/Cnw/KXLB+NLl66P4Zlt17TtMq6ssq4I/dSLU4RNq3FOaOOItOb4wTtxcCEPYI0aLirpiPJg0E3MMREY7LdyYu+Hcp474f7k2fTDKjdZXB0n82n7gjZa5t5X/IfCJxFTwvaShHTMh8V7oJBn63QCjcDsn64LSk/zS8664yKtroIrhPgeVJsMdQk/qCk9mM8R5wi0N3scRDSy752oI/K4pe9EF0PntJ1x7Og==
X-YMail-OSG: Uu3ZiBcVM1nrd.RFW_s5F7aGyYYrd11gBauHFzG1mF8wbtd2Kkk4o8TuiEdXcry
 LACyH5Tr4jz9qZoI89UMnWjamiXvDwNy2XTzpHlqEP2DpANlHwLfjaZ_KjUeL7DfjKcMcI8r8XEx
 IY.P_wGnTRnAPJL88QGhDvAZB7rQwMKiBdbCa0i2uIgJGbmX_BG0gUzbVuNOuYnFlA_68Y5SJaOL
 Wtbj4jtnoxr4J6p6c5wmG6_rB52awAXVbLiM.iMStS0aFo0l46A29rs2go0KOy1q8X.7SzoXSPin
 dnCppWRXi7BX82DgMndqpUF5p5WPGk1260.ai2vgYG0c.wdzRDLGhsuMDT_SFqk_RcqMo9RVOqqk
 AtnsvLSy5fGtGXCS3xNcCgmC.pZngcrx9LIqT8jRa2GUSgftqwh_6i_gCkGBSaVeUftTQ5goBFyL
 Y98_.Qbp91weDFfL6z.iQhyPUMxfZVvetRHZovVAAaD2nBEWNvA9CCJ5vbcibGx4lNfcxvYfULiL
 qQGxWZaggAEoV_42deSwbGO.epho.FAAlhH0Fq3sVJvX_TTVvMoaAdTieNhyVyPJkRpAPZg.iZtU
 G4FQN5c8FRmy8x6GsHbmrOkP9B.skvo10C2TY3oH58iuQyeR79qHuXz6835IRwWOYej6Qpjg9x_G
 G2dsj05oT3ANu20H50eUHZe.ed2XIcNTJ0jSEvm9mE0DF2iwdWGSt60RPLFtEaWIWlwHE5EwVRve
 fzYc_pnpQJVcdaeSTcfmNeAw_NJURdjY3VDyYM.boUt4Dc0RoMdHq4EBwR6S0FgWDaA4aSyJUH7W
 B586nisljAwi8j73fCvwkYwQ452tCijB8N7eSX.9gpRyh0dPbPNYtIyWZQQiqur9wuTjTwrumQVc
 7.VhJ_du7Gf3DTIs.uGlmEYe.XlrPjSc2AAV1g6oRzv6fTYEq0.0T25aJlQm_8Ql3s.Ivkk9uRmI
 6I4cE48E8vr8v_baoSV5CAigLJaUBnJtjpYH2ii8GzQ_9dJgZG9D2rEjGFeMmY2ztZm8gwV1yJwa
 L9Nx5TSVcrizVNEwzzXkwTHyuImRRxdlOvz9XAefZ87vJfh.6CQKINnxclBXduzZWbUlaU5YQlo0
 DOxDj0...wPmQbUw8MUnMPO.yaZOFcb_iLoCRzKaXfkDT.uDBsnlBSXWiYf1D4Tw2R61wPolquW_
 CxTEO9cBi_gOJNJI5wR5qV7p2qpQuQ1JSRzJSKPrs54aKvELmyqKtlkju1d6nLi.cAMbYLr4qiIf
 gk6tIySi.SDQxXgn4tqhbipMkaLJPqa25YShjkuo5zfkLyJqPU7mDtsldKomXH8QnvlH.jaWBW2B
 ucCYv.nw6j8t6f3eW9RwZ9Ybk.mJVmkfEY6ory1z5eJZYXoEN3q7UXR.u5E51yxiXcitlX3UgdvF
 Kjh4YjkB7.I4W963nVDfY1IpYEEeQZ02ALAh3IBAITC1bSrjFQUcMVNJmz_hUWlf03zoypZOaXL0
 w691W8PRgGjjqvrXTkK_G7w_pcdn3B2pLQKLjp4502lnMjggrBEaGYyB43OoxDLtZHHLHSsf_MWT
 n5q5dkOfQNDxp6A71hyGg7ej1b4tT6A7pa2q3_O_FZSLyy.TKPPuFrM8OHAkAAFFTkStR5hHQT_K
 jbuCTt_mkBbCyO_i9NzNKNARGEy37aJa3fUKWmDRaOed8qhlYmrGC2Ryx0ttMFkaGzC3Yi5aHrOp
 CUE_tU8ZOYz1bVT89Nw8WAhvZ4GK4wrLzSw2F9xaNrT8RyU4rdzoz0ScTsUBykap5hNqA54MOIBW
 KAgH7xzuR20Am13hX3hQbH79zfwKhzr9XCnTtpkjBoNbJxuKdziCC3SZJ8P9ah9_Vw_fsfWSSRJn
 jo1KEeW6NkNcdxAFxLSFasuR1DtwBzJUBV7K_Q2tv2RYf08ruSOo1s.5W3EqqPqTWlj5Nt11.Kc3
 29sf_0rlkGZG3NRz3VzHvSTcsDdqIKBGx6r0R8S.mdXr7RCg5ayNYheIBoLB8L2MmL6Ohl247Vxy
 hAySe4bjPI2g1Licb3g2X2mAeHJU1apSp01usvghGunmT7391GVQF8skQ6ri9ZcOVgikijIi_5K6
 IXPclfp.O2LsfRORXCvjm7TdaKUro1jkcE3tPHdKLmy1pL.wygj1upmE0TfjgjN.56_Vrfcz1I5j
 .ZqYd9e4XpmABsU2lgiP71gedWovWzJ4AgkVxl_cMEAJY8uhEcjEL4nGKVU.pKlspJmEBszKEMzb
 L2vtHln1.UiHZUJ5x2bE3FbDlakNaCPIZMEFvzHVF1SLK.v2.uSTpqYztCy3eQmNygbNMW4EMUV6
 wuMEnXQVSH1STAyp5FGf8OFWJZ9T.nTGVi4FI2poH
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 3722bc1a-f06c-4595-9938-da4ba0b926cb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 9 Oct 2024 17:44:16 +0000
Received: by hermes--production-gq1-5d95dc458-6q8w6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7e77129a0d9b2a8b8a48f1f6322a7dc;
          Wed, 09 Oct 2024 17:34:06 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	mic@digikod.net,
	audit@vger.kernel.org
Subject: [PATCH v4 05/13] LSM: Use lsm_prop in security_ipc_getsecid
Date: Wed,  9 Oct 2024 10:32:13 -0700
Message-ID: <20241009173222.12219-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241009173222.12219-1-casey@schaufler-ca.com>
References: <20241009173222.12219-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be more than one LSM that provides IPC data for auditing.
Change security_ipc_getsecid() to fill in a lsm_prop structure instead
of the u32 secid.  Change the name to security_ipc_getlsmprop() to
reflect the change.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: audit@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
---
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      | 22 +++++++++++++++++-----
 kernel/auditsc.c              |  5 ++---
 security/security.c           | 14 +++++++-------
 security/selinux/hooks.c      |  9 ++++++---
 security/smack/smack_lsm.c    | 16 +++++++++-------
 6 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ed6ea0b1ec57..6ef2a345ea03 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -256,8 +256,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmprop, struct kern_ipc_perm *ipcp,
+	 struct lsm_prop *prop)
 LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
 LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
 LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5652baa4ca3c..15aef5f68e77 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -289,6 +289,17 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
 	return kernel_load_data_str[id];
 }
 
+/**
+ * lsmprop_init - initialize a lsm_prop structure
+ * @prop: Pointer to the data to initialize
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmprop_init(struct lsm_prop *prop)
+{
+	memset(prop, 0, sizeof(*prop));
+}
+
 #ifdef CONFIG_SECURITY
 
 /**
@@ -297,7 +308,7 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
  *
  * Returns true if there is a value set, false otherwise
  */
-static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+static inline bool lsmprop_is_set(struct lsm_prop *prop)
 {
 	const struct lsm_prop empty = {};
 
@@ -515,7 +526,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -571,7 +582,7 @@ int security_bdev_setintegrity(struct block_device *bdev,
  *
  * Returns true if there is a value set, false otherwise
  */
-static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+static inline bool lsmprop_is_set(struct lsm_prop *prop)
 {
 	return false;
 }
@@ -1377,9 +1388,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp,
+					   struct lsm_prop *prop)
 {
-	*secid = 0;
+	lsmprop_init(prop);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e89499819817..5019eb32a97f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1397,7 +1397,7 @@ static void show_special(struct audit_context *context, int *call_panic)
 				 from_kuid(&init_user_ns, context->ipc.uid),
 				 from_kgid(&init_user_ns, context->ipc.gid),
 				 context->ipc.mode);
-		if (lsm_prop_is_set(&context->ipc.oprop)) {
+		if (lsmprop_is_set(&context->ipc.oprop)) {
 			char *ctx = NULL;
 			u32 len;
 
@@ -2638,8 +2638,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	/* scaffolding */
-	security_ipc_getsecid(ipcp, &context->ipc.oprop.scaffold.secid);
+	security_ipc_getlsmprop(ipcp, &context->ipc.oprop);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 1842f1325e77..f269421c2d72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3730,17 +3730,17 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 }
 
 /**
- * security_ipc_getsecid() - Get the sysv ipc object's secid
+ * security_ipc_getlsmprop() - Get the sysv ipc object LSM data
  * @ipcp: ipc permission structure
- * @secid: secid pointer
+ * @prop: pointer to lsm information
  *
- * Get the secid associated with the ipc object.  In case of failure, @secid
- * will be set to zero.
+ * Get the lsm information associated with the ipc object.
  */
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+
+void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	lsmprop_init(prop);
+	call_void_hook(ipc_getlsmprop, ipcp, prop);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6e88faf3c6e5..1d43367009ed 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6319,10 +6319,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getlsmprop(struct kern_ipc_perm *ipcp,
+				   struct lsm_prop *prop)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+	prop->selinux.secid = isec->sid;
+	/* scaffolding */
+	prop->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -7215,7 +7218,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmprop, selinux_ipc_getlsmprop),
 
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 66da7cbcc0b7..fed44b4fc73d 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3435,16 +3435,18 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 }
 
 /**
- * smack_ipc_getsecid - Extract smack security id
+ * smack_ipc_getlsmprop - Extract smack security data
  * @ipp: the object permissions
- * @secid: where result will be saved
+ * @prop: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getlsmprop(struct kern_ipc_perm *ipp, struct lsm_prop *prop)
 {
-	struct smack_known **blob = smack_ipc(ipp);
-	struct smack_known *iskp = *blob;
+	struct smack_known **iskpp = smack_ipc(ipp);
+	struct smack_known *iskp = *iskpp;
 
-	*secid = iskp->smk_secid;
+	prop->smack.skp = iskp;
+	/* scaffolding */
+	prop->scaffold.secid = iskp->smk_secid;
 }
 
 /**
@@ -5140,7 +5142,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmprop, smack_ipc_getlsmprop),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
 
-- 
2.46.0

