Received: from sonic308-16.consmr.mail.ne1.yahoo.com (sonic308-16.consmr.mail.ne1.yahoo.com [66.163.187.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F71D1318
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978765; cv=none; b=bu9/EqF08ANN86UIAw0FzK9/9D34xISlrhsjiatUMctB8nUso4CkrT2pSdp8g4a8SSRqnqGBgWlaJn7uGHLKogFV+e2LX5k0rPw9dF0XCTeyZmsT1M5+Qe8IZXMrPjVJ6UTyIk41BOJQzLE0RUv9ne8y2goeh7ZxnUMr1bTWR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978765; c=relaxed/simple;
	bh=WIo7RjfjzCM4PfItxYsF071hSZlJ4WcjUQz1IlE93Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjASjU7DGOorb6ClH2MiTanid1wZLWsrNtIzXliKKENJZkV+C/j/CmS3r+c+RxnnfZR9vpw1emGKO1QJHfsmHGtR2a4DAsXQ4Z8lMfZ5NvS6GTDMNK73TmFN7m71tSxj9rX3ZV5+XFKO0yk6W7rTel6oMBge5HxuN3XG0Rb+pPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LikXcZGg; arc=none smtp.client-ip=66.163.187.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LikXcZGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978763; bh=DLpXQa4JsJkIRpfEAEc+Y9Ht1T3bHoWaYdhrtE7A5pE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LikXcZGgvzyuT9KAhRwaazYvTiplziBIrWRAr4XYjlrjrqqkTCfYYF+AJkVpL6LPB/415+1cepLTtMbcfNZyR6jbcMlAMrKmi+wfajzhDOC2g2SqYpOOhiTgJCpfL/JTv+dobKXTyZFjEW/b2n1zxKoW7tSBqHQOA+/QvDIW2VlJ804GU8Mn7+NnnKwxxGSQGDUcltFX4QO6TFEkynRo7IFMub5ORYSs/AcN3I0BbXQkm9pj/8mgE49U9skW8SRuzvnDd2LvEPT+Pqc6TT0i8fxhzQClsh88s4QSeS4hJhRqXjdj4NQAhhg2AiVXH9e27+G5tF9ZvgW6AhvOFaD2vg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978763; bh=utMQU1FCZ7lCCKV0ZUWbvYqFPyOy4UVkfy8av3CgUSh=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=h6y0KDrSIFJjzopNvNSVsbn7kuIDX31ZF2mJMvsmKV0DnnOJuwEbUzJ4ZOw2R5m8Prw4dlQW7isxoIotmru5qdXV4eR68OkY5oRVv4Q+tF2MUUq7N3aIT06xRJViZZ+uZTfk/QdWdAKimXyYCmppUqC5OthHuEEXS6jd7ueJv/BkzAJU0de4tIjoxVqZ1oNWBbhRLUMhYdYUk601/pjI0QNWnRens4j2ZqsfXNrIXv4Es97FfnVQ34sd1gH232V7oquc5n9LGaWV1KUdGTXmYDorDRJ4NBrlNxyQpCk2ObD8VhJO0gZbWwtAiH+lWFSisLFt5vjoIxDNKhONQsZb8A==
X-YMail-OSG: eMiopRkVM1laUH7VVDiEDoU2jqapbZfnNKduWhzBETG0YwJzQ9zW59VABv7l.9p
 gdYMnReLgGjaLNhH1bGRvyDu1ceeh_zMCXY67bMxzGVJ4_qMPIWA7.R8BPbmrR0Kvwduyb1bUAws
 UqhpVxDDtUTnx2AWJ0Is_uUSNaypRWcnPmR_.xnWXnTQ1pd_4xpWVLLLA95dxnkAEndegs9DoTBA
 .RubWGDNfgCUW9Y_qHw9SjTeZDDZBgf96ASMS7ovn_P5bQdnTYwLlu_hR1y2zNiSMsylBzEqyq2.
 amNXfiMTIBAOEwqpU9GDhY96HVLf6WXuvjFq4Fl52R3ABhuguQ07qxlzB4hhI9RrZjipgOJ8UZdL
 1TjvclCV4KbC9MW5g3Flbtnyu_ZIxJ6KO3IfJFof5TCDTn.YeYOtyFygYxnjggiZ8oFgMnk7jrOo
 YDZdz2v7G6xAJ.dmzWbFu5mKII3pjyXL_C2dYpwBj8T5U2e.3qQ.cyka2xyA_IJxpDXEDHz.HV7l
 ZHoO0sRJH_avG.GHR3z_JrCz1nKm5unQaw7PsDvqkeWkTW8VB2Un7r6e2.ZMnyVGZg8agTc.x48Z
 mnWbupoh3j_AckEmO725sRQE8rnMAeT.03c1cmxH_py_CvhHHFQSFyIXtpqxLM55EH8NgxvMy_UB
 PrhdOF9SBddqTCixhpEc4yZdxNBucXEQMy7.y2XvkkMLEflXWKBaSwzAlKCFVuSJtOw9DUb7YaFq
 .J8Nh_034PiMuP.l3hZmRRFW9YuHW.hv3ieJCHdiBts4GdQoGJF9ebP.d8.485LoYK7MonE6wC_S
 ZcYoe1sRQB.P_gmUVXAR3TGV7RkRTUllZLLGtDUJ3dw.UtJiII1j14khGxve73cl_obIWDO8s9Qq
 k3nDv_btKa8idmiOucEegvkpsXn0qeajzx826uxUjexjWml9per7anGwxHAzKVQRCbMT_LV5HAzc
 kv9d85ybs4K_IwvGlgsZOaaWycxAovue5tMBFWvFnE5Ce2UMTer6FDXSfZ7d.0_myTTd6kteiWDl
 h5IGAGvG_xvFxKON37Gxj0_mP2oRPvOyVz9OVsNtA8FGT2pVq2R3tdK39RNNAkvKtVcbFEm9aeaA
 apY71L.u87xNDI07vyzNWRD25IHlPLCjweo0xSbpatyMgApC_Odq_veDYH7GluJsRiVROAhntfTe
 r9Oijf.e7qDb4jyNcuHvddqkc3BNkWa5E2a1vBkKjYwJ67qbSsoHlnnbHiL9QDcYok4zsqc53qdN
 xA3Y85ukjqkh5cfTVQd3OdC2UgnAnQ06Bv.K6YwjY0Uo.1dNsUIqcXIC.4V8xMisNerg0rrRPaDY
 Tys95H_P1._IfqujNF1z4nLPcU05oT5wCeh3WtLAYXlC1YxLfwX6l5fkQTR.T9S09yRJwyf6Rm8j
 0LeecgR6vej4WsvuhD41sPCPh0q2qp6IWKIwrZ7omTaKVa32BBtVXH5e8SoqOOTf84bg0FZvDbFL
 8coFrB29Lth71rEgL_lqReY_lnhjuaZkNTKFH_VkOXIm6T3v1fmybVzQY7aqbrvR6hN92KZs68Wu
 xw34jGEpMqrBONs6XpnK2zyFcPsSx1buOzSR7odajbkV.3xx3EZ8ZmkeJGbXbPbHVpg1nqlFU9Ci
 6W72TUCPR1m1F1GCOW9M.NYlnX96HvwfryKIrJtyxqmK7ZrH2897JdVyHVqQRFQ2VQZ3ALJoAiY0
 HXUIn3KxbajB_xHUNzfnyAw9PWroP9FtiNngH2nhMggiBW_Bz89l5NKjeINLTuJzfCDZR__hwIJm
 tetXDq.F4mb0IkyLV73im7xL_d3UM4J3ampD6SbXr08LygKzU5eJuIztxwPqIAbHicGyPvI6oTZU
 rLHvBaDk9sqi9uuNM6Tm7TYCzXVAff1p1_WxHuzFnnDwrkJpbOA1gaVqrraYvLHOyBg6qOmy_5Zf
 B7ZmO21BgtsV.t4h722hDBUWVlCUivaXiBtGKrwb59Z8l7a_2ppCEEOvj4RKSqOuhMWZrpgrPdwn
 8JaVdxVwypsVI.q27.4oSlvSm34kvubC0puM_C5VHtqgNCI2pt__IDES7chlV03H2UO5k9eCfQPp
 HGnV4TDEUGiQovGxNYl_RwepUGzzGz30GOWW0PerAEggU35qXH85ggjA_plw12eDmmqGY4bdLmVK
 Vu2B6sxf4sHoi.dvL3OT20Uf5eIoUnIbouL99m3NoaB0MqW2CqJN3OQlraYq8EKHivOEdQKmok0B
 RYN.cqoCkBZuBrXPD3E75z52k1H_UEB86Q14vPINwm9_PPBjvA9FR8Rly1Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4afc0cf6-54f5-461d-aff2-58a225cbb2d5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:46:03 +0000
Received: by hermes--production-gq1-5d95dc458-24x88 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dffbd785ee8ecfc4db9f25ae20a43d90;
          Fri, 30 Aug 2024 00:35:53 +0000 (UTC)
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
Subject: [PATCH v2 05/13] LSM: Use lsmblob in security_ipc_getsecid
Date: Thu, 29 Aug 2024 17:34:03 -0700
Message-ID: <20240830003411.16818-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830003411.16818-1-casey@schaufler-ca.com>
References: <20240830003411.16818-1-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be more than one LSM that provides IPC data for auditing.
Change security_ipc_getsecid() to fill in a lsmblob structure instead
of the u32 secid.  Change the name to security_ipc_getlsmblob() to
reflect the change.  The audit data structure containing the secid
will be updated later, so there is a bit of scaffolding here.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: audit@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: selinux@vger.kernel.org
---
 include/linux/lsm_hook_defs.h |  4 ++--
 include/linux/security.h      | 18 +++++++++++++++---
 kernel/auditsc.c              |  3 +--
 security/security.c           | 14 +++++++-------
 security/selinux/hooks.c      |  9 ++++++---
 security/smack/smack_lsm.c    | 17 ++++++++++-------
 6 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 3e5f6baa7b9f..c3ffc3f98343 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -253,8 +253,8 @@ LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
 LSM_HOOK(int, 0, userns_create, const struct cred *cred)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
-LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
-	 u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, ipc_getlsmblob, struct kern_ipc_perm *ipcp,
+	 struct lsmblob *blob)
 LSM_HOOK(int, 0, msg_msg_alloc_security, struct msg_msg *msg)
 LSM_HOOK(void, LSM_RET_VOID, msg_msg_free_security, struct msg_msg *msg)
 LSM_HOOK(int, 0, msg_queue_alloc_security, struct kern_ipc_perm *perm)
diff --git a/include/linux/security.h b/include/linux/security.h
index a0b23b6e8734..ebe8edaae953 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -290,6 +290,17 @@ static inline bool lsmblob_is_set(struct lsmblob *blob)
 	return !!memcmp(blob, &empty, sizeof(*blob));
 }
 
+/**
+ * lsmblob_init - initialize a lsmblob structure
+ * @blob: Pointer to the data to initialize
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob)
+{
+	memset(blob, 0, sizeof(*blob));
+}
+
 #ifdef CONFIG_SECURITY
 
 int call_blocking_lsm_notifier(enum lsm_event event, void *data);
@@ -500,7 +511,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_create_user_ns(const struct cred *cred);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1340,9 +1351,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 84f6e9356b8f..94b7ef89da2e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2638,8 +2638,7 @@ void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	/* scaffolding */
-	security_ipc_getsecid(ipcp, &context->ipc.oblob.scaffold.secid);
+	security_ipc_getlsmblob(ipcp, &context->ipc.oblob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index bb541a3be410..6e72e678b5b4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3611,17 +3611,17 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 }
 
 /**
- * security_ipc_getsecid() - Get the sysv ipc object's secid
+ * security_ipc_getlsmblob() - Get the sysv ipc object LSM data
  * @ipcp: ipc permission structure
- * @secid: secid pointer
+ * @blob: pointer to lsm information
  *
- * Get the secid associated with the ipc object.  In case of failure, @secid
- * will be set to zero.
+ * Get the lsm information associated with the ipc object.
  */
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+
+void security_ipc_getlsmblob(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	lsmblob_init(blob);
+	call_void_hook(ipc_getlsmblob, ipcp, blob);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 102489e6d579..1b34b86426e8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6328,10 +6328,13 @@ static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return ipc_has_perm(ipcp, av);
 }
 
-static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static void selinux_ipc_getlsmblob(struct kern_ipc_perm *ipcp,
+				   struct lsmblob *blob)
 {
 	struct ipc_security_struct *isec = selinux_ipc(ipcp);
-	*secid = isec->sid;
+	blob->selinux.secid = isec->sid;
+	/* scaffolding */
+	blob->scaffold.secid = isec->sid;
 }
 
 static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
@@ -7252,7 +7255,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(userns_create, selinux_userns_create),
 
 	LSM_HOOK_INIT(ipc_permission, selinux_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, selinux_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, selinux_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_queue_associate, selinux_msg_queue_associate),
 	LSM_HOOK_INIT(msg_queue_msgctl, selinux_msg_queue_msgctl),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5d74d8590862..370ca7fb1843 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3442,16 +3442,19 @@ static int smack_ipc_permission(struct kern_ipc_perm *ipp, short flag)
 }
 
 /**
- * smack_ipc_getsecid - Extract smack security id
+ * smack_ipc_getlsmblob - Extract smack security data
  * @ipp: the object permissions
- * @secid: where result will be saved
+ * @blob: where result will be saved
  */
-static void smack_ipc_getsecid(struct kern_ipc_perm *ipp, u32 *secid)
+static void smack_ipc_getlsmblob(struct kern_ipc_perm *ipp,
+				 struct lsmblob *blob)
 {
-	struct smack_known **blob = smack_ipc(ipp);
-	struct smack_known *iskp = *blob;
+	struct smack_known **iskpp = smack_ipc(ipp);
+	struct smack_known *iskp = *iskpp;
 
-	*secid = iskp->smk_secid;
+	blob->smack.skp = iskp;
+	/* scaffolding */
+	blob->scaffold.secid = iskp->smk_secid;
 }
 
 /**
@@ -5157,7 +5160,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(task_to_inode, smack_task_to_inode),
 
 	LSM_HOOK_INIT(ipc_permission, smack_ipc_permission),
-	LSM_HOOK_INIT(ipc_getsecid, smack_ipc_getsecid),
+	LSM_HOOK_INIT(ipc_getlsmblob, smack_ipc_getlsmblob),
 
 	LSM_HOOK_INIT(msg_msg_alloc_security, smack_msg_msg_alloc_security),
 
-- 
2.46.0

