Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63698C282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6B0217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EAMx1pZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDSArT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:19 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:39870 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbfDSArT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634838; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EAMx1pZIpJhKJ/L9D9fHZcIksCMY2HcZ/u2U3c1/3ft0VAeW4Ltrj3f80EwJSyrUMxdIMCWkOLxu1JQflJ7SpYw0Sl95pp9B7P0/hiwqs6S09teSxXL1ZZ6KK0N/RNIpVP6nP+ds96ChXqM/W7kCgHFrc8tSj67Ea/+giQJMNrLErI3Q5PmNW91D1NtgYR5OcoEYgxeoLcWnlvMYxZ047B+SAeAHJokELS1E9vjE/d1d6EOKb9S/7ohxG9XWIcdIFouWrVE+GitvkKclDAAGeUo+8J1L1KifHj+3Hu7VVewp35C7H9zNxDWyvR6M2Ew2Nl7DO+ka1+ppveNhV5aZEg==
X-YMail-OSG: TDBFR7UVM1nqilPpYCa_dqZHln4.beY4xmDY2TNp2N8U.lj5VpmEg3rzvgnx7RU
 6IfCh5VXFN2hWANwLm9u2BNLB2gA2Xoq_.JZwpXWzUfyu5vp5mgbwv4gXyuuq_eaw.gdLlbDbux2
 fFVboRIxNAoKtUZXxrM2935z_Y6VRNV9UI2aDLBk3hry0Adwqw2msiYJ2ZY4dN8mdcllxet_g7EG
 xZIVmVZMW5iOiLCRmC5QImQfRuC0RqFi1oxh6rhB4SEftBt1p985dvnOO.WtnMeSju5oHn6CHcHw
 XLwukqo7UEtjZ9aXWCJFc0tekZa8cb74JYO91CF1xUv4ZjbiYxujZSWxjeyxpCki973g_RcdagOC
 hFv6pJJX15gaz2cbrTe4p6AT1unQ3I2vKNA0IYOupGLKnD6kkdUsv2Qml7puFV0LISanHfmGcnCr
 z3cB6KUpIaR9IhOHPzGP6_iOou97GA1FA3LhoGN2r1ooUhJyd0bVkIvFhWorRCwBSh3RaE9Z0BrV
 IHzLfr3XJb2ZuLqGVTLbJFwKmv0WuEcWgAUJmRcMZMf29BwMqLEbBn4Az6NEz_iVbeWSBen.tWeO
 iJUUC53FD4StldN5FtgGeFWELjGN5TkYeYGH05_muQi3gXhV8l.WZzbG28frcGQQjNnWblHnBp.0
 Qi1ml94ogzmnlZjOLxGZ92Jizbw5D0zCVBuYXuSdy072HnZVg65Mw6J4hMZ9FXQi1GPAsenqi25Z
 nGmYq_kf1J9_sYhMjLxfn6GRbWquXFQN4Y3.ctZPqR4IN2fewwMGZIZ0mn9wF1xHRodvUeUI1tZq
 jUlG_bqZcrNRLxp4Mfa_KGMqW1rBCC10R6.IOKcvVNhA3LIaT4Jz6KrMounrKyVA3PKi_vsztuLS
 Uwtv7H4q0JDfc6mEPeBZP.1orCeEJcx0e0Q0wDPPKPs3GH8C4GOLl0zsotGwT2TmRYKzHjKclcn8
 j2NkTl7nXqYR0z8VPbk9k450MiQxzejRkbNDHJEAYWJPsrJEgOuqvc5SXyBPY_ArxtaecKzZrXnf
 pWPwJ2LfFoDCvb5VTuAqANxlh.5RbPI56uKQo8M1eUStRxQJxpRgAEpqTKzfusO7lW0.JMOBMnRs
 2WUi9nYFxh7d4GZDTdU0btVpzFkBzYxxm8lr3FbZqs.9AaIERm3TF58J3YXvgzPp.35JTbUsU0hO
 vm0peOWonNigD0Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2b98cff5dd7fb51e7c7719cd11eecc1a;
          Fri, 19 Apr 2019 00:47:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 24/90] Audit: Convert target_sid to an lsm_export structure
Date:   Thu, 18 Apr 2019 17:45:11 -0700
Message-Id: <20190419004617.64627-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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

