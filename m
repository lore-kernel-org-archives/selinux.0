Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281qtvu030167
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:52:55 -0500
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1f1f333b-d953-87ad-c9d4-828f82ada638@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:52:42 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 2/8] LSM: Manage credential security blobs
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 2/8] LSM: Manage credential security blobs

Move the management of credential security blobs from the
individual security modules to the security infrastructure.
The security modules using credential blobs have been updated
accordingly. Modules are required to identify the space they
require at module initialization. In some cases a module no
longer needs to supply a blob management hook, in which case
the hook has been removed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h           |  14 ++++
 kernel/cred.c                       |  13 ----
 security/Kconfig                    |  11 +++
 security/apparmor/context.c         |   2 -
 security/apparmor/include/context.h |   9 ++-
 security/apparmor/lsm.c             |  46 +++++-------
 security/security.c                 | 106 ++++++++++++++++++++++++++-
 security/selinux/hooks.c            | 113 +++++++++++------------------
 security/selinux/include/objsec.h   |   9 +++
 security/selinux/selinuxfs.c        |   1 +
 security/selinux/xfrm.c             |   4 +-
 security/smack/smack.h              |  15 +++-
 security/smack/smack_access.c       |   2 +-
 security/smack/smack_lsm.c          | 138 +++++++++++++++---------------------
 security/smack/smackfs.c            |  18 ++---
 security/tomoyo/common.h            |  21 +++++-
 security/tomoyo/domain.c            |   4 +-
 security/tomoyo/securityfs_if.c     |  15 ++--
 security/tomoyo/tomoyo.c            |  56 ++++++++++++---
 19 files changed, 364 insertions(+), 233 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index e0ac011d07a5..bb36a9ead1fe 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1969,6 +1969,13 @@ struct security_hook_list {
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
@@ -1981,6 +1988,7 @@ struct security_hook_list {
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
+extern void security_add_blobs(struct lsm_blob_sizes *needed);
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
@@ -2027,4 +2035,10 @@ void __init loadpin_add_hooks(void);
 static inline void loadpin_add_hooks(void) { };
 #endif
 
+extern int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
+
+#ifdef CONFIG_SECURITY
+void lsm_early_cred(struct cred *cred);
+#endif
+
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/kernel/cred.c b/kernel/cred.c
index ecf03657e71c..fa2061ee4955 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -704,19 +704,6 @@ bool creds_are_invalid(const struct cred *cred)
 {
 	if (cred->magic != CRED_MAGIC)
 		return true;
-#ifdef CONFIG_SECURITY_SELINUX
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	if (selinux_is_enabled() && cred->security) {
-		if ((unsigned long) cred->security < PAGE_SIZE)
-			return true;
-		if ((*(u32 *)cred->security & 0xffffff00) ==
-		    (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
-			return true;
-	}
-#endif
 	return false;
 }
 EXPORT_SYMBOL(creds_are_invalid);
diff --git a/security/Kconfig b/security/Kconfig
index c4302067a3ad..116dba966553 100644
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
diff --git a/security/apparmor/context.c b/security/apparmor/context.c
index c95f1ac6190b..db203ee24db8 100644
--- a/security/apparmor/context.c
+++ b/security/apparmor/context.c
@@ -50,8 +50,6 @@ void aa_free_task_context(struct aa_task_ctx *ctx)
 		aa_put_label(ctx->label);
 		aa_put_label(ctx->previous);
 		aa_put_label(ctx->onexec);
-
-		kzfree(ctx);
 	}
 }
 
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index 6ae07e9aaa17..301ab3a0dd04 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -18,11 +18,12 @@
 #include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/lsm_hooks.h>
 
 #include "label.h"
 #include "policy_ns.h"
 
-#define cred_ctx(X) ((X)->security)
+#define cred_ctx(X) apparmor_cred(X)
 #define current_ctx() cred_ctx(current_cred())
 
 /**
@@ -54,6 +55,10 @@ int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
 
+static inline struct aa_task_ctx *apparmor_cred(const struct cred *cred)
+{
+	return cred->security;
+}
 
 /**
  * aa_cred_raw_label - obtain cred's label
@@ -65,7 +70,7 @@ struct aa_label *aa_get_task_label(struct task_struct *task);
  */
 static inline struct aa_label *aa_cred_raw_label(const struct cred *cred)
 {
-	struct aa_task_ctx *ctx = cred_ctx(cred);
+	struct aa_task_ctx *ctx = apparmor_cred(cred);
 
 	AA_BUG(!ctx || !ctx->label);
 	return ctx->label;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 77bdfa7f8428..6058ce595037 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -56,22 +56,6 @@ DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 static void apparmor_cred_free(struct cred *cred)
 {
 	aa_free_task_context(cred_ctx(cred));
-	cred_ctx(cred) = NULL;
-}
-
-/*
- * allocate the apparmor part of blank credentials
- */
-static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-{
-	/* freed by apparmor_cred_free */
-	struct aa_task_ctx *ctx = aa_alloc_task_context(gfp);
-
-	if (!ctx)
-		return -ENOMEM;
-
-	cred_ctx(cred) = ctx;
-	return 0;
 }
 
 /*
@@ -80,14 +64,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 				 gfp_t gfp)
 {
-	/* freed by apparmor_cred_free */
-	struct aa_task_ctx *ctx = aa_alloc_task_context(gfp);
-
-	if (!ctx)
-		return -ENOMEM;
-
-	aa_dup_task_context(ctx, cred_ctx(old));
-	cred_ctx(new) = ctx;
+	aa_dup_task_context(cred_ctx(new), cred_ctx(old));
 	return 0;
 }
 
@@ -743,6 +720,10 @@ static int apparmor_task_kill(struct task_struct *target, struct siginfo *info,
 	return error;
 }
 
+struct lsm_blob_sizes apparmor_blob_sizes = {
+	.lbs_cred = sizeof(struct aa_task_ctx),
+};
+
 static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
@@ -777,7 +758,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
 	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
 
-	LSM_HOOK_INIT(cred_alloc_blank, apparmor_cred_alloc_blank),
 	LSM_HOOK_INIT(cred_free, apparmor_cred_free),
 	LSM_HOOK_INIT(cred_prepare, apparmor_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, apparmor_cred_transfer),
@@ -1033,12 +1013,10 @@ static int __init set_init_ctx(void)
 	struct cred *cred = (struct cred *)current->real_cred;
 	struct aa_task_ctx *ctx;
 
-	ctx = aa_alloc_task_context(GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
+	lsm_early_cred(cred);
+	ctx = apparmor_cred(cred);
 
 	ctx->label = aa_get_label(ns_unconfined(root_ns));
-	cred_ctx(cred) = ctx;
 
 	return 0;
 }
@@ -1122,8 +1100,18 @@ static inline int apparmor_init_sysctl(void)
 
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
index 459977ed5dec..c471019e2a7e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -39,6 +39,8 @@ struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
+static struct lsm_blob_sizes blob_sizes;
+
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
@@ -76,10 +78,22 @@ int __init security_init(void)
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
 
@@ -187,6 +201,73 @@ int unregister_lsm_notifier(struct notifier_block *nb)
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
@@ -987,17 +1068,36 @@ void security_task_free(struct task_struct *task)
 
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
index 8abd542c6b7c..aee16f5b6e1e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -192,12 +192,9 @@ static void cred_init_security(void)
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
@@ -207,7 +204,7 @@ static inline u32 cred_sid(const struct cred *cred)
 {
 	const struct task_security_struct *tsec;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	return tsec->sid;
 }
 
@@ -443,7 +440,7 @@ static int may_context_mount_sb_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
@@ -460,7 +457,7 @@ static int may_context_mount_inode_relabel(u32 sid,
 			struct superblock_security_struct *sbsec,
 			const struct cred *cred)
 {
-	const struct task_security_struct *tsec = cred->security;
+	const struct task_security_struct *tsec = selinux_cred(cred);
 	int rc;
 	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
@@ -1895,7 +1892,7 @@ static int may_create(struct inode *dir,
 		      struct dentry *dentry,
 		      u16 tclass)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *dsec;
 	struct superblock_security_struct *sbsec;
 	u32 sid, newsid;
@@ -1916,7 +1913,7 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	rc = selinux_determine_inode_label(current_security(), dir,
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()), dir,
 					   &dentry->d_name, tclass, &newsid);
 	if (rc)
 		return rc;
@@ -2396,8 +2393,8 @@ static int selinux_bprm_set_creds(struct linux_binprm *bprm)
 	if (bprm->called_set_creds)
 		return 0;
 
-	old_tsec = current_security();
-	new_tsec = bprm->cred->security;
+	old_tsec = selinux_cred(current_cred());
+	new_tsec = selinux_cred(bprm->cred);
 	isec = inode_security(inode);
 
 	/* Default to the current task SID. */
@@ -2555,7 +2552,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	new_tsec = bprm->cred->security;
+	new_tsec = selinux_cred(bprm->cred);
 	if (new_tsec->sid == new_tsec->osid)
 		return;
 
@@ -2597,7 +2594,7 @@ static void selinux_bprm_committing_creds(struct linux_binprm *bprm)
  */
 static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct itimerval itimer;
 	u32 osid, sid;
 	int rc, i;
@@ -2897,7 +2894,7 @@ static int selinux_dentry_init_security(struct dentry *dentry, int mode,
 	u32 newsid;
 	int rc;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
@@ -2916,14 +2913,14 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 	int rc;
 	struct task_security_struct *tsec;
 
-	rc = selinux_determine_inode_label(old->security,
+	rc = selinux_determine_inode_label(selinux_cred(old),
 					   d_inode(dentry->d_parent), name,
 					   inode_mode_to_security_class(mode),
 					   &newsid);
 	if (rc)
 		return rc;
 
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	tsec->create_sid = newsid;
 	return 0;
 }
@@ -2933,7 +2930,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const char **name,
 				       void **value, size_t *len)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
 	u32 newsid, clen;
 	int rc;
@@ -2943,7 +2940,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 
 	newsid = tsec->create_sid;
 
-	rc = selinux_determine_inode_label(current_security(),
+	rc = selinux_determine_inode_label(selinux_cred(current_cred()),
 		dir, qstr,
 		inode_mode_to_security_class(inode->i_mode),
 		&newsid);
@@ -3391,7 +3388,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsec = new_creds->security;
+	tsec = selinux_cred(new_creds);
 	/* Get label from overlay inode and set it in create_sid */
 	selinux_inode_getsecid(d_inode(src), &sid);
 	tsec->create_sid = sid;
@@ -3783,53 +3780,17 @@ static int selinux_task_alloc(struct task_struct *task,
 	return avc_has_perm(sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
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
-	struct task_security_struct *tsec = cred->security;
-
-	/*
-	 * cred->security == NULL if security_cred_alloc_blank() or
-	 * security_prepare_creds() returned an error.
-	 */
-	BUG_ON(cred->security && (unsigned long) cred->security < PAGE_SIZE);
-	cred->security = (void *) 0x7UL;
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
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
-	old_tsec = old->security;
-
-	tsec = kmemdup(old_tsec, sizeof(struct task_security_struct), gfp);
-	if (!tsec)
-		return -ENOMEM;
+	*tsec = *old_tsec;
 
-	new->security = tsec;
 	return 0;
 }
 
@@ -3838,8 +3799,8 @@ static int selinux_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void selinux_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct task_security_struct *old_tsec = old->security;
-	struct task_security_struct *tsec = new->security;
+	const struct task_security_struct *old_tsec = selinux_cred(old);
+	struct task_security_struct *tsec = selinux_cred(new);
 
 	*tsec = *old_tsec;
 }
@@ -3850,7 +3811,7 @@ static void selinux_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int selinux_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -3874,7 +3835,7 @@ static int selinux_kernel_act_as(struct cred *new, u32 secid)
 static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
 	struct inode_security_struct *isec = inode_security(inode);
-	struct task_security_struct *tsec = new->security;
+	struct task_security_struct *tsec = selinux_cred(new);
 	u32 sid = current_sid();
 	int ret;
 
@@ -4359,7 +4320,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 static int selinux_socket_create(int family, int type,
 				 int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	u32 newsid;
 	u16 secclass;
 	int rc;
@@ -4378,7 +4339,7 @@ static int selinux_socket_create(int family, int type,
 static int selinux_socket_post_create(struct socket *sock, int family,
 				      int type, int protocol, int kern)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct inode_security_struct *isec = inode_security_novalidate(SOCK_INODE(sock));
 	struct sk_security_struct *sksec;
 	u16 sclass = socket_type_to_security_class(family, type, protocol);
@@ -5001,7 +4962,7 @@ static int selinux_secmark_relabel_packet(u32 sid)
 	const struct task_security_struct *__tsec;
 	u32 tsid;
 
-	__tsec = current_security();
+	__tsec = selinux_cred(current_cred());
 	tsid = __tsec->sid;
 
 	return avc_has_perm(tsid, sid, SECCLASS_PACKET, PACKET__RELABELTO, NULL);
@@ -5908,7 +5869,7 @@ static int selinux_getprocattr(struct task_struct *p,
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = __task_cred(p)->security;
+	__tsec = selinux_cred(__task_cred(p));
 
 	if (current != p) {
 		error = avc_has_perm(current_sid(), __tsec->sid,
@@ -6021,7 +5982,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 	   operation.  See selinux_bprm_set_creds for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = new->security;
+	tsec = selinux_cred(new);
 	if (!strcmp(name, "exec")) {
 		tsec->exec_sid = sid;
 	} else if (!strcmp(name, "fscreate")) {
@@ -6144,7 +6105,7 @@ static int selinux_key_alloc(struct key *k, const struct cred *cred,
 	if (!ksec)
 		return -ENOMEM;
 
-	tsec = cred->security;
+	tsec = selinux_cred(cred);
 	if (tsec->keycreate_sid)
 		ksec->sid = tsec->keycreate_sid;
 	else
@@ -6396,6 +6357,10 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
+struct lsm_blob_sizes selinux_blob_sizes = {
+	.lbs_cred = sizeof(struct task_security_struct),
+};
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6478,8 +6443,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(file_open, selinux_file_open),
 
 	LSM_HOOK_INIT(task_alloc, selinux_task_alloc),
-	LSM_HOOK_INIT(cred_alloc_blank, selinux_cred_alloc_blank),
-	LSM_HOOK_INIT(cred_free, selinux_cred_free),
 	LSM_HOOK_INIT(cred_prepare, selinux_cred_prepare),
 	LSM_HOOK_INIT(cred_transfer, selinux_cred_transfer),
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
@@ -6629,11 +6592,19 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 
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
 		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
 		return 0;
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 3d54468ce334..e57010b2ea1f 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -25,6 +25,9 @@
 #include <linux/binfmts.h>
 #include <linux/in.h>
 #include <linux/spinlock.h>
+#include <linux/lsm_hooks.h>
+#include <linux/msg.h>
+#include <net/sock.h>
 #include <net/net_namespace.h>
 #include "flask.h"
 #include "avc.h"
@@ -155,5 +158,11 @@ struct bpf_security_struct {
 };
 
 extern unsigned int selinux_checkreqprot;
+extern struct lsm_blob_sizes selinux_blob_sizes;
+
+static inline struct task_security_struct *selinux_cred(const struct cred *cred)
+{
+	return cred->security;
+}
 
 #endif /* _SELINUX_OBJSEC_H_ */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 00eed842c491..855a13053a81 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 #include <linux/kobject.h>
 #include <linux/ctype.h>
+#include <linux/lsm_hooks.h>
 
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 928188902901..1ad8ad446a45 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -79,7 +79,7 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 				   gfp_t gfp)
 {
 	int rc;
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 	struct xfrm_sec_ctx *ctx = NULL;
 	u32 str_len;
 
@@ -136,7 +136,7 @@ static void selinux_xfrm_free(struct xfrm_sec_ctx *ctx)
  */
 static int selinux_xfrm_delete(struct xfrm_sec_ctx *ctx)
 {
-	const struct task_security_struct *tsec = current_security();
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
 
 	if (!ctx)
 		return 0;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index f7db791fb566..0c6dce446825 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
+#include <linux/msg.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
@@ -356,6 +357,11 @@ extern struct list_head smack_onlycap_list;
 #define SMACK_HASH_SLOTS 16
 extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
+static inline struct task_smack *smack_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 /*
  * Is the directory transmuting?
  */
@@ -382,13 +388,16 @@ static inline struct smack_known *smk_of_task(const struct task_smack *tsp)
 	return tsp->smk_task;
 }
 
-static inline struct smack_known *smk_of_task_struct(const struct task_struct *t)
+static inline struct smack_known *smk_of_task_struct(
+						const struct task_struct *t)
 {
 	struct smack_known *skp;
+	const struct cred *cred;
 
 	rcu_read_lock();
-	skp = smk_of_task(__task_cred(t)->security);
+	cred = __task_cred(t);
 	rcu_read_unlock();
+	skp = smk_of_task(smack_cred(cred));
 	return skp;
 }
 
@@ -405,7 +414,7 @@ static inline struct smack_known *smk_of_forked(const struct task_smack *tsp)
  */
 static inline struct smack_known *smk_of_current(void)
 {
-	return smk_of_task(current_security());
+	return smk_of_task(smack_cred(current_cred()));
 }
 
 /*
diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index 9a4c0ad46518..133774805594 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -275,7 +275,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack_known *obj_known,
 int smk_curacc(struct smack_known *obj_known,
 	       u32 mode, struct smk_audit_info *a)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_tskacc(tsp, obj_known, mode, a);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index feada2665322..a992c0a04795 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -121,7 +121,7 @@ static int smk_bu_note(char *note, struct smack_known *sskp,
 static int smk_bu_current(char *note, struct smack_known *oskp,
 			  int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (rc <= 0)
@@ -142,7 +142,7 @@ static int smk_bu_current(char *note, struct smack_known *oskp,
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *smk_task = smk_of_task_struct(otp);
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -164,7 +164,7 @@ static int smk_bu_task(struct task_struct *otp, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_inode(struct inode *inode, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *isp = inode->i_security;
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
@@ -194,7 +194,7 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 #ifdef CONFIG_SECURITY_SMACK_BRINGUP
 static int smk_bu_file(struct file *file, int mode, int rc)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -224,7 +224,7 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 static int smk_bu_credfile(const struct cred *cred, struct file *file,
 				int mode, int rc)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_known *sskp = tsp->smk_task;
 	struct inode *inode = file_inode(file);
 	struct inode_smack *isp = inode->i_security;
@@ -308,29 +308,20 @@ static struct inode_smack *new_inode_smack(struct smack_known *skp)
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
@@ -428,7 +419,7 @@ static int smk_ptrace_rule_check(struct task_struct *tracer,
 	}
 
 	rcu_read_lock();
-	tsp = __task_cred(tracer)->security;
+	tsp = smack_cred(__task_cred(tracer));
 	tracer_known = smk_of_task(tsp);
 
 	if ((mode & PTRACE_MODE_ATTACH) &&
@@ -495,7 +486,7 @@ static int smack_ptrace_traceme(struct task_struct *ptp)
 	int rc;
 	struct smack_known *skp;
 
-	skp = smk_of_task(current_security());
+	skp = smk_of_task(smack_cred(current_cred()));
 
 	rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
 	return rc;
@@ -912,7 +903,7 @@ static int smack_sb_statfs(struct dentry *dentry)
 static int smack_bprm_set_creds(struct linux_binprm *bprm)
 {
 	struct inode *inode = file_inode(bprm->file);
-	struct task_smack *bsp = bprm->cred->security;
+	struct task_smack *bsp = smack_cred(bprm->cred);
 	struct inode_smack *isp;
 	struct superblock_smack *sbsp;
 	int rc;
@@ -1743,7 +1734,7 @@ static int smack_mmap_file(struct file *file,
 		return -EACCES;
 	mkp = isp->smk_mmap;
 
-	tsp = current_security();
+	tsp = smack_cred(current_cred());
 	skp = smk_of_current();
 	rc = 0;
 
@@ -1839,7 +1830,7 @@ static int smack_file_send_sigiotask(struct task_struct *tsk,
 				     struct fown_struct *fown, int signum)
 {
 	struct smack_known *skp;
-	struct smack_known *tkp = smk_of_task(tsk->cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(tsk->cred));
 	struct file *file;
 	int rc;
 	struct smk_audit_info ad;
@@ -1887,7 +1878,7 @@ static int smack_file_receive(struct file *file)
 	if (inode->i_sb->s_magic == SOCKFS_MAGIC) {
 		sock = SOCKET_I(inode);
 		ssp = sock->sk->sk_security;
-		tsp = current_security();
+		tsp = smack_cred(current_cred());
 		/*
 		 * If the receiving process can't write to the
 		 * passed socket or if the passed socket can't
@@ -1929,7 +1920,7 @@ static int smack_file_receive(struct file *file)
  */
 static int smack_file_open(struct file *file, const struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct inode *inode = file_inode(file);
 	struct smk_audit_info ad;
 	int rc;
@@ -1957,14 +1948,7 @@ static int smack_file_open(struct file *file, const struct cred *cred)
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
 
@@ -1976,15 +1960,11 @@ static int smack_cred_alloc_blank(struct cred *cred, gfp_t gfp)
  */
 static void smack_cred_free(struct cred *cred)
 {
-	struct task_smack *tsp = cred->security;
+	struct task_smack *tsp = smack_cred(cred);
 	struct smack_rule *rp;
 	struct list_head *l;
 	struct list_head *n;
 
-	if (tsp == NULL)
-		return;
-	cred->security = NULL;
-
 	smk_destroy_label_list(&tsp->smk_relabel);
 
 	list_for_each_safe(l, n, &tsp->smk_rules) {
@@ -1992,7 +1972,6 @@ static void smack_cred_free(struct cred *cred)
 		list_del(&rp->list);
 		kfree(rp);
 	}
-	kfree(tsp);
 }
 
 /**
@@ -2006,15 +1985,11 @@ static void smack_cred_free(struct cred *cred)
 static int smack_cred_prepare(struct cred *new, const struct cred *old,
 			      gfp_t gfp)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp;
+	struct task_smack *old_tsp = smack_cred(old);
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
@@ -2022,10 +1997,7 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
 
 	rc = smk_copy_relabel(&new_tsp->smk_relabel, &old_tsp->smk_relabel,
 				gfp);
-	if (rc != 0)
-		return rc;
-
-	return 0;
+	return rc;
 }
 
 /**
@@ -2037,15 +2009,14 @@ static int smack_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void smack_cred_transfer(struct cred *new, const struct cred *old)
 {
-	struct task_smack *old_tsp = old->security;
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *old_tsp = smack_cred(old);
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = old_tsp->smk_task;
 	new_tsp->smk_forked = old_tsp->smk_task;
 	mutex_init(&new_tsp->smk_rules_lock);
 	INIT_LIST_HEAD(&new_tsp->smk_rules);
 
-
 	/* cbs copy rule list */
 }
 
@@ -2058,7 +2029,7 @@ static void smack_cred_transfer(struct cred *new, const struct cred *old)
  */
 static int smack_kernel_act_as(struct cred *new, u32 secid)
 {
-	struct task_smack *new_tsp = new->security;
+	struct task_smack *new_tsp = smack_cred(new);
 
 	new_tsp->smk_task = smack_from_secid(secid);
 	return 0;
@@ -2076,7 +2047,7 @@ static int smack_kernel_create_files_as(struct cred *new,
 					struct inode *inode)
 {
 	struct inode_smack *isp = inode->i_security;
-	struct task_smack *tsp = new->security;
+	struct task_smack *tsp = smack_cred(new);
 
 	tsp->smk_forked = isp->smk_inode;
 	tsp->smk_task = tsp->smk_forked;
@@ -2260,7 +2231,7 @@ static int smack_task_kill(struct task_struct *p, struct siginfo *info,
 	 * specific behavior. This is not clean. For one thing
 	 * we can't take privilege into account.
 	 */
-	skp = smk_of_task(cred->security);
+	skp = smk_of_task(smack_cred(cred));
 	rc = smk_access(skp, tkp, MAY_DELIVER, &ad);
 	rc = smk_bu_note("USB signal", skp, tkp, MAY_DELIVER, rc);
 	return rc;
@@ -3641,7 +3612,7 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
  */
 static int smack_setprocattr(const char *name, void *value, size_t size)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct cred *new;
 	struct smack_known *skp;
 	struct smack_known_list_elem *sklep;
@@ -3682,7 +3653,7 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
 	if (new == NULL)
 		return -ENOMEM;
 
-	tsp = new->security;
+	tsp = smack_cred(new);
 	tsp->smk_task = skp;
 	/*
 	 * process can change its label only once
@@ -4318,7 +4289,7 @@ static void smack_inet_csk_clone(struct sock *sk,
 static int smack_key_alloc(struct key *key, const struct cred *cred,
 			   unsigned long flags)
 {
-	struct smack_known *skp = smk_of_task(cred->security);
+	struct smack_known *skp = smk_of_task(smack_cred(cred));
 
 	key->security = skp;
 	return 0;
@@ -4349,7 +4320,7 @@ static int smack_key_permission(key_ref_t key_ref,
 {
 	struct key *keyp;
 	struct smk_audit_info ad;
-	struct smack_known *tkp = smk_of_task(cred->security);
+	struct smack_known *tkp = smk_of_task(smack_cred(cred));
 	int request = 0;
 	int rc;
 
@@ -4620,7 +4591,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 			return -ENOMEM;
 	}
 
-	tsp = new_creds->security;
+	tsp = smack_cred(new_creds);
 
 	/*
 	 * Get label from overlay inode and set it in create_sid
@@ -4648,8 +4619,8 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 					const struct cred *old,
 					struct cred *new)
 {
-	struct task_smack *otsp = old->security;
-	struct task_smack *ntsp = new->security;
+	struct task_smack *otsp = smack_cred(old);
+	struct task_smack *ntsp = smack_cred(new);
 	struct inode_smack *isp;
 	int may;
 
@@ -4682,6 +4653,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 	return 0;
 }
 
+struct lsm_blob_sizes smack_blob_sizes = {
+	.lbs_cred = sizeof(struct task_smack),
+};
+
 static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
@@ -4858,23 +4833,35 @@ static __init void init_smack_known_list(void)
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
@@ -4888,20 +4875,9 @@ static __init int smack_init(void)
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
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e53d55a..9d2dde608298 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2208,14 +2208,14 @@ static const struct file_operations smk_logging_ops = {
 
 static void *load_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2262,7 +2262,7 @@ static int smk_open_load_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_FIXED24_FMT);
@@ -2414,14 +2414,14 @@ static const struct file_operations smk_load2_ops = {
 
 static void *load_self2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_rules);
 }
 
 static void *load_self2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_rules);
 }
@@ -2467,7 +2467,7 @@ static int smk_open_load_self2(struct inode *inode, struct file *file)
 static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_write_rules_list(file, buf, count, ppos, &tsp->smk_rules,
 				    &tsp->smk_rules_lock, SMK_LONG_FMT);
@@ -2681,14 +2681,14 @@ static const struct file_operations smk_syslog_ops = {
 
 static void *relabel_self_seq_start(struct seq_file *s, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_start(s, pos, &tsp->smk_relabel);
 }
 
 static void *relabel_self_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 
 	return smk_seq_next(s, v, pos, &tsp->smk_relabel);
 }
@@ -2736,7 +2736,7 @@ static int smk_open_relabel_self(struct inode *inode, struct file *file)
 static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct task_smack *tsp = current_security();
+	struct task_smack *tsp = smack_cred(current_cred());
 	char *data;
 	int rc;
 	LIST_HEAD(list_tmp);
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 539bcdd30bb8..0110bebe86e2 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -29,6 +29,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/un.h>
+#include <linux/lsm_hooks.h>
 #include <net/sock.h>
 #include <net/af_unix.h>
 #include <net/ip.h>
@@ -1062,6 +1063,7 @@ void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *fmt,
 /********** External variable definitions. **********/
 
 extern bool tomoyo_policy_loaded;
+extern bool tomoyo_enabled;
 extern const char * const tomoyo_condition_keyword
 [TOMOYO_MAX_CONDITION_KEYWORD];
 extern const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
@@ -1196,6 +1198,17 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
 		atomic_dec(&group->head.users);
 }
 
+/**
+ * tomoyo_cred - Get a pointer to the tomoyo cred security blob
+ * @cred - the relevant cred
+ *
+ * Returns pointer to the tomoyo cred blob.
+ */
+static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
+{
+	return cred->security;
+}
+
 /**
  * tomoyo_domain - Get "struct tomoyo_domain_info" for current thread.
  *
@@ -1203,7 +1216,9 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	return current_cred()->security;
+	struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
+
+	return *blob;
 }
 
 /**
@@ -1216,7 +1231,9 @@ static inline struct tomoyo_domain_info *tomoyo_domain(void)
 static inline struct tomoyo_domain_info *tomoyo_real_domain(struct task_struct
 							    *task)
 {
-	return task_cred_xxx(task, security);
+	struct tomoyo_domain_info **blob = tomoyo_cred(get_task_cred(task));
+
+	return *blob;
 }
 
 /**
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index f6758dad981f..b7469fdbff01 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -678,6 +678,7 @@ static int tomoyo_environ(struct tomoyo_execve *ee)
  */
 int tomoyo_find_next_domain(struct linux_binprm *bprm)
 {
+	struct tomoyo_domain_info **blob;
 	struct tomoyo_domain_info *old_domain = tomoyo_domain();
 	struct tomoyo_domain_info *domain = NULL;
 	const char *original_name = bprm->filename;
@@ -843,7 +844,8 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 		domain = old_domain;
 	/* Update reference count on "struct tomoyo_domain_info". */
 	atomic_inc(&domain->users);
-	bprm->cred->security = domain;
+	blob = tomoyo_cred(bprm->cred);
+	*blob = domain;
 	kfree(exename.name);
 	if (!retval) {
 		ee->r.domain = domain;
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 1d3d7e7a1f05..768dff9608b1 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -71,9 +71,12 @@ static ssize_t tomoyo_write_self(struct file *file, const char __user *buf,
 				if (!cred) {
 					error = -ENOMEM;
 				} else {
-					struct tomoyo_domain_info *old_domain =
-						cred->security;
-					cred->security = new_domain;
+					struct tomoyo_domain_info **blob;
+					struct tomoyo_domain_info *old_domain;
+
+					blob = tomoyo_cred(cred);
+					old_domain = *blob;
+					*blob = new_domain;
 					atomic_inc(&new_domain->users);
 					atomic_dec(&old_domain->users);
 					commit_creds(cred);
@@ -234,10 +237,14 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  */
 static int __init tomoyo_initerface_init(void)
 {
+	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
 
+	if (!tomoyo_enabled)
+		return 0;
+	domain = tomoyo_domain();
 	/* Don't create securityfs entries unless registered. */
-	if (current_cred()->security != &tomoyo_kernel_domain)
+	if (domain != &tomoyo_kernel_domain)
 		return 0;
 
 	tomoyo_dir = securityfs_create_dir("tomoyo", NULL);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 213b8c593668..821ca242a194 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -18,7 +18,9 @@
  */
 static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 {
-	new->security = NULL;
+	struct tomoyo_domain_info **blob = tomoyo_cred(new);
+
+	*blob = NULL;
 	return 0;
 }
 
@@ -34,8 +36,13 @@ static int tomoyo_cred_alloc_blank(struct cred *new, gfp_t gfp)
 static int tomoyo_cred_prepare(struct cred *new, const struct cred *old,
 			       gfp_t gfp)
 {
-	struct tomoyo_domain_info *domain = old->security;
-	new->security = domain;
+	struct tomoyo_domain_info **old_blob = tomoyo_cred(old);
+	struct tomoyo_domain_info **new_blob = tomoyo_cred(new);
+	struct tomoyo_domain_info *domain;
+
+	domain = *old_blob;
+	*new_blob = domain;
+
 	if (domain)
 		atomic_inc(&domain->users);
 	return 0;
@@ -59,7 +66,9 @@ static void tomoyo_cred_transfer(struct cred *new, const struct cred *old)
  */
 static void tomoyo_cred_free(struct cred *cred)
 {
-	struct tomoyo_domain_info *domain = cred->security;
+	struct tomoyo_domain_info **blob = tomoyo_cred(cred);
+	struct tomoyo_domain_info *domain = *blob;
+
 	if (domain)
 		atomic_dec(&domain->users);
 }
@@ -73,6 +82,9 @@ static void tomoyo_cred_free(struct cred *cred)
  */
 static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 {
+	struct tomoyo_domain_info **blob;
+	struct tomoyo_domain_info *domain;
+
 	/*
 	 * Do only if this function is called for the first time of an execve
 	 * operation.
@@ -93,13 +105,14 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
 	 * stored inside "bprm->cred->security" will be acquired later inside
 	 * tomoyo_find_next_domain().
 	 */
-	atomic_dec(&((struct tomoyo_domain_info *)
-		     bprm->cred->security)->users);
+	blob = tomoyo_cred(bprm->cred);
+	domain = *blob;
+	atomic_dec(&domain->users);
 	/*
 	 * Tell tomoyo_bprm_check_security() is called for the first time of an
 	 * execve operation.
 	 */
-	bprm->cred->security = NULL;
+	*blob = NULL;
 	return 0;
 }
 
@@ -112,8 +125,11 @@ static int tomoyo_bprm_set_creds(struct linux_binprm *bprm)
  */
 static int tomoyo_bprm_check_security(struct linux_binprm *bprm)
 {
-	struct tomoyo_domain_info *domain = bprm->cred->security;
+	struct tomoyo_domain_info **blob;
+	struct tomoyo_domain_info *domain;
 
+	blob = tomoyo_cred(bprm->cred);
+	domain = *blob;
 	/*
 	 * Execute permission is checked against pathname passed to do_execve()
 	 * using current domain.
@@ -493,6 +509,10 @@ static int tomoyo_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 	return tomoyo_socket_sendmsg_permission(sock, msg, size);
 }
 
+struct lsm_blob_sizes tomoyo_blob_sizes = {
+	.lbs_cred = sizeof(struct tomoyo_domain_info *),
+};
+
 /*
  * tomoyo_security_ops is a "struct security_operations" which is used for
  * registering TOMOYO.
@@ -531,6 +551,8 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 /* Lock for GC. */
 DEFINE_SRCU(tomoyo_ss);
 
+bool tomoyo_enabled;
+
 /**
  * tomoyo_init - Register TOMOYO Linux as a LSM module.
  *
@@ -538,14 +560,28 @@ DEFINE_SRCU(tomoyo_ss);
  */
 static int __init tomoyo_init(void)
 {
+	static int finish;
 	struct cred *cred = (struct cred *) current_cred();
+	struct tomoyo_domain_info **blob;
+
+	if (!security_module_enable("tomoyo")) {
+		tomoyo_enabled = false;
+		return 0;
+	}
+	tomoyo_enabled = true;
 
-	if (!security_module_enable("tomoyo"))
+	if (!finish) {
+		security_add_blobs(&tomoyo_blob_sizes);
+		finish = 1;
 		return 0;
+	}
+
 	/* register ourselves with the security framework */
 	security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
 	printk(KERN_INFO "TOMOYO Linux initialized\n");
-	cred->security = &tomoyo_kernel_domain;
+	lsm_early_cred(cred);
+	blob = tomoyo_cred(cred);
+	*blob = &tomoyo_kernel_domain;
 	tomoyo_mm_init();
 	return 0;
 }
-- 
2.14.3
