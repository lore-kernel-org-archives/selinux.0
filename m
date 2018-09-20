Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K0MGHE020912
 for <selinux@tycho.nsa.gov>; Wed, 19 Sep 2018 20:22:16 -0400
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
Message-ID: <8ef63a94-c7b6-226d-2d60-a05f79406819@schaufler-ca.com>
Date: Wed, 19 Sep 2018 17:21:53 -0700
MIME-Version: 1.0
In-Reply-To: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH v3 16/16] LSM: Blob sharing support for S.A.R.A and LandLock
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LSM: Blob sharing support for S.A.R.A and LandLock

Two proposed security modules require the ability to
share security blobs with existing "major" security modules.
These modules, S.A.R.A and LandLock, provide significantly
different services than SELinux, Smack or AppArmor. Using
either in conjunction with the existing modules is quite
reasonable. S.A.R.A requires access to the cred, inode and
task blobs, while LandLock uses the cred, file, inode and
ipc blobs.

The use of the cred, file, inode, ipc and task blobs has been
abstracted in preceding patches in the series. This
patch teaches the affected security modules how to access
the part of the blob set aside for their use in the case
where blobs are shared. The configuration option
CONFIG_SECURITY_STACKING identifies systems where the
blobs may be shared.

The mechanism for selecting which security modules are
active has been changed to allow non-conflicting "major"
security modules to be used together. At this time the
TOMOYO module can safely be used with any of the others.
The two new modules would be non-conflicting as well.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst | 14 +++--
 include/linux/lsm_hooks.h               |  2 +-
 security/Kconfig                        | 81 +++++++++++++++++++++++++
 security/apparmor/include/cred.h        |  8 +++
 security/apparmor/include/file.h        |  9 ++-
 security/apparmor/include/lib.h         |  4 ++
 security/apparmor/lsm.c                 |  8 ++-
 security/security.c                     | 30 ++++++++-
 security/selinux/hooks.c                |  3 +-
 security/selinux/include/objsec.h       | 12 ++++
 security/smack/smack.h                  | 13 ++++
 security/smack/smack_lsm.c              | 17 +++---
 security/tomoyo/common.h                | 12 +++-
 security/tomoyo/tomoyo.c                |  3 +-
 14 files changed, 194 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index 9842e21afd4a..d3d8af174042 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -17,10 +17,16 @@ MAC extensions, other extensions can be built using the LSM to provide
 specific changes to system operation when these tweaks are not available
 in the core functionality of Linux itself.
 
-The Linux capabilities modules will always be included. This may be
-followed by any number of "minor" modules and at most one "major" module.
-For more details on capabilities, see ``capabilities(7)`` in the Linux
-man-pages project.
+The Linux capabilities modules will always be included. For more details
+on capabilities, see ``capabilities(7)`` in the Linux man-pages project.
+
+Security modules that do not use the security data blobs maintained
+by the LSM infrastructure are considered "minor" modules. These may be
+included at compile time and stacked explicitly. Security modules that
+use the LSM maintained security blobs are considered "major" modules.
+These may only be stacked if the CONFIG_LSM_STACKED configuration
+option is used. If this is chosen all of the security modules selected
+will be used.
 
 A list of the active security modules can be found by reading
 ``/sys/kernel/security/lsm``. This is a comma separated list, and
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f6dbde28833a..7e8b32fdf576 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2082,7 +2082,7 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
+extern bool __init security_module_enable(const char *lsm, const bool stacked);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/Kconfig b/security/Kconfig
index 22f7664c4977..ed48025ae9e0 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -36,6 +36,28 @@ config SECURITY_WRITABLE_HOOKS
 	bool
 	default n
 
+config SECURITY_STACKING
+	bool "Security module stacking"
+	depends on SECURITY
+	help
+	  Allows multiple major security modules to be stacked.
+	  Modules are invoked in the order registered with a
+	  "bail on fail" policy, in which the infrastructure
+	  will stop processing once a denial is detected. Not
+	  all modules can be stacked. SELinux, Smack and AppArmor are
+	  known to be incompatible. User space components may
+	  have trouble identifying the security module providing
+	  data in some cases.
+
+	  If you select this option you will have to select which
+	  of the stackable modules you wish to be active. The
+	  "Default security module" will be ignored. The boot line
+	  "security=" option can be used to specify that one of
+	  the modules identifed for stacking should be used instead
+	  of the entire stack.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_LSM_DEBUG
 	bool "Enable debugging of the LSM infrastructure"
 	depends on SECURITY
@@ -250,6 +272,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
+menu "Security Module Selection"
+	visible if !SECURITY_STACKING
+
 choice
 	prompt "Default security module"
 	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
@@ -289,3 +314,59 @@ config DEFAULT_SECURITY
 
 endmenu
 
+menu "Security Module Stack"
+	visible if SECURITY_STACKING
+
+choice
+	prompt "Stacked 'extreme' security module"
+	default SECURITY_SELINUX_STACKED if SECURITY_SELINUX
+	default SECURITY_SMACK_STACKED if SECURITY_SMACK
+	default SECURITY_APPARMOR_STACKED if SECURITY_APPARMOR
+
+	help
+	  Enable an extreme security module. These modules cannot
+	  be used at the same time.
+
+	config SECURITY_SELINUX_STACKED
+		bool "SELinux" if SECURITY_SELINUX=y
+	help
+	  This option instructs the system to use the SELinux checks.
+	  At this time the Smack security module is incompatible with this
+	  module.
+	  At this time the AppArmor security module is incompatible with this
+	  module.
+
+	config SECURITY_SMACK_STACKED
+		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+	help
+	  This option instructs the system to use the Smack checks.
+	  At this time the SELinux security module is incompatible with this
+	  module.
+	  At this time the AppArmor security module is incompatible with this
+	  module.
+
+	config SECURITY_APPARMOR_STACKED
+		bool "AppArmor" if SECURITY_APPARMOR=y
+	help
+	  This option instructs the system to use the AppArmor checks.
+	  At this time the SELinux security module is incompatible with this
+	  module.
+	  At this time the Smack security module is incompatible with this
+	  module.
+
+endchoice
+
+config SECURITY_TOMOYO_STACKED
+	bool "TOMOYO support is enabled by default"
+	depends on SECURITY_TOMOYO && SECURITY_STACKING
+	default n
+	help
+	  This option instructs the system to use the TOMOYO checks.
+	  If not selected the module will not be invoked.
+	  Stacked security modules may interact in unexpected ways.
+
+	  If you are unsure how to answer this question, answer N.
+
+endmenu
+
+endmenu
diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
index a90eae76d7c1..be7575adf6f0 100644
--- a/security/apparmor/include/cred.h
+++ b/security/apparmor/include/cred.h
@@ -25,7 +25,11 @@
 
 static inline struct aa_label *cred_label(const struct cred *cred)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
+#else
 	struct aa_label **blob = cred->security;
+#endif
 
 	AA_BUG(!blob);
 	return *blob;
@@ -34,7 +38,11 @@ static inline struct aa_label *cred_label(const struct cred *cred)
 static inline void set_cred_label(const struct cred *cred,
 				  struct aa_label *label)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	struct aa_label **blob = cred->security + apparmor_blob_sizes.lbs_cred;
+#else
 	struct aa_label **blob = cred->security;
+#endif
 
 	AA_BUG(!blob);
 	*blob = label;
diff --git a/security/apparmor/include/file.h b/security/apparmor/include/file.h
index 4c2c8ac8842f..aeb757471cc0 100644
--- a/security/apparmor/include/file.h
+++ b/security/apparmor/include/file.h
@@ -32,7 +32,14 @@ struct path;
 				 AA_MAY_CHMOD | AA_MAY_CHOWN | AA_MAY_LOCK | \
 				 AA_EXEC_MMAP | AA_MAY_LINK)
 
-#define file_ctx(X) ((struct aa_file_ctx *)(X)->f_security)
+static inline struct aa_file_ctx *file_ctx(struct file *file)
+{
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + apparmor_blob_sizes.lbs_file;
+#else
+	return file->f_security;
+#endif
+}
 
 /* struct aa_file_ctx - the AppArmor context the file was opened in
  * @lock: lock to update the ctx
diff --git a/security/apparmor/include/lib.h b/security/apparmor/include/lib.h
index 6505e1ad9e23..bbe9b384d71d 100644
--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/lsm_hooks.h>
 
 #include "match.h"
 
@@ -55,6 +56,9 @@ const char *aa_splitn_fqname(const char *fqname, size_t n, const char **ns_name,
 			     size_t *ns_len);
 void aa_info_message(const char *str);
 
+/* Security blob offsets */
+extern struct lsm_blob_sizes apparmor_blob_sizes;
+
 /**
  * aa_strneq - compare null terminated @str to a non null terminated substring
  * @str: a null terminated string
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index c97dc3dbb515..50da984fca54 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1544,7 +1544,9 @@ static int __init apparmor_init(void)
 	int error;
 
 	if (!finish) {
-		if (apparmor_enabled && security_module_enable("apparmor"))
+		if (apparmor_enabled &&
+		    security_module_enable("apparmor",
+				IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED)))
 			security_add_blobs(&apparmor_blob_sizes);
 		else
 			apparmor_enabled = false;
@@ -1552,7 +1554,9 @@ static int __init apparmor_init(void)
 		return 0;
 	}
 
-	if (!apparmor_enabled || !security_module_enable("apparmor")) {
+	if (!apparmor_enabled ||
+	    !security_module_enable("apparmor",
+				IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED))) {
 		aa_info_message("AppArmor disabled by boot time parameter");
 		apparmor_enabled = false;
 		return 0;
diff --git a/security/security.c b/security/security.c
index a151d728aed2..e7c8506041f1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -37,6 +37,7 @@
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
+#define MODULE_STACK		"(stacking)"
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
@@ -49,7 +50,11 @@ static struct lsm_blob_sizes blob_sizes;
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
+#ifdef CONFIG_SECURITY_STACKING
+	MODULE_STACK;
+#else
 	CONFIG_DEFAULT_SECURITY;
+#endif
 
 static void __init do_security_initcalls(void)
 {
@@ -173,6 +178,7 @@ static int lsm_append(char *new, char **result)
 /**
  * security_module_enable - Load given security module on boot ?
  * @module: the name of the module
+ * @stacked: indicates that the module wants to be stacked
  *
  * Each LSM must pass this method before registering its own operations
  * to avoid security registration races. This method may also be used
@@ -188,9 +194,29 @@ static int lsm_append(char *new, char **result)
  *
  * Otherwise, return false.
  */
-int __init security_module_enable(const char *module)
+bool __init security_module_enable(const char *lsm, const bool stacked)
 {
-	return !strcmp(module, chosen_lsm);
+#ifdef CONFIG_SECURITY_STACKING
+	/*
+	 * Module defined on the command line security=XXXX
+	 */
+	if (strcmp(chosen_lsm, MODULE_STACK)) {
+		if (!strcmp(lsm, chosen_lsm)) {
+			pr_info("Command line sets the %s security module.\n",
+				lsm);
+			return true;
+		}
+		return false;
+	}
+	/*
+	 * Module configured as stacked.
+	 */
+	return stacked;
+#else
+	if (strcmp(lsm, chosen_lsm) == 0)
+		return true;
+	return false;
+#endif
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3c53a3ba480e..44337d2349d9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6981,7 +6981,8 @@ static __init int selinux_init(void)
 {
 	static int finish;
 
-	if (!security_module_enable("selinux")) {
+	if (!security_module_enable("selinux",
+				IS_ENABLED(CONFIG_SECURITY_SELINUX_STACKED))) {
 		selinux_enabled = 0;
 		return 0;
 	}
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 5bf9f280e9b2..ee4471213909 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -160,18 +160,30 @@ struct bpf_security_struct {
 extern struct lsm_blob_sizes selinux_blob_sizes;
 static inline struct task_security_struct *selinux_cred(const struct cred *cred)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return cred->security + selinux_blob_sizes.lbs_cred;
+#else
 	return cred->security;
+#endif
 }
 
 static inline struct file_security_struct *selinux_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + selinux_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }
 
 static inline struct inode_security_struct *selinux_inode(
 						const struct inode *inode)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return inode->i_security + selinux_blob_sizes.lbs_inode;
+#else
 	return inode->i_security;
+#endif
 }
 
 static inline struct msg_security_struct *selinux_msg_msg(
diff --git a/security/smack/smack.h b/security/smack/smack.h
index dffa0ba8fd49..59d0bc994304 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -337,6 +337,7 @@ extern struct smack_known *smack_syslog_label;
 extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
+extern struct lsm_blob_sizes smack_blob_sizes;
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
@@ -359,17 +360,29 @@ extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
 static inline struct task_smack *smack_cred(const struct cred *cred)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return cred->security + smack_blob_sizes.lbs_cred;
+#else
 	return cred->security;
+#endif
 }
 
 static inline struct smack_known **smack_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + smack_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }
 
 static inline struct inode_smack *smack_inode(const struct inode *inode)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return inode->i_security + smack_blob_sizes.lbs_inode;
+#else
 	return inode->i_security;
+#endif
 }
 
 static inline struct smack_known **smack_msg_msg(const struct msg_msg *msg)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8f3b809d7c26..0156ffea7f8c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3475,18 +3475,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
 {
 	struct smack_known *skp = smk_of_task_struct(p);
 	char *cp;
-	int slen;
 
-	if (strcmp(name, "current") != 0)
+	if (strcmp(name, "current") == 0) {
+		cp = kstrdup(skp->smk_known, GFP_KERNEL);
+		if (cp == NULL)
+			return -ENOMEM;
+	} else
 		return -EINVAL;
 
-	cp = kstrdup(skp->smk_known, GFP_KERNEL);
-	if (cp == NULL)
-		return -ENOMEM;
-
-	slen = strlen(cp);
 	*value = cp;
-	return slen;
+	return strlen(cp);
 }
 
 /**
@@ -4734,7 +4732,8 @@ static __init int smack_init(void)
 	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
-	if (!security_module_enable("smack"))
+	if (!security_module_enable("smack",
+				IS_ENABLED(CONFIG_SECURITY_SMACK_STACKED)))
 		return 0;
 
 	if (!finish) {
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0110bebe86e2..f386f92c57c5 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -1087,6 +1087,7 @@ extern struct tomoyo_domain_info tomoyo_kernel_domain;
 extern struct tomoyo_policy_namespace tomoyo_kernel_namespace;
 extern unsigned int tomoyo_memory_quota[TOMOYO_MAX_MEMORY_STAT];
 extern unsigned int tomoyo_memory_used[TOMOYO_MAX_MEMORY_STAT];
+extern struct lsm_blob_sizes tomoyo_blob_sizes;
 
 /********** Inlined functions. **********/
 
@@ -1206,7 +1207,11 @@ static inline void tomoyo_put_group(struct tomoyo_group *group)
  */
 static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return cred->security + tomoyo_blob_sizes.lbs_cred;
+#else
 	return cred->security;
+#endif
 }
 
 /**
@@ -1216,8 +1221,13 @@ static inline struct tomoyo_domain_info **tomoyo_cred(const struct cred *cred)
  */
 static inline struct tomoyo_domain_info *tomoyo_domain(void)
 {
-	struct tomoyo_domain_info **blob = tomoyo_cred(current_cred());
+	const struct cred *cred = current_cred();
+	struct tomoyo_domain_info **blob;
+
+	if (cred->security == NULL)
+		return NULL;
 
+	blob = tomoyo_cred(cred);
 	return *blob;
 }
 
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index bb84e6ec3886..fa121ad8534a 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -564,7 +564,8 @@ static int __init tomoyo_init(void)
 	struct cred *cred = (struct cred *) current_cred();
 	struct tomoyo_domain_info **blob;
 
-	if (!security_module_enable("tomoyo")) {
+	if (!security_module_enable("tomoyo",
+				IS_ENABLED(CONFIG_SECURITY_TOMOYO_STACKED))) {
 		tomoyo_enabled = false;
 		return 0;
 	}
-- 
2.17.1
