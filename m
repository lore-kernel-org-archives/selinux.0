Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAUMK6u9013289
	for <selinux@tycho.nsa.gov>; Fri, 30 Nov 2012 17:20:06 -0500
Message-ID: <50B930FC.4070106@schaufler-ca.com>
Date: Fri, 30 Nov 2012 14:19:40 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>,
        LSM <linux-security-module@vger.kernel.org>
CC: SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: [PATCH v9 1/2] LSM: Multiple concurrent LSMs
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v9 1/2] LSM: Multiple concurrent LSMs

Infrastructure changes in support of multiple concurrent
Linux Security Modules.

Replaces the single vector of security operations
with a vector of security operation lists. Moves the
default capability operations into the basic hook
handling. Pulls commoncap function use out of the
LSMs. Manages sets of security blobs.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---

 include/linux/lsm.h      |  172 ++++
 include/linux/security.h |  218 +++++-
 security/Kconfig         |   64 +-
 security/Makefile        |    3 +-
 security/capability.c    | 1075 -------------------------
 security/commoncap.c     |    6 -
 security/inode.c         |   46 +-
 security/security.c      | 1944 +++++++++++++++++++++++++++++++++++++++-------
 8 files changed, 2106 insertions(+), 1422 deletions(-)

diff --git a/include/linux/lsm.h b/include/linux/lsm.h
new file mode 100644
index 0000000..4177d59
--- /dev/null
+++ b/include/linux/lsm.h
@@ -0,0 +1,172 @@
+/*
+ *
+ * Copyright (C) 2012 Casey Schaufler <casey@schaufler-ca.com>
+ * Copyright (C) 2012 Intel Corporation
+ *
+ *	This program is free software; you can redistribute it and/or modify
+ *	it under the terms of the GNU General Public License as published by
+ *	the Free Software Foundation, version 2.
+ *
+ * Author:
+ *	Casey Schaufler <casey@schaufler-ca.com>
+ *
+ */
+#ifndef _LINUX_LSM_H
+#define _LINUX_LSM_H
+
+#include <linux/cred.h>
+#include <linux/fs.h>
+#include <linux/msg.h>
+#include <linux/key.h>
+#include <net/sock.h>
+
+/*
+ * Maximum number of LSMs that can be used at a time.
+ */
+#define COMPOSER_MAX		CONFIG_SECURITY_COMPOSER_MAX
+#define COMPOSER_NAMES_MAX	((SECURITY_NAME_MAX + 1) * COMPOSER_MAX)
+
+#include <linux/security.h>
+
+/*
+ * Just a set of slots for each LSM to keep its blob in.
+ */
+struct lsm_blob {
+	int	lsm_setcount;			/* Number of blobs set */
+	void	*lsm_blobs[COMPOSER_MAX];	/* LSM specific blobs */
+};
+
+static inline struct lsm_blob *lsm_alloc_blob(gfp_t gfp)
+{
+	return kzalloc(sizeof(struct lsm_blob), gfp);
+}
+
+static inline void *lsm_get_blob(const struct lsm_blob *bp, const int lsm)
+{
+	if (bp == NULL)
+		return NULL;
+	return bp->lsm_blobs[lsm];
+}
+
+static inline void lsm_set_blob(void **vpp, void *value, const int lsm)
+{
+	struct lsm_blob *bp = *vpp;
+
+	if (value == NULL && bp->lsm_blobs[lsm] != NULL)
+		bp->lsm_setcount--;
+	if (value != NULL && bp->lsm_blobs[lsm] == NULL)
+		bp->lsm_setcount++;
+
+	bp->lsm_blobs[lsm] = value;
+}
+
+static inline void *lsm_get_cred(const struct cred *cred,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(cred->security, sop->order);
+}
+
+static inline void lsm_set_cred(struct cred *cred, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&cred->security, value, sop->order);
+}
+
+static inline int lsm_set_init_cred(struct cred *cred, void *value,
+					const struct security_operations *sop)
+{
+	if (cred->security == NULL) {
+		cred->security = lsm_alloc_blob(GFP_KERNEL);
+		if (cred->security == NULL)
+			return -ENOMEM;
+	}
+
+	lsm_set_blob(&cred->security, value, sop->order);
+	return 0;
+}
+
+static inline void *lsm_get_file(const struct file *file,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(file->f_security, sop->order);
+}
+
+static inline void lsm_set_file(struct file *file, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&file->f_security, value, sop->order);
+}
+
+static inline void *lsm_get_inode(const struct inode *inode,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(inode->i_security, sop->order);
+}
+
+static inline void lsm_set_inode(struct inode *inode, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&inode->i_security, value, sop->order);
+}
+
+static inline void *lsm_get_super(const struct super_block *super,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(super->s_security, sop->order);
+}
+
+static inline void lsm_set_super(struct super_block *super, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&super->s_security, value, sop->order);
+}
+
+static inline void *lsm_get_ipc(const struct kern_ipc_perm *ipc,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(ipc->security, sop->order);
+}
+
+static inline void lsm_set_ipc(struct kern_ipc_perm *ipc, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&ipc->security, value, sop->order);
+}
+
+static inline void *lsm_get_msg(const struct msg_msg *msg,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(msg->security, sop->order);
+}
+
+static inline void lsm_set_msg(struct msg_msg *msg, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&msg->security, value, sop->order);
+}
+
+static inline void *lsm_get_key(const struct key *key,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(key->security, sop->order);
+}
+
+static inline void lsm_set_key(struct key *key, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&key->security, value, sop->order);
+}
+
+static inline void *lsm_get_sock(const struct sock *sock,
+					const struct security_operations *sop)
+{
+	return lsm_get_blob(sock->sk_security, sop->order);
+}
+
+static inline void lsm_set_sock(struct sock *sock, void *value,
+					const struct security_operations *sop)
+{
+	lsm_set_blob(&sock->sk_security, value, sop->order);
+}
+
+#endif /* ! _LINUX_LSM_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 05e88bd..b9cb187 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -87,8 +87,6 @@ extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
 extern int cap_inode_need_killpriv(struct dentry *dentry);
 extern int cap_inode_killpriv(struct dentry *dentry);
 extern int cap_mmap_addr(unsigned long addr);
-extern int cap_mmap_file(struct file *file, unsigned long reqprot,
-			 unsigned long prot, unsigned long flags);
 extern int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags);
 extern int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5);
@@ -112,8 +110,6 @@ struct seq_file;
 
 extern int cap_netlink_send(struct sock *sk, struct sk_buff *skb);
 
-void reset_security_ops(void);
-
 #ifdef CONFIG_MMU
 extern unsigned long mmap_min_addr;
 extern unsigned long dac_mmap_min_addr;
@@ -184,15 +180,222 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 	opts->num_mnt_opts = 0;
 }
 
+/*
+ * Index for LSM operations.
+ */
+enum lsm_hooks_index {
+	LSM_ptrace_access_check,
+	LSM_ptrace_traceme,
+	LSM_capget,
+	LSM_capset,
+	LSM_capable,
+	LSM_quotactl,
+	LSM_quota_on,
+	LSM_syslog,
+	LSM_settime,
+	LSM_vm_enough_memory,
+	LSM_bprm_set_creds,
+	LSM_bprm_check_security,
+	LSM_bprm_secureexec,
+	LSM_bprm_committing_creds,
+	LSM_bprm_committed_creds,
+	LSM_sb_alloc_security,
+	LSM_sb_free_security,
+	LSM_sb_copy_data,
+	LSM_sb_remount,
+	LSM_sb_kern_mount,
+	LSM_sb_show_options,
+	LSM_sb_statfs,
+	LSM_sb_mount,
+	LSM_sb_umount,
+	LSM_sb_pivotroot,
+	LSM_sb_set_mnt_opts,
+	LSM_sb_clone_mnt_opts,
+	LSM_sb_parse_opts_str,
+	LSM_path_unlink,
+	LSM_path_mkdir,
+	LSM_path_rmdir,
+	LSM_path_mknod,
+	LSM_path_truncate,
+	LSM_path_symlink,
+	LSM_path_link,
+	LSM_path_rename,
+	LSM_path_chmod,
+	LSM_path_chown,
+	LSM_path_chroot,
+	LSM_inode_alloc_security,
+	LSM_inode_free_security,
+	LSM_inode_init_security,
+	LSM_inode_create,
+	LSM_inode_link,
+	LSM_inode_unlink,
+	LSM_inode_symlink,
+	LSM_inode_mkdir,
+	LSM_inode_rmdir,
+	LSM_inode_mknod,
+	LSM_inode_rename,
+	LSM_inode_readlink,
+	LSM_inode_follow_link,
+	LSM_inode_permission,
+	LSM_inode_setattr,
+	LSM_inode_getattr,
+	LSM_inode_setxattr,
+	LSM_inode_post_setxattr,
+	LSM_inode_getxattr,
+	LSM_inode_listxattr,
+	LSM_inode_removexattr,
+	LSM_inode_need_killpriv,
+	LSM_inode_killpriv,
+	LSM_inode_getsecurity,
+	LSM_inode_setsecurity,
+	LSM_inode_listsecurity,
+	LSM_inode_getsecid,
+	LSM_file_permission,
+	LSM_file_alloc_security,
+	LSM_file_free_security,
+	LSM_file_ioctl,
+	LSM_mmap_addr,
+	LSM_mmap_file,
+	LSM_file_mprotect,
+	LSM_file_lock,
+	LSM_file_fcntl,
+	LSM_file_set_fowner,
+	LSM_file_send_sigiotask,
+	LSM_file_receive,
+	LSM_file_open,
+	LSM_task_create,
+	LSM_task_free,
+	LSM_cred_alloc_blank,
+	LSM_cred_free,
+	LSM_cred_prepare,
+	LSM_cred_transfer,
+	LSM_kernel_act_as,
+	LSM_kernel_create_files_as,
+	LSM_kernel_module_request,
+	LSM_task_fix_setuid,
+	LSM_task_setpgid,
+	LSM_task_getpgid,
+	LSM_task_getsid,
+	LSM_task_getsecid,
+	LSM_task_setnice,
+	LSM_task_setioprio,
+	LSM_task_getioprio,
+	LSM_task_setrlimit,
+	LSM_task_setscheduler,
+	LSM_task_getscheduler,
+	LSM_task_movememory,
+	LSM_task_kill,
+	LSM_task_wait,
+	LSM_task_prctl,
+	LSM_task_to_inode,
+	LSM_ipc_permission,
+	LSM_ipc_getsecid,
+	LSM_msg_msg_alloc_security,
+	LSM_msg_msg_free_security,
+	LSM_msg_queue_alloc_security,
+	LSM_msg_queue_free_security,
+	LSM_msg_queue_associate,
+	LSM_msg_queue_msgctl,
+	LSM_msg_queue_msgsnd,
+	LSM_msg_queue_msgrcv,
+	LSM_shm_alloc_security,
+	LSM_shm_free_security,
+	LSM_shm_associate,
+	LSM_shm_shmctl,
+	LSM_shm_shmat,
+	LSM_sem_alloc_security,
+	LSM_sem_free_security,
+	LSM_sem_associate,
+	LSM_sem_semctl,
+	LSM_sem_semop,
+	LSM_netlink_send,
+	LSM_d_instantiate,
+	LSM_getprocattr,
+	LSM_setprocattr,
+	LSM_secid_to_secctx,
+	LSM_secctx_to_secid,
+	LSM_release_secctx,
+	LSM_inode_notifysecctx,
+	LSM_inode_setsecctx,
+	LSM_inode_getsecctx,
+	LSM_unix_stream_connect,
+	LSM_unix_may_send,
+	LSM_socket_create,
+	LSM_socket_post_create,
+	LSM_socket_bind,
+	LSM_socket_connect,
+	LSM_socket_listen,
+	LSM_socket_accept,
+	LSM_socket_sendmsg,
+	LSM_socket_recvmsg,
+	LSM_socket_getsockname,
+	LSM_socket_getpeername,
+	LSM_socket_getsockopt,
+	LSM_socket_setsockopt,
+	LSM_socket_shutdown,
+	LSM_socket_sock_rcv_skb,
+	LSM_socket_getpeersec_stream,
+	LSM_socket_getpeersec_dgram,
+	LSM_sk_alloc_security,
+	LSM_sk_free_security,
+	LSM_sk_clone_security,
+	LSM_sk_getsecid,
+	LSM_sock_graft,
+	LSM_inet_conn_request,
+	LSM_inet_csk_clone,
+	LSM_inet_conn_established,
+	LSM_secmark_relabel_packet,
+	LSM_secmark_refcount_inc,
+	LSM_secmark_refcount_dec,
+	LSM_req_classify_flow,
+	LSM_tun_dev_create,
+	LSM_tun_dev_post_create,
+	LSM_tun_dev_attach,
+	LSM_xfrm_policy_alloc_security,
+	LSM_xfrm_policy_clone_security,
+	LSM_xfrm_policy_free_security,
+	LSM_xfrm_policy_delete_security,
+	LSM_xfrm_state_alloc_security,
+	LSM_xfrm_state_free_security,
+	LSM_xfrm_state_delete_security,
+	LSM_xfrm_policy_lookup,
+	LSM_xfrm_state_pol_flow_match,
+	LSM_xfrm_decode_session,
+	LSM_key_alloc,
+	LSM_key_free,
+	LSM_key_permission,
+	LSM_key_getsecurity,
+	LSM_audit_rule_init,
+	LSM_audit_rule_known,
+	LSM_audit_rule_match,
+	LSM_audit_rule_free,
+	LSM_name, /* Used by security/inode.c */
+	LSM_MAX_HOOKS
+};
+
+/*
+ * There is a list for each hook.
+ */
+extern struct list_head lsm_hooks[LSM_MAX_HOOKS];
+
 /**
  * struct security_operations - main security structure
  *
  * Security module identifier.
  *
+ * @list:
+ *	An array of lists of hooks. These are traversed on
+ *	hook execution.
+ *
  * @name:
  *	A string that acts as a unique identifier for the LSM with max number
  *	of characters = SECURITY_NAME_MAX.
  *
+ * @order:
+ *	The numeric order in which this LSM will be invoked.
+ *	Set during LSM initialization. Used to identify
+ *	which security blob to use when there is more than one LSM.
+ *
  * Security hooks for program execution operations.
  *
  * @bprm_set_creds:
@@ -1378,7 +1581,9 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
  * This is the main security structure.
  */
 struct security_operations {
+	struct list_head list[LSM_MAX_HOOKS];
 	char name[SECURITY_NAME_MAX + 1];
+	int order;
 
 	int (*ptrace_access_check) (struct task_struct *child, unsigned int mode);
 	int (*ptrace_traceme) (struct task_struct *parent);
@@ -1658,9 +1863,10 @@ struct security_operations {
 /* prototypes */
 extern int security_init(void);
 extern int security_module_enable(struct security_operations *ops);
-extern int register_security(struct security_operations *ops);
-extern void __init security_fixup_ops(struct security_operations *ops);
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+extern int reset_security_ops(struct security_operations *ops);
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
 
 /* Security operations */
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
diff --git a/security/Kconfig b/security/Kconfig
index e9c6ac7..397ca41 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -123,49 +123,55 @@ source security/tomoyo/Kconfig
 source security/apparmor/Kconfig
 source security/yama/Kconfig
 
+config SECURITY_COMPOSER_MAX
+	int "Maximum allowed security modules (1 to 12)"
+	depends on SECURITY
+	default 6
+	range 1 12
+	help
+	  The number of security modules that can be loaded.
+	  The default value allows for all of the upstream modules.
+	  The maximum allowed value is 12.
+
 source security/integrity/Kconfig
 
 choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_YAMA if SECURITY_YAMA
-	default DEFAULT_SECURITY_DAC
+	depends on SECURITY
+	prompt "Presented security module"
+	default PRESENT_SECURITY_SELINUX if SECURITY_SELINUX
+	default PRESENT_SECURITY_SMACK if SECURITY_SMACK
+	default PRESENT_SECURITY_APPARMOR if SECURITY_APPARMOR
+	default PRESENT_SECURITY_FORMATTED
 
 	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
+	  Select the security module that will be presented
+	  with the /proc/*/attr interface.
+	  If not specified the interfaces will expect input
+	  to be specified as LSM name and value pairs, with
+	  the specifications deliminated by "/" characters, as
+	  "/smack=_/" or "/apparmor=unconfined/smack=_/".
+	  The leading, separating, and terminating "/" are
+	  all required.
+
+	config PRESENT_SECURITY_SELINUX
 		bool "SELinux" if SECURITY_SELINUX=y
 
-	config DEFAULT_SECURITY_SMACK
+	config PRESENT_SECURITY_SMACK
 		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
 
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
+	config PRESENT_SECURITY_APPARMOR
 		bool "AppArmor" if SECURITY_APPARMOR=y
 
-	config DEFAULT_SECURITY_YAMA
-		bool "Yama" if SECURITY_YAMA=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
+	config PRESENT_SECURITY_FORMATTED
+		bool "Use /lsm=.../lsm=.../ format"
 
 endchoice
 
-config DEFAULT_SECURITY
+config PRESENT_SECURITY
 	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "yama" if DEFAULT_SECURITY_YAMA
-	default "" if DEFAULT_SECURITY_DAC
+	default "selinux" if PRESENT_SECURITY_SELINUX
+	default "smack" if PRESENT_SECURITY_SMACK
+	default "apparmor" if PRESENT_SECURITY_APPARMOR
+	default "formatted"
 
 endmenu
-
diff --git a/security/Makefile b/security/Makefile
index c26c81e..b1875b1 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -14,9 +14,8 @@ obj-y					+= commoncap.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o capability.o
+obj-$(CONFIG_SECURITY)			+= security.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
-# Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/built-in.o
 obj-$(CONFIG_AUDIT)			+= lsm_audit.o
diff --git a/security/capability.c b/security/capability.c
deleted file mode 100644
index b14a30c..0000000
--- a/security/capability.c
+++ /dev/null
@@ -1,1075 +0,0 @@
-/*
- *  Capabilities Linux Security Module
- *
- *  This is the default security module in case no other module is loaded.
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; either version 2 of the License, or
- *	(at your option) any later version.
- *
- */
-
-#include <linux/security.h>
-
-static int cap_syslog(int type)
-{
-	return 0;
-}
-
-static int cap_quotactl(int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_bprm_check_security(struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_committing_creds(struct linux_binprm *bprm)
-{
-}
-
-static void cap_bprm_committed_creds(struct linux_binprm *bprm)
-{
-}
-
-static int cap_sb_alloc_security(struct super_block *sb)
-{
-	return 0;
-}
-
-static void cap_sb_free_security(struct super_block *sb)
-{
-}
-
-static int cap_sb_copy_data(char *orig, char *copy)
-{
-	return 0;
-}
-
-static int cap_sb_remount(struct super_block *sb, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_kern_mount(struct super_block *sb, int flags, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_show_options(struct seq_file *m, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_sb_statfs(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_sb_mount(const char *dev_name, struct path *path,
-			const char *type, unsigned long flags, void *data)
-{
-	return 0;
-}
-
-static int cap_sb_umount(struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static int cap_sb_pivotroot(struct path *old_path, struct path *new_path)
-{
-	return 0;
-}
-
-static int cap_sb_set_mnt_opts(struct super_block *sb,
-			       struct security_mnt_opts *opts)
-{
-	if (unlikely(opts->num_mnt_opts))
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-static void cap_sb_clone_mnt_opts(const struct super_block *oldsb,
-				  struct super_block *newsb)
-{
-}
-
-static int cap_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
-{
-	return 0;
-}
-
-static int cap_inode_alloc_security(struct inode *inode)
-{
-	return 0;
-}
-
-static void cap_inode_free_security(struct inode *inode)
-{
-}
-
-static int cap_inode_init_security(struct inode *inode, struct inode *dir,
-				   const struct qstr *qstr, char **name,
-				   void **value, size_t *len)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_create(struct inode *inode, struct dentry *dentry,
-			    umode_t mask)
-{
-	return 0;
-}
-
-static int cap_inode_link(struct dentry *old_dentry, struct inode *inode,
-			  struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_inode_unlink(struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_symlink(struct inode *inode, struct dentry *dentry,
-			     const char *name)
-{
-	return 0;
-}
-
-static int cap_inode_mkdir(struct inode *inode, struct dentry *dentry,
-			   umode_t mask)
-{
-	return 0;
-}
-
-static int cap_inode_rmdir(struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_mknod(struct inode *inode, struct dentry *dentry,
-			   umode_t mode, dev_t dev)
-{
-	return 0;
-}
-
-static int cap_inode_rename(struct inode *old_inode, struct dentry *old_dentry,
-			    struct inode *new_inode, struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_inode_readlink(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_follow_link(struct dentry *dentry,
-				 struct nameidata *nameidata)
-{
-	return 0;
-}
-
-static int cap_inode_permission(struct inode *inode, int mask)
-{
-	return 0;
-}
-
-static int cap_inode_setattr(struct dentry *dentry, struct iattr *iattr)
-{
-	return 0;
-}
-
-static int cap_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
-{
-	return 0;
-}
-
-static void cap_inode_post_setxattr(struct dentry *dentry, const char *name,
-				    const void *value, size_t size, int flags)
-{
-}
-
-static int cap_inode_getxattr(struct dentry *dentry, const char *name)
-{
-	return 0;
-}
-
-static int cap_inode_listxattr(struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_inode_getsecurity(const struct inode *inode, const char *name,
-				 void **buffer, bool alloc)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_setsecurity(struct inode *inode, const char *name,
-				 const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_inode_listsecurity(struct inode *inode, char *buffer,
-				  size_t buffer_size)
-{
-	return 0;
-}
-
-static void cap_inode_getsecid(const struct inode *inode, u32 *secid)
-{
-	*secid = 0;
-}
-
-#ifdef CONFIG_SECURITY_PATH
-static int cap_path_mknod(struct path *dir, struct dentry *dentry, umode_t mode,
-			  unsigned int dev)
-{
-	return 0;
-}
-
-static int cap_path_mkdir(struct path *dir, struct dentry *dentry, umode_t mode)
-{
-	return 0;
-}
-
-static int cap_path_rmdir(struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_path_unlink(struct path *dir, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int cap_path_symlink(struct path *dir, struct dentry *dentry,
-			    const char *old_name)
-{
-	return 0;
-}
-
-static int cap_path_link(struct dentry *old_dentry, struct path *new_dir,
-			 struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_path_rename(struct path *old_path, struct dentry *old_dentry,
-			   struct path *new_path, struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static int cap_path_truncate(struct path *path)
-{
-	return 0;
-}
-
-static int cap_path_chmod(struct path *path, umode_t mode)
-{
-	return 0;
-}
-
-static int cap_path_chown(struct path *path, kuid_t uid, kgid_t gid)
-{
-	return 0;
-}
-
-static int cap_path_chroot(struct path *root)
-{
-	return 0;
-}
-#endif
-
-static int cap_file_permission(struct file *file, int mask)
-{
-	return 0;
-}
-
-static int cap_file_alloc_security(struct file *file)
-{
-	return 0;
-}
-
-static void cap_file_free_security(struct file *file)
-{
-}
-
-static int cap_file_ioctl(struct file *file, unsigned int command,
-			  unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-			     unsigned long prot)
-{
-	return 0;
-}
-
-static int cap_file_lock(struct file *file, unsigned int cmd)
-{
-	return 0;
-}
-
-static int cap_file_fcntl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
-{
-	return 0;
-}
-
-static int cap_file_set_fowner(struct file *file)
-{
-	return 0;
-}
-
-static int cap_file_send_sigiotask(struct task_struct *tsk,
-				   struct fown_struct *fown, int sig)
-{
-	return 0;
-}
-
-static int cap_file_receive(struct file *file)
-{
-	return 0;
-}
-
-static int cap_file_open(struct file *file, const struct cred *cred)
-{
-	return 0;
-}
-
-static int cap_task_create(unsigned long clone_flags)
-{
-	return 0;
-}
-
-static void cap_task_free(struct task_struct *task)
-{
-}
-
-static int cap_cred_alloc_blank(struct cred *cred, gfp_t gfp)
-{
-	return 0;
-}
-
-static void cap_cred_free(struct cred *cred)
-{
-}
-
-static int cap_cred_prepare(struct cred *new, const struct cred *old, gfp_t gfp)
-{
-	return 0;
-}
-
-static void cap_cred_transfer(struct cred *new, const struct cred *old)
-{
-}
-
-static int cap_kernel_act_as(struct cred *new, u32 secid)
-{
-	return 0;
-}
-
-static int cap_kernel_create_files_as(struct cred *new, struct inode *inode)
-{
-	return 0;
-}
-
-static int cap_kernel_module_request(char *kmod_name)
-{
-	return 0;
-}
-
-static int cap_task_setpgid(struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
-
-static int cap_task_getpgid(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_getsid(struct task_struct *p)
-{
-	return 0;
-}
-
-static void cap_task_getsecid(struct task_struct *p, u32 *secid)
-{
-	*secid = 0;
-}
-
-static int cap_task_getioprio(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_setrlimit(struct task_struct *p, unsigned int resource,
-		struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static int cap_task_getscheduler(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_movememory(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_wait(struct task_struct *p)
-{
-	return 0;
-}
-
-static int cap_task_kill(struct task_struct *p, struct siginfo *info,
-			 int sig, u32 secid)
-{
-	return 0;
-}
-
-static void cap_task_to_inode(struct task_struct *p, struct inode *inode)
-{
-}
-
-static int cap_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
-{
-	return 0;
-}
-
-static void cap_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
-{
-	*secid = 0;
-}
-
-static int cap_msg_msg_alloc_security(struct msg_msg *msg)
-{
-	return 0;
-}
-
-static void cap_msg_msg_free_security(struct msg_msg *msg)
-{
-}
-
-static int cap_msg_queue_alloc_security(struct msg_queue *msq)
-{
-	return 0;
-}
-
-static void cap_msg_queue_free_security(struct msg_queue *msq)
-{
-}
-
-static int cap_msg_queue_associate(struct msg_queue *msq, int msqflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgctl(struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgsnd(struct msg_queue *msq, struct msg_msg *msg,
-				int msgflg)
-{
-	return 0;
-}
-
-static int cap_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
-				struct task_struct *target, long type, int mode)
-{
-	return 0;
-}
-
-static int cap_shm_alloc_security(struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static void cap_shm_free_security(struct shmid_kernel *shp)
-{
-}
-
-static int cap_shm_associate(struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int cap_shm_shmctl(struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int cap_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr,
-			 int shmflg)
-{
-	return 0;
-}
-
-static int cap_sem_alloc_security(struct sem_array *sma)
-{
-	return 0;
-}
-
-static void cap_sem_free_security(struct sem_array *sma)
-{
-}
-
-static int cap_sem_associate(struct sem_array *sma, int semflg)
-{
-	return 0;
-}
-
-static int cap_sem_semctl(struct sem_array *sma, int cmd)
-{
-	return 0;
-}
-
-static int cap_sem_semop(struct sem_array *sma, struct sembuf *sops,
-			 unsigned nsops, int alter)
-{
-	return 0;
-}
-
-#ifdef CONFIG_SECURITY_NETWORK
-static int cap_unix_stream_connect(struct sock *sock, struct sock *other,
-				   struct sock *newsk)
-{
-	return 0;
-}
-
-static int cap_unix_may_send(struct socket *sock, struct socket *other)
-{
-	return 0;
-}
-
-static int cap_socket_create(int family, int type, int protocol, int kern)
-{
-	return 0;
-}
-
-static int cap_socket_post_create(struct socket *sock, int family, int type,
-				  int protocol, int kern)
-{
-	return 0;
-}
-
-static int cap_socket_bind(struct socket *sock, struct sockaddr *address,
-			   int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_connect(struct socket *sock, struct sockaddr *address,
-			      int addrlen)
-{
-	return 0;
-}
-
-static int cap_socket_listen(struct socket *sock, int backlog)
-{
-	return 0;
-}
-
-static int cap_socket_accept(struct socket *sock, struct socket *newsock)
-{
-	return 0;
-}
-
-static int cap_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
-{
-	return 0;
-}
-
-static int cap_socket_recvmsg(struct socket *sock, struct msghdr *msg,
-			      int size, int flags)
-{
-	return 0;
-}
-
-static int cap_socket_getsockname(struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_getpeername(struct socket *sock)
-{
-	return 0;
-}
-
-static int cap_socket_setsockopt(struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_getsockopt(struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int cap_socket_shutdown(struct socket *sock, int how)
-{
-	return 0;
-}
-
-static int cap_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int cap_socket_getpeersec_stream(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
-
-static int cap_socket_getpeersec_dgram(struct socket *sock,
-				       struct sk_buff *skb, u32 *secid)
-{
-	return -ENOPROTOOPT;
-}
-
-static int cap_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
-{
-	return 0;
-}
-
-static void cap_sk_free_security(struct sock *sk)
-{
-}
-
-static void cap_sk_clone_security(const struct sock *sk, struct sock *newsk)
-{
-}
-
-static void cap_sk_getsecid(struct sock *sk, u32 *secid)
-{
-}
-
-static void cap_sock_graft(struct sock *sk, struct socket *parent)
-{
-}
-
-static int cap_inet_conn_request(struct sock *sk, struct sk_buff *skb,
-				 struct request_sock *req)
-{
-	return 0;
-}
-
-static void cap_inet_csk_clone(struct sock *newsk,
-			       const struct request_sock *req)
-{
-}
-
-static void cap_inet_conn_established(struct sock *sk, struct sk_buff *skb)
-{
-}
-
-static int cap_secmark_relabel_packet(u32 secid)
-{
-	return 0;
-}
-
-static void cap_secmark_refcount_inc(void)
-{
-}
-
-static void cap_secmark_refcount_dec(void)
-{
-}
-
-static void cap_req_classify_flow(const struct request_sock *req,
-				  struct flowi *fl)
-{
-}
-
-static int cap_tun_dev_create(void)
-{
-	return 0;
-}
-
-static void cap_tun_dev_post_create(struct sock *sk)
-{
-}
-
-static int cap_tun_dev_attach(struct sock *sk)
-{
-	return 0;
-}
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-static int cap_xfrm_policy_alloc_security(struct xfrm_sec_ctx **ctxp,
-					  struct xfrm_user_sec_ctx *sec_ctx)
-{
-	return 0;
-}
-
-static int cap_xfrm_policy_clone_security(struct xfrm_sec_ctx *old_ctx,
-					  struct xfrm_sec_ctx **new_ctxp)
-{
-	return 0;
-}
-
-static void cap_xfrm_policy_free_security(struct xfrm_sec_ctx *ctx)
-{
-}
-
-static int cap_xfrm_policy_delete_security(struct xfrm_sec_ctx *ctx)
-{
-	return 0;
-}
-
-static int cap_xfrm_state_alloc_security(struct xfrm_state *x,
-					 struct xfrm_user_sec_ctx *sec_ctx,
-					 u32 secid)
-{
-	return 0;
-}
-
-static void cap_xfrm_state_free_security(struct xfrm_state *x)
-{
-}
-
-static int cap_xfrm_state_delete_security(struct xfrm_state *x)
-{
-	return 0;
-}
-
-static int cap_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 sk_sid, u8 dir)
-{
-	return 0;
-}
-
-static int cap_xfrm_state_pol_flow_match(struct xfrm_state *x,
-					 struct xfrm_policy *xp,
-					 const struct flowi *fl)
-{
-	return 1;
-}
-
-static int cap_xfrm_decode_session(struct sk_buff *skb, u32 *fl, int ckall)
-{
-	return 0;
-}
-
-#endif /* CONFIG_SECURITY_NETWORK_XFRM */
-static void cap_d_instantiate(struct dentry *dentry, struct inode *inode)
-{
-}
-
-static int cap_getprocattr(struct task_struct *p, char *name, char **value)
-{
-	return -EINVAL;
-}
-
-static int cap_setprocattr(struct task_struct *p, char *name, void *value,
-			   size_t size)
-{
-	return -EINVAL;
-}
-
-static int cap_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
-{
-	return -EOPNOTSUPP;
-}
-
-static int cap_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
-{
-	*secid = 0;
-	return 0;
-}
-
-static void cap_release_secctx(char *secdata, u32 seclen)
-{
-}
-
-static int cap_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
-{
-	return 0;
-}
-
-static int cap_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
-{
-	return 0;
-}
-
-static int cap_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
-{
-	return 0;
-}
-#ifdef CONFIG_KEYS
-static int cap_key_alloc(struct key *key, const struct cred *cred,
-			 unsigned long flags)
-{
-	return 0;
-}
-
-static void cap_key_free(struct key *key)
-{
-}
-
-static int cap_key_permission(key_ref_t key_ref, const struct cred *cred,
-			      key_perm_t perm)
-{
-	return 0;
-}
-
-static int cap_key_getsecurity(struct key *key, char **_buffer)
-{
-	*_buffer = NULL;
-	return 0;
-}
-
-#endif /* CONFIG_KEYS */
-
-#ifdef CONFIG_AUDIT
-static int cap_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
-{
-	return 0;
-}
-
-static int cap_audit_rule_known(struct audit_krule *krule)
-{
-	return 0;
-}
-
-static int cap_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx)
-{
-	return 0;
-}
-
-static void cap_audit_rule_free(void *lsmrule)
-{
-}
-#endif /* CONFIG_AUDIT */
-
-#define set_to_cap_if_null(ops, function)				\
-	do {								\
-		if (!ops->function) {					\
-			ops->function = cap_##function;			\
-			pr_debug("Had to override the " #function	\
-				 " security operation with the default.\n");\
-			}						\
-	} while (0)
-
-void __init security_fixup_ops(struct security_operations *ops)
-{
-	set_to_cap_if_null(ops, ptrace_access_check);
-	set_to_cap_if_null(ops, ptrace_traceme);
-	set_to_cap_if_null(ops, capget);
-	set_to_cap_if_null(ops, capset);
-	set_to_cap_if_null(ops, capable);
-	set_to_cap_if_null(ops, quotactl);
-	set_to_cap_if_null(ops, quota_on);
-	set_to_cap_if_null(ops, syslog);
-	set_to_cap_if_null(ops, settime);
-	set_to_cap_if_null(ops, vm_enough_memory);
-	set_to_cap_if_null(ops, bprm_set_creds);
-	set_to_cap_if_null(ops, bprm_committing_creds);
-	set_to_cap_if_null(ops, bprm_committed_creds);
-	set_to_cap_if_null(ops, bprm_check_security);
-	set_to_cap_if_null(ops, bprm_secureexec);
-	set_to_cap_if_null(ops, sb_alloc_security);
-	set_to_cap_if_null(ops, sb_free_security);
-	set_to_cap_if_null(ops, sb_copy_data);
-	set_to_cap_if_null(ops, sb_remount);
-	set_to_cap_if_null(ops, sb_kern_mount);
-	set_to_cap_if_null(ops, sb_show_options);
-	set_to_cap_if_null(ops, sb_statfs);
-	set_to_cap_if_null(ops, sb_mount);
-	set_to_cap_if_null(ops, sb_umount);
-	set_to_cap_if_null(ops, sb_pivotroot);
-	set_to_cap_if_null(ops, sb_set_mnt_opts);
-	set_to_cap_if_null(ops, sb_clone_mnt_opts);
-	set_to_cap_if_null(ops, sb_parse_opts_str);
-	set_to_cap_if_null(ops, inode_alloc_security);
-	set_to_cap_if_null(ops, inode_free_security);
-	set_to_cap_if_null(ops, inode_init_security);
-	set_to_cap_if_null(ops, inode_create);
-	set_to_cap_if_null(ops, inode_link);
-	set_to_cap_if_null(ops, inode_unlink);
-	set_to_cap_if_null(ops, inode_symlink);
-	set_to_cap_if_null(ops, inode_mkdir);
-	set_to_cap_if_null(ops, inode_rmdir);
-	set_to_cap_if_null(ops, inode_mknod);
-	set_to_cap_if_null(ops, inode_rename);
-	set_to_cap_if_null(ops, inode_readlink);
-	set_to_cap_if_null(ops, inode_follow_link);
-	set_to_cap_if_null(ops, inode_permission);
-	set_to_cap_if_null(ops, inode_setattr);
-	set_to_cap_if_null(ops, inode_getattr);
-	set_to_cap_if_null(ops, inode_setxattr);
-	set_to_cap_if_null(ops, inode_post_setxattr);
-	set_to_cap_if_null(ops, inode_getxattr);
-	set_to_cap_if_null(ops, inode_listxattr);
-	set_to_cap_if_null(ops, inode_removexattr);
-	set_to_cap_if_null(ops, inode_need_killpriv);
-	set_to_cap_if_null(ops, inode_killpriv);
-	set_to_cap_if_null(ops, inode_getsecurity);
-	set_to_cap_if_null(ops, inode_setsecurity);
-	set_to_cap_if_null(ops, inode_listsecurity);
-	set_to_cap_if_null(ops, inode_getsecid);
-#ifdef CONFIG_SECURITY_PATH
-	set_to_cap_if_null(ops, path_mknod);
-	set_to_cap_if_null(ops, path_mkdir);
-	set_to_cap_if_null(ops, path_rmdir);
-	set_to_cap_if_null(ops, path_unlink);
-	set_to_cap_if_null(ops, path_symlink);
-	set_to_cap_if_null(ops, path_link);
-	set_to_cap_if_null(ops, path_rename);
-	set_to_cap_if_null(ops, path_truncate);
-	set_to_cap_if_null(ops, path_chmod);
-	set_to_cap_if_null(ops, path_chown);
-	set_to_cap_if_null(ops, path_chroot);
-#endif
-	set_to_cap_if_null(ops, file_permission);
-	set_to_cap_if_null(ops, file_alloc_security);
-	set_to_cap_if_null(ops, file_free_security);
-	set_to_cap_if_null(ops, file_ioctl);
-	set_to_cap_if_null(ops, mmap_addr);
-	set_to_cap_if_null(ops, mmap_file);
-	set_to_cap_if_null(ops, file_mprotect);
-	set_to_cap_if_null(ops, file_lock);
-	set_to_cap_if_null(ops, file_fcntl);
-	set_to_cap_if_null(ops, file_set_fowner);
-	set_to_cap_if_null(ops, file_send_sigiotask);
-	set_to_cap_if_null(ops, file_receive);
-	set_to_cap_if_null(ops, file_open);
-	set_to_cap_if_null(ops, task_create);
-	set_to_cap_if_null(ops, task_free);
-	set_to_cap_if_null(ops, cred_alloc_blank);
-	set_to_cap_if_null(ops, cred_free);
-	set_to_cap_if_null(ops, cred_prepare);
-	set_to_cap_if_null(ops, cred_transfer);
-	set_to_cap_if_null(ops, kernel_act_as);
-	set_to_cap_if_null(ops, kernel_create_files_as);
-	set_to_cap_if_null(ops, kernel_module_request);
-	set_to_cap_if_null(ops, task_fix_setuid);
-	set_to_cap_if_null(ops, task_setpgid);
-	set_to_cap_if_null(ops, task_getpgid);
-	set_to_cap_if_null(ops, task_getsid);
-	set_to_cap_if_null(ops, task_getsecid);
-	set_to_cap_if_null(ops, task_setnice);
-	set_to_cap_if_null(ops, task_setioprio);
-	set_to_cap_if_null(ops, task_getioprio);
-	set_to_cap_if_null(ops, task_setrlimit);
-	set_to_cap_if_null(ops, task_setscheduler);
-	set_to_cap_if_null(ops, task_getscheduler);
-	set_to_cap_if_null(ops, task_movememory);
-	set_to_cap_if_null(ops, task_wait);
-	set_to_cap_if_null(ops, task_kill);
-	set_to_cap_if_null(ops, task_prctl);
-	set_to_cap_if_null(ops, task_to_inode);
-	set_to_cap_if_null(ops, ipc_permission);
-	set_to_cap_if_null(ops, ipc_getsecid);
-	set_to_cap_if_null(ops, msg_msg_alloc_security);
-	set_to_cap_if_null(ops, msg_msg_free_security);
-	set_to_cap_if_null(ops, msg_queue_alloc_security);
-	set_to_cap_if_null(ops, msg_queue_free_security);
-	set_to_cap_if_null(ops, msg_queue_associate);
-	set_to_cap_if_null(ops, msg_queue_msgctl);
-	set_to_cap_if_null(ops, msg_queue_msgsnd);
-	set_to_cap_if_null(ops, msg_queue_msgrcv);
-	set_to_cap_if_null(ops, shm_alloc_security);
-	set_to_cap_if_null(ops, shm_free_security);
-	set_to_cap_if_null(ops, shm_associate);
-	set_to_cap_if_null(ops, shm_shmctl);
-	set_to_cap_if_null(ops, shm_shmat);
-	set_to_cap_if_null(ops, sem_alloc_security);
-	set_to_cap_if_null(ops, sem_free_security);
-	set_to_cap_if_null(ops, sem_associate);
-	set_to_cap_if_null(ops, sem_semctl);
-	set_to_cap_if_null(ops, sem_semop);
-	set_to_cap_if_null(ops, netlink_send);
-	set_to_cap_if_null(ops, d_instantiate);
-	set_to_cap_if_null(ops, getprocattr);
-	set_to_cap_if_null(ops, setprocattr);
-	set_to_cap_if_null(ops, secid_to_secctx);
-	set_to_cap_if_null(ops, secctx_to_secid);
-	set_to_cap_if_null(ops, release_secctx);
-	set_to_cap_if_null(ops, inode_notifysecctx);
-	set_to_cap_if_null(ops, inode_setsecctx);
-	set_to_cap_if_null(ops, inode_getsecctx);
-#ifdef CONFIG_SECURITY_NETWORK
-	set_to_cap_if_null(ops, unix_stream_connect);
-	set_to_cap_if_null(ops, unix_may_send);
-	set_to_cap_if_null(ops, socket_create);
-	set_to_cap_if_null(ops, socket_post_create);
-	set_to_cap_if_null(ops, socket_bind);
-	set_to_cap_if_null(ops, socket_connect);
-	set_to_cap_if_null(ops, socket_listen);
-	set_to_cap_if_null(ops, socket_accept);
-	set_to_cap_if_null(ops, socket_sendmsg);
-	set_to_cap_if_null(ops, socket_recvmsg);
-	set_to_cap_if_null(ops, socket_getsockname);
-	set_to_cap_if_null(ops, socket_getpeername);
-	set_to_cap_if_null(ops, socket_setsockopt);
-	set_to_cap_if_null(ops, socket_getsockopt);
-	set_to_cap_if_null(ops, socket_shutdown);
-	set_to_cap_if_null(ops, socket_sock_rcv_skb);
-	set_to_cap_if_null(ops, socket_getpeersec_stream);
-	set_to_cap_if_null(ops, socket_getpeersec_dgram);
-	set_to_cap_if_null(ops, sk_alloc_security);
-	set_to_cap_if_null(ops, sk_free_security);
-	set_to_cap_if_null(ops, sk_clone_security);
-	set_to_cap_if_null(ops, sk_getsecid);
-	set_to_cap_if_null(ops, sock_graft);
-	set_to_cap_if_null(ops, inet_conn_request);
-	set_to_cap_if_null(ops, inet_csk_clone);
-	set_to_cap_if_null(ops, inet_conn_established);
-	set_to_cap_if_null(ops, secmark_relabel_packet);
-	set_to_cap_if_null(ops, secmark_refcount_inc);
-	set_to_cap_if_null(ops, secmark_refcount_dec);
-	set_to_cap_if_null(ops, req_classify_flow);
-	set_to_cap_if_null(ops, tun_dev_create);
-	set_to_cap_if_null(ops, tun_dev_post_create);
-	set_to_cap_if_null(ops, tun_dev_attach);
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	set_to_cap_if_null(ops, xfrm_policy_alloc_security);
-	set_to_cap_if_null(ops, xfrm_policy_clone_security);
-	set_to_cap_if_null(ops, xfrm_policy_free_security);
-	set_to_cap_if_null(ops, xfrm_policy_delete_security);
-	set_to_cap_if_null(ops, xfrm_state_alloc_security);
-	set_to_cap_if_null(ops, xfrm_state_free_security);
-	set_to_cap_if_null(ops, xfrm_state_delete_security);
-	set_to_cap_if_null(ops, xfrm_policy_lookup);
-	set_to_cap_if_null(ops, xfrm_state_pol_flow_match);
-	set_to_cap_if_null(ops, xfrm_decode_session);
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	set_to_cap_if_null(ops, key_alloc);
-	set_to_cap_if_null(ops, key_free);
-	set_to_cap_if_null(ops, key_permission);
-	set_to_cap_if_null(ops, key_getsecurity);
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	set_to_cap_if_null(ops, audit_rule_init);
-	set_to_cap_if_null(ops, audit_rule_known);
-	set_to_cap_if_null(ops, audit_rule_match);
-	set_to_cap_if_null(ops, audit_rule_free);
-#endif
-}
diff --git a/security/commoncap.c b/security/commoncap.c
index 6dbae46..813b35d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -979,9 +979,3 @@ int cap_mmap_addr(unsigned long addr)
 	}
 	return ret;
 }
-
-int cap_mmap_file(struct file *file, unsigned long reqprot,
-		  unsigned long prot, unsigned long flags)
-{
-	return 0;
-}
diff --git a/security/inode.c b/security/inode.c
index 43ce6e1..eac2f08 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -21,6 +21,9 @@
 #include <linux/namei.h>
 #include <linux/security.h>
 #include <linux/magic.h>
+#ifdef CONFIG_SECURITY
+#include <linux/lsm.h>
+#endif
 
 static struct vfsmount *mount;
 static int mount_count;
@@ -215,6 +218,39 @@ void securityfs_remove(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
+#ifdef CONFIG_SECURITY
+static struct dentry *lsm_dentry;
+static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	struct security_operations *sop;
+	char *data;
+	int len;
+
+	data = kzalloc(COMPOSER_NAMES_MAX, GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	list_for_each_entry(sop, &lsm_hooks[LSM_name], list[LSM_name]) {
+		strcat(data, sop->name);
+		strcat(data, ",");
+	}
+	len = strlen(data);
+	if (len > 1)
+		data[len-1] = '\n';
+
+	len = simple_read_from_buffer(buf, count, ppos, data, len);
+	kfree(data);
+
+	return len;
+}
+
+static const struct file_operations lsm_ops = {
+	.read = lsm_read,
+	.llseek = generic_file_llseek,
+};
+#endif /* CONFIG_SECURITY */
+
 static struct kobject *security_kobj;
 
 static int __init securityfs_init(void)
@@ -226,9 +262,15 @@ static int __init securityfs_init(void)
 		return -EINVAL;
 
 	retval = register_filesystem(&fs_type);
-	if (retval)
+	if (retval) {
 		kobject_put(security_kobj);
-	return retval;
+		return retval;
+	}
+#ifdef CONFIG_SECURITY
+	lsm_dentry = securityfs_create_file("lsm", S_IRUGO, NULL, NULL,
+		&lsm_ops);
+#endif /* CONFIG_SECURITY */
+	return 0;
 }
 
 core_initcall(securityfs_init);
diff --git a/security/security.c b/security/security.c
index 8dcd4ae..c65c34e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -25,30 +25,284 @@
 #include <linux/personality.h>
 #include <linux/backing-dev.h>
 #include <net/flow.h>
+#include <linux/lsm.h>
+#include <linux/shm.h>
+#include <linux/string.h>
 
 #define MAX_LSM_EVM_XATTR	2
 
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
 
-static struct security_operations *security_ops;
-static struct security_operations default_security_ops = {
-	.name	= "default",
-};
+static __initdata char specified_lsms[COMPOSER_MAX][SECURITY_NAME_MAX + 1];
+static __initdata char allowed_lsms[COMPOSER_NAMES_MAX];
+static __initdata char present_lsm[SECURITY_NAME_MAX + 1] =
+	CONFIG_PRESENT_SECURITY;
+static __initdata int present_lsm_count;
 
-static inline int __init verify(struct security_operations *ops)
+struct list_head lsm_hooks[LSM_MAX_HOOKS];
+static struct security_operations *lsm_present;
+static int (*present_getprocattr)
+		(struct task_struct *p, char *name, char **value);
+static int (*present_setprocattr)
+		(struct task_struct *p, char *name, void *value, size_t size);
+
+static int lsm_count;
+
+#define for_each_hook(SOP, HOOK) \
+	list_for_each_entry(SOP, &lsm_hooks[LSM_##HOOK], list[LSM_##HOOK])
+
+/*
+ * Add an entry to a list of security operation vectors.
+ * The "interesting" logic is included here rather than in the
+ * caller to reduce the volume of the calling code.
+ */
+static void __init lsm_enlist(struct security_operations *ops,
+				const enum lsm_hooks_index index,
+				void *interesting)
 {
-	/* verify the security_operations structure exists */
-	if (!ops)
-		return -EINVAL;
-	security_fixup_ops(ops);
-	return 0;
+	struct security_operations *sop;
+
+	if (!interesting) {
+		INIT_LIST_HEAD(&ops->list[index]);
+		return;
+	}
+
+	if (list_empty(&lsm_hooks[index])) {
+		list_add_rcu(&ops->list[index], &lsm_hooks[index]);
+		return;
+	}
+
+	list_for_each_entry(sop, &lsm_hooks[index], list[index]) {
+		if (ops->order < sop->order) {
+			list_add_tail_rcu(&ops->list[index], &sop->list[index]);
+			return;
+		}
+		if (list_is_last(&sop->list[index], &lsm_hooks[index])) {
+			list_add_rcu(&ops->list[index], &sop->list[index]);
+			return;
+		}
+	}
+}
+
+static void __init lsm_enlist_ops(struct security_operations *sop)
+{
+	lsm_enlist(sop, LSM_ptrace_access_check, sop->ptrace_access_check);
+	lsm_enlist(sop, LSM_ptrace_traceme, sop->ptrace_traceme);
+	lsm_enlist(sop, LSM_capget, sop->capget);
+	lsm_enlist(sop, LSM_capset, sop->capset);
+	lsm_enlist(sop, LSM_capable, sop->capable);
+	lsm_enlist(sop, LSM_quotactl, sop->quotactl);
+	lsm_enlist(sop, LSM_quota_on, sop->quota_on);
+	lsm_enlist(sop, LSM_syslog, sop->syslog);
+	lsm_enlist(sop, LSM_settime, sop->settime);
+	lsm_enlist(sop, LSM_vm_enough_memory, sop->vm_enough_memory);
+	lsm_enlist(sop, LSM_bprm_set_creds, sop->bprm_set_creds);
+	lsm_enlist(sop, LSM_bprm_check_security, sop->bprm_check_security);
+	lsm_enlist(sop, LSM_bprm_committing_creds, sop->bprm_committing_creds);
+	lsm_enlist(sop, LSM_bprm_committed_creds, sop->bprm_committed_creds);
+	lsm_enlist(sop, LSM_bprm_secureexec, sop->bprm_secureexec);
+	lsm_enlist(sop, LSM_sb_alloc_security, sop->sb_alloc_security);
+	lsm_enlist(sop, LSM_sb_free_security, sop->sb_free_security);
+	lsm_enlist(sop, LSM_sb_copy_data, sop->sb_copy_data);
+	lsm_enlist(sop, LSM_sb_remount, sop->sb_remount);
+	lsm_enlist(sop, LSM_sb_kern_mount, sop->sb_kern_mount);
+	lsm_enlist(sop, LSM_sb_show_options, sop->sb_show_options);
+	lsm_enlist(sop, LSM_sb_statfs, sop->sb_statfs);
+	lsm_enlist(sop, LSM_sb_mount, sop->sb_mount);
+	lsm_enlist(sop, LSM_sb_umount, sop->sb_umount);
+	lsm_enlist(sop, LSM_sb_pivotroot, sop->sb_pivotroot);
+	lsm_enlist(sop, LSM_sb_set_mnt_opts, sop->sb_set_mnt_opts);
+	lsm_enlist(sop, LSM_sb_clone_mnt_opts, sop->sb_clone_mnt_opts);
+	lsm_enlist(sop, LSM_sb_parse_opts_str, sop->sb_parse_opts_str);
+	lsm_enlist(sop, LSM_inode_alloc_security, sop->inode_alloc_security);
+	lsm_enlist(sop, LSM_inode_free_security, sop->inode_free_security);
+	lsm_enlist(sop, LSM_inode_init_security, sop->inode_init_security);
+#ifdef CONFIG_SECURITY_PATH
+	lsm_enlist(sop, LSM_path_mknod, sop->path_mknod);
+	lsm_enlist(sop, LSM_path_mkdir, sop->path_mkdir);
+	lsm_enlist(sop, LSM_path_rmdir, sop->path_rmdir);
+	lsm_enlist(sop, LSM_path_unlink, sop->path_unlink);
+	lsm_enlist(sop, LSM_path_symlink, sop->path_symlink);
+	lsm_enlist(sop, LSM_path_link, sop->path_link);
+	lsm_enlist(sop, LSM_path_rename, sop->path_rename);
+	lsm_enlist(sop, LSM_path_truncate, sop->path_truncate);
+	lsm_enlist(sop, LSM_path_chmod, sop->path_chmod);
+	lsm_enlist(sop, LSM_path_chown, sop->path_chown);
+	lsm_enlist(sop, LSM_path_chroot, sop->path_chroot);
+#endif
+	lsm_enlist(sop, LSM_inode_create, sop->inode_create);
+	lsm_enlist(sop, LSM_inode_link, sop->inode_link);
+	lsm_enlist(sop, LSM_inode_unlink, sop->inode_unlink);
+	lsm_enlist(sop, LSM_inode_symlink, sop->inode_symlink);
+	lsm_enlist(sop, LSM_inode_mkdir, sop->inode_mkdir);
+	lsm_enlist(sop, LSM_inode_rmdir, sop->inode_rmdir);
+	lsm_enlist(sop, LSM_inode_mknod, sop->inode_mknod);
+	lsm_enlist(sop, LSM_inode_rename, sop->inode_rename);
+	lsm_enlist(sop, LSM_inode_readlink, sop->inode_readlink);
+	lsm_enlist(sop, LSM_inode_follow_link, sop->inode_follow_link);
+	lsm_enlist(sop, LSM_inode_permission, sop->inode_permission);
+	lsm_enlist(sop, LSM_inode_setattr, sop->inode_setattr);
+	lsm_enlist(sop, LSM_inode_getattr, sop->inode_getattr);
+	lsm_enlist(sop, LSM_inode_setxattr, sop->inode_setxattr);
+	lsm_enlist(sop, LSM_inode_post_setxattr, sop->inode_post_setxattr);
+	lsm_enlist(sop, LSM_inode_getxattr, sop->inode_getxattr);
+	lsm_enlist(sop, LSM_inode_listxattr, sop->inode_listxattr);
+	lsm_enlist(sop, LSM_inode_removexattr, sop->inode_removexattr);
+	lsm_enlist(sop, LSM_inode_need_killpriv, sop->inode_need_killpriv);
+	lsm_enlist(sop, LSM_inode_killpriv, sop->inode_killpriv);
+	lsm_enlist(sop, LSM_inode_getsecurity, sop->inode_getsecurity);
+	lsm_enlist(sop, LSM_inode_setsecurity, sop->inode_setsecurity);
+	lsm_enlist(sop, LSM_inode_listsecurity, sop->inode_listsecurity);
+	lsm_enlist(sop, LSM_inode_getsecid, sop->inode_getsecid);
+	lsm_enlist(sop, LSM_file_permission, sop->file_permission);
+	lsm_enlist(sop, LSM_file_alloc_security, sop->file_alloc_security);
+	lsm_enlist(sop, LSM_file_free_security, sop->file_free_security);
+	lsm_enlist(sop, LSM_file_ioctl, sop->file_ioctl);
+	lsm_enlist(sop, LSM_mmap_file, sop->mmap_file);
+	lsm_enlist(sop, LSM_mmap_addr, sop->mmap_addr);
+	lsm_enlist(sop, LSM_file_mprotect, sop->file_mprotect);
+	lsm_enlist(sop, LSM_file_lock, sop->file_lock);
+	lsm_enlist(sop, LSM_file_fcntl, sop->file_fcntl);
+	lsm_enlist(sop, LSM_file_set_fowner, sop->file_set_fowner);
+	lsm_enlist(sop, LSM_file_send_sigiotask, sop->file_send_sigiotask);
+	lsm_enlist(sop, LSM_file_receive, sop->file_receive);
+	lsm_enlist(sop, LSM_file_open, sop->file_open);
+	lsm_enlist(sop, LSM_task_create, sop->task_create);
+	lsm_enlist(sop, LSM_task_free, sop->task_free);
+	lsm_enlist(sop, LSM_cred_alloc_blank, sop->cred_alloc_blank);
+	lsm_enlist(sop, LSM_cred_free, sop->cred_free);
+	lsm_enlist(sop, LSM_cred_prepare, sop->cred_prepare);
+	lsm_enlist(sop, LSM_cred_transfer, sop->cred_transfer);
+	lsm_enlist(sop, LSM_kernel_act_as, sop->kernel_act_as);
+	lsm_enlist(sop, LSM_kernel_create_files_as,
+			sop->kernel_create_files_as);
+	lsm_enlist(sop, LSM_kernel_module_request, sop->kernel_module_request);
+	lsm_enlist(sop, LSM_task_fix_setuid, sop->task_fix_setuid);
+	lsm_enlist(sop, LSM_task_setpgid, sop->task_setpgid);
+	lsm_enlist(sop, LSM_task_getpgid, sop->task_getpgid);
+	lsm_enlist(sop, LSM_task_getsid, sop->task_getsid);
+	lsm_enlist(sop, LSM_task_getsecid, sop->task_getsecid);
+	lsm_enlist(sop, LSM_task_setnice, sop->task_setnice);
+	lsm_enlist(sop, LSM_task_setioprio, sop->task_setioprio);
+	lsm_enlist(sop, LSM_task_getioprio, sop->task_getioprio);
+	lsm_enlist(sop, LSM_task_setrlimit, sop->task_setrlimit);
+	lsm_enlist(sop, LSM_task_setscheduler, sop->task_setscheduler);
+	lsm_enlist(sop, LSM_task_getscheduler, sop->task_getscheduler);
+	lsm_enlist(sop, LSM_task_movememory, sop->task_movememory);
+	lsm_enlist(sop, LSM_task_kill, sop->task_kill);
+	lsm_enlist(sop, LSM_task_wait, sop->task_wait);
+	lsm_enlist(sop, LSM_task_prctl, sop->task_prctl);
+	lsm_enlist(sop, LSM_task_to_inode, sop->task_to_inode);
+	lsm_enlist(sop, LSM_ipc_permission, sop->ipc_permission);
+	lsm_enlist(sop, LSM_ipc_getsecid, sop->ipc_getsecid);
+	lsm_enlist(sop, LSM_msg_msg_alloc_security,
+			sop->msg_msg_alloc_security);
+	lsm_enlist(sop, LSM_msg_msg_free_security, sop->msg_msg_free_security);
+	lsm_enlist(sop, LSM_msg_queue_alloc_security,
+			sop->msg_queue_alloc_security);
+	lsm_enlist(sop, LSM_msg_queue_free_security,
+			sop->msg_queue_free_security);
+	lsm_enlist(sop, LSM_msg_queue_associate, sop->msg_queue_associate);
+	lsm_enlist(sop, LSM_msg_queue_msgctl, sop->msg_queue_msgctl);
+	lsm_enlist(sop, LSM_msg_queue_msgsnd, sop->msg_queue_msgsnd);
+	lsm_enlist(sop, LSM_msg_queue_msgrcv, sop->msg_queue_msgrcv);
+	lsm_enlist(sop, LSM_shm_alloc_security, sop->shm_alloc_security);
+	lsm_enlist(sop, LSM_shm_free_security, sop->shm_free_security);
+	lsm_enlist(sop, LSM_shm_associate, sop->shm_associate);
+	lsm_enlist(sop, LSM_shm_shmctl, sop->shm_shmctl);
+	lsm_enlist(sop, LSM_shm_shmat, sop->shm_shmat);
+	lsm_enlist(sop, LSM_sem_alloc_security, sop->sem_alloc_security);
+	lsm_enlist(sop, LSM_sem_free_security, sop->sem_free_security);
+	lsm_enlist(sop, LSM_sem_associate, sop->sem_associate);
+	lsm_enlist(sop, LSM_sem_semctl, sop->sem_semctl);
+	lsm_enlist(sop, LSM_sem_semop, sop->sem_semop);
+	lsm_enlist(sop, LSM_d_instantiate, sop->d_instantiate);
+	lsm_enlist(sop, LSM_getprocattr, sop->getprocattr);
+	lsm_enlist(sop, LSM_setprocattr, sop->setprocattr);
+	lsm_enlist(sop, LSM_netlink_send, sop->netlink_send);
+	lsm_enlist(sop, LSM_secid_to_secctx, sop->secid_to_secctx);
+	lsm_enlist(sop, LSM_secctx_to_secid, sop->secctx_to_secid);
+	lsm_enlist(sop, LSM_release_secctx, sop->release_secctx);
+	lsm_enlist(sop, LSM_inode_notifysecctx, sop->inode_notifysecctx);
+	lsm_enlist(sop, LSM_inode_setsecctx, sop->inode_setsecctx);
+	lsm_enlist(sop, LSM_inode_getsecctx, sop->inode_getsecctx);
+#ifdef CONFIG_SECURITY_NETWORK
+	lsm_enlist(sop, LSM_unix_stream_connect, sop->unix_stream_connect);
+	lsm_enlist(sop, LSM_unix_may_send, sop->unix_may_send);
+	lsm_enlist(sop, LSM_socket_create, sop->socket_create);
+	lsm_enlist(sop, LSM_socket_post_create, sop->socket_post_create);
+	lsm_enlist(sop, LSM_socket_bind, sop->socket_bind);
+	lsm_enlist(sop, LSM_socket_connect, sop->socket_connect);
+	lsm_enlist(sop, LSM_socket_listen, sop->socket_listen);
+	lsm_enlist(sop, LSM_socket_accept, sop->socket_accept);
+	lsm_enlist(sop, LSM_socket_sendmsg, sop->socket_sendmsg);
+	lsm_enlist(sop, LSM_socket_recvmsg, sop->socket_recvmsg);
+	lsm_enlist(sop, LSM_socket_getsockname, sop->socket_getsockname);
+	lsm_enlist(sop, LSM_socket_getpeername, sop->socket_getpeername);
+	lsm_enlist(sop, LSM_socket_getsockopt, sop->socket_getsockopt);
+	lsm_enlist(sop, LSM_socket_setsockopt, sop->socket_setsockopt);
+	lsm_enlist(sop, LSM_socket_shutdown, sop->socket_shutdown);
+	lsm_enlist(sop, LSM_socket_sock_rcv_skb, sop->socket_sock_rcv_skb);
+	lsm_enlist(sop, LSM_socket_getpeersec_stream,
+			sop->socket_getpeersec_stream);
+	lsm_enlist(sop, LSM_socket_getpeersec_dgram,
+			sop->socket_getpeersec_dgram);
+	lsm_enlist(sop, LSM_sk_alloc_security, sop->sk_alloc_security);
+	lsm_enlist(sop, LSM_sk_free_security, sop->sk_free_security);
+	lsm_enlist(sop, LSM_sk_clone_security, sop->sk_clone_security);
+	lsm_enlist(sop, LSM_req_classify_flow, sop->req_classify_flow);
+	lsm_enlist(sop, LSM_sock_graft, sop->sock_graft);
+	lsm_enlist(sop, LSM_inet_conn_request, sop->inet_conn_request);
+	lsm_enlist(sop, LSM_inet_csk_clone, sop->inet_csk_clone);
+	lsm_enlist(sop, LSM_inet_conn_established, sop->inet_conn_established);
+	lsm_enlist(sop, LSM_secmark_relabel_packet,
+			sop->secmark_relabel_packet);
+	lsm_enlist(sop, LSM_secmark_refcount_inc, sop->secmark_refcount_inc);
+	lsm_enlist(sop, LSM_secmark_refcount_dec, sop->secmark_refcount_dec);
+	lsm_enlist(sop, LSM_tun_dev_create, sop->tun_dev_create);
+	lsm_enlist(sop, LSM_tun_dev_post_create, sop->tun_dev_post_create);
+	lsm_enlist(sop, LSM_tun_dev_attach, sop->tun_dev_attach);
+#endif
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	lsm_enlist(sop, LSM_xfrm_policy_alloc_security,
+			sop->xfrm_policy_alloc_security);
+	lsm_enlist(sop, LSM_xfrm_policy_clone_security,
+			sop->xfrm_policy_clone_security);
+	lsm_enlist(sop, LSM_xfrm_policy_free_security,
+			sop->xfrm_policy_free_security);
+	lsm_enlist(sop, LSM_xfrm_policy_delete_security,
+			sop->xfrm_policy_delete_security);
+	lsm_enlist(sop, LSM_xfrm_state_alloc_security,
+			sop->xfrm_state_alloc_security);
+	lsm_enlist(sop, LSM_xfrm_state_delete_security,
+			sop->xfrm_state_delete_security);
+	lsm_enlist(sop, LSM_xfrm_state_free_security,
+			sop->xfrm_state_free_security);
+	lsm_enlist(sop, LSM_xfrm_policy_lookup, sop->xfrm_policy_lookup);
+	lsm_enlist(sop, LSM_xfrm_state_pol_flow_match,
+			sop->xfrm_state_pol_flow_match);
+	lsm_enlist(sop, LSM_xfrm_decode_session, sop->xfrm_decode_session);
+#endif
+#ifdef CONFIG_KEYS
+	lsm_enlist(sop, LSM_key_alloc, sop->key_alloc);
+	lsm_enlist(sop, LSM_key_free, sop->key_free);
+	lsm_enlist(sop, LSM_key_permission, sop->key_permission);
+	lsm_enlist(sop, LSM_key_getsecurity, sop->key_getsecurity);
+#endif
+#ifdef CONFIG_AUDIT
+	lsm_enlist(sop, LSM_audit_rule_init, sop->audit_rule_init);
+	lsm_enlist(sop, LSM_audit_rule_known, sop->audit_rule_known);
+	lsm_enlist(sop, LSM_audit_rule_free, sop->audit_rule_free);
+	lsm_enlist(sop, LSM_audit_rule_match, sop->audit_rule_match);
+#endif
+
+	lsm_enlist(sop, LSM_name, sop->name);
 }
 
 static void __init do_security_initcalls(void)
 {
 	initcall_t *call;
+
 	call = __security_initcall_start;
 	while (call < __security_initcall_end) {
 		(*call) ();
@@ -63,24 +317,71 @@ static void __init do_security_initcalls(void)
  */
 int __init security_init(void)
 {
-	printk(KERN_INFO "Security Framework initialized\n");
+	enum lsm_hooks_index i;
+
+	for (i = 0; i < LSM_MAX_HOOKS; i++)
+		INIT_LIST_HEAD(&lsm_hooks[i]);
+
+	pr_info("Security Framework initialized\n");
 
-	security_fixup_ops(&default_security_ops);
-	security_ops = &default_security_ops;
 	do_security_initcalls();
 
 	return 0;
 }
 
-void reset_security_ops(void)
+/*
+ * Only SELinux calls reset_security_ops.
+ */
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+
+static void lsm_delist_ops(struct security_operations *sop)
 {
-	security_ops = &default_security_ops;
+	enum lsm_hooks_index i;
+
+	for (i = 0; i < LSM_MAX_HOOKS; i++)
+		if (sop->list[i].next && !list_empty(&sop->list[i]))
+			list_del_rcu(&sop->list[i]);
+	return;
 }
 
-/* Save user chosen LSM */
+int reset_security_ops(struct security_operations *ops)
+{
+	/*
+	 * This LSM is configured to own /proc/.../attr.
+	 */
+	if (lsm_present == ops)
+		lsm_present = NULL;
+
+	lsm_delist_ops(ops);
+
+	return 0;
+}
+
+#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
+
+/* Save user chosen LSM(s) */
 static int __init choose_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	char *cp;
+	char *ep;
+	int i;
+
+	strncpy(allowed_lsms, str, COMPOSER_NAMES_MAX);
+	cp = allowed_lsms;
+
+	for (i = 0; i < COMPOSER_MAX; i++) {
+		ep = strchr(cp, ',');
+		if (ep != NULL)
+			*ep = '\0';
+		if (strlen(cp) > SECURITY_NAME_MAX)
+			pr_warn("LSM \"%s\" is invalid and ignored.\n", cp);
+		else
+			strncpy(specified_lsms[i], cp, SECURITY_NAME_MAX);
+		if (ep == NULL)
+			break;
+		cp = ep + 1;
+	}
+
 	return 1;
 }
 __setup("security=", choose_lsm);
@@ -94,74 +395,265 @@ __setup("security=", choose_lsm);
  * to check if your LSM is currently loaded during kernel initialization.
  *
  * Return true if:
- *	-The passed LSM is the one chosen by user at boot time,
- *	-or the passed LSM is configured as the default and the user did not
- *	 choose an alternate LSM at boot time.
+ *	-The passed LSM is on the list of LSMs specified at boot time,
+ *	-or no boot list was specified.
  * Otherwise, return false.
  */
 int __init security_module_enable(struct security_operations *ops)
 {
-	return !strcmp(ops->name, chosen_lsm);
-}
+	struct security_operations *sop;
+	int i;
 
-/**
- * register_security - registers a security framework with the kernel
- * @ops: a pointer to the struct security_options that is to be registered
- *
- * This function allows a security module to register itself with the
- * kernel security subsystem.  Some rudimentary checking is done on the @ops
- * value passed to this function. You'll need to check first if your LSM
- * is allowed to register its @ops by calling security_module_enable(@ops).
- *
- * If there is already a security module registered with the kernel,
- * an error will be returned.  Otherwise %0 is returned on success.
- */
-int __init register_security(struct security_operations *ops)
-{
-	if (verify(ops)) {
-		printk(KERN_DEBUG "%s could not verify "
-		       "security_operations structure.\n", __func__);
-		return -EINVAL;
+	if (lsm_count >= COMPOSER_MAX) {
+		pr_warn("Too many security modules. %s not loaded.\n",
+				ops->name);
+		return 0;
+	}
+	/*
+	 * Set up the operation vector early, but only once.
+	 * This allows LSM specific file systems to check to see if they
+	 * should come on line.
+	 */
+	if (ops == NULL) {
+		pr_debug("%s could not verify security_operations.\n",
+				__func__);
+		return 0;
+	}
+	/*
+	 * Return success if the LSM is already resistered
+	 */
+	for_each_hook(sop, name)
+		if (sop == ops)
+			return 1;
+
+	if (specified_lsms[0][0] != '\0') {
+		ops->order = 0;
+		for (i = 0; specified_lsms[i][0] != '\0'; i++) {
+			if (strcmp(ops->name, specified_lsms[i]) == 0) {
+				ops->order = i + 1;
+				break;
+			}
+		}
+		if (ops->order == 0) {
+			pr_notice("LSM %s declined by boot options.\n",
+					ops->name);
+			return 0;
+		}
+	}
+	/*
+	 * Check for conflicting LSMs.
+	 */
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+	if (ops->xfrm_policy_alloc_security &&
+	    !list_empty(&lsm_hooks[LSM_xfrm_policy_alloc_security])) {
+		pr_warn("LSM conflict on %s. %s not loaded.\n",
+				"xfrm_policy_alloc_security", ops->name);
+		return 0;
+	}
+#endif
+	if (ops->secid_to_secctx &&
+	    !list_empty(&lsm_hooks[LSM_secid_to_secctx])) {
+		pr_warn("LSM conflict on %s. %s not loaded.\n",
+			"secid_to_secctx", ops->name);
+		return 0;
 	}
 
-	if (security_ops != &default_security_ops)
-		return -EAGAIN;
+	/*
+	 * The order will already be set if the command line
+	 * includes "security=".
+	 *
+	 * Do this before the enlisting. If there is an error
+	 * (Very unlikely!) that prevents the enlisting from
+	 * completing it is still necessary to have a blob slot
+	 * for it.
+	 */
+	lsm_count++;
+	if (ops->order == 0)
+		ops->order = lsm_count;
 
-	security_ops = ops;
+	/*
+	 * If there is an explict "present=" and that LSM registers
+	 * use it in [gs]etprocattr.
+	 *
+	 * If it isn't specified, or never registers, and there is
+	 * exactly one LSM that provides [gs]etprocattr use that
+	 * LSM as the presenter.
+	 */
+	if (!strcmp(ops->name, present_lsm)) {
+		present_lsm_count = -1;
+		lsm_present = ops;
+	} else if (present_lsm_count >= 0 &&
+		   (ops->setprocattr || ops->getprocattr)) {
+		present_lsm_count++;
+		if (present_lsm_count == 1)
+			lsm_present = ops;
+		else
+			lsm_present = NULL;
+	}
+	if (lsm_present) {
+		present_getprocattr = lsm_present->getprocattr;
+		present_setprocattr = lsm_present->setprocattr;
+	}
 
-	return 0;
+	/*
+	 * Return success after registering the LSM.
+	 */
+	lsm_enlist_ops(ops);
+
+	return 1;
 }
 
 /* Security operations */
 
+/*
+ * Because so many of the cases are treated the same.
+ */
+#define call_void_hook(FUNC, ...)					\
+	do {								\
+		struct security_operations *sop;			\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC])		\
+			sop->FUNC(__VA_ARGS__);				\
+	} while (0)							\
+
+#define call_int_hook(RC, FUNC, ...)					\
+	do {								\
+		struct security_operations *sop;			\
+		int thisrc;						\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC]) {		\
+			thisrc = sop->FUNC(__VA_ARGS__);		\
+			if (thisrc)					\
+				RC = thisrc;				\
+		}							\
+	} while (0)							\
+
+#define call_int_cap_first(RC, FUNC, ...)				\
+	do {								\
+		struct security_operations *sop;			\
+		int thisrc;						\
+									\
+		thisrc = cap_##FUNC(__VA_ARGS__);			\
+		if (thisrc) {						\
+			RC = thisrc;					\
+			break;						\
+		}							\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC]) {		\
+			thisrc = sop->FUNC(__VA_ARGS__);		\
+			if (thisrc)					\
+				RC = thisrc;				\
+		}							\
+	} while (0)							\
+
+#define call_int_cap_last(RC, FUNC, ...)				\
+	do {								\
+		struct security_operations *sop;			\
+		int thisrc;						\
+									\
+		list_for_each_entry(sop, &lsm_hooks[LSM_##FUNC],	\
+					list[LSM_##FUNC]) {		\
+			thisrc = sop->FUNC(__VA_ARGS__);		\
+			if (thisrc)					\
+				RC = thisrc;				\
+		}							\
+									\
+		if (!RC)						\
+			RC = cap_##FUNC(__VA_ARGS__);			\
+	} while (0)							\
+
+
+#define call_alloc_hook(RC, ALLOC, FREE, FIELD, GFP, ARG)		\
+	do {								\
+		struct security_operations *sop;			\
+		struct security_operations *note[COMPOSER_MAX];		\
+		struct lsm_blob tblob;					\
+		struct lsm_blob *bp = NULL;				\
+		int successes = 0;					\
+									\
+		memset(&tblob, 0, sizeof(tblob));			\
+		FIELD = &tblob;						\
+		for_each_hook(sop, ALLOC) {				\
+			RC = sop->ALLOC(ARG);				\
+			if (RC)						\
+				break;					\
+			note[successes++] = sop;			\
+		}							\
+		if (tblob.lsm_setcount != 0) {				\
+			if (RC == 0)					\
+				bp = kmemdup(&tblob, sizeof(tblob), GFP); \
+			if (bp == NULL) {				\
+				if (RC == 0)				\
+					RC = -ENOMEM;			\
+				while (successes > 0)			\
+					note[--successes]->FREE(ARG);	\
+			}						\
+		}							\
+		FIELD = bp;						\
+	} while (0)							\
+
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_access_check(child, mode);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_access_check(child, mode);
+	int rc = 0;
+
+	call_int_cap_first(rc, ptrace_access_check, child, mode);
+	return rc;
 }
 
 int security_ptrace_traceme(struct task_struct *parent)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	int rc;
-	rc = yama_ptrace_traceme(parent);
-	if (rc)
-		return rc;
-#endif
-	return security_ops->ptrace_traceme(parent);
+	int rc = 0;
+
+	call_int_cap_first(rc, ptrace_traceme, parent);
+	return rc;
+}
+
+static void and_caps(kernel_cap_t *base, const kernel_cap_t *mask)
+{
+	int i;
+
+	for (i = 0; i < _KERNEL_CAPABILITY_U32S; i++)
+		base->cap[i] &= mask->cap[i];
 }
 
+/*
+ * Odd duck hook handling.
+ * This hook returns the set of capabilities available to
+ * the "target" task. Apparmor restricts the capabilities
+ * based on profile and SELinux may deny the ability to
+ * look and see what they are. cap_capget never fails.
+ */
 int security_capget(struct task_struct *target,
 		     kernel_cap_t *effective,
 		     kernel_cap_t *inheritable,
 		     kernel_cap_t *permitted)
 {
-	return security_ops->capget(target, effective, inheritable, permitted);
+	struct security_operations *sop;
+	kernel_cap_t cap[3];
+	kernel_cap_t this[3];
+	int rc;
+	int i;
+
+	rc = cap_capget(target, &cap[0], &cap[1], &cap[2]);
+	if (rc != 0)
+		return rc;
+
+	for_each_hook(sop, capget) {
+		rc = sop->capget(target, &this[0], &this[1], &this[2]);
+		if (rc != 0)
+			return rc;
+		for (i = 0; i < 3; i++)
+			and_caps(&cap[i], &this[i]);
+	}
+
+	*effective = cap[0];
+	*inheritable = cap[1];
+	*permitted = cap[2];
+
+	return 0;
 }
 
 int security_capset(struct cred *new, const struct cred *old,
@@ -169,195 +661,284 @@ int security_capset(struct cred *new, const struct cred *old,
 		    const kernel_cap_t *inheritable,
 		    const kernel_cap_t *permitted)
 {
-	return security_ops->capset(new, old,
-				    effective, inheritable, permitted);
+	int rc = 0;
+
+	call_int_cap_first(rc, capset, new, old, effective,
+				inheritable, permitted);
+	return rc;
 }
 
 int security_capable(const struct cred *cred, struct user_namespace *ns,
 		     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_AUDIT);
+	int rc = 0;
+
+	call_int_cap_first(rc, capable, cred, ns, cap, SECURITY_CAP_AUDIT);
+	return rc;
 }
 
 int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
 			     int cap)
 {
-	return security_ops->capable(cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	int rc = 0;
+
+	call_int_cap_first(rc, capable, cred, ns, cap, SECURITY_CAP_NOAUDIT);
+	return rc;
 }
 
 int security_quotactl(int cmds, int type, int id, struct super_block *sb)
 {
-	return security_ops->quotactl(cmds, type, id, sb);
+	int rc = 0;
+
+	call_int_hook(rc, quotactl, cmds, type, id, sb);
+	return rc;
 }
 
 int security_quota_on(struct dentry *dentry)
 {
-	return security_ops->quota_on(dentry);
+	int rc = 0;
+
+	call_int_hook(rc, quota_on, dentry);
+	return rc;
 }
 
 int security_syslog(int type)
 {
-	return security_ops->syslog(type);
+	int rc = 0;
+
+	call_int_hook(rc, syslog, type);
+	return rc;
 }
 
 int security_settime(const struct timespec *ts, const struct timezone *tz)
 {
-	return security_ops->settime(ts, tz);
+	int rc = 0;
+
+	call_int_cap_first(rc, settime, ts, tz);
+	return rc;
 }
 
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	return security_ops->vm_enough_memory(mm, pages);
+	int rc = 0;
+
+	call_int_cap_first(rc, vm_enough_memory, mm, pages);
+	return rc;
 }
 
 int security_bprm_set_creds(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_set_creds(bprm);
+	int rc = 0;
+
+	call_int_cap_first(rc, bprm_set_creds, bprm);
+	return rc;
 }
 
 int security_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
+	int rc = 0;
+
+	call_int_hook(rc, bprm_check_security, bprm);
+
+	if (rc)
+		return rc;
 
-	ret = security_ops->bprm_check_security(bprm);
-	if (ret)
-		return ret;
 	return ima_bprm_check(bprm);
 }
 
+
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committing_creds(bprm);
+	call_void_hook(bprm_committing_creds, bprm);
 }
 
 void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
-	security_ops->bprm_committed_creds(bprm);
+	call_void_hook(bprm_committed_creds, bprm);
 }
 
 int security_bprm_secureexec(struct linux_binprm *bprm)
 {
-	return security_ops->bprm_secureexec(bprm);
+	int rc = 0;
+
+	call_int_cap_last(rc, bprm_secureexec, bprm);
+	return rc;
 }
 
 int security_sb_alloc(struct super_block *sb)
 {
-	return security_ops->sb_alloc_security(sb);
+	int rc = 0;
+
+	call_alloc_hook(rc, sb_alloc_security, sb_free_security,
+			sb->s_security, GFP_KERNEL, sb);
+	return rc;
 }
 
 void security_sb_free(struct super_block *sb)
 {
-	security_ops->sb_free_security(sb);
+	call_void_hook(sb_free_security, sb);
+
+	kfree(sb->s_security);
+	sb->s_security = NULL;
 }
 
 int security_sb_copy_data(char *orig, char *copy)
 {
-	return security_ops->sb_copy_data(orig, copy);
+	int rc = 0;
+
+	call_int_hook(rc, sb_copy_data, orig, copy);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_copy_data);
 
 int security_sb_remount(struct super_block *sb, void *data)
 {
-	return security_ops->sb_remount(sb, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_remount, sb, data);
+	return rc;
 }
 
 int security_sb_kern_mount(struct super_block *sb, int flags, void *data)
 {
-	return security_ops->sb_kern_mount(sb, flags, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_kern_mount, sb, flags, data);
+	return rc;
 }
 
 int security_sb_show_options(struct seq_file *m, struct super_block *sb)
 {
-	return security_ops->sb_show_options(m, sb);
+	int rc = 0;
+
+	call_int_hook(rc, sb_show_options, m, sb);
+	return rc;
 }
 
 int security_sb_statfs(struct dentry *dentry)
 {
-	return security_ops->sb_statfs(dentry);
+	int rc = 0;
+
+	call_int_hook(rc, sb_statfs, dentry);
+	return rc;
 }
 
 int security_sb_mount(const char *dev_name, struct path *path,
                        const char *type, unsigned long flags, void *data)
 {
-	return security_ops->sb_mount(dev_name, path, type, flags, data);
+	int rc = 0;
+
+	call_int_hook(rc, sb_mount, dev_name, path, type, flags, data);
+	return rc;
 }
 
 int security_sb_umount(struct vfsmount *mnt, int flags)
 {
-	return security_ops->sb_umount(mnt, flags);
+	int rc = 0;
+
+	call_int_hook(rc, sb_umount, mnt, flags);
+	return rc;
 }
 
 int security_sb_pivotroot(struct path *old_path, struct path *new_path)
 {
-	return security_ops->sb_pivotroot(old_path, new_path);
+	int rc = 0;
+
+	call_int_hook(rc, sb_pivotroot, old_path, new_path);
+	return rc;
 }
 
 int security_sb_set_mnt_opts(struct super_block *sb,
 				struct security_mnt_opts *opts)
 {
-	return security_ops->sb_set_mnt_opts(sb, opts);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_sb_set_mnt_opts])) {
+		if (unlikely(opts->num_mnt_opts))
+			return -EOPNOTSUPP;
+		return 0;
+	}
+
+	call_int_hook(rc, sb_set_mnt_opts, sb, opts);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_set_mnt_opts);
 
 void security_sb_clone_mnt_opts(const struct super_block *oldsb,
 				struct super_block *newsb)
 {
-	security_ops->sb_clone_mnt_opts(oldsb, newsb);
+	call_void_hook(sb_clone_mnt_opts, oldsb, newsb);
 }
 EXPORT_SYMBOL(security_sb_clone_mnt_opts);
 
 int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts)
 {
-	return security_ops->sb_parse_opts_str(options, opts);
+	int rc = 0;
+
+	call_int_hook(rc, sb_parse_opts_str, options, opts);
+	return rc;
 }
 EXPORT_SYMBOL(security_sb_parse_opts_str);
 
 int security_inode_alloc(struct inode *inode)
 {
-	inode->i_security = NULL;
-	return security_ops->inode_alloc_security(inode);
+	int rc = 0;
+
+	call_alloc_hook(rc, inode_alloc_security, inode_free_security,
+			inode->i_security, GFP_KERNEL, inode);
+	return rc;
 }
 
 void security_inode_free(struct inode *inode)
 {
 	integrity_inode_free(inode);
-	security_ops->inode_free_security(inode);
+
+	call_void_hook(inode_free_security, inode);
+
+	kfree(inode->i_security);
+	inode->i_security = NULL;
 }
 
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 const initxattrs initxattrs, void *fs_data)
 {
+	int rc = 0;
 	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
 	struct xattr *lsm_xattr, *evm_xattr, *xattr;
-	int ret;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
 	memset(new_xattrs, 0, sizeof new_xattrs);
-	if (!initxattrs)
-		return security_ops->inode_init_security(inode, dir, qstr,
-							 NULL, NULL, NULL);
+	if (!initxattrs) {
+		call_int_hook(rc, inode_init_security, inode, dir, qstr,
+				NULL, NULL, NULL);
+		return rc;
+	}
+
 	lsm_xattr = new_xattrs;
-	ret = security_ops->inode_init_security(inode, dir, qstr,
-						&lsm_xattr->name,
-						&lsm_xattr->value,
-						&lsm_xattr->value_len);
-	if (ret)
+
+	if (list_empty(&lsm_hooks[LSM_inode_init_security]))
+		rc = -EOPNOTSUPP;
+	else
+		call_int_hook(rc, inode_init_security, inode, dir, qstr,
+			&lsm_xattr->name, &lsm_xattr->value,
+			&lsm_xattr->value_len);
+	if (rc)
 		goto out;
 
 	evm_xattr = lsm_xattr + 1;
-	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
-	if (ret)
+	rc = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
+	if (rc)
 		goto out;
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	rc = initxattrs(inode, new_xattrs, fs_data);
 out:
 	for (xattr = new_xattrs; xattr->name != NULL; xattr++) {
 		kfree(xattr->name);
 		kfree(xattr->value);
 	}
-	return (ret == -EOPNOTSUPP) ? 0 : ret;
+	return (rc == -EOPNOTSUPP) ? 0 : rc;
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
@@ -365,10 +946,14 @@ int security_old_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, char **name,
 				     void **value, size_t *len)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_init_security(inode, dir, qstr, name, value,
-						 len);
+
+	call_int_hook(rc, inode_init_security, inode, dir, qstr, name,
+							value, len);
+	return rc;
 }
 EXPORT_SYMBOL(security_old_inode_init_security);
 
@@ -376,206 +961,300 @@ EXPORT_SYMBOL(security_old_inode_init_security);
 int security_path_mknod(struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mknod(dir, dentry, mode, dev);
+
+	call_int_hook(rc, path_mknod, dir, dentry, mode, dev);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_mknod);
 
 int security_path_mkdir(struct path *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_mkdir(dir, dentry, mode);
+
+	call_int_hook(rc, path_mkdir, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_mkdir);
 
 int security_path_rmdir(struct path *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_rmdir(dir, dentry);
+
+	call_int_hook(rc, path_rmdir, dir, dentry);
+	return rc;
 }
 
 int security_path_unlink(struct path *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_unlink(dir, dentry);
+
+	call_int_hook(rc, path_unlink, dir, dentry);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_unlink);
 
 int security_path_symlink(struct path *dir, struct dentry *dentry,
 			  const char *old_name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir->dentry->d_inode)))
 		return 0;
-	return security_ops->path_symlink(dir, dentry, old_name);
+
+	call_int_hook(rc, path_symlink, dir, dentry, old_name);
+	return rc;
 }
 
 int security_path_link(struct dentry *old_dentry, struct path *new_dir,
 		       struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->path_link(old_dentry, new_dir, new_dentry);
+
+	call_int_hook(rc, path_link, old_dentry, new_dir, new_dentry);
+	return rc;
 }
 
 int security_path_rename(struct path *old_dir, struct dentry *old_dentry,
 			 struct path *new_dir, struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
 		     (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-	return security_ops->path_rename(old_dir, old_dentry, new_dir,
-					 new_dentry);
+
+	call_int_hook(rc, path_rename, old_dir, old_dentry, new_dir,
+						new_dentry);
+	return rc;
 }
 EXPORT_SYMBOL(security_path_rename);
 
 int security_path_truncate(struct path *path)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_truncate(path);
+
+	call_int_hook(rc, path_truncate, path);
+	return rc;
 }
 
 int security_path_chmod(struct path *path, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chmod(path, mode);
+
+	call_int_hook(rc, path_chmod, path, mode);
+	return rc;
 }
 
 int security_path_chown(struct path *path, kuid_t uid, kgid_t gid)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(path->dentry->d_inode)))
 		return 0;
-	return security_ops->path_chown(path, uid, gid);
+
+	call_int_hook(rc, path_chown, path, uid, gid);
+	return rc;
 }
 
 int security_path_chroot(struct path *path)
 {
-	return security_ops->path_chroot(path);
+	int rc = 0;
+
+	call_int_hook(rc, path_chroot, path);
+	return rc;
 }
 #endif
 
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_create(dir, dentry, mode);
+
+	call_int_hook(rc, inode_create, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(old_dentry->d_inode)))
 		return 0;
-	return security_ops->inode_link(old_dentry, dir, new_dentry);
+
+	call_int_hook(rc, inode_link, old_dentry, dir, new_dentry);
+	return rc;
 }
 
 int security_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_unlink(dir, dentry);
+
+	call_int_hook(rc, inode_unlink, dir, dentry);
+	return rc;
 }
 
 int security_inode_symlink(struct inode *dir, struct dentry *dentry,
 			    const char *old_name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_symlink(dir, dentry, old_name);
+
+	call_int_hook(rc, inode_symlink, dir, dentry, old_name);
+	return rc;
 }
 
 int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mkdir(dir, dentry, mode);
+
+	call_int_hook(rc, inode_mkdir, dir, dentry, mode);
+	return rc;
 }
 EXPORT_SYMBOL_GPL(security_inode_mkdir);
 
 int security_inode_rmdir(struct inode *dir, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_rmdir(dir, dentry);
+
+	call_int_hook(rc, inode_rmdir, dir, dentry);
+	return rc;
 }
 
 int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dir)))
 		return 0;
-	return security_ops->inode_mknod(dir, dentry, mode, dev);
+
+	call_int_hook(rc, inode_mknod, dir, dentry, mode, dev);
+	return rc;
 }
 
 int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry)
 {
+	int rc = 0;
+
         if (unlikely(IS_PRIVATE(old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE(new_dentry->d_inode))))
 		return 0;
-	return security_ops->inode_rename(old_dir, old_dentry,
-					   new_dir, new_dentry);
+
+	call_int_hook(rc, inode_rename, old_dir, old_dentry, new_dir,
+						new_dentry);
+	return rc;
 }
 
 int security_inode_readlink(struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_readlink(dentry);
+
+	call_int_hook(rc, inode_readlink, dentry);
+	return rc;
 }
 
 int security_inode_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_follow_link(dentry, nd);
+
+	call_int_hook(rc, inode_follow_link, dentry, nd);
+	return rc;
 }
 
 int security_inode_permission(struct inode *inode, int mask)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_permission(inode, mask);
+
+	call_int_hook(rc, inode_permission, inode, mask);
+	return rc;
 }
 
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setattr(dentry, attr);
-	if (ret)
-		return ret;
+
+	call_int_hook(rc, inode_setattr, dentry, attr);
+	if (rc)
+		return rc;
 	return evm_inode_setattr(dentry, attr);
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
 int security_inode_getattr(struct vfsmount *mnt, struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getattr(mnt, dentry);
+
+	call_int_hook(rc, inode_getattr, mnt, dentry);
+	return rc;
 }
 
 int security_inode_setxattr(struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_setxattr(dentry, name, value, size, flags);
-	if (ret)
-		return ret;
-	ret = ima_inode_setxattr(dentry, name, value, size);
-	if (ret)
-		return ret;
+
+	call_int_hook(rc, inode_setxattr, dentry, name, value, size, flags);
+
+	if (rc)
+		return rc;
+	rc = ima_inode_setxattr(dentry, name, value, size);
+	if (rc)
+		return rc;
 	return evm_inode_setxattr(dentry, name, value, size);
 }
 
@@ -584,99 +1263,176 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 {
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return;
-	security_ops->inode_post_setxattr(dentry, name, value, size, flags);
+
+	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
+
 	evm_inode_post_setxattr(dentry, name, value, size);
 }
 
 int security_inode_getxattr(struct dentry *dentry, const char *name)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getxattr(dentry, name);
+
+	call_int_hook(rc, inode_getxattr, dentry, name);
+	return rc;
 }
 
 int security_inode_listxattr(struct dentry *dentry)
 {
+	int rc = 0;
+
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	return security_ops->inode_listxattr(dentry);
+
+	call_int_hook(rc, inode_listxattr, dentry);
+	return rc;
 }
 
 int security_inode_removexattr(struct dentry *dentry, const char *name)
 {
-	int ret;
+	int rc = 0;
 
 	if (unlikely(IS_PRIVATE(dentry->d_inode)))
 		return 0;
-	ret = security_ops->inode_removexattr(dentry, name);
-	if (ret)
-		return ret;
-	ret = ima_inode_removexattr(dentry, name);
-	if (ret)
-		return ret;
+
+	if (list_empty(&lsm_hooks[LSM_inode_removexattr]))
+		return cap_inode_removexattr(dentry, name);
+
+	call_int_hook(rc, inode_removexattr, dentry, name);
+
+	if (rc)
+		return rc;
+	rc = ima_inode_removexattr(dentry, name);
+	if (rc)
+		return rc;
 	return evm_inode_removexattr(dentry, name);
 }
 
 int security_inode_need_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_need_killpriv(dentry);
+	int rc = 0;
+
+	call_int_cap_first(rc, inode_need_killpriv, dentry);
+	return rc;
 }
 
 int security_inode_killpriv(struct dentry *dentry)
 {
-	return security_ops->inode_killpriv(dentry);
+	int rc = 0;
+
+	call_int_cap_first(rc, inode_killpriv, dentry);
+	return rc;
 }
 
 int security_inode_getsecurity(const struct inode *inode, const char *name, void **buffer, bool alloc)
 {
+	struct security_operations *sop;
+	int rc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_getsecurity(inode, name, buffer, alloc);
+
+	/*
+	 * Only one LSM will supply a given "name".
+	 * -EOPNOTSUPP is an indication that the LSM does not
+	 * provide a value for the provided name.
+	 */
+	for_each_hook(sop, inode_getsecurity) {
+		rc = sop->inode_getsecurity(inode, name, buffer, alloc);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+	return -EOPNOTSUPP;
 }
 
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
+	struct security_operations *sop;
+	int rc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return -EOPNOTSUPP;
-	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+
+	/*
+	 * Only one LSM will set a given "name".
+	 * -EOPNOTSUPP is an indication that the LSM does not
+	 * set a value for the provided name.
+	 */
+	for_each_hook(sop, inode_setsecurity) {
+		rc = sop->inode_setsecurity(inode, name, value, size, flags);
+		if (rc != -EOPNOTSUPP)
+			return rc;
+	}
+	return -EOPNOTSUPP;
 }
 
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
+	struct security_operations *sop;
+	int rc = 0;
+	int thisrc;
+
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
-	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+
+	/*
+	 * inode_listsecurity hooks never return negative values.
+	 */
+	for_each_hook(sop, inode_listsecurity) {
+		thisrc = sop->inode_listsecurity(inode, buffer, buffer_size);
+		buffer += thisrc;
+		buffer_size -= thisrc;
+		rc += thisrc;
+	}
+	return rc;
 }
 
 void security_inode_getsecid(const struct inode *inode, u32 *secid)
 {
-	security_ops->inode_getsecid(inode, secid);
+	if (list_empty(&lsm_hooks[LSM_inode_getsecid]))
+		*secid = 0;
+	else
+		call_void_hook(inode_getsecid, inode, secid);
 }
 
 int security_file_permission(struct file *file, int mask)
 {
-	int ret;
+	int rc = 0;
+
+	call_int_hook(rc, file_permission, file, mask);
 
-	ret = security_ops->file_permission(file, mask);
-	if (ret)
-		return ret;
+	if (rc)
+		return rc;
 
 	return fsnotify_perm(file, mask);
 }
 
 int security_file_alloc(struct file *file)
 {
-	return security_ops->file_alloc_security(file);
+	int rc = 0;
+
+	call_alloc_hook(rc, file_alloc_security, file_free_security,
+			file->f_security, GFP_KERNEL, file);
+	return rc;
 }
 
 void security_file_free(struct file *file)
 {
-	security_ops->file_free_security(file);
+	call_void_hook(file_free_security, file);
+
+	kfree(file->f_security);
+	file->f_security = NULL;
 }
 
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_ioctl(file, cmd, arg);
+	int rc = 0;
+
+	call_int_hook(rc, file_ioctl, file, cmd, arg);
+	return rc;
 }
 
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
@@ -716,360 +1472,752 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
-	int ret;
-	ret = security_ops->mmap_file(file, prot,
-					mmap_prot(file, prot), flags);
-	if (ret)
-		return ret;
+	int rc = 0;
+
+	call_int_hook(rc, mmap_file, file, prot, mmap_prot(file, prot), flags);
+
+	if (rc)
+		return rc;
 	return ima_file_mmap(file, prot);
 }
 
 int security_mmap_addr(unsigned long addr)
 {
-	return security_ops->mmap_addr(addr);
+	int rc = 0;
+
+	call_int_cap_last(rc, mmap_addr, addr);
+	return rc;
 }
 
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	return security_ops->file_mprotect(vma, reqprot, prot);
+	int rc = 0;
+
+	call_int_hook(rc, file_mprotect, vma, reqprot, prot);
+	return rc;
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
 {
-	return security_ops->file_lock(file, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, file_lock, file, cmd);
+	return rc;
 }
 
 int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	return security_ops->file_fcntl(file, cmd, arg);
+	int rc = 0;
+
+	call_int_hook(rc, file_fcntl, file, cmd, arg);
+	return rc;
 }
 
 int security_file_set_fowner(struct file *file)
 {
-	return security_ops->file_set_fowner(file);
+	int rc = 0;
+
+	call_int_hook(rc, file_set_fowner, file);
+	return rc;
 }
 
 int security_file_send_sigiotask(struct task_struct *tsk,
 				  struct fown_struct *fown, int sig)
 {
-	return security_ops->file_send_sigiotask(tsk, fown, sig);
+	int rc = 0;
+
+	call_int_hook(rc, file_send_sigiotask, tsk, fown, sig);
+	return rc;
 }
 
 int security_file_receive(struct file *file)
 {
-	return security_ops->file_receive(file);
+	int rc = 0;
+
+	call_int_hook(rc, file_receive, file);
+	return rc;
 }
 
 int security_file_open(struct file *file, const struct cred *cred)
 {
-	int ret;
+	int rc = 0;
+
+	call_int_hook(rc, file_open, file, cred);
 
-	ret = security_ops->file_open(file, cred);
-	if (ret)
-		return ret;
+	if (rc)
+		return rc;
 
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
 int security_task_create(unsigned long clone_flags)
 {
-	return security_ops->task_create(clone_flags);
+	int rc = 0;
+
+	call_int_hook(rc, task_create, clone_flags);
+	return rc;
 }
 
 void security_task_free(struct task_struct *task)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
-	yama_task_free(task);
-#endif
-	security_ops->task_free(task);
+	call_void_hook(task_free, task);
 }
 
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp)
 {
-	return security_ops->cred_alloc_blank(cred, gfp);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	cred->security = &tblob;
+
+	for_each_hook(sop, cred_alloc_blank) {
+		rc = sop->cred_alloc_blank(cred, gfp);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), gfp);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->cred_free(cred);
+		}
+	}
+	cred->security = bp;
+	return rc;
 }
 
 void security_cred_free(struct cred *cred)
 {
-	security_ops->cred_free(cred);
+	call_void_hook(cred_free, cred);
+
+	if (cred->security == NULL)
+		return;
+
+	kfree(cred->security);
+	cred->security = NULL;
 }
 
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp)
 {
-	return security_ops->cred_prepare(new, old, gfp);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	/*
+	 * new->security will be NULL on entry.
+	 */
+	memset(&tblob, 0, sizeof(tblob));
+	new->security = &tblob;
+
+	for_each_hook(sop, cred_prepare) {
+		rc = sop->cred_prepare(new, old, gfp);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), gfp);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->cred_free(new);
+		}
+	}
+	new->security = bp;
+	return rc;
 }
 
 void security_transfer_creds(struct cred *new, const struct cred *old)
 {
-	security_ops->cred_transfer(new, old);
+	call_void_hook(cred_transfer, new, old);
 }
 
 int security_kernel_act_as(struct cred *new, u32 secid)
 {
-	return security_ops->kernel_act_as(new, secid);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_act_as, new, secid);
+	return rc;
 }
 
 int security_kernel_create_files_as(struct cred *new, struct inode *inode)
 {
-	return security_ops->kernel_create_files_as(new, inode);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_create_files_as, new, inode);
+	return rc;
 }
 
 int security_kernel_module_request(char *kmod_name)
 {
-	return security_ops->kernel_module_request(kmod_name);
+	int rc = 0;
+
+	call_int_hook(rc, kernel_module_request, kmod_name);
+	return rc;
 }
 
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
 			     int flags)
 {
-	return security_ops->task_fix_setuid(new, old, flags);
+	int rc = 0;
+
+	call_int_cap_first(rc, task_fix_setuid, new, old, flags);
+	return rc;
 }
 
 int security_task_setpgid(struct task_struct *p, pid_t pgid)
 {
-	return security_ops->task_setpgid(p, pgid);
+	int rc = 0;
+
+	call_int_hook(rc, task_setpgid, p, pgid);
+	return rc;
 }
 
 int security_task_getpgid(struct task_struct *p)
 {
-	return security_ops->task_getpgid(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getpgid, p);
+	return rc;
 }
 
 int security_task_getsid(struct task_struct *p)
 {
-	return security_ops->task_getsid(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getsid, p);
+	return rc;
 }
 
 void security_task_getsecid(struct task_struct *p, u32 *secid)
 {
-	security_ops->task_getsecid(p, secid);
+	if (list_empty(&lsm_hooks[LSM_task_getsecid]))
+		*secid = 0;
+	else
+		call_void_hook(task_getsecid, p, secid);
 }
 EXPORT_SYMBOL(security_task_getsecid);
 
 int security_task_setnice(struct task_struct *p, int nice)
 {
-	return security_ops->task_setnice(p, nice);
+	int rc = 0;
+
+	call_int_cap_first(rc, task_setnice, p, nice);
+	return rc;
 }
 
 int security_task_setioprio(struct task_struct *p, int ioprio)
 {
-	return security_ops->task_setioprio(p, ioprio);
+	int rc = 0;
+
+	call_int_cap_first(rc, task_setioprio, p, ioprio);
+	return rc;
 }
 
 int security_task_getioprio(struct task_struct *p)
 {
-	return security_ops->task_getioprio(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getioprio, p);
+	return rc;
 }
 
 int security_task_setrlimit(struct task_struct *p, unsigned int resource,
 		struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit(p, resource, new_rlim);
+	int rc = 0;
+
+	call_int_hook(rc, task_setrlimit, p, resource, new_rlim);
+	return rc;
 }
 
 int security_task_setscheduler(struct task_struct *p)
 {
-	return security_ops->task_setscheduler(p);
+	int rc = 0;
+
+	call_int_cap_first(rc, task_setscheduler, p);
+	return rc;
 }
 
 int security_task_getscheduler(struct task_struct *p)
 {
-	return security_ops->task_getscheduler(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_getscheduler, p);
+	return rc;
 }
 
 int security_task_movememory(struct task_struct *p)
 {
-	return security_ops->task_movememory(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_movememory, p);
+	return rc;
 }
 
 int security_task_kill(struct task_struct *p, struct siginfo *info,
 			int sig, u32 secid)
 {
-	return security_ops->task_kill(p, info, sig, secid);
+	int rc = 0;
+
+	call_int_hook(rc, task_kill, p, info, sig, secid);
+	return rc;
 }
 
 int security_task_wait(struct task_struct *p)
 {
-	return security_ops->task_wait(p);
+	int rc = 0;
+
+	call_int_hook(rc, task_wait, p);
+	return rc;
 }
 
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			 unsigned long arg4, unsigned long arg5)
 {
-#ifdef CONFIG_SECURITY_YAMA_STACKED
+	struct security_operations *sop;
 	int rc;
-	rc = yama_task_prctl(option, arg2, arg3, arg4, arg5);
+
+	rc = cap_task_prctl(option, arg2, arg3, arg4, arg5);
 	if (rc != -ENOSYS)
 		return rc;
-#endif
-	return security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
+
+	for_each_hook(sop, task_prctl) {
+		rc = sop->task_prctl(option, arg2, arg3, arg4, arg5);
+		/*
+		 * -ENOSYS returned if the lsm doesn't handle that control.
+		 * If the LSM does handle the control return the result.
+		 * The assumption for the time being is that no two LSMs
+		 * will handle a control.
+		 */
+		if (rc != -ENOSYS)
+			return rc;
+	}
+	return -ENOSYS;
 }
 
 void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
-	security_ops->task_to_inode(p, inode);
+	call_void_hook(task_to_inode, p, inode);
 }
 
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
-	return security_ops->ipc_permission(ipcp, flag);
+	int rc = 0;
+
+	call_int_hook(rc, ipc_permission, ipcp, flag);
+	return rc;
 }
 
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
 {
-	security_ops->ipc_getsecid(ipcp, secid);
+	if (list_empty(&lsm_hooks[LSM_sem_associate]))
+		*secid = 0;
+	else
+		call_void_hook(ipc_getsecid, ipcp, secid);
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
 {
-	return security_ops->msg_msg_alloc_security(msg);
+	int rc = 0;
+
+	call_alloc_hook(rc, msg_msg_alloc_security, msg_msg_free_security,
+			msg->security, GFP_KERNEL, msg);
+	return rc;
 }
 
 void security_msg_msg_free(struct msg_msg *msg)
 {
-	security_ops->msg_msg_free_security(msg);
+	call_void_hook(msg_msg_free_security, msg);
+
+	kfree(msg->security);
+	msg->security = NULL;
 }
 
 int security_msg_queue_alloc(struct msg_queue *msq)
 {
-	return security_ops->msg_queue_alloc_security(msq);
+	struct kern_ipc_perm *kp = &msq->q_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, msg_queue_alloc_security, msg_queue_free_security,
+			kp->security, GFP_KERNEL, msq);
+	return rc;
 }
 
 void security_msg_queue_free(struct msg_queue *msq)
 {
-	security_ops->msg_queue_free_security(msq);
+	call_void_hook(msg_queue_free_security, msq);
+
+	kfree(msq->q_perm.security);
+	msq->q_perm.security = NULL;
 }
 
 int security_msg_queue_associate(struct msg_queue *msq, int msqflg)
 {
-	return security_ops->msg_queue_associate(msq, msqflg);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_associate, msq, msqflg);
+	return rc;
 }
 
 int security_msg_queue_msgctl(struct msg_queue *msq, int cmd)
 {
-	return security_ops->msg_queue_msgctl(msq, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgctl, msq, cmd);
+	return rc;
 }
 
 int security_msg_queue_msgsnd(struct msg_queue *msq,
 			       struct msg_msg *msg, int msqflg)
 {
-	return security_ops->msg_queue_msgsnd(msq, msg, msqflg);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgsnd, msq, msg, msqflg);
+	return rc;
 }
 
 int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
 			       struct task_struct *target, long type, int mode)
 {
-	return security_ops->msg_queue_msgrcv(msq, msg, target, type, mode);
+	int rc = 0;
+
+	call_int_hook(rc, msg_queue_msgrcv, msq, msg, target, type, mode);
+	return rc;
 }
 
 int security_shm_alloc(struct shmid_kernel *shp)
 {
-	return security_ops->shm_alloc_security(shp);
+	struct kern_ipc_perm *kp = &shp->shm_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, shm_alloc_security, shm_free_security,
+			kp->security, GFP_KERNEL, shp);
+	return rc;
 }
 
 void security_shm_free(struct shmid_kernel *shp)
 {
-	security_ops->shm_free_security(shp);
+	call_void_hook(shm_free_security, shp);
+
+	kfree(shp->shm_perm.security);
+	shp->shm_perm.security = NULL;
 }
 
 int security_shm_associate(struct shmid_kernel *shp, int shmflg)
 {
-	return security_ops->shm_associate(shp, shmflg);
+	int rc = 0;
+
+	call_int_hook(rc, shm_associate, shp, shmflg);
+	return rc;
 }
 
 int security_shm_shmctl(struct shmid_kernel *shp, int cmd)
 {
-	return security_ops->shm_shmctl(shp, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, shm_shmctl, shp, cmd);
+	return rc;
 }
 
 int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg)
 {
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+	int rc = 0;
+
+	call_int_hook(rc, shm_shmat, shp, shmaddr, shmflg);
+	return rc;
 }
 
 int security_sem_alloc(struct sem_array *sma)
 {
-	return security_ops->sem_alloc_security(sma);
+	struct kern_ipc_perm *kp = &sma->sem_perm;
+	int rc = 0;
+
+	call_alloc_hook(rc, sem_alloc_security, sem_free_security,
+			kp->security, GFP_KERNEL, sma);
+	return rc;
 }
 
 void security_sem_free(struct sem_array *sma)
 {
-	security_ops->sem_free_security(sma);
+	call_void_hook(sem_free_security, sma);
+
+	kfree(sma->sem_perm.security);
+	sma->sem_perm.security = NULL;
 }
 
 int security_sem_associate(struct sem_array *sma, int semflg)
 {
-	return security_ops->sem_associate(sma, semflg);
+	int rc = 0;
+
+	call_int_hook(rc, sem_associate, sma, semflg);
+	return rc;
 }
 
 int security_sem_semctl(struct sem_array *sma, int cmd)
 {
-	return security_ops->sem_semctl(sma, cmd);
+	int rc = 0;
+
+	call_int_hook(rc, sem_semctl, sma, cmd);
+	return rc;
 }
 
 int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
 			unsigned nsops, int alter)
 {
-	return security_ops->sem_semop(sma, sops, nsops, alter);
+	int rc = 0;
+
+	call_int_hook(rc, sem_semop, sma, sops, nsops, alter);
+	return rc;
 }
 
 void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 {
 	if (unlikely(inode && IS_PRIVATE(inode)))
 		return;
-	security_ops->d_instantiate(dentry, inode);
+
+	call_void_hook(d_instantiate, dentry, inode);
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
+static void free_value_list(char **values)
+{
+	struct security_operations *sop;
+
+	for_each_hook(sop, getprocattr)
+		kfree(values[sop->order]);
+}
+
 int security_getprocattr(struct task_struct *p, char *name, char **value)
 {
-	return security_ops->getprocattr(p, name, value);
+	struct security_operations *sop;
+	char *result = NULL;
+	char *cp;
+	char *values[COMPOSER_MAX];
+	int rcs[COMPOSER_MAX];
+	int only = 0;
+	int total = 0;
+	int order;
+
+	if (lsm_present)
+		return present_getprocattr(p, name, value);
+
+	/*
+	 * Find all the LSMs that produce procattrs and call them,
+	 * saving the results. Note if more than one gets called
+	 * and if there are any failures. Track how much space is
+	 * going to be required to combine the strings.
+	 */
+	for_each_hook(sop, getprocattr) {
+		order = sop->order;
+		rcs[order] = 0;
+		values[order] = NULL;
+		rcs[order] = sop->getprocattr(p, name, &values[order]);
+		if (rcs[order] < 0) {
+			if (values[order] == NULL) {
+				values[order] = kstrdup("(null)", GFP_KERNEL);
+				total += 6;
+			} else
+				values[order][0] = '\0';
+		} else
+			total += rcs[order];
+
+		total += strlen(sop->name) + 2;
+
+		if (only == 0)
+			only = order;
+		else
+			only = -1;
+	}
+	/*
+	 * Special cases for 0 and 1 LSMs getting called
+	 * In the multiple called case compose a string.
+	 */
+	if (only == 0)
+		return -EINVAL;
+
+	if (only > 0) {
+		if (rcs[only] < 0) {
+			kfree(values[order]);
+			*value = NULL;
+		} else
+			*value = values[only];
+		return rcs[only];
+	}
+
+	result = kzalloc(total + 3, GFP_KERNEL);
+	if (result == NULL) {
+		free_value_list(values);
+		*value = NULL;
+		return -ENOMEM;
+	}
+
+	for_each_hook(sop, getprocattr) {
+		strcat(result, "/");
+		strcat(result, sop->name);
+		strcat(result, "=");
+		order = sop->order;
+		if (rcs[order] > 0) {
+			cp = memchr(values[order], '\n', rcs[order]);
+			if (cp != NULL)
+				*cp = '\0';
+			if (values[order][0] != '\0')
+				strncat(result, values[order], rcs[order] + 1);
+		}
+	}
+	strcat(result, "/\n");
+
+	free_value_list(values);
+	*value = result;
+	return strlen(result) + 1;
 }
 
-int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+int security_setprocattr(struct task_struct *p, char *name, void *value,
+				size_t size)
 {
-	return security_ops->setprocattr(p, name, value, size);
+	struct security_operations *sop;
+	char searches[COMPOSER_MAX][SECURITY_NAME_MAX + 4];
+	char *data = value;
+	char *values[COMPOSER_MAX];
+	int eos = 0;
+	int formatted = 0;
+	int only = 0;
+	int thisrc;
+	int rc = size;
+
+	if (lsm_present)
+		return present_setprocattr(p, name, value, size);
+
+	if (size > PAGE_SIZE - 1)
+		return -EINVAL;
+	if (size > 0)
+		eos = size - 1;
+	while (eos > 0 && (data[eos] == '\0' || data[eos] == '\n'))
+		eos--;
+
+	if (data[0] == '/' && data[eos] == '/') {
+		/*
+		 * "/smack=Howdy/apparmor=confined/bandl=12/1,2,6/"
+		 */
+		formatted = 1;
+		data[eos] = '\0';
+		for_each_hook(sop, setprocattr) {
+			sprintf(searches[sop->order], "/%s=", sop->name);
+			values[sop->order] = strnstr(data,
+						searches[sop->order], size);
+		}
+		for_each_hook(sop, setprocattr) {
+			if (values[sop->order] != NULL) {
+				*values[sop->order] = '\0';
+				values[sop->order] = values[sop->order] +
+					strlen(searches[sop->order]);
+			}
+		}
+	}
+	for_each_hook(sop, setprocattr) {
+		if (formatted && values[sop->order] == NULL)
+			continue;
+		if (only == 0)
+			only = sop->order;
+		else
+			only = -1;
+
+		if (formatted)
+			thisrc = sop->setprocattr(p, name, values[sop->order],
+					strlen(values[sop->order]) + 1);
+		else
+			thisrc = sop->setprocattr(p, name, value, size);
+
+		if (thisrc < 0)
+			rc = thisrc;
+	}
+
+	if (only == 0)
+		return -EINVAL;
+	return rc;
+
 }
 
 int security_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->netlink_send(sk, skb);
+	int rc = 0;
+
+	call_int_cap_first(rc, netlink_send, sk, skb);
+	return rc;
 }
 
 int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	return security_ops->secid_to_secctx(secid, secdata, seclen);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_secid_to_secctx]))
+		return -EOPNOTSUPP;
+
+	call_int_hook(rc, secid_to_secctx, secid, secdata, seclen);
+	return rc;
 }
 EXPORT_SYMBOL(security_secid_to_secctx);
 
 int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid)
 {
-	return security_ops->secctx_to_secid(secdata, seclen, secid);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_secctx_to_secid]))
+		*secid = 0;
+	else
+		call_int_hook(rc, secctx_to_secid, secdata, seclen, secid);
+
+	return rc;
 }
 EXPORT_SYMBOL(security_secctx_to_secid);
 
 void security_release_secctx(char *secdata, u32 seclen)
 {
-	security_ops->release_secctx(secdata, seclen);
+	call_void_hook(release_secctx, secdata, seclen);
 }
 EXPORT_SYMBOL(security_release_secctx);
 
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_notifysecctx(inode, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_notifysecctx, inode, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_notifysecctx);
 
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 {
-	return security_ops->inode_setsecctx(dentry, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_setsecctx, dentry, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_setsecctx);
 
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
-	return security_ops->inode_getsecctx(inode, ctx, ctxlen);
+	int rc = 0;
+
+	call_int_hook(rc, inode_getsecctx, inode, ctx, ctxlen);
+	return rc;
 }
 EXPORT_SYMBOL(security_inode_getsecctx);
 
@@ -1077,188 +2225,291 @@ EXPORT_SYMBOL(security_inode_getsecctx);
 
 int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk)
 {
-	return security_ops->unix_stream_connect(sock, other, newsk);
+	int rc = 0;
+
+	call_int_hook(rc, unix_stream_connect, sock, other, newsk);
+	return rc;
 }
 EXPORT_SYMBOL(security_unix_stream_connect);
 
 int security_unix_may_send(struct socket *sock,  struct socket *other)
 {
-	return security_ops->unix_may_send(sock, other);
+	int rc = 0;
+
+	call_int_hook(rc, unix_may_send, sock, other);
+	return rc;
 }
 EXPORT_SYMBOL(security_unix_may_send);
 
 int security_socket_create(int family, int type, int protocol, int kern)
 {
-	return security_ops->socket_create(family, type, protocol, kern);
+	int rc = 0;
+
+	call_int_hook(rc, socket_create, family, type, protocol, kern);
+	return rc;
 }
 
 int security_socket_post_create(struct socket *sock, int family,
 				int type, int protocol, int kern)
 {
-	return security_ops->socket_post_create(sock, family, type,
-						protocol, kern);
+	int rc = 0;
+
+	call_int_hook(rc, socket_post_create, sock, family, type,
+			protocol, kern);
+	return rc;
 }
 
 int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_bind(sock, address, addrlen);
+	int rc = 0;
+
+	call_int_hook(rc, socket_bind, sock, address, addrlen);
+	return rc;
 }
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return security_ops->socket_connect(sock, address, addrlen);
+	int rc = 0;
+
+	call_int_hook(rc, socket_connect, sock, address, addrlen);
+	return rc;
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
 {
-	return security_ops->socket_listen(sock, backlog);
+	int rc = 0;
+
+	call_int_hook(rc, socket_listen, sock, backlog);
+	return rc;
 }
 
 int security_socket_accept(struct socket *sock, struct socket *newsock)
 {
-	return security_ops->socket_accept(sock, newsock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_accept, sock, newsock);
+	return rc;
 }
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
-	return security_ops->socket_sendmsg(sock, msg, size);
+	int rc = 0;
+
+	call_int_hook(rc, socket_sendmsg, sock, msg, size);
+	return rc;
 }
 
 int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 			    int size, int flags)
 {
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
+	int rc = 0;
+
+	call_int_hook(rc, socket_recvmsg, sock, msg, size, flags);
+	return rc;
 }
 
 int security_socket_getsockname(struct socket *sock)
 {
-	return security_ops->socket_getsockname(sock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getsockname, sock);
+	return rc;
 }
 
 int security_socket_getpeername(struct socket *sock)
 {
-	return security_ops->socket_getpeername(sock);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getpeername, sock);
+	return rc;
 }
 
 int security_socket_getsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_getsockopt(sock, level, optname);
+	int rc = 0;
+
+	call_int_hook(rc, socket_getsockopt, sock, level, optname);
+	return rc;
 }
 
 int security_socket_setsockopt(struct socket *sock, int level, int optname)
 {
-	return security_ops->socket_setsockopt(sock, level, optname);
+	int rc = 0;
+
+	call_int_hook(rc, socket_setsockopt, sock, level, optname);
+	return rc;
 }
 
 int security_socket_shutdown(struct socket *sock, int how)
 {
-	return security_ops->socket_shutdown(sock, how);
+	int rc = 0;
+
+	call_int_hook(rc, socket_shutdown, sock, how);
+	return rc;
 }
 
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return security_ops->socket_sock_rcv_skb(sk, skb);
+	int rc = 0;
+
+	call_int_hook(rc, socket_sock_rcv_skb, sk, skb);
+	return rc;
 }
 EXPORT_SYMBOL(security_sock_rcv_skb);
 
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len)
 {
-	return security_ops->socket_getpeersec_stream(sock, optval, optlen, len);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_socket_getpeersec_stream]))
+		return -ENOPROTOOPT;
+
+	call_int_hook(rc, socket_getpeersec_stream, sock, optval, optlen, len);
+	return rc;
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->socket_getpeersec_dgram(sock, skb, secid);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_socket_getpeersec_dgram]))
+		return -ENOPROTOOPT;
+
+	call_int_hook(rc, socket_getpeersec_dgram, sock, skb, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
 {
-	return security_ops->sk_alloc_security(sk, family, priority);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	sk->sk_security = &tblob;
+
+	for_each_hook(sop, sk_alloc_security) {
+		rc = sop->sk_alloc_security(sk, family, priority);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), priority);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->sk_free_security(sk);
+		}
+	}
+	sk->sk_security = bp;
+	return rc;
 }
 
 void security_sk_free(struct sock *sk)
 {
-	security_ops->sk_free_security(sk);
+	call_void_hook(sk_free_security, sk);
+
+	kfree(sk->sk_security);
+	sk->sk_security = NULL;
 }
 
 void security_sk_clone(const struct sock *sk, struct sock *newsk)
 {
-	security_ops->sk_clone_security(sk, newsk);
+	call_void_hook(sk_clone_security, sk, newsk);
 }
 EXPORT_SYMBOL(security_sk_clone);
 
 void security_sk_classify_flow(struct sock *sk, struct flowi *fl)
 {
-	security_ops->sk_getsecid(sk, &fl->flowi_secid);
+	call_void_hook(sk_getsecid, sk, &fl->flowi_secid);
 }
 EXPORT_SYMBOL(security_sk_classify_flow);
 
 void security_req_classify_flow(const struct request_sock *req, struct flowi *fl)
 {
-	security_ops->req_classify_flow(req, fl);
+	call_void_hook(req_classify_flow, req, fl);
 }
 EXPORT_SYMBOL(security_req_classify_flow);
 
 void security_sock_graft(struct sock *sk, struct socket *parent)
 {
-	security_ops->sock_graft(sk, parent);
+	call_void_hook(sock_graft, sk, parent);
 }
 EXPORT_SYMBOL(security_sock_graft);
 
 int security_inet_conn_request(struct sock *sk,
 			struct sk_buff *skb, struct request_sock *req)
 {
-	return security_ops->inet_conn_request(sk, skb, req);
+	int rc = 0;
+
+	call_int_hook(rc, inet_conn_request, sk, skb, req);
+	return rc;
 }
 EXPORT_SYMBOL(security_inet_conn_request);
 
 void security_inet_csk_clone(struct sock *newsk,
 			const struct request_sock *req)
 {
-	security_ops->inet_csk_clone(newsk, req);
+	call_void_hook(inet_csk_clone, newsk, req);
 }
 
 void security_inet_conn_established(struct sock *sk,
 			struct sk_buff *skb)
 {
-	security_ops->inet_conn_established(sk, skb);
+	call_void_hook(inet_conn_established, sk, skb);
 }
 
 int security_secmark_relabel_packet(u32 secid)
 {
-	return security_ops->secmark_relabel_packet(secid);
+	int rc = 0;
+
+	call_int_hook(rc, secmark_relabel_packet, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_secmark_relabel_packet);
 
 void security_secmark_refcount_inc(void)
 {
-	security_ops->secmark_refcount_inc();
+	call_void_hook(secmark_refcount_inc);
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
 void security_secmark_refcount_dec(void)
 {
-	security_ops->secmark_refcount_dec();
+	call_void_hook(secmark_refcount_dec);
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
 int security_tun_dev_create(void)
 {
-	return security_ops->tun_dev_create();
+	int rc = 0;
+
+	call_int_hook(rc, tun_dev_create);
+	return rc;
 }
 EXPORT_SYMBOL(security_tun_dev_create);
 
 void security_tun_dev_post_create(struct sock *sk)
 {
-	return security_ops->tun_dev_post_create(sk);
+	call_void_hook(tun_dev_post_create, sk);
 }
 EXPORT_SYMBOL(security_tun_dev_post_create);
 
 int security_tun_dev_attach(struct sock *sk)
 {
-	return security_ops->tun_dev_attach(sk);
+	int rc = 0;
+
+	call_int_hook(rc, tun_dev_attach, sk);
+	return rc;
 }
 EXPORT_SYMBOL(security_tun_dev_attach);
 
@@ -1266,78 +2517,119 @@ EXPORT_SYMBOL(security_tun_dev_attach);
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 
+/*
+ * The xfrm hooks present special issues for composition
+ * as they don't use the usual scheme for passing in blobs.
+ * LSM registration checks ensure that only one xfrm using
+ * security module is loaded at a time.
+ * This shouldn't be much of an issue since SELinux is the
+ * only security module ever expected to use xfrm.
+ */
 int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp, struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_policy_alloc_security(ctxp, sec_ctx);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_alloc_security, ctxp, sec_ctx);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
-	return security_ops->xfrm_policy_clone_security(old_ctx, new_ctxp);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_clone_security, old_ctx, new_ctxp);
+	return rc;
 }
 
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
-	security_ops->xfrm_policy_free_security(ctx);
+	call_void_hook(xfrm_policy_free_security, ctx);
 }
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
-	return security_ops->xfrm_policy_delete_security(ctx);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_delete_security, ctx);
+	return rc;
 }
 
 int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx)
 {
-	return security_ops->xfrm_state_alloc_security(x, sec_ctx, 0);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_state_alloc_security, x, sec_ctx, 0);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
-	if (!polsec)
-		return 0;
+	int rc = 0;
 	/*
 	 * We want the context to be taken from secid which is usually
 	 * from the sock.
 	 */
-	return security_ops->xfrm_state_alloc_security(x, NULL, secid);
+
+	if (!polsec)
+		return 0;
+
+	call_int_hook(rc, xfrm_state_alloc_security, x, NULL, secid);
+	return rc;
 }
 
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
-	return security_ops->xfrm_state_delete_security(x);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_state_delete_security, x);
+	return rc;
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
 void security_xfrm_state_free(struct xfrm_state *x)
 {
-	security_ops->xfrm_state_free_security(x);
+	call_void_hook(xfrm_state_free_security, x);
 }
 
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir)
 {
-	return security_ops->xfrm_policy_lookup(ctx, fl_secid, dir);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_policy_lookup, ctx, fl_secid, dir);
+	return rc;
 }
 
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi *fl)
 {
-	return security_ops->xfrm_state_pol_flow_match(x, xp, fl);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_xfrm_state_pol_flow_match]))
+		return 1;
+
+	call_int_hook(rc, xfrm_state_pol_flow_match, x, xp, fl);
+	return rc;
 }
 
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
-	return security_ops->xfrm_decode_session(skb, secid, 1);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_decode_session, skb, secid, 1);
+	return rc;
 }
 
 void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl)
 {
-	int rc = security_ops->xfrm_decode_session(skb, &fl->flowi_secid, 0);
+	int rc = 0;
+
+	call_int_hook(rc, xfrm_decode_session, skb, &fl->flowi_secid, 0);
 
 	BUG_ON(rc);
 }
@@ -1350,23 +2642,62 @@ EXPORT_SYMBOL(security_skb_classify_flow);
 int security_key_alloc(struct key *key, const struct cred *cred,
 		       unsigned long flags)
 {
-	return security_ops->key_alloc(key, cred, flags);
+	struct security_operations *sop;
+	struct security_operations *note[COMPOSER_MAX];
+	struct lsm_blob tblob;
+	struct lsm_blob *bp = NULL;
+	int rc = 0;
+	int successes = 0;
+
+	memset(&tblob, 0, sizeof(tblob));
+	key->security = &tblob;
+
+	for_each_hook(sop, key_alloc) {
+		rc = sop->key_alloc(key, cred, flags);
+		if (rc)
+			break;
+		note[successes++] = sop;
+	}
+
+	if (tblob.lsm_setcount != 0) {
+		if (rc == 0)
+			bp = kmemdup(&tblob, sizeof(tblob), GFP_KERNEL);
+		if (bp == NULL) {
+			if (rc == 0)
+				rc = -ENOMEM;
+			while (successes > 0)
+				note[--successes]->key_free(key);
+		}
+	}
+
+	key->security = bp;
+	return rc;
 }
 
 void security_key_free(struct key *key)
 {
-	security_ops->key_free(key);
+	call_void_hook(key_free, key);
 }
 
 int security_key_permission(key_ref_t key_ref,
 			    const struct cred *cred, key_perm_t perm)
 {
-	return security_ops->key_permission(key_ref, cred, perm);
+	int rc = 0;
+
+	call_int_hook(rc, key_permission, key_ref, cred, perm);
+	return rc;
 }
 
 int security_key_getsecurity(struct key *key, char **_buffer)
 {
-	return security_ops->key_getsecurity(key, _buffer);
+	int rc = 0;
+
+	if (list_empty(&lsm_hooks[LSM_key_getsecurity]))
+		*_buffer = NULL;
+	else
+		call_int_hook(rc, key_getsecurity, key, _buffer);
+
+	return rc;
 }
 
 #endif	/* CONFIG_KEYS */
@@ -1375,23 +2706,32 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
-	return security_ops->audit_rule_init(field, op, rulestr, lsmrule);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_init, field, op, rulestr, lsmrule);
+	return rc;
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
 {
-	return security_ops->audit_rule_known(krule);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_known, krule);
+	return rc;
 }
 
 void security_audit_rule_free(void *lsmrule)
 {
-	security_ops->audit_rule_free(lsmrule);
+	call_void_hook(audit_rule_free, lsmrule);
 }
 
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
 			      struct audit_context *actx)
 {
-	return security_ops->audit_rule_match(secid, field, op, lsmrule, actx);
+	int rc = 0;
+
+	call_int_hook(rc, audit_rule_match, secid, field, op, lsmrule, actx);
+	return rc;
 }
 
 #endif /* CONFIG_AUDIT */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
