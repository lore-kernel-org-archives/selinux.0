Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275F7C282E2
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2912082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z2xuumYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfDIVkh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:40:37 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:33414
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726713AbfDIVkf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846034; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Z2xuumYWxQWcbNzKOpBlMBC9/T4m7npE0afRWO8TGZ4vJWTPUMGddGv8J4cypX0eINbKlTyARU2yRF7H41Ox1AWoKucaCHAwInYtlQiSfZLeGyMJ65/aj5YwjQaIn9WXd/bY57AaYA2fon9a7hPJrpY8ypLlRv9WOtN/RH3N8A8GaO+AY0wfPm0yl/UDERTUAoF1YQjsBzjv6dFJzSi6QMKqDPsE9Qfq8FyDrura0evG542WFz//swfkmNdDKlrAIlQAIFcRPCwX6J8ZRwxbEeJhOf24BtIGT+FzX+hE6GpRwNZyYO5LINXc8qBUNtbPSioOcttplZJhhn3FQlnzTw==
X-YMail-OSG: XE0GTJUVM1koJ7q1Pq_7mYY8f.p5dVNo9hKjLdozob8svlibl48xDL8jwstBuP.
 P82xHpxNuTmXofSmtHwidqMcPAC8nubJOkuWyeL8vDWjjSsGs.D64KS7Y342M2ipDtE7t50B5Hog
 kldCbQg1CpQwt6IO_FuBXZjRZZ0znXYnKLEPQMLjs6lc9FQ47xBBg6NV_j09pcKkRyKzK5jmOSHw
 CdXPlYgDzhlLoDDbY3kxCPES9VoaptpnmdBgWCaN0Sb7YXsQSg.Lpulw7yXwWcdW.cneEeP6QSix
 Apf56if5oDCMZUcjoiDcDSzg3foIQmDf3MTrTuelfjrUe2i8kfwTDFV94Yv.oDlrwUGxYU9CnRlU
 Ct4zYPpwCwy9T6yvGN_qoKJsN6CFvkVBmu3VgjGhnEvxcqn_r7FbVJzD4T5Hon.lYF7RfO6LI0E9
 GW085rafmvElDwkRPYaq0h0lj_C3kDbFs_MHNRauCiOedOCpgdK6_NSx0K0IUgTLBLLa0d1eyyoF
 Z6iiUUJRXiPev.PcuuB.UUeFAG5azL6nW21d0t1PZJ9ceAOcH_tQpkZOVl58sNCeApPSqgjxXlSk
 rcgEQMTKrRhX6GZozUYQZMVqKzbG4qW6QcwPM3ZzM6DnGOdfBk76UsKKJCOz..P.PdjikEjXCcDO
 EfPjnHiV5SYvSgSNH6yT909MoKORfYdJvBiPdXMPb7qcXI_hYaymh1PDjoMzeT7Qk.xfoAUZHe8D
 wdQ31SMhz2FCnTz7Gb.umQE5k54v5mFhwHc58Y1Iv8YsTeYz0L7jWFQI5NM_wg7SWed8kWsripa0
 k9Tr96i0.rSf_7uuYv3WSf58W_JVo6Ii2rQb_KsihZNIOzZIw2v6dewSNR74Owjz2ulDtVeOl08D
 rvB7CmvxcLikyQWwA26mZnz87j_Fh8TO9mNv86MjZSIkdE1p0yCBc0mvMx7IdyWeaKNDQrbbvoEO
 AkDVWZ3orJb6nGockfkZVJIm5JJ7ZLNkBGUHl62AgQOVZ16QAClU9qUmp0Xr45mCbD4zwVhLmBU3
 WXva3cRKvTRaGBsalVZsb5c7k8jHt6peRs6A7iP.CSQQiIUQpN8PgnNnwDVWWas7jPLiLaPqJNOV
 EDpHp13UqSUYOaGfsiU1nvUQyB_HX3XQQJb7iRIJy4i17ajPXqLQjh6FfJyXUqw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:40:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9d24739551c480912ea4720c6639d78e;
          Tue, 09 Apr 2019 21:40:29 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 24/59] Audit: Convert target_sid to an lsm_export structure
Date:   Tue,  9 Apr 2019 14:39:11 -0700
Message-Id: <20190409213946.1667-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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

