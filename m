Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D7CC433E0
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C65A64EB2
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBSXaA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 18:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhBSX3x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 18:29:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEDC06178A
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t63so7293429qkc.1
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wCyRr1s1Q50L7dfTjP22sXRMm4M7NMzKEpM5WNi5jqk=;
        b=SUufNCStg3WYL/uZgGcTRtOtGT/NFTXdRVvYywaMlBVsI8axPv/LLLS3KIoVigscHD
         ftH6VdVU4QpDCs5Ldj2vfqCBAWS5aprHH7z7fem3gDj8geUN7gIV45VraMHJ/8MEIinC
         p1l7jrUdOmtNr+vZIjoLOOTf3K4OV6FCEDFGX+dRHxREsaXKrfCBm/r1GCJdqIZGuipF
         gYXfeFQwO1O7DQfIAXQ9fSx5p7M5nfvAeTUFd3jk8RPVU1x2j++nPeDAQrZYKjTGJYaD
         DRNoSvRhapNJ0Vf4h0YPDAJmXRLyOA9gc/xY3RJFzXX30pwvL/St5v5gWS975ECbi1GV
         DO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wCyRr1s1Q50L7dfTjP22sXRMm4M7NMzKEpM5WNi5jqk=;
        b=Pn4CZOnBWbSdeRFa52YdSrlrGTu9Ibpg3sMGh3mLFX6SI6wr+qiSLbW1QxqGsdrqE6
         G3NDrGz71Lqj/Ar8HCp4tUxRk1cXIIJdeKuNXUoVfSSXICFPLGmm+al1byxA2o4k2UWR
         3PbYlqJuRO9xIEV10PODiwGmG4oEbqaHaJY6yGtOvGRDOYxtTvDrvSThKTv8yZHmKP+s
         JKpmru+2BDQfNem9vLLQzREsE3ziCMY3QJh+2pmD+nniJYx0wYpG0KvDvNx/4wz7L+Kj
         F0NUPcVsnSrNOmIvtGe6qd2XFf4hoNQ/8to7KULNm5BgoGTtnY3bc2uHgOqqg0mQBYqT
         TL+w==
X-Gm-Message-State: AOAM533i609rDruEoctD9LOKC11kkpjxg5XvK2c3kCzEs8a5UBMa/NBC
        mGJsLU/fvFnww5DQhePArnGJ
X-Google-Smtp-Source: ABdhPJwefJ+uwNrxQOowyEJn+AzsJsiW4N1Zdv6Kj2OjaRlAHxpVSVQQMNepnsnj6NpQpZGpUncI4A==
X-Received: by 2002:a37:63c7:: with SMTP id x190mr11874580qkb.189.1613777346436;
        Fri, 19 Feb 2021 15:29:06 -0800 (PST)
Received: from localhost ([151.203.60.33])
        by smtp.gmail.com with ESMTPSA id 76sm7464944qke.95.2021.02.19.15.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:29:05 -0800 (PST)
Subject: [RFC PATCH 1/4] lsm: separate security_task_getsecid() into
 subjective and objective variants
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Fri, 19 Feb 2021 18:29:05 -0500
Message-ID: <161377734508.87807.8537642254664217815.stgit@sifl>
In-Reply-To: <161377712068.87807.12246856567527156637.stgit@sifl>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Of the three LSMs that implement the security_task_getsecid() LSM
hook, all three LSMs provide the task's objective security
credentials.  This turns out to be unfortunate as most of the hook's
callers seem to expect the task's subjective credentials, although
a small handful of callers do correctly expect the objective
credentials.

This patch is the first step towards fixing the problem: it splits
the existing security_task_getsecid() hook into two variants, one
for the subjective creds, one for the objective creds.

  void security_task_getsecid_subj(struct task_struct *p,
				   u32 *secid);
  void security_task_getsecid_obj(struct task_struct *p,
				  u32 *secid);

While this patch does fix all of the callers to use the correct
variant, in order to keep this patch focused on the callers and to
ease review, the LSMs continue to use the same implementation for
both hooks.  The net effect is that this patch should not change
the behavior of the kernel in any way, it will be up to the latter
LSM specific patches in this series to change the hook
implementations and return the correct credentials.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 drivers/android/binder.c              |    2 +-
 include/linux/cred.h                  |    2 +-
 include/linux/lsm_hook_defs.h         |    5 ++++-
 include/linux/lsm_hooks.h             |    8 ++++++--
 include/linux/security.h              |   10 ++++++++--
 kernel/audit.c                        |    4 ++--
 kernel/auditfilter.c                  |    3 ++-
 kernel/auditsc.c                      |    8 ++++----
 net/netlabel/netlabel_unlabeled.c     |    2 +-
 net/netlabel/netlabel_user.h          |    2 +-
 security/apparmor/lsm.c               |    3 ++-
 security/integrity/ima/ima_appraise.c |    2 +-
 security/integrity/ima/ima_main.c     |   14 +++++++-------
 security/security.c                   |   13 ++++++++++---
 security/selinux/hooks.c              |    3 ++-
 security/smack/smack_lsm.c            |    3 ++-
 16 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c119736ca56ac..39d501261108d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2700,7 +2700,7 @@ static void binder_transaction(struct binder_proc *proc,
 		u32 secid;
 		size_t added_size;
 
-		security_task_getsecid(proc->tsk, &secid);
+		security_task_getsecid_subj(proc->tsk, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263f..42b9d88d9a565 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -140,7 +140,7 @@ struct cred {
 	struct key	*request_key_auth; /* assumed request_key authority */
 #endif
 #ifdef CONFIG_SECURITY
-	void		*security;	/* subjective LSM security */
+	void		*security;	/* LSM security */
 #endif
 	struct user_struct *user;	/* real user ID subscription */
 	struct user_namespace *user_ns; /* user_ns the caps and keyrings are relative to. */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index dfd261dcbcb04..1490a185135a0 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -200,7 +200,10 @@ LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid, struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, task_getsecid_subj,
+	 struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
+	 struct task_struct *p, u32 *secid)
 LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
 LSM_HOOK(int, 0, task_setioprio, struct task_struct *p, int ioprio)
 LSM_HOOK(int, 0, task_getioprio, struct task_struct *p)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index bdfc8a76a4f79..13d2a9a6f2014 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -706,8 +706,12 @@
  *	@p.
  *	@p contains the task_struct for the process.
  *	Return 0 if permission is granted.
- * @task_getsecid:
- *	Retrieve the security identifier of the process @p.
+ * @task_getsecid_subj:
+ *	Retrieve the subjective security identifier of the process @p.
+ *	@p contains the task_struct for the process and place is into @secid.
+ *	In case of failure, @secid will be set to zero.
+ * @task_getsecid_obj:
+ *	Retrieve the objective security identifier of the process @p.
  *	@p contains the task_struct for the process and place is into @secid.
  *	In case of failure, @secid will be set to zero.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index b0d14f04b16de..1826bb0cea825 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -406,7 +406,8 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
+void security_task_getsecid_subj(struct task_struct *p, u32 *secid);
+void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
 int security_task_getioprio(struct task_struct *p);
@@ -1084,7 +1085,12 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid(struct task_struct *p, u32 *secid)
+static inline void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
+{
+	*secid = 0;
+}
+
+static inline void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
 	*secid = 0;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 1ffc2e059027d..8e725db6ecb02 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2132,7 +2132,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	int error;
 	u32 sid;
 
-	security_task_getsecid(current, &sid);
+	security_task_getsecid_subj(current, &sid);
 	if (!sid)
 		return 0;
 
@@ -2353,7 +2353,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid(current, &audit_sig_sid);
+		security_task_getsecid_subj(current, &audit_sig_sid);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 333b3bcfc5458..db2c6b59dfc33 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1359,7 +1359,8 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid(current, &sid);
+					security_task_getsecid_subj(current,
+								    &sid);
 					result = security_audit_rule_match(sid,
 						   f->type, f->op, f->lsm_rule);
 				}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8c9e2279ba9..3bfbecca4664a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -667,7 +667,7 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid(tsk, &sid);
+					security_task_getsecid_subj(tsk, &sid);
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
@@ -2400,7 +2400,7 @@ void __audit_ptrace(struct task_struct *t)
 	context->target_auid = audit_get_loginuid(t);
 	context->target_uid = task_uid(t);
 	context->target_sessionid = audit_get_sessionid(t);
-	security_task_getsecid(t, &context->target_sid);
+	security_task_getsecid_obj(t, &context->target_sid);
 	memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
 }
 
@@ -2427,7 +2427,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 		ctx->target_auid = audit_get_loginuid(t);
 		ctx->target_uid = t_uid;
 		ctx->target_sessionid = audit_get_sessionid(t);
-		security_task_getsecid(t, &ctx->target_sid);
+		security_task_getsecid_obj(t, &ctx->target_sid);
 		memcpy(ctx->target_comm, t->comm, TASK_COMM_LEN);
 		return 0;
 	}
@@ -2448,7 +2448,7 @@ int audit_signal_info_syscall(struct task_struct *t)
 	axp->target_auid[axp->pid_count] = audit_get_loginuid(t);
 	axp->target_uid[axp->pid_count] = t_uid;
 	axp->target_sessionid[axp->pid_count] = audit_get_sessionid(t);
-	security_task_getsecid(t, &axp->target_sid[axp->pid_count]);
+	security_task_getsecid_obj(t, &axp->target_sid[axp->pid_count]);
 	memcpy(axp->target_comm[axp->pid_count], t->comm, TASK_COMM_LEN);
 	axp->pid_count++;
 
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index ccb4916428116..3e6ac9b790b15 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1539,7 +1539,7 @@ int __init netlbl_unlabel_defconf(void)
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid(current, &audit_info.secid);
+	security_task_getsecid_subj(current, &audit_info.secid);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 3c67afce64f12..b9ba8112b3c52 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -34,7 +34,7 @@
 static inline void netlbl_netlink_auditinfo(struct sk_buff *skb,
 					    struct netlbl_audit *audit_info)
 {
-	security_task_getsecid(current, &audit_info->secid);
+	security_task_getsecid_subj(current, &audit_info->secid);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 1b0aba8eb7235..15e37b9132679 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1243,7 +1243,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(task_getsecid, apparmor_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8361941ee0a12..afa4923dbd33d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -75,7 +75,7 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f87cb29329e91..97a6913bb3d86 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -391,7 +391,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid(current, &secid);
+		security_task_getsecid_subj(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 	}
@@ -429,7 +429,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
 				MMAP_CHECK, &pcr, &template, 0);
@@ -469,7 +469,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	int ret;
 	u32 secid;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
 				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
@@ -494,7 +494,7 @@ int ima_file_check(struct file *file, int mask)
 {
 	u32 secid;
 
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
@@ -679,7 +679,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
@@ -722,7 +722,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid(current, &secid);
+	security_task_getsecid_subj(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
 }
@@ -859,7 +859,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_task_getsecid(current, &secid);
+		security_task_getsecid_subj(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
 					&pcr, &template, keyring);
 		if (!(action & IMA_MEASURE))
diff --git a/security/security.c b/security/security.c
index 401663b5b70ea..85e504df051b3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1757,12 +1757,19 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid(struct task_struct *p, u32 *secid)
+void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
 {
 	*secid = 0;
-	call_void_hook(task_getsecid, p, secid);
+	call_void_hook(task_getsecid_subj, p, secid);
 }
-EXPORT_SYMBOL(security_task_getsecid);
+EXPORT_SYMBOL(security_task_getsecid_subj);
+
+void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
+{
+	*secid = 0;
+	call_void_hook(task_getsecid_obj, p, secid);
+}
+EXPORT_SYMBOL(security_task_getsecid_obj);
 
 int security_task_setnice(struct task_struct *p, int nice)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index af2994adf9dd1..f311541c4972e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7143,7 +7143,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(task_getsecid, selinux_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f69c3dd9a0c67..2bb354ef2c4a9 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4755,7 +4755,8 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(task_getsecid, smack_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, smack_task_getioprio),

