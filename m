Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CD3C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760F82084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LkMSVqky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDITTT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:19 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:43341
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfDITTQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837555; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=LkMSVqkyT/1q3UjwuyS0dRCnBhCTkJnPynPY/4ZJCCg8JTmXNL650HrUi1tn56z2bFtvmGe/kETjA7kATy9Cm/fYPFzH30zrbqSRlzzIyyskD5VCHcOmXRt5X+mbWWqZYG+QThymoRU/oIT28RI6pKT2l85lsq7BfEFv8O4N1NZo4TLz1Mwce0ibcYJmxVsz1aE4Je8BB94lAqcxVQpEdrZOL5TM/qDCD1+tYXyYEmpOZaE/CQfiZf0xjU4lVQXjoWqppc0vqd3UAya7zejAR/CVDZaz71RkVH5KSqlGL42xd5E5/bMettMOEjSeyfCMqmtYaVlwK22hpRvjeCMe5Q==
X-YMail-OSG: lVo6sJsVM1lNRnwnGeg9TZT7OfsNIiVJmc6iAni9au6vXHBvbUApD45k7.0pdpg
 XbblQZqUJdGa62xT_NBAJXWq.5hZe8PEG8UNrvYiaoKoswRQbzYTdgZB.Pg.7ZBzjooJflPCMPHo
 3D0p1OplbO7IZrsLIKSwwtZPAQGsjreC9EULGGMJ7ebzHNAfMzMGkfCqZFSItw9cxd2AfVoYUAds
 tGgUqdYsBM682Wyf9cT3bEHdBlczylpS14CUCwuU6SgB1pmPkIrVsNRBgDOAHFs.7AymIj85agcH
 aLVDx940BnIdGa9vRPBEaIMgBaxWqvdlhtRuZHkIT_mlX88WAhymE0qeq0.3His62iY00LCdF9Dc
 KeyF.vEDdzyOeWsLGqNh1meqj2olffz44e_6DpdE6e5u_TgqFwvIo7t5FlKOe6H8SgmfZI_GS2cd
 Fs3BXGPZrwxX5gZniLBvysMOmcmOyEprk1_unTVj7FUjK0Uee4qrU19ftAPgjRRv1vfpzV8Ev05d
 71rI7xwpCzaoqeNfoIF.K0pHMzpwch3iQcbXSzTQ5pRQAMqBBRARHq78qkNEnT8lT6pSCHvTj3gV
 CsY8YbDXsbEcVl5sCvueTPDNtjhuX2CYSgp9WX6dxXwyyZtPQ1Fpz8i0dkg3aRaErTWJ9Mw9Ltm8
 TW6bFG5Vah74Yrb7Ws6jwls0T0_fyywzVw7JasUOk4o8l5mTRj79Y5eN5PDLkEMQG6976kwGztVE
 sM6p_PgjJY9nWIctW02wjfZKAMFVDrNuL2vg9t0P.Dg9gPK3gypeME8roqZbniYsK3pb7LMTevLZ
 iDTBUJKkBPhtIfQpt01wiOEhvVS3CPiwuDL.jTXx5ClX.FE6UkVGNp7_tB_v1wc3DhqRhZ19KBsQ
 YjRItL3mOZaLMXpKqTJ19kiHemF9M9dGVLoyinom6LwfWMLmlYduMazTsqbx1hz3.lj2ay6gi9kS
 wvJxpYiC.UtRDFLoHbNf3ff6LdfLCU3q1iSeO_PGxniQLlk99wxg5jqc9gUDctXkeybdvNfstbWg
 jKTVBR5eI7otDBBC6ltZjzfqxQavjS17juzIIRBgvhnFFmX2Nt9RfPuLJ.HzfrLHXk4ef1ONbxhv
 wVtN5P7JKdaMSoGpCRIO90sOyuGrZmkxZY5SHf.MzjsAFqJ5DJsn9Zg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:15 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp401.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 70e478474b1bad4641d6b335096eeb36;
          Tue, 09 Apr 2019 19:19:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 24/59] Audit: Convert target_sid to an lsm_export structure
Date:   Tue,  9 Apr 2019 12:18:13 -0700
Message-Id: <20190409191848.1380-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert target_sid to be an lsm_export structure
instead of a u32 secid. Clean out the associated
scaffolding. Change the name to target_lsm to be
descriptive.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 kernel/audit.h   |  3 ++-
 kernel/auditsc.c | 30 ++++++++++++------------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 64498850c52b..e2e6fa911f9c 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 
@@ -147,7 +148,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsm_export   target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 41f540037a93..75d181029d40 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -112,7 +112,7 @@ struct audit_aux_data_pids {
 	kuid_t			target_auid[AUDIT_AUX_PIDS];
 	kuid_t			target_uid[AUDIT_AUX_PIDS];
 	unsigned int		target_sessionid[AUDIT_AUX_PIDS];
-	u32			target_sid[AUDIT_AUX_PIDS];
+	struct lsm_export	target_lsm[AUDIT_AUX_PIDS];
 	char 			target_comm[AUDIT_AUX_PIDS][TASK_COMM_LEN];
 	int			pid_count;
 };
@@ -937,14 +937,14 @@ static inline void audit_free_context(struct audit_context *context)
 }
 
 static int audit_log_pid_context(struct audit_context *context, pid_t pid,
-				 kuid_t auid, kuid_t uid, unsigned int sessionid,
-				 u32 sid, char *comm)
+				 kuid_t auid, kuid_t uid,
+				 unsigned int sessionid,
+				 struct lsm_export *l, char *comm)
 {
 	struct audit_buffer *ab;
 	char *ctx = NULL;
 	u32 len;
 	int rc = 0;
-	struct lsm_export le;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_OBJ_PID);
 	if (!ab)
@@ -953,9 +953,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
 	audit_log_format(ab, "opid=%d oauid=%d ouid=%d oses=%d", pid,
 			 from_kuid(&init_user_ns, auid),
 			 from_kuid(&init_user_ns, uid), sessionid);
-	if (sid) {
-		lsm_export_to_all(&le, sid);
-		if (security_secid_to_secctx(&le, &ctx, &len)) {
+	if (lsm_export_any(l)) {
+		if (security_secid_to_secctx(l, &ctx, &len)) {
 			audit_log_format(ab, " obj=(none)");
 			rc = 1;
 		} else {
@@ -1525,7 +1524,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1534,7 +1533,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1711,7 +1710,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsm_export_init(&context->target_lsm);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2363,14 +2362,12 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
-	struct lsm_export le;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &le);
-	lsm_export_secid(&le, &context->target_sid);
+	security_task_getsecid(t, &context->target_lsm);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2387,7 +2384,6 @@ int audit_signal_info(int sig, struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
-	struct lsm_export le;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2411,8 +2407,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &le);
-		lsm_export_secid(&le, &ctx->target_sid);
+		security_task_getsecid(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2433,8 +2428,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &le);
-	lsm_export_secid(&le, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.19.1

