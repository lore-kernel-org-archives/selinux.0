Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96457C433E6
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6414F64EAF
	for <selinux@archiver.kernel.org>; Fri, 19 Feb 2021 23:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSXaX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Feb 2021 18:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBSXaW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Feb 2021 18:30:22 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4168C0617A7
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:25 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 81so7285501qkf.4
        for <selinux@vger.kernel.org>; Fri, 19 Feb 2021 15:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=E8JBjLM+VrYyjykM174pAPWmD9tkjj7saJUnrbSTTIQ=;
        b=NGobJwWTh8zbH5rAkWvWVRcqEw3b+YYNJVeKTjUrXmga+QJLtmFGS/0mt/JvFLVNVD
         r/NWrI6X2OKwjMYBU0Xks39ATK+OEhEV1eYn14DTWORAJSquOMt4uN0b8PREAEWNBDRb
         AgdOwDLTdu1wI/u3YyZ8YOxw1kZnrvnDQtw5sRZyzs78RT0IDfeAr0iabQJp/uOpXG/K
         BzqliD5yEqHmKOCitwMex1wXdTp3Mzy7BkuuZ5GEiwWQd9Z2I6ASGQusWv6e4ELuifXw
         oR+QUMRLLaHGmskPbHZMER5DWKWFu96OHMPie09v8y062ahEiJaFnOUkd1hn/wqFLW+G
         HFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=E8JBjLM+VrYyjykM174pAPWmD9tkjj7saJUnrbSTTIQ=;
        b=MSDt0a01lQRavKQUnNplSHuNxj7IZ/27gbNkMiLTTf5yS8cnxasCSvW5RxD87n0h70
         oCOi7dDnlWDck6tH+XugRM8zEUE7sD9OrmsuAK0QpEhQLpiLpeVroa0SkjOA1MF+SSWa
         2Mu5zc4wscZZvgGlhG7a9a+hwZqVdR34kJQAh4qkDPShOJ6UDr7Ed2cuV6GMTQiL0fKm
         7xSyp4N9N9QfDBD+YupCxnz0XD74ihnIkC2LmRa/sV7EH8OCxoTPQ3XSo/+NKu1pCPHK
         tO2SZP7+pMpWwF67HS72Th85t528/LJXy8hW6pmps23b89soSNmSfyHXMgY8SQ8VHLW5
         sQ1w==
X-Gm-Message-State: AOAM532QD2GSOozcnMQhFu1aTJmUowp3QEw3ti8FTOT0x3aeYPBfVLtF
        V9SqkZNJhcGDUA1PpeNYkjusHEnGqUZFlXw=
X-Google-Smtp-Source: ABdhPJxoRGMhZL78hlgpeoNTGZ7eVPG9JEN4WQFHSand8x2oz5IGs23RnAOoMBSQwfB/dM2aIvOuKQ==
X-Received: by 2002:ae9:e915:: with SMTP id x21mr11772911qkf.311.1613777364889;
        Fri, 19 Feb 2021 15:29:24 -0800 (PST)
Received: from localhost ([151.203.60.33])
        by smtp.gmail.com with ESMTPSA id z139sm7433814qkb.0.2021.02.19.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 15:29:24 -0800 (PST)
Subject: [RFC PATCH 4/4] apparmor: differentiate between subjective and
 objective task credentials
From:   Paul Moore <paul@paul-moore.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Date:   Fri, 19 Feb 2021 18:29:23 -0500
Message-ID: <161377736385.87807.7033400948278183233.stgit@sifl>
In-Reply-To: <161377712068.87807.12246856567527156637.stgit@sifl>
References: <161377712068.87807.12246856567527156637.stgit@sifl>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the split of the security_task_getsecid() into subjective and
objective variants it's time to update AppArmor to ensure it is
using the correct task creds.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/domain.c       |    2 +-
 security/apparmor/include/cred.h |   19 ++++++++++++++++---
 security/apparmor/include/task.h |    3 ++-
 security/apparmor/lsm.c          |   23 +++++++++++++++--------
 security/apparmor/task.c         |   23 ++++++++++++++++++++---
 5 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f919ebd042fd2..9ed00b8dcdf0c 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -67,7 +67,7 @@ static int may_change_ptraced_domain(struct aa_label *to_label,
 	tracer = ptrace_parent(current);
 	if (tracer)
 		/* released below */
-		tracerl = aa_get_task_label(tracer);
+		tracerl = aa_get_task_label_subj(tracer);
 
 	/* not ptraced */
 	if (!tracer || unconfined(tracerl))
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index 0b9ae4804ef73..43c21ef5568ab 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -64,14 +64,27 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
 }
 
 /**
- * __aa_task_raw_label - retrieve another task's label
+ * __aa_task_raw_label_subj - retrieve another task's subjective label
  * @task: task to query  (NOT NULL)
  *
- * Returns: @task's label without incrementing its ref count
+ * Returns: @task's subjective label without incrementing its ref count
  *
  * If @task != current needs to be called in RCU safe critical section
  */
-static inline struct aa_label *__aa_task_raw_label(struct task_struct *task)
+static inline struct aa_label *__aa_task_raw_label_subj(struct task_struct *task)
+{
+	return aa_cred_raw_label(rcu_dereference(task->cred));
+}
+
+/**
+ * __aa_task_raw_label_obj - retrieve another task's objective label
+ * @task: task to query  (NOT NULL)
+ *
+ * Returns: @task's objective label without incrementing its ref count
+ *
+ * If @task != current needs to be called in RCU safe critical section
+ */
+static inline struct aa_label *__aa_task_raw_label_obj(struct task_struct *task)
 {
 	return aa_cred_raw_label(__task_cred(task));
 }
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index f13d12373b25e..27a2961558555 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -33,7 +33,8 @@ int aa_replace_current_label(struct aa_label *label);
 int aa_set_current_onexec(struct aa_label *label, bool stack);
 int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
-struct aa_label *aa_get_task_label(struct task_struct *task);
+struct aa_label *aa_get_task_label_subj(struct task_struct *task);
+struct aa_label *aa_get_task_label_obj(struct task_struct *task);
 
 /**
  * aa_free_task_ctx - free a task_ctx
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 15e37b9132679..38430851675b9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -119,7 +119,7 @@ static int apparmor_ptrace_access_check(struct task_struct *child,
 	int error;
 
 	tracer = __begin_current_label_crit_section();
-	tracee = aa_get_task_label(child);
+	tracee = aa_get_task_label_obj(child);
 	error = aa_may_ptrace(tracer, tracee,
 			(mode & PTRACE_MODE_READ) ? AA_PTRACE_READ
 						  : AA_PTRACE_TRACE);
@@ -135,7 +135,7 @@ static int apparmor_ptrace_traceme(struct task_struct *parent)
 	int error;
 
 	tracee = __begin_current_label_crit_section();
-	tracer = aa_get_task_label(parent);
+	tracer = aa_get_task_label_subj(parent);
 	error = aa_may_ptrace(tracer, tracee, AA_PTRACE_TRACE);
 	aa_put_label(tracer);
 	__end_current_label_crit_section(tracee);
@@ -719,9 +719,16 @@ static void apparmor_bprm_committed_creds(struct linux_binprm *bprm)
 	return;
 }
 
-static void apparmor_task_getsecid(struct task_struct *p, u32 *secid)
+static void apparmor_task_getsecid_subj(struct task_struct *p, u32 *secid)
 {
-	struct aa_label *label = aa_get_task_label(p);
+	struct aa_label *label = aa_get_task_label_subj(p);
+	*secid = label->secid;
+	aa_put_label(label);
+}
+
+static void apparmor_task_getsecid_obj(struct task_struct *p, u32 *secid)
+{
+	struct aa_label *label = aa_get_task_label_obj(p);
 	*secid = label->secid;
 	aa_put_label(label);
 }
@@ -750,7 +757,7 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 		 * Dealing with USB IO specific behavior
 		 */
 		cl = aa_get_newest_cred_label(cred);
-		tl = aa_get_task_label(target);
+		tl = aa_get_task_label_obj(target);
 		error = aa_may_signal(cl, tl, sig);
 		aa_put_label(cl);
 		aa_put_label(tl);
@@ -758,7 +765,7 @@ static int apparmor_task_kill(struct task_struct *target, struct kernel_siginfo
 	}
 
 	cl = __begin_current_label_crit_section();
-	tl = aa_get_task_label(target);
+	tl = aa_get_task_label_obj(target);
 	error = aa_may_signal(cl, tl, sig);
 	aa_put_label(tl);
 	__end_current_label_crit_section(cl);
@@ -1243,8 +1250,8 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 
 	LSM_HOOK_INIT(task_free, apparmor_task_free),
 	LSM_HOOK_INIT(task_alloc, apparmor_task_alloc),
-	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid),
-	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid),
+	LSM_HOOK_INIT(task_getsecid_subj, apparmor_task_getsecid_subj),
+	LSM_HOOK_INIT(task_getsecid_obj, apparmor_task_getsecid_obj),
 	LSM_HOOK_INIT(task_setrlimit, apparmor_task_setrlimit),
 	LSM_HOOK_INIT(task_kill, apparmor_task_kill),
 
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index d17130ee6795d..c03c8e3928055 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -16,17 +16,34 @@
 #include "include/task.h"
 
 /**
- * aa_get_task_label - Get another task's label
+ * aa_get_task_label_subj - Get another task's subjective label
  * @task: task to query  (NOT NULL)
  *
  * Returns: counted reference to @task's label
  */
-struct aa_label *aa_get_task_label(struct task_struct *task)
+struct aa_label *aa_get_task_label_subj(struct task_struct *task)
 {
 	struct aa_label *p;
 
 	rcu_read_lock();
-	p = aa_get_newest_label(__aa_task_raw_label(task));
+	p = aa_get_newest_label(__aa_task_raw_label_subj(task));
+	rcu_read_unlock();
+
+	return p;
+}
+
+/**
+ * aa_get_task_label_obj - Get another task's objective label
+ * @task: task to query  (NOT NULL)
+ *
+ * Returns: counted reference to @task's label
+ */
+struct aa_label *aa_get_task_label_obj(struct task_struct *task)
+{
+	struct aa_label *p;
+
+	rcu_read_lock();
+	p = aa_get_newest_label(__aa_task_raw_label_obj(task));
 	rcu_read_unlock();
 
 	return p;

