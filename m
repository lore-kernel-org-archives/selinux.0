Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w281rY5l030442
 for <selinux@tycho.nsa.gov>; Wed, 7 Mar 2018 20:53:34 -0500
To: LSM <linux-security-module@vger.kernel.org>,
 James Morris <jmorris@namei.org>
Cc: John Johansen <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Paul Moore <paul@paul-moore.com>, Kees Cook <keescook@chromium.org>,
 Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
 SMACK-announce@lists.01.org, Casey Schaufler <casey@schaufler-ca.com>
References: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f74e3daf-ab58-be23-1ce2-cfe000c25195@schaufler-ca.com>
Date: Wed, 7 Mar 2018 17:53:26 -0800
MIME-Version: 1.0
In-Reply-To: <d2c25c38-e19d-1e08-8c49-4726a34e72bb@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Subject: [PATCH 6/8] LSM: General stacking
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Subject: [PATCH 6/8] LSM: General stacking

Leverage the infrastructure management of the security blobs
to allow stacking of security modules in all but the most
extreme case. Security modules are informed of the location
of their data within the blobs at module initialization.

Stacking is optional. If stacking is not configured the old
limit of one "major" security module applies. If stacking is
configured TOMOYO can be configured with an of the other
modules. SELinux, Smack and AppArmor use (or in the AppArmor
case, threaten to use) secids, which are not (yet) shareable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 Documentation/admin-guide/LSM/index.rst | 14 ++++--
 include/linux/lsm_hooks.h               |  2 +-
 security/Kconfig                        | 86 +++++++++++++++++++++++++++++++++
 security/apparmor/include/context.h     | 10 ++++
 security/apparmor/lsm.c                 |  8 ++-
 security/security.c                     | 30 +++++++++++-
 security/selinux/hooks.c                |  3 +-
 security/selinux/include/objsec.h       |  8 +++
 security/smack/smack.h                  |  9 ++++
 security/smack/smack_lsm.c              | 17 +++----
 security/tomoyo/common.h                | 12 ++++-
 security/tomoyo/tomoyo.c                |  3 +-
 12 files changed, 181 insertions(+), 21 deletions(-)

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
index 03f036ab7b59..2e05734bc46e 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2030,7 +2030,7 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #define __lsm_ro_after_init	__ro_after_init
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
-extern int __init security_module_enable(const char *module);
+extern bool __init security_module_enable(const char *lsm, const bool stacked);
 extern void __init capability_add_hooks(void);
 #ifdef CONFIG_SECURITY_YAMA
 extern void __init yama_add_hooks(void);
diff --git a/security/Kconfig b/security/Kconfig
index 116dba966553..8225388b81c3 100644
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
+	  all modules can be stacked. SELinux and Smack are
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
@@ -251,6 +273,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
+menu "Security Module Selection"
+	visible if !SECURITY_STACKING
+
 choice
 	prompt "Default security module"
 	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
@@ -290,3 +315,64 @@ config DEFAULT_SECURITY
 
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
+	config SECURITY_NOTHING_STACKED
+		bool "Use no 'extreme' security module"
+	help
+	  Use none of the SELinux, Smack or AppArmor security module.
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
diff --git a/security/apparmor/include/context.h b/security/apparmor/include/context.h
index c6e106a533e8..c6d5dbbd18b0 100644
--- a/security/apparmor/include/context.h
+++ b/security/apparmor/include/context.h
@@ -55,9 +55,15 @@ int aa_set_current_hat(struct aa_label *label, u64 token);
 int aa_restore_previous_label(u64 cookie);
 struct aa_label *aa_get_task_label(struct task_struct *task);
 
+extern struct lsm_blob_sizes apparmor_blob_sizes;
+
 static inline struct aa_task_ctx *apparmor_cred(const struct cred *cred)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return cred->security + apparmor_blob_sizes.lbs_cred;
+#else
 	return cred->security;
+#endif
 }
 
 /**
@@ -89,7 +95,11 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
 
 static inline struct aa_file_ctx *apparmor_file(const struct file *file)
 {
+#ifdef CONFIG_SECURITY_STACKING
+	return file->f_security + apparmor_blob_sizes.lbs_file;
+#else
 	return file->f_security;
+#endif
 }
 
 /**
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 03c7cbce4853..f0b1694c4a6f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1105,7 +1105,9 @@ static int __init apparmor_init(void)
 	int error;
 
 	if (!finish) {
-		if (apparmor_enabled && security_module_enable("apparmor"))
+		if (apparmor_enabled &&
+		    security_module_enable("apparmor",
+				IS_ENABLED(CONFIG_SECURITY_APPARMOR_STACKED)))
 			security_add_blobs(&apparmor_blob_sizes);
 		else
 			apparmor_enabled = false;
@@ -1113,7 +1115,9 @@ static int __init apparmor_init(void)
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
index 4ca49b5074f8..42255b40768a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -36,6 +36,7 @@
 
 /* Maximum number of letters for an LSM name string */
 #define SECURITY_NAME_MAX	10
+#define MODULE_STACK		"(stacking)"
 
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
@@ -48,7 +49,11 @@ static struct lsm_blob_sizes blob_sizes;
 
 /* Boot-time LSM user choice */
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
+#ifdef CONFIG_SECURITY_STACKING
+	MODULE_STACK;
+#else
 	CONFIG_DEFAULT_SECURITY;
+#endif
 
 static void __init do_security_initcalls(void)
 {
@@ -168,6 +173,7 @@ static int lsm_append(char *new, char **result)
 /**
  * security_module_enable - Load given security module on boot ?
  * @module: the name of the module
+ * @stacked: indicates that the module wants to be stacked
  *
  * Each LSM must pass this method before registering its own operations
  * to avoid security registration races. This method may also be used
@@ -183,9 +189,29 @@ static int lsm_append(char *new, char **result)
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
index cb51b66c483b..5aa8caf2e23d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6454,7 +6454,8 @@ static __init int selinux_init(void)
 {
 	static int finish;
 
-	if (!security_module_enable("selinux")) {
+	if (!security_module_enable("selinux",
+				IS_ENABLED(CONFIG_SECURITY_SELINUX_STACKED))) {
 		selinux_enabled = 0;
 		return 0;
 	}
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 56b9428ac934..e3f4f7b57b23 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -159,12 +159,20 @@ extern struct lsm_blob_sizes selinux_blob_sizes;
 
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
diff --git a/security/smack/smack.h b/security/smack/smack.h
index d2df0af9e5b5..87ced0fc1a19 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -337,6 +337,7 @@ extern struct smack_known *smack_syslog_label;
 extern struct smack_known *smack_unconfined;
 #endif
 extern int smack_ptrace_rule;
+extern struct lsm_blob_sizes smack_blob_sizes;
 
 extern struct smack_known smack_known_floor;
 extern struct smack_known smack_known_hat;
@@ -359,12 +360,20 @@ extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
 
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
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 5197c7bf7f63..78086e5dc29f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3424,18 +3424,16 @@ static int smack_getprocattr(struct task_struct *p, char *name, char **value)
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
@@ -4674,7 +4672,8 @@ static __init int smack_init(void)
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
index 821ca242a194..eb4b886b6076 100644
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
2.14.3
