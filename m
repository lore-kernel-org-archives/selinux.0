Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BBAC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0B820851
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rJoexait"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfB1WUM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:12 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:44237
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729920AbfB1WUG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392406; bh=RkkT8VCXXloma0Fq/QmxeKgnWLosnAsoKiC6R1t6xs0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rJoexait/gFkMkP6lsEGLJWa6eeNVahGo3xUcEfA6c9cTqiyqdwuxbmndrfGDyDwjt2GMYPd2r7mD2kkEIg28auhIBGvIBZY6fNJgPIwF3R4QbN4OkH7ZefcuK9nqJaYVKpLqQv0YElQW6MXooHX4K4iGTKZYXLpepRjJOQDjNya4RLgbn1lqlQG4rRAh94RA7Jo6p9aM93hY3SfWYsFw3AOlzPKX+grMqWRtB/oZ1qpbXjWR8D9ZG7cGyOSGiF/aIh2wONUrbUnFVtFMhPuxahlcbRivj33ufIFpTBcurB2AQZU+kjLGqLRKRN7JBjl+qyWmYc0KMlOScQ5lvi5gg==
X-YMail-OSG: jEm.EwcVM1nxwz7G39ySxyN_SP5CWoVCLNzNh7fbTZrdG7LbgIbUTh5ZYqab6zG
 _.jLw1SMXYYnVoT984yuD3XwYWfqCWp5D1.SNXK90ZUsvqQMoxVyeiydpgsI2FvmMbq7_IKiNGDH
 CS6veEx.nfpQTFiFtEYowM.q45vbwXfcItgVkSBWlePMZ4ck3wP0Y1lXMbeVLL1QResHTCC6a.na
 GkJA0l4_I0.3u88KNMGt0uH4MpdGetIZb.CuVfrdUIfgYqbqRK0LKrniMV.u_4J4rlMcPkIOdxSy
 _hS3aNY9z9DinXhTEOf1mNl8_Vz9AuhadWKrPYTMuPcUj9_UQN_dCvvqespRQq6eJwle4QckY.Ic
 6aDFE0VGTi_VmLfguLy_izKekJGgFPV1dYXiBz.kkf0sAj4Hx5M6_wv7Uk8U1Ei1fny1qw6Or0_y
 ks5OEiPRVlFBPDAC4F2hV.KtwCohTuMIhR19USe6vpY2PNf3_SIafYaSXYUQZmJnWfuSxspplQbD
 QcS1.F8zNXH1pk4VJy239Nm90lw_l86It1PkF1AHqyxqUBK8PetbmM5m38CnqcjIOtgkMOv7_TfR
 41M2xhFx7_NKFzTk1ozOyZVENBTJAVciyGrXOJh4h_abjCiz4zaeicgUt4y4jZL8P12Qy3ViDGVf
 lUKElSWBZcZBLuiCi18GFT2_QdT9ypDL.J4XQeSxvZx.kpnxIoGk6.9JZovbSP9fmljt06adbBoC
 jgBW7AtboDANT8qXeTnOtfVdreYXeHL77NAHKYxsUFen.0iH3Cbv1OKN5D6JyEOEPFK32kqOl.rN
 mg0mBf5wj27_hgGHnyTbxJI8SDuEhx3kaSpM902y5KlELy8S78iyLPQ5y953.bPjffdhAWB3ET.J
 dux0BwmCq8bTjRndeUHEy8z_kTxbzGPlAWGFeRdEElFO7sIfOs.au2CnEH9.tHXTmTnVK50HHfhr
 KVvsAWW643_OzsYPneDxXCvwa__NZbaxs2q6nWxEFwDTDOOqRRQ_gpseQcImuZjLuJzmrQMHqKMQ
 s2yT_7bkHAvWg.bt3ft_xCfG4yBzL_g1XjW6VLiFIw1QbuRp6fuhew8c0D37ozz5.B6_7iP7dGuV
 YZciNRm3lXQg4WeTmiThDBIq8IntpvhD4Ez2yDXFfBtBrF3g-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e8fded081226753664bb344863181a7a;
          Thu, 28 Feb 2019 22:20:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 30/97] Audit: Convert target_sid to an lsm_export structure
Date:   Thu, 28 Feb 2019 14:18:26 -0800
Message-Id: <20190228221933.2551-31-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
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
index 06c732e0f301..63883a773aa2 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/audit.h>
 #include <linux/skbuff.h>
+#include <linux/security.h>
 #include <uapi/linux/mqueue.h>
 #include <linux/tty.h>
 
@@ -146,7 +147,7 @@ struct audit_context {
 	kuid_t		    target_auid;
 	kuid_t		    target_uid;
 	unsigned int	    target_sessionid;
-	u32		    target_sid;
+	struct lsm_export   target_lsm;
 	char		    target_comm[TASK_COMM_LEN];
 
 	struct audit_tree_refs *trees, *first_trees;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index c57c2e346c6d..2ee74d18c90c 100644
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
@@ -934,14 +934,14 @@ static inline void audit_free_context(struct audit_context *context)
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
@@ -950,9 +950,8 @@ static int audit_log_pid_context(struct audit_context *context, pid_t pid,
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
@@ -1401,7 +1400,7 @@ static void audit_log_exit(void)
 						  axs->target_auid[i],
 						  axs->target_uid[i],
 						  axs->target_sessionid[i],
-						  axs->target_sid[i],
+						  &axs->target_lsm[i],
 						  axs->target_comm[i]))
 				call_panic = 1;
 	}
@@ -1410,7 +1409,7 @@ static void audit_log_exit(void)
 	    audit_log_pid_context(context, context->target_pid,
 				  context->target_auid, context->target_uid,
 				  context->target_sessionid,
-				  context->target_sid, context->target_comm))
+				  &context->target_lsm, context->target_comm))
 			call_panic = 1;
 
 	if (context->pwd.dentry && context->pwd.mnt) {
@@ -1587,7 +1586,7 @@ void __audit_syscall_exit(int success, long return_code)
 	context->aux = NULL;
 	context->aux_pids = NULL;
 	context->target_pid = 0;
-	context->target_sid = 0;
+	lsm_export_init(&context->target_lsm);
 	context->sockaddr_len = 0;
 	context->type = 0;
 	context->fds[0] = -1;
@@ -2260,14 +2259,12 @@ int __audit_sockaddr(int len, void *a)
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
 
@@ -2284,7 +2281,6 @@ int audit_signal_info(int sig, struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
-	struct lsm_export le;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2308,8 +2304,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &le);
-		lsm_export_secid(&le, &ctx->target_sid);
+		security_task_getsecid(t, &ctx->target_lsm);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2330,8 +2325,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &le);
-	lsm_export_secid(&le, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &axp->target_lsm[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
-- 
2.17.0

