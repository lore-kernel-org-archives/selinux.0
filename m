Message-ID: <1459958221.7680.2.camel@gmail.com>
Subject: [RFC][PATCH] selinux: distinguish non-init user namespace
 capability checks
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, Daniel J Walsh <dwalsh@redhat.com>,
 Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 06 Apr 2016 08:57:01 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Distinguish capability checks against a target associated
with the init user namespace versus capability checks against
a target associated with a non-init user namespace by defining
and using separate security classes for the latter.

This is needed to support e.g. Chrome usage of user namespaces
for the Chrome sandbox without needing to allow Chrome to also
exercise capabilities on targets in the init user namespace.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 14 +++++++-------
 security/selinux/include/classmap.h | 28 ++++++++++++++++++----------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fce7dc8..a9ca5ee 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1622,7 +1622,7 @@ static int current_has_perm(const struct task_struct *tsk,
 
 /* Check whether a task is allowed to use a capability. */
 static int cred_has_capability(const struct cred *cred,
-			       int cap, int audit)
+			       int cap, int audit, bool initns)
 {
 	struct common_audit_data ad;
 	struct av_decision avd;
@@ -1636,10 +1636,10 @@ static int cred_has_capability(const struct cred *cred,
 
 	switch (CAP_TO_INDEX(cap)) {
 	case 0:
-		sclass = SECCLASS_CAPABILITY;
+		sclass = initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
 		break;
 	case 1:
-		sclass = SECCLASS_CAPABILITY2;
+		sclass = initns ? SECCLASS_CAPABILITY2 : SECCLASS_CAP2_USERNS;
 		break;
 	default:
 		printk(KERN_ERR
@@ -2142,7 +2142,7 @@ static int selinux_capset(struct cred *new, const struct cred *old,
 static int selinux_capable(const struct cred *cred, struct user_namespace *ns,
 			   int cap, int audit)
 {
-	return cred_has_capability(cred, cap, audit);
+	return cred_has_capability(cred, cap, audit, ns == &init_user_ns);
 }
 
 static int selinux_quotactl(int cmds, int type, int id, struct super_block *sb)
@@ -2220,7 +2220,7 @@ static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 	int rc, cap_sys_admin = 0;
 
 	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
-					SECURITY_CAP_NOAUDIT);
+				 SECURITY_CAP_NOAUDIT, true);
 	if (rc == 0)
 		cap_sys_admin = 1;
 
@@ -3201,7 +3201,7 @@ static int selinux_inode_getsecurity(struct inode *inode, const char *name, void
 			    SECURITY_CAP_NOAUDIT);
 	if (!error)
 		error = cred_has_capability(current_cred(), CAP_MAC_ADMIN,
-					    SECURITY_CAP_NOAUDIT);
+					    SECURITY_CAP_NOAUDIT, true);
 	if (!error)
 		error = security_sid_to_context_force(isec->sid, &context,
 						      &size);
@@ -3376,7 +3376,7 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case KDSKBENT:
 	case KDSKBSENT:
 		error = cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
-					    SECURITY_CAP_AUDIT);
+					    SECURITY_CAP_AUDIT, true);
 		break;
 
 	/* default case assumes that the command will go
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8fbd138..1f1f4b2 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -12,6 +12,18 @@
 #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
 	    "write", "associate", "unix_read", "unix_write"
 
+#define COMMON_CAP_PERMS  "chown", "dac_override", "dac_read_search", \
+	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap", \
+	    "linux_immutable", "net_bind_service", "net_broadcast", \
+	    "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module", \
+	    "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin", \
+	    "sys_boot", "sys_nice", "sys_resource", "sys_time", \
+	    "sys_tty_config", "mknod", "lease", "audit_write", \
+	    "audit_control", "setfcap"
+
+#define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
+		"wake_alarm", "block_suspend", "audit_read"
+
 /*
  * Note: The name for any socket class should be suffixed by "socket",
  *	 and doesn't contain more than one substr of "socket".
@@ -34,14 +46,7 @@ struct security_class_mapping secclass_map[] = {
 	  { "ipc_info", "syslog_read", "syslog_mod",
 	    "syslog_console", "module_request", "module_load", NULL } },
 	{ "capability",
-	  { "chown", "dac_override", "dac_read_search",
-	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap",
-	    "linux_immutable", "net_bind_service", "net_broadcast",
-	    "net_admin", "net_raw", "ipc_lock", "ipc_owner", "sys_module",
-	    "sys_rawio", "sys_chroot", "sys_ptrace", "sys_pacct", "sys_admin",
-	    "sys_boot", "sys_nice", "sys_resource", "sys_time",
-	    "sys_tty_config", "mknod", "lease", "audit_write",
-	    "audit_control", "setfcap", NULL } },
+	  { COMMON_CAP_PERMS, NULL } },
 	{ "filesystem",
 	  { "mount", "remount", "unmount", "getattr",
 	    "relabelfrom", "relabelto", "associate", "quotamod",
@@ -150,12 +155,15 @@ struct security_class_mapping secclass_map[] = {
 	{ "memprotect", { "mmap_zero", NULL } },
 	{ "peer", { "recv", NULL } },
 	{ "capability2",
-	  { "mac_override", "mac_admin", "syslog", "wake_alarm", "block_suspend",
-	    "audit_read", NULL } },
+	  { COMMON_CAP2_PERMS, NULL } },
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket",
 	  { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder", { "impersonate", "call", "set_context_mgr", "transfer",
 		      NULL } },
+	{ "cap_userns",
+	  { COMMON_CAP_PERMS, NULL } },
+	{ "cap2_userns",
+	  { COMMON_CAP2_PERMS, NULL } },
 	{ NULL }
   };
-- 
2.8.0
