Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17ABC388F7
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505712075E
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 23:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XzO+qDxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgKDXuZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:50:25 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:40796
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733080AbgKDXuY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 18:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533822; bh=U5bKWCQ1u99Nru5o24TB+6IKzAJnsO7yXV4aGiXz6j8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XzO+qDxnTgpXNz7m3xq/4gWgOUERuzPqUxB7erjRKnqrmkFYCvciDQdx+C8oqXW+qxRHJSSJwnKymMb9cO/YrKcq2uz5ISDtQ1q3yLtK/HHBdb7o35es5ETZO97m7LWmqHAFK4cEVNL72u/L76RVm1qJm5QEh1d7hXbuyiRrWcr7UH+3UuFJwk5rqNoEgkufcJKj/J+6JRpdFx3JFJDl8RryuRlgq6nWcHCU9n13ZGJx4dOVHY5a/Hjb05THsHj7c6Pi9a8MYO+jeqSMk26EM3DpVHKz2Vs9tKOdlHFsVa5cHIr9YsS6hLRm6fxxRCSeRgx/wY6HSeerVZeKeB0duA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1604533822; bh=3UhOoslsnfsqfF6hR+s/qCpCPR7QK4U9VBKdUY4f2qv=; h=From:To:Subject:Date; b=kFfrqG4bpt5IsFAsj1/k2BlArDPYiM8wZfzhHA0JJLNs3Dy35gpQD9V7owZIpXtktKt4suyjqYGy+PONgfULfDkCFwB/ls1dfbt3mLLGRAy3qh4melpZp+gKzS3lm9Y1/JPMsGXigVgPAJ1xb96TY+MZYwB7L4FTexzF0aIr9i+5WsI26LjYQsEY4cK5hkE67mdAy0hFao4TJAhywxdwf4hIjOK6cDdgsv/Fal0CHAYDC1FxWi70PsuW1P4lz+gRvDyuqDKgnDFUgisavP0KP/avkGwT5CNnugEaOdVIyUvx5T+w379w0j1TdFe6v4v92gPNUoDJXxdCsjDxiWnkqA==
X-YMail-OSG: 09UsMW0VM1kibSLgQpEZrCsrxHqYLRql4MrK3TFzDpxf8VErzeFOWcAtMqEv0u5
 N5k2N4sBhOqwFnv2322wlJZ_3BZrOe4oek3zesp2kIil.EaTA7ZqFxz3ZRuut43bHLUjW.4Skulc
 Fig4dcQRhW3TAav5H_rPVt7XQFot3GUR2.3hJGPHJv85.Gbg2Y3HaeYdPcSToMgsCsnNDFQyMjuZ
 DJ.OGC29zMfE5xGLyCHDifXmICjpgFfqlhNQHG6Zii1.HUS3gTQL76LNw6xA0JdVSy8owiIJrgnb
 pgdD5iS6RJqVq2p2HHfiJSNoMpzTpASZJTGWI7vA4UY8lVnQTt5Syekel3nctYQ1NZWb.VFYcJre
 vK9G245LH5DemRBicpyjD87he.bnfdb167iaLjNJD1zAldibVatUPxRCZXpYiGaxKzGC.vglkIG6
 xFQnDKw1_vjEFp9jAfBOq5xFOG3c5dCtslJC6g4z.prsmZUiEeVJy6Mp2qCcrjmC0zea0T_SlTvi
 fct7FleyKpM_aa5MWLn4ghHr0703v3Pq2BxyByxY3tDcBz18j6Whw6y4pZ7llFdUrSG.gF9XaCv.
 AxZZG2DZ7KGOmEoCgi1BKPAjquRfeA_FqkICW3dyBdMzL1AlUZQCzuPHD.0pWzOdqpZr2xuivj2y
 _sMsd0luWyyyrGx0ox_IQmvHU5XdXoo_SSfa0HVjLCJjbjMIxlxjikjt4h5ZZZk6M8fzzdZnLqqx
 8iaBSvTU6fMrgTKiUJqVj3pl2.sQRzgYwRCpuUVvoJfAqT1BARqpgggzclZ6ugSiUR1E3e5hksa8
 S5xtCkg6Ayz9SYAmM9tk8J0OzdYKoWeyujUAm_ln3p88RqkuPBYNtKjPUQlEdOAa0VbzsANNpiwu
 lBHwdPAQspiRJhm6toEURkidbAxdXb2B4sdkaxa2Diceefx7VK_VtHigQYSfKvE9V5TUxafjmtgx
 VpPm3mBS87LXz6otDkemmctaXGNjG.t.dzo5tEH9FIZxd8UoLpC7UIp.gGSPDHEBsTyWV7otn0dW
 yqI3W6wCFXGrs4Ozabu8qZSLPRgE87JaGZ9gJqQhUA8G8BrrGSNPCB7xoDHf03PUOtFDnzpz_9I2
 M3qs6qM1r3oOAbwpLY9871k77om.j_mrG6tmzV533J4zaWyHdvp88V.XpU5ApOYnTIupyitfhB1U
 4wzG1SuTgkY5W13qxyE003cLo.ia9Dh9z5xRHZgwtjcUFQWm92nHEPV7cXSKHET39srd5il71pmb
 ghSv8Lzf563Fb4py6B87HNqi5Ps17JvOpjzcgQFQmL1I3zx7flprOZblpMrmUy2noaPLwS8UXy5s
 r.1PSuwuRzBeR62Pvf3Izx17U5c0_IRpp7gaMhhdGr.O0fE1BblDfLncl5R.91FpTxv9S7iQzJQw
 7GubcWUtNrRJAKFmKarF4OKQgfYFylwx38jtP8zOkl7EZIuDjg36njP4tcE8o7K1x_a7RFlVcLKY
 Wj103SpUQ1x2tnHVTPx06efQVX3iA0e1AaUyd1U70DRS304az3F4cwKapw6aZua0KmGhlpIuslV_
 ODY1xZZbLcBsSixW7pCEQFTziMVQsFZtTL8gyL2k9ODbUQYT2iB2Habh3lroq_0Mbexvjwt.Pslk
 XNYrx3cBxfJ5.EUMKR0yTNAHaF6ulGTq.vgTCkO_F10Ik2f57qe0ockn0bs2lr6xt.mtCn41qbCg
 Bz4mjyo246OMh1urtVZzXAhJXlSK6zSod01eTUEuID9mK9SKRcm56cqpQmdJ3aDM9rl3EnkRkQt8
 DcjWXe2cwxEcGLz9s03r3EoTp3cOZHg0YYpdxtaIho6WOp3dIxBq3yqghWAV3AZ6UkvJBvmp2dK3
 ry.CaHYMIWb1V4ofIfj7AGq_RfkRaWpOZZuTuOpwkvwiTgexoJa8AovNYtIpnaKMpkOZiDN3iwY3
 0SpNebhrqHXfXYo1.X43aRphJWVbEboF35_QviPBrcbzcJjVigLubIuYH3dHWjZaz6uzfqGVhneq
 TdfoIZelcSxzSFEyHInbubO4u7C8yKLte8sXEYV8YViopCGdcxjoi29SVq_QB65EnmW2fjc47gSJ
 Fr8CJtuNTWJ88lKYkW1E7vJNGY7ptSy2JGMJJopQzLLHspRzrvNzxFw11HEvqa55Z3ncNmNIoXyK
 FNHqcHb10_3_kB8zTDWpxBIsN62J8XbEf5BbVTTytaDNnsy9mmrIq10ykGzFAytUGrLcFVKLbOo2
 0DIhcbRxI71HUbdSyTFTaPjm67kcLmV.MHymfVNDxySW3MjfhIPXbeYCfP8TztKIHesJYsQ5vYQK
 l92NjM8wCURopm2JglbSO5BL1OtUPur43DyLj9gHLMRxpNqODu.wiO.QCUzGt9wCMOX9zh3tFz11
 pOo5hUDcf2RJqJ3FhNqmjDOYltFuj50uN8j2OnuyWDR5KaTbB1U0HpJWjxO7wEQw0sigRpKmuuSo
 B3OyjNgOWtiQ2F.GBmiRCJ2DopJYjrGJ_SrJHUp2W6OcY0x9vWHAd84GO7ad9NKMsvpcEYvtv4fV
 4OpUbNHREkjiqwHd0GOWMMh.tDNo4ZaEsVR1bhF_lEGu4nYp4U4g8hKTvFKwE1lGIKe8ovH3Bj2U
 TWy04bmtkjKtc77zMLZgmjrWT0HOLh7hoUta8WjIJgXTzTk2_bU8Xh1EVw6GRuKZEqP57ezAZPNQ
 fQI1jfkaMpJTUORDqoWZrqpIyBnsNu5VCsate8dNybAjagaJEZO9J9IGPYLzJArAFzjTJJolbIdH
 TeCHuFGPz861sqsDyjsW0XTAmV_1fUz4_d17V71n_VFCEuwNWHLQ6QJzCOG1_28TIb3rB9ecYkaV
 d56rPr9wNHEFio3aHlNjC3AtL3ciOjoMHEiRI.g6YDTpE8ygkzAkSzi33pEwYdjC42dh6aA.CsS9
 BeV_ayzu6ApW5n0c5m1V2RMPWLsZWyiGNow34Sd.295LMILk4MHOUPiWGy8v3atmf3bOqFawXaCh
 B7MjcrCMM_E4jglOM9G2HIyBpMCWAEMSOPOT8qXpBcssUNKLtp7cRQ14cs_aKrfKldKty0cFPDVf
 VRtRbYYpTQnLqeiXkcbGJgEXw.Ys4xwm0Ziapg2thXEWcMaWRTZba0D94fjrW.P4ry5CY9XK9i9w
 NWQ3cUGnxNSGvl8st8tvOnuohb.17UqIHQxb.t9qsJHlA4hXzAi4hWIargicNOqcWXNce0H0wEvx
 Yv9VjBJgk.C4n3HDnLe7UxjDX3fLLoC67FqhHIUXucZCuoUH3PIlgZqomJ6tUdXIIZBqmT6uBYCI
 MEyKlPsfwt3KWcvMeDceDfqgrZ2_TFTkbqqARQilV8zQdCdoHAAVh7.afP1cpY6duH0DDtIo-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Nov 2020 23:50:22 +0000
Received: by smtp423.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 4a17fb36862a3a05cf4ce3fe352ac738;
          Wed, 04 Nov 2020 23:50:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v22 07/23] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed,  4 Nov 2020 15:40:58 -0800
Message-Id: <20201104234114.11346-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201104234114.11346-1-casey@schaufler-ca.com>
References: <20201104234114.11346-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-audit@redhat.com
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  7 ++++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index fad361bf320e..be8db737da74 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -499,7 +499,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1228,9 +1228,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 5f9bdd62f78d..35d6bd0526a2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2341,11 +2341,16 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* context->ipc.osid will be changed to a lsmblob later in
+	 * the patch series. This will allow auditing of all the object
+	 * labels associated with the ipc object. */
+	context->ipc.osid = lsmblob_value(&blob);
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index ea927a00de18..9c1098ecea03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1882,10 +1882,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.24.1

