Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u33LvXIQ021853
 for <selinux@tycho.nsa.gov>; Sun, 3 Apr 2016 17:57:33 -0400
Received: by mail-pa0-f47.google.com with SMTP id tt10so129946512pab.3
 for <selinux@tycho.nsa.gov>; Sun, 03 Apr 2016 14:57:32 -0700 (PDT)
From: Jeff Vander Stoep <jeffv@google.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov,
 Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH v2] selinux: restrict kernel module loading
Date: Sun,  3 Apr 2016 14:57:00 -0700
Message-Id: <1459720620-7987-1-git-send-email-jeffv@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Utilize existing kernel_read_file hook on kernel module load.
Add module_load permission to the system class.

Enforces restrictions on kernel module origin when calling the
finit_module syscall. The hook checks that source type has
permission module_load for the target type.
Example for finit_module:

allow foo bar_file:system module_load;

Similarly restrictions are enforced on kernel module loading when
calling the init_module syscall. The hook checks that source
type has permission module_load with itself as the target object
because the kernel module is sourced from the calling process.
Example for init_module:

allow foo foo:system module_load;

Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
v2: The target type for init_module changed from SECINITSID_KERNEL
to the same type as the source.

 security/selinux/hooks.c            | 52 +++++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3fa3ca5..f870c4d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3719,6 +3719,57 @@ static int selinux_kernel_module_request(char *kmod_name)
 			    SYSTEM__MODULE_REQUEST, &ad);
 }
 
+static int selinux_kernel_module_from_file(struct file *file)
+{
+	struct common_audit_data ad;
+	struct inode_security_struct *isec;
+	struct file_security_struct *fsec;
+	struct inode *inode;
+	u32 sid = current_sid();
+	int rc;
+
+	/* init_module */
+	if (file == NULL) {
+		rc = avc_has_perm(sid, sid, SECCLASS_SYSTEM,
+					SYSTEM__MODULE_LOAD, NULL);
+		goto out;
+	}
+
+	/* finit_module */
+	ad.type = LSM_AUDIT_DATA_PATH;
+	ad.u.path = file->f_path;
+
+	inode = file_inode(file);
+	isec = inode->i_security;
+	fsec = file->f_security;
+
+	if (sid != fsec->sid) {
+		rc = avc_has_perm(sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
+		if (rc)
+			goto out;
+	}
+
+	rc = avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
+				SYSTEM__MODULE_LOAD, &ad);
+out:
+	return rc;
+}
+
+static selinux_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+{
+	int rc = 0;
+
+	switch (id) {
+	case READING_MODULE:
+		rc = selinux_kernel_module_from_file(file);
+		break;
+	default:
+		break;
+	}
+
+	return rc;
+}
+
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
 {
 	return current_has_perm(p, PROCESS__SETPGID);
@@ -6022,6 +6073,7 @@ static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(kernel_act_as, selinux_kernel_act_as),
 	LSM_HOOK_INIT(kernel_create_files_as, selinux_kernel_create_files_as),
 	LSM_HOOK_INIT(kernel_module_request, selinux_kernel_module_request),
+	LSM_HOOK_INIT(kernel_read_file, selinux_kernel_read_file),
 	LSM_HOOK_INIT(task_setpgid, selinux_task_setpgid),
 	LSM_HOOK_INIT(task_getpgid, selinux_task_getpgid),
 	LSM_HOOK_INIT(task_getsid, selinux_task_getsid),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index ef83c4b..8fbd138 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -32,7 +32,7 @@ struct security_class_mapping secclass_map[] = {
 	    "setsockcreate", NULL } },
 	{ "system",
 	  { "ipc_info", "syslog_read", "syslog_mod",
-	    "syslog_console", "module_request", NULL } },
+	    "syslog_console", "module_request", "module_load", NULL } },
 	{ "capability",
 	  { "chown", "dac_override", "dac_read_search",
 	    "fowner", "fsetid", "kill", "setgid", "setuid", "setpcap",
-- 
2.8.0.rc3.226.g39d4020
