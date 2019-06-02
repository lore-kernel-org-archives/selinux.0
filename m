Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46302C28D16
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B724A28
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eav5+bSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFBQw3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:29 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:40228 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfFBQw3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494347; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=eav5+bSojuVq1NDxIbxwTMl4MicQpAfi0MtatlV4KE3SKLYcCqRpDpPYNRQPk8Wd13rpIAXvy11TtKhBpG3918CLYvxYlCX2sgrYMH7eWq9RTnN8hEyxOP/QyMb63U18hz2ZXmK5fAJXlchDaLl+b4AKS4kw4ifdqw//TBp6zVkUKgoT7nsXhcHkLvMjxd+rnBy3udgo4fMYNk5TaD33+V81aRNp14pUh3usPYCbx7Vm/nWuJlr0WF1bzgM5zE0+pA3Hyvx+tdhzNuF5oU44ipYVTHTbszG0NWWtebrGIrTvI+ZDmVKknudPhsMft/+FdHqT3uZQCHFVeeSuf5ke2g==
X-YMail-OSG: z2oBVSQVM1nDZ0uVkeUn935NhnBZqy6I23osLCQdSSgBCkZOYzvop2Z5zyVKeeQ
 SKuyygCs2jHXtk7BZkrqmNcEh9g1FYUx1y6.M8dSIypN8glQ_WyOl3MDkVHX31KjNPqt11.E0YKB
 fk6CgfnfaI4f33CKt0oMzGVc._LCPvubzj.uEC3wDEyXVcISFARH8gzG4T_VBCXuTbrj7UvkfNYI
 U5aSX_2fUWc47.tzvX2YayPD1CU4xXflUhl.d6eLeiMFlmhABmo5WKjqK7NyKexB9Sl4gHAE6Lxi
 p1jnSGlL1byjE8R.ngaqO9KIImuR2x1r_h8Tfy5kAY3daDq_t4Ceo2y9UQBrBe1CkOnpngSGDtHE
 32eepRYhyIyhYX4sJSEe8TQbklwKxZTuuMnbWtGplwT_83_quU.hHJgHAmxVxrgkbIJrVgo6jviB
 _PUKFzqAlTC45zFBq4r.HRns5rRKzqHVkZxbE_n1taza_TeeBiLaHCMOXFM9WN1JR209mBUH5.el
 PfT89o1INQ5w4wk.p3Fmr.IGkuatY9AH84jzRfE87qyMrv1gJMz0BEZOZMUtInfDQoX3VF_FyNIA
 5RkYLFw_JVYLcqEA4wASOW0IPizbo5ZbcuiywlSrxH9k5lwKdU1meoaTvB0eVZVRnz1NPrnqw9CB
 cYZtHMeETxwC3sTDEW1QmYSbp_RB1sRNxEY5c6JssXKFxu7mbDiG.wO0a9hvMTEjTPKL.GYc_wxK
 XrXDd2lJ1IAV73Qf1PcLYlhLY0_xoQIdu9YeusrWzGWFySQxznTf0F0Dw9uCSCSJqD8ZlUG0nVam
 WYiRwYnce.3zt_1PLBTEAooaO9L.AgoS5SDKtQRBzwJHf_m9E_Cz0hI15pNbUGi0A_Y0Zaixj_2L
 d1YeOGPlQNuwtzyI02ENxm0WOVcwPJXJnw5P3gQcfPxm8_.lcB7ToZYFxdDL0X5l.KujDCzOIEZy
 TYc0OrkrVQ5MgZXku_XqAzWdK269CpzALZ1yIBtPPqq847alXdke3WAOv6z7TYTNF1ifYntEUkXc
 rrDu8rqvKO2s8FHOHhrpqdVQ99krjUbCh1gu63i1AQa4xPJsuMWTDIAncYGUup7dRnuC66gLeKFp
 VeG15IWMkv.gijfkMVEuhSk7KSO47X0EvvwL.ZdJsBWIrAJuJ3149bnMQ045ciA_IhgBSVuNPV7w
 5ZY.xaKj3cfQNkVYDRSHntqTfdouDFusyyC3Jz8Vi47ae5HDu1TvuzMAC2x2vQeUXZ6_YDHncf_P
 YegMvsrwau54mYpSARQms.5k25uKW8XX38XKgZ5cQSReChnBMsax09fP_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:27 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp403.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f0b498552947f6b5133c1cce9fc77f09;
          Sun, 02 Jun 2019 16:52:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 23/58] Audit: Convert target_sid to an lsm_export structure
Date:   Sun,  2 Jun 2019 09:50:26 -0700
Message-Id: <20190602165101.25079-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

