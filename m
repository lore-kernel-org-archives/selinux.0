Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8M0IhQH009862
 for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2018 20:18:43 -0400
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
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
Date: Fri, 21 Sep 2018 17:18:31 -0700
MIME-Version: 1.0
In-Reply-To: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v4 08/19] Infrastructure management of the cred security blob
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move management of the cred security blob out of the
security modules and into the security infrastructre.
Instead of allocating and freeing space the security
modules tell the infrastructure how much space they
require.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h         |  14 ++++
 security/Kconfig                  |  11 ++++
 security/apparmor/lsm.c           |  18 +++++
 security/security.c               | 106 +++++++++++++++++++++++++++++-
 security/selinux/hooks.c          |  58 +++++-----------
 security/selinux/include/objsec.h |   2 +
 security/smack/smack_lsm.c        |  85 +++++++++---------------
 security/tomoyo/common.h          |   2 +-
 security/tomoyo/tomoyo.c          |  16 ++++-
 9 files changed, 212 insertions(+), 100 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97a020c616ad..0bef312efd45 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2024,6 +2024,13 @@ struct security_hook_list {
 	char				*lsm;
 } __randomize_layout;
 
+/*
+ * Security blob size or offset data.
+ */
+struct lsm_blob_sizes {
+	int	lbs_cred;
+};
+
 /*
  * Initializing a security_hook_list structure takes
  * up a lot of space in a source file. This macro takes
@@ -2036,6 +2043,7 @@ struct security_hook_list {
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
+extern void security_add_blobs(struct lsm_blob_sizes *needed);
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
@@ -2082,4 +2090,10 @@ void __init loadpin_add_hooks(void);
 static inline void loadpin_add_hooks(void) { };
 #endif
 
+extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
+
+#ifdef CONFIG_SECURITY
+void lsm_early_cred(struct cred *cred);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index 27d8b2688f75..22f7664c4977 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -36,6 +36,17 @@ config SECURITY_WRITABLE_HOOKS
 	bool
 	default n
 
+config SECURITY_LSM_DEBUG
+	bool "Enable debugging of the LSM infrastructure"
+	depends on SECURITY
+	help
+	  This allows you to choose debug messages related to
+	  security modules configured into your kernel. These
+	  messages may be helpful in determining how a security
+	  module is using security blobs.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITYFS
 	bool "Enable the securityfs filesystem"
 	help
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 4f51705c3c71..c2566aaa138e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1126,6 +1126,13 @@ static void apparmor_sock_graft(struct sock *sk, struct socket *parent)
 		ctx->label = aa_get_current_label();
 }
 
+/*
+ * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
+ */
+struct lsm_blob_sizes apparmor_blob_sizes = {
+	.lbs_cred = sizeof(struct aa_task_ctx *),
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -1455,6 +1462,7 @@ static int __init set_init_ctx(void)
 	if (!ctx)
 		return -ENOMEM;
 
+	lsm_early_cred(cred);
 	set_cred_label(cred, aa_get_label(ns_unconfined(root_ns)));
 	task_ctx(current) = ctx;
 
@@ -1540,8 +1548,18 @@ static inline int apparmor_init_sysctl(void)
 
 static int __init apparmor_init(void)
 {
+	static int finish;
 	int error;
 
+	if (!finish) {
+		if (apparmor_enabled && security_module_enable("apparmor"))
+			security_add_blobs(&apparmor_blob_sizes);
+		else
+			apparmor_enabled = false;
+		finish = 1;
+		return 0;
+	}
+
 	if (!apparmor_enabled || !security_module_enable("apparmor")) {
 		aa_info_message("AppArmor disabled by boot time parameter");
 		apparmor_enabled = false;
diff --git a/security/security.c b/security/security.c
index 3dfe75d0d373..ff7df14f6db1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -41,6 +41,8 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
+static struct lsm_blob_sizes blob_sizes;
+
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
@@ -85,10 +87,22 @@ int __init security_init(void)
 	loadpin_add_hooks();
 
 	/*
-	 * Load all the remaining security modules.
+	 * The first call to a module specific init function
+	 * updates the blob size requirements.
+	 */
+	do_security_initcalls();
+
+	/*
+	 * The second call to a module specific init function
+	 * adds hooks to the hook lists and does any other early
+	 * initializations required.
 	 */
 	do_security_initcalls();
 
+#ifdef CONFIG_SECURITY_LSM_DEBUG
+	pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
+#endif
+
 	return 0;
 }
 
@@ -198,6 +212,73 @@ int unregister_lsm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(unregister_lsm_notifier);
 
+/**
+ * lsm_cred_alloc - allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ * @gfp: allocation type
+ *
+ * Allocate the cred blob for all the modules
+ *
+ * Returns 0, or -ENOMEM if memory can't be allocated.
+ */
+int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+{
+	if (blob_sizes.lbs_cred == 0) {
+		cred->security = NULL;
+		return 0;
+	}
+
+	cred->security = kzalloc(blob_sizes.lbs_cred, gfp);
+	if (cred->security == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+/**
+ * lsm_early_cred - during initialization allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ *
+ * Allocate the cred blob for all the modules if it's not already there
+ */
+void lsm_early_cred(struct cred *cred)
+{
+	int rc;
+
+	if (cred == NULL)
+		panic("%s: NULL cred.\n", __func__);
+	if (cred->security != NULL)
+		return;
+	rc = lsm_cred_alloc(cred, GFP_KERNEL);
+	if (rc)
+		panic("%s: Early cred alloc failed.\n", __func__);
+}
+
+static void __init lsm_set_size(int *need, int *lbs)
+{
+	int offset;
+
+	if (*need > 0) {
+		offset = *lbs;
+		*lbs += *need;
+		*need = offset;
+	}
+}
+
+/**
+ * security_add_blobs - Report blob sizes
+ * @needed: the size of blobs needed by the module
+ *
+ * Each LSM has to register its blobs with the infrastructure.
+ * The "needed" data tells the infrastructure how much memory
+ * the module requires for each of its blobs. On return the
+ * structure is filled with the offset that module should use
+ * from the blob pointer.
+ */
+void __init security_add_blobs(struct lsm_blob_sizes *needed)
+{
+	lsm_set_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+}
+
 /*
  * Hook list operation macros.
  *
@@ -998,17 +1079,36 @@ void security_task_free(struct task_struct *task)
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	return call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	int rc = lsm_cred_alloc(cred, gfp);
+
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(cred_alloc_blank, 0, cred, gfp);
+	if (rc)
+		security_cred_free(cred);
+	return rc;
 }
 
 void security_cred_free(struct cred *cred)
 {
 	call_void_hook(cred_free, cred);
+
+	kfree(cred->security);
+	cred->security = NULL;
 }
 
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
-	return call_int_hook(cred_prepare, 0, new, old, gfp);
+	int rc = lsm_cred_alloc(new, gfp);
+
+	if (rc)
+		return rc;
+
+	rc = call_int_hook(cred_prepare, 0, new, old, gfp);
+	if (rc)
+		security_cred_free(new);
+	return rc;
 }
 
 void security_transfer_creds(struct cred *new, const struct cred *old)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 82b28ee878c4..b629cc302088 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -212,12 +212,9 @@ static void cred_init_security(void)
 	struct cred *cred = (struct cred *) current->real_cred;
 	struct task_security_struct *tsec;
 
-	tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
-	if (!tsec)
-		panic("SELinux:  Failed to initialize initial task.\n");
-
+	lsm_early_cred(cred);
+	tsec = selinux_cred(cred);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
-	cred->security = tsec;
 }
 
 /*
@@ -3897,47 +3894,16 @@ static int selinux_task_alloc(struct task_struct *task,
 			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
 }
 
-/*
- * allocate the SELinux part of blank credentials
- */
-static int selinux_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-{
-	struct task_security_struct *tsec;
-
-	tsec = kzalloc(sizeof(struct task_security_struct), gfp);
-	if (!tsec)
-		return -ENOMEM;
-
-	cred->security = tsec;
-	return 0;
-}
-
-/*
- * detach and free the LSM part of a set of credentials
- */
-static void selinux_cred_free(struct cred *cred)
-{
-	struct task_security_struct *tsec = selinux_cred(cred);
-
-	kfree(tsec);
-}
-
 /*
  * prepare a new set of credentials for modification
  */
 static int selinux_cred_prepare(struct cred *new, const struct cred *old,
 				gfp_t gfp)
 {
-	const struct task_security_struct *old_tsec;
-	struct task_security_struct *tsec;
-
-	old_tsec = selinux_cred(old);
-
-	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
-	if (!tsec)
-		return -ENOMEM;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
-	new->security = tsec;
+	*tsec = *old_tsec;
 	return 0;
 }
 
@@ -6887,6 +6853,10 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
+struct lsm_blob_sizes selinux_blob_sizes = {
+	.lbs_cred = sizeof(struct task_security_struct),
+};
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6969,8 +6939,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
-	LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
-	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(cred_getsecid, selinux_cred_getsecid),
@@ -7126,11 +7094,19 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
 static __init int selinux_init(void)
 {
+	static int finish;
+
 	if (!security_module_enable("selinux")) {
 		selinux_enabled = 0;
 		return 0;
 	}
 
+	if (!finish) {
+		security_add_blobs(&selinux_blob_sizes);
+		finish = 1;
+		return 0;
+	}
+
 	if (!selinux_enabled) {
 		pr_info("SELinux:  Disabled at boot.\n");
 		return 0;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 734b6833bdff..ad511c3d2eb7 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -25,6 +25,7 @@
 #include <linux/binfmts.h>
 #include <linux/in.h>
 #include <linux/spinlock.h>
+#include <linux/lsm_hooks.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -158,6 +159,7 @@ struct bpf_security_struct {
 	u32 sid;  /*SID of bpf obj creater*/
 };
 
+extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 {
 	return cred->security;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 68ee3ae8f25c..a06ea8aa89c4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -309,29 +309,20 @@ static struct inode_smack *new_inode_smack(struct smack_known *skp)
 }
 
 /**
- * new_task_smack - allocate a task security blob
+ * init_task_smack - initialize a task security blob
+ * @tsp: blob to initialize
  * @task: a pointer to the Smack label for the running task
  * @forked: a pointer to the Smack label for the forked task
- * @gfp: type of the memory for the allocation
  *
- * Returns the new blob or NULL if there's no memory available
  */
-static struct task_smack *new_task_smack(struct smack_known *task,
-					struct smack_known *forked, gfp_t gfp)
+static void init_task_smack(struct task_smack *tsp, struct smack_known *task,
+					struct smack_known *forked)
 {
-	struct task_smack *tsp;
-
-	tsp = kzalloc(sizeof(struct task_smack), gfp);
-	if (tsp == NULL)
-		return NULL;
-
 	tsp->smk_task = task;
 	tsp->smk_forked = forked;
 	INIT_LIST_HEAD(&tsp->smk_rules);
 	INIT_LIST_HEAD(&tsp->smk_relabel);
 	mutex_init(&tsp->smk_rules_lock);
-
-	return tsp;
 }
 
 /**
@@ -1958,14 +1949,7 @@ static int smack_file_open(struct file *file)
  */
 static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	struct task_smack *tsp;
-
-	tsp = new_task_smack(NULL, NULL, gfp);
-	if (tsp == NULL)
-		return -ENOMEM;
-
-	cred->security = tsp;
-
+	init_task_smack(smack_cred(cred), NULL, NULL);
 	return 0;
 }
 
@@ -1982,10 +1966,6 @@ static void smack_cred_free(struct cred *cred)
 	struct list_head *l;
 	struct list_head *n;
 
-	if (tsp == NULL)
-		return;
-	cred->security = NULL;
-
 	smk_destroy_label_list(&tsp->smk_relabel);
 
 	list_for_each_safe(l, n, &tsp->smk_rules) {
@@ -1993,7 +1973,6 @@ static void smack_cred_free(struct cred *cred)
 		list_del(&rp->list);
 		kfree(rp);
 	}
-	kfree(tsp);
 }
 
 /**
@@ -2008,14 +1987,10 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
 	struct task_smack *old_tsp = smack_cred(old);
-	struct task_smack *new_tsp;
+	struct task_smack *new_tsp = smack_cred(new);
 	int rc;
 
-	new_tsp = new_task_smack(old_tsp->smk_task, old_tsp->smk_task, gfp);
-	if (new_tsp == NULL)
-		return -ENOMEM;
-
-	new->security = new_tsp;
+	init_task_smack(new_tsp, old_tsp->smk_task, old_tsp->smk_task);
 
 	rc = smk_copy_rules(&new_tsp->smk_rules, &old_tsp->smk_rules, gfp);
 	if (rc != 0)
@@ -2023,10 +1998,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 
 	rc = smk_copy_relabel(&new_tsp->smk_relabel, &old_tsp->smk_relabel,
 				gfp);
-	if (rc != 0)
-		return rc;
-
-	return 0;
+	return rc;
 }
 
 /**
@@ -4652,6 +4624,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
+struct lsm_blob_sizes smack_blob_sizes = {
+	.lbs_cred = sizeof(struct task_smack),
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4830,23 +4806,35 @@ static __init void init_smack_known_list(void)
  */
 static __init int smack_init(void)
 {
-	struct cred *cred;
+	static int finish;
+	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
 	if (!security_module_enable("smack"))
 		return 0;
 
+	if (!finish) {
+		security_add_blobs(&smack_blob_sizes);
+		finish = 1;
+		return 0;
+	}
+
 	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
 	if (!smack_inode_cache)
 		return -ENOMEM;
 
-	tsp = new_task_smack(&smack_known_floor, &smack_known_floor,
-				GFP_KERNEL);
-	if (tsp == NULL) {
-		kmem_cache_destroy(smack_inode_cache);
-		return -ENOMEM;
-	}
+	lsm_early_cred(cred);
 
+	/*
+	 * Set the security state for the initial task.
+	 */
+	tsp = smack_cred(cred);
+	init_task_smack(tsp, &smack_known_floor, &smack_known_floor);
+
+	/*
+	 * Register with LSM
+	 */
+	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
@@ -4860,20 +4848,9 @@ static __init int smack_init(void)
 	pr_info("Smack:  IPv6 Netfilter enabled.\n");
 #endif
 
-	/*
-	 * Set the security state for the initial task.
-	 */
-	cred = (struct cred *) current->cred;
-	cred->security = tsp;
-
 	/* initialize the smack_known_list */
 	init_smack_known_list();
 
-	/*
-	 * Register with LSM
-	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
-
 	return 0;
 }
 
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index c9d8c49e3210..0110bebe86e2 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1206,7 +1206,7 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
 {
-	return (struct tomoyo_domain_info **)&cred->security;
+	return cred->security;
 }
 
 /**
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 25739888921f..bb84e6ec3886 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -509,6 +509,10 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
 
+struct lsm_blob_sizes tomoyo_blob_sizes = {
+	.lbs_cred = sizeof(struct tomoyo_domain_info *),
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -556,16 +560,26 @@ bool tomoyo_enabled;
  */
 static int __init tomoyo_init(void)
 {
+	static int finish;
 	struct cred *cred = (struct cred *) current_cred();
 	struct tomoyo_domain_info **blob;
 
-	if (!security_module_enable("tomoyo"))
+	if (!security_module_enable("tomoyo")) {
+		tomoyo_enabled = false;
 		return 0;
+	}
 	tomoyo_enabled = true;
 
+	if (!finish) {
+		security_add_blobs(&tomoyo_blob_sizes);
+		finish = 1;
+		return 0;
+	}
+
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
+	lsm_early_cred(cred);
 	blob = tomoyo_cred(cred);
 	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
-- 
2.17.1
