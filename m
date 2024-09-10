Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087C1A704A
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994406; cv=none; b=Iihdko+3YryuZX1M/WRHTFGbKFPA8xK/6tJ7tgSE61/YLWMhjBtRvTz4fNEkXOYdDi3/RXfd0+BXuL4hGv0o7t2muojdgSx5w0k966GP8XyRYLqWhYMHRwsHEc5sEx+pcPe2pCPxCAZY/iNuyvkDsHlsxIwqzgaQskNsiO1G+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994406; c=relaxed/simple;
	bh=IoX9nQjI2oP0imTJJZDHPStaBUxY820d4vgsxZmjUYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCcIumGipV0Kizvq8PfpUUR/eu64szIkYX/D3M8nQqb42cbXWi6kHSIuEx6/Vpzk0H89s1aEYoDSZMWMNwo65jHAVkA6Xq9r6mhDyO9ewKNP0cT05JbdF48gTlmJ+I7vfTsd6VUOuEWz2UgNrIRJBv0YX4rcWwTwLhS0YZGucrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r+OUhHZX; arc=none smtp.client-ip=66.163.185.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r+OUhHZX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994403; bh=snRkCW1CoQhwTkFHaGmHmPb0/0EzthT9FmZrwfJIwtA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=r+OUhHZX/WxM123FVmw/ZHYYNymeAiyA0IRkAlCfcnFJjHi3rAUZ0R324nRJRsX129Mxqzh0GGzdwMHqVp8wLpLbHqd0pOGdONR285maaRWUyImaTavtW+CwprulNF2z5Cz/MegevHLpu93g+F03OF8eMhaayUJIkOsBMUaJm5IMht+eA9NTn69Zfdo85JpErLP0mjhMU9ydxBC++WOZu4jk7c2DGe2xn9Yt+a/j791ROBFb7fG21JofIcoprZhMi86m/GmiobUtHf/GA10F8L0IQ2obFCHKQOtQbMgHLRj3JPHBmb5iAZt5rO0a78s5A9PzaKT9pLYN8myZJCtF3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725994403; bh=DzOmSwcWsnXN1JVa+2mnK7gggO08PT5Ldif5bSDappE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=et4hvcITz8CAb8yCX0xB19ojFJi+4jJaXUGqXEdt/saaIJCH3KDoIMoM3BirtJaQK8GUy56jMInUQUWHg7ajbRBDo4iupEWsoiPWQ8czCXgWMaOjMq/E+uAWl/5vvZqNqsCEsV5jqYdvN62M2AZfcUaGLqH75LHegkNyd2qotRad3Y58lagcubq2Da3bmnSTa0wxo6qv5lH/ItoMv5PVRbpykTqrXXHD1CPxrg5fhiT6an4M95JNxuhrgYIPY/Oq+OkiNUOI+e5XANRmLkeFdpx943GiaI6M8PnCbopDwzZKSTFi3PREY9XaxUAYvf/SXEelrHg1dswuTAKPo/3VVQ==
X-YMail-OSG: DWhATRMVM1newNlpUoJ0rvExXh0dXCALrF8_47tYcXZh0O22LarfIyporiWjKZq
 .P6J6WqLusmVB8kqPHBHoYzUN.gyl.IY4LJIMEnMi9xfy_HycMJTmEdY6jGDGpMK91cdtuJFqrOg
 .e2RxFgbip2LaZxQYN3vX22YqGd_qqBg7Y3Am3xo.MrFEHiC9EifgfCRrKhIKaVpwZ3C4H2isnE4
 xaJFmchs91.epl0eLiWgGmV0v5fVNeZdTFUSTqCcGakkhDpXeOSEb5U7bsN9kxxQD.rpYKMDacY7
 6RSk_rb457fqj1.1O9ho.Z_Sx1DZTo9XpZnngeS97_._5wmEVvks4N5x5OtmSwfLOjCXeAVk06rw
 Q9EpRguli_YpFbmiMsEaTC0jwVs.LIvPBpSoHCZNX8W9D1PfRUqfcHwa5ip9Al2ud0cvX..v3U4X
 2dBwcITtMHVu05Nq0Oofw6A8AA5v6sFwsCyfUf6NLlUIrDXw0aFv3SscZxGvLuhekGbvnGfozOnR
 fd2YW3webPo07WTzZfK3Sv9f6bOtdEgBEnoilMxy4cQUVXejVY4UA1889Aoe51CGVUjm9hotj92W
 5l3VOlMMXXc1QUn0kSVqHYGMG.7QJeivGKVBdi7CjQ2HPvsu9fRQLCCPkIbL2Cy8Yld4SK50bPpO
 4syF29ccgIJlfu.FMI48CL8KkZPuzlBxHJwbYbnrTK84lcma56Rg1437fMVCwjjnJOisLDUGehK3
 HcFoIm1x.ZkNnkFE84WzYwf9u5GsVyeiq0N9yygW7Vkof0K2FgHnJrNRYbxLCoG9uveYQvr.g4J_
 NE_OCe_wGKtNUf8tAc5rl379yvYBrvWZbzlE3HIXN79DMzv_2JgCN6KlftENlpyQa05r9VJh8qm5
 F2ATOzqGecpIjOWfTevTm.FNcsh.aYuHWmMsiJ4UOiYztLf12UMu0LacZP1Mq5LnUcbLJCvtyABh
 wYr2wvAlauuQJubLIuGZUykFg0_kPQiIL9wub5hPZjhgxmcpR1hCgJe0yQuZj3O.tAATf9W922FR
 eIp.HmSr78JvgNWODJksVC91a24Ui0CKDFNCGTP2G5QMqCOe4Kgj9C0tJSjnCD6oYBRO7X7NFvL3
 oDpBVVABomtydpLUT90jMHnl6LtvSau_U7Bx11pQ_zFcUfc6ReSIxy6KRIa_sPUOdNZ.n4NQptaU
 AmEEoZ4Y.95EW8KSwRpDtLZ4YKPo5FDzI0tJGtNTqorZLE2oSq8W8wgYLCvRurW09eA_p4ypilUR
 JAia2t1SwgL9SumsMaBInZfapqE7L9IU9sfhNAb9NYs5Q6y2vhBANZOqVoflJHirvpkmx3Qb3DCB
 9AhPMlO5OpCtjMku8ZIOJFb1wBw5K.r.NT06UNNjOuDeYEeimTrimUkJSjWAp7G0HlcFKyVTIrxY
 TjgPBa50w0d4dUolu7bZzIxfSBoDXmdal5HJEW_URfLXTXLddAg8cJdVlSj9ergBaYvFReCdP_Of
 YKj5T7K.gnK05iQdJA2uZ2sR_lKU3I9dYplmkLf.CHgy3PZUs6gFCD0rd6MPaboXlhnjgL73fUOe
 cUGb5XRs3qsav9Duk7Z6ctNEl9GKLHO6QXGokh1xJH4whdTZzaurkP8rW_f19dvT9jrJh581IGdB
 XmmGmdw9LTG1Z.ysSflhuSMAi9ibWRpJc2UX_9ZMtGw5sXYXaWrHcE0oVSzfGqXXYwWHmAempst6
 bP9n3I20LyN1RHUFqH751J8cPzT4nr8ARSh3DMy71jmsTmmfi6DCHHLVWLbb_Dn7FWnJ4kwt.._F
 0ZXUz6Kz6eB2RMED1YFe.DWbqU2fPArh37hkIY0VyJhAvUumY7MNQt8GqWCIjexayx9ddA.lJ0mG
 .TDuhucTPCx7CghYs5rU3ITGx_2hH5KpIms5aPEijaIO64rwWF0A8EE5WCSG1WYIVRxTl6IePq.9
 lGEJBNbumX6kFYVK.0wQvrtm9AkadhhyezbxYijXLySxI8rjoWc9Z15wqJ.BXntBSGbqc3R8Hr8u
 X1ctgvuD2.IxHzLAtVH2rCm8fr_2tgaqagNZPNxL08ZbErdj.rQrBuv9mSKcjOc_Nnj3aHdmotNM
 TTHuXhlBtoePVxdp_Tobz0t.F1_ziYINvid0Bz5sXPEg0KVu9KoML_QAEyyBCD8_zZt0_xIsIzcd
 BlcdP9U5KZmlQMMdf_jlHnsk3dDRyvp0Ok9JYmMftJzZsE1N8nYb1Lx5RmmBLpbmVoS4XsfW69Lq
 yBNr0nOxaf8X9HA8gnk7hgSbxtb2ixEzLOJHW0WrbS7nA5MsX8jKYSAxqAE77MHAaSwRzM7TISP9
 hVUlf5_UIuNopGkl3vHB61Bw_VTmHveOymXcuL1Q-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 5dba500b-dbef-4d20-9d04-e54cd028f336
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Sep 2024 18:53:23 +0000
Received: by hermes--production-gq1-5d95dc458-4tw7n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bfec55394db9c3ecf7e1196118de0a4c;
          Tue, 10 Sep 2024 18:43:10 +0000 (UTC)
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
Subject: [PATCH v3 05/13] LSM: Use lsm_prop in security_ipc_getsecid
Date: Tue, 10 Sep 2024 11:41:17 -0700
Message-ID: <20240910184125.224651-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910184125.224651-1-casey@schaufler-ca.com>
References: <20240910184125.224651-1-casey@schaufler-ca.com>
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
index f53323e52fe1..315bbe1f63fc 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
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
index d739a4cf43d3..c8f020cf2a84 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -277,6 +277,17 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
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
@@ -285,7 +296,7 @@ static inline const char *kernel_load_data_id_str(enum kernel_load_data_id id)
  *
  * Returns true if there is a value set, false otherwise
  */
-static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+static inline bool lsmprop_is_set(struct lsm_prop *prop)
 {
 	const struct lsm_prop empty = {};
 
@@ -500,7 +511,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getlsmprop(struct kern_ipc_perm *ipcp, struct lsm_prop *prop);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -551,7 +562,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, u32 *uctx_len,
  *
  * Returns true if there is a value set, false otherwise
  */
-static inline bool lsm_prop_is_set(struct lsm_prop *prop)
+static inline bool lsmprop_is_set(struct lsm_prop *prop)
 {
 	return false;
 }
@@ -1350,9 +1361,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
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
index 014d23370384..3e051014484c 100644
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
index 859b37e51796..410bf69af427 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3611,17 +3611,17 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
index a2da81d0d5f5..10c7fc61a786 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6328,10 +6328,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
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
@@ -7252,7 +7255,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmprop, selinux_ipc_getlsmprop),
 
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1f478bb08779..7926f40bc7db 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3442,16 +3442,18 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
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
@@ -5157,7 +5159,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmprop, smack_ipc_getlsmprop),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
 
-- 
2.46.0

