Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7016C43381
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778D264EB2
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBSXaA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 18:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhBSX37 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 18:29:59 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB35C06178C
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:13 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id e9so3469343qvy.3
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=v6NSQC50KFmeUPKJBeoKhuyWn2xCwILBIvdMD1P82gw=;
        b=VzhVA5AagbGb4kOzVU0A3fAW6AKt1nNLkKnm4Km6f8mSv7Oxuw4ndZIK/T4xWPryP8
         9Ryrcmvbsa7hYWeaemUYG8nkOMC8reOZh0DFnmraA42MPUWYAh54EO2LVByif03vdzz9
         xVplzgAqTSsQZg2s5ivvH9MVXoAk3TQb6+a19oHPa4CFzh0hdlzgKwCYJkFa8pVLDFan
         xLzKA2CP7jylaANxYgOl+LugiqiX56JKJT8fsFxWE6SeUs0cvS6wGAithuDdRlhfhSFK
         E/X4nuagHwfZmoTzboKeTudObWB0+M4gupNcSrVQK4yj/bP4aUj71u7w+vq3IM7LKxfI
         RkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=v6NSQC50KFmeUPKJBeoKhuyWn2xCwILBIvdMD1P82gw=;
        b=XxVWYIGQhIuPVb87KDc5+UmzfSx8Xqqjm0zn2EAfVOKVWmjwJK9h8lubqzaxkYpmDf
         rCE4s6pva4ShueEcxMleyCifTnj06+WxJgFwQQf4Em37tgcDewz2UPPQUVA5oTwCrKxM
         D2S87Kq7yEXvSRhkxnQaMGjP6dqkhNzPhb7fdIvBAADHtJf33bqyR088ypYOhpx+jsHz
         RleFShQSstrqffqCy57qYzL9Hpe2DUwE+Ctoj/G3PZDMIV5PeU5g8F6/1sebeq5FvicI
         y2R1MXZFxMN3mXXAyi7GsASs/Ju24Rzkog4BXqUX66Hp2nANeqaPfU4Dgx0YcGwdr2Aa
         qV9g==
X-Gm-Message-State: AOAM533M+MF7olcxwrdZxJ+MKzXiKyz44pTc5M8wKYtjOwwSBENFttqM
        E0BcvNTHCjl9DjENNSjsUEtu
X-Google-Smtp-Source: ABdhPJzzBiMLcwtjpEsmxAq4hBzGFFfdNi8YiGlaj+SswkJ1hiKCM0HUDXQrbiSvSmP1pRdk/xjkdA==
X-Received: by 2002:a0c:ee89:: with SMTP id u9mr11509948qvr.40.1613777352635;
        Fri, 19 Feb 2021 15:29:12 -0800 (PST)
Received: from localhost ([151.203.60.33])
        by smtp.gmail.com with ESMTPSA id w139sm1572331qka.19.2021.02.19.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:29:12 -0800 (PST)
Subject: [RFC PATCH 2/4] selinux: clarify task subjective and objective
 credentials
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Fri, 19 Feb 2021 18:29:11 -0500
Message-ID: <161377735153.87807.7492842242100187888.stgit@sifl>
In-Reply-To: <161377712068.87807.12246856567527156637.stgit@sifl>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

SELinux has a function, task_sid(), which returns the task's
objective credentials, but unfortunately is used in a few places
where the subjective task credentials should be used.  Most notably
in the new security_task_getsecid_subj() LSM hook.

This patch fixes this and attempts to make things more obvious by
introducing a new function, task_sid_subj(), and renaming the
existing task_sid() function to task_sid_obj().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   85 +++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f311541c4972e..1c53000d28e37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -229,10 +229,23 @@ static inline u32 cred_sid(const struct cred *cred)
 	return tsec->sid;
 }
 
+/*
+ * get the subjective security ID of a task
+ */
+static inline u32 task_sid_subj(const struct task_struct *task)
+{
+	u32 sid;
+
+	rcu_read_lock();
+	sid = cred_sid(rcu_dereference(task->cred));
+	rcu_read_unlock();
+	return sid;
+}
+
 /*
  * get the objective security ID of a task
  */
-static inline u32 task_sid(const struct task_struct *task)
+static inline u32 task_sid_obj(const struct task_struct *task)
 {
 	u32 sid;
 
@@ -2034,11 +2047,8 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(struct task_struct *mgr)
 {
-	u32 mysid = current_sid();
-	u32 mgrsid = task_sid(mgr);
-
 	return avc_has_perm(&selinux_state,
-			    mysid, mgrsid, SECCLASS_BINDER,
+			    current_sid(), task_sid_obj(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
 
@@ -2046,8 +2056,8 @@ static int selinux_binder_transaction(struct task_struct *from,
 				      struct task_struct *to)
 {
 	u32 mysid = current_sid();
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
+	u32 fromsid = task_sid_subj(from);
+	u32 tosid = task_sid_subj(to);
 	int rc;
 
 	if (mysid != fromsid) {
@@ -2066,11 +2076,9 @@ static int selinux_binder_transaction(struct task_struct *from,
 static int selinux_binder_transfer_binder(struct task_struct *from,
 					  struct task_struct *to)
 {
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
-
 	return avc_has_perm(&selinux_state,
-			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+			    task_sid_subj(from), task_sid_obj(to),
+			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
 }
 
@@ -2078,7 +2086,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct task_struct *to,
 					struct file *file)
 {
-	u32 sid = task_sid(to);
+	u32 sid = task_sid_subj(to);
 	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
@@ -2114,10 +2122,10 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 }
 
 static int selinux_ptrace_access_check(struct task_struct *child,
-				     unsigned int mode)
+				       unsigned int mode)
 {
 	u32 sid = current_sid();
-	u32 csid = task_sid(child);
+	u32 csid = task_sid_obj(child);
 
 	if (mode & PTRACE_MODE_READ)
 		return avc_has_perm(&selinux_state,
@@ -2130,15 +2138,15 @@ static int selinux_ptrace_access_check(struct task_struct *child,
 static int selinux_ptrace_traceme(struct task_struct *parent)
 {
 	return avc_has_perm(&selinux_state,
-			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
-			    PROCESS__PTRACE, NULL);
+			    task_sid_subj(parent), task_sid_obj(current),
+			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(target), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(target), SECCLASS_PROCESS,
 			    PROCESS__GETCAP, NULL);
 }
 
@@ -2263,7 +2271,7 @@ static u32 ptrace_parent_sid(void)
 	rcu_read_lock();
 	tracer = ptrace_parent(current);
 	if (tracer)
-		sid = task_sid(tracer);
+		sid = task_sid_obj(tracer);
 	rcu_read_unlock();
 
 	return sid;
@@ -3916,7 +3924,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 				       struct fown_struct *fown, int signum)
 {
 	struct file *file;
-	u32 sid = task_sid(tsk);
+	u32 sid = task_sid_obj(tsk);
 	u32 perm;
 	struct file_security_struct *fsec;
 
@@ -4135,47 +4143,52 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETPGID, NULL);
 }
 
 static int selinux_task_getpgid(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETPGID, NULL);
 }
 
 static int selinux_task_getsid(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSESSION, NULL);
 }
 
-static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
+static void selinux_task_getsecid_subj(struct task_struct *p, u32 *secid)
+{
+	*secid = task_sid_subj(p);
+}
+
+static void selinux_task_getsecid_obj(struct task_struct *p, u32 *secid)
 {
-	*secid = task_sid(p);
+	*secid = task_sid_obj(p);
 }
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getioprio(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
@@ -4206,7 +4219,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
 		return avc_has_perm(&selinux_state,
-				    current_sid(), task_sid(p),
+				    current_sid(), task_sid_obj(p),
 				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
 	return 0;
@@ -4215,21 +4228,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 static int selinux_task_setscheduler(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__GETSCHED, NULL);
 }
 
 static int selinux_task_movememory(struct task_struct *p)
 {
 	return avc_has_perm(&selinux_state,
-			    current_sid(), task_sid(p), SECCLASS_PROCESS,
+			    current_sid(), task_sid_obj(p), SECCLASS_PROCESS,
 			    PROCESS__SETSCHED, NULL);
 }
 
@@ -4248,14 +4261,14 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 	else
 		secid = cred_sid(cred);
 	return avc_has_perm(&selinux_state,
-			    secid, task_sid(p), SECCLASS_PROCESS, perm, NULL);
+			    secid, task_sid_obj(p), SECCLASS_PROCESS, perm, NULL);
 }
 
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
 	struct inode_security_struct *isec = selinux_inode(inode);
-	u32 sid = task_sid(p);
+	u32 sid = task_sid_obj(p);
 
 	spin_lock(&isec->lock);
 	isec->sclass = inode_mode_to_security_class(inode->i_mode);
@@ -6148,7 +6161,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
-	u32 sid = task_sid(target);
+	u32 sid = task_sid_subj(target);
 	int rc;
 
 	isec = selinux_ipc(msq);
@@ -7143,8 +7156,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
-	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid),
-	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, selinux_task_getsecid_subj),
+	LSM_HOOK_INIT(task_getsecid_obj, selinux_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setnice, selinux_task_setnice),
 	LSM_HOOK_INIT(task_setioprio, selinux_task_setioprio),
 	LSM_HOOK_INIT(task_getioprio, selinux_task_getioprio),

