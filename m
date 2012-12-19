Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBJIb8UH006702
	for <selinux@tycho.nsa.gov>; Wed, 19 Dec 2012 13:37:13 -0500
Message-ID: <50D20937.6000801@schaufler-ca.com>
Date: Wed, 19 Dec 2012 10:36:39 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>
CC: Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: [PATCH v11 4/9] LSM: Multiple concurrent LSMs
References: <50D205E2.9010203@schaufler-ca.com>
In-Reply-To: <50D205E2.9010203@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [PATCH v11 4/9] LSM: Multiple concurrent LSMs

Change the infrastructure for Linux Security Modules (LSM)s
from a single vector of hook handlers to a list based method
for handling multiple concurrent modules. 

Configuration changes.
Headers files. Add securityfs files to report the
registered and present LSMs.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

---
 include/linux/lsm.h      |  174 +++++++++++++++++++++++++++++++
 include/linux/security.h |  254 +++++++++++++++++++++++++++++++++++++++-------
 security/Kconfig         |   79 +++++++++-----
 security/Makefile        |    3 +-
 security/inode.c         |   78 +++++++++++++-
 5 files changed, 520 insertions(+), 68 deletions(-)

diff --git a/include/linux/lsm.h b/include/linux/lsm.h
new file mode 100644
index 0000000..5f36b6b
--- /dev/null
+++ b/include/linux/lsm.h
@@ -0,0 +1,174 @@
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
+#ifdef CONFIG_KEYS
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
+#endif
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
index 05e88bd..51c9d2d 100644
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
@@ -1655,12 +1860,18 @@ struct security_operations {
 #endif /* CONFIG_AUDIT */
 };
 
+/*
+ * The security operations vector for /proc interfaces.
+ */
+extern struct security_operations *lsm_present;
+
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
@@ -3022,36 +3233,5 @@ static inline void free_secdata(void *secdata)
 { }
 #endif /* CONFIG_SECURITY */
 
-#ifdef CONFIG_SECURITY_YAMA
-extern int yama_ptrace_access_check(struct task_struct *child,
-				    unsigned int mode);
-extern int yama_ptrace_traceme(struct task_struct *parent);
-extern void yama_task_free(struct task_struct *task);
-extern int yama_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, unsigned long arg5);
-#else
-static inline int yama_ptrace_access_check(struct task_struct *child,
-					   unsigned int mode)
-{
-	return 0;
-}
-
-static inline int yama_ptrace_traceme(struct task_struct *parent)
-{
-	return 0;
-}
-
-static inline void yama_task_free(struct task_struct *task)
-{
-}
-
-static inline int yama_task_prctl(int option, unsigned long arg2,
-				  unsigned long arg3, unsigned long arg4,
-				  unsigned long arg5)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_SECURITY_YAMA */
-
 #endif /* ! __LINUX_SECURITY_H */
 
diff --git a/security/Kconfig b/security/Kconfig
index e9c6ac7..83415b6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -123,49 +123,74 @@ source security/tomoyo/Kconfig
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
+	default PRESENT_SECURITY_SELINUX \
+		if SECURITY_SELINUX && !(SECURITY_APPARMOR || SECURITY_SMACK)
+	default PRESENT_SECURITY_SMACK \
+		if SECURITY_SMACK && !(SECURITY_APPARMOR || SECURITY_SELINUX)
+	default PRESENT_SECURITY_APPARMOR \
+		if SECURITY_APPARMOR && !(SECURITY_SMACK || SECURITY_SELINUX)
+	default PRESENT_SECURITY_FIRST \
+		if SECURITY_APPARMOR || SECURITY_SMACK || SECURITY_SELINUX
+	default PRESENT_SECURITY_NONE
 
 	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
+	  Select the security module that will be presented
+	  with the /proc/*/attr interface.
+	  If not specified the first registered LSM that uses
+	  the /proc/*/attr interface will be chosen.
 
-	config DEFAULT_SECURITY_SELINUX
+	config PRESENT_SECURITY_SELINUX
 		bool "SELinux" if SECURITY_SELINUX=y
+		help
+		  Present SELinux context information in the
+		  files in /proc/*/attr
 
-	config DEFAULT_SECURITY_SMACK
+	config PRESENT_SECURITY_SMACK
 		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
+		help
+		  Present Smack process label information
+		  in /proc/*/attr/current
 
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
+	config PRESENT_SECURITY_APPARMOR
 		bool "AppArmor" if SECURITY_APPARMOR=y
+		help
+		  Present AppArmor context information in the
+		  files in /proc/*/attr
 
-	config DEFAULT_SECURITY_YAMA
-		bool "Yama" if SECURITY_YAMA=y
+	config PRESENT_SECURITY_FIRST
+		bool "Use first registered LSM"
+		help
+		  Present information from the first LSM that uses
+		  /proc/*/attr in the files in /proc/*/attr
 
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
+	config PRESENT_SECURITY_NONE
+		bool "Present Nothing"
+		help
+		  Do not present LSM information in /proc/*/attr
 
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
+	default "FIRSTLSM" if PRESENT_SECURITY_FIRST
+	default "NOTHING"
 
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
diff --git a/security/inode.c b/security/inode.c
index 43ce6e1..2c14313 100644
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
@@ -215,6 +218,69 @@ void securityfs_remove(struct dentry *dentry)
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
+
+static struct dentry *present_dentry;
+static ssize_t present_read(struct file *filp, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	char *raw;
+	char *data;
+	int len;
+
+	if (lsm_present)
+		raw = lsm_present->name;
+	else
+		raw = "(none)";
+	len = strlen(raw);
+
+	data = kstrdup(raw, GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data[len] = '\n';
+	len = simple_read_from_buffer(buf, count, ppos, data, len + 1);
+	kfree(data);
+
+	return len;
+}
+
+static const struct file_operations present_ops = {
+	.read = present_read,
+	.llseek = generic_file_llseek,
+};
+#endif /* CONFIG_SECURITY */
+
 static struct kobject *security_kobj;
 
 static int __init securityfs_init(void)
@@ -226,9 +292,17 @@ static int __init securityfs_init(void)
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
+	present_dentry = securityfs_create_file("present", S_IRUGO, NULL, NULL,
+		&present_ops);
+#endif /* CONFIG_SECURITY */
+	return 0;
 }
 
 core_initcall(securityfs_init);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
