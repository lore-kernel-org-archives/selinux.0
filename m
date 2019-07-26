Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA50C76190
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CF821994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cEi+zTTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGZXjn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:39:43 -0400
Received: from sonic311-31.consmr.mail.gq1.yahoo.com ([98.137.65.212]:38804
        "EHLO sonic311-31.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727796AbfGZXjn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184381; bh=sZLZcqDLXjHGG+OTnhul6miLPONlWzEpDQClgCPdkKk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cEi+zTTljiHmxuPdg3/lL1zbUaYgfP0HHYn/D4qutBafntytGGgjJz3NqDPiXFj/kbGSJC4y4rlWvsRVXqF2+wDccUP3z+gEAJCgraiAfjKDnCcryt4rGet9Lw2Wfm+zkWHj9cKMNQVc23Emg72RstobK4W0ngItX9S5bAhlRbRd9nS0IMwBq8VJNfhXBZ/IO+5mXnbFCNYDTTc/UnBRoAtWmNq9jjU993I6oV4G2161+ybv/0BJTW5osnw5LGm3Ueum7qDF46T7JR/ada5F2Zjy0Dp0ZXNvcDiQMOaTwSRBbvozBiJ4t03gZbv/klfEa4OndAgvr6v/8sTHUMuf7Q==
X-YMail-OSG: At1Obw4VM1knjn6XFZ3f5DmZ7zM_djC6aMhaGCyX_w_ooORzJN64Ax7QPAIFZcH
 fQg5YoNBttsIqSMtpincLuPEawpEWGCZO0jniadN93oKSHkgeEZXcNa.4BUCViBRq6pcV6ueIc_q
 8EObT9m1Vxiv1.KDsM_1ChAEz7L0JCaBMeYAjvokaNVTbWTQZuMA8fNCmoDS4qLX6Ym8mFtVJP82
 VNXseysmsWr2VRdoYk3C_Hj.4MJS0TEZ_UaIfiaq57NncXnxVCf9QCUZLRBTpJ_jJ_2QFVPm4UHt
 bxUZgGDiunXMg4fUjqfvGh00WIcw6MOwWV_R7s2xccX5GZaqhjC2dBPfrTApMRf7qFlqQEkFcXQP
 s5DngxMEBphVPfJ9XrxxEZsnC4sGRZoC99GWNZIVW4cuOyNcyQ6GszdK0dxVZyk2pMD_iwjl7btk
 mDsmN88Q53IMftCgxm31C0VTCi9.FRQ681GrHt4aVmFywu6xvz7BLhjcpgW.0AMx7_5fNKreuW6R
 4aJJ6hwFY_N.JA4jEdkULq69_49DboQ3ayHcMpbOxZDMCtIRD_24I_wEQaYjJcEcMKhUQ.qRo6Cx
 rTCnEGXspMbjfHF3qBIvwPCe2orwlZaO7uwJJs9wOwtFei_UKIZ1s7j19F79bqKz8g2SFnTo8M7A
 E4Ch8PUu9.JOC.myqyMB.JEIRIJoglHAO1sGi4m51A0B7RbDsnYKJYQ1XOgTj1H_6SxWnsh8.UbT
 uIRWxWko.Ebj4sV9qE8NlY4WOeWAclByS2dfTJcPfAhlzoQI1jqMq9Ju.xvA1n9zNzv.SEv2b_f_
 AveEbfhF7Du80Skcz9xadxOGu2.TtCihSOEc0B2W8jAJfB5pHZN_YzPWQUpHG.6kRJ2fggp1q4Q3
 7gXkljtPvzhzikVLlJWeakEwxEFJu6EJKPT1g7510mfDVC5ON.JHh.7BbIi.bW2i8KU.e_99F6pH
 roJdyvFxhyjSIeDRuCC42.gd5X0S7WyN.5pLMlRdjUR.C0bFUFrzkL6YaijjgvGonKFcBUMkgEq1
 S2pEpSDnZqduMjTQVi6k3UILgx8G.5Ji5F7nJsQWVC389PTTaSQTTYgDNEdyYqr6QOjWdQp_5nMp
 O7lA1sIVNKSHw.X7vcAnl1zF5OOm2oGunFbI34FwFNHQfNNILi4ie_STmFfdOFSxEnuv9YWJr34z
 AG1e03vd4a4hYVHLTmVA3qRpeMlRRjJfqHa3ShWfI4zIvD0vlQlQfh1pfn9ylBU302GE.DD1j8ND
 rbuGDViv13Ptxk48ol5NbyMfi1uFjP0NU9Ly66SEhl0ZW8mmLMTdR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:39:41 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 78a02322228761c8d5b60901ce41d5b3;
          Fri, 26 Jul 2019 23:39:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 10/27] LSM: Use lsmblob in security_task_getsecid
Date:   Fri, 26 Jul 2019 16:39:06 -0700
Message-Id: <20190726233923.2570-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the security_task_getsecid() interface to fill in
a lsmblob structure instead of a u32 secid in support of
LSM stacking. Audit interfaces will need to collect all
possible secids for possible reporting.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 drivers/android/binder.c              |  4 +---
 include/linux/security.h              |  7 +++---
 kernel/audit.c                        |  6 ++---
 kernel/auditfilter.c                  |  4 +---
 kernel/auditsc.c                      | 22 ++++++++++++------
 net/netlabel/netlabel_unlabeled.c     |  5 +++-
 net/netlabel/netlabel_user.h          |  6 ++++-
 security/integrity/ima/ima_appraise.c |  4 +++-
 security/integrity/ima/ima_main.c     | 33 +++++++++++++++------------
 security/security.c                   | 12 +++++++---
 10 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 1962f6b8abd0..144ac4f1c24f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3119,11 +3119,9 @@ static void binder_transaction(struct binder_proc *proc,
 	t->priority = task_nice(current);
 
 	if (target_node && target_node->txn_security_ctx) {
-		u32 secid;
 		struct lsmblob blob;
 
-		security_task_getsecid(proc->tsk, &secid);
-		lsmblob_init(&blob, secid);
+		security_task_getsecid(proc->tsk, &blob);
 		ret = security_secid_to_secctx(&blob, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 41dc3053094e..cfd7cf4b0be9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -400,7 +400,7 @@ int security_task_fix_setuid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1029,9 +1029,10 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid(struct task_struct *p,
+					  struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_task_setnice(struct task_struct *p, int nice)
diff --git a/kernel/audit.c b/kernel/audit.c
index d0338411d75d..a0205f3c23c7 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2075,14 +2075,12 @@ int audit_log_task_context(struct audit_buffer *ab)
 	char *ctx = NULL;
 	unsigned len;
 	int error;
-	u32 sid;
 	struct lsmblob blob;
 
-	security_task_getsecid(current, &sid);
-	if (!sid)
+	security_task_getsecid(current, &blob);
+	if (!lsmblob_is_set(&blob))
 		return 0;
 
-	lsmblob_init(&blob, sid);
 	error = security_secid_to_secctx(&blob, &ctx, &len);
 	if (error) {
 		if (error != -EINVAL)
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 8786b95b60bd..8f244c98bb57 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1323,7 +1323,6 @@ int audit_filter(int msgtype, unsigned int listtype)
 		for (i = 0; i < e->rule.field_count; i++) {
 			struct audit_field *f = &e->rule.fields[i];
 			pid_t pid;
-			u32 sid;
 			struct lsmblob blob;
 
 			switch (f->type) {
@@ -1354,8 +1353,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid(current, &sid);
-					lsmblob_init(&blob, sid);
+					security_task_getsecid(current, &blob);
 					result = security_audit_rule_match(
 							&blob, f->type,
 							f->op, f->lsm_rule);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 148733ec3c72..7112fe31684d 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -444,7 +444,6 @@ static int audit_filter_rules(struct task_struct *tsk,
 {
 	const struct cred *cred;
 	int i, need_sid = 1;
-	u32 sid;
 	struct lsmblob blob;
 	unsigned int sessionid;
 
@@ -628,10 +627,9 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid(tsk, &blob);
 					need_sid = 0;
 				}
-				lsmblob_init(&blob, sid);
 				result = security_audit_rule_match(&blob,
 								   f->type,
 								   f->op,
@@ -2365,12 +2363,15 @@ int __audit_sockaddr(int len, void *a)
 void __audit_ptrace(struct task_struct *t)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 
 	context->target_pid = task_tgid_nr(t);
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid(t, &blob);
+	/* scaffolding - until target_sid is converted */
+	context->target_sid = blob.secid[0];
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2387,6 +2388,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 	struct audit_aux_data_pids *axp;
 	struct audit_context *ctx = audit_context();
 	kuid_t uid = current_uid(), auid, t_uid = task_uid(t);
+	struct lsmblob blob;
 
 	if (auditd_test_task(t) &&
 	    (sig == SIGTERM || sig == SIGHUP ||
@@ -2397,7 +2399,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid(current, &blob);
+		/* scaffolding until audit_sig_sid is converted */
+		audit_sig_sid = blob.secid[0];
 	}
 
 	if (!audit_signals || audit_dummy_context())
@@ -2410,7 +2414,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid(t, &blob);
+		/* scaffolding until target_sid is converted */
+		ctx->target_sid = blob.secid[0];
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2431,7 +2437,9 @@ int audit_signal_info(int sig, struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid(t, &blob);
+	/* scaffolding until target_sid is converted */
+	axp->target_sid[axp->pid_count] = blob.secid[0];
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 2d8dd5b84457..2294aa9471e6 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1552,11 +1552,14 @@ int __init netlbl_unlabel_defconf(void)
 	int ret_val;
 	struct netlbl_dom_map *entry;
 	struct netlbl_audit audit_info;
+	struct lsmblob blob;
 
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until audit_info.secid is converted */
+	audit_info.secid = blob.secid[0];
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 4a397cde1a48..ab88baaaa50d 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -48,7 +48,11 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	struct lsmblob blob;
+
+	security_task_getsecid(current, &blob);
+	/* scaffolding until secid is converted */
+	audit_info->secid = blob.secid[0];
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..85c7692fc4a3 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -51,11 +51,13 @@ bool is_ima_appraise_enabled(void)
 int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 {
 	u32 secid;
+	struct lsmblob blob;
 
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid(current, &blob);
+	lsmblob_secid(&blob, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..fefa848cf0c7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -335,12 +335,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
  */
 int ima_file_mmap(struct file *file, unsigned long prot)
 {
-	u32 secid;
+	struct lsmblob blob;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
-		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+		security_task_getsecid(current, &blob);
+		/* scaffolding - until process_measurement changes */
+		return process_measurement(file, current_cred(), blob.secid[0],
+					   NULL, 0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -363,10 +364,12 @@ int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	ret = process_measurement(bprm->file, current_cred(), blob.secid[0],
+				  NULL, 0, MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
@@ -387,10 +390,11 @@ int ima_bprm_check(struct linux_binprm *bprm)
  */
 int ima_file_check(struct file *file, int mask)
 {
-	u32 secid;
+	struct lsmblob blob;
 
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, NULL, 0,
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
 }
@@ -499,7 +503,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		       enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
-	u32 secid;
+	struct lsmblob blob;
 
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -521,9 +525,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
-	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+	security_task_getsecid(current, &blob);
+	/* scaffolding until process_measurement changes */
+	return process_measurement(file, current_cred(), blob.secid[0], buf,
+				   size, MAY_READ, func);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index b4789c31e532..43076ae0373f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1712,10 +1712,16 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid(struct task_struct *p, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.task_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.task_getsecid(p, &blob->secid[hp->lsmid->slot]);
+	}
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
-- 
2.20.1

