Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBJIargv005095
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2012 13:36:53 -0500
Message-ID: <50D20923.6040100@schaufler-ca.com>
Date: Wed, 19 Dec 2012 10:36:19 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH v11 1/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com>
In-Reply-To: <50D205E2.9010203@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v11 1/9] LSM: Multiple concurrent LSMs

Change the infrastructure for Linux Security Modules (LSM)s
from a single vector of hook handlers to a list based method
for handling multiple concurrent modules. 

Changes for AppArmor. Abstract access to security blobs.
Remove commoncap calls.


Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 security/apparmor/context.c         |   10 +++---
 security/apparmor/domain.c          |   19 ++++------
 security/apparmor/include/context.h |   13 +++++--
 security/apparmor/lsm.c             |   66 +++++++++++++----------------------
 4 files changed, 45 insertions(+), 63 deletions(-)

diff --git a/security/apparmor/context.c b/security/apparmor/context.c
index 8a9b502..3d9e460 100644
--- a/security/apparmor/context.c
+++ b/security/apparmor/context.c
@@ -76,7 +76,7 @@ void aa_dup_task_context(struct aa_task_cxt *new, const struct aa_task_cxt *old)
  */
 int aa_replace_current_profile(struct aa_profile *profile)
 {
-	struct aa_task_cxt *cxt = current_cred()->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(current_cred(), &apparmor_ops);
 	struct cred *new;
 	BUG_ON(!profile);
 
@@ -87,7 +87,7 @@ int aa_replace_current_profile(struct aa_profile *profile)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (unconfined(profile) || (cxt->profile->ns != profile->ns)) {
 		/* if switching to unconfined or a different profile namespace
 		 * clear out context state
@@ -123,7 +123,7 @@ int aa_set_current_onexec(struct aa_profile *profile)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	aa_get_profile(profile);
 	aa_put_profile(cxt->onexec);
 	cxt->onexec = profile;
@@ -150,7 +150,7 @@ int aa_set_current_hat(struct aa_profile *profile, u64 token)
 		return -ENOMEM;
 	BUG_ON(!profile);
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (!cxt->previous) {
 		/* transfer refcount */
 		cxt->previous = cxt->profile;
@@ -187,7 +187,7 @@ int aa_restore_previous_profile(u64 token)
 	if (!new)
 		return -ENOMEM;
 
-	cxt = new->security;
+	cxt = lsm_get_cred(new, &apparmor_ops);
 	if (cxt->token != token) {
 		abort_creds(new);
 		return -EACCES;
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 60f0c76..7ad4e26 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -353,14 +353,12 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 		bprm->file->f_path.dentry->d_inode->i_mode
 	};
 	const char *name = NULL, *target = NULL, *info = NULL;
-	int error = cap_bprm_set_creds(bprm);
-	if (error)
-		return error;
+	int error = 0;
 
 	if (bprm->cred_prepared)
 		return 0;
 
-	cxt = bprm->cred->security;
+	cxt = lsm_get_cred(bprm->cred, &apparmor_ops);
 	BUG_ON(!cxt);
 
 	profile = aa_get_profile(aa_newest_version(cxt->profile));
@@ -539,15 +537,10 @@ cleanup:
  */
 int apparmor_bprm_secureexec(struct linux_binprm *bprm)
 {
-	int ret = cap_bprm_secureexec(bprm);
-
 	/* the decision to use secure exec is computed in set_creds
 	 * and stored in bprm->unsafe.
 	 */
-	if (!ret && (bprm->unsafe & AA_SECURE_X_NEEDED))
-		ret = 1;
-
-	return ret;
+	return bprm->unsafe & AA_SECURE_X_NEEDED;
 }
 
 /**
@@ -557,7 +550,7 @@ int apparmor_bprm_secureexec(struct linux_binprm *bprm)
 void apparmor_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	struct aa_profile *profile = __aa_current_profile();
-	struct aa_task_cxt *new_cxt = bprm->cred->security;
+	struct aa_task_cxt *new_cxt = lsm_get_cred(bprm->cred, &apparmor_ops);
 
 	/* bail out if unconfined or not changing profile */
 	if ((new_cxt->profile == profile) ||
@@ -634,7 +627,7 @@ int aa_change_hat(const char *hats[], int count, u64 token, bool permtest)
 
 	/* released below */
 	cred = get_current_cred();
-	cxt = cred->security;
+	cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 	previous_profile = cxt->previous;
 
@@ -770,7 +763,7 @@ int aa_change_profile(const char *ns_name, const char *hname, bool onexec,
 	}
 
 	cred = get_current_cred();
-	cxt = cred->security;
+	cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 
 	/*
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index a9cbee4..8484e55 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -18,6 +18,7 @@
 #include <linux/cred.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/lsm.h>
 
 #include "policy.h"
 
@@ -81,6 +82,8 @@ int aa_set_current_onexec(struct aa_profile *profile);
 int aa_set_current_hat(struct aa_profile *profile, u64 token);
 int aa_restore_previous_profile(u64 cookie);
 
+extern struct security_operations apparmor_ops;
+
 /**
  * __aa_task_is_confined - determine if @task has any confinement
  * @task: task to check confinement of  (NOT NULL)
@@ -89,7 +92,9 @@ int aa_restore_previous_profile(u64 cookie);
  */
 static inline bool __aa_task_is_confined(struct task_struct *task)
 {
-	struct aa_task_cxt *cxt = __task_cred(task)->security;
+	struct aa_task_cxt *cxt;
+
+	cxt = lsm_get_cred(__task_cred(task), &apparmor_ops);
 
 	BUG_ON(!cxt || !cxt->profile);
 	if (unconfined(aa_newest_version(cxt->profile)))
@@ -108,7 +113,7 @@ static inline bool __aa_task_is_confined(struct task_struct *task)
  */
 static inline struct aa_profile *aa_cred_profile(const struct cred *cred)
 {
-	struct aa_task_cxt *cxt = cred->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(cred, &apparmor_ops);
 	BUG_ON(!cxt || !cxt->profile);
 	return aa_newest_version(cxt->profile);
 }
@@ -136,8 +141,10 @@ static inline struct aa_profile *__aa_current_profile(void)
  */
 static inline struct aa_profile *aa_current_profile(void)
 {
-	const struct aa_task_cxt *cxt = current_cred()->security;
+	const struct aa_task_cxt *cxt;
 	struct aa_profile *profile;
+
+	cxt = lsm_get_cred(current_cred(), &apparmor_ops);
 	BUG_ON(!cxt || !cxt->profile);
 
 	profile = aa_newest_version(cxt->profile);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 8c2a7f6..28d6fd4 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -48,8 +48,8 @@ int apparmor_initialized __initdata;
  */
 static void apparmor_cred_free(struct cred *cred)
 {
-	aa_free_task_context(cred->security);
-	cred->security = NULL;
+	aa_free_task_context(lsm_get_cred(cred, &apparmor_ops));
+	lsm_set_cred(cred, NULL, &apparmor_ops);
 }
 
 /*
@@ -62,7 +62,7 @@ static int apparmor_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 	if (!cxt)
 		return -ENOMEM;
 
-	cred->security = cxt;
+	lsm_set_cred(cred, cxt, &apparmor_ops);
 	return 0;
 }
 
@@ -77,8 +77,8 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
 	if (!cxt)
 		return -ENOMEM;
 
-	aa_dup_task_context(cxt, old->security);
-	new->security = cxt;
+	aa_dup_task_context(cxt, lsm_get_cred(old, &apparmor_ops));
+	lsm_set_cred(new, cxt, &apparmor_ops);
 	return 0;
 }
 
@@ -87,8 +87,8 @@ static int apparmor_cred_prepare(struct cred *new, const struct cred *old,
  */
 static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 {
-	const struct aa_task_cxt *old_cxt = old->security;
-	struct aa_task_cxt *new_cxt = new->security;
+	const struct aa_task_cxt *old_cxt = lsm_get_cred(old, &apparmor_ops);
+	struct aa_task_cxt *new_cxt = lsm_get_cred(new, &apparmor_ops);
 
 	aa_dup_task_context(new_cxt, old_cxt);
 }
@@ -96,19 +96,11 @@ static void apparmor_cred_transfer(struct cred *new, const struct cred *old)
 static int apparmor_ptrace_access_check(struct task_struct *child,
 					unsigned int mode)
 {
-	int error = cap_ptrace_access_check(child, mode);
-	if (error)
-		return error;
-
 	return aa_ptrace(current, child, mode);
 }
 
 static int apparmor_ptrace_traceme(struct task_struct *parent)
 {
-	int error = cap_ptrace_traceme(parent);
-	if (error)
-		return error;
-
 	return aa_ptrace(parent, current, PTRACE_MODE_ATTACH);
 }
 
@@ -140,14 +132,11 @@ static int apparmor_capable(const struct cred *cred, struct user_namespace *ns,
 			    int cap, int audit)
 {
 	struct aa_profile *profile;
-	/* cap_capable returns 0 on success, else -EPERM */
-	int error = cap_capable(cred, ns, cap, audit);
-	if (!error) {
-		profile = aa_cred_profile(cred);
-		if (!unconfined(profile))
-			error = aa_capable(current, profile, cap, audit);
-	}
-	return error;
+
+	profile = aa_cred_profile(cred);
+	if (!unconfined(profile))
+		return aa_capable(current, profile, cap, audit);
+	return 0;
 }
 
 /**
@@ -375,7 +364,7 @@ static int apparmor_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 
 static int apparmor_file_open(struct file *file, const struct cred *cred)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = lsm_get_file(file, &apparmor_ops);
 	struct aa_profile *profile;
 	int error = 0;
 
@@ -409,8 +398,8 @@ static int apparmor_file_open(struct file *file, const struct cred *cred)
 static int apparmor_file_alloc_security(struct file *file)
 {
 	/* freed by apparmor_file_free_security */
-	file->f_security = aa_alloc_file_context(GFP_KERNEL);
-	if (!file->f_security)
+	lsm_set_file(file, aa_alloc_file_context(GFP_KERNEL), &apparmor_ops);
+	if (!lsm_get_file(file, &apparmor_ops))
 		return -ENOMEM;
 	return 0;
 
@@ -418,14 +407,15 @@ static int apparmor_file_alloc_security(struct file *file)
 
 static void apparmor_file_free_security(struct file *file)
 {
-	struct aa_file_cxt *cxt = file->f_security;
+	struct aa_file_cxt *cxt = lsm_get_file(file, &apparmor_ops);
 
+	lsm_set_file(file, NULL, &apparmor_ops);
 	aa_free_file_context(cxt);
 }
 
 static int common_file_perm(int op, struct file *file, u32 mask)
 {
-	struct aa_file_cxt *fcxt = file->f_security;
+	struct aa_file_cxt *fcxt = lsm_get_file(file, &apparmor_ops);
 	struct aa_profile *profile, *fprofile = aa_cred_profile(file->f_cred);
 	int error = 0;
 
@@ -472,7 +462,7 @@ static int common_mmap(int op, struct file *file, unsigned long prot,
 	struct dentry *dentry;
 	int mask = 0;
 
-	if (!file || !file->f_security)
+	if (!file || !lsm_get_file(file, &apparmor_ops))
 		return 0;
 
 	if (prot & PROT_READ)
@@ -510,7 +500,7 @@ static int apparmor_getprocattr(struct task_struct *task, char *name,
 	struct aa_profile *profile;
 	/* released below */
 	const struct cred *cred = get_task_cred(task);
-	struct aa_task_cxt *cxt = cred->security;
+	struct aa_task_cxt *cxt = lsm_get_cred(cred, &apparmor_ops);
 	profile = aa_cred_profile(cred);
 
 	if (strcmp(name, "current") == 0)
@@ -614,7 +604,7 @@ static int apparmor_task_setrlimit(struct task_struct *task,
 	return error;
 }
 
-static struct security_operations apparmor_ops = {
+struct security_operations apparmor_ops = {
 	.name =				"apparmor",
 
 	.ptrace_access_check =		apparmor_ptrace_access_check,
@@ -878,6 +868,7 @@ static int param_set_mode(const char *val, struct kernel_param *kp)
  */
 static int __init set_init_cxt(void)
 {
+	int rc;
 	struct cred *cred = (struct cred *)current->real_cred;
 	struct aa_task_cxt *cxt;
 
@@ -886,9 +877,9 @@ static int __init set_init_cxt(void)
 		return -ENOMEM;
 
 	cxt->profile = aa_get_profile(root_ns->unconfined);
-	cred->security = cxt;
+	rc = lsm_set_init_cred(cred, cxt, &apparmor_ops);
 
-	return 0;
+	return rc;
 }
 
 static int __init apparmor_init(void)
@@ -913,12 +904,6 @@ static int __init apparmor_init(void)
 		goto register_security_out;
 	}
 
-	error = register_security(&apparmor_ops);
-	if (error) {
-		AA_ERROR("Unable to register AppArmor\n");
-		goto set_init_cxt_out;
-	}
-
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
 	if (aa_g_profile_mode == APPARMOR_COMPLAIN)
@@ -930,9 +915,6 @@ static int __init apparmor_init(void)
 
 	return error;
 
-set_init_cxt_out:
-	aa_free_task_context(current->real_cred->security);
-
 register_security_out:
 	aa_free_root_ns();
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
