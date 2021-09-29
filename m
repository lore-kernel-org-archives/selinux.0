Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C639C433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 19:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D65261528
	for <selinux@archiver.kernel.org>; Wed, 29 Sep 2021 19:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346539AbhI2TTH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Sep 2021 15:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbhI2TTE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Sep 2021 15:19:04 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B8C061766
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 12:17:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 194so3381955qkj.11
        for <selinux@vger.kernel.org>; Wed, 29 Sep 2021 12:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eJb/JVp3FxYYy6amy1IruEIALBdW9MHQB109k6uN/v8=;
        b=OEg0DHRNuXRLc1V6+7F9NDFSHuy5GLz7adaD9dNnKQ2LH4tCZuMxOvXXke8u4VMmgI
         eNTaryQUc7DvC0oCa3ObnN+arXUoi1Ko8YF4AQCqqM9GTgWxMROQMA9pZSZqGIC/r/3Z
         KjJQOJdSy02pE0aysiM4IvfqA2M/c3CgFI14uarMi/NrKaoxPEu7/G1q2+YlsyEmmLeF
         QQ+xVjDyBvXl9yw0i/V5eLs+Lt5u+8Hh1CmSoBejuA8pqxbKOb3joxu3PSYIr9RiAjzc
         +0NZxupcyAcNfLnnMjdRQR2YvSQCCZ8smHAVZv6/X6IDxCRKM4s013UarKsSOh0mo98c
         703Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=eJb/JVp3FxYYy6amy1IruEIALBdW9MHQB109k6uN/v8=;
        b=WEBt3w+NNTXBmoWjz6boWaHv2QmmVru/+q/9Lt8GHcIp85E9kZ2EIFlC5PvGqej3Oa
         1Avh619DdRZH1e22WvDTHaFzp44IP22oDO4UBSccRHvzsPw5e/4YxjN4VYPBm0+xRnlC
         L27ON5KphLUTXJ8/fHL4ZdvRSHcvqFnIyJqKot073GVqyR15vFhoFmVSnLt6WAKM5ZCz
         ZOBhj0vEBu1/EvNO2Avh3yqauvTtyZ7qoS8pCGHvIYk3271+6jgMor3tgGmsPdHuQ/B0
         nbeZxpv2zO0g8qrII8qhfRsjsY29PzrX+INSXGyKeF7U+769zWzcEsynExjtbk6NKKU9
         Bw2g==
X-Gm-Message-State: AOAM53034fNym+lJqxt5J02UU3Lx8qhbnI97AVZJQtr54XaBJXpeqeES
        dzk5gKb3MTxIeAlE1O6LPp6aYZKcg8Dp
X-Google-Smtp-Source: ABdhPJw55jw6kvvccB5JEofP9H+Em3wj1Gp4II+pjFc1Lw/J5XL6Pter86UGn/JG5SfWjT6KzQNjKA==
X-Received: by 2002:ae9:d8c6:: with SMTP id u189mr1363042qkf.391.1632943041787;
        Wed, 29 Sep 2021 12:17:21 -0700 (PDT)
Received: from localhost (pool-96-237-52-188.bstnma.fios.verizon.net. [96.237.52.188])
        by smtp.gmail.com with ESMTPSA id l7sm407623qtr.87.2021.09.29.12.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:17:21 -0700 (PDT)
Subject: [PATCH] lsm: security_task_getsecid_subj() ->
 security_current_getsecid_subj()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Wed, 29 Sep 2021 15:17:20 -0400
Message-ID: <163294304032.208242.9097581875096098591.stgit@olly>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The security_task_getsecid_subj() LSM hook invites misuse by allowing
callers to specify a task even though the hook is only safe when the
current task is referenced.  Fix this by removing the task_struct
argument to the hook, requiring LSM implementations to use the
current task.  While we are changing the hook declaration we also
rename the function to security_current_getsecid_subj() in an effort
to reinforce that the hook captures the subjective credentials of the
current task and not an arbitrary task on the system.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hook_defs.h         |    3 +--
 include/linux/lsm_hooks.h             |    8 +++-----
 include/linux/security.h              |    4 ++--
 kernel/audit.c                        |    4 ++--
 kernel/auditfilter.c                  |    3 +--
 kernel/auditsc.c                      |   10 +++++++++-
 net/netlabel/netlabel_unlabeled.c     |    2 +-
 net/netlabel/netlabel_user.h          |    2 +-
 security/apparmor/lsm.c               |   13 ++++++++++---
 security/integrity/ima/ima_appraise.c |    2 +-
 security/integrity/ima/ima_main.c     |   14 +++++++-------
 security/security.c                   |    6 +++---
 security/selinux/hooks.c              |   19 +++----------------
 security/smack/smack.h                |   16 ----------------
 security/smack/smack_lsm.c            |    9 ++++-----
 15 files changed, 48 insertions(+), 67 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2adeea44c0d5..8d04b18155a3 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -205,8 +205,7 @@ LSM_HOOK(int, 0, task_fix_setgid, struct cred *new, const struct cred * old,
 LSM_HOOK(int, 0, task_setpgid, struct task_struct *p, pid_t pgid)
 LSM_HOOK(int, 0, task_getpgid, struct task_struct *p)
 LSM_HOOK(int, 0, task_getsid, struct task_struct *p)
-LSM_HOOK(void, LSM_RET_VOID, task_getsecid_subj,
-	 struct task_struct *p, u32 *secid)
+LSM_HOOK(void, LSM_RET_VOID, current_getsecid_subj, u32 *secid)
 LSM_HOOK(void, LSM_RET_VOID, task_getsecid_obj,
 	 struct task_struct *p, u32 *secid)
 LSM_HOOK(int, 0, task_setnice, struct task_struct *p, int nice)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c4c5c0602cb..9f5b93011ecb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -716,11 +716,9 @@
  *	@p.
  *	@p contains the task_struct for the process.
  *	Return 0 if permission is granted.
- * @task_getsecid_subj:
- *	Retrieve the subjective security identifier of the task_struct in @p
- *	and return it in @secid.  Special care must be taken to ensure that @p
- *	is the either the "current" task, or the caller has exclusive access
- *	to @p.
+ * @current_getsecid_subj:
+ *	Retrieve the subjective security identifier of the current task and
+ *	return it in @secid.
  *	In case of failure, @secid will be set to zero.
  * @task_getsecid_obj:
  *	Retrieve the objective security identifier of the task_struct in @p
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b7288521300..24190cf61858 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -417,7 +417,7 @@ int security_task_fix_setgid(struct cred *new, const struct cred *old,
 int security_task_setpgid(struct task_struct *p, pid_t pgid);
 int security_task_getpgid(struct task_struct *p);
 int security_task_getsid(struct task_struct *p);
-void security_task_getsecid_subj(struct task_struct *p, u32 *secid);
+void security_current_getsecid_subj(u32 *secid);
 void security_task_getsecid_obj(struct task_struct *p, u32 *secid);
 int security_task_setnice(struct task_struct *p, int nice);
 int security_task_setioprio(struct task_struct *p, int ioprio);
@@ -1112,7 +1112,7 @@ static inline int security_task_getsid(struct task_struct *p)
 	return 0;
 }
 
-static inline void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
+static inline void security_current_getsecid_subj(u32 *secid)
 {
 	*secid = 0;
 }
diff --git a/kernel/audit.c b/kernel/audit.c
index 121d37e700a6..d4084751cfe6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2132,7 +2132,7 @@ int audit_log_task_context(struct audit_buffer *ab)
 	int error;
 	u32 sid;
 
-	security_task_getsecid_subj(current, &sid);
+	security_current_getsecid_subj(&sid);
 	if (!sid)
 		return 0;
 
@@ -2353,7 +2353,7 @@ int audit_signal_info(int sig, struct task_struct *t)
 			audit_sig_uid = auid;
 		else
 			audit_sig_uid = uid;
-		security_task_getsecid_subj(current, &audit_sig_sid);
+		security_current_getsecid_subj(&audit_sig_sid);
 	}
 
 	return audit_signal_info_syscall(t);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index db2c6b59dfc3..f4ebd2f1cfca 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1359,8 +1359,7 @@ int audit_filter(int msgtype, unsigned int listtype)
 			case AUDIT_SUBJ_SEN:
 			case AUDIT_SUBJ_CLR:
 				if (f->lsm_rule) {
-					security_task_getsecid_subj(current,
-								    &sid);
+					security_current_getsecid_subj(&sid);
 					result = security_audit_rule_match(sid,
 						   f->type, f->op, f->lsm_rule);
 				}
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dd73a64f921..e0987ee71b8f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -673,7 +673,15 @@ static int audit_filter_rules(struct task_struct *tsk,
 			   logged upon error */
 			if (f->lsm_rule) {
 				if (need_sid) {
-					security_task_getsecid_subj(tsk, &sid);
+					/* @tsk should always be equal to
+					 * @current with the exception of
+					 * fork()/copy_process() in which case
+					 * the new @tsk creds are still a dup
+					 * of @current's creds so we can still
+					 * use security_current_getsecid_subj()
+					 * here even though it always refs
+					 * @current's creds */
+					security_current_getsecid_subj(&sid);
 					need_sid = 0;
 				}
 				result = security_audit_rule_match(sid, f->type,
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 566ba4397ee4..8490e46359ae 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -1537,7 +1537,7 @@ int __init netlbl_unlabel_defconf(void)
 	/* Only the kernel is allowed to call this function and the only time
 	 * it is called is at bootup before the audit subsystem is reporting
 	 * messages so don't worry to much about these values. */
-	security_task_getsecid_subj(current, &audit_info.secid);
+	security_current_getsecid_subj(&audit_info.secid);
 	audit_info.loginuid = GLOBAL_ROOT_UID;
 	audit_info.sessionid = 0;
 
diff --git a/net/netlabel/netlabel_user.h b/net/netlabel/netlabel_user.h
index 6190cbf94bf0..d6c5b31eb4eb 100644
--- a/net/netlabel/netlabel_user.h
+++ b/net/netlabel/netlabel_user.h
@@ -32,7 +32,7 @@
  */
 static inline void netlbl_netlink_auditinfo(struct netlbl_audit *audit_info)
 {
-	security_task_getsecid_subj(current, &audit_info->secid);
+	security_current_getsecid_subj(&audit_info->secid);
 	audit_info->loginuid = audit_get_loginuid(current);
 	audit_info->sessionid = audit_get_sessionid(current);
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f72406fe1bf2..fc21190c4f4f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -728,7 +728,14 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
+static void apparmor_current_getsecid_subj(u32 *secid)
+{
+	struct aa_label *label = aa_get_task_label(current);
+	*secid = label->secid;
+	aa_put_label(label);
+}
+
+static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
 	struct aa_label *label = aa_get_task_label(p);
 	*secid = label->secid;
@@ -1252,8 +1259,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
-	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
+	LSM_HOOK_INIT(current_getsecid_subj, apparmor_current_getsecid_subj),
+	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index dbba51583e7c..17232bbfb9f9 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -76,7 +76,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
 	if (!ima_appraise)
 		return 0;
 
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	return ima_match_policy(mnt_userns, inode, current_cred(), secid,
 				func, mask, IMA_APPRAISE | IMA_HASH, NULL,
 				NULL, NULL, NULL);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 465865412100..8c6e4514d494 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -408,7 +408,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	u32 secid;
 
 	if (file && (prot & PROT_EXEC)) {
-		security_task_getsecid_subj(current, &secid);
+		security_current_getsecid_subj(&secid);
 		return process_measurement(file, current_cred(), secid, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
 	}
@@ -446,7 +446,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(file_mnt_user_ns(vma->vm_file), inode,
 				current_cred(), secid, MAY_EXEC, MMAP_CHECK,
@@ -487,7 +487,7 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	int ret;
 	u32 secid;
 
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
 				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
@@ -512,7 +512,7 @@ int ima_file_check(struct file *file, int mask)
 {
 	u32 secid;
 
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
 					   MAY_APPEND), FILE_CHECK);
@@ -709,7 +709,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 
 	/* Read entire file for all partial reads. */
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	return process_measurement(file, current_cred(), secid, NULL,
 				   0, MAY_READ, func);
 }
@@ -752,7 +752,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	}
 
 	func = read_idmap[read_id] ?: FILE_CHECK;
-	security_task_getsecid_subj(current, &secid);
+	security_current_getsecid_subj(&secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
 				   MAY_READ, func);
 }
@@ -905,7 +905,7 @@ int process_buffer_measurement(struct user_namespace *mnt_userns,
 	 * buffer measurements.
 	 */
 	if (func) {
-		security_task_getsecid_subj(current, &secid);
+		security_current_getsecid_subj(&secid);
 		action = ima_get_action(mnt_userns, inode, current_cred(),
 					secid, 0, func, &pcr, &template,
 					func_data, NULL);
diff --git a/security/security.c b/security/security.c
index 9ffa9e9c5c55..827bd161f8b0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1807,12 +1807,12 @@ int security_task_getsid(struct task_struct *p)
 	return call_int_hook(task_getsid, 0, p);
 }
 
-void security_task_getsecid_subj(struct task_struct *p, u32 *secid)
+void security_current_getsecid_subj(u32 *secid)
 {
 	*secid = 0;
-	call_void_hook(task_getsecid_subj, p, secid);
+	call_void_hook(current_getsecid_subj, secid);
 }
-EXPORT_SYMBOL(security_task_getsecid_subj);
+EXPORT_SYMBOL(security_current_getsecid_subj);
 
 void security_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index e7ebd45ca345..5c766b901f66 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -229,19 +229,6 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
-/*
- * get the subjective security ID of a task
- */
-static inline u32 task_sid_subj(const struct task_struct *task)
-{
-	u32 sid;
-
-	rcu_read_lock();
-	sid = cred_sid(rcu_dereference(task->cred));
-	rcu_read_unlock();
-	return sid;
-}
-
 /*
  * get the objective security ID of a task
  */
@@ -4222,9 +4209,9 @@ static int selinux_task_getsid(struct task_struct *p)
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_task_getsecid_subj(struct task_struct *p, u32 *secid)
+static void selinux_current_getsecid_subj(u32 *secid)
 {
-	*secid = task_sid_subj(p);
+	*secid = current_sid();
 }
 
 static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
@@ -7221,7 +7208,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid_subj),
+	LSM_HOOK_INIT(current_getsecid_subj, selinux_current_getsecid_subj),
 	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c3422596ab..fc837dcebf96 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -389,22 +389,6 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
 	return tsp->smk_task;
 }
 
-static inline struct smack_known *smk_of_task_struct_subj(
-						const struct task_struct *t)
-{
-	struct smack_known *skp;
-	const struct cred *cred;
-
-	rcu_read_lock();
-
-	cred = rcu_dereference(t->cred);
-	skp = smk_of_task(smack_cred(cred));
-
-	rcu_read_unlock();
-
-	return skp;
-}
-
 static inline struct smack_known *smk_of_task_struct_obj(
 						const struct task_struct *t)
 {
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 21a0e7c3b8de..40e1d764e616 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2061,15 +2061,14 @@ static int smack_task_getsid(struct task_struct *p)
 }
 
 /**
- * smack_task_getsecid_subj - get the subjective secid of the task
- * @p: the task
+ * smack_current_getsecid_subj - get the subjective secid of the current task
  * @secid: where to put the result
  *
  * Sets the secid to contain a u32 version of the task's subjective smack label.
  */
-static void smack_task_getsecid_subj(struct task_struct *p, u32 *secid)
+static void smack_current_getsecid_subj(u32 *secid)
 {
-	struct smack_known *skp = smk_of_task_struct_subj(p);
+	struct smack_known *skp = smk_of_current();
 
 	*secid = skp->smk_secid;
 }
@@ -4756,7 +4755,7 @@ static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, smack_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, smack_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, smack_task_getsid),
-	LSM_HOOK_INIT(task_getsecid_subj, smack_task_getsecid_subj),
+	LSM_HOOK_INIT(current_getsecid_subj, smack_current_getsecid_subj),
 	LSM_HOOK_INIT(task_getsecid_obj, smack_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setnice, smack_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, smack_task_setioprio),

