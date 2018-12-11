Return-Path: <SRS0=YYAz=OU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9104CC67839
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E1120672
	for <selinux@archiver.kernel.org>; Tue, 11 Dec 2018 22:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MTSSMZQi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E1120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLKWoi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:44:38 -0500
Received: from sonic311-28.consmr.mail.ne1.yahoo.com ([66.163.188.209]:44176
        "EHLO sonic311-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbeLKWoH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Dec 2018 17:44:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1544568246; bh=rtgbAY8v8bf2tMWocN4/v1BHGqtzr15pWf8snPHIIn8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MTSSMZQiJGfO2lz3OCDx3mwrFNR7BZFxhpvp6he8a2kehNR4TfXnSpYlv/i0IPXDYhA6A6lD6u1e0lRak6VV+WfKi8g4IWdw+Kemt4CKhE1Cm/T46QClFGDPIlJ56IFYN1VLXTsthzhGh7Y6DQvL2aEj0aOf/n0zJ/zUW3BtwN/DSFlL2O7+wnGGQNjyjcJYtGsiehyjPdoa9QEPk9+Nt/RETB1UNkEeZ57z3j1yS8G1ZrudTHbEV8nHh2OuA3jjgBkBlJ3IaXiS9TlM8xNFASsEJojkSMmA8EAw+1kjMyXpuVqVQhXAf77QrYCEjNkusJtjec58aWutY20/FZuahQ==
X-YMail-OSG: ODv9pKMVM1k5bhJQ17ZasrABywSFB0XI0VLo3BkVWEgONXM1uTRUaQOcwoYL1ys
 WYGcMXnme3BwY41bs7wJUl1gNL3QzRZqR9WhX0sMsUSFwrSnXqOJWq2sWfzvaKHYf2j93xNOpIJJ
 0aVPPtq1fxDRII_KMAHNELdah52lWV2kWJgx.fwH2i.DT0aNaOi1YbG2xEGZOBgKzxJ..EwAXnFw
 qciDWbFR.w6uvp3uKv.Q6QM5p6lsk6h0yj7NLJbObqpmU4AW2WPZzqQDBcBrcHP0T_HGwzivPZh7
 _jnIDELvU70v5R8S1sPfzRLKnUlXjHe2p6XOoGfIwVTsE6UDuHjSGpCOZnLLzAbcybzi_N3fYYzJ
 y.WWloMNNkruxfMCAHuTtQsnj5cCN3XbYGkIwd8VhOjpZXXJdnLwZytDXIteroVEBoahRelyhbaV
 M6d4l4XYQ2wJiL0TSSFtnfAoDDRDxfjTugnwmUM46nJ23c9VplZZQz4DleuSwMQyHEd7b6FOv_WL
 UKSa812SJE50ualiS_YlZmf3_Y93NKWS95J2dXwMjWAIYRUPQNqS7pOs8ijDl_hyBbFy0e0vTddW
 7N_N0Lzx9c10d.P71wbuLl_HCYJhnjgU0mQz_Wite8y95uLktqepGOGi48YZUDN57l9klyCgP0WD
 CpmOHWlRvh6mKRXQ7USwWyITUHUwA4TMViya2.Esepi07cPnidmdVap0os_wtUj5rjdGUYMhHU2N
 y3qyy7F12xOpLwW5TOlIAhCEBxBk4IxVAwz9fvahAm7Jt5oEH0hlgsMHkvE4beB395A.KWtQNM0B
 cTGty3ipS.Qe2w3ZUW35Uuv7WtIS_bqRNfMLYAWU7JwZ.0EDvfWMlheM62fQ6hdUYkI2F3ohW30V
 fdxf.QTWuQsQF6VGwLzj_BBiajmMiJ7nawDwVWlqNfVjaeopr_Y9c3cjx5VXI8tCmoMHaF1hs4AU
 gRpsloZWwlgCZlpfWy9fn00U6OQpia1nrUjUxo8LIhsgRmfwiTxJi0.dQEk1QldET165f6jL4FcD
 IY9DwaOxwGMlTySXvN1uKjR9iaGSiiZVxIpSwO1tUgXBfcZlw3IT_kazF_bx2_PJ8SIcadSzAGLh
 3YHS86.OcyGpWXqRVRQmfcmib6X.MmKElvLj6rNxIpR0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Dec 2018 22:44:06 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6f4a30c5671782919fad3da3c826f035;
          Tue, 11 Dec 2018 22:44:02 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Cc:     john.johansen@canonical.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, sds@tycho.nsa.gov,
        adobriyan@gmail.com, mic@digikod.net, s.mesoraca16@gmail.com,
        casey@schaufler-ca.com
Subject: [PATCH v5 34/38] LSM: Infrastructure management of the task security
Date:   Tue, 11 Dec 2018 14:43:10 -0800
Message-Id: <20181211224314.22412-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20181211224314.22412-1-casey@schaufler-ca.com>
References: <20181211224314.22412-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.
The only user of this blob is AppArmor. The AppArmor use
is abstracted to avoid future conflict.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
[kees: adjusted for ordered init series]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++-----------
 security/apparmor/lsm.c          | 15 +++--------
 security/security.c              | 54 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 65440005ec92..243c7c6e181d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_task;
 };
 
 /*
@@ -2106,6 +2107,7 @@ extern int lsm_inode_alloc(struct inode *inode);
 
 #ifdef CONFIG_SECURITY
 void __init lsm_early_cred(struct cred *cred);
+void __init lsm_early_task(struct task_struct *task);
 #endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/apparmor/include/task.h b/security/apparmor/include/task.h
index 55edaa1d83f8..039c1e60887a 100644
--- a/security/apparmor/include/task.h
+++ b/security/apparmor/include/task.h
@@ -14,7 +14,10 @@
 #ifndef __AA_TASK_H
 #define __AA_TASK_H
 
-#define task_ctx(X) ((X)->security)
+static inline struct aa_task_ctx *task_ctx(struct task_struct *task)
+{
+	return task->security;
+}
 
 /*
  * struct aa_task_ctx - information for current task label change
@@ -36,17 +39,6 @@ int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
 
-/**
- * aa_alloc_task_ctx - allocate a new task_ctx
- * @flags: gfp flags for allocation
- *
- * Returns: allocated buffer or NULL on failure
- */
-static inline struct aa_task_ctx *aa_alloc_task_ctx(gfp_t flags)
-{
-	return kzalloc(sizeof(struct aa_task_ctx), flags);
-}
-
 /**
  * aa_free_task_ctx - free a task_ctx
  * @ctx: task_ctx to free (MAYBE NULL)
@@ -57,8 +49,6 @@ static inline void aa_free_task_ctx(struct aa_task_ctx *ctx)
 		aa_put_label(ctx->nnp);
 		aa_put_label(ctx->previous);
 		aa_put_label(ctx->onexec);
-
-		kzfree(ctx);
 	}
 }
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 3ae8c902d740..83dc23f33a29 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -93,19 +93,14 @@ static void apparmor_task_free(struct task_struct *task)
 {
 
 	aa_free_task_ctx(task_ctx(task));
-	task_ctx(task) = NULL;
 }
 
 static int apparmor_task_alloc(struct task_struct *task,
 			       unsigned long clone_flags)
 {
-	struct aa_task_ctx *new = aa_alloc_task_ctx(GFP_KERNEL);
-
-	if (!new)
-		return -ENOMEM;
+	struct aa_task_ctx *new = task_ctx(task);
 
 	aa_dup_task_ctx(new, task_ctx(current));
-	task_ctx(task) = new;
 
 	return 0;
 }
@@ -1156,6 +1151,7 @@ static int apparmor_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
+	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1486,15 +1482,10 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
 static int __init set_init_ctx(void)
 {
 	struct cred *cred = (struct cred *)current->real_cred;
-	struct aa_task_ctx *ctx;
-
-	ctx = aa_alloc_task_ctx(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
 
 	lsm_early_cred(cred);
+	lsm_early_task(current);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
-	task_ctx(current) = ctx;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 0cc48072eb3b..d3d3963d7914 100644
--- a/security/security.c
+++ b/security/security.c
@@ -169,6 +169,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /* Prepare LSM for initialization. */
@@ -292,6 +293,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("cred blob size     = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size     = %d\n", blob_sizes.lbs_file);
 	init_debug("inode blob size    = %d\n", blob_sizes.lbs_inode);
+	init_debug("task blob size     = %d\n", blob_sizes.lbs_task);
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -515,6 +517,46 @@ int lsm_inode_alloc(struct inode *inode)
 	return 0;
 }
 
+/**
+ * lsm_task_alloc - allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_task_alloc(struct task_struct *task)
+{
+	if (blob_sizes.lbs_task == 0) {
+		task->security = NULL;
+		return 0;
+	}
+
+	task->security = kzalloc(blob_sizes.lbs_task, GFP_KERNEL);
+	if (task->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_task - during initialization allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules if it's not already there
+ */
+void __init lsm_early_task(struct task_struct *task)
+{
+	int rc;
+
+	if (task == NULL)
+		panic("%s: task cred.\n", __func__);
+	if (task->security != NULL)
+		return;
+	rc = lsm_task_alloc(task);
+	if (rc)
+		panic("%s: Early task alloc failed.\n", __func__);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -1346,12 +1388,22 @@ int security_file_open(struct file *file)
 
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
-	return call_int_hook(task_alloc, 0, task, clone_flags);
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		return rc;
+	rc = call_int_hook(task_alloc, 0, task, clone_flags);
+	if (unlikely(rc))
+		security_task_free(task);
+	return rc;
 }
 
 void security_task_free(struct task_struct *task)
 {
 	call_void_hook(task_free, task);
+
+	kfree(task->security);
+	task->security = NULL;
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-- 
2.14.5

