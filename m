From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] security: report the module name to security_module_request
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, dwalsh@redhat.com
Date: Tue, 03 Nov 2009 11:35:32 -0500
Message-ID: <20091103163532.28449.1998.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For SELinux to do better filtering in userspace we send the name of the
module along with the AVC denial when a program is denied module_request.

Example output:

type=SYSCALL msg=audit(11/03/2009 10:59:43.510:9) : arch=x86_64 syscall=write success=yes exit=2 a0=3 a1=7fc28c0d56c0 a2=2 a3=7fffca0d7440 items=0 ppid=1727 pid=1729 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=rpc.nfsd exe=/usr/sbin/rpc.nfsd subj=system_u:system_r:nfsd_t:s0 key=(null)
type=AVC msg=audit(11/03/2009 10:59:43.510:9) : avc:  denied  { module_request } for  pid=1729 comm=rpc.nfsd kmod="net-pf-10" scontext=system_u:system_r:nfsd_t:s0 tcontext=system_u:system_r:kernel_t:s0 tclass=system

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 include/linux/lsm_audit.h |   18 ++++++++++--------
 include/linux/security.h  |    7 ++++---
 kernel/kmod.c             |    8 ++++----
 security/capability.c     |    2 +-
 security/lsm_audit.c      |    4 ++++
 security/security.c       |    4 ++--
 security/selinux/hooks.c  |   13 +++++++++++--
 7 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 190c378..f78f83d 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -26,14 +26,15 @@
 
 /* Auxiliary data to use in generating the audit record. */
 struct common_audit_data {
-	char    type;
-#define LSM_AUDIT_DATA_FS      1
-#define LSM_AUDIT_DATA_NET     2
-#define LSM_AUDIT_DATA_CAP     3
-#define LSM_AUDIT_DATA_IPC     4
-#define LSM_AUDIT_DATA_TASK    5
-#define LSM_AUDIT_DATA_KEY     6
-#define LSM_AUDIT_NO_AUDIT     7
+	char type;
+#define LSM_AUDIT_DATA_FS	1
+#define LSM_AUDIT_DATA_NET	2
+#define LSM_AUDIT_DATA_CAP	3
+#define LSM_AUDIT_DATA_IPC	4
+#define LSM_AUDIT_DATA_TASK	5
+#define LSM_AUDIT_DATA_KEY	6
+#define LSM_AUDIT_NO_AUDIT	7
+#define LSM_AUDIT_DATA_KMOD	8
 	struct task_struct *tsk;
 	union 	{
 		struct {
@@ -66,6 +67,7 @@ struct common_audit_data {
 			char *key_desc;
 		} key_struct;
 #endif
+		char *kmod_name;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/include/linux/security.h b/include/linux/security.h
index 3f3844a..9c3a43b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -706,6 +706,7 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * @kernel_module_request:
  *	Ability to trigger the kernel to automatically upcall to userspace for
  *	userspace to load a kernel module with the given name.
+ *	@kmod_name name of the module requested by the kernel
  *	Return 0 if successful.
  * @task_setuid:
  *	Check permission before setting one or more of the user identity
@@ -1577,7 +1578,7 @@ struct security_operations {
 	void (*cred_transfer)(struct cred *new, const struct cred *old);
 	int (*kernel_act_as)(struct cred *new, u32 secid);
 	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
-	int (*kernel_module_request)(void);
+	int (*kernel_module_request)(char *kmod_name);
 	int (*task_setuid) (uid_t id0, uid_t id1, uid_t id2, int flags);
 	int (*task_fix_setuid) (struct cred *new, const struct cred *old,
 				int flags);
@@ -1843,7 +1844,7 @@ void security_commit_creds(struct cred *new, const struct cred *old);
 void security_transfer_creds(struct cred *new, const struct cred *old);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
-int security_kernel_module_request(void);
+int security_kernel_module_request(char *kmod_name);
 int security_task_setuid(uid_t id0, uid_t id1, uid_t id2, int flags);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags);
@@ -2409,7 +2410,7 @@ static inline int security_kernel_create_files_as(struct cred *cred,
 	return 0;
 }
 
-static inline int security_kernel_module_request(void)
+static inline int security_kernel_module_request(char *kmod_name)
 {
 	return 0;
 }
diff --git a/kernel/kmod.c b/kernel/kmod.c
index 9fcb53a..25b1031 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -80,16 +80,16 @@ int __request_module(bool wait, const char *fmt, ...)
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
 
-	ret = security_kernel_module_request();
-	if (ret)
-		return ret;
-
 	va_start(args, fmt);
 	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
 	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
+	ret = security_kernel_module_request(module_name);
+	if (ret)
+		return ret;
+
 	/* If modprobe needs a service that is in a module, we get a recursive
 	 * loop.  Limit the number of running kmod threads to max_threads/2 or
 	 * MAX_KMOD_CONCURRENT, whichever is the smaller.  A cleaner method
diff --git a/security/capability.c b/security/capability.c
index d30a8e8..10f23a4 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -421,7 +421,7 @@ static int cap_kernel_create_files_as(struct cred *new, struct inode *inode)
 	return 0;
 }
 
-static int cap_kernel_module_request(void)
+static int cap_kernel_module_request(char *kmod_name)
 {
 	return 0;
 }
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index e04566a..acba3df 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -354,6 +354,10 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 		}
 		break;
 #endif
+	case LSM_AUDIT_DATA_KMOD:
+		audit_log_format(ab, " kmod=");
+		audit_log_untrustedstring(ab, a->u.kmod_name);
+		break;
 	} /* switch (a->type) */
 }
 
diff --git a/security/security.c b/security/security.c
index 48ec2b4..739033e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -761,9 +761,9 @@ int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 	return security_ops->kernel_create_files_as(new, inode);
 }
 
-int security_kernel_module_request(void)
+int security_kernel_module_request(char *kmod_name)
 {
-	return security_ops->kernel_module_request();
+	return security_ops->kernel_module_request(kmod_name);
 }
 
 int security_task_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0c0c1bf..18e2e5b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3338,9 +3338,18 @@ static int selinux_kernel_create_files_as(struct cred *new, struct inode *inode)
 	return 0;
 }
 
-static int selinux_kernel_module_request(void)
+static int selinux_kernel_module_request(char *kmod_name)
 {
-	return task_has_system(current, SYSTEM__MODULE_REQUEST);
+	u32 sid;
+	struct common_audit_data ad;
+
+	sid = task_sid(current);
+
+	COMMON_AUDIT_DATA_INIT(&ad, KMOD);
+	ad.u.kmod_name = kmod_name;
+
+	return avc_has_perm(sid, SECINITSID_KERNEL, SECCLASS_SYSTEM,
+			    SYSTEM__MODULE_REQUEST, &ad);
 }
 
 static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
