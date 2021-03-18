Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95753C4332E
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9164F3B
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 20:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhCRUmi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhCRUmc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 16:42:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BBFC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:42:31 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g8so3953013qvx.1
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 13:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tBNS9rivP7Xv1VpsrX/MYeb12WoZu7yJMD0Mcu5oDSw=;
        b=EAI6gUOBQc1tRdQ1pn8vA8wAIBOfTlk3JwZuWWUq8TeXGJ1Us+lHXzTMy8H2udFooK
         48+MnCObObJ9LOmtUZuu1JnSHMDjTQQC5KfCTLsfOP7bTaldvA09QhH/CdszMXMKw8p3
         PpYgf82J77GHqwoBE0cumboBwrRIo7TBTv/gB+5/F5mvAh0ddCS4L//USQQ5y+cWrAuV
         Yrb0mQD29jeBEDf9OagLhje1gLZYfluaQjQPSmMe45+uShO7IK2mopNIwtmwsVIr5u/H
         b6m74GPz5a3+Qi4VNsaQNeUclbGibp/wRBm+jFWVbRlgRWWsV2ESYmMSG2vt+t+V9NFe
         iCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tBNS9rivP7Xv1VpsrX/MYeb12WoZu7yJMD0Mcu5oDSw=;
        b=b+8ylfwxaWK8UqeOF1JbMsOMGfLoOphXyGAhE6licqiGOzebONUMIyFW0DTIWYqap0
         JoaHlXewiGtEvRHgdphMAHQU0DNwNldx6W0Yz+1+31oT4nKqJqFUU1Fv8lEBNZu1n94O
         UhC/4krLa7NbQowXYUI28W4nkIPo9OXSAYbAAyxwJmIs4cipAX+TK7gxEJzB8G4pUnkS
         OM8zMLa9C1jzclBUe1mCV5gjM/pxCKZRzacuoRdj8VW0LN2LGUFGnU/+jcIX3p4YTodG
         zYYZVX3DGKT53R+EoCtdtbpvJocnMv/pCnOktgTjymSv1KlwU4cn30Rgl5AScSL/0hM/
         VnTg==
X-Gm-Message-State: AOAM533edPgxm/1TNea8CFNxnlghxp5qed7OGTw7AEFu1z24GN5vB5Tn
        0yMhHH/hXMKMIjCYF4ryZaxx
X-Google-Smtp-Source: ABdhPJwtZ/2y9zGKSjRyb/5w9R0SydixhwTvpA2Urk0sU5glXyXEH9TaU4UPesTuJ14QReVYix9N0Q==
X-Received: by 2002:ad4:510d:: with SMTP id g13mr6357990qvp.3.1616100150924;
        Thu, 18 Mar 2021 13:42:30 -0700 (PDT)
Received: from localhost (pool-72-74-249-41.bstnma.fios.verizon.net. [72.74.249.41])
        by smtp.gmail.com with ESMTPSA id u11sm2124350qta.91.2021.03.18.13.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:42:30 -0700 (PDT)
Subject: [PATCH v2 2/3] selinux: clarify task subjective and objective
 credentials
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        selinux@vger.kernel.org
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Richard Guy Briggs <rgb@redhat.com>
Date:   Thu, 18 Mar 2021 16:42:29 -0400
Message-ID: <161610014979.55424.673449459081578214.stgit@olly>
In-Reply-To: <161609713992.55424.6906498317563652734.stgit@olly>
References: <161609713992.55424.6906498317563652734.stgit@olly>
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

This patch also adds an interesting function in task_sid_binder().
The task_sid_binder() function has a comment which hopefully
describes it's reason for being, but it basically boils down to the
simple fact that we can't safely access another task's subjective
credentials so in the case of binder we need to stick with the
objective credentials regardless.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |  112 ++++++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 39 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 24ca545c6e1b..901a3ce453f1 100644
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
 
@@ -242,6 +255,29 @@ static inline u32 task_sid(const struct task_struct *task)
 	return sid;
 }
 
+/*
+ * get the security ID of a task for use with binder
+ */
+static inline u32 task_sid_binder(const struct task_struct *task)
+{
+	/*
+	 * In many case where this function is used we should be using the
+	 * task's subjective SID, but we can't reliably access the subjective
+	 * creds of a task other than our own so we must use the objective
+	 * creds/SID, which are safe to access.  The downside is that if a task
+	 * is temporarily overriding it's creds it will not be reflected here;
+	 * however, it isn't clear that binder would handle that case well
+	 * anyway.
+	 *
+	 * If this ever changes and we can safely reference the subjective
+	 * creds/SID of another task, this function will make it easier to
+	 * identify the various places where we make use of the task SIDs in
+	 * the binder code.  It is also likely that we will need to adjust
+	 * the main drivers/android binder code as well.
+	 */
+	return task_sid_obj(task);
+}
+
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
 
 /*
@@ -2035,11 +2071,8 @@ static inline u32 open_file_to_av(struct file *file)
 
 static int selinux_binder_set_context_mgr(struct task_struct *mgr)
 {
-	u32 mysid = current_sid();
-	u32 mgrsid = task_sid(mgr);
-
 	return avc_has_perm(&selinux_state,
-			    mysid, mgrsid, SECCLASS_BINDER,
+			    current_sid(), task_sid_binder(mgr), SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
 }
 
@@ -2047,8 +2080,7 @@ static int selinux_binder_transaction(struct task_struct *from,
 				      struct task_struct *to)
 {
 	u32 mysid = current_sid();
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
+	u32 fromsid = task_sid_binder(from);
 	int rc;
 
 	if (mysid != fromsid) {
@@ -2059,19 +2091,16 @@ static int selinux_binder_transaction(struct task_struct *from,
 			return rc;
 	}
 
-	return avc_has_perm(&selinux_state,
-			    fromsid, tosid, SECCLASS_BINDER, BINDER__CALL,
-			    NULL);
+	return avc_has_perm(&selinux_state, fromsid, task_sid_binder(to),
+			    SECCLASS_BINDER, BINDER__CALL, NULL);
 }
 
 static int selinux_binder_transfer_binder(struct task_struct *from,
 					  struct task_struct *to)
 {
-	u32 fromsid = task_sid(from);
-	u32 tosid = task_sid(to);
-
 	return avc_has_perm(&selinux_state,
-			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
+			    task_sid_binder(from), task_sid_binder(to),
+			    SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
 }
 
@@ -2079,7 +2108,7 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 					struct task_struct *to,
 					struct file *file)
 {
-	u32 sid = task_sid(to);
+	u32 sid = task_sid_binder(to);
 	struct file_security_struct *fsec = selinux_file(file);
 	struct dentry *dentry = file->f_path.dentry;
 	struct inode_security_struct *isec;
@@ -2115,10 +2144,10 @@ static int selinux_binder_transfer_file(struct task_struct *from,
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
@@ -2131,15 +2160,15 @@ static int selinux_ptrace_access_check(struct task_struct *child,
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
 
@@ -2264,7 +2293,7 @@ static u32 ptrace_parent_sid(void)
 	rcu_read_lock();
 	tracer = ptrace_parent(current);
 	if (tracer)
-		sid = task_sid(tracer);
+		sid = task_sid_obj(tracer);
 	rcu_read_unlock();
 
 	return sid;
@@ -3921,7 +3950,7 @@ static int selinux_file_send_sigiotask(struct task_struct *tsk,
 				       struct fown_struct *fown, int signum)
 {
 	struct file *file;
-	u32 sid = task_sid(tsk);
+	u32 sid = task_sid_obj(tsk);
 	u32 perm;
 	struct file_security_struct *fsec;
 
@@ -4140,47 +4169,52 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
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
 
@@ -4211,7 +4245,7 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
 	   upon context transitions.  See selinux_bprm_committing_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
 		return avc_has_perm(&selinux_state,
-				    current_sid(), task_sid(p),
+				    current_sid(), task_sid_obj(p),
 				    SECCLASS_PROCESS, PROCESS__SETRLIMIT, NULL);
 
 	return 0;
@@ -4220,21 +4254,21 @@ static int selinux_task_setrlimit(struct task_struct *p, unsigned int resource,
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
 
@@ -4253,14 +4287,14 @@ static int selinux_task_kill(struct task_struct *p, struct kernel_siginfo *info,
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
@@ -6153,7 +6187,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
 	struct ipc_security_struct *isec;
 	struct msg_security_struct *msec;
 	struct common_audit_data ad;
-	u32 sid = task_sid(target);
+	u32 sid = task_sid_subj(target);
 	int rc;
 
 	isec = selinux_ipc(msq);
@@ -7149,8 +7183,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
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

