Received: from sonic305-28.consmr.mail.ne1.yahoo.com (sonic305-28.consmr.mail.ne1.yahoo.com [66.163.185.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BE125D5
	for <selinux@vger.kernel.org>; Fri, 30 Aug 2024 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978961; cv=none; b=QK7omfNiv3VVb5y5Q1cVqCMQii+Nr2WXH9UIHIWyqcacyplOf0gxfHkIYECcFcIvymXaQMB190g359SYXDRnUCozYJkCMUFobxo+QrKuF6RBs5cdqHHBTe9hqZn6ufgPxN67y4G2StxT87EIJMCNXwHZ4CJkISAcEOD4mXC1hQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978961; c=relaxed/simple;
	bh=WOgb0l3+mNTEJgc9hmsiRiCiiWeY0qj2It6RPDfGCMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDEECcsVJ9TMt88OGiW0hNiTWrJ/J4T+W9LPAxqHbtUyajWSdDXlkdxufXyqtkp0gOC82wrMeYg+7Z4cPTy8axlAYmlIwWeuPdc+mMxtxR9b3lx/hcpkmHK5ItfjBzZRjj6WIYUEIvZ0pXCIOa/j2eOwrHrd2qmWj8SNtXik91k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=EOZ3/oJM; arc=none smtp.client-ip=66.163.185.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EOZ3/oJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978959; bh=2r/dWdCbRvU4etEW6v9mydXKfVO+AeWq12qn+jOgxk4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=EOZ3/oJMq57vaSx0BpugqKY9Oa0huNqQa3yyBjnl/qroQz+mnz3A4izfF//n6gZUL8rHHmjY8YuJjFiuJqiz87p56bRkzxxwoYqkEi8N9p8hIlor3ovujLr5N+YsVvtrfJdwl+mhmJTb5h2jF1uBYx1EgH7pw/+kwgv58gP4cgZ84sFFRxgf3+EaFzvBndwoLO3E8s9L5fLJBOLmlx47qXLP9oG2/AbQyOBl7L/VF5i+3k914LxKM4Yaz2YZ9g/BM0Y/GTmjuGyFyPkxO7e79FEjjJr5xP1j3qQF7yi2MNwPktPVvyzkItKs+fZCHENFb1FiWSU4ByQpzU4uf/Ndvw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724978959; bh=j/VUtp0Ju4ukMxtyszAwCBgMuPuRB2Gqo0Ma2SlWB+u=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=WbLyssRm7PAemZdsrBPIUWkjhUgzACLKGs/1XvU5hqv5Pp0ruC7Iw2nFEdFR9BfdyrjCQk/uBJ5pVP4UzyP5UTprEXpg/+o/cON3REz+EZsDLIthoHUogQvy7YqWqW8gUtQs6OHutNnhqxqW1lBd+SnI+UFaR9oLPal8hFFVz3Ii6hPh0aD4SWgmR3chKWqGuBJ1Zv1Zsq30g81MKM9qCp6VKpqc1ji/xe8tvT16UenkLyBYQOMhYSYODJya/olNxqbliw6c221aX6RiTcwzx0u/gDu+b7QKlPDaCovNfui+Wgmz48XIsQsMLDBhOr6Z2S3RFNUm1OLHySEKTEseMg==
X-YMail-OSG: sbHVq2EVM1kj_I5b8rvftmXOnBJ_IPiiE.gCBDeRXeJTE8L4RRRpNcmHUdUeCpR
 wftLbSWU6J_6AxGcq4rSebQS8C5q069CR.cC_HUiLA5OM_9jNj5yIoLwfWOM8IfRtnPbj1kBrltA
 UyARgnXcpu5arEAOTm84BLxFKUA3OoFsPtnGetIH2EwcjDXLRZy3NRzgWVtIP9ZVlaWsHbzb1MAl
 2KN5q393M1lK2ov_7Xo.3j9TJOBdcoGz5vMHg3wspSI9cJoL5_8FkAl4_F3O5r.hygvSzHh5Qh8s
 FTuatcgIBJWw8VNHr3voZO262l1Bz7pZyEPD_Oq_0z9HU0Pyo1regh8FhmCuJyjZimzc0Pk2yplv
 zVbnln1j4if7PKQGSgxCQQErD_UAtEiADNZ.rlR4vrbmqKwNpau1HaM4ynY77KMiCtxyESIIZFZe
 LkzYI_nhybFC5qRoGa4pZmr3ZwWgheo0xENl0uSNM7WcmJJJFS84nC86YUxVhiynyKZ0jmcQYC5Z
 RYMdFqPDJX9XFhoRJzkQ6qpDASkpg8_Qg7Bwg6R3saHcPl0mnuHODMds1v_iuFk9pF5Lkbj0aPWn
 kLCTv9BBCYPBVidp_REZ7L6qE2chUEAH5HHJxDMiM0iXSI5XmuBlIfMvsCdpPN_2ZpqbZ2LETNzU
 Ixm3510bEigf9Duu3gZHJBtKnIpZDAoavPQmccgnexPb8oT6ibquPww.8U5rzv8_g8Smpu7eKFOp
 ywCzpilPZLcm7Km_mWaqnjCG_R.y1fWjff7xl782FlLka5.iUSpO0aaZs1j6xjXGFfUZWvX20DRt
 AXjsiVXs7Ev_xM14.V.8VxbwmNbH2jWpiTPH_TEI73qcU.Dl8blixt98wfkbDcFn9_bRysl5up4Y
 PHWu1Eyo2Kl3x1uOkmQdoPIBsO2Y7MUB8adKntATuO_3xKJV156LLCLyybfiqxd283BIrw0SZWYw
 2wLkrr08y1nm_aGz8fO89xWYa2OjXwztFMS814fKUz1Gvz1wom0_hBom7JGYgVjLiSmyegPiNHeA
 wHmkbrw56_u9GwbzOznl8fout4RxETYyHgXQ6o18hQBN4EqBgSI9Ha08EhybK3UNh7DPRuCOB2Pj
 NcBCVNlF5XbTXtdoRDhdWNtur6nvjZRpQ3Z4uG9m3JWN7s7SudDRcXTIed3Kvv7Jkj6qEpdIoNU4
 kAhr7JNh6kqjG9NN5kVFNW1ZrUnWwYzMWowYqwlKbkCBbkpKOmaEadLRzqix9w2h9bv5g7YULu2.
 9v18fumsidoUhXM56buA_JIj2VRw1SGYD810hAGNnkkkWtFECyRfHOSxQegRiu7cEc92Shp6tkfA
 QLPZQlJPNFgABxTZLoq9L_npZAB6wP_Yf0hwCRz2.5R1lg12QmD7J4aUnTjHLDicTLlvE2GYZckr
 eEZWMnoyEWnp.QCUMnHQJFfdtD16WqKxcLf87VHMLPHS4_KNRHhomwxOGS1VuRY8LXipFqoTQ__A
 hn3KbP5V_abYw96gF.vkvZfX9DxriIw.Vc0tZncLMlJ48i1TpD2K._dg1yNzuI046FfiK4hlrTsK
 rKdQKNu8k9Zde85OEhlxWj.hxlJvuSKSwWUM4cP6F1G4rFbCEyL2Y4U8i3OAXiGnzt0yPygDdmIk
 TCGCjF2neQh12IkLj767Z59Gnw_zNBF._oMgDsYJpW9MfcOIhwkqLCrC17Svg0AbuU5YA90.GgL2
 Kq_QDCH.34Zy7ZPqTbSLr_7yvnufCTIbZYZlTsGMWnbxTnLA611t29dei3j_j749u1J15otj5zpL
 ULxaXDL0ZxokEzCO6HUr0F.muKnWXMsi7Im_DZjx5poyjyxuPvfbf6UDdoTzyic52LfEp0xQW1db
 LKwxXx39nwjBCrwZK0jJQjp4HddVGpzfS_S1hOE28r312XpN_dwQtTJotPxTwVRhePXFl4vrcHhB
 8RmqOdV.3rdZmojwmPiu.eAaaUc.LrY.o20R.tBTQjjGsjtJrY464mUDhxi1R36v5OCkA9TPlUX.
 AzxT3MUeDKvWdfg.rk6w88fneRxfm2mG.dOt.udgCIt0XI0xAZLP7AfRuovPimuw1YVKpJTDzwb0
 QM9RdOtU.pJYYPn92zAF7C9W5uBdk8jOhgvuMZJak39J_r0r4oPUz8zksA7y9YdhCqsjqjRHW1AF
 8uAc8t9xrNr1rqJYzn8mRGFCiJHk.qRmrp3uTlp_zxUud_kYHd0Kv9H52aDmbfHklzenNQM_CgSP
 0m0VZJL4_cZ.MsoYyBVvYkbtDTdUxdFSigucNQOkr2sQv2vJPdoTzxrMf5eigNskO6KYLz6Jy3z0
 kfJS9SK6U3N7MSiz868zIinuq71rQKVHkMs5K70V97wE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 967549dc-f23a-49d0-b828-58a830707dfd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 30 Aug 2024 00:49:19 +0000
Received: by hermes--production-gq1-5d95dc458-jflr5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 35a934a1749a25fd4473b6654327c16f;
          Fri, 30 Aug 2024 00:39:07 +0000 (UTC)
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
	mic@digikod.net
Subject: [PATCH v2 11/13] Audit: Change context data from secid to lsmblob
Date: Thu, 29 Aug 2024 17:34:09 -0700
Message-ID: <20240830003411.16818-12-casey@schaufler-ca.com>
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

Change the LSM data stored in the audit transactions from a secid
to an LSM blob. This is done in struct audit_context and struct
audit_aux_data_pids. Several cases of scaffolding can be removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h       |  2 +-
 kernel/auditfilter.c |  1 -
 kernel/auditsc.c     | 31 ++++++++++++-------------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 6c664aed8f89..b413c0420c6f 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -144,7 +144,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsmblob	    target_blob;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 06309227a0eb..b3562e6ca081 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1370,7 +1370,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					/* scaffolding */
 					security_current_getlsmblob_subj(&blob);
 					result = security_audit_rule_match(
 						   &blob, f->type, f->op,
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 886564532bbe..bfe2ee3ccbe6 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -100,7 +100,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsmblob		target_blob[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -1019,7 +1019,7 @@ static void audit_reset_context(struct audit_context *ctx)
 	ctx->target_pid = 0;
 	ctx->target_auid = ctx->target_uid = KUIDT_INIT(0);
 	ctx->target_sessionid = 0;
-	ctx->target_sid = 0;
+	lsmblob_init(&ctx->target_blob);
 	ctx->target_comm[0] = '\0';
 	unroll_tree_refs(ctx, NULL, 0);
 	WARN_ON(!list_empty(&ctx->killed_trees));
@@ -1093,8 +1093,9 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid, struct lsmblob *blob,
+				 char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
@@ -1108,8 +1109,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		if (security_secid_to_secctx(sid, &ctx, &len)) {
+	if (lsmblob_is_set(blob)) {
+		if (security_lsmblob_to_secctx(blob, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1778,7 +1779,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_blob[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1787,7 +1788,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_blob, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -2722,15 +2723,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* scaffolding */
-	context->target_sid = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &context->target_blob);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2746,7 +2744,6 @@ int audit_signal_info_syscall(struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t t_uid = task_uid(t);
-	struct lsmblob blob;
 
 	if (!audit_signals || audit_dummy_context())
 		return 0;
@@ -2758,9 +2755,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getlsmblob_obj(t, &blob);
-		/* scaffolding */
-		ctx->target_sid = blob.scaffold.secid;
+		security_task_getlsmblob_obj(t, &ctx->target_blob);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2781,9 +2776,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getlsmblob_obj(t, &blob);
-	/* scaffolding */
-	axp->target_sid[axp->pid_count] = blob.scaffold.secid;
+	security_task_getlsmblob_obj(t, &axp->target_blob[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.46.0

