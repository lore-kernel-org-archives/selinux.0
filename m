Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K0LjnN020818
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 20:21:45 -0400
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>, SE Linux <selinux@tycho.nsa.gov>,
 LKLM <linux-kernel@vger.kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Kees Cook <keescook@chromium.org>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=
 <mic@digikod.net>, Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
Date: Wed, 19 Sep 2018 17:21:37 -0700
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v3 14/16] LSM: Infrastructure management of the task
 security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Infrastructure management of the task security blob

Move management of the task_struct->security blob out
of the individual security modules and into the security
infrastructure. Instead of allocating the blobs from within
the modules the modules tell the infrastructure how much
space is required, and the space is allocated there.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h        |  2 ++
 security/apparmor/include/task.h | 18 +++-------
 security/apparmor/lsm.c          | 15 ++-------
 security/security.c              | 56 ++++++++++++++++++++++++++++++--
 4 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 416b20c3795b..6057c603b979 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2031,6 +2031,7 @@ struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
 	int	lbs_inode;
+	int	lbs_task;
 };
 
 /*
@@ -2098,6 +2099,7 @@ extern int lsm_inode_alloc(struct inode *inode);
 #ifdef CONFIG_SECURITY
 void lsm_early_cred(struct cred *cred);
 void lsm_early_inode(struct inode *inode);
+void lsm_early_task(struct task_struct *task);
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
index 15716b6ff860..c97dc3dbb515 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -91,19 +91,14 @@ static void apparmor_task_free(struct task_struct *task)
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
@@ -1132,6 +1127,7 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 struct lsm_blob_sizes apparmor_blob_sizes = {
 	.lbs_cred = sizeof(struct aa_task_ctx *),
 	.lbs_file = sizeof(struct aa_file_ctx),
+	.lbs_task = sizeof(struct aa_task_ctx),
 };
 
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
@@ -1457,15 +1453,10 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
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
index 2501cdcbebff..7e11de7eec21 100644
--- a/security/security.c
+++ b/security/security.c
@@ -116,7 +116,8 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
-	pr_info("LSM: inode blob size       = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -301,6 +302,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
 		blob_sizes.lbs_inode = sizeof(struct rcu_head);
 	lsm_set_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -364,6 +366,46 @@ void lsm_early_inode(struct inode *inode)
 		panic("%s: Early inode alloc failed.\n", __func__);
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
+void lsm_early_task(struct task_struct *task)
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
@@ -1196,12 +1238,22 @@ int security_file_open(struct file *file)
 
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
2.17.1
