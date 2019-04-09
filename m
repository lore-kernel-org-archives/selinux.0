Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10238C282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D225E2147C
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 20:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PwDFRtpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDIUA1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:00:27 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:34133
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbfDIUAZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554840023; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PwDFRtpQYNIo+FWCyVabdOJF7TUw287fp5O5VJi9ShV61OYdGvE9T/TbYOyQrRgc/+I36bneqlCzdjUEm/syJYoaImNXDaj3JZa3WCBjZjiTpve3QihWvN+qyoz2WqjpGb4FEjHH6SbN7dbvJfBV7qDJ52ycwc7mX1LOlodUlPEjhd3TYr9X7LgMMw1CNfsCcqWWiSPLB+d/mQ7L8rN24Fq/zGm5TvDrcAII7ccNF2vcmVaUDxoe7Sdk4xge1DdGwECvVMnVUgYMRHN6+CXMdtO/6H2NqFERBO6M8YftG4Yl7BzZCSCTNIVeeiXXhw8ghUSlKJYAdLMDBmZ9WUwZwA==
X-YMail-OSG: .5Ec1KoVM1kxwgVOuJGvaW8XyVZOjcWbSdYn9BEhit.ItAd.2PT7uoU3FITEuVS
 2xzBuP3I1KXL29Kqk8gonK0enfIA8D9fRuN66DbVA7Bu5e6GEIwhILTqOJigTn4.19.S6Z03jkIE
 ekvdN1BYqA6cpr6x_RPtKrGf_p_bIeTEBQaK7tE5dQcRi_YIklpj8j0xbdQgW6nFSdJYNz.dAVDm
 PJA52EpdRDS.blpVnfoXSwajiaMeoaHE6ICmRw8fCbCPb09L5IE4UEnz_MUZJTyGF1ePBtBH1HTY
 bw0K1O104iqGDWRLVkL501zo9buyMyZFTznHRVhu4nw1p_nImADgLu.8B7bd5A1BEjSvcCy1Ty2i
 PW4Q8pnSQFsjTi.u8T5MAA7COrjGNHxY8sfYFLktE.coLaamknIk.nMRXvCK_wfFUNnfF352mgVB
 l70DfSjBNJkNO6p44UTBH.o6iH06G4sG3_8SFKA5cVI85a_Sko_gAMhxeUylMnNPCumXQc2FOc23
 8pit2CeFgnH4ha6xT78q.e8Bs3Zn.BuCv9qspnF1_zDTQ9n8umH59LxNmXbT5o2MKpU6iyU3hFg3
 hZIImsDHRlVC_9ka2ku_TGYjsukO.KGp_0ds6.D.xNl4CJME9BXMx9XEAtT72lY_LZhAstgqqCnu
 gieGg__hZpNd9nK76QKC2wvQdWSuSls1VHneN7Og3LIyTZ5tPvR_1B.9Iw9h5J7jAOpJD4vmm.s6
 2d61cxLg5hHH3OBdrXULzp9PpdLeXg3H7xVgRjluKb24.Q12FoMXPmSIxffLd8.UiflGny2P_7y3
 2ZLhWpHuAUDzo8cDQwU0g5U.XgTp1GN1WSkXHChtGzR.kd37rJo6p65amyOVzQdduux0qQqt84EN
 aMqiV.IIlDrNXVkZBInMQWa3vQmg0QB35i3wSJXWHRLWnTuX.j.crPp6nPs6Udw0xRAKjM.eV5QA
 tyawG9U1crJhDzs3g7VcHkakjWLLmBYHVY2Ub3oafUUHjuQ4IQBFKb5jSnl4oV5joe5d7Fxn9KbM
 fcYB8ApS7OMqxWSgx7yEfs542ODrGmQzqoZ6Mzy2vufNf.n43jDcvLD1l.1zOeLRUR2Ykyj.TKdW
 quQ_fyBtSwygZ4FpAXDPIZTvvbGZtIlf3GfhCidowBHJluHjQ.kxrj3NoRiJX
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 20:00:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 102fe805e930c993b64b67f47c5c2e96;
          Tue, 09 Apr 2019 20:00:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 24/59] Audit: Convert target_sid to an lsm_export structure
Date:   Tue,  9 Apr 2019 12:58:49 -0700
Message-Id: <20190409195924.1509-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409195924.1509-1-casey@schaufler-ca.com>
References: <20190409195924.1509-1-casey@schaufler-ca.com>
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

