Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281rC7R030423
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:53:12 -0500
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <14eeb676-17cf-dd58-4c01-01a4a5a4e651@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:53:03 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 4/8] LSM: Manage task security blobs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 4/8] LSM: Manage task security blobs

Move management of task security blobs into the security
infrastructure. Modules are required to identify the space
they require. At this time there are no modules that use
task blobs.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  1 +
 security/security.c       | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 417a8946201a..da09168e4daa 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1975,6 +1975,7 @@ struct security_hook_list {
 struct lsm_blob_sizes {
 	int	lbs_cred;
 	int	lbs_file;
+	int	lbs_task;
 };
 
 /*
diff --git a/security/security.c b/security/security.c
index 90d09d8542d4..8d6738f384fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -102,6 +102,7 @@ int __init security_init(void)
 #ifdef CONFIG_SECURITY_LSM_DEBUG
 	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
 	pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
+	pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
 #endif
 
 	return 0;
@@ -277,6 +278,7 @@ void __init security_add_blobs(struct lsm_blob_sizes *needed)
 {
 	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_size(&needed->lbs_task, &blob_sizes.lbs_task);
 }
 
 /**
@@ -300,6 +302,27 @@ int lsm_file_alloc(struct file *file)
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
 /*
  * Hook list operation macros.
  *
@@ -1106,12 +1129,22 @@ int security_file_open(struct file *file, const struct cred *cred)
 
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
2.14.3
