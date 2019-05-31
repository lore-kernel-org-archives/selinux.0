Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C3C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211A26FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kk+VTXnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEaXNm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:13:42 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:44843 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfEaXNm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344421; bh=V6rKCyElicKZF/0fKwJbU08oHRiI1KUrOSjj+nGJXW4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kk+VTXndsuL2kxK1HbZ6qsr21wdQFYxDOGALvRkV+mAYb+U51CJmoTSKi4ElCyEyFJMRqB/kmg7s7sAyAilmlY2aqiino6U15YV1YVfzcUgRbW9zYvPV+6oQZ3iisIKHCDRqP+tDxtRemHadgRMj2f159V/o08rFi+TolzxTw7SEZhAvGvzJ3LT1sueqtTLtq8Aw/Vw+MJEDyMaLaVlxNFwjn+qOgPDhenyZkNgdGT265mD47R3ywDDCWI0NbLMnMKC1jiJK81WM2G3LoP8w+vnMj7xsr6hCKu8JoQbhWdECqI+4CjrTwvhdRBSRGmgoaq3DXhSNBUCHpTn5n7YdLg==
X-YMail-OSG: 6pbJXn4VM1nBitkPuqE_bwwpcEwcQOhfXHXhVY4gISEZSIloWAWUCO.oEdEkpJ5
 aQKp0UPHNRJmAwdBegZqHo8SC8amjdjyI_FFJT3vOI0tgn0SlUMMqtsmpqA0MS7JQdyW_vaytFQH
 1Gzc7J.PeAd7h9XmxpMijNSs0J1NAHL.lMRU6VGo0nHHFpbRd8YrS_LmYAhr.nmFBcOgtGhXwxSW
 qSJNMUp1765k70LNToqDonGesWGouN8pcU5eYhPob4txduJfD5AiqaQ0suCiYI.9EKXD00c.ncrb
 Msz3bsv6TGWsSWwVMW4DLjtLXxsC1VcYPBUV3GMtswt0UMaJTKHiTF.gXu5YoOnXfnCd56NRhPXo
 wqVxnQtgel5sxddZJ75neg.F5D3j2rzVbni4NvzPGPqrjcPJSE52z3IM8nlosqMPSQWQbnpHYfu_
 6HT5DHY2L4LmZ_4tl7EWpuCYnlKtQcfU.3r59e7125m_sU3j01HYfq5ftvI7sF03tdsydrF93Tdz
 unj6SxfVOSCeju90a8ZnAwkdVrF9j6Y8Prx4HbPbU.cQW0d3C_urdSioa9tc8rUaeedVtmY.tUOV
 cZ15xX_k3Qt52fHegL1eAZrkPd_xx50_b0lUjzkcn53Ni1Xoh99YqkxPCeZHYd6UERRM3EAutrdp
 kB8LJaSsG1AEQZVXV4mfwT5RB8bXID3U6uaElmP5O4DhuAJwBdXrxH0LDxra.PpKrE_ydfChqDRK
 Hq1J.CqriMtpGQEqIuo2.XBdJ7oqPAriEMvfmJHIcfwU9CEBmnFP.YC5K4NnR06EtBcZdQN16epr
 kEO2dnNkuXTRJZdq81_FCrNQbqlmsXvkgc_4Pgsf6ZgbuSMCUHDr88kuwXVn97vbiCijpu.AxLX2
 86OOYNmYL1g2LDClPcrYsnZRvyQDH9iDwcq98JSqoc1HSMiqrOxJ8Zd7dz8KhvqWOtAXqxLJwXAO
 _uq0DdCRWDLfYhGQZcYk3BvTj9LWFmds.0yDmb.rBoOtOzn72BDAEsQgOK0_C9HVjRT3ThpGIHli
 PmIhCxOV4_LcZP3i_sjZ7sSiEYkq9_BF2Of7Z6SDacsHn2.JvUnAArMpuFSj.xlaG_6ChpoPj4Vy
 WOBxj4JoPMb7nXj2z7uxCt84C18hZ2llyHF88JE71E6b63tfVTQNnpTZbPieVO1Q0fLrgVXEK0Tt
 dVd2Cg4hq6E2VWE.m6sMZe3SLblvdmAmFjkvGGb8ePCQJTJOaIcvwi8QAyIMKDhCQlaAW_Jcjlik
 a_lOaga0dioQKCFftnYY9xsAoI9S.fT52IovCFuLnWp1iSESYZezUvSrLeA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:13:41 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f1f4781a1c1cfce2dfc25044e7a51d44;
          Fri, 31 May 2019 23:13:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 23/58] Audit: Convert target_sid to an lsm_export structure
Date:   Fri, 31 May 2019 16:09:45 -0700
Message-Id: <20190531231020.628-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

